Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5539F45DA51
	for <lists+linux-pci@lfdr.de>; Thu, 25 Nov 2021 13:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343837AbhKYMvw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Nov 2021 07:51:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:45206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352585AbhKYMtr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Nov 2021 07:49:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C3CD61106;
        Thu, 25 Nov 2021 12:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637844395;
        bh=Dy8qixfk57rxiBBpn+qUTpl4vWEooJOjRKRfTNJLD/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bij3g2C/t7Mf00IbUdKDfY+HDz0dRyV/6sQFImcbYYDCwQTYPPh3g/g7cXQD8rb9s
         0QsFyQ7NrGavpa385+PNBioY3/GJj3rLoOHrg1dDsg9Q8RO5sKL3V3vruiD92w33bx
         rYMIWtoc5FoCU5WvyG3cDgEsxophgKKGjOTpflxQRNYwTKjPLkwIq4qdRb+u2lw2zd
         8hVrfgvGxq/oO8zbxocOABbESreRdJjQ5FuO9yF1CEN83PYMzZFyIXhwpLS5TDET2q
         je/wkVobQnaA8h3+CtFVbsKdqAJPoFYwkonmG2d3vlKGV+NysCh5yQiIaxZ95Q7Tm6
         C0W9to3icYTvg==
Received: by pali.im (Postfix)
        id 5B737EDE; Thu, 25 Nov 2021 13:46:35 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/15] PCI: mvebu: Disallow mapping interrupts on emulated bridges
Date:   Thu, 25 Nov 2021 13:45:55 +0100
Message-Id: <20211125124605.25915-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211125124605.25915-1-pali@kernel.org>
References: <20211125124605.25915-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Interrupt support on mvebu emulated bridges is not implemented yet.

So properly indicate return value to callers that they cannot request
interrupts from emulated bridge.

Signed-off-by: Pali Rohár <pali@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-mvebu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 19c6ee298442..a3df352d440e 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -705,6 +705,15 @@ static struct pci_ops mvebu_pcie_ops = {
 	.write = mvebu_pcie_wr_conf,
 };
 
+static int mvebu_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	/* Interrupt support on mvebu emulated bridges is not implemented yet */
+	if (dev->bus->number == 0)
+		return 0; /* Proper return code 0 == NO_IRQ */
+
+	return of_irq_parse_and_map_pci(dev, slot, pin);
+}
+
 static resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
 						 const struct resource *res,
 						 resource_size_t start,
@@ -1119,6 +1128,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	bridge->sysdata = pcie;
 	bridge->ops = &mvebu_pcie_ops;
 	bridge->align_resource = mvebu_pcie_align_resource;
+	bridge->map_irq = mvebu_pcie_map_irq;
 
 	return pci_host_probe(bridge);
 }
-- 
2.20.1

