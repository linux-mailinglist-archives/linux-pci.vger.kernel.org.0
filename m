Return-Path: <linux-pci+bounces-22396-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4B9A45273
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 02:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB113A49C6
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 01:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8209015575C;
	Wed, 26 Feb 2025 01:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1kinSTs9"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD669383A5
	for <linux-pci@vger.kernel.org>; Wed, 26 Feb 2025 01:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740534863; cv=fail; b=eJ62UpGive8OtdWIxZkmNUY+4H63KIdGj0hqykP7kZ/j4lHDHZO7JyWOOqOLPLE9W1PiESAVZjgbQWoVA6XU9kJvHvyi7+K1SWCU402B8ag+7nRSje7NnkEKyXQ88sqdqG4LJUZigOOrGG5HTWsNqYfvkWPSEORF6iaXqf9vfpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740534863; c=relaxed/simple;
	bh=LFuP9fEyCjLHTgzYB+eUbtOZUeTc46Co4jt6q9dIzZU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oAVi23UJDVVRNZlcT+V8B9RarsBHFjFMNg/1S/LOiFL4RCeeSUVYrOKY8kBM7tihBb+TiFf3VDSdud5Wvp6Ycp9cTifKci4kCf9U3xoCEsCxQ6i9CutEGFQET8gcGMOcbeYRwBIIIJeSMJxI6ixcmEe3E4FJDqqsVLhjPFK5KC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1kinSTs9; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4iVsI8urrxHjVGAvhEw5+oQayYpKDmqZ14g5sninwMo9wmhGwSefBY81DF6BdDol+FQ/+iNHgL/Gxkyj5fZRCpYXFmYKr4TFlyqCqh0B87eSTFOM4C6KpDTsgzj2TJw8otAIkc0H3Gl5IQy2/4PTdPKUM3QCOKuYmVJe9AGt8tzqE9mPJ75rVpPv0tkuCchpvVTRm7hTEGY3y6vxHpBwdVhLGE4iGs07v0TMXI0kHxkauK+l6u6deQVGPjKSoGfCFlRuFSS6aAjF1p9HUVKsVOZZ0RfGT/oO+MNTxvvpMkDjGXOkQRNkFit0g1+2RSt0gthAgSH96u12rkwQM6QsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1E4EIsmIVlYLBJBu3zOg/H4mdan688wOtqnouTf66Y=;
 b=zFTVxZR5xl7W9pu4BltXgv4d70btqUYZjQCtDpmp3MoCSzk80LMOMPOrtrM9Fcmg2re8oz+o+VcM3DnRKip85HPPo0Z4a1YsdD/FlVjDPgzJ6X2jYy4vqJEHSkhREqeGF+X9CQvL6G1YX4wdoux7wecQPuVbycO+Ip13YTUzKvplMFaLba44MdzENpmAgq3ohPijm20lSb3nR63UHX2ISz6I3ryEbXNzn9DxWwvRJ3qWqmRAtFGv911l4i60D8g+1STTDLzoAiUkp1d3ExXiQhJ2VexxB7dG2uyKy2aFoXJvN5l1a9DeXu7IjaJK8f0HhUXkd73HBd2Ymyc5TaIfsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1E4EIsmIVlYLBJBu3zOg/H4mdan688wOtqnouTf66Y=;
 b=1kinSTs99tfmFAjSHPseYLfcMeNpVmIeCNrQWTG9ZMspRMpmu+XbD8o5A1JhanXUhRa2q2LPW2gWnKR5LaEciCz9W80eyZC6EZshCxMbDM5V48u/n4n18HLChYatWJX2iUD1Ge4niJMN1iP74FOLr+eWLKokcV/WpNcJtckhybo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by BY5PR12MB4227.namprd12.prod.outlook.com (2603:10b6:a03:206::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 01:54:19 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 01:54:19 +0000
Message-ID: <d6c400ab-7062-4e66-b4ee-20e882df605b@amd.com>
Date: Wed, 26 Feb 2025 12:54:11 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
 <9f151a74-cc5c-4a7c-8304-1714159e4b2c@amd.com>
 <6d50f215-93c4-49a5-9ee2-f9775b740f92@amd.com>
 <67bcd68bae71f_1c530f294f2@dwillia2-xfh.jf.intel.com.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <67bcd68bae71f_1c530f294f2@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MEAPR01CA0027.ausprd01.prod.outlook.com (2603:10c6:201::15)
 To CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|BY5PR12MB4227:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca59cae-4d59-48d0-22d0-08dd56087ba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejdaQkJUdGdNQ1ArcjRSRU03TlhwVlk5d0RuN2IwME5hODdpeHEzWVh5RDV3?=
 =?utf-8?B?aTNodzYwRGNSd1FsSXdPa0x6c1owZ0ZjV1hicDVXbFBFdktraTk0YUJqanVR?=
 =?utf-8?B?a1RoVUx6WjZlT1lxbDk5MGdoN1dBVTZpTU5RR1VZaGRtb0VNeXFIOVVtdFo3?=
 =?utf-8?B?TXpZZnpZbVc5Q0pJNEUyd29waTBXR1JQSjBVUStxdUxrR2RiRUdVNG82ZVIy?=
 =?utf-8?B?UXBxTmhSOE16cm9XUTFyVXNjRkVpTlc3cmo0K1N1YjdnNmhDNVJLa1psSzlo?=
 =?utf-8?B?T2ttM1hIZXFDVFhGNTBXVnZlSXc4OUtzaUp2UGJiYy9lTWhYL3hWYVdFbFp3?=
 =?utf-8?B?R0xuRlRReUw3MEFwOEpMeG1rYURmVVI4STQwMXhqSDFNYXREcThOK016emc3?=
 =?utf-8?B?MUVPTDZGcVdpU1htcEVSNjVDaDEzV2lHQ3JGaDVZSVNxMjIvSlBXOWhCS2Vt?=
 =?utf-8?B?RHFZakw3eGdiVHlLYlhQemtxbDdjd25UZ0FuKzRWam1rM3BHR3dGeWhPenRn?=
 =?utf-8?B?a1dqdVk4S0hZUFJpZWhXa2ZYWmNJSTlOZE43Y2lhREhsNDk3NEkzTEplbEpl?=
 =?utf-8?B?MGVZdHBiK1dQK2Q3TUs1UVBwMzljVU4rcDZQcUFpcjk2K0U2cStUU3BHOXBQ?=
 =?utf-8?B?MllOcGVrTGFybXhmTmd6UWhvWThwTFEyYmxJL1Jwb1pwa3UvZXErdFVDNDBh?=
 =?utf-8?B?QjVydkNvV1d1c00vdkkvZHU2MTI5MkcvWVhjWFZuZklyWkFFOUZMei9MVUlM?=
 =?utf-8?B?U2hwU2NTMUJOOUIweHZ4NXkwQ0ZCWGpoM2oxNGV2eFd0eERsUVlURlRQV0hn?=
 =?utf-8?B?aVBQeFpRcjY0WWVNM3JNRjAwR2VqVjVueGw1UEt3MXA3eG1kRmNQaUVRRGRT?=
 =?utf-8?B?WFJHYkhxRS9kZjZUR2F2M3B6Z2ZiNHZlZFB0M1ZESWcxcXBWNkZQcDNwVUhk?=
 =?utf-8?B?TXZpZEFqMkxKRjdVYXdSWk02QlJkNzVGNmduQmRydVNhNVgwQmZES0ptd2tP?=
 =?utf-8?B?RjBZRmpiRldIeW9mK2pxR2JISzZ1WmdoaEtuTUU1YXZSMGFhYmtpZWpZZldp?=
 =?utf-8?B?OVBOZ1VlaU5GUm9iV3NFYk5jdXh1SWViMG1IT0lrYnRiR2VpVDY0VXIrSzg5?=
 =?utf-8?B?alJYNjVPWUVVNFlyeHJCUE0xT2hBN2lKMXZoVE1ZTDF2a2QyZWYxejI2WjVo?=
 =?utf-8?B?OTNXbElJdzd5MkZGTVlhNHdVbjlsdEQ5TTM5Q3g1bTg0ZVM5U0h1dHUwNHd6?=
 =?utf-8?B?YXJ6U2hxcDQvN2k4c1lsTXMzQ0hwNVltdlNsZksxVWZzbitaWmN4NFVEWjZ0?=
 =?utf-8?B?bXJkNEN5QUtDelpvRHo4YVk5ZzFGQ3VKNFlHR25Cb0tvS0NyTmNHTFJUc2pP?=
 =?utf-8?B?QUtOSWFjMkpQelcyWm1Qbm94cjFsWmE5Ykx5eEJ4SXFWeXRkeVFVd1NxSU8x?=
 =?utf-8?B?NmwzYkJTSWFSWkI5bWUwTlBtUzc5UzNHdWVEUjIwZ21GSmp5N1JESUFVN01m?=
 =?utf-8?B?YVU4bHRmSWd4eC9IQ2p1ck4wa3ZVanpRdnVDOUl0ZWdNR3lOUlVKSDkybjJR?=
 =?utf-8?B?SmRHdkdwNXhDMmxuQkU5VFBwYW9mSFAyT0EzZWx6Skh3MGFQSjFlMmVHRzlJ?=
 =?utf-8?B?dnh2YWFXVDU3MFBUNTI5RGdhMDJwSmU0VDJvc21HQUc2Z1FNOVlyTkI2OU1B?=
 =?utf-8?B?SURrMXNURnZJczNGRUY1and0bkdsQ29ialNPY0JyQUFDOG5QRi9sTGxYT0N0?=
 =?utf-8?B?UTdja2RKRjBNaitTY3hNc0ZoSjd2NDF6ejNCNmxMR3h4Q2VvcE1DaVB4clRW?=
 =?utf-8?B?OU9hOXJDSFBqQUd2enJZV28wK3EzbVovRUdLTytGM1M1bGVRTHhlQ3AyQkhL?=
 =?utf-8?Q?CXfX2DDTPVI3U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXZkVFQ4N2FnR1BNZnozMlhDZ3h4amduNE5BaEdkbWpxWG03V3hEWWhRTEVw?=
 =?utf-8?B?R3YyNWpoUlZ5OFd5enhhems2d1FZM0w0NlpnSFFNcWdBSVlleUxWR0hocE1m?=
 =?utf-8?B?aU1RSWgxYzl1RWNYTTBNK2RVakVpSi9UaHNHeEJTM1lrbG9WTGgxbGVsWHNB?=
 =?utf-8?B?RUpPRDV6OXI0L3luZVF6Q002bG1Hc0dJaGRmRGtKQWtGdzd0SXFmZkwzcWR3?=
 =?utf-8?B?STBCY042eXk3Y0J6dEtYSUpUM3JxUllUYkJHTkRJOGMzeEgvWU1UMmlvWUdK?=
 =?utf-8?B?b2YyanM2a1Nid0JrK0hYWVNlZ05XNkZpZnNoR0RWUnUweEliSm83MEZiMGF6?=
 =?utf-8?B?dFhnYlIzanozalY3V2RDUExFejNjTXVuY1NDWE1EUFY4WE9hRlprVTdoODFw?=
 =?utf-8?B?ZEF4ME9JSjd0MG04RUN2cVUyMXhLcGtiSTMxakwwbHlVK00yTy9PaHZzTlY3?=
 =?utf-8?B?TXFiV25RbjgwQStXcG9pbHNMR1dzVWhTaU1keG0xV2IyV3hvdEpaL2VKVEdu?=
 =?utf-8?B?bHpEcnRVL0g0d3ZZOXY0Q1pxOFlHbm94MHlVdG1GbWs2MlNTcldZQVpBYUZk?=
 =?utf-8?B?M3psZmdLbElhNy9lZGVPcUU5OTZjNG1TTlQ3SFRNSE8rRkJJWmtxLzYrem1l?=
 =?utf-8?B?cHB2RGtWOFpOR1FHdVZrS2JPa3loYVpEaXdiV2VxRmJBa0Irdk1TUGhaSVhq?=
 =?utf-8?B?dDkzdXVKVldpUGVMRC9ybFZsNWdEc1BWYkpDSUxDZTFFNFlMYXYvcjBoYVFX?=
 =?utf-8?B?RGgyVE13RnpqOVA4TlJpd05lTTFRVnF3dlY0S05DNU0zUkNLYUMxZ2kyK2kz?=
 =?utf-8?B?WWJPT1UxVzFUVzdDdkpXM2cxSW5KcjYrZlowUytlM2RTelh4bFpNUlpMaERr?=
 =?utf-8?B?UWZITnFyZm9pVEFLbWhnRDlSMVg3cnJYZ3BVUHBjMHhGVW90M1BncE9wekJt?=
 =?utf-8?B?MHlqT3gzVGFSUG9WQ2RwanBPQ0dtUzFzdk5rT1ZvOXJjRjBhd2o4ZFVxL3ha?=
 =?utf-8?B?RHBCOGFIcDB6eVRWSnNVMGxGdTE3Z1huelA0UnV3L3VqRENTQ1d4aGVtZHI0?=
 =?utf-8?B?V2RZSDkvWGtxeVN1THB6R01XcFBDazU0WUxuYVJNdFVlTGRPM0tWZkpOendu?=
 =?utf-8?B?WTlQNVMvS2JaNXYwSVJoV1I2M241dm01Um5lVmhHZjFIOTFuem9rcEJCWVVt?=
 =?utf-8?B?QWlsWlk0TjY0WllIM2VMYyszQ0tvTVBINFpJdGRKL2VFR0V4WjNHTWJPd2ZQ?=
 =?utf-8?B?NTZDQ3VXWTRkdnB5VUxqdG5qaktPWnVXQzhvOGtXUGh5cVU3V2Q2cUYxWnFV?=
 =?utf-8?B?TmNVNTNWUlJ4Mk16UkZtYzViWm1aOE4zdVIyOXNTaFVwYzZlMThUeWFrSjQ3?=
 =?utf-8?B?a2RtcnZNdkZCNkxydEorWlZiNFJMYkdBYWI5WlB5d3Z5SGhtM0xEY0NxODNj?=
 =?utf-8?B?L1k2SjdKZnh0OGprbjA4WWkxY25HUzNIVkZIQlIyM2c1RFZFWE1jWHlqbHY0?=
 =?utf-8?B?Z1RNNU8xbWZKK3dvT0l1cmVVMnNNc1VXY25za2dDQ0hXTjE3WmRHUmY5a0J6?=
 =?utf-8?B?WThQK0xPRTJ1N0M2Sm9meTh3ZjI1bDhEeDIwR1BpMUhBaWw3YldXN1pBOWYy?=
 =?utf-8?B?N0UySGJON1pNUkJVUkh4eExkZVNOTllKSU8ra2w0a20zSFVyalora1VZdStQ?=
 =?utf-8?B?V2tySlo0dGx3QVluY3J3bEMzVUFJaVNZL0doWXN0Uy8wdVNQOFRETTBwMGM2?=
 =?utf-8?B?YjBWUjRycnB2Z2U0WklKcGxuUERLYmswRVhmNThJQnBBMlV2Yjk2TUlRdFYv?=
 =?utf-8?B?UkNhMmZmbXgwdmFTN29KdVNyb1AzZjJOVys2YnRpOGhSOHhlOGNpYzF5aDBm?=
 =?utf-8?B?ZXRNdFNUYk1pOTFZbWNWZExqeHV3WGNNVWlnbjJGRndWd3EvVlBCdjEvV0FJ?=
 =?utf-8?B?S0pINHhaTmhXUE4wTlE2VnlWZEVzQStaNThEdS9yWVBQZi9PaDc0K3R5UklV?=
 =?utf-8?B?UHF2dFhnaEE2OXVESjdVVlZvamlhM3RIQVB5TnJKRXJCeDluRGRRVmh3N3Iz?=
 =?utf-8?B?T0EydnVZOVdWOHV3eGEySkppaExoWlZ3T21SeXUxcll0N0pSZk5xWkEzVUJy?=
 =?utf-8?Q?CrPclzliHIogFC3fXnjaYYVq6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca59cae-4d59-48d0-22d0-08dd56087ba4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 01:54:19.4114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5iYroPzRszTJ20hFMxwtE58xgNYK6kBaP1uxa7B28HZi3DahWvpygJsFVTcihr5fpG29RRi5aOJyH3VaiExpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4227



On 25/2/25 07:28, Dan Williams wrote:
> Alexey Kardashevskiy wrote:
>>
>>
>> On 19/12/24 18:25, Alexey Kardashevskiy wrote:
>>>
>>>
>>> On 6/12/24 09:24, Dan Williams wrote:
>>>> There are two components to establishing an encrypted link, provisioning
>>>> the stream in config-space, and programming the keys into the link layer
>>>> via the IDE_KM (key management) protocol. These helpers enable the
>>>> former, and are in support of TSM coordinated IDE_KM. When / if native
>>>> IDE establishment arrives it will share this same config-space
>>>> provisioning flow, but for now IDE_KM, in any form, is saved for a
>>>> follow-on change.
>>>>
>>>> With the TSM implementations of SEV-TIO and TDX Connect in mind this
>>>> abstracts small differences in those implementations. For example, TDX
>>>> Connect handles Root Port registers updates while SEV-TIO expects System
>>>> Software to update the Root Port registers. This is the rationale for
>>>> the PCI_IDE_SETUP_ROOT_PORT flag.
>>>>
>>>> The other design detail for TSM-coordinated IDE establishment is that
>>>> the TSM manages allocation of stream-ids, this is why the stream_id is
>>>> passed in to pci_ide_stream_setup().
>>>>
>>>> The flow is:
>>>>
>>>> pci_ide_stream_probe()
>>>>     Gather stream settings (devid and address filters)
>>>> pci_ide_stream_setup()
>>>>     Program the stream settings into the endpoint, and optionally Root
>>>> Port)
>>>> pci_ide_enable_stream()
>>>>     Run the stream after IDE_KM
>>>>
>>>> In support of system administrators auditing where platform IDE stream
>>>> resources are being spent, the allocated stream is reflected as a
>>>> symlink from the host-bridge to the endpoint.
>>>>
>>>> Thanks to Wu Hao for a draft implementation of this infrastructure.
>>>>
>>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>>> Cc: Lukas Wunner <lukas@wunner.de>
>>>> Cc: Samuel Ortiz <sameo@rivosinc.com>
>>>> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>>>> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
>>>> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
>>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>>> ---
>>>>    .../ABI/testing/sysfs-devices-pci-host-bridge      |   28 +++
>>>>    drivers/pci/ide.c                                  |  192
>>>> ++++++++++++++++++++
>>>>    drivers/pci/pci.h                                  |    4
>>>>    drivers/pci/probe.c                                |    1
>>>>    include/linux/pci-ide.h                            |   33 +++
>>>>    include/linux/pci.h                                |    4
>>>>    6 files changed, 262 insertions(+)
>>>>    create mode 100644
>>>> Documentation/ABI/testing/sysfs-devices-pci-host-bridge
>>>>    create mode 100644 include/linux/pci-ide.h
>>>>
> [..]
>>>> +    __pci_ide_stream_setup(pdev, ide);
>>>> +    if (flags & PCI_IDE_SETUP_ROOT_PORT)
>>>> +        __pci_ide_stream_setup(rp, ide);
>>
>> Oh, when we do this, the root port gets the same devid_start/end as the
>> device which is not correct, what should be there, the rootport bdfn?
>> Need to dig that but PCI_IDE_SETUP_ROOT_PORT should detect that it is a
>> root port. Thanks,
> 
> Why would the values be different? The Stream is associated with a set
> of RIDs, I expect the PF and the Root Port to agree on that set?

My current understanding of this the RIDs range is a firewall rule and 
not to tag PCIe trafic with a specific streamid, so:
the PF's RIDs should be just 1 RID of the RP;
the RP's RIDs should be the whole range of RIDs of that PF + all its VFs.

Or I am missing the point of it, am I? Thanks,

> Regardless, the PCI_IDE_SETUP_ROOT_PORT concept is dead so this could
> support distinct settings per Root Port vs endpoint, but I am missing
> where / why those would diverge.


-- 
Alexey


