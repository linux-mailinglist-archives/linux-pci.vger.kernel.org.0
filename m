Return-Path: <linux-pci+bounces-33865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E86BDB22C8E
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 18:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6C774E312F
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 16:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CF32FFDF4;
	Tue, 12 Aug 2025 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tO8f+uI8"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4A92FDC40;
	Tue, 12 Aug 2025 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013995; cv=fail; b=ZSzcHCjraWCXEe7qb0bUp4AVlOEc9dKafVRcKOVzw5hpweLsMVtOAnpha3f7YtGsCxERUOjRWbKFdDU6gKC/e913IbFR89PRAngwdbIWW10qLMZxVn5m7a8qhjGjO+ChpwM5hj91tT/gLoL04eZT5p9jMQUDqvFCFK7lYQC8JrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013995; c=relaxed/simple;
	bh=VjOOXK9lgNce2wIuyq8/gdU1UqF5k80boMLd1x+bWMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HFLs0dBRioDNmvrfEzw77XyAFNHCuE7W019r/MAikOWAG5w/kn96onLi4nks4gDvzSNibI+kou9D6JUnWazqqNnOOeaKKUC3o2xliRUlnuvHSBVJEEcuXZnSzJLj4XqaeX2rB02wq8OjYA7J+ggNZF9SzGtScUk/bM8ZuR1mWTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tO8f+uI8; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRLH2s3aTlvtay16osA15A9M5BAD6fjZZux9Ma3E9TpOyFSJkgCIP+2JdiMGTOBusLIOXM7hOE43WOJsf+QATf+G/Lr+z/kX2NOwZjvQUHKYFMdQtMySKdyX0VI5RByddleVx7+PHOJRe8tRjW+bn2wB7cBenfBBNeRFlPjlXCxRPmokRiu3ghn6bnZbjLNrUWJ1xqZjNoJq20VZBL4s9PeKIhd0K+27Yff91kDsxEb1UeI2uEnkq63zB/lBWW0/AhO1YVCPfQO/sP/nB/8Z2lVQj3RXm8lsBHpszuyKpJQ/FneroS/tIeCD9CQk6AIA4ATRgCZT2CqFhNGGiXEVOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbkxOAWk9d1j96IpZYOdIzPDOMNprbtXCJUQ1iRoQTw=;
 b=JJPJ3hMlFOtKW+AAyCYbHBBL1gKDL+hxvLaL6L7hTUVs9zpYJ7NJxXgN14IiPPd6E8raqMr8/zFuRmZaKd6YBaUiKJOC2Hb0iUKu7xeDKo0MlrbnUfmll9hjHpxlUhO+dBOrjqVvhSF8wSoWiuG9xnREFtScRAZJVLsJ6KOuFtaqrQFyTo30vmIU8nQRoswmIdmyrDOtsg8bQzn6c305Ci6dlR0Mn2/f2OGeBzIRiWw3ff/i3Ju6Xvd95pTbNLZVthyoXzhNr8hi2PBsrvQmCcgTPhL6MDGZliRewkh6NSHL6v1D2AKIFuNsIQAHsmP7gc2B+Vt8VGjAtCAhFx3elg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbkxOAWk9d1j96IpZYOdIzPDOMNprbtXCJUQ1iRoQTw=;
 b=tO8f+uI82zLpxBoT1dIEQ6IY5K0hSDO4d/afnv3FyvOqrpLwWXE//r8uHVTjaDtNeLrGhAO3tF7r3QZ5c45JM262xYgjr1JWeWGxPEWh24cBQiLQ/hgKEZAVkSNhePu5UstyI/L4bYcEgDK6e08rbC5R9y+TEtRbIvm/ThhVxEI=
Received: from SJ0PR13CA0197.namprd13.prod.outlook.com (2603:10b6:a03:2c3::22)
 by SA3PR12MB9228.namprd12.prod.outlook.com (2603:10b6:806:39c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Tue, 12 Aug
 2025 15:53:11 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::fe) by SJ0PR13CA0197.outlook.office365.com
 (2603:10b6:a03:2c3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.14 via Frontend Transport; Tue,
 12 Aug 2025 15:53:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 15:53:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 10:53:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 10:53:07 -0500
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Aug 2025 10:53:07 -0500
Message-ID: <e15ebb26-15ac-ef7a-c91b-28112f44db55@amd.com>
Date: Tue, 12 Aug 2025 08:53:06 -0700
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
 <c627564a-ccc3-9404-ba87-078fb8d10fea@amd.com> <aJrwgKUNh68Dx1Fo@lpieralisi>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <aJrwgKUNh68Dx1Fo@lpieralisi>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|SA3PR12MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: c72ad43b-c170-47dc-c6f6-08ddd9b8561e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEVyMnMvRHNEWlRRcktoNTR6amhxWVNPdHZJZzdvTjhZTlkvTWlQcXdhNUFR?=
 =?utf-8?B?NFcrTWNhNW5TNEJZcFRSN2J3eGxyQkRhRDZiMHc0ZWIxR3NvekJKV2hmSzMw?=
 =?utf-8?B?QTBNYmFmbTBqajlXY1VUa2ZCVHByRVdKaG9GeWhXeUNPSUEzT2lTTmJCUzZR?=
 =?utf-8?B?SHZmVmF3L0tHemcwdVFiRXpXVGdSSVYxY1ZKM3M3TGdZUGRRT0J3V2V2MWRz?=
 =?utf-8?B?U09CVS9lcXlvQnlUSEZ6bE4xdDBvRzY1bXFvT1l2QStoVGk4eTN4WlBmQXhB?=
 =?utf-8?B?NkJta2FpTVpUdjk3M2UvYVB1blBWaTJYUWdyb2xGU1BBUFo1dVgxaVIxbk5u?=
 =?utf-8?B?Yi9zclF5YXVZM3ljak5tQlhSTlNCaVB0MlR6d0pIT2pCQmQ2K3J5V3lBcVc1?=
 =?utf-8?B?cVJsM0xzejU4Z2ZwWVJXTnRwMlhxVFA0STFGbTBPZTdnZkJQNDdkekxSWWRz?=
 =?utf-8?B?ODZFWUZCN2lLZDVqNUZWV3ZmQ3pxdVg3OWx0QmNRdzR0N3RUdGFIRjBaT1NS?=
 =?utf-8?B?eHhmUEtEbW54bENSOGxwbERlcHFXUFdTSzlGM1l1YUNvMVY3eE1Va0JtSUpY?=
 =?utf-8?B?VnhONmMyamswbWhMQTZqWm1NU24zcVlBSUtzaTRvdUQweGNtdWZZUk9hcWY3?=
 =?utf-8?B?d0VNd0RPM1MxSUc4c0p1d0J3SzMyZ2ZBV3p3YS9nRjFuOWxmd1ROUjNVcWMw?=
 =?utf-8?B?bmVya3YvNEhZL0hvSVViYUYydTVGRS84NW1vTUVUb29ySTcxY21UZFk0MC9u?=
 =?utf-8?B?Sm1JbHZrUHk4UjF0elNJZW55S084cjR5RHZRTVB1Q0g4TjFjVW45RDhyNEJm?=
 =?utf-8?B?NFNISjRKeWVwOFQ2cW13SkdQU2ZtNWpBYWVTc1dnVVhYODB3a0VWL2hCYjBJ?=
 =?utf-8?B?VEFwdEdadUg2RjJtdXhleWRNWGRrN1BxTlIrNkFCTlltbjNmSXRCaTdnZFFm?=
 =?utf-8?B?Y3lDSVZDVWFGTGVtQzlDK3BsZ1hQSGE1T3pZeW42MVFhaG5XbWxtdE5ZeDFr?=
 =?utf-8?B?a215UWFleG9pOVZGV2VFcW1HQ3B0TDFqei9maGNqbmJmd20zd0wyeWJ6b2Jq?=
 =?utf-8?B?cmplUk9nMjJyZ3BMQ3BNVW5DbE1GTjBNdXZvcUl4ZU51TTNVditNU2FuSDln?=
 =?utf-8?B?V3JWYXl2THF0SnVUMW1ZblVkNC82Wm9VNjNBQkJDenhsWUFTVHo4WlIzdHhM?=
 =?utf-8?B?aXFzblloZ2o2UmdVNDVreldmWFJXMWN3cTlrZVIwZndQeXZoV1lYN3hmMGRx?=
 =?utf-8?B?NGxoOXpmQ1ZNTjlubnpvZVZBVXVxREdBNXFCdHkrallSendDWWpKZVViTEJw?=
 =?utf-8?B?b0tLUmp5eG1SR2VOY1ZLTWxhK0J2ZlFweERBK1c2NHI4TnpqY1ZZbzBrRkIz?=
 =?utf-8?B?dHlQelRBWkQwNGJ4T3g0SU10ZVpRbVV2aUxCMytoR1hmVi81RHBmaG9SNlZw?=
 =?utf-8?B?SkJMODN1OXZsaW0wUmE5RWNRaExKamNFRFNqRTJVcTE3MWVNamdyYUcyLzB0?=
 =?utf-8?B?QTV5US9KNmJ6MjBVMk5EbHpUazB6dGFMa0pTWHhraWZ4aFloTUMxcTduVUE0?=
 =?utf-8?B?cERtQ1VGQUFoL3JkOVBzN2lURGdSRjk4dkVmTVUxazRWamdtNGR2VFJmQ2Jy?=
 =?utf-8?B?eGhTQUVDb0FKQmNWcGc3VEhzSGJ0MkxnU21Ca0pUbXlub2dtWnV4YUxWVkNs?=
 =?utf-8?B?YWl2UU5md1NyZGJoTThlSnFkdXlNQWVBUmJOZmlBaGdEbm4zZEkvWEFJNXdP?=
 =?utf-8?B?TnhFa2FNVzA1Mm8yZHl6NmFST0psckM2QzBkNFo2SkREZFMvcGNJK1JvMlFC?=
 =?utf-8?B?KzBFMUpjejlhRW5xekRjNlNCVjhVK2psVzZ1QlY4ZkpyMk85Q1h0OXdJM1VS?=
 =?utf-8?B?Ym9OMTNRQk9ULzEwZU9uYjFORDNSUUFINGY5RkV5V0FodHNtdG5xY0REUXhq?=
 =?utf-8?B?OXVqS3FwRWRzWUZnY3NtVmNKak1IbytYYk5aMmVNenlKSFJ0NHJXSDFaV0FE?=
 =?utf-8?B?Z1R1dEtXbmlBPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:53:09.7200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c72ad43b-c170-47dc-c6f6-08ddd9b8561e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9228


On 8/12/25 00:42, Lorenzo Pieralisi wrote:
> On Mon, Aug 11, 2025 at 08:26:11PM -0700, Lizhi Hou wrote:
>> On 8/11/25 01:42, Lorenzo Pieralisi wrote:
>>
>>> Hi Lizhi, Rob,
>>>
>>> while debugging something unrelated I noticed two issues
>>> (related) caused by the automatic generation of device nodes
>>> for PCI bridges.
>>>
>>> GICv5 interrupt controller DT top level node [1] does not have a "reg"
>>> property, because it represents the top level node, children (IRSes and ITSs)
>>> are nested.
>>>
>>> It does provide #address-cells since it has child nodes, so it has to
>>> have a "ranges" property as well.
>>>
>>> You have added code to automatically generate properties for PCI bridges
>>> and in particular this code [2] creates an interrupt-map property for
>>> the PCI bridges (other than the host bridge if it has got an OF node
>>> already).
>>>
>>> That code fails on GICv5, because the interrupt controller node does not
>>> have a "reg" property (and AFAIU it does not have to - as a matter of
>>> fact, INTx mapping works on GICv5 with the interrupt-map in the
>>> host bridge node containing zeros in the parent unit interrupt
>>> specifier #address-cells).
>> Does GICv5 have 'interrupt-controller' but not 'interrupt-map'? I think
>> of_irq_parse_raw will not check its parent in this case.
> But that's not the problem. GICv5 does not have an interrupt-map,
> the issue here is that GICv5 _is_ the parent and does not have
> a "reg" property. Why does the code in [2] check the reg property
> for the parent node while building the interrupt-map property for
> the PCI bridge ?

Based on the document, if #address-cells is not zero, it needs to get 
parent unit address. Maybe there is way to get the parent unit address 
other than read 'reg'?  Or maybe zero should be used as parent unit 
address if 'reg' does not exist?

Rob, Could you give us some advise on this?


Thanks,

Lizhi


>
>>> It is not clear to me why, to create an interrupt-map property, we
>>> are reading the "reg" value of the parent IC node to create the
>>> interrupt-map unit interrupt specifier address bits (could not we
>>> just copy the address in the parent unit interrupt specifier reported
>>> in the host bridge interrupt-map property ?).
>>>
>>> - #address-cells of the parent describes the number of address cells of
>>>     parent's child nodes not the parent itself, again, AFAIK, so parsing "reg"
>>>     using #address-cells of the parent node is not entirely correct, is it ?
>>> - It is unclear to me, from an OF spec perspective what the address value
>>>     in the parent unit interrupt specifier ought to be. I think that, at
>>>     least for dts including a GICv3 IC, the address values are always 0,
>>>     regardless of the GICv3 reg property.
>>>
>>> I need your feedback on this because the automatic generation must
>>> work seamlessly for GICv5 as well (as well as all other ICs with no "reg"
>>> property) and I could not find anything in the OF specs describing
>>> how the address cells in the unit interrupt specifier must be computed.
>> Please see: https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html
>>
>> 2.4.3.1 mentions:
>>
>> "Both the child node and the interrupt parent node are required to have
>> #address-cells and #interrupt-cells properties defined. If a unit address
>> component is not required, #address-cells shall be explicitly defined to be
>> zero."
> Yes, but again, that's not what I am asking. GICv5 requires
> #address-cells (2.3.5 - link above - it has child nodes and it
> has to define "ranges") but it does not require a "reg" property,
> code in [2] fails.
>
> That boils down to what does "a unit address component is not required"
> means.
>
> Why does the code in [2] read "reg" to build the parent unit interrupt
> specifier (with #address-cells size of the parent, which, again, I
> don't think it is correct) ?
>
>>> I found this [3] link where in section 7 there is an interrupt mapping
>>> algorithm; I don't understand it fully and I think it is possibly misleading.
>>>
>>> Now, the failure in [2] (caused by the lack of a "reg" property in the
>>> IC node) triggers an interrupt-map property generation failure for PCI
>>> bridges that are upstream devices that need INTx swizzling.
>>>
>>> In turn, that leads to a kmemleak detection:
>>>
>>> unreferenced object 0xffff000800368780 (size 128):
>>>     comm "swapper/0", pid 1, jiffies 4294892824
>>>     hex dump (first 32 bytes):
>>>       f0 b8 34 00 08 00 ff ff 04 00 00 00 00 00 00 00  ..4.............
>>>       70 c2 30 00 08 00 ff ff 00 00 00 00 00 00 00 00  p.0.............
>>>     backtrace (crc 1652b62a):
>>>       kmemleak_alloc+0x30/0x3c
>>>       __kmalloc_cache_noprof+0x1fc/0x360
>>>       __of_prop_dup+0x68/0x110
>>>       of_changeset_add_prop_helper+0x28/0xac
>>>       of_changeset_add_prop_string+0x74/0xa4
>>>       of_pci_add_properties+0xa0/0x4e0
>>>       of_pci_make_dev_node+0x198/0x230
>>>       pci_bus_add_device+0x44/0x13c
>>>       pci_bus_add_devices+0x40/0x80
>>>       pci_host_probe+0x138/0x1b0
>>>       pci_host_common_probe+0x8c/0xb0
>>>       platform_probe+0x5c/0x9c
>>>       really_probe+0x134/0x2d8
>>>       __driver_probe_device+0x98/0xd0
>>>       driver_probe_device+0x3c/0x1f8
>>>       __driver_attach+0xd8/0x1a0
>>>
>>> I have not grokked it yet but it seems genuine, so whatever we decide
>>> in relation to "reg" above, this ought to be addressed too, if it
>>> is indeed a memleak.
>> Not sure what is the leak. I will look into more.
> Thanks,
> Lorenzo
>
>>
>> Lizhi
>>
>>> Please let me know if something is unclear I can provide further
>>> details.
>>>
>>> Thanks,
>>> Lorenzo
>>>
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5.yaml?h=v6.17-rc1
>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/of_property.c?h=v6.17-rc1#n283
>>> [3] https://www.devicetree.org/open-firmware/practice/imap/imap0_9d.html

