Return-Path: <linux-pci+bounces-36896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2D3B9BC77
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 21:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37EB37B43E6
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 19:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83E825785D;
	Wed, 24 Sep 2025 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ad+Ify4o"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013042.outbound.protection.outlook.com [40.93.196.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE82248896;
	Wed, 24 Sep 2025 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758743581; cv=fail; b=kPG5nms5vnRYLwnHxtl5CcIhRQZSpfkDSflLxO75KdEgLkmEGlvkrI8MX3j8FnLCbPy8nEurOXZTtUX+fJAOEhOchIBeJGKT4kolF9gaDpx8tzw1TnlmT6kNd9yQ9YHs4chhMF3rdfdnYLg9A/58tIdJL1m/Ng0G8e4gzi+Vo8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758743581; c=relaxed/simple;
	bh=X4gTZAgzj0Acm/uTF1UyZ8ASgbyzxBmFWVd2R5VkknA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qOlXf12jIejGUrPSeSejYwTrWdezrWLOIRiW50GALDOuSz+2Zavs2C/jbZt30SuMNWs/dLS/LH0jGWOGE3Hs/3ank8UrtF6yXsolANExV4c0zIH86javP96Mv9eT2N7KRK7UdLdibvpTUvmRBAaCLplmldEZaIl/uvvajSCcseY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ad+Ify4o; arc=fail smtp.client-ip=40.93.196.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/RDsTbfpqDIsn/NjZycNqmqnDfny2VH0dCUJv5Fy1Vu2lIL1xfU8FS0s6LTmHBU4x3vKiefZjkTLrgvR/+cGL4uESgN3NhBvykab1fSMeID4bNDiUfqEedh4jAe8knNo+RXRIM/oohJ+RYTL1Kr1ly67fUm6Wf1Zr030vU+yYAlZDFwoa7yS6npn07Yj1F0MdM7VMC3DGcS0etELL5Z8ChzH4vdDmnhbirj6iAcX5FPVhaYgwLDcVAuNJQBQ/i1hOSGBp3u5zfLzRvWPJSLZG5MvoffHZ+h8/XDw5dMQEk8Big8BDxbMIGCVzckm4mqITHUBQHlokEhhDm1byi8mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h36M90qbEvch+tm6tddJtlbDaQTb6fMH/sKMkJ6AupE=;
 b=HIBLDsTfpjQd4AG1l+3TbOMX+hZlk8X0RVhYh2GxNgIDXma2tdDWLT3+nHIG0oblp5oKlzF4QH2kuwKhQlVofsOJgiLRPGwvM1AzSY+Moge2Z2GpKl7ZbFLoH8rB0CC0/UrM1P30+aLX44R2+It+BvgWwjS8BVDV0V7Ea4zNg9D4DprG7pTahkrkHgDq1xZgJKWsbBD8bMe5Kruqc+uWRo/c6UL4M/0BFTnwTZmUIngXV9hAWs5A6KX3dSDFEV24ICwH5XVuFClwC70GjJK3PdhuT9J/8SnE/4g9u6gobILMYUetDP5EThA4TEDm5PNZne1wSYK7ZPEmilvGfEc7tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h36M90qbEvch+tm6tddJtlbDaQTb6fMH/sKMkJ6AupE=;
 b=Ad+Ify4oD6j3O+2Xw+F7KKRpkBRfxx1202EZy8oJ7aqTY7i6GOVCNabb1AOjgTfQ3s8185b08yKEtv5vqPux/s8wrEm2cLautGEcbeCXRfHsD5leaZ8sp2tRp4+CsSQhk33onvM8VTrdqXVm2a5uvcIHXGYOAJMpBesEQ/5WDmwQFs0kFRM/6jUG4klJmpJus5hqm9tdYh8+xPSHcwjSE9BE84CTI86K+e5ukRIDD1XXKwAurdjOHDhJ8zuKEB+8KGNH6ROJlYXkQoEi1vXfMVNqjQqnAVintGl85IPQG7w6Rgk2NthVrcj6kGhsvSX6mTFGQZP1hQzyc/6kGZn0Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by PH7PR12MB5617.namprd12.prod.outlook.com (2603:10b6:510:133::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 19:52:56 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.021; Wed, 24 Sep 2025
 19:52:56 +0000
Date: Wed, 24 Sep 2025 16:52:54 -0300
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
Message-ID: <20250924195254.GL2617119@nvidia.com>
References: <cover.1756682135.git.nicolinc@nvidia.com>
 <c9daeafb9046bed9e915fdafe20fe28a8c427d29.1756682135.git.nicolinc@nvidia.com>
 <20250924191055.GJ2617119@nvidia.com>
 <aNRLOsomtHNumaSY@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNRLOsomtHNumaSY@Asurada-Nvidia>
X-ClientProxiedBy: PH8P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::34) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|PH7PR12MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: 7259264d-3500-459c-be2c-08ddfba3f507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X0NFKomuYlwUxb0xbljlrmTkjD3xnlKBNTLwE6rkluETugXVsuqUIRhBizhB?=
 =?us-ascii?Q?JNMaW+vJ57wbY8/Tdg+fq1GhR8WhlKHhch4AlG5V5FfPWLDcwAAt20TV9A3k?=
 =?us-ascii?Q?YHJwc1lNqIx5JYfFTQmk7Zh+3+krpOOo/eF4pdMIaibCKe3Hh+ZCZYKpfChb?=
 =?us-ascii?Q?fjul4ja9DC0nuU3fAE5Cg/S2T33a+FCGqwF2PnaspjTw6E/X5LFRalcjlVbl?=
 =?us-ascii?Q?2YaOcDKo5uk2ydHlexH/mUzcEsijx54lYj7pawA4DI6kSJcvXIs7OrDl1hUb?=
 =?us-ascii?Q?m6f2XOpc+hD/mT6pbluizw5Z9k47JdxRx8Z4d+gRwbyxcr6CuDYMzUfTurIr?=
 =?us-ascii?Q?HBvhB08RpgHlTUtS7SwuYZpF8713yaoSxcJwpj6XTT5aKlZsbY/Uu9IsHzSC?=
 =?us-ascii?Q?/dfxv2mkWepyHSQA5AXecoZDylParXBilbJRYsvndNx4F5gQMzQDz3tNy2Tb?=
 =?us-ascii?Q?HCeblHQe6SF7tmVuJ8yfwQT8HcFINuafTM5xXHofIgtOT+jCq+rvyeol1wXx?=
 =?us-ascii?Q?ovRcFrKW0MmHfceDogayNfXJdsl6M0sy5wcl2/Q3nANvXffnapwsLlI2zZKo?=
 =?us-ascii?Q?aEeooGC9kG8V6UBRhmCwKiCP/cAuZsRA5/xr5h3LnwfMm02ro8umDUvsG9lj?=
 =?us-ascii?Q?mVvgXChf3FWsbx2vBotFDQhTFkMx+9xDjcQwvmmxzdV6I7DV4KpA1dHdZiPF?=
 =?us-ascii?Q?9M52XEYP+sL3QZU7QxBJYwiM9E4xaNemr4UbvVUYMJiyeg4kpBsUbln/XvGk?=
 =?us-ascii?Q?A3SfWRo2rS5ykNlSGGKoXhUDsFfSN9zIiFSP8cbiNGl74LTqslN9EFYe4qC7?=
 =?us-ascii?Q?NlK3kYqadz2Ke9MzEko38KO0+oSEK3dU/bITXMZazdM101j/U7H0AZzpdxRf?=
 =?us-ascii?Q?FaG4MfiiXOoZxRQXin0OmRVB9+VvNQyVgBzp9qyj2J5eWaWNvyHifW0LoHuX?=
 =?us-ascii?Q?mEMahrmjb5ShoQhrAbiORj+n8XbFbRx+gO3ob4zChdztFmoKPwHBkr6Ci0mw?=
 =?us-ascii?Q?79H7RwGpb1QQfrMhhQ3lULEPb5/lxcqe58imObFXq6tv/BR1YpSo5VzWuUqP?=
 =?us-ascii?Q?xZK3LoCSYjg3VtZqP4tSC23dBfmcm1eDh6K8WdC7xzJ00h6JOnl3Bblu+hrH?=
 =?us-ascii?Q?CwQUaE86LaQNuntZCSvRUVoIN8JgNrW3rQvAGNlcrHgtYNyyO7tDK4kvw3vC?=
 =?us-ascii?Q?2A7Rrk0IA8+AyGavheku5uoJ0LslNrQzrxxlpYu9QQXiVp4HopmwF/Q9xsS/?=
 =?us-ascii?Q?inuNlcIU9W6e9UDUQEhY1EiqHHUihDJRjzxlUC0M1yxWHG7pajbkrVsaLw2H?=
 =?us-ascii?Q?4ftOSB6EA06ebfU6Prs1Yk6plL/7Hxes9MkasDdH5iF4iqKn1PPjFsbnbi8t?=
 =?us-ascii?Q?Q0/5mPfMH96o6a5gtV0qcGmKvOIalcJKOK/AMONmSiSqfl2e0rloZU/EhM8D?=
 =?us-ascii?Q?lAFFhaQZsgM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8YFdti0BuHm62IA4FN7/Rrf5eQ1K9lRo6qycyzTALCbt0OYkPMyA8Qv9vxk5?=
 =?us-ascii?Q?sehHQlCLcBlrswo+k5W9srQlIj/X6+API3f9Ywmjyw20UNAkGCVJ4CJOI26r?=
 =?us-ascii?Q?64JEWGeTHtAnBLvD6Uk3tVhqOT0Kjrb6+ps+L9m4tUeJ/oCzJHJSKwf229xB?=
 =?us-ascii?Q?SEZOBbado3exRvR1HTvAPAH/tWiV6YeLrnOTbVyZhZ+rFdgODp3SRw5dLXZ2?=
 =?us-ascii?Q?2pxvCJ6415W0Ow3L2ZORWw+6I3l9lXG3vlwqYv68T0wK01lLRp6040oNKDFu?=
 =?us-ascii?Q?DGaai4eG8LtghymNnUXXKCVvGKGI9BCxKRr/w1oQe03lbp+Qpi9uwhfJ2Klm?=
 =?us-ascii?Q?lE3t7mNMzcw/WyOJrq4Q/D6Qn/3BRKLy2INR82W5Rds/tZLht45caAj/iFTp?=
 =?us-ascii?Q?1b+a91SWsQ3+eI6wLv0h0Lzrq79Yzy7l/h4wjkzTftxU3iG5LmXOHOZDnyDU?=
 =?us-ascii?Q?b0TnWsj73L39VdoIdmh9EnfqMxMbjwaV7GF6Y5UBLLAJsp7Z5dEy+uAg+AQu?=
 =?us-ascii?Q?WL+paA20T83HmQMytHQfVwolF+fhTp7oA7HItJC0Ho8r5akFhMmVvaB7hdBf?=
 =?us-ascii?Q?Gy93cwJW4pRbKRC2yiWRN4g4u+GhcEMvnfrpT+0pyQVgbeV5ILVEsYHvI0+W?=
 =?us-ascii?Q?zqD8BmnG9ICH9djsmniUtIlYNOnU2ClbOug/uw8RRL6ZyjyabVzCAf/FP/wI?=
 =?us-ascii?Q?x1H0LtB6SQmTzaJrWlKmiKTEABtfiTCGl+ssuVIMP6ccZZ/00ice2z1PmZOG?=
 =?us-ascii?Q?sYJetbARZ4L8kZUvAG8I2NPg9LB3/27tZY3WYH1tNBI/mySpsckgUZTC6R9M?=
 =?us-ascii?Q?Wwqgwp6VdTLT8cM307UNN5RrsWebfS1WQpg/u1a8uclWQp9niHH111JI8pes?=
 =?us-ascii?Q?igTAMUXusvJG4eU8+rHEWs6VFosqqjh+oL8aMkImHbtnW6qT5cIDi09UaJ9X?=
 =?us-ascii?Q?ToWK1+eMEodXWiXq7bGeIj5S+tBWEQoIAHY/aSVPK3rVj8tv0akP+RrmDYe7?=
 =?us-ascii?Q?kY4tPGLruz32MpgqGBqQaOiyDq47mJnvK6RRIGm4RDIBXV61AUQWIU6XKbLU?=
 =?us-ascii?Q?QBBUsiJmbMvKaCwdfHd4o1a5DORk2ATbUaFaL8RrOc3/G+u9u4UWx6VRnpB5?=
 =?us-ascii?Q?c7UREv+pUm6E+2zk6UAyEgMyITZ2UrotpzSg2m+iRoq5de9MY7jFdym2vYHz?=
 =?us-ascii?Q?RdvvCV/OZ8fZxDewOkDd89ZcNdaZfXX3hQPwBXqQnVEgSb+YUCxgPcDmiIal?=
 =?us-ascii?Q?H7L+mEW8/KFMwr/S0yV0ip1VGBPI5D+cN9QcukSGQdhHCc+i2gT2BRCPdZxU?=
 =?us-ascii?Q?ACi2joFPB9klGWSPFhuLMpTxe+HUrtoCYwHxY+NEki8u8n+AmLSyF8TxrWMl?=
 =?us-ascii?Q?IhcwDYcxHwK9Np5Pz8oAcZOjr0SChKEDBtwED6qdagzi/EiCVICusLPR3AOt?=
 =?us-ascii?Q?yfZ7Mo29BDb2PoQzCFgduGOKVgDkLHkUW/XI6mUqlGYNPIR/MnishSt63dHq?=
 =?us-ascii?Q?Lm53fMsziVNukoUfBK1psOf+Hq3rxuUYAQxM9ZJpWIJUam72e5WadB8w9h9a?=
 =?us-ascii?Q?uz/xrscaHUA7cSgb/RykyEseB7b1Fs1kJArz+RMo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7259264d-3500-459c-be2c-08ddfba3f507
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 19:52:56.7450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70+D0SVbYv7cF/5AFM9if3GlKWQCuoi6MKI1B1vNyypFv/1ekYyaG5l1nr0BrNk8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5617

On Wed, Sep 24, 2025 at 12:49:14PM -0700, Nicolin Chen wrote:
> > I really wanted to say this should just always return the
> > default_domain, but it looks like host1x_client_iommu_detach() is the
> > only place outside the iommu drivers that would be unhappy with that.
> 
> I suppose any external user that allocates/attaches a domain has a
> risk of potentially using this helper, in which case group->domain
> may not be default_domain?

Yes, host1x seemed to be the only place that had that intersection.

Jason

