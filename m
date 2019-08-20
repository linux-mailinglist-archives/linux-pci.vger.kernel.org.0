Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3589585D
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 09:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbfHTH2r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 03:28:47 -0400
Received: from mail-eopbgr50042.outbound.protection.outlook.com ([40.107.5.42]:35297
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729370AbfHTH2r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Aug 2019 03:28:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAb1XY6XALShoMYDbq9nvBZscpHkJFKPpUVzBMA5/rN/F5iqj550wIcXy+FOfXYcRPqIlmjT52IOP6un0DKP5ac5Tjgo1BGNF8XyoJZKE2fZtMLV3BHnQcpy1PTvZTfbiiz/pZh+UhPk66buUrRPpl1AdQM6hBgxYXd/oSWFPeIEEB5HOjQ6G3NUh5dq+4HgQH3A3fdGOFyuDt0AbhaqASq/ia9O6DRdPG2l6XZrR3Qx+JwFr8fKxfQeg8Uoy9MI/zyBZdQAR3fyWsrklveW5nBaUuAnQyNkIYiGRSckQraOq1Q2mtGsqOCnK1wdwZGvR4QXqMKllLaZaRhW9DFD6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5i9txYWJMT8MYt5B7mqevbBv2T1FIEyxwXnJSDNCcI=;
 b=SWceyVir+17JIjIpXHoA4t2XpcSBE1WBJGvmrxx9hViAlRZGnaAbPPk1vtFf9Mnsv6ZhMjM9zoTqwcIkYPxfzhxEfQy+cYvEGdv7y0HP5+CDwszwTVZgL7INxU02poA6qj8dvG9bZTC4DtCvcHpiQS8gGgqeGjRWoHhoQH5uxwHCElBZod2Fy26tD5OmBY9z7OZOiM//D0a0KWGegDH2B38fl3uK5/qp0MqyfqQqccKuP57uX1sB76XCseR9KAYRIY00wHE/I52mX8ncUW+q/ZgLOWgxjzUI4Xqjv66jE1LaTPkgg6S+mKdCxbxmWk/P3nRdaWB92hfJy9m2LMwcvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5i9txYWJMT8MYt5B7mqevbBv2T1FIEyxwXnJSDNCcI=;
 b=GFJcxqZhkN9af3rGw0/JqeySkeOrBZ+aYUsTVfMvk7X7zKzo9lndeG4XBiUeY87Ts9dMsKYCsnsDCrM2/4ZP54992tKc1RkKqPXGJmgZJltNmdqrSp3GBaykXEwg5zh1jhtHiPJEUymjG2cdvM2yBEcFiyklI3NHRZrDska5dLU=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB5627.eurprd04.prod.outlook.com (20.179.9.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Tue, 20 Aug 2019 07:28:43 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb%3]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 07:28:43 +0000
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
Subject: [PATCHv2 1/4] dt-bindings: PCI: designware: Remove the num-lanes from
 Required properties
Thread-Topic: [PATCHv2 1/4] dt-bindings: PCI: designware: Remove the num-lanes
 from Required properties
Thread-Index: AQHVVyjlrdLaxDNDsUGTjgUCHNzTaQ==
Date:   Tue, 20 Aug 2019 07:28:43 +0000
Message-ID: <20190820073022.24217-2-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 82144e1d-aa0f-43fd-b2a2-08d725400796
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB8PR04MB5627;
x-ms-traffictypediagnostic: DB8PR04MB5627:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB5627E83942A479EDDA476D5184AB0@DB8PR04MB5627.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(199004)(189003)(54534003)(2616005)(4326008)(6512007)(1076003)(66446008)(66476007)(476003)(76176011)(99286004)(66066001)(6436002)(478600001)(71200400001)(81156014)(66946007)(71190400001)(52116002)(66556008)(54906003)(110136005)(81166006)(7736002)(14454004)(305945005)(8676002)(316002)(8936002)(7416002)(25786009)(3846002)(6486002)(14444005)(486006)(256004)(64756008)(53936002)(86362001)(386003)(186003)(6506007)(6116002)(2906002)(5660300002)(446003)(2501003)(102836004)(26005)(2201001)(36756003)(11346002)(50226002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5627;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: usoT+PFsZrxs5ZSa2zcdhD8xpeh/uZ+SxcMI9iBDI7PPpuUuNN5vXBWvw/k13EqUnSIXWasE6gtcbtB3XiXNvVDSJhGRM9O+ePSGQEBHngP9WEFss610c2B5T/kQqScHpVQlVuzUQqxK5lvQ5cXrcpJmZ1anUlsxGLdr0coB+xQ5RtbXN1ULRglUT7Ohtdt9rTNMzincsedNbu2fsiGVBu+0WSraiZh1bvUFdZ0DO2H3WPBHXtHBG12+mrmMD8NwnSYLEuv8LCiUoB/c/SZ4CtsNUMgy4JGcreuG6oCcYm4pGfGlckOYZ3ZO/LML7rIv+I8dsFIAEBlm3Uki7skLOioY6r9aCtiU4Xcl0xpdI/wbhPNmCWsIH+PGOpc5aIbmFbyISl6Zk6NrwZMkOsvxiFxwCtAF5nu7I1ra6xq97m8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82144e1d-aa0f-43fd-b2a2-08d725400796
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 07:28:43.6313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4euP2iQ+pL7ViGXth6D1qr44FMPWubR53Qa/2buAr1qNof7HBYHAkDOrZPDmWVk9ddyadI1c+nqnWKk1eOBabg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5627
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The num-lanes is not a mandatory property, e.g. on FSL
Layerscape SoCs, the PCIe link training is completed
automatically base on the selected SerDes protocol, it
doesn't need the num-lanes to set-up the link width.

It is previously in both Required and Optional properties,
let's remove it from the Required properties.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - Reworded the change log and subject.
 - Fixed a typo in subject.

 Documentation/devicetree/bindings/pci/designware-pcie.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Do=
cumentation/devicetree/bindings/pci/designware-pcie.txt
index 5561a1c060d0..bd880df39a79 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -11,7 +11,6 @@ Required properties:
 	     the ATU address space.
     (The old way of getting the configuration address space from "ranges"
     is deprecated and should be avoided.)
-- num-lanes: number of lanes to use
 RC mode:
 - #address-cells: set to <3>
 - #size-cells: set to <2>
--=20
2.17.1

