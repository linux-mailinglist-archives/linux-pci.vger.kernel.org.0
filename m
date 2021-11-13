Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E945E44F1DA
	for <lists+linux-pci@lfdr.de>; Sat, 13 Nov 2021 07:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbhKMGjd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 Nov 2021 01:39:33 -0500
Received: from mail-db8eur05on2060.outbound.protection.outlook.com ([40.107.20.60]:65056
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229487AbhKMGjc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 13 Nov 2021 01:39:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuiKF5na0Jyu/B2MZTUMXMU6up5J2zJnP2QPq5yZkg8OoLS8wKjXAcfeUoTvbjdIUM6wd2VOsJr83S0pueeXmoPa+9LH2J6AhkB6zfvJA1F/IZhCBTk5blKmlp/aQLJbTBx9yF0sTfgT7Y8twxU4LCA50TZAx9cd71GfiYrF7rhaYDmki3KnNuW0SgTQr/EDS8ln+9OOhwg5T0b545gxSRtiTR99a/2LnYrXSphjhZlereQBdezgSI/mIF1lXcFky7sKRwco51ntbG4VYxpc15dJrfWcd8jYTDsn7KrMyKLuFsjv8IoC5JjXxz1ka41Hu7ORmpdHGHv/evNf/uNsOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbU29xn1Bl+/GmaRI6MHmRTTDBAN3CoMTksSDPxUlUQ=;
 b=gRVjVa5e7J13RPWWarIiMPwX4khcaipr+jYBXp5Vb3cbF/ny6R5TCfeNqelP5KACseC5tB8SwRCGibIxwq7jRstUA6izLTHGU0sGR68ZtUQsVhRS4IPT4jrrgYcUyYlMGRRfLxsqyRmNyIaEsIapgDioprMEdKTG/K65XpX9Kmh1uZEmqAxpKo2Ztrna7COxlrT1VhVbU/na/LBtSLHwzlaU5ePXOyTnJtBCKRiCsed778zu6fHFecTLtH3YLhClLUkq675R/WrgzfRn/CgN3t6umaXIEu7SIc2iSalOHHGtFpyz8Gi/uhzsgBkiacynkxAjaji6yyvLrExG7afEdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbU29xn1Bl+/GmaRI6MHmRTTDBAN3CoMTksSDPxUlUQ=;
 b=HfP+EYe58yYOcoByCoFu9Bv6PC9+TtnDkE4Yc5mkqTKZfqHdzuiidkTwyHa1ehKlngUxgMlsMvj5n8WjPvmPBYjXEb+Abh8o1cMO0a8VlnsEKY9PJQrbCdX/BWf0B055QmDGtRWoPq7LMd67VwFWK3ZTKAMkNhtpzfv63wp4sc0=
Received: from DB7PR04MB5322.eurprd04.prod.outlook.com (2603:10a6:10:1f::15)
 by DB7PR04MB4906.eurprd04.prod.outlook.com (2603:10a6:10:21::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Sat, 13 Nov
 2021 06:36:38 +0000
Received: from DB7PR04MB5322.eurprd04.prod.outlook.com
 ([fe80::d4a0:67dd:1872:19ec]) by DB7PR04MB5322.eurprd04.prod.outlook.com
 ([fe80::d4a0:67dd:1872:19ec%3]) with mapi id 15.20.4669.016; Sat, 13 Nov 2021
 06:36:38 +0000
From:   Sahil Malhotra <sahil.malhotra@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH 11/11] arm64: dts: ls1028a-qds: enable optee node
Thread-Topic: [PATCH 11/11] arm64: dts: ls1028a-qds: enable optee node
Thread-Index: AQHX2BWMhZViCHKynUmVLYvls288mawBASTA
Date:   Sat, 13 Nov 2021 06:36:37 +0000
Message-ID: <DB7PR04MB532234C5ECD4B0F76A5F451F82969@DB7PR04MB5322.eurprd04.prod.outlook.com>
References: <20211112223457.10599-1-leoyang.li@nxp.com>
 <20211112223457.10599-12-leoyang.li@nxp.com>
In-Reply-To: <20211112223457.10599-12-leoyang.li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13f7bb20-f93f-49ef-ea10-08d9a66ff1fb
x-ms-traffictypediagnostic: DB7PR04MB4906:
x-microsoft-antispam-prvs: <DB7PR04MB490644EBE46E798FD06490A982969@DB7PR04MB4906.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:454;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MMmhe/0VPngaIcgh0DQOraYH811rMtBJEutVMclY7Mf/7PFUAw47xbdl4Wda/YVhmYIXeqSSBANMbvxitTvQMTdtoIgH2d3ld8YrsJwnlwldm7A9fT5CyMCpVEyxtCqhrj12ZZmAZQyldZsmCcAlBw22XOaTSpRSqe/heNylgy4UVi2loFj8MpnszdzIYXa/46oVj9R0BKpjHetFFuutxw+quqvH2yFqOw6CJz5fGi1PNirwU+Cx7n/1mfRAMWlEBBftPYTO7uY+rCwY1WVhNrt2uslll1jgs/g/XQVH2CG90sYYbjB+Zyx9u7GUMIY2JtLrJvgY5WjKpmvR617Z9gE4SK6bIzPX7NyvkQpNOqv6YPy4OWpQAoFGLJDULQohIJHpQ4ZLWo1oMi9PzqSyBxjD+/MVr+vdvMjbbycdVEzv1Z8+9uORpTEs7n3FuvnGBqL434Zi6AS38tsVd/ibHoWN22/H4ELCrqa8w3YK/nDr46QEvLyXRNBuBiaWE9+TjNlomNtOprU5DbSad4vjlaUaoYgiBTSTrYU+5WAORZ9MAnI5fFZpm2b2YENjCD+43tmxYWWRHufn8zBOX41foxmXPBzZ5MIagAw0ePdjlAdlKhAXvpGm7IwkBOos4Q2y5BwJIsJJUdlpLG/gzZhbQ/qtko8NX+kj+sMQoBlDQfypN95VGIG4KMW4thvVox6E08EtabeLo9A8Rr8NwIOwHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5322.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(44832011)(4326008)(52536014)(2906002)(5660300002)(66556008)(66446008)(66476007)(64756008)(76116006)(66946007)(122000001)(38100700002)(86362001)(55016002)(54906003)(110136005)(9686003)(316002)(6506007)(53546011)(33656002)(8936002)(7696005)(186003)(26005)(38070700005)(508600001)(8676002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WcLBJNOcsufre05BLARSI2GGwR/Avqtm6kK63vXUqDe/jq0+RJemDqcSCKR0?=
 =?us-ascii?Q?2hoMP2xnej5+Klkf4qSDpCwD20QQMdluqEa+4P5Atdzzn0j+MD5WDS5YqbXT?=
 =?us-ascii?Q?l9BfBIpRX0eet3Gt+U3BFyXWOcYuCJdd/1Tp/JxWw0Rk+eoxVjMA4fQ2izuI?=
 =?us-ascii?Q?bz3iMKYW7zfkHKbwIGS0020UguUvpKu2tlhDjJb/ik8wq/4eFucGTqsLDdbi?=
 =?us-ascii?Q?HHbSVwbTAIfoE6W/hEFJnVdRDoVDgSCB5IVwOyLBBIFMKPEhE2/N0hDIKC8u?=
 =?us-ascii?Q?r8wIvnr7k3BSs1di6Ahl6jVrKYv+qZWaCnjTLAXp7PWOSjab6cw22uywLydN?=
 =?us-ascii?Q?OmcBirhRS1rDwrzHfg4oOj5IZbeXV3ApafM8dfsxHvo2rTM55LRlRQe7/Fhi?=
 =?us-ascii?Q?9Fh7nVXFvGIxvyu+ern8W4Z83u5fVvlsz7aATY7+xeT8HdUQBNl41BmNrM1a?=
 =?us-ascii?Q?1FtbIGHAzdHryyj7yZueqZznX5DqjFJBxZaWaZpDqJvxiyWQfpTASFusPhpL?=
 =?us-ascii?Q?6IlNYv+YtHHE/7jWM4M/ggfdmxZ5rFBGRxPdHQa09qONy0afeSprcdALSYf8?=
 =?us-ascii?Q?DXgXuDQFdMXkbb70BPEry+WYxVa3H3Nm9Zb0Si74k4YnPLd9lJMaHqmvBlmv?=
 =?us-ascii?Q?cOZWSlaLQC0WWt/IoSIVOp6BepFQ4w3RhLbHwptNAkyRJosr5JnlEvMynYCX?=
 =?us-ascii?Q?2xvBwCCD4TrfgVWGAQYN81wzhRXPCPxuFgOtyaZZM36cvPxooZKctNJG7jmw?=
 =?us-ascii?Q?j422YaE+OH8IoBpzwOhUEAGqBrYeM3Mgiq6JNsKlNv0sbGtCX/0afVCs+mTH?=
 =?us-ascii?Q?eUGgsC+CqqBoUt5MsAYzlCFL2/WO7j4C3IVcaTPKLuLWINveMCP3al3riyoU?=
 =?us-ascii?Q?tN4cnmeZBKldl/39GWhQSixy+mTuem/8gsSGkvxVAqxIEo03sTQgySs4y1W7?=
 =?us-ascii?Q?Cd0x2TrOJ/NRvJxRDHzA+zywmfKZExdG+6SZPOUxFfeX/P4VeyJHv8gqOA9u?=
 =?us-ascii?Q?p6fBJuXXEuiBSQk49hsg1eZIAURl0vusviwyqsFFbZoKTqawhLM18p92Dx4B?=
 =?us-ascii?Q?f87iPGt2TB7JyWYZmAcT4oTfLV9T+bPziW0BdwugCQJSshgqnOJYAHNCppFC?=
 =?us-ascii?Q?FGPJUAnHXNk3HGvBODs1ngPel+PYcKGY553pZ/GAotemEksbPZgx9awpRpDl?=
 =?us-ascii?Q?SoHV0QP5YKJrZgKfzhDc+9wqLdFo+ZeoCu42Tq+6Q9nhUBlVUXFUjW4wRI+p?=
 =?us-ascii?Q?hWf6F+3T85HGb+NKyi0eRHT3FeqLycwS390hZHjvn1t+eJlSFaba/DbxQ1Yo?=
 =?us-ascii?Q?a+I9/AyDwK7wNLT1fQVqaL7lONVw+yTzP5jkKw3gWOLo8tyzsGlEtdjVf+rK?=
 =?us-ascii?Q?Jb6ObmM0HDk0lwlyn0LecWZ7nbJiC2GOEAl4GTKiAeB59K8fnPRaOIDvyULj?=
 =?us-ascii?Q?1lop2l5uuSbMVgTjw1Lty6gF/wT+QZDGMAKG5IRO+NTOV7uqGTt2AhjdZoz/?=
 =?us-ascii?Q?52Aq+rIW/90ySEIBTe4W6rPZdthT2KZiJ4lyjl4qehCmG2qHV2S2OK/u3QaX?=
 =?us-ascii?Q?j8Bve6iUFJJYQfhXac1oOVPg2afLlxPsNpngrLvbG0lILMWcCfi5OWW0c8Pw?=
 =?us-ascii?Q?4g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5322.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f7bb20-f93f-49ef-ea10-08d9a66ff1fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2021 06:36:37.9485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EiESHHotjOw0xlYT0TbQkm/5FagIRpdW0Mit2/P57G09ThAdaz+YlIGz3gyxjkRIG4UWQyZNozoCRNbDaxGqFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4906
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Leo,

We support OP-TEE on LS1028A-RDB only as of now.
LS1028A-QDS doesn't support OP-TEE.

Regards,
Sahil Malhotra

-----Original Message-----
From: Li Yang <leoyang.li@nxp.com>=20
Sent: Saturday, November 13, 2021 4:05 AM
To: Bjorn Helgaas <bhelgaas@google.com>; Rob Herring <robh+dt@kernel.org>; =
Shawn Guo <shawnguo@kernel.org>
Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vge=
r.kernel.org; linux-arm-kernel@lists.infradead.org; Sahil Malhotra <sahil.m=
alhotra@nxp.com>; Leo Li <leoyang.li@nxp.com>
Subject: [PATCH 11/11] arm64: dts: ls1028a-qds: enable optee node

From: Sahil Malhotra <sahil.malhotra@nxp.com>

Optee node is disabled in SoC dtsi.  We are enabling it on qds board.

Signed-off-by: Sahil Malhotra <sahil.malhotra@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64=
/boot/dts/freescale/fsl-ls1028a-qds.dts
index 0e2cc610d138..9c74be22d263 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
@@ -349,6 +349,10 @@ &mscc_felix_port4 {
 	status =3D "okay";
 };
=20
+&optee {
+	status =3D "okay";
+};
+
 &sai1 {
 	status =3D "okay";
 };
--=20
2.25.1

