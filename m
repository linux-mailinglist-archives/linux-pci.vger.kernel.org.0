Return-Path: <linux-pci+bounces-3559-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFED85707D
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 23:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44B391F267A0
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 22:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAC513DBA4;
	Thu, 15 Feb 2024 22:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M4ag6Gr3"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB09513AA23;
	Thu, 15 Feb 2024 22:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708035732; cv=fail; b=QoUj1n1sc/2Z6Npi+teQPJ26lOhMYIw3fyA24cnRWLP4AtLgxZp7obc6NmxY2uQJ4tUbrBGeDnRtrSN219w/dCbARbSfQT0BRGGC0ypyuftTitdLwZyES1+6rBHJsk93u70IT2s+KoKI7oGNyoebAm1D8jQHd5CLVFIVqMiS5Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708035732; c=relaxed/simple;
	bh=7Go+GcUy346nDjJAvu51L/2f18DtIeC5jyY3bgZTQ3s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aF8f2/FFC/QL9h7NNtYDLOOCzv/ebpl/U4oHn0TxeiA/sTsZhsU07X6io88BEGg2170ElxAY8r1OSi4MImL7Y3FVykyPICXCrKW285Bu9XsNCKCwfTOWcGly82DgsAWl5OOv5WXz06tpJg6SqITFhjAtJ7rUV88x4r4ZO1MAG6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M4ag6Gr3; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRbnQ0LUBL3FfDd/Y07HPYUznBv5b6qyVuZ1SxuNVr3/msdFnzhRHNsjyrodXjdJtzATMk8c59CvWN6h+hmGPO558QfslVab7LRNzjDcxPyHY8kuz/sbZLGbtOd2qpKEoxeJ40hqgcVsCFU88JgFQv27QBXTZq6aJ+U7hKopBr2LUtLI471KbtSbDW4nsVBSNmVwYhj/9rl3w7u0QNbSViWo2EqBvphhYCfrDTwHPYAvnI5dwBm6dePTq6NnsvCmpxkjKxfGG2+Au4/24Q41sd2zWJBcjf7hhEBYiLnJG8eFly8rLFDLflFnBlkiXmzPT57adxfw3zIUnXZnKy36GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6B/3yIaVqmK2jRgRsnJoWbPUceYHh1ihIhfUwk5MD+M=;
 b=C8Vf3sHy2u5Peu6yvS9zJrUV3HeEOwdJBR/H5bOBNuLKRZru63JcwWK+xojqOvy9f79rj1A58V4h5YO1Gj8wFtwla7EbvVXBjg59z1XNuMZJT7Y/TorWYz1P1ddNLt38ernMstKHtG2cXcf0nDVhLbmsqe18Ajo2Sd1i6hI9+Vz/K+mHa0pIjM7Qy620CIgA4mVWOlOMUY/2JzyObLeQJxNy5BqUm+YNPSY69fFh+XtjbnS31vX+uPwmW10QBWgjEAoMy2ROD0riMd/xzWYGRY0M/WjTFj/6Q1dSLB0Riq0i/nrNMJr3eYwgXQXlY/blTt5z3J+KvR5DV8HFsZ5bAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6B/3yIaVqmK2jRgRsnJoWbPUceYHh1ihIhfUwk5MD+M=;
 b=M4ag6Gr3RgYKqPQ3aJe8svgu34uZLJDSplReQK0wW7wY+e4sIo2OOHVCN0oKhZ1aiGf1nAcpNut5IMgNXWGFg2gWazzuf9Z4TKOrM6VOUQNY1emQYVBGSHDiJW6ku2U1Se+PLnkcqI1840rpJmPSW58SyvOFSC7+wT9t3eeKSGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Thu, 15 Feb
 2024 22:22:08 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458%7]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 22:22:08 +0000
Message-ID: <fb3eb4ac-c265-47dd-a608-7bf423865e71@amd.com>
Date: Thu, 15 Feb 2024 16:22:07 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/6] pcie/cxl_timeout: Add CXL.mem Timeout & Isolation
 interrupt support
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com
References: <20240215215735.GA1311372@bhelgaas>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20240215215735.GA1311372@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0066.namprd07.prod.outlook.com
 (2603:10b6:5:74::43) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|MW6PR12MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: 4661cfdc-d712-4c68-1c12-08dc2e748bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0A7cE0SjocfxlbMzz8HssvOLccxC+p2SSm9OFsmi9qDjUeG7tQWxadykpKt4ptjNwiXRrZUM9vEC2mEFE1EgvaO0wNQn/CisR2SsA6bhkX3zFb2+tJ7xj4oCPOvOsJoqv2V2IpbHFdGF9g3IqCtRoPQ3aD3pB8iiQgjrVq3ijh5U7YSlNxcGYzQv/btcu6IaCcLJH3Po0yahEvLQWhxarj7uzzOZL8fb8WTukX/NY28i/alcbI4OIN+3pFZfxJHMtc0t5bUAXOyY6+JygImbjD+moU1HyDDapxhp/3ostt1+LE6asZ5l37GPGp2i8So97zWdaGp7JtcC6lTffVQv+g4yTcc7AaderkdhCzBXEwmPIdz6dI5DxOXabeG3bTNtQ/FeWY103PdEca5D0KWh3P0Z0seGPryWEoslNEP/ewZCdJmwX2GykNyStzSSaR0ffS9USLuYdBqa5US7pPwQ4buSMMTE7Gd6HDRQSvmouz//ZBYGqF3MijEORbM0S19b9Ou7z3wX/GMJoEnD/LmewPWSvDdyft9axUVIWMIl/jib5kT6sGxtsullGCGI9mVz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6512007)(478600001)(2616005)(41300700001)(53546011)(31686004)(2906002)(66476007)(8936002)(4326008)(8676002)(7416002)(5660300002)(6916009)(4744005)(66556008)(66946007)(6486002)(6506007)(316002)(36756003)(26005)(38100700002)(31696002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkRVOEJGQnFoMmxveUQ3YjVnd2J0dDU0dzNMSW5HOTdrc3UxU1J1bUhkYmpF?=
 =?utf-8?B?NklETEZQUHBVbVVkczRZREJ3MU10SEs1NDFSOHNhWDF5RWQ5QXhuR3pVdHdZ?=
 =?utf-8?B?RWN6bElsWkF6Z2w4WkliRXBEaUFOd282YU0xRHg1L2k2VUpvTXRZaCtFSHJQ?=
 =?utf-8?B?bVhmNzJpdExkL2p3bTlGdStZcGpRdGdWTlJOU0VPTkZCR1JkMzRmSFhKeTVO?=
 =?utf-8?B?OVdVR2JOelNxbmUwTDBKYXhvdHRtYS9VMGJ4NmtnbGR6ZWIxUUpTZjBDeDNl?=
 =?utf-8?B?WnQ0R1pQRHRzY1N1cTFHRmVJNVV3aGJmby9LWG5GdXg2OWRyZE9VeW52bkJ5?=
 =?utf-8?B?L3ZGRDdCQjBxRmhkdTlSbnZycXhrSVNkOUthM1Z0ZS9Ud1pMaXVJcGUzdWF1?=
 =?utf-8?B?YVgzZmx5bnVkSzNLY1hFakZZcDR0Sk9mTkdFSGdlbVc5ZXV1MjFCL214a1E0?=
 =?utf-8?B?M3orN24zYU5CaVEwVEVybkplbEdDRXR0SHRyK1Q3SmpWNEFjeXNvOVZKdml2?=
 =?utf-8?B?Tk5SZGtkd1M1SlZpU0ltR3B5czVhVWZBcGRWZWlPWko3VkpUdFlyUlQzZTg0?=
 =?utf-8?B?VWxrK0s5cmEyZHpuaHgrWW9ieVFBUXlIclpVUTVYUjh6ZlBObUNMQnN5U1FB?=
 =?utf-8?B?KzZJNStydVFnR1dMak1xQkYrVWRiZHpTSjZxNTFia2lKN3N4TGxUaGQ4RWsr?=
 =?utf-8?B?NkZjNzdkV3JaYTQzNXBzUGdpdXFKc2JEeHpyVHVaQXZycGZaK0dGZ1BWWVZX?=
 =?utf-8?B?b0tmYnVnZDZPL1Y1TWJBMWpWU2ZGUnJ4UEtqMUxqZk9ub3NCVllmR3lQTGNM?=
 =?utf-8?B?MGswbDBESXhFcVRnWkcwemZsQXpkci9ua0RDNE1wVW4yNGJjaGFXaVBEckYy?=
 =?utf-8?B?dG10L0ZVSnMyRDJEMTFDZk5GNFNad241b2JtN2t5dGd6SExyWVM2Q0tsN3kx?=
 =?utf-8?B?K2svempBL245Wkg2MjdackhZRmNYNjlwajNIYXFjeEhybitlWjMvUW5LMnVP?=
 =?utf-8?B?QWJxM01ody82TWVZclVkZElBSVpDRGRRMHdZZ2hLM1Q4MU9IR1NjNkJRN1Bi?=
 =?utf-8?B?dWRsSWpXNzBCMWFqVHpvZUZELy9aeHh3R1l0MHBZclNQUWU5Q2hyQUtKdlZZ?=
 =?utf-8?B?RktGdExqM3oraEt3dnF5OGUyYmNmS3puRm56b3JBT1JWNFhaY1h0Ui9jdmsx?=
 =?utf-8?B?cC9hOHMrZUw5amUxY2tRMzlVWWY5ak9uTEYydWpMNlM0U3ltejhGN3g1Nm1t?=
 =?utf-8?B?T0crZG5iUUJYQVl4WjV2ZFIzc1dwOGRLZTBEVHZvdmYwMU9QSVdiR3J0Wi9T?=
 =?utf-8?B?L0xGdzFodEd5ZjVjRzhyNHBUZnVDTEVBZ3puNnRndCsvVEJRY2Uyd0FTM2xJ?=
 =?utf-8?B?K29WNXFDNmt0ZXcxeEtHYU5xUGt4eUh6UFV4a2JJUmRJcFdXS0dzSTBzQzNi?=
 =?utf-8?B?eVNMVDZhQW05M1BYREgrTjV3TVVxaU1tQ3Jqa1pHUFpHVEFRdFpsZWdxcXU1?=
 =?utf-8?B?YkptL0pUVXk1RUxKeFhScGJTSFZmeDlncHAvelIvT0pPaWN5TmhFQ0JqWk9P?=
 =?utf-8?B?L2ZEOG93dDBMU0E3WEl2dnhGYjE3QVhoZGd4ZUV0REZ1dTJSUnQ0S1F2K3U5?=
 =?utf-8?B?UUV2dGFKUnFyNmJsWml2T280NWJpVWhRVXhTWU5zdlpEMWRqZmxja0hoMkM3?=
 =?utf-8?B?MGc5S0N5Y2xYcGxUMVFScVdEZERKekZnRnRHOUYzaWtLNlFRNWZqV2lWbHd4?=
 =?utf-8?B?eUJmL2xLeTdiYlVhK3VwV3JqbW5UWmtUS25lazB6QjZUVWR2V1lGRHFhb3pu?=
 =?utf-8?B?amFjRXVkYXc5ZzN1WUd6bFZxcUdneGNqcExrcFF1cFRMZlpwdDhqbGNTeVBy?=
 =?utf-8?B?Z2JGR0dkcjFjN0ZVODY1T1NtbHZwOEw3eHE4U01nZ1l5c2ZWR2tRYXRiVmVu?=
 =?utf-8?B?a0hiYitRVnNsNkNOdzdDcVFlNzVqMTJoaU43bGViSml4VXJYQldtQlpyYmpE?=
 =?utf-8?B?SjlMczVoU2dLZ0JjT0FFMWJZZ0twS2lPckFrc2N6RTRmUXRIclBrNmVvRHpY?=
 =?utf-8?B?bHRuT3BXWmVZQ2RFT0ZQaFdOa1VCdWQ0ZFd5S2RpekMwYVdXaWVyc0pEOXFF?=
 =?utf-8?Q?FcXgIeUjSd8tE3/fdQHpvu6/D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4661cfdc-d712-4c68-1c12-08dc2e748bf3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 22:22:07.9924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxeTCgV8KOWEcOCL2JcV9fi5JGVfZPGc8Xlgaog0KQN/4NsjCEq9G7xaZgJEacYmzmyMLOIU2G8ZwQTeKqVgNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916



On 2/15/24 3:57 PM, Bjorn Helgaas wrote:
> On Thu, Feb 15, 2024 at 01:40:48PM -0600, Ben Cheatham wrote:
>> Add support for CXL.mem Timeout & Isolation interrupts. A CXL root port
>> under isolation will not complete writes and will return an exception
>> response (i.e. poison) on reads (CXL 3.0 12.3.2). Therefore, when a
>> CXL-enabled PCIe root port enters isolation, we assume that the memory
>> under the port is unreachable and will need to be unmapped.
> 
>> --- a/drivers/pci/pcie/portdrv.h
>> +++ b/drivers/pci/pcie/portdrv.h
>> @@ -10,6 +10,7 @@
>>  #define _PORTDRV_H_
>>  
>>  #include <linux/compiler.h>
>> +#include <linux/errno.h>
> 
> This doesn't look required by portdrv.h.  If it's only needed by
> something that *includes* portdrv.h, I think errno.h should be
> included by that .c file instead.
> 

I agree. It's a remnant of an older version of this that had a declaration
that needed it, I'll remove it.

Thanks again,
Ben

