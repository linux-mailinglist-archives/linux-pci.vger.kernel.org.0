Return-Path: <linux-pci+bounces-624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED5F809169
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 20:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4225628178D
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 19:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919ED4B138;
	Thu,  7 Dec 2023 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QM6eSu8n"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2058.outbound.protection.outlook.com [40.107.6.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8636F11D;
	Thu,  7 Dec 2023 11:34:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GehCewLa0L10eJymg593vxCDGC+2qfoVjTtxg+CmLsxPs1DiUwYrI/W2ZaKE22J3qkcG/BLgfZyFWYO39Lsm7LWgtuBZanbr5vUxrVLLyLhaJqSAsuD7c0Z/tC0hs9wDek2+2yf1NzQ1VEksvP1jELEla+pW6DrIBCN/Ay+OPD7jNhSExjrMAcaeYhCYCWJL5zAZsvH9VXxbz+LHNwMufYKRuVjhbf4vE0obUxQa0ToSxo6jEAJFZu5iYAxGhPjUGmyX2VjnlxzqowUHDWyvBzYuDANlrQA/soXdLrCUmMGKk8SpVa6JgSlDqCBtO60C8tPZ9co4OfL0u0OBMZYnHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNkSQwzKXGQp6yi0kvE24U3kEqTFmMVL/whMruEi+WU=;
 b=K6z2bGujx3O7i2BXRcs2cbU89vP04ESR3u+bIywuakV3e09MyfA+5lwzeQ1NQ5o2bTLwJyKYXrtXfvtOOqoJl3uT6UNrko736Hyw6qSL5mpvduSsVdZ8AF5/3ITFkPZnUUdExCcDDa6boGNe4a19r83H1PRTDbCbWY/rF5ahELiMd4bt0xrqtU1FSTpOJnKVWSoWEw2Mz9KLiI0LiCKwDpHDJO3dZKHI2OqnXr/IcmKXiAfjpe4Sjn13LJ3cjtyAw49hEjQ5zOy32PU9cDoLhFcZXTxuz6V5Zvi4Q8TDG42YVxu+oMwJEHJkHZ4JTh7bxPgOzh2qXAYlQxuYVTx1gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNkSQwzKXGQp6yi0kvE24U3kEqTFmMVL/whMruEi+WU=;
 b=QM6eSu8n6gucyk5IhrT8LGNQV7uaBbXSMSJRhpXPwnA8vU7vycxHkTxLGu3SaZQ/DVqqrNOIHKF4n1+ZjXe5MiGyHbehDh+fozGteQnXtmhzUBxj/FwmYvFhIFnoFAbJaL0SZS8Wsda19d0oi4DupElioDSl9AkhFA7cocyrXiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU0PR04MB9635.eurprd04.prod.outlook.com (2603:10a6:10:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 19:34:50 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.026; Thu, 7 Dec 2023
 19:34:50 +0000
From: Frank Li <Frank.Li@nxp.com>
To: helgaas@kernel.org,
	manivannan.sadhasivam@linaro.org
Cc: Frank.li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	hongxing.zhu@nxp.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org,
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
Subject: [PATCH v2 0/9] PCI: imx6: Clean up and add imx95 pci support
Date: Thu,  7 Dec 2023 14:34:21 -0500
Message-Id: <20231207193430.431994-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU0PR04MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: a142cac0-0419-4c74-ce4f-08dbf75b9435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B0id3v/W/rkKSmkVC7dApRZET3WekGe2PLCeTY+r2mqcAsieD8TVHRjmuVsN0L/T25oolPEDoLR5g5Bo3iMWdN3qjqTI4CgH2fYQ3TZWOYGI5GAc7pGUYF9Y0MlvSxBuc28mgRwYR/qDmhVv5cWaaUx2JO0NlGfLiDrJDf6ztrJ2MtlcvLc9z1QRgjixBzV4P6OaaExWrJxAfQoY5ITr0XfC5lMjqOw6EInzC361K/jScUhHKIPJqmZDWwE267qMJtumZjRANt4jqoKjFP6OV4JL1gwJC/vd49EPb85tKrxXEDezViLFR1v4x23XgCAvpUGs5QAyFgTgkJFnUVW7uM+gX3R2ThXA7ZZl6q8JV0392oAu1KIZdGISwcJTuuePUVEz6DxtUkiJM8CmsM4Y3ku2qFV/TFFEGv1cLu6NP4lY+PzXLH+ZIa+hRU6DrUAuUuhRlxDIc5tz/1BQ6Eg1SxAv5ZuFxEa6xBvKKdFaSojwl25bv9XBxuovqEKu7quFeIJlJ+eRovXkNg3xDi54rIAlLytPS0yrUvbmgso0EJHQUcmcsNJEaEdl4lehFWcXEmbk3rkCNp+9MOeB97F8iulbX4ubuyCPikILfrJDRGHTxbb0hLisSgLT+FpCkn50
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(52116002)(6512007)(38100700002)(66556008)(66476007)(66946007)(316002)(6666004)(6486002)(1076003)(2616005)(26005)(6506007)(83380400001)(478600001)(8936002)(8676002)(4326008)(4744005)(2906002)(7416002)(5660300002)(86362001)(41300700001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t1NglX5a2KaiZ82lMvp+j+DMhM2A9B4MIHnx+fF0v7U3KU71CXrZdO5FB1qS?=
 =?us-ascii?Q?7NMbmO5xJ0DVu4EERNMMw406WHRt9zmnhYroJnH5v629pHkdqHXcmqMGufWT?=
 =?us-ascii?Q?fAOhTWNqWArKx8tFKVRdCyk4wuJ8TDZqlh2XU9O39OIpVd72WlYLYDFXzNLZ?=
 =?us-ascii?Q?3R4cJFg//N26aLBqkKmjs3uYmiLjO4Sv1mVjOKr5laE+NwJKtQFSNQ9nYM4E?=
 =?us-ascii?Q?E58fkzRxic3GjiYOlc9PAquUS+aW38fUk1v+s7IsHdKrvXp+zbTlUYtVz6ME?=
 =?us-ascii?Q?AaiJ5OiCb1dR7pzeyVt3wV1zcA4ezYu4MJtEWLGXwogvKGrbZ4qkqKKNGu0s?=
 =?us-ascii?Q?R7MayRwUjt0ULka5zrVUa3/2t6w0yC7kHogMY52pdy0yIRJUe2Gv4PldWSqZ?=
 =?us-ascii?Q?cRlqGv6iLF32Zc12Gw+46Cz4UphsJ3diaEKBJ5LzOKCIi/Le+ZNGP2tJtB3M?=
 =?us-ascii?Q?vcWa0Bt8yph1CgnV5CCVmqiUcx90DPYB+iMsdWNEqyHGFkN7B4NDlWCfvT4B?=
 =?us-ascii?Q?8XZAfySdmXYUNxwh9HmUmr9rghr9UrsiLLMN0zpCr0+B/VJugTSwWH+81HWk?=
 =?us-ascii?Q?oTAljuZ6aqQAlr+pI73vwrRGfEfuRgGU/g2RKI4jGlZRlYdE85umOgVGWuGT?=
 =?us-ascii?Q?ecFWWNRDPnm6XxT5YY+rAU9+aiKvrRpDyqKsl/pBob9jK0ebQVwk+Dle8+bu?=
 =?us-ascii?Q?2sffUFGD5rdvOU64vgTFMKW/32YHYhbRaxBoWLZue/HQRdAjzHgl1Q7lefCU?=
 =?us-ascii?Q?SDpPrniPsxXWrkuCGRVLXqRJ330J9zHVlLIXXvF9ha8BsQnoLPUs3aXRl+jE?=
 =?us-ascii?Q?UTAhUnDoFnz+Ge1nSJCs5lVB7dcf1WIREHEmtkai/GNPJz4J46q/pf8jq6Tr?=
 =?us-ascii?Q?UcilFiHOAPR+WbJQtOxglLTzSg3XykkrSQPCuWtQ6slVsujwiGcahDxL3eD0?=
 =?us-ascii?Q?ZQUwYjDKzq8BOUisaq8Aaq+uRpKRaOtCzonViHNmsehwK5ZsulU6WTzGPFD1?=
 =?us-ascii?Q?2gedWCeH0pCK3/oeylPReEo0+6oYYc86tD6zD08c4O7wtUPeGiQKLs6JxWYC?=
 =?us-ascii?Q?rhHMqMlm6jz2ycVKsgCGiHk3QmsAjerR2yiE5upLRGa5m7RrkqERv77MhtUg?=
 =?us-ascii?Q?w98sPJCAgMYCOQ1OVkDvBqVAGC0J0UTksAP5g0nN9DFJcpKro1+PcnI+6CiA?=
 =?us-ascii?Q?IPgzLsbYnEX2lDeHy2r/pNq+ao9JXFiJ1Ny5X7RAMUEzK/WsMiAgLzWQfjX3?=
 =?us-ascii?Q?nkY+0U33rIdZ78PAdjmItG+/F0Q4+sGQuP+PN3HxAaK6CapiGU+jFAqXu0/M?=
 =?us-ascii?Q?L0rA6aXL4hA7IlMqKNgLVos5qVa8Dis1DhiuS1lMAKew35lVxeWCZPF1hbDc?=
 =?us-ascii?Q?EvyL0mblM7F7AvHuXHiPo9jwtDsbzjfxCDz+GK8kLn+BmYNvGMUNXFpjXEMd?=
 =?us-ascii?Q?5ZE1hwROThq+CEkIlzAFTke4dPmPIyOqBwa0OW2eYx34kDO//55c9RkOFiIP?=
 =?us-ascii?Q?Y0Hsv3B5jN2fVKjw10s4bjNyuFI3zir6bQYX0hYT3x24skBYWk2s+pcZGG/J?=
 =?us-ascii?Q?DtwcMtUS2DxieLizJVo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a142cac0-0419-4c74-ce4f-08dbf75b9435
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 19:34:50.6917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LqEe1A3Grko5hBu0sQqhiWPyjZbpiaahVVS7324mNDB/IhG5ypFtb5loC2CvwGhzV/IT5xdhML06LE9PxKM9LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9635

first 6 patches use drvdata: flags to simplify some switch-case code.
Improve maintaince and easy to read code.

Then add imx95 basic pci host function.

Change log see each patch.
Means no change if not specific change in notes.

Frank Li (8):
  PCI: imx6: Simplify clock handling by using HAS_CLK_* bitmask
  PCI: imx6: Simplify phy handling by using by using
    IMX6_PCIE_FLAG_HAS_PHY
  PCI: imx6: Simplify reset handling by using by using
    *_FLAG_HAS_*_RESET
  PCI: imx6: Using "linux,pci-domain" as slot ID
  PCI: imx6: Simplify ltssm_enable() by using ltssm_off and ltssm_mask
  PCI: imx6: Simplify configure_type() by using mode_off and mode_mask
  PCI: imx6: Simplify switch-case logic by involve init_phy callback
  PCI: imx6: Add iMX95 PCIe support

Richard Zhu (1):
  dt-bindings: imx6q-pcie: Add imx95 pcie compatible string

 .../bindings/pci/fsl,imx6q-pcie.yaml          |   1 +
 drivers/pci/controller/dwc/pci-imx6.c         | 514 ++++++++++--------
 2 files changed, 300 insertions(+), 215 deletions(-)

-- 
2.34.1


