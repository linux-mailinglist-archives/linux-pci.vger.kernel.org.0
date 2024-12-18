Return-Path: <linux-pci+bounces-18721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5B69F6C83
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 18:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C961894123
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 17:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736F01FAC4C;
	Wed, 18 Dec 2024 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GNNPeGiM"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2046.outbound.protection.outlook.com [40.107.247.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F661FA828;
	Wed, 18 Dec 2024 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734543892; cv=fail; b=Krpzq61isvn5T2dtajhNzl5qUryK0Qcwgeu/Uezrm1ywrmmTt4UQHWA9cV+iXhZF0lDxmQLG1sNkf2v9Au9ZRiXxsfBhIaNN6GQEMXhYS8P2dLHApgjn4fOtMtq4OKOJy0ohg/t7zUxY/cx3AARd1oPMiXMa094g3c+uNM0L2Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734543892; c=relaxed/simple;
	bh=wMdY5TxoEEX+1oy3F0VwCgAvCaLArPstY52HkB5L4Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iI2zOuPh6q0fq/C3Jf9igp7+iB2eqqE9CiV1XCxxV/iUcNNXai1siVw3Nc9uy9OP7YE7+LUo0RQZ9T43P7fo3+b4UuchnQw+a6l8eI4P/L0/mbHErZCrIt+jpfy8eGHxeKHZH+hgvfR3O7V1J3aItenFfWuWvFlAdSZMRuMc+Zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GNNPeGiM; arc=fail smtp.client-ip=40.107.247.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwNMggdwWqrzFndB50D82A+DUX7dV6CTv8aHI631Cdj+SlPPelSeJ1EufQX2sQWjAYYhXX4Df+IZ6uaRG7AqanJQ2xnLhk+1QLh3E5frpi2n9esnT+HisZXNT+q/pGqCxfnFhJIlifWeiPd7N8Av5rs7aqkQn+QqJ0zbrHUlG0Y+clqXYEwQTduiePR0O7vIvzzlv4g9e2ttdx5dhYAhKpENLlRyY5zzC7kMiG/v9r0TkT0xDFr26Mgfx9GZV6xK/qI2GHAETb35PKlRIGQlfXHm2FTHvUWOEQ8neNjQAyddlA5yH3XWD8/FzmlE/ImjgmK3CQiCax4ZjwGf0T0jhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXqNsgOT7RYHyzEAGV0EdyGdGBzhihkLQbOJIcAEBcI=;
 b=KordCaQvuNpmnRVPezHnkOWNLJOrArYl/y9ybuWkEeN5uDshheP4qDMkypeSy+I9cfAvQTLNm5JEap7WvrQyPUFnb1ml2co88PAwpt3cJJ05MxAcv9cq1FtC3xrZR4FMNiWKsX8gWHuY10r+4UyznjjQBvJEm9TgP2BQxUi5bm/xs4PWtDakB13vuRYFUgG7fmqa43R6kkFESjeEs0bJrs3uPFCaR87mTaDk0/8GheF/IkMWYxeaES0IdH4o19E+PwMH9vUv1DVVr3InAZ3xVdGSbO9LLT8GtMEvUghDtilh61tnBrhgPvT4BXirRcAizLw0WMoRlWfxq41i9x0QXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXqNsgOT7RYHyzEAGV0EdyGdGBzhihkLQbOJIcAEBcI=;
 b=GNNPeGiMQg5VodKGW7Eck06OR6Pao9325VvEYQoWtmo5obLQw/AbuRdKqc/lMojhwLTCJBETXaoe7prWny66pmHWw9/4Vu/apD5K12h5thUrexNDKZ2dPJ67V1yb+BKZokkb7X0tZfuHUd1xhzTtMmeu6x2iCAzRM6DH38SqQNViFK0g/fXQaVvM4989cs5nIceT7pVLQlkTThoPhyvKQFNQp/QyKwR8VYsoGWe+250hMQfoTqE8WsFMLQwMqHA9Nv+P4KY2+E+JWSfhpIe4ZG7K5cfxBkeNqCz6TXt/4LswCeFMTPxu7zCA5AXuhyi7UA40ja1uYgd9TJ1W6AvnZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6773.eurprd04.prod.outlook.com (2603:10a6:20b:dc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 17:44:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 17:44:47 +0000
Date: Wed, 18 Dec 2024 12:44:40 -0500
From: Frank Li <Frank.li@nxp.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
	dlemoal@kernel.org, jdmason@kudzu.us,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v12 2/9] PCI: endpoint: Add RC-to-EP doorbell support
 using platform MSI controller
Message-ID: <Z2MKCIImpnDjS1zd@lizhi-Precision-Tower-5810>
References: <20241211-ep-msi-v12-0-33d4532fa520@nxp.com>
 <20241211-ep-msi-v12-2-33d4532fa520@nxp.com>
 <87o7197wbx.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7197wbx.ffs@tglx>
X-ClientProxiedBy: SA1PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: 4826d498-cb59-4835-b468-08dd1f8ba9f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4QDYlwWN34u6X3ZW5OM3j74yOB4fM8mb6uyIeIj+aa7aCaZ23k0ONBpAQi4D?=
 =?us-ascii?Q?fQYKo3dwFFrU8z/EkTqeIQvB6GxoJa5ah4SE0vQRHaYYoaAXscecec/XK0rt?=
 =?us-ascii?Q?05v71aiNclfggOyX9ibYoGoxBevosdUsPnfr2B2/h+Cs7i6j/JUVAXYWngpu?=
 =?us-ascii?Q?MbEqnWIzXd78ElfrPu1onbSPLH04rFxPmDweZTuPhvGA6PoBYrFOFyq+uLof?=
 =?us-ascii?Q?CEaIU4+Bk/bZr6QcSpUPbmMSTl93pGqlGLqs+dAgjEQF36HByLbnrqciTCz1?=
 =?us-ascii?Q?XrPGA2euMNPmmOI17Uv/lxMFOHYgddehEFuaxjfnBMCM45/nBaYGIyo8Lwti?=
 =?us-ascii?Q?GPj73BEnk+GMZHBLJ9tdYJPvYpYwlwkybQz3yuBOpBl95ZzqQ8UAoDs5EprG?=
 =?us-ascii?Q?PR4/4/4Mz2oCtFeeMgQ6Nx7uU7tLsPZIqItnCzzrXDSkspfZ0f0Imdnok4Vu?=
 =?us-ascii?Q?/KZbA+kRZNX3Ie5neBj9kTLb759thPUkOBxrpvwV3RdWp9XvYvadvukGSOw5?=
 =?us-ascii?Q?9XSnM3pIJT0uBvYVrWvKMW4rJLSRrzZ+8GBHps5Rz18NQW5BFMGN/BObXqQw?=
 =?us-ascii?Q?7Fwd6Pxa5EjsHndn1lJwL/+KyGgWNjUelnCYaQQUzZW9CyNU3douNxeS0awJ?=
 =?us-ascii?Q?4GEwwRyKOvMXEq+w9nDuHoBzAIoyPce59kmcf72tnbQET/c+BhQ6POD4lynJ?=
 =?us-ascii?Q?PIWFWALy4Ry26b0ez/Nejlm9A4yuBLaUvI/3Rh54lMoLMbk3dP7ewLJ1gOm2?=
 =?us-ascii?Q?ViRFB+q9hIXJrIrL4Q4pn6Y4JAtiQ8ngjElRq5I3SQKGeyyy8nxmVPXRN/U6?=
 =?us-ascii?Q?6fxMw9V3klTnihLIsBLy5EwPrBPLMed2YmRIiYRHWEQuFlD2sNIEi/BROsTn?=
 =?us-ascii?Q?T4LYpcAWHzSh5VEVk/JUbCB45rrt7LneFzLuPgJzzaNf0qtfx/iri7byIm7Y?=
 =?us-ascii?Q?f/wk1/20k8NEF/tb7fYXQwJrcmOkLjSO1lDdqI4hyrjpupGIZX57pXKuLHYO?=
 =?us-ascii?Q?JUp52QwSgkIcaHHoqfSOb7Ueu0CeUOaMF2zhqJm3ID0zRYP4hwffNsXfjXdP?=
 =?us-ascii?Q?F2s1UhkecL8m2IhKht6oYQ8xvI+Icnl6h7GqVSlC9Ug/I9mq8ByKjcz1zRrr?=
 =?us-ascii?Q?phdEC3udBWG/me2hfF/CGSEQMyqorXXNRf+8TwQxnozSqcF3BqyGV7FMp3bR?=
 =?us-ascii?Q?wFDvESF0GkviOpCj/IN8PDQf2e2IlD7l+hkmFdt4JR55J7Xpk+wpaNKfEl0o?=
 =?us-ascii?Q?Y7RdYoD2LbT/abVjQqc6rON4o7YBFDgyJONmvl8mesVbW12CBzcdstI148sH?=
 =?us-ascii?Q?leNq0/4ywe1TPd7UpJ6PtuhlLXFoD8LazMiyZTREWwNoDDWJve4LHE9/ZJ2v?=
 =?us-ascii?Q?04P944cFSDymuvEvfGTtV3LlS+QItihMZw8ezg4PETYKuiMliikaYH9eerZd?=
 =?us-ascii?Q?HiDfCO1yUR+iPksfllmrsPY/61b15f8o?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9ApirrzsN12En69h2RfZL5yt5DIf+XYpK6uRYU8837xPs0lgTHWa/YoNk5l1?=
 =?us-ascii?Q?NsF5l5xvpAf5kZmAZ8H6Jcj+KnjWavXB0o7/8NPTw16pg69LUBwAb3ZXgi0I?=
 =?us-ascii?Q?HVs9NpEDFiXPUPCTOlRU1hGWE2vI/DM2b776U/Z+OfK0SoO6R8z8LgFjru/u?=
 =?us-ascii?Q?dEj9MYkJ706K9uINzzRrgEkP1pWclDv421p/Om2/zCkBam4gqw8E7S3wXKSe?=
 =?us-ascii?Q?1n6H+LBW09nNTnmw4QMdLRg69BiMYaBuY+eSxmRVO7GBcadmFCFXDPcFEA5x?=
 =?us-ascii?Q?aAoxzhpdehZTNm//Odgh9y8Q8/ApfaEU8Ef8yD0vtckFPstr3dsiDDvDiov7?=
 =?us-ascii?Q?qgl69pwun21Om3I9QgWdEruSzZzaLG9k9YtVSlBarXZM8sIQ+M8BMqNE5xhg?=
 =?us-ascii?Q?aL7MQs1h7g2fXA4g0qbORi7rhRDbW6TQ/PYhsOEJmMZtIQWRL9wBEooKpJM4?=
 =?us-ascii?Q?Cf1u3SEyGeiBWThTAKUOJe2YbE//kklfVQuMI0hvczws9/CTWRT2/fZzJNPm?=
 =?us-ascii?Q?3uQ0BDsp90FfmkuW8zbYd9ZbUYBrSGTJXyr+tjh/DU/rQphamUpwgV7hEHmr?=
 =?us-ascii?Q?isxY4yeiOWngBW/ECWcohWgpfY4+75BJrTRn5XqCdHthSGe2b29LzBLgjrQh?=
 =?us-ascii?Q?xECHSiRIdVZ9EQVuTXUIectyWLcDeNcRifRkWkHJH1E7D2ScmSn0tWMXcn9r?=
 =?us-ascii?Q?MVnYL72Gevp9tY9SQqvZFNJNiJ/EAUoiScE86X+nhL7B5i3Vw4u8WCauiC+O?=
 =?us-ascii?Q?ntHuovwVI49ow3HCfXmf4HP55KEGUTH8oP77fXSItZVAPJH6ep4VcPYAxU+e?=
 =?us-ascii?Q?hZwoqRtZfaYVo0eiIWfIFZcAqWoNEbyOxhW2+LowPlFymEUjBAEgOUBDCycw?=
 =?us-ascii?Q?pyxZAQWZl4VAEHnmNJw2mqIYk1Dhz1W7nXc/ecKTXxRGFxG4pJTpGio92U8K?=
 =?us-ascii?Q?VBxBj6lD23DZ5aecs/pP3HSAZHcquZ5HL2x6CuUw6Ux4xV3SyJrWBhViO7Dw?=
 =?us-ascii?Q?6vsGFHuShOnnt1FwoBF7DcNKRoAJ2UDJZCzlDA4GdyowFC2Z3lY3Vgpj0Dfo?=
 =?us-ascii?Q?5Lu58gt8aBRqJYoi1wjVLT+S5YdFQDHWAgxM0F3AURnqfxqYMiGYedhg/aCb?=
 =?us-ascii?Q?kppJCAK2BZ3N0BtFrKNG1gZVEjveC8sPqvLd22QaJV04gKs/R5qJlnkZ7xpF?=
 =?us-ascii?Q?Ql+cx06RerfftLOSppOErqPEgTA6H49yGSFMdaGv6TtgbawZnjoh6B/5X7eW?=
 =?us-ascii?Q?72iy9woXpM4yS4zxWw0CtMgAiUfVSXeCV3JTyrptetLATxfT5SGwcXCDW/e3?=
 =?us-ascii?Q?htuY/9U7p8J+UmV+CH4FK8HMcqc/HILRwgFUvxXcP5M2s6gYaXRmlwNPNR5c?=
 =?us-ascii?Q?kKNgayd/vuoAn8XO7hEvyKzVcWZzK/MuQq0bZMrXlUQfED8uUx6gVWZ9HwLL?=
 =?us-ascii?Q?+ES8h0fDfunKvcl+layUM7c1U9Tualc8Kt5Vs3nw2gLP80SQ1lHaXYykXWnk?=
 =?us-ascii?Q?4P31RaAo2A3A7WRpPG6tEenoYkiQ9kt8AQxcvHNe+acgRQoQXOTYo4U5p5aW?=
 =?us-ascii?Q?yW+QMOjT/4aZdbp9KSfeCq35RskkXxMv9eLpPVg5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4826d498-cb59-4835-b468-08dd1f8ba9f6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 17:44:47.0144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZuaSaYDQInMNlJqNHkwMjB2IwHeulIq5SFeMudrzNJgjcQWpyW5LPy6PIp0voamMp/jT/tLILHYDEfByNoqrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6773

On Tue, Dec 17, 2024 at 11:56:18PM +0100, Thomas Gleixner wrote:
> On Wed, Dec 11 2024 at 15:57, Frank Li wrote:
> > +static int pci_epf_msi_prepare(struct irq_domain *domain, struct device *dev,
> > +			       int nvec, msi_alloc_info_t *arg)
> > +{
> > +	struct pci_epf *epf = to_pci_epf(dev);
> > +	struct msi_domain_info *msi_info;
> > +	struct pci_epc *epc = epf->epc;
> > +
> > +	memset(arg, 0, sizeof(*arg));
> > +	arg->scratchpad[0].ul = of_msi_map_id(epc->dev.parent, NULL,
> > +					      (epf->func_no << 8) | epf->vfunc_no);
> > +
> > +	/*
> > +	 * @domain->msi_domain_info->hwsize contains the size of the device
> > +	 * domain, but vector allocation happens one by one.
> > +	 */
> > +	msi_info = msi_get_domain_info(domain);
> > +	if (msi_info->hwsize > nvec)
> > +		nvec = msi_info->hwsize;
> > +
> > +	/* Allocate at least 32 MSIs, and always as a power of 2 */
> > +	nvec = max_t(int, 32, roundup_pow_of_two(nvec));
> > +
> > +	msi_info = msi_get_domain_info(domain->parent);
> > +	return msi_info->ops->msi_prepare(domain->parent, dev, nvec, arg);
>
> While I was trying to make sense of the change log of patch [1/9] I
> looked at this function to understand why this needs an override.
>
> This is a copy of its_msi_prepare() except for the scratchpad[0].ul
> part. But that's a GIC-V3 implementation specific detail, which has
> absolutely no business in code which claims to be a generic library for
> PCI endpoints.
>
> Worse you created a GIC-V3 only PCI endpoint library under the
> assumption that the underlying ITS/MSI implementation is immutable. Of
> course there is no safety net either to validate that the underlying
> parent domain is actually GIC-V3-ITS. That's wrong in every aspect.
>
> So let's take a step back and analyze what is actually required to make
> this a proper generic library.
>
> The endpoint function device needs its own device ID which is required
> to set up a device specific translation in the interrupt remapping unit.
>
> Now you decided that this is bound to a DT mapping, which is odd to
> begin with. What's DT specific about this? The cirumstance that your
> hardware is DT based and the endpoint controller ID map needs to be
> retrieved from there? How is this generic in any way? How is this
> supposed to work with ACPI enumerated hardware? Not to ask the question
> how this should work with non GIC-V3-ITS based hardware.
>
> That's all but generic, it's an ad hoc hack to support your particular
> setup implemented by layering violations.
>
> In fact the mapping ID is composed by the parent mapping ID and the
> function numbers, right?
>
> The general PCIe convention here is:
>
>     domain:bus:slot.func
>
> That's well defined and if you look at real devices then lspci shows:
>
> 0000:3d:00.1 Ethernet controller: Ethernet Connection for 10GBASE-T
> 0000:3d:06.0 Ethernet controller: Ethernet Virtual Function
> 0000:...
> 0000:3d:06.7 Ethernet controller: Ethernet Virtual Function
> 0000:3d:07.0 Ethernet controller: Ethernet Virtual Function
> 0000:...
> 0000:3d:07.7 Ethernet controller: Ethernet Virtual Function
>
> In PCI address representation:
>
>    domain:bus:slot:function
>
> which is usually condensed into a single word based on the range limits
> of function, device and bus:
>
>    function:    bit 0-2         (max. 8)
>    device:      bit 3-7         (max. 32)
>    bus:         bit 8-15        (max. 256)
>    domain:      bit 16-31       (mostly theoretical)
>
> Endpoint devices should follow exactly the same scheme, no?

Can't reuse BDF beasue Bus because device have not any means for EP side.
such as PCI EP controller have 8 physical functions. called EP.1 EP.2 ....

EP.n may connect PCI host 1, which bus number is 1. so BDF
	0000.01.00.1: sampe EP devices

but if it connect another PCI bus 3,  so BDF is
	0000.03.00.1 sampe EP devices.

At EP side, it don't care connect to RC bus1 or bus3.

	EP.1  use MSI irq 3
	EP.2  use MSI ire 4

regardless EP connect bus 1 or bus 3, door bell always trigger EP side
irq 3 for EP.1,  irq 4 for EP.2

So only function and vfunction should be used for as request id.

I worry about some hardware (I have not met yet) direct use BDF from RC
side because it is simple hardware implementation for dual role pci
controller.

>
> Now looking at your ID retrieval:
>
> > +	arg->scratchpad[0].ul = of_msi_map_id(epc->dev.parent, NULL,
> > +					      (epf->func_no << 8) | epf->vfunc_no);
>
> I really have to ask why this is making up its own representation
> instead of simply using the standard PCI B/D/F conventions?

See above!

Addtional difference vfunc need difference doorbell msi domain.
I have not sure how virtual function to map to BDF. If it map D, we just
simple mask B. I want reserve it to avoid ABI change in future if vfunc
support since my hardware don't support EP's side vfunc yet.

Anyway, let me implement what your below suggestion then fine tune this.

>
> Whatever the reason is, fact is that the actual interrupt domain support
> needs to be done differently. There is no way that the endpoint library
> makes assumption about the underlying interrupt domain and copies a
> function just because. This has to be completely agnostic, no if, no
> but.
>
> So the consequence is that the underlying MSI parent domains needs to
> know about the endpoint requirements, which is how all MSI variants are
> modeled, i.e. with a MSI domain bus.
>
> That also solves the problem of immutable MSI messages without any
> further magic. Interrupt domains, which do not provide them, won't
> provide the endpoint MSI domain bus and therefore the lookup of the
> parent MSI domain for the endpoint fails.
>
> The uncompilable mockup below should give you a hint.

Thank for your example, let me try to implement it.

Frank

>
> Thanks,
>
>         tglx
> ---
>  drivers/irqchip/irq-gic-v3-its-msi-parent.c |   50 ++++++++++++++++++++--------
>  drivers/irqchip/irq-msi-lib.c               |    5 ++
>  drivers/irqchip/irq-msi-lib.h               |   12 +++++-
>  include/linux/irqdomain_defs.h              |    2 +
>  4 files changed, 51 insertions(+), 18 deletions(-)
>
> --- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
> +++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
> @@ -126,20 +126,9 @@ int __weak iort_pmsi_get_dev_id(struct d
>  	return -1;
>  }
>
> -static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
> -			    int nvec, msi_alloc_info_t *info)
> +static int __its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
> +			      int nvec, msi_alloc_info_t *info, u32 dev_id)
>  {
> -	struct msi_domain_info *msi_info;
> -	u32 dev_id;
> -	int ret;
> -
> -	if (dev->of_node)
> -		ret = of_pmsi_get_dev_id(domain->parent, dev, &dev_id);
> -	else
> -		ret = iort_pmsi_get_dev_id(dev, &dev_id);
> -	if (ret)
> -		return ret;
> -
>  	/* ITS specific DeviceID, as the core ITS ignores dev. */
>  	info->scratchpad[0].ul = dev_id;
>
> @@ -159,6 +148,36 @@ static int its_pmsi_prepare(struct irq_d
>  					  dev, nvec, info);
>  }
>
> +static int its_pci_ep_msi_prepare(struct irq_domain *domain, struct device *dev,
> +				  int nvec, msi_alloc_info_t *info)
> +{
> +	u32 dev_id = dev_get_pci_ep_id(dev);
> +	struct msi_domain_info *msi_info;
> +	int ret = -ENOTSUPP;
> +
> +	if (dev->of_node)
> +		ret = do_magic_ep_id_map();
> +	if (ret)
> +		return ret;
> +	return __its_pmsi_prepare(domain, dev, nvec, info, dev_id);
> +}
> +
> +static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
> +			    int nvec, msi_alloc_info_t *info)
> +{
> +	struct msi_domain_info *msi_info;
> +	u32 dev_id;
> +	int ret;
> +
> +	if (dev->of_node)
> +		ret = of_pmsi_get_dev_id(domain->parent, dev, &dev_id);
> +	else
> +		ret = iort_pmsi_get_dev_id(dev, &dev_id);
> +	if (ret)
> +		return ret;
> +	return __its_pmsi_prepare(domain, dev, nvec, info, dev_id);
> +}
> +
>  static bool its_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
>  				  struct irq_domain *real_parent, struct msi_domain_info *info)
>  {
> @@ -183,6 +202,9 @@ static bool its_init_dev_msi_info(struct
>  		 */
>  		info->ops->msi_prepare = its_pci_msi_prepare;
>  		break;
> +	case DOMAIN_BUS_PCI_DEVICE_EP_MSI:
> +		info->ops->msi_prepare = its_pci_ep_msi_prepare;
> +		break;
>  	case DOMAIN_BUS_DEVICE_MSI:
>  	case DOMAIN_BUS_WIRED_TO_MSI:
>  		/*
> @@ -204,7 +226,7 @@ const struct msi_parent_ops gic_v3_its_m
>  	.supported_flags	= ITS_MSI_FLAGS_SUPPORTED,
>  	.required_flags		= ITS_MSI_FLAGS_REQUIRED,
>  	.bus_select_token	= DOMAIN_BUS_NEXUS,
> -	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
> +	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_PCI_EP_MSI | MATCH_PLATFORM_MSI,
>  	.prefix			= "ITS-",
>  	.init_dev_msi_info	= its_init_dev_msi_info,
>  };
> --- a/drivers/irqchip/irq-msi-lib.c
> +++ b/drivers/irqchip/irq-msi-lib.c
> @@ -55,8 +55,11 @@ bool msi_lib_init_dev_msi_info(struct de
>  	case DOMAIN_BUS_PCI_DEVICE_MSIX:
>  		if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PCI_MSI)))
>  			return false;
> -
>  		break;
> +	case DOMAIN_BUS_DEVICE_PCI_EP_MSI:
> +		if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PCI_ENDPOINT)))
> +			return false;
> +		fallthrough;
>  	case DOMAIN_BUS_DEVICE_MSI:
>  		/*
>  		 * Per device MSI should never have any MSI feature bits
> --- a/drivers/irqchip/irq-msi-lib.h
> +++ b/drivers/irqchip/irq-msi-lib.h
> @@ -10,12 +10,18 @@
>  #include <linux/msi.h>
>
>  #ifdef CONFIG_PCI_MSI
> -#define MATCH_PCI_MSI		BIT(DOMAIN_BUS_PCI_MSI)
> +#define MATCH_PCI_MSI			BIT(DOMAIN_BUS_PCI_MSI)
>  #else
> -#define MATCH_PCI_MSI		(0)
> +#define MATCH_PCI_MSI			(0)
>  #endif
>
> -#define MATCH_PLATFORM_MSI	BIT(DOMAIN_BUS_PLATFORM_MSI)
> +#ifdef CONFIG_PCI_ENDPOINT
> +#define MATCH_PLATFORM_PCI_EP_MSI	BIT(DOMAIN_BUS_PLATFORM_PCI_EP_MSI)
> +#else
> +#define MATCH_PLATFORM_PCI_EP_MSI	(0)
> +#endif
> +
> +#define MATCH_PLATFORM_MSI		BIT(DOMAIN_BUS_PLATFORM_MSI)
>
>  int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
>  			      enum irq_domain_bus_token bus_token);
> --- a/include/linux/irqdomain_defs.h
> +++ b/include/linux/irqdomain_defs.h
> @@ -15,6 +15,7 @@ enum irq_domain_bus_token {
>  	DOMAIN_BUS_GENERIC_MSI,
>  	DOMAIN_BUS_PCI_MSI,
>  	DOMAIN_BUS_PLATFORM_MSI,
> +	DOMAIN_BUS_PLATFORM_PCI_EP_MSI,
>  	DOMAIN_BUS_NEXUS,
>  	DOMAIN_BUS_IPI,
>  	DOMAIN_BUS_FSL_MC_MSI,
> @@ -27,6 +28,7 @@ enum irq_domain_bus_token {
>  	DOMAIN_BUS_AMDVI,
>  	DOMAIN_BUS_DEVICE_MSI,
>  	DOMAIN_BUS_WIRED_TO_MSI,
> +	DOMAIN_BUS_DEVICE_PCI_EP_MSI,
>  };
>
>  #endif /* _LINUX_IRQDOMAIN_DEFS_H */

