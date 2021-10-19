Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CED43348B
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 13:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbhJSLUi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 07:20:38 -0400
Received: from mail-eopbgr10046.outbound.protection.outlook.com ([40.107.1.46]:39747
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230281AbhJSLUi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 07:20:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MH8Jm4FvGegxhyKN2QRSFpCAMh63MPkv4Ou9WafzxVcdfrPf0PyvP0sxljLTfi8ogJnnhtiQqXvwc8+y88bFdSlvBq6j7VzD6Ep9IsVaE+V4MOss2Pe2KSKGuYnAVWybMXdaiKawjjBfTKsX+SqSizWzQQADEL87Eiyq4Syqnufh+fI7ZiP/q87+mwEqws/JRz+mzBFGBxGf47sV0E3Zfc+rtalCtZ4wGgITD7tzVqEvc1XtxFVJQGXuZsmLvBqI2KsV13fA7sYWkWn1RVwik2gxydIGUnjr+eJvneuPuEynoJv6oECnO5GWXeHWuWX9ltdahcW28ic/+P1gy8VQvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwn8YdnOhsLvMLvbasNvPi5rZFgKRrQqsa8M8cvpvqE=;
 b=SSZqHLEK7HfG32y+EtSYUL0GL0rBM0pl3U1CDHCm4h5tDQ8CC4A/gBuPlhRG8gb5YnlucBAGLaWPSbjBfgttRgGNkSRaSb2BNa/7i0jQr2nA+iBTYxriPopVI5ktMJbJxgfVLzU7TojtNRWPDRALgVUIPF5LKS7kvITyqMq4flqGMZMTVzySuZY4LuALc8ymdC2SsUbDNKQGav69MrRmEENOMECVpXlmJaD74JbVv0JW3fd65P92+7rQ0UmsBJAqjtj0En1sPgxg+6UukJqKyr6yEYkyDLQ/QW3UgG2pK3VwJUf39U8Rv6W8ugCv+GNHMCui73a5V6Ms1BViA++s+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwn8YdnOhsLvMLvbasNvPi5rZFgKRrQqsa8M8cvpvqE=;
 b=YFBMhRKlZ0czMcBdz3KblDv0rk4Wil//rDNYcqdG/RI8nffJMvpPqAVUyZlIKphA/1cVTCOikQQY87Io6apIFJR26WYvAnjUlM/xsk9pFovWicikey5/6+1hnO5M6JAyZZYw+1EJPLsQa0zIKgHZhaWu83wfmKcaSgsAXymmpXI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB2974.eurprd04.prod.outlook.com (2603:10a6:802:a::24)
 by VI1PR0402MB2879.eurprd04.prod.outlook.com (2603:10a6:800:b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 11:18:23 +0000
Received: from VI1PR04MB2974.eurprd04.prod.outlook.com
 ([fe80::793c:ef8d:72fc:df15]) by VI1PR04MB2974.eurprd04.prod.outlook.com
 ([fe80::793c:ef8d:72fc:df15%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 11:18:23 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        robh+dt@kernel.org, leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        kishon@ti.com
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH 1/2] arm64: dts: Add PCIe endpoint mode DT node for ls1012a
Date:   Tue, 19 Oct 2021 19:17:49 +0800
Message-Id: <20211019111750.28631-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:194::9) To VI1PR04MB2974.eurprd04.prod.outlook.com
 (2603:10a6:802:a::24)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.73) by SI2PR02CA0016.apcprd02.prod.outlook.com (2603:1096:4:194::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Tue, 19 Oct 2021 11:18:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aca84796-4dc2-447c-4d57-08d992f22988
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2879:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB287904205D21989B9649ECDE84BD9@VI1PR0402MB2879.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kgHxJcVHjhXPgpWFCRqtIqx50m5ggDSuUZRepYyztm3J4HhzqhgMxGUBX/1ZpooLdFGdi2t74M/SuHWbbJ4yX4mDS/24GwJ8o0rpOtmNH4v1EI3P6qyRinztV0IDfIqgTzXya8DlVX3aq4bEAWnSebYV/K92WRkHuAUmN8PH7b4Z12r5vxuEecvkwIKKkrs8++bEUvMynl3RivDD14OunFbr5Z4KDPpU0CTgAfoTjRFT7EsnvwfQK+mwK9gIFcSlBuZLJBDGMZApHEfIahQfNMT5E+EvRbuD1b+dwaOzKooSAeyBnu+QVO4pIOPp7TI/8KWnLusKE1DnqC5A6FzFYDk6KgG3XbFJnvqWpjZ7cFYdnRSq1G5/Uci+S0my0nQUVEB8V5fEzgg4Y15W2AKTKMbAgViM5XhinyI/Nqq5f2Oni4KDNCrZRsL+PL1AsqClYIRR4p95Fwve89y64712gVVDIrRAHB61VODw4AAEJ5Zq1r59AXYRjy0eH8JlQJIhiRo2f7yn+a1cloo1L7zVuQEpsfhiRSMqvq8WzPrDiuJ2SztjKK24e9JyrQjvcbuz5IVHt4WI962v6GEOK7FGUgoySpoVei5WOSLFLHcG0fMQ1beiPLxy7AFzlA0G2CFHPmExADeD0DkL/hWfSNk5m71jGMrSqcY0PPeXLfvLFu93sjqpgjW/xnRc7hKtnPdSuOQjASndx/ZpvhHiTk9rmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB2974.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(8676002)(52116002)(1076003)(86362001)(2906002)(66476007)(66556008)(316002)(6666004)(6512007)(38100700002)(38350700002)(6486002)(8936002)(66946007)(4326008)(26005)(186003)(36756003)(4744005)(2616005)(6506007)(956004)(508600001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AXGr4O6XEbUhHZXsomeT+KnRcSA/msyLo/YDGQzeK7vrjI8FkUoOMTyLv1m1?=
 =?us-ascii?Q?kNpGtNd68AITHi+g0XisWpg0IV6ulll7ekcBDPZmHI8XstuQ1Bn7dU7kNevX?=
 =?us-ascii?Q?ctDPyeNHxYj9GqRAyEvo4sRZIPykksY1BNZNF564a6luH4Kq/UstJXuL8Ela?=
 =?us-ascii?Q?94uzEGene/bB4KE4rN79gUeAjh+aaTxuFW7mxGytyxsqmcbnjvARqdZRUQXd?=
 =?us-ascii?Q?ylDsibHgB2Kqxo7Ks6OokWm8k8eNyMmObFmgABQ1r5xiIyF9yECKW7+5G4do?=
 =?us-ascii?Q?z/VqbrsLapmN9CZTOoctRsZCnTksgMzNIQGvKk6bZuV8OJtywhQWkhA5vkq6?=
 =?us-ascii?Q?+e5HOX4Cdk5mPevJJKOf+zzLDN/ZurOlBgol+QkEZ9VqSyDvbqlf2Mx/PCSG?=
 =?us-ascii?Q?7DKpDQXCpAHKdMvdduupH1TFKeDWINPagyr17ArbUbID+yhwSUafkuKTePLt?=
 =?us-ascii?Q?9K8FYbEojaMWGPLrpjFOCftc0yRgDZvRrUJ4ih9glXUyKc3wvYZ9fFBM9hQU?=
 =?us-ascii?Q?ijG4uilOBJoiZ+1Gm/g7snZygeQB3eI/6HvXU7vVRkARIE6ZdvmjPhheXp+t?=
 =?us-ascii?Q?IPWnWUfVjS0Ul7UvR0DU1DQCj3GiX/L8a3Iil59FXkq8ZwlELRJwMVVahczP?=
 =?us-ascii?Q?DqcJLWdc7GjpD3fe5mDKleMHPNdHtZiFyUUV9xfkMfUKDnd2ynrwJ1TeNOWf?=
 =?us-ascii?Q?AbN2RjKM/bp1EnzP0XiHr9ID0uwB/HUXKyC53ms7mY1bIDfOmATvCm2wp3jm?=
 =?us-ascii?Q?ugtIihHVjpeR7xoMNuNFDsXHYFwr6Uom7thDaIrqpRGdrdDQxN/WpbMzPTcu?=
 =?us-ascii?Q?uWPWWLNN3qpe4DaNLggRVn8ha3s4aBcKQHy1P475Y9d9WHEo1BXAU62hl7Qs?=
 =?us-ascii?Q?fjugUHvLocvYKPHLZjMWeSElUef46z6GlQc+btWsshpsBXnbOhG23pHoM/Lg?=
 =?us-ascii?Q?E3oKbTU4Yl4Lz8QjctLUfojg8qOBFCd02Q58ixD+ttHYApDtBJRreYTkp/e7?=
 =?us-ascii?Q?yoLpMJFD7KPgK+3dGWMwmY2kEmA3Jxvn2ElX0mCcOyb8fN0a2HOeu0YRN8x4?=
 =?us-ascii?Q?7Q6glbKRB8dBIo8auPhDHBGmAr2/I4Rlmezxp3OzewQvno4Y83Bh36rhiFhQ?=
 =?us-ascii?Q?Gp3jZFiRQY0MwhWbausOQW23zQjlx5qUO3yFAQzr9FJyQJ80wYj5Yp6KdvgI?=
 =?us-ascii?Q?62YpKR8JK2kwJ3UVNXnf/e63Wpy6a7JTZ+5k8In8lfxtNW/GK0QNvMMGB6LI?=
 =?us-ascii?Q?vfaPFAI8kg+9ari7sUNuGvp28bEhhuItrvS+QVXwnkBvWW2SJT06B6dm6y2/?=
 =?us-ascii?Q?936Y0d9vU/VWOU26tPdR8FNW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aca84796-4dc2-447c-4d57-08d992f22988
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB2974.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 11:18:23.0492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FqEfiXwkdns0smaQWgqzUVw5LFGBgHVPM7KXFAZx/9SWv+ZqQ+YKI013KKJrkYBmFT0I17ZFbcbVkzqJLpsvJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2879
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add PCIe endpoint mode DT node for ls1012a and reuse the
compatible string of ls1046a.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 50a72cda4727..82bf2fe6f8bd 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -545,6 +545,16 @@
 			status = "disabled";
 		};
 
+		pcie_ep1: pcie-ep@3400000 {
+			compatible = "fsl,ls1046a-pcie-ep","fsl,ls-pcie-ep";
+			reg = <0x00 0x03400000 0x0 0x00100000>,
+			      <0x40 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			num-ib-windows = <2>;
+			num-ob-windows = <2>;
+			status = "disabled";
+		};
+
 		rcpm: power-controller@1ee2140 {
 			compatible = "fsl,ls1012a-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1ee2140 0x0 0x4>;
-- 
2.17.1

