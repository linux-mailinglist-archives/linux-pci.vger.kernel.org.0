Return-Path: <linux-pci+bounces-11680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06091952212
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 20:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE141C2133D
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 18:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A460F3BBCB;
	Wed, 14 Aug 2024 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TiZ6ZWcD"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CC5B679;
	Wed, 14 Aug 2024 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723660272; cv=fail; b=ghneQx/U1OieZZw8BUwSiQEVVwBfA/oHCs2wVqExj510sTaSzWXymRchw8WZ+cqfYSn00G8SIsveGJv12/pAoZ1bzWEyTxAymPK2IsU4MbzlYMuiKB5FWmGQKmyMDeFKgHMxFi8trEFVP+87RXCEmwXj30jXNx+aP3eoMfoFi2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723660272; c=relaxed/simple;
	bh=KI4bxaVF5AYshXmq9F0g7G4/mdPW8FOmvuJRH2pm+zQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nIXHOUa/1BEbWQn98S4LnXyMZ7OsQ+DGaHHbZgGofqplPDL/eq0zhN2IoPxYtX/s6a1+zk0ubqPvbQS5sv4IBSPXQxgF4m9a+MRvUVeEwnPu6kkDEO01V6ic5MEyftG3qwclpn9s2Vk+ZlYFvD4CHUkGHq0GxZUeCug9mB/lJ1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TiZ6ZWcD; arc=fail smtp.client-ip=40.107.96.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZ6fKCSJ9hFmGPi+Nmsur0LT4tqjiG4xo7nGid1pF4e0gKzqNlFt2xX5fa80/F9IxpfC+TpMoq//qb7B2TJBopOQSn1aVSyuck+K7CuxePNKr9ZNYygDSkEVKxXkxPxrb93trT5X3CYGVGo0balhH8UNkrTXAs7pxTlUILI/wJkL9fmlXqNLLRsc0uqgns9e1DGM9RFRHPlEl6vblnMGr4musICAcJ0DuG6iCeW+GmJkcu8fIKyk0uh1R5op0PW+hXGY6SAaP7F1Iz98tmlFOxnD9FCT9gwuQPCjI2TDwG2UwYH6ZA3reGIhZyLxB7LHMczIKx0fkMtCLKcLYIgf8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqk1p4drJ0V7KrOzfwGN33m/2KR8om5U+vPMToWOPBU=;
 b=yCzkRVDNxImBbUr4844AghXX16WINdDcm7Ie3OaNS/fK2OK9rN7V9QAkC8l3JfIlhDZFGvSwX6mtJYrgY1XVP5hbbJV4ENjgZzvjgzOrTQQryBo8vk7Ae2I24Jg92/hAYu7Pj0PShiyzZtj6qptdnhpaO7Pi9fGkINrCzrRJZYsv52alh6MqlFt4W/ePRdH6jYlbNAGIKvlDIpqi1F6znCSIFOIORQ/UKQ68JexQV8zW82qMEMYYASNF++LIkcXPl2LeGAOInAz/Ra45rSYuuCzn8OveYH4uH9icDzgxo0KrTwex2ynRu3vyArfXegJo1ttSjH25oMZf5rldXDXalQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqk1p4drJ0V7KrOzfwGN33m/2KR8om5U+vPMToWOPBU=;
 b=TiZ6ZWcDNM1/+HFCBDOG32rKSexQd0fMcSXJSCEWWqBTvlRGZLQX341zj9MAm7LnAge+Ehl9ggqJPtSFn1djey1e/mjB/2rbtySHRRKiR80k+AdWs6R+QeciuCwRc/UGtB9qaLr0ynN8b6k2Vu6NHiYMJ+h/ldfFnDKG2jvpgJM=
Received: from SA9PR13CA0104.namprd13.prod.outlook.com (2603:10b6:806:24::19)
 by SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Wed, 14 Aug
 2024 18:31:07 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:24:cafe::45) by SA9PR13CA0104.outlook.office365.com
 (2603:10b6:806:24::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Wed, 14 Aug 2024 18:31:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 14 Aug 2024 18:31:03 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 13:31:02 -0500
Received: from [172.23.60.101] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 14 Aug 2024 13:31:02 -0500
Message-ID: <1810d450-de90-4403-bf1b-0dfb4a6a3442@amd.com>
Date: Wed, 14 Aug 2024 14:31:01 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] PCI: Restore memory decoding after reallocation
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240808193731.GA156598@bhelgaas>
Content-Language: en-US
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
In-Reply-To: <20240808193731.GA156598@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: stewart.hildebrand@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dba754f-de3d-4d20-68c8-08dcbc8f40d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	Cjcpd/PD2m91RlOfcwdPZJBVg1bh9L/ZiuhKCHVkHPjuY6Qd5YxMX8ndS2+nSr2SuFphzuTR0dEgceD6+JVI5mxW2HKftqI/pO49P3fOQMEsaob/NWCvNnrT+XxCBaEAdR50zmnVDhQ2JSwRHA5L9IaWv3bJiVqyKg+FyF2ARZ/xjp8jCY26lPtZWhSr+EHn0xD4Pb4E2nHiLGFjiEEqNV8iH4MocVneVPyWz248Q+Cw1LLYKXvrX79XHE0h25D2j2ZDN4nnoCLezlPTKzIL6tPrFDzumu7VBHsI7HIv/n2af7JBAzlPQXPCG3vvFbSniq/tn/wy9POeC+8GiaNNEHBazqfRqgML7OaVVQXsBoMxoopD/80dQz0L/RVHZE0sVcf74ahufJEu75qeiFND/WyAtbcvJDKceHKqwg2x3DZGvik+UGtw0AJUiQW7yu3uKXq0Ml0LTYuEATJwh6ypMUIejeVe5VHRPdhsxZqhCamnx3caZ3+K2ymXCbwm3XfmH8e5dBBZ/Q4eP0HwqM014E1jVkT9Z9YYGROuG+7/9/OpzQr3rDEoGuB7dojykH7ENF1Uz2P2KePm08sxPx8YWh11a09x2n08a8OiqBPSH091F/016k9gNnzs3g3mnQ5qKUpWvI+QEv6ATx3HwACfssPE6neujgXeYJ1trHEy4vx8bYcc3ZW4lF8r0Ic/YdtHNNodbb1BMEuLoXbonWB6RA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 18:31:03.2641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dba754f-de3d-4d20-68c8-08dcbc8f40d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723

On 8/8/24 15:37, Bjorn Helgaas wrote:
> On Wed, Aug 07, 2024 at 11:17:13AM -0400, Stewart Hildebrand wrote:
>> Currently, the PCI subsystem unconditionally clears the memory decoding
>> bit of devices with resource alignment specified. While drivers should
>> call pci_enable_device() to enable memory decoding, some platforms have
>> devices that expect memory decoding to be enabled even when no driver is
>> bound to the device. It is assumed firmware enables memory decoding in
>> these cases. For example, the vgacon driver uses the 0xb8000 buffer to
>> display a console without any PCI involvement, yet, on some platforms,
>> memory decoding must be enabled on the PCI VGA device in order for the
>> console to be displayed properly.
>>
>> Restore the memory decoding bit after the resource has been reallocated.
>>
>> Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
>> ---
>> v2->v3:
>> * no change
>>
>> v1->v2:
>> * capitalize subject text
>> * reword commit message
>>
>> Testing notes / how to check if your platform needs memory decoding
>> enabled in order to use vgacon:
>> 1. Boot your system with a monitor attached, without any driver bound to
>>    your PCI VGA device. You should see a console on your display.
>> 2. Find the SBDF of your VGA device with lspci -v (00:01.0 in this
>>    example).
>> 3. Disable memory decoding (replace 00:01.0 with your SBDF):
>>   $ sudo setpci -v -s 00:01.0 0x04.W=0x05
>> 4. Type something to see if it appears on the console display
>> 5. Re-enable memory decoding:
>>   $ sudo setpci -v -s 00:01.0 0x04.W=0x07
>>
>> Relevant prior discussion at [1]
>>
>> [1] https://lore.kernel.org/linux-pci/20160906165652.GE1214@localhost/
>> ---
>>  drivers/pci/pci.c       |  1 +
>>  drivers/pci/setup-bus.c | 25 +++++++++++++++++++++++++
>>  include/linux/pci.h     |  2 ++
>>  3 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index acecdd6edd5a..4b97d8d5c2d8 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -6676,6 +6676,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
>>  
>>  	pci_read_config_word(dev, PCI_COMMAND, &command);
>>  	if (command & PCI_COMMAND_MEMORY) {
>> +		dev->dev_flags |= PCI_DEV_FLAGS_MEMORY_ENABLE;
>>  		command &= ~PCI_COMMAND_MEMORY;
>>  		pci_write_config_word(dev, PCI_COMMAND, command);
>>  	}
>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>> index ab7510ce6917..6847b251e19a 100644
>> --- a/drivers/pci/setup-bus.c
>> +++ b/drivers/pci/setup-bus.c
>> @@ -2131,6 +2131,29 @@ pci_root_bus_distribute_available_resources(struct pci_bus *bus,
>>  	}
>>  }
>>  
>> +static void restore_memory_decoding(struct pci_bus *bus)
>> +{
>> +	struct pci_dev *dev;
>> +
>> +	list_for_each_entry(dev, &bus->devices, bus_list) {
>> +		struct pci_bus *b;
>> +
>> +		if (dev->dev_flags & PCI_DEV_FLAGS_MEMORY_ENABLE) {
>> +			u16 command;
>> +
>> +			pci_read_config_word(dev, PCI_COMMAND, &command);
>> +			command |= PCI_COMMAND_MEMORY;
>> +			pci_write_config_word(dev, PCI_COMMAND, command);
>> +		}
>> +
>> +		b = dev->subordinate;
>> +		if (!b)
>> +			continue;
>> +
>> +		restore_memory_decoding(b);
>> +	}
>> +}
>> +
>>  /*
>>   * First try will not touch PCI bridge res.
>>   * Second and later try will clear small leaf bridge res.
>> @@ -2229,6 +2252,8 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
>>  	goto again;
>>  
>>  dump:
>> +	restore_memory_decoding(bus);
> 
> The fact that we traverse the whole hierarchy here to restore
> PCI_COMMAND_MEMORY makes me suspect there's a window between point A
> (where we clear PCI_COMMAND_MEMORY and update a BAR) and point B
> (where we restore PCI_COMMAND_MEMORY) where VGA console output will
> not work.

Yes, there is a brief moment of garbled junk on the display, but it is
not fatal. The VGA console display returns to normal after the bit is
restored.

> This tickles my memory like we might have talked about this before and
> there's some reason for having to wait.  If so, sorry, and maybe we
> need a comment in the code about that reason.

I don't have a strong opinion on which way to go with this, but my
understanding is that we want memory decoding disabled while r->start
doesn't match the actual BAR value. If you agree with this rationale,
I'll add something to that effect in a comment.

See the prior discussion at [1] (link above), and discussion from v1 of
this patch [2].

[2] https://lore.kernel.org/linux-pci/1d0b52bd-1654-4510-92dc-bd48447ff41d@amd.com/

>>  	/* Dump the resource on buses */
>>  	pci_bus_dump_resources(bus);
>>  }
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 4246cb790c7b..74636acf152f 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -245,6 +245,8 @@ enum pci_dev_flags {
>>  	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
>>  	/* Device does honor MSI masking despite saying otherwise */
>>  	PCI_DEV_FLAGS_HAS_MSI_MASKING = (__force pci_dev_flags_t) (1 << 12),
>> +	/* Firmware enabled memory decoding, to be restored if BAR is updated */
>> +	PCI_DEV_FLAGS_MEMORY_ENABLE = (__force pci_dev_flags_t) (1 << 13),
>>  };
>>  
>>  enum pci_irq_reroute_variant {
>> -- 
>> 2.46.0
>>


