Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8818F1C9BEC
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 22:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgEGUP5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 16:15:57 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:47442 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726320AbgEGUP5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 16:15:57 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 8F84230C034;
        Thu,  7 May 2020 13:15:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 8F84230C034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1588882520;
        bh=npjqBEkqyKXmQajtJumnktVRzekVxfAFiYz9GloJQsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A7RFaEN5PFTJA4ZtTC29VGFguzgRrwdD2Y2wQHvbGIVuO00FrJVYMNVGK5kr0v6p6
         UXaV9b4BQjS4RFIa8fsKTVT0hSGZhajOy6qOx4nr83raNplhMHQBrsFC5wyj+8Hh0/
         jLN7XkbeDpDFfBCRQXuUCWjC6HANvDJpZH9u9QOM=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id A115B140069;
        Thu,  7 May 2020 13:15:54 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     james.quinlan@broadcom.com
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND
        ENDPOINT DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/4] PCI: brcmstb: Don't clk_put() a managed clock
Date:   Thu,  7 May 2020 16:15:40 -0400
Message-Id: <20200507201544.43432-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507201544.43432-1-james.quinlan@broadcom.com>
References: <20200507201544.43432-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jim Quinlan <jquinlan@broadcom.com>

clk_put() was being invoked on a clock obtained by
devm_clk_get_optional().

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/pci/controller/pcie-brcmstb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 6d79d14527a6..454917ee9241 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -899,7 +899,6 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
 	brcm_msi_remove(pcie);
 	brcm_pcie_turn_off(pcie);
 	clk_disable_unprepare(pcie->clk);
-	clk_put(pcie->clk);
 }
 
 static int brcm_pcie_remove(struct platform_device *pdev)
-- 
2.17.1

