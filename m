Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B457C3561AC
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 05:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348223AbhDGDEE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 23:04:04 -0400
Received: from mail-db8eur05on2041.outbound.protection.outlook.com ([40.107.20.41]:63409
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348216AbhDGDEC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 23:04:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EueMg1loAjO1SAsOxFNR1ReLuUqjbNMe5JmvX7+uYZMcyMZPPii1eXO8UQiFlADenogDt6Uk9oskvriTXznIwUFQ+BlkUwes+y/t6NsJqK4TYIcNjBO2b1ePQcR6DU8FH/4MyJVsnvHWYhrl9NHyAWgbqo6spQcIAYr1GLyO0GruQjtYhLy0dzD0P2pM6UFMTrQ6vpJpZvM8P4b8oA68qP8alLDaES15x348u5cIUkwKdZ0LKP80vvbWEbfFSpvXE473bC8y5W1A4nKYQblpD3OzMnqfkUcfras07igjSvY+mrbh94yfPS3x2EHfdmxagshtxLvW3XyLQ8B2kOw5KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ncn5u62IfCKvDWDOq5oYa00zSenRGTKkEgmSOnxa7gM=;
 b=QP4Q9ANzrxCdMSev2K17sDlPefgYsaLcvatJFgLLmXrVQrnPEEqIZAhXRVFd/SW8m4hEYfbEhyKxaoXVl91+HfT7Z8JGSSNTzRcu0MbgO7W/8egAUDB8GRBHgBlZrrlbY6vjTQFaBOCH21YcFWuphO+UaSmD344Jogu7oV+LswtIdJwEBb9OIxPeHnU+CF23dGE5EbsTcsvgiXSBRnu8PZJNuPRmnKzkfGzcRS+GNoD8Icf+AC6YWriW/y3vYa9IkRzDYOgSEOhd5R+zZGGeUd/t8OL3Q0NkNBThpXIj92Y0lfE1K/P3iPCDVwieb21DE5envE6G0Y6LB3HlVRACZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ncn5u62IfCKvDWDOq5oYa00zSenRGTKkEgmSOnxa7gM=;
 b=IbE9ohOg81OKy4Dx64BTuzg5bfJISbwk4Bb8OSo0h+jNccgFpnFM9cc6rVUAs2LzbVCwWpNhlsNX6NrqhQW+OaEF4PtuGuVAFpKvroq503DTZfiLyugGCg8BAXsdpd4ix9V++kRwVC2+GJAE6LAajRGCbGdb+q0i6EbPw3z1ckU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR04MB3276.eurprd04.prod.outlook.com (2603:10a6:7:22::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Wed, 7 Apr
 2021 03:03:51 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc%3]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 03:03:50 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv5 3/6] arm64: dts: layerscape: Add big-endian property for PCIe nodes
Date:   Wed,  7 Apr 2021 11:09:45 +0800
Message-Id: <20210407030948.3845-4-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210407030948.3845-1-Zhiqiang.Hou@nxp.com>
References: <20210407030948.3845-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: MA1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::26) To HE1PR0402MB3371.eurprd04.prod.outlook.com
 (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by MA1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 03:03:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03175b5f-4b17-4ccf-5bf0-08d8f971c409
X-MS-TrafficTypeDiagnostic: HE1PR04MB3276:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR04MB327677F403B4AC028994193E84759@HE1PR04MB3276.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yi+JCOYLpYPJjtoyqwp33JqPy3pZX0cBiXZcGDQtIBbMkq82OLcUT5zVz3ryrgMB8+/LS6mQpjC8S9vEFkTkQOMYwpMXSZyKylNNpiwW16YhM3w60cJGcROu4dvB5mWSsJ4b2PYOStgAxHp/eGR8nqyD50P4XWAdSyPj0ibZ98M/HqBrChgtuc6AVir1Bjedv2/mhsP4X+9NECjks0UwB+2qwbU7DK3EsyYFJnVpKtJp+iFy3q0cb7/vAvfglsBPxxzfjxDJX5d065YzUqGeW/KT6r1O20AXmZzcvPyxEpVOXkYs9gWIBqRRs3y5TYqPO3gt0Je+8K2FfcqO/bZTNpvIi9C2sg3LrMHN+/rFIw3CWv/cfjhZleyqnWAZusgnwfObocS2yPe0OkxjHjKz4aJmNw98Xvjs/IxS8D9R+Mn0mzLVyii0YDybQ+Qif1TdzZBNtjS3TVakDphZ3L5yhrRKW744fEOmg1gg/owhxLxMS36BwdcLIFtDb4Teckg+nFDr+/69bFIPhhgrtprDBEYvTVnZl8eNqZYxJITwVT1KWRZfu2zZWEtwdPUYELQTSu7PprxoeY38+Q/bHl7Qfyn4Xfn71SiMQf5Gl9Yns3OViGuBtO5PQcNM8Vn7O7/+tARPrko7hjOOejk3wbGwYvyHVCF8+k7kImkqoG2j1BqLZgcTyJg7mB9fQPQp2fCd2WcHz8zX2Uo4wrGKOR5R8DjqaZaBj/mXnPvddvcEt5M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(4326008)(6506007)(36756003)(38350700001)(26005)(2906002)(6486002)(1076003)(66476007)(16526019)(186003)(66556008)(956004)(86362001)(66946007)(38100700001)(69590400012)(316002)(6512007)(83380400001)(478600001)(8936002)(2616005)(8676002)(5660300002)(52116002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?eAoBPs/It/9NaWx2MJ/FKg0J8imCBjErQ5G31x2lFP5CWoDsFrE+BG7umPsA?=
 =?us-ascii?Q?qABX/QH9fsa87+5zI2Rqq4yu1AynxtajptIWaQ8yL8FCyDrdJp572rg6joBY?=
 =?us-ascii?Q?hhZLU8bd7JHx+b/FV+vDQZVQ32WMPBD2BeT8qwEZENdWLgcUQDfKpYsR3FHH?=
 =?us-ascii?Q?tYVwpHOMvG8nguGuVPtvuhSxcNjrhccszWgCojatvcfnvtxbMKUt/eIAN5G0?=
 =?us-ascii?Q?tXWkfKUQ7qxZRA70seOGbfoimzRUNbvmkdDRouT6MrSpb7U8nUr3ATHqcR8o?=
 =?us-ascii?Q?mQ9lTCFRi1XAN3FM6BRLiaeAHz4Vl8TfkYeTS3Hoj2VNeB0uI1GWfXFgE5QF?=
 =?us-ascii?Q?m7RvLKHf6n0xuGWONqPzwaapj+lut4zASEf0TPV0d/TvY3AyDdtcLiF/R9xP?=
 =?us-ascii?Q?lk75SQ0jz+5OD7KyAVpzQDcivdgEmww5OQbBR/X1TTD83CsQmr0b1cmqhUnP?=
 =?us-ascii?Q?Ucd0NXMNaxcZlyfN7QWUBfstYO8FilZ+WvAGGlFmAoKyKVOJ6+upiJgqi/c5?=
 =?us-ascii?Q?9sz9iZUovipQLJpNLxypkr403loJfu4E42xdmalV3ilhkNv3dTTPxUb4V/68?=
 =?us-ascii?Q?7krHxvlpEM6/eSL9+8/YwSX6MjtSzdSpNjPc7teiEHhUGJ+/ZGAFFSwCwnik?=
 =?us-ascii?Q?ukXKK1PM9HYKiCaDnLmpXZ3c+8+55LGfWyCoP6UfVbGXTiPKIEvTcgOCgRzt?=
 =?us-ascii?Q?MqWL6fudaDBU9Z0QOGxrw4fCVL4yHbtbSw/KnJEXdwIkUTVedzao3NhLKA/L?=
 =?us-ascii?Q?T9isVROmj25zSX8r2zXNTB8RpJpbQLEJ7x+0TFO/0jpolwp3sWeRNol389Uk?=
 =?us-ascii?Q?UTJZWXOV2Cpf2LaiYlG7+i92Bg9/3SvI41szKcV18Sm8qgccGHZQRXCzb3Yq?=
 =?us-ascii?Q?fHibRC2kpTVoCG2zei9Mt7Y29nQlWsZWA/Zjo8TJJjF+iOtSnef/AcmfVgp3?=
 =?us-ascii?Q?tYEmyRXa6BVpsDzGPJ87Zz07OpN+qselJXZyK1xrerrnQI/uqeBnIGxCYnad?=
 =?us-ascii?Q?yl/PHqPEHk9yEBqlcE5hSU73gdSRUM8lGtJQagte4Euxamzei3kbSNjDlwXb?=
 =?us-ascii?Q?/m8MzrDT9as3FMQFDPDI9DA0bKmnjx4sJf7+9lo4ys5oUaFt6jetB1t0H+Mj?=
 =?us-ascii?Q?RCxec0TnyIE3X620M9c6cab0MOmnobE8UkExAV33WL4THsw9DljcPSPNp6PA?=
 =?us-ascii?Q?2RCtE0vqSqUeuX3V9N2DJe3rWnbPLYc65e63hI2f2nIWS7y5ik9j4fF3AUbE?=
 =?us-ascii?Q?SsxDb/z0jA1kGdZdOLZdK5yNN9Ji5cN+h5QptmhZJG1WE+AmErc1MIVXx07M?=
 =?us-ascii?Q?I1biY7kNfsMtbGLO7DQ0qTN3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03175b5f-4b17-4ccf-5bf0-08d8f971c409
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 03:03:50.8202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IXb9etByFOfG63ZVSLQOFef0JUEdqZB1v/UhUAIU4FO17KX/FWvhTvmp9a16OkfiI0FA5xV43bDbni6bDKNUdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3276
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add the big-endian property for LS1012A, LS1043A and LS1046A
PCIe devicetree nodes.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V5:
 - No change

 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 9058cfa4980f..ac23e938fd1d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -542,6 +542,7 @@
 					<0000 0 0 2 &gic 0 111 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 112 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 113 IRQ_TYPE_LEVEL_HIGH>;
+			big-endian;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 28c51e521cb2..46826752a691 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -890,6 +890,7 @@
 					<0000 0 0 2 &gic 0 111 0x4>,
 					<0000 0 0 3 &gic 0 112 0x4>,
 					<0000 0 0 4 &gic 0 113 0x4>;
+			big-endian;
 			status = "disabled";
 		};
 
@@ -916,6 +917,7 @@
 					<0000 0 0 2 &gic 0 121 0x4>,
 					<0000 0 0 3 &gic 0 122 0x4>,
 					<0000 0 0 4 &gic 0 123 0x4>;
+			big-endian;
 			status = "disabled";
 		};
 
@@ -942,6 +944,7 @@
 					<0000 0 0 2 &gic 0 155 0x4>,
 					<0000 0 0 3 &gic 0 156 0x4>,
 					<0000 0 0 4 &gic 0 157 0x4>;
+			big-endian;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 39458305e333..f21ee7825d40 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -794,6 +794,7 @@
 					<0000 0 0 2 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			big-endian;
 			status = "disabled";
 		};
 
@@ -830,6 +831,7 @@
 					<0000 0 0 2 &gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			big-endian;
 			status = "disabled";
 		};
 
@@ -866,6 +868,7 @@
 					<0000 0 0 2 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+			big-endian;
 			status = "disabled";
 		};
 
-- 
2.17.1

