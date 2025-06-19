Return-Path: <linux-pci+bounces-30146-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 849EDADFC68
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 06:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382373B9D0C
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 04:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70053085D4;
	Thu, 19 Jun 2025 04:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aGhIc77S"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010017.outbound.protection.outlook.com [52.101.69.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9250323AB85;
	Thu, 19 Jun 2025 04:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750307374; cv=fail; b=s+dd6Qre38vg3cR6zjRtDbszUfmfGRSeo66ToJFpWv74qtybfFSoS1vn9s4e5gb2knZnbJzbl/y2W0bMujPDDq6SPi3N+9vVCoxtz4sv8fDxlMERG2anDT2Odx+1HlaLIXJJ/MfzoUQc10S+h0fBdM/Q7KvkdgIHmXa1eAMq2z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750307374; c=relaxed/simple;
	bh=2i9Qc2nUDrOZekjL4CONKmEU7VdAVsyFYl8UxRnSWdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jr9ZeUPbsCA/l5giGk3UpidJo9flCrg6mG0pndd/Z12Epg7HB9BkLDQwi2KeameESVjERge3VunOran0Vai9Xl50b++oAK21ihVn9DC1AbDwhI3VoVKNK2eQILvHjTxu/PoYj6jMK/28cyHumKAamMnLcOi8GcXfAl/3yr6TRyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aGhIc77S; arc=fail smtp.client-ip=52.101.69.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvcqRyu4SVzCKRlilKN0KZxpSha6y9PmOPayUOLSFifV1HN32HWpIIh5PiLgaQoOZplKW6eWInVIYAFdtF1kRJSiEVI1sfphdXMFCA6ngYaPEDaVmOcXDJh/oKHw/620yjDl88j6DmTodONUt6FkpdXQ2RDZ7SpNul0/DFVgVbA9fatEd2op2+qsgD6yqXFKBgltulsD8UMhLwsWEkLNEGsYdkHC5nC04li3hwkBsEV37nHDrQSBUtaCDOMbVYbulGiXXgO3TG/Mj+O0Z9AwpvBCPx26XBQCna9s23OVq3vchu7/uopyyByRpf0c3kqhtMyJoxarlxFtB5I3rPDtdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBB1ePBRSnnNcWe695EHahAEUNtqDVKmJ7SlI9zUBr8=;
 b=W75W1Vgh4Ibpl3z2nPOOjGpnG8cePW0NebTFjsx3UX9Dp5cWYpWYKWLjmR7Y2CcQEa06DmrJsTyxr6gebkITZzGU5ZffnLcFu0GlbUX3TDikU7N0I//qe7gQZjA3mFmBmt0aq1L1IONPd5WdMy1TxLKeuJezVBy0JWPDuQ+/oKldt7hJL6ICeA39a7hYBiH4u+Z/lG20T3i5MfvCbmqfjZnwfvQ+kvBKy2OHrcMFNrEUj7kPxrIRAH6a4L66+2WO0f/Eg4O3xJjZGrytBKRB16Q8JY0B1vY6YcfX0bAUpH5W4PC8ui9aVf7SYaoUANfT2GyesZHJrimPYI0jf36+Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBB1ePBRSnnNcWe695EHahAEUNtqDVKmJ7SlI9zUBr8=;
 b=aGhIc77S/VJwtoPEMzUiUcyArMvPQSbEN7XVwG6ko0Zb8r2DOn/kuooUcTgDWr9MB89KwsauH8AOfnoxNAkHBobkE52ZEk1M29BO6HC7QFfwWq6EOPWgHOLU4APJ8oxqeMJqYBMR+A3S4Uw1xFUYXdS8tqdv5yOews73X42NcvdETXYwR0vYr7UitZZ/tezZ4N/vz5uhPQkx+EvdWdax+LiaH4HIJLasJgJ+UmBI28b/v5e1ZR79Kf+X8NeT8nE6twdjBcmrZzGFcCy4m+0wN/XTBAntYOqFnxCMh4dQFwfMeRTpXdBh9WhrSOsq7op4pDofBCnz6fYHk/dAQNKC4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10202.eurprd04.prod.outlook.com (2603:10a6:150:1c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 04:29:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 04:29:29 +0000
Date: Thu, 19 Jun 2025 00:29:22 -0400
From: Frank Li <Frank.li@nxp.com>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, mani@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, jingoohan1@gmail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/13] PCI: dwc: Add dw_pcie_clear_and_set_dword() for
 register bit manipulation
Message-ID: <aFOSIj1fimMwWCT7@lizhi-Precision-Tower-5810>
References: <20250618152112.1010147-1-18255117159@163.com>
 <20250618152112.1010147-2-18255117159@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618152112.1010147-2-18255117159@163.com>
X-ClientProxiedBy: PH8PR21CA0005.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10202:EE_
X-MS-Office365-Filtering-Correlation-Id: 552f57bb-59c6-4398-910a-08ddaee9e143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lHSdV5+c61nOut9XFePy7CsQZouAsPxp+6VGdbAl/EtR975N8ta6Ghe3eMVi?=
 =?us-ascii?Q?T+A1QxTqrLWzRCY7AMqxvsOW+sBTjTML+zfnYR96fyZgn5Dh9LYfD0a2feJ2?=
 =?us-ascii?Q?Hr6NEzXkKqbHpq93y/Md+b3boxa7Vbn0OttFlYInQpBnNiIBAIUIPWJTvaQh?=
 =?us-ascii?Q?dtkPy0mErKYp9ptq4CrirhmMHcbctHW/8ek12zuGhhofhQKh8pszOtWQ7PNc?=
 =?us-ascii?Q?/fA9Cp4ms223B6K9JGOtFkfXUzph+SyMqX5Dk44oXY1ziE/IFtYck54bZBQu?=
 =?us-ascii?Q?5vUj81CiTBJcyj/YqUNA39d/To4QR1xgQfCrLE3wLd0T6hwahUy0RxtZrZ6h?=
 =?us-ascii?Q?c/SiCEKVJcri4D0uV5/WhI0AbX1rpLDIesRt3+flJGYY2A/dNjzXkPuIgNjR?=
 =?us-ascii?Q?HGSp7b4nCgJsmYmF9VIBR/kBqBacuiRAwFlhTwtxTY6KG28vqbj1O2HQqSg/?=
 =?us-ascii?Q?uPGn4ebe6ZBZsHT68IT5PppsUBSsh2Ajuuofc2eaDO3FNp9anK8HxRU1haW4?=
 =?us-ascii?Q?RGnsvW23KCADMqnQ1fN6LbKqLcZYVQO7McKjvGchrS78EzYixHn2jdSHHkTz?=
 =?us-ascii?Q?nIcYggI6h9IdOutIdMcquHW1booBehC4XPZh1FjlPnhOKr/dxGRGA0psnqhI?=
 =?us-ascii?Q?61vJey1ecrn0yqO0AKdUFHELpWbYsB6Yvub36+9hX6Scp9zNXc4UsjMIawqu?=
 =?us-ascii?Q?sIw6CQ9pPkxzjNdrlyrtXAQYQeLMIjDHx5I5ASEgDBvqigTG/u5fS7btm/x0?=
 =?us-ascii?Q?Zyl68I9aT1kM1wz/2eccEtdSZU/lAMPkb+z3ANMCI2+EugQyIcBjIO2wuTL+?=
 =?us-ascii?Q?t/EXfnb7CZ+NlPM1ld7NJE+TeRtN7kpWsN/I4VlXl/vNJfqY2Dx3VaYU6UXD?=
 =?us-ascii?Q?RcKD4UuBcR+PDVQ7kREYJ9dCVhKbmPq6uR+85b54UJ/6/6CuLDMXjxE+GpF/?=
 =?us-ascii?Q?+HgSE0TPkOrW8+W4EJJPdjV9wr6h7oUgjZdXSv4HaO7rjX0DzG/2Aziz5Myv?=
 =?us-ascii?Q?x+nTaLZKLVfQ7LFxl7hS7ZXyHAYH8+BT3jmy+KEBo+9+66lwS73qM4ri4uxm?=
 =?us-ascii?Q?gxyllehb+0/rljUHmRXLrZ5gkIh1VEVzb11hGUdW3F+cj7CoDQDkhPiEHJXG?=
 =?us-ascii?Q?/m7k4KZ55EUoSWcZp3Rcic93Ykq1clVgIM5gdYp8UVXHH697hXdAo49WimO2?=
 =?us-ascii?Q?YaipmEn2F6tqtB+SY2V3ySY/n9xxTd7fzzhxdMu8vQuFZiWAPAF/18TX4tgU?=
 =?us-ascii?Q?vZw/Y8mGnlYxmEKoCJQywt9wl810aczOdqwts7hP9/9pNsG0sCwCxgyxTg3g?=
 =?us-ascii?Q?0PeeyL0sWKc/FxnaXxdJW3hOiBae6C24xLHDlVQf5gZ0YJU8FQSDAwGwZbUV?=
 =?us-ascii?Q?GBSj2wUPMM1WOxGOBpVsybxzOA1UPnj76yVzyf1WxUP4OlM3ikVYnhliLe6N?=
 =?us-ascii?Q?y7y6swp8Tso2eX+TEJhF7lP+H2U9MKpYGbCsGkd6R4gn2jsXmVJjGhg5Gem2?=
 =?us-ascii?Q?z716/BtQRF5NW0M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rqS7qOdfJwXSkyq2MefCmODh16DgkCkZwXcLH+mFsrxrYoYYWJySKPDcgQPi?=
 =?us-ascii?Q?6MbiQ/rn6LLGtzxoU41/OfWYcfqtgGiqCfXzegM5Pd0b8s4Vr8GOO9vuFY0u?=
 =?us-ascii?Q?P9jqwB/bdaj4xX4hKTZlgrwnOEyjcOAcbezIazAro9q7N3Uvx0exzsV05cr0?=
 =?us-ascii?Q?qDInMSwJD0rB2aofWYuUr6Q09Jri2SDwt500CnH0zo5pTY04GL/H4SI5/mo3?=
 =?us-ascii?Q?D3DKP9W3G1Jqq5S1hEUc0qlschcEjQL7v4u+4KVq9KPZZncAffrKq6etbET4?=
 =?us-ascii?Q?c/p6oM3r5IBt9oZkNB0xcfxWnatXhRKTxF/ErS3hyzUGVS82N/ZQJLf1XcJw?=
 =?us-ascii?Q?f2+wyt0H2yGdG0EfohOjMpeECBZkdfvWVrmPctfWllmS+ZnL0z+OPcbwJKab?=
 =?us-ascii?Q?u0npTADtjO3jUmHXKLE4G2mCQZiHjQ3bkpWj/zbV0lN5353w5YiQUt1d+6T+?=
 =?us-ascii?Q?S+8fMQtdCqsVNnrPWQnVr+tZewRRH/kHY0oyyZgIJWlvEpRlgtgBrN5RGl2z?=
 =?us-ascii?Q?RvWKC2pmTnB78gtCUKSUKnKLbSSnv290ZC5oZoqq2K3lehKQ2iO0uivJb0cQ?=
 =?us-ascii?Q?GsLLSu2dGlqFNwceVfTJ0nHG9tOzOclTFMAEUPoAymkuFq+lLSriu/PDIAJA?=
 =?us-ascii?Q?sFYOBPfsnZNggCieoOBXGaRGABpbb5+G9+D+fP+TMXXAAKCeAXpUh6mB71Hq?=
 =?us-ascii?Q?9yFqpZyjJTl6PB1Gs+CisNOWScxm3M3wiCT/+4rRubmcTjXoBsuYs/pBccXa?=
 =?us-ascii?Q?QsC8CleHopgF0R6yTUmSNbyjk9/cvgBQDXvcy7uR0Xr/ise9xdEA+liZawpj?=
 =?us-ascii?Q?2KLNt1d/158f36Vl5er0Ml2gMSmj6Z7LLQnlpEIGCrhAmlJWQlt9NPQ9MJz0?=
 =?us-ascii?Q?csfq4moFBLlP4gR014F1QDg96+EmNFlAFW16uZewClyRGiqJ+uqOkonXr880?=
 =?us-ascii?Q?rDd0Pk3RPvnXF28BF4AeR1KjSKoonWbUsEi/C7hSY3OgZA2dC+73WwXNace3?=
 =?us-ascii?Q?MkgOxQFls8DuiX1+UYCo9ZCJPjBFGDGl6y2c0SpgoBT8UBO5xHbuikYs6tnP?=
 =?us-ascii?Q?6VOq0RZQQnQI6Zu0wtIywAAE2da79HQH8s1zrnriNfsNWBKV72v1TU6TSlRt?=
 =?us-ascii?Q?kn+Gl4nF17ql0cnrsNK0koVGwrue1cbjvjHQNYyUeiq/hjzYt9mipuG12tau?=
 =?us-ascii?Q?mCo1vMvRaJr9IIQ5ET8lfY1G8x2ZahZhGvrr+XRZTv7TJHCr5WKtOD+4GSFr?=
 =?us-ascii?Q?a5j5BOGITzWyJPXNgeytDoqX/E7yWaKCcwcAg8MoifbCHc44wOtdDKAtQgJ7?=
 =?us-ascii?Q?BLpbcT45T5SF+zoggbaqB4jir9QyfAjP96MbLVSya175p6npsYSsyG2yqAAL?=
 =?us-ascii?Q?v0LHl5MZym0mdsN4mew/siGRFDHgw69RSeAEOAQnhuwO+HP6kJFMCnV8qqQY?=
 =?us-ascii?Q?NjHZJFtDrdAsjWjjENvo4zCktlwAq1l1InY9xLcxjvd4x68gU6NVPGRHYVwq?=
 =?us-ascii?Q?c5WH0Y9Tf6gyWv0aiN/M/34cSgeWHA5z4RkTOLyTqdcFAcRwopOnTl9Uh81L?=
 =?us-ascii?Q?p+17hYr+s+e/N/NqutI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552f57bb-59c6-4398-910a-08ddaee9e143
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 04:29:28.9508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGMlBHR8mnEHQvhasbn/dmSvpp1HyeJPP28YB2Su0o54hyud2S6gDgwZTCrBasd0vJH2gUpHov+/i7L56iMc5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10202

On Wed, Jun 18, 2025 at 11:21:00PM +0800, Hans Zhang wrote:
> DesignWare PCIe controller drivers implement register bit manipulation
> through explicit read-modify-write sequences. These patterns appear
> repeatedly across multiple drivers with minor variations, creating
> code duplication and maintenance overhead.
>
> Implement dw_pcie_clear_and_set_dword() helper to encapsulate atomic
> register modification. The function reads the current register value,
> clears specified bits, sets new bits, and writes back the result in
> a single operation. This abstraction hides bitwise manipulation details
> while ensuring consistent behavior across all usage sites.
>
> Centralizing this logic reduces future maintenance effort when modifying
> register access patterns and minimizes the risk of implementation
> divergence between drivers.
>
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index ce9e18554e42..f401c144df0f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -707,6 +707,17 @@ static inline void dw_pcie_ep_writel_dbi2(struct dw_pcie_ep *ep, u8 func_no,
>  	dw_pcie_ep_write_dbi2(ep, func_no, reg, 0x4, val);
>  }
>
> +static inline void dw_pcie_clear_and_set_dword(struct dw_pcie *pci, int pos,
> +					       u32 clear, u32 set)

Can align with regmap_update_bits() argumnet?

dw_pcie_update_dbi_bits()?

Frank

> +{
> +	u32 val;
> +
> +	val = dw_pcie_readl_dbi(pci, pos);
> +	val &= ~clear;
> +	val |= set;
> +	dw_pcie_writel_dbi(pci, pos, val);
> +}
> +
>  static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci)
>  {
>  	u32 reg;
> --
> 2.25.1
>

