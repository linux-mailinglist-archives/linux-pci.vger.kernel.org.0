Return-Path: <linux-pci+bounces-36891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 511E9B9BAA2
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 21:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852C1426993
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 19:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C107265CDD;
	Wed, 24 Sep 2025 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lk+db/bL"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011053.outbound.protection.outlook.com [40.93.194.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88392594BD;
	Wed, 24 Sep 2025 19:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758741541; cv=fail; b=e0SPRVaQqUh0+L1DVdPsHb50662hFNWkKEb4L0vxZtY3csSWIh47StRiEpM5Z5Z0KYP+5ZSpwa+8DRmaQb+ggTlXnEHscbKF4hfWiLkPVGZQelLMzCb2IUeaQOJORJoHJy/xxl+Mk6DZ+c/A96T2shfiPE0wklj8smL1yBLvROc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758741541; c=relaxed/simple;
	bh=yZfyw3n+mBkzqu+xn7uTgzhM5cFEpb3B43KpWTGLipw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ofh3dY7XfgcQi+jgoVxln2t0KNIlbauquUQKLDABsbmDW33VMUJX6Atojb+ywvwoUPzuy8XgcEFBZzbNfOjwfBQ+Zqpm0D3jZR1pBWg81S5bI2eKYLAJosbZ+4D3JeIMraqRPeybd5acV9JJV/jp+xV6ibZiPtZ02lfxpOL8uZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lk+db/bL; arc=fail smtp.client-ip=40.93.194.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HFXIG7KcQZvwT9GX4t4wFzNHoCGkDJo7NfcOB9Gb1cxCx9NyRpu8+YFm9cDVZoelu/k+SM9Xp1Ro7hqJgLreEkMGTcIltjJtH9/h9KALfuAlsuSMetCmzX25xAa2NmBZZuSadb4w9gEmcB3aI8juRRoewq50Un6x65Pstyn7I5KPIdKO+tl115BCzRGoJmm6Z2/gqjo3p868hqmDhzXcFiZ2hdjUfb6lPRM0/TLYoVb4n8JAKrugZkqFhL8d1QnFjRbmD+009ycKsMhjHBTriKqZ+2KvNzC5cjx7bLx672RHuDEpWXjSfS91I+qZSoUZlAmtLl/DPNDKbcq9tmUhIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXNzY6XHZfn/5ZTzycSEtYX2YjcDoXsQIMwssN7E92s=;
 b=KDnQ0BkyJxaSM5IcFi/ifoQXSnff46+ZZfn88iwkbLvRasx5wtpvBdLb8+FWzKXi26+ZKhjumy7MPxFY8Hykn7ArqycyetxCiPomNZ5XLtSiJxG6muQzevqj3vCqWi/SbGDuyLbOb28gdk/uUf95Vz4pniQd6Igs/qlmB9Aqc78b6dvaIM1kg6WsoUon4IWmjmD0C2JHYFwYBRwJpbLG9TlCIj6gzvsIdmTHxHKg9Ze+OsLobGLXwkZByZM14oW6UK9+9Zquh5rj4Cs1EPzInr1kVfJ72dAgQAf6PlDGQPqNc+W5TL46PgzNHAmfef7a7YTTf56mV+pa861lZS14Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=csie.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXNzY6XHZfn/5ZTzycSEtYX2YjcDoXsQIMwssN7E92s=;
 b=lk+db/bLq1f0SifuPXuFUQ+zGjgjutqjhqiHVlbBm4HkFu+1jDQqJKwRNOSEl+8bdkndHfd7hihCbCCM05zyZVXtD0xbg4BC4SpQL9Fi4EtWqAFO7+Pck2nC/L5XWhyZr13UHt2jKLhpkx2kkiqS4cXRWizbg0//57dB32Yn7PfY9LURqeoP+54pkHit//uSUEcNKVBUY8ZqFPkUtxorcHuo+gK9/nlSm5CoYU5KS0HV0/2gvVas2uPufL3SpB/IiIeRcCYhn1a8e0cKvE71c+nUHSzSS9cNGf1rKndYvkJo6yCfzO7JavPm7BSqQNyrYVHSeGcrlkgskM1BMt0F2A==
Received: from CH2PR12CA0006.namprd12.prod.outlook.com (2603:10b6:610:57::16)
 by LV5PR12MB9778.namprd12.prod.outlook.com (2603:10b6:408:300::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 19:18:57 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::b1) by CH2PR12CA0006.outlook.office365.com
 (2603:10b6:610:57::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 19:18:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 19:18:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 24 Sep
 2025 12:18:47 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 24 Sep 2025 12:18:46 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 24 Sep 2025 12:18:44 -0700
Date: Wed, 24 Sep 2025 12:18:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <suravee.suthikulpanit@amd.com>,
	<will@kernel.org>, <robin.murphy@arm.com>, <sven@kernel.org>, <j@jannau.net>,
	<alyssa@rosenzweig.io>, <neal@gompa.dev>, <robin.clark@oss.qualcomm.com>,
	<m.szyprowski@samsung.com>, <krzk@kernel.org>, <alim.akhtar@samsung.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<yong.wu@mediatek.com>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <tjeznach@rivosinc.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <heiko@sntech.de>, <schnelle@linux.ibm.com>,
	<mjrosato@linux.ibm.com>, <gerald.schaefer@linux.ibm.com>,
	<orsonzhai@gmail.com>, <baolin.wang@linux.alibaba.com>,
	<zhang.lyra@gmail.com>, <wens@csie.org>, <jernej.skrabec@gmail.com>,
	<samuel@sholland.org>, <jean-philippe@linaro.org>, <rafael@kernel.org>,
	<lenb@kernel.org>, <yi.l.liu@intel.com>, <cwabbott0@gmail.com>,
	<quic_pbrahma@quicinc.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <asahi@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-samsung-soc@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <linux-rockchip@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-sunxi@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<patches@lists.linux.dev>, <vsethi@nvidia.com>, <helgaas@kernel.org>,
	<etzhao1900@gmail.com>
Subject: Re: [PATCH v4 4/7] iommu: Pass in old domain to attach_dev callback
 functions
Message-ID: <aNREE5qMJRU+0+Bw@Asurada-Nvidia>
References: <cover.1756682135.git.nicolinc@nvidia.com>
 <19570f350d15528e13447168b7dcd95795afdbf3.1756682135.git.nicolinc@nvidia.com>
 <20250924184346.GI2617119@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250924184346.GI2617119@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|LV5PR12MB9778:EE_
X-MS-Office365-Filtering-Correlation-Id: ea0ff33c-82bc-4f39-19cf-08ddfb9f350a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cBcblxgwdefty0+60CAsDexb2LWIuUGGs0+Yy5DkDXjR4BUO44FR/6HKpIKO?=
 =?us-ascii?Q?tdnp3sb9LM8uZHZUbPzqhOmJmrKOwPiZCQY6CuXP1rC23o2MMDInzbVByHbr?=
 =?us-ascii?Q?yH1oIEFFPsIun7Us/3MMYvtkTTbQymsB2+wdzG0k3nR9m+IncBPAwKs9sWik?=
 =?us-ascii?Q?CAIe4ks0/LOuwdG+7gVZRmv/9cZ1iqRly02LTfjNtaBMEKH5hCUgfpn+nxfJ?=
 =?us-ascii?Q?3p30Xz+XrSSx/u1icZ0e9L0Qq/Oe0eE9yEM7Wva/6ommIGFEsUdvpZVpM9cY?=
 =?us-ascii?Q?I5R8eg4bgVkRPRaGvkzUgsI2bLS0xqK7LySXirszLbbxTrIhsKVw/DLmCgDT?=
 =?us-ascii?Q?JMLViVBhvUDk7iwn9oSglYJNyr4adrDClCpeobfg6QoKWRtnqlZnnhs1aQFR?=
 =?us-ascii?Q?FEzvCG/IIp9s1mYqsFumCevpUjX62zObZ0AWfLoGzZN4YANv2EIwb6abYRG3?=
 =?us-ascii?Q?m8sEMAtTb2t9mbQaALvTfGU9oF9YDB8aTEBqcqw8zJUbo59zMMrw6dt1H49S?=
 =?us-ascii?Q?CHITGOg3hMPk3HukIGRC222AUhws0rE8jRscGocO/k3Qnp7eO7ZGrwDYNV5a?=
 =?us-ascii?Q?N2t+fdDrlWVD2yG2oSKkVcoag21QH+qTR5PzynQVq+yf6wys3aYGO3w6P0IJ?=
 =?us-ascii?Q?RG3U6+eBswCLuA58GAMB5oJVMC4QCy5DqIOfs3IZiSPql/fruopHmxqQXLCA?=
 =?us-ascii?Q?4qRNjMU4vl8K/wEFIykH0cwNwyM+4hbWk1Ymi4o/4m5+yr58CyqqbKZcjlye?=
 =?us-ascii?Q?Gg2bPK5+DP/kOw/SXbOq04GpmnmhGHvIDHhV/4kPP09vZIGBO8vgTDD2gPKE?=
 =?us-ascii?Q?x7TKwPXfsBtw4Th5eZpUj0CdfPsBTGqeaUKZrUbwq1rOJg1V0ropL8XHs0iu?=
 =?us-ascii?Q?N6fiTEo4htBXkAicXqtl9lxY9YY/0plvbOg4uODOF647EYWB1oKHJHKrG3Sq?=
 =?us-ascii?Q?31xXjMgbXfoJ1PXDAMe5/brF2XU66q+1tFn+phQxH3/B88CyC1M37vtyYEt5?=
 =?us-ascii?Q?HjxE6yD3rxyuKuYNRtgU1son+QRNk++x+kWN+rcQG7819p6lckdX5EEQVHY7?=
 =?us-ascii?Q?ajTICTjw7FgbeSnU1f92uyvcfbTG916BoUkFREaucvA6hN0ClXHMkock70G0?=
 =?us-ascii?Q?6Z8b+6U+GXp8Q7YTJD43yJq0G8m0gSITjbfN5d0/y5ORLD2OTfaIhtPTrJME?=
 =?us-ascii?Q?dbqDpRO16+4+gla4Tjr1xm455k+UhIJsYNkJcbT7jS9dT34tJWszd2gpJdSn?=
 =?us-ascii?Q?zedMJX6pCVH+HZqsd/38bIA89gY+jFG1MzO8JuVm/I/CgKFr2np3yvwivc/l?=
 =?us-ascii?Q?ND4yChwwsjuMgKLbhjgZAjkwiUc0IAET6/iHjlvLvA4rQniKn689LRh0RrD+?=
 =?us-ascii?Q?ZLYvlSEspBwAVIx2dpXa9MPS81C0VVjh2ZG0dEtGEHMM8t8ppQ93OGH3n4bB?=
 =?us-ascii?Q?Rul/s13vpajYIrpY/pmxAkcRWfVN3FKf4Fh3MfgI7V3XFqVu0ufUzEQVp7RT?=
 =?us-ascii?Q?qqWvWRMYCKiButfEjzP2C4O3EQz9/+zNQ72l?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 19:18:56.3711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0ff33c-82bc-4f39-19cf-08ddfb9f350a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9778

On Wed, Sep 24, 2025 at 03:43:46PM -0300, Jason Gunthorpe wrote:
> I've split things like this into more patches before, but this
> actually isn't too bad, so I wouldn't push for it.

Thanks. I will keep the flow in mind.

For working more on the new test attach op, I'd probably keep it
as-is.

> A series version would be:
>  - add a new op 'attach_dev2' or whatever
>  - Convert all drivers that just change the signature
>  - Convert drivers that have a trivial iommu_get_domain_for_dev()
>  - N patches to convert more complex drivers one by one
>  - Remove old op attach_dev

Does this mean that drivers would live with the 'attach_dev2' op
renamed from 'attach_dev'? Or the last could rename it back?

Nicolin

