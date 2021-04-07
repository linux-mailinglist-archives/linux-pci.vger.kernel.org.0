Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD983561A9
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 05:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348209AbhDGDD5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 23:03:57 -0400
Received: from mail-db8eur05on2059.outbound.protection.outlook.com ([40.107.20.59]:62177
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344228AbhDGDDy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 23:03:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0OC2IhU1MsDqZ43kbb52DUGHMrPiHMDfRrMxOcvfhFDMlQbtPDQFQ31EfsXzHdn3yed2DTaE6Ye56a3n99rcWWPeKzgXfPvIntLvnDG2a3kI6axDhr5Pt6K54tz4/FByQlBiW+/FwHnDRz4KwFjOCha/6jNwWiYAwnOtozB4PugPmNdowVhYyEuMWQYIEEorgix3edq9U3Ws058mrXP1+u7Tel2RRAUr6Wih/theiW/PZkkZYnOoM7TFFIUWDwefjY/IZJ1nkP6emK6lpyycqfceIG9b2O/0cHqa/U4Yc2zKdXqbetgbSoVjFK1TWGNlXJICEovK6ODqcz2viej4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lKAep+0+Cc2ajk+UnkD5zLCckdWXnbpRCto72XKAfM=;
 b=NPf0Z3r9NQxNpkYWfe8eW5JEoh/fcNFE7ykFVgKliERtiDHw/ZC1n8vTLjof/8DepQ/qjMo9BLJCI+prWsP7koVLvmYWel5cmlzDJjMjUoGaHWwQC954GbV6ZpwhHi3uPMrXs8FGMeg+CcH1GI3HgCPjVddv9o16SL96ep0iIrnm0jxpg2jtwzMJHDxj5zY/N/im8MR8cGdD+9poHuMkMawlfNwTzhdTrL5BEf+ok8psvsSUuYRfWSTfqMzWc9FTbtHUpiVmdp6+iucIfot8dTT+7paBh6ZGCjCUuIGg3Fvink5rSDbaMt1IOhECnVMyBfP/I4OrivE8kUOka1Z+2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lKAep+0+Cc2ajk+UnkD5zLCckdWXnbpRCto72XKAfM=;
 b=mHJbAWvz3z/sR0CItvK2AnywjBheLMIVG6ZPOEwsN43Z9GPtuHzLppPgkKLYl3faE4rQOopCJ1J8nyIN6//74cZCXJ8epK/GGvgy5O774hIokG7Xx5RcL2QJSliY3o6YjIEsowmbp3OulN5j3aMaewlIdUX8Qe6A9QQKEWTbvg4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR04MB3276.eurprd04.prod.outlook.com (2603:10a6:7:22::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Wed, 7 Apr
 2021 03:03:44 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc%3]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 03:03:44 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv5 2/6] dt-bindings: pci: layerscape-pci: Add a optional property big-endian
Date:   Wed,  7 Apr 2021 11:09:44 +0800
Message-Id: <20210407030948.3845-3-Zhiqiang.Hou@nxp.com>
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
Received: from localhost.localdomain (119.31.174.73) by MA1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 03:03:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3daf7b7-278e-4276-762e-08d8f971c0b0
X-MS-TrafficTypeDiagnostic: HE1PR04MB3276:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR04MB3276B9BD64C8AB3C15CA79F884759@HE1PR04MB3276.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mtIA0MdmM/ebyivwIJl0c1QVgqp4pLqOtI5j805d/appBVx1wY1fTCvBr0Qdd7qy0Z9wP+L17nujsxuBe+oxIgGXNwao3mKzJmyI7qRFpZQpiXe6HieA19YW18+VTwp/p1s5Yu6x3M6yNIuZO48K28UItjpSNol5v41UmxivQphmMmowdEe0R7Xji5XErcxYPahdJmdNtaa/JI39bnFxrtmzI9lY9uCrLmMCWl8xJK5Sh9PA0+2XYTedrx/xJJK+ZSeFvJzp4chlGo+WAnll/wzBJoSSqSSwnnyYgvAMDBMyzQRxVGrhRhAUIEw9HL8mCJId7RoGC+8ojnsOFyEQpJqVvIfYAcXBj3uyxp/1lcrVyorY4t9KNSsXSLwtrc5ad9eXiUpUyKNR4WJUsqq9V61jRXjPzNjdlkMePxXC0frqOCmxNR6nq0PtLohJgi8hda2qhiRL8yxrIGwvcQZN72oLCOtmdYASjbFXRn9/tq0YWOMlgZPHNDf3cS30Wi9NOYryYhhNTGExZmltGDKk/ElSgiMqTP2h45dQIsyue416bv/e4QLt/Bq0DDH8lOl68j06hMRLr1gEN2xxK8ZfeHYf0tSm8O3nyBLKNRshGrJgz88lFlGclwq/Gn0jcrT2OaMVCl5g98n6tRdqeJygRlT6qLI7D0mwVHSFglz1gw2/VXRsVUV9yIhG4QBa7RNyure5lH8UlChFks1iIoV298j+sIHgCYh9MI91ZUsvNnw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(4326008)(6506007)(36756003)(38350700001)(26005)(2906002)(6666004)(6486002)(1076003)(66476007)(16526019)(186003)(66556008)(956004)(86362001)(66946007)(38100700001)(69590400012)(316002)(6512007)(83380400001)(478600001)(8936002)(2616005)(8676002)(5660300002)(52116002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PsalVuelNE4O1QOw9j931DfC4/w+1Nnesr19GA7p8dwle1XtwUYW4AEs8Yol?=
 =?us-ascii?Q?BEsWGktIM3HbAZsDTjrRQkOP1MjBz5+7KcoYpUk8f7ZpVFD7ELRtS9Q0VV48?=
 =?us-ascii?Q?ulVk9Maqs55/cnUA2yO8OtqABvcZtXCSOKqxMZVKiDY3W33wTPlO+AwXmDKY?=
 =?us-ascii?Q?EnqAkPqI4jaxIkEgJMMcj2kd0ZWFZPUv18RWXScI9Kb7+e2CFrARX5Yomi2T?=
 =?us-ascii?Q?Ql0Oq/0rPnbevUl4Br9lqAfA5wVPnEu7kaNUTPn/GfQdTr2h1xecsBPnKqw+?=
 =?us-ascii?Q?ywX6LCufIthQ1/dq/eRjdBXT+4op4La53eYGNyiOAD8IY8oW0N22mQoUS7Q6?=
 =?us-ascii?Q?6btI9X5erFaf9Ihk1WaJ12nnx1bUaY7eYZ/4zcvnln0kU55KkQDxootoms25?=
 =?us-ascii?Q?lgAobkmkON7kJ45pVv/rQP83Z8sy85W8LVWmS5w+XPd/5cZtF0kppPT0wTJ2?=
 =?us-ascii?Q?L4wZ4vV5oH3nEH+Svn06pGA6sIkLUEHI+sC7Vo4Ip2uz/eEA+VVtTPZsx7Wz?=
 =?us-ascii?Q?/V8f3kaFViR639KjDvrUl58XNlc6iRhnc0ZNffZgAxbR2qrxQC4dCOiJ78wZ?=
 =?us-ascii?Q?fqR0NW38hxvB8RRojO2GGS/KMyFT5KGYR6IGGkXC3REvpmHkf0UzAjFXh9YB?=
 =?us-ascii?Q?jqU1nbxegCnVtrGLnukFuaotG1tvm1wWIg7Pr8WaNtc2NpQaAqcKD/r+x+pJ?=
 =?us-ascii?Q?C07A2JyrfaI7uZu7A4++CSykjS9vNvnGowVqPHR4WcRQH63SosFxQQ4K+KBM?=
 =?us-ascii?Q?nP075Ew2efRsgBE3P4k6ep3M2zHtKhlcRJ9QCm6OrgnH19pwS9JZ8YLn1alb?=
 =?us-ascii?Q?icBL0qmiBsE6G/Hq3VmsE7o9+ZUm3JZ65MlIG89m58vrW/x5Qtk2+vbhurqd?=
 =?us-ascii?Q?GJLVdWrLAOY9LDMuG39FLhLp+KCJZfMsOh7VqJu8YboZar+TaR03AsaHDDzk?=
 =?us-ascii?Q?hzYGp5tKrVX8taAVmZ/k87MJM/jyVvt7/ZwFZDngrvb8kCP6t59Wb3GvfEb7?=
 =?us-ascii?Q?Xj7zyfjc+RUrkY8QP9yaNRIl5CNVz/QdpTU2oHFKD7zwpV3kQfARmMeaeLgl?=
 =?us-ascii?Q?PRYxLKBhBgacLnM//PNV0uSc0GHEWgKAWF8LlMoPgiiCiMoknnISMGW4uZa1?=
 =?us-ascii?Q?3cLV4InOy3ZL7S7XldqbrkzuSBoscQLHDs56PUw7zPwzgLOdbhpYGw9Ndfgq?=
 =?us-ascii?Q?3nZmleoei1GrJ6L+pHFyMxRh6NN/Qy7YwtCmNaO/tbZlaYPm6Hl3PH3lJ4wQ?=
 =?us-ascii?Q?vAb336aUaPYM6sqKLKWIkH1fedhX4nB0kORFuCb+ZUOKVW8Axc95g3NHI/2E?=
 =?us-ascii?Q?BNZgyn41PEDJdF1ZzU5t1JuR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3daf7b7-278e-4276-762e-08d8f971c0b0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 03:03:43.7962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0/5ROx33dK6K9YFoBIQZ6BN+B0ICBSKXXY3i16252ExV6U57LVEwFuyPiNJ8MfU1QzHvfabpPaK0vP1NqU77w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3276
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This property is to indicate the endianness when accessing the
PEX_LUT and PF register block, so if these registers are
implemented in big-endian, specify this property.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
V5:
 - No change

 Documentation/devicetree/bindings/pci/layerscape-pci.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index 6d898dd4a8e2..d633c1fabdb4 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -40,6 +40,10 @@ Required properties:
   of the data transferred from/to the IP block. This can avoid the software
   cache flush/invalid actions, and improve the performance significantly.
 
+Optional properties:
+- big-endian: If the PEX_LUT and PF register block is in big-endian, specify
+  this property.
+
 Example:
 
 	pcie@3400000 {
-- 
2.17.1

