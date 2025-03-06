Return-Path: <linux-pci+bounces-23029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E81CA5411E
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 04:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7708116D98D
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 03:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D1A18E351;
	Thu,  6 Mar 2025 03:16:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2091.outbound.protection.outlook.com [40.107.117.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33941362;
	Thu,  6 Mar 2025 03:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741231000; cv=fail; b=bYv7jBMTb5AwZezhRyyp6B0zEhKK6gzckdIlHnD9zG66ioDIWrbvLySqWG8ScCe75X9imS4/swMLVLz67oUml3id2/VPRp2GHx2cNfxWxb9X8yAD5srg9J+REbokGUsUN2YrNUpetB+GeR7+2FHxrPvyGJHaQaxyfAerZe7xP4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741231000; c=relaxed/simple;
	bh=CTumLdEVwrc/aN/GBkrIvfRmv/mBgY939Hch24IRjLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CrSxQNGE4eVTAnS7wegalWRCNBVvDPHPnOp8ErrJAsx/+Yvc47ucHd12tR8kxLc9b79ySBCqpARjQI+Bk3851AF34koUl85ZNgKmrkUAvSbgLbw2a9XES6OsbjLHsIaxBECGq5iNmNQWH9+deuzjk4Y7CWWjeqF2EW4Et9FY5rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.117.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QK8eH5JMtoqDqjZngnlTZw8M3YgReOrBAsbfzaEf/oP/TQf54ItmugXk/H093Udvl4K/LgJx0ybEbEu9rEIdqb74GrCDtvjpgC+p8sdOr8oKco3E1VQmYn8yLi2CFGW41sq7iCxMYdEU70FpLQZ4G6wR5q9Z4zrngMmdR8G43FT9BaOAzOxEZSSnkfhIR/kK+seVdFXtBSakA1X27gAqgHkVQBd4SDI9Na7D9d7wP9OETsWrB9bl6Ig9v4uOUE+tiJhg6eM1XAOCDaQpR0MxCGRAKJFZItPFmMlVZ8woILHNv9tOzYILtADLpRBIgNAVxt+Cftx1G8epzAMhYxaO0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gikBC1R+uDXZ/0DLUK7HtCsNFGI11PW42tZfRLOpcGs=;
 b=qnK1+Db7a3ClzMHAdn2HrGInvf5V02btvvLBqMaNxcJsJggWISC7QZymWoKC2OuUpqILqQX9EJnCTIlgPijmPLhdxZJzQ+h4vuyBFmn4eC0yzkk2W48+QDvync9wc5DzgYC1aBU+4gOsymQnRihOpoFvNutG5GyprvCpnXAH/L1k/TBannCJKtXK58eHPY8oTg+RA6eM519KWkknqTwh/PCo86JFUm+4XFoNzV6DOzuI8uGpp6AOaPEaPASPlKs5Oq2t2a9NRFJJtqzQqOWd8dcMJek+5WDRD20M8H6SEd+i38cIbKwHO52UNCObp16dwI0OwMPp8KYPCrR1Cy9ARQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR01CA0174.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::30) by TY1PPFF4DC72DCA.apcprd06.prod.outlook.com
 (2603:1096:408::931) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 03:16:32 +0000
Received: from SG1PEPF000082E7.apcprd02.prod.outlook.com
 (2603:1096:4:28:cafe::f5) by SG2PR01CA0174.outlook.office365.com
 (2603:1096:4:28::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Thu,
 6 Mar 2025 03:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E7.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 03:16:31 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id A67314160CA0;
	Thu,  6 Mar 2025 11:16:30 +0800 (CST)
Message-ID: <4f0a6680-3413-4503-9eef-983027c4fbf5@cixtech.com>
Date: Thu, 6 Mar 2025 11:16:30 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Add PCI quirk to disable L0s ASPM state for RTL8125
 2.5GbE Controller
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, cix-kernel-upstream@cixtech.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Chen <peter.chen@cixtech.com>, ChunHao Lin <hau@realtek.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
 netdev@vger.kernel.org
References: <20250305222016.GA316198@bhelgaas>
Content-Language: en-US
From: "hans.zhang" <hans.zhang@cixtech.com>
In-Reply-To: <20250305222016.GA316198@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E7:EE_|TY1PPFF4DC72DCA:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb7afe0-c626-4a24-6141-08dd5c5d4ae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZllJVU1tT0JuTWJNUzdFZ2dXYlg1ci9qKzM1WEFzT3RydFNneXlnYkRxWnM3?=
 =?utf-8?B?c2JCeFJ3d0w5b1ZjMmtRNXhkNERHK0hCUkx6am9xcFduZkdBOVpnUS8vVVFi?=
 =?utf-8?B?YVZudlZNK1p1cnAyZGJ5M3NYWWYvNlpwM2d3N3FZNmdDM3NNcDVIUGZ4Ymhn?=
 =?utf-8?B?aWJRUXBmdVhaM3k2RW56eHErSWswTDluSWZnOHUrTkJIN1RZM1hCZ0VEc3lY?=
 =?utf-8?B?blFoTzdwOEZnNzJoMzVWWHlHSXA3UDRkdUl5TlU1eWIzK1hSMzhuYldWdEV0?=
 =?utf-8?B?alVjZDI1THN4MTcwQ1FQNU5KdVhFR3ZCVTFla0NpWllqdS9vaEUzZjVLZHVo?=
 =?utf-8?B?azlrQ3pwT1cxOStzWGFLblJQdWF0eXI3RjcyWVU5UTFHbjBUeHJkckJrYkdZ?=
 =?utf-8?B?Wko1VlNPUkZXZEhQYzA2RzVtSENQMVVEN2FGWkZDSE1zcXVZUWtiTWhxcG0r?=
 =?utf-8?B?THZ4YzRiSHBHeUxDSGZmT2JmdWozaUs3WmRRcm4yRG53eG42N1hyOW9HN3di?=
 =?utf-8?B?WVplTWxLUW12ckhtVDJ4c0VUU1JCQnlUbXN5Tm1hRFl1TUpGTVNiRU5xTS9F?=
 =?utf-8?B?STB6TmVjRkdQTmFlb21hZVpYYmhuM0R6RW83bGwyWFJ2Y1JuaXNobUI5Z3Zm?=
 =?utf-8?B?M0kyT2JwWUpybC9IbFo4SzVWTzdDbElyVzFmUVJ3L0NtcTlNendGUE5vOU5B?=
 =?utf-8?B?NUVIdEVKdTVrcXdQeXBpcWt3YjZjY2JDWkZMTDJYMUh0Y2ovb3ZGb01Yd0da?=
 =?utf-8?B?Z2hvNGpxVmFYUDJ5a05NNW8xYVoveWF5VUZITnBKNTNxL243ZTRRcERYa2lN?=
 =?utf-8?B?TTBXN29uY3VyYVZ1b1RJWWxzVEd2c3UyeVcvd2pxWWNjaDdsMmIvZmNWdmpi?=
 =?utf-8?B?UEtRTlJOYnZiVUg0VDUwZ0VSME4wSHQyNnlueFp3d2ZDamNnVmhwcmlaU3Y2?=
 =?utf-8?B?RVZnSkhwSDF0Rm4vdG5KSUk4bzBhU3ZnUnczbTNpRUNPbXRWMHJqTEdkMDNO?=
 =?utf-8?B?ZDRzRHF3dGFQeTRyMHhzUmJnMVB1clc4Ny93aVJMQnhPN1ZKVXE2Z3MyTTdO?=
 =?utf-8?B?em5jTjNINTBvTTlKeUlnTjd3L2psVGczem9XTk1wR2g0czBoNTdEamMvWW50?=
 =?utf-8?B?SldNVXRudDRKYW9DdWZCOTBDelgwOGJCR2VhNFp6d095QzBjT0hadVBFMElZ?=
 =?utf-8?B?Tk80S0JpendqbXk4a3VZKytyeWU1c2ZTWXh5R2pZd3JFdUU5aDM4WTJrbFpa?=
 =?utf-8?B?c25HSWFrVDhMK1YwSVdDdVM0WnExOFdSUjBJRTBFMGlGNXZDYTQ3QVRFYklJ?=
 =?utf-8?B?cEpKcmpXa0FKSFpaTjQxS0t3RWd2SEcwbDN0bDFxUzdleVhUQVVVTFVhOWpu?=
 =?utf-8?B?L3B0R1hRWTJpL0o0MVRkYUJjUEZUZ2FPZThJUWlzK3MwOTQxS0xkOGRDdjNp?=
 =?utf-8?B?STFiL2JSMGNvby9vL0tZeXdmLzhpMmQ0SElIekdXZjYvMHRNOWNpM2dqUHU4?=
 =?utf-8?B?b21yc3ZOdDBxSS9QN1lVSU5jR1BiUm10cVhrWXdDUlJqQUlKb0pFSWJTZU5l?=
 =?utf-8?B?bGk5azl0WTJUeWZWUjV5N2wvTzgvblZLWk42K2RNZUpNZGR6OXYvZk14eldX?=
 =?utf-8?B?THpzZUdkdW1mWlhSb3E0S3VQeHRhbi9FK3dOeTFCc3JGVlBkcTk0Y09Fb3p2?=
 =?utf-8?B?bWcrM1V0bWtLcW51YlZLVkpvSHVYc0Q0bWNabkU0Rm11Ylc3NTd2dytUdjYr?=
 =?utf-8?B?M3FKRDFPMUJRdXkyS3RxNkkweTM2V1U2b1RmZWZvd1JvWkI1UU45M3JMY1RG?=
 =?utf-8?B?TzVmUTRvUzQwcG1YM0h6VmxJcUc0a1NDRkxwYnhrMXJIWWhjS3paOENFbTlP?=
 =?utf-8?B?Y01oY2xXUC9QZjBZcFd6M05JN1IzV0NrVk1NOFlLSEcyVzlLRFIwTzJxd2JW?=
 =?utf-8?Q?1MFOhh+yGoA=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 03:16:31.2823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb7afe0-c626-4a24-6141-08dd5c5d4ae2
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFF4DC72DCA



On 2025/3/6 06:20, Bjorn Helgaas wrote:
> [Some people who received this message don't often get email from helgaas@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> EXTERNAL EMAIL
> 
> [+cc r8169 maintainers, since upstream r8169 claims device 0x8125]
> 
> On Wed, Mar 05, 2025 at 02:30:35PM +0800, hans.zhang@cixtech.com wrote:
>> From: Hans Zhang <hans.zhang@cixtech.com>
>>
>> This patch is intended to disable L0s ASPM link state for RTL8125 2.5GbE
>> Controller due to the fact that it is possible to corrupt TX data when
>> coming back out of L0s on some systems. This quirk uses the ASPM api to
>> prevent the ASPM subsystem from re-enabling the L0s state.
> 
> Sounds like this should be a documented erratum.  Realtek folks?  Or
> maybe an erratum on the other end of the link, which looks like a CIX
> Root Port:
> 
>    https://admin.pci-ids.ucw.cz/read/PC/1f6c/0001
> 
> If it's a CIX Root Port defect, it could affect devices other than
> RTL8125.
> 
>> And it causes the following AER errors:
>>    pcieport 0003:30:00.0: AER: Multiple Corrected error received: 0003:31:00.0
>>    pcieport 0003:30:00.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
>>    pcieport 0003:30:00.0:   device [1f6c:0001] error status/mask=00001000/0000e000
>>    pcieport 0003:30:00.0:    [12] Timeout
>>    r8125 0003:31:00.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
>>    r8125 0003:31:00.0:   device [10ec:8125] error status/mask=00001000/0000e000
>>    r8125 0003:31:00.0:    [12] Timeout
>>    r8125 0003:31:00.0: AER:   Error of this Agent is reported first
> 
> Looks like a driver name of "r8125", but I don't see that upstream.
> Is this an out-of-tree driver?

I'm terribly sorry. In the r8169 driver, I see the setting for pulling 
the disable L0s. Please discard this patch.

When I enabled ASPM and insmod r8169.ko, it worked fine.

Previously, we used a separate RTL8125 driver from RELTEAK. Compared 
with upstream, it has more functions and is more complete, but their 
drivers do not disable L0s, so this patch is mentioned.

Best regards,
Hans

drivers/net/ethernet/realtek/r8169_main.c

static void rtl_task(struct work_struct *work)
{
	struct rtl8169_private *tp =
		container_of(work, struct rtl8169_private, wk.work);
	int ret;

	if (test_and_clear_bit(RTL_FLAG_TASK_TX_TIMEOUT, tp->wk.flags)) {
		/* if chip isn't accessible, reset bus to revive it */
		if (RTL_R32(tp, TxConfig) == ~0) {
			ret = pci_reset_bus(tp->pci_dev);
			if (ret < 0) {
				netdev_err(tp->dev, "Can't reset secondary PCI bus, detach NIC\n");
				netif_device_detach(tp->dev);
				return;
			}
		}

		/* ASPM compatibility issues are a typical reason for tx timeouts */
		ret = pci_disable_link_state(tp->pci_dev, PCIE_LINK_STATE_L1 |
							  PCIE_LINK_STATE_L0S);
		if (!ret)
			netdev_warn_once(tp->dev, "ASPM disabled on Tx timeout\n");
		goto reset;
	}

	if (test_and_clear_bit(RTL_FLAG_TASK_RESET_PENDING, tp->wk.flags)) {
reset:
		rtl_reset_work(tp);
		netif_wake_queue(tp->dev);
	}
}


> 
>> And the RTL8125 website does not say that it supports L0s. It only supports
>> L1 and L1ss.
>>
>> RTL8125 website: https://www.realtek.com/Product/Index?id=3962
> 
> I don't think it matters what the web site says.  Apparently the
> device advertises L0s support via Link Capabilities.
> 
>> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
>> Reviewed-by: Peter Chen <peter.chen@cixtech.com>
>> ---
>>   drivers/pci/quirks.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 82b21e34c545..5f69bb5ee3ff 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -2514,6 +2514,12 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10f1, quirk_disable_aspm_l0s);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10f4, quirk_disable_aspm_l0s);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1508, quirk_disable_aspm_l0s);
>>
>> +/*
>> + * The RTL8125 may experience data corruption issues when transitioning out
>> + * of L0S. To prevent this we need to disable L0S on the PCIe link.
>> + */
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REALTEK, 0x8125, quirk_disable_aspm_l0s);
>> +
>>   static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
>>   {
>>        pci_info(dev, "Disabling ASPM L0s/L1\n");
>>
>> base-commit: 99fa936e8e4f117d62f229003c9799686f74cebc
>> --
>> 2.47.1
>>

