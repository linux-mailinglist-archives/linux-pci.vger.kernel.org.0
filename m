Return-Path: <linux-pci+bounces-30536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B31AE6E75
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 20:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92FAB188D81A
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 18:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD4C2D23AE;
	Tue, 24 Jun 2025 18:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MY6b7YQB"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B110298984
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788896; cv=fail; b=qUuzlz1q6B1sZJxai3i+ZONrZ1aMopBHmuKshjo/lqWMtkcKzcsT0kn8BnUm+RHA+Xrfssi3fpy2Z2ZNbjhy5nXmEO2qBKp+rLl6Cgh37VFO/gABcwjRJFHmP908FNXD1GwbbXtr4CEDL9tZfIiftd5vrHl4GTM7OQppWdgLEcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788896; c=relaxed/simple;
	bh=VSK0WL2vjYScibmHRCBwxUG1RHs0v4LGTbJQIw2//mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q83hhava0G3BGaanl4us0XQH4wLUic1Fojx+BmGljW8WSGXR8w3XAPElsNRYCYKcASgeUUoWPgiAymx+Fw6XrAWk1J1TCS75C1nCpXLGJzGVBidNbMdpKIpMtIAl9/cWvvKlC2112cra5OW32Se69WAIekTzPAeKZS2qsFwuakk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MY6b7YQB; arc=fail smtp.client-ip=52.101.70.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAv6A/RZ8hjsSM5WzBXcHtxQIkMdI2Pn6zSk+ITx8vmmdQWwonWgtjhj57IM8VEb3BU7aF2OowRC7uAZoAI6AGP9lVsPJ7+6qDoCkrxnnIBsEqGwN+QHRbXjLxnzfg5Z5I+MMzuIFlQSXvcrxKcP8dRQ0W5dSE2BANnOuqagC9Dw+awpgC52XUsPq7LMDsyqCierr5lsa8vubM75wUQXQGcrIrqw/MyZL+J26MHwT+o58J1S5LkGVGeEzgKtwZ8LeITYCVNn3mPiUrVaPUCSZBPOaO1cS0aBke6Nt/3n9RJ5lrsgk97ZnUV3aVIyrx/nI/CylNAENWdc4KF5sYACmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbTojIOENUqzHF7skZqvx7c2RN4ElrFWr/XrUCsBDBc=;
 b=Z3pFchikOy+5PdwJWHJ2LH0RJTEzsuppi0oD9GSjoFrNXzvF3s1QVobVGIAn3DwNdJym+z+UYuXevrT/yJewpeGsjUycnkWbISJsoSsqundyFna9H39HxbyrWYSYa2ZmFsGh+4jFOsbQGyfoGNxURiId2GB7ATxmp8WZSjGiFe5ZqfyT4Rxz/k3R25+ji6ssjdo0b6kaCzR/zONrd8npqKGqXFLgO1CkBq5j+Ms9Do7jHQpTfuaPHLSzUMfn3qXSYtUsLs9JD4lDIGreW84bEOex0jzpzu9lqiy/C0SW4XXHtPbQ+dH4o2aKS2860tU1blmo39mAftnlgo+buoK6Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbTojIOENUqzHF7skZqvx7c2RN4ElrFWr/XrUCsBDBc=;
 b=MY6b7YQBNal5o6E30Q67RDelPHtgE6HBJfRLPannere88ivQkEGtrOPVmcdd9NX0mi1vMO8P3hifPmZ5CdCPhtuCglDsofgXTGGhWc/hvXfrnDMhB1azNcVh8ejVm4sIgnaPz4oW/tWAQlYg2ButuMsvSn+evy5vO6e9gl+Kd3FiBDjgojNlK7VSz+QSSYsSI0vFLpU/D7bV72wXdBZVjK1bNNTq+72/YN4yqSSddlZwzZ3V4hwC0OEyg783Po/QJ5XYOy6cUQU3OrWdLImObeFTNawrHkeeCHfoUnDeAJAgVWv+aIEwQeows+0hik9t8iC/UVWzSDxl9/ix3LFodA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8624.eurprd04.prod.outlook.com (2603:10a6:102:21b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Tue, 24 Jun
 2025 18:14:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 18:14:51 +0000
Date: Tue, 24 Jun 2025 14:14:47 -0400
From: Frank Li <Frank.li@nxp.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v2 2/2] PCI: endpoint: Fix configfs group removal on
 driver teardown
Message-ID: <aFrrFwcS/KflScJ9@lizhi-Precision-Tower-5810>
References: <20250624081949.289664-1-dlemoal@kernel.org>
 <20250624081949.289664-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624081949.289664-3-dlemoal@kernel.org>
X-ClientProxiedBy: AS4P192CA0025.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8624:EE_
X-MS-Office365-Filtering-Correlation-Id: 48be8ae1-1269-46ad-9c11-08ddb34b0327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gp44uDFl6I6yEWpQuliTz6vI8sxxrts6MLpYsnsutqAUaq2UfaYwFnHrWx6I?=
 =?us-ascii?Q?R1UjvcaKYsG3bws714gLL4vPqZwZJeTmbSGNuPyBf3JeIHAgSlQZt0x3jjlh?=
 =?us-ascii?Q?2WCch3mW48w+/Nxj//jnK6+QwvoScoO0apcpZ9hqkLLiX9Nkr36OW8y2eiH9?=
 =?us-ascii?Q?NA+VnZs/PYUNXTw5C7vP/4Vj6ZomExyHnw5EQtjYRCL8ok6xvnWoIrbnpNLQ?=
 =?us-ascii?Q?79BukKTBKbYhOkc0YS96qobLPcI7TDpJ9TDq4w79b43vKf6IovlNN/NjFtDk?=
 =?us-ascii?Q?H9qdjnbcA0KPv2QF7Db/KsdmMiem4pUUeKKlQMtYDHzNOGGiuRj8tjjhq1rV?=
 =?us-ascii?Q?7BC58ZcIsqfSnKjwhahcnKcZk2+JU4IeBVQdn+3MFHSf76LMX2lwclzB/y+A?=
 =?us-ascii?Q?6ySVo6X9ru+tMh5ToBAAzvGfgRmB1kPY/HmQVDlLscOycnziXx7sipl3jtOa?=
 =?us-ascii?Q?BTZvcr40OZ9N+QfH756eZl5XXabdqad1durD/ytbp01YZ7H1zcdlDb2RBy/t?=
 =?us-ascii?Q?7yfL8kLngQL0saGsyeVFhODNVWt4IQqmxeCS866bzdgOmphspmtyUVvf3nrZ?=
 =?us-ascii?Q?gVTB0ohmHm6xxqlG307RQD8v+sQhOufez31y0AaNkiRGy4ummVf4jrMAXm5a?=
 =?us-ascii?Q?I0ez1555qwPnv/XLSxFyv0pbfosPMtL0Pg41MMNF35c2RvqIHy2KlfiqCgPX?=
 =?us-ascii?Q?LjwGZzDrtaO51vpgJ57hKfS63YoZR8PXQ5erujPz8d/2Mj5zemNjweGH2AgP?=
 =?us-ascii?Q?cY7qC9GyM91smhk2UBdNmdNphQSFBr9LHIWDyxalUsLTlpuaNN1vMkTV8Fvx?=
 =?us-ascii?Q?3SWEP+olPfGu1EBKBQRemlnYetkUpMVIerntkgGeEjRyqEkPfSzSvC8yLmXs?=
 =?us-ascii?Q?Mp4VIuIcxkIXEqibcM6v+wR0Bh2m2mxKmaKit4uqTtt7PLNvgyc75of8reC6?=
 =?us-ascii?Q?UfC0cEAxR97ngt7ATlGS6AbDm3yP3GUB6R0YYHa8U8F+yqyYqWCFdTPfbp3s?=
 =?us-ascii?Q?X/Grx1jwooqJUlWXHC/BJ/PTZKtuulNjJEfawj09BPzVl6qASw+d6X0UEJJY?=
 =?us-ascii?Q?IpVuZMfOxT6Sc4lpd4O47l3pdA+T37xQuzbTIB+Ede6Vd3Cc2V5x6MhYZvL2?=
 =?us-ascii?Q?QNIv93V8KXgdyHwxKHkIWBJLCLrLYv64C1N3nq0BuAASTKFQrnU3fTd3IixM?=
 =?us-ascii?Q?h6YXg/mUBJBwV+1SJA0k9ARs5UamvFJ6ON82dHjTLoPthu3veERjHhYmATQn?=
 =?us-ascii?Q?C6OLaN/m7yoqxUYyJGvkqTviPYdn6O7Jzuk7qeUtlKCtQchPkNrf5iw6kSUc?=
 =?us-ascii?Q?hx+6bFGcNT7GPW+aaOwKHsH59psuguftdpHRZ95iHvVltUBMNGzfAcc+lwiZ?=
 =?us-ascii?Q?eqLcP29bJaf3/FQwepz1IrNqtjHaSpMUtWJPkOPvlcjDMXLHmpGCdovJ4ofh?=
 =?us-ascii?Q?HZ6v2R/ommxcK0qqtzl49YAoeocd/lHyg3oMNx+uIY27qRPG0QwgUA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iEBfSTDW9CMlAWYaflR0prEZFXtfgZxzVcPnjmSCzGah4YU18Pb/fiMXeHtm?=
 =?us-ascii?Q?uO6EgXKM4/0skMzzW9nJv4hYKIekFfD+IE7PcxcMsom1ab86TuYrNiaRkgs0?=
 =?us-ascii?Q?HLYrdnLKAn2ervKpAatjVMUdYAwGb4E2E1MrRYpTSDMAKn87XZNyFLuUQ52v?=
 =?us-ascii?Q?ufSzifqdluumTVvNhw2GsmQI39QjL1UZlJmyM8F+agsRV72zAp8wsbUjE7/t?=
 =?us-ascii?Q?qtGc0Y138QsuyjWeAu5CWZxGT4NKhAemXMeWjG6eDnKkuI4sl8C7y68LIXUl?=
 =?us-ascii?Q?shlRCdCeKtsdgLevmrn/vnydx7n/eAuLeF6JTMzvJ1Pm3dg/aoN/2T5pneTM?=
 =?us-ascii?Q?XXEYgCi1ZcVctlTstQ2mS7aciN2lTflb+cMHmhPkLGpPr7Khbdti78Raix+h?=
 =?us-ascii?Q?gcrU1r70q8j1XVfhmcHE2JaPFNCQWB1zzclJHObNqm8zJ/gmQLJRalL0SuPq?=
 =?us-ascii?Q?Uotra+GJM7HWGcWfD16flrIWDu229ChBuNp6cNTqXC0onYetMgYDVfCMDI2t?=
 =?us-ascii?Q?BZP1gZMU6VnJiQPdrbvSwYsNHjijZMJ2ahLbBT+WCBOwUbOtWbOriTQzuiGO?=
 =?us-ascii?Q?vmkNNtuqJTLulckCnxb3jYIsZ0LesyV5jRpZMtHwPt3GQ+oHxsJckbK99vqF?=
 =?us-ascii?Q?XHGWQ9YJqVePCZn1INop8kisO1Ntk6hUEPekxmwVCIzXYP0ouMGKDQfxRft+?=
 =?us-ascii?Q?tUrGlIF6BB+lf0f2jpaOdPvd0ONX6ucKsVK9JFBEOhy1Lnga1qv+IdIPEczS?=
 =?us-ascii?Q?FvXys54H7+86tSo3LUGuLKwLhkhk/HYB1t7NU0PElMN8wyw90WFGuetR16Dm?=
 =?us-ascii?Q?MQ/OhTRflZnzLj7VKFu2ZftIQVHx42o+moBwPxaDSQXVYWLMeIrlkjb0CVmp?=
 =?us-ascii?Q?jEBlcvdp2RSiBrmG2KUgC2OrU+RkgwfkeMo+QzlwNvO+yI2ugiGio/x6oa6X?=
 =?us-ascii?Q?hXezgnUL1aQ+WQX16BePNDLcCLefyiXtIJcn4Gq2q4K18FOPQo8m6/+jwhze?=
 =?us-ascii?Q?G+GAugSzU3aiWPoDeXg/P8lUybkW4A6q3HOmumHAvghZpA0IGGvmbH7RrBOV?=
 =?us-ascii?Q?6ALF9h6613RmysZpORxLo8F0iakkCDgNwQB/8Hedjj/DmgGI7FhArqDRsQff?=
 =?us-ascii?Q?QRbwwHzJ+j/1X13IhpdCKNLodjQN10UYaP0VQ9Yv6t7M0miE/yNn3cREQsZa?=
 =?us-ascii?Q?+FZdJ7FccTAPqcM3jFqCP3uSKMtGjj6RT3WO6LvheoOvAcq7E3qoomipp09t?=
 =?us-ascii?Q?xCAAB+Vg7HJUBbU5fItA0HM+6HrWYz+g6yMpSxdB7upmrUa5qO4rJWzkWapz?=
 =?us-ascii?Q?mL6pMAJ1Smyu9tsR665gdOe0vZe39HkLMx/wwcVVLqLMTcjq2hpX959hQgmv?=
 =?us-ascii?Q?tQUrKVfMyBqY8W3KYgAg5lOa1pwpMPLuLjUwvgzmshySF1ZuBUbkCVoEqmOU?=
 =?us-ascii?Q?nnnWt+YQa/tjHYI1b7JaMWQM9L9Gmw5GdlHqLFBp+Rhig/na18ogKCGycaTd?=
 =?us-ascii?Q?Vr+9fmSKxhQnX8HpcG9lRl5f5/fAhCKRvHQesQUrkr6amBQErbsuCI7ODjwF?=
 =?us-ascii?Q?tYJlUM1zNZ4yrJOUB3aLClVPhU06+vSvdGzVfZ0i?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48be8ae1-1269-46ad-9c11-08ddb34b0327
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 18:14:51.4948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bdLdq/t7x8R2rJW4ve14w45Lxd7pJYTQ2DX5LpKimMdCh8s58ERoE7RJ3/T4g5aFI5pob5JFb6zoPNETKomijA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8624

On Tue, Jun 24, 2025 at 05:19:49PM +0900, Damien Le Moal wrote:
> An endpoint driver configfs attributes group is added to the
> epf_group list of struct pci_epf_driver by pci_epf_add_cfs() but an
> added group is not removed from this list when the attribute group is
> unregistered with pci_ep_cfs_remove_epf_group().
>
> Add the missing list_del_init() call in fpci_ep_cfs_remove_epf_group()

reduntant "f" before pci_ep_cfs_remove_epf_group()

Frank
> to correctly remove the attribute group from the driver list.
>
> With this change, once the loop over all attribute groups in
> pci_epf_remove_cfs() completes, the driver epf_group list should be
> empty. Add a WARN_ON() to make sure of that.
>
> Fixes: ef1433f717a2 ("PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/pci/endpoint/pci-ep-cfs.c   | 1 +
>  drivers/pci/endpoint/pci-epf-core.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> index d712c7a866d2..63876537e7dc 100644
> --- a/drivers/pci/endpoint/pci-ep-cfs.c
> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> @@ -691,6 +691,7 @@ void pci_ep_cfs_remove_epf_group(struct config_group *group)
>  	if (IS_ERR_OR_NULL(group))
>  		return;
>
> +	list_del_init(&group->group_entry);
>  	configfs_unregister_default_group(group);
>  }
>  EXPORT_SYMBOL(pci_ep_cfs_remove_epf_group);
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index defc6aecfdef..167dc6ee63f7 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -338,6 +338,7 @@ static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
>  	mutex_lock(&pci_epf_mutex);
>  	list_for_each_entry_safe(group, tmp, &driver->epf_group, group_entry)
>  		pci_ep_cfs_remove_epf_group(group);
> +	WARN_ON(!list_empty(&driver->epf_group));
>  	mutex_unlock(&pci_epf_mutex);
>  }
>
> --
> 2.49.0
>

