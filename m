Return-Path: <linux-pci+bounces-36887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE49AB9B8CE
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 20:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD1B1BC1CB6
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 18:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CE231690A;
	Wed, 24 Sep 2025 18:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T1smw1jE"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D473081BE;
	Wed, 24 Sep 2025 18:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739435; cv=fail; b=YjW9AyhZdauQFhuKaRz+RTv/8bShEXUOrUpQPuuLi5jurm/rq4sWJRyCd/UeN9y1oX+qLOvmawM6qUjHj68ajnI8bxGWAVPZ9gnr3USZKg3K9S+xgoSQL7ruUNIPaQEcL6IpowX4SEMMjU5rqFQZ+lOrsPjztOCZZD+ucTbwl5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739435; c=relaxed/simple;
	bh=x+iySf7xybApmKEzeIcKGEqQ6zUdLQmw2qtHw/yLHhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mf+ADejASmWSOlEn1IMNeXox7iRoCkRNxyuOXpjXO5Tkb6NBT+btuzLXsHcxYhDHWJL7QFOi5lP2weoe1P+lILmiB21HWuVrWVklzSE6dWLKnz7V/Qyr5tMwCXg9Cvvgsgwkz5VEpBCquvFEt0QeSH5RCu7El11aWCkk4DIVAxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T1smw1jE; arc=fail smtp.client-ip=40.107.209.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+sP7dTezXeV1UcfvipGrOusthP5rUCPZu4wwMqCiHTTPYxAtJRRgjBFiKLiwdBE0zv6Ped9D8vHid/uZ0aTI5Plw53GcgP+p3u55B7euGsAH2t653cns0eoxvDPUxM+bVmFciEsbbHb8SwnH3Zpc3x3WMSTHdoy4FIUpjrXzSQNRnzB7JMiyg6RVXFnp/ffmzIx4S6+j0Wqzb7/lOK62xzL+Jjuuyrn4ywm0Bs4Z7rLBt3W7V5z8PEks3dUulFuILYVnn7wUrK3dk3MHNYoV4CF69MAvzub5Hk0utzTWGfvSl5rEIq7r8hffJenS3JwtvnPsOxNhpBpZ8jhGJplng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zzw2HcUr2PoxiD2L8KvFNGIWovYFKTJxOLFmSXX3o4I=;
 b=u+zArf6UEFsDmICQEqAOEQpXyC/9Ec9fDa/bZ6CMkGd6aSxjcmJ1JV8v793igmZv9aBuPH3+jTgMP98rfnGEP1DJxkcY40yorKrB3oQ8Npnd8IDha9LCaBM/c5MlwUzExk3QBnNaYQdgyYqiLjeHcaiOF5G6GaKQPn/+YKuePIvv2URDO2oSb97VC1aBNyfytxJViVLddVXKCtLRVsnLUXzYPXaRje9r79zBKYG3XKU+z/W4hotvFNS11KweGnqgdIOLPDfE11ckEr7Y3N/o6tKXmB+TeL6RRepgsbfDYw4uDR7iYM9nr44gpHJHoj0LwJZ7udd/Zm2icnm94GpsCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zzw2HcUr2PoxiD2L8KvFNGIWovYFKTJxOLFmSXX3o4I=;
 b=T1smw1jEJ6t6m3HbKUvD/VTjTzS1HQMyF33AmonXc3Dk2BPzzswgNQg+HtckYdJeFVspUhHZdvt9vJp+n/IvWM/RHNMCArS35lwiF8B8GN9gfwN7oryLZZETx+QoyhlL5SttyGVuFFQVuqYYpCmNICc6R843Ftp4ZhxQL1qfajghIaod8XPvg3Ejc5zHJ/QmPBfnrPMG+oVWRfHzFtnW/YhGhNiC2/1wkPwkg22OTtcsq3VbgyHdiB1sT73wypSr/A3xcd67pknkb1NDzQ6m6mCl5ttABleBdDHlYMeXAhUQKOaZMRzo7xs60TQyYEG8s3C7yewjwjTWi6vMqdE32w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CY8PR12MB7338.namprd12.prod.outlook.com (2603:10b6:930:52::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Wed, 24 Sep
 2025 18:43:49 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.021; Wed, 24 Sep 2025
 18:43:49 +0000
Date: Wed, 24 Sep 2025 15:43:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: joro@8bytes.org, bhelgaas@google.com, suravee.suthikulpanit@amd.com,
	will@kernel.org, robin.murphy@arm.com, sven@kernel.org,
	j@jannau.net, alyssa@rosenzweig.io, neal@gompa.dev,
	robin.clark@oss.qualcomm.com, m.szyprowski@samsung.com,
	krzk@kernel.org, alim.akhtar@samsung.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kevin.tian@intel.com,
	yong.wu@mediatek.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, tjeznach@rivosinc.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, heiko@sntech.de, schnelle@linux.ibm.com,
	mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
	orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
	zhang.lyra@gmail.com, wens@csie.org, jernej.skrabec@gmail.com,
	samuel@sholland.org, jean-philippe@linaro.org, rafael@kernel.org,
	lenb@kernel.org, yi.l.liu@intel.com, cwabbott0@gmail.com,
	quic_pbrahma@quicinc.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
	virtualization@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, patches@lists.linux.dev,
	vsethi@nvidia.com, helgaas@kernel.org, etzhao1900@gmail.com
Subject: Re: [PATCH v4 4/7] iommu: Pass in old domain to attach_dev callback
 functions
Message-ID: <20250924184346.GI2617119@nvidia.com>
References: <cover.1756682135.git.nicolinc@nvidia.com>
 <19570f350d15528e13447168b7dcd95795afdbf3.1756682135.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19570f350d15528e13447168b7dcd95795afdbf3.1756682135.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN0PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:208:530::10) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CY8PR12MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: a8b9e5f1-5f96-49f0-8549-08ddfb9a4cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G6VfVzphA3BUM/5NT8fGXajxuh7mocbcDHI7udJMAfyxKaiYqcJw24ikh0Ob?=
 =?us-ascii?Q?O727qpk0e/LorIWGJGH1QUccC8m3Kuk50pAsBYecnpotg5FMrmdz6R/9FLBt?=
 =?us-ascii?Q?YWZafNXe11UwP/f1upN00Aanc12HmAtNmU3Xi29Mg7OCXQ5WkL+PTmNjTkPm?=
 =?us-ascii?Q?yGEv1yKa+Z39Y0EBV6qoXhU6FNrxu7BXGxAamYkDqgPxQFLzRS4taASvJUS6?=
 =?us-ascii?Q?Phliu5otHt7qngp2Sk8tpg685O8gaMbbl9NevPBjT2bRKFs/CU4oZ3nSWUfN?=
 =?us-ascii?Q?IcGLJKnKtwHgmrErRJ2Odc3hHkxzugI6G6i6hG3sgRArlPtMdRLiMinF2/C0?=
 =?us-ascii?Q?cC1KGmJ/nbEq0m23NpPL0RXKUI8fqAT08GAgKQ9A4xshJCtTTbpIrt6iEwwX?=
 =?us-ascii?Q?MU9ZY7IHRPN0OxE3p7u9YeN8WtF8KI5tepMcAtQSYNv+W61CDWfEd3yGFrTN?=
 =?us-ascii?Q?rWP5DylQuyufayxAJuXfeF1mk5OTurGjdmFuCbXYrfk0jn+myZDx0A8UdACS?=
 =?us-ascii?Q?WPQxiMhcsphEC80UKhc5hrHFF9pqTtpasOXDprKoGGR06vshhMqlQcBp+YWC?=
 =?us-ascii?Q?EUApAYrXF43graJuh9ZGnZZ+vuQ+aXL5gyTobVDgi0nspi53o2FzxvJnAOKj?=
 =?us-ascii?Q?ig+huXVn1agsPXOPjIk6tui2NB9wb1arvH7X8eoj+MIH6XIt7IItS0RIsF6m?=
 =?us-ascii?Q?niIMHDyhE8iBxoWrR2OgodO6glDajrPpQPbaZPpS06sD0oWKcPQtA5Dwv03h?=
 =?us-ascii?Q?X9oLBRY/SQzVcYv1d2IFq6moFRxMn7MCs/RhJ9p7vwDe2TdVqTLZiXjPwjsR?=
 =?us-ascii?Q?SlN/nkouKEcu3OPDcPO2r9s9yIHwUZDU+IDn6gTdHqScSyes7voDWA5Ns3yU?=
 =?us-ascii?Q?NPh+TfmuGQ/yCGfNjuhHwKZl4kNuVsnIwVuxRfDjYfoGpQnerX/dRNDCmmc8?=
 =?us-ascii?Q?RD2SrKG6+YJ39bjsjlLahfaKuwI3wfqFoU2LF5IaFZGm+QVMF4KsIwSz8oQV?=
 =?us-ascii?Q?6zpQw3KaSrleAV8zIuierheHtlKniU4TlJ4YeflovjE3FdrReg5gJKAOJW37?=
 =?us-ascii?Q?dD6v5dTZY/2cgQBRN/3OlEP20gE0CV38WDzAYmjmq/gIopg50x8XfRP20pQJ?=
 =?us-ascii?Q?6oqAJWwB8uCgg+48SsBysQdVt+nzFG1Ejc9u616ULITgPxRZOAUApWYQsozn?=
 =?us-ascii?Q?+21ZPKkgeMBMf4GQzdKpYwCXreVDA7qQZ6twKwuwmGDWubu6ova6Y8SzkchR?=
 =?us-ascii?Q?McJZ02qk6HhbY1dkWkaBjHwAkaySIE6R/aaG1EThPgd0aU2kidtVlye82xmI?=
 =?us-ascii?Q?xmtegP65ZF7axJ6ARwdYoDGDp6p6pnb5Z5hOnaK4v6IX348qt03DfrmSziTu?=
 =?us-ascii?Q?WKXoHlewug7dVgG8Ace0Btmc8TevnlZrZL4awc9RclduJpL9EH5d40qHDPw7?=
 =?us-ascii?Q?9Jxtrp9Cxo5AkGqyPXFNsMjrOehxHQ27?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xz2aH2uvI8r0Vvi1YRYUXGs1Cq0LJYr+OBhN2nXW5LKpQrV8iAxu3idGAAQC?=
 =?us-ascii?Q?pvIlrpcQXa3Md9J7i0Iww9gjTybbHumYz/88ZhEYOJP1kXmG97ErDsUgXurS?=
 =?us-ascii?Q?qkbTe+bNp+LJ11KuusJmoPhqpvbCkVrjo9Iu5IbNV41Tn2o90MLCMOUmtMeO?=
 =?us-ascii?Q?kzRfVPYJ80x0oFsCmSRnJMmazU0SXGxMorg2ygBeT7Q+upbHv4f06sHOCBKQ?=
 =?us-ascii?Q?bHLen5NWWNMJZ0isreFIYpkUwfwAl+wy63MZxSaftiKYlyCq36vMbkAeuehk?=
 =?us-ascii?Q?ChpvDjIipdiK7zg6KcX71dGZl5A72JhvU8CLfyUczdr1hytSEbkh5Q4odbzL?=
 =?us-ascii?Q?pzuEPqZye4YdbO/nImLyflA7BqD8pSMN6EhqGHgBGvCEr6b/lD+0rrfvmvQp?=
 =?us-ascii?Q?H0wtLYLHseA/3WLuuPJW3RqPfDfL8+SYi+nSG6PhW4wPV5koZxG7y5LrBgNv?=
 =?us-ascii?Q?P12wfzsIKflBPwUEjwukR2SNbsup7JwKV/yHaqlL0rxMF+0NsKPYjK+Vze9x?=
 =?us-ascii?Q?l9d48QMixrL1fmIHNSfpK6tG5myF1CTH+/UY7DsFpCAfnM7iyDBQYqZd3tXE?=
 =?us-ascii?Q?5MU1Yl+p0Yv1ABBakMLeOBV48TZgeDfTmQUU+fh6fnRbR9ghwemJwoPr603N?=
 =?us-ascii?Q?wC7Oh7pLsmgSsajS7eM5AULB6wPNvk8Bgkw1DPLWe2Z78g7mFBRVYOu8y5Ko?=
 =?us-ascii?Q?tOPJKBerkNHvggF86J8QTZLueKgiLy/IRpaQDcdwubr3A2tuNqWQCLVUCg5N?=
 =?us-ascii?Q?wSlepXoTSIaLYzhCetl8F1Io8WwGF3cb/92E0wR9IoTzhjGCdbu9cL7Tth7S?=
 =?us-ascii?Q?Ac9wFmbVf8ItXSVMQFA5hVAz2owa9yJqfWIqDWpOpvKafrHCYwDGHqvZ3wp/?=
 =?us-ascii?Q?Cy0hCbJVWcr3y6olO/a4Hg+0kw3gAdkwI3MTvLT/vtfyRYf2TMM0aTRoP6zF?=
 =?us-ascii?Q?1V0J3uNTr1U1cdsMiPQf3vBAOWa8WrLtW1lJ+5IlyGc+qCWA+1BNE57S/sZD?=
 =?us-ascii?Q?ogKIjNzHRiHZZ5Kz7WUKAbIvcUPhnLATWFA3uVbgj7YxE6dnGh7yZZf+obSa?=
 =?us-ascii?Q?tXL1H2wH3s0/S8ZBEzfIWrSynGv3SYOxeF+G/TmKYDUmbEBdHE3GE4gTAFEu?=
 =?us-ascii?Q?urH0y1s2nMcbw66KoPdX/NjU17CxKUaLsL+UvUaROnTXsGyWejJvY8f4KWXn?=
 =?us-ascii?Q?gtIjBfDKXzRTZkBn8S9exF9cFyvurs5KeFYAcearvMqpKhbrqbEi9pHZ/ULM?=
 =?us-ascii?Q?3C3oYRB2erRBlypCRmHJXblU0EL0cxXWRboCytCKaZZlWWTmimX73apEhPTe?=
 =?us-ascii?Q?vFZiNTiheD6Y97H0TdRDi4WIGc0sU+iFRDqCdTjjXcGidVA2MHWmSTYCRoG1?=
 =?us-ascii?Q?GnWTJEgRfIp9De/iyprb2VpxBN61sNCcKQe3nJlIgpfA+CrulLUjSg+l+kXW?=
 =?us-ascii?Q?3wJIgRGB+4xW+dnE2AAxgkUdCAHdOYaTeh7SUivNaLZNQQ4OBtfcTd20g8Tj?=
 =?us-ascii?Q?eRvjSp7Zf360xxSd86yMQG7wEanH9cf9vUxSrZIE6lPvhHOKsRXmP3A/R9V9?=
 =?us-ascii?Q?1yeKIm2VWz2mBHLy/FS8zOkeNWg1XFQcLgzd3s6e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b9e5f1-5f96-49f0-8549-08ddfb9a4cc8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 18:43:49.0037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QdQX4Qrt+nHrxWju+c6sUOvaW9aPLjI//2RpiMBFJ6ofulFb6twFfXsqmruG3Tsm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7338

On Sun, Aug 31, 2025 at 04:31:56PM -0700, Nicolin Chen wrote:
> The IOMMU core attaches each device to a default domain on probe(). Then,
> every new "attach" operation has a fundamental meaning of two-fold:
>  - detach from its currently attached (old) domain
>  - attach to a given new domain
> 
> Modern IOMMU drivers following this pattern usually want to clean up the
> things related to the old domain, so they call iommu_get_domain_for_dev()
> to fetch the old domain.
> 
> Pass in the old domain pointer from the core to drivers, aligning with the
> set_dev_pasid op that passes in already.
> 
> Ensure all low-level attach fcuntions in the core can forward the correct
> old domain pointer. Thus, rework those functions as well.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommu.h                         |  3 +-
>  drivers/iommu/amd/iommu.c                     | 11 ++++---
>  drivers/iommu/apple-dart.c                    |  9 +++--
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  5 +--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 33 ++++++++++++-------
>  drivers/iommu/arm/arm-smmu/arm-smmu.c         |  9 +++--
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c       | 11 ++++---
>  drivers/iommu/exynos-iommu.c                  |  6 ++--
>  drivers/iommu/fsl_pamu_domain.c               | 12 +++----
>  drivers/iommu/intel/iommu.c                   | 10 ++++--
>  drivers/iommu/intel/nested.c                  |  2 +-
>  drivers/iommu/iommu.c                         | 26 +++++++++------
>  drivers/iommu/iommufd/selftest.c              |  2 +-
>  drivers/iommu/ipmmu-vmsa.c                    | 10 +++---
>  drivers/iommu/msm_iommu.c                     |  8 ++---
>  drivers/iommu/mtk_iommu.c                     |  8 ++---
>  drivers/iommu/mtk_iommu_v1.c                  |  7 ++--
>  drivers/iommu/omap-iommu.c                    | 12 +++----
>  drivers/iommu/riscv/iommu.c                   |  9 +++--
>  drivers/iommu/rockchip-iommu.c                | 20 ++++++++---
>  drivers/iommu/s390-iommu.c                    |  9 +++--
>  drivers/iommu/sprd-iommu.c                    |  3 +-
>  drivers/iommu/sun50i-iommu.c                  |  8 +++--
>  drivers/iommu/tegra-smmu.c                    | 10 +++---
>  drivers/iommu/virtio-iommu.c                  |  6 ++--
>  25 files changed, 152 insertions(+), 97 deletions(-)

I've split things like this into more patches before, but this
actually isn't too bad, so I wouldn't push for it.

A series version would be:
 - add a new op 'attach_dev2' or whatever
 - Convert all drivers that just change the signature
 - Convert drivers that have a trivial iommu_get_domain_for_dev()
 - N patches to convert more complex drivers one by one
 - Remove old op attach_dev

Again, looks Ok as-is:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

