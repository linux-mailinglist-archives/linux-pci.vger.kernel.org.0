Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E95524FB43
	for <lists+linux-pci@lfdr.de>; Mon, 24 Aug 2020 12:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgHXKXx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Aug 2020 06:23:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgHXKXx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Aug 2020 06:23:53 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77AB420738;
        Mon, 24 Aug 2020 10:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598264631;
        bh=4+OzVArS4T+WesA/uA9lGqHjid58hKksVXjy0kXV8vs=;
        h=From:To:Cc:Subject:Date:From;
        b=MRWZQp+uZ+FB7DjduS4Zuds1HNvbh9QWfE0Vp08WFnWF0jW1xWxgX8/rilbSSx2Ts
         LMnYKzyU5j7bnly3Rs9TMukbnW68uERw7Lb1PuVjsVwjfBeNOVA/BYt9W0nC1UNb23
         W/uIbsHyKSX/aKdGytK4HPBU6dBOEN5m02pygg30=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kA9dl-006BQc-Ld; Mon, 24 Aug 2020 11:23:50 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH 0/9] irqchip/gic: generalize use of HW-based retriggering
Date:   Mon, 24 Aug 2020 11:23:08 +0100
Message-Id: <20200824102317.1038259-1-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, gregory.clement@bootlin.com, jason@lakedaemon.net, laurentiu.tudor@nxp.com, tglx@linutronix.de, valentin.schneider@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Valentin recently pointed out that that relying on SW-based retrigger
with any of the GIC interrupt controller is both inefficient and
slightly broken, as it messes the GIC's own state machine.

In order to move the GIC over to use its natural HW-based triggering
mechanism, we need to teach all the stacked interrupt controllers that
can pile on a GIC to use the hierarchy-based retrigger helper. This
includes the bus-specific irqchips, such as PCI, FSL-MC, and the funky
platform-MSI.

Marc Zyngier (7):
  irqchip/git-v3-its: Implement irq_retrigger callback for
    device-triggered LPIs
  PCI/MSI: Provide default retrigger callback
  platform-msi: Provide default retrigger callback
  fsl-msi: Provide default retrigger callback
  irqchip/mbigen: Use hierarchy retrigger helper
  irqchip/mvebu-icu: Use hierarchy retrigger helper
  irqchip/mvebu-sei: Use hierarchy retrigger helper

Valentin Schneider (2):
  irqchip/gic-v2, v3: Implement irq_chip->irq_retrigger()
  irqchip/gic-v2, v3: Prevent SW resends entirely

 drivers/base/platform-msi.c      |  2 ++
 drivers/bus/fsl-mc/fsl-mc-msi.c  |  2 ++
 drivers/irqchip/irq-gic-v3-its.c |  6 ++++++
 drivers/irqchip/irq-gic-v3.c     | 12 +++++++++++-
 drivers/irqchip/irq-gic.c        | 12 +++++++++++-
 drivers/irqchip/irq-mbigen.c     |  1 +
 drivers/irqchip/irq-mvebu-icu.c  |  2 ++
 drivers/irqchip/irq-mvebu-sei.c  |  2 ++
 drivers/pci/msi.c                |  2 ++
 9 files changed, 39 insertions(+), 2 deletions(-)

-- 
2.27.0

