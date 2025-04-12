Return-Path: <linux-pci+bounces-25716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D440A86E08
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 18:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092023A4369
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 16:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3487D1F8751;
	Sat, 12 Apr 2025 16:02:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2107.outbound.protection.outlook.com [40.107.215.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1040C1AF4D5;
	Sat, 12 Apr 2025 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744473773; cv=fail; b=MNH0opYxzTjW6Ueyrvj7RGS5PaRigRUNcoL+YS6wLGFD3a849NtRGf2ecABUsTSBFJJUT5Q1g9qg7Lfblf4xkpUwN6XGAsFwgshTEHFH3YfQDH716+ED1nTrrG1tLxlOZGA9IpKhBY+xy9K420JdSMNJIGgiaN/zg6Dy7ZWpYNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744473773; c=relaxed/simple;
	bh=i6vdrfWmmDgQpk35E+zggObarLAfouvqabAFg+MaXk4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ELXoOCEGOahgecGlWw0JyKsE1OVpfNHrMk2NeFfWqyZeaUxSC9+eu1+WM8zOVU3yu6uM+cZU3bmC31+1C0+pK0Qym2shscg0Ts2IrxkCZ6Ovb+xZFCbfkZ8p4qXvWmzmXfbush1wePu5Sky4q/De1mWA7sI3BwltuenipbSeE7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.215.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhfsNgqnc8pVtR5RksmDW650Ye47LzHRtKvbsnm+mU2S5cstiXES/XfL5UPxgl/d0RpIJJRZ+2f5nB1/LZZaRlFKkKeJ/Dpw+oLFToFFeArbTDDjvAOM3VuDo+iZccha57R0vUtx0M+C7iBq0l6UaBa69gmtPCrSIa+08Sk/K2cGCU3yI9UPDZ4nT4oTOWSkxHtmovObSazdFfHjx1BePldw8n/GNPMCn4UrkwyKCHQg2PSgsP2yIpyQOPjOZzQ5a3uQsh5p8R8kkRoE7Sdv3Hz9dPRWcdLNtnNhN32guUg1DW3jLOiIk6uolI46i1tDycMHPPNvok3mAyyRa4ehlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjcLWuEEFZ8x73venkAxYeuLchSROMehltySMaO+nqU=;
 b=URGnG/juM6Qu++1sqMZSxwWUW4r4KaILTFuUhdRFqZfS02Y+wL6TGiAi+D5YDZfqttl5UPz17RdPL37eT6uM9PPn4eLK47dk0kSyg8whHOQ/jpUlaa9By9msEOPXKMkg1l7HuGblx/3oljBWvrudY1GYOQZFdjPn9s2Yx5GUIRPSW/nanvGCwFfsgsW3+nvqTVQtUzBqTjOvmd3vFKo9f5cQXFnqEvUcyH5C4XviWbkVyPVgDWeiNuaJEesJjdahlmPxHhDC+CljSjucKjF6K0Hg10KutcxEvbSdHqghcYxK8JwsXXkvENI9L82Dqn9hzkzpPRIyRwR8Ho8sYl/Sog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR01CA0168.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::24) by JH0PR06MB6850.apcprd06.prod.outlook.com
 (2603:1096:990:4d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Sat, 12 Apr
 2025 16:02:45 +0000
Received: from HK3PEPF0000021A.apcprd03.prod.outlook.com
 (2603:1096:4:28:cafe::6c) by SG2PR01CA0168.outlook.office365.com
 (2603:1096:4:28::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.29 via Frontend Transport; Sat,
 12 Apr 2025 16:02:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK3PEPF0000021A.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sat, 12 Apr 2025 16:02:44 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 3BDAF41604EB;
	Sun, 13 Apr 2025 00:02:43 +0800 (CST)
Message-ID: <94d08e9b-9718-4ee2-be9f-469177f7e4db@cixtech.com>
Date: Sun, 13 Apr 2025 00:02:39 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] PCI: cadence: Add callback functions for RP and EP
 controller
From: Hans Zhang <hans.zhang@cixtech.com>
To: Rob Herring <robh@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 manivannan.sadhasivam@linaro.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Manikandan K Pillai <mpillai@cadence.com>
References: <20250411103656.2740517-1-hans.zhang@cixtech.com>
 <20250411103656.2740517-6-hans.zhang@cixtech.com>
 <20250411202420.GA3793660-robh@kernel.org>
 <07457d00-82bb-4096-ba07-6cc7b7d118e3@cixtech.com>
Content-Language: en-US
In-Reply-To: <07457d00-82bb-4096-ba07-6cc7b7d118e3@cixtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021A:EE_|JH0PR06MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ae1a2b-3469-448c-7716-08dd79db7649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWJReHg0L1lPVS9QcmZMRG1Gb0ZFY3dLck9uVE0vS255a0lPUkNNc0p0SXhW?=
 =?utf-8?B?K0lQN2czajY0Y3VxbmMvTUllbGJULzQrQUlqMzRqVkJnblNpYjl3QWFSSTAy?=
 =?utf-8?B?SThMRmJhRHF0UUZ1OEJMWS8vNWR6endDdTNZbGNEbll3dUpieVBEaWJLV1FE?=
 =?utf-8?B?b2plOUpYK0lyVlNUT3ZuaEQvOUJWTFBpdFVoYVlXMlc0anNtUWErWjhucXFw?=
 =?utf-8?B?QzJ5MURBcFlVUjhQbGZOc0E5aHpEbzk3K1NjcWYwdVZab2cvTHFiZEdzSUo0?=
 =?utf-8?B?MTA5ZXJnc3lVMEtpVmFjRUx6bWdRYTAxR2tFTHZGRm5wNUNNTEx0dzcycDBX?=
 =?utf-8?B?UEltWThRVFE5dG84cDdDVjRONktLMGd6R3JKb1BseUlTalhZVzhaRVdibTRt?=
 =?utf-8?B?R2NEZHU5S3ZscU5VNzNBSktib21MN2R6RWZmQ2FMZnFPZ291UjZKNXVSTStT?=
 =?utf-8?B?Z3BNZmhIWTZMSmpEUytneGcyUTNrSUdPTFJiS1p6V0xHOWN6UnF3TTVBclox?=
 =?utf-8?B?cUQ1UjdnU0pRMXE0Q0trR2FOV3BGTUZUa3p3LytMLy9lbldvd0ExSkNlb3VL?=
 =?utf-8?B?N3pZZUpsQ1oxTjFCRC9ESkNweFFPakJMWEFOTHoydmFMd1lqclBCUFVFSVVi?=
 =?utf-8?B?R0dXNzVOVTFHMDBORFE2QWErbVBCTWRCYitHckJBbldjS0VERXZxZ05lVGFx?=
 =?utf-8?B?UVh5V0JiNTFEVUJvanRVM0VZd1NXOGN4TDJtczdMVnRBK1FldCtMVnptNmk3?=
 =?utf-8?B?L2NaL0lDTWxlbnJVMElUbDMwRWRQQTN2Ny9FN1JIYnVuVDVJVlJJOGlIYTc3?=
 =?utf-8?B?aWRmMW1leWNyaG0zZUd2Z2ZJMWorK3hyZjFTMmZGcDJ1NTVZT2t6eVhQbUFy?=
 =?utf-8?B?QUV5RHpCSVJxOW41aXBaWkh0M2RzZUFCTTdkUTUzZjdxVHFic3YxT1dab2JG?=
 =?utf-8?B?U2djWnpsZDI5RHJqVi9KTUhkZTZZT1ZlYXNYTDF5a0IxYmVtTzZ5WFhVb2ZI?=
 =?utf-8?B?WFJxMTIrVEV5bDVZZzhLdjhsQTkvU0JzTERXQ3k0eGh4Y3AzaVFCWmp4TTB2?=
 =?utf-8?B?RXB5WlpJNTRkUVJUcTlCVU01a2d5NktrTzg2YUR4bVEvVUFFVjdhTzE2d3JK?=
 =?utf-8?B?ck5ZQ0wvd2ZxbkFmYkFjYmV2SHE1QWlpNGtpSVJQbWtMM1ZZWXRiUXNtRnRG?=
 =?utf-8?B?eDJGNndpNWJ6RmF4dmYwV1FaMlJYU0ZNRm5BRm9YUkVvUi9NeGFXb0gyeUxO?=
 =?utf-8?B?Y0x5emY4VjcwNUxCSFdpZldLcFR5dTF2dks4cjhjNE41QVFoOHdUWmJBS0Ns?=
 =?utf-8?B?T01LcjhNK1cvS082TFB2VC8vS09qNHFLUWM4RHhqRk5OOG0zMWtpTXp3SUlp?=
 =?utf-8?B?M2cwWGdiTnRhNG5KRmVLK3ZXUmVzZ1dHZWRTWDkySE8yVlNLbFJPcnNDZTBy?=
 =?utf-8?B?WkdSSTNaR1Z0SWJWd1hhaHpKbUhsSWFnMlFaNklBb3BabTZiOFJUUjVGV25p?=
 =?utf-8?B?SUJXZFc2Y0EwZEZabkRDckZCYlptME9HQ0FRUU1wQVhYd091Y1dmYkswVThy?=
 =?utf-8?B?ZlZRQUV1Ukh4LzFvVmhQV201RWNwZDFsOHVWYlBzVnNqbTV2TUNGS21KSzNW?=
 =?utf-8?B?cFk2Z2MrbUJjZ0JwbnBQdUorUlBVejhndEdJS2NmRGpEd1hpbTkzU3d2Z2FB?=
 =?utf-8?B?VEl5R0t3R2x3S0hlQThGUnVUUDI0SmNybEIrdWI2R2VPWDRWbE9SWmg2NDY5?=
 =?utf-8?B?QngycS9jaytSQmlrNmdrS1lYcWd4d3hUcWwyK0VIYTVvZnRhV3hmTXhrL2Zy?=
 =?utf-8?B?MWtSaEFiY0tCcmpQY1dKSUcrK2d3VTE0QTRQbGtqOWNwMXhJbU1TNEtVN1ZK?=
 =?utf-8?B?ald1bVpCV3ZBME5sc0pLYnMyZmo3bmVmdCtiWkRlaEpDUitvZmVQQzBsZWVL?=
 =?utf-8?B?L2RwZ2YxaEtWanBGd0lRWVlQeEhuUEVuWWI2Nkd0SVd0aHRJdms0V2NVTFdr?=
 =?utf-8?B?RFdQRU1qSGh3eFJlczBJQXVIMUJlYWhkanNtVHZGeVdOSWxKMFRnaTlobUdp?=
 =?utf-8?Q?AWA33P?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2025 16:02:44.3303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ae1a2b-3469-448c-7716-08dd79db7649
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021A.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6850



On 2025/4/12 23:45, Hans Zhang wrote:
>>> +     /*
>>> +      * Clear AXI link-down status
>>> +      */
>>
>> That is an odd thing to do in map_bus. Also, it is completely racy
>> because...
>>
>>> +     regval = cdns_pcie_hpa_readl(pcie, REG_BANK_AXI_SLAVE, 
>>> CDNS_PCIE_HPA_AT_LINKDOWN);
>>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE, 
>>> CDNS_PCIE_HPA_AT_LINKDOWN,
>>> +                          (regval & GENMASK(0, 0)));
>>> +
>>
>> What if the link goes down again here.
>>
> 
> Hi Rob,
> 
> Thanks your for reply. Compared to Synopsys PCIe IP, Cadence PCIe IP has 
> one more register - CDNS_PCIE_HPA_AT_LINKDOWN.  When the PCIe link 
> appears link down, the register -CDNS_PCIE_HPA_AT_LINKDOWN bit0 is set 
> to 1.  Then, ECAM cannot access config space. You need to clear 
> CDNS_PCIE_HPA_AT_LINKDOWN bit0 to continue the access.
> 
> In my opinion, this is where Cadence PCIe IP doesn't make sense.  As 
> Cadence users, we had no choice, and the chip had already been posted to 
> silicon.

Supplement: Prior to this series of patches, in the current linux master 
branch, Cadence first generation PCIe IP has the following code:

void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
			       int where)
{
	......
	/* Clear AXI link-down status */
	cdns_pcie_writel(pcie, CDNS_PCIE_AT_LINKDOWN, 0x0);
	......
}

It seems that all Cadence PCIe IPs have this problem.

> 
> Therefore, when we design the second-generation SOC, we will design an 
> SPI interrupt. When link down occurs, an SPI interrupt is generated. We 
> set CDNS_PCIE_HPA_AT_LINKDOWN bit0 to 0 in the interrupt function.
> 
> If there are other reasons, please Manikandan add.
> 
> 
> 
> In addition, by the way, ECAM is not accessible when the link is down. 
> For example, if the RP is set to hot reset, the hot reset cannot be 
> unreset. In this case, you need to use the APB to unreset. We mentioned 
> an RTL bug to Cadence that we currently can't fix with our first or 
> second generation chips. Cadence has not released RTL patch to us so far.
> 
> This software workaround approach will also later appear in the Cixtech 
> PCIe controller series patch.
> 
> 
> Best regards,
> Hans

