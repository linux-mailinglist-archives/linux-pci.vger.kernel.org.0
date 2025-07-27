Return-Path: <linux-pci+bounces-32977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49755B1305F
	for <lists+linux-pci@lfdr.de>; Sun, 27 Jul 2025 18:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1E13B9C80
	for <lists+linux-pci@lfdr.de>; Sun, 27 Jul 2025 16:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74F521B1BC;
	Sun, 27 Jul 2025 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jb85E0ff"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B4BEEC3;
	Sun, 27 Jul 2025 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753633248; cv=fail; b=AxEvQFh73qiRX3IlKRL7ntvwO0v7nWVBd71/OMpshhoyudPCizNhHQWCFPKvnfsgr+RcaHEG+Ui6Mo7AZ9G5u6/fIYHNSsDUhhd4VPI71h04SVm6LYgUGk3ChiY6eQEEH40LjAcBzUJYMWMzxJVM62itDaQrry4k29Cn3B8W0DM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753633248; c=relaxed/simple;
	bh=M13NX9fKNUMHFewX9XziqABAqgK4ixk4/2CvEcQyzCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hpeCgpGcV2hUZOL/330nPwN8dPasxrfpNIKdmkc6D/08NX9KTGruwBctTUr8M4Q29zVj92s98PFRR8a1WoXBAi8CVzNnqM7c5VL+LVfny6zTCIscvdSVOKqGPS7kaC6FgM6AT5iER0ed82NeAr3WN0PTMdkRXbr0Vlv/QNJ/AXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jb85E0ff; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lG3iZ+h7L4FX1FRQgEPo/niBPuTpPg3XtwM0SkYU+Qqk489oQHGZXNNOxyS8g4J7nmBmDmAVeyc988zqPFgxpQGDme3abaRRHlPHCODgLvslXMiEXtgZJYqbvOx4O8j1lDeY0ML3/0c2iLa4wIYHHyt6W7uzWr1k7dow6hCjgfovPavbVhzYySdbCjTGI0bJXMfzQ3GfCUmGaxN74ShT2Q2Q5VhUDdNe7CSheXLeHoWGWIoiWeBfmqw4bbIvut02Jgnm+RDEx1AK/op1QUOCNgj1al+WY+NEyVIUtgi5Pt73L7ZFnXyJ2OHNEcqnGvIF52CD9zuXgRWvO/LmRQfRvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M13NX9fKNUMHFewX9XziqABAqgK4ixk4/2CvEcQyzCY=;
 b=Fa0Yuvaz2OsKbWfzbSnh0Z/j7C4XOVxsQYCdpXUgIsbnrGpzW6CQFgWBbYddW5F5/7ivjCQQFfe2SVeOcYB99s4W+JHOOJ+XVgraF7uhVWPBz7ZA7xXAsRPOkfh+DQlAI/8/oWYauegY9j8o92AZhXr2SLM1F6PNFXI/+qj2GF6C73HzLlrW+WCwZPxyoRdHse4JGv4pMPbYk0P40ugG+1JOylW84dykBz3KXjknecowOGWJ/vnkdDkCwYmiNZN6drA8n85EMLUHyK3/eXClTufjYP8VcR79voG+ZZW7JOUQpExUcrDDi/xhSFFMsUn9/adcapvPhWDunJGcG8Nzfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M13NX9fKNUMHFewX9XziqABAqgK4ixk4/2CvEcQyzCY=;
 b=jb85E0ffaeA3bevT/y8qwdLfeFknlPMSCbVc0cnUiP2puPHdQkc5EysNDAM5/3QpOCmHNWdfXKxVQaHEPZErpUiN/EGS5vzzwYAMX4YR7R28P629Gdsp95pserwIAeEC8i4/3nV5amiE5hX9lntlUvjCNp1IFOYtEUvyjNNKH1EDFWtlsxy8ZRGF7jDUN1XWp/xuc5TrT9p8CCsJT5jbwW7/GxqLIeUue2WuW4bhGPWez8DKkI8xYUVz9UzgSfmmYOKCTEPnXK4+Im4ZhA3wMiumJ92kfRQ2sdsR6TZ18MN9g8a+9yYILAOVCeYwchUnCc24PH4DwmtPWvc2+GuKtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB6739.namprd12.prod.outlook.com (2603:10b6:510:1aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Sun, 27 Jul
 2025 16:20:43 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8964.024; Sun, 27 Jul 2025
 16:20:43 +0000
Date: Sun, 27 Jul 2025 13:20:41 -0300
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
Message-ID: <20250727162041.GC7551@nvidia.com>
References: <cover.1751096303.git.nicolinc@nvidia.com>
 <4f7e4bfb-1bc7-4c87-a9f1-8c8b6ee9a336@gmail.com>
 <aIOz1bzgfK9q0n4b@Asurada-Nvidia>
 <606f65e1-ccfc-4492-a32f-90343be654e7@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <606f65e1-ccfc-4492-a32f-90343be654e7@gmail.com>
X-ClientProxiedBy: SA0PR11CA0076.namprd11.prod.outlook.com
 (2603:10b6:806:d2::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB6739:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a9c49f-4137-4db6-2405-08ddcd2988e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I2MR1jMvk/V/ianw35xQdgor0ttfsiya7tw0AVWRYf86Vyr80kLZxeJC40IW?=
 =?us-ascii?Q?E9grMOaAFMhEMHRFtlPR7tDvSR42E+FYbOh6a6M8IEYYUsm0Twp2oTksNqA1?=
 =?us-ascii?Q?J9bCpc4z8TNitarsnOmApMzOlEPhoYeF7JYmvpRivED4mA77YJbHKLObvoVe?=
 =?us-ascii?Q?x3acBRMmTyCFEUIkpGe4nU+2iE9dAdvVA8YcqDzCjuSKwjSpAKoTnCti79mn?=
 =?us-ascii?Q?6bc1M4695wKoREvWiIcJtAyx317zDRNgfBPgyX2c2GCTo9tKewlxHOi5L1rQ?=
 =?us-ascii?Q?1dyh0JcQuB7b1YvYJ+HbKnxFVYHlcdehEszN3ZjM3LQ2a7fbN3yeMvn9Cpyw?=
 =?us-ascii?Q?02ipjlkUCDD/aST2iDYLp1qi/lMRD72KPrAhKUym+aNiLwICYqcEKp137MMa?=
 =?us-ascii?Q?yGpGjtW7ToIUvEC1mBqx2MsSWwk5gaVJ8Gahld4V7AUIMiHLk40gnj7XZD8m?=
 =?us-ascii?Q?N++3Q1iPWxJmxj4T+bGsS8mEqQqgIzpNYsqRaSt6YWjquDbtN4++tQ/4DzBO?=
 =?us-ascii?Q?EXkjdo4Uah/OMv6clVMCBKIATYay4TJoyV3R9A7EbAd3yL4JsuJmfw7DQG7U?=
 =?us-ascii?Q?w18zTjM7BJ0sj5ObitqbeN/+EFZkAWGHEquJ7Nz8j2+qUrObRXmA4i8JO+c1?=
 =?us-ascii?Q?XmLNI6dp4oYSC7y06ZbmH0j8cuZJ+lxOEhRUKG8m65T2NQ1igcYeEby/hmJi?=
 =?us-ascii?Q?h6o0SMKJx9uofnyKkTHwER0ix99UV3a0TZnPFfwmAfJUcZXs4y4BbSEwoynw?=
 =?us-ascii?Q?8IFzrzsoqGS1EakZ325i4YAdGJ68GTafA7oGFTXnIZmDZMXohBDSoFQTWwWj?=
 =?us-ascii?Q?Ulzqyhz2FxB5h7ET5LbioymY9LKsrCMXocKizKFpt+tCKaCJXi+0PHqOn3iN?=
 =?us-ascii?Q?zzKEvEcdNFOAFnz4xM9CxK19TPS4FM3qdWwcwOFvGws3cHA7US0dg8m6BnOZ?=
 =?us-ascii?Q?vAieKLj6kdkfgsCrcFLuAHm2wZx7z2479R4QH2P81k1Ue0F5m7oEG7gr1k0e?=
 =?us-ascii?Q?9vTyd483YunT92xK68k09t7ZTMrGiHICAySCV/eAY6/MnpjdS1oLuAflMTCD?=
 =?us-ascii?Q?cbVhB+Yb1rU8fF2PRtlLT61CrUH/uKqmbFwGSIK9JS2LFy/U2VhLXsx9TMqb?=
 =?us-ascii?Q?EJ+LRckQwJyJySvntBFyUlGx+YUfaUH5o65EAMNzwZ1s6bmk0JswuXX3TeLY?=
 =?us-ascii?Q?DyLOSa0BQbvFXu/rF3oySIw4Yk1jkeI87KbH8AtzSY1TaGJUN6DpxGIrA9/G?=
 =?us-ascii?Q?bLR1ygEYGeyEiAXqY7hTSPVMnMCGdiQwUVN1IonUVEaFwNC+0bR1Ccnu7IC1?=
 =?us-ascii?Q?qirDhuiyfYsW05DHrdHqa2Q81M82fYYoqXXDYnEtBT0JyCqxDCK7BV5BT7Yu?=
 =?us-ascii?Q?+Ibva7hFWCg4PVi6IIB29GXyuFthPnc1bpbzN1AU+2fj9GTGInm0WDa2Vr1f?=
 =?us-ascii?Q?41XI63eA+2I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F5DNa/cIKq90psR8VNrfdiprXsr99tAd8nLjaG1QfNP+UrGilqUVCihPoIwn?=
 =?us-ascii?Q?Ni54kb3QrM/IVSLENTo9ySRe0IUr8fXTvqgTP2ocbtZJecFz4/wkvBiHfD7C?=
 =?us-ascii?Q?f2EhvVJP19f5leaynJ1s4/w3BHmopn597vp8QHvKAkCDykcrG7kWsC6IUWbo?=
 =?us-ascii?Q?M6zh+8O7cSpKJY4NIN3Q2Gx+xnHJzW+xlgnihUMbxv2Zprwk5JParaZ7BVIK?=
 =?us-ascii?Q?HM7+wiq46s9RaE1NisJM8Y66Rnb62g3HVb4BKmhpP3ErSQo4HfbS8dt5JV+m?=
 =?us-ascii?Q?frLaBqAjP2nZGO1eYyBL4XO/93V7sqo6fBUAX0yFGRtNNMFsjnMTOnx+XG+5?=
 =?us-ascii?Q?phbPuObMa8T1yPSvirLLF4ptSlnhTQsyD6BV8wyA8uuIGrlddQEHNDPgyzv7?=
 =?us-ascii?Q?SPUM884s4keoZPP/wKzY0oJIdITTNf658KonqjsHaYij49w399bC3pxvDqXj?=
 =?us-ascii?Q?l1LWtqYO1C4XuV93agbqE2lwuMT8q8YG/YQXyHIYfoDw08zMMQmUvwg6OvY/?=
 =?us-ascii?Q?o5cqYyQnhwqlJNuey5mpO6P4AZzz8ATeG0ekMitDjXhVYW+Tpb8LXxY8y2Dg?=
 =?us-ascii?Q?JBzBufySv2jitS0jHJO9RryCfdYRhv9/4K8KKh6FByutgUcRIj1jtc//PnJC?=
 =?us-ascii?Q?lSh87uCI1X7J3M/NoLzR7jF9vvDubt9vbhZjog+A0Ksb0axa7Y5mwSsWEHs8?=
 =?us-ascii?Q?6+5RwhNVpfNVEFJRxoWlIgBUocnR+MIJSI09zgVQu1boUWV4mm3eksTdI5+D?=
 =?us-ascii?Q?mRfKuzRAV/lTZGJfmVya2LElj0FuJnDZLvim4VhFtp+lj5kACwLyS6vzAibe?=
 =?us-ascii?Q?0rbQFP+/dZkLhiBKxDkqKiRfh5T5UTnacAyv/tnJBF6oPAR/iGVSB0Fr/mWn?=
 =?us-ascii?Q?sGwm1qTwih/gkitjdxn51k9EaPnwCRMz0JXY+7XXppXQHyf59EY907ZHUsbL?=
 =?us-ascii?Q?AYA+p1zWSsB4LWwKd8/m7fbr+kzced37Q9WGtnoDtIZegTmgFZvOSN2LAAsa?=
 =?us-ascii?Q?EgwdFD7PRgyqJ4XV5RTmb1jss+XK8EZwyiJYW3t4X+60L7ww+jdEndvs2vJ0?=
 =?us-ascii?Q?l9NSBv3i1g1U59V4kC9+FFhQF14OGJVSKY77hdpbJFKL2bkUJs3vipwfdOLr?=
 =?us-ascii?Q?SIehAEB+Vip1uB5Hyd+BXfVIn5qg6v0082BiREgJWL3S3Zh0IMi82xNq53Lq?=
 =?us-ascii?Q?tZYW/jVU10MGkQV2LWW2sS7KXGM/uMreafEXbWbHSQvOjyif6MkL/ULyi2eS?=
 =?us-ascii?Q?dlnXgV2Pb0/oDYjg2y/+sYqLhoq2K02y9N1jHiTdUn3fi9OvIPQ1onXYaohe?=
 =?us-ascii?Q?QSohCM1mrrEuqPX+5zLJLEJrxZerJX9ZOfhenmmBsSsLW5GJ6Xeqy87GbmGH?=
 =?us-ascii?Q?NzGclS2a62oWRkm6JTJ6gsXcCv7Y9gneGhPz4z5hWhHr6TYYzHOmjggEYpdS?=
 =?us-ascii?Q?a7aeHq9f4v5ZcLJ6zeSPOQwaoJba8uV6zFOxd/JpUWhn6CgGftKE+njr6CMW?=
 =?us-ascii?Q?QetxNXTJyNUbxxDpIxzFzKXTQZ0+PF8QSdJIaXfe0bJEjk+kZuXU1EEYXvgJ?=
 =?us-ascii?Q?1fr1bHfqRpt3wXYrnFs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a9c49f-4137-4db6-2405-08ddcd2988e4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2025 16:20:43.3110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLuWOX2Oa+ffSX3WqGp33uz8VpMgqubzRrMJQF4puqLpmYOWkd0L2Fjj6SOo/e1q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6739

On Sun, Jul 27, 2025 at 08:48:26PM +0800, Ethan Zhao wrote:

> At least, we can do some attempt in DPC and Hot-plug driver, and then
> push the hardware specification update to provide pre-reset notification for
> DPC & hotplug. does it make sense ?

I think DPC is a different case..

If we get a DPC we should also push the iommu into blocking, disable
ATS and abandon any outstanding ATC invalidations as part of
recovering from the DPC. Once everythings is cleaned up we can set the
iommu back up again and allow the driver to recover the device.

I think the current series is a good step along that path, but we'd
also need to improve the drivers to handle abandonding/aborting the
ATC invalidations.

IMHO DPC and SW initiated reset are separate projects.

Jason

