Return-Path: <linux-pci+bounces-4796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABD087B5F5
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 01:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2491F22FF1
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 00:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BE1EDE;
	Thu, 14 Mar 2024 00:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2i0YnsQ+"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A571FB4;
	Thu, 14 Mar 2024 00:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710377971; cv=fail; b=fClLpuvPBB6/KgbtYtQYmVcvRbJUJaShdUX+UI0hVKa38OGjm7J+ifqPGglGGDx5ef8fhmgYhb5iW6tOicf0odVjtRLbdcYxOubYpAa0nPSo/5KrdLjfLYRjkTulh3uqskave+EbvNycgRG8TMuCJzzaqB4jF7c3VjP50f2Mbkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710377971; c=relaxed/simple;
	bh=6cEKniRX1nFwb86J0xAB7zfHDImKbUyd4N3xC7Giewk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BWY6sl9FFdwgJiZ3RJ9WXaul3J+9rkZxdzVbVTqZMk2XE4BytgMM0B/2j4yahntY5k8zbmUFBru9yrBAuuMDHBWReREmIG633YzK8UY1Rr8baSUeBW0YHuD07KNIlajzrhNBydgX1GT0SXdiHiZtRf1L9vmT/BSqKrLy4ZMZFiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2i0YnsQ+; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvxI9yDlA89dSRUgR4dgd7MtBG8aztHpoP/clw/iP/C++qFi+dCMxa4wN56fsKOKjRzwVFBVMphk9KYmTliyljuS3ZJolOmj3h8ASwppntXu/RGLW8R/iwdDm/fURMkexINMnxAW97YR9qgSGhDfHhYaDoj95dr7GzkdLkfUEyn8NNYqJBGIrfAxMu12yA/8zpcGX2pDs1UALgSIhkrqVhYaWnqv/4lP0l17ETEW64d4SBkM6YBZfVGPxg4AWjKG21wY3RHjcqLvmsAEh+/fZhgzftkTmntrZqqM7AGsTNPr/6vwUhQb6vhazdSUBrOYgUStlwgmi021HzGPgN+s8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYchX5B6E2+inJBhcJU5LBwWPpey6AdzFMV7mR5d/A4=;
 b=R1p0HuM9IhMuwUFH3SfTxLEWZg40ugwyfzozJZqKsGWCXzWP26szcDhkkpTmOVdP0jYDBJX2h2PZiAHrwk6gR1M8B9G2xvWR2mpVnVn3e4J64eEVS/XMl9sCeMMw4uKwZwr43Oo2iAzByBBaH30p0zUdI7u/gXuyyXMiHZX7/gwrHvnF6H2/wQhVveCF5JhqUdf1FjdALjvWCVWogwjc9av4Uwu0jkSnJWq82372s1NFB9Y/FdP7ubvpiIjJKuZmWB21r/ZOzs2eknUARkyc0S0jQ/2Rce88KG3B+9o07GF3zRfc/zTqxZVFlDSwLAYZihop5VYKRPD1zz356FkKpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYchX5B6E2+inJBhcJU5LBwWPpey6AdzFMV7mR5d/A4=;
 b=2i0YnsQ+Xgu/2LI42F06v0n6oB0AIhofzylw4E5MLlgaIvrlGd6sAsxuA7dul3ey1MtqIcP44+doc9r/0xPTjL/Ev5RloEBmRS3owisNXXIOSA7BtKqVqQNIdpPh8nREocik+hJe95A13L95kho7xtoyraNjGl+r6J9eoF2DnCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH8PR12MB7422.namprd12.prod.outlook.com (2603:10b6:510:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Thu, 14 Mar
 2024 00:59:25 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::ed15:6173:2f14:f539]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::ed15:6173:2f14:f539%5]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 00:59:25 +0000
Message-ID: <8d542410-d8e1-4243-939c-6ce7743a66f1@amd.com>
Date: Thu, 14 Mar 2024 11:59:18 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH kernel v3] PCI/DOE: Support discovery version 2
Content-Language: en-US
To: Sathyanarayanan Kuppuswamy Natarajan
 <sathyanarayanan.nkuppuswamy@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Lukas Wunner <lukas@wunner.de>
References: <20240307022006.3657433-1-aik@amd.com>
 <32ac2ee6-26b1-4f37-bd88-db1ef2a31267@linux.intel.com>
 <16120a31-c3d6-48a8-9355-7b063e28d242@amd.com>
 <CAC41dw9x8H2m=YB66+PA-GwiVkpCyT0PobdWvFXLHpAsQOE0ew@mail.gmail.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <CAC41dw9x8H2m=YB66+PA-GwiVkpCyT0PobdWvFXLHpAsQOE0ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SYBPR01CA0156.ausprd01.prod.outlook.com
 (2603:10c6:10:d::24) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH8PR12MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: f0ba8196-64d3-4c95-b81d-08dc43c1fdd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZKayGZuiBkumB24FhBQxTaCJnh6kGo+JPI16oXxQXNOELLCcFJvksRYG/rVNoA7cUOJQlTGk8+ULnge3/adB8yJbnuaMBPfSB0PdrsoyTcHUrC58fhQTe3HuPdXifo3Bdju6pTwgLQBd8X/ZnnQu/W6ZWFd/ZUGfRk7MNZo5QGjNFU47E3Nf5iUXJI0rO9o85bZIVVsRlNiNxBNgyPDBMUqjYGf+d+BQEO9vkvJcTq483G0bOF/ALscvfi6r+Uq5QkmWHu3FAAU/RpCS2tOL5Fkv9VblLNIcKUSPfjvD0UhgEiow0tf7b6XS/DB2DYCs8Y5WX1uiaVuvLyaDf01KzAYBNIphAN5jPdZctl+RG90ss41SD9Hy/mXbAvkvAOr4+mrcFlJ6O/LyysARWhEPDGngtzuOPtOTpsWm6i68Hi11VU5yMgxLYHLuSnggMxuAYP1bHmMQFc4+GtArEMaJubc+VaZh6JRXVWEU2VJscel46443NwU+QrA6b1y2abTLUEKQmu6eM/KP5wizHXV5Z398uCJBWfI7Bum16Ggx/ys6n/BftQV4cZHFMjTKNv8zZ4SC4jLhk1kvsU8ESe7eEtNwweyCSu6tPP6LJaDkAkgXNgYmER1HGtdDvPf/42gyznCEWF02GhpgXx30LSlGF0gkXjiTmmlj9jZ1gVunIsY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1BGK2s0Ulh0SXBCKzdUTCs0NWJSM1k5Y3doNzZ1R0xsNGtVRVJEbjZTaGY5?=
 =?utf-8?B?WjBDZW45Z1YyQWgwTDlXejhpR3RJcWo3MXVIRDNla3BGT2Y2dDVwV3BBZm0v?=
 =?utf-8?B?T0djazk0cWp0N2xENU5kanRtL2krbjVxQ2lMc2VVY2RBNk45Q3JwcHFTZHRF?=
 =?utf-8?B?eVBBYlBINmU0Qjk3SEJjT25DR2FzSkZpRDg3NU56SVNQbTJIbGZ1R09kbUhl?=
 =?utf-8?B?cnpYMTFmR3lYMEsvMlVsSkNOUnhDOFJhUlBHeTdFSUR5MVlQUElMQmZZd0M4?=
 =?utf-8?B?NGk0dDBEU1BnSEFmVUk1V3d0bTNkdDlnbGxOdGpJRDhtVDlzMGw5N2FlMXlG?=
 =?utf-8?B?eHQ3WmR0OWZ1aGRIUThyTTQxNThQKzZ3UEtQa3FvZ1hTOUtzSTY0VmZsOHNt?=
 =?utf-8?B?dDhRMjJ4K0hMMEtKdW9PMDg5WWpTZ3BreFIxN29PcnlGVVhybDV3YVNvSjBk?=
 =?utf-8?B?c2hMMU1PRVJjL0tmK3A0WFV2dFViUzhNbDdBaTN3YmpEcnRka0ZhQitoZzJD?=
 =?utf-8?B?ZTZSUVpxUDRUblNYOXFVb1hvV04wVGNWeldHYkRhS08yZEsxNVNpalFDZ2hF?=
 =?utf-8?B?SytON05CQmt1WnhBVk43L3ZENkxuNFBaNVBXN2ZITUt2NktsZW94YVJvN0Ey?=
 =?utf-8?B?WC8xcEVFdFVCRHJhMExzNDY1VlVGUWNxeE42Q0pDUmU5dHJmOE94cjNWSlhV?=
 =?utf-8?B?ZjY1Z3R5TU54cVg4RUpiUjJldmdZRzBjREtaeFUzanp5L0dBY2MyYmFPWnFF?=
 =?utf-8?B?OW1WMHl5NGx4VTRGNGkrYVhmN1hkWFE2dkU4bFdPZTlVQndTOXNqVnpaTDI2?=
 =?utf-8?B?dTVESHZMS2VDQUV6TmhDRzF6UWZUdjVJTWNtTTB2YjBaNFo0dDlaa285bVpN?=
 =?utf-8?B?YWFRbnU2SWxqamZjbnVFOUlSc0pSeTg1cTBBRTFkdjFLSEU0Zk5wL3UrVjlu?=
 =?utf-8?B?aG5RbGhYZWJxSEgxNzZzRXVpc0t2aGo1ZGZUdTV2ZXh0UDByT1pEdmlZc3FT?=
 =?utf-8?B?SFhxVSszTVkyZ2pXT0RWN3BYRnNxQWxTSlAyZi9oWUhIaGtkRG9VYUhRK3ZV?=
 =?utf-8?B?d0pHTFEzU2xIT0RYN3VKVThRSWlhNGtnbUJkY2ZHT1A0RUg1TTBEaHJtUmpu?=
 =?utf-8?B?SElpY0hxV0IrbHNENmszdFNVSFovQTZibnhNbTJCNWxNcFZ2blFFdklvckZZ?=
 =?utf-8?B?S1pWWXNhd21JWjBCSm1vQVlHUEFZZWFzQmtyejlZT295eDB3bXBJeHhYTFBo?=
 =?utf-8?B?ZGpjNFlxTHArSEN4bkJJdThjUTZjbWRNNkM5dWs5TU50L3lNNTVTNDY5aFpl?=
 =?utf-8?B?c1FpVDZCNWJQL2w5VUEvT1pzUXZrOFM0aVhZWG9UQkx5QlA2R0F3Wnh4Z1Jx?=
 =?utf-8?B?cjcrQWRnN2tvSWYyRlBYb0FuQzAvUFVUa1c3S3BJVTRkbStadTN0WERzVHJm?=
 =?utf-8?B?YzUzZkN0WHN3MjR4b1JSUjNpdVBTUDlodzdoM2ZWdUtUS3p1MVpnbldZTDZ6?=
 =?utf-8?B?QURia0hiNXJoUXMvZVlGZHA4cGlTRWV3SDZFZ3lpZFJCMU9VOEN0Q1VCOFJl?=
 =?utf-8?B?Y0RFL1FwTG8wdlRNdlZGeXdQNE9XVWhQeGYzalFpcC9LNGx0dVMyMGJ3U2lm?=
 =?utf-8?B?Q1NKY1VDQTZSU2tJRDdyYkg0TG1MVDI2VTFMaHRwMzc3WVV3VEZma1hJaUd3?=
 =?utf-8?B?VW5sbS9WV0EwUE5kZ29GdmpXOGJ5N21qSmtwdnUvMXFxaUI0S3RJanU4aTNx?=
 =?utf-8?B?QVlpcllCN2tjaGI5NXloVVQ3R2o0d29qVVl2VTJJWTI3ajZVZE8rQ05uNnI3?=
 =?utf-8?B?V21NWVFjZk1pRFdTQWhXN05MSER6Rm8vT1ZQZGxhdWlrZDQxNlE5cFI5TWRT?=
 =?utf-8?B?bWV0eXVhY2dFRmtOS0k2aVlHMDgwYlNQS1RNRjU4ejFMRk84WG1kMFJ1Rjdl?=
 =?utf-8?B?VnRiYW1LMG13YkxMMTVaNjdXTytuSkpxYmMwbEdDTGVmZWtZVUwySFJ1NzVT?=
 =?utf-8?B?SG5uRXVpbHBPUmxTZzhPYXMvU0ROdWlrVFpWS05sb1hWVWFxTzBNQUZVcndx?=
 =?utf-8?B?TVU4R3VZTnM5OFh6SXk5aG41dTRLSXY0TjRIUURMMFVVQU9jQVlhZUwzK0dX?=
 =?utf-8?Q?ewJ2clymIQgnG0GVzuetznaeU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ba8196-64d3-4c95-b81d-08dc43c1fdd1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 00:59:24.9221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnf6rNpVi66bsc3GLnF7t/cmXO4leXGY8OtSDZW/Zt2fZ0ELlFD84ViRCkzHVn7wju61ptlWKauWwYMqwn6DeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7422



On 7/3/24 17:22, Sathyanarayanan Kuppuswamy Natarajan wrote:
> On Wed, Mar 6, 2024 at 10:09 PM Alexey Kardashevskiy <aik@amd.com> wrote:
>>
>>
>>
>> On 7/3/24 16:06, Kuppuswamy Sathyanarayanan wrote:
>>>
>>> On 3/6/24 6:20 PM, Alexey Kardashevskiy wrote:
>>>> PCIe r6.1, sec 6.30.1.1 defines a "DOE Discovery Version" field in
>>>> the DOE Discovery Request Data Object Contents (3rd DW) as:
>>>>
>>>> 15:8 DOE Discovery Version – must be 02h if the Capability Version in
>>>> the Data Object Exchange Extended Capability is 02h or greater.
>>>
>>> Does this change fix any functional issue? If yes, please add Fixes:
>>> tag and probably CC stable?
>>
>> The issue is that before this patch the DOE driver was following PCIe
>> r6.0 and it was not working on a device with DOE cap v2 added in r6.1.
>> Is it "fixes"?
>>
> 
> Since you are enabling support for the newer spec version, I think it will not
> fall under bug fix. But it might be qualified for the stable branch.
> It depends on
> whether you want to support this device in older(stable) kernels.


I am going to need lot more stuff (TSM, IDE, TDISP) in addition to this 
but it is coming much later so there is no point in pushing this alone 
to older kernels. Thanks,


-- 
Alexey


