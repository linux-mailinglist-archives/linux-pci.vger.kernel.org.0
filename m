Return-Path: <linux-pci+bounces-43230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E917ECC9012
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 18:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73C1D3053FEC
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 17:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B36133F37D;
	Wed, 17 Dec 2025 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eIdujiZV"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013071.outbound.protection.outlook.com [40.93.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8497A26F2BD;
	Wed, 17 Dec 2025 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765991380; cv=fail; b=lKDLDq4K8xVnUaSUgd7E69i32TXIx9fITQDMDy1yTpjc3MJYERpqyuKBOEncwMfF60PmS77j13DxoRsMzJHFa/inmxMox+V7lqy0trbkJ58oRQysa705QndocqWcfe4cmWNh4I5Dm7baZbh6vYawfcweEodZfBxkT/+tmW2VItA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765991380; c=relaxed/simple;
	bh=0T1Jppdb1d/aTsEmZyCn0/y3tibLjLGedpE6UFTq7vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pPJdyrJouLQAOyDe7QM3ZJzJQz0CBxUSAC3J0tqFT4+cP4gHyqyx0Wv0CWjc93hW1SLBcnPuaVXKEM+locC7G2c+Yz4ejaQzFKelzYk9Cy1pidvOPNLOyrikF1yJedLDS6zupSYyeEZCBHDEmcHV67+WcBTs0ST9UMsCLeEhpxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eIdujiZV; arc=fail smtp.client-ip=40.93.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZw4p2mS0ooog+HhxkIrv1zIjUC686V+5zVJVTFUPXHcBLVrSektGnfPvFdB8xxceAzlBuBOpi6y5R3OBTA9mLWZoAtnuEgng5pixJyq3/WvvZmu+VSAvIb071RFnpsNkMEW7JeaANQf91vn8osqmtmfbI+Nf7mX2klmHGOOH2ouPGZW1OTQpmqw5KHybg1ROTvZdX5nQCMuamxxKxLbQmsA4duoGhufVVGiNl2HbJ/B1lCp5e0WHjk+gOpYI7U+i8USmf7ries8Cx0qz6gBSugW7aSP7xTtHKbELso93oSyyB7lkuQz6b+O0ZBdsn+jnn9dI0o0X+Ue8GKDVscUEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdxD98ufSwKEGQffQ/pBTzg6Ksk+KDLOjblhvszTnYI=;
 b=rrBnEtE4J6MPTQKF/AHtd/UTXdlooo+5ZKDzEh1tIoSC84lf/qVi3ywjOT9q+c46azCWsgrn8Pj4TEA4UlSr8Cv9TWClPyAZxJ35QrzrUCLHzbODvEnLFX+hRRzFXT9fkKG4SGxP4K3/WqndVWzchYzGarUDSLqQuW5Qgs7/hkXvdQhD62bSyQtNpAYdEIXRXuKH0wwXFD+vpsg34IJZ6Bab6UbsVZL8oa5TqpyZxs/ySODihL5yiQxxmyfcZlShagzuPHLVWMjqo9MleZWMQYCDvGhXIjcnkdVBAs5UB0DrqjHMi77Y4mHOY0HOUe4qNhj4BsAjfx0MlYk3r1FXNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdxD98ufSwKEGQffQ/pBTzg6Ksk+KDLOjblhvszTnYI=;
 b=eIdujiZVj5uYPyH9VvWVAfJ78eqGnrGpdNXjpIOTvvrhUPdtPtpYc4tnlFL/6VaJFS/vq/R1+DaPaZ8JDV4vStRfyt/m6zR6PVXEeQm4zWjgscTKcmppWqfz/2wkj4i/q2XDRwns9mWfxSj4VCuCsG7kYHja8X2vMtrY9p1LuOitpIlfKvlPLw8a44qqYPGkOpleYX5vcWkq8U5sm1VZcp6JKq8vR44u/hn4ZR4q2KQJ++UP8GVOQ9g22j01DIoEbESJZQTHoAgXiwPQA+07In/Il9kQGK+l3JI12jR8/IkAWsQdkcup0Ggbe0UkKyFX1IfrGLaHssy3/JEDWI+4YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB7537.namprd12.prod.outlook.com (2603:10b6:930:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 13:36:59 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 13:36:59 +0000
Date: Wed, 17 Dec 2025 09:36:58 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nirmoy Das <nirmoyd@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux.dev, jammy_huang@aspeedtech.com
Subject: Re: [PATCH] PCI: Add quirk for ASPEED AST1150 bridge to prevent
 false RID aliasing
Message-ID: <20251217133658.GL6079@nvidia.com>
References: <20251217133232.274942-1-nirmoyd@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217133232.274942-1-nirmoyd@nvidia.com>
X-ClientProxiedBy: MN0P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: b392a451-a3de-460e-1623-08de3d715a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?+aTGwGpNoRlXZ+0FVVGXFKyaa70oY+NZTwf9rq7CfYz1OhH1sYE70EZQHo6i?=
 =?us-ascii?Q?tvO1yUIQVB8oRdXGeQmNQZSi2l6YGU8Ob5c5H6cqxLPUBKvUSndfT8tzmVcX?=
 =?us-ascii?Q?Nv2wSUFLwE+7VyxE4Lkrnwzogd6dm5ddEWmPMERnUR8ZKIgOwJFwL5nANtO/?=
 =?us-ascii?Q?idG0g1xk3MkakX5j6n1EzUouZP2Mq36Ykq1HtiT87YzVi5ekPh+1MR4R0QPB?=
 =?us-ascii?Q?ZEBVL7G4fHYHof/WNh5wTXDa7KxM03mclFK/ZfjCbm1aCAjcPp2BAKc+4Shy?=
 =?us-ascii?Q?uKbRZY5wGAQxoCeYRg82CLGeQpeZA3hkjpkBF4ivuLsL8l1fvOeVa9XxcePt?=
 =?us-ascii?Q?KDDkEFzvKOh+bhqOvr4BvqcnqAXYGyNDGorvrGxXMVnYMX9NxNSZII6JPC82?=
 =?us-ascii?Q?tJSntJLJu5KXAxw88UhqJ1Incv/QsHqFPFhZoy3+ve1GNfPTebBuYfCqtSn1?=
 =?us-ascii?Q?/j3492WE7q6nVcjvts2Dwj0olfwzFtw/rQjzR0mt9s5o2UnuxTB/SB0H8lhL?=
 =?us-ascii?Q?/xwjEUZTmvTbE5UKkNhV4hHp8VZaCGq+/x/kIE0/Pr55+yFeFg4gQuczcWfc?=
 =?us-ascii?Q?00xGtDhgcdhaSOkE4/rqRAy/7h6NNjfkdqe1+PIlwbmVL7rSdJByzkfAae6k?=
 =?us-ascii?Q?CY7dfDLcLC8Nq1eenrLWmqOINhgtgsyaw8aJBfCB8R+V7ZlAb1ZEJD3SaG5z?=
 =?us-ascii?Q?4sF8r+WRfn2/tLbg8gC5WOmGEtyIONjhtfhH67y8e5dZ+m0LBhWEtwX1C+sz?=
 =?us-ascii?Q?kfgGNrjgHfdPYQfUSI1etdgBLswpftpN39r0HbHP5zLqsJmcnToSUKFqNMnw?=
 =?us-ascii?Q?XHkQ8POCnE1ri2pXPUgJqMggZAdAfDm3dKMJGDqEOOz/tD06SSyjOOc/wg6h?=
 =?us-ascii?Q?UTIl6t1AXeuAIMs7s0StA0LyeC4p6meWTmuKuxua7dC4vqzl8f38fRNueS3n?=
 =?us-ascii?Q?m5e5+LmnjL6PpM/bf/Wr1YP38rxmqZGRCuU6CkGa6+ZzxcJxHf4Dy3BL6YGa?=
 =?us-ascii?Q?ieg3sdC7Ok1A1IBUc/NTYJwBy2/tekz2uPpDvNZ7zn/zFZh8hwk9Ux9R7OhG?=
 =?us-ascii?Q?76H3XMBNeA8u4eewxRUr8Mgd9dMiEMRziveBhH6nCOqJ70PHgSJ6jaXOOJmY?=
 =?us-ascii?Q?P77A4r0Nc00fAg9Y8bEEbsXqsjvCIku39EnvDhBnE7l3MJC69TrII20U7n/+?=
 =?us-ascii?Q?o8FyDTkewvtTpaDrVcgihoDzKhGG16kAW7U/InVMEfoF3TKkCW5/RxrshUFE?=
 =?us-ascii?Q?wQIEkoQRBa24Aj/htQUySBvjHnnHERa8fPti6UL2ucd5LjeVwq6BoyaetNGp?=
 =?us-ascii?Q?teb0r8hh/90AGmUnLDRZA1Ef9axm7SzzlKddySBq/TPboYLVRkpbTgUdV8w+?=
 =?us-ascii?Q?v5GsY/V+To2ruHwm4zM1d3mvGXABpkg7l+1YIrHynRZMeb0Uf8AaVYmcW820?=
 =?us-ascii?Q?s+jKPwC89i5s70ohaGuXMSaBj5llukPq?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?LRch5CEmiu2dYD8mofxx4Nn4y+ixft/TJwMgfVom7aig9EyKUcuUxUDIQOqQ?=
 =?us-ascii?Q?6ZOoV/eAgSQkRscW1JBEA9Y14lIiLb/benPK5MLo20iVDgNmS79KDJ32CLge?=
 =?us-ascii?Q?UL9AuehoO+uhBDBvVMpwRTwssX+BAMtb1+c+imIFWg35RWVnQAqG0OoA2tgS?=
 =?us-ascii?Q?QkrBK3D25+IVKqGXFmb2LkFKnbYzesWVmr1SxNkp/VPqnkuntHctwXMqkF70?=
 =?us-ascii?Q?N5erUQaFbeIzWR6oXeL/hGjihqkhUVsxXkCfhzaPNWBEttApOnb1AuZtNpn5?=
 =?us-ascii?Q?gZ2d8j9lmM+ExO+wsex5q6C+E3FF2zxZ29L0PHDtYG2wZ9CK7/bluc/D8WFX?=
 =?us-ascii?Q?HjuS24Qabc7kd+vpGIaj9nWjzpzdmP0YCjnPLvJEVxRf2q4d6dFUMWdzBsan?=
 =?us-ascii?Q?VPMcFqhLxZ5IYX/PqQfNC5efSZl0dgYor3mhuWXHZI/Wawv8Jmxgx2MsXFv/?=
 =?us-ascii?Q?rhDTKkpl8egMc2cVArhImAeJXALJf++nwAGEwOl3tMYDlxryrZRtiLiYyKjI?=
 =?us-ascii?Q?++VNajWXNtjl/vEKwjeZKYiO5PaJ1M4Uv+O+A9p95Tbs6oZemyWG0T+jxrt5?=
 =?us-ascii?Q?Dy3AKPZ+Gk60tpeYgFE7JQIB6YLchHHw2Aym4Xuhe8mxQZaRTGJ28DwMNG5H?=
 =?us-ascii?Q?UxEBWudP+aAm77pm0QiIVx8NuaLsVwgIhlfMRLnB0g3If3VSyNU2ZgtEO6UI?=
 =?us-ascii?Q?LgJIWB6c9qyvhMKYAxqdG9p7YIcL9y/sl0eRy+s7ugwHudvSHnicKGlmhoc3?=
 =?us-ascii?Q?CUziPJRym+TNzhNKh+hr1o2XL76xqLI8XFaeSCuNP1Qz/Il+wRFc7YSPCoaD?=
 =?us-ascii?Q?zOg87GPyzz/dnlEjoWVleITnc+7SltAB56zFS8Eb7kIrcVMUqu3PIuKCSsGe?=
 =?us-ascii?Q?MlNp7V5WKu3o2INdg8L6UuCgF9SuXQ/4b/ud2ndXbVCVsOnJGzKVj+Ax+ny7?=
 =?us-ascii?Q?4ilY8xxHFq4ZsYfRWV/Nyh+VcntWymlA4Q++gzCVlh7MnH8j2/dPQLX+X8/E?=
 =?us-ascii?Q?AoM1o7nwZJkJe3IZ2Snj1xfzYdpUha3S9067qjpFNFOOYlrzC+zB/IMHuNJF?=
 =?us-ascii?Q?Jcy+VAng7gkHe1rIpsboAFLB5fBkORSHreT88EMSTjCFxnIqlTHzi+P+Ehfy?=
 =?us-ascii?Q?jqhrFMZ5PSa+mn9dE27WI+m4PCjaf8YdVLfHS5/FKY/sZhj7ZAHfnUAByXg3?=
 =?us-ascii?Q?GZFuQgJidk1ym150sAQt6QDPYva+w6PMoS+kD2W5e4ioj1b6lsqpUAiyfAt5?=
 =?us-ascii?Q?4U149yTbRXHYZLmlpbTaUBSey8c1r0foDHN9AWDrQuGj3ITO+J1PmfX8sFZy?=
 =?us-ascii?Q?4XItekV33aMhlxPuw2NiBH2lKVbxcqNLS9GNeZA6FUu8z/0mvB+liqg200iU?=
 =?us-ascii?Q?89h9vah5F9m/+1MgvGQg6j7MEasp5bMMdviimKiOFLdU0/6QMPsiFwsvNEQ0?=
 =?us-ascii?Q?ndTuASdPpm9kk3R+ZzsKoOusANo26eVu963OxQGUe0DXFbD/6lPLvft53Ea7?=
 =?us-ascii?Q?TJNnDqeoSm3/seBA1HclSa1CmDzd7QGb4uxJCJ4SarBkh6iLdcpBNLFLLjpe?=
 =?us-ascii?Q?qR/8cnf8n+l36NHf79E=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b392a451-a3de-460e-1623-08de3d715a5b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:36:59.0874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnFVqEZxNiX2ZSUFuOZs6yEUzo/KN8YxaosxESDW3N3L1NjZprSdfnwSq5VfI1O8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7537

On Wed, Dec 17, 2025 at 05:32:32AM -0800, Nirmoy Das wrote:
> ASPEED BMC controllers have VGA and USB functions behind a PCIe-to-PCI
> bridge that causes them to share the same stream ID:
> 
>   [e0]---00.0-[e1-e2]----00.0-[e2]--+-00.0  ASPEED Graphics Family
>                                     \-02.0  ASPEED USB Controller
> 
> Both devices get stream ID 0x5e200 due to bridge aliasing, causing the
> USB controller to be rejected with 'Aliasing StreamID unsupported'.
> 
> Per ASPEED, the AST1150 operates in PCI mode where downstream devices
> generate their own distinct Requester IDs. Set
> PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT to stop false alias detection.

This isn't right

Per ASPEED the AST1150 always uses the RID of the downstream and never
replaces it with any other RID. There is no real PCI bus inside the
integrated device.

> Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
> ---
>  drivers/pci/quirks.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

No, please add a new quirk. A downstream PCI device is never the root
of translation.

Jason

