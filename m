Return-Path: <linux-pci+bounces-33813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F01B21BA4
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 05:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85561169CDD
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 03:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BD92D2390;
	Tue, 12 Aug 2025 03:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lCumiTjL"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF62335C7;
	Tue, 12 Aug 2025 03:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754969181; cv=fail; b=Lqc7CQWJAn6UBtkx0XLKqpnSGLk/2WpqF8J+/E4urbFMvUJcy/C3iIZVldzrf6KYuyFyMJpxy7FIoaTiBi33ry9qx6VteYlrsM1AmCi9rU4NTVbaHBn0B3r5Z1Ww9OTqEby/R4gsvFdcDCUmRwqzSRMi1hGMI2I5NA9mSMC1xO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754969181; c=relaxed/simple;
	bh=VyvwYTTY4MegeIxlT3jQ0PITJBpFd8xgAB6hr2tk1rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JUrQM2OFdpgBkIDdkkNCZosvmvWUGwO5Ej8ymZCEFR2AoiMwqz/wFjPRQEyu11+207yNgkkgdZeGSIz0u3y0HxSy9Lj7xro47l/F1zFWbeMrYPuZG9z+bfjKiTj1qKSC/GHeB8tzxrqUniF7NDnCt6lB9RJuqF9VvNq0DjimfII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lCumiTjL; arc=fail smtp.client-ip=40.107.212.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z60xUCRb/A4FraWlSOitYkzMaOgeqnUpY2QIZNzTqaevOhg75ZYQtjDMwlyVNwt+n7UJITnLZ+vGeHeMZo7UOoHuW58m25nb6PI6cWF64T5+8YR3nugNMO04rLoplrTiiUAocIJfdObShR2/Cp0qINU8zzg6TSc7g7xpXABpxkL5Df1+rO8G7gxJX+5TCZkZ6LNjWEB9WC1zXo/vB4MPukozwl+zOZ9UAqm1MDOhIakhNhvpodb9fmrnFWqZd6Nsbqmv/G0y9NE6GQRkgg7csSqR71a6yitGOGSjDeifMkoXHi7B1VOW/68OsSXH3h63wztxQguhvQ0qbehpLZn26Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJFPrgweUbYgMQHtvWj25zohzbbwj4tGvIrwPukKhsw=;
 b=iczkoZib7JiFOkRr8Wrr7q8W2FZU/5tI/fOTzP8UMrsIEVc5rR2Ily2B/5N4RFRGWhEP2V8y/vm2sgYcKyi5JqmTnCP5KFQqI22ufEF8Je9jbZ7+vhaXBiFb6D/j/d9GSNLPHUQ/TwIgMTSpetoYbDyv1XuJo8BobrYb9zrMZ2xy/9ThnQlKdHjdvzXrer6GZ8tFgLJ8GuvYjs3Z+OKTBz6MizjsdRG1f0BoanMTEb0xykNXuQ2Wn66yo4omIbgEZwAgK3Yzkg/7dbRSPa/HmDwf2byeeT0NHVlgiauxJZEEJR1l4bYUYXYSOdW8kDHs0JiKbewhoBOPed2nlz8kXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJFPrgweUbYgMQHtvWj25zohzbbwj4tGvIrwPukKhsw=;
 b=lCumiTjLpxJSIcswBEht//pJEM/pfHIK4tJOfnmi4TJLR+QUY/1cGIFMvBILDIbWybLz04qX7Gz+WQ6YmdfnK00vmsUXGb2SHgFmiPwX51tujWzZ8WrMyPmued4wExgFLJn+X8DxXQoVKrh51dp5lhH6bIAOSdz4ItoKprH/fz0=
Received: from BY3PR03CA0009.namprd03.prod.outlook.com (2603:10b6:a03:39a::14)
 by PH8PR12MB7158.namprd12.prod.outlook.com (2603:10b6:510:22a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Tue, 12 Aug
 2025 03:26:13 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::d9) by BY3PR03CA0009.outlook.office365.com
 (2603:10b6:a03:39a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Tue,
 12 Aug 2025 03:26:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 03:26:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 22:26:11 -0500
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Aug 2025 22:26:11 -0500
Message-ID: <c627564a-ccc3-9404-ba87-078fb8d10fea@amd.com>
Date: Mon, 11 Aug 2025 20:26:11 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Issues with OF_DYNAMIC PCI bridge node generation
 (kmemleak/interrupt-map IC reg property)
Content-Language: en-US
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>
CC: <maz@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <aJms+YT8TnpzpCY8@lpieralisi>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <aJms+YT8TnpzpCY8@lpieralisi>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|PH8PR12MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: 04869163-1b65-4289-4555-08ddd94ffd63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUx1ekc0NEhlM0V5MThxQjBHdmIweE5ieFJoWmZ0U1lXcVhScUc2OVZTc3Jz?=
 =?utf-8?B?TENIQU1iRklDelpZeXNLZXlKcjZyUFhWOTNacngrNXRJTzI1MHB5b0t5R1p4?=
 =?utf-8?B?VGJERnZXQ3AxUUd6WC9JVWEyZEVtUU5WNWNvOGFqNjBBb1A5bnE2Vklibmw5?=
 =?utf-8?B?QzFFMFpvVm5wSEkrNTllWGZjUHcwNW9uR2d5S3VMWm96MDVseDQ1VmRFdnRQ?=
 =?utf-8?B?VDhVUnJWbXp0QVhqQk9Gemk3QmlyeFFPRUI0S2h5YktyRTNXR2ZTSWU5OS9C?=
 =?utf-8?B?VzV3dk9IRWRvcUJnY2dQRDR4bitEOElicVZLMDFzUElVaHE4NVl3Ylo2aith?=
 =?utf-8?B?ZHQxQjRQV3lWUW5PZkNLMW1HOVVES0ZHcFRyK2h3WE1LWHNVOE9Da0NFUDZu?=
 =?utf-8?B?YmRaTEgxMmtEUE4rTUtNdTU5c2RWZ0tSVGNCSEFLam9KODZPU2dVM1p6UUtt?=
 =?utf-8?B?cCt0dndXak1NZnMvRklLQ3FNcEpKRzkybGJoVm9STmpEcnkyeWMyNDVRdWE5?=
 =?utf-8?B?NTBOREZDYTJ0VkpaVlYveUFwaEtXQmN0MnpVUW5zWWxiNVlmdmIxdVV3V1VI?=
 =?utf-8?B?OE1sYVFSU3l5emRUQWJxVDZpM1NqR0VodzlKMWVyR0twWWRvMmhiNDA0ZDVS?=
 =?utf-8?B?R3laR3ZlVWtNN2hjNlZtVHM2N0p6Y21pNHZMdlI2eDBIdjh5c01vMmkzNDNq?=
 =?utf-8?B?WG4rdXNZTjJKLyswdDN4SDlQWXpRd0diY3I2UTlqcUhPcFM2RGtGenErZDJJ?=
 =?utf-8?B?dnhCSDdDWkt2THE5eG1vOWpwb2xvWFpQeXFEbWljTEdQL0ZuUEpnTS90a1gv?=
 =?utf-8?B?bUlxemhlM0VuajJlbGdUSjJJN0JJZ2IrN2hDWFBnQ0ZDMXJwNWhMNjNKK1Z1?=
 =?utf-8?B?Skdwd0NyZnUzMXdyaUx2VkQ3UDBlcXFlS2JQVWxhSWpNd293TkMzRDJ4bUhi?=
 =?utf-8?B?L2pzUytrMDV4a3pKaUVKNjJSYWhvQ1JXREJqUy80NFhvMU9qY3hUMWV0K2p6?=
 =?utf-8?B?VmNkbkc4a2RoOUp3UDZZZ1FFOStrWGJtMXE3dlhId2hDZ0FzQlVCbzg1bWk3?=
 =?utf-8?B?NjdtZ1NHMTBrOGdOUkYrbmhWQUxDWUZlUGV6OUxXdWxUQU5vZG1CNUhQVEJB?=
 =?utf-8?B?VVhHSUM4YVVUMUlsNS9ldExCZlpVSVhvVFhhWjZqU0RxUDEvRW5FUnhJZDA5?=
 =?utf-8?B?TFQrSktBVFMwTkZXbDNnVTc2OWFmb2hmS2pnUFEyVEdKZTBVbVArejVTWmFU?=
 =?utf-8?B?L0RDbDg2d0tTTFpDVk85bGZCYzlRL2UrTldFVjdzcytxcTloSmg3UEV2SzY0?=
 =?utf-8?B?aHRBOEFuWWFHaWJMNEV3WG94T3lvQUdINzZSTWw4Zmd5dmRCYy9SRy9janpo?=
 =?utf-8?B?TzN2WFpDRlBSYVlyamdES1pZdTJmZ0NNbUU5VXk1S2I4c1lJRUpKTGVpcnN0?=
 =?utf-8?B?WTY5UkJqNGdUc1RtaHRwc2ZLQy92UXNBSjc0VjIySjNRR3VtNHpva0hTWGdR?=
 =?utf-8?B?eXAyQW9Pd0NLdkFoVzh6VkIwOHRBQi9Na1QxdUJCd2tSalI1Y284SWpsQWdZ?=
 =?utf-8?B?RUkvRWpWZGZXb0F3ajViZU1QQkNhK2phT05vRDcxb2tpOWZNMjF1Z1czTTVz?=
 =?utf-8?B?WjljQW1EMVdKRk8yU0N4RGtPeXRDYXZTeXRWdFl5aUdkcmJsNUFYbnJRcE5L?=
 =?utf-8?B?K0s1RnFZTk4yYkRLRnR1Y3poOTN2d0FnbTRIR0NzK05ncTJodTM0ZjZ1ejVY?=
 =?utf-8?B?OTVEaE5mOHhOUkcwU2l2WnpIREZkdzg3a0pNSkdOamIvbmVTY1NFZG5JcWxZ?=
 =?utf-8?B?WkQzM1VCZ1JGeExkem1WZU8wcHRzSVZKUVJnMmpxOHhsMjA5cjl3cjI0OXpa?=
 =?utf-8?B?Zjg3ZHVoY0hsZzk2dXRGRkNsYy95M1Y5SElZMSt3c1NFU2lBdW9SSmhZcDY3?=
 =?utf-8?B?UmxxL3h5MHpZdkxCdW1ZOENVL2VqR0pZVmFIaEkvNE1KeVNvVUxNWWpURDRS?=
 =?utf-8?B?dUdUUitrdkpBPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 03:26:13.2514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04869163-1b65-4289-4555-08ddd94ffd63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7158

On 8/11/25 01:42, Lorenzo Pieralisi wrote:

> Hi Lizhi, Rob,
>
> while debugging something unrelated I noticed two issues
> (related) caused by the automatic generation of device nodes
> for PCI bridges.
>
> GICv5 interrupt controller DT top level node [1] does not have a "reg"
> property, because it represents the top level node, children (IRSes and ITSs)
> are nested.
>
> It does provide #address-cells since it has child nodes, so it has to
> have a "ranges" property as well.
>
> You have added code to automatically generate properties for PCI bridges
> and in particular this code [2] creates an interrupt-map property for
> the PCI bridges (other than the host bridge if it has got an OF node
> already).
>
> That code fails on GICv5, because the interrupt controller node does not
> have a "reg" property (and AFAIU it does not have to - as a matter of
> fact, INTx mapping works on GICv5 with the interrupt-map in the
> host bridge node containing zeros in the parent unit interrupt
> specifier #address-cells).
Does GICv5 have 'interrupt-controller' but not 'interrupt-map'? I think 
of_irq_parse_raw will not check its parent in this case.
>
> It is not clear to me why, to create an interrupt-map property, we
> are reading the "reg" value of the parent IC node to create the
> interrupt-map unit interrupt specifier address bits (could not we
> just copy the address in the parent unit interrupt specifier reported
> in the host bridge interrupt-map property ?).
>
> - #address-cells of the parent describes the number of address cells of
>    parent's child nodes not the parent itself, again, AFAIK, so parsing "reg"
>    using #address-cells of the parent node is not entirely correct, is it ?
> - It is unclear to me, from an OF spec perspective what the address value
>    in the parent unit interrupt specifier ought to be. I think that, at
>    least for dts including a GICv3 IC, the address values are always 0,
>    regardless of the GICv3 reg property.
>
> I need your feedback on this because the automatic generation must
> work seamlessly for GICv5 as well (as well as all other ICs with no "reg"
> property) and I could not find anything in the OF specs describing
> how the address cells in the unit interrupt specifier must be computed.

Please see: 
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html

2.4.3.1 mentions:

"Both the child node and the interrupt parent node are required to have 
#address-cells and #interrupt-cells properties defined. If a unit 
address component is not required, #address-cells shall be explicitly 
defined to be zero."

>
> I found this [3] link where in section 7 there is an interrupt mapping
> algorithm; I don't understand it fully and I think it is possibly misleading.
>
> Now, the failure in [2] (caused by the lack of a "reg" property in the
> IC node) triggers an interrupt-map property generation failure for PCI
> bridges that are upstream devices that need INTx swizzling.
>
> In turn, that leads to a kmemleak detection:
>
> unreferenced object 0xffff000800368780 (size 128):
>    comm "swapper/0", pid 1, jiffies 4294892824
>    hex dump (first 32 bytes):
>      f0 b8 34 00 08 00 ff ff 04 00 00 00 00 00 00 00  ..4.............
>      70 c2 30 00 08 00 ff ff 00 00 00 00 00 00 00 00  p.0.............
>    backtrace (crc 1652b62a):
>      kmemleak_alloc+0x30/0x3c
>      __kmalloc_cache_noprof+0x1fc/0x360
>      __of_prop_dup+0x68/0x110
>      of_changeset_add_prop_helper+0x28/0xac
>      of_changeset_add_prop_string+0x74/0xa4
>      of_pci_add_properties+0xa0/0x4e0
>      of_pci_make_dev_node+0x198/0x230
>      pci_bus_add_device+0x44/0x13c
>      pci_bus_add_devices+0x40/0x80
>      pci_host_probe+0x138/0x1b0
>      pci_host_common_probe+0x8c/0xb0
>      platform_probe+0x5c/0x9c
>      really_probe+0x134/0x2d8
>      __driver_probe_device+0x98/0xd0
>      driver_probe_device+0x3c/0x1f8
>      __driver_attach+0xd8/0x1a0
>
> I have not grokked it yet but it seems genuine, so whatever we decide
> in relation to "reg" above, this ought to be addressed too, if it
> is indeed a memleak.

Not sure what is the leak. I will look into more.


Lizhi

>
> Please let me know if something is unclear I can provide further
> details.
>
> Thanks,
> Lorenzo
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5.yaml?h=v6.17-rc1
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/of_property.c?h=v6.17-rc1#n283
> [3] https://www.devicetree.org/open-firmware/practice/imap/imap0_9d.html

