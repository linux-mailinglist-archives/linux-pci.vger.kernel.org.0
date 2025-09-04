Return-Path: <linux-pci+bounces-35443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A52B438F5
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 12:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EFEF1899EDB
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 10:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B201D2F7455;
	Thu,  4 Sep 2025 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e5hi9Dxv"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29C52EE274
	for <linux-pci@vger.kernel.org>; Thu,  4 Sep 2025 10:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756982301; cv=fail; b=q599uegGHJlFP1GcYVXH8+lSI2LFWum5LReSZ3nmpr1gG+WjA2mX8UoKF+bfVsxi3u8uBAQW4682zwsM0D2wT+jR/8wGzar0DD0CQMFAJonpHFOXJjp3WUFd0uaarXycgaGUntH9tdE8V1+b9hnUQX8ThDR/fZ+YFPvtMIxkCsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756982301; c=relaxed/simple;
	bh=apUQExsEdT0EcgsHLtQ1qKIlP6vjK040HyqQNeOumdA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y28UxfV/wI6OaCjQNErY+9A2hVmnk4VbGpmZ8vDzlKXJNLxSMsT5oZSwj1O/KewrILwDqWDypjfRAe0v2IdCN048Pi3bRNorIugKWb9JcGQlpbrCxKQ7LBiY3kuCPipCm3y6mB4ozl5iIW7Agaymtk22NcCY30YHSk2vA3pPfg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e5hi9Dxv; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aEdAU1pxd5+gpfOyoYE1pSFhyzZTFGusnRsr6Gr4FfkHACCda8On+5Tjxc18RwbQelLRiSn5zlPoHKYT2g3wiJ11D93CFYkiOBi9wVJQciq0+we56EYDCDHd3y/5ARP9pMgrlCyPQdpUuT2IQpUODSTjJcyXk8NrCLTh4yaq29mP1KU3kk8UCEdIqXWZH2MwRY5nRKo6/9RtUvdk3CQa4E0IaSAeiXce2g8vmlXAmFNsr2LiUYL+NIYqQ2aj2lRF4r9LtLbm0r+DoukHKPaB+v9orzIcrXGVC+ky3xFknE909tdeKfNYTmMIhk9VWEisXr21+RyDjLYDNDfwkZJLhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufRIJz1SIbCB7p3DL8iv1fH+JGRJORbQEHNJ5jX1onw=;
 b=DqkoRl0y8r0zzkB4cOpDGTBzdQ5lRF1+/J3hzWbhm9z2QXraqfNOnw4BJB487zeFBYuCYnd88BsTaIHoCwjvz6wKi7KtLoSHMdBZXe06cHyKCVodEkzbQt/WyyINM8BTo6qsDenHe4Em/fcSL/kg/q5foqmPp35z4XGiBibyouOKXf7xJT7MOXJ+T9GWsv+RKz5y6NpabMsI+jIWFtKpWAb2YX+yok4q7TjuLJ+6TNUdzt3ybay5VPaYnCsxwD9z49MTUQh7nDENc8TXt9trEZnSryLuq6thVtFrS98V5cjlncmJQ36eK2+IXgy4VD5PO+Zgwoac+3dSm2VI+zz8RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufRIJz1SIbCB7p3DL8iv1fH+JGRJORbQEHNJ5jX1onw=;
 b=e5hi9Dxv9H4oTLXRgZLLcVVGeFnXnyJ7euJtbN8sbgcwQkpzItdhK+UP4LO1/3Tyn0UZrJDOeL4CpXglj1hIlEw9sKrQUO66YyYSrYhsu08BVXCHTMXPQyE0sgOKpaK9bj6ofSlBF5nnGaRpf2PWpb/lhRClqa7FVqMt8V16BtQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 10:38:17 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9094.015; Thu, 4 Sep 2025
 10:38:17 +0000
Message-ID: <9db48807-2a9a-4854-8735-90bfafbaeb6f@amd.com>
Date: Thu, 4 Sep 2025 20:38:12 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 1/7] PCI/TSM: Add pci_tsm_{bind,unbind}() methods for
 instantiating TDIs
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bhelgaas@google.com, yilun.xu@linux.intel.com
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-2-dan.j.williams@intel.com>
 <yq5ay0qv1s66.fsf@kernel.org>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <yq5ay0qv1s66.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0068.ausprd01.prod.outlook.com
 (2603:10c6:10:ea::19) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|MN2PR12MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: 40582a24-838f-46b6-3a54-08ddeb9f28a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUF6VThrVnVRRTNOc21hU2Q1UkZ6ODVwaUViVVlpWi9Da0ZIZ2dSd1I2bnVx?=
 =?utf-8?B?K3piSVY1aWxFZDl0a284ellkd0FtTWcvdlowSEE4ckl6UFhyQ0FNSys4NnVQ?=
 =?utf-8?B?K1Y4WlpyRzY1L0hlOG5PVEpreXJXMk5qa2FoNHg2aFVpamErYXZETnZaZEN0?=
 =?utf-8?B?NzN6ZmdOUDh1bWlMaFh2R2hPUE1UUTdxWE5MYlpNMG9ncHduUHByR3RhOE9O?=
 =?utf-8?B?QlRVSTBXTWxya0NmT0VONGd3Q0NLS1ZqdWhUTExTdUxqQWFyTVM4K05YKyt2?=
 =?utf-8?B?Z3ZOeDN1QXkraWxLYzYzZzBKZC9qZUorWW5CRlpjbG5nUjJUN0NxN3c0THJp?=
 =?utf-8?B?QzRDa3pXVGQveGh6MDIvSStQazM0ZlErcHlreUExQnhwOVVJU05QencrNkVq?=
 =?utf-8?B?VEs2TEFDMXY1Z3E1Z3BReEJuWlRsajhFRVc3aDZqSHNxYTM2QlVQQ1d4OUNL?=
 =?utf-8?B?UEwyNTNPYmpPeXUrLzQwQkR3dlNPTHQxWEltVUNyQ09CbzZzbmJENzBQSkNH?=
 =?utf-8?B?dys2YXZEdk5Bemh3dGpndTUwb2V2Z1MwaWxlVVVmZDc2RGRwMEx6NnRkb0Ri?=
 =?utf-8?B?QWlFeW5YRnZ3ZlFvUVNtV2grMElQLzRQeHZ1TGNxZHd2VHpvOEpNNndqdVFV?=
 =?utf-8?B?S0RPTmlWUExJK2tlVUxHRHZPVnlhcFE3Wm44ZVNXdmNwTW5ubzFlYTU2dTJl?=
 =?utf-8?B?Y0hLazNyODRJNm1COUpHV21mY1IzTzFuZG5MejlOVTZUaEVlUGtUUE90YU1o?=
 =?utf-8?B?S1lCS0hSTU0xWFRoZGZDRjhVYUN1Y0E1UDltRjlSbnk4Q01lc3RjTXhPLzNm?=
 =?utf-8?B?NWhWSjF6RkNpaXM3ZlpmZWVXK1crZWgwVUJyemY2TW9yM1YxZEcrSWhlOGx6?=
 =?utf-8?B?Zk1jTE9qc2V6OFpvWi9GTHFuYmZoVnJYRzY0Wnd0cFVqY1VOKzZEdTZQbEx1?=
 =?utf-8?B?Mm9QUjZkSlVJMDRzRFY1ayszUWpWZEtXSDFaaS9oc3FuODBFb0QyOUJTTVU1?=
 =?utf-8?B?ZWhsUmRlVTY5azFoM2piMDJrMEJuYlRZd05QeXllVVZQdTVpVXc0WWN0ZTk3?=
 =?utf-8?B?bjJvNUY1cHVObkNETnJwaHNKT1FtRXBiS00zNXdBMnpLV0wrRkJKRWtrNEUv?=
 =?utf-8?B?L0NXK3hsdTJuYlQ1Z01OQ0k4OVM1czU2ZXpUUCtYMGFJTXgxZklaMldHWWVk?=
 =?utf-8?B?SndsbUx6M01DNmlpWlNZZlRHdzFKbUhvb3VrVERiRnQzRXhzRzhCNHB5L205?=
 =?utf-8?B?aVRmMHBxWURJWTRkaXg5OGtTeVZyZkx0UTVZUkYrSFpsZWhJY3ZZUThOSkhU?=
 =?utf-8?B?Z1k1K3JNMExvcUkxbG9kZVFMNUJXSGtBeFp3aUNtalpXTEVlaFJtSnlYM2d1?=
 =?utf-8?B?MzR1djhvQjRFbk9aZk4wV1RPdmV0Z0JteldOUEsvdUhjUm44VUE4WnV3ZnZM?=
 =?utf-8?B?ZWFlS0Q1b3I3a2R2Y085cmMrblcweGdteXc3MUtVTW9ZOHdoQnFaWXUyNUdp?=
 =?utf-8?B?bWJSclJFMU0xSDRVem45cGROK0I4QlliNGRiUE5NZUZuZVNaeDZRTGYrSnVO?=
 =?utf-8?B?ZndjQVdkdDdnR0hUL3gxMnh4aVBEUFUrZzJyT3Bta0pJNTNoazkrK2RZVHRL?=
 =?utf-8?B?MUJOVFduTDBLdmkyQnNWWGlrYVpmRy9iQVZkQmdPS1FVZXZnQk9BMkluVnMx?=
 =?utf-8?B?ZHZsU21PRENONW1lbXdSWkttSFduTnNSenh0WVZTbzJVc25MMWpwOGlaYlMx?=
 =?utf-8?B?UDYvcDBqeVBIZ1NZL3ZZaG9RVXJ6akZVVjNROGdWbHlyRGVUY2haZDBEVHVS?=
 =?utf-8?B?VHFmZHllaWZIQWdOalBmc1YxMU9ycEZKUXZEMldOWEhUUUlKMk8xTEZsVTZZ?=
 =?utf-8?B?cFE5ZGVuUzI5cE82MmJYcGxJZi9Pajg1aXVCYTFVNnF5WWs1Z0FnUjAwVi95?=
 =?utf-8?Q?EApROMRNmNI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVMyQk5lTWY0U3YyUnB3eXNWUk40OVNmcWdxY3JQUWJ0YkNKZDJsTDVVYXhK?=
 =?utf-8?B?ODVKcUdnQXNVOGdBZzFWODN0cXhqSHlORUpvd2V1dVV2N05yUndjWDVYTTB4?=
 =?utf-8?B?MGYrT0hPOXh6VHRwZklYVVJrZXBSaWc5d3FmSTNzUExVZEhaSm01ZzRGdDc1?=
 =?utf-8?B?SUI2a0cvdFVjYWxTU1UwVHNQOW9QbG1YeElJanVacE1oT2hUc0ZXQjlnczlK?=
 =?utf-8?B?TmRZZ3d2TmRaNE1ydEdEZVJWTCt1dXBkNERVRkJNQXc3aHlGU3d6SmtqdXNq?=
 =?utf-8?B?MXpBandQLzN5TUVmUWdUQTFRTy9QTkZWMXhGdzFUM1JMYVo2bGNPckc5M1A5?=
 =?utf-8?B?T3Z0NEZkVlkwY2UyNkVrN2F6RzlMM3IyenJuSDE3aWdaNkR1NzhRek84eVR5?=
 =?utf-8?B?dHlmeFpMSWtrY1h2anB0RGNJQyt0ZXNyMHhGS3E5SWw1Q3EzY0lZV0ZCRVBp?=
 =?utf-8?B?QWwyMkU5enpxZDdWYVVtSzV1cVpEWlBoRndUTHVEK2tzMWNxaWdjYlZacnp5?=
 =?utf-8?B?QnFvdEJoMlI4Zi8xbHNkRnlSampnN0FjUU8wZ3FaZjVDRnhyTXk4cllsNUtm?=
 =?utf-8?B?Qi9qeTc3aUlTaTc5cVFaZ25SNDl2M3ZkakZJeFBybHRDS1lVS09IMWxucnN6?=
 =?utf-8?B?RFR5cVVYdEFTdGNLdGVSTUM2dXU4UUxBaUsrUktwVXNMZlJ5dWx1aTlad2lY?=
 =?utf-8?B?ZmZpMlUvQnhsRnRLcVFieVNuejZyUUgwZjJ5NU84MGd1bXlJT2Uyb09GVU80?=
 =?utf-8?B?V2VITGhLNk9ONUZuU0VVemlSbW1GT0JYbEFSdzhCWFg3QUpHR0d5NWFORTNs?=
 =?utf-8?B?ODgyYW9zbFpkOHhEWXhnN3hnWTNsSkpQNVdwaWhSNTRhZXd2bFdBVTEzK3VR?=
 =?utf-8?B?L2FGYUVXUmNzc0NLaTAxVDlIQndNUUljRlpndXdYYitTTHJRamdubVROSllk?=
 =?utf-8?B?UUVlNnN0TGZXejdyUHV1WGpNWWRobkdhRHZlMEJia1FxcS9LcGE3ZTZsTkZU?=
 =?utf-8?B?WENESWlsaDdROFdwVHdpTWlUNERWdHNRdytHcVpVSG5DT3JjQ0drNk5xSGhv?=
 =?utf-8?B?NDN6Q1B4NHlxZm1veWhjek5EVmV6WiszR25BbUYyenlVazBOS0YrNHV1U1J6?=
 =?utf-8?B?djAyYTNBNlpycTRPZEJ2OHdUV0xSeWNONzdmWDdmQ3ZFTTFJa003bzhDMG45?=
 =?utf-8?B?dDdzRFZxRWFFVGU1SVFVUGdra2IxVW9oQjJCS3c5b0I1S1BvTE42d3g2Zkk3?=
 =?utf-8?B?WEc5WnJ4SnJvYmxoUGpTZ1FqbCtWcUh1MUpXMnRvZlorQ05OdjdxOENRdnk2?=
 =?utf-8?B?NFpnTjlPVUpUeVV1TUR6djRhSlNOSHk0cmZNWTRBb3ppZDNRT1pVQXdabTJj?=
 =?utf-8?B?RmFtbEtlcjlac0dvSWVRTVhMZlNWeXRQRGwwb1FzYmVFUzU4V2VoMU9Na2Ex?=
 =?utf-8?B?ai9YS2J0cGtPVUp5WS9MNFN0K2dXcms1TTdwejBBdUdQNzhnNEpZS0FES1VU?=
 =?utf-8?B?Z0o5dmI5aWlLZ1AzQ0hTbVBmRVBicFJSOUltblNxeDF4TTdUUkR0M3VNMEI5?=
 =?utf-8?B?aTQxYjlPM2RPSi9rSlptbVdVbUxNbzRNMTlBVC9LMXJWSHlqNHRRUkVYVUVY?=
 =?utf-8?B?MnRuVHFHNTFLWDlEaWVhNTVteGM3c1dnUTh2ZlcrWStWRWRQRlVkMDBQZjl3?=
 =?utf-8?B?aWVKZUFzdlNvQUxZU0wzNm5jQjRISVZUTllMbUtqb3FjNlRqYU03b3JldUli?=
 =?utf-8?B?dkEvd0RGSEE0a0E1djV3S1RhMXRjRXdnS2ZiM21wakcxMzRjVE5LVzFlS1Y1?=
 =?utf-8?B?elE1ajAwZUY0VUJoQkRzWHhoQ0lFalhxMXZjYVZqVVNac0ZGYUxjNUpSUnkx?=
 =?utf-8?B?UHZHajlNbUdJM0JqMGN5Y3A3OEJmbERsNWc4WENWWkdzSWxqc2ZJdktnRFhO?=
 =?utf-8?B?dkxlM2NsUVV6OWZZOUsvblZ1cjVjbVhvUUFhWUxjQjVqMHpDUG5SazBTZVRy?=
 =?utf-8?B?UVAzUUtHeWdWd0RuRWNTTE1nbXlCZlV5L1ptekQrbFBFMm9Gb3dqNTF3eWRQ?=
 =?utf-8?B?MlJrdTd0OXNUcG1pNmxEQUR1c3BPd2NUQ213VG5zekZpNDBQMzNJeXYrZkpl?=
 =?utf-8?Q?WlaKxSka8QLuy1zhViABd7whA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40582a24-838f-46b6-3a54-08ddeb9f28a1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 10:38:17.5407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJ0eYBuDTTHesAZ0xtvRvTTqf6ebetUsu2V808GhFJt58Mzk6AWT2vy63kKvjUiBWCnDvniPEtWPt3n6J3NicA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063



On 4/9/25 01:17, Aneesh Kumar K.V wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> ...
> 
>> +/**
>> + * pci_tsm_bind() - Bind @pdev as a TDI for @kvm
>> + * @pdev: PCI device function to bind
>> + * @kvm: Private memory attach context
>> + * @tdi_id: Identifier (virtual BDF) for the TDI as referenced by the TSM and DSM
>> + *
>> + * Returns 0 on success, or a negative error code on failure.
>> + *
>> + * Context: Caller is responsible for constraining the bind lifetime to the
>> + * registered state of the device. For example, pci_tsm_bind() /
>> + * pci_tsm_unbind() limited to the VFIO driver bound state of the device.
>> + */
>> +int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id)
>> +{
>> +	const struct pci_tsm_ops *ops;
>> +	struct pci_tsm_pf0 *tsm_pf0;
>> +	struct pci_tdi *tdi;
>> +
>> +	if (!kvm)
>> +		return -EINVAL;
>> +
>> +	guard(rwsem_read)(&pci_tsm_rwsem);
>> +
>> +	if (!pdev->tsm)
>> +		return -EINVAL;
>> +
>> +	ops = pdev->tsm->ops;
>> +
>> +	if (!is_link_tsm(ops->owner))
>> +		return -ENXIO;
>> +
>> +	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
>> +	guard(mutex)(&tsm_pf0->lock);
>> +
>> +	/* Resolve races to bind a TDI */
>> +	if (pdev->tsm->tdi) {
>> +		if (pdev->tsm->tdi->kvm == kvm)
>> +			return 0;
>> +		else
>> +			return -EBUSY;
>> +	}
>> +
>> +	tdi = ops->bind(pdev, kvm, tdi_id);
>> +	if (IS_ERR(tdi))
>> +		return PTR_ERR(tdi);
>> +
>> +	pdev->tsm->tdi = tdi;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_tsm_bind);
>> +
> 
> Are we missing assigning pdev and kvm in the above function?
> 
> modified   drivers/pci/tsm.c
> @@ -356,6 +356,8 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id)
>   	if (IS_ERR(tdi))
>   		return PTR_ERR(tdi);
>   
> +	tdi->pdev = pdev;

This signals that this pdev backref is not exactly needed :)

> +	tdi->kvm = kvm;


iommufd_vdevice holds the reference and AMD TSM only needs kvm* during bind() so it can go unnoticed but it is needed, yeah. Thanks,


>   	pdev->tsm->tdi = tdi;
>   
>   	return 0;
> 
> -aneesh

-- 
Alexey


