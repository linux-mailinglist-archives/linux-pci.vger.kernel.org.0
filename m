Return-Path: <linux-pci+bounces-3562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A857857092
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 23:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 002462848B2
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 22:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BA08833;
	Thu, 15 Feb 2024 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IpZSrc9h"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0088C142;
	Thu, 15 Feb 2024 22:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708036249; cv=fail; b=WxssGF6Fg/5e4+92/si5gT1RPTUMV4uFjQLjWHbyLrBUxkWCJw1TTH8Y3f8WjKB1J2Jw34b5pkZWGgKUi29Fg+Zka8gIsSe4UWoWpHCHFI07FOxoRY31zX5pOtDlu0YPYpBkkDNeCNq93GSa4h5bdaNZSd9jjY9vnYFMUqgAcrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708036249; c=relaxed/simple;
	bh=GAGq068tTNV0sLjYGCoBQeXV9usb12tjeD96DL+6VJg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I0Jw/r0QHohksDIg635giSIKoE8RDFGc1k1Z8Rbu3EQIHCngmdu1VgeKkmneBWbtZDS1J0o7mhQ5jyMvO94WzXQG0+Ly4MWsx9C6nWqQ6AJdGp3emOpN8MPzQMlZhHEUqmSHPNJbQ29Ocdp6d8GczFXki7gU3kedqcqj3zSUQwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IpZSrc9h; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNDfANqHZ2f9EQMBG3QtcLIl9tiKvZazKOavq0F68uX9np0p1qBHs+3nXviCjfk9fPqVt3TxcGarpABDKXpasdTQrriAbNn4A+q1yB5lnoLXQqH8bgpos1/0ncO3c/XF9MpUd6tHi9AuSPVcWyjT2ojfwGVgxQsD73Wnq0rv5it4/qGYFtPRPeq8WlFr2SztC3BYGJ0yqNN+0CL8XBuZt+JS6d88TvQe2FgYzWXniLa8ixsD7uhan6WLwVBNuNvftTcGt/yNSInhUTAhH6U0VPnOA0PeCNVpNXGMlbT8348FmfjE+su0zcT8krJCCTwr684KqVtKUqsqZO7bR/D3NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTkGnlmt6GuZ/skRFH+rSuftaxKGNE3SWvvLS46YvkM=;
 b=iGPCFeqkWqdr3purf79w8ubINRGvC4geqlyD6zg+TocrD1AYsJlKNpJtNo9pqApSEm4ZlFzN5h1D40Eh9f/b4XslLBP3uzBNETX31zD4I23OV0M9RaGNEb949l11bKSbqbgHe2NYZ3UBLjKnqRVWOrIlwIRXT2UAbGjAFTVYwGjhI0dJik3Eh/Xdx5gjJHZCqstxqEitznu4hELAeRkboTpIHUfhSiO9GkcIgVxOE0LT1zuDwnRe2VU+hICjHrEjD/WorfgOVK61ZmSpYFTHRg4McVHLoMHMB0LhuYFJP33XmOa+0UzPviKMq5BUcJ64mE5nHMy89LxLM/bvQMm/MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTkGnlmt6GuZ/skRFH+rSuftaxKGNE3SWvvLS46YvkM=;
 b=IpZSrc9hFcJQKLKny2lbjvdm+K5J7AeKUOG6VMj8PK8JUZtu+CsItH3UPUf9I9s0gi1WDAqgekmXLiq3OHt8F9fPZ9xk4tyJy52O4fJQmcuCPa5a6dMZ/hJCplCjuU7cPI1a4LP4FfvCp2KhmA5APurXl9BjuJ6wZZd444uOn90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.11; Thu, 15 Feb
 2024 22:30:41 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458%7]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 22:30:41 +0000
Message-ID: <4fdbfae1-8e86-4422-890d-5f548390e4fc@amd.com>
Date: Thu, 15 Feb 2024 16:30:39 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/6] pcie/cxl_timeout: Add CXL.mem timeout range
 programming
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com
References: <20240215222915.GA1312780@bhelgaas>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20240215222915.GA1312780@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0118.namprd05.prod.outlook.com
 (2603:10b6:803:42::35) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|MN0PR12MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b546fbd-5716-4441-a0af-08dc2e75bdc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ict4NJUc88cbea114SV3vmnK2iZox/ULQzPkiUv8XCnUtEweruhxjmftcUM2iywTaqqoXZwyCf3K1ztqY7nJCYGpdiOBx5cLluER3pfmySqCsmbfN/n6jR3oGR2sjtYdd8rIHKHCfvi9jkDERPJpxK3F/oxGspFYZpUtt2Mv+xIzqqbF7DENclfwAdv8RjUz3//e71aSPoZd/GzHHK4jrrgV88fqLLufvyT2FDbAtpVjoh/tWbth30EwKfkJufY9Vhu4TaSQDk34KsHUKrjKlLzXfgXtS2qsrXOydQV8XWmSbbTpc/MxfCa4vrrxFYXLoO/hP/7VK+NPVTYCIVO8YZwSNZt+fJfXYkmi7yUjnxR2dfMhSdqjs2vkrBU8S0CAlCnNyETQLxp9wDUz+a46LefdWQXHp9GfGwbIEwDjdWBzCywGJLB75Vnu4KsyWa2QTn7zWciyh6BGy6t0sUqNMagWzBxpRTmUm23zdkbsKbCrhUayUdCmAEN07dRAu57PgXzECa4i0adIf7ECI7daBZlV8uu932fm5qCtIBX6cwHK19N+grhgWShUO6wsi/dx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(376002)(39860400002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(31686004)(4744005)(5660300002)(38100700002)(7416002)(2906002)(4326008)(2616005)(26005)(66476007)(316002)(6916009)(8676002)(66946007)(66556008)(8936002)(478600001)(53546011)(6512007)(6506007)(31696002)(86362001)(41300700001)(6486002)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEZpYUxLNDFaTFhTTzl1UDRXN1VBMzBJd1ZnNURObHZoUHAzZWlqaTFqc1Az?=
 =?utf-8?B?QkFiaHNwQ2lBTjhFZHNvOTlLRUNHZm1sdzQycHlNemlQaHNTZThBNGJIY1lt?=
 =?utf-8?B?R0tCaWxIcm1hNUJRc0tLNnRGVWlleTY3N005NjBXSzNGeW5TbG1tVlp0Q2xU?=
 =?utf-8?B?MnRHQkJwSEpIaVp3MVNyMXd1Y0IrMFJYaTQwS0xhMXhyOGtWc0lZWC8xTEQ5?=
 =?utf-8?B?d3YvVktzL2JYVEZvYW0vSXRPYlArRC9YSmZscDA0V0xhUENITDZFbk5iQU9M?=
 =?utf-8?B?K0w3eHhDekpMVDNhSnFmSjBiMlJLZWU3ekxUK0tGMEVuTENMdFZQcFRIOHdI?=
 =?utf-8?B?Z2MwRlRJQjNOK2Z0bEhTbG02S1F2OHNYb2RnZTZqUnRYVTFXeHplWUNneEJk?=
 =?utf-8?B?MXlxaEtrTlZLdGQ3NzR1NlY4c0tFNi9nVUNJdDRjcnVCbk05emExblRwVDds?=
 =?utf-8?B?MlhtVUJHTG0wNlBsRlNzL3ljOUs0ZFdaRFFib3I4dHUwWlNoTU5ST0d2M29K?=
 =?utf-8?B?ckxSbnNrcEpyaVppMHlqWmdiSGFCSU5ac3d0ZEswUnIyWVB5clNINGZKbXpp?=
 =?utf-8?B?RXN3UVh2eC9YWnVZNERaQXNUUGZzb0N0TWxTMW01RkFBODAxUFlzY09rRGgr?=
 =?utf-8?B?bmVjRmthVmRoK3JtVWRJbjd0SU52R1pFWWVENTdKYlBGUjRkR2V5a29tZGwx?=
 =?utf-8?B?UEY2ZG1uSzVaOUliTFFpZmplUEp5UmNhUVl4WElMaUY3WmZiM2dxVmJkYjk4?=
 =?utf-8?B?SS9LcVdQZ0liVFZkWXNzdVFrdEJOcnd4V3FQUlJka1czSGZ6eElXaTFxdUNJ?=
 =?utf-8?B?YllQemNPaGliUEFJbEFDWWF2aDIxb0Qrd09hWDZMdDJVM2NlS1cyaXdvUGRZ?=
 =?utf-8?B?TDdEcnBXUEVadFMrRVFWY1dRakV1MEdsZHdQaCsyZFc2dmlLb2xVUmZoUC9R?=
 =?utf-8?B?Nnc3cnZpWWRaNGFZT0NkdC8zMDlPRG1BMDFSRXhoTmI1aW9Mcm9tY1hwVVBE?=
 =?utf-8?B?MnFoODgvMUlOcHUxZXJBNWdCdGZIWHhBNHBxYWVBb2g4UCtsci8yL2MyeDlG?=
 =?utf-8?B?SmtMZERUVmV1akIxNE1Gb2FJS25WMkxGQ0Z0VlFBVllFM1cvazQ3ZUw0WExk?=
 =?utf-8?B?OUJ3UnR5YnZZQVpHVEpqcHNMRGxURGFTbXc5T2ZwUDVqYWh3bytaQis3WVJP?=
 =?utf-8?B?cjZYelJBS2haRTE3SlNGRzAreXhNV1hOM3JIY3c0dndXQlhGNjZuK0tyZ3lr?=
 =?utf-8?B?ZjhCN2NBSHNUVEVzUGhsSEhYWm5vcjg0dXVXR2tNVWYzbjlZZzRUNUpkQS8r?=
 =?utf-8?B?ekxiV01zR1hqWXlWNW03M3NJbEUwTTd2aEtKWE1kL01uTkVqWGpJM1pOZWJi?=
 =?utf-8?B?S1N4NVk0N3Y0Q09mcG9zT21HRGQ3U0JIQlpLbWZ5dnVpUkRCQnpXWE0yOEdY?=
 =?utf-8?B?N2MyYU9Fb1FuOTgzV3NJOXorWEVGTWVHenNMWlowbG51QjR4ckI3VEZ0SmRj?=
 =?utf-8?B?R1Bab2E3dnIwZXJLMEx2UW8zWktiVEgyUjhNaGFUN3Eyc0JEWXBxK3pzWCtI?=
 =?utf-8?B?dWJHYzBldDg1UVZ6Q0MwTkNHOTRFSU5qaVBPNGorbmJJRnJ3V2RmSThUY2Z5?=
 =?utf-8?B?Q2ZvU3ZFZml1VXVBS1RuWHVwUm5PR3hRWnVDYll2VmtHdndlUGlRbTFiR0l6?=
 =?utf-8?B?VUdnMTV2N0Mzb2NWMnlYc01ZdWFkeTlTcjQvQWxYZVRFMXZERTVicmdCNkN2?=
 =?utf-8?B?QWpTM3Q0dUpwQnB2blBWVVVZL0M5amJYbWVDMDVSZ25zVEtpZXV4TTljNHNH?=
 =?utf-8?B?Q3N6dlYyMWtqUi9HS1NIdmMvOE1LQ0taZVMrZG5mOHVrVjVnMTZHMHR3R1ow?=
 =?utf-8?B?eTVSSWNzV05NeUYrWDNUMElWN2NnT3RHVFFJS2Z0ZFNsdEc1eXhPamlkRFND?=
 =?utf-8?B?OEFXSWg2bXlRbWtyRFdnMnJUUVBtUUZDemt5bjAzVStlSkd0MGZES1N6anBU?=
 =?utf-8?B?V3FEOTNBNy9DRVd4WDA4QjdQQUFMWVNsY3VFVmQ1Qm90QW13ZFZqbVY2QjZh?=
 =?utf-8?B?WXVFRXZCNVlUMXBHQzlzcTNxNERXcUJGd0lVUlZaYnFNM3FNZU5MTkRLQTQv?=
 =?utf-8?Q?NZDqzBEs8JeoN7SvnReWrgVS3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b546fbd-5716-4441-a0af-08dc2e75bdc1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 22:30:41.1043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+bKefOIrZT0g4Yz1pZ+7Tm54fYp4Eh9KjOuOVZO3uUxux8b0EGNbagKB3JmkflVt1RgD8VGwunP3KeFdHcSOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810



On 2/15/24 4:29 PM, Bjorn Helgaas wrote:
> On Thu, Feb 15, 2024 at 04:21:48PM -0600, Ben Cheatham wrote:
>> On 2/15/24 3:35 PM, Bjorn Helgaas wrote:
>>> On Thu, Feb 15, 2024 at 01:40:45PM -0600, Ben Cheatham wrote:
> 
>>>> +#define NUM_CXL_TIMEOUT_RANGES 9
>>>
>>> I don't think we actually need this constant, do we?
>>
>> Not really, just gets rid of a magic number (as well as makes sure
>> anyone who changes that array remembers to update the array size).
> 
> My point was that I don't think you need to specify the size of the
> array at all since it's initialized, and you already use ARRAY_SIZE()
> elsewhere.
> 

Sorry about that, I just completely misinterpreted that. I agree, I'll remove it.

Thanks,
Ben

