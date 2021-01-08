Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEFA2EEF9D
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jan 2021 10:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbhAHJ2g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jan 2021 04:28:36 -0500
Received: from mail-eopbgr20073.outbound.protection.outlook.com ([40.107.2.73]:11339
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727375AbhAHJ2g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Jan 2021 04:28:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDtBQGKxmFA/h6CA6/3aQ0Iu+oilx4bLbBWZyhY4IiJiQpXWK8B/Q2yF6kSdIyXwUDrPZM/N1Uoz6AIuyV4oJjvp579oSQOR8hIid2+ynQxjWzdo2wSdz+3AstU9WZXjdTmIVnnQiNpjuDnyVH+52VHW1BzzyBuu0S9LbdDvwa/orV9awTaGxP2+KoHiF0AHxPnqlG+QquLy1eWbXgWNMI5LC8bl0qCtBgrxWVaK7jIxmYEcA+CBd0gxCF6FB6qrasBZePNteJkmEHOqgjGXrlNVXuEkcJD9TWq0tHK8bQcmjoWjVIG5UraOR+7j6GCS6f7VUubO4uAMS7YZ8A8CSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4BDYxD4IGOqm+xQnyGp5Z2TNKwh4xmeFteDxqgitIE=;
 b=TBkDYureUN+MRHu3uNWJo3XG3GqPiiJabFoXRNfdszEt5WhG949WpxQmHBEGbMmrYMjlvX1yf6Sh5uMDrr0HU5krXrNceQpwpPtqtHltAhExTREunDhcrhnjN1xg3YtHLGSVhh9n6RQRwKJPHR4QgYd5/i32rvQiAS09Ih6B5CZYtgMhCDt67KSMsNreBfYkPAWjp5GU6bijU18B6G4EAdSz1POVvyYi5Vfof8WiIq0olwqsuFlr0xL8Nm2oF8DIofKZYthjGxFTCfkOmBG0mBSUBsBDRjbVTN1qPWGQizGginyxBBTxd5n3q+etK881BEAY4KLp1GIpNSueUmryVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4BDYxD4IGOqm+xQnyGp5Z2TNKwh4xmeFteDxqgitIE=;
 b=ZsXswskqmQXtCzkeyRjqRIvatA+wZjzv4hgOc/b6m2MNes1xE4/YsYCTaW+grdJMlTGq0Xg5Z2OvZd4y8qDRHOj1SFUzF9zsl6W2f+UmNdtDN6nqQnrKZeVF8AVRBNliTemAFw5ePqKCcT/PV8h88lbVKVGqnPTwfnrq1qDbNQ8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.22; Fri, 8 Jan
 2021 09:27:46 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::3194:64d6:5a70:a91d]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::3194:64d6:5a70:a91d%4]) with mapi id 15.20.3721.024; Fri, 8 Jan 2021
 09:27:46 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv3 4/7] arm64: dts: layerscape: Add big-endian property for PCIe nodes
Date:   Fri,  8 Jan 2021 17:36:07 +0800
Message-Id: <20210108093610.28595-5-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210108093610.28595-1-Zhiqiang.Hou@nxp.com>
References: <20210108093610.28595-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: MAXPR0101CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::29) To HE1PR0402MB3371.eurprd04.prod.outlook.com
 (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by MAXPR0101CA0019.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:c::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Fri, 8 Jan 2021 09:27:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6af74a16-04b0-42b3-2713-08d8b3b7a8a6
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3371:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0402MB3371FDAC4C0F994C2B7F58B784AE0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ywOAzlhlKPnSHUWg7mffvYfW1jPGpS65vIqVaz/V1nM9ZTYhaZVN+TSah4u7XPk9gMV2DysXH14JerRhqDQ5twg62Vi9gCCmXNZL44ertkbh9qMfc2Kt3bsKG6QktsAJy9XpW9NkjykTiowqypQ66LIDrpW4fdrI1VBiOX00is0YMznmu5G010j/V9SJLbq72rQGnVJQ6qC09EJgFpgBd2Id8p7AA3XjBVMbQabjLVy6i3adNfp+rnP+GDHND1yV4E8NMFiOROhhEIqZVCl9Kk8dIYZGcjh32BJTDCPaQ//V/A5+RVCpoz0/xx4rdq6RwWGYXQzcBa95KFL0a4pn58jJlMCiZ6/jgZnD3/zit9zG0IDFLV+TzAxE8I7lxRNYLZHWVrK9A09IkoKIqy/Nro37cc5cTinemBs9aP7JW79gsdIm2pP4tGOz/GdLK/GgK4kL2BgdzYc8YP06a97nuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(186003)(6512007)(16526019)(26005)(6506007)(36756003)(6666004)(66556008)(69590400011)(8676002)(6486002)(478600001)(66946007)(52116002)(2616005)(956004)(66476007)(86362001)(4326008)(2906002)(1076003)(921005)(5660300002)(83380400001)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QQdlpYLAlMrpuUHIOGVmNaMpee1Ll2jRb2POMndpSuDoZwmyBsSWjjEp6afq?=
 =?us-ascii?Q?AyLgUIbxNStDad/alTTUQJ0H6M8mLanLJPive8o7k+MsYUChqUSgOUTgnEwJ?=
 =?us-ascii?Q?teHKnKHu6BpO+z82DeBjKohNOs6oFos5pbVW1rTRBS5K+iorfevookOlVVph?=
 =?us-ascii?Q?EsRUCvybdmdk1mi5mYapnSNu1gR0oskSe9Lb7kkhlGdCX7XBSski+gGftJR2?=
 =?us-ascii?Q?DVMQD5RkUtevd2pGJ4g7FkDH41m++JZUqApiTIPAUyw0UOJZAzVafxrm6pkI?=
 =?us-ascii?Q?nt27dr0k29eAqiq1KvbH15eT4s4eg5dARo/t6fv7k+tnKci/zz84M1XlA29g?=
 =?us-ascii?Q?Jm6iumukolCPJXXNgRSO0HZrHNHXFJoYCrS7Xf0/t2482K0Jsp7+9R1/V4wZ?=
 =?us-ascii?Q?wfnzIUuUrIofsGAKAC+vLqomCkLoTeuEkDMFc5UDYSKQHXG43i62xhvG8Ui2?=
 =?us-ascii?Q?Cu17fUNp83dx9waFbCWIvTIOcXztALJO26+7kL8tTffMVi3GZdrgX8h9Y2HX?=
 =?us-ascii?Q?ty0J29pjgAzVa7+zBhLUVCGMiZ8C6WcU1q5t961YZ/F+UM6rCBPuuxDTi/WC?=
 =?us-ascii?Q?YgPA66OguM6Xr3v1wVwge9autolBfW1Iy8YPgJyKCUPln3AvCJjvn9uYlW3Z?=
 =?us-ascii?Q?Gp76MjRBkKLVMKLiQlrtGZb7fa4YIcQquKmXWnXtpXVVxDwgMphuZiY7iO40?=
 =?us-ascii?Q?bc40gmiQVsNVIh9DXK5rrLVQ6XFzm53ZG+9mpuQtt+gzGgdj+hgnQcSE34ID?=
 =?us-ascii?Q?DESAJK2OBM/6gDFMIZiDf610QKSvBRrDRF8KtRdBCTpk34xBYO5A7lqCAsvu?=
 =?us-ascii?Q?05ckYgbJZZpuKSHAMUhsjGdJZQw0+0SxruMA5gCzwCdPO900RqgjEhROqJLy?=
 =?us-ascii?Q?IZAm+A8ibZoh6KCrybipa+hoYNQSYq9+Hh93BoZLdt4wnqUzDsHWT/FEjvve?=
 =?us-ascii?Q?Q5vQLVntt9PKllL/pLqp1XMlc+qn2f5V33bUdxXLKgpI1SdIJRRPPlKbzh0i?=
 =?us-ascii?Q?3jej?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 09:27:46.0854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af74a16-04b0-42b3-2713-08d8b3b7a8a6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MgqDm9ExumUKo2V3W0d6HTVKRxfxbWXLUzEvjuTFP9XuoO/Qq8n3SOHb3Vm7EY5gagwpr7JLnFCwg211rER2zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3371
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add the big-endian property for LS1012A, LS1043A and LS1046A
PCIe devicetree nodes.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V3:
 - Rebased against the latest code base

 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 626b709d1fb9..3c1ecb9d843f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -515,6 +515,7 @@
 					<0000 0 0 2 &gic 0 111 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 112 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 113 IRQ_TYPE_LEVEL_HIGH>;
+			big-endian;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index bbae4b353d3f..aca45bf348b4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -841,6 +841,7 @@
 					<0000 0 0 2 &gic 0 111 0x4>,
 					<0000 0 0 3 &gic 0 112 0x4>,
 					<0000 0 0 4 &gic 0 113 0x4>;
+			big-endian;
 			status = "disabled";
 		};
 
@@ -867,6 +868,7 @@
 					<0000 0 0 2 &gic 0 121 0x4>,
 					<0000 0 0 3 &gic 0 122 0x4>,
 					<0000 0 0 4 &gic 0 123 0x4>;
+			big-endian;
 			status = "disabled";
 		};
 
@@ -893,6 +895,7 @@
 					<0000 0 0 2 &gic 0 155 0x4>,
 					<0000 0 0 3 &gic 0 156 0x4>,
 					<0000 0 0 4 &gic 0 157 0x4>;
+			big-endian;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 025e1f587662..facf396ce08a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -745,6 +745,7 @@
 					<0000 0 0 2 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			big-endian;
 			status = "disabled";
 		};
 
@@ -781,6 +782,7 @@
 					<0000 0 0 2 &gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			big-endian;
 			status = "disabled";
 		};
 
@@ -817,6 +819,7 @@
 					<0000 0 0 2 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+			big-endian;
 			status = "disabled";
 		};
 
-- 
2.17.1

