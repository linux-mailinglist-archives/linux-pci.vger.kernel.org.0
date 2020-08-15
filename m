Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F8724541E
	for <lists+linux-pci@lfdr.de>; Sun, 16 Aug 2020 00:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgHOWMh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Aug 2020 18:12:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728830AbgHOWK1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 15 Aug 2020 18:10:27 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C50BF2311E;
        Sat, 15 Aug 2020 12:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597495884;
        bh=4abrb1hIgzDOMolRWfF5UG90g9XBAir7ef4PB2uBVuU=;
        h=From:To:Cc:Subject:Date:From;
        b=kN7OhMiT916olPv4+/4DmqTTNi0+ib9YnLbL5+XPnMEpaDmhtOeoeDG0jrr5tj5C+
         NzsIns2VxT1xD/JLjLmXSVqijaSFkbFpjUD8l2oqhH5dTIXsf+elWnWsbbVk1NS17K
         xzuTzTQEnSRtkrVTSLMWfhoK3Or9FDI5mvXjrYC8=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k6vec-002Kds-Va; Sat, 15 Aug 2020 13:51:23 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>, kernel-team@android.com
Subject: [PATCH 0/2] PCI: rockchip: Fix PCIe probing in 5.9
Date:   Sat, 15 Aug 2020 13:51:10 +0100
Message-Id: <20200815125112.462652-1-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com, heiko@sntech.de, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Recent changes to the way PCI DT nodes are parsed are now enforcing
the presence of a "device_type" property, which has been mandated
since... forever. This has the unfortunate effect of breaking
non-compliant systems, and those using the Rockchip PCIe driver are
amongst the victims. Oh well.

In order to keep users happy as well as my own machines up and
running, let's paper over the problem by detecting a broken DT from
the driver itself, and inserting the missing property at runtime.

For a good measure, a second patch fixes the DT, but the chances of
such a fix being deployed at this stage are pretty slim, so the above
hack is in for the long run.

Marc Zyngier (2):
  PCI: rockchip: Work around missing device_type property in DT
  arm64: dts: rockchip: Fix PCIe DT properties

 arch/arm64/boot/dts/rockchip/rk3399.dtsi    |  2 +-
 drivers/pci/controller/pcie-rockchip-host.c | 29 +++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

-- 
2.27.0

