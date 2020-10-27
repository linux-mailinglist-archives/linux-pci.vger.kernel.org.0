Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7679329A5AE
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 08:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgJ0HnW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 03:43:22 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:45137
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2507972AbgJ0HnV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Oct 2020 03:43:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T022JTdVZC/09QfXPgX3pFjVgvd3T9JUKtzLWFsMth329TwdLp6Qyd8IpWJo4li0q2xWq7WBIAKtlBDOLjaEcSP8lg0PBele0xovqptlHeXmHQet69oW3eBOyz3SMKQkWuq60M6Q7aDHqETAK+C8+gzFj/Y5qDD3c8TKvZkkLyunrCYg4nxTMO9vvbCgC0kVd+PPoFEOa3rHUGrjXjXQyQHDl9OHx6OSjYKFXn3Q7T5kSxuMiNPJiFQuWPWwXeQHUiA4VA0W0qPGsuIH5SjFEzDM5xTEYErRl/p7ylKTBBoYK2qcvfTwLgAQCAswY5hJ9WeCoKRw2IZZjVUUdhQT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzF1q97Q6m4XmQWrzKHzORKpyrNgqKqqz4LG63VzAEs=;
 b=dEnYo7HWypmiZi9Oj01Hs69VGHRskqvn21sKXClSTvAVhDJbceDdiCPVn1tXnb05BeOrhOuX6im3K1f2rb5VD2eKuckpvoOb7G6cf9AZvAnNMwNqE6UYnirqxwqMv1uLvoc1IJnAj2rqvbn2kq43e6kpbD3lIfftmxjkYf3NabP8OPlqcPvl/zh9ARU3xS+QMUMjagDpYGkHZs30gb0XHamzHq0E+XmVwFsi9OOpPTQtR/NF66ijW52WxrYOpuqmdEwXvjpkfvsYWixeBporENrO7qLU+2lESspUo27HUWWOgXETD13hVY8cd5W/95QNIFlZmnb5+WCcqlNcSvIAhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzF1q97Q6m4XmQWrzKHzORKpyrNgqKqqz4LG63VzAEs=;
 b=ZJ3XkFpBGz16IaHtF5EBpRdzy9zGgAlVfMFRQqpICuBgzWwxqoiHgX6MdoSHVz6pUYvi8mSHv8IXyDToIPdyWvMPuX7oc9SbxgprpREFqtMkqPLF7e+HEregiovlzkXVHpadczn1MsBcv3o0SAkdvnLYSIb52GoHGlxHhAmCtvU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Tue, 27 Oct
 2020 07:42:17 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::f882:7106:de07:1e1e]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::f882:7106:de07:1e1e%4]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 07:42:17 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv2 4/7] arm64: dts: layerscape: Add big-endian property for PCIe nodes
Date:   Tue, 27 Oct 2020 15:29:58 +0800
Message-Id: <20201027073001.41808-5-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027073001.41808-1-Zhiqiang.Hou@nxp.com>
References: <20201027073001.41808-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: SGAP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::14)
 To HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by SGAP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 07:39:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 70162701-d6c0-4fe2-13fc-08d87a4b7cc4
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3371:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0402MB33717E05F7AE1013E9375BCC84160@HE1PR0402MB3371.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3NWbvToTS6rdgeFmOuwXBWExdAenb//jhFm8L/Z9oBh8UeprgXuQDtdEogPbTN7oDm90MGVD6Mh6nTZv2CqAR1E17QJgan9OynTo3nPFYIf+ExvhRo/lfjGmwDH0uTvLbgdDJN678U8kU85d+2jeDadlw8BVf3FRZP6q31ZldXodSP4uW9trR3+xsFn0NYPOj+j6vRtNKSr8I29W4/DoRGqN3G5rHTHGTOnYYvvHJ80r3o5i2fGU61eZ4aky1raPYDz8JnAKnv0wI1w00KsN19q6ZwyR5IKaIauMn6NQPG6klUxr7pFT07+RUoyYAQ1w2BUwVOCINO76hVkbDYwNG8ghKy+YdZMy40RGF/9l+Ai3biBhRZDeUZajvxZw4YUrFJFJSOQms67jG2C8mAu8oQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(1076003)(8676002)(5660300002)(86362001)(2906002)(186003)(8936002)(6666004)(4326008)(16526019)(6506007)(26005)(316002)(52116002)(2616005)(36756003)(956004)(69590400008)(6486002)(6512007)(478600001)(83380400001)(66556008)(66476007)(66946007)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: sBpgyDbWs4TtWPygTFY6S7hB/MGjihfWw2e0EoITcctY5dNUPp4d3D//H9H6yNKtN84vTDAlFqilv/FQjNc9SosfL6mKeZJkEyaC8TBz/wUyiK1lN6VGd9eYEnFg1ML8t2/ODGdOaGIoUkjAi58XboTilCGxwUHfRueUDUZf3ER5HZ0jdyocj5hXdwRFfMpU8nGsWAwMBzVDhYtraEN126KJZgFdms0GZqzvHbgKFFn+VtYLPQM7lc1sA4r2/kEH7KFx4at0JrxPHsliKABPEEMBnQamiKgaytkWlJGr9LAlLA3ZfYXGCgodkok5Xg15qCC0eGKhMzZcbGnThrJkTbOVBWS29jOSOWXxQ3uhRFZV83MKV2ADXJuG8i0ijFLfQ1IJWFObMepofDlRZWkdqs9XFOp28QIlaNPe999qUGjaifdclRlFFOogVI6FdhmWayx3MH35cL9La5blSnfu9XZIk9AQtskE4kRVT93T9m/25lER2mN8KaFow+9Fbu2LvzPSh2VcckRms3eZ7oGfAggmATvMQmuWsBH4BNZuz4pUcxoadppZdJ1QofD5PiUZ5ZRXpk4MFQCnp2pjrmoKnHiRAC3tODhMWG2l6HzVYKkdDEYwbCoLzlAo+BBj2XcHjPOxSjgNXX1mLkOlqJU5YQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70162701-d6c0-4fe2-13fc-08d87a4b7cc4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 07:39:51.1093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAJHtBXuVo9AMks46rGmzolLobeRY4i2AXwifK4Chu6paJ70ZA+xpUan4O0Z9M4tjEMRJlnXSppvbZiGu7/Ckg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3371
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add the big-endian property for LS1012A, LS1043A and LS1046A
PCIe devicetree nodes.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - No change.

 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 6a2c09199047..0f63aea30477 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -512,6 +512,7 @@
 					<0000 0 0 2 &gic 0 111 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 112 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 113 IRQ_TYPE_LEVEL_HIGH>;
+			big-endian;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 0464b8aa4bc4..d33a64ae8b0f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -837,6 +837,7 @@
 					<0000 0 0 2 &gic 0 111 0x4>,
 					<0000 0 0 3 &gic 0 112 0x4>,
 					<0000 0 0 4 &gic 0 113 0x4>;
+			big-endian;
 			status = "disabled";
 		};
 
@@ -863,6 +864,7 @@
 					<0000 0 0 2 &gic 0 121 0x4>,
 					<0000 0 0 3 &gic 0 122 0x4>,
 					<0000 0 0 4 &gic 0 123 0x4>;
+			big-endian;
 			status = "disabled";
 		};
 
@@ -889,6 +891,7 @@
 					<0000 0 0 2 &gic 0 155 0x4>,
 					<0000 0 0 3 &gic 0 156 0x4>,
 					<0000 0 0 4 &gic 0 157 0x4>;
+			big-endian;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 1fa39bacff4b..b01fb93f7d19 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -741,6 +741,7 @@
 					<0000 0 0 2 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			big-endian;
 			status = "disabled";
 		};
 
@@ -777,6 +778,7 @@
 					<0000 0 0 2 &gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			big-endian;
 			status = "disabled";
 		};
 
@@ -813,6 +815,7 @@
 					<0000 0 0 2 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+			big-endian;
 			status = "disabled";
 		};
 
-- 
2.17.1

