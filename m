Return-Path: <linux-pci+bounces-41686-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D7AC71251
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 22:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EC154E163C
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 21:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6B42FB624;
	Wed, 19 Nov 2025 21:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XVkr1zLF"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010023.outbound.protection.outlook.com [52.101.84.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008EA2F49F1;
	Wed, 19 Nov 2025 21:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763587528; cv=fail; b=IS5cfdzE++5rfNFV7QNmdBt346iaxyGLcZdn3qW/GmFHH+9VVqvcg7IwvaZ+98txLXA9XXWZBLWHfGsyrQ7ODIetfQ4J8ZwzZr3sPn7+bwBdUs4iaQx1rFgnM8D5y3I+pTdFhUFnaZJi7MjaNsFAjcDrpKBSOxut5t8LuMyIg7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763587528; c=relaxed/simple;
	bh=E1Sx+nDTFLsSgUaNPbFeIM6hJPJu6P/FwQI/mWnT2V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HjheULNYXPQbuoGexh9o3Ui3OccWs0yLjFwz4bE1CYPyjs9zt58OWgPmaXImwSGAhrJcxrJSULKD3miXTMd7Nr4OoVYJE/q+rK8W6TCyKudHkgWpmPOxAiQgHwiqASPrIBmOkMOCze3hunccLaatlQ6ipCNhj03Ns/22W+E8c3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XVkr1zLF; arc=fail smtp.client-ip=52.101.84.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJyoNor8zVaRHMGJalqEcOYLt/vqVaj29P7+lS7wg9WUnCrb7A7U4ByNL2mTA2niuj0rXK5UIqDFhaE9NFdNO39d4N3QB/hFoopq0JAduqx0hAJcGHPzQatEgidW8qZPEwC6HuY+9VqxvKYwqVf+1Y5cHdVuWbYfnOkSHvlZR7mrtlZlmQlw6Rk7Pirob/QEfC68LzDs6VsGlVr53LG4wGSCUFVUVyigg81hGuRQeKduOnLmEiPx46H7AGhYRVMJD+29ug3FSfeEehICmBiRmJ1D7ZiWRD6KiU/IYZdmL6o+VwnZEPhksquiqgQwbqJ1Df2IiKAsRauF968FG6wlDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAVZrkuj/1l3xPcnzB30OGl5K6/prumzkh4HGkxPqec=;
 b=O1J4VhMeVxMw5zapWQ1bXNBV+zn5Vhhe6lDKNRKW3MAaFOqfeWp6q7NvIqitSjiW9R8NyP51crgyLPlYP4cs6Wce9FbyUHDVx6PhuKuDFe+RWN4hbuvkwRLJy+KW3nf02iZAphslSlOXJPwWKTotWWlp0Fdto99XMmk0gT6kYJegUxWrnr+IFFsmK5Mqnq+exg7Lqr28lxqSt9zHlcqkVQwXG4uRMALdP+/XdFu74E5r3xdynZ5ut7sH0KoGgeZzhJ0c/8mzB3gKiPzMN1hiUHJr2XPehR3dxIz3avJJdvoqDl8l1fiWHZTRlQmfH2QdnCF+VIekif4fUKBIeP7TRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAVZrkuj/1l3xPcnzB30OGl5K6/prumzkh4HGkxPqec=;
 b=XVkr1zLF5sijBlYqTxmTEsSbVMlzOpcfj6eioLSE65g2oKyQKwN2AHeql7rS9eZcH9E9wpfGVUFE2jj3865x+gZy4xweyjjreFbu/Rm+2Kzj/JRqqteCkFTMBD6MzHFL49l/8LD/9yJTpn22b95Cw1KQ5YPBJq5VMavgQvWXwU8TGuQkAMrlcB0WBewsbLjE9uN1cyvlrFMKc7/MvRtH6F8EykmB6V6R+dvhc57ybDA+vaG4GX3vmdMTonPWkgj4RfKQjVH4Bz9e3ilNWHEkU7odP6Un8u/5mm8iL6gBlfsAkm/4Y1r5SqPf8vDpEWmx8CZxkCibwbbMhMiWLJkxqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by PAXPR04MB8862.eurprd04.prod.outlook.com (2603:10a6:102:20d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 21:25:22 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 21:25:21 +0000
Date: Wed, 19 Nov 2025 16:25:12 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com
Subject: Re: [PATCH 1/2] PCI: dwc: Skip PME_Turn_Off broadcast and L2/L3
 transition during suspend if link is not up
Message-ID: <aR41uNTg4gUdoe/p@lizhi-Precision-Tower-5810>
References: <20251119-pci-dwc-suspend-rework-v1-0-aad104828562@oss.qualcomm.com>
 <20251119-pci-dwc-suspend-rework-v1-1-aad104828562@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-pci-dwc-suspend-rework-v1-1-aad104828562@oss.qualcomm.com>
X-ClientProxiedBy: BY3PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::35) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|PAXPR04MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5d9be5-f035-409b-292f-08de27b22544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|19092799006|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N+6cgX8EQJ2OmUZeVH/YYo2MJsd1iLcSt9Xb3i5HCkE65dS2cQAz8Z44qrGs?=
 =?us-ascii?Q?L/D266QYkINLNtIAOxTw4Wbb0AZXYMZ952Pa9oxWjwAZLJCIdSrQMUQTf/wm?=
 =?us-ascii?Q?75kJNDwhG8eMibRk7kJI0TiqxP11upHTm880UUSc87mNgg7jYq8IYJ4EO/sC?=
 =?us-ascii?Q?i3kPdJqIbIUvD0DygkGpzKn+yp8Y9vaFyXfxOE5GmunPYpkK9ErYQQQUPaq+?=
 =?us-ascii?Q?E4vjqURy+7NuHlatDP6HdMFw9I5T1NDkc7uoqIgGaMwztdSbvs3KSMszIXUU?=
 =?us-ascii?Q?wmy7omkSzpU1tQL41ajima8KfhMyL3aeZgjtEfxceok0BquzDuVvKKIQY5KI?=
 =?us-ascii?Q?l5LLyyfYQ8iUhjVh297cLPucDN3K0baaVemimfj//Ep4KIF30qmwb6jb+Zpv?=
 =?us-ascii?Q?u2y4lCGkJ+1AJwEhuqZGtLyw1Dvt+ktkjyyzfsWY1Al/xqEyehRs4jst5Z7p?=
 =?us-ascii?Q?dssWUCKGd8vZlqFcIL6O+Jxd7R6Pc1R3Boj5OiKl5Pd29sie7RYnAAl/vhwU?=
 =?us-ascii?Q?QMAo1DmnL5LSEPJNg9cvBxT/18PnnA961UgbpyJEncmYymzUxLNIuyVToxEk?=
 =?us-ascii?Q?8lTuQDNONw/e3i2mN6Cg1RBPd6Ai6WsXt/WpCcuPakE+h/9oCe92exkP5wMh?=
 =?us-ascii?Q?OzYsswjhyl1GUGgS9PmNewB8m2NRCu0TT5494MkwYpy/J0B+uePNAt6GXDDP?=
 =?us-ascii?Q?MFEutl4cUw0g000qh3dR2epzjPRR1QBp1ImcaYAwCWcPUpt/4UgCwDhBGXu3?=
 =?us-ascii?Q?vdg7hS7B8RMt5Ocu6Z9S0JrIZG8AtPMmQnNgZZK2vvzDdha/qIk8uDJMi+hS?=
 =?us-ascii?Q?NaEqG2ocRoIiWBQhHlTMQTTFS5db4E5HvR+NzLgfUtcPjVPXanExrjqa9Nm9?=
 =?us-ascii?Q?d+ajdtQ/w7kiFn6Lc9xpfm4dV3CSepocQ8rPjOUm08pV6D1NGjMvuqNHewP1?=
 =?us-ascii?Q?yw/BZchv4d8gq6esmFxuvKngfaItBdCArzi2Y2tKN77QpojYahYMGSY1QYeQ?=
 =?us-ascii?Q?JJdhJSPz5t5h+Gnvm1jBJUqnxjwUt9X4JWFbwOBdaNlrO6fGvksmU4OGUSAI?=
 =?us-ascii?Q?6zS07FTWjdyLPq1tNXpphjLgIDDF5VvZ1vYAzWG4O5cmJso+XCZLebH5uYUQ?=
 =?us-ascii?Q?765VQRjCn6LsEXq7vokmtrPBW4beVaKTah2VRHTxHEQYjVYNm8U+pC4SLeUf?=
 =?us-ascii?Q?O+AGVbAVUwHB2XHrWoJO33ZNiNqU99E5MLHd+KliWBLbATk80nktZUxGUzx5?=
 =?us-ascii?Q?Jp4YPMvEoBDuXnd2cPyub1fjMD0jYR7JMvKvUrLQPcObmbQCW/HgrThdt3nu?=
 =?us-ascii?Q?SZE8LZ+u4euj0CjupH+uWtz8hjhbapTlk6ASTHDSUX8aMZH6U+QFvw4emHod?=
 =?us-ascii?Q?5qumibVkinoF6UBQJ5q7/T2e49PrZrnxg4oqSM2gfYuiPuE/JnQ3qvnC0wJp?=
 =?us-ascii?Q?LcyMJ3r2xv1U/Rx0FpSz8KJ6y608jNIlRXXVOM86nWRMR0dz2NetLFMhbD+q?=
 =?us-ascii?Q?aomJG7tk5WxvU430TJryQSWSatgrhTmMqfJ3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/8MZD/S6IkrEqTXqlmD8qzh+iZl4i76X82ii+Hboo/b363SLM7ymbSYnpstS?=
 =?us-ascii?Q?pHqspuuBPu9OY4HEDSiq2JCF5rMXN8Fmthl+vh2SLapPvuRgIyBAmyN5RwD4?=
 =?us-ascii?Q?vfYrJWYMN1g7pZHjmLfvXh6FlwS8bgFrmUbyAlSdFB4hd8S34+u06iF8niNH?=
 =?us-ascii?Q?9pDsUI247ihKMUeYbHCEC/yZnYB6ny6atrm6tPFbE28D6qdsaxcn1qOh3lzV?=
 =?us-ascii?Q?4KWmbLxHe2xkd28Je+Uqn7huWz9KYCruMqz4NrrFNHvCIXlAzcXAGSJqZjuE?=
 =?us-ascii?Q?8kMDw8eiGfPs9l4g7+AI4K+QAwhCBQg1cdGW68WiHOnYttFK68VHZ07CurHC?=
 =?us-ascii?Q?FiDF4CKstrF/57mRYG98MTRnrebyQ6CzmAjzfzn4vNCk+Pk0uN+MSHXFPQ3Z?=
 =?us-ascii?Q?J2pvob1HQouNKKc5ditIuIQVUMfGeAGDU3uJaNhqipvg7h0qlawl8XBRPuwh?=
 =?us-ascii?Q?mgfAzKA1+XqFWQaMI1mU55rCapxIcdy3k1sXOw77QipGgKcp5GBTKbmdosNJ?=
 =?us-ascii?Q?qsDD6H+KaZ+C+3NeZOV8wwsovDo49Zon4XydpbkwvEQnV88c7pFrzzXpZNpA?=
 =?us-ascii?Q?6w7sGQJwKx3YNgswCyHkB1CCpUCnwVwVXDLt5URaccFiDmqXPzHwB2lh+evY?=
 =?us-ascii?Q?JXGMTYfI5PoHWEpSbyyx1attGzsxdRt27VKIASLo/I7T1LS3/ye7ZsuNsBOi?=
 =?us-ascii?Q?m3bc4Ax0J9C7/crBC4knHQzyIsEhYgjJWlmmxSWYcQrN9OA7P5Kv8EM1kBYm?=
 =?us-ascii?Q?WR6OCWHNtTzLxBz/5j3wLVUFx28fEy9evNUkqyec7VSnrM8YP2F5O4sbGjeb?=
 =?us-ascii?Q?BSbIjObl5I44BmJt3BBAGgOHt1p+791r74iIRMPVkkFwDDsq/QDllscxz14o?=
 =?us-ascii?Q?6t1Sc3gbyhTv11Wf9+RE8v+TDxX/hmA3QwbJv1KPjblhWNAJHGIYU9W7WG/n?=
 =?us-ascii?Q?iKl0jmd8H4jKmoOVfLX8brdrTv7mb7KkO3s/uBpd7VzpQHmTgOzLKG5RFJlH?=
 =?us-ascii?Q?AtGXy/SXHSe9rFsKwFta94+NvbdhlOQbxw7QweEDIMze397IBm80YXDcFbhE?=
 =?us-ascii?Q?RLCcyY5FUysWJQt0/8o9F2idEBLugDF2ni9LFHH6GiGMIXVX0FPQpII96h5w?=
 =?us-ascii?Q?iZu3TSsoERL86Ou+AZGDlVn2+2iqgIUui2uquxwT6N/krRG7lpa04XU/pIZ8?=
 =?us-ascii?Q?tdkm2+zOc4YJ4Ne9PeSjvDwqCr+TKvpg0xBt6FuZEAyvpI5V9ovhl8EN7ZdE?=
 =?us-ascii?Q?AUXWGThKgk1//8D3G/9Bgsm0/Ea7GuDAC8Xuxxoc78k5kWhG2tzRs68N+bld?=
 =?us-ascii?Q?Z+5u2+YTi1yn4rQbrW9rlW29cSVmAxa1bY4cBRRNMrpvEsJ/0VM2Ig8cGzMe?=
 =?us-ascii?Q?F7WaZcPBVR2VPKi3t/TMtU8pySWpgEc3laTWED4ArB1FE4Q3iF4fWhqZmi/Q?=
 =?us-ascii?Q?5Mp0vKELawZx+QKeF++pBkYQNbsgzXiUeuaBJs6g0GYodCWHWGxGGB3VEEpV?=
 =?us-ascii?Q?MPwsDcelbs1+6Rf1yMZgoBFF+FuaUC6U0CJZQ0WYtbfvaqqzRUzSNIYfMtP8?=
 =?us-ascii?Q?CrlOD9gZsomUSQPjHa0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5d9be5-f035-409b-292f-08de27b22544
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 21:25:21.8494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PR1ZRa5P4E2Ctq4nny5dAAqGD4rKvxTt6pHBTbJsoSs6t1HZfi2g1gJDvqJShPJQn7gRp0BtUw+0f/Yk2+XIvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8862

On Wed, Nov 19, 2025 at 11:40:07PM +0530, Manivannan Sadhasivam wrote:
> During system suspend, if the PCIe link is not up, then there is no need
> to broadcast PME_Turn_Off message and wait for L2/L3 transition. So skip
> them.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/controller/dwc/pcie-designware-host.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 20c9333bcb1c..8fe3454f3b13 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1129,6 +1129,9 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  	u32 val;
>  	int ret;
>
> +	if (!dw_pcie_link_up(pci))
> +		goto stop_link;
> +
>  	/*
>  	 * If L1SS is supported, then do not put the link into L2 as some
>  	 * devices such as NVMe expect low resume latency.
> @@ -1162,6 +1165,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  	 */
>  	udelay(1);
>
> +stop_link:
>  	dw_pcie_stop_link(pci);
>  	if (pci->pp.ops->deinit)
>  		pci->pp.ops->deinit(&pci->pp);
>
> --
> 2.48.1
>

