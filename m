Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F229A24FB45
	for <lists+linux-pci@lfdr.de>; Mon, 24 Aug 2020 12:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgHXKX5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Aug 2020 06:23:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbgHXKXx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Aug 2020 06:23:53 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5138D207D3;
        Mon, 24 Aug 2020 10:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598264633;
        bh=qQLRqcw1hna/ly45S3xl2gW2vdko3+2aJQbithHj/G4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PsaAJmFc/7WLwZYJnL+pXjeECv3gSO7mWkS5ODgcAbOelXBC3jIZbUQTcH6SrnL/F
         yCfH35wLPg01Qv2aAqzS2hH/NrNmZjB2AP5BYVq4Jdeixk6ZBOG0bwb05LzXxsUqBf
         RP2SLsnnZjk/Z7rcqTcUXpHvd/WDuJ+s7MxSJewU=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kA9dn-006BQc-Px; Mon, 24 Aug 2020 11:23:51 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH 3/9] PCI/MSI: Provide default retrigger callback
Date:   Mon, 24 Aug 2020 11:23:11 +0100
Message-Id: <20200824102317.1038259-4-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200824102317.1038259-1-maz@kernel.org>
References: <20200824102317.1038259-1-maz@kernel.org>
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

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/msi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 30ae4ffda5c1..c4d31ce2d951 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1446,6 +1446,8 @@ static void pci_msi_domain_update_chip_ops(struct msi_domain_info *info)
 		chip->irq_mask = pci_msi_mask_irq;
 	if (!chip->irq_unmask)
 		chip->irq_unmask = pci_msi_unmask_irq;
+	if (!chip->irq_retrigger)
+		chip->irq_retrigger = irq_chip_retrigger_hierarchy;
 }
 
 /**
-- 
2.27.0

