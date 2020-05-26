Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999431E2C4A
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 21:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404330AbgEZTNt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 15:13:49 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:46306 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404321AbgEZTNt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 15:13:49 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 96E9D30D79D;
        Tue, 26 May 2020 12:13:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 96E9D30D79D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1590520427;
        bh=TD+pvEeaAmIZ4gEFvHmv/B24eOz6zs85BaHEGnwgiAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hfe62d57qbpTb415H8SRSPuUrUqZluoAya3dfh+fSyJ9MbVu1AW5egz29Yp3LLa+M
         iEflTmOjHNRly4fFxUAznA7LsnQUKYPmnwIdfFojAjXwFw6Vd0B6Ss+ffLdxznWJ4F
         p2bsM+eNnOpY3gXvhELGIBH+6tuAwByMYRoY4w7k=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id F092C140069;
        Tue, 26 May 2020 12:13:45 -0700 (PDT)
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
Subject: [PATCH v2 14/14] PCI: brcmstb: Add bcm7211, bcm7216, bcm7445, bcm7278 to match list
Date:   Tue, 26 May 2020 15:12:53 -0400
Message-Id: <20200526191303.1492-15-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526191303.1492-1-james.quinlan@broadcom.com>
References: <20200526191303.1492-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that the support is in place with previous commits, we add several
chips that use the BrcmSTB driver.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 131cf0a51398..22dbecb5403c 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1189,6 +1189,10 @@ static int brcm_pcie_remove(struct platform_device *pdev)
 
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

