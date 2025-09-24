Return-Path: <linux-pci+bounces-36901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0160B9C395
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 23:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E96267ACB3D
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 21:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D20283FE9;
	Wed, 24 Sep 2025 21:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="doMmKeaQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6699226CFE;
	Wed, 24 Sep 2025 21:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758747757; cv=fail; b=Jg14FtBIcHpOZF6/nr+/F3toGCk6iDa99jNE1pfDOTlwLh6/KVdba2ffpocNkZpcYGHVTShj+p0gsMwbE5liDDqPCPXNyhKuiVd9SABmjZh9wSIMnrVTE/fFBWO56r9jAIU7fCiM6HKSKXCo6nlXVhrM3exzxO9FNvybnNrHN0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758747757; c=relaxed/simple;
	bh=wyCXQ9x5TQCrhtcm+Khx/xPwStfI5lYgIsmO7OreCmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XPuhTFMO+wlXp3SXvPioGsatpBlYVuxZmRm0cmTeUK5kivfZSdIFn1z2tkCHisLnOrkKVM33GcR5xoVW5BkCp/ZiBW7EI/hxK4UgSOC9HQmjKT0Qkg9BnPpeooMZB2GtmhqM/5lQjckNXPGQ2+RrxmtVe3TAqmPfq92dJrjgd6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=doMmKeaQ; arc=fail smtp.client-ip=52.101.62.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=miQLbuj5pjmPg8wjD8lGiM7I+D8rofgR4Bixk7fFHzmrbqCiqpg+x8HI+BWAUwGf5QEIMpGYakiuxUj+OQPQ/yWr+3XCa51OfAgRnhP9VxU9TpW4+TJYmZzy2VXboRxd0lDUpyYeGJp64uUhKl7dvXNsF/YPrTd/Cg84K2zhVesGvUi7Ba3V9Za9f7kyzg0kcI6BrD3gSn+efizhv78kopya0ryHeieDp4/NHQHwULoiwb/5EU5B/k+h/tx8rqcLsRP0323H8MpWMAsUkNZfV8rpove+msRell6tSpyZF+BVhj8qT/9tN+/D9t32NnfWb8CrZssyMJYgSyjz1p417w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNojt7aMVflgWZMZF/1yfftwQPxOFC3B//05vtbnNE8=;
 b=iIQb5Soz8KA8uj1UgnrXlaWbtb9ZsDQqgs66BkHR4ianyfDhdcynfLRIptP0vhWOnIKYTmYrrXK8T2s8ZeSfkx82OhZWqeend9LrojWE24bxxUeLabVLHoOu1tYapQIewuQx7T/WO6WSzqYg3pDwXh8R8lIerdcIiLBEuWKbewR4VRGoL9Si1I0ydvJE2iONE+E1DY4aFg04kBUlJ3kaVGQlCiEgIafCORsFqGBI2MfWzzxVqL2si9Lww+ykrJqcNHg59HgDNvfgqMbB4k/WYfGT7XPXGsNScZkXc40bEb+9Og6OzBgHTVpDM9CPOdBeInCSaGyEOWmxVu0js2n+Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNojt7aMVflgWZMZF/1yfftwQPxOFC3B//05vtbnNE8=;
 b=doMmKeaQtoi8yeYARUMLxGN7qIBrv/es4sxPAmlsfLurbo01RPZhUSIMQTHfv721beogMInIScijBSIknw5CLIyYXKCu4TSUnNAL8GvJPCYl/BFmEkvq7kasuqBQzqintygV0+z6/aZvL+sOr6BOlYS2Kdc16PRQS0phJQpNf6v7s1x7ytn6Fy3FTLCOmjngsFd9ES0Sfu0lx87ibtlM5QF0oezZw1LR2vf+ez/qKviicp2FGVNH0APrLusGqCJw7eLmo2LCl7SqcP0W3syu/NmigU5RmaNmkxRtWA93aUwPaXXE0qPh3ER1AkV5YdJIf0XoFevhrQNC6Fa1NNZ6Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 21:02:30 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.021; Wed, 24 Sep 2025
 21:02:30 +0000
Date: Wed, 24 Sep 2025 18:02:28 -0300
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
Subject: Re: [PATCH v4 5/7] iommu: Add iommu_get_domain_for_dev_locked()
 helper
Message-ID: <20250924210228.GM2617119@nvidia.com>
References: <cover.1756682135.git.nicolinc@nvidia.com>
 <c9daeafb9046bed9e915fdafe20fe28a8c427d29.1756682135.git.nicolinc@nvidia.com>
 <20250924191055.GJ2617119@nvidia.com>
 <aNRLOsomtHNumaSY@Asurada-Nvidia>
 <20250924195254.GL2617119@nvidia.com>
 <aNRObmtcUkYTworw@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNRObmtcUkYTworw@Asurada-Nvidia>
X-ClientProxiedBy: BLAP220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::9) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CH3PR12MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc089ef-f2f8-41bf-b3c3-08ddfbadac80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HN9MCgHfnMwp+8+QALWQd9n7lwqyOEZwHb7roaj+zKJf6OewNNh9wuhPd8lX?=
 =?us-ascii?Q?pycdFFWpbgt1F/O0RjxJmcE6uZd8ajoxwcVF+w6uclo9cgnxKPgFYvs5ipeI?=
 =?us-ascii?Q?MfWfIGwYg5guhpmo8GggD4EE+CZYE4PLct19ADyqCxOsU2wD3PJ+XQV13j0g?=
 =?us-ascii?Q?YUyvi5Z9qQ+d7UR5FfrsCIKcy6sQwVj39l7VJFY2rCAwviS1UVF2MdG3EN6z?=
 =?us-ascii?Q?rNMRW+QIDtTbI/Ai2dIRXFGR8ipgTcXRXAOxiCokpskTwz1JTw/M7mFifDVT?=
 =?us-ascii?Q?Xf/GSpbNz2+2I6ZdRBZG1C55eqZGTS15z1UuqKKC3Ln35mw9pHuaoqZV/tDl?=
 =?us-ascii?Q?YfNSTNSZI7q/Eo4J1iZWtS8qOYZOVr86y9PuI8k8NTST7/S6+hHTsJNlIA0g?=
 =?us-ascii?Q?rdXwHb4JLVg7m0OACtAk0KgEV+EldBKLPU5bvydphdTPXITlIfJcHUj+Dngj?=
 =?us-ascii?Q?9cHe5EgCm+4UjHDpTfjEJlj4PfdIkeFbxYAiEM5QEU+whTPuo0587EhoEqYt?=
 =?us-ascii?Q?Tfh/AvbXbC3iTncyn7A11J+GMcBk9GzdUge34PluXghfwpKi4NkyGz6EoIn+?=
 =?us-ascii?Q?OaLhNRC0EUXTjVjCpt19YEtwnatyJix/bnz523rd+4SbhOY3IfxVBPU9YUET?=
 =?us-ascii?Q?iiIluX8I4jgMAq/3y2UEvuGP3h9I3KvjBPsZwN0or31wMBglc3FxKgkvjUaF?=
 =?us-ascii?Q?wk5BfUIKzb+UebOX2bYL0KBfep2TpT/kEhsYkM0pmUcCMbu6prXAeV2g8Y0I?=
 =?us-ascii?Q?qfPnRtI07ikLOFy9F02fWQ40lc1MYBosB2J/iMlDyoRlIzdjALwRMPNCc3Lo?=
 =?us-ascii?Q?X3XgX3TYtxNiuYjPOuRBSBCQKVUTeCTy6TK5eazas0hyuBxNC5OeH75ioPp3?=
 =?us-ascii?Q?hSQ3m34gEuAjGnLBWdO/AHk+TaXFFcEQeG6s3zwZpjObaT8JtGjbahT9H4Um?=
 =?us-ascii?Q?6uJ/3Ft6WRJFrJbi40xkE8XjUAwny8eyU3oTHVObFtQw4lnH7kbukgzhptp9?=
 =?us-ascii?Q?ARtqUOYfAZWglQHtS/WIUftYravvpnFcylkHyDcWUcecfPC2Lt9tojWx4LCj?=
 =?us-ascii?Q?BTFemJkt1nVX1di6+4ei8Gj5MCKE2VsYPnGBwz0coPr40ozK1K2eoIhtO4NM?=
 =?us-ascii?Q?zBggKr9pQLs+uq5hwJrc1jsuV/U1zJBLqZs0vljysJjz2W/m1J+VoZBWSgkr?=
 =?us-ascii?Q?KjL725rElRFZfoZdptHQOvRfuLQCxruiiFTf1J2c3i8SU3DcIG2F+jdAQHwa?=
 =?us-ascii?Q?8kKOmVWuC5IMfDhr1dvTIuOIgtYjHFEq/AQ31wwSnxcVnoOX9BaHcYSHAWGz?=
 =?us-ascii?Q?kXMfJr8HoOp3ylxMECl+KqhDP84m0KB+x73Kwz0x5LB9X9t9eD5CJToxIQli?=
 =?us-ascii?Q?AawLSP91jzinRf4jfGtqQeUhQt4u6PyMRYwkGyL0NJlwgDTAj5I/lz7ouoFW?=
 =?us-ascii?Q?sieIEsDr9ts=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?llu2qpY0s2eoOiIYovn16JfEgXyp1x0Gxn7U0JDa+0i3kAnV8nqg7XSAbN7/?=
 =?us-ascii?Q?V+tsS9uSrj/TsV3Tm8Mx5zcWQ4W/i11Zy926inoQyE/LfT3Qz5GeFkuGII2h?=
 =?us-ascii?Q?BynuplbFA6935+w521aezby7ew32jdHjQ6VVVl2YSPg4I/GeEZE6NnlJZZ5S?=
 =?us-ascii?Q?5IhoGo1HmW16I+23AhWU5ndMTyV/Zv7BG8vlvSFWYMsEUWcvcpirwWx3jjJS?=
 =?us-ascii?Q?Xb7OCR/qmukhWiRXnrb+/lXKBqURK/G2rArcbHxkJu7Fe6+lie3eCDFL8JxD?=
 =?us-ascii?Q?ss45yoDEAyHme4UuOyq0o9jznI/phOB+JrNBCidJ+HF7m56DFx51TOQmwjjp?=
 =?us-ascii?Q?GzdqjEXbUJitfSyXJuG5rUyrEqzr814wdWqJHQhoBnC80uhfKjqf6NV9+ox7?=
 =?us-ascii?Q?vaaaO9LNJYyDbWCwiw/Z4ivl0rWv9oscoL94QzWbfGSKvgDlu5lckEUn9/oy?=
 =?us-ascii?Q?33DbUWm3IOLnIpjWA5ZSnnUcR7fJYAFYoJFdCNcHFWNFiZUDqBTyRrrjE8Zr?=
 =?us-ascii?Q?Kvu2yXT5K/LJGBh1Dz6Ng2pKs//QRs3qpU0SChG6/+igEE7kFpkqsalcnoSY?=
 =?us-ascii?Q?8YIHXUByKCmpvxY5wIAmHXGDM3mkJGAQioJnm2C+7PYIzBD8Ufo20Vdk19H3?=
 =?us-ascii?Q?F3Ny+gCs+oW2Jun/pJu812IJHN4XrXVR9TutT9fn9rPdn6s9j+oXHFl6DFI/?=
 =?us-ascii?Q?q4ANsNvYuvIChBUqzjBXneNedZhK+iUTvu2m16uEcZeTPS/sReoOJ3Pijkt7?=
 =?us-ascii?Q?SR/ssJSl+2lnNrU9BM+1vqHFyEzCPUKqPpbddqkwzUZ5jiQBNZzfTnHXg431?=
 =?us-ascii?Q?1FLWAT2mHnZzduvBEctN8dFjnRUUqz9EuLL1Ya9EsoStMoDyLy3Wtr6PXjJE?=
 =?us-ascii?Q?+qsmf5bZ+e5AFfYjwI4qCu4I+vwrd7PkT8EvAQnLfXvNgF0yJpIlHQn+lkDk?=
 =?us-ascii?Q?rcPiiTAmnZ8gBalNGxNWxRgtJoN5rZLyOiaTILhfq6v57d8Y7SZP17g9EBsY?=
 =?us-ascii?Q?BQMfLkrZGKSBKTmKgewTvEAQEJFAPX3ZUua4WPHaVcsgiQuJYcvzJZ6aCCET?=
 =?us-ascii?Q?1lldZwP8x7VIbtwgqB9SGTkG6sHDtgtxgofwlZeKajM+8fLGs4R7KuY/ahNC?=
 =?us-ascii?Q?OmMQdPrcSEjGl0D+BbGO4uUAFPZfacOWx6YMgdYyffyWge9SEUtjVJNEOiZP?=
 =?us-ascii?Q?QfBRj9vGxD0G9tv9NaQkCREJRRudmpxyNFXsSWLqMKXYH5bf+zKnhCIV4N/e?=
 =?us-ascii?Q?g7SF1EqML+ENE0lG0OewixIHDtM+SCIgvAcmuKLVXBcxVGGFCQS4Dxbl2Atf?=
 =?us-ascii?Q?F6nq5PCHyCNSwAdFrbG+ynGkAUHQcpS7yWiuCP8rajW2jEaMQAyQbjpiBsqU?=
 =?us-ascii?Q?IDFedulN3oAaBercVL9LgeL+ylUrHWZDYa6Zp+l14ydCGRkiQz+1xQfh7dr7?=
 =?us-ascii?Q?nQz887L/Wj7f7opXPErLaf52+KehGwebIQRSyYgbqpwGeJIEsMt60Kv9KNMM?=
 =?us-ascii?Q?VjxYCzs+WsHTm3QWqZ6GOx3kPQmYgeMJTvfmCJ+oSjogaX49ll5zlBKo4pbk?=
 =?us-ascii?Q?yiN8VtCjRDFpSs+PC9y/EzzkYnDlAqJUe7apPu7L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc089ef-f2f8-41bf-b3c3-08ddfbadac80
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 21:02:30.0895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FR9ue+xgoyRVvrOoIkk2uaqr3m6O93ZubObdMPfJqo1B7ZhQmHA2NI/RW7XftyRy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9194

On Wed, Sep 24, 2025 at 01:02:54PM -0700, Nicolin Chen wrote:
> On Wed, Sep 24, 2025 at 04:52:54PM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 24, 2025 at 12:49:14PM -0700, Nicolin Chen wrote:
> > > > I really wanted to say this should just always return the
> > > > default_domain, but it looks like host1x_client_iommu_detach() is the
> > > > only place outside the iommu drivers that would be unhappy with that.
> > > 
> > > I suppose any external user that allocates/attaches a domain has a
> > > risk of potentially using this helper, in which case group->domain
> > > may not be default_domain?
> > 
> > Yes, host1x seemed to be the only place that had that intersection.
> 
> I meant, we cannot prevent others from calling it like host1x does?
> 
> Even if we have those replacement APIs that we discussed last time,
> such a driver might still want its own domain v.s. default_domain,
> for pgsize or other use?

If a driver allocates its own domain and attaches it then it should be
able to track it and not need to ask the iommu subsystem to give it
back to them :)

Jason

