Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D45F89612
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 06:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfHLEWW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 00:22:22 -0400
Received: from mail-eopbgr40052.outbound.protection.outlook.com ([40.107.4.52]:41425
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbfHLEWV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 00:22:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsF7YDn4UMkgmO7EvsuLs6UkisyVu0l67sBdJnm2nApD05joUeZNr1L+uHnLR7XTW3iEQgoZPHwFUp5sF8GaF6yk/hGEXal96Gupvb4RyUBtHmpcvO4tCv0kZTvhoobZ7rV03TQWcVRsr68nWCt2ooslPAEJDyhn4BQf8PozDGlComjMvHkN+pMyyLod3mg12ZkU5HRSASJuADS1BhnX3KBiIulQb7VQmAE70z7NjdR3efpt0J0WAjqB2hDYgHKFxCnDghbDFntaq313XCR+lrpRfpbd2P515oOSQRB4HIOsVjC5n/33etvFabu6Qp6wz6PzDr6Va9X3VU1fNJcfEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EG700lrQm+MfmR0ADwb4ksaoTp9Dv3tRaZ4l1aDvzFw=;
 b=Gnn69kP3Em2dMYZy1iWb6cBFc/H1wIr/Xj8vtHHd6CpCNfR75yk3NNiOTPpxb/CB32W9IRAB3SUsH3p/wmwlyHuRbeDKGVkEe5CkYBp49t+604hggo7hnHuG4D1NPK0tRZLiVJPm/FTsIXFouTELdjem3Ry1B1MgYPyRCiUnKVNkG2yDAy5Qu464krXG7wWAtt8DYGNoebmNrGkZCEDvxYxrLQw5+VTmBnRsN+LDQqTcN0hl294b7AH14n1FNS+DsOzJmCnFi2MzVLHo9ZKE/lhHLNfpydYuRPD8HErn60ZgINpfWLDNhu/pVW694IdVMSBuawfqt6bsHSL5BfoKKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EG700lrQm+MfmR0ADwb4ksaoTp9Dv3tRaZ4l1aDvzFw=;
 b=JXD0SZ3FC4PrwS9I/YIZLqm3RhfSUINtbm4JzvMLF1tvH5Nl3e0Q/pStNcQkpJRlVMu9eSn5HD4T5AMUTsLuvq/9RxIlWG6up5fTqheWm4BHRzRVn3kkoIk8UiwXlmsh3fMYAP3sxu6+zCU5iYv8vZyGplMPu1VL1LUZtboK+LE=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB5931.eurprd04.prod.outlook.com (20.179.11.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.23; Mon, 12 Aug 2019 04:22:17 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb%3]) with mapi id 15.20.2157.015; Mon, 12 Aug 2019
 04:22:16 +0000
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
Subject: [PATCH 1/4] dt-bingings: PCI: Remove the num-lanes from Required
 properties
Thread-Topic: [PATCH 1/4] dt-bingings: PCI: Remove the num-lanes from Required
 properties
Thread-Index: AQHVUMWGvFlksd6l7UqMedZRUuiO6A==
Date:   Mon, 12 Aug 2019 04:22:16 +0000
Message-ID: <20190812042435.25102-2-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 5e06ed89-0d88-40d7-3be3-08d71edca876
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB8PR04MB5931;
x-ms-traffictypediagnostic: DB8PR04MB5931:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB593135DECD8FB34CC77C5E8884D30@DB8PR04MB5931.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(189003)(199004)(6436002)(256004)(25786009)(14444005)(66476007)(66556008)(66946007)(50226002)(2616005)(476003)(64756008)(186003)(11346002)(446003)(486006)(6486002)(66066001)(66446008)(53936002)(7416002)(71190400001)(6512007)(71200400001)(2501003)(8936002)(4326008)(8676002)(6116002)(3846002)(76176011)(52116002)(110136005)(54906003)(305945005)(7736002)(1076003)(81166006)(81156014)(86362001)(5660300002)(14454004)(26005)(478600001)(36756003)(2201001)(2906002)(386003)(6506007)(102836004)(99286004)(316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5931;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u6FWg3+Qd4iFxajy3eOCHG9ZgqmDrn3cEVCB5vZl1D0RcBtsYbZNN/NQyKMR2QtVHrOPVm4WTONCEcGp1Caqhh9U1Y3B/ZcAj4Pet5XWN4GqO/UpLwEFyCDD1zGEcgzxVIhd6YlZkd9er710IGGA+mBHVwQKO7+y5dpYeTLUkGHnHm2k2WNh1K7BZcntR/3Mcmqk0h5AYrd5y9ejdy/UnvK9cRoiuL4j/tryBTarkbU+cWxGP0vOsxw+43N+G+Itf9hlHP4KTa62rfGfdwafLyMz/lP71/xlHyWEfK1in76573X3ceEG+GSTcMUrAEh+D8UfYFITRZsaXxhn7/X/UjvH8ByhzYINYxF2y9ILqayT853pP/Ef2S1oAvrkBiOBnYy1qZyCAvqiakBlCVpEx5FY65pHsdT2Qwlprip3bnU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e06ed89-0d88-40d7-3be3-08d71edca876
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 04:22:16.8301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 22x7u6ULxGDAAuV3q5LGQEtMiD9sIcaW6R+1KFjrYIC8uK6a/gHKbYnR8jeg5znjuAVagME98N8gUP5F1LYzcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5931
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The num-lanes is not a mandatory property, e.g. on FSL
Layerscape SoCs, the PCIe link training is completed
automatically base on the selected SerDes protocol, it
doesn't need the num-lanes to set-up the link width.

It has been added in the Optional properties. This
patch is to remove it from the Required properties.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
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

