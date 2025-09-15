Return-Path: <linux-pci+bounces-36152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20006B57BF2
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 14:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2352072DF
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 12:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF10B309F1A;
	Mon, 15 Sep 2025 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ttNzcs59"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012054.outbound.protection.outlook.com [40.107.200.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8633074B2;
	Mon, 15 Sep 2025 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940844; cv=fail; b=cqgFaA2Q6cpN1Au9psPmLVBSOuBhFX9IldUP+CcF7xxOYTUTeqNUUzyhzP9dWFXxr7QXh9iWNr3QpVCJ108SShAOIrnq92LX/nSPtsGuHOw0ngS5WtDHKay9ujTK1VVqhoJCyYmT25wFkasNShN1UxmcYoCfHxQ2vphPOrnxcB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940844; c=relaxed/simple;
	bh=fz8vFIYJ8X+lrg95fzEdnVWLs7e145O8cxaTawqNx+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hU8XXxlKbxX5s1omKnNxmfH6fvSUO+LjNIm8bWvyHdtM+AavX5vXam7xRP8ZamSoGw4A81UIkBdHWNb6KnNK2DgbEifhiCiYKIoDgPzV06YRUHPfLTckkvhyTrZrwW1XCQ8yaF6+wp52bfYz3y4/m3ozVt5FedGIL+YxbFqzhCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ttNzcs59; arc=fail smtp.client-ip=40.107.200.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0N1jETXxQ2hDUCsG5X04R9iIjH/0Odf5ygqf6qVZxAGHqMojO2v1CRF7eLC4523QAFnp+1rFjct7nH+N4ApnAg/nlkMlFKTSWPe3fq2uxb54861peIzT7wXTylN88tcM9AoXTKCSwDEfnZA6DR9Oavwr4H6I0VqhszEJqZTfUFNcx4SAeI3vWqt+5a3UGTVlFxUOVRtzxSAMq2HJpdGazT1CzFA0D71lZZyZVju74FB/CwhXRnAGQ78iYyuJuDIV+Jb2tHvBsmcOg1QSwYoOLyDkNfPB6vXuOu0B15qrvx2MfZBirTZr3KinTk2yHwHAtuseoUnkXEBiqERhOgsmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJLrZIdADYAkPAeo0mCjntcnT0DyDjK4qMg0FeNUBtI=;
 b=Cwou92zt7uyhzSfxGVw4i/sej3qPFhamvru16DFKkUfVrYAqiBBfBNfGQjcdjJO3IPrUYcb5LbrG6yLKUs1V6e9wYjP5qLZGX6QpMJsE/Jtjlg5dC2GhnuUdSKmITbFKTGAGSW9WkK8sgz6ytwRknw3K+06yUcP1mwzXKw5Na1WVUWr5wxhortxcHLIrniFy7y9QPPpRobpzJIYtP49YDKrxQVfuVckcntolTZ0sZrmPxLl57vJGoqiNCqDlEdSKKLHLZbsQvt1ysP6waTdagpQsacHbAWne3ruM9iIiaL+/Oa5hJNueo6tiXAedZwsUmINDGKni9LKzScRyLj5MqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJLrZIdADYAkPAeo0mCjntcnT0DyDjK4qMg0FeNUBtI=;
 b=ttNzcs599CW8Gc2+2NDNjhyHropkgKOFYkzjct8NvxdCFAJh13FdGV5BMKU23PKtkpoUyRYMVShDrhSsnGWkezxqPf6M1uxVSHJ2uju8jdd7/YXPDur/ATdxLsSNHzjvFtG/erJiy40hZZLp1q1ZEdp+6JM4CgnzdEWK00Kj3jQXqAuXaZgrUD3jJrtbLh5ae3JHWfSkElCOMcQB1uZhxXognhS3IlwD9JYCZ/vy2qMW2FttlzvXttJ+XxLqgfIRhGTMVirNR1dSVR43o/2vL2pjqlNizJKoYXWPgCNm4q1Ia/a8EIS9VcsWcXoMlZ/8SS5VYrrWno8hkqdwZGUVoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SN7PR12MB7346.namprd12.prod.outlook.com (2603:10b6:806:299::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 15 Sep
 2025 12:53:59 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 12:53:59 +0000
Date: Mon, 15 Sep 2025 09:53:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"sven@kernel.org" <sven@kernel.org>, "j@jannau.net" <j@jannau.net>,
	"alyssa@rosenzweig.io" <alyssa@rosenzweig.io>,
	"neal@gompa.dev" <neal@gompa.dev>,
	"robin.clark@oss.qualcomm.com" <robin.clark@oss.qualcomm.com>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"krzk@kernel.org" <krzk@kernel.org>,
	"alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"yong.wu@mediatek.com" <yong.wu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>,
	"tjeznach@rivosinc.com" <tjeznach@rivosinc.com>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"alex@ghiti.fr" <alex@ghiti.fr>,
	"heiko@sntech.de" <heiko@sntech.de>,
	"schnelle@linux.ibm.com" <schnelle@linux.ibm.com>,
	"mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
	"orsonzhai@gmail.com" <orsonzhai@gmail.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
	"wens@csie.org" <wens@csie.org>,
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
	"samuel@sholland.org" <samuel@sholland.org>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"cwabbott0@gmail.com" <cwabbott0@gmail.com>,
	"quic_pbrahma@quicinc.com" <quic_pbrahma@quicinc.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	"Sethi, Vikram" <vsethi@nvidia.com>,
	"helgaas@kernel.org" <helgaas@kernel.org>,
	"etzhao1900@gmail.com" <etzhao1900@gmail.com>
Subject: Re: [PATCH v4 6/7] iommu: Introduce iommu_dev_reset_prepare() and
 iommu_dev_reset_done()
Message-ID: <20250915125357.GH1024672@nvidia.com>
References: <cover.1756682135.git.nicolinc@nvidia.com>
 <0f6021b500c74db33af8118210dd7a2b2fd31b3c.1756682135.git.nicolinc@nvidia.com>
 <BL1PR11MB5271BE949150D4C2B5EC589A8C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR11MB5271BE949150D4C2B5EC589A8C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
X-ClientProxiedBy: YTBP288CA0019.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::32) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SN7PR12MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d01b779-94e1-4514-31ba-08ddf456f017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pvJs3ZsEG/4gI4E0Fm9q13EAi+c+FQkDeBrdqb3EFM9pOFheqcgH9617rkM0?=
 =?us-ascii?Q?YkZ3laHuXyaQ3csIwSIMJWMPuKOclHoJQwKqp3bMnI4AgUtBtVaAUNfMoac3?=
 =?us-ascii?Q?Vkz1OOEq86GPtKjIJBuHiFtEgbQtwg+FkndPXi7Ccogd0o4feTySoYIvj/nP?=
 =?us-ascii?Q?PhPAb3jB3YEXabdvzJluVAwcUAaYL6D7TXnHe/b3yRHWVvy2P9cSx8b4Lyep?=
 =?us-ascii?Q?/a6sgAfCHhHUdWkYn2J359RqjX5+T/YgIHXQxcyXHWVux3noJFYQVabqBNPn?=
 =?us-ascii?Q?agGf0ev8ofBU165igJXC8unKxUCXo6T9BvNrDqWVNIkQ2hfiKOWoiN5ceJ05?=
 =?us-ascii?Q?Z2puSJupQOhppbIV7Y9vZC9uEc3NhE50e+Z76Ez11RYh9PmlKMQxGAIPGERP?=
 =?us-ascii?Q?kZhDdyK6u5v7fm89dmqowN+F3meSztuqWwlyNVUer58G0SsDq5LexTHBa/97?=
 =?us-ascii?Q?zjd/FSjoHWTdO19HSgZYiyAABGzouzi3ZbrYTLN0QxaC/eqX0O9eqYauYobT?=
 =?us-ascii?Q?waMtYr/azAODfcXXeRtocBP4w1sYGwCyBROvPWVNulYGiUf7UTsoeZxETb41?=
 =?us-ascii?Q?bAxhzfjOnoOWPUQFCaiX7OL/7duNzj6EHfvzGHpxqEZzYWPaRNFGIT0PjnR/?=
 =?us-ascii?Q?c/yGZwoqcoOpsAN2x8gzfIr2700Mg1lzz7fwnkAl8rU5yPz32aNcX7QeGxcb?=
 =?us-ascii?Q?PYJqG3unFB+0MU7XSfKmMatRLiaCys4xmfDroPylVb69gkOWmmC2SUfqrfPU?=
 =?us-ascii?Q?IG9DEjuQ/EUdWX2ggFi0jXXNF+GattCehqmm1N7LHgBYTabsk3PKxWRo016h?=
 =?us-ascii?Q?WUqP5+LGfgZvXi5IKw8aaHn4m7N4e8pHf0ABmWndfJ8kDANjjOGkQxmNCg6m?=
 =?us-ascii?Q?op4tPtT6DeJieF6nmek/Z3kNETL0v7oLl8+24BJTUqK3asYWlEezIb43P6pA?=
 =?us-ascii?Q?Iv21Qj+paL/+XJfBwxbSRZSwFohsq8Gqlf9L7XkkXIbNYBTOradswP0ylte9?=
 =?us-ascii?Q?4Cnn2QIqDqtY3TWtBjlSN1WkWm3eQo62kAMMtfy9KNSnOsAXNfmjjjsdnSMa?=
 =?us-ascii?Q?GYBdiEVz3Eirn7mxJZ5fmYZ7xGgXtuuyJxsXSB6Rd+AxM4QUAtG2KWBnDnvl?=
 =?us-ascii?Q?qISgOmMXvDqK5Tmj+PKCNW1RaBuR3To6d0YWERSm6p90Ho8XTvbIkKIgr91X?=
 =?us-ascii?Q?1HZIB6IRZ+qNrJuvTQqbHCn8IMtRjaS6qc9WolT5z8ZzfilzkrvTkRt/xOgP?=
 =?us-ascii?Q?RD6lsp3l8OnlMM0krCtIgLrmkm9lWUwfj0kbCVLC8r5VutIz1oryO9sLmDnV?=
 =?us-ascii?Q?gfi9w8U4gOF4f66bdjFkplTYaN9wiLo/PLQCXw9SZXeEpLKWknazM9g/WFC7?=
 =?us-ascii?Q?PdcwnH6kkIF0s19OrBVKVebbfQmbx6G1LGJ3HC9r4BULDrq7Tg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SIzLxcoMZS6WwUlmyB+R1Fn37YD0nGa7gRfqt97TobFgLpS4bWDOR2me6YIg?=
 =?us-ascii?Q?AiUMrUYp5ypLrlu31Kk5aqmPinhBiecDSPJvwjQEEuM/MRPpEHFudcMV9ORt?=
 =?us-ascii?Q?RRNnmHhE3k0nFi8BWcwYafO2vbulOpLTArMPx2O1r/imcfB2vVMtNJUZ6wAh?=
 =?us-ascii?Q?N0HLgk3oZULJh7Ir0Nvm9HZlczWA0zzhQUdwW0tg/HxmSMtAT8berLrakyqH?=
 =?us-ascii?Q?OYryZTleHt4PMGSowNQVaYwPxIRc481XJV35da1FAZBKYGgu1FqUaMM+peZp?=
 =?us-ascii?Q?3rxibqUbdVhNvY/aKzurifye7k8QFIpkq0upUOzqC5jctdgEKRRhuIA+RMGD?=
 =?us-ascii?Q?YKBsokFY81pMqCm/LY6EreIWumYpvcFerb0Z2g1RjzVltfG2s7IcceS4GHLs?=
 =?us-ascii?Q?eEchZkpf6eu1e8Mu49Ey/dDLQoPSzGTnG6G3tWZOszh5CoCeYwt9oB32S/GZ?=
 =?us-ascii?Q?rF2YG5FonwZmzEua3rtZa5/8RnkdpmLaN8yihVN2NudBJrTq4TW3CLS3gORn?=
 =?us-ascii?Q?pFe6vESkv6tqF61Kw1HKRZtkiT5f7rys8P6Cc7Wo9+xoCTW2PBQqHvUd2ue6?=
 =?us-ascii?Q?V7DIN8WIj7W84Z0V6mSTe60bnLHtX8wGWEPOYOO0KAMfqB7wp0ELGMhEZSNR?=
 =?us-ascii?Q?u3B9jF/YBEAdj8BUJC0R/0goG/N4c/onxFag4aeq1ixd6CyUNQeqapczW+Oy?=
 =?us-ascii?Q?hYinEaYiEUa200MD+PyPtQkYZjIkd9HhAq0P6RLCly9bYbTle+tSPH0xUjyy?=
 =?us-ascii?Q?uOPSQHVvVsx19T1RFiXQc3MHGu4Jw1LknCrAiOjubQi5m963yYTCfrqoI2q2?=
 =?us-ascii?Q?ShkT+MhS4HZbMkkbirxNvptcZrzSuw+bflMJbxNrGdLolhC6u6T4SEI+lvUZ?=
 =?us-ascii?Q?ezbopFtqP/c+Wa/fgRjXYGkSmqfQvnzC2uDZgoDVlYg+HwuFSfRvTCDeIKDl?=
 =?us-ascii?Q?YKbXlEdFuMAuFLMn72asytqjXt7CgB6sE48Yjaa6MoIRKu2uBziFEej4lVpF?=
 =?us-ascii?Q?nuWE0YygNjNzXStxsPCkkAO1g8vGNvTBCyTQGHDZp12GBPlbQyFZhh4vv8ar?=
 =?us-ascii?Q?Y71z/pJbuq+6uMyvs8afOwRZlohLCO4wm0F4E7Gckcg30wnYEGkeoBRZJHil?=
 =?us-ascii?Q?tr0iO+7h3ZliT9etL4+IWIPjGTKT1MDOmauyPAJn6vkYAnK4dSRfopxd7wyn?=
 =?us-ascii?Q?e71WWXxEmyPliZKO+ZlTU2Mm7LX4XzBzgru5fJsaERSvcT5e+J5D9PvJXd8R?=
 =?us-ascii?Q?kD0UiZ/si6Opbq8jNuYlYRtvpqVAy5DpwMcEvpwvw987gLiW14A7WxoSTDaU?=
 =?us-ascii?Q?Se+Rqzq4GlnxNxLBjhLrvLj2b4GG6wvHkrknjLhRolTU4Zfe3uqQ5rQtF6jg?=
 =?us-ascii?Q?hjeOpoislXMd/NYtDFqgNb9Q3sErPkeQzDWwoHrUBJ5iuEKIqjgCzNverNf9?=
 =?us-ascii?Q?Pznd2NVd6h5dbnSGytQW/vD8k4ltbNxmxvFLVBlrtDPPfaB+tH8cn9sdIqeT?=
 =?us-ascii?Q?vHQqT/6rueJIjxK++DbubgZNWpMPt0RhOP+xkVpCibWb9XGdaUN9ep6MLrZE?=
 =?us-ascii?Q?VZvVxn8bN8bR317yDwA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d01b779-94e1-4514-31ba-08ddf456f017
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 12:53:59.2168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/e3Z82iHxMU6YMiwYeyxkyq5iCH0VT7YVc0GX21OwYq/IpZ3oIe/3IBPu5BkVE3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7346

On Fri, Sep 12, 2025 at 09:49:13AM +0000, Tian, Kevin wrote:
> > There are two corner cases that won't work:
> > 1. Alias devices that share the same RID
> >    Blocking one device also blocks the other alias devices that might not
> >    want a reset. Given that it's very rare for an alias device to support
> >    ATS, simply skip the blocking routine.
> 
> it also applies to the devices in the same iommu group. While one device
> is being reset, all other devices in the group cannot change the domain. 
> This needs to be documented in the attach uAPI.

I think we should just exclude multi-device groups for the first
version of this.

We really need to fixup multi-device groups to distinguish between
cases where the group is there for aliases and we must have consistent
domains across the whole group and cases where the group is there just
for representing isolation and different domains are fine.

We are now having workloads where this difference matters, ATS reset
is one case, but I'm interesting in seeing iommufd able to control
domains per-device within a group. We have some HW that wants this.

Jason

