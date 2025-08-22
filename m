Return-Path: <linux-pci+bounces-34565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BB2B31AF6
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 16:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B601CC0C95
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 14:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B0F30507B;
	Fri, 22 Aug 2025 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fP5neuLr"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D580B2857D2;
	Fri, 22 Aug 2025 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871708; cv=fail; b=OA69id3QU0RvAPv+VlhzjjAxqAnfsHmSic3g5EAWGySW44s1totUDQHfrRrMlQQgzQIwQ61pRJVkWF+V6lksl5xV4n5G5/O5Zx8i4sZQnMibeR5y1/Cz7dinXXQ2WxRUlRmRuO60htcop4EK/WLMSZ8cMtWNOFdrzjqF5yKmthg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871708; c=relaxed/simple;
	bh=DwCItR5Zf8P4ffJFJlhHm0OnoOIbjwQGOjHuYMr7lvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=luTuA/Jh5e//1BcdtukVVibjQFsF9f3RxkFWz6Om0XePrE2xMqTN3T2Husr/3PxsiWpSlUYOSdXsrA1L5wrLk4/pWeYmUozGeE5ThYVAmoqZ9w4T98QsVUF4kEX7/hfr1RnKTIHFOrvH/6oNL1bQEBXSWxXoWdMt6G92zeIEBI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fP5neuLr; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0pJhcMCBIfbt6bMPQ2aUFE+TQ1bHw5aVHPx7meq0UYvcmjOIoADhFDOgKd5d+sLxBhqmL64czCGgnN9j1dQAxTqwNBz7GpyuErIyosbbbeNYr3L+hvl9gPvysBZnPd6eR34Q1B3bWDzOMFJQO1+pnNvgAMAmB66vqpvwyLuAGdv4Y0ljkjpxxt1umodWOk3LOymEOdF6443Jo01MPAan4fEUS99o8FTZ63lC72gg5OC953aHl8k5SbQHhHTpkscZ3enR18UOBuARwZaNTvTAoVrsAS/APg7x+QUl0hz3ae7GdVQE5kGReEvnoOvoSlwRH+QVKg3+gYJOi9HwxExuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9v2lsHeDrelTrJ0icGcPS1c8mav+ES3EK0mqQdgOerY=;
 b=sDnK7ZMhoDealTc4CnaSUjNeaahZG4voivHrxQ91GVWezA+S68LNm/TigyzI6ZjC+gRadhVmROzWI0zaSnizMZ8wdjGXNyqW59UIgR2GSN+R6ZpnbP3DeRz6O6euYFqQUkUhB7P3iZ0CvuWSmo2haSe06o/EIyDxWNlCyTJyd1X+eDZX1nrRCQo0dsHDSpG91EoLiOdCGONKJwmHvfIWy6eW/rl2MqWv3kw/abRuIxaNbJyXZRqpRqZlvMoAJA/sVxagw9Kswn5QgxU0nTCMVVmAugjvneIrbqLpfZUjd63K/iY6sHxil8snO4WzLN0nWZgPbRryTZiFTlKpFnS28A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9v2lsHeDrelTrJ0icGcPS1c8mav+ES3EK0mqQdgOerY=;
 b=fP5neuLrR7t+UOtzKi7DYtpiI3pkGF5DoXOY34nw5pW2SY4PBwZmBd7ptu0Q1PpoTtHqeRhgPAn4pg1pOhAk4S19BMCrULGsW2HYt+Aguuip1EeXAW9jMcas4LztFrr0jv3IDYyJ+B5lciGTF0OSjaBnnZS0WImYdYWEPW4WY+/EJ+yadOYf2ZJE7vtGO/qVKAH9Smxq86HcDuts6a3uZMcOgesklpDJff6JmFplS2Kcw5u3MfzaYnhhWJcHxuGQ7/FzTxZFQ2UjWVFivuQM9KOt8KCNLXL8Dll5Zu1aYClgV+u86AtWDTF3gxC/u60IbzVmmi0qH1Mws6VmZ1vweQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ0PR12MB6941.namprd12.prod.outlook.com (2603:10b6:a03:448::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Fri, 22 Aug
 2025 14:08:23 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 14:08:23 +0000
Date: Fri, 22 Aug 2025 11:08:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Ethan Zhao <etzhao1900@gmail.com>, robin.murphy@arm.com,
	joro@8bytes.org, bhelgaas@google.com, will@kernel.org,
	robin.clark@oss.qualcomm.com, yong.wu@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	rafael@kernel.org, lenb@kernel.org, kevin.tian@intel.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	patches@lists.linux.dev, pjaroszynski@nvidia.com, vsethi@nvidia.com,
	helgaas@kernel.org
Subject: Re: [PATCH v3 5/5] pci: Suspend iommu function prior to resetting a
 device
Message-ID: <20250822140821.GE1311579@nvidia.com>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <3749cd6a1430ac36d1af1fadaa4d90ceffef9c62.1754952762.git.nicolinc@nvidia.com>
 <550635db-00ce-410e-add0-77c1a75adb11@gmail.com>
 <aKTzq6SLGB22Xq5b@Asurada-Nvidia>
 <20250821130741.GL802098@nvidia.com>
 <aKgPr3mUcIsd1iuT@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKgPr3mUcIsd1iuT@Asurada-Nvidia>
X-ClientProxiedBy: YT4PR01CA0492.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ0PR12MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: f6b08c05-5412-4b83-6de3-08dde1855acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K4Sn4efH8CrFP1YLLxqgcvSFhUcF3jLxenK/y3a5ISCbzjDwa3/2Jogf5bXN?=
 =?us-ascii?Q?RmW7QnZfNGvtZAlaNJntEYS/3EIHyUN6rjceGBuDcvXtTu9upE4oqVnEFOZC?=
 =?us-ascii?Q?c9Yg5AEL2hMOFlQJd1Kda/SqVfNZUhKcbs+sFUvDLzIFTd9bYAb0f7YJykI9?=
 =?us-ascii?Q?BLpg8DrIcZfTidnH6CoB17j46PaZpYOY/ppYhS6SRHLV1PxsJs/Z7falrlnk?=
 =?us-ascii?Q?SrAKThOmGVlMPbkwlUwRGDs8++JeOYq4DzL1EeEVOS9DbUyik6tzqwEmME+x?=
 =?us-ascii?Q?pM/hovFM5dsx0FsIJF9Q1pe6RAKQqr10PK86HjrknUJOdFFl2OhywJ2cPmtT?=
 =?us-ascii?Q?d05B2N/2EbIVtiRQG0c+exzurzShSuESrurwRFwVMeAHuyROHr2buObQZQ5S?=
 =?us-ascii?Q?sC/lbs+M6kD8JXwLfPAOZTSypuVSUllvKJy+zKAFoFaDcAwMEJ2EZl2mFcSh?=
 =?us-ascii?Q?o2e+RlantQseJaSCz7cdQ6CHzr7KZIUpdPEy1qMYFI+MzNMwuRByDRsDmEmo?=
 =?us-ascii?Q?XGokJTRx+/6pdDE3DN/H9sX34QuQmzy35MeBxr0dJAqC+FaXNWbFQS91Jx4O?=
 =?us-ascii?Q?8w6SKg73X7dcU/8fuqUmncUyx9JJojxkPEch32S6r8Ht+2lnsZN6PqM2YEQ7?=
 =?us-ascii?Q?6AaG3mHFaKdVfg9ciNkK9eICN9YMq6t7/ZFjORY4sDO2WDspy4LJzjyyT0dx?=
 =?us-ascii?Q?KjgzB5yRr5jCZtpbQb+RhK3d8fiy+pboxGi4jtEG9dNSA3UtWERGhQL5917N?=
 =?us-ascii?Q?519/HuIjsqeE1fzHHqZsG546RX8AXS92e2OG6HzXjfUnQv8bg5EvvRwbUz+c?=
 =?us-ascii?Q?NbtGWC5C8OVCb5xoupvRPEUwBs+UkBAJCnC/0O+3ni+n4RDDxBOPMkU4Scth?=
 =?us-ascii?Q?HWERVwXAQkvPHAfWol64jhhuWveXscpme1WB1uZZ5eai1IbLXhNxCv3bXIF6?=
 =?us-ascii?Q?XQ/lULqiGMXPgSiBGx3eVWA+T6XRxsNdZBsKgC9pbQPOyKx/L1EenDPTTW47?=
 =?us-ascii?Q?IWMjF6DPRzCv1YXU6eHsqgiDVbmPqWvNAgFbVnEo59jzOzWOud3JN6jY1gbP?=
 =?us-ascii?Q?A/h4aUYgmmRFhjRDEu9Jgz34pxfX29pu5v0oND7DBCMHhKIJWvj2LrJfzzuZ?=
 =?us-ascii?Q?XtXu/vJDwGXYpaREQyYZccmFwny8qaYqsicJT31XwFX3rDXkWaW2tS7IbW0O?=
 =?us-ascii?Q?zysO6OXV5+tsCEda+LlZd75sNUNB3Y7i1E9sCeElrQ6zTo2gRy1iBmC32Wt/?=
 =?us-ascii?Q?mvu8pCcC5rvcAyS/r2tN+QLfpIE6y82vUVlRJRbsYnttT0OIDL776MqK+qM2?=
 =?us-ascii?Q?U4aiXfCuVrJ+Cj0TC7DwJvS7diacxJpwKY1cNAc2/vGFpO0QiU8OTG3UlHjG?=
 =?us-ascii?Q?uKeRrSiVUDIpSITUyzZz+G21JPJBbURmJSW/drrnLRJDWfgUzg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gzPzT+Hx26THA35AgBMGV2VRCoR0cHSIVBT0XWhue/3FzR2oGaaYtLa7a4LI?=
 =?us-ascii?Q?UK4cJz3KztObVqpXl8nEemnFQvPXf6ZuvHdxsH+u++wml80RS2Proin3krL2?=
 =?us-ascii?Q?l0PmJqX+c6GDDt6tIk0FujVgXkia5aPP/kBI5VwEi+lXSoaZcw9EcGDWKWL1?=
 =?us-ascii?Q?UBDWAW4Gl2z65ljp8+zag+r6SXKgCXs7duiaRSpt/B0DcJ5+1iL3bAXvmCsM?=
 =?us-ascii?Q?NNbyyUcQ07AwCBkN87d94uo54SaMizhWAG+PnamhXl4EU4KjmSshdLvqKSY9?=
 =?us-ascii?Q?PfLpOMMq0O/RGSg36+VDWk2c3EZROBAZcfAmaxWUNkhlT+Os6DiwmyN108hT?=
 =?us-ascii?Q?+7zEJHSO0fcdH6pKd45gizQozW6lqhwmW44VGubClsBO5tGwBkSJCpnXVwqX?=
 =?us-ascii?Q?tHvS7tPv+kdxUsigj3f/X+9FmRyvZoQ3rG9BhAfS0QMnk0l3N+FNCaYuGoJZ?=
 =?us-ascii?Q?Iw4uZMlBICZEzxuR3AR57WDst+QY3R73qonXW/NGsydNH9Tz6KLJaukkIM8Q?=
 =?us-ascii?Q?iTU5AE2Dx9NBZ2+81bAdZyh+kWEhuJcQUUy2FT2VXpm3sQ+o/8V2uW51zDVZ?=
 =?us-ascii?Q?T2NuiuWvzK2j9W4EHZUiKAsKdXftDAmTrN2tCvIuY7AgPL8JgjywwwGmmnsJ?=
 =?us-ascii?Q?wtU3av3rFQh9M5vv3Syua7OwSFBINbfJd5GO0TG1cRyfSUhhEX4ahPEkcDCj?=
 =?us-ascii?Q?XwkayYS5ZQ+YItn7fNTpnox5U+7o+5+LcypVEScfPyr/1PxVZVxYwmBuFkWG?=
 =?us-ascii?Q?mqX+2aVn7lZ8FUiOzir819HAf77p/fJLdHgmdWqk6B6A7tcPZ/5/YrCNRuHK?=
 =?us-ascii?Q?i+ONT46QBocVaml8SVOhHC4/qtBikzdV93dmDDyTgyU87f9CKVtfMIaZrmin?=
 =?us-ascii?Q?XEjpygaROZn+fncsV6NU1TpMQZFxXiyTos1HjRtAHNNkBn5PKrM2aLwCql4v?=
 =?us-ascii?Q?UgDlE0UFWJLb3EJ/y6LLKuUphBV5aGOvqy5CjXhLqyHjQZMWTb4Us5VBgtos?=
 =?us-ascii?Q?4Yv5l6CWnU+HyYD0FXBMGyL23+0sn57DMbnDr9PaZgrtxVLHGSk6qDJVkDlw?=
 =?us-ascii?Q?W+alqPLMXHhMTWLcvtVNUzwf7L6/cPKA48kqwGru3RH6lonwzH9apdVeBrm0?=
 =?us-ascii?Q?rksLP3g2vIbrGeRdefxvZS0Pb4fX3z3PCOQt+0brrzo4bGehe4BEpPrVmDiq?=
 =?us-ascii?Q?mWh+uJiDzRQMUKkxq2YgHga5s4G4Zouw8sWk/01jv6EA21GQXPz/JkFZZURe?=
 =?us-ascii?Q?2oOneUhFikKtl4RKeewFTjV7FukF+CKTrntO2saQ73xEfg/Kz4g9SFkounbX?=
 =?us-ascii?Q?S9krzrG267vZGJ6OSkgFQUI/r0R7BHWAokPmGVKYfQUiR0DZ5GT3UPbbDvsX?=
 =?us-ascii?Q?1+yvGW/sZFzop7jXXytHLGcKuRsxOo+AGvaKlAY0pNGO/ShDpT+JTN27JYjl?=
 =?us-ascii?Q?t2hvGr4RQgTuss6f8ey9Nn8mBavg2GfMPVUtpwncXS58YhggVRnKiXEhO982?=
 =?us-ascii?Q?ns7w3cUUS7NJh5svBSor/TZkdpAHzojQORL2C32bn5krqrYXy4Z+vmrvgEwQ?=
 =?us-ascii?Q?jM6/pAqymMQY1NKbz78=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b08c05-5412-4b83-6de3-08dde1855acf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 14:08:22.9726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KcFEunT9jrEzU5kzEC7ZmhYvx4+aLmtEQbuv0fHS/GMemJsWBvgZzXnLOGAS+T3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6941

On Thu, Aug 21, 2025 at 11:35:27PM -0700, Nicolin Chen wrote:
> On Thu, Aug 21, 2025 at 10:07:41AM -0300, Jason Gunthorpe wrote:
> > On Tue, Aug 19, 2025 at 02:59:07PM -0700, Nicolin Chen wrote:
> > >  c) multiple pci_devs with their own RIDs
> > > 
> > >     In this case, either FLR or IOMMU only resets the PF. That
> > >     being said, VFs might be affected since PF is resetting?
> > >     If there is an issue, I don't see it coming from the IOMMU-
> > >     level reset..
> > 
> > It would still allow the ATS issue from the VF side. The VF could be
> > pushing an invalidation during the PF reset that will get clobbered.
> > 
> > I haven't fully checked but I think Linux doesn't really (easially?)
> > allow resetting a PF while a VF is present...
> 
> Hmm, what if the PF encountered some fault? Does Linux have a choice
> not to reset PF?

Upon more reflect I guess outside VFIO I seem to remember the SRIOV
reset to the PFs will clobber the VFs too and then restore the SRIOV
configuration in config space to bring them back.

> > Arguably if the PF is reset the VFs should have their translations
> > blocked too.
> 
> Yea, that sounds plausible to me. But, prior to that (an IOMMU-level
> reset), should VFs be first reset at the PCI level?

PF reset of a SRIOV PF disables the VFs and effectively resets them
already.

But reaching out to mangle the translation of the VFs means you do
have to take care not to disrupt anything else the VF owning driver is
doing since it is fully unaware of this. Ie it could be reattaching to
something else concurrently.

Jason

