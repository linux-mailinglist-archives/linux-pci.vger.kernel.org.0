Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E50232A77
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 05:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgG3DiE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 23:38:04 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:55662 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgG3DiD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2020 23:38:03 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6B1728011F;
        Thu, 30 Jul 2020 15:38:00 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1596080280;
        bh=zj6MeGpKBno5Q9imPzulxAOCtgQV2JSmD3hyVPNyDJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hF6zjJlK5tK0ahmbdj9r/Ej84yc2qbeIkvwrlkiJtk1KyC9NpkiF/gp7tl1uqjKod
         z5P4UsoPYLzSmDuorFzbAfCDGbWfOSulcP4bqrbTmJhoBD/yQzyMtgc+4CvoOX5JQg
         SU5QQzL4UPnINK+ndupe8hI9XcoZAXBo1cPh7QUG/kfj/OaB8WirCg6f+KGIz60lEg
         X5iLEzVNzdH+scla2I87KKVb2LclUtQq6f4gNq32MkjKT6OXER2/L92H20Gl63/Df/
         1SIT8fuik6mXvFyHdxkoAY3gtqwpU9SEFwar5ISi4fBHpup8I/gRSWbUQqcZlgBO6q
         IrK400aLtT0mQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f2240990000>; Thu, 30 Jul 2020 15:38:01 +1200
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.25])
        by smtp (Postfix) with ESMTP id 018C213EF0D;
        Thu, 30 Jul 2020 15:38:00 +1200 (NZST)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
        id 3C3A733F7C9; Thu, 30 Jul 2020 15:38:00 +1200 (NZST)
From:   Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To:     bhelgaas@google.com, rjui@broadcom.com, sbranden@broadcom.com,
        f.fainelli@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Subject: [PATCH 2/3] PCI: iproc: Stop using generic config read/write functions
Date:   Thu, 30 Jul 2020 15:37:46 +1200
Message-Id: <20200730033747.18931-2-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730033747.18931-1-mark.tomlinson@alliedtelesis.co.nz>
References: <20200730033747.18931-1-mark.tomlinson@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci_generic_config_write32() function will give warning messages
whenever writing less than 4 bytes at a time. As there is nothing we can
do about this without changing the hardware, the message is just a
nuisance. So instead of using the generic functions, use the functions
that have already been written for reading/writing the config registers.

Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
---
 drivers/pci/controller/pcie-iproc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller=
/pcie-iproc.c
index 2c836eede42c..68ecd3050529 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -709,12 +709,13 @@ static int iproc_pcie_config_read32(struct pci_bus =
*bus, unsigned int devfn,
 {
 	int ret;
 	struct iproc_pcie *pcie =3D iproc_data(bus);
+	int busno =3D bus->number;
=20
 	iproc_pcie_apb_err_disable(bus, true);
 	if (pcie->iproc_cfg_read)
 		ret =3D iproc_pcie_config_read(bus, devfn, where, size, val);
 	else
-		ret =3D pci_generic_config_read32(bus, devfn, where, size, val);
+		ret =3D iproc_pci_raw_config_read32(pcie, busno, devfn, where, size, v=
al);
 	iproc_pcie_apb_err_disable(bus, false);
=20
 	return ret;
@@ -724,9 +725,11 @@ static int iproc_pcie_config_write32(struct pci_bus =
*bus, unsigned int devfn,
 				     int where, int size, u32 val)
 {
 	int ret;
+	struct iproc_pcie *pcie =3D iproc_data(bus);
+	int busno =3D bus->number;
=20
 	iproc_pcie_apb_err_disable(bus, true);
-	ret =3D pci_generic_config_write32(bus, devfn, where, size, val);
+	ret =3D iproc_pci_raw_config_write32(pcie, busno, devfn, where, size, v=
al);
 	iproc_pcie_apb_err_disable(bus, false);
=20
 	return ret;
--=20
2.28.0

