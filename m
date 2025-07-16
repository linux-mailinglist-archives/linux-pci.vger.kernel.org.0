Return-Path: <linux-pci+bounces-32299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA18B07B34
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 18:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79036189A191
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 16:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFBB1A5B9E;
	Wed, 16 Jul 2025 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b0QTRh2V"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD1C3BBC9
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752683502; cv=fail; b=EdftNnRLUUDbvoKoRGrLk7lsWsA0Q3kxol72wBTyOakxFKwTsCUnCKm99W5XJmUgDrTFjVnmG6ISAYWXOIl/I9wYW5rzTck6TLKk6rXkl4rek5/lvUVT9ONLmHBUS7xSOYBJNq+ZrfEO+Fv/lGVTj9ecgU1HcuaNSYx6mtIYyqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752683502; c=relaxed/simple;
	bh=yzUW9lymT8ZdozOfUpHpDhWvUJDmFq4f9pu6r6gGGM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=thuoKgWaIDLfz8MJZKVJ9VFFUvmvZChASv4kAVMuajCTEt4AqebTL70aD9qmTv3on2ObP7aI9ssTJlE2NqqSu7j9333BwSZyUwUDQINGPyesCGnfjG3WplbhFjNHkzGCwmpOvdacroIknZZbEYzDsAPpzJawCjxjBxDKmwbEuUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b0QTRh2V; arc=fail smtp.client-ip=40.107.96.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgOBIlNYCKHpgv+UUTIzrvUhYExpDqgkSwSA2ehZ+26UQjxmHjESdjJBYSeHLdhdJDpiQRXmc9iAHDWpDUkLy0rh9XNqeqDYMgCgylVy92ymURA19ftLJqkROCEDibLJflTX8LLIWInwD0byY8YuiQujCENEKletM6GvOHc5iwSd3RG7+Mm4gj2GeQxOfjv52hx+NMGALlkTzOWUKgOSp6RkkE9voID/GWQqMvwsaFGTZpL9ooGrqLeq9RF44xNjzxjvWqPuhhj9D+9JC9zVHng5Od65xGmv2MXwiY39JnJZoiQ+zXvmFbtnAOfUo8IgzCn51mXoYeF0ch+d/pwlkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DO97BsPbBO4EQM9OArzwQoBUM2TTSO7KsqeIT/zoPKs=;
 b=okmV/6xUbwtgkH4kQvv3jGIJ/H/5IHwEwNNCgs6famXy0+G9r0+wULdT46s3csGURQVWuKrrD4TFZFPxNhhkXusIty9v2pEYkh3jwfEfgcWvV2BMqqoC+Lor/U3pmkNU5mSz8Y60afGNlK4OOM01honZNUuDvjF80LEvvPVXcSKvHw61xhANHXqoEWSgmP/+PLFS5aVRRlaG19D9S/GnWlbmYSsmQg4Jq+k2tUGFYnaAIMpFT4a8n6oJqNRjL/B33BxTgbh3bNdjLynPBM+wRjpwrrpnXQN4BLmCC53kbQZBA9Hu5WBpPyxxJz5DvMgt6ssjyRoLj38fot8E7nCGbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DO97BsPbBO4EQM9OArzwQoBUM2TTSO7KsqeIT/zoPKs=;
 b=b0QTRh2VnGjK7e7J1JnjNRe35OqPno1eeJvH9w5ysc/h87IPYGD9Be/9z5CMvlgzSWsVywbCL8o5obW+yNIxImoij2kewxr9y4PRWJyujDtU7e+uihuCLY8UEDZOiyX9UHUE2lqEO9m+0jSylFQ5XhdxcWmBSf3uuoCyr5N90AS9PTai5PmHtZGcPKBJ8N3D4H/WGm/SMSSahiNYaYlQoQuJHEzIZ7t8ywwR53KJG10JHVAB4fhVnK58YRZ56iSb0cLP3cdDcfyjbMjPwakd0HWbbZNJ+GFoyicZlYURDrDpgYTugfzW04MGL5vhu2dW2RPUw5arr7XBqVQsYtKa9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.29; Wed, 16 Jul 2025 16:31:36 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Wed, 16 Jul 2025
 16:31:36 +0000
Date: Wed, 16 Jul 2025 13:31:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <20250716163134.GA2177622@nvidia.com>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aHYtj/jyfXD4XhZy@yilunxu-OptiPlex-7050>
 <20250715130949.GM2067380@nvidia.com>
 <aHfIGJzqv+4XiO7f@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHfIGJzqv+4XiO7f@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: BL1PR13CA0450.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c08550-47f6-4bb7-0076-08ddc4863b99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4qn0mINzSlrEFQdt1aetpVJ1Iu1BmVE7ccIZzpzhKo9u+Pl7pO6HgBmTybyW?=
 =?us-ascii?Q?qjPtq0a3eXE8la8MpXcvNBgVBzSbSjpB9C/17DLf4OAoCrH3d1N5g7CzPr6a?=
 =?us-ascii?Q?tSebxmpegUfAoj34Q3X+/7TGq2huizeYpGOmGBfSlECYlzClLN/O26JhFSb1?=
 =?us-ascii?Q?GxEZA+QrWH2urV1eXZnq7nvC2o1uA9XhYkQlANfiXkkD9ErFKSEIlCg51EC0?=
 =?us-ascii?Q?8cOYXt9ioMWguJ1XXbtDBx1TKB2Lx6NRGQIXKTyusZ9TPuwukfuhLGtdsB3Q?=
 =?us-ascii?Q?vr0ijeD1rTTzFKkGc0osD2wEKYs0za4FpkHr3Jsv24i+W4opDUPtQEW+Efn0?=
 =?us-ascii?Q?oXqzgDHu+vbfgikadrctpd55JysAYuKd71ovVRm4fwB4nqC1HT9kjl9ma4Zb?=
 =?us-ascii?Q?j43R0MlzO7mhwP8C4wf3YBcKblpLbPAzCHuGCOaB9JkcoQxDQ7xnoXcwK7uM?=
 =?us-ascii?Q?ryRX/EQJyPX8/OAUjpMWUmWZ7hl99GwgTTyJnNaMfRS/nSjoBzxzNJt1ma1w?=
 =?us-ascii?Q?++4ECkuzh4uxUshOER0/7/KJPgZ7rUPfbx7Q5THYZ/3Iq5wOxwH1D7jumfXN?=
 =?us-ascii?Q?CtQGWpS3nKE3++0Vi55SnBdDchavJ5Xj5o7Li5S7S4FmrQXQuWbyBwxwsaub?=
 =?us-ascii?Q?QpvF2ZXrDwpfqTN1ZI7ln7OymVWLm1tq1I2/xJBneajxMdEen/N8BZBAxsbY?=
 =?us-ascii?Q?2VAsQ452NAR0jJMLmFhgb57ke80AI3roFv7x5k+E7Ni9FBlmOxyR38KnvwMt?=
 =?us-ascii?Q?8qJ9KLhVDt3AGlO8hoNk8FaAIN3Goosvl+MF1Qnl8Kky3acUiSEdO/4WrFer?=
 =?us-ascii?Q?5kmQbThMwKSD7IGrA44OBKOyf5rTgFtenknfpzT2ULayS1Zp2ZOOOZkdMMf3?=
 =?us-ascii?Q?sTMB9NIoRFue59tZ4pNpsL05JEAs0izdm4kP1igNvHgIgONipbT4t7P5Boh6?=
 =?us-ascii?Q?togOU6tnC4uw9PgrAofCVINL0rx+Qtzp8q77dD8sAYSjKetXSRShy0/EY7C6?=
 =?us-ascii?Q?vr2rWIBLxAVGMLPKYCtk1ZO4u0YO0E8o7qV5iuwX8TPp95pfK+GhfA01loJw?=
 =?us-ascii?Q?goJMSi8IWllBUXgwC8lfsLM4HgKa1fkpxdl9gi1S0eAGXCvm+3sprz7NyhxC?=
 =?us-ascii?Q?2/2sNzuKUqyO9po4BCvh0jBMI6R+achHgKDQg0OZ6HToitQZUIjTHYD07gcr?=
 =?us-ascii?Q?5BcJMy3G+JKQSpm6oSZV30jDz53T/U/GZPGSJWt6WfuxaUDSQjwZ7YhZWY9Y?=
 =?us-ascii?Q?jQDiw2LDy/rv+wHoJ9zgRpe4EzwV3XVh/VuGT9fvGSaINesDUX+5cCx1Z2+u?=
 =?us-ascii?Q?I4ImwLo1Y2Yz0bFGMjIwIfLR7+yBMiUHmDxy/ycO/kN2t2iByRmuWRVrnNaO?=
 =?us-ascii?Q?CcpIC0IlUxBUCBDYYm2ykAEQLL8Kuj3/BHWDaRSFx1O1/otd4PWMR9YqiX88?=
 =?us-ascii?Q?uGGEyfpx5l4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v9Y/btgpt8mO1Otj+YY8Tj2K3Ih+vKCL6xdp0KFjZwPeCWO39UhzGAjvnB2P?=
 =?us-ascii?Q?/IpmKVq0PMdLZthKrcJ7AJ9M7vVWz+siyBurJ2RAx+WEVC56Gz+9cu2zMZkO?=
 =?us-ascii?Q?t52O9DxjB4ltYNnBaGu7RyrzLdnMEjz0kNk61n3kf+PVG+S7mgWY3dIXDbt/?=
 =?us-ascii?Q?ZOKvL60mN1jQOuX7ct2c9unDLl7AR+2MmMlfknNhvhAWwuFUczMIDg5c2Iyn?=
 =?us-ascii?Q?eN638Dlr82iDlpcULrFvSFDTB9zActg+ivWu09DcoyZeEvvzibzjN59zlL7F?=
 =?us-ascii?Q?jfepbNYVmWi08QR+Igh+jsTz5t2NY//N8cGNyuziw8VdBhsjXV/wmFs/aYYX?=
 =?us-ascii?Q?hg0QQQNK5DQBPH6PA7bBQ0v4oQjehOnXwNW8STFTEt1GivAiKqR6HJMtMpQp?=
 =?us-ascii?Q?kGFFRsaOqNvyZi279ca3A35x4wjQU2pbDfcEOP7LQ0X+FThqcvrtPBlIpP2t?=
 =?us-ascii?Q?fmLGaXnfUoemOXtW7jbPLExBpWWox3Om5RrFQnIOXdfyXg8Gw3KQseUnYGzo?=
 =?us-ascii?Q?9T1fw/SdiRIEUkkujV4pMLTPGkdDXG/1jjhMzeUAUvheGTvz18YjwPJmjP3l?=
 =?us-ascii?Q?DvQZG2qR/iz1r0jE94LFYweLQlBnHpOSdqyw2Ora2LuT5FEg1Dx5+rpTwikX?=
 =?us-ascii?Q?qHaWpkU0/IEydWHuPoLyyKd3tJKDceIagGjkSXqi7OE64Ak2S0RUr5ZrOqnO?=
 =?us-ascii?Q?erzHtUnrB8RrWb9FTlvCH0zPP92tEBfcyHbgDzGE1yeLg6NjRNBu9dm1SWu/?=
 =?us-ascii?Q?P/+QqrnPDenCD5cMGYGmvst/adIvXkeSt/WxT6P4oyMcmOZMsgKpfRsK69XL?=
 =?us-ascii?Q?qr5IJcG3qkFHAEAvnNdVBcc7oKz/xvdjxhWc00ehRxY+jVb9HDC4Uw4SChLU?=
 =?us-ascii?Q?X+jTyGdZJ8rz+I1sD9UbtQvkKBFkDvWDjtQrOKeLjSr7pgvMTrkNbJkXHoqE?=
 =?us-ascii?Q?eQy+LqpL+ZrJR6YSph5BPxi0pddnsjP9+XiAVwiK7Uk+tyN5P9TKFMizDxaX?=
 =?us-ascii?Q?nOi/Lk0q5gVIoEIzBU6hWWLj/yrHPHJ0mlA3tYx31Xa/SkZpgKIvMGX/ws3R?=
 =?us-ascii?Q?zHvraJapMFXwWbqVgGn+QbSnZR1w86dfMaFMHnLlsViX6tuUfJcW9YCum0HX?=
 =?us-ascii?Q?soFIzF9xrTUN5mpKS/6nEdR7LyXHA8hY6WbhJ27LFAHbghRPtEI4GuE/v90n?=
 =?us-ascii?Q?8blweXZRE4PtkPYY9EYSLShMGK84gc0FE+uBhfvU3hzyyNa8OqGSG7mHdZNk?=
 =?us-ascii?Q?7rA3dFvmxq64bgbf+xGVq2y1y+nrmj6fe2/xFeh9haY2BAIkS3kZfI5X8W9x?=
 =?us-ascii?Q?MpillUR1QCMIWfgbPRD3F23+/VwJwM3tnz/3gQ1NpisbXZRA7BSPQp04wyrd?=
 =?us-ascii?Q?533TV8Qog54sDEOaiWS8YPHC17tkjxit2xEzdwKj2WeSObVmcl5iTvAN+wi4?=
 =?us-ascii?Q?Ihp1KHMsyJ0NuTLINPLMeGx3xHrqXUTudmmVZ38exsylFh6Mpa5olIq0JU/r?=
 =?us-ascii?Q?kEQzO281n4mSJ9RLlAcoKMvjWP0w3N73ZTyhZtdDC7MG9iiknUZupfwPin9s?=
 =?us-ascii?Q?x3whhsX9oP+EfqUE7QfV0ouj0kPrmPDBih9mZlHa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c08550-47f6-4bb7-0076-08ddc4863b99
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 16:31:36.3000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJY/qk83isQa/MA8snZJ95VH3SU0DN7dGYNhS1RDP2EZC3u9bTEYBsIoHgLhqzMm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392

On Wed, Jul 16, 2025 at 11:41:12PM +0800, Xu Yilun wrote:
> > Except it doesn't work like that for MMIO. Shared/private is a TDI
> > operation only and effects the whole device. We shouldn't split it
> > into two actions.
> 
> OK. IIUC you want 1 uAPI, TSM Bind, to finish all secure configuration,
> including MMIO sharebility. I think it is possible, the MMIO shareability
> is fixed after TSM Bind. iommufd could fetch TDI report to get the
> private/shared MMIO ranges and callback to VFIO.

Am I wrong? Isn't this one action? Once you do bind you MUST have no
hypervisor mapping or x86 will explode. And once bind completes the
hypervisor mapping is unusable on all other arches.

That's one operation as far as I can tell??

> > I also don't think it needs to be strictly 'in-place' as we expect the
> 
> When I said "must be in-place", I mean the MMIO resource (hpa) for one gfn is
> fixed, can't have 2 copies of backend as the current private/shared
> memory does.

Ok, I would not call that in place..

> > VM to be idle on the MMIO during this change over. Faulting would be OK.
> 
> Sorry, I don't get your point about 'strictly in-place' here?

Here I mean the iommu page table would have to atomically change "in
place" from shared to private in a way that that is hitless to the
guest. We don't need this, IMHO.

> > Any case where we need to get back to vfio for something needs to be
> > managed with a callback of some kind. We need to get a list of what
> > those things are.
> > 
> > What do all the arches need here?
> >  - ARM I suspect has the TDI locking operation install the MMIO in the
> >    secure S2, not KVM?
> >  - AMD just leaves the MMIO mapped all the time?
> >  - x86 presumably needs to carefully map/unmap to KVM and iommu in the
> >    right sequence or you get a MCE?
> 
> Yeah, for Intel TDX, basically 2 things, zap the mapping on opposite side
> page table, mark the correct shareability for correct fault in.

I expect userspace to be doing this, which is why I asked about two DMABUFs..

> > So what is the plan? You want to wrap this in DMABUF, but will there
> > be two DMABUFS, one for secure and one for non-secure? Is userspace
> 
> No I don't expect 2 dmabufs. I image shareability could be an physical
> attribute of dmabuf and the callback to VFIO changes the shareability.
> And VFIO, the dmabuf exporter, could notify KVM/iommufd about the
> shareability change. Then KVM/iommufd unmaps their page tables.

How can this work exactly?

Does Intel put shared/private MMIO at the same guest address when it
changes around? I understand other arches do not do this.

Even if you do, the owning page table changes, right? In public mode
it has to be mapped into an ioas and in private mode there is no ioas
mapping?

Seems to me that two DMABUFs is easier than trying to teach DMABUf
about some new attribute..

Userpsace can unmap all the shared DMABUFs, do a TDI BIND, then map
private DMABUFs. DMABUFs do not change from private to shared on the
fly.

Invalidation is only an error case situation to revoke if userspace
didn't do the above sequence right.

Is that reasonable???

Jason

