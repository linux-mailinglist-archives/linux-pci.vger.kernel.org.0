Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5697895861
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 09:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbfHTH2y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 03:28:54 -0400
Received: from mail-eopbgr50081.outbound.protection.outlook.com ([40.107.5.81]:41294
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729370AbfHTH2y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Aug 2019 03:28:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NL40BQEHT/daowuOnhL/oriVcd4a2UuH3KdRSqTRNBDvAdmPHmJCgryNEgg9WEt4XJgOkOiyuhVeBTUYOARabGaFVlkR2MZVIr2H15PEPsqnNI83WWwtyuk5bQw7yPHbKQw0TvPhat/EW/xhY8B1vOC7sEvdZsqRIeSOYYzi6m30NANOs81IEnJWZ/oscD/BYhp7Ri00N/rwH3n2MrPyNlWNmlLwAP95Yq2iOueZv6Cg5Oc+JHsJFu76bM3gI3D/UtmK6Fs2wMm98VPi7rVVj70RKcz+wPVDdduq0pqgn1lGk3h6G2UeK/IV30DBqDUz4OP9Un+wFeEfNpAtNbSvnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uy90e1wHWVAB9u62bo6wZba9DjHmAlYB2MyhG9ZYOZ8=;
 b=OBVC9KyWAabbX6H3KQ6KdhCKd85VGW9tv1wu/Jvd7h4RIVMdrXouF9Xv2IIK06g4Xkbk/cG02RdNFvvb5MHlVlp/2N3aT71C5/gABrp6sDBqS90i8jO51Q4/EMZc0AdNl/QtbiyctWklnwN4b0IfoMbJL5Orlyu+qnqiZajnmqr4PQlPVFoc9UBaxv8ChYy8tALI2/A0Q35ClBr1KtH0kHzJhc9sRPlriDgH8xmGTCjxflMl9zuwngDV5DTUqcD/Id2yuGThTb9cUxFm3a5QjBiTSWS27z7nlzqqc5z5dmMB0PfSkT+RmMf1wdp4jHslQlaR3cOUjmuUJcLneNbAPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uy90e1wHWVAB9u62bo6wZba9DjHmAlYB2MyhG9ZYOZ8=;
 b=O/zt/2yKjx4wRY64LLbLVcRwkRFOqKKDjMlPECctQ1iefshIBaIr+k4TRay136pxvJADcRhRq3YQcFRQTXq5ZnTinOCIIRP4v+Uy3tUGftJVsNuer0B9tE9Zxt8MhaVpm/4nmNrmw9eXic5O6/OTBgjjuamIpw//PZ/P9yfbzPk=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB5627.eurprd04.prod.outlook.com (20.179.9.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Tue, 20 Aug 2019 07:28:49 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb%3]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 07:28:49 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>
CC:     "M.h. Lian" <minghuan.lian@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv2 2/4] PCI: dwc: Return directly when num-lanes is not found
Thread-Topic: [PATCHv2 2/4] PCI: dwc: Return directly when num-lanes is not
 found
Thread-Index: AQHVVyjoYYapbxP8hUy34gCcDaXGwQ==
Date:   Tue, 20 Aug 2019 07:28:49 +0000
Message-ID: <20190820073022.24217-3-Zhiqiang.Hou@nxp.com>
References: <20190820073022.24217-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190820073022.24217-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::18) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f027966-3deb-4c19-bd13-08d725400b2e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB8PR04MB5627;
x-ms-traffictypediagnostic: DB8PR04MB5627:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB56279885881E6855A92A777F84AB0@DB8PR04MB5627.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(199004)(189003)(2616005)(4326008)(6512007)(1076003)(66446008)(66476007)(476003)(76176011)(99286004)(66066001)(6436002)(478600001)(71200400001)(81156014)(66946007)(71190400001)(52116002)(66556008)(54906003)(110136005)(81166006)(7736002)(14454004)(305945005)(8676002)(316002)(8936002)(7416002)(25786009)(3846002)(6486002)(486006)(256004)(64756008)(53936002)(86362001)(386003)(186003)(6506007)(6116002)(2906002)(5660300002)(446003)(2501003)(4744005)(102836004)(26005)(2201001)(36756003)(11346002)(50226002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5627;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oAPvtp1/wuSqIOgjWEfCA/CgD1/efj9c9PJfvUwPfGTKcds8HfmfrXClgYUSZanDKZaBkFrJsYehRjsp3mNvJhrSk9K4Tqz2RfE5q9gaXbOur6lEekCfmvf4J4shDMX+tKFdB+J1CBuTGykNqq7r9a+ENQpWm1RQ7tDPXgeiDLjF2SOFEB5CwD7ffA/FDh1NfB8a9EJxXMYXhBLQcYbulb3A3lUnG0MzAfYnqXK+kTYXoxdHrnz6y7N7X+BftZDVfOwQIP2gVjGcQvfgFV2qj7pNwphKfPcFKJWKM+LXvbpzkoLh7lZwaZigcjMh+upOSnmlnL9rPXNT1i/jzjixvLDgAVeWNuIsvrs5k/6QlOeoid4zRVvqO74HsO9dJnyU0ReJJBwpdt5tvrM7Ng3KGczvmbXMBwZjfMT5TIhr+bE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f027966-3deb-4c19-bd13-08d725400b2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 07:28:49.6509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t5HlMeoLrItYRRsI2MdETNJ7ZaAAk2puC/JyGEgycZJoMU7CmBJ34kYtXPDh5+tYG7vnmWsT8pszVHmxZmmzZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5627
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The num-lanes is optional, so probably it isn't added
on some platforms. The subsequent programming is base
on the num-lanes, hence return when it is not found.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
---
V2:
 - No change.

 drivers/pci/controller/dwc/pcie-designware.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/con=
troller/dwc/pcie-designware.c
index 7d25102c304c..0a89bfd1636e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -423,8 +423,10 @@ void dw_pcie_setup(struct dw_pcie *pci)
=20
=20
 	ret =3D of_property_read_u32(np, "num-lanes", &lanes);
-	if (ret)
-		lanes =3D 0;
+	if (ret) {
+		dev_dbg(pci->dev, "property num-lanes isn't found\n");
+		return;
+	}
=20
 	/* Set the number of lanes */
 	val =3D dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
--=20
2.17.1

