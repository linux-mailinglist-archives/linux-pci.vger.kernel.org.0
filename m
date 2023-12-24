Return-Path: <linux-pci+bounces-1325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BAE81D7CB
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 05:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492F42825A6
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 04:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC72C7FC;
	Sun, 24 Dec 2023 04:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kJqB9GLM"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2047.outbound.protection.outlook.com [40.107.15.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA84EBC;
	Sun, 24 Dec 2023 04:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUm40QOV4RK/N5LPE+2jOEjN3HaGUqsOIb/Zyp67k+iOSyn6Pb2G0I8+iwWlWLkjhCjTtYk58WDe8wp2D6cgKGBA3ix7vufr/IWuUvmJFl/yTqY3mPuIIcBrAncNPdZgj7/8riSQBKaSFuxx12mFvIhGUm4rDSgJMZQxe6j/d/zky4guBp1/MWIJqccH91wstDzqo6cnZ6ok6rGRUxzQtT5g1d4YEzq5k2V4J04Hnw3CzZRXJRfZv1e3bBgJTH3u2ET61YjWaE0QtatetuJ6i/rdTC7qMy9QPSH9DTgj+TNAgRI2CJPgh/pX0rcNI8zn97M/hjELemKb7h+FyUb9ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KtRKc/o7fPXt5BqNF4qLHusMx6Q2OobEZzR1um8KU0=;
 b=XwXWaECgzZp5pzcxbK7wWbjwS9lSLArKR92Qux6jJNN5z5pqF0FmGNQfFvBBTp/PDBmUQEg/czI1yydKCuFUOytniymEkeNBhQIBsqpVWPrknfQg/SrBTxpyRKvAC+7usH3+i23U8Gs2Qk4I/t440plqLT7cscwgGu7y8UezMHc9zhu9FtGoNTBhkAvuZBNa9wphQwKCktlazEfNRaXCztBTc8rHObP2yoMiYhSWesCEsgElgwiey/25weiVtPTRkfp0/wILXYcs0MBSQaz4UDp9WgS70kGZOph+2qlTe9d8C0BBPGPj5nAuzRKMr6bfiFgB/cnhwIi9XLFehWYn0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KtRKc/o7fPXt5BqNF4qLHusMx6Q2OobEZzR1um8KU0=;
 b=kJqB9GLMFkP6ZYxm+rAY7kve0neOUPEeRLF9bf2b5JA0ENQ/Aj4pRF1bSetwSBY8j9l4Xu/bMcCDUp1tZZrbmY6pUtiQh1LXj0ja1vQinupyjdcM6fwwfpdwgtUiTmRWX+AMT9S/zg9alrxZNGVZVSfxKahaXtrjNsdZa7UeE10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7409.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.24; Sun, 24 Dec
 2023 04:34:13 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.023; Sun, 24 Dec 2023
 04:34:13 +0000
Date: Sat, 23 Dec 2023 23:34:03 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, manivannan.sadhasivam@linaro.org,
	bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, festevam@gmail.com, helgaas@kernel.org,
	hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
	l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org,
	s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v5 10/16] dt-bindings: imx6q-pcie: remove reg and reg-name
Message-ID: <ZYe0u+DyPztkQ82t@lizhi-Precision-Tower-5810>
References: <20231220213615.1561528-1-Frank.Li@nxp.com>
 <20231220213615.1561528-11-Frank.Li@nxp.com>
 <20231221225033.GA228866-robh@kernel.org>
 <ZYZYFYBr23OtTtrd@lizhi-Precision-Tower-5810>
 <524646e6-17d4-4a72-be96-74347be36482@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <524646e6-17d4-4a72-be96-74347be36482@linaro.org>
X-ClientProxiedBy: SJ0PR13CA0046.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::21) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM8PR04MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: 58b0d3a4-70c8-42bc-9d21-08dc04399485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Lz8Cmln4ahWdccFP6pVXJsU0SbDRUOw6sT6AZk5Owu8oOPk3K5YWvFG+71VmgD1M8YOn113cNNrTTwzKm+KMkXJsj/Sam4br392lexAL59bHDMGUhhcDOve3LTQKj0a751A9hc/RThfs4twqaW8iEmNcjLYS5LR0x6mYWOs09ZKQHZVRIlymUP1up8edysh7vFyBz3IlCy1kBRdpdB13bJTnnQJ8eUL5r2jZpLQ2zvwN7elWtRDjCUGWfSQrugFek7IcAvS00uxVOJr76vFhP8aYaLeaSpG+IODE8wtPIYfDkpjp8rbvI88NLGVd0sSLnTMZHl0PBod3Ebm0cmuja67jUbbkgKy2lGOZLLDq5rKRBneJ3dizcby1MyZjjuGDxbhBUzn7ncX3ydC/dZraAXyeNDl2RVMk0kT/VAk6gosRujz8FLlGy1BPNS15Uq5Nj8zaoH4TJiq/ZjyIQ8fB32H0EqSh3vEy2mACZLHjSvLnJUhp7cHZ/9pdJFTPLefS0kU/of516tTTclMzgmj7cjb0lc0wc9gQY5qmM19ZRmYp38std6VwBPf4TPd5mE0F+7fnEX4idXPENYKrt+Z1zYMukV/UM6p3PZHg7kUu5dOzR63G1nJK5ZZthgFYZM7T1AVzdhKXaxzGIShGuUDxDVjzjKzs3Dapf3E/JIq8Kbo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6506007)(26005)(9686003)(6666004)(6512007)(53546011)(52116002)(86362001)(38350700005)(38100700002)(5660300002)(7416002)(8936002)(8676002)(4326008)(83380400001)(66476007)(66946007)(6916009)(66556008)(6486002)(41300700001)(33716001)(2906002)(316002)(478600001)(32563001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XdgfALZPS9DzDHloT61KEgyj7C+An4iqFZDXtMfyS3f+tbOCH+2/iHOpVB/e?=
 =?us-ascii?Q?wXSm3312Y6DwgwxHgBv9NR7jtVxiKrlBkgJ59gCqYNpx2WuoIVUzIzIJJXu1?=
 =?us-ascii?Q?WENQpP2mS9WHue8sCm6zeZXtLSsUuhFeZj+mowba5NY1vpON0YUquqS5sduT?=
 =?us-ascii?Q?/KL7EQB/CFv9LDwjn2vVedSLtBHR9vjKIhYu6v0HnOYkePe4lCn+XEg5MPkG?=
 =?us-ascii?Q?htdTGBbx7iOP36J6hvoPtnUIaYrqC9+MwDHYEn2tpMGbVnNKcoke5FFLk+bc?=
 =?us-ascii?Q?1rAK393Tbwt35kCZxEa4nf7/ALyoBJUWODxtZZCSJ7dH5/F8vRFj7uP7rL5X?=
 =?us-ascii?Q?zKtcesfkhwXJ6m8z9T636QZi8OU0kHAH7wKqCbhD+aPF8PUVf3VQ9QI//0oq?=
 =?us-ascii?Q?jPAOMioFxxWNP30C1InTt32iFoaH/lQB6StaWDWD2+Dn/iIV/8xIhg9OjbgJ?=
 =?us-ascii?Q?Rbac03RnFStLIxPKMPjLY4bL/sc3j9XViHn4iP6ljnxzCwpejkhr7R3AzWAE?=
 =?us-ascii?Q?9d8iVEJTx3R68+3roVNU68N3Ya4GM5qKz8wcBfHWOgDmlqQyzKhgqjUq3Avw?=
 =?us-ascii?Q?INn8Qyx3egS5RkRDP+MPARlpUMqmIiCqZyS1EOPjN4ZZx5VXmZz8Zpjl9r2g?=
 =?us-ascii?Q?7KS8Y/e8+MLVAsbRfSvfRNc4QALByjDFBIpZDxayJC7mAbD1IAEDiIrDOIB+?=
 =?us-ascii?Q?K/LwUeMFqwrw6UJjmC8YCRC0krmmYIEC1vrx35gcOLcLWo4AkyB/1toLwhK4?=
 =?us-ascii?Q?jSE6BQHo7Ndl9i+Rx6Ls61eb1xszZIf1z23PTsKek0ekRgpcZBLYuhKNEEp3?=
 =?us-ascii?Q?mYHAZC0FdyEEBorzQ70KGbj6++AEwG8qEBABwXGskm3CACe9CXDg5JG/OdyY?=
 =?us-ascii?Q?c6wxOEsYJg3PVCuDr3iXAVudVgdGUdhEgVNEtnE8mZ1XC+c9UBfSuPcFITDN?=
 =?us-ascii?Q?sQssiJGrB3IKJ5m+BqkFSGoxfaK/5rEN/KTchrigLfhvJN/JUjVtg0DBnouD?=
 =?us-ascii?Q?bvMOZ0gVN6tO3oidPHVTqsR1U76aLPJ+TNSZNp7GWneQHWkeZCXRAO5FjdvO?=
 =?us-ascii?Q?uqMurqc8NpF4n3L51K0JQ3GEzyKFynhAKsdwJUVIvUGpG27E/qmqAU2lSTVy?=
 =?us-ascii?Q?VfujgR0b0Mt8V+vZVDlnmqoj1TqIeU0cqh9cmO7nFX/o6PbQNNH7WOFPq6dL?=
 =?us-ascii?Q?nOxX2K8GZ0oiiLhsMXaaTnhzHBJ7XsLX565k+/hpmzo1qeA5SgYA8FTPFqau?=
 =?us-ascii?Q?JTdKhyTtAsYLFSW5u2f6kspbcYxlguXFb1YX/EJXQwy7w0tzu2OlDLyQ0whj?=
 =?us-ascii?Q?DS23u/SBF07kSQxfpKLX0w9kn26IIjoQCtoiV7YIkDaSYNOWYlhSgifLhErG?=
 =?us-ascii?Q?xfqArq03nemA2y0qRCGp5fKkeFLJJQF/g/DaDR1Y54OgO3WLvqKbXlnPWVrc?=
 =?us-ascii?Q?VE2cmEWGcPEhQpHkNlCS1or2+tP2Vg+se8/8W9j50BN+8o1QtX3feQaKNjPz?=
 =?us-ascii?Q?VyYmn/dA0hfYXD0qyluN1BQDbT/hTsXCLSeK4AQYmEjRHKG9fZlklwslYbrX?=
 =?us-ascii?Q?kaR5E7o8uTfHtLsoq+0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b0d3a4-70c8-42bc-9d21-08dc04399485
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 04:34:13.2814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0mGyD1mHLsnPop2NQeX2jgjwIgqHqYu1FAg7++oWUY4OH50StHBd1Gghkwog9YNxCyGZrJ5U7Z/hwAJhJhWmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7409

On Sat, Dec 23, 2023 at 07:43:01PM +0100, Krzysztof Kozlowski wrote:
> On 23/12/2023 04:46, Frank Li wrote:
> > On Thu, Dec 21, 2023 at 04:50:33PM -0600, Rob Herring wrote:
> >> On Wed, Dec 20, 2023 at 04:36:09PM -0500, Frank Li wrote:
> >>> snps,dw-pcie.yaml already have reg and reg-name information. Needn't
> >>> duplciate here.
> >>>
> >>> Acked-by: Rob Herring <robh@kernel.org>
> >>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> >>> ---
> >>>
> >>> Notes:
> >>>     Change from v4 to v5
> >>>     - add Rob's Acked
> >>
> >> Err, that was intended for patch 9, not this one. This patch should be 
> >> dropped.
> > 
> > Sorry, will correct it.
> > 
> > Actually I want to move it under Allof
> > 
> > if compatiable string (A, B, C...)
> > then
> > 	reg-names:
> > 		-const: dbi
> > 		-const: config
> > 
> > Differece SOC have difference reg-names required list. If split it, it
> > will be easy when add new SOC. Needn't change two place.
> > 
> > Let me update at next version.
> > 
> 
> This patch should be dropped. Why do you remove entries from top-level?
> Are they defined in other schema?

pci/snps,dw-pcie.yaml already define it.

Frank

> 
> Best regards,
> Krzysztof
> 

