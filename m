Return-Path: <linux-pci+bounces-29377-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 318CBAD46ED
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 01:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A4C18948BF
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 23:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991A0284B3A;
	Tue, 10 Jun 2025 23:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OEtFV+XM"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2441523816B;
	Tue, 10 Jun 2025 23:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749599015; cv=fail; b=Pb7U5lTnWMqAMcf2I+VaUrWhTaEUkCqLBhwLid/eaa5nqtH6X6fylJRdGk5PPuwLH2q/7Nf37k0kzGR3VPexnGe4GcWNDX2ttrxujfOAMZ1Nl2l4eLIxBqIawo8Y4Dh6QTTLI+hI7vGVwSlFkzwpB+WJVJvUwWRmhfufM8q9Ibg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749599015; c=relaxed/simple;
	bh=ztsCx+1Q8Zp0g/5joSLTM9OjXRM6gXERbksi7q4yWbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IDolAU42JBPWoFRtFISO1S2ogXE0ddn6NcLIo4rmMqdvmylIpRMrWVwcLhguFh/lwtiKf/lzAKnwp+8kzKS60zn+5DR1AvdD0TgHcZvdMjHX3VQ2TraKHUWWZ7peCiHs84nWwWlA95B1CAyJsEG0Ba4GfEhvgq0134D3kbuoZzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OEtFV+XM; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQXCP4418RGzhJNofZTpYxENtLt1qsoLGanCT+LERvh9W+hHu1Frmaeunq/oAB5aO7CrdU85WaLasZHnL5+vN8ogfrB4zYRZFLY0lfDo9CheYRO2K9Hb7M7qTxVtQDYCU3DX0kyIWvdutqR4IOXJvaBc9JZaxK+XFkKuuDmWeA3RmctcqKrEGA3wL550XXH+Vr0IhxPNx6kJBsFIHKRr7PIuKqVaaIJeTrXAjlaXMB2/5yznRccj1tuNvMjl7hXNI4Dh+idoqAVKAwN7fUHkgZ9F9cEtY3LpTIkZ21CEXq3rjxjsL40RZE2QI72AG14EdWkF6OHHvKz+3nhsFbDSYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zy8SkXKusre9LXby2bdRXuOIo2KxRQA0ltqCv9SzDN8=;
 b=SJSNdmSwwFfXRVIKbq+VZQ5lejZNynxHVSSGTMcQb7AuDwb8KuJUzfEjxbmFITvHJBIpGFgbwcbbUsTpxC2/mLlAUT30Qr2oyAifNzDRoRRbny65Lp9rrF6amQ7tA5bIAnm+Gb1jEFQ5N19ZcHHeAjmwL5ie+R/Lvplij5ISpHyudvVJuvkjJzvDaH4f4vyd/k/N157IoA426yR2L57p419MkI52gh3zRF/qdROTny9fuhPxsyNtXAqBekFTYV95xT8PpDWEUwIUzMWW5jZSSBON/acZFpqIR7GoElf8kuB5igPDus+aHmepUoMcTN4dm0JoHcPHgiWegkpl4Nbrxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zy8SkXKusre9LXby2bdRXuOIo2KxRQA0ltqCv9SzDN8=;
 b=OEtFV+XM9D5fosj9xVX//czDu8PkA4GwFEQVSk+D1hrQKdWg+vsbaG+fUF+PihV5eXr5jzFjFItuiTdzinGJhkYQhsvBGT2/Jyy9XvvJbzFRh0ti8uhYfJMyyCkdnU3cJuQJmSrN+MCV4hg0ygmqgsfApJSmZDdUXSMO4Ahg2clqPSE8af2GnkzDE38HU/5DuJg1bSdz+kQsq2DEaTJoKTFh6LgpHcDNEDNPFfKB1ZM/ak0ImaaFVMCbMIWMh6LpMDK274C33JBh4huZUZ6TRK+BfWquEK3uqLgQ9AqwLrkoQfIL5ltwDuM+to3omdF2/u4hdV/Lr9hI3em8nqqAyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB6221.namprd12.prod.outlook.com (2603:10b6:208:3c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Tue, 10 Jun
 2025 23:43:30 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.038; Tue, 10 Jun 2025
 23:43:30 +0000
Date: Tue, 10 Jun 2025 20:43:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org,
	bhelgaas@google.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	patches@lists.linux.dev, pjaroszynski@nvidia.com, vsethi@nvidia.com
Subject: Re: [PATCH RFC v1 0/2] iommu&pci: Disable ATS during FLR resets
Message-ID: <20250610234329.GN543171@nvidia.com>
References: <cover.1749494161.git.nicolinc@nvidia.com>
 <40f1971d-640a-44b4-b798-d1a5844063e2@arm.com>
 <20250610163045.GI543171@nvidia.com>
 <aEiXXYdhyeqcNiHX@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEiXXYdhyeqcNiHX@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB6221:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e7921f4-734a-4ca0-895e-08dda8789ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DEr5gjT4Lm9Pv+vaUa0Lz/qHdu+dYDgaE9x+ku+yqPuzGaDnnQJw6FW2FXLL?=
 =?us-ascii?Q?XdM0I36luUR7hVu+xIV/OjRomhffNlxvGIr2XNHO21g54yrT5Q12d7W3vzZ/?=
 =?us-ascii?Q?VJACXIUsRvkyieq7askztfTSVonW/PvIOFK/1t4HB3gvNHQjCY0hnGYo+Ao5?=
 =?us-ascii?Q?tZh3C3/+7UtsK2gh5rI4NYk0MyBameAMVmr9ezYBN2RSb+MI0yPQEzoGVEcm?=
 =?us-ascii?Q?mc8PBAwjQc+S6HPj2Gy5puib5DK7HeRmfOaqhxhxBO3EdZfgnnPMeMu8hYQW?=
 =?us-ascii?Q?SzhaDyK2YAx7s32ybGa4WLwePYYkh+fTCkX9AV8xObG9qSsf6yXR1M/YDwMb?=
 =?us-ascii?Q?hlQVS0SmY4OzjPLn00wM6CQ4HVPqUhZe02FY63rJfp6WI1mTXbFM58EQf7qN?=
 =?us-ascii?Q?UA4RUYJ9N93eHZD00tDnTC7Ok5LNs3OECkLz8pT/5+H3VCmhu6WkxCO78mN6?=
 =?us-ascii?Q?MqHZDyFT/B3xzEBK/Oxe1lf9wHR0K8BmQUwyYeRBz1aT0SIxgKtV6K7vrsAf?=
 =?us-ascii?Q?Tbke1xcITy3FlU4XsnULI4taRXdkI2r8P3W3NJAPR+ulAFIOWg/xnOu50/lo?=
 =?us-ascii?Q?GfOF4zdfrjFgd/O1SrRVdHscO3h3IyCAnTvhXpVcdTRNY/CySxI9QxEsyeP/?=
 =?us-ascii?Q?pjEqawXKIKFDe5qzDeDInbBOHFp4kA3Rx/mHwaEx6lot9TNZyNcFk/K8e00T?=
 =?us-ascii?Q?85IFTnmsjfZq5K/b31Y0kKFdLMYzlSHMpAj2ZjGpsvRbrFt4A6k4GTGYCvmp?=
 =?us-ascii?Q?4NP+xB1Jok/Sdsrrcqx515cXuNg/pVS2TSmMvujlhnge30NxMEQ37H9qpk+C?=
 =?us-ascii?Q?zPG7rcUTF6o+/B7HAabL/aQOUm0YIQDZ5fAI5As9h6c48D/wPjF9XUVcnC1j?=
 =?us-ascii?Q?3XM6EHbOabOda3GryTc/FmUFMsHgJIUCHxl9kzsHmMp6wIkMBPimK0IEAZG8?=
 =?us-ascii?Q?AvzmEN12dhiisR3M5Ut3cSqYx3rx5ohiSKSNAnN+Ozdrex7Mn5w8tRIY9/Qe?=
 =?us-ascii?Q?4Vk83yyj4qC/XdYdLm4Ecvm5vaaj/ksz3WPGmUG9qEHJ5YP6B4GD1vcwlCTe?=
 =?us-ascii?Q?+yM6HdoWjxV1ZHk/P78IFo4hpFuAGXyou5ONgeHe0sDgo2tJESyOwcX2WDR9?=
 =?us-ascii?Q?FXQI9m2KPERfJoE6AWx2RxVSRtbnZAo3yhvw1TWRH9kh6fllc2GYO2nTF5nQ?=
 =?us-ascii?Q?0X1zlK8O58TLi0uAy8/lc9DPMqT6GTcX9Ss3boSF7dxpLpCUOPovVNoqfN4d?=
 =?us-ascii?Q?jcm8gN6ikgdBlgqk4Qimf6/utoCkUnwLcq5sLX/SEAnLXoEJcQq6XMrXQ0ul?=
 =?us-ascii?Q?qpoTbW7FpqdwegIKqP8Eck8c95gsXm6oetdV/RltbvT1j/4CFP6NDPvwRG5p?=
 =?us-ascii?Q?dzzwAHt0oPuNuILmq/O8QWB+qYRwO0qWXOZ9Wl6WMQTwqezWyGMXGsfPlKBq?=
 =?us-ascii?Q?bgug6h2m8G8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?46PdBESfNfyT6RNHIUs7qR8Kw5T+SEsEyJIPtxjaj8GQYKWMgHmf2YN/lrIs?=
 =?us-ascii?Q?eUgvRY+WKsxuv7kqPgvs33co0+j3w4Q+x8xXiOLNsP1C9aOItWpVy+MEI3o4?=
 =?us-ascii?Q?KGVWcZT5AmXUMmwTq3O3r6lACdNY9uicKJfHBNFbf76kxHrNl9KT9Io5D+vD?=
 =?us-ascii?Q?1jAqpvml1h/rLzUoe/sZcJj2nqdvE4oJ8t/FxB+G0BJIKgEUeKM+MUHFSk1r?=
 =?us-ascii?Q?4Kf1au6Cd997FZ71mlYu46V0A1+FJb62n6TeZN/rp+zVKBzktOzosRB38NPO?=
 =?us-ascii?Q?fTMFiYWMLc217tlOPkz5vnKYl/+rtmS8J6LMESXB4SFMwr4nIyPytRWpeDot?=
 =?us-ascii?Q?pjPBQM5wuVZfR1plY9DJG+kEXq0Lggn7JIOiG2EAnnAnt3q/Z/n2+TYGxOUQ?=
 =?us-ascii?Q?ukeNiY6ZKEGTu7RBNXMeGwYL7R25cNZUaOycC5GRVRpi3vCQkbyIAAVhgqx4?=
 =?us-ascii?Q?MdtgwCMEzeL0C1+Z4rq3+XMdA2/aMCLASmgv7cnFs3O2115HvDOl1TnbupYU?=
 =?us-ascii?Q?w1PX4kDJr7ZtaqvvdsOiGfgmjZFcktUedN+dpT5aY1B2O+CRuxBb7WhtjUe0?=
 =?us-ascii?Q?XbCk1vUQ/YFlPWkLlIswlacCkHBu/0+POdz2qa5rhKLp9CloRceq7zpp9D//?=
 =?us-ascii?Q?pezhUbZIM9xpYZ4uwvVVxCVb73x5cJXSAlZolk/rBOiaRcXlyTq1webSSIvk?=
 =?us-ascii?Q?gpmImSf8R0lYKP+IjHx15AutQ2j0fH7ZoNpT0YllRRokj38dIl2IAVGlz7hz?=
 =?us-ascii?Q?j2G/wOeZfjA94Lpe7yljLLENxinQtryKg3URNu0dTio6dwGxueFAzkj8CdwL?=
 =?us-ascii?Q?lapeXNKGgTyGYBPxbtaVEu0a8koLY3yBFLuxU37qS7HKwOx7fIRz0nh+sEpK?=
 =?us-ascii?Q?bsOwbos42t09wSC8wFiJKsYKlk/kE0Za6UD/wHpZLxbEl4wQAN/leNDNZv8C?=
 =?us-ascii?Q?2DjNVkKy35NJHZX5NfnV56MHnTp7UaUOmc0PnZl2AcqoBDMfNDT9Z6QoAWb+?=
 =?us-ascii?Q?9zThQ5rdccsmFfd1Hi+qSDOtLhRJ4Wm2ZNTDVGDwqfM+9tjL6f1k6DEDO0zU?=
 =?us-ascii?Q?HVdcR870Inpf5iy2aWcb4eR18shhyQqFOMhAga+SqUNg63cko2c426XrPtJY?=
 =?us-ascii?Q?29jfoJmtTHZLWrgCrkWjkFRcHpfJW2iTQgiH+GtBvVqLhaqT2rr00us1heLu?=
 =?us-ascii?Q?FBYtM1ck0MPq3wRF/rA5XUwLs14rAf6aaWZjwl6lsp3hrSXW3V8xyRpDOGsb?=
 =?us-ascii?Q?oGJ9mUE5VkD/rx/IoRXRBwvS8O40AQNsu1NMQ0kF6sbhEt/jn4Pa4aMf/YXP?=
 =?us-ascii?Q?f9+yNqCTYNDTcTCVtSgu5H2F5Nu2CyAS6Ao1XK5iK2/G2gjJfyEGmiJphh6i?=
 =?us-ascii?Q?JAv7mdPMdi8/4+dAe2M/jSIQWe9URbF+G2E46ksSQ4ilSeesDEf2FeSmau3N?=
 =?us-ascii?Q?RjLm2TdkGeE8hLmcHRIctZhqi8dcR6+iCBOM9YD39vcIYzKL6RtYIoA1rcPh?=
 =?us-ascii?Q?jnOG3gLaz0US6X3CzpS0DoK6o2o5HPLyeKa9mpbhCLQ6aYEkDvnsock8V4ZQ?=
 =?us-ascii?Q?vyh3Sq4o1Ic6DOPNVnVmWUEDiAlB1/8mxpyFA9Nv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7921f4-734a-4ca0-895e-08dda8789ada
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 23:43:30.5568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGGQMnDFXn+cBH8bT9E5voJHuWWGUnDLx6IcXSS6rShjI/RSzVdenVuS9xp+uEtO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6221

On Tue, Jun 10, 2025 at 01:36:45PM -0700, Nicolin Chen wrote:
> > I don't view this a problem for FLR, we can hold a mutex for a long
> > time. It principally delays domain changes which are kind of nonsense
> > to be doing concurrently with FLR in the first place..
> > 
> > However, for suspend, we probably want to leave a marker in the group
> 
> IIUIC, the thing for suspend/resume is that it would result in a
> long hold of the mutex, which can be a problem?

Yes, it would be a confusing mess to do that..

> > that the group is force-blocked and all domain attach/detach logic
> > will only update the group tracking structures and not call into the
> > iommu driver. When the resume happens the core will set the current
> > group domain list to the iommu driver. No need for a long lived lock
> > this way.
> 
> Yea, what we don't want is driver re-enabling ATS. So, bypassing
> it at the core level should work. Then, iommu_dev_reset_prepare
> and iommu_dev_reset_done will only mutex the flag.

If it is easy it seems worth including.

Jason

