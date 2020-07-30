Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9EC232A79
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 05:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgG3DiG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 23:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbgG3DiG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2020 23:38:06 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5B9C0619D5
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2020 20:38:05 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7494A891AD;
        Thu, 30 Jul 2020 15:38:00 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1596080280;
        bh=YeyiC4Wu/Uu6RclpPH7B15lEUocwEtXXxu8/RyKOIpE=;
        h=From:To:Cc:Subject:Date;
        b=MOSOkalMNZDIEz/AzPSRcDz8YirOPqIyxHhtWoz/btlpahHWVzB2miKlAfp8sMIfN
         htGpmPvN3UBrpy4Ait8Z+/w84wMqTGNk9A0zTs+Ilqr9G31xNcG4XZxRmeNNbiAGJP
         qzqYfXZs02+iMHY/EOjgRWpNXAExjgHb52UCRZlOXgFk4UOWB8nL9Gp5MalY7fZdBM
         i7pXyeoyOpRYmulEn3a5qhEKkr8Dm1C8zAP8rNLtK4OhJnU01SmNZ9pmd+fJZZ41GI
         75trd+PRdoVcwYfBRpPGB1f/XwEm3jyRNLE1JnbbkPc3Te8VU5gNpLQ/M8lmPSDvI/
         aHuYo4r9nzisA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f2240990002>; Thu, 30 Jul 2020 15:38:01 +1200
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.25])
        by smtp (Postfix) with ESMTP id F363813EEB7;
        Thu, 30 Jul 2020 15:37:59 +1200 (NZST)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
        id 3A1C8341092; Thu, 30 Jul 2020 15:38:00 +1200 (NZST)
From:   Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To:     bhelgaas@google.com, rjui@broadcom.com, sbranden@broadcom.com,
        f.fainelli@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Subject: [PATCH 1/3] PCI: iproc: Add bus number parameter to read/write functions
Date:   Thu, 30 Jul 2020 15:37:45 +1200
Message-Id: <20200730033747.18931-1-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This makes the read/write functions more generic, allowing them to be
used from other places.

Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
---
 drivers/pci/controller/pcie-iproc.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller=
/pcie-iproc.c
index 8c7f875acf7f..2c836eede42c 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -660,13 +660,13 @@ static void __iomem *iproc_pcie_bus_map_cfg_bus(str=
uct pci_bus *bus,
 				      where);
 }
=20
-static int iproc_pci_raw_config_read32(struct iproc_pcie *pcie,
+static int iproc_pci_raw_config_read32(struct iproc_pcie *pcie, int busn=
o,
 				       unsigned int devfn, int where,
 				       int size, u32 *val)
 {
 	void __iomem *addr;
=20
-	addr =3D iproc_pcie_map_cfg_bus(pcie, 0, devfn, where & ~0x3);
+	addr =3D iproc_pcie_map_cfg_bus(pcie, busno, devfn, where & ~0x3);
 	if (!addr) {
 		*val =3D ~0;
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -680,14 +680,14 @@ static int iproc_pci_raw_config_read32(struct iproc=
_pcie *pcie,
 	return PCIBIOS_SUCCESSFUL;
 }
=20
-static int iproc_pci_raw_config_write32(struct iproc_pcie *pcie,
+static int iproc_pci_raw_config_write32(struct iproc_pcie *pcie, int bus=
no,
 					unsigned int devfn, int where,
 					int size, u32 val)
 {
 	void __iomem *addr;
 	u32 mask, tmp;
=20
-	addr =3D iproc_pcie_map_cfg_bus(pcie, 0, devfn, where & ~0x3);
+	addr =3D iproc_pcie_map_cfg_bus(pcie, busno, devfn, where & ~0x3);
 	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
=20
@@ -793,7 +793,7 @@ static int iproc_pcie_check_link(struct iproc_pcie *p=
cie)
 	}
=20
 	/* make sure we are not in EP mode */
-	iproc_pci_raw_config_read32(pcie, 0, PCI_HEADER_TYPE, 1, &hdr_type);
+	iproc_pci_raw_config_read32(pcie, 0, 0, PCI_HEADER_TYPE, 1, &hdr_type);
 	if ((hdr_type & 0x7f) !=3D PCI_HEADER_TYPE_BRIDGE) {
 		dev_err(dev, "in EP mode, hdr=3D%#02x\n", hdr_type);
 		return -EFAULT;
@@ -803,15 +803,16 @@ static int iproc_pcie_check_link(struct iproc_pcie =
*pcie)
 #define PCI_BRIDGE_CTRL_REG_OFFSET	0x43c
 #define PCI_CLASS_BRIDGE_MASK		0xffff00
 #define PCI_CLASS_BRIDGE_SHIFT		8
-	iproc_pci_raw_config_read32(pcie, 0, PCI_BRIDGE_CTRL_REG_OFFSET,
+	iproc_pci_raw_config_read32(pcie, 0, 0, PCI_BRIDGE_CTRL_REG_OFFSET,
 				    4, &class);
 	class &=3D ~PCI_CLASS_BRIDGE_MASK;
 	class |=3D (PCI_CLASS_BRIDGE_PCI << PCI_CLASS_BRIDGE_SHIFT);
-	iproc_pci_raw_config_write32(pcie, 0, PCI_BRIDGE_CTRL_REG_OFFSET,
+	iproc_pci_raw_config_write32(pcie, 0, 0, PCI_BRIDGE_CTRL_REG_OFFSET,
 				     4, class);
=20
 	/* check link status to see if link is active */
-	iproc_pci_raw_config_read32(pcie, 0, IPROC_PCI_EXP_CAP + PCI_EXP_LNKSTA=
,
+	iproc_pci_raw_config_read32(pcie, 0, 0,
+				    IPROC_PCI_EXP_CAP + PCI_EXP_LNKSTA,
 				    2, &link_status);
 	if (link_status & PCI_EXP_LNKSTA_NLW)
 		link_is_active =3D true;
@@ -821,19 +822,19 @@ static int iproc_pcie_check_link(struct iproc_pcie =
*pcie)
 #define PCI_TARGET_LINK_SPEED_MASK	0xf
 #define PCI_TARGET_LINK_SPEED_GEN2	0x2
 #define PCI_TARGET_LINK_SPEED_GEN1	0x1
-		iproc_pci_raw_config_read32(pcie, 0,
+		iproc_pci_raw_config_read32(pcie, 0, 0,
 					    IPROC_PCI_EXP_CAP + PCI_EXP_LNKCTL2,
 					    4, &link_ctrl);
 		if ((link_ctrl & PCI_TARGET_LINK_SPEED_MASK) =3D=3D
 		    PCI_TARGET_LINK_SPEED_GEN2) {
 			link_ctrl &=3D ~PCI_TARGET_LINK_SPEED_MASK;
 			link_ctrl |=3D PCI_TARGET_LINK_SPEED_GEN1;
-			iproc_pci_raw_config_write32(pcie, 0,
+			iproc_pci_raw_config_write32(pcie, 0, 0,
 					IPROC_PCI_EXP_CAP + PCI_EXP_LNKCTL2,
 					4, link_ctrl);
 			msleep(100);
=20
-			iproc_pci_raw_config_read32(pcie, 0,
+			iproc_pci_raw_config_read32(pcie, 0, 0,
 					IPROC_PCI_EXP_CAP + PCI_EXP_LNKSTA,
 					2, &link_status);
 			if (link_status & PCI_EXP_LNKSTA_NLW)
--=20
2.28.0

