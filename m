Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B952E6E4F
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 09:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732017AbfJ1Ifg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 04:35:36 -0400
Received: from mail-eopbgr1410110.outbound.protection.outlook.com ([40.107.141.110]:57760
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732003AbfJ1Ifg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Oct 2019 04:35:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKyJ9QeDblgykuXtRR/KU+l6JgtqcW733CGr2bPxC2BjJ58Jfk5H55Y1tXg365xeWmatlwaMIcYqqvCu0ogXf9py4GiEZnHnP+QhnSTlCRdaJO9OvW9gEE9sAeDOib8qHtIRncq8FqX/1ZNp9CJNDwW1s28dVNO11gg63299QwvPDQP4sEtEFQkRnFygnt0vh1PgvlUuu27NCoj+IlA5NE+PQYNlJLdw7MWrQqxvlZNVpT0fgdmz13MjtSf8npXnty/VW1QezYUVJmJSKSZn4oJg1OjjSexFSBL6KDVVOYaZYl4DlkXjuHbiWXMrG6oODdlh4fghmXeljIRqftBMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxzz5uoSDNxmMep8dP8qQfvfDy0n70sUvCI06W/Fj+g=;
 b=UZePvT1eARuLEHZdGJ+fPEKHaE235l0TiObYswh45gwAxfxFsGetjvOWXNaT9wocXgfavQ7GDNakb4wzYDQpxHfOSkls6JU+WdkplE3FQtJvv1Q7cihFL2zX+GUXru3aMefu7mfh9JCNlVNWv4GraWlOKCE53dugq5645npa4yjUSe3eiCMKAJ9PjJNsrDPoe4ovcPXFh4+NE2e/Yz38lWmn0rsxQvCa0EOdvTST+40WkKbJmq68e18V91nqdVbQausxi7m508BiZIJRl3/iO2KUgGU8opqLSTzSRXrWwynAXuzzZI6hB43RQIOYfBbMyeGxgaBEJ9k73mh6Fy3Mpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxzz5uoSDNxmMep8dP8qQfvfDy0n70sUvCI06W/Fj+g=;
 b=V9SuOHvoFpWUuuDFS2lSVB6suWK21BeDAX/6pcRsqUWRF8mL7CXMjVGNT2sdDimFYAWLhS+RXOAfqZYa7Ww3jdHu+ra9+pV7dLnwCFKB+lh1f7KfNecTK/e2ucgSNslPnjOh0dMCb0lon1Sw9EIMz8kCBDvk6FK2ljdKg0ae7co=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB3471.jpnprd01.prod.outlook.com (20.178.137.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Mon, 28 Oct 2019 08:35:32 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947%4]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 08:35:32 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH V4 2/2] PCI: rcar: Recalculate inbound range alignment for
 each controller entry
Thread-Topic: [PATCH V4 2/2] PCI: rcar: Recalculate inbound range alignment
 for each controller entry
Thread-Index: AQHVjCsJKpaGn6Kn8EmC1egFxu/pWadvudHA
Date:   Mon, 28 Oct 2019 08:35:32 +0000
Message-ID: <TYAPR01MB45441C49E8E4C33DDBB09071D8660@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <20191026182659.2390-1-marek.vasut@gmail.com>
 <20191026182659.2390-2-marek.vasut@gmail.com>
In-Reply-To: <20191026182659.2390-2-marek.vasut@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 93d2ce4c-441f-4dcd-8dc1-08d75b81cbb5
x-ms-traffictypediagnostic: TYAPR01MB3471:
x-microsoft-antispam-prvs: <TYAPR01MB3471C5E67A64122A08592215D8660@TYAPR01MB3471.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(199004)(189003)(2906002)(3846002)(81156014)(102836004)(6246003)(52536014)(76116006)(305945005)(7736002)(8676002)(446003)(11346002)(86362001)(476003)(6506007)(478600001)(7696005)(6436002)(9686003)(14454004)(25786009)(99286004)(76176011)(66446008)(26005)(66556008)(64756008)(66946007)(66476007)(186003)(4326008)(5660300002)(54906003)(33656002)(74316002)(66066001)(81166006)(8936002)(316002)(110136005)(55016002)(71190400001)(256004)(71200400001)(2501003)(229853002)(486006)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB3471;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GjV/DVxf3mVMolh2UDkKRdR5iPxxix+FIDMM43pN87ajt4lJcuMsLJC3CPAMlHJYnOCY1R3bpl1BVcrnxo4wxKR2fn+Fwx2nhzrGvjOeAH+Q2mrxxFuSchKGoYtdhuu1CV+KY8XSLLzUqWVQHi72YjwNfEAhnlGNtdXmqI7IcdRKgVHRrworyFKoD+mm6bJb3XsrNIJIGWkf3NjDlBUUw8oXx9DbpFA5kfAA0zFZqm7/MAlMruL/hCT6eLWTpnrKXpoFZR7lmkLcF3iGCIPJiYNgTTKP+QjvVCtcqtMXgYp5L1s/EAOV2a7EGauYU99CRTE7neC3jPkr8CIs08IFVzaYsu5RDPCtzB7PbpQTayrPDVlQk2RwqWqxzhHgAuJGBv8c0okYU6E5fTzqGEGQ1jTNXjoo0fH2nSyG4XvLlMWECreU7wqFT/oodLRZRMUh
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d2ce4c-441f-4dcd-8dc1-08d75b81cbb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 08:35:32.0997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kU0i2Rkf9dUjql48jNdsE9lQTSzR3NukeY3Toam9HPKyUNH3Oi0cKWORCSLhpWXOTwCNZ6/emacC+cdHJPD59J5ezUtjhlx3OV/Ci7GyyonlyrlyCLd+j0M2wRLfqJGd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3471
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marek-san.

> From: Marek Vasut, Sent: Sunday, October 27, 2019 3:27 AM
>=20
> Due to hardware constraints, the size of each inbound range entry
> populated into the controller cannot be larger than the alignment
> of the entry's start address. Currently, the alignment for each
> "dma-ranges" inbound range is calculated only once for each range
> and the increment for programming the controller is also derived
> from it only once. Thus, a "dma-ranges" entry describing a memory
> at 0x48000000 and size 0x38000000 would lead to multiple controller
> entries, each 0x08000000 long.

I added a debug code [1] and I confirmed that each entry is not 0x08000000 =
long [2].

After fixed the commit log above,

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

And I tested on r8a7795-salvator-xs with my debug code. So,

Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

---
[1] Based on next-20191025 with this patch series:
diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts=
/renesas/r8a7795.dtsi
index fde6ec1..9bdd39e 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -2684,7 +2684,7 @@
 				0x02000000 0 0x30000000 0 0x30000000 0 0x08000000
 				0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
 			/* Map all possible DDR as inbound ranges */
-			dma-ranges =3D <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000>;
+			dma-ranges =3D <0x42000000 0 0x48000000 0 0x48000000 0 0x38000000>;
 			interrupts =3D <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pc=
ie-rcar.c
index 0dadccb..54ad977 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -11,6 +11,8 @@
  * Author: Phil Edworthy <phil.edworthy@renesas.com>
  */
=20
+#define DEBUG
+
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -1054,6 +1056,8 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie =
*pcie,
 		mask =3D roundup_pow_of_two(size) - 1;
 		mask &=3D ~0xf;
=20
+		dev_dbg(pcie->dev, "idx%d: 0x%016llx..0x%016llx -> 0x%016llx\n",
+			idx, cpu_addr, size, pci_addr);
 		/*
 		 * Set up 64-bit inbound regions as the range parser doesn't
 		 * distinguish between 32 and 64-bit types.
---
[2]
[    0.374771] rcar-pcie fe000000.pcie: idx0: 0x0000000048000000..0x0000000=
008000000 -> 0x0000000048000000
[    0.374777] rcar-pcie fe000000.pcie: idx2: 0x0000000050000000..0x0000000=
010000000 -> 0x0000000050000000
[    0.374782] rcar-pcie fe000000.pcie: idx4: 0x0000000060000000..0x0000000=
020000000 -> 0x0000000060000000
---

