Return-Path: <linux-pci+bounces-8668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF3B905242
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 14:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F4FEB21070
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 12:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EF416F0EE;
	Wed, 12 Jun 2024 12:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bN0VbqlD"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA25374D3;
	Wed, 12 Jun 2024 12:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718194788; cv=fail; b=MSZgkvAnYHzisWnkT3uCMXb9zdNS3dJ9P4QpT13XQ4fHL3vkcWyyP5TOM14IECKrWHi30vLWEEQnkfFPJJshI/3RK1+dbUs8EuAJz5kAyZHNLiRgKDMSy6sy4FRqK0Ecb/hCvhc3jBIynKROh8Qr+Dssc9VBnpw4JnHzeqDj0eI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718194788; c=relaxed/simple;
	bh=ubcXW3ku14wxzCo32/ZUqw75jgiqu/dHiCz0U5NvfVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iYneyi6bs22LeUjGsCL+fMI/r/v1AuAW5DjwHNm5YSanwPV4SlPtksfAMN1PKOT/KXShgWtfvb0awwyu+t5yOK8q8VzRT7wi9QMs4SKJnHRge260qK2WhCuaSP9Cs09HB8HNmTeqv8gKity6gpOoe0luYvWAM4CrEGKLEzj1TdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bN0VbqlD; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAktogYU6uHw1FCw9Tbua8UBTgWOjNvOC8CcwyAa38WlDaq4a/qDNCLedrrqEKClNLKbuAnoCy49cuWL04C73/oyU1q+jLyl6hsLASr4QTmUBPJ2j2sSCY8X9ANiMiuOBR3Zuz3ahttT+FtIeS8cJxoRSCEQb1H3zLoj8IsUEhd3cUPF+NagZqj2Cx+tNICaJnNGf1u0bTR1y464wY5hbVLGVuVpUf1B6LXSSsiVKBq48oEg+Zrzxzb12lFI6g4kjcc/obmkOjEvFfDlq1WfxBdbnMqad+T0wA8L2mmsEBKDkmf4agR+6ExxCgnRvCqOCmiCzKIWD6Gfw5/EF4/Tvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MS716LbYE4+elIrEEKAzpBD0uboibCmHZMXPvrqfmc=;
 b=FOpOtizzNZA8FzJfxccKEb0MRPGuJoN/MkOhTTsIF6CtPhf6msh3+nEnprHP6AGCiRpUn8yatKzPx+Nlh052L0icCpMvTUB0jGoRsW5UNw5Av6VC+r3vRxOB33h5q1nOXehLvUemnRlNnaab0z3PDtZ0pFiLCKDnhffM+TswFHvQjEDaUd0cNlZwMpBN8YV9xn4/JTPC4w4ef1gLL0zQCyNTTYahF1XoUjLFXF9hlEPKZ6gJz+9Vv2MZHejihwI5/xt39QHUj1jUvoDWNFF8Ofo40JuezPzX/YZfawt1MeyA0u2Swzw0Z48hHk+QuFndzFJo/30cVRqEB3mVKkHOng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MS716LbYE4+elIrEEKAzpBD0uboibCmHZMXPvrqfmc=;
 b=bN0VbqlDCD4WRsWxo8MqZZcxINMwgW4CLieWOUhfCdMiWaQsBkGFR9RarF77w+/TbwWjYhuy/wlyCFpBl3Uimevqd8JK94HUyY4FDqdhqO6xIK+zEnwg4HOFPieo9TDVkyBn3EDrj8I6xSGd6c1H/kQd+WrEDxLE6Q0HNaRhXHyJep4bmYPBgNdys5+0Ww/myNbquw+M4c8obALeBaYs+I9ShB45R/s/mgrjraikTMto2kLabBbQOiDyAdxEaMsObl8FeWUVzMoLAFcoTYH5C6MFEfvfP5WIwUmcWfX6/B7qP8xuETgiVkH5aHUe+mOEFN3pvt10ND9Uh1aK/G2A3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 12:19:43 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 12:19:43 +0000
Date: Wed, 12 Jun 2024 09:19:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: corbet@lwn.net, bhelgaas@google.com, galshalom@nvidia.com,
	leonro@nvidia.com, treding@nvidia.com, jonathanh@nvidia.com,
	mmoshrefjava@nvidia.com, shahafs@nvidia.com, vsethi@nvidia.com,
	sdonthineni@nvidia.com, jan@nvidia.com, tdave@nvidia.com,
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kthota@nvidia.com,
	mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3] PCI: Extend ACS configurability
Message-ID: <20240612121941.GZ19897@nvidia.com>
References: <20240521110925.3876786-1-vidyas@nvidia.com>
 <20240523063528.199908-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240523063528.199908-1-vidyas@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0400.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::15) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM6PR12MB4340:EE_
X-MS-Office365-Filtering-Correlation-Id: 349d2c7a-8b01-4bd6-8b82-08dc8ad9f0cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0tVa2haV01nRWZGbndEemJ1cnVjZzV4azAyUTFXQlVBanlJV2dibzFFb0lS?=
 =?utf-8?B?WUpoQVY3cHdtSDRSN2RtYXNwbVg1RkNsU21SbnhvNW9uWkdWVlRkek9YVklK?=
 =?utf-8?B?MjBMeTlXaVdTRmlja25RMGZsTVBWZmVNREN5WFpXRlJETzQwdGE2a1o4TDZ0?=
 =?utf-8?B?NDJPZndFSnJLd0dtaks2V2dIRk5qSWozL2hQM3NMZzFPK0hpQnRzYVg2MTdH?=
 =?utf-8?B?RGFRdURhMXlSNC9lMXJFMXMwREhuR3E3U1d0Q3VIWC9RRDM1TzBlbUNFNE80?=
 =?utf-8?B?azR6eVVGOEFpcTdMUUcyeHBPL2k2eFhxVXRpVkVQcHRJL2ltTUx4TXB4NDYv?=
 =?utf-8?B?YW5Qa1VLR0hhU3NYOFdDaGdVN1hxTDV1dDB1WDVsL1A3ZGhCRW5Vc0xpVE9L?=
 =?utf-8?B?ZG1Ray9qd3ZNb2FhdW5vdHp6MTFsazZqUHExSUF0ejNVMjA3YzNIWHVSeEdY?=
 =?utf-8?B?UnQ5VUo5R0NCM1RNNnZQcDEySnZPa3ErTWpSVFRQeFJTcnBITlIvWGlRS0NX?=
 =?utf-8?B?OFI3VkJHa3JXSlFBb3MrK1U2dE83SjdJQUtBdVV3bGtiTlFHZ0xDSjYvK0Nw?=
 =?utf-8?B?R2RjdWV1bE1XVjdNbjBjMFVSa0lIbXFOZEczN1MrRE9sSWYrWFd0NU0vVHBN?=
 =?utf-8?B?bWJ1TVhiSzJoYkxSZDhTUFNkRWpGR3JseWY0M2J5VmdtS25ZY1pSVGxWbjVn?=
 =?utf-8?B?OEhyVVBVeXluRU5HdEFSbE1WdmtucjI4ZkpTN29TTzl3ZW1SUW40YXJQMnpv?=
 =?utf-8?B?aE5uMk4xSTZmaGh3VWVsazdmWlZOYkFIRFN2NkloT3c5bDhaUXNIOEwvQkZX?=
 =?utf-8?B?R2ZpUkd3QmtjdEs1MGlvZzNsYTNZTXdxOHFLTEUzQmRneUREa2s5M05WZ0pS?=
 =?utf-8?B?b2VVRTN5YWFkNEhSK0xjaGR4ZWhUcjdWU0dUR1E2VXIzWjlRYnQzc0pzc3Fk?=
 =?utf-8?B?OUhHNG9sbUxnYmFLRDU3NVVPa0x4N1NKUUh3b2F1ODgvdk1DMmtQYmp0ZjR5?=
 =?utf-8?B?QVRBYVJBajl1Zytid2JDYkFsSlI5TzNkY1dPekp1Skxaa0ZjUUs2UkV4NVFj?=
 =?utf-8?B?ZFg3bUhndUY4Nk9lVGp3NjByV0NqbWJIU1JKczIyNTdXQnBHVTNlRDg0alZE?=
 =?utf-8?B?MnR2VFhLUXA5ZEVFcVpFR1UrTk5vQThRWGVVaXIwQUhNVnZvRWFKaEVoQWwz?=
 =?utf-8?B?Zk8wK0JFckpsSE55OXV3RC9lNDZ5ckVoYlUvNUZlMmsxK3BVcjNvZ1VwVTVK?=
 =?utf-8?B?aTNnNms2em53aFczMFRuYm83LzBhMlEzVW5DeEw1MnBROFl5eitsd0EzeklB?=
 =?utf-8?B?T0lWQjl4ZkNrcVMrRklOYitZUjV1YUpHQkpVWDZQQlllYjJTcXJSZDJZcUt5?=
 =?utf-8?B?eDFvWFkrM1c4VTlpQkNYRkJ6UVRZRkN3Z0RodjN6UG1sajlqWHVLQjdhVUYz?=
 =?utf-8?B?VThFd3FhM21rK3RvL3V2dmRsNWFyTjUyVzQzb1pVT3pFNkZHWTFTOXIweWZM?=
 =?utf-8?B?NlkzRDJ4TDloNkRaMlJGb1hLZXF6NHpabU56MVROSUJzakhTNnBSQUNOTXRR?=
 =?utf-8?B?K2NIV2hDT1FLYmdRNTZKZk41R0xtRVhGcWpMbGpuUkhNT2NkKzA2NFNnM2dn?=
 =?utf-8?B?WE5DOGNCcnViNDNtSThkcDNHby8yRXZudGJ6bHdNNFh0OXJ3YUxRLzU2WnQy?=
 =?utf-8?B?R0xWVWYzM01WWFpXd1hJYWJhZG52NXJLS29pTkkrcm04MlRWZEVqQ2ZMNVBm?=
 =?utf-8?Q?dLU01sLjjcNRmuFNZWc55JsW5xyLSwc9ejYqEuU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkpjZjU2TFZiVkJsNTlYNlc4M0ZJeVg3WUh5b0UrVms0TWN3djRydWN0dEhT?=
 =?utf-8?B?OHAxeEhuK0FOQzJFQkhLWWlacDlLNFdvRStjK25GYklGZ3kyU2t0NUdaRXVl?=
 =?utf-8?B?TXFLR29OcUNwTWVHRmZxOFlXUldjbWlHSExCVHpVQ3QwZExuNVpYSWcrdzNB?=
 =?utf-8?B?NjVubCtmR0hvTlYxSXZMcFZEd3N1ckVnWWJvMk96VjJTbTR4U25zWU4vZFFY?=
 =?utf-8?B?a3BNRU12cUdqQ2xUODBmU0ZMSURLRUR0aFh3clNZU2xrRnBFWms3TFhSU1Mx?=
 =?utf-8?B?VTBDWEE3OFlYQjE1cUlOcEZzK0F5Nld1OVFlbWdjaXp2ODZ5aHprVEx3a29X?=
 =?utf-8?B?YmtHUlIvQmIreWxlY3ZOY2s5WWRmRlh0enV1WjJpU3c4TnUyeml6cEplVlNo?=
 =?utf-8?B?ZzdrbzE0SEs5U3VqUVB5dVd0UlhTSlFsdHd1aXdVU1M0V3ZDMzhndjVoYVZP?=
 =?utf-8?B?aDVQNk44cklHUjdKcWMybnFjUFNEMktrZ2k3TEJFYVNGMnBlRnVEZ2RKT055?=
 =?utf-8?B?ZTVCVEFlMENtaEx6MzAvKyt2ZzJSTXY2cnBFdjNoaGdpNmxmTEtCbXdrMHN0?=
 =?utf-8?B?TGo5MyswVG5GdDdrT1ZnS0N4MTE4NklJclJ0cEh3aVlaOXZqUDhCOVZzZXMw?=
 =?utf-8?B?WWpNOFpSOEVraGl3TitiZGxwRWxHVmltaVAxRm1KKzJNR0EwaTc4MXFwR1lP?=
 =?utf-8?B?TDJuVS9pdi9CY0p5RFplZ0xyQ0dFWmN2ai8vdEpkSlQwKzllOXZkRlF1M3pH?=
 =?utf-8?B?N2ZySnNtVk55S2dwNEpoUFBhMlpFMC81aWRJK1pYYlN1VzJrc29PeElvN1Fq?=
 =?utf-8?B?N0wvd0ZjbEt4QzR3cDlMbms3OTdxUW9oaWtVdGdKSmhZdHE2Zm5wdWk5dVlj?=
 =?utf-8?B?VUlMTkpQYjFGRWs4Q3BoSXNOL0RFZ2FndHkyRWZMN3lLNCtHeVcyZXNwL2JO?=
 =?utf-8?B?NGV2UThDSUU0UXhjaVVqWVBtQnJ2K2djd2FZR0VNSHZCd2xueC94S0RKaElB?=
 =?utf-8?B?RlZVT1pGN1JIajhralJEQUVTT3dTWWY2bVlENmhsZy9NSEJPOEg1emo5Sjhq?=
 =?utf-8?B?cE9TTmlQaUx3ellxS09wSGszTTR1ODF2bnBLd29USDIxN1VsSit2ekdDSzFM?=
 =?utf-8?B?M09BT1VIV2hyZXY0QW4va3lFZ1Y5WDN6NjluTm5SY1lJcGRHRDNjQWRGdzlZ?=
 =?utf-8?B?SnBGcHkwV240WHN2ZnUyckZPVUhjcFUyTTBaOVhzSjZkT2xtQVJ3d01UTnlu?=
 =?utf-8?B?OVJDQ2ZpUjlwSURNV2oxb25qcXdBV053Q2R2LzBZK3Bld1NWZHFocGY2dEds?=
 =?utf-8?B?WmhyUU1saENCTFNoMmxKRUk2cXpzSC9WTGVoMXFGVlBzcmJnZmZVVzM5TXFN?=
 =?utf-8?B?Z2pDVXZkcHp5SS9Hd3FzakdyZmcxQVhISVNJUWttRU1xSlZwSk0xV1M1aXlZ?=
 =?utf-8?B?clNSNm1YcXQ3b1BraGtrdERQQjJIMHZ5Tk9mTDUvNUJ0M3YveXQ4M3hHMTdI?=
 =?utf-8?B?MEdlL3dFc1VveG0yWVZlckRiY0Jpcms3ZUxBckVZL0tXSjhjUHhOUW1TNFF6?=
 =?utf-8?B?TTBEV2Z4N0pJdWdBVW50azZDUTUycHhwbVY3cnl3TjZTOEVsaHo3NmJaSzdo?=
 =?utf-8?B?Z0wwN2pESndIaENnK2xFV1AwMlp1S0gxeFdYM3czZWREbkR4c0E4R01wY3lU?=
 =?utf-8?B?MW4rODVza1A3Vk9sNldRcjFxb1NidTkzbk1UUEtyN3VNeGJJTlNsRjFxdnU5?=
 =?utf-8?B?VmlyRHlpVTB2djJsaStyME1oMWVIUEVuZkV5TWF1OGVZeUkvc2RIYXpmcEov?=
 =?utf-8?B?MkVndGFDMkIyN0NmVTAza2pCOCtLUFg4Tnl4L2EwNDMyNEk3VGRzSy92cmZT?=
 =?utf-8?B?L0hKR2lqK3cwUlFubCtTdGRCZGp4NDhhYnluNjI3TFNRK2FZaGlERmc4a1pE?=
 =?utf-8?B?aWhzZTJjSnNUQllJTkxLYThZeVZnMU5nSy8vdTROZ3drYzN4M2k4REZHWGxz?=
 =?utf-8?B?ellRY2M0dk5SMlV3VjhxTWNOajVicGw4R1pIWThiR1ArcU1MczlHVnRMU0pT?=
 =?utf-8?B?SE1GdnBUeTVmNHk0WEtLQ0RTekZVTWxyT1NLZU83RUFPM1ZJdXZmYm1NeER3?=
 =?utf-8?Q?CdfY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 349d2c7a-8b01-4bd6-8b82-08dc8ad9f0cd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 12:19:43.3731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QctoMZ809v+as5p1I1mvCtKcNC+108MBUKP6EdYMJQz+UvmCGbd52dbplEtL7Htx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340

On Thu, May 23, 2024 at 12:05:28PM +0530, Vidya Sagar wrote:
> For iommu_groups to form correctly, the ACS settings in the PCIe fabric
> need to be setup early in the boot process, either via the BIOS or via
> the kernel disable_acs_redir parameter.
> 
> disable_acs_redir allows clearing the RR|CR|EC ACS flags, but the PCIe
> spec Rev3.0 already defines 7 different ACS related flags with many more
> useful combinations depending on the fabric design.
> 
> For backward compatibility, leave the 'disable_acs_redir' as is and add
> a new parameter 'config_acs'so that the user can directly specify the ACS
> flags to set on a per-device basis. Use a similar syntax to the existing
> 'resource_alignment'  parameter by using the @ character and have the user
> specify the ACS flags using a bit encoding. If both 'disable_acs_redir' and
> 'config_acs' are specified for a particular device, configuration specified
> through 'config_acs' takes precedence over the other.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> v3:
> * Fixed a documentation issue reported by kernel test bot
> 
> v2:
> * Refactored the code as per Jason's suggestion

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

