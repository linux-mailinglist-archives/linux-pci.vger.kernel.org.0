Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6D33561B1
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 05:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348219AbhDGDER (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 23:04:17 -0400
Received: from mail-db8eur05on2070.outbound.protection.outlook.com ([40.107.20.70]:24289
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348248AbhDGDEN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 23:04:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0v6J7q675GEhd3PyapQEaCTJ7lUg8dl3PcJKZjAQTZDH9Gc58ZbH5cqfaftgBIeNIzloD7AhSVLk2lsTJuZGGTpp7Sh7T5OTSQMuDKVDQGneneEMOuTH4tf+tvfu61vWKx3ioej/p7U3VP6kZB3jNbyLFPYkHsdTNjAxAnogLITQZOoqHRtAOLQ68HhjKskm+akRb0YFLsRyAZQ2K6qBTzFVNyoMlqmSMwcgqWHsfT3tj3bwEU2F86DcV/WC3xkzXzWZB6Z0LYmfDlJ+cCYSpT0U3RFNV5vIBIoATuMqn0+k/6S1vifvGhgWmZI/wtyYyso5lrE/KSwy7vHcvT4hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7KWig5tKl4+q2AtgwOkF376aZCYnwqiW+tQpr6nafE=;
 b=bMUAyhWs9C9uWPIr85/HdYF/SGnp+w6IK4LIhQB+e0JN8hdLxT0spw0xIlRov1PngZgbfJosdVBtdbynPkgC15d+2gUJ453C4xKtp0yOs6CR2eK0YdypGPmsnzggv93QuBoZ+kwaInlltnmhA/i7ia2J23zTPlaWXK3eUZc9S2PzC8vzLBKcM6r38sd/ortxtqOWfVcvT7lsgmbna/4EfXHB8wxE0i8N0WjRZweyrHiOU7om+yaRPXq9HdvEj0TOoLMNyQGPs+wpCshk34/Rmq9pKdlGoMBx110MlZ4VpCanPs4CI9OqBnALI27BWZwcTO10Nji3eo4zjYdMhuOWDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7KWig5tKl4+q2AtgwOkF376aZCYnwqiW+tQpr6nafE=;
 b=QZ68pqpwUR+VAKwa1/vSFA7zzYFAmJ5M1RK2jQzMqplKzR8xLja8q0lgjZq64Qp35qKRZG0NrpWh/ovpXgxCwyi4IEF5HPaqH8mjN/6Z27YNchS3SCWaNawE+jY+cDAby+t9sTDopiTZ3Q9SYtebwPH9BEg4AdVe+ei1fo66N0c=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR04MB3276.eurprd04.prod.outlook.com (2603:10a6:7:22::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Wed, 7 Apr
 2021 03:04:03 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc%3]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 03:04:03 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv5 5/6] arm64: dts: ls1043a: Add SCFG phandle for PCIe nodes
Date:   Wed,  7 Apr 2021 11:09:47 +0800
Message-Id: <20210407030948.3845-6-Zhiqiang.Hou@nxp.com>
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
Received: from localhost.localdomain (119.31.174.73) by MA1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 03:03:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5e6b0f1-493f-4ede-e4d7-08d8f971cc3d
X-MS-TrafficTypeDiagnostic: HE1PR04MB3276:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR04MB3276E55A993914D67714A15584759@HE1PR04MB3276.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2EVDZhb94M4WooI8xU0nCE0QkeOqFDVErcTvhOjyjDm7fvKTTzyjhftPV1n9gRx524fvCFd6PI7Mz0AGjsoR3bWLyQTVjuj2NmTNisHlIpLCJgP60MsbG0CuUzwCNdTvsDfKwTiLv0mQ9GOHdV9rfBb26mH0adLENwCgMeAVD6xs8N0XgrvFHsfiLOVLY4cEo44/ngEplxGYK3Yqd2+Q1OLF3QLSiVfRfxBOXZGLUxRKD2xhK9wJVrq0ojAAbYF6mItzCgu6WSX/kBue/NP7Cf6Re4x/dK7RwceJpJFx9UupOjYMUztzbkhJG1lPERVUGCnjhSkzmLcmoaUl61IcYUkEMpenFaJ+tlH4ccOXJMYFBybMQPwTmFA0WCEZ/gKai9/r9oua8jXo3hS0hWji+0jjar4RA25fhz3mmMn/V3OYAomkbxakDEveyV2Hrew1Yxfx/UwXVofMB44Z2vtr0gJtblaQ0AcFYocx5AKFJ6BvKYiGZxl7uDPE2vUqSCPoXBlyWjHocDvA2HGJ50nvZEanO/xxs/ruULNWAUA5IKWl4ijJQ+VRxz5I0+EG2lCE0Acljewuf5I7XWJZqrdOYCdLbN6+stBqHCAN4MHAEbwCnUn781QNVAHO3ANkiQkiiIPSkz/UUZnw8FkmMGfe4718BTawBO0u3xmFio8OFuksp9tWKViUu+WvUMo01irkM6gojzix3eW7v/Vap+m7f+U4mGCScCX3z9Cl+UsAuvo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(4326008)(6506007)(36756003)(38350700001)(26005)(2906002)(6666004)(6486002)(1076003)(66476007)(16526019)(186003)(66556008)(956004)(86362001)(66946007)(38100700001)(69590400012)(316002)(6512007)(83380400001)(478600001)(8936002)(2616005)(8676002)(5660300002)(52116002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?z0j7Zjp0/hta/VnzuZ+AvP6ipOQAacOtZ13cZFlUhhCtZSJhrihsZzvD4eLh?=
 =?us-ascii?Q?htUL23VsIpCd5IoUhQGveJSh1al08Fmn3+ugG9bKlLDJlvP3ITk1yQ/TZnGZ?=
 =?us-ascii?Q?ce5wdRXskVl6uv3ZU7qV+/VQyBtRpuvbTc02GkL1DImLS0fcgwkMFIzrRzsG?=
 =?us-ascii?Q?ctmepzWqoA47tt5f5zXucgyQmXnISGgW36ftCIeQL8FiEooKRt/sSf5w4Eod?=
 =?us-ascii?Q?/QsZ3QGd3SFplouiWI0z22TaPRNR1la364akkmc23PE8K7a/VoCEe7J71rFJ?=
 =?us-ascii?Q?TofF5Pbz0Jw0YwxKgBU5DIxqtut3JtTvJsqb4aAPQpXAx9BKohbjJUfS2h0i?=
 =?us-ascii?Q?97S5n2g36K2S5BWP7POKkIFjvkKOZrw3y1ivKD5KDAeMKNGb3iwTl7RlKLJz?=
 =?us-ascii?Q?6P77f9ff1xxV1j4q7AY6AhSvvL9x2agCNjTeDUwzkk4CrPowXjKc5UuQTOd/?=
 =?us-ascii?Q?BFMhx65XfXVUq8/wmLMfYOTfR52x/0+NCM3z8ric6qPK7wxTc5E8FWWYImTy?=
 =?us-ascii?Q?isjGUOHMTLQLrAWpYhEu5u91J9JR6VlfsmiJGKAbSQkfcYPhslsvUdO6xtOZ?=
 =?us-ascii?Q?GFsd+Y+HCE9mrOTR2VypUPob04gqX9w6t9lkf7qp+27Fbikuc5YGLaszJU1w?=
 =?us-ascii?Q?Mm0YHQXZij4kDj+8IiCVIRikWSHECHcQrexovlxLV6nNqfric4TIJ4L9jW2M?=
 =?us-ascii?Q?7AjsdZaaf15UDAgTXSU32EO2Ylw70RDHahKUdsQt8XynZSkwA4ca4GYp5N1/?=
 =?us-ascii?Q?xvv2NEVZu1zPz0wNaPbSIwR7jTB4f5OgYdM1JeU94aWrcEPs0xyvBLpss6mU?=
 =?us-ascii?Q?BGZCwb2Hsfe/PHAwi2+OwVFEFVHjIzwZpIYC2o3foLpbJb9H9qfi3M+zvx77?=
 =?us-ascii?Q?n2UJoa953o2JCV1xdKUk0okXpajW1uRw8nqwEIgqkM4RH5jyD29nvmZ0hAcq?=
 =?us-ascii?Q?azO36Atijea2UoU7GvOHjPtrqN2XYlb6RM+ub4JaWkepu4EotHmFVkzuewA+?=
 =?us-ascii?Q?vd1TxjarKFtydtCdjOLufPCTuzWV4umponhwD4PlyIx6H2V4Dyx/GRumRHxZ?=
 =?us-ascii?Q?F28OQDQQRaU/onoZQfme7+BQS0oOhtMpsmeyqLjl9wwwrnQJnaDNu8Vlaech?=
 =?us-ascii?Q?hHlikSG5S+0sHG3LNiXpCp/4l7FSbMEA0woRIlzx840vzhWgPzjNAK1UzfQf?=
 =?us-ascii?Q?rilsDZDafWeQQQvD9Jf/MME9MLrks/9x24NIUvHPFRu+wGCkHwMT4BGhFF30?=
 =?us-ascii?Q?/L8xUPdfagW6ssa1PbCdLHIoP6yUWLhZOVJEPPwW/n3CerndN9quhwL81jHX?=
 =?us-ascii?Q?hOKaouq7yzAiYCyhoddXYQKr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e6b0f1-493f-4ede-e4d7-08d8f971cc3d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 03:04:03.1161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPlTgnJeKddu3K3VwhnGGphrdcDvmn1vKLbazHv4eGt1UBGxD9uYK1h48u0y158YZmzxudY4YEU4la8QGMHpCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3276
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The LS1043A PCIe controller has some control registers
in SCFG block, so add the SCFG phandle for each PCIe
controller DT node.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V5:
 - No change

 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 46826752a691..704e9e249729 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -875,6 +875,7 @@
 			interrupts = <0 118 0x4>, /* controller interrupt */
 				     <0 117 0x4>; /* PME interrupt */
 			interrupt-names = "intr", "pme";
+			fsl,pcie-scfg = <&scfg 0>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -902,6 +903,7 @@
 			interrupts = <0 128 0x4>,
 				     <0 127 0x4>;
 			interrupt-names = "intr", "pme";
+			fsl,pcie-scfg = <&scfg 1>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -929,6 +931,7 @@
 			interrupts = <0 162 0x4>,
 				     <0 161 0x4>;
 			interrupt-names = "intr", "pme";
+			fsl,pcie-scfg = <&scfg 2>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-- 
2.17.1

