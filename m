Return-Path: <linux-pci+bounces-18172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FE29ED678
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 20:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1788F188BC7E
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 19:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1F7259497;
	Wed, 11 Dec 2024 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AYdKBsio"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C26E2594A2;
	Wed, 11 Dec 2024 19:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944872; cv=fail; b=BQ/CqqYC+Fn8aShmqN+tTdFOZXjiRowvFjUUQxOXg81fcxxEBoLm/qq2J10TEAkh5oAASQHl43qPG60laIDJkkpraJuf36GULAWCqiT+P1AonqWG5aEkCX+7IZQay4VGnPKkqnV+DJ2zcmfjEAqfbnV5bNHRWkq8XYVXlrV8kcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944872; c=relaxed/simple;
	bh=N7fxG1hdlUEJYK8R7cGur6fqwTE4KWo/PR3rsSuMUb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mYeRJLYRGxV9YzqUeDwGj/jYuGdONBnhcUcDn/akPNmkHi0XZYWY4JioRSAIlJ1IMbkpIy9m6jq01GPv1vHHOm/zi2Ewdxmek8QI0FtwAvaEw4+ZaRr2oEBaWQrkDmHRJP+GeVZemITxbngJqvVOgf95Jz/G3YROg8vhHu2e+xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AYdKBsio; arc=fail smtp.client-ip=40.107.102.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMPaBHM5s1HP4aIWxORyfGOCs0qs0FnfLvmDqdEghfya9MZHyrNL+V5J15BoVDnbZBtIIG4KKzBJCR2Vmb++d1glNRy1ST6eBPgG0xiFEFRQQCgvJr3563LjPPJ3BCfK8/v+mo6JIsWgOSmLXfphlUlLQ/bCTa8akQKcuj27FDjd5eHCiYnKYVB3hNPArv6nIxv4ckDVHbzC3KguBje1YSz0+suMbHM+jfANe4xherL9chxRJXk2yXC97xUUhP7xKyapCE7QhUOeHfYGzhsouNcoBV3ErIcCCrwq8T2y+jL6Bjw22jp76tTA9SaRRAVFABEchEi5tY5vWzu3vS/BjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZ8pq7qzfZVM4/KRkNAPIbtUpmui1Qw/UuBQ0o+0ySU=;
 b=iPKhqlVvj/FvEpda48V7RLJqBP06s+pWqqafJ9rhX6fyyy+v3pk2k3Pbn5BPn1/21HSmfKxJ9zRuwpuOWDMBejwVYjOGs8KPKxRTWZul8BtxlrSvliJHeSIecJ+T6ubtaI6SvakXMZ9WgXDKo5NXmkYgjNdjlyghuV1dtyg9/P9lTzIQVtRsPeCX6kuZT0L5TZmQmiYs1MRiNkU24OUFj+2Q4S1JAx4gVBxvl8aDOIX3PGS18U+qKCN2K8vq3n6Elx8nwZrbzQR6ArOywb6LYVBlYIcQQ7Q8DdDmk1ELHZ0y8TOcMP0m1c58TxR7HRUMVWq6I5VqDmjgLbCUnX9+dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZ8pq7qzfZVM4/KRkNAPIbtUpmui1Qw/UuBQ0o+0ySU=;
 b=AYdKBsiom2pBeU30aEQehfpRa5X/P2+m2JIhzxI+LZ5YrFe8rjuDxBLCXLqnvRy+8/7kzE96vfaSbKKR/tUCDUFIBDrLqQu2C1k9BW/LOUiPwStSQRK6LxINjZosi7ReQYe/LnaaHUzDEs9b1nBFiRYokolMx8XSq44gdaNxi14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.14; Wed, 11 Dec 2024 19:21:00 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 19:20:59 +0000
Date: Wed, 11 Dec 2024 14:20:48 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
	tony.luck@intel.com, bp@alien8.de, bhelgaas@google.com,
	robert.moore@intel.com, avadhut.naik@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev,
	CobeChen@zhaoxin.com, TonyWWang@zhaoxin.com, ErosZhang@zhaoxin.com
Subject: Re: [PATCH v4 1/3] ACPI/APEI: Add hest_parse_pcie_aer()
Message-ID: <20241211192048.GA1960478@yaz-khff2.amd.com>
References: <20241205114048.60291-1-LeoLiu-oc@zhaoxin.com>
 <20241205114048.60291-2-LeoLiu-oc@zhaoxin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205114048.60291-2-LeoLiu-oc@zhaoxin.com>
X-ClientProxiedBy: BLAPR03CA0038.namprd03.prod.outlook.com
 (2603:10b6:208:32d::13) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|MN0PR12MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa213ba-7aec-4fbf-51e8-08dd1a18f18e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bcY580uVSaZdc+7Xz+sKK6/9svKS4zHuUUrBGv8wwLk7WxHc347Nu5FTYoK6?=
 =?us-ascii?Q?PZ/nsUtPjPOC7iIWZ3InY7bWhC6eTP48PcnmYubr08PgKiZlW7dakrjYrHFA?=
 =?us-ascii?Q?Z8ZpoNkngVzim3fPxlvsNm6YmimCrL4UJlRUfwIIWWbt8rKOjhdZhMAFk7ul?=
 =?us-ascii?Q?ppFPpwvp9PvjdFExpa44KybBdwyvsr/OF63yHk5gQpFzhaiQpr+gq4OQEdpJ?=
 =?us-ascii?Q?UV10M9xhVkFPMnefozrgOfeU19CLE5BXCaKwje3ZDPFm3YqHUVQ/nbOyZRmV?=
 =?us-ascii?Q?nrhvq2FT0PDuWzmjWbOc7mRmuOB4hFFR8LhOHiCtzFhgseT3HWO26U11H5gz?=
 =?us-ascii?Q?FAHvlQEuL1UA9vWBtn641val3HZhKnbOoFgMnbgZiRRO6U4F55HJ0RNtcDSv?=
 =?us-ascii?Q?J8k5X26NPal3LXVLZFNvmCBIN6vZuTNjrEDHaX9bDxOMvW2a0Ody3iOymtod?=
 =?us-ascii?Q?13zgYxU4DhKWGm2j/NSnDJAYGNCat8xL82lVLLo9wAXneBJXpCSVYgOWHMgA?=
 =?us-ascii?Q?c20mU6xgFO6YrnmLDUUVI0Nd/4xC+rm1d1+1Fw6c00XExBmyFT+Z4conTfu8?=
 =?us-ascii?Q?cOY57WisYZMf9kvOUinpHN5MfrXmHxFtJIVlM/bekmPbESAdhtrKKmzkDOTw?=
 =?us-ascii?Q?uRO6h4++BgFkCgyeCszYLnGxjLt7Kd64PLEmFQTtygFcIVwLxd9XeIMCo5FO?=
 =?us-ascii?Q?+yrT/Unx+sv8uPA5KI9Dh46HsecdigZ/5Dli8JvN8CkU9UucOpGLr8awQtjm?=
 =?us-ascii?Q?9wP6Tcd/AevQlRC1AJvdaiLZpODDHJcLqZwQjGSpiES5r3eZX/nRWKKQLdCc?=
 =?us-ascii?Q?SIH8QB1kUv1YrKedMxAVHc4jHLxEjDJsKaCoVmgs3/O+OPUnwTO1Sa80fJpT?=
 =?us-ascii?Q?GhueAJcE0VlPtUwhmNnb6OIzZ09E2pHZNgicvMdsO5rqbzLjHmp8DihQyvyu?=
 =?us-ascii?Q?2Wav4Cp5TlPGuIyEr7gkRQYY8Aizr5R21dCqUz3LslASrAV7O3TC2wOefwlx?=
 =?us-ascii?Q?+ojgKaILBwEIAXytVYyiI+UPdg0w2LoYSkiLmWw9ZJ5AudQTKz9nUOapdTag?=
 =?us-ascii?Q?0GGTWQ3NmzBcAkwkA8H3/QP0m7eR97Mgp/CcZpdBm7dbq4nm+kkhD3DTV3LV?=
 =?us-ascii?Q?SmcMODBPQsi2TwYPcYRy8OIersNpNbJHL8lPSt5lWfs2/VfggAUb+uaYa1wA?=
 =?us-ascii?Q?FValuX0vu86wlce6M6uhXv5PM25qtk21fV0yK/1HPchkE1XPECL3vlJLyT/d?=
 =?us-ascii?Q?ahI3TFAL6uY6Vbvtf5UbyguYKKaBh/d9DipyNrmytO6XxMsil49XRI67eRgS?=
 =?us-ascii?Q?kPWHKxydPXwqmPrvQUs9OaiesAl7HYbkp/Y/wfIFsgmZ2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SO/SUUq1NVwodYhVUfhdJqgWQXbKEquJDK64I3efiAAdjLcwUINtpjyDPf7U?=
 =?us-ascii?Q?EPQuUB0uPNMaKI75r7/zdyaasyZeakOyXyakT0Sn1J0XdYgc2NRp/GAa7KHz?=
 =?us-ascii?Q?MDgCgK/SBMxUGLYFCQC1HpCVXPea6IS/0ssGo7Z70C3zDRlzhdERQvpSkrAr?=
 =?us-ascii?Q?qqk38+/eP1r6XhefgfPnfzphDAkQ5V593DK+k6wCe8m9ZC0+OJPtZTTK0sme?=
 =?us-ascii?Q?rVABNGD+BqceLZCNs3R68Vch4F9Sn9nj8gB31MGnhE1SW1abR29L8xaJuqEk?=
 =?us-ascii?Q?AP5DSD/+MzgXQAKsCksLehwZeLwBvu+k2Vu1W880jixUhvKHDIrYPfNqIhqt?=
 =?us-ascii?Q?MaUqun+mc6OABF1hRB9hcDW1yaxvP+OVft/LZwr7KIGVP72t8DISQKQfIVu1?=
 =?us-ascii?Q?1anMHT09xuIVBWAwtEjQDurwZ+hODatCh/ld6MAckY0nI7NP0Q3rxjK1fmvU?=
 =?us-ascii?Q?vAbfMh9Z/+iNCAquVx0RHVH2Iv8uWKBjl67NhsaAlhhc8sN75Z9BtH3N8DF9?=
 =?us-ascii?Q?xjLM/kg6Nl/+bHMuZLBFkZ7XNEklDQIk4yWefikmfGu9iJ0oBBJO2uu/c6qn?=
 =?us-ascii?Q?t0TGwSy5vbtvhI7fnRajbXQ2BLyN7r0xArUSbkfv15NxnqI1C9bok8vMYuuY?=
 =?us-ascii?Q?2TMQKi4Qylpk6d1TAx2oRIUxMN5rWfWqVYyYf8qiQ54W2OLEe8UlVSjKWdI3?=
 =?us-ascii?Q?UpffO+9R6vSUdxkw4HxuPYhNRLp68whUIqC0gxlUnn3KGLTvgVCtGuOwd9AS?=
 =?us-ascii?Q?qfIlEA6eIVLkWT+rcd+jYKY8EhSlXKadoPDUI0ZArYkB+4YmV3IKTouM8xXn?=
 =?us-ascii?Q?kJgm/Vl2qDEO0hEqHhTRuxtEo2XOxd2UylZFRBcU0RU59pGE+xsWQhea3mhC?=
 =?us-ascii?Q?4/QSe1/ANLJwlHjN8yZQQipNkrNeGnBHF1Ry92kkiFVl1cpNoll4z7EL8eNz?=
 =?us-ascii?Q?pvWa3ZrsDE0KchEF2fJ2zcD2F4ymRkSfzoHO5A8z9V/X2QxzT4g+hqPAixLx?=
 =?us-ascii?Q?c32f1QPBrWxo/kqtVpFvvvp+aMdLK9asFZjy1mUiSql4XEKPhGmMQsDJ1+9w?=
 =?us-ascii?Q?UXi0X4fdzSvEx6akwk8vKZ5cPLd/kdScfnAvd6fTcxq6G6/pPpuDNVwqSQGz?=
 =?us-ascii?Q?J9QBnftmpJVmYhqzb+GolT4oJb2XedOz+SBVu5igdrKJkWMIXpURE4N7PRAK?=
 =?us-ascii?Q?upvRrFE3M1wOKtN4XGz8K/JFtc+L+6snvqs6LI1l766iDKL7oHDRF8uTylk2?=
 =?us-ascii?Q?AWhilH14fRWByqlfQQUN28nOkp6ypHXC8YIH/zHp1uIdjHLF0kHMsUhHuiVn?=
 =?us-ascii?Q?ScwDW3pdB+QX7JusxlSrtWEqBXN25HjExCJruxrbnfbpv5eN6MDyvnkNYW9Q?=
 =?us-ascii?Q?Tli/YFtkwFS3woEeCaxurDyRM+07UB/xBAEahSYny+6xPqj9RwE5QLdA0+fF?=
 =?us-ascii?Q?ySjoGYjzlk1SWDG+JuxrYJIxelegVrcqHjAwzr0+ORHBp8ApqmeRJYoBBprk?=
 =?us-ascii?Q?JqrIUs66vJJSiMfxH5OeaDsw92PN13HgKn2zA6vmIienxXy7HXdwUsbL24Bq?=
 =?us-ascii?Q?doUzSTNJyaaFdIGuZHUqHE9jO3i2lXAqNJ3aOenN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa213ba-7aec-4fbf-51e8-08dd1a18f18e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 19:20:59.3201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: or7dkXxJLkjyzMeRul+84uJ+aL8CBOuZT6pcQxqowTjS6sLWa3dni96X9MX9pUkh8isvlbL82NChkJMUKnrVUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932

On Thu, Dec 05, 2024 at 07:40:46PM +0800, LeoLiu-oc wrote:
> From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
> 
> The purpose of the function apei_hest_parse_aer() is used to parse and
> extract register value from HEST PCIe AER structures. This applies to
> all hardware platforms that has a PCI Express AER structure in HEST.
> 
> Signed-off-by: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
> ---
>  drivers/acpi/apei/hest.c | 77 ++++++++++++++++++++++++++++++++++++++--
>  include/acpi/apei.h      | 17 +++++++++
>  2 files changed, 92 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> index 20d757687e3d..13075f5aea25 100644
> --- a/drivers/acpi/apei/hest.c
> +++ b/drivers/acpi/apei/hest.c
> @@ -22,6 +22,7 @@
>  #include <linux/kdebug.h>
>  #include <linux/highmem.h>
>  #include <linux/io.h>
> +#include <linux/pci.h>
>  #include <linux/platform_device.h>
>  #include <acpi/apei.h>
>  #include <acpi/ghes.h>
> @@ -132,9 +133,81 @@ static bool is_ghes_assist_struct(struct acpi_hest_header *hest_hdr)
>  	return false;
>  }
>  
> -typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
> +#ifdef CONFIG_ACPI_APEI

Why is this needed? The entire hest.c file is only built if
CONFIG_ACPI_APEI is enabled.

> +static bool hest_match_pci_devfn(struct acpi_hest_aer_common *p,
> +				 struct pci_dev *dev)
> +{
> +	return ACPI_HEST_SEGMENT(p->bus) == pci_domain_nr(dev->bus) &&
> +	       ACPI_HEST_BUS(p->bus) == dev->bus->number &&
> +	       p->device == PCI_SLOT(dev->devfn) &&
> +	       p->function == PCI_FUNC(dev->devfn);

It may be nice to align all these lines on the "==".

> +}
> +
> +static bool hest_source_is_pcie_aer(struct acpi_hest_header *hest_hdr,
> +				    struct pci_dev *dev)
> +{
> +	u16 hest_type = hest_hdr->type;
> +	u8 pcie_type = pci_pcie_type(dev);
> +	struct acpi_hest_aer_common *common;
> +
> +	common = (struct acpi_hest_aer_common *)(hest_hdr + 1);
> +
> +	switch (hest_type) {
> +	case ACPI_HEST_TYPE_AER_ROOT_PORT:
> +		if (pcie_type != PCI_EXP_TYPE_ROOT_PORT)
> +			return false;
> +	break;

The breaks should be indented to the "if". Same for the rest of the
file.

> +	case ACPI_HEST_TYPE_AER_ENDPOINT:
> +		if (pcie_type != PCI_EXP_TYPE_ENDPOINT)
> +			return false;
> +	break;
> +	case ACPI_HEST_TYPE_AER_BRIDGE:
> +		if (pcie_type != PCI_EXP_TYPE_PCI_BRIDGE &&
> +		    pcie_type != PCI_EXP_TYPE_PCIE_BRIDGE)
> +			return false;
> +	break;
> +	default:
> +		return false;
> +	break;
> +	}
> +
> +	if (common->flags & ACPI_HEST_GLOBAL)
> +		return true;
> +
> +	if (hest_match_pci_devfn(common, dev))
> +		return true;
> +
> +	return false;
> +}
> +
> +int hest_parse_pcie_aer(struct acpi_hest_header *hest_hdr, void *data)
> +{
> +	struct hest_parse_aer_info *info = data;
> +
> +	if (!hest_source_is_pcie_aer(hest_hdr, info->pci_dev))
> +		return 0;
> +
> +	switch (hest_hdr->type) {
> +	case ACPI_HEST_TYPE_AER_ROOT_PORT:
> +		info->hest_aer_root_port = (struct acpi_hest_aer_root *)hest_hdr;
> +		return 1;
> +	break;
> +	case ACPI_HEST_TYPE_AER_ENDPOINT:
> +		info->hest_aer_endpoint = (struct acpi_hest_aer *)hest_hdr;
> +		return 1;
> +	break;
> +	case ACPI_HEST_TYPE_AER_BRIDGE:
> +		info->hest_aer_bridge = (struct acpi_hest_aer_bridge *)hest_hdr;
> +		return 1;
> +	break;
> +	default:
> +		return 0;
> +	break;
> +	}
> +}
> +#endif
>  
> -static int apei_hest_parse(apei_hest_func_t func, void *data)
> +int apei_hest_parse(apei_hest_func_t func, void *data)
>  {
>  	struct acpi_hest_header *hest_hdr;
>  	int i, rc, len;
> diff --git a/include/acpi/apei.h b/include/acpi/apei.h
> index dc60f7db5524..82d3cdf53e22 100644
> --- a/include/acpi/apei.h
> +++ b/include/acpi/apei.h
> @@ -23,6 +23,15 @@ enum hest_status {
>  	HEST_NOT_FOUND,
>  };
>  
> +#ifdef CONFIG_ACPI_APEI
> +struct hest_parse_aer_info {
> +	struct pci_dev *pci_dev;
> +	struct acpi_hest_aer *hest_aer_endpoint;
> +	struct acpi_hest_aer_root *hest_aer_root_port;
> +	struct acpi_hest_aer_bridge *hest_aer_bridge;

These three pointers are mutually exclusive. Can you save just one
pointer and then cast it when checking the "port_type" in patch 3?

> +};
> +#endif

I think the #ifdef is not needed, because this is not declaring an
instance of the struct.

> +
>  extern int hest_disable;
>  extern int erst_disable;
>  #ifdef CONFIG_ACPI_APEI_GHES
> @@ -33,10 +42,18 @@ void __init acpi_ghes_init(void);
>  static inline void acpi_ghes_init(void) { }
>  #endif
>  
> +typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
> +int apei_hest_parse(apei_hest_func_t func, void *data);
> +

Minor nit: this could be done as a separate patch.

Patch 1: Move apei_hest_parse() to apei.h
Patch 2: Add new hest_parse_pcie_aer()

>  #ifdef CONFIG_ACPI_APEI
>  void __init acpi_hest_init(void);
> +int hest_parse_pcie_aer(struct acpi_hest_header *hest_hdr, void *data);
>  #else
>  static inline void acpi_hest_init(void) { }
> +static inline int hest_parse_pcie_aer(struct acpi_hest_header *hest_hdr, void *data)
> +{
> +	return 0;
> +}
>  #endif
>  
>  int erst_write(const struct cper_record_header *record);
> -- 

Thanks,
Yazen

