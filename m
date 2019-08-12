Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD2928960C
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 06:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfHLEW3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 00:22:29 -0400
Received: from mail-eopbgr10050.outbound.protection.outlook.com ([40.107.1.50]:13314
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726805AbfHLEW0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 00:22:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwuKDL1uNvC73N2CGHktEKw6eatEBCTnqEepCecgl+rkfb0CUvVOIpQuW1b4ue/q71s6qFpHHdPC4z4N07o022Nsmc+8vAQ0JXPSYh9vqMHJimiiCCksN0RKH03hdEs3Tf/N4Xb2l1/jqxZ9qMSUpnb4D7fE+oiew5PkmTVFyMwJgWB8K0YmBgwMo9CbsjT3C9+wj3XDUp4uoI7SUOa3cbEbo/5w5Jbi/9THJ9hQuINrLEZEZpyzwd+ztB48LVVxcaT0s2mF7zv5m7ro+9C1k5sYNaQBqN6Co9YHDvUfxAmoVVUrSM9bdsbCiUN0IBJ9L5Zzf9W+g9/Xpuo4DDW0Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuPR9USDNJ0zLmZcNYBKTTfUb0Pc5v0J9W0qbSDkliw=;
 b=H9KqFHVIoJD0ub40fu0QuUM1t4DRiEj000cZ6SOIkyOr2PkLayM4pczZkZsXcuCTLm0FPGqcxlRH4OLi6dObCyy4lcoKkbP0piAGaAQSyJoB3cvE64A1yRJ6iXV616N7YEZ866dCiKYKzRIrlV4U2tam//6Iiv2+xdSTqJWsH6cE3aaSB93IX6OlJbD7ndkAtCn9MUoKBxmEFtYTF+wvpTVuj6f4mMqsnhcQWp+sIb/d4gb865/+YW28W9tc2A4T+QzoZX+Dim+wXLKdYgt6OmVP81NAcxHw4P1saNfgm0HWfD92SNiogm4AWBHyBsdam16bttyNGOK57lm8Tk5zVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuPR9USDNJ0zLmZcNYBKTTfUb0Pc5v0J9W0qbSDkliw=;
 b=gTy/agJMlNfZVJGl+WFBrFAO1/Qn2eztHrCbDCzOGk5W0ZlwUIVCapAS175Z7W8U7TVYAn3pzwliszW5iutRKVxGzeyzMwAP4oLvYaH+F1iDBNI1/QwIWPVZvT2uJ8KCzP9lrVLd7bvCMijKhlURDzkjxZ1v5uRBZjwfYEg3wEA=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB5931.eurprd04.prod.outlook.com (20.179.11.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.23; Mon, 12 Aug 2019 04:22:23 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb%3]) with mapi id 15.20.2157.015; Mon, 12 Aug 2019
 04:22:23 +0000
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
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "M.h. Lian" <minghuan.lian@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCH 2/4] PCI: dwc: Return directly when num-lanes is not found
Thread-Topic: [PATCH 2/4] PCI: dwc: Return directly when num-lanes is not
 found
Thread-Index: AQHVUMWJYdzIy46VokSNj8ZzDl4Zng==
Date:   Mon, 12 Aug 2019 04:22:22 +0000
Message-ID: <20190812042435.25102-3-Zhiqiang.Hou@nxp.com>
References: <20190812042435.25102-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190812042435.25102-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0060.apcprd03.prod.outlook.com
 (2603:1096:203:52::24) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec292f5f-ba13-49dc-c1a8-08d71edcac25
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB8PR04MB5931;
x-ms-traffictypediagnostic: DB8PR04MB5931:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB593156AA0AD90E15B86D424F84D30@DB8PR04MB5931.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(189003)(199004)(6436002)(256004)(25786009)(66476007)(66556008)(66946007)(50226002)(2616005)(476003)(64756008)(186003)(11346002)(446003)(486006)(6486002)(66066001)(66446008)(53936002)(7416002)(71190400001)(6512007)(71200400001)(2501003)(8936002)(4326008)(4744005)(8676002)(6116002)(3846002)(76176011)(52116002)(110136005)(54906003)(305945005)(7736002)(1076003)(81166006)(81156014)(86362001)(5660300002)(14454004)(26005)(478600001)(36756003)(2201001)(2906002)(386003)(6506007)(102836004)(99286004)(316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5931;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tR8ohjz6E/Rp1PIl5yJlCWk20lbro7Diom+951JzfB6MhRkNAm2RlHY2SO9O7XQxmFoWA3s14CNCMIiJ5bqW6XPW2/s4i4d3CS5hu962WfY+r4kT+xEJiH1dQRcWUsSGzPvel2xr/m/9sCj3nV9XEaKXJ+O1ch/GZKTygG1oy6XFshbUay6btZzQF4Tf/E4VFr/BNf62G8Eu0Rl5geNHxJJT/vjw0mqffChClSURSHaSAMOHF8Ecjtit/PwtTn4ExRlfP+tLDR9UDciet//KF/zw17OVWXUgfCf2ByecLVlLD9ZZvc+OXijlid1ykStFMzmqC3DCr1/dMRD1LqRGTocSaLQ6b7926cbnQRC6kyXHtgPy6setSCwrvZjpKyelVeqy5e3Psn6QOY9Kcn/1SrBu4lOoTjl7yHk0lqRrH6I=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec292f5f-ba13-49dc-c1a8-08d71edcac25
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 04:22:22.9676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ujcgmYEeyLeE1sc/ZYUQHrsZuoQSQZtPTYOfHtYekD/078USWxQOWYQAEM5dcEP4gJGkboecxGpjliDVaAL2qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5931
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The num-lanes is optional, so probably it isn't added
on some platforms. The subsequent programming is base
on the num-lanes, hence return when it is not found.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
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

