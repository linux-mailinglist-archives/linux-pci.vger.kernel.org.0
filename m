Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63D745DA4B
	for <lists+linux-pci@lfdr.de>; Thu, 25 Nov 2021 13:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353655AbhKYMvp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Nov 2021 07:51:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:45138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352565AbhKYMtp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Nov 2021 07:49:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 632F9610F8;
        Thu, 25 Nov 2021 12:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637844393;
        bh=CFRpIIvV+dRawyP1HEAT1CWwpAzBUW1TAumtSAX1zdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPR7zYq10qu2cCGOR1Su7Z7FMC7TwAqk3pyARxezKNxK3nDejX3oj3OJVfu8QG2dd
         jtonb2lywy0K2v0aTMKnkrgwmzOOPVFXGaFTTcEiu4dkeuLP36ojWnOr1fcR5lHS3H
         +iH/qJF5T//9r5r0eod1KccMscu/jmqzSqvO7Te2CVLVDCCHNf7rfi0tZeGImv8+SD
         twfoldtaNiVR3vOmivZ/qgiIxmLxMsKGwWqiYoBCiUD/bFtfJugL2m8OXXuO5faxnF
         W4WpTDG0mo6V3C1LECIKoSJUBprj5f95H3Z+oHUDiuupZywnGiB8bZ2FQ5MVI8mobG
         H7x6B0DboyCIQ==
Received: by pali.im (Postfix)
        id 21E8EFB1; Thu, 25 Nov 2021 13:46:33 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/15] PCI: mvebu: Check that PCI bridge specified in DT has function number zero
Date:   Thu, 25 Nov 2021 13:45:53 +0100
Message-Id: <20211125124605.25915-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211125124605.25915-1-pali@kernel.org>
References: <20211125124605.25915-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Driver cannot handle PCI bridges at non-zero function address. So add
appropriate check. Currently all in-tree kernel DTS files set PCI bridge
function to zero.

Signed-off-by: Pali Rohár <pali@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-mvebu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 6197f7e7c317..08274132cdfb 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -864,6 +864,11 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
 	port->devfn = of_pci_get_devfn(child);
 	if (port->devfn < 0)
 		goto skip;
+	if (PCI_FUNC(port->devfn) != 0) {
+		dev_err(dev, "%s: invalid function number, must be zero\n",
+			port->name);
+		goto skip;
+	}
 
 	ret = mvebu_get_tgt_attr(dev->of_node, port->devfn, IORESOURCE_MEM,
 				 &port->mem_target, &port->mem_attr);
-- 
2.20.1

