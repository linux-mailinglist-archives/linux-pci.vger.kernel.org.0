Return-Path: <linux-pci+bounces-40850-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0695AC4C72F
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 09:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E719D4E61F8
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 08:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234F02D663B;
	Tue, 11 Nov 2025 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dk8aFq9W"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012039.outbound.protection.outlook.com [52.101.53.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8695B2773F4;
	Tue, 11 Nov 2025 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762850662; cv=fail; b=YADH2hcYSAHfakmZHhifVSt81ygKNrgwG4oOhdiN3MOD2AJJoTj5m1Km0brhqpbzGp+2U0/GLGbvqfaoWQcivnTmM0Lgn6eNQGpOOraqiixeZ6piX5dk3G6xCPtdhNFL25paUPmKrasvLcznDJfvOQuXX9amM3jze+4fP9vGJh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762850662; c=relaxed/simple;
	bh=OOqjygENOF57xHSuhWg6Tty2HNy3AQt8kHG1ZipL6/s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KR3RTHn8emE1qrNpYN36dKr+2tGVzTZxOp3BcuQDVDDFZ7KZJ9pmlJE1Cef7u0qljfV7UO9Xo2x30XzBvmA2HZ6FrM22mMQ/Bk5uNb3hHzZVeg7yQQRrnM83kGfF1luTQ0YLA93zTmwzenknGHc0IuKMlHrLcjs3JWb4BY+OB6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dk8aFq9W; arc=fail smtp.client-ip=52.101.53.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTLh0zyJ8DDaKAStfoBjn4N8zWaemt8PsvdoqEUaWmWJOkmZM+oqufPuSfurKtbzNITo4xnrkT4GxHIsMbs8N1FwklPs1X1wzSNzLbPWfl9gRsXbeCh1P6OSFJyzk646Wf0g8S4XKBvV+y+h15DVI7BYiQXybMdLzlw06l+52ITtr9AEtEQ2o51qJ2MSp6HI4Cq+gzqezCxOVcaQtH3Ecwla8gfr5Pl8eHEha7jIqlhOroBonCkkSZQruuMAyOdDooJAKlZ9jOyjobRenSM2mdBoIqYkVHrhrHc038gDwZXO+6KbiN04OWZxY5Al4PRi26MXXF3Zr+JrYP9bQ7Y7mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muSv2KJesz1dbecmS1zqsHlwDxaWxfZe+rK0zxCbqCE=;
 b=cL/GF6lGZjnhpK6pmngC8ITSUqSHJghHnhGXgTikV+GV27IMkgHBwzlJE1woXtRa/K0bLOYMQiYMIIOmNaaw49hvwTa3UoGKhn55G+FLTllSONjQR2BWjvRoN4T5DL45ApHE/pHL/I2ssPABtc4vUn0ht62sGd2+D+06ZR6kv1TwcJpg624ncfxqmDhMT5V/Vibz5kYswBbIPBf1fjVAoY98qhmqAJ9sLF/EIVrrKqlK8AdpHAypHmzfAyrGJ+KqucWlP3ypEH17eWySsYeHHMMT6Ia9nXBJuy4epLBEN8yW/BA2SEzGTic71/MAB8nTUl/mpdVklNCgKTN16etZOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muSv2KJesz1dbecmS1zqsHlwDxaWxfZe+rK0zxCbqCE=;
 b=dk8aFq9WCdkqIelRBzzRaJqFfsbXjfj99uCzQI96xjac6Jm30kfE6SZ0CIIYfDsV4zBBiGcN213FNmNJ2AG6P9z3FviWeA1R35zBv4/LnnoZZy3yUfx7rla1ucNs5S0xYgWpzzgtIxBYIS9dGMCRsyP6ZjmKaWReP+CKCF2XgpH+S5BXigZ0qfizR9fEIvoDxVy2qs2G5IkzqOQQi8Lm4B4G1AE0HreyWVy6/h02uGlWx9HQ+8z95JfoTDdAjmJGe/1spWbUC0uS3WsdcawHAwm8IZusTFnj12wiMDzE5suFFaqVmhUbN8OqY4sgfKqGEK+0B846ZmfZ4r+nfRawEA==
Received: from BY3PR05CA0024.namprd05.prod.outlook.com (2603:10b6:a03:254::29)
 by CH3PR12MB8283.namprd12.prod.outlook.com (2603:10b6:610:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 08:44:16 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::a4) by BY3PR05CA0024.outlook.office365.com
 (2603:10b6:a03:254::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 08:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 08:44:15 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 00:44:04 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 11 Nov 2025 00:44:03 -0800
Received: from inno-thin-client (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 00:43:55 -0800
Date: Tue, 11 Nov 2025 10:43:54 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<acourbot@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH v6 RESEND 0/7] rust: pci: add config space read/write
 support
Message-ID: <20251111104354.2533a3d3.zhiw@nvidia.com>
In-Reply-To: <0e8988f4-07ba-4c3a-8285-2960bc40dc65@nvidia.com>
References: <20251110204119.18351-1-zhiw@nvidia.com>
	<0e8988f4-07ba-4c3a-8285-2960bc40dc65@nvidia.com>
Organization: NVIDIA
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|CH3PR12MB8283:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e5654ab-084b-4fef-d6fd-08de20fe7f21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JkUtw/xSQ5Nb7BEQiERcG6fd3uBllZ/iUGNnOIBG7/tm8qfKIR72kK+G1Nph?=
 =?us-ascii?Q?vNA3SjKostYHok6WaIo74g6Q4/Hc0wdsPgGZE9fM072bQ2U2b52gc/9kKI1a?=
 =?us-ascii?Q?pjgz6Z4PVaVZx02tcBoqbPeiiGOwGg4g1hN89oOYFBhyvZ2gRuzwgbMoHoWm?=
 =?us-ascii?Q?G/GFIGgiSG05TZwAz2WTziyxYPTk1NzTN8Wsns5EzIfNRFumV4SvnOzD6V9u?=
 =?us-ascii?Q?iXaaGYKRNCTw4Mdi4Ebg5boTuiufap3khQZg2DjUKBuzPxFY4gtgfN98xFQ0?=
 =?us-ascii?Q?uoMBu0qraA5rvKZbsz3WjCaExy3uvK8NYeaC0eGUGVLgUyXpqOevcJiT8WT5?=
 =?us-ascii?Q?RKAOyAMgCmrBZHKKJukLnrgeizn0wBNnLZ4VX6rKw7LQB3HGREKNSKKCtjcd?=
 =?us-ascii?Q?JV33DvJy0pKBo+QYoue+rdXUXDxVkajtionFJfYhJjyp86J6ouKCmLmwcAsT?=
 =?us-ascii?Q?w2AbFZFzRWlv31xh5psSehw5Fcn+RhiXOcD4VmIrWIpNt2bGRUmZC+UmQYtt?=
 =?us-ascii?Q?ILSVHTh40uhAn5X4svxaXSLoIS2njCyYqu7ieH5bFq0Hm2wkkzUPv6zcHNdz?=
 =?us-ascii?Q?IYbBIlOp4nTc99hA06AIb9EurpjMjyjV2IwmNsD9bh9EkHkkBoS7LRLoRyVb?=
 =?us-ascii?Q?ziaPk2+A5k9NifuAl/vJnW1260M34BdVbl04BHnCZxBmMPLGCBNcKB9vH9x+?=
 =?us-ascii?Q?CosA8ulnps4sAm+fTCI3SK3p0fT0iU+G/CQ4PJCCuABoSe9mvu94+4Mye8eD?=
 =?us-ascii?Q?zzc3ERoZg6PLHJy9w3ZhNLbHqebHbBzaG2IIZqz/esh2TvqGi+znjwVjNnMv?=
 =?us-ascii?Q?ulg5U9Vv9RpGx7wl7wrX25/dOyskfoMNHcvykHHlYIJckXW+YHGjO/Vemlfh?=
 =?us-ascii?Q?uucqS6a1chZYtmf1CYZEQGJIT6JY+KxiwxRqcHqVNTjfUsHVI6QlytGt4yRD?=
 =?us-ascii?Q?GAh/TWXlEH93HoMPhFFzNsS6c2EAYvo9I63ZO7qvzy4ItTqM9tGgH1Vv9RIT?=
 =?us-ascii?Q?tfSU8rFCpQlYP1t2wRFU7L7dnedBYzk9U5OwKNVTLfaKnaD3Bwepyiw4+8F/?=
 =?us-ascii?Q?kIO41onayfrujrGwMy+wC2eIWwy4iiGVeTVMSQGEdZOg3ZL5Qylg4Lci+g9G?=
 =?us-ascii?Q?/32z485Mzdym3ksZqAjyu6P6OygZiJGBUXyxEs7AGOsA8XKwj/trJA4y3w8y?=
 =?us-ascii?Q?hsRPenhHFY2WG/L5pS4Qkz7s2J1KFpb1Z9NmB/4T7VHdRvud5mHnjbS5CU46?=
 =?us-ascii?Q?pnyGeqQN6oJfEHoHuOJ5ZixKZuIATdpMEnNbf8VTCSfYfpA+fbHAPxqm3TCv?=
 =?us-ascii?Q?AI8sj9tOKF3MWJcXN4s6XZypJeZYd48sJsMcDuU2N3x9QqIChiOOXhX3K8MX?=
 =?us-ascii?Q?jbCxSmLXcG7oKpDcnRHzkNPYXDTnUC3rHTyHaR15g0Qjq34ACTugymubw8Zz?=
 =?us-ascii?Q?R4VmhJ99FJcacCHP5c1u9O9SdFU3oq6q8LtZSWIPx252mepZuwO508Slqbug?=
 =?us-ascii?Q?RRv1Ojtrvil+4/yJt72f/yM+HIgJXOCs0vfo0JryVH9yxqG2TdbO9E4kdSm2?=
 =?us-ascii?Q?lA/rN8STSJBWLa5Ax8Y=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 08:44:15.9606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5654ab-084b-4fef-d6fd-08de20fe7f21
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8283

On Mon, 10 Nov 2025 19:01:39 -0500
Joel Fernandes <joelagnelf@nvidia.com> wrote:

> On 11/10/2025 3:41 PM, Zhi Wang wrote:
> > In the NVIDIA vGPU RFC [1], the PCI configuration space access is
> > required in nova-core for preparing gspVFInfo when vGPU support is
> > enabled. This series is the following up of the discussion with
> > Danilo for how to introduce support of PCI configuration space
> > access in Rust PCI abstractions.
> 
> Hi Zhi, is there a tree with all the patches and dependencies for
> this series?
> 

Hi Joel, I uploaded the tree here:

https://github.com/zhiwang-nvidia/nova-core/tree/rust-for-linux/pci-configuration-space-v6

> Typically it is a good idea to provide it with all dependencies, so
> folks can checkout the tree.
> 
> git format-patch also has an --auto option that adds base commit
> information, so folks know
> 
> Thanks.


