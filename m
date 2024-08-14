Return-Path: <linux-pci+bounces-11678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC699521D8
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 20:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2CA41F24046
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 18:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DC41BDA8E;
	Wed, 14 Aug 2024 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qCMimJA6"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FFA1BD509;
	Wed, 14 Aug 2024 18:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723659141; cv=fail; b=czTHsWqDyaaCcnHwrwLTnAbJwhJk9LQh49vDDS1XSSWjQhTg/c2d4UuX7kkjC3IBDYTM8OpaCzfBsNhue7YfOhO0bPmiIKpK3SCgQ3t60eSQKLnruj45bAoQ54HOl0u8wymvkFGG1KUzuT9KX0k6lIOnNoOEaa5ghYLb7TdLxyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723659141; c=relaxed/simple;
	bh=o4dfIunzq6h8DDdW5TyidbwaSVSoeJU8wVuirRIgP5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VOMmnY+JsFQ5AGfmij9d+rSjyJSiVtSbamBBPhu7I1PbFWs5YkoNU6Y0pHXmixhdaEMgQIhIk+vvhGCbnawW1SyFRuHykaWtpF/NTsgrBRYmt+qCiRcAfTmm74AI48WSEaY6bQJinTv0ioiyEKD5YD5om1NY0HySnZxuG80jG8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qCMimJA6; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CThBqjDroYNhNhCBtpjSgupIuauXeXcxnH1vFLkCBhqUsozFK5OoLugDjef+xpauinm0MgRqaTzsN8PNzLKe8gmbpaOO4NHBM8sacePZ7qxoasQNF6kScOwi9C6H5GDy92snKYIhe9wF1tlVkAsHfIBD6pNVCnEk4WxykJ8ceOri0q0ut0UKllbwsV9fZpCnKXk4g/iX6le8ZD6S9pyVTms7HQF/ux+tVrz0i1Lz7eWQkZKe4KC8RASDQrnGmdP+NLna0gHbSYNKx8qFJxf3NR6VbfQ79avcuT003LsiUTAUED3/pJ3ASQbl7gI0GFhb6U1eJ+BU6KVWwfjh4vAX4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfXy5zzabu6F7nEWXuv8tL3KEQj2Xs646mlLGjfoAS0=;
 b=gNCHPgg7kakS8HqWUSefVy02fCDvlb49rbs5wT7r+xYmucu+++twJiRal1plEiWGeyLBzIcWfhYYH7h9ektT8N95NvgCLAP9fnvcw7t62nEGTXO5JTvuuYVnq9NKnpqIhN50mB6qVv2RevEGqKmkqNlD1KHUGv6d31u0uKgl7tq+Y9Ma0llR9PiTSoS1Dwlf08LFj8igok4boJl52dL1laEK6p+iR9E/Io8tfwU5IAmJxkcppj9eKiomJyB/O4dV2eIzAd3Dczus2k+INzU1AGf/bxw/Y+f+jD7bNTXOVfImejhg9MdYF/9nTCx7BTPGyLZXKwhNcCAWXzo1LKNvxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfXy5zzabu6F7nEWXuv8tL3KEQj2Xs646mlLGjfoAS0=;
 b=qCMimJA6e3Zo48hH4Q7FVaCXlhXYtIcwztvZhX0aWOPkLT/jAcmrw4isGcAYh5at+TKZA7/zA2EmkrgvVGr3BNz+qo7vaQQBYHpUB3zUuqDy3Uz/Iz7RdQV9CLjDb+EsaU8USs3qgL0s7y4br2rPU//p/ziexqLa+qiktebzMRI=
Received: from PH7P220CA0120.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::22)
 by SA3PR12MB9226.namprd12.prod.outlook.com (2603:10b6:806:396::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Wed, 14 Aug
 2024 18:12:16 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::96) by PH7P220CA0120.outlook.office365.com
 (2603:10b6:510:32d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Wed, 14 Aug 2024 18:12:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 14 Aug 2024 18:12:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 13:12:14 -0500
Received: from [172.23.60.101] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 14 Aug 2024 13:12:13 -0500
Message-ID: <cc986313-4eb3-4ec9-a217-5d8dac141fe9@amd.com>
Date: Wed, 14 Aug 2024 14:12:08 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] PCI: Restore resource alignment
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240808215443.GA158993@bhelgaas>
Content-Language: en-US
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
In-Reply-To: <20240808215443.GA158993@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: stewart.hildebrand@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|SA3PR12MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e4265dd-a94d-48e5-46fc-08dcbc8ca0cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjJVWVI5cnViRWRldXNpVXQvL2FGbTFqUnVhUVM0bjQ4bXMycHBCb3g5YUFJ?=
 =?utf-8?B?VjB5NzNac0NseHM5VzA3eHhFMEFmV3hrTUJkL1lZTWRkTnNVa2dKTHFldUJj?=
 =?utf-8?B?UUVVUVFKYTRidGorV1hOTGQvZm1yZ2JlY0Ivc3h2bEhXQ0xxT3ptWWtuZWV5?=
 =?utf-8?B?QU9rVy9NL0wveGNnc2lSdUF3SlFHVXlXR0ZRUzRQbXlZbXhaZXVNbFgxbmNj?=
 =?utf-8?B?VjZiQlhCM041RjA1bWFYV3ZDZHVpek9yS3lWczJCSDMrS2Q2a3kzSmxSdlRZ?=
 =?utf-8?B?Tjc0R2hzQ0lvQ1hMRUFlYmNaQ1pWYVpnR2FBb0I0c2V0N0R5bS93anRjOFdu?=
 =?utf-8?B?clBZYlVMMHFjc05uTFhCcDJnWWJLZ3ZROE41dTRxRE0zTXBmNU5UcXUrSWNV?=
 =?utf-8?B?d0U0Tmlnc2hKaTc0bXYwdFgrdkVTZHRwYUFJVmlBOGRpYi9rVTBEcjc3V0JI?=
 =?utf-8?B?S2RJSGxSVDZDU0RDKzNxbzdOMVh1K2F2RFRxU2lNRktZSEYwYjBmbUdTV1BJ?=
 =?utf-8?B?RGZ3K1pNaE1Id2NzL3NaaWFyTXVyQVROREpMbGNFZytBZ1lsNlU2QXVYZEZH?=
 =?utf-8?B?bER0ejhoSVMxRE9QdW8yRXdjaFdGcHd6NTdjT2kwUFByZFQ2OTNGWDBRTVl5?=
 =?utf-8?B?cS9NVTV3MHNTUHNqdnZxM1RSbFpNTzFabFRXbURlVlpuUGpMa0RSbVFrZ3Vm?=
 =?utf-8?B?eTVTanJ2T1N2REgxWWtoRVJUVGx0MlBpU05xNkIzcjRSWXQva1R6cWIxSTJH?=
 =?utf-8?B?TFE3TFhpaXM4c0pudTBlcDBHemlPZEZ0NUo2dklnQ3RMbDRsRXIwT2dUckVj?=
 =?utf-8?B?dmZvT0VTN2hVMGZIMVY1V0VOampPZzMrbmppaDBVODFsSXhyMkYybXZrUnNo?=
 =?utf-8?B?eFlYQ2hmQStxbUdXTEdRenE1ZUJpNHBpZnJYNkhqVS9ZMGo5N2lHQlB1UERY?=
 =?utf-8?B?SHcwNzNKb3p6cHdhV05qQ1ZnRWZIVmN0anJnb29ja2xrdnFGeXJHQjY1TWRK?=
 =?utf-8?B?VS9EelRGY0F6aEUyMkFwaTVXVkQ3emp1elE1dC9hK0hybGsvMEt1bHR6TUNH?=
 =?utf-8?B?V3ZIYXp6S1F0S2dTcENzK3RHLzRFWDYwcWJKam1YUnNMdnJMOCtWNHhyK0F5?=
 =?utf-8?B?Y3V6RytGUndNWFkvMW12WStCOGRiQ0VXeWlueFlYYlRybmtsazlkei9RV1VD?=
 =?utf-8?B?L09SMzM5QklDNENMWCs1aldBYWFOQnhJSkhOWXdHYVhFL3N3ZE5xeEF3VmFO?=
 =?utf-8?B?YzkyRStHSlBYZGlUMkJMV3Nudm5iQnZET3NCMTBIUnRJckJjUDVWdVZzOEZw?=
 =?utf-8?B?MWJEUXNiaHBZRHZtUU9jQ0FabmgvYno0SnIzV1A2dU9vUXlhQWQySmFIUm5K?=
 =?utf-8?B?bXJza0xKbVNJVmVVRDRGN2VGb3BLZ3pRSlFCMTRxbG5GYnRHN2tqME5mcVRl?=
 =?utf-8?B?RER6OHFPK1FxUXZsNzh5RWVoK2F0NnZxeUtzTmVRWFEzaWJmSUt4cnpNK3VR?=
 =?utf-8?B?TS9jVnBvT1JIV3phbEU1elc1cE9LWUJ6cmV6TC92aWxkTUQ3YkZhNnJYY0g2?=
 =?utf-8?B?Sk83MG9WNEQrSWFzTmJxSXc5YkE5WmN0YzJUZm5vVE1wbXFLNlpteWVmd2FM?=
 =?utf-8?B?SXJzRzBiTmpJNGxzQzI5ZmRNYXVMK3Jqd2t3d0pQRzVEdkg4TXE2SjA2STdD?=
 =?utf-8?B?RjlDU0swYTZXNW9VdktCNTZIN01jSENFRGFneDhxNGNxdE9hdkdBWGpZT3Ro?=
 =?utf-8?B?NlFkZWhGWngzayt6Q25mTFhiVEx2OTVEdEpzR2N0OWswb2NZSGlKQmwrN1Jt?=
 =?utf-8?B?Y201YUNJbWd3YnZUczVzVFJZT1JBUzJYN3JKa1NZNmZaVHlRR3Zwd0cvYXVM?=
 =?utf-8?B?UmJxY1JjbmhaSG5iM3VlZ09sNG9DSWZRallvTW9qVEcwN1l5OGY4S3J4UCto?=
 =?utf-8?Q?QubFWT84leactj5hSSRQCK8GzGlYGYHb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 18:12:15.7143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4265dd-a94d-48e5-46fc-08dcbc8ca0cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9226

On 8/8/24 17:54, Bjorn Helgaas wrote:
> On Thu, Aug 08, 2024 at 04:28:50PM -0400, Stewart Hildebrand wrote:
>> On 8/8/24 15:28, Bjorn Helgaas wrote:
>>> On Wed, Aug 07, 2024 at 11:17:12AM -0400, Stewart Hildebrand wrote:
>>>> Devices with alignment specified will lose their alignment in cases when
>>>> the bridge resources have been released, e.g. due to insufficient bridge
>>>> window size. Restore the alignment.
>>>
>>> I guess this fixes a problem when the user has specified
>>> "pci=resource_alignment=..." and we've decided to release and
>>> reallocate a bridge window?  Just looking for a bit more concrete
>>> description of what this problem would look like to a user.
>>
>> Yes. When alignment has been specified via pcibios_default_alignment()
>> or by the user with "pci=resource_alignment=...", and the bridge window
>> is being reallocated, the specified alignment is lost and the resource
>> may not be sufficiently aligned after reallocation.
>>
>> I can expand the commit description.
> 
> I think a hint about where the alignment gets lost would be helpful,
> too.
> 
> This seems like a problem users could be seeing today, even
> independent of the device passthrough issue that I think is the main
> thrust of this series.  If there's a problem report or an easy way to
> reproduce this problem, that would be nice, too.

Oh, sorry, I just realized that it's only alignments with
IORESOURCE_STARTALIGN that get lost during bridge window realloc.
Specifically, r->start gets overwritten in __release_child_resources().
There are a few code paths, such as the one in
__release_child_resources(), that assume IORESOURCE_SIZEALIGN. In case
of IORESOURCE_SIZEALIGN, the alignment is restored by a simple
calculation. However, with IORESOURCE_STARTALIGN, we can't use a simple
calculation, instead we need to consult
pci_reassigndev_resource_alignment() to restore the alignment. I'll
update the commit message.

An alternative approach might be to store the alignment in a new member
in struct resource, thus saving us from having to call
pci_reassigndev_resource_alignment() for each PCI device on the bridge
undergoing reallocation.

BTW, this patch and the two "[powerpc,x86]/pci: Preserve
IORESOURCE_STARTALIGN alignment" patches could potentially be folded
into a single patch as they're all dealing with fixing
IORESOURCE_STARTALIGN.

To repro the issue on x86, we will need to apply this series except the
current patch [3/8].

I ran into the issue with the following device. Let's call it example 1.
Scrubbed/partial output from lspci -vv:

	Region 0: Memory at d1924600 (32-bit, non-prefetchable) [size=256]
	Region 1: Memory at d1924400 (32-bit, non-prefetchable) [size=512]
	Region 2: Memory at d1924000 (32-bit, non-prefetchable) [size=1K]
	Region 3: Memory at d1920000 (32-bit, non-prefetchable) [size=16K]
	Region 4: Memory at d1900000 (32-bit, non-prefetchable) [size=128K]
	Region 5: Memory at d1800000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [b0] MSI-X: Enable- Count=2 Masked-
		Vector table: BAR=0 offset=00000080
		PBA: BAR=0 offset=00000090
	Capabilities: [200 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy+
		IOVSta:	Migration-
		Initial VFs: 4, Total VFs: 4, Number of VFs: 0, Function Dependency Link: 00
		VF offset: 6, stride: 1, Device ID: 0100
		Supported Page Size: 00000553, System Page Size: 00000001
		Region 0: Memory at 00000000d0800000 (64-bit, non-prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Kernel driver in use: pci-endpoint-test
	Kernel modules: pci_endpoint_test

BARs 0, 1, and 2 are small, and the host firmware placed them on the
same page. The host firmware did not page align the BARs. There is also
an SR-IOV BAR that the firmware couldn't fit in the bridge window.

In example 1, I did not specify pci=realloc=on. I used a kernel with
CONFIG_PCI_REALLOC_ENABLE_AUTO=y, and the SR-IOV BAR triggered the
bridge window realloc. Alignment was requested for BARs 0, 1, and 2 of
this device, using IORESOURCE_STARTALIGN, because of patch [8/8]. The
alignment was lost during realloc.

Such a device from example 1 may be hard to come by, so here's a way to
reproduce with qemu. Example 2:

01:00.0 Unclassified device [00ff]: Red Hat, Inc. QEMU PCI Test Device
        Subsystem: Red Hat, Inc. QEMU Virtual Machine
        Flags: fast devsel
        Memory at fe800000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at c000 [size=256]
        Memory at 7050000000 (64-bit, prefetchable) [size=32]

01:01.0 Unclassified device [00ff]: Red Hat, Inc. QEMU PCI Test Device
        Subsystem: Red Hat, Inc. QEMU Virtual Machine
        Flags: fast devsel
        Memory at fe801000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at c100 [size=256]
        Memory at 7050000020 (64-bit, prefetchable) [size=32]

01:02.0 Unclassified device [00ff]: Red Hat, Inc. QEMU PCI Test Device
        Subsystem: Red Hat, Inc. QEMU Virtual Machine
        Flags: fast devsel
        Memory at fe802000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at c200 [size=256]
        Memory at 7050000040 (64-bit, prefetchable) [size=32]

01:03.0 Unclassified device [00ff]: Red Hat, Inc. QEMU PCI Test Device
        Subsystem: Red Hat, Inc. QEMU Virtual Machine
        Flags: fast devsel
        Memory at fe803000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at c300 [size=256]
        Memory at 7040000000 (64-bit, prefetchable) [size=256M]

This example can reproduced with Qemu's pci-testdev and a SeaBIOS hack.
In this case we will need to specify pci=realloc=on to trigger the
realloc because there's no SR-IOV BAR to trigger it automatically. Add
this to your usual qemu-system-x86_64 args:

    -append "console=ttyS0 ignore_loglevel pci=realloc=on" \
    -device pcie-pci-bridge,id=pcie.1 \
    -device pci-testdev,bus=pcie.1,membar=32 \
    -device pci-testdev,bus=pcie.1,membar=32 \
    -device pci-testdev,bus=pcie.1,membar=32 \
    -device pci-testdev,bus=pcie.1,membar=268435456

Apply this SeaBIOS hack:

diff --git a/src/fw/pciinit.c b/src/fw/pciinit.c
index b3e359d7..769007a4 100644
--- a/src/fw/pciinit.c
+++ b/src/fw/pciinit.c
@@ -25,7 +25,7 @@
 #include "util.h" // pci_setup
 #include "x86.h" // outb

-#define PCI_DEVICE_MEM_MIN    (1<<12)  // 4k == page size
+#define PCI_DEVICE_MEM_MIN    (0)
 #define PCI_BRIDGE_MEM_MIN    (1<<21)  // 2M == hugepage size
 #define PCI_BRIDGE_IO_MIN      0x1000  // mandated by pci bridge spec
@@ -1089,6 +1089,7 @@ pci_region_map_one_entry(struct pci_region_entry *entry, u64 addr)
         pci_config_writew(bdf, PCI_MEMORY_LIMIT, limit >> PCI_MEMORY_SHIFT);
     }
     if (entry->type == PCI_REGION_TYPE_PREFMEM) {
+        limit = addr + PCI_BRIDGE_MEM_MIN - 1;
         pci_config_writew(bdf, PCI_PREF_MEMORY_BASE, addr >> PCI_PREF_MEMORY_SHIFT);
         pci_config_writew(bdf, PCI_PREF_MEMORY_LIMIT, limit >> PCI_PREF_MEMORY_SHIFT);
         pci_config_writel(bdf, PCI_PREF_BASE_UPPER32, addr >> 32);


