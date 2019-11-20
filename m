Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B77A0103225
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 04:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfKTDpe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 22:45:34 -0500
Received: from mail-eopbgr00058.outbound.protection.outlook.com ([40.107.0.58]:36436
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727357AbfKTDpe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Nov 2019 22:45:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=em45W8fTrhEAZoSaqFobJi8iHUPREnxB4AzfERV5dQlehfctv7zPDn5vPO9+OvM9JU2Fpl07rYM2efnyCMqWHodCIvUWSDpem9TiKUpFqeI9XzR+ucs9fFanGr+FwNhP4MJ9IsbGo3M3MsRStSd+wzONfgF7QcBuinUtv6RsNWz+mxiGSDFzHzUYu6Xso++CPsbiY3MnLnGr7KeJJ0acvqNJnH+8K2zOyTiOozT9/q+rcI5ypOniA5sJBkDX5LUKT+dW8YiZoJ99Qr8L4YKHTx3jl/eXosApy3GYIUP1eg0svNYHcYmq8rF+Bsa9W78lIwWJPVQRLPQuWO/Q7CSzrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tcCzCpg7MhUp68daqYKGFgRIlEc8U/und6a3AG+9pI=;
 b=W0AV0rwjDOCLEzrcMpCGtlVjqAkiEfCcBE84b455U+UtNkh2ft7Z9uD4hXuFpzZ+8VamVwKkNz/SN/XMRtB/8lM79TQgFM0bWZ15PKVfAXpJp1vzhSXBX/teLibrkcdTbeDbXDJ3glzzJDI0x47fGugzOzMtmTELf+U4rH7MV8NKPYYDYd5sDj++VdvIRKbGlyPXfrSgDGUjiyUxV36veVVl1fdya4beMhAUbpp6GH8BgnvOUH6eLoTwxd6HBfDfYNFlhSKMYKNuqeRsbh65QreSDn31lE5+ohkXu6ixtS56ztojHLJItfcWZGCNYB/u1niCQTHTd4eyWKAFrzNEyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tcCzCpg7MhUp68daqYKGFgRIlEc8U/und6a3AG+9pI=;
 b=r5WmqLa9gwtBa6bjl594p9Ys5yUvHOTAmgCcFVxhZHJweYGjhdDGORXX3c+/RzLqc6xfrY3gBMe1Whav/0KqWMGak8lmAsHT/YblyQvGS5RKdkGQvesUKmI4NSASS2j21vPU4Dco7m6FflGJwy2sIOlUsvDmRhszV681anHpsf0=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB5657.eurprd04.prod.outlook.com (20.179.9.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 20 Nov 2019 03:45:30 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::898f:3cd6:c225:7219]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::898f:3cd6:c225:7219%7]) with mapi id 15.20.2451.029; Wed, 20 Nov 2019
 03:45:30 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv9 02/12] PCI: mobiveil: Move the host initialization into a
 routine
Thread-Topic: [PATCHv9 02/12] PCI: mobiveil: Move the host initialization into
 a routine
Thread-Index: AQHVn1T0j1qfl+edyE6Gq9MkhB5hBA==
Date:   Wed, 20 Nov 2019 03:45:30 +0000
Message-ID: <20191120034451.30102-3-Zhiqiang.Hou@nxp.com>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0199.apcprd02.prod.outlook.com
 (2603:1096:201:20::11) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5cc634a7-b256-41c6-68e9-08d76d6c16c5
x-ms-traffictypediagnostic: DB8PR04MB5657:|DB8PR04MB5657:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB5657E9AA02A341A32A8841CB844F0@DB8PR04MB5657.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(199004)(189003)(2201001)(54906003)(86362001)(36756003)(256004)(7736002)(305945005)(6116002)(66066001)(3846002)(110136005)(316002)(71190400001)(7416002)(1076003)(71200400001)(52116002)(2501003)(4326008)(5660300002)(66476007)(476003)(64756008)(66556008)(11346002)(446003)(76176011)(2616005)(66946007)(6512007)(66446008)(8676002)(386003)(6506007)(2906002)(99286004)(102836004)(6486002)(81166006)(81156014)(8936002)(50226002)(186003)(26005)(478600001)(14454004)(486006)(6436002)(25786009)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5657;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4A0KbhAdvAKEL5XsoFjbnRBgYoCp4t2w645CJ+XMTu3KOebhsw+I8bvEs9lStcqf/mK3/cBf/jWn+97VJO2gLin+oU44HJtIhxN9EBHLhL9tpZVvulPnKY2jUk0NIvVp7x/jZ74dMkTYnY59Xc8BsuIN5v3qrtFa1XXkNQh83oVLET1z+TnyajFP9Zu5oTlD/Zem3UCfZF9hBZ93ToRIg7SHViJUlv2ZMkRpajNPDsiNi4XyJ7v8eQh22ETmVwrICVE9QnReOGiuNCvsaVq/3zZRb3pTkCsdr+T/0WVto6tWHQekS7bXU0MhoABSrQvBoCwAlyftRE87oNPFpftn/rCrgk34CyW2NoSXLFviWTlZtG5VSogN54jUyyI8ymVNm/PBO+W2JGup41eAwXZfRVwCzNhROA9Xkthrx9iZdx2FUHcvdldFDKCKgP24q89a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc634a7-b256-41c6-68e9-08d76d6c16c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 03:45:30.4714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RAyEzTHD8749SWCUdP+YVR3y6WO3MNLnN5Cg2jUfyb2lM8qTPaQxdHHFehAgYqYq1XQYaxyFvrm1FEV1+TIifA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5657
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Move the host initialization related operations into a new
routine to make it can be reused by other incoming platform's
PCIe host driver, in which the Mobiveil GPEX is integrated.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V9:
 - New patch splited from the #1 of V8 patches to make it easy to review.

 drivers/pci/controller/pcie-mobiveil.c | 38 +++++++++++++++-----------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index 5fd26e376af2..97f682ca7c7a 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -873,27 +873,15 @@ static int mobiveil_pcie_init_irq_domain(struct mobiv=
eil_pcie *pcie)
 	return 0;
 }
=20
-static int mobiveil_pcie_probe(struct platform_device *pdev)
+int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
 {
-	struct mobiveil_pcie *pcie;
+	struct root_port *rp =3D &pcie->rp;
+	struct pci_host_bridge *bridge =3D rp->bridge;
+	struct device *dev =3D &pcie->pdev->dev;
 	struct pci_bus *bus;
 	struct pci_bus *child;
-	struct pci_host_bridge *bridge;
-	struct device *dev =3D &pdev->dev;
-	struct root_port *rp;
 	int ret;
=20
-	/* allocate the PCIe port */
-	bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
-	if (!bridge)
-		return -ENOMEM;
-
-	pcie =3D pci_host_bridge_priv(bridge);
-	rp =3D &pcie->rp;
-	rp->bridge =3D bridge;
-
-	pcie->pdev =3D pdev;
-
 	ret =3D mobiveil_pcie_parse_dt(pcie);
 	if (ret) {
 		dev_err(dev, "Parsing DT failed, ret: %x\n", ret);
@@ -956,6 +944,24 @@ static int mobiveil_pcie_probe(struct platform_device =
*pdev)
 	return 0;
 }
=20
+static int mobiveil_pcie_probe(struct platform_device *pdev)
+{
+	struct mobiveil_pcie *pcie;
+	struct pci_host_bridge *bridge;
+	struct device *dev =3D &pdev->dev;
+
+	bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
+	if (!bridge)
+		return -ENOMEM;
+
+	pcie =3D pci_host_bridge_priv(bridge);
+	pcie->rp.bridge =3D bridge;
+
+	pcie->pdev =3D pdev;
+
+	return mobiveil_pcie_host_probe(pcie);
+}
+
 static const struct of_device_id mobiveil_pcie_of_match[] =3D {
 	{.compatible =3D "mbvl,gpex40-pcie",},
 	{},
--=20
2.17.1

