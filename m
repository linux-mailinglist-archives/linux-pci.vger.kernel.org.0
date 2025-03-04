Return-Path: <linux-pci+bounces-22798-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DD7A4CF96
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 01:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD413A7F87
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 00:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F70EC4;
	Tue,  4 Mar 2025 00:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="giic5pL5"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553C92F43
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 00:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741046609; cv=fail; b=C00jCnu3ydNfC3z5yWRkjE3NPqUSTS6HTm04yAZmYOCZqbyPWmtx2JYt5moL7DTQa2p2q4bV3wWGwHlGu+4VMInP3zvaSDVTUZp1aQocNFMWt8nTG/jj3e05Eqt50Z342XGJ+d/qjnfrji6GmwS8F099S41qm8BC8/ZmgYzS1Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741046609; c=relaxed/simple;
	bh=6V4kuKfVl0NNd8rrjI0I6qQSTmJ5TxtSNV/FSyNrrXI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gYldfuDEgcr0tkljM0haB8pSSQujBskv4QjP+0eNGfwIk8n8nXJWvExk/lyG+z7YyPwvGlRcNzPCQnF1fnpAv9sivznLj6YvYsU9AKTbBEvUsj9B5Pl+QO/yS0Bvgdxj7emEFG3qiSwcdQPQbRDPMBbqziZ8b391kXx6tnSQn2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=giic5pL5; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzB0O4wH+M6s84vRDhcuS5tWL6yvOTse8I+xxF4AqQzPGhhHQy/CTyHoKwrNOjMMm24GZppVFUOjzKuxe9ZiZMgkUt3YmtoGU6iYY5jW9nsSVt6m07LZOAfsfurOr9zGGDfNouOlyruw6kFneobxqMCLmbKeMenSyTI1CTmBxIpLBGxcRvBA5H/sm8QH6WawlNuacKjEjB7pgrPXcTGozcktnvdDk4P+iWDNOspCezPv4hwTc6Ittce4Wz/x4htOkhhD2KGz6mkT+tPpl0IkE4K1GsPDZ1kmtU748R6UNskM6b7ESippvJ4b/L/r8xkorLx7/I9sl9bJKjzAV0euZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5ehYn54zcfnIgqEYABd2X3JiTzW4MoRZ/xM0YltDGc=;
 b=ud2ZmGSKdX9sBnktijmTYBGJjMJm9f9d58xXgPc5/L7hnhH4l8HoYRjW7LwlkMLb9ERhV6jVzpTDc49kjKZqfEIgVtAd9VOSGdDZn30kEfzCdtaOin22rMH0zlysAsKTwILpAtvUuprAH2mDCUJYXiG6/39zs1CfxJR96arjtvr47qnJNdXBUk99qiIiokvQ1MHl3/+GTg5RP8Ga3xfq1fJwIdTIUlw/xyWoqbVurQRd8TJVMIPhLlF0OPw/RS0xY+ii89RNbJvAFPtwsozBBQi83hB5zls7r+mMlNbYi34Fb8//HEncHlK4pLcLtQiE2kIspZcdFb9Ubb671eBERA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5ehYn54zcfnIgqEYABd2X3JiTzW4MoRZ/xM0YltDGc=;
 b=giic5pL5CjOdPDP3O4v9VpCAeemFvEZabvYtY7uchgnfyt+WCzpyggj2wpPZleBijfPdCGjGa+e19OSTJitlsBo+S64yOFojV4ZZrkUNArt+2OFW+sCG39rF++VNnuLh/PFT50nrBNaQjh9X+xJEp6IeEbzazHOpnOuk0aiB4gU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 00:03:24 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%3]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 00:03:24 +0000
Message-ID: <8c091787-9275-40db-9167-af270dc5bb8e@amd.com>
Date: Tue, 4 Mar 2025 11:03:17 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>,
 Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-coco@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
 Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
 <9f151a74-cc5c-4a7c-8304-1714159e4b2c@amd.com>
 <6d50f215-93c4-49a5-9ee2-f9775b740f92@amd.com>
 <Z32H2Tzd1UHCQEt5@yilunxu-OptiPlex-7050>
 <d71dd5c5-4c20-4e8e-abaa-fe2cdea4f3b2@amd.com>
 <Z4A/g5Yyu4Whncuu@yilunxu-OptiPlex-7050>
 <a11c82c3-b5fb-48d9-8c95-047ac4503dc6@amd.com>
 <67bd098f4dcd1_1a7729449@dwillia2-xfh.jf.intel.com.notmuch>
 <cf2f615d-2a28-45ec-8bb9-563c2a5bde73@amd.com>
 <67c11ed38ff8_1a7729458@dwillia2-xfh.jf.intel.com.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <67c11ed38ff8_1a7729458@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEWPR01CA0019.ausprd01.prod.outlook.com
 (2603:10c6:220:1e4::13) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bdfda43-1d12-4255-d79c-08dd5aaffb72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TW9IaVVuaU85VGVLNEV3NG9WK1NRWWpYTFNCSWV1T2R3S3g0U2xsb2F4Ynhu?=
 =?utf-8?B?Vm1ZdDJwR3A5Y2NXbXdyelNzRlozMi9nU1dnOHhpSm1hWkJsazBQc29NTVdC?=
 =?utf-8?B?OHBoOFZUTDFTMmZrSW5UNVVCbDJpbWxlUXNkd1JlalBHSE90dXZBYi9GVGhv?=
 =?utf-8?B?SWhFcWhpRFF0bTQrT1A0c2dnayt5Kzdxd2FlUjlKUkk2V0d3SGN1N3A0NXhV?=
 =?utf-8?B?S05maGRSTk5rS0FEQm1FNlpXVFV2U24vNTRTcmZIc0lKbGFHUUx3ZDhZRUN1?=
 =?utf-8?B?b2IyMms1QkNtNnZ5VnA4bi9kdzZzSC9zbkFmTi9sSHdKYzF2QzBWV3F3cUlF?=
 =?utf-8?B?ODFNYzZYUTZsbEZoVEJyOGNwTmNwdCtJQVRCME1Gc3RhbW93dnp5SHduMG9V?=
 =?utf-8?B?aWRreHFpR3FNQzIrcGpDQXo2SWcwMUlkU0VJRUZub0NHVkVqMnNXQ1ZkTDZL?=
 =?utf-8?B?a000YTdubGxRZHJWSzFTWUVtdzFUUGJnbktFcjVTNUtQNkJMTGE4OC92bll4?=
 =?utf-8?B?VEFlT0lUNEg5WC9QUTRtVTR0T1pNV0pQSnpDVHdKQUp3R0xmZUxSWWlmcFVO?=
 =?utf-8?B?b1hkY0cyaTc5YnpjZUhPUG1TdUlmbm1KOXpKOVBidE9DMGZGdzBzS0hHR0VU?=
 =?utf-8?B?bjQxRVg5SW9GVWhuQitsY0xmSkhoM1hCUGhSV2dDMGE0elJQUWNuT2dGUmpQ?=
 =?utf-8?B?SE85ZFl4dFVob2FQSjVKZy9HZVpXWW01S1pXbUxOV2RlTHQ2aXVTQTdPT3pP?=
 =?utf-8?B?R2lDYTFVbzg4eFlKU0Z6SXUvOTVKRWdyT2p1VklYb3dDTlJNRkxaUW9wMXgx?=
 =?utf-8?B?Vmc3eUtiTUlGMnJJR24wQWZ2RnhNOEtsT2Q1QlNCeHJZbVcxa09QNDRQalZ5?=
 =?utf-8?B?U3ZhTnY3b0V0UHdraEk5WVBQSEZlQktoSnZHNmlicHhZNmYwbHFDdEQrOXcz?=
 =?utf-8?B?RzJqN2N3Q2dYVnpGMy9oQTRGd0txN1M1dVcxZlZ1OWdTQ2VBWHBJWXc2NXNs?=
 =?utf-8?B?RFpTNGJXbUNaQ25Ha3F1SHl3S3B4eHVJczRqMTNuRXJQNXBLQmxWUk10M1Vn?=
 =?utf-8?B?K2ZoVnRkVVJhc1BnYllLNXliVmpSSjFNK2kyQ1oralJpZUJDTFhNL08wU204?=
 =?utf-8?B?TFdQUlNrbE40aTlEdS9yZWhRSnI5TU5Tc0xENzg5QWRNS1h0YWhMT3JZajM1?=
 =?utf-8?B?UzFuWWwxMUpzdDQvRmZKWlZnWnU4Z2NUNzl2QUE1VUIxSjE0UThLWFRaM3RK?=
 =?utf-8?B?SDdaYnovQ0IrRW5CZ0VlZVhQT3M0SGxNeVhTbi8wSUgzTm55UTBMOGxaaTIy?=
 =?utf-8?B?c1lQeXJ0SnZlZExMUmpWeDd2MHZjbUR6QmJGWFp3aGlHUUExRk53a05Mbmdw?=
 =?utf-8?B?aGdZSFdiYTltc2l5aDRLLzFUekpvQlRRNDUzNGZ3M3JrNzFPTDZGQTJtSUJl?=
 =?utf-8?B?QTlSYWVrWXVIZ0FaSzFZWVNDalVmYjlQQ0IyKzZPT2VnWXo2VVNUc0RJYjhm?=
 =?utf-8?B?RzBxWWNwWEJRb2IwR3lLVWFVenBWYVJyVnNmR0xPdzVHL3JMR05rS0txZ3Bu?=
 =?utf-8?B?TVdDRWRwOGhhMEZnL21qQ2V0NnlvS1haMmZjcEpaalYrelJ4U1Q2eGg4UmVj?=
 =?utf-8?B?Rmh3a0xYK1VKdVJxdTVydjV2RXR1TzB1OXRmZVhIVWx2SEg4TFhGcG9sQjBk?=
 =?utf-8?B?YlF1ZCs5NS9iN0RVbEZ5R0gwUjdIdWFkd0RvT21adnhxQi9QVWFUbWFOZ21v?=
 =?utf-8?B?WmJZdXhFaEs0VTB2dUdNMEJ4MDJKbnJqWWdhNktLNzNHeWtWMEg3RGNDZ2kz?=
 =?utf-8?B?YTgzSjZYNDlmN1ZHQUw2S04wQm1QOEFyTnNhTzJBMkIwcXU1NnhkaFZvSzRR?=
 =?utf-8?Q?aXIMVrzN7GbgH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDEyOVBTcCtuM1RneGRrSHNwLzBuK043N2M3d3lDUzlCRE1iRVZDYklEVU8r?=
 =?utf-8?B?Q1h5SkhuZXEzWUdyVW82WVRHZXRTWTNxb2JsU2ZWbFZ3ck5xV2VNZktiNEtB?=
 =?utf-8?B?U1NRVXhPMllxN2dsZkNLZFlTR2RBQWQrdlNkdXJYZmdlcDNJcDllVktxRDFw?=
 =?utf-8?B?Vm9sVGlRcUpPaHQ1Ky9vbEtMZmdPRGJjdXNIMWFQUzd3eUpzKzN2UlVzVFM3?=
 =?utf-8?B?UyttUUVlOTBOWit6N0ZhYTJYbDByVjVlak5RQlg2ODdTbjB2WE03QWQxK0xp?=
 =?utf-8?B?Q2V1ajlNMVl4YkE2OGlYQ1ZYVWtnbTFEbW9RbHJ0QnJVU2hnVjNjM0tUTEdK?=
 =?utf-8?B?Y1lidytiYmdTUE1hY1c5cXNQVUlDMHRxYVovOGV5a3lDdWMycVRVOGR4cXB6?=
 =?utf-8?B?am5BaGtHbnJMQUsrZ2F4RHgycU8ySEpkVk9tOEQwMVUyenFMOTQzNm5KT3hV?=
 =?utf-8?B?SWJUbkx5MWhYTERSbXBRaG5GK2NNK21JVUo1ZkVMcGxvZXZwMWw5VHJZMGxs?=
 =?utf-8?B?YUt4akNFSlhlaEFSS0ROS0xOZTdtL3EwT25xYXpwaitHQVZWbzZtdm5CS2Zy?=
 =?utf-8?B?WjVTK3ZwcDhzS0pHc0daQ042ZGN5elNlbnlMU0Z3dDN1enhSMjRGeSs0R3Zv?=
 =?utf-8?B?eG5pMVVWY1QwMkdYSUlmSk9JRVczTmJ4UHBrSnVKWWZCR1Q0cWpodUtKa01J?=
 =?utf-8?B?VkJlMGZWKzdNWVlaL1JSdi9jeFhNOWovSFhkeU1yY253My95dWJvWWV1bllW?=
 =?utf-8?B?eml1d1pBSlBkcFRXdFBqQlloNEhYOUFRVnhiZWRPa0RZVWppNGFBUEs4VTNG?=
 =?utf-8?B?aXFQbE1YMThTN0l2dElCcllnd0Rlb2trZnZqQUxqc3IrbElscGJzVmFZRlRQ?=
 =?utf-8?B?Y08xcDlxTXg2dGlIdDlFNzdDNU13U0h2WUptRXQxUmhWRTdrOWxSeFU5VXJC?=
 =?utf-8?B?ay81aE5HRU10MWY1SlNYVjdaZ0hXUCs2K2ZZRlRGV3RQcGVVWkswdmthd2FM?=
 =?utf-8?B?Sk01RGZ5STNmMk93S3Y3WUY0MWVvdm5Sdm84YWdOcUJRYnRqKy82UWtEL1Z6?=
 =?utf-8?B?R1JCT3ZydDEyOEQwMjQrZFRrKzI5bnZVMkd4eGVSc09LN2xZdCtkM0Z4L1Zp?=
 =?utf-8?B?Wlo1ZitTTytleml1UkNocEJTOFNPWm5GYXlZenRnSERIem9sTWt6eUZBOFlZ?=
 =?utf-8?B?TVoxNUhzMVkzNjd6OWRjMVlYRE1XOEFzRlE0LytjSjdzd2tXaGRVTjJLbERV?=
 =?utf-8?B?dWlQdDdqT2ZtcU92SWczL1Y0dXZaNytNMFVxeCs0V3dESGN1eVdGYkRQUUE5?=
 =?utf-8?B?eWJYWS84VW04MENxMU4vRWlzeHROcWlEMkhVNjAvbytod0NTLytKQmJxSjVX?=
 =?utf-8?B?QzhLN1BYN0ZkMHpOU0FOYmdTNi9QTEw3Y0pPb0dxL0E4REtqdWVyK1BPZFlG?=
 =?utf-8?B?K3VqbWYxTDdvK1lqaE1RZWFoOTJpNU5aSXZhbkNCQW5JNUVqYnJtY3BoQTFk?=
 =?utf-8?B?TXRxU295dk0wRUdibkVaODdjTGNTd0V3RHFrSFZLcVRGUGdyY3dpSmFXcm1u?=
 =?utf-8?B?UnZZd3oxOFZqU2t5a01KdWdCWkNkS25lNC9NUnViN3luQzRRKzQvZldSeVNn?=
 =?utf-8?B?dXlOKzJkOFJjVWFCRDdsK3RacWpoS0JHc2xzR3phYW5VYUNNeFlVVDl4VkR0?=
 =?utf-8?B?RFBEZENDS091Y0ZoeHhOcmsvWmtNQWNjM2V2d1BmUU95V1AyK2NIcjRkNGRm?=
 =?utf-8?B?ci9hR2pmVGxXd2NlYnUreWpES0tnajB5Zk9EUjUrcjh5VGhNd3hFTHA2VTdu?=
 =?utf-8?B?cGhFZ2Y4Y2xSTlkrV2lkWElzcUxDeEluRmhKUDN6OG95VnQ3dDdURDJsZmhh?=
 =?utf-8?B?bXZqRmJWVnVwVlVZazRyNmlwb05LWXUydG0yNU1sQnhOMWVQZm92b09sM3By?=
 =?utf-8?B?SUE4S0dmdk81aURzQmljZkE3OGRRUkpYRTNnUnJCY2REdXU2VnVIcGdwSDNF?=
 =?utf-8?B?cWN6UXNMWUY4TkZQeEdBbGwwbUxqbFQ4T2JwZVVIS1dqbDNQekp5T3BCdk9i?=
 =?utf-8?B?aTV5N1V6bUhMTmQ3eW44RmJBSDVMRW9DRGdMWno5K01lL3VHRm41RmdNbm1k?=
 =?utf-8?Q?x3Id3Pp/48tha0tfdin6TwRQl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdfda43-1d12-4255-d79c-08dd5aaffb72
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 00:03:24.4503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RjNXfw8gxo6pD0bIjlrzTLHOIuuVl5zppB6pLE2IfbWoS/P3noDO+PWS55fP4/fdKxPdwI4Vv8PKSd/QsbYrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014



On 28/2/25 13:26, Dan Williams wrote:
> Alexey Kardashevskiy wrote:
> [..]
>>>> And it just leaves link streams unconfigured. So I have to work around
>>>> my device by writing unique numbers to all streams (link + selective)
>>>> I am not using. Meh.
>>>
>>> This sounds like a device-quirk where it is not waiting for an enable
>>> event to associate the key with a given stream index. One could imagine
>>> this is either a pervasive problem and TSMs will start considering
>>> Stream ID 0 as burned for compatibilitiy reasons. Or, this device is
>>> just exhibiting a pre-production quirk that Linux does not need to
>>> react, yet.
>>
>> The hw people call it "the device needs to have an errata" (for which we
>> will later have a quirk?).
> 
> It would be great if by the time this device hit production that problem
> could be fixed, but hey, errata happens.

Unlikely though.

>>> Can you say whether this problem is going to escape your test bench into
>>> something mainline Linux needs to worry about?
>>
>> Likely going to escape, unless the PCIe spec says specifically that this
>> is a bug. Hence
> 
> Linux has a role to play here in influencing what is acceptable in
> advance of the specification catching up to provide an implementation
> clarification.
> 
>> https://github.com/aik/linux/commit/745ee4e151bcc8e3b6db8281af445ab498e87a70
> 
> I would not expect the core to have a "Some devices insist on streamid
> to be unique even for not enabled streams" path that gets inflicted on
> everything unless it is clear that this bug is not not limited to this
> one device.
> 
> Also, I expect the workaround needs to be re-applied at every Stream
> establishment event especially to support TSM implementations that
> allocate the Stream ID. I.e. it is presumptuous for the core to assume
> that it can pick Stream IDs at pci_ide_init() time.

True.

> It would be great if Linux could just say "the maximum number of
> potential Stream IDs is 255 (instead of 256). All TSM implementations
> must allocate starting at 1". Then this conflict never exists for the
> default Stream ID 0 case. That is, if this problem is widespread.

Better if the PCIe spec said that but yeah, this would do.

> Otherwise, at pci_ide_stream_setup() time I expect that the core would
> need to do something gross like check the incoming Stream ID and walk
> all idle streams to make sure they are not aliasing that ID.

This is what PCIe spec suggests doing now imho.


>>>> And then what are we doing to do when we start adding link streams? I
>>>> suggest decoupling pci_ide::stream_id from stream_id in sel_ide_offset()
>>>> (which is more like selective_stream_index) from the start.
>>>
>>> Setting aside that I agree with you that Stream index be separated from
>>> from Stream ID, what would motivate Linux to consider setting up Link
>>> Stream IDE?
>>>
>>> One of the operational criticisms of Link IDE is that it requires adding
>>> more points of failure into the TCB where a compromised switch can snoop
>>> traffic. It also adds more Keys and their associated maintainenace
>>> overhead. So, before we start planning ahead for Link IDE and Selective
>>> Stream IDE to co-exist in the implementation, I think we need a clear
>>> use case that demonstrates Link IDE is going to graduate from the
>>> specification into practical deployments.
>>
>> Probably for things like CXL which connect directly to the soc? I do not
>> really know, I only touch link streams because of that only device which
>> is like to see the light of the day though.
> 
> CXL TSP is a wholly separate operation model and it expects that CXL
> devices, and more specifically CXL memory, are inside the TCB before the
> OS boots. So there is no current need for Linux to consider Link IDE for
> CXL.

Link IDE or any IDE? I know very little about CXL but some of those 
device types are not just simple fast memory but also do read/write 
from/to that memory so they cannot rely on CPU memory encryption and IDE 
makes sense for those (especially Link IDE as there are no bridges, or 
are there?). Thanks,


>>> We can always cross that sophistication bridge later.
>>
>> Today SEV-TIO does not do link streams at all so I am with you :) Thanks,
> 
> Sounds good.


-- 
Alexey


