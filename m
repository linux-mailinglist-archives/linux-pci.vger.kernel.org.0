Return-Path: <linux-pci+bounces-28801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C84ACAE41
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 14:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 697E83B4489
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 12:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1951DF27C;
	Mon,  2 Jun 2025 12:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nSKLvXRk"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FF638DD1
	for <linux-pci@vger.kernel.org>; Mon,  2 Jun 2025 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748868444; cv=fail; b=LriU0N3Pa0hG1w5m08euwM0JqcCAy63HFntPImTZltmV4eyWy1Gs4z25BZEQl89TuwQjdzebFqUkzCTYMYKp0LGcgUtK/eSLmqdNLh/CyAgNaQVH4GW1IJzYLLf2433P7s3RviqCgGJn/oUW7S3kZnSCfi5zNW7v1hlaWbklXGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748868444; c=relaxed/simple;
	bh=JhqZ+qXs+wEYjtoOcCaMrBKfmar2QDoWe5C6wy2czJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KQDWFSsJLB8io2vtzCc4ewrVUk6N1TbhSIOKIWzWQzig4qWYEtf4ZKnGoloM+tPWR70n38DH4oN8SvMSbS7lkqWkyMxXhqFWINGsF9UGolfrKDOf17umfbx836C9Ya1kYUv3tEbGeAY79GnTw9wD0I22LvCOrxmi+n6egglHV8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nSKLvXRk; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDplenp4izpzhA+K+NEJIZjhR8B7sc/5GFkfs1h+vIlKqpQGhusqkxeWXkJwuk3Vd0zrwzEDkxekHOIZyhMeJHNh66ZqgUlpsUursxLXlpoGpjtywbX7x5lz60j3FwJh5MYRotvJE5JCcnd0AagUXEoGANQuxeqbtXQDBhNWEd/qhEASktebIMvYVG9O8ifJgsB5+0u6XXrma0PleGu5Y/iyBBVMizSg8bfU4CRRv3XkrJ/FglSx58t9wqRlh6Sm2rVOawjU5sfyBZwaEjoHjuX1jqXJeOyl+44c0srXRpN3RLTcfdJSTz2Ud7EmwOcfW8xPdk/YtORVfaH43krNbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kerFk/j7JJe2aoZd2GBqDUdFItObwylfj+HlFtdrx1A=;
 b=YkLMxdmCwA0ivcs6FLKw02n2C6X9cDLJv4qoDYTQlK4FG/FXMRgJGFTqBpU1QnrBFbReiRMkM0IyXczpYeuFRZ06cVP6FM9qI0OZ4qUKUVUKvky9sa3IPRIgCfODN3yz9YIntpi3sk1G3nqSHrUCyRd4ZPH8mnTeB91JmiG/ktikGWEpRLhlINuIvW1WNFYGgsfZxrXKq/0x6OJg+1zdcGjJTUFks1i2YL9NHVLsul/QYDLMJD4fPA04YibgqWuuiMbEULP2NCF9jaykY4og4pp4cVinWnRfRjAPhRDPff31kqudgYa1u0N3chP/e1QszSi3/GKPV3DKp0daKfmK9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kerFk/j7JJe2aoZd2GBqDUdFItObwylfj+HlFtdrx1A=;
 b=nSKLvXRk4KBPwQVlYh/o/J66i10dxbIHYB97U4+Ocf8RT8VVvlqq10O/aSh3u0IsevHN+qjxzBUlQ202CC3WHQghYc3dAOLo67+2U3LGlfxcf45rG4pxBJntwiYFxKSsS5+mekVyJeY+OGPNualLWacAhaFS8E5Sq/nOq91AdOMLqLPrRcMdM2Vv1juVc9vFOicVS13SpHklBTO1iGam+iwm+4wE5HIIqqqZuWFNAn3miOCn0Uoxsf589D2CepQmdkcz/uraQ4bKSjcTHgb9p5394QgfMfRJjUe1gFMbdoviWc91cRbqlr4cTvwJvvf6elT/+9kbPRSg1YJ4WFy3Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.36; Mon, 2 Jun
 2025 12:47:20 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%7]) with mapi id 15.20.8769.033; Mon, 2 Jun 2025
 12:47:19 +0000
Date: Mon, 2 Jun 2025 09:47:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <20250602124718.GY233377@nvidia.com>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: CY5PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:930:8::33) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|DS7PR12MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bdecaff-3e9f-4a30-959e-08dda1d39cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L8k86xwB7COrYXWDCKBUa3dDV3EkL2wJiY0CR76juOsqOaz2dMWqrZZvjwil?=
 =?us-ascii?Q?1J0NxcLx6TMSb2PVfRzSQhvoQSd+bYdVDT+2mxZnocF+ZhKo0tPNudSvIt29?=
 =?us-ascii?Q?0u6beij9MQ4DvDFveKV9uQjxHEuKqyLNsE/hmmdBSF18KB1LxzEVjovFb9GH?=
 =?us-ascii?Q?Pda8Ms4dtCAd+7VHekv1WWySpx+o1Mt3AVJ/lBsXxdiEtKNxH1iezGl0hElL?=
 =?us-ascii?Q?LdCx5TIblA38Icl9ZBxRqA4TQE05HXKgTJ1y3w6c1WWU7g7Yqpf6Am9bL46d?=
 =?us-ascii?Q?gj3fglX3Hphv5lMTirqvvoCl87GSkXQkT2P9B/oLVNvqK++X35X05npuaDUb?=
 =?us-ascii?Q?0D8ixH8C39rc+kxU1BprEmst32asDqL4XqTdJqvkg1VgsIED3xzPFXpdCmQi?=
 =?us-ascii?Q?LxjNy801PyW7xYNbJT1a0CAqUuTdcdqkEnF/2PsSijTdAfEmNOXc1snnOHtY?=
 =?us-ascii?Q?uhSjU6U92wGVWdAJHxBIHmd/eTTDIq+VExai9V+6aj2eb+npYuPFzVkRORAC?=
 =?us-ascii?Q?CFsfwLLzzjds4eDvLy27LnKA+EufKn/OAIVQeQHWsDHaf81jePZPuCzsQ7II?=
 =?us-ascii?Q?z70HEc7PuAtdhyCtSy1mlUCVCbuGn1SkENXEh9NfAZIcaQgEWR/R/y2GyxhZ?=
 =?us-ascii?Q?A6bkgoqeQg2myq5DS6wetoP/kzViyGT1/su6uZxQTHO55681ODBnv8OeazSw?=
 =?us-ascii?Q?Bl3oBqD2H81hS/cJD3KhRQzqhU0voQBobEbYUqCanWd0leShO4f+4bU1KzkH?=
 =?us-ascii?Q?5ZZzHsiP70sR27p/OEvepF4P+DrqT9z5PRJcXwOKLgZTbYVD+ALBbA+AMfN3?=
 =?us-ascii?Q?eKCtvJHPvLl5xl2fInlMev2S4p3u9UxNYluR2b1PJ1bw8t/q3QkeHS0XgLLP?=
 =?us-ascii?Q?XYDMvXBumjwce+Xs1g5yG5wakoWnFk5Jb9/ARCxKlU9bQm1dcjf9WRJXdter?=
 =?us-ascii?Q?k0thxxlg+Ku2XKZ5ZeAZ7n7ztHQK5Uq6K06O7fhJNXgtYaXDun0vqjv/j3YD?=
 =?us-ascii?Q?F/k6dF9KVQAZgEG+tQaI1ujnbhbKBm98RmfnTcrKnTigV3fZS7T2FWqo3Zr7?=
 =?us-ascii?Q?Rc+Le8+oHWv2nEQ1p+ikK32iNUTAZCqLVSaayUfpPWLtSG1K57XMRUDrtleH?=
 =?us-ascii?Q?OlyBfwrOztFfXEpPTDS0HYqZNF65cWOrBgxq6gw5GfHNd6dhmeq/ipAOXej/?=
 =?us-ascii?Q?WJ0zgyjGmP7QXEzaDwl5PU0e7Sxl1UbJcV4CMc9xCgzU78XirVCxGQ3o+2Th?=
 =?us-ascii?Q?Cl7Xdy9D+RZuLgSQxfHqH7BwvTpZGzAieD+6gaf150xTxG0OVXi4ocAbc/VY?=
 =?us-ascii?Q?f4DFXYHGzQVjogzgFWE66SavHrlCWjh51aFbjKA8M0CmPC4/eC5MRhcBLoP/?=
 =?us-ascii?Q?CbzspMMb2VPrXZlG92/uXTvDhcSVTgjZsd0NK5mlIIUwJr1bFkWI8YlT/E7i?=
 =?us-ascii?Q?WWYmghAYHvs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jDpBJTseMCCQY+UFih8Mt/edTOL8HLLMVeAuM/U5ZEpOmi2Bi5uAbVqm73lZ?=
 =?us-ascii?Q?T8kBAt3M1V3ESGqO6Wr3p+ushzGDpCcNkbDY3D89TaCzwoQ/vaG6G1XSkRbd?=
 =?us-ascii?Q?segRJDm8l7Y2BELibMPbV20OvmxhvALxZZFQMBTjESoUZyTk+lANx0dVY2xB?=
 =?us-ascii?Q?3OM2WOXWptEEliWYIDRH2zDcPP6sly4tysrwHAo4AKSlU0RwWvgrS1lXPwFM?=
 =?us-ascii?Q?+TFPZee2kOpuKgAxGCRgcoWCF4blOUeE8L0fspedvO8KxAtHk6x6E252nQyR?=
 =?us-ascii?Q?GEFCpwDUe+CWvn1AYFQ/p+ulku1V8pAEpzvocZxZZ3E6aZFhXsxu/v/GGzLn?=
 =?us-ascii?Q?t/zLFBXZj5K8D4SxBLoynAENqrnL2lqLccBmNni4kGXMBR7m/YQPGfS18ji3?=
 =?us-ascii?Q?hzWyLHSXM5JyWqjukQc44FyJL0OU+DCTs3WQhT8bbgCr7WKRUlq0T3tMm14v?=
 =?us-ascii?Q?mq8u+QPuPC963wzwKKl4XDr1TQGAUCpzhBz+ZAiNgIl2nFRGbAjZHNUzvjKJ?=
 =?us-ascii?Q?asXnmiP+AQCX3G8b8M1bNF9jdwhkgHHgLrGdFW+4V/qmlZFJjIbJNZjSgZgS?=
 =?us-ascii?Q?KGuf4vb01Ma+Oy3iuQ22ZSNDaiR0BlE2eU4DXu674VL5JnfZ2H7q4lgbXIlr?=
 =?us-ascii?Q?8MfRzNjigWu8j7azSSPZJX1w4341rEexijnWXnEQXuHsjA4YCOSSvTl7uN24?=
 =?us-ascii?Q?zeTtzhhbD4nlXbYzt1J4blPH745QVxKX8xcnAwkK8yBevq8E4YW6x+8tP1y6?=
 =?us-ascii?Q?q1sVANn7lRWIsp2pEI5/Td5RZ3vXMpGGnTzIzEzth3gQgSuZpNu5J4hgqd5V?=
 =?us-ascii?Q?X45RofVl5XrCwap6Gh3TnwSxUQaIE2EAJLAts9H/l8DnYeKcM7/bPhXV5Pbd?=
 =?us-ascii?Q?lnSNU1SUfR5qukn7z/auldMkN1nEkz4N2JDzQKDquuv9O5BmhiPKrYLxzdEm?=
 =?us-ascii?Q?yM7myRc68FctHtAwheGFBT91JNP7pHCbgHbv/U7d244S35YE70BQTggj+B8a?=
 =?us-ascii?Q?yrZhcP2A2fGj0UsTGsO7Z//JUrhoAyOGT2SBbHcN+1PGYDRQ3GDGVU+JJ2jX?=
 =?us-ascii?Q?x8Q7uAUXMhbxxxdU0HSQrHT9KiAE2q9/EgspUzsie88OKXjxK/kcKmTDeK/T?=
 =?us-ascii?Q?KJkB99qCwev/SYHHUkD8c9RWHk8MXM0LOJCVu6BqxRPnUuKZFxxcThPXX/Gu?=
 =?us-ascii?Q?XDuGZ8LTjq0Q7GUoNJaJkhhq2fy5/0Xn7Otz7lhquA9y5kKf09DYLEYKSHLi?=
 =?us-ascii?Q?nxHCXYIQ3dgFsoPde3Hft5r0yTKTgv5dlUyF1/874T3F8/2GtCp1+IIs4dcm?=
 =?us-ascii?Q?KYI0h0GjV3K2lryN27RzVOlBAnODHJ0SfT/QzhQ5L0MR37r6RnHTGNWKRufR?=
 =?us-ascii?Q?mj1mksJ0QSNpK4lNv2iAbzRmodSYuCsP5nvinZfZGh1CZe5hX78VqebJLn7e?=
 =?us-ascii?Q?RedG4QcsQ/4TNFiPk/a7WIb8YREKLDbiUnijPJubr+guLP0Fk18FwC1Omkkf?=
 =?us-ascii?Q?xOGBRhXwu7G5FMEOaIuOVp+5cK4dnNhvwnJih/9y9kP8607xGzNQQFkf+Sle?=
 =?us-ascii?Q?FgiYCOlidGFL15/ujWAfLMoYD1dr/cGQ/Bs7dloi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdecaff-3e9f-4a30-959e-08dda1d39cb3
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 12:47:19.7781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yR9NQKZG7jeRmBJ2ZUE9lLzn5tH75JqA/XiT3dDq0hqfRoIH2smOMsaRat7q4vkM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813

On Sun, Jun 01, 2025 at 12:25:15AM +0800, Xu Yilun wrote:
> > + * struct iommu_vdevice_id - ioctl(IOMMU_VDEVICE_TSM_BIND/UNBIND)
> > + * @size: sizeof(struct iommu_vdevice_id)
> > + * @vdevice_id: Object handle for the vDevice. Returned from IOMMU_VDEVICE_ALLOC
> > + */
> > +struct iommu_vdevice_id {
> > +	__u32 size;
> > +	__u32 vdevice_id;
> > +} __packed;
> > +#define IOMMU_VDEVICE_TSM_BIND _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_BIND)
> > +#define IOMMU_VDEVICE_TSM_UNBIND _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_UNBIND)
> 
> Hello, I see you are talking about the detailed implementation. But
> could we firstly address the confusing whether this TSM Bind/Unbind
> should be a VFIO uAPI or IOMMUFD uAPI?

I thought you guys had moved past that? VFIO doesn't have enough
information so iommufd would be a better place to make the call?

Jason

