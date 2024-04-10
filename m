Return-Path: <linux-pci+bounces-6001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 097BD89EC5E
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 09:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC001283FCD
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 07:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB4313D269;
	Wed, 10 Apr 2024 07:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MydF8Kyk"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2131.outbound.protection.outlook.com [40.107.95.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC658BE8;
	Wed, 10 Apr 2024 07:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734873; cv=fail; b=A/Q8HmY/jky5hoNhUV8SeG+f7Nf40H43D+dSpk5dChj6WmRF2a15z16np331Qw9t2TkZWlY6NylUGNcc4H+6F183JuVxg6Kx3ziwhtdViQ7+goWjXeaFVCFfKGuDsP+IfmGhFWtp4hvIMA1XMk8SJ+qdBQp8lb/iAo0lQkjDwuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734873; c=relaxed/simple;
	bh=vSOjuPxfQnfhMdcrFWSUqgremb/+kZ6n/dZbKcZQado=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IPDppH5V70MOft30Y2T0YFPRd4j1XCZJS544fxw+wCIqZA3fab13gBaeVUSNG9newCDMC/ZDlBB8457xwVXGsklhJ+GfeGGyuGbC6dw7sZs43eQRmTVP3pUlGc2lTAvccz9OAnHejFsoU08ADgUHDVGhx4fRAce2DXU0IJz4nE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MydF8Kyk; arc=fail smtp.client-ip=40.107.95.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nusgrMP7+5Lz2++dsNranu6fgt0XunnbHk/+h6How617JfSo3q3FdXxWTF1vWWj8qlZhkeOW0+4SCdwWaJ6FM55LHEvKM9sTAdI5D6OWbh2oVALAnhJhpBhHRBbOHOj96nO97nbbFBr+cRlNBivDVirmwVuu7p/qDZlHCtlLLB7dwP1ntIJ7dIIIoejleM9m6+Y0Xe0ee6SARoIgHWvPdUpLOjYe+CZMaKYn0LunjG0j+E8UjtGY+YXkyd2oxD/ghmfFLCj8jEgQdZEwiaTkrNN2bhREXy82JqG7EjraGqX4dWcHgxNSpYwFfMiuP1CjmQAiPxLCTVVWgPCen4w0PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvgMBNbUFC/hKPAR4eq0XJR5UxNwxaxc6pjQC8h39Rs=;
 b=BRojP3GUjYFr4Ywdm7GfIx3cTT4lqz+1OzNRmCThkVMAderUQPokjXlxt3q4Gh22P33jq3mtbZ8BMEZyYZd9qYfqq8doHkhI9gXgxfAbDk7U5mkXgRGJl+XqLQSji5MDH1ZHmX8HHzRAoE/3vRjh3s2VWwclemxXnqdDk5k2GFKjyEMSyLe44JVTpFsksZr1TwI3cgo+0qg06JkYd5HW7+wOse27u/9m2DXZtM5Xla67E18/OOQDsi3SRjQpDjJuEDU/WAfR/OZAp8cBT0X+ixljMhBeZgXCGIBOCkVP1P0zAcB9zsP8Nmqzp7tREXeBBZKE0qZftnEZsIPbx+wUPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvgMBNbUFC/hKPAR4eq0XJR5UxNwxaxc6pjQC8h39Rs=;
 b=MydF8KyknMhdb6tIL7uib34m6ydJdTL5Hmlzd5UUYzsyJFKcAZaSklrfjR/VS3l34CyZlKVljoJ4nn3jaKwC12DzKYmIZRDTAI9HAClVDFS8hDO9w29ehTeP1Bo/ULaTTXDiXW3cuAUoOzBdqNwOWlct4Tt/1W9MZb+mG7yJtTn+JHmAY1J7qnCRh043wlMnCmsKAsG735LaEidJMLULISOqIen0b6GQb+ULefQRebzLhvyy6MmVOMy71v5GJLBQmzYmn1yIKzqUoDKUmhxHe8EX2iC37j9YXrziTiWMIbGwEOjkDmL7q7Vbuj6DZgwwSnFFHwZh3Y0KNETHQXG9EA==
Received: from PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 by PH0PR12MB8173.namprd12.prod.outlook.com (2603:10b6:510:296::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 07:41:08 +0000
Received: from PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::c19e:4e13:c3bd:191d]) by PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::c19e:4e13:c3bd:191d%7]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 07:41:08 +0000
Message-ID: <72cad548-e2b4-48c3-9427-53004a40ee2e@nvidia.com>
Date: Wed, 10 Apr 2024 13:10:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Query] ACS enablement in the DT based boot flow
From: Vidya Sagar <vidyas@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Manikanta Maddireddy <mmaddireddy@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Krishna Thota <kthota@nvidia.com>
References: <PH8PR12MB667446D4A4CAD6E0A2F488B5B83F2@PH8PR12MB6674.namprd12.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <PH8PR12MB667446D4A4CAD6E0A2F488B5B83F2@PH8PR12MB6674.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::17) To PH8PR12MB6674.namprd12.prod.outlook.com
 (2603:10b6:510:1c1::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6674:EE_|PH0PR12MB8173:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cBwTEbHvgBggI2XEmy9fiDx4fjaFm3jLqPkbGoWD4IGctdWXQ6L6ENrf0i9OMRK2je9fYpYAbCgPGI7WN0N0N3sLNbFJPis5wCuEdkaY48GT98mNnol8WlopIyvTy6QBMR8ZTA8OVEEnJFkmhxRbAWp5Phg9q8WKpHllmV+mxH1SZmH6hr/owHlRFmIU4eEa9MHD7WoijUs0T4PXaQdrfiHEH1cjugcf9IJ81vVyicA1GiBD06c/C6y81GXAGcPrqoUnfNcYsS7xVVFgEI08Hz0QTX0q+DvxBQd9+BeExKVEfS1z5SR8xWddP38ijGmuFFVmNhi5JD8XmKAES3iQglLJWTj4QfF5wTWBc56aNiLGtI/CIC5BzTw9s/O2mWY6y6W5baviXqY3VU9h3EeKy2Q38BqMFy5HK5SFTbVdjs9lFFb5BGtYOqV922WNyd98DNcrfWxvE11S7hU4a+x+/DajD6i2FbyZVB8pZJ9bYEB1Lphegk+kwj+W0kJZ73KfP+GZUoBqOscH9RPMs6mOA7Yxj/TP64kzLT7UJPk9p0qPkwfKRNQWshixYELfj/Is/MsXY3w72D2uDJovdK9o3EPz0WAvhwtuQB5TVIr5v93tyBryjT67HmqK2oKslOR+dt4ENyzu6GkwHSqbButLC+JyBh0lM12Da7zb0zooCn0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WStIcEFaakZ4amdmSU50UXR1N2xLZVNBNU82ZElXMVFFempVd3J1RVFCNXlO?=
 =?utf-8?B?dUZLQU9rdnhQSmVnRlN5NzlXUzdRU2FmSXlqVk1qSUgveTFGZkxuNzRtNUtE?=
 =?utf-8?B?bC83MVE4YVA0MGJTRlByeGhNeUpldENkMnZqWUpOR25DSWtzU0c2Z21vZGRX?=
 =?utf-8?B?bXlVa0t3SmR3NWNBRW9lT0xMNUJtNFRuK0pibzhMaU50WGVoazMzNHVkbzAx?=
 =?utf-8?B?bW16THluQUdpMlAwYXViTERoM3hpRktOQmpyTDI3MDErODRORTdVNjZUVDJK?=
 =?utf-8?B?dXF5MmVxK3VON25TUG55UHNoRG1tbWhtQ2dsQ0c0Tk5uU2JEd3dKS1pSQUdR?=
 =?utf-8?B?ZmNlaUJBaVZUYjdKSzJ5Y3hzY0NKbHJiZlYxQk8vdGFKQ01Tc21NcWlRV09t?=
 =?utf-8?B?aTNuMlp2dlRvbmxYcUc0UE83eGJXT3VmVFk3bXdLTnN0S1F2V2VpUE9FdmV1?=
 =?utf-8?B?VEVxWTM2VW10M245ZEJidU01RitYRFk0Mytqc1VlZy9mL0VxTFlBWG9lRjB4?=
 =?utf-8?B?OEVsdFRUSGVJb3pTeXRvd2VVWjNJSXR1N1NRVXJvbVhqVFBobHlxT290SmFk?=
 =?utf-8?B?Qi81VXNnVTJxcXRCcHZDM2NZMzFndmF0b0x0cURKMFpYOGkyVUs3T1U2Nzd0?=
 =?utf-8?B?Qi90SlQ4K3lSU0s4Ry9yc1A5Q2YyYUlwQkgxYnh0SHlBNDcyd1BJWkoySWVE?=
 =?utf-8?B?eWh0M3o5OEFsdytIVjZoV29pUnZPdHN1WitBc2NzV2Qza08weE0weHp0bllh?=
 =?utf-8?B?STlIdWFUZGtKaDgvQjJwWng2OXVVdXlFblo4czgrMmRYTVZNeGd3SUN3TWRU?=
 =?utf-8?B?alE5cG02NVUzVklOamtDZFUwRURPWFhuamMzN0JsMmVMMHFoUVVYK3l3TmQz?=
 =?utf-8?B?cm4zUCtkd2EzN1JOOUw4em5Gc3dPeHYxa2lwVjZWZlpESWRNWWJ0TDFaZHVU?=
 =?utf-8?B?UTdqc3Z4aW5EV2t5VFRxWk00NTV1bDgzOE5KNHBsUTFwQXZDUDlUdE5GaWcy?=
 =?utf-8?B?eklKMDNiem9kZjRJN09zaVVINmZsbDVOYXloUVZoQkR6MlBxeHFwcVVXNXpF?=
 =?utf-8?B?MExhZmxFM0ppS0Y0L2RXdWM1V0J1YVQxUEZTRGo2NE41eEJmemFtSE12aFR1?=
 =?utf-8?B?SFh4RjY5TXNtMlBJa2xHeU10RW1jMGNMdEZScnlzb3N2cU1CZnlvRUUrZURu?=
 =?utf-8?B?K2xVeGRaZk10TGN5VmV2SmRkWVk0L2hRSnBXT0dseEcvdFdZdW1nWDNEaEIr?=
 =?utf-8?B?VmJnZ3NCa0pmM2tWSEVob0tDendNbEJZY2daNHY5Unp6UmtwRVRsUVJEd1Bh?=
 =?utf-8?B?ZHNnVWVuMnVmelBPaHNQS0M3Z0JzZkhXUkF6MHlWVkd3dmNhTTA0aDErbElY?=
 =?utf-8?B?REYyZDZmTEpVbG9DQU1zOHZBcnVCa2JtRVRoRzIyc09wbmp0OHgrYXhObXlp?=
 =?utf-8?B?ZzdlT1ZaY3ZBVEE3NnhndHNpV2dNaW5YWHVPSVNzTzVtUGFsMjl0bXFuRWR0?=
 =?utf-8?B?WWFCeEJvMmQ5RjhLNHZTUG5zSXAzTzZCQjFFanM5cTZldzN0NzYzVWE5KzMv?=
 =?utf-8?B?a1pmT2tlR0o4QXVsTlE4amFFRGxCQmJ0WE5aL0o0UDdJaWNLaklLVmdCSWhO?=
 =?utf-8?B?b0N6VEljTGF4Lzh5cGd2SFdOMk9tTkhPTTM1dGlRaWhJOXJ4ajEwV3B3U3V5?=
 =?utf-8?B?Sm5iR1NnU3pHNFdDQ0xzWW81Qjh1RGJPYlBxdjZIYkVhWnBNZURXZVlKbVgz?=
 =?utf-8?B?Y255M0hnU09zQU94SE5OZk4yNHVXbGFMbC9qNlpPeGl2SWRMc2R4b3M2SFFh?=
 =?utf-8?B?dVYxTnVFZmlKcEEwclp6a1VibDVPOU9NS2xkYkxTWWxWOW0vSWZjU1JvOVls?=
 =?utf-8?B?OW5vVGNucjBlM1VlbnpZc3pDM3Zxa2FUWmFpWGxWdVl0RFJFUm1CTDR1aGs4?=
 =?utf-8?B?NVRsOTdrTHZoZWpXa0ZndDlYVWNha2x6d2JRaVJDOTRISTFMWW8wRHhvZnRl?=
 =?utf-8?B?Q3dxWEhjdUhpUWdrRVNZcGNRRzNnV3NCbldBS0RhanI2WE5sQm1PTXIvTFll?=
 =?utf-8?B?bUNMN3JrWXJ6WGdnSkNyTGhVRllSM1lFT2U2UVpja2hySjJQL3p2bk9CU2x6?=
 =?utf-8?Q?683v+1NmQPQV2yhiD9suv3fpe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c948c55-99f0-4c88-c654-08dc593195d4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 07:41:08.5408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ui4EEwBzCAnb9deq9gtV2fgH0mLTQgzGmnssMNHucE32B+S4Malts+qtMufaCV876A5vSbEmzEjQ5SNUHIHzvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8173

Hi folks,
any thoughts on this?

On 01-04-2024 16:10, Vidya Sagar wrote:
> Hi folks,
> ACS (Access Control Services) is configured for a PCI device through pci_enable_acs().
> The first thing pci_enable_acs() checks for is whether the global flag 'pci_acs_enable' is set or not.
> The global flag 'pci_acs_enable' is set by the function pci_request_acs().
>
> pci_enable_acs() function is called whenever a new PCI device is added to the system
>
>   pci_enable_acs+0x4c/0x2a4
>   pci_acs_init+0x38/0x60
>   pci_device_add+0x1a0/0x670
>   pci_scan_single_device+0xc4/0x100
>   pci_scan_slot+0x6c/0x1e0
>   pci_scan_child_bus_extend+0x48/0x2e0
>   pci_scan_root_bus_bridge+0x64/0xf0
>   pci_host_probe+0x18/0xd0
>
> In the case of a system that boots using device-tree blob, pci_request_acs() is called when the
> device driver binds with the respective device
>
> of_iommu_configure+0xf4/0x230
> of_dma_configure_id+0x110/0x340
> pci_dma_configure+0x54/0x120
> really_probe+0x80/0x3e0
> __driver_probe_device+0x88/0x1c0
> driver_probe_device+0x3c/0x140
> __device_attach_driver+0xe8/0x1e0
> bus_for_each_drv+0x78/0xf0
> __device_attach+0x104/0x1e0
> device_attach+0x14/0x30
> pci_bus_add_device+0x50/0xd0
> pci_bus_add_devices+0x38/0x90
> pci_host_probe+0x40/0xd0
>
> Since the device addition always happens first followed by the driver binding, this flow effectively
> makes sure that ACS never gets enabled.
>
> Ideally, I would expect the pci_request_acs() get called (probably by the OF framework itself) before
> calling pci_enable_acs().
>
> This happens in the ACPI flow where pci_request_acs() is called during IORT node
> initialization (i.e. iort_init_platform_devices() function).
>
> Is this understanding correct? If yes, would it make sense to call pci_request_acs() during
> OF initialization (similar to IORT initialization in ACPI flow)?
>
> Thanks,
> Vidya Sagar


