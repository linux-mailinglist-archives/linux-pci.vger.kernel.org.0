Return-Path: <linux-pci+bounces-36789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824A8B97027
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 19:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376C63A66C8
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 17:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7528527F727;
	Tue, 23 Sep 2025 17:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NaXSL+Ym"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C383D273D6F;
	Tue, 23 Sep 2025 17:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758648157; cv=fail; b=GfTZbC+qre8DNIn29p9Z/SCcu0UYW+w8V6UaapR6SCLkZzqyYcfC/GWeRaVGUPcfJr19o4a4rHcbTldYf2yfGVyaBaEIGQQkoJTHxbt8keSEdZzLN9OfoP1jBYQifmpU/5REsvQgr716Xb0PQparjUvna3OTkJxkNufkaFYXl6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758648157; c=relaxed/simple;
	bh=k7KEYpPUdp2ejkjfW/UCrWiO4I/ePltMkcqVc8lsmFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D90368pqS0KtXY+yLLtPaVzT18Fi28YpOhbmcFWDwnplrXoCKTUGVyQnQMuJjogfPY1hj4OsKRiouE2ywxcX8n/hbIVCu0bswYOiBRRci9BUZobdDWNjkXpRtPTEE3ohuGJgbtDqF5c+nVRtJw6f5bOMhznZFPGUeGCriRHuiro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NaXSL+Ym; arc=fail smtp.client-ip=52.101.57.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWqBhkC11zqmF/FOXSfvlh4g6fLmkt3NNIQeF12tGKIVyerNZqdRINCPZjcfQH9CTKb4EAzAxTzrzeT7IRTlaUCF2OPHGMtqwSUKjoMq+rR9wSFkzAo/X1FcwpWrbp6u+clhIMr/c1ZDUyjUppJpWAo1ERWi/YQrdOA62q0oi22OuW+zMlNdgm7bBo5ENics896f96xUuSs2usgbx5S/e68WTznWpAewXKsZMZIptw/uK4am8B9MvFzkBBNXh1QpkHt5gmX+6oFbbKN/tkryldzNHjTHRKB2+UWg6E6Y4RntdpFTcvyB/UYKcarBaIJKheXfSoyRDLfr7w2LLkDiGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pXz2vFsmRRdf4uq/BTawldylsgWK2uDiwO2PD7QL+g=;
 b=aay84Zk/wz5xzHeSxwqJM9Ow6o/AzLReKyVj+wTbuGHRjLLcbWgCJ9CS/oHqWocnNBj7eCu+zAuKvrEhYfaYRJYDUe5Yi8oqzzoNmfQEKZ/TZTHAETiPtgOIYFI1HEakT2hKvvfYhnkROMIleNYYKOTI1IjePnoFcaw+JfWKz9bhQESwNexSSIuu0u2JC1zM4NLGzOsazgqCMe8/vpCOjWZu9BkAwh4HmtOD7JRGY1M6AzvSJPaSKzn3wP3pKS42MsIePbIAxlpJz0CNunVGR9Nqm6HexR/1pBYau06INo11uYhkqnX48rszWP8d9UafE4O0hooF1/cuntmTZ4utKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pXz2vFsmRRdf4uq/BTawldylsgWK2uDiwO2PD7QL+g=;
 b=NaXSL+YmubFif3oWQoQcsxfHUlg+GFpDJ3uKc5RdOliZgg5siHoeJprkSvKAWlz3ZVAUL3gwGXjRkYsoC8JFPHaHIcYALqZ7CdOMlpB3rnZrSKWWA53C13FTap2a6NBeIF2TRGc7tnKXqGKwknNfTaw87EYAJ9aSokKjNJyi+QBDjPeL5TjjXkfNictZ1gdadL5RtEm/aklQ2x4u+fkwpyHv6N9ysAv9mgOrUTYe31j4hx8+yw/7ZCwyihU5rAODhoZee0noSSjXVElHF/QiEoy6hHNOr11WFmQs18TbqjGkhHZwYPXi57gG+oSHfY6ab9ZlhCi1UkqR0EhfY5cMrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CH3PR12MB8076.namprd12.prod.outlook.com (2603:10b6:610:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 17:22:32 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 17:22:31 +0000
Date: Tue, 23 Sep 2025 14:22:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
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
Subject: Re: [PATCH v4 1/7] iommu/arm-smmu-v3: Add release_domain to attach
 prior to release_dev()
Message-ID: <20250923172229.GD2608121@nvidia.com>
References: <cover.1756682135.git.nicolinc@nvidia.com>
 <c6bc114e438779129a891408af7d997bf6c28b5b.1756682135.git.nicolinc@nvidia.com>
 <BL1PR11MB5271767F92289C1D1207D8188C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20250915123515.GE1024672@nvidia.com>
 <aM3dlQH0rk74w2CH@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aM3dlQH0rk74w2CH@Asurada-Nvidia>
X-ClientProxiedBy: SA1PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::11) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CH3PR12MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 742a7fd9-6fbf-4aa8-c42c-08ddfac5c726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yQ3nt/Apvs0jvf7A9/uDc2cn+3UAwOIHU2tTAvTXGj2R8xtGxIXHSKKpUaEu?=
 =?us-ascii?Q?FcZqy4cmglMvE/HSMJhehcLnKk+dShbLalblHtVv5DCsWxxyvha6VegSRx58?=
 =?us-ascii?Q?fPEqKxMbBPDPz4ipnmBo/mZD5EgGvnLVoJWavfMlB+hJBMa5/EyHhIv4uPtZ?=
 =?us-ascii?Q?no8fMAfSHZciDo2j3UidBSN+Vk/eeoO+yc93+YevPqKeYO6V5A8FbwJHwyEK?=
 =?us-ascii?Q?tLYi5UgxaNQ+yMiCaiyIVUfJwOXKcMCsgV9oUsjrvQqnIht+ZYGgOeX5IM1C?=
 =?us-ascii?Q?0Q2EI4OX3f3KAnynEnFzhXKqbK6iI6oaSeLP7+Kn1CjW0k3m9YgoXnj6euea?=
 =?us-ascii?Q?aP85f+1sOye5cm7lT9SZYU2ECbPrBfOvEZXXT/A5+0m15uXP2KhRpA/sujH+?=
 =?us-ascii?Q?v5T9mLkvYHcMwFFg74rT8g/rEvUKBb0Yv4s4L7B0YUXYZK+AHGlagy4zGLQE?=
 =?us-ascii?Q?u25InJgiRE1me1sUnvCrbwKuuqyYKKBgLs57eFl2imHeblLbqN6745jvtyWD?=
 =?us-ascii?Q?mwmchItYX2LIPuO532xmDkMnWAiE+KQOX4s+pqH8H49UYPrNYNjS5Tt0gAQE?=
 =?us-ascii?Q?kx7IdNJtwJxdzWvj3FOYfaQdJBmVuwxeTCBENCAHFf6mKEeRLzViNtiPM77W?=
 =?us-ascii?Q?TqF0ZNVouPdlsbkNeLvebarhyvB+UwXz0e3Adc37Nt8HtNYp9QtuXlBtEBD1?=
 =?us-ascii?Q?Adnc1z80pFIEeosiJJQ2jdxjH6IgBuV1i/Avk5EVsfEmjw6jldqprZbKxAXz?=
 =?us-ascii?Q?UAfD1krqEGXOViNDPMIsMHcI6VOO77UJRpL/Y2OfIpLC0Zby9UrYB6QLEnsc?=
 =?us-ascii?Q?NvwgdVLAQdQZEi/LeDF9qqXKhIgYJ25Hg5LgyPFe/FrHYS7oBTALrGw+37fL?=
 =?us-ascii?Q?BSv8CS6ZS9NvLbx+OxyT900Jv3qC48Mo/iTt+0ezPBesnFZZkoAL4L4DygvV?=
 =?us-ascii?Q?WUdag7WRnpmxhJX1Dgw7zysF5dCkV7o3f8a78gKAtysyrGrKpPvkeZ+EOT8e?=
 =?us-ascii?Q?iw3taj6NhN4+PbxrtdRWvGLnQFl0UFglyVen8fZj1WEvfjtObBjlUCLkY6K8?=
 =?us-ascii?Q?giskzcqlC/KNULCCkypb2vJTdstsWu/ij9MEG+kdYKcZ09XGv8YzSCiL95K6?=
 =?us-ascii?Q?Rk0X+MmAiOsWs6PP8lGk8hjDKkvT+S3aG8GtYqCaIPauYXx9dUPxfq8d41gH?=
 =?us-ascii?Q?q4njkW6gMSheGvQG+tnnQ/KZITK0rZhFgaO2SJXa7M36EHpaRNcAoisDdHVC?=
 =?us-ascii?Q?YcnjVvfiX2VWiSGE3eoAi1eBRVBLuSSV7hucFab4ERDdL21vMxGVfNPUFZTT?=
 =?us-ascii?Q?OtN4QhhVfB0KuVXNiG+cL6e87wQHIzoe07W12Uu+RxR7qmQFqx3ytvubc46/?=
 =?us-ascii?Q?N9TZM6kH5TfS8UV8IxwN/qZJ/UGnWL+22yk81ifUhne0doL9frTNlp1Y7afn?=
 =?us-ascii?Q?oloNt11kpTI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WL8+x+rO7rWNwdQC/VzMtoYYgcC0ooPl9gd3jq6vBcDMxonl6I7cpOZl4MDi?=
 =?us-ascii?Q?bs3Gy+XFVodasMaTwtjDfRgJKa3TU6any6VjKzrSZPkD4e5OQWbvJbgxGhhK?=
 =?us-ascii?Q?MoqPLGcioWkkw3oMie5FL4IhhSHZSCdMiGro+ijZvFsnt+TJJWP29foz8FC6?=
 =?us-ascii?Q?eaEQDeo0KkJPU08HEpb1EEiIQJK0mMRZ8rrJLmYNq6CFnabcAb9w7HMog470?=
 =?us-ascii?Q?/IqIu/CLsNYfBQF//dXWOY6Jn3tgJEKGYYpTrnJneqRJ2Vncp60aQBqwI69C?=
 =?us-ascii?Q?NRqtFUtocnClhviVwzFqaPk/hY/nSA3+k0pnLipnKVr3hJrz/PXpIJdwkOng?=
 =?us-ascii?Q?0a4I5vdZ8vXzxouhhB4S1ell3YJzE6Dy9eYMj+9djdliFLGFPzIftXaFSGnW?=
 =?us-ascii?Q?WXGRZZbZWiQZebV60XqdbQXKa6TP3EJ3lNbK8QOAzFg8AY+sn5tdW6obogJy?=
 =?us-ascii?Q?jZ27O2EFQ5EwyxgY1aFsW9fWpt/nPmmdg6YtEZ9B/KYvl9Kdzbk6uE9cmPBK?=
 =?us-ascii?Q?x/1BpUnenXt/GQzBvxiC58wdK7jZOxJOATYc8zSwrzT2RoxK6eRJsMUGTCl3?=
 =?us-ascii?Q?rdpLBIQo0XZaH2Mh9AILagjPWeqD6xs8EH3ug+TG91on6oFFS58HUXqGG6dB?=
 =?us-ascii?Q?E6wKwWSTJK3VA2GPo1Dxe8R9txjtL+G/EP4nZ/zzWeO6A0opc8IzswIUdYzM?=
 =?us-ascii?Q?VdKR4xPu95MG0hZ6WglTLTPuPZeyAl5fR/RUY3ZucXf+toDmoMsmcYmq/R4N?=
 =?us-ascii?Q?58pr75+nbKddS4vKm+Tmuu6Hu4/5oYdJG5NmxG2zsIj8KHprXnVVQsZBBqeT?=
 =?us-ascii?Q?32mEA8Pa+N43PD+IWyC+RwlC7pxxDPudyc0bmCaVgtrSq7zd5a/DpaczOEVW?=
 =?us-ascii?Q?0uEJbH75HktCbXVMsVLduSpLuk1FyrC79m75FY8DvrMGb97NHoUMSqGhhbvY?=
 =?us-ascii?Q?6yIN8fTtpB6fPRlmfntaWVLNNFM9t8GKyI41zsCTPzD8Xtr2WiCgHmKdRLAn?=
 =?us-ascii?Q?mbqrwv0r6q+UB206vxIF1QUGYuSGgGvpKDAnHIoCO5SEf5/4slpP/2RztRno?=
 =?us-ascii?Q?YY3w05FYp5fmVORuDUADfdzVUwwJ2YEQUcQeTb1xH+CF+pObSYV/NN8MDjbz?=
 =?us-ascii?Q?dCSL16yJ4GvytdwUSBY/yeasa990OUZIn54ctnmNTRY/x1wB7ZkC8Fa/qW/5?=
 =?us-ascii?Q?Er8EcrWO0hjvg9DDlKC313WH/vR54rCKN1EADQpMzeUdAiWJoMjhmHZfpnLF?=
 =?us-ascii?Q?BTkMfxh2pvfARys/jqmlFvwAkITjit7fEzDglRWUUTNKCKydJlI0Ql7HNEMu?=
 =?us-ascii?Q?dcVe+lceRPmcN2BKo2qWvQCiM2fMTCiOceIHSoYR+i7ZjbNTbRkEDM5D2AWK?=
 =?us-ascii?Q?scmlmUVgW6qrM/GVtJhu4mZYP9YgjF+AxVdzs5ipZj/8eF9yd2o4JIE3Yiq4?=
 =?us-ascii?Q?X/71x1tXu/vpN7M2y9/6gzxNLonLhAuXQ5t/TAZKYMysB3qvcFqpubfIhvzX?=
 =?us-ascii?Q?Hoeh1YSdnzjRy+ImFxh2U1nWHjyJmjQs+/2Jsb5gsq3C+g9YdUkcChnvsYC+?=
 =?us-ascii?Q?kBOrIdczPQr36yaBRmwWXZw9gPQAmcb8e+hoVBZB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 742a7fd9-6fbf-4aa8-c42c-08ddfac5c726
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 17:22:31.7080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWCDeH4jjnixP9SeY3dQ8qk3PCu0ltBRuZYqmcUEF0UdpYCfePhOA48q2TVi3jqb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8076

On Fri, Sep 19, 2025 at 03:47:49PM -0700, Nicolin Chen wrote:
> +/* Same as arm_smmu_blocked_ops but less set_dev_pasid */
> +static const struct iommu_domain_ops arm_smmu_release_ops = {
> +	.attach_dev = arm_smmu_attach_dev_blocked,
> +};

don't worry about set_dev_pasid for the release domain, it is never
called anyhow.

The intention is to just use identity or blocked domains as is.

Jason
> -----------------------------------------------------------------
> From: Jason Gunthorpe <jgg@nvidia.com>
> Date: Fri, 19 Sep 2025 22:26:45 +0000
> Subject: [PATCH] iommu: Use identity_domain as release_domain for
>  require_direct
> 
> If dev->iommu->require_direct is set, the core prevent attaching a BLOCKED
> domains entirely in __iommu_device_set_domain():
> 
> 	if (dev->iommu->require_direct &&
> 	    (new_domain->type == IOMMU_DOMAIN_BLOCKED ||
> 	     new_domain == group->blocking_domain)) {
> 		dev_warn(dev, "....");
> 		return -EINVAL;
> 	}
> 
> Thus, in most sane cases, the above will never convert BLOCKED to IDENTITY
> in order to preserve the RMRs (direct mappings).
> 
> A similar situation would happen to the release_domain: while driver might
> have set it to a BLOCKED domain, replace it with an IDENTITY for RMRs.


How about

[PATCH] iommu: Generic support for RMRs during device release

Generally an IOMMU driver should leave the translation as BLOCKED
until the translation entry is probed onto a struct device. When the
struct device is removed the translation should be put back to
BLOCKED.

Drivers that are able to work like this can set their release_domain
to their blocking domain and the core code handles this work.

The exception is if the device has a IOMMU_RESV_DIRECT region. In this
case the OS should continuously allow translation for the given
range. The core code generally prevents using a BLOCKED domain with
this device.

Continue this logic for the device release and hoist some open coding
from drivers. If the device has dev->iommu->require_direct and the
driver is using a BLOCKED release_domain override this to IDENTITY to
preserve the semantics.

The only remaining required driver code for IOMMU_RESV_DIRECT should
preset an IDENTITY translation during early IOMMU startup for those
devices.

Jason

