Return-Path: <linux-pci+bounces-12379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEF7962FF9
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 20:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CF5B1C24BA3
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 18:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118FD1A7AE8;
	Wed, 28 Aug 2024 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JrupxumO"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A786156997;
	Wed, 28 Aug 2024 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869826; cv=fail; b=LFYTayN8R1+vMRRfR+Fl9Ua+59b75+84lTH/F/30CS6CtwO64Fw22fu0Xj28vUWni+G1ihXw+eGGaxwm7bMQGmnF/vs0iMC92FHNI5pUvvNrN6pBw0zgKHeQdd4mt7/N3GRgiZA4aJ57Eufzbmiz+R2YrQy67gK5ipR9VHUXFG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869826; c=relaxed/simple;
	bh=kgAMQnfGhIrARmWopNs1yCTF6YuLJbusgfz8W8qORNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eU78dGbdiGr0VDpMkggoRet77Mp4GqOFH7MQmZy/LopW+MqlK2wN8ApDnbi0ACZTvHdKTdSbuaho8zO8WgwNnP1E9jk2JEBrT3v6olKqpp0+wMtI9Y09vYr9RMlNiRBOe+aZLWL+BVLuzTduci1BXg0njQiiWFEvwqrYpO+AekA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JrupxumO; arc=fail smtp.client-ip=52.101.66.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEiRMZV3KEW8/Nmmvh1T1qtf3gmDT+aXaZtLfIOkRscT1vHa9Sti+s/wd7moCEQ/B6w+H2VSx90NTle1ksvu6gWWsY54ww5gFevfEUsvW2QznZlcGSMZ7Glb3TrOiEkt/F+a88iccHxtLXLQAsDVFYk1k52fUmzy64VaRct9EiPFzEb9gnehz8DMGl2RCnO3+HGGCmPXYKYqVLla3fxNyXPa2Ye/3mXdvSNbo92KT8AnFSdt1/wiqxdS/pqidsFXgZvtHPL73GHTpD2wDBtd7VsGhsgfK4EAU3CshpbwhX9a2y8aY0tjP9u2C0wsg1R13QIF2rANz9C2KywliGEBWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtTX7ZeUWon3ysxxLnLMj9HAA+ZQa1VvMs1V3MlR+4A=;
 b=FJppQbGux5Zp0t87RtMTpGKodk7HEuJ1XxH7hxPlLD5JVtY1uyAF2GU3WA5BVkhvj8wwboZzcTl4CY2IbqKFIy8d3YN1CMkTWWiX7Zvd6WCDDUPrpJBSTICHd0fNm1VBEEO1jVzC47xutl4lEAZDWTW1PP6np6/dGI/LUPGmNN/ZHFnugMwBm7IgEFzwO0yjWrdbbdk1DH7zH8j1P7q1tUHmHvqbIjYeEWTliX+u6n1Y0H9beTXaRr80/9CxmiQpQtiH8H94E/UGy5kWNi6prRn8TOEE1HWxZWev/HA9N8t5XhVj1TCuGaOX4FyGweOE+SUgkT/vSuve41owF5vCBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtTX7ZeUWon3ysxxLnLMj9HAA+ZQa1VvMs1V3MlR+4A=;
 b=JrupxumOjex7loUZtMYFQygakWa9tp2qLRFO3rVD4FQs29bp24QrbhnszwMZtdGvZ8bS9yLsEtniGaGrA2pHqXRSQ86++O90tdMAf8DjfrReDWMEaqyoO4w+AX6GlAagogkqz5LZOvxChqPpGIyb4cfSATYMH0JvkpMeYOtu/Kf5Ski43VlaNaDGQ1yhrqW5gN2ZtDPXlRQ6ULcPl4EgtCrFdlzSAu/FwW0WU5gw41CqpjW6qN4+yt+gpou1HAQQ0TG5A2TadXWxej6NOferVsCveINPJBVC5wYjpb5MHN6JXoFcMC+fY2U28Taozr5qe2+2fE42IL59FvYShWO3SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7957.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 18:30:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 18:30:21 +0000
Date: Wed, 28 Aug 2024 14:30:13 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 05/12] PCI: endpoint: Assign PCI domain number for
 endpoint controllers
Message-ID: <Zs9stQDfpUcpIxt9@lizhi-Precision-Tower-5810>
References: <20240828-pci-qcom-hotplug-v4-0-263a385fbbcb@linaro.org>
 <20240828-pci-qcom-hotplug-v4-5-263a385fbbcb@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828-pci-qcom-hotplug-v4-5-263a385fbbcb@linaro.org>
X-ClientProxiedBy: SJ0PR13CA0179.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: 40462fe7-b546-4e8d-271c-08dcc78f79c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mu3Ci3dwTTa/x7CJuv4ELo4zDnI4X6EG40gBfbkzQzEs8bmBxsPPDfBYzOxP?=
 =?us-ascii?Q?65oOLvmEknV26kFwwzr+7MKG8UonXtStkRHMX6+2VCYfRFlAAd5PBJg1yBXf?=
 =?us-ascii?Q?tOEY/5iPjZB8vbwRA17CVj1zKx9UG18f1+OZ0EuvrWcTyJ0VnEzwGzNuyWOv?=
 =?us-ascii?Q?f+dizbkTpUgedbAbTW5sLE1KtiYL3X5jsnZeQnffidAZ8UZayIzokbTLoZJi?=
 =?us-ascii?Q?03Fzt+ydCoj+0QlMlXl1sS8GnTSTCpnbAXOUzmdU1EcazpQ9B7Lq1BmivRCG?=
 =?us-ascii?Q?CLdqMftkH8544buM2jHWTmLqex+E1MH86ni7BwoN4xBf03jkK/XONjggFj/W?=
 =?us-ascii?Q?WJCivbYYPOu3sdFReV4o9D2g//d+HZuKLWW9E5gvHTdlZvOrWJLc/s1iXFWi?=
 =?us-ascii?Q?Sc2VSJVNxRSSrbvXwOlt4YIUasi+Zt619EWaDklxJAXj0ni8Qm657mddRcV4?=
 =?us-ascii?Q?dkl8WRHqZKG2hg9gTbQb/k5xLL9lpk0WvTiFR4wKqVm6MKGxwDluN0TD/6xe?=
 =?us-ascii?Q?KjMoQO9FnUfhtaoyoy1UWFDjYJciZtsym0xZkeiy3/ElJA40dI3V4Zcl5iNq?=
 =?us-ascii?Q?txHsnZOe8zrDBabNa5x4zHq3EepDzdz4FrYJiKPiNxKUgxbtXIrA2GiVoWNq?=
 =?us-ascii?Q?e5ZIzK3gGcEMJMH+lLZ1VcYToyf0DHqX3nqcOT9e3ulOyixtUda7ZKp+CSDa?=
 =?us-ascii?Q?cBIJ7lubr68Lpdv1yXiXk90pKW1UFl6hj7JNdovJTPyTtktj43jdwXWsVkuK?=
 =?us-ascii?Q?SRAoCaImzbBSLvmABYkK0koOS/XOJTB0Q1cwuqrhx7pvJswzBMn+lOxYcdZU?=
 =?us-ascii?Q?5GCkVbOY+ISIMEZklTaRyAG1u32+0hiX40vapWNWwS//UL/mfmEHXXK9Z9Mh?=
 =?us-ascii?Q?8knDar9M8n5bOMPugYIWUciWm+CEwAtz0KXMOPZsA21kurFUjFWc5dlCrjxM?=
 =?us-ascii?Q?d6CIWy81l8FQv4xxxhW+ceghQKPcfaLzn9KpbTFNXB0AvAAIHoTSN0VruzFL?=
 =?us-ascii?Q?/amuCU+L5dAEpnkTGpCMrata2cMBzjtOnufDy7LlOrn2VfG3nzr01z3v/npr?=
 =?us-ascii?Q?7q3ceS+sGImDyf6LpzrFIayWAR4t62ykZb/9+Fg7CKSWXBoBQvNSpfaQaS8U?=
 =?us-ascii?Q?WP/dCY2nUYX/s6iUoV9Bw0f3fF0JPdTT2BT80f73AyE5xw3ksmYopmL37ZQ5?=
 =?us-ascii?Q?Elihfh0+XNMY4HkyQB5fklZVn5bvMMxOmN5aJrku1dLxdfMMtJ2LOagM+MfK?=
 =?us-ascii?Q?8kM1/D7pedHcf168HUMFGdaC2mtluS+lUxuvN5JZ3rMwKBkBFQuAb2Qkv8J8?=
 =?us-ascii?Q?q2gOJNUe35Rvcw/wrekxt6I/NiTxFzQ7i/IFYMJ6XRap1Guw+s8B5pYm4qse?=
 =?us-ascii?Q?L5Rt05PMBIWc/IvlBUfzkDBmzpwCU3kwi6SSvSlGom2ycexaFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P9+22/hNLooBLom4KRPzrhncPbkqHShNqM+Ym9zk/Jeh3SlDD1d31x9q/byG?=
 =?us-ascii?Q?x6ImEBJlyeBgYfbscQugs3g3aj67mU15LOKQX7nqT8GOxfomuYZ73etVxdO2?=
 =?us-ascii?Q?AOnZNvQpN2oBtwzKi5Z4M3GU81vn2v49NTZLM9IuktlVhVfZrOm4du6CL0zw?=
 =?us-ascii?Q?ID0n/XPObHepGhYslJb/pVjCizO3R2b3EvzpzkYX2zW0WHWxrttcnEPksK7N?=
 =?us-ascii?Q?NjigYmRly2Tz4AAwMR9ZnaH92qSoYJieWU2zSx+j5xyELgaCJqi/jg8SepdC?=
 =?us-ascii?Q?7BrhcMqi3nGaF0PzaQCdKPTudsdX7BFq8ZBINpCPMge+JvXk9Y8hg9vFUeDS?=
 =?us-ascii?Q?GO7DUKfSr2G5pCKp5pUGER7Kp76TcqQjf8AkkJCCrIRsVP94IvXbsAb6oAWq?=
 =?us-ascii?Q?dVnxge0r0WuXFCqkOrhHswLxcQw+CC6VI3cWkOMb0dO60NU4zrR1N+lfVeoH?=
 =?us-ascii?Q?tB/jxQVA1W8F711bf807GeTQe6FoL5EnZmmhHjAJFuRP+gvKy2zo0Det1LcU?=
 =?us-ascii?Q?fDj2ZiS7CaDIJifA9kpMpK3/wb3rLpvcIp1tkqZe9wLpWCxzkb7RtKL+J6sq?=
 =?us-ascii?Q?g8gayHXOzwpj3TdGhoG7xwjbUoUZYJj9swLaeTZsBxlgp/SXx5SGp0ytBU1D?=
 =?us-ascii?Q?OJPBDUOMgivN8EsGAct49+NQg5IyAnDObFuaCEj60QJLMMCYoLiWR/RvCWja?=
 =?us-ascii?Q?pEmQoma0qcY0CnQL0hEEzJLj1ILpzqmr4bx/Qq1PiiasplT1AUemS/Fpt2Er?=
 =?us-ascii?Q?cb45GIlgyMjPTdQQ9QloWlO5zNpqbdeZCa4Uu4wIngMdPidwziOcMb8sAA7B?=
 =?us-ascii?Q?U5fK5Cxnz1zvm+fxdbiNFzp/SJq0SW8UpiLq04YTQhabhAwRx4zvKrMYQzdD?=
 =?us-ascii?Q?g8rpYSjx4EK/zSiwX+XMQxThGfAI9sBhLchZQYV/+R7h7AjyOnKFsOFI+uSy?=
 =?us-ascii?Q?QontwNjqHziknNn6oxGCxjD3uW5zSKU0XcaZdaB3Zifs2hO++ENUvuRSRFBo?=
 =?us-ascii?Q?E4/85F+4tkgN4VdtVbO6DaI7odQTYwxZuFoDCuOOxHOQJglIJYeMTTJk5Rhf?=
 =?us-ascii?Q?0tiM5Fl+2KwDKK+72fOj2PSsX5s80cXP92M/ohnFtKY/Q+13T36Pr+XEX0YF?=
 =?us-ascii?Q?mAaoonxY5axuUoAA4OV7J99h7CS4H20d1JYYez3LZAvIMlwBNJv9bR0nvoT+?=
 =?us-ascii?Q?aNnINIyL6WYdB+EPA8F5bu0dQiT4rcrsIIK9jIRmStQD/UcZFlQ5Z/kBOspy?=
 =?us-ascii?Q?aqxXreV18b4akEY67D3gWqnRANfVpQpGTP18cnfq5vzfGBn5vZafd232K4Z5?=
 =?us-ascii?Q?3QlZvpkv1KIjtSDHvU/DIa7fMIzKwOi9dtMRu085M8vV1PNNdnQTWifkIVKk?=
 =?us-ascii?Q?H/4ByDqMrO0JuiiqsQiyJsXHfVk/whiboQ1nyYzzmWHFJJT7+xgO+kEKlw7f?=
 =?us-ascii?Q?SQUyMc3CzsDxTLmBsO5rDTTd2dxPduGcWQATMonA/nbDu+SfvzEl00pjspAn?=
 =?us-ascii?Q?CeGS+XYQnRTun9baEvsnC08JTAp4jJ/3iCojOpkI3aqPLST4jMCsSKmWgqaj?=
 =?us-ascii?Q?+9QwpDYhQCy1neko6wODRbURY15C5OTjFJlxRvxY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40462fe7-b546-4e8d-271c-08dcc78f79c4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 18:30:21.8650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1K1t7SCs14y7fTHRgy7xAJypJ1a0o8Ni2yzynJGWRSPVVMD/hVwArcHPDcM0BFehaRs32s+Z5tJmHBvCrdieg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7957

On Wed, Aug 28, 2024 at 09:16:15PM +0530, Manivannan Sadhasivam wrote:
> Right now, PCI endpoint subsystem doesn't assign PCI domain number for the
> PCI endpoint controllers. But this domain number could be useful to the EPC
> drivers to uniquely identify each controller based on the hardware instance
> when there are multiple ones present in an SoC (even multiple RC/EP).
>
> So let's make use of the existing pci_bus_find_domain_nr() API to allocate
> domain numbers based on either Devicetree (linux,pci-domain) property or
> dynamic domain number allocation scheme.
>
> It should be noted that the domain number allocated by this API will be
> based on both RC and EP controllers in a SoC. If the 'linux,pci-domain' DT
> property is present, then the domain number represents the actual hardware
> instance of the PCI endpoint controller. If not, then the domain number
> will be allocated based on the PCI EP/RC controller probe order.
>
> If the architecture doesn't support CONFIG_PCI_DOMAINS_GENERIC (rare), then
> currently a warning is thrown to indicate that the architecture specific
> implementation is needed.
>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/endpoint/pci-epc-core.c | 14 ++++++++++++++
>  include/linux/pci-epc.h             |  2 ++
>  2 files changed, 16 insertions(+)
>
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 84309dfe0c68..085a2de8b923 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -838,6 +838,10 @@ void pci_epc_destroy(struct pci_epc *epc)
>  {
>  	pci_ep_cfs_remove_epc_group(epc->group);
>  	device_unregister(&epc->dev);
> +
> +#ifdef CONFIG_PCI_DOMAINS_GENERIC
> +	pci_bus_release_domain_nr(NULL, &epc->dev);
> +#endif
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_destroy);
>
> @@ -900,6 +904,16 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
>  	epc->dev.release = pci_epc_release;
>  	epc->ops = ops;
>
> +#ifdef CONFIG_PCI_DOMAINS_GENERIC
> +	epc->domain_nr = pci_bus_find_domain_nr(NULL, dev);
> +#else
> +	/*
> +	 * TODO: If the architecture doesn't support generic PCI
> +	 * domains, then a custom implementation has to be used.
> +	 */
> +	WARN_ONCE(1, "This architecture doesn't support generic PCI domains\n");
> +#endif
> +
>  	ret = dev_set_name(&epc->dev, "%s", dev_name(dev));
>  	if (ret)
>  		goto put_dev;
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 85bdf2adb760..8e3dcac55dcd 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -128,6 +128,7 @@ struct pci_epc_mem {
>   * @group: configfs group representing the PCI EPC device
>   * @lock: mutex to protect pci_epc ops
>   * @function_num_map: bitmap to manage physical function number
> + * @domain_nr: PCI domain number of the endpoint controller
>   * @init_complete: flag to indicate whether the EPC initialization is complete
>   *                 or not
>   */
> @@ -145,6 +146,7 @@ struct pci_epc {
>  	/* mutex to protect against concurrent access of EP controller */
>  	struct mutex			lock;
>  	unsigned long			function_num_map;
> +	int				domain_nr;
>  	bool				init_complete;
>  };
>
>
> --
> 2.25.1
>

