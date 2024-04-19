Return-Path: <linux-pci+bounces-6486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BCB8AB1E1
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 17:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7513281F3C
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 15:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E65512AAF4;
	Fri, 19 Apr 2024 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uFDxGn3P"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B13977F13
	for <linux-pci@vger.kernel.org>; Fri, 19 Apr 2024 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540699; cv=fail; b=c0Akue3oSctghq4IAeunkrfoPvlaA4GVVRiapXucGQxWHNqIcBeM1vV7sbmB3EUixDpK7/WS9aSMpZkFai4INiUo0m4fBZZeiO38yXC25KhY2ULsj0q8+tTXcTj0oCykZ1G6SrX77UhYY96+eNuxjb7Z4EJDb7fflrPPQMn+V/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540699; c=relaxed/simple;
	bh=+v4himJ/dmyta7vnHp6W1v/HD3DBEwZAeUuAWNMcWIw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S7neePCRIWFDbCaHWN9hehxHlEm4Fu0a9Xk8n9nKKrAvP1GnL2Zy2PX4tC2sZTP1axaenpMudFtLW913ereBp4iCoes+y+oidDSGJ/3op6xrT0rxMNACk7o8nWm0fDyAEXe0TBNwnRjYcSnLOkhNJCjW3zLvm8Gs0kKcwT62nOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uFDxGn3P; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhZujZeRPzmQCT9DIf12CO/TkjrF336m1plTZQCawSdZoB6u0F5R6dXmtPgZ8dK5jYHsXz5k9UEHRY/uLIc4rs25vz9kuMxuCdzc/uCGO1tfpwErC7BulEd/G+tmLmbC/IXgqlUK5meGAxwQ4HGDKIJtWzyImj2J8uJcmqmlxZyzhEm+dCEHQzd11DcwCesYSV9ZdM3LSVdpYaH5O9hJs8LyKUYj06f0GopLanNhX6u2Ol8HL8Yta8rmUzz7sjNA+iQPhBpRFBdZ+gDPC006wec4dOm0Q36jC1D1qq/1pPgV/hZlCfl3TD4oFalmOtku7EdupgWJdOtFPuNrv/YMaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+aM/AafeyBfurGwu124tMKdyhGiDIBFmpXp+tftPLY=;
 b=YFkPJk4NjsurpSE3FowE4GIM7w/2wzvb3yW8c3mkBz9YUZlOGAfVPfW+0/Rclt+jp6Ukt178UTLQ9yAr/1gAbE28tjsbaqBI6V+u/X6WJRuf7Jbrsk3mOWNS+SABaE1Ovwln17qu5l9yy/0s1tDz0cZdOR6Bo37U2qSHfKPHV626MDHgF1IW2YQr6OdTLdpuVFTEIujkuQgdvzuBHzBu/DC2yLmz3avDWeGIKQPcedjCf0NLzSASfGlighGHHSWmxSFOKLeQwlMxOR+evCIfp4O+kldYsro6pfkqUw/f31PeaAqQKara+QbF6jkuKWEcZ0EznpvE0XV2cRuW50Csxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+aM/AafeyBfurGwu124tMKdyhGiDIBFmpXp+tftPLY=;
 b=uFDxGn3POA4nnfQ8292dsc31daVOgZG151N85UA4IgqQ7QAUjnfce2r9P0nHVgdEciZdk3IkSXBukS0eUidFVBeY1YeBaqoxWv09N112hFS64sCWWoOj0EI+48jqFL/lWgBeyqI8Z2uebJRtXkPJao/N1iGhFfQjRy48g8W1u2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB6983.namprd12.prod.outlook.com (2603:10b6:806:261::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 15:31:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 15:31:34 +0000
Message-ID: <71456a7b-8dbd-4108-ad15-ddd7c0811b0d@amd.com>
Date: Fri, 19 Apr 2024 17:31:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: PCIE BAR resizing blocked by another BAR on same device?
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Dag B <dag@bakke.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
References: <20240417151313.GA202307@bhelgaas>
 <d509c9e6-37be-44ab-8f47-6fe55397794e@amd.com>
 <fa9245d6-ffb7-4bac-8740-219af7fcd02a@bakke.com>
 <fbc9f2c1-2e5a-4611-801e-f055e6042897@amd.com>
 <ee971d86-5fe4-4e0e-9eb2-21272e793974@bakke.com>
 <815337f1-920f-b2ad-7f28-b1b366eb23f5@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <815337f1-920f-b2ad-7f28-b1b366eb23f5@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c26e5aa-8aec-4e21-4486-08dc6085cb60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGdiZ2FFUFo1ZXR2dnB4clNnUkVUZlUvYzQ3VGhMNk9waWNxNDNpRGlXNUsx?=
 =?utf-8?B?cm16OHZKNnJmQmt6MHVyTk9JSVdLTG1TbzBJZ0c0WjdyQUt3VmU1TjU3MWNG?=
 =?utf-8?B?UEVRS1Q5Y1VIN0JiZkhidDAzV29oOVhxZmJWeGUzbXY2bTBpcVVFbmtSQlpU?=
 =?utf-8?B?aGcrMG1vTmh5UjJWaG5XQjNEMCtPMnRjb2h2dVJGZW1pamxKbnNmckZKTHZW?=
 =?utf-8?B?VjVQN2RCQ0pET0ZvbFQwY1drOVVzYnNYa0pjSStLSHdEZGx6NDhOeHBPWHpL?=
 =?utf-8?B?YWdmSXV3WWF0T0xYNjBVRjlBaWFuTi9RcEJQS2xEV3VqMGdCeCtGZ3lZbzA3?=
 =?utf-8?B?ZzRGWGtPRUYzYlBqUUdzbzgyM1pkU3AxR0gyOTkwa2lldzRQanlHMDEyVVJ2?=
 =?utf-8?B?bUsxTzRwU3gxRUZzUkpRK2N5UDhFaXp4M3g1NHFiWERHaGRIenVWRjZJRktN?=
 =?utf-8?B?SUIzZjBZWGFOT0QzMjhMbWJlNUEyWkRzdmlpekpJUEVlVDRmb0czQ1d2bGF3?=
 =?utf-8?B?ZjRkRUNFVDJhSTBWSW14NyszVEw5cHhUVFBkS2dFa1l1M251dVg1MkNRelh6?=
 =?utf-8?B?U3JOcXVPUlBwUFFWeE93dXFKSDhmbk5YVzNEUXNlZ25kOEFzREpjTWtWT1VK?=
 =?utf-8?B?ZUhVTTUwWmNiWDl3MDlSaWE5SVRuU1MrbVFSSGhMT1FlT3dBMlhtOE1Xbm51?=
 =?utf-8?B?UDRkVFhDb0w4YTJQdzBrTmRBZXZDdDQwdFJ5L2g0L3o3VXNjTTR2MU1tZnEx?=
 =?utf-8?B?YWQ3RURsOUEvVXRFbWxsK0RiMTZjb25veU5BQ0RBK3ZhKzVHTmxpRExGM2NJ?=
 =?utf-8?B?dTZoNGxYcFVNSW96c2ZESGdPcnJKaEFmYWp5dWxiNU94YWluWTRkQ1VRalIy?=
 =?utf-8?B?cnNYVG5NUEN3M0xkYlpSR0dGVGtXL0Q5eDFaY0hRZWFMbXZ0OVRVMHMwRWF4?=
 =?utf-8?B?WFAwRzNiTG02OWI1TncycWdncjhydjA5M2FHUzBsT1o0Y3JQU2w3Tk9oZFJF?=
 =?utf-8?B?R3VGMmhsSE1nTWt2dG1wSGtVTGxaaEFyTVQrby9rR1RES0dxTkVxSkcrcXo5?=
 =?utf-8?B?QlRnNlJsMGdpZFJLSysxREdnUXRiNWRiUUtONkRzRUgyRGNBMTZIUTlPTkVX?=
 =?utf-8?B?YW95V290UWdhZ0grYm90V0MwZlArRHllY0FrVVBkNjFSQUlZQVpDQjFJMlZ4?=
 =?utf-8?B?S2RMbnkrSjhEbWc5bVpXSk9CL1RyVThWK04zTFc3ZnRKVFpDcS8vcHRaejBy?=
 =?utf-8?B?SlBWQlNjVnQ4TmpNbHhzVlFMNUd6QWNGcTNiWWd5SmpwbFhLQml6T0d6d2d5?=
 =?utf-8?B?Y0o1TFBBZW9VeHl5cHpYUFBicmlrdkdrY3BucFl6YnRUZGMyMnMxYUpuNzlC?=
 =?utf-8?B?c2tyMDc3STE4RElUUzBGdXNmTVdUamttWUJmRGM5SWs1MFVnWnJXSldjeStt?=
 =?utf-8?B?cnBzYXdOTTJvQUpzdlZMRStvblZBOUREdXZxRzlJczhyNkVpS0dUUG01SEln?=
 =?utf-8?B?RE41aGdtUCsyaGgrMEsrQlptRUpqYU1kN3RUZEFDbTh1aHFqeitoWDlYK29T?=
 =?utf-8?B?RktYUTg0ejZIOU9MRTdsSmVTTms2N3FwQm9VeFNZR1lxUStUcWdLU2NxalUw?=
 =?utf-8?B?WFNKSTBGR2VDdTJjeGFiU1ZKVGxJRkFpTGc4R015R0l0UC9TaFhGaHh5Uk5Y?=
 =?utf-8?B?VDNkSzdlRCtYUWdKTWFoRzh3Rnd1ZEJnQlZJRHBMU29VR2tON3lLUkZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTRQREt3YXQvbmtqQnRJRkp4Y1dIVjJKL2M3eEtJT3VaU2lncjhhTngzZCty?=
 =?utf-8?B?am5rR0lpN2wwZmhRblpja2YwSnZGT3VtaUtLM09BN0tvcnZxd3NWZEwvVXBt?=
 =?utf-8?B?VHIzSlJkV2pXdnhiMGFGVTNFRndKR2h2Mk9pWUdKZzF1WUNwdzFUR3o0UVRo?=
 =?utf-8?B?TjFXUnl1QnNBdmpwZUFsT0VpbG1GZkgrRDlMQ0REdmliSURSdUVMZWNRNHlJ?=
 =?utf-8?B?Y0ZjcjV3K05sdjgvc096dFhEVXg4eE1NMjZSeVN5Z2gxc1U0eEhabDJBa2NG?=
 =?utf-8?B?cThGeXREMmlVWlRMR0tuZkgvaWY4YVNVclBVb2FkcXVlMEZYTEFFWG1CY3Mr?=
 =?utf-8?B?enhLcW05MmdKeWJBQ291OGRJTjcrTm5IVldNMnE4QUliRGs2VnhybktvMVM4?=
 =?utf-8?B?bFNqeGRUTG9KbUVQVmVBNTFPQmdTZXZhb1NGU0ZxTXZYQ2p4V1F6TXRjWVpE?=
 =?utf-8?B?TEFKMWxaVUNGdm1TL1k5TDIyMEdaUU5NYitQWDJxUGVMZmZzYlg4cEpkWFRx?=
 =?utf-8?B?R2tKRjZSbW0vYkNOQks3a3VwOFhWb1JXdVAveTh2Z3ZwbmxvcnI0ekJscldu?=
 =?utf-8?B?SDhlTmliRE1MRzBYNE9BN0R0ZHlydEJNcGMxbWFvV1QwdU5FOS8wVlJFaC9i?=
 =?utf-8?B?SmRwZDdMY09xOGZ2RlRLdHdlemZIV0FWbmNDSXQxeFZPQ1RtZWU0Zmw0N1kz?=
 =?utf-8?B?MGNzQ1BTcU9RbHczSFZnUkd4ZTJhQ1RvelZZRjl5dlRYRHhyamI0NTQ3YkhD?=
 =?utf-8?B?WE8zU09Eb0pCSUdOeGprZDlkdHFmQXFvN1E2QmRqTFhQRTVybjZQeUdVZW1V?=
 =?utf-8?B?SU5BcnhnR3VDTG15NzlBSENHR3MwRmZmaG9DanRYenVPUStzODJDNjIwU1FW?=
 =?utf-8?B?WjZpRXVTRXZ5WG5JTyt4c2N1UVQrR0RIRDF3YjI4NmNjakIrSHIzdTBBREFq?=
 =?utf-8?B?UkQySWxZS3ZQNmFYSEVDZ1d2TFBRRmdaNEo1OU5ZTDJXNDVVWE01SnZ0VURN?=
 =?utf-8?B?NlhxbTBMczB1RnhZbVFmV25pK2lieEhzTWhtdHhpcjU0TWMzNWc0aDZBQy9p?=
 =?utf-8?B?WTRSL0I2ZUpoeCs0eTc1dkZzcHRtdWwzT3hSZitISVI2ZlRVVmUzM1RORU16?=
 =?utf-8?B?bVo3U0FTR1RMYzA1cUErdmYwYnBwQWpEb0tnbXF5TzJQR0hDaEdETTVvUXBS?=
 =?utf-8?B?RHdDMExQUkl2aXo5MXV0T0hFQ21pOEc5aVlSTzZrNHNNSXRISllwN1ZZZGJ2?=
 =?utf-8?B?MEkrTExaRXp1T3Q4LzdIV0dlMk9oaHNGYzFwdkdjckszR2FRTlU5c01Ha2tk?=
 =?utf-8?B?dGY4YUFkWnFLUGVVZ0lxSG5qaVp3SGl0K1AvUmh0STJFT0N1L1pYS0s0c3Ew?=
 =?utf-8?B?dGdIa1dFTGxoLy9pdUg1Y05PTHM1QnVrczJsRXU1M1hSM0ZxVHRxN3NFd1lP?=
 =?utf-8?B?Z21teFNHSnhPRHlPZGpCTkN4MVBBNFN1bStsSzAzakd5RlVLb0xtUHphUVdl?=
 =?utf-8?B?ZFpJWUdhaFlaK3hVaFg5ck1GQVRrT2JITmt1L2swSzhEYmhpaUl1cGc3M29E?=
 =?utf-8?B?Z0lCTmthdXFvYVlmR2JrUHpZbXRETmJQcWd2Y1pCcmhqTzFmNnI3dENjOFhp?=
 =?utf-8?B?QTlVZHFDdlNyR2RlRHEyemx5L2VjZFluamNVcXY5MUUvakFXUktQczYxZk1L?=
 =?utf-8?B?M1A0V3l1RktFU2o1bXJxUjk1ZlpFVm01TEpyV0N1Wi9yZ3lBM1FRbGczdjkr?=
 =?utf-8?B?aFF4bmtKbFVzT0xXcUZUSTdWRzZPbzFqSTl6VU5TczRVNEgySzV4M2NFY0Zt?=
 =?utf-8?B?ckJNelQ3SjFXMGZnU1d0QkNpTkw0Z2lJcHVrZWYrVGVOWlRvc0VGVnJhRnNC?=
 =?utf-8?B?U0VUa25mbm9FRjNjR0wrcnYvN0dkQk9zdzc2WVBYZitOYVpoS3JWNDBUWXhE?=
 =?utf-8?B?U2FpWCt0SEQvbXB3OSsvbjhLZDZaMW9qSW9EbThHcmZmRTFZNFhDd2tGdkRo?=
 =?utf-8?B?ZzZwb0JETUFISkdVeEtPN1dlb1FuSnVkcWtsTUVkQXRIb0t3NHprb0k0WnZ6?=
 =?utf-8?B?bkU4YWp0Z3FVR0E0UWcvUk56dVNuRnVvSmcvNjRpV0ljV29kTGNvUGc5TGJF?=
 =?utf-8?Q?BC8w=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c26e5aa-8aec-4e21-4486-08dc6085cb60
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 15:31:34.0123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NAw1QhRDxPNS/xbADfuBQENkv8wswzzP9IVLeyjpS7gRH+f0CQ9GrzEnBGuM2cCE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6983

Am 19.04.24 um 17:19 schrieb Ilpo Järvinen:
> On Thu, 18 Apr 2024, Dag B wrote:
>> On 18.04.2024 14:24, Christian König wrote:
>>> Am 18.04.24 um 12:42 schrieb Dag B:
>>>> [SNIP]
>>>>>>> Is there a good ELI13 resource explaining how resizable BAR works in
>>>>>>> Linux?
>>>>>>>
>>>>>>> My current kernel command-line contains: pci=assign-busses,realloc
>>>>> That's a really really bad idea. The "assign-busses" flag was introduced
>>>>> to get 20year old laptops to see their cardbus PCI devices.
>>>> I threw a lot of mud at the wall to see what stuck. Removing it now did
>>>> not make a big difference.
>>>>
>>>> Removing realloc prevents the second TB3 GPU from being initialized, so
>>>> keeping that for now.
>>> That's really interesting. Why does it fail without that?
>>>
>>> It basically means that your BIOS is somehow broken and only the Linux PCI
>>> subsystem is able to assign resources correctly.
>>>
>>> Please provide the output of "sudo lspci -v" and "sudo lspci -tv" as file
>>> attachment (*not* inline in a mail!).
>>
>> In case I have expressed myself awkwardly, the realloc=off case appears to
>> make the device driver have issues with the second GPU.
>>
>>
>> I have attached both outputs, for realloc=off.
>>
>> Not knowing what is considered acceptable message sizes on this m/l, I
>> uploaded the same for realloc=on, as well as output from dmesg for both cases
>> to:
>>
>> https://github.com/dagbdagb/p53
>>
>> If the m/l has mechanisms to archive attachments and replace them with links,
>> I'll redo the exercise in a follow-up email. I understand the value of having
>> the 'context' of the discussion readily available in one place.
> The mem BAR & bridge window configuration is identical between
> realloc=on/off.
>
> The error seems to relate to io BAR:
>
> [    2.782439] nvidia 0000:09:00.0: BAR 5 [io  0x0000-0x007f]: not claimed; can't enable device
> [    2.783139] NVRM: pci_enable_device failed, aborting
>
> With realloc=on, the entire IO window is disabled for the bridges and for
> some reason nvidia doesn't abort in that case.

That actually makes a lot of sense.

At least on AMD hardware the IO window is only used for VGA emulation 
and I strongly suspect it's the same on the NVIDIA GPUs.

So what basically happens is that the BIOS for some reason enables the 
IO range on both GPUs while when Linux makes the re-alloc it disables 
the ranges. Most likely because the Linux PCI code knows that they 
should only be used if this device is the primary VGA device used during 
boot.

Now when pci_enable_device() is called the function checks if all 
enabled BARs actually have resources and without realloc=on the I/O BAR 
has nothing allocated and the function fails. While with realloc=on the 
BAR is disabled.

Well, what a mess. @Dag I would just strongly suggest to see if you can 
update the BIOS. What happens here is clearly incorrect.

Regarding the resizing as far as I can see the BIOS allocates only a 
single 1GiB window to the upstream bridge, that is most likely way to 
small for anything than the default 256MiB BAR.

Maybe try to force assign more address space to this bridge. IIRC one of 
the kernel parameters could be used for that, but of hand I don't 
remember the syntax.

Regards,
Christian.





