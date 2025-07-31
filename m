Return-Path: <linux-pci+bounces-33244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5AAB17249
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 15:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B271C20EB3
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 13:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E2F239E84;
	Thu, 31 Jul 2025 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h9kmH5xD"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8D222338;
	Thu, 31 Jul 2025 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969650; cv=fail; b=Htw2ZXSBseHVxtpEtOST12XUPhpB5bj/MELEf1uEEE4uRGjQ9GxUMwKoJxODxYt6GL94Cu9ITrUEad2tVys8LmjFx1WleWqYgqNHC3P5FCvLKEoM/JE+56HD0kUptUSLnRzSxu63CP0IQB0prcm1wclo1VCj5t6JkkW76WmiKBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969650; c=relaxed/simple;
	bh=D8XtFlIOYjW+Na31tdyJLVfCS6PLmagoTDhvrV+KE18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nEe02QB8jqHoYyY7MVvs6NS5nVNewU4YMPQjvLxCiCfIaUmNT3sX0sPv2vku8BZfhe8oNehMGDHQ6O8UbZSUAY6W8RWaWk+fViNmD4DY+7q/2JOK8yk2fnXwB8Zcq4C6wPqubOW3ML91mQ5v+erywWt2CVwF4ACXwN2m7ZTPDZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h9kmH5xD; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8x4cn7iF5bKDPbB9dRGENg7vplO7zPFtUj8Iexk/rG/nSK70EcylNJ6fXemnxG4ZxnIA50Vs7SSRjr/ZBXiIKm04atyjW/UwtZ+kxGkeKEa5j0WjeW3G1lYumHwMytTlcgwc0SMuCdtqmRHu289aoEcVT+sh5IVglBgnRRCq6LruIbGzlecrW0kg08Q2lyDsMsY8ip24o2cOPDTJnrXbzeEpFK+oYvff529cUESlspw7E3IBNgbA1EXJAT94jL4YQ/t1eOtsjuptOWJXxolrYH34mVU5XeGIZ2Np12vy+LUhXd1KzmRN/6nR0uJ8mML6LxLFYL1HnR10Q3VAaFR/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrmeDPKrZNKaRRyEdELhNyk8PQuszxPcj7I3IfBusws=;
 b=n/YO8blOuN22T4PQm9vmlo15Sajqev0WprXhaEYuF7TBBRP4YcajebW0u+MusROKWKU1pN27y1qkT28Sl7VSy6iQVxJn5ioo8a5LN3t8EEEmgv2cqs2lgjoneqJkFyfSnPe0saA+i2YG398GO2ofcPY+jfzPttfahVg7KopMFarsRIbcTywyqlDmZVabU2XWz8YS7twv/INAI+Rl2XaHVP2BZg02dAIxML8/jPacO5w8vu/7V6L3O4ErxshV9OH65nB2qHqzMkJPgie56kMxzNRpOAv10QXS9G1ucJwGklS1N40UzL4vdJ5rKn1tPajTmu4HL0wL7V9JcKcChlOeTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrmeDPKrZNKaRRyEdELhNyk8PQuszxPcj7I3IfBusws=;
 b=h9kmH5xDpBrA5djbM8bVfetLFz+lCBamdqLOefnrkG8+wcxWiWFy8t2eXFm18/ywpn8RVWkNfHuRA9lRW8Jp4HzNFqylS1fSGaHe4J8KPAO/MYKuS/22vBu3hvG/TX4s2c6iZN3BFgH8gK4PxjMjnZ2rjKZCC8o1A5wsrmH+JGwnoQwHNcC55nh8+84bRWShX7g9/3iztAUQHrgLzsnMD8PlK8tfNPkryeX7ogUcXCFuiTMRtn5KB3xoAqX3hYKfBDwz8nG+BgSLFyhffNbnwkBQyx0xKp/DovVcW4xeriMTwx72XtrsCH+z02Zxf5t8FKHbWyiBjfDtXPKOm+4nmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS5PPFB8FBD73EA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 31 Jul
 2025 13:47:24 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 13:47:23 +0000
Date: Thu, 31 Jul 2025 10:47:22 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Ethan Zhao <etzhao1900@gmail.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, rafael@kernel.org, lenb@kernel.org,
	bhelgaas@google.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, patches@lists.linux.dev,
	pjaroszynski@nvidia.com, vsethi@nvidia.com, helgaas@kernel.org,
	baolu.lu@linux.intel.com
Subject: Re: [PATCH RFC v2 0/4] Disable ATS via iommu during PCI resets
Message-ID: <20250731134722.GA184255@nvidia.com>
References: <cover.1751096303.git.nicolinc@nvidia.com>
 <4f7e4bfb-1bc7-4c87-a9f1-8c8b6ee9a336@gmail.com>
 <aIOz1bzgfK9q0n4b@Asurada-Nvidia>
 <606f65e1-ccfc-4492-a32f-90343be654e7@gmail.com>
 <20250727162041.GC7551@nvidia.com>
 <d7543795-b172-4452-8789-e1c810d8075a@gmail.com>
 <20250729125953.GH36037@nvidia.com>
 <f6fedc6c-9f3a-4ffe-adb1-38b4f1632647@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6fedc6c-9f3a-4ffe-adb1-38b4f1632647@gmail.com>
X-ClientProxiedBy: MN2PR15CA0024.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::37) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS5PPFB8FBD73EA:EE_
X-MS-Office365-Filtering-Correlation-Id: db58b373-b81d-42a1-5793-08ddd038c733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RvnqaGQNtqFEsSs+g8DUXg7ep5fTjwUlrixiAfFZG2rGcouBnZTX0TlIxxxq?=
 =?us-ascii?Q?grmk1/ajGQV+glYn9ZeyXc//ECBQoBX3q5+yJUyotyBwmoovEz6HoFeGob1H?=
 =?us-ascii?Q?fuQV4ChqH1t2odSzNYf6+MiFn2oMK/J++w5AsqEumkN+9AH3KzmrTI6DpjlM?=
 =?us-ascii?Q?pVl205Wl1iDUSgXVymsXTGn2pJXWDGY3LJXlLGWE6g07onyAa3Bv5bI69vSt?=
 =?us-ascii?Q?VRjCxTfIe+xFLXPDQQFRJybavjRg5KyGUr6KiY5Qhe/mhou9TNGpa6pRqcl/?=
 =?us-ascii?Q?T6qRphzP5XVo14ytkYhK1nxhh66Pg6E1HiirVy7epRhUSF4fvivMpAOuJoGJ?=
 =?us-ascii?Q?6qMD6MkoNl0ple5i0CpyOEFQiyNpKhE+2QcxRfIRBi4PU+bIWRyc21+ds/u9?=
 =?us-ascii?Q?lH/HymJttOAvuT0UcoP4T6EbGrXJ4slhiIAnQIw4vnpf5qKp8LOj73fYhwpL?=
 =?us-ascii?Q?6att6ygVYuKNkDa2Q/fliMENwSF504Pm7gq8W0Bu/gLgx0gy9E5bB60oMc9V?=
 =?us-ascii?Q?HxBh3YsRKMnQQMpHHzFuhSpKS3cFYUpJSZ/4fJMWKXyN5vHXjve6ip8JzjG9?=
 =?us-ascii?Q?01CQmJu6m6LdA1aQu0/VWzGv2dWFNpp5QND+FhKGspMbwA8/DrHIB5BCLGlF?=
 =?us-ascii?Q?TbRcsVu+IU1cG0nNCY9UuLBqDRHqB3+62p4SovjkN/IU4/BplQ2kMniQowJB?=
 =?us-ascii?Q?EtohZlDuIWnl1I109j7g+NTRTi89SCUq45tdeOGE7qdf8cOMI6GkKXWryWMj?=
 =?us-ascii?Q?XLV+hdaeK5COX7mFomciEXroLqKAIecOyYEUJtNH9+A/1Wx4NsLcjba3aGwc?=
 =?us-ascii?Q?ymNUIsFz4uHRInP0P4u+SpDnuRzzTYPMZ4hf8TjNkMhSfJXNHpV3sPhVl9vV?=
 =?us-ascii?Q?90UPbJQOBnJH53CSk8Uv7SPtScVHT98Y2R0h/256sJ08Z2SkyKRfWRBsH2Pt?=
 =?us-ascii?Q?BW4AVkVViMvSUi9UhXL+0nhrMCg8RYsILKEGvZwL/T/BJOjMMKgT1+SwsoSm?=
 =?us-ascii?Q?Z9938XIqtApG/wMx4g/3Kpfx30aI+H9Otsn6xpG6yJBTsasfIiUxp+DjYPgG?=
 =?us-ascii?Q?1Y1M5AsJTu5EvPORgNer0zZrMitLgYq9FRZYA73T45p8hWUhAnS/+4IunDtx?=
 =?us-ascii?Q?mOI415AK50l1msgsAf82cEcZIz8lged7zjNgZzbzlhyH7Z8Mkbg+St1qatzd?=
 =?us-ascii?Q?KLe/dax3sv6IhQDx/V/0ghpKSn7BNYsyXcIt8m1YzBwFgxCsEHsWug+ZL8Ak?=
 =?us-ascii?Q?2VBSqP2txM5GZmRh5CQUcGTkLwBkaPiLhVEZvSLTAEDB5j6AbSDYFJKk1Jp1?=
 =?us-ascii?Q?goGca5DmeSsB9L9KptWKY1gr1VPversqBLgBEHtfnAGWcMPAbeRv22dssQCP?=
 =?us-ascii?Q?dO2id6U27txqDq73xh/jV7ZmKIoDaTnDkXWvs8kETErciuw7x+HuWxD2kCSx?=
 =?us-ascii?Q?O5gCTMjyveo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CEkNH2zZf8K9edEIgDRNiSNSm8p7ZRRCjM/55Z2ITMYnfISzF/RclIpw2L24?=
 =?us-ascii?Q?0fqQbwWDzsW+s4SO4BkATrnNgSa9mpBKKHSl7BB9ppzXoxlHX3TSuLKXCcWO?=
 =?us-ascii?Q?4PdfknZ/pGwnRCtwQN9iOs5NjwbAK+4DrsT36fVwuU87VJSVkgelv2QZlebH?=
 =?us-ascii?Q?I8br6XC+qCbmI3HaCF7LsmOm30QLlvyenyOH3O9zIMh8ziPzmk9UEHaqhwyM?=
 =?us-ascii?Q?0P8QTz6ntozLbYyfxNhEVA2SjiLUK0QgjdQoExdHGEMuE9Km9vqw+GnkoX1V?=
 =?us-ascii?Q?LPV/mn75mNbpukq6zkdqu/z/I1GZttAq3K0W2OgiXT1w4XlJ0BGk1XVHJaYj?=
 =?us-ascii?Q?SHve86QaBwveOrbRjZ1kxls2+onp5wn0Dh2DS5N7kcFwPR+nU7Iegn/JJTPL?=
 =?us-ascii?Q?yDFBtPERw/iHL5CSdHvs//V2kgsqyPzgLmcO4wLAR282ay7mZ1MKwqo/H+nZ?=
 =?us-ascii?Q?uML7Ci9ifbjQXeNAgcc99nx7JJ3dBTaJX8jfMugkPjhYT0iHvdj/egLzWy5R?=
 =?us-ascii?Q?HSUCZEl7ACWSMs45+caZTgVcIbRAaILRcTrJZZmZjBLAkR6lmxhUsIOpH8Np?=
 =?us-ascii?Q?k1wNifjQzov8aFobq5cXmoMWWM84eNW10GVjMoNPgYhfY195fACbyTspWKHB?=
 =?us-ascii?Q?LMGPSzIZNZI8nCKUxt8AXTljT1ai06n5/NRrKOCyyHWOIp4I2l2wcZfMehNx?=
 =?us-ascii?Q?O/cWIwSmSUbExfMZgw8sb6WzXsnY8HeYjEH0pitEZ1GJc4Xd58Pt2de9EAcJ?=
 =?us-ascii?Q?WPdcPPGDCXfdy2Zzc13NH0gUy4yq4/XTDryzTwm585Pv41FHpTipOprdGr5Z?=
 =?us-ascii?Q?yMs29uXS21KUQw64hnmieqbxpqF1raJilCdurjIET6MmK7YFgUpaFucB0+C1?=
 =?us-ascii?Q?d0nsaHAVskns4taVwFOzxzzMq3+v+ljDbb/iux5xWUCEvPt2SoK2CdmTJ5DV?=
 =?us-ascii?Q?4MGtRUSlFOtlsQ2hJ2+iPLeLhGiVpMVGfbytw74oIY60K1B3AmuS6hY3dIKb?=
 =?us-ascii?Q?LEhBjMGVby4JImfqBfTPotSvNfgXm12ls8y4SJAhHzstOwZrjeL3qnWG+sNS?=
 =?us-ascii?Q?HNswMsGdy/P1VEygp0jm6wzP2Ty0YT9+td8uc94BSxPgV9FANacUBK4VLnW9?=
 =?us-ascii?Q?n9FafxDOGtT6N0XjYUTktP1uhQsC8GofKKY8MmIyJ4sGIVLrH++pRABKwxhl?=
 =?us-ascii?Q?lk2K+S9Jz5qCy5vQClpdoFrzFufxDt+ILEzMmqSETPi916HMZw2Z8i6va25O?=
 =?us-ascii?Q?59pybxW4N75WBbDBZTZZyRE/SLxYC+SavZ40AKXvIVGSA9UjhRBfdGV32xAv?=
 =?us-ascii?Q?4Jp9olgOz9hB9DnYpBufeVlhpqEpsFOzCXED/gVluhnJv7D9s3czRQ/N4EXR?=
 =?us-ascii?Q?jZNoghhR30tyLHXneeWYcsjrCDJsHawHJz/wH4P+QpfXp/xJ2wMOOScP35yE?=
 =?us-ascii?Q?bgzVeYQK6Kt4RgK32+6ZBfByMFNOXwVzTHfwwJOy0CgcnPJ2Q+w2TvWqvd2c?=
 =?us-ascii?Q?PUkVVo/YPzYNNqJUdRKNu+I6SlO5hOJmZpAqMxx1sXG2zME7u8rTLfw+Jh7d?=
 =?us-ascii?Q?zyjLR+Z5hgvafcCCtQs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db58b373-b81d-42a1-5793-08ddd038c733
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 13:47:23.7987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjxIxTevGgizfirnsbVx3Kl3Ewg2Pl2VDNHJsPgkjNZXjLGBcjhc7MW/PUupdulp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFB8FBD73EA

On Thu, Jul 31, 2025 at 09:10:59AM +0800, Ethan Zhao wrote:
> > invalidations when the FLR is triggered.
> > 
> > We have been talking about DPC internally, and I think it will need a
> > related, but different flow since DPC can unavoidably trigger ATC
> > invalidation timeouts/failures and we must sensibly handle them in the
> There is race window for software to handle.
> And for DPC containing data corruption as priority, seems not rational to
> issue notification to software and then do resetting. alternative
> way might be async modal support in iommu ATC invalidation path ?

DPC would still act in HW to prevent corruption, SW would learn about
it either through a DPC async notify or through an ATC timeout, then
SW can reprogram the IOMMU to disable ATS.

We can't make the invalidation path async, the invalidation must
succeed or the iommu itself must fully fence future access to the
now-invalidate memory - most likely by disabling ATS, blocking
accepting translated TLPs and flushing out all previously accepted
translated TLPs.

Once invalidation finishes there must not be any IOMMU access to the
memory that was invalidation, and this cannot fail.

Jason

