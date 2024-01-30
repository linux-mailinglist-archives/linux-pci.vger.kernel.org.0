Return-Path: <linux-pci+bounces-2837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9756C842D4D
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 20:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF22289452
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 19:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597FA7B3D5;
	Tue, 30 Jan 2024 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ozmfoTzX"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA0126AFC
	for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 19:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644214; cv=fail; b=KK6pCYB84QtOQmNcXakSpiMT3HBGARncLhaQGMRiM9tss51Y3t60L3GWzpz9rgrZKESVv7SeZwbcRBlZm1r5Zn2oA9Iv/CDHwmTkMxVJCIVaTikBZPTB3aDk/4j9B/oNZyDXzoBUrdCZflN+Ng9Cq1BNkTyx+Khm+qwfl2w4ESI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644214; c=relaxed/simple;
	bh=s1mKxbiEviSqQ/lIiKjusEy4Wf+kZkMkv5x5pLaAOM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a0r4WGgpt/dq7SalAN1rQAqdrpG/lUKsprgKE1m91ZH0DhJCT0XmWVc3mqaJxF4ya0VeIMUtHX0iG9J0qR6FFb7CjbeetJSVT+okGT3kjFUPQ309tvrfUQMPhiWmEHn0gLhP/CpT0xUzOAWRBcWH+gjwYW+azZ5PR90I4JVAU74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ozmfoTzX; arc=fail smtp.client-ip=40.107.105.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcAQvNwOdr4lYZOIoNjLOnGc/p6Zka8mwo8wKb/DIKzdvJtNRLJExxHlOACj35oglb+Chj5UJyhWxhAyNqoYFWsiR0FiFT6l71MVzbpiS/K9WmBgjO5MYshuhHATkp3VXVop3Yfu9mcsyJJ2m3W6Ej0IpDqTJRqoYYBrX8UsMEDTp/14j3V3Z7Go9ToyYEWEJvCi8VztQkxG+Iomx7wrz2SCu0Ftr4yEPhIka76QNoOnKoxCAW6jAi/J4fvQqgMmLkBWBBKAYjV48qwJK1zHAwrOU3cQmEiXT/bApFYBfttGA2jwthLm1vSL5yLWMeQTHa4HOG3lpf/vzOKRF8vwdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyEHkv0HR6Nc2ND1jBsYLPyGEFGrG1vDI8yUPk7yIvA=;
 b=KUWjo7SSLFOzv5YsEY4+cNaN4S863eX7N2ps+4VHpHbi74yGG5KGlBcM0YcrXmadDD3NTxckvtD1IqrnpN5ww83PfmnCmaky5aHWpXWoNg/9NbOfE6m71t5H8KlEF42A8Z0itkOn1u7evkznB2kCI6lcWUwM/OAki8F8C8mKt5QuqrZVOJOgloMo1fkmFXnK1axd1gGEWbDOXjHX7/adew6PgAmhyYaRGjLbulQD0o8d08ZP62Vww8Sv9uRNgFX14rCmVCvUiPUjw1A04ehlvNsXcNaizTPGAWH3bx7J3RLv9Up8noMef+j72h8NDqVXQD7fJO1UvYFcfZDlbCQAOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyEHkv0HR6Nc2ND1jBsYLPyGEFGrG1vDI8yUPk7yIvA=;
 b=ozmfoTzXUoXgEdRWO6iIJ6HHpuu6s4cUOKbIsctMQupsZDAw/3TNGcX6P3g2VtaeHtvPwdaDpRc6wAJFEh7FybIG1D1KBYBq1YDJMFT4sXXnR+KhOBT8o4Tyvv5Fm1aiz9YqVKAhZyrjIXlGWATSVwvDX4nvlFHekqBAgBzgz5k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8171.eurprd04.prod.outlook.com (2603:10a6:10:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 19:50:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 19:50:09 +0000
Date: Tue, 30 Jan 2024 14:50:02 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: endpoint: improve pci_epf_alloc_space()
Message-ID: <ZblS6lJmT4iqkgJn@lizhi-Precision-Tower-5810>
References: <20240130193214.713739-1-cassel@kernel.org>
 <20240130193214.713739-3-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130193214.713739-3-cassel@kernel.org>
X-ClientProxiedBy: SJ0PR13CA0228.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8171:EE_
X-MS-Office365-Filtering-Correlation-Id: 220803e6-9066-4cc4-124b-08dc21ccaa18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XZTyIn/pGBK9Nc5Gehd35jNdAfs3iKHmZFZhNy9RxBpZGypy8buNT+YS10B3jtvTJbwH8oPsTTg06uYvzbZjqeTn/vMKFompNhHBX3PN+IA3fXPdU2DYmlcugayNhRqCZkOa6LhPWTpKqE+R9ANpUujfnGtwhVk1usfazpiKm+EesYvkxqw8glXCT49zwE/ztkUBNcZQmqhlMDcIX9E0vYBq/NN0SB2dzN/q1dqJjUMktcEi2OXWVhj6eNAkVcqxzvAORgSiBKvPr0Iu5ZJsbYsu8DjVDWVdIzBYY7v72B7nqKuO7ucdNi++pTvcc3HQkqV9mV3+La8g0PkJMLqJ4MPtsG7v8sViOW+WZZzomVwoVHuTY5jq8RdbNN3TiTAJ/lmGjJLfdOsRuXboZfj+dwBxcEmHsGSSn+21fZWB6V98ud6Qah9cLAs5rhlCiOQRnr+UX1Os30fNP8U+cPH85T7QQzr0iCsa5ETd3/zkbUTbodBdGaz0VBgMaS2pL/rHKIcma6ESYcIOc2ehaG0bbz08pVxe/zY5nQZx2zctC6DCd/iisSqWdAvZKeV4pgLNAuOdhAOa5lqhdgMEDNURBgGh8dfNXYgILwxx6/ee9zs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(346002)(136003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(66556008)(6916009)(66946007)(54906003)(66476007)(316002)(966005)(6486002)(478600001)(41300700001)(5660300002)(86362001)(38350700005)(2906002)(33716001)(8936002)(8676002)(4326008)(38100700002)(26005)(9686003)(6512007)(83380400001)(6506007)(6666004)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zPjzrtyyLWxIQavsuubwAgaMNWH3xyPz2MJrhcZp1j0PJHamWNII37wODFfZ?=
 =?us-ascii?Q?ySfBvBsHjXD4Lpnwv+FNsm/cJU4YL5L3xvuRAd6E0XUC7X79SHIMH1Yu/ttE?=
 =?us-ascii?Q?zWeHGUmu+Xly2pgCuOeMM+A9v8UJdbndHmjqmGHEWnIoN5ID+a6Id+L4q7FM?=
 =?us-ascii?Q?5ST+pXX3sAUglG8ALtDYpXCA1TvlX8dWsWiOqZzFq8M5Zngf0ubCB20Px45x?=
 =?us-ascii?Q?JHDh9sxlF4uqr4uhTv441kRvEpF/UFEo+Jx5s1z8pdYAUc/XQQ8saWfD8TBf?=
 =?us-ascii?Q?XOePaIrG+xF9dsAVrRha7vJSiVxeAlay9AvUEyJSBP6XhrUBgY/Fit7ONKOg?=
 =?us-ascii?Q?53qyj8wJF1sHUNdEtrve5idR3txShD583SjyjfQsVjKAYALfscXjNfTR4Kbq?=
 =?us-ascii?Q?/Bc6pkUnRiJn14kxopRusMshb/AmGGhypWmCR5aAjiQl28TSzkjyNRl/6BWN?=
 =?us-ascii?Q?Z7iaAxoKlZZcb0HHK9vAYZCSoFGgbku9fTC50Uw5dHdGKUSLIuCygZCRGtiF?=
 =?us-ascii?Q?BmoiCvj8OdmYnU/liLvRPyggb2Ry4DMhYJNNIBPJACi9EIg0JU8Uc+ymBum1?=
 =?us-ascii?Q?OETtaQifgxLfjjWc6tmkuXZFKgghtIjs3vT4IVyaLTeg9UdPsVF+043KQeGM?=
 =?us-ascii?Q?7ZMzSXzaA456kXUZu28xmuqnsxabm18+KRDaiPKK49oaUutQHebaoqSwlMjn?=
 =?us-ascii?Q?RGuv3lvd2qdpnLLocWlLe2WJDjmLgCnqS9Ve39VIWFkJU+Uhwt84kd5prp5z?=
 =?us-ascii?Q?3UmFXGfRvrdEvEmzdMCuf8o/mcJQpYtwFoz44UT4F0pSPNbwdyR3+csFxJW+?=
 =?us-ascii?Q?C3hsxvZWI4lcNK9w5FmtH/oaLKEhjqHAnd5leO8n4xopM/YCl45S9jr2Lgtq?=
 =?us-ascii?Q?Y/DGVsKtn7jiiLwaiumwcFiigUOqkJNQNHHsdxcdqDJUcQZWIC0ixs9uzfTl?=
 =?us-ascii?Q?wGpo8+/4dDygGqxa39PLEtsm3sSYbJTuuBqP25Rwto7R5OAc82uhnxCKcFxy?=
 =?us-ascii?Q?tnqB3Vjt3CT90fhOFSlxVG1R41EtXAHbRiTu7yEW2wLz45TIyMHzLhJFqUf8?=
 =?us-ascii?Q?o5RH421nZlbhyHxLCzYu64y/DiItvYD94TmpcGa9gu1QY+grhPJOM7GWrt0U?=
 =?us-ascii?Q?RZoA+kqb3n/7KNPCXO+4l/nOO6QtOwr+zEicndfC33ZtJ/ojvyfNAzSyY9R8?=
 =?us-ascii?Q?TB05YRY1YE8aQkPancGC2dL0UdXpmAUzXapLUlvDb1Lmsj3Jtp1qSCuh15nX?=
 =?us-ascii?Q?TJ/bNQ2yxznUoUKTTfeg/wN5VVDYHQQeHMPO9CmnBV6rIhGqnYydG7DlD2Ky?=
 =?us-ascii?Q?CkoDVIlQfuBw4NFpYqgXj/e+IKa35Owg3OQucPWUXmAzMMe0a9udsmlADr3Y?=
 =?us-ascii?Q?fcttSXzPGiiAI8Y21+X1dPMFHpq5+AoVrXwE+Tpw6E1KaabHbQmCk+WX+PJS?=
 =?us-ascii?Q?sNbFgLczhZvd+VC5qgSuSE2DFdPuLpDYsaEUDWpBQRW5Kv8Z/axsLm03uBir?=
 =?us-ascii?Q?9wneiY0YPdUk+VAQg7q8z/oAzoJkiWuuse5uPUn0p1WBrLmkRJuA1YdVdZzv?=
 =?us-ascii?Q?DvJZ3E0P4awO8CoctkCrzZDPfXb9PCTQ0indWsW9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 220803e6-9066-4cc4-124b-08dc21ccaa18
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 19:50:09.1557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Ja0ruixqW4/4+YV+XcaGZqqr1x2R7Bx6u5ejqmTZgQYMM/X7LGpJY2DoX6TKdWy+2SOdG2C/K4WWwSVgOaqcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8171

On Tue, Jan 30, 2024 at 08:32:10PM +0100, Niklas Cassel wrote:
> pci_epf_alloc_space() already performs checks on the requested BAR size,
> and will allocate and set epf_bar->size to a size higher than the
> requested BAR size if some constraint deems it necessary.
> 
> However, other than pci_epf_alloc_space() performing these roundups,
> there are checks and roundups in two different places in pci-epf-test.c.
> 
> And further checks are proposed to other endpoint function drivers, see:
> https://lore.kernel.org/linux-pci/20240108151015.2030469-1-Frank.Li@nxp.com/
> 
> Having these checks spread out at different places in the EPF driver
> (and potentially in multiple EPF drivers) is not maintainable and makes
> the code hard to follow.
> 
> Since pci_epf_alloc_space() already performs roundups, move the checks and
> roundups performed by pci-epf-test.c to pci_epf_alloc_space().
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c |  8 --------
>  drivers/pci/endpoint/pci-epf-core.c           | 10 +++++++++-
>  2 files changed, 9 insertions(+), 9 deletions(-)

Suggest split to two patches. One change epf-core, the other one clean
up epf-test, or you can combine epf-vntb to it, which clean up checking
code.

Frank
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 15bfa7d83489..981894e40681 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -841,12 +841,6 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>  	}
>  	test_reg_size = test_reg_bar_size + msix_table_size + pba_size;
>  
> -	if (epc_features->bar_fixed_size[test_reg_bar]) {
> -		if (test_reg_size > bar_size[test_reg_bar])
> -			return -ENOMEM;
> -		test_reg_size = bar_size[test_reg_bar];
> -	}
> -
>  	base = pci_epf_alloc_space(epf, test_reg_size, test_reg_bar,
>  				   epc_features, PRIMARY_INTERFACE);
>  	if (!base) {
> @@ -888,8 +882,6 @@ static void pci_epf_configure_bar(struct pci_epf *epf,
>  		bar_fixed_64bit = !!(epc_features->bar_fixed_64bit & (1 << i));
>  		if (bar_fixed_64bit)
>  			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
> -		if (epc_features->bar_fixed_size[i])
> -			bar_size[i] = epc_features->bar_fixed_size[i];
>  	}
>  }
>  
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index e44f4078fe8b..37d9651d2026 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -260,6 +260,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  			  const struct pci_epc_features *epc_features,
>  			  enum pci_epc_interface_type type)
>  {
> +	u64 bar_fixed_size = epc_features->bar_fixed_size[bar];
>  	size_t align = epc_features->align;
>  	struct pci_epf_bar *epf_bar;
>  	dma_addr_t phys_addr;
> @@ -270,7 +271,14 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  	if (size < 128)
>  		size = 128;
>  
> -	if (align)
> +	if (bar_fixed_size && size > bar_fixed_size) {
> +		dev_err(dev, "requested BAR size is larger than fixed size\n");
> +		return NULL;
> +	}
> +
> +	if (bar_fixed_size)
> +		size = bar_fixed_size;
> +	else if (align)
>  		size = ALIGN(size, align);
>  	else
>  		size = roundup_pow_of_two(size);
> -- 
> 2.43.0
> 

