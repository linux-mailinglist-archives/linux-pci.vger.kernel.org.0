Return-Path: <linux-pci+bounces-20100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 368EDA15EF6
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 22:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47161165DF8
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 21:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B918C17C7CA;
	Sat, 18 Jan 2025 21:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iUfBO9Sx"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2065.outbound.protection.outlook.com [40.107.103.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB951632E6;
	Sat, 18 Jan 2025 21:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737236751; cv=fail; b=K2DnWbPhV/0AHS0/vd3qJzmYmY0y+Wo8Wzz+HOTZbOC3BkdKPLO3P4tPyv8O14OgLVcv2R8gXfTA2fzEIItOHZeELZd+FTQ894jD0JWrh+hOgqAweFcssfXQmXRtodf8NwwUxQ+45M1Getnch55EK/GT6bYmtP0JC7qbqS1B+WM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737236751; c=relaxed/simple;
	bh=WuConc1usnc2Npu7VfCv6vYcs2Ori99w/Me3xw9sQyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fc546JSq/ASNx/cUYEEXdqSBJ2EsxJcmQAuegXih7j5cyEfnfWN4EjdvfVLFC02ivPwDyZC6sxB+XcFxKfRvCGN3gk1jGTwcZXtQrjYuZDujj9GXql3MHbYgOqLNWimikW9qC+tWn5HIaMaBtURu1C9JHDRvhTTrWR8yEcVlfg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iUfBO9Sx; arc=fail smtp.client-ip=40.107.103.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBsaIBv7VUlsM7PtYFK80+s2QfwWhp9S1tNfOy9QCNMVRGQrYGQWtfVf8cuNJIA+t1v3DZ8MNioTiEtTYc9AFLnaSZNGhERWh4LnACUIwVzUW8l1Hnu65MaWTk8djH8qOVeds0MXtSrepuAK74iqavG3zS+u7EH61ZO/Fmx1KvbfKEbdV4Xld1v84JX8H/rPaccHoqq49HR3Uv+kX2ZqVkJam2Gh5hIpo5oF3nhVpBS7Hj6Eq8inL3ovsVag262BaWCWfGqQPevi4iIdI+es0dvfG6xuw682bvm4p68P+O3Hhe1cnbxaeBkXrIKIVtpvgH4akhKJqI/r6QppqF+SHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpPC1yvwHAZqessSPl68kI0LXX3QvoGQzyVzIAewl+E=;
 b=FYvyVa+2x1giGZ2pY+n7ZnxKmotTjmk3MKDDDgX2+omuCCZ73w9H16L4uJ48Hz+VsHqZdpz5LW6DjrHv46Uhm6lf6eby2I5ZW6LmZx3TI9QFz+KfZ2/iKOUBMb+a06OWPlC2XHg1HgSebWu4hMw9KOAU5ktOhoQOAlEZMAFNc/MAiY1twwIxksXPmV3eL3ouWEKf2dwX8B+8h6id0fn9QXdg3kZsYcXQqqJL1yxywow0r2vfNynIK5G+tnU6zFGx8NiN4RpwxjrklBOBLZ4fJTXjjhBXVNipdvJPjtzcgRExljp7pb5MmUSQCHykxKi4xxbuTRfziSeUdFPeI3T1lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpPC1yvwHAZqessSPl68kI0LXX3QvoGQzyVzIAewl+E=;
 b=iUfBO9SxQ/zNF4pQCUewx3VkUtJ0kLQFZ/LxrdUOO4MxEURmrToHsbHDkIHACpj5mJT0PfqJ2vkOI54/CTjfrsjq75tufClvvgz9+dgbPCvx3/petkON7RfDwN3QFLM49vXPJdgMO5UmN5rC39+OUyxApuOMvErtq2WtS2GuoStc6oTHEvx/4ixyHE1q/sWMuJtDdgGlE2WEa1b2jFmmKMKRuh5Fcgb0pVeE2KMVRAp+5ix+J28CXHPh7rK79y39/nt3XkvyDwXC99ELMAHVhaU28a9KlLxh/IXllFJ67E8w5scPtwXDKAaNuxamJUHnWg05bVd3bLLFD5Jxu+d77w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8509.eurprd04.prod.outlook.com (2603:10a6:102:210::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Sat, 18 Jan
 2025 21:45:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8356.014; Sat, 18 Jan 2025
 21:45:46 +0000
Date: Sat, 18 Jan 2025 16:45:37 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: dwc: Simplify config resource lookup
Message-ID: <Z4whAeajxo04DhGr@lizhi-Precision-Tower-5810>
References: <20250117235119.712043-1-helgaas@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117235119.712043-1-helgaas@kernel.org>
X-ClientProxiedBy: BYAPR08CA0043.namprd08.prod.outlook.com
 (2603:10b6:a03:117::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8509:EE_
X-MS-Office365-Filtering-Correlation-Id: ba336f8f-05ec-484d-db2d-08dd3809770f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ow4iIdy7iTPnDmhyLrDiGR8T4BbhV9NUSUjkc4g625yBu01/mBgU/RYYrh4t?=
 =?us-ascii?Q?imVp+q5trNPKo+m8SkMl9JDgOM20/Tv5X2tdQD4cK2ONOz5YctZ1HxSCSUPT?=
 =?us-ascii?Q?BGrS89KgUn1Uh399+nQLXxZalwsREV6WLhq4trHh3FaeP7Y1gbZV6AaMEF6u?=
 =?us-ascii?Q?Mw8I7Mt4Iz6kKgy7DG+vFXN9G0fP0DZFZGoV3zS6spYmNiYWJiQfd7rIGp+I?=
 =?us-ascii?Q?DnHDpft6BpVUbXTI86f8f9O/7f9S6b/TPz2GVxEwltDuc+y1YDxgtzrpa5Z0?=
 =?us-ascii?Q?hakS3KzpkqCrGpm88RYronFc3kVh3Q1bpXO7H8KW+spTlA8R8a0Xd1J80Niq?=
 =?us-ascii?Q?Gkwkf6titQBPH6KYVjEPs0w1bpg6xV2FamU6A2Rp8FDXRErYD3C6tTshByh4?=
 =?us-ascii?Q?k/YFLxhXVZzEJh1Tm1xPObLaE+jFjkXvVqhCb5o1LpbbGpjC7Aia0A3MMnUK?=
 =?us-ascii?Q?9S3ReLIz4SzygyrY9r8Hbxtd/r94jbRab8IBCvP1auYUMkMVBiy2giLK1jUs?=
 =?us-ascii?Q?LvZFNyDC0SOEX2cFFbtDXiW3UwAvsvmoSdGPqPwKg1o1lvtr5+4/o6uwii6z?=
 =?us-ascii?Q?AceB9ypQntSiIeXiV02vxg/0zPe5NWQlZe0GuWXRqJcmwRbVBrFqozMMfWvx?=
 =?us-ascii?Q?/vexBCEFEAUZjsrwEjMkOsN7gZkdmL5e+HrURzWuhRdnbL1brkbJJgLd9QYz?=
 =?us-ascii?Q?ZmRlaHKeA3O9d5B9fvJ7hpaekfNGpwwGhOx+RUGZedDMvfPrQ7FUp+cqgSxC?=
 =?us-ascii?Q?cj0lZFXK4cf7CbwCNzYDTT1kmfe1R9ltZz4LlO6c2wS5MG2MgaijpSb4R7cz?=
 =?us-ascii?Q?3jjk+67gmoTfWI62bD6Yff2vPRr0//hE1Z4UsoTAOjVpKzxPQ2uVMMIvLnq4?=
 =?us-ascii?Q?uy5F2UXATBTP75s/GOqD+IRArJ8DA57mCcbP4mJa0RGMOfjCiseKPPX19AII?=
 =?us-ascii?Q?0AbWRpP/8ShaZVEQ9sTF5SYuqDs94ndiYHSncxA89U9ENH069IH7ucOe4Qz+?=
 =?us-ascii?Q?3gIAQ7QhHsBytjWTU/s+ft0tRFTVYcLnADba2GXE1xWGZEVeVZaqamn3Fm8f?=
 =?us-ascii?Q?zeii30aDk5eoXkVGhN1VjvjZUdfl6+jnCqB04C+UryrpMRlfXi3vtLWLiKvR?=
 =?us-ascii?Q?Yfwx8VwSzOVoWKfe7uUhXhl4J0R1Zd3higJBnHgRlMXPlP9GOwlYrxlI+PQ3?=
 =?us-ascii?Q?lXyCJKYN9XJf/qeP5B3H69W47L9+c0PGJDYdqTUuHbwVYr7fXzU8V46dBND7?=
 =?us-ascii?Q?ygAMR/6FTaPBj7mBwkTi4egOYbHRgzfKchNkATROa4bYgJTuHBmiBpR/fbTZ?=
 =?us-ascii?Q?QcVhJdfLF3ggCDtQC0cRxMXzyk21ESwKRaiGWRujNRvNOxS2qeWA4i9nlqwH?=
 =?us-ascii?Q?F06o3YKY7pStiqJvLLQgCsMz20INIWF4FkcmLMSkG9Rmd8Y2tBOWb8OYl4ke?=
 =?us-ascii?Q?ZM7h5d7XViGAD6c9Ais4iv192xBaK8ko?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yRSTjyhliXILT4eKdfBFakow2wZClhFiNpPhb0pXl7qVN8El78cFaTZGvknR?=
 =?us-ascii?Q?YbzvMzhgJgPV3ePf8sN461y10ybo/C10zIsHqlMQb/KBgN2l3uQiqpAoRICx?=
 =?us-ascii?Q?1OjKCSkfpW5FIT2QYflMDdSI724qXF8GpIZkuva8oOp9s5aG4SS6ubAw2TQE?=
 =?us-ascii?Q?42woMEJWPOoBk99o4HhEl/fHARXSEU+PPEaTZi+jG1TIdqP9DSiCpsfuBzGH?=
 =?us-ascii?Q?nnDVw727r3XGu04qCl/jwTOFvH4kOFfEhOBDnqPHmRutE5/x6QHXkZ47kRXy?=
 =?us-ascii?Q?Y60hH731bvXccY+g/kcnPdu+N4hpc3OEip5craG+157ah5bg9Ni05JvOCJvJ?=
 =?us-ascii?Q?r98fRyMrNaU1YKw4EwrWIqBCMkqzynGv0x3//ZN3N6kqlUS3H05Qqxcgevty?=
 =?us-ascii?Q?tCTj02KyYkV8pWNZ+txybLwSp3Xu1ir0+AeJzoR3dQZ69TjPvk06hofUvIDE?=
 =?us-ascii?Q?YZADaG/u+kbd4g2qrm8+/m5IXHUhDe4VadcRWZFS3BL0cTUCkYUTwuHTSN+e?=
 =?us-ascii?Q?MUnEYR6f6mwzW4pg+RJ+AEgb3rf4GUZGG4VXkdM77pph1MnuEyQDkSGT/fUj?=
 =?us-ascii?Q?hdv3+kEPqE6zLo76fK/MshXATSQaopDcKrX8RHj8BHbvZ/NWgLeXjY7wxfGM?=
 =?us-ascii?Q?w7ONHZAJc0DG4gindnZ71kmOf7VOrGML78W0JL3718FMvInaAFtmrawU5F7Q?=
 =?us-ascii?Q?qbMro71o6GPCrSsKU/jZxkRYTOZxUyvWaq9s3t0jaFndpYkpPQHeM/hmPMzz?=
 =?us-ascii?Q?PBbL0VtY+cxnSS/9VrQVEYHjOpDHS/JgmxbfLste1voyIEf4O+bX3T6ryOth?=
 =?us-ascii?Q?n6IVsurO4m+nkRtVC7ItqqwQqTmmRjfYwXgZxYgYQZRGQAnU5WtkhdoKFbvH?=
 =?us-ascii?Q?/61LZrSAVmjhzU+VNSdD1lYSJhNUCwbD8tltIvWVgPkgvw5anFBqSyqKeUhm?=
 =?us-ascii?Q?srNfOhvCmcW1VTPqb7UuU49vvt+WE0fnXoNQOEQocwJ7y/ZbVVzVoP9eeG7F?=
 =?us-ascii?Q?OfPTuXyBOnMyxpfWD2hoLi6e6OJ1JLohBGaRCAj0S9Zx+iBlMv7boY/NGmBU?=
 =?us-ascii?Q?Zv/4JoTQdiHznFeovgg1E6vpkEVzwzw2jBuNf2Q4ku4J0yUYB/iYcXOoONcw?=
 =?us-ascii?Q?0BBTcbFBnlktHy+QlltA9x1jliF/9mOEfoweENQJljBS7bb2prAUmp7g/z+a?=
 =?us-ascii?Q?eUVC4yXKX6NW7d+9nslmWtgdiyvQrw1cMj6ZezS6hgvEcA4KWxq7xw7s5XN3?=
 =?us-ascii?Q?L+diDvOVLPj5ZI5iEtkQSDXEfsX0RME8Gyql80hSorKAeuqcg1RaCoxVXMWb?=
 =?us-ascii?Q?WGJr4XBnMHJySFOOXJcFJ2xcXntc5oUJwH5BmIpxQ1zGK1v4TberbJHArjiX?=
 =?us-ascii?Q?L7hshiF3xPF8HKti4baRPSohhS0Eh7ClRAj5GwjVudgMPxQhhFJuMg4/RlRt?=
 =?us-ascii?Q?Pet8hM6lFKE+PyqEf7KHN3Q8DSb0WbLPEMJvomhIjXzusyW/NFbCrCPlIyPD?=
 =?us-ascii?Q?aHoBJhcYvGQZBEgpq8ioDqJhCyAzkZsolFcrWBxlmVNQ/t7ekAGdb0hZ7imW?=
 =?us-ascii?Q?9642dFqxgmhjS4svaig=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba336f8f-05ec-484d-db2d-08dd3809770f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2025 21:45:46.1031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85GimmezLtIylCH9amvj/GYgqCf3Fdi5E8UL2g24e8H0+uTdUn3iLpqtDUimUpmZIFnfEyNEOMIcB+eV0aVOew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8509

On Fri, Jan 17, 2025 at 05:51:19PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> If platform_get_resource_byname("config") fails, return error immediately
> and unindent the normal path.  No functional change intended.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  .../pci/controller/dwc/pcie-designware-host.c    | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index e42a74108f0f..3fca55751dca 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -436,18 +436,18 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  		return ret;
>
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
> -	if (res) {
> -		pp->cfg0_size = resource_size(res);
> -		pp->cfg0_base = res->start;
> -
> -		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
> -		if (IS_ERR(pp->va_cfg0_base))
> -			return PTR_ERR(pp->va_cfg0_base);
> -	} else {
> +	if (!res) {
>  		dev_err(dev, "Missing *config* reg space\n");
>  		return -ENODEV;
>  	}
>
> +	pp->cfg0_size = resource_size(res);
> +	pp->cfg0_base = res->start;
> +
> +	pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
> +	if (IS_ERR(pp->va_cfg0_base))
> +		return PTR_ERR(pp->va_cfg0_base);
> +
>  	bridge = devm_pci_alloc_host_bridge(dev, 0);
>  	if (!bridge)
>  		return -ENOMEM;
> --
> 2.34.1
>

