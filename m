Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9E41CA9A5
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 13:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgEHLej (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 May 2020 07:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726616AbgEHLej (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 May 2020 07:34:39 -0400
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683B3C05BD43;
        Fri,  8 May 2020 04:34:39 -0700 (PDT)
Received: from localhost.localdomain (unknown [142.147.94.151])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 88D6E20CE6;
        Fri,  8 May 2020 11:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1588937677; bh=BsYKKDVjGrGZ45XtSJs9R6ZJaKv6eacQRLmTdmKpjC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DWQuGz/YAvGylUx5HdviGbZu227tAzJ0dwIx0KqVuCtVXt9R5hnYj5aZeaAhp+jCt
         iwfE8fwRFXNFLVA2AuibSjrc9J0irQtmOqupkrdM4uIn2Tl9IsdvchqGxgwBp7+u5x
         ZLM79gfSVwPRmFUUY1ykmt1dnaoTiQxV+QgESx1Peyzlbn/XlSqE6LX0H9aAbOVHkb
         PT5OvW6RXDy3lBFMFhh6LqHNu599YiJAp4kbUHOsfzoC4zJwaKKxGR8EqKwjDugqdB
         vcvfJREmD95uHSG3SVtswsWHsrPssb98oS8NEVlzrmxZI3ffLRpiDZGoJyDW2PUhQM
         tfx9ljlyzjssA==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     maz@kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paulburton@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH v8 1/5] PCI: Don't disable decoding when mmio_always_on is set
Date:   Fri,  8 May 2020 19:34:01 +0800
Message-Id: <20200508113414.3091532-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200427060551.1372591-1-jiaxun.yang@flygoat.com>
References: <20200427060551.1372591-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Don't disable MEM/IO decoding when a device have both non_compliant_bars
and mmio_always_on.

That would allow us quirk devices with junk in BARs but can't disable
their decoding.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/pci/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 77b8a145c39b..d9c2c3301a8a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1822,7 +1822,7 @@ int pci_setup_device(struct pci_dev *dev)
 	/* Device class may be changed after fixup */
 	class = dev->class >> 8;
 
-	if (dev->non_compliant_bars) {
+	if (dev->non_compliant_bars && !dev->mmio_always_on) {
 		pci_read_config_word(dev, PCI_COMMAND, &cmd);
 		if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
 			pci_info(dev, "device has non-compliant BARs; disabling IO/MEM decoding\n");
-- 
2.26.0.rc2

