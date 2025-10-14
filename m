Return-Path: <linux-pci+bounces-38093-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0729ABDB9CD
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 00:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D921C4E8D41
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 22:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E3B30CD86;
	Tue, 14 Oct 2025 22:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eAdjgHH7"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010013.outbound.protection.outlook.com [52.101.69.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D440E1E3DED;
	Tue, 14 Oct 2025 22:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760480470; cv=fail; b=uqsrCzyEw2ion5q4j1D9KKeCHZmUhnLww+d0XON1CQAVqv5HhhXAU+o41aciApF7+y+7oUXX+uUvVdEXfwDvaiMxqeiujO2/bYbWvt/P07KPj4C+zcr05z9rc/OPRX0Zdqr7EJeLdIaX9V8Yhfhs15dtm7oXCNtfZne2vXbZd/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760480470; c=relaxed/simple;
	bh=xX3MSy4ILFeMoDJ4QPS0CWlDvwqoQ7P7aG07ULoTY7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jmep9lKltiGltz0rTfCKhvsUbuzLn+ORghRbQsR3Qy1LizFZUjVN0chfhkp+h1yr1V35ryRNCAXplaOG7mI9Q3LsUKyOIsZmqgNcZ36XAXgHZLDl4VIZQg2eZswIbH0yLCbUQCErqhOVhy6FhMlkBe0YQBNfjRccDsSTCnNGdUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eAdjgHH7; arc=fail smtp.client-ip=52.101.69.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MjuQLQj1PgDoxXnZ79Gg1QckleLvXXMSUpCQyWBagfza6vVJMwwTkrk58H5bAQhdejTFovzuO+Z7VeNq2IQwP1Wt8gpZgJSZVdT4CMPb4jffVqzlImugzL4b2wcCHxwpm1EXbueyF5mZB3CaO4voPWBYWqm0YTwP+fmAMp81YTd6AFmf5MvxE/j8/2ncfF8s9HGDwG0esGAW6GkdNvNmpGB4SjVXmXM/WPl4HFFFkhCECrIUA/usOdiynk22CN34Xp6a9S2WWrLU5CC9uNx6xGWu41LwrzSdb5V09vy69etaVJGwmfaGZFVsdRxZZnW9FB2XzvKLJB/N/s3wrL353g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3yCRcO1O/Fc/3+wF+IU7bzNlu2Y3ZbOjG+Dpc8/xLY=;
 b=qWPtNXqYbM7sMJxj9IMcnTILoduOI0ojoBfENCmJTx3qIsMG18eNH/zyrMIFIeC4dSpzYCcMCOt/a1gZc18lPJ+K0W5CSmUxt0p8Pmcaax4p+5rfsv/zPBpWzQxFSO2QgIi0t6JcMa1Ha9WmP73WqzGUAIZT51CMtdnULolON2I4/nymPqB99hrfOUOFHMzYfXseJtsCai1VYkrIFXS9nQqQ6wW5eviiXkIbvN7CL1Sm37OV5nEpfTMufBSCseG1SpHISaV/iD+dLfQhjlPUjM+erpQHQMmRhe4BAVL8OhfhVgoDTni1vG2kvHLyz6XhonBhejTikVqzmptQKfDFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3yCRcO1O/Fc/3+wF+IU7bzNlu2Y3ZbOjG+Dpc8/xLY=;
 b=eAdjgHH7JQejPXymFUhSyv1uM27XJbLL4MRYwGijX7e/VPA8YltdFOZtJGPEfcE74rnueDayZ3r1/KXkfRV8EF4VgReegEUbue4w9SW/z+LJ6htp87dQ6SKWLzYwGI2dpt6+VHm6ZNwuh1iSQ+VHdtmuuEFdToFXN5yMKVOZmiMLSvUwXmMfM9AGMnH1Q1uvuPiB4ST5/U40QHi2hXil4uJ6pciQp+aRdVqiiddbHgRF275Ak3fEXB+Op0rMfuQFsM/iQcklJhDP9ZssAIfdc5dAg0PVfztxuxpax0sOsjqchk6Qqd4zOyr9GQag5an3g1jT3aLRE2gqEXdkCx2cIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB9045.eurprd04.prod.outlook.com (2603:10a6:20b:440::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Tue, 14 Oct
 2025 22:21:03 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 22:21:03 +0000
Date: Tue, 14 Oct 2025 18:20:55 -0400
From: Frank Li <Frank.li@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Scott Branden <sbranden@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 2/4] of/irq: Fix OF node refcount in
 of_msi_get_domain()
Message-ID: <aO7Mx11tWFbDX8u1@lizhi-Precision-Tower-5810>
References: <20251014095845.1310624-1-lpieralisi@kernel.org>
 <20251014095845.1310624-3-lpieralisi@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014095845.1310624-3-lpieralisi@kernel.org>
X-ClientProxiedBy: PH8PR21CA0017.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::17) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB9045:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b43d9e3-ad5a-4573-e710-08de0b6ff5ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|7416014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BTjcchDBJElvehx7SYHeov+U8udcwEQ+/kZWp5bbNM+hCEkqPshGcIpGh5Wl?=
 =?us-ascii?Q?W8CHrqLQSrybp9OFpyFnT750LHAg/nh2N33nNwmr4CJztU90JlN1PqdsEajn?=
 =?us-ascii?Q?5YHWcvEtbd4YSW7EriiHQAVYJ86UV9Z1ZKx9ZnhxXTweBPOe/SNKCGm4QS8Z?=
 =?us-ascii?Q?Pwfltnweq/5AIoV5fkSciKcwWL7GIoR6uQtfFKhy9/Xzmlq0B/lkD1eDkQmA?=
 =?us-ascii?Q?PPfg1dq9gD3/IrgXlQSGUAehEkA9SiKPyPkICh0xMLSe4jVRe2+iomZMlg0w?=
 =?us-ascii?Q?iUOGDNwoyOol1lWApo+Zq0U7C6EvAvvqQa42kaoIK8I1CnuCbiMU+CKalIRU?=
 =?us-ascii?Q?Z/ynyzgv59SGuUjm2jbHcFX4FOb/66ZxsTIj066uOwbCQsuUGRaeDB7YyMPP?=
 =?us-ascii?Q?/7WCblik5H8/Ag0yp9FgEsr309zBQE9Uaq7P/CHCvflAGWr91KwkiMsSHrIo?=
 =?us-ascii?Q?rvd7ERUbIoDIyfR8OOZOOlEiKij9XgA/V6YlPJA5niKB5r11GhsTh8eBMJ/Q?=
 =?us-ascii?Q?cjiArFNwb3Nc9QHjc9LWfhDO0UtLBW300TOYeYWvvrbIB2m05R2S9uoRYHG4?=
 =?us-ascii?Q?1TvKBxYLG0yT2oP5GQbPEVry82qh/FEvziYu5eHHmMd0u5h9R9pAI/9JiEXO?=
 =?us-ascii?Q?yuATWm3ERY7HhSD1v0e2ywRoTcVfawRQ1Pi6MlUNkXZ49uo1rvumsile84ml?=
 =?us-ascii?Q?/q6fasNzR3MrgxGUe6QiK7hXbBXtld8+FBVldKylom5OIl7X4rt5YrgtL4p5?=
 =?us-ascii?Q?ZaZ4XmDWQv6BS8U1T/J2Iu1p6DnmqNKDE+dDwqAN9VBhrsKmxZjj5bihEX2z?=
 =?us-ascii?Q?zaJUIN+sL6FopmGZ7Ys5/XHvCbSN8xPD7uPYJH+/cHxdOiXvgEQrr34+9nJU?=
 =?us-ascii?Q?XwvbHZ6h9BJGb5fSTvW+1argmhSm80RzS54yYzu4JAwFAljYkV7wmmjiiflc?=
 =?us-ascii?Q?R2IjkqNUFndBRXV6Npl9COhrGckDKms0wh9NjdMaI1B+4AWzDa1HE/yoevar?=
 =?us-ascii?Q?6qlVCsdbviBDS55E4sP6k3U3ZH+VOcLdztX0CrdW+vHOigSleY3I9Lxm6NLB?=
 =?us-ascii?Q?yc2gHgojlotzjJZZRsXRgy/0lPs2lY4rFUiSC0cLsaGr4rRrS7whqMOJlaA0?=
 =?us-ascii?Q?lOpse8Sk9tR1EZ/KiP6VVr5oiRSAp80u3iIp0oG/Me+i92hf1kAMb6pPXn7f?=
 =?us-ascii?Q?3M70HQMQiIfKF1r91XQAFAgYQzBac7j9aWD5ODLfQ2MO/O3u6kocJBvNMqbz?=
 =?us-ascii?Q?YhdS+jvPpN6WIsqIzbGF861GwUmSAHrptuX7fQ1hLqjaHOemHjKKaEQejPbA?=
 =?us-ascii?Q?kNGosf4oPeO9K5Gc4bIkNM0sR50NQI2Q2jTqgpWw3WGVeHRvVJJaV9jNGP9g?=
 =?us-ascii?Q?hcZfOvwP6ztF5+hXuKaV8AU2bNSXu89ibGsoDBbQDsVl6QiTyLkHir1UmZ6f?=
 =?us-ascii?Q?mizsBJNt3xEsNs6JlojH5dpc/25fTSJqh4+GgvbQsccmqL6CXa38HABDUvWZ?=
 =?us-ascii?Q?KJ0WOj3at8xI8d5zpXiceLDHXETKc9c4yXNB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(7416014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rFYrXesA0kBG4/3ReSg9xEHBUj453jtnANtXSAZoo3eOEk4UiZZABugi1zF2?=
 =?us-ascii?Q?WxxPCvz8891zjkGjWNVv976vfeLGWiEQRKivtghkZgu3zy/iNgY4WPdEOkAi?=
 =?us-ascii?Q?O0OY2EWLzYKhL0u9VLFpgaqFXCwWjKUbktJHE5fYTcPllZ9CwR8ggkgP5ewB?=
 =?us-ascii?Q?lWQ8biXYvotcXC0QNA/iBBi9rLmAJ47uKebCgUEPTKQMzqqV6c7LEkPELtth?=
 =?us-ascii?Q?eSSax7hY8VBhLJkHNkXAKx0CWtb/zZxHHu4nTSnFBKUtnft3npZZki93FLyc?=
 =?us-ascii?Q?xDTyPk54gTg4C6++heaIDvCGuNUT9ct36E0cMiuc1BdJvw3DNCiCqnIQ8Mmo?=
 =?us-ascii?Q?hA/k6HrkWZPasRESmbCoeYPlyPmMvJTrclCb/I9NMWbST7kVNPXMWqiJJsmQ?=
 =?us-ascii?Q?tyDxIajnupb66Ih4wvaiwWcWhICrw32of2PHQc5LTw8ILrvzmNfyAixxcWRT?=
 =?us-ascii?Q?R5NtseO6REvUQarxke5t2deltLG2YxUfBFTdSKf6A1RUwm5e2S7Y6YU0X4er?=
 =?us-ascii?Q?7rulOWYkTpMkD1l/2xb8EyDSA4kK8GPhr1z9P4dSgFaHg4Irf3ca0ccKmGxu?=
 =?us-ascii?Q?WHlblEsovVr9ZUstap1Q1AJr3DTN/M/lAMVBB4nF0bjam6Lg3MHA3je2+u1T?=
 =?us-ascii?Q?JeQNAqge/RtjCAySTjgjO7m3b/ovXU2N55UJ67+080gQ41mjN1GdWA4jnkFr?=
 =?us-ascii?Q?rq7+mvI/uU2FUk1xHoMmqpXF+vZUPksDsv6h2ACLXptVVynNIs08UC5uU5OO?=
 =?us-ascii?Q?JBNTQ/g2NfQH4Frx3f9Qv5tchWvxcnO6ICyxH1tQpqZe4bYtlZvQjqbuUUl+?=
 =?us-ascii?Q?Zw+ffH2UBNyBMY/L+Qezw5MOwA/0sqL51zO7d/QA8uckUUI7nZm24aYWL7pW?=
 =?us-ascii?Q?63Bql4fFxhATNdwgt9FwsYpoTRa3yGiUju9SdIqi3BlulFF/AMl8Ec93Xgic?=
 =?us-ascii?Q?XSjgXOvJBo/w7fmC7D6CdKkk0rt9S/ZJjiHyxKzKnA8VX5Vkp4lZ4BTe2SC3?=
 =?us-ascii?Q?4Xfr97znxGFQOkaF9gnc70w1WKp4QcfM1V4B790EZhV/J75kuo/tZ6Pvv7sA?=
 =?us-ascii?Q?5Xnz2nibNmy3TnXt9F59o/W3NbwrrSooB9NEAz7/R3WT3s/Pim4DU7R/AF1f?=
 =?us-ascii?Q?/n56qm0/QGuZJW8mxeoBA5SN7xNo518oeELw+wom/KU3v96P/mm0OEeg5QoW?=
 =?us-ascii?Q?eS+vKuw7ahS9fTTxMXYKG+iqKaNi+DYwpv3Og8I9lOH4bjFUvFwl1uxHEcQS?=
 =?us-ascii?Q?Dxj+9gze9r4CgeLpol8loHGygoAvi5vZzSuW22jKaVaWma8WbhZUYuT4AzN6?=
 =?us-ascii?Q?WvsRRB6sPGXoPNQzUzW11+zwYNrmaodEUTe6dllwdSuhzgSiOzthrjL+Yn8m?=
 =?us-ascii?Q?7yHzvwdR2Qt9NqcYqh2CYpwocbs5liYE4+s8DMJ5IUUB1ITi8rY4Y4cBrtHe?=
 =?us-ascii?Q?qYdgb2BSZkHdVG2wU2Z1n/V01yWd5GDUfAoRa45BcFelcPiUsTCeT9Yrgvrf?=
 =?us-ascii?Q?8Itn8Vdc4EmM6AgR/zYbVk7b+fanXty3/5XRACWj2b3oe6UmImaEGOz6sQs4?=
 =?us-ascii?Q?0ecCammY7TwfFkGo3os=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b43d9e3-ad5a-4573-e710-08de0b6ff5ff
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 22:21:03.1175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2JOULJhQWo/bnIqAEeB0pcgw3OrN6aoJ3/NmrOoMGgcUlXf/JGUXc8xLl6ehZhO11O5Mezx9/X0BNZXwCn3Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9045

On Tue, Oct 14, 2025 at 11:58:43AM +0200, Lorenzo Pieralisi wrote:
> In of_msi_get_domain() if the iterator loop stops early because an
> irq_domain match is detected, an of_node_put() on the iterator node is
> needed to keep the OF node refcount in sync.
>
> Add it.
>
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

After go though of_for_each_phandle, I understand why need of_node_put()
at break branch.

It will be nice if add of_for_each_phandle_scoped() help macro.


>  drivers/of/irq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index e67b2041e73b..9f6cd5abba76 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -773,8 +773,10 @@ struct irq_domain *of_msi_get_domain(struct device *dev,
>
>  	of_for_each_phandle(&it, err, np, "msi-parent", "#msi-cells", 0) {
>  		d = irq_find_matching_host(it.node, token);
> -		if (d)
> +		if (d) {
> +			of_node_put(it.node);
>  			return d;
> +		}
>  	}
>
>  	return NULL;
> --
> 2.50.1
>

