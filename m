Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1E624FB50
	for <lists+linux-pci@lfdr.de>; Mon, 24 Aug 2020 12:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgHXKYX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Aug 2020 06:24:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbgHXKX5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Aug 2020 06:23:57 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4117C208E4;
        Mon, 24 Aug 2020 10:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598264637;
        bh=sggu6pj/oQ8QePbPrz42wiG5AT6WR9prGNVAkCslxNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KQaDRLWwBXdR8XCUc55k/6hIf/bzMFN1R9QStWUY3umdmN5WbSSkC291L29y82Pph
         gprxFXog9c0904g8yYeNemapsdEAxI1s4Foq7GUqBrDuEAC/1DkS+1/vli5lLiZ3+N
         cOcRwrBs2uqJkMsR//PTbaxWcYBBl/sfsbIlSXtY=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kA9dr-006BQc-OP; Mon, 24 Aug 2020 11:23:55 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH 6/9] irqchip/mbigen: Use hierarchy retrigger helper
Date:   Mon, 24 Aug 2020 11:23:14 +0100
Message-Id: <20200824102317.1038259-7-maz@kernel.org>
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
 drivers/irqchip/irq-mbigen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index ff7627b57772..8af35225b46d 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -142,6 +142,7 @@ static struct irq_chip mbigen_irq_chip = {
 	.irq_eoi =		mbigen_eoi_irq,
 	.irq_set_type =		mbigen_set_type,
 	.irq_set_affinity =	irq_chip_set_affinity_parent,
+	.irq_retrigger = 	irq_chip_retrigger_hierarchy,
 };
 
 static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
-- 
2.27.0

