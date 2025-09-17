Return-Path: <linux-pci+bounces-36363-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1ECB810CC
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 18:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FDB71884A22
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 16:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D806A2F9DA1;
	Wed, 17 Sep 2025 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZxTwOwHS"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010015.outbound.protection.outlook.com [52.101.69.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34FF2F999F;
	Wed, 17 Sep 2025 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758127108; cv=fail; b=md/EktwTJXUBL8dwMKJTDq8t2OaPRoB+cuOsZUF/83qm9wk+wMtDsz3kHEJJIvxLjJwHZK3anUXImhsE6aali2nX6b1RMqGE1gSHONHAfw+CpjahfOYCbtPmimklIh+fvI+TE8mYzdxYrJoToqfjpsQ194iaok/XxuKCaEo4PTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758127108; c=relaxed/simple;
	bh=P5iRSguE4JkCofl4RSdKTKcj7JRzZFoWvmE0hb4knaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mZU+6ifyC1Ta8Ruh+mHQPv0M2uvg7inoHWc6Tl9GaxrOT0+rVhIUYmW26ulFMtBipFOabOvudKpAU74Wk1kJBiBcyC+h48Wer/W9cfnRlx//Af7CI1PO8tHHH0yWtY3Th04Vmuttwt+es6aD2DtPqY/7a7sPN1ybvzLpAH6SBVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZxTwOwHS; arc=fail smtp.client-ip=52.101.69.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QeP6yEvHu91Of3rAFLYY7yw9+rLpdgVqOWVlMrpEW20sMW9fHBuhYvlKPYaMYIsytUC40wh27Vx882i/fHg9zbb5gWFxvNo8SeAgiR/0VIr6nIXzDUMRa6adKopClcytMKF8C2pupWOBi9QDxYuCNVA4BqX69pCqud/l84yJOSaNmDAu8iiIQkOAOsxEKh49BboQvaN3bLYtv7vchyP2dMRs82rkmlomBjZtvruXgtmDYD6CZmaOerVOuliTUjQqMukEAwHUPCmv4/lmS0eIrEeXXAw0FpViNiGmjEqczdavGDiHXteoBftRE0Qi030OK1IUA9DnIcZuCbcTque6Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYBn8/GewY2izMW/aSYPsdS6FcoYlWc4rsXTClsONr8=;
 b=vIxB++aU7wkUOK6UOogohTxu2qDkUGCfF6ZGbkUvB1w1ARFv0xQqQAZ9bQv1D5mRneI5WVjjJH6CNbk3P6MN6WU054LklG4ghhHbc5kvXp2ld8mOXiJQ2nu58IOKzAYCm8ZGaUNQhmmuqIIumusgj4989D91gyrSkk65ARyBJGyZJ4CAW3i2KnjLEvRdutPDH+EMMOu2bGR0Y57x4H0lafo1uJ/xAALSKTynHQYOs98r6dqG4tw65NZ9qAGr6sXOJ+bK2TTOMC0L7qbQsVJCT4vSE6TZS6X6O/hVp+2XL45jo44IBDLyYfP/PJc4vZndwx/5+dJrFfnF1dOAh2MH4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYBn8/GewY2izMW/aSYPsdS6FcoYlWc4rsXTClsONr8=;
 b=ZxTwOwHSlF0yXRMitSAMmAyG6pGkZNWSKDnqPu+mn3uCzVSS+4YrZpFaKYAJqNCB1tLvv9TU9pKHaUCynZuLmGSL0e16w0XDU/lrU5e3o/MueM36JibKu1nIlQBwt8TrV6BsX9kpAmZHxo1RlE7ftMWED/e0i0CF3/dIITy3ygNb4F8SEb3W1qrzdOnJROXxzUepSID+1PfiW5+IsXHEVzvL5Z3JBHfpDo2TcVFZxgSq1Dq7Bh89PsQHAv5pdBLDT1YvoFdpSr6AaQ0yczc/W80b4OGj+fvaHOGyvFvA6wdDg0TKsRLc1XyUecbHwCAbWz+1/ScHl0ys4WpecJWfFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB10855.eurprd04.prod.outlook.com (2603:10a6:800:25b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Wed, 17 Sep
 2025 16:38:21 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 16:38:21 +0000
Date: Wed, 17 Sep 2025 12:38:12 -0400
From: Frank Li <Frank.li@nxp.com>
To: Randolph Lin <randolph@andestech.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alex@ghiti.fr,
	aou@eecs.berkeley.edu, palmer@dabbelt.com, paul.walmsley@sifive.com,
	ben717@andestech.com, inochiama@gmail.com,
	thippeswamy.havalige@amd.com, namcao@linutronix.de,
	shradha.t@samsung.com, randolph.sklin@gmail.com,
	tim609@andestech.com
Subject: Re: [PATCH v2 2/5] dt-bindings: Add Andes QiLai PCIe support
Message-ID: <aMrj9K78v4dde/MB@lizhi-Precision-Tower-5810>
References: <20250916100417.3036847-1-randolph@andestech.com>
 <20250916100417.3036847-3-randolph@andestech.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916100417.3036847-3-randolph@andestech.com>
X-ClientProxiedBy: PH2PEPF0000384B.namprd17.prod.outlook.com
 (2603:10b6:518:1::68) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI0PR04MB10855:EE_
X-MS-Office365-Filtering-Correlation-Id: 636e8f34-8176-4167-5706-08ddf6089d63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|52116014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cGNveMBN+f3hW4JurdBdAHaoctNxHSHhP68N2u4ozL9N1a1c+tvw9I2X9k3K?=
 =?us-ascii?Q?7ZeiF5koc9ILyRnnh0uR+glQervL2nAD7S958+ThWJYTTqt3CkZWVUvwinVX?=
 =?us-ascii?Q?K5XkXeZdNWT2GI/isLZri+bGarDuJtsbb1xL5k9opu2ua5+IFvfGjdPJLCOa?=
 =?us-ascii?Q?MvBaHl/LMfiLUWlp5yQsBSWsXjXMWZUI7W3RvEJA20bhSuw9D2WARmHrzelc?=
 =?us-ascii?Q?wl8KSJoZJyswgIOGlqIGdlhR9/JsbQ2khud7fWJlRDZuZnToeOf2oK4JqiIO?=
 =?us-ascii?Q?LoZHdrTr7US/VC6OIY7mjQWAQ460QwlYr3SFuIsyxeE2cAi+EdAHX/BQ8RBu?=
 =?us-ascii?Q?Zmqicy+5GOpCF+k2WCApicVGi2gqYeSNcR6dnTSAkDWHKra8mgH4gMhnACtX?=
 =?us-ascii?Q?DZVqn+PV5miL0PwB6QOxmsgLvNBp2qy71bOXtaPsZpvvBMnSm7sJ3NqqQtdI?=
 =?us-ascii?Q?2Y7CmjV/d0yWQprhKxDKL+q83wRjKQXWDh0/VSw56hzBm11su7tUKv8EHnkJ?=
 =?us-ascii?Q?hytDMpnaXbYDcjDI3MXt3qmxzyJTP+TZVbERipKGO32am+0C3g2RL3FIHyM4?=
 =?us-ascii?Q?y3qFfbzrr1RSanRJXXGoEhngC8cvu42bXeU1A40EH67Rx8c27ETztt0/dnXv?=
 =?us-ascii?Q?WINjy1E2g/kVhN7dW35hU8t2onVxD6vnLzJI+HYP2UvJiBzqyBTIz/NRWRgw?=
 =?us-ascii?Q?VthYF2nwlLUvCicQxAmKoUiQA6KIXFvFS8yRcUG0XgKwoYMXdZpQWFpcV9Cb?=
 =?us-ascii?Q?Uq3BrKb4xJ08Ha6j+FntW6XxQ0D0Vp61V/w6vv/O4pEse3xUCAKkhe64y7rE?=
 =?us-ascii?Q?dCOvkL/Mi/qg0MFNI36/GKfQcNMwTkUvFJgty0ToFc1OstxS111Scs8Rg7mx?=
 =?us-ascii?Q?Ph9STys8dN5mYESpLz7j7PuzRBb960GyQ8NGsZrmv9O0hLGVf0m7qi+3vVrv?=
 =?us-ascii?Q?NjZO+YG7brZnEcclbem6QS3G0Xuk+0CZMYf/3pKTJ9529/ViE7mpSUXWt02j?=
 =?us-ascii?Q?qHrCG8XyA1v8J9AkYxw37/PGOQrXjHW+nGexvTe5SuFD1F+7BzAwgfsAIDTV?=
 =?us-ascii?Q?d/o53f1RYQlhym1LrSpV85qVuJ/G8crhNuQbyOJD+uLvNrFOxOF/gl6ABq3a?=
 =?us-ascii?Q?yTyfkOLeL0LXVHgl4c/PafSDktojiJCxd3p8B44nXV7gQe4k5OSXxq4nJYYo?=
 =?us-ascii?Q?NnOMzga7rvFlTwsk+6r7YwEUjy05Srlz1Y9uLrtY6bzmt94FRN0AQR7No+mA?=
 =?us-ascii?Q?VCht7JyybX3auNVJg3o9ENCzs4Q5idVO40+61NfKmvbrQIuGoZzDLNibEyT5?=
 =?us-ascii?Q?1DUMFaq2iEDGEdRTC88tuwIquNVGdcsP6R/LJirBS5CfEhibRI8gMgmYL7Vv?=
 =?us-ascii?Q?Ed9ehx/Yt0FB6CdWufmtS7sireuyeWbPfkJ8VPBit9VNDwALBZ7++NV1caN1?=
 =?us-ascii?Q?RTw7pKZV/3qtVoP4NGkZLrHmOBsr8Z/W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(52116014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jMbAEgtf5u63R/V1bXO+rwWaYtq48JXw2izMJIE7OXyrkIumZMhWawkMmbrz?=
 =?us-ascii?Q?NsRRbVJlYXJ7OAUMd3r8LRBZ9+dHSIBvBKqD+WQT/JMpFQL3++ft+CBSqh6H?=
 =?us-ascii?Q?WsDKKAUUaw+suFLXdQ9lJVAwM8BE/5qn5M3lL6ZSXIQtFKqCnTs13PjLcyRY?=
 =?us-ascii?Q?EPtHD2tow8SWM8nBTFr8KsV20ROLlNNnjmYhljQdrkHLCwLRlaSOhebUgb6a?=
 =?us-ascii?Q?d1n2AtLyP+bXL/nvNi3v1NcSFFTptCIwZeLKt6vOB61E9DWFUOAxKmH2d8AN?=
 =?us-ascii?Q?Zj2bfWFRQwJG77Vvtv0XpguqeivXI5dI3PlrWIWsxO5eY1AN06w6w8wR+7xA?=
 =?us-ascii?Q?TfGfEAl+lQDSz4tguMsWBM6xaLkr2GhgvJ071Cj5pC8uj+M4evrGFsmsf3E8?=
 =?us-ascii?Q?4+Ixq4iK956CAE/4Cr1InveXIR9dwjmehWfqu76cfFQX7oXYYvj5GOPHmBmQ?=
 =?us-ascii?Q?6JXN/e9Mz4yDnDJvZGEtMm98G6mt47uxmA55umbkwk0Q8UEroY6F2Nmrewe+?=
 =?us-ascii?Q?IlX19EGbnt2cErekc2BfAP2a6TSLueD9CT8sGQ2sIRao9bkS+p12FX1RiE3I?=
 =?us-ascii?Q?hibrngHgebloxprsQ/4XSDN5YCVtZcXYuc024kykKyHi6Jlm/rOH5pnQX3zV?=
 =?us-ascii?Q?8brRwhqF3njUIgIcwLyxtyKnZhR93PvNhO9+0rgQeaW5Nl1Vf7F60RSKzREi?=
 =?us-ascii?Q?PvsGK+Y80dmfJ+nKJa+i9acNgS0ewveBd+4iIK7p3Z4bFtpqzQ4kK4lCDcGZ?=
 =?us-ascii?Q?JzYXbEYUXrENbiRM/rO3WkPWViFi2jdg0DFEWAlc4kDDJfrma8BD2gh0xzPq?=
 =?us-ascii?Q?H6NUl/ljEIoK98nMiFMjfVO2s46eIet3KLc9vRSe+hrb6i8cfGmSCKMmTl+h?=
 =?us-ascii?Q?lEezQJQ4A9TDWdMtJSnUiwAl9LN5lg1Ok3fuDtFL2/+OBUoMhmbS+VFDbL46?=
 =?us-ascii?Q?/1xj8K8n5ypiA8COCY+fmuKfYXYNErHTLOINdKZ3cn8biYIZViYprxgi6nxz?=
 =?us-ascii?Q?jKKGOE0BnPN/6cCE8KsSEWq6TSWhXmHi9Hc9qsmP5ouBL+nY0Al2EhdhuL29?=
 =?us-ascii?Q?6WYhKvN/lkYVzhNamW9tofolwHvVqQpNYQY/OXgzaHWyGXp+0jlXiRlY/NUj?=
 =?us-ascii?Q?RgeEcbIDojefZOBx0A/BtY/uVg6RFVqQ/cLvmaiRvWXx+Jr5bckKwUt5K+TF?=
 =?us-ascii?Q?vnlQUPsXDorR/zDROjlVRYq7byp965IkcvrB+UimMi3u706uvfMkP4kAiXTJ?=
 =?us-ascii?Q?rAYGLsvuJeoR0LQmKga4hXjNFbMJR21K9Z9LTYYRnxgep+JnQfIfm5TqObOy?=
 =?us-ascii?Q?Z0uUbb0TQoO0LYdEpfkYS5hcU9Ue2RB8RlXOEQ1wV+eD25nRfkD7tU7BIAl1?=
 =?us-ascii?Q?w978GmBSCL2eybv+ks4Z96+aQNu1YCJkhdKjTO5MxcaavHBl5Jl8YhLuSfXz?=
 =?us-ascii?Q?Sspi1xsW1GwvGbkf4dterKuA7hKaTYRFUbPFvC8xdC+OrH5DXn7+zm3+bHAd?=
 =?us-ascii?Q?rHnt8qtRMH2ZPWO0tEJGyqsZil2UuNWAUssMhT9aNThwlSh8DBMlwsZDQ2l9?=
 =?us-ascii?Q?3hZCDy5BkVnyVPFPhFP6U2OQIgWSbIABc/DwDKKO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636e8f34-8176-4167-5706-08ddf6089d63
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 16:38:21.8078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 624J7N1doXoQxqD2k9DqGKHDatzV2SRKNB/emDjuKT7YD4mb8SFBiOB6nrAJ/n8jayHC4VX+ORand/5eklwJjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10855

On Tue, Sep 16, 2025 at 06:04:14PM +0800, Randolph Lin wrote:
> Add the Andes QiLai PCIe node, which includes 3 Root Complexes.
> Only one example is required in the DTS bindings YAML file.
>
> Signed-off-by: Randolph Lin <randolph@andestech.com>
> ---
>  .../bindings/pci/andestech,qilai-pcie.yaml    | 102 ++++++++++++++++++
>  1 file changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
>
> diff --git a/Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml b/Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
> new file mode 100644
> index 000000000000..41d3d4eb0026
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
> @@ -0,0 +1,102 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/andestech,qilai-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Andes QiLai PCIe host controller
> +
> +description: |+

Needn't |+

> +  Andes QiLai PCIe host controller is based on the Synopsys DesignWare
> +  PCI core. It shares common features with the PCIe DesignWare core and
> +  inherits common properties defined in
> +  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
> +
> +maintainers:
> +  - Randolph Lin <randolph@andestech.com>
> +
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#

Move after required, in case add if-else in future.

> +
> +properties:
> +  compatible:
> +    const: andestech,qilai-pcie
> +
> +  reg:
> +    items:
> +      - description: Data Bus Interface (DBI) registers.
> +      - description: APB registers.
> +      - description: PCIe configuration space region.
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: apb
> +      - const: config
> +
> +  ranges:
> +    maxItems: 2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#interrupt-cells":
> +    const: 1
> +
> +  interrupt-map: true
> +
> +required:
> +  - reg
> +  - reg-names
> +  - "#interrupt-cells"
> +  - interrupts
> +  - interrupt-names
> +  - interrupt-map-mask
> +  - interrupt-map
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      bus@80000000 {
> +        compatible = "simple-bus";
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        dma-ranges = <0x44 0x00000000 0x04 0x00000000 0x04 0x00000000>;
> +        ranges = <0x00 0x80000000 0x00 0x80000000 0x00 0x20000000>,
> +                 <0x00 0x04000000 0x00 0x04000000 0x00 0x00001000>,
> +                 <0x00 0x00000000 0x20 0x00000000 0x20 0x00000000>;
> +
> +        pci@80000000 {
> +          compatible = "andestech,qilai-pcie";
> +          device_type = "pci";
> +          reg = <0x0 0x80000000 0x0 0x20000000>,
> +                <0x0 0x04000000 0x0 0x00001000>,
> +                <0x0 0x00000000 0x0 0x00010000>;

reg should just after compatible

   compatible
   reg
   reg-name
   ...

Frank
> +          reg-names = "dbi", "apb", "config";
> +
> +          bus-range = <0x0 0xff>;
> +          num-viewport = <4>;
> +          #address-cells = <3>;
> +          #size-cells = <2>;
> +          ranges = <0x02000000 0x00 0x10000000 0x00 0x10000000 0x0 0xf0000000>,
> +                   <0x43000000 0x01 0x00000000 0x01 0x0000000 0x1f 0x00000000>;
> +
> +          #interrupt-cells = <1>;
> +          interrupts = <0xf>;
> +          interrupt-names = "msi";
> +          interrupt-parent = <&plic0>;
> +          interrupt-map-mask = <0 0 0 7>;
> +          interrupt-map = <0 0 0 1 &plic0 0xf IRQ_TYPE_LEVEL_HIGH>,
> +                          <0 0 0 2 &plic0 0xf IRQ_TYPE_LEVEL_HIGH>,
> +                          <0 0 0 3 &plic0 0xf IRQ_TYPE_LEVEL_HIGH>,
> +                          <0 0 0 4 &plic0 0xf IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +      };
> +    };
> --
> 2.34.1
>

