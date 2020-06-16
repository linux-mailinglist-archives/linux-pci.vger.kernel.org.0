Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDFE1FC06E
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jun 2020 22:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbgFPU4Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jun 2020 16:56:24 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:34534 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730537AbgFPU4V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jun 2020 16:56:21 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id B884230D89C;
        Tue, 16 Jun 2020 13:56:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com B884230D89C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1592340980;
        bh=wfbg3gvJq29zwPDXM/Xv4PCCOzZXFGtxf8w+fJjea3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BEx4eSc/IXtdGuU4w7w3gy5VDvSaIsWM+aTZ7EQ/ukeYRHAjIGHibVCdh9JCCkLow
         H8sozSthkqY4sLe6n8lLg2Bm+oqhuvxuWlq//InBWhhD0eLSKPdHZhIZUat6+oVHtl
         g5ASvypGd4H9LLDdRB1nfIv3EanB3F1o4d0bvWjU=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 32C48140069;
        Tue, 16 Jun 2020 13:56:19 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 12/12] PCI: brcmstb: Add bcm7211, bcm7216, bcm7445, bcm7278 to match list
Date:   Tue, 16 Jun 2020 16:55:19 -0400
Message-Id: <20200616205533.3513-13-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616205533.3513-1-james.quinlan@broadcom.com>
References: <20200616205533.3513-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that the support is in place with previous commits, we add several
chips that use the BrcmSTB driver.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 02b769534e53..1437ad1a26c8 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1184,6 +1184,10 @@ static int brcm_pcie_remove(struct platform_device *pdev)
 
 static const struct of_device_id brcm_pcie_match[] = {
 	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
+	{ .compatible = "brcm,bcm7211-pcie", .data = &generic_cfg },
+	{ .compatible = "brcm,bcm7278-pcie", .data = &bcm7278_cfg },
+	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7278_cfg },
+	{ .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
 	{},
 };
 
-- 
2.17.1

