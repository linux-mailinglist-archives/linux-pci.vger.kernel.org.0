Return-Path: <linux-pci+bounces-3487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F26638561F0
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 12:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67BD91F26D7B
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 11:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FA36350D;
	Thu, 15 Feb 2024 11:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cwAx7h/d"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD7F6A339;
	Thu, 15 Feb 2024 11:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997456; cv=fail; b=psJQRTlLo01ifMRGJYabjxxxYPcwPwJFn1K8Vddrv6Jh2L84ktd2hpWC3SzI5HrK9O5Q89yqejH0JjpUnYsYib2CPw/DGxULXB7ZfwlYs+mC2ugLOYGC3/5am9JaEy5TnQ4R8/TtLjT5PPTG/HILxQMynnZJYxiw6YibrOqvxVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997456; c=relaxed/simple;
	bh=e1rcC9hoqqBX6HcZW2O9T19mr2d8EF0XZp7iOIKrKF0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=maMi2Sj6lcj7+qy3PYnMhZ05Vhe1kzfB5fbYaukwoPLZumY/k5wLJOoerFUe4Y5IbvhJXjbMZO71KUKhL1lfEakCFFEesk7PGS1Eav1qwwpydGvtpgNX6UjkmyZFpKvuolmvVtJnZt/hjWkgoV7NT77JsDC6a5ZM6dMU4rj8oAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cwAx7h/d; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZfqzhFaHR4CIOTNkojGyGipFFK1j5pKxwY5aiCNcAV5GkI4OFSS3V6a312WGhGlpl00G1y/F7dBRPccqiTEH4E0LRBqwk8BHZDPrllA5qhZ6lDCkTgLF5AL+P+/5Y19BqzmOTnxoRe/mFKKzQa56GzFCfmLrzMVsSVJGq3GlY2n8DNXskdLroHs7fG8Big1/hwpSt/efFF+KV9lvMcRvqtwdywL+0XT+E9sHImlS9Ie8AWWz90kXgGaK5BlsXe1iHCA1rCmegmzAThNmc1GBmr5eQ8Q39BWvdWTRVq8snIohnyz9l7ZCI1P0rtbIBY8T788TDBugBH6Lc+u4yfX8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPEvuG54xdujnrSUc2pKlKH/UVyP5L9UPcoONmar6uE=;
 b=lEurXjD0PoITVC9/+/otLOMxPDhFeOOXP7ifYQjAgmbka4XoKWlz4Y+86Wjx/O1OawnJnGT5O3PAyniu9mrxSLlMAT7lZpe4o7DZKxfZag8mB3eBOUq3fOzTrt17e+SlOyjPtJk1Kmd/OyWSMYgGrWfr2u1/paLXYbM2XBKSr5471k93CA0jcsVz08Cy27OcWJvYXnXylMQcMXvB1Z6wlbDPtKHO3wCDMK84lxJjAxjMGbx0YiH/BRAa//p3L3u9mSa+3Sb1ac0xqv1OxgcQpyhHB1YL0DqqcKf3Xiu8UdGK5HVTLfEtYoF03/AQwPY983FsA2PXND3A2VyIpSYUDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPEvuG54xdujnrSUc2pKlKH/UVyP5L9UPcoONmar6uE=;
 b=cwAx7h/dJYwQVd1cgVQqd4X6tb/IOrj75y/qFmw82h/XQzlg3ROI2cSjlSfkq9TRTbF8sNA06aPgwtpn4HNYw0/7SDf93Qdmv3PjxDh4DfuErmQukM7Zu9dC1MzC1N5YFlWmUAAm5Hzt+Dt2xJtMfzF1ql5kaPvmE6DnPFRxPNI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Thu, 15 Feb
 2024 11:44:11 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::c167:ed6d:bcf1:4638]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::c167:ed6d:bcf1:4638%7]) with mapi id 15.20.7316.010; Thu, 15 Feb 2024
 11:44:11 +0000
Message-ID: <30824dde-d504-43ff-8f2e-ff948dc800b7@amd.com>
Date: Thu, 15 Feb 2024 22:44:04 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH kernel 1/4] pci/doe: Define protocol types and make those
 public
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20240201060228.3070928-1-aik@amd.com>
 <20240201060228.3070928-2-aik@amd.com> <20240201065040.GA31925@wunner.de>
 <895b31de-f7f8-425c-870b-1524be21c688@amd.com>
 <20240209085216.GA15263@wunner.de>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20240209085216.GA15263@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYCPR01CA0048.ausprd01.prod.outlook.com
 (2603:10c6:10:e::36) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f886133-a7ca-48f9-3430-08dc2e1b6d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GHD9yCgWCfkI2OfUaDb5WUS2JkgfN8J2zB2u7uchrcr4pMctrYYiYp9DEwXVWIUFS5mK4ssm1UxKs87W81Q2PdwRm7k+8kHFYPmN0pEuudxrFTiVgpvTRKIMXQqv2mkKsHt2KrFuMp5QhoheYy1r8OOjpFx/il4Wm5vAdGZs7jZSCDkdQqKcqOuKWmGes2FvOMBkSdhJhboHqc4/PYZJcPxHtBN8EzFs7fFQe34zeDPhlOFyOYII/0exBArHSOZyaywQheE0T9WVzM3X6hcNAUeA8BD3W3xB/Vc9JoAYwQ5jFBSX42kOvHU2f64fYBNovDIKvEUBX1l3yzGVsU7JfrGmQJNs17E/gves5qNNORB8p8f+k1wJlJDGihK2YIcmSKosLt7GKk9fDANUfiw3186cO9TFKaobcL28LjpBcdsoqmXMCk8H873e/xgnnCITCbXUEzA98VSWvhKkKzTfsH3EHL2IWg3UUG7gWt3IXhdB/Axawx+v84lM62yXmb8O+JWCoW20X1jfJkO2wBAj6DpwfS1QjboKa5M4Uuu0SRG7lTcLLZ1kMYdjmuvgXHKg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(366004)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(478600001)(6666004)(6486002)(31686004)(41300700001)(31696002)(4744005)(5660300002)(2906002)(6916009)(316002)(54906003)(66476007)(66946007)(6512007)(6506007)(53546011)(66556008)(4326008)(8936002)(8676002)(2616005)(26005)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVlhYmhDUHBaMHdHeERCSXVhZFZVSm5tQkNsNFNZczdudGFyb0dwM2xObmk0?=
 =?utf-8?B?ZDZGSC9JQXRYY0FIdHl0ODF0dGNwajZqZDB2dVN6SmFrVXJiNXRtTk8yalIx?=
 =?utf-8?B?Zkd6QjhZNysvMGtQcE9SWWUycWxnT3NmdGZVU1pCOCtNbWsxcHNta3FRZlhZ?=
 =?utf-8?B?cXNObGpoUzdxTktYZ08xWmp4MVFJVEd4L1dkTnhrcjNzWEMrN014RWpRRmZw?=
 =?utf-8?B?TlBNYSszc0w2b2VyT1p1SGhyYlV5REhhK3ZNSGxIWndDemVQSEQ4ZXlWajBP?=
 =?utf-8?B?RkoxREtmcFpJZlRGWGdzRWZTbHB2SHN3ZmxHWHA0dTJFVlYxNkVRUm5PNEFv?=
 =?utf-8?B?bFYrUzdCVnRkTXVhaTNRMElIOURLM2tLVFFpcHhFRTBIRGxXa1Q1WWYxendD?=
 =?utf-8?B?UWZKNzg2MlNUOGNKUU15N015SDZKUlU4T0ZqMWNnbE5JUDFZUU9mK2grVFpj?=
 =?utf-8?B?eWMxeDJBa1dLSGNvVWFiWTBRSnVVcm44bHFpWDQxV0pqQUl3T0tJYXdZclA2?=
 =?utf-8?B?WGZzcEQyWDhmTDdDb2t0QjdnNkdzSUt0b3RBRkhZMEJRYzRnVkdPdGdHZk5s?=
 =?utf-8?B?Nml3WXQyakhUMjM5b2hHRkVaYTEwaTV4YmZmbkh0NERHZXFiVnpzcWZXaDlB?=
 =?utf-8?B?Y1UyeWxadllXSUxqMkVtcWZQaDhFc0hkOUNqa0VpTzBMYUxSRGZSQkdmTEVD?=
 =?utf-8?B?L3ozRXJZWXc0elhTemVjZE1lTlBMTFU2VXo3aVpGQ0NUL096TFB3Mjc2VFJq?=
 =?utf-8?B?WkF0TjdVQkQyeVdSYWpnd2tQVDRvdmhFYU55WjZyYktlcGlNK2hydkhIeElR?=
 =?utf-8?B?STFRbzNSRGUrdGJKRG9JUS9SdHdVRU8wOVBFWUx4cDNTTVhCYnhJQjhPYUQ2?=
 =?utf-8?B?Nyt3cEx3ZHNGWkV4UGdpaGZNOVVYQm94R1ljZTVkNVdDdDV3ZEE4bFNydnVC?=
 =?utf-8?B?cms0RGJNK3JpVFN4RGdHcjhWNkJ0SE10VjVxZStoTlVTSGkrVGtVZVNjbGZI?=
 =?utf-8?B?c3dkdHZHTVRPMlM5dnFycFpyS21IOW44d2NnaFd0aG8rNTNocE5weUJwZjBv?=
 =?utf-8?B?U3BRVTdlMWxpUjNkTnRVQmxGS1VWQnNBNTV5N2dwNkgrTkZtYld1aUpoYzJy?=
 =?utf-8?B?d2RWOWxwQjhSWFpGblUwM2xZQitxa2I3aURBV3k0U3MrV01FVHFRcmNSNnhF?=
 =?utf-8?B?V1NTbWtUcHR0a0RITzltTDJBbm1XZHU3RWpyNmFrclZMVkc4OHFvN0ZJNER1?=
 =?utf-8?B?bjVPL05KRXEwRGlHQ21vMnhTbm00Q29GTGRiZW4zY1lqS2cvalRTbzdBTnJv?=
 =?utf-8?B?VTFPSVFVN0N4U0NSV01IK3NDR1JWN2VYK29NM1Y5TmdYQ0hZYXlHbGcrdXM3?=
 =?utf-8?B?QXg0bGZhQ3A5MnlJbFFqZmN4cCttY1J6SGZxdE5xZFovWHhUWkNrdENrWm9E?=
 =?utf-8?B?YnFvcm1pRXJSSzJoaEVRNUEySmFGeWdoV0dxNmFkdWt2Z1BTMWV0dFBBQ0hC?=
 =?utf-8?B?dm5SUTN1VDdRVHZWL3FXenRDeWdWbVU1OUFSNkxuM2hKY29MQjFTNEtCMjc0?=
 =?utf-8?B?Uzl6VDFEQThVbkxOVWQ4dzVDakp6aVZWUDh1d1ZxQllpVUkzbDhJZ2xSanBh?=
 =?utf-8?B?ZC9RWkRWakdROGxqZzM0b0hrV1h1QnBjRHhyelFXU2ZlSTh3YXZGVFVxSDlE?=
 =?utf-8?B?aXJJVkhacnVLcUdEekdjR1ZwdmNZQy96c2F6Q3lHVVpldG0ybVI3b2xQVWFq?=
 =?utf-8?B?Wi96ajRmOHVad3c4VWpsbGJYNkpJbmVBWXBrOTFzSjl6M2FJMW5xdFhxdndE?=
 =?utf-8?B?U3orRnZ2VWhSUnIxc3BTVXY0S2lhTXhMQ0dTaFk1aVFJdGd0azNaWDZySTB6?=
 =?utf-8?B?ZXJHMUJsbFV3MlZtN2NJUHoyTldQNkpnVlZpSVJydUNMRkQxTnlYUEZLczlv?=
 =?utf-8?B?Z1BTYThTeCtYeHp6aW1LVUFXZDRwVnVodWh5dHhybitnaDZMeHF0VkNBT1JP?=
 =?utf-8?B?eitMNVlId1RXWkUvT0JrMEp5QlcxcDVsQ0RaMC9OemtWQkFkUEhTa241NmU4?=
 =?utf-8?B?MUg5dnRZbG1ITUREM0t6ZkU0L0FNWFZZV1FuU25IaW1HVkhvdXFLV21ZUjhm?=
 =?utf-8?Q?qbp56NapuzqyMWLdbfOn28x9I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f886133-a7ca-48f9-3430-08dc2e1b6d1d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 11:44:11.2694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61xAXZKYHu6eoLf7BQvxb9hfJL/h1hiYxnEarcFG6Onlf7UW0Ajd3bz1zd6s5UON/cCZc03Q3JP8+5GZmJcR9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302



On 9/2/24 19:52, Lukas Wunner wrote:
> On Thu, Feb 01, 2024 at 09:16:37PM +1100, Alexey Kardashevskiy wrote:
>> Or the plan is to add pci_doe_secure_transport() to cma.c and force everyone
>> use that?
> 
> Right, the plan is to pass an additional callback to spdm_create()
> which performs a secure transmission.  And cma.c would define that
> to use the separate DOE type.

But it is no use for the TDISP case which won't be calling spdm_create() 
and will have to define CMA_SPDM and SECURED_CMA_SPDM, again.


-- 
Alexey


