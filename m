Return-Path: <linux-pci+bounces-1242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9894381A83D
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 22:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FB88282259
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 21:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937C74A983;
	Wed, 20 Dec 2023 21:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="by3PgZN9"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020544A9B0;
	Wed, 20 Dec 2023 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FArDlOL17CAoJatie20L0nCGEJwPqLviUYQPwG1L3Bks5BssZhU9cNfPPpQrNZDJ0HH/PxYIOKNq9rWz2x2pCrahxrowj9X0qwDt1v1pOl6Ylk4HcitBONsFVumDgiXD1apfmowPoTls058XZof5eeq67ZhHApmiXFXJmtcPdtdqeievvDylV64vJOhBv0UhuavpbwAZGxEYfrnH0hXIr8q/noz493gGK87/Legn5QwLgKmnnGsdp5QKL1c7trOMTmD11Sb8DYso1Jz4dmLI+lWmaZylVdlmprTD+fBZOVeUWe5cpeJGusCXu6kXfKh/RxFx/W131MMs9OI0RKDUlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/2FmDfgz5s/jZe3VzvLNU2YVXcftn71yBufc3jxwcw=;
 b=Wa0gYuKphxPx0QPPUDsOFJCJFu/hoV1hvU11wkiYZuoSEJLLt0NIQ2q77oD9kKYOFm4sIjNsxrcKLndJzMBLW+m+TfBz6ECxVsyP3MAGPPORUV72FniZANGjQ75T1y0fimiAqDQN9CnXCmhx2C+/lnR7D1KsPBqZ3tA1vhAeYsccHUcckdIQiQvhpAYL+Smsu7HyfWjp4hC3TfO4VgW7t9vwxGmS5FnB+InkJ4RLRrTPG527ytqUoC+KhuaimJ6G8FvmcHnbRldDxrxOnSRGR+M8m4vFjPJkhMGnbRLGXt3qcNmFEDHRozd/HRquq2Luy8c/b/H2FYwym9SIP7o1Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/2FmDfgz5s/jZe3VzvLNU2YVXcftn71yBufc3jxwcw=;
 b=by3PgZN9w4csQ3mA80RCyX66b2ZlBTBNGsrObdg68FUTbVF3LFfZqRsCzm/FJCKMcYDJ2xl3vxzkMZv89e7+ufDLlWvDNlTQidhV+Ymjj1EkoyB7u2xv4GVu4vzcGaGIH0AUywN4/61hKcd0aYrDPu8RadQJTMPmhbDL+mSvlzo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB6777.eurprd04.prod.outlook.com (2603:10a6:10:11f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Wed, 20 Dec
 2023 21:37:33 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Wed, 20 Dec 2023
 21:37:33 +0000
From: Frank Li <Frank.Li@nxp.com>
To: manivannan.sadhasivam@linaro.org
Cc: Frank.Li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	helgaas@kernel.org,
	hongxing.zhu@nxp.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v5 10/16] dt-bindings: imx6q-pcie: remove reg and reg-name
Date: Wed, 20 Dec 2023 16:36:09 -0500
Message-Id: <20231220213615.1561528-11-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220213615.1561528-1-Frank.Li@nxp.com>
References: <20231220213615.1561528-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0110.namprd07.prod.outlook.com
 (2603:10b6:510:4::25) To AM0PR04MB4834.eurprd04.prod.outlook.com
 (2603:10a6:208:c8::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 8590f525-1d0d-4daf-33e4-08dc01a3dffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8LwuftgBvxdz54jJ4Nc604mbUj2j3+YFQrtrYYAjtAmPVAejRT0NxT9ndJDld1YB9alutq9OiSILuxhQD7dqoA9vLm0Hy2vwHW35xq/kbz5X5pWMBN/zP1D0c4M3xq1Si1SP70/k+6TvGnIJVeCAIAtgYBLTqZ+jRaul+m+I4fxbY2t19RL/HMN9rfakJ72xFclT0DXpQmaaGp2GVnyaoLvRcRBr48nOo1U/37+/FCqPisOiONYb5dp7r2T4dRnk9b8VgNU2JdPNTNF9s30SBDSBea9DVgt85T85Ya5W1m/8k1MdK8fjHcXGkT0OAoRlxnUHLf2NhMo6b1EAuLwgE3qpBjNLnINtBHY8az2dyb3zJl5vQhD/ehx9I8iuOP3jdIckVTHv3pt+f6HwgTI0lIcaLAXwv5Z7gYDjaRBy0Ti1t0OwvfIe1fTE2JIg3dDPuuDE2zHiG77K8gMmYgCHi1DM5tVGJiJkYXvQdIxXisW9js/dAH+ia+m1ewLovhvTI1GXqHthXHZP9rt5aee3ob4MQ/3DM7gVY9QjAogEkRPmLMcaBfDcfWbSDY0ZIutTHXS+9tZ2C4GebEOSQK08G1TTkE7MK7/Y+fKnu1CpomiIPULRUyGwxq3R0BC7bGdcSqwf9heOe25SJvSGsb79Zg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6486002)(6666004)(316002)(478600001)(6916009)(66476007)(66556008)(8676002)(8936002)(66946007)(83380400001)(6506007)(6512007)(52116002)(1076003)(26005)(2616005)(41300700001)(2906002)(7416002)(4744005)(4326008)(5660300002)(86362001)(38350700005)(36756003)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a59NSdSCOWfQGDPlZb+GLZSmq4rIZjmZP9nfivRRJiCe3xZp5o2KalIfJ0j/?=
 =?us-ascii?Q?IJvTGF4O7QuhOGOcL6yF9wFIOJLS6BnT7P1qLXNTKalucuoxUG/Gn2eyrBoI?=
 =?us-ascii?Q?GaNFODmp/PYktFpn2OyIFW8GsQmp3eCQi8nivTKQNisWifkDzt/nJMUHqgCK?=
 =?us-ascii?Q?TnFR/0PNkabALcJIvK7coPMaGXFczimtmHLxSBJFrl1s6GLinn5Uo9C8LPJb?=
 =?us-ascii?Q?dKg5Emd35Yx8dIe546E8z1XowvuFjP6VHMv+ZG0HzjaePcbrgKuxOT46NOyR?=
 =?us-ascii?Q?xbigtTWDB2aTSYqPprjtgHvM3DYPxRcS6Y7gZVRj9KanBsxD9E4/nGOOzBIS?=
 =?us-ascii?Q?jRNb5285kit/c45+qYJRdKsfnjVLHJSKQIVnrJWlFfhDk0EHjWMhXg1Qgd7v?=
 =?us-ascii?Q?eEJYcilGgVyadgOnzw2XUvXX/taMAVVUJA42UfE3DRnS0wPfI+OKyqHlyZWO?=
 =?us-ascii?Q?Vt2jd2DfJ3f0DiBpc3Ji0RQvK9caoPznElsAJk9MfNFcOtfO7lpRso3aPR/Y?=
 =?us-ascii?Q?1cLxm8stTa7MhPmWor7zVB6L6ZxrMJAEaAyE/nmaPYRW2bC9g5Qrr3mH4cSL?=
 =?us-ascii?Q?k/kEuRFr8TJ6xhY3+ACCxPTiCa6vyrIM3bVUsi5LGWDkDy04D5d+BfNkej7E?=
 =?us-ascii?Q?/nRk92uR+BSBz5GPkN449KhXebXZayMVsOFXRMk68hgUTX/GflM2XpXMtwgk?=
 =?us-ascii?Q?zqINm8qWyo5tVADPQQLurjdzdbJb6bPbqrjC0o9qsWu5hej8Z/GurJM6a+KV?=
 =?us-ascii?Q?C+12vUQ+WFgS4nCojDjJQkLIwq5ZBRSE8Kkdzd4aAiy29+sbNVI5cpEtnqa2?=
 =?us-ascii?Q?//EHFR03b+tHDzu9JEfIxS5y1d3Y3zih2ecUvmakPs1BtVB3TKVaqsBH6i1D?=
 =?us-ascii?Q?rX9W7juQlUcL9awnEQrV2IPvFkMUocVaZAma6Gvl9oXVRswLGILW7PpxUstn?=
 =?us-ascii?Q?kIqamBH0QOFkDRSisCpq6zicWHekQ8GQN4AonuDuGmpRYpPAuoLo3zHGzXe3?=
 =?us-ascii?Q?RvXCf5avklaIMAp27FT3LGAGo3M1HrSr2cmTXiOb7zFtJZGzt8y/5oGK9eFE?=
 =?us-ascii?Q?OQhUgbPX931jABIr51sqDXQhjeeFElA1kGFOXtij3N8XCKXPXb8nqfYe8b6F?=
 =?us-ascii?Q?iPrIg5sgjNA7vP5vMB4YhR1byH3WRazHkLKELno6yI2perZ3k5c3nOJOrJ63?=
 =?us-ascii?Q?avzoAu9eDgqBCIonXEjnqM763YRamlVkgVwmICJl1GlQX6FYoG7MvAKZqFsG?=
 =?us-ascii?Q?+JjQNUEOtcQJc7JKNftXEHBgDWzHRD5KZIbcIobaJzRocqGr1XCdFhgSMBBL?=
 =?us-ascii?Q?6fsO3UR3iSp4Vhz8xfZc+zuH6cKtp5LqiXoLU8AZ2+89WJ1W3LrOYU2Us3el?=
 =?us-ascii?Q?8/bRXU+WBRroHVAABtuu97irR2XLZKQAkEB4g8ZloCRP4yfqxmUGOoW32Ghh?=
 =?us-ascii?Q?4oYJkSO9t0rZ3p/U61AwcuOQUaSVjWkaES512mTULN8oUCVgkvmZb/1NeW3T?=
 =?us-ascii?Q?mgqW7ad1jtdpGz0SvzNklYLH/ZI0XOty4m/fSlEDb6TQmAxDZny5vT9wno4n?=
 =?us-ascii?Q?Mev4MRDg3omd8EHJSeE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8590f525-1d0d-4daf-33e4-08dc01a3dffd
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4834.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 21:37:33.3287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tYO7KZRgt9QtSMNi3TR6VakrA4xV9WBo1O/KVpI4YZMe0dzZ8S5Ut+9TkyFAn+Sph0Y3dihTMkNDa9jVCYU25w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6777

snps,dw-pcie.yaml already have reg and reg-name information. Needn't
duplciate here.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v4 to v5
    - add Rob's Acked
    Change from v1 to v4:
    - new patch at v4

 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml        | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 81bbb8728f0f9..f20d4f0e3cb6c 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -30,16 +30,6 @@ properties:
       - fsl,imx8mm-pcie
       - fsl,imx8mp-pcie
 
-  reg:
-    items:
-      - description: Data Bus Interface (DBI) registers.
-      - description: PCIe configuration space region.
-
-  reg-names:
-    items:
-      - const: dbi
-      - const: config
-
   clocks:
     minItems: 3
     items:
-- 
2.34.1


