Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82C4354F3C
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 10:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244686AbhDFI6w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 04:58:52 -0400
Received: from mail-eopbgr80089.outbound.protection.outlook.com ([40.107.8.89]:55395
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244677AbhDFI6v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 04:58:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkXixfK9UDbWisMvjNciJWfM1Fw28/WjR7sIt7ZZOZYhCM8J0oDcuTKlB9BbmLSt+8QlYWoy1EQlcGlc5zFIOTVwsovyQdnQMkKH3gxX1RvIo1F6MkWVw1FCsHxhOT3jDPqHJO0oUXqCybpJLEA2H9Zpg9d3HinNz2ogCz5FoLcrmi6p/HYpaSmtAKpnY7A0dHDFOrYbid/L7KqE9UrMnAA9FZESzoFT6yeOp+pQ6/RrZELzSlhWUPEMF3zlIZt8cDM19KR4HFXNvYA/V23spLwz+jk9lmOIhzG8ywYFNxRMnHKQLaYVY5De69iYpAYqQG3IaSLXuCmaieiXzZzGlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaIRUw4cwGD8GYsaqwP0mUD4Pb/VrPrxA3EQA6XX5Xw=;
 b=MxKhxQVD1diK9hc7TKMAzvLNPSPNyPOKzbZufjUqqJiQNeqeceQAqM0TDhwSmC+JCS59DGdlj/TCT/iRAQAVpMLuWZr5VTW/rw5Lpbj4vu8sZWBDzBdOlinh6RcbUyC0qsJBwb3lucRCobqIWh/iqLd6bBnmdEn3WPpeo59g7ijLP9IdzWSmnTgId1cUij4uCmb+uRCylKI//a/Nww0toE6hv5LjgoqA+YRykQa4wYMQLSSVy9otURQveQS7w8UbKKKXL1ih6LTmKFLMMKZGPxWmXrMTtsg3MuYfB88Uy1ZyIn0Kv8Dofv08Do4yLD+JzaQ+1Vt1L22OXRWRT/1FMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaIRUw4cwGD8GYsaqwP0mUD4Pb/VrPrxA3EQA6XX5Xw=;
 b=lACJl5sim14PVO6WBXDL0CE4Z8EOljf/cqOZ00fDoG8GHK7/x9i9ATxNU1EC+4W5MLXbo59qnSGZ6c4iu6Yk6+O9oMwDCbB86+x64BG0oFx0aQYUOiAS3KT6lflkUkbF0z9cB35dkLNlVNrP9NIM45hrSfvrxcklZkeynrtlTtY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR04MB3275.eurprd04.prod.outlook.com (2603:10a6:7:1a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 08:58:41 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc%3]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 08:58:41 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv4 3/6] arm64: dts: layerscape: Add big-endian property for PCIe nodes
Date:   Tue,  6 Apr 2021 17:04:46 +0800
Message-Id: <20210406090449.36352-4-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210406090449.36352-1-Zhiqiang.Hou@nxp.com>
References: <20210406090449.36352-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: HK2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:202:2e::13) To HE1PR0402MB3371.eurprd04.prod.outlook.com
 (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by HK2PR06CA0001.apcprd06.prod.outlook.com (2603:1096:202:2e::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Tue, 6 Apr 2021 08:58:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56c066e1-3244-4eb1-9347-08d8f8da2c3d
X-MS-TrafficTypeDiagnostic: HE1PR04MB3275:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR04MB32756F81B0947B10D814DD8784769@HE1PR04MB3275.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yjoncmgbtkn09z+jpEsrXdP/ouWG0eijo1JzyPVCWAK6+bi2F7fZxTq6/wfniBVO9NcTkIFZ1j9ofM1H5s8DB4DnzJ7zkoMY/tBdTqjTm5Z6URWsG9cmrF1VkYni4T5uBtaT8gT95ZzbYZpWuw4Sur9sQV6YQKs484QmL2+pmlAk4J+NvQtIvJ4JMULQ+aN5jlFn1n7++0iSUNQSspbZzbPnqmlyqYCrsrWg33wU8VpXruAJvGxYhtovdcydeDDWGkNTdT6ZKqMRKG+DmxkExuKr06FRARESQPtMVndwi2E9389571CFu1u5iW2iLVQyfSdySNiXIDLGvIfaCnjvYNTHk+fjXLLQrK5mQukUA4CcAt6ICDVEOVH6Z/j7OxlWRi/41GqSmZo3Dhly4vWcHUfl82JENVJ5kAgMKGsq7ivELI4pZW0X1Qgc+XF8YitzGgKGsUgtMnG8dA/kUAe5XUuT6zkIpM4OlpOVbEKqyWiziwyqDP1zyi1DREwWE9ieyjEUrZpATfnXdorBXRSgQ+nC0xh76fQH2QA5dZCk3o6/QKUawwQyNUcgTxM7PPGSUd9MTFeCf1jMfLC8+QERlNobNz5/nH9SwIEbbUVZbx6NKMgTC/e/yYFhug2/ZkQ4655OVkgtmTnbF5JWadK94SwmJBcXdLd0/dDXs8TlsjUHINQgMozYO19rdfOtUxj+tmRrjbO9x0QVIF9Y32flgLYXvE2whuyQPJQlBJP1OJnqKZZUCL8EQqQYFF5Y8OyB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(6506007)(38100700001)(8936002)(316002)(921005)(2906002)(66476007)(478600001)(36756003)(6512007)(5660300002)(6486002)(1076003)(8676002)(52116002)(69590400012)(4326008)(26005)(6666004)(186003)(66556008)(83380400001)(66946007)(86362001)(2616005)(16526019)(956004)(38350700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9iXMfOWCm4Az2OVeFEmxhGyRtEJjZoWp7bimoaaR/RJr/P3Bho1krZb5yr2f?=
 =?us-ascii?Q?sUq8+5HIENLqCNnCQI+++74MBCB+NabgtgkPdW1vw63E/VPR+PSO9l1mBtZP?=
 =?us-ascii?Q?H4i3yRO7iBdklUAHbhIjj4Ks2YDZEx5IyOQy+wIIzjRmcJ6I3EXMm4DcoIrC?=
 =?us-ascii?Q?dNdBwlZuNnagvg50OkvH15IaNVNmSJ3mVdwEX2Dc87Z1juouo/EdsV3PTnS9?=
 =?us-ascii?Q?NQEMGVZ9Mvet9JeUltb3NSo0vKc/0kZb3rAiTuD0piSh7zu9lM3rikt8hws1?=
 =?us-ascii?Q?5QMH5huwg7EMiX1o50IqX2oOpcq4QBniX83Fxx72qU9wJkN/H0Vmpl2DAXWH?=
 =?us-ascii?Q?Wzk/XVPKI1Vj3SMW38t3kZlWRMTQjNgfFYIrLE0afAaoMUvWK54XXIKjaeh1?=
 =?us-ascii?Q?3QtntptH5hRtjQAb5kP9X2PpTdySdpwIPJlkTJCK0HoXEo+Ol+sTeRj5gQWF?=
 =?us-ascii?Q?DaUC9T4s1uw+P9euSa5jWXgv1n/3nWQO8J+AxVfpw0WP7p2JrTmJNu6Dynod?=
 =?us-ascii?Q?JNQXmWPa/mmUj8x4TojncpwqPCUFSU+zDQuRUL9p9DSJKfKp2Qk/erRBKUo0?=
 =?us-ascii?Q?lSVut9xsPw6anoKyCez8ZpOC1sRdxZVdU5tjvn51ESlN+eY4HE7umgvNWHva?=
 =?us-ascii?Q?EPAuEtrgVUhc8rlKGFWQZKN1sh5ACad/LOscbHCJS/iLy5680yubM3vG+QdU?=
 =?us-ascii?Q?Dq3bceYRquBhgbBPTlCLdqnxGZDlgba6WdfOSKVFXLOZoOqrHUMwbUvUP/8a?=
 =?us-ascii?Q?oi4XZmX0WQ4PMerq6ijS16Uzl4gGIjxs5z2FgNvOamxom3J6xOJQSsybdm9X?=
 =?us-ascii?Q?PEgSw8sk2WqVl8GvLL6mPF73Wnant8b4LFik21T9oZVfxjRZgVgdlOUm8T8o?=
 =?us-ascii?Q?bg4iAzoFv8g6mAZJD2aS9XjyGwHwbzT2JtRDqJQ7mH8nj/jspZ2cOQga8CKA?=
 =?us-ascii?Q?XEdloLMX9qNmaelAVmQIM9Z4jrUvCUfnCJkuDRmNVfvyeFpwfeX2SGwlwplQ?=
 =?us-ascii?Q?r46ecgMEJDHBCq8VvdT9Yk6F5vHHbh+GeRKb7Rq4BWjWvjc4hpQa2U2ATY7F?=
 =?us-ascii?Q?xR9e9rJ4ZadLwfMHPChmYpCRyxC0MyA43XFGNKuJwcZXa1jF0DVvgTB4nAo9?=
 =?us-ascii?Q?TUtlst1S6KnC0CFqJ0uKqQkhHEYkZpqbBFJbzr0Mtlz8G/fcS0wQNd8bAHaI?=
 =?us-ascii?Q?tXI3cl+dk5PZGtykzZaU0jblzkKIunsJyGoEZN/cas5dpKDwivLXt2/T0wS1?=
 =?us-ascii?Q?Sz/8md9EPW/S9cWYPM8Q48BQd3Yts5Don+SALVqcstJElWdK2q89oXYIzIBM?=
 =?us-ascii?Q?6NlC8w2PExqWkj2/ur4ea2s5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c066e1-3244-4eb1-9347-08d8f8da2c3d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 08:58:40.9092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvXf61PDDDxhN06nnffjruR38C5RVTIqaa8PO/vHFjPnannlyeMzbilitriKC2vWh9nGHaak/Tqbtkl8NQbf4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3275
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add the big-endian property for LS1012A, LS1043A and LS1046A
PCIe devicetree nodes.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V4:
 - Rebased against the latest code base

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

