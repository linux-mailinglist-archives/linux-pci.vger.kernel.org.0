Return-Path: <linux-pci+bounces-22713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5E9A4B0A9
	for <lists+linux-pci@lfdr.de>; Sun,  2 Mar 2025 09:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 365E77A7638
	for <lists+linux-pci@lfdr.de>; Sun,  2 Mar 2025 08:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB3E1D7E37;
	Sun,  2 Mar 2025 08:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KNWi/Iam"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D711D6DDC;
	Sun,  2 Mar 2025 08:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740903770; cv=fail; b=PU7CHt8DtCC16Et1QopMIUr6nBcmlAs1Od6L9eLNxPQRvBefdnbRpo+Rsgrbe54ymDpe9FIyWvilzgj/9wSfIlI17FbmG7aW307jkE5XVf7DfQEYpf5JDbLCVDV4K9YDEbeCgSmtVrEy7d0x31Y0dxfzBIF8DO5gh/oKwg3C6RM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740903770; c=relaxed/simple;
	bh=iXmC2iAIziNf3aTdNEvCtbC2G/tAB3BWtaYRPmehwhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MQf4mBubCfQQwqYDZFy95QfKJvqhylA/kFk83a1qFCK9euiQxOtjqhyADSe3rHbA0xqJ4Ekba5Df6l3XepJToVHD3tAvWbOuk1dFRFEB+2nG56Z007gqLMO6ltfH/9JzrZVlePKAaGpqfosl3sLUbdbYieWiPyT7cKSoro4lQso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KNWi/Iam; arc=fail smtp.client-ip=40.107.96.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7ZYhIeeEYEDs3jg4ciotlV0wnTtfy8Z0EpfSXFKJVtC2qsxfDTLc184VU8Irf5uwu9GUnm82A9kEjJLekJicA0BhMmtZgkUEMaDQOioMDEfqnVmQLQ3TW0cPx9vYninKhwEutGWUPL3l40aF9TgXGgENfCXla0C1PGzRxgXIMw2qI7qIbOa7v080DKxQqyDdB3i55+pneCRU1up6i25/UkpB7+gKE1Z35+34DhkuRAH9/8xoRTczOYe6mUMX/Xt4KCOGFGVCwZeRfpwg/SEh09FLkn+2EU5JS/xjSNejj1wDZsbHULeOwWO7lYA+yZYaYCraGPZbf4EYHiEdjRr3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8s2JXJaOBF5Ys2tsA9mMfMbDKIm5bEjnBYCgqzeII0=;
 b=IBRsw1NpAesYC1vGTuBUoxLi/ri4KIDLcry14h5fGu4LQ1NOW1M72+3HoTpGxfqbQ9mU4Edv17evq6e0ztR7Ey5uf7dbxm7CINxkUWcVg5Kc6P/kszUDavX8c4LNO1CI9EXVKfxUs4AOaQgRC2M2H+51sPbwo9EnBXPKqZPdN5j6ow8WU9r9PhA0KyXIti5B9s4KqJQXD++SG8LfEEC+hADScl/HLUex4k//E1A00QnCKaDPGaUB1ajl/AjyjOwp22uEgcglpFVZJj8GLBKkscVp4XOf7frOuxR0VJwHoBqU99b85FRY4vtXVfmTpZTh0OKPYWWGLLyytGt+lAbS1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8s2JXJaOBF5Ys2tsA9mMfMbDKIm5bEjnBYCgqzeII0=;
 b=KNWi/IamYkJKh1fRmNsCUmhmxSuVHlVd6w5gwhshEoQl7xiHtWu9HdDAYRzNormCEDy5szXREwgXNZhVnbOK601AXPM3vQxQPyhLFke/03LPp3sAiQQ0HUJ7mvPI1ZH6nnO6Jc4nxUCkOaagKH1eo3KiuqTkef17tTo2ZkuDrayGw8hPVyDHCBZicY6ZYcPTWWPMAIWYOw2dyrivEjjgAj2t6NytFxi4kZ67YkqG8YIlmm1gg+JiLY/logpww7rc04UnBbVmnaDe5VJn11qgQyzjCDeabXCNtKUYwSDxXjlggD376t97DLvRCvFUDtAG5DMsUOCv6qPuY7mliOJVUw==
Received: from MN2PR05CA0054.namprd05.prod.outlook.com (2603:10b6:208:236::23)
 by MW4PR12MB6999.namprd12.prod.outlook.com (2603:10b6:303:20a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Sun, 2 Mar
 2025 08:22:44 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:208:236:cafe::2d) by MN2PR05CA0054.outlook.office365.com
 (2603:10b6:208:236::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.13 via Frontend Transport; Sun,
 2 Mar 2025 08:22:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Sun, 2 Mar 2025 08:22:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 2 Mar 2025
 00:22:32 -0800
Received: from [172.27.49.60] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 2 Mar
 2025 00:22:29 -0800
Message-ID: <f3a98fe9-ced9-4d1c-b77b-2c1d65ff9e23@nvidia.com>
Date: Sun, 2 Mar 2025 10:22:26 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix NULL dereference in SR-IOV VF creation error
 path
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Keith Busch <kbusch@kernel.org>, "Leon
 Romanovsky" <leonro@nvidia.com>
References: <20250227224547.GA22604@bhelgaas>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20250227224547.GA22604@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|MW4PR12MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: a43d349b-b0ac-400d-9067-08dd5963679e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlFlNk15Nlk5M3NRQytSL0g5ODZqOVpwQ2VvN0FlekxFem8zbkpuZjZva0M2?=
 =?utf-8?B?aStlQXZ5aWY1QUEzaGlzL0lPVTlkOVMxT0RpejdtS1l5MjNmRFczdXRkY2pE?=
 =?utf-8?B?dzAwMDZBSUNOWXMwUTFBZXBwOGNxVUFvZkJERXVLdm4yNEdsVkU3SklEd2tx?=
 =?utf-8?B?eExtT3VqUGh3d2g2d2JUQzE0TTVvQmZPZDJVYXFHMDVoRGxBcFdWcXJpTzBB?=
 =?utf-8?B?YmxKOVNuN3NBVmU3VXBpR2p0cCtMMmRNMEY0aGhMbDcrdTVhNERsMEUydVNS?=
 =?utf-8?B?U3h4VUJZMDMwUUE4OFZqOWhRWDNKM0pEMU9FdlYvaEZLSjRrSUJSc3YxUXEy?=
 =?utf-8?B?MFQ3VkdmbCtEYUMvVmRZTjRDTnVrZlUxY2xNdFROeUhBMVJSdVAxcTBOY3BV?=
 =?utf-8?B?QTFSL2Y1NEJjdHFTK2cvOGlDNGRFdHM0RC9ScjArTFZ6OWFVUWJCWHRqaHF5?=
 =?utf-8?B?eTdWYUxFZGJNM1VEcU9BREhOWHpqOHZVVWk0eHkwTm1ZSENNYml5SzV3eVlM?=
 =?utf-8?B?dWFTbDJiZjBlWjdBNHhBUFJ6RDQyODBxOXBSUnpNd2h6R0ZoQ09BRWpjdGxK?=
 =?utf-8?B?Rmx1L2VCakdGS2RRbERTUDBOclRwVENIcWZjRDhCRHk3UEpvNkFIMzhPNHBr?=
 =?utf-8?B?MU5NMVhuQVRXMEN0bEZNajZjSEpaMU1Ec1U5dHdVSWtma0hjdkVjZ0xZcllN?=
 =?utf-8?B?UStpY09KSUtFd3NGaXdZdHU3enNKQ2RpUy90VDBOeS9PdTdzT3I5RmtLOFRz?=
 =?utf-8?B?K1huU2JzMVpZT1IxS3lGME1JTVpVUkozOEQxSUVKVGpJR1dXK0ZjcGZXOVd6?=
 =?utf-8?B?L3JPNXVOOGNGWVpaQm5ENmNER001MzhIemJJTGYyUENMNXIrUktGRnRTZGxt?=
 =?utf-8?B?ZUtiaWlPeFoxWGc2V3V2TUl4aGg2NFVKSlRUZlBnQkJJZ0hnU0RtenNTOGhz?=
 =?utf-8?B?NG9CV1VXN1RFYzBMNVI4TjllS3BnL1l6MS9Wb3FBT1F3aE9leVpRS0dVR0xO?=
 =?utf-8?B?SUZrQjFwZjExOXV5VWd4a3ZTbUphWDlYaUd3c09tU2NJcHBPT1I4Slp6TjVH?=
 =?utf-8?B?NEM4QU5HM29nSXN1ajh4eTZIV0doU3ZGemtmK3FZRzdza1cvUTBFaWNGOCtN?=
 =?utf-8?B?Zzh1MGFDK0pQQnc4d2ZnYTNYaFY3Y3oxalpIVDc0Rm9MKzJVWjNub05VVlVv?=
 =?utf-8?B?K2FjWFpiMk0xaHJVT0dVelRpYSszMHluc1k3b3VhM0dYd2ZrVklQQnJLL0dt?=
 =?utf-8?B?bkhjVThqZ2doWitlMWxpMFdhTGdBc25EUXQ2ZDlUV0Y0YlZDbUJzbnhrdG9W?=
 =?utf-8?B?Z0trNklQQlQ1RVBJeWhvUnJxQnBxb3pSYTUwMGtWbGhHVHUybkgxMWpzNTlz?=
 =?utf-8?B?T0NDTzlYRklvWFRWeFN4a24veHF1VFkzSTdia3MvazRKek5sR2hFWEh6d2Q1?=
 =?utf-8?B?ckF5cEdQWkJIanQ2MHV3cURhRkhvTTZBa29XUnNVaHdBOGl1VzZ3Y2xqNGlF?=
 =?utf-8?B?bm1pOURnSG5UTlRUM3hxRnBaSUJUSGR3WlpNUTA3UlFjZ0d4K0FYbjFLVms4?=
 =?utf-8?B?MWFTa3hYMHJObWlpdTU5VXNDdUJpWE4zeGhLVlVDeXcrWHJVNEh3Um9LVFNr?=
 =?utf-8?B?bW1tRXRTVmNCeHJybk13UUJ0RnMvSkh4dnpBZ1pKOFM3S2VDOWN6T3cxc1Iw?=
 =?utf-8?B?ajRyVnk1TmRVZmhieTZMaWNFOGNObGZDckl2cm5SeDh0YWZSaGcwTDBXK2Y3?=
 =?utf-8?B?TnJ2OTRBYTlob3c4bHBRUnp5VWI1U2Z0U3J5c1kyM3o2OG5wTHhJbUlzM1dk?=
 =?utf-8?B?clRZUFp2WWVQK0YvRmcvV2JlNktwcHBPRXhiNUtxbU5SUFB0T0xTc3RSRzFn?=
 =?utf-8?B?d0J0K2hHKzJCaDBzcTUxQkcwc1JBNGd6eENNOHcvN0hoK2MxVFpZTmtsUjJ3?=
 =?utf-8?B?TVZseEIzYUxrWnJwTzVyU1BZWmNtU3VVblI1V2VxeTlLUll4bWJpUVlFd2Y5?=
 =?utf-8?Q?K5t4A3op/xFYu78scXb7CBM6MJMeUU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 08:22:42.9526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a43d349b-b0ac-400d-9067-08dd5963679e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6999



On 28/02/2025 0:45, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Sun, Feb 16, 2025 at 10:32:54AM +0200, Shay Drory wrote:
>> Add proper cleanup when virtfn setup fails to prevent NULL pointer
>> dereference during device removal. The kernel oops[1] occurred due to
>> Incorrect error handling flow when pci_setup_device() fails.
>>
>> Fix it by properly cleaning up virtfn resources when pci_setup_device()
>> fails, instead of invoking pci_stop_and_remove_bus_device().
>> This prevents accessing partially initialized virtfn devices during
>> removal.
> 
>> Fixes: e3f30d563a38 ("PCI: Make pci_destroy_dev() concurrent safe")
> 
> It's not obvious to me how e3f30d563a38 is related.  Can you elucidate
> the connection?
> 

The Null-ptr Oops is from device_del() inside pci_destroy_dev().

Before e3f30d563a38, pci_destroy_dev() check for device's kobj parent.
pci_setup_device() doesn't set device's kobj parent, which means that
in our case, pci_destroy_dev(), which called from
pci_stop_and_remove_bus_device(), is no-op.

after e3f30d563a38, the above is no longer true and pci_destroy_dev() is
being executed and call to device_del()...

>> CC: Keith Busch <kbusch@kernel.org>
>> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
>> Signed-off-by: Shay Drory <shayd@nvidia.com>
>> ---
>>   drivers/pci/iov.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>> index 9e4770cdd4d5..3dfcbf10e127 100644
>> --- a/drivers/pci/iov.c
>> +++ b/drivers/pci/iov.c
>> @@ -314,8 +314,11 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>>                pci_read_vf_config_common(virtfn);
>>
>>        rc = pci_setup_device(virtfn);
>> -     if (rc)
>> +     if (rc) {
>> +             pci_bus_put(virtfn->bus);
>> +             kfree(virtfn);
>>                goto failed1;
>> +     }
> 
> Thanks for the fix.  The mix of error recovery styles (cleanup here at
> the point of falure vs. goto different cleanup steps at the end) makes
> this kind of hard to understand.
> 
> I see that this cleanup is similar to what's done in
> pci_scan_device(), which does help.  Did you consider making a helper
> here with structure similar to pci_scan_device(), e.g., a
> pci_iov_scan_device()?  I wonder if that could make the error handling
> here simpler?

seems like a good idea, will do it in v2.

just to be clear, the outcome will be something like:

bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
if (!bus)
         goto failed;

rc = pci_iov_scan_device()
if (rc)
         goto failed1;

virtfn->dev.parent = dev->dev.parent;
virtfn->multifunction = 0;
<...>

> 
>>        virtfn->dev.parent = dev->dev.parent;
>>        virtfn->multifunction = 0;
>> @@ -336,14 +339,15 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>>        pci_device_add(virtfn, virtfn->bus);
>>        rc = pci_iov_sysfs_link(dev, virtfn, id);
>>        if (rc)
>> -             goto failed1;
>> +             goto failed2;
>>
>>        pci_bus_add_device(virtfn);
>>
>>        return 0;
>>
>> -failed1:
>> +failed2:
>>        pci_stop_and_remove_bus_device(virtfn);
>> +failed1:
>>        pci_dev_put(dev);
>>   failed0:
>>        virtfn_remove_bus(dev->bus, bus);
>> --
>> 2.38.1
>>


