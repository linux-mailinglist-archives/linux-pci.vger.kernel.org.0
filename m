Return-Path: <linux-pci+bounces-17603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DD49E2E38
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 22:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A92A5163EDA
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 21:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA1F205AA9;
	Tue,  3 Dec 2024 21:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PyBqPO/+"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2080.outbound.protection.outlook.com [40.107.105.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED60E40BF5;
	Tue,  3 Dec 2024 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262031; cv=fail; b=LrZv8os63VASZH3uPC+4eW7+smTtCz9UC7jIb++X7N/F1EGYfl8wEMQz6O+F+0doxw6fydurjfcBLrYy2zLY72l2oot1pHFGG8qTFYSkRVqB+IsFne6PHixLFumksASoxkfwGtvyHDQkxx5zAjbiq2o63FRaV7/qW1kE8E5EZE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262031; c=relaxed/simple;
	bh=dRVC6XSvLKkgjiPbWJtGZcpY73+AlYfDSVyUrjxqwBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AAUsfJUywj6+eFvyYSXwJM7JFjnF9K8XSmFnLvh5ibvhY1YgnpL8JOC+/rLlk5W20Hsi5InmTclE7nE8pGwAyEkvuSghVf6WWziTKP0ULpPhmjUy7oipkAhnvZrLcHk7HWmweex/URNUlQQzsEW/MpBNUKaN3DRavEyqe29Krlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PyBqPO/+; arc=fail smtp.client-ip=40.107.105.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggVpIjhk1CkK65NWcfgW+F+KjIMTDzAGSe4jSuVVCIk5h6ucRhkfazJ80hBQJt/dEePlSPt9zJJPRYINxyyXER+joj7KKVhI3taulJLpLRmbrWBYE2ndVBfrhrYWPcuvSNMYYtr4MfxxUWA+t59cy3SNeSWbPq9bPm49EFZIE1B4i9+r/ChAV8vAN+aR70wukMq85Jsuuqy3XMm5XTNJvf0ikRnjS/M8GN9QpWtEeqZyJgXuzOUXNuZBa0FCjCh7vOsb96OkdzL9qJxK8z8OXb9+hszKd/pVZMRFD2ySLbcMTeQtPdRQsGe/nE4DUkoclgAY5rQASU+EMafQi7tPHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GoMrnfez8gkqSQdYCjv9jiFqJ6aB1zoOleoYA9M1Bw=;
 b=Zsicf0DoWY4gdCVEvQE9xyyHlBsu+BvmroCxfBZ/3Z3Ye3HOln4Rb140nTPM89Yb9SzriNVBA09alNt5WNke/35dK6cdAukk5p5plyU4qsPf+H4NZYJ3YdnIcIH4VnUGhKY9p3bbWpHiKRvlzfQpV7rSweHuCa9vTR8BR4LtVRl2gGBWMXgdgDJFy33eria7IZt0L9012pYmqphLV7HE1n/dqlsHeRxgJbVYAjw85NSYs+CogDHYjKQn3vDH8reGuZSP4iODPJxt0WpJ7ZfHP2zslb+Ra11u9Wziq3iaA2BQOnu9Rag1eS85kZlteluMwMwtT8neAWZiqlsmntmmeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GoMrnfez8gkqSQdYCjv9jiFqJ6aB1zoOleoYA9M1Bw=;
 b=PyBqPO/+L8xyp5VBG9LZkmp1EMVpT0F0I4qRKLgPUIrmoR0/5i+CQRfty4dZVM6DAK6GQcIvdRlDKe9mPjJOKkRzzFkzwIKaCxG8vFVU2aYQxNl4x9g171hYxCltnepT4F8qBNaqwxipF7h9EPX12TQQW9tG828rctZkaSFefeMNq2GLPJYGk2YdtAsy+oGYDMIQRczqWblg4CC4KvI8g9O+T2CgYhZA+d1Oug/p4MXYZRVsBkRRLxo5ePdvScgo6DJNeSt3Fm6kbInNlaM6QMZ2WZF17w4FluQVfGG57SvvqSUivnec2x81DM7A+pjXUmzfIPGc26Regh6tjnFYHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9129.eurprd04.prod.outlook.com (2603:10a6:10:2f4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 21:40:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 21:40:25 +0000
Date: Tue, 3 Dec 2024 16:40:16 -0500
From: Frank Li <Frank.li@nxp.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Anup Patel <apatel@ventanamicro.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org,
	maz@kernel.org, jdmason@kudzu.us, stable@kernel.org
Subject: Re: [PATCH v9 1/6] platform-msi: Add msi_remove_device_irq_domain()
 in platform_device_msi_free_irqs_all()
Message-ID: <Z096wCMFmR7AyfWn@lizhi-Precision-Tower-5810>
References: <20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com>
 <20241203-ep-msi-v9-1-a60dbc3f15dd@nxp.com>
 <87y10wsc6z.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y10wsc6z.ffs@tglx>
X-ClientProxiedBy: BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: a6fd3284-0377-4edd-2ea8-08dd13e31912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YUvF0ms5KwV6qIPXTQIqFfroL4p5WiM8F80buXtjPFlfStwGBOCLYVRkox15?=
 =?us-ascii?Q?Z/Z/tnEJBPaUgkyBuIlSKQTbxEJnQ+9Gku06nYRDtx8Sqpj9XUThALU+SHu8?=
 =?us-ascii?Q?jec7iig/KkOCWK2vG9Rh5JOpcm5ZFEdC0umTj/Xqt7FMHWR/tAGq339WRaYR?=
 =?us-ascii?Q?htq6XSH8W4yvoIjszoxZaFmv1UUQHl2Vv/8mHhnwySlzK4wohxG2TTg19Bec?=
 =?us-ascii?Q?fr3t+8ddBPmNv2w8fCdLvv+bFLWNpAbXjFgHbg1X6wmjl7MnnMwCknFPhDAv?=
 =?us-ascii?Q?IHWMtzX1gHKW0gwv0c0yNWr8EiTQZ4q204tKuL0IdBMir3dQdzwGteUYVegB?=
 =?us-ascii?Q?4re8EzYPDjVzqXS8XWX6Vd/Jbg3AyD6L1rEiINh2NhxW8ghrnul1xDzPvP7U?=
 =?us-ascii?Q?tNO6m3aAJKKNDouqO7Rr/gABqkEGeC4ytNGFe7Ha/70iRit5gK/PmqaaEKko?=
 =?us-ascii?Q?B7wg9I0z48EA/+ejdVhLMqIASaNbEIx0DwQPV7iabDewWZLLHzsSY02MxK5a?=
 =?us-ascii?Q?E4E8yqDUoablORqD1WZ3t08tau8vqyBdW27eVcQldF+GLwrp8GmFSSlSzMAW?=
 =?us-ascii?Q?1JFaXsx5dplUhRlf22SMr1QJZA6/uFuYNRSTWibB7Sz9vqD60sgjephZtGRZ?=
 =?us-ascii?Q?f3g23rvz6ACgKJm4SFjXQj7aGVNEJWCaP/wlbZ0TPIenkI3Z9S1lgXh7eE17?=
 =?us-ascii?Q?IZaQMkAbCAwGNBpLh2dOZnMj6UjLlU+pb0sTdS8q60goZWnWsaz3DFvbBhr4?=
 =?us-ascii?Q?3seOIi0gYVfZPhppR5ryh/heWeedXCdVxeEdECpNpe/sjwUoIaTkHL+gp9ea?=
 =?us-ascii?Q?Lx8kst1fvrsfOMJr75hoHfEp347QUnBcY/KG9cHKCFw/qoMNToYXWejzt2nf?=
 =?us-ascii?Q?VI8McFltHUJewig7tRX3I5rOKtVpwbYTmKEv/jzGZZBYTafp+4Dz8jqimVTw?=
 =?us-ascii?Q?T1avqZasUY887LS81DMs/HuS/NN6OpHMCmaY9Nuqz1PrKSgn9lrGYADSyqHo?=
 =?us-ascii?Q?Yn9R+M7eYcCLXpBsaNT5tfIpjnYcHbIih8030HdQ40+K2hfCXrwr+f1zz7zt?=
 =?us-ascii?Q?k3yZq8ZztdhJ7XGl6R+x/mZCr5TxHFlHGY0MSwY5OW/+JUaurrBasWuhOeTo?=
 =?us-ascii?Q?iVFsUw0+mqtlD1l0cs5fymVSR83cHUkfJ0gSAbzKgsqVO83EITlwTa/R/931?=
 =?us-ascii?Q?c8I1A331HHXq4/dnwTtBRYSdZQTmtTRkewrdqkShnwdFzw9cuLYNlSzUNTX3?=
 =?us-ascii?Q?GhD8SNR8xjdlRu6Rqb4XmsHZvio88Y9tQXbKFOAMRqo8SgxTpmLDyf5daeUS?=
 =?us-ascii?Q?Ez6YwIMbGNEcvbVkiGtEhRvk1uS2Hte0di01tbCOkthAcmdFFqQ+KcR1HEMc?=
 =?us-ascii?Q?cw8G3NtrvPBF8Y9Pl9o7nO8xpr6n12z2dPtB9PuiHbaA3i4q1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YH0v7jiMO7xSr9SpryKg2dwKezFtZGRqYa3yuygM+OXJQcxIlLkrg3cy63LZ?=
 =?us-ascii?Q?KD5IOaR+EyvCE3TD5dX6Bi2/Lu30Oq8fthDKoN2RIhLD7LO30fgPnJsxejT5?=
 =?us-ascii?Q?UWqVu7fyxiiLNj9SS97JvOVIdfFG/u9ETgYYLTCqjkJ3kAIOUWCMk4/GKV7R?=
 =?us-ascii?Q?Jl6wLBY2VsqCZr/gSEeinGR2IH7Frg3+kxVVGzq2N5do2rSGUUJjySkKcRpu?=
 =?us-ascii?Q?1dKIuZ8D0AyH+yF02Gwz1oRskejKREtjr1QBVj1iRI3T0rRpiMn9OqjuiKIt?=
 =?us-ascii?Q?i/mgu0zDLTvHv2NRXzh7OMLMU2/GgNOevCf0npIFjPuilFGnZm3IwIFv8MSf?=
 =?us-ascii?Q?Mv9j4csAEk6ZyH1pa3BgWe7aXEkoNdblp/f4SKcEMF6EtAXZ3BNkbtu2NPdA?=
 =?us-ascii?Q?IBTQ0TCzrkPyOr5BkN1omZH/TRajmCeCx4xuwLN9VLWAxPiJpJEli2XGZIUz?=
 =?us-ascii?Q?CtykFlzQjarqYoCuE2LuZ+Spm7YJn7zDh2vsyyuRjV+ZQsSLQt4bWpsEFfJx?=
 =?us-ascii?Q?r9Hi8nPdX5hIJRoMiLzpgY8E8H/A52adKGHbOaSWqEg6iyOX1VZK/qWuiumi?=
 =?us-ascii?Q?yc222njxSoWSZi47yVFINm481Ktc1bLeZb5z+QUb9O2RRS17YnJHhthYh0ag?=
 =?us-ascii?Q?6eKMU9sLhF8CAfFBUVZ+m8TmLuRHlhBcNebaGdkmDNDLtkvPhdezJU3r+GGB?=
 =?us-ascii?Q?Hqk/mDlcYsggZ4cy2pG9SNRs3cBuS7i5jdsHm704q6SfnEGcALpcMhVn+vCX?=
 =?us-ascii?Q?GZsS2wSBXWkUagvxfiB9CMHLmYLoI1lQfxUT/dQKu+dVxOWUQos8K66wJ9z2?=
 =?us-ascii?Q?24+JBAM0xjcbJS7YEU24qCcQ8IsVXmFinOKe2cEo8lxKV6OtudIOmqCmSqOV?=
 =?us-ascii?Q?V5VpT2cY9rk4kVL3ijQbWYCPWWiiDoQYVgeNs0r4h6BNIBS+w23Y1cCDleUR?=
 =?us-ascii?Q?Z/kyPOzCZ/7pf7axizH+OW4AVhAX1n//VasYNK4FeUmZGL37Eoafm0yUHxYj?=
 =?us-ascii?Q?EbkENsO4CL3ltGubY9OK/bfPW4Mrlb34Z66RLw4O//ketz3Ymr4qYnhuAbLf?=
 =?us-ascii?Q?Qt0Rpb4yEP1wVvPt5tgapzHfp6X0DEAwUyIgqoN0V4CdGjDDAdR/6s5gFL2x?=
 =?us-ascii?Q?BTLD6jq2Rk8o95+oyg5H4moeVqA3uJFcE93cAlEIps5fS/4RwKo4p9sta5yu?=
 =?us-ascii?Q?ba8vcYhIFmixEwo5ejtSLmDYW99hnMbM2oRnrJL4MG1UI27ECgSCRyZ3ZQ41?=
 =?us-ascii?Q?+5xEUjnK2H8CSMbe39rcQxWxMEe4b8AcBZQEm8/fz2CIbdPdioxD5awWpaPU?=
 =?us-ascii?Q?yYgIlUdubpmcSbO9HALDKyJsQlZ0SKGZnQLBYeRpKKzbABrEUui3nFkCmfSc?=
 =?us-ascii?Q?vUBch0a6Ht1V3AekBs7ZYiMB1SeyJxY5yFyAf9piKiMGUW5bPe0N/yABoVxF?=
 =?us-ascii?Q?bwbWXBtDpuuiRtHvBncgO36zn9EBfhlLDIoVSe983sDK1K16tJYfy/qOyQ37?=
 =?us-ascii?Q?A7lwybwp2fMCAWfdl07VgjjJ7Efe906K6iN4P63fYrazgWsX6+lkf74REx87?=
 =?us-ascii?Q?3nVkd+8MA0lKIUE8wSo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fd3284-0377-4edd-2ea8-08dd13e31912
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 21:40:25.7338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRtK9tjlqdVxwQXvLlKN+0NjSkWkMxyZ4ZZD4ncliwRb6EgEemGyyvjTD3S6eFhvf8h5hM9Z0XE0p8xvKL3sqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9129

On Tue, Dec 03, 2024 at 10:12:36PM +0100, Thomas Gleixner wrote:
> On Tue, Dec 03 2024 at 15:36, Frank Li wrote:
> > The follow steps trigger kernel dump warning and
> > platform_device_msi_init_and_alloc_irqs() return false.
> >
> > 1: platform_device_msi_init_and_alloc_irqs();
> > 2: platform_device_msi_free_irqs_all();
> > 3: platform_device_msi_init_and_alloc_irqs();
> >
> > Do below two things in platform_device_msi_init_and_alloc_irqs().
> > - msi_create_device_irq_domain()
> > - msi_domain_alloc_irqs_range()
> >
> > But only call msi_domain_free_irqs_all() in
> > platform_device_msi_free_irqs_all(), which missed call
> > msi_remove_device_irq_domain().
>
> It's not a missed call. It's intentional as all existing users remove
> the device afterwards.
>
> > This cause above kernel dump when call
> > platform_device_msi_init_and_alloc_irqs() again.
>
> Sure, but that's not a fix and not required for stable because no
> existing driver is affected by this unless I'm missing something.
>
> What's the actual use case for this? You describe in great length what
> fails, which is nice, but I'm missing the larger picture here.

PCI host send a door bell to PCI endpoint, which use platform msi to
trigger a IRQ.

PCI Host side				PCI endpoint side

Send "enable"  command      ->         call platform_device_msi_init_and_alloc_irqs()
Get doorbell address        <-         send back MSI address by shared memory
Write data to doorbell      -> 	       MSI irq handler triggered.
Send "Disable"  command     ->	       call platform_device_msi_free_irqs_all()


At endpoint side, need dymatic response "enable/disable" commands. Of
course, I can call msi_remove_device_irq_domain() in my disable function.
But I think it should be symetic in alloc/free pair functions.

Previous version, alloc/free in bind/unbind function. I missed to do
unbind/bind test. the principle should be the same.

Frank

>
> Thanks,
>
>         tglx

