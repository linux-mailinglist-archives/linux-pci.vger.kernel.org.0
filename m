Return-Path: <linux-pci+bounces-35213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB83B3D6FD
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 05:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2636C3B36E4
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 03:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE6D219A8B;
	Mon,  1 Sep 2025 03:09:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022093.outbound.protection.outlook.com [40.107.75.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27F0202C5D;
	Mon,  1 Sep 2025 03:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756696171; cv=fail; b=fPJH8Shd2uaf36H6zGlmxFRgSj4wBcLw+yrmWrbYY+NJmgVLcWw0HOeyD0Ob866O6TWILQyxy/axIl+d8CuHTalwxq0p5zp7OiQzlYKPZM3mhZA+VT9UjNkS8bqALr8skPOkARM/rkOctb9CDhZKDUGi0GSNBQvIBPF/yIt+C0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756696171; c=relaxed/simple;
	bh=N+nntBFHl/dr9HX1FNVbT01tcHauZ7RuC34nk4eRywg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ku0KBau8oC1JDxJLoC5WGu36rQawoIoc5pCGgF0DpEyyiaiNYBNRTdER7e8CCgXUQWTEqLwLM3XAXgCaI5dlM8d31c9X9fhFbTO9tzwSRpe+KBY2T4xdgxklRMK5jvDRjWWeA/v9Qzf5kCqbsS+MyDC5lrvGofH7GESfNn1uK8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlU0R+pFRPlPDKlnFleebnOj/xjMkjWFlNGSLwnVy6jRdxz69SmMr1Nndlg665rmJbWGosp+G0+rLOK/LGMLpwoy7R5TAqh2rBCHc5ZacNr9l6y0xYCmZpj3RxayN1df8haZoX+Z1CemZ6L65TXXEqGpzHBK/EumvPQ+hg3b1za/2S+ZVa6vm/2NeeO6yjBXfSSDnpzSQRhPeJTAXBxEpPq3/4K67tlsMpE3KJCZ/89GR5DZSNE+RaYXB0rmPPyQhcBvgb4m3QSEU/L+s1p0IaCsPGiAcEtjC7jLZhwYJ7MDyFNP8ueJZGmMj8LQLD6rwJNMggFE2SQ0s4AOccVTAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHnwZG4WSi6waxd7LgDNa9udaISg41qAX1NcBO+CC7o=;
 b=PScdWxNEEA79nTmsZCvVYRvFfNijECwINuEfHlmXg052feqq2F6b92O1h0myuwNWRp6ko1mRt0bUdh039XdNCqFVjOXasFqiLD/UjR4XbGcR1qGGaHCpknmrdC4GNIzGr+JSvlEI4nQXeuy8R2q/Ipbsyl3JXUkpcMLvXkPdojmEWO95ApHc1c+VbgfKmwAlkJMPVFKhgavusOqtL6jskj+LCByNnojm7t4o8yfkydz61O1p2rNdidckpu7w/2epKsjD06BdwEqNJlq6yvc4MqlvekRrjRgJntnEeri2yIjQDPq387OJn/3jaNQv6Vw4JyGdVhObd4e3Mvs/Fjzt4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) by
 TYZPR06MB6728.apcprd06.prod.outlook.com (2603:1096:400:44c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.26; Mon, 1 Sep 2025 03:09:26 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096::cafe:0:0:c1) by SG2P153CA0011.outlook.office365.com
 (2603:1096::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.4 via Frontend Transport; Mon, 1
 Sep 2025 03:09:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 03:09:24 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 0573240A5A13;
	Mon,  1 Sep 2025 11:09:24 +0800 (CST)
Message-ID: <2c280f84-43b1-401b-bafb-4c148ff70d81@cixtech.com>
Date: Mon, 1 Sep 2025 11:09:23 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 14/15] arm64: dts: cix: Add PCIe Root Complex on sky1
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mpillai@cadence.com, fugang.duan@cixtech.com,
 guoyin.chen@cixtech.com, peter.chen@cixtech.com,
 cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
 <20250819115239.4170604-15-hans.zhang@cixtech.com>
 <4mxs6oyaipouujkfw2lomf4fp3z64f2tos7b35qkzlx7c6vi63@lzm4syg4vayh>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <4mxs6oyaipouujkfw2lomf4fp3z64f2tos7b35qkzlx7c6vi63@lzm4syg4vayh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|TYZPR06MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 03cc9694-6937-465f-176b-08dde904f497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmVKZVRrYzMxKzVNbjVTMWtsZElqMlRQbkFKOGVIU2ozNFBRV1B3T2ZtQ1Jz?=
 =?utf-8?B?REo3b0ZzNzV1UmE4V0FKNkFyQVFqdDJEVm1MMEptVjFETmt0dXR4TldVYmRG?=
 =?utf-8?B?SG5vbm9acVVsSk5lWG9kbXNLc1NCMzNLNHlZWjZRNUxJRytkMGtieHNUZ3Jw?=
 =?utf-8?B?WWVaOVFwMHlHb2lsSXU0cDI4djVwVmd4WVJRMW9ZRVBlUlZxdkJLcTZWRlVL?=
 =?utf-8?B?YTVrU3lhMHFiSG9YSkR3aHl4dGlwWW1xVmNzSTNXQmhnbXFONGJMbTROV0sy?=
 =?utf-8?B?VWx2RjJyeW9Hblhoc2JpL2FYRzloVVR0SHpocmptZmlndlpKWW1KVjRTa0E0?=
 =?utf-8?B?MkRwYzhBa2VNd3NwTXJ4MnZBZ3pacVZBeUFRVE8wTVBsZVBPTjFUWVAxOUdr?=
 =?utf-8?B?dXFBVjlTSFZFa2VNLzJBYjM5ZVpWYVV3N01HZllwbVN4MjdWbWE0em0yNC91?=
 =?utf-8?B?eTBHcURkRjQyVWRPcTVGdmZ3aHRIekZSN1R3aGdZL2x2SVRoaDdCYVYxRWtp?=
 =?utf-8?B?UTR2OG9SRUlhdU5ITit1L1hWQi96WHlTUWxXRWtweTIxTHVYWHZZZGVrRlF1?=
 =?utf-8?B?OEpYbHJiS1NiZjQvempRTmZ5TUtpYWNyZE55VFpWQ1VKek5ZaDVGL051THlS?=
 =?utf-8?B?WHlNV2J0aVBHa2VSYVN6OFhUNmhNUXFTODNWQjB3YzRzdldBVTdHR05PUXFL?=
 =?utf-8?B?Z3lJQjZucFFiTW9GVkNGOWNCN1RYTU5wS2o1UWJ2amx3N3hxZ0xIcWVoMXVF?=
 =?utf-8?B?V1lrWkR6b0UvZC8xTkJBK1JSOU00aVpDMHRzTUQyRVlnNHd0dVlqMzAyYytk?=
 =?utf-8?B?dDNQZ25qVE1CVDR3S0Y4d2hadlpZT1NpeTVyellVbWlleTB3RUZzTGdGMW8r?=
 =?utf-8?B?cHR1eDBaTG5vb2xoMzJKNnZtMk8xcUdlNllvd3dJQnNmSVBvcitrR3FwektV?=
 =?utf-8?B?dnNVeFNzVlhvaXZ5TkFKOVduSVZnREZsbXo2RjVWeGpGNmZYWTdacHpVcnpH?=
 =?utf-8?B?NTNseVRZeXRybG9UcWJYMmlHSnowVFE2dU41TFpxOFM1YmFuRXZJNHNyWTgx?=
 =?utf-8?B?Wm9GTzZ6dnZ4KzZoQlFGQW9TL3d1dnh5UkdTSEhMd1ZONmhEZXhSN1l4YW9I?=
 =?utf-8?B?SDZUY0tVcG1kUGhTVnd5V2FLN1BpR0VlM2Rkd09sUElTNE52cnRhR1pCbWtl?=
 =?utf-8?B?WENMdnptcWJoNEJIaEJUaXdnWElhKzE5VEpoRkIwMnd3RU0zay9TOVFPOHQ3?=
 =?utf-8?B?ZElqZ280M3IwRk1DZURwR0R0UGRlQXVyaFU1OVVyNVpmV2dRdkQrTDJBOGUx?=
 =?utf-8?B?aFJlbDE2QkxMZC9KeG04K2RPNXRMelYyazNVUTJGblhGei9xQXI2Zzc2VE5S?=
 =?utf-8?B?NDkvdEwrbHNFakkvS2FyNktmMEhIdUxWdWtTYmhTZzZ2RDJkdW1zZ1Ryc3Vp?=
 =?utf-8?B?cjNWWWM3c0xXWkNmNDc2TXBocGlkUHVDVGdCNkw4Mk1FdndlUHJ3VFRVYkky?=
 =?utf-8?B?blpiZ0c4bGhSU1IzQm1kYVYwRUJJbjQ1YUJ4L3V3a0tZL3k3YWhSM3ZVdFdO?=
 =?utf-8?B?a3ZIRGJYUnFkcHdBR0RDWTFCcFNua0lhZWJUZ0U1VEFJMXRxaWlkMWdFT0Fi?=
 =?utf-8?B?OTZxdmU0dFhEOWs1aldudFVNbFdzKzNKbVJKcTVwanlGWnc5QWZBZmVCY1h6?=
 =?utf-8?B?WkZXeWpUeWg0dXl1ZXdjL21Qelh5UkJydXgrNFpZcmZwdlpiU3ZEZmRpQUh6?=
 =?utf-8?B?aUl5ODFadU4wdS8wYWdyVFUyQTgxdE9ZM2xuNTVmelI1ZE1QT2llVzF3UDE3?=
 =?utf-8?B?UmFlV203cmRrbFlhMit3WG9laHdKa0tZOHBMVkpwSk43d0FJQnVKNHoyNTk4?=
 =?utf-8?B?cHhPNlVnQ1BMcnZRSGxhOEFmaDU1RDlGay90MVRCUWxSMEs4bVRqYzNyZGZG?=
 =?utf-8?B?NjVvY1pBN1hxREVPa0JnRjM1Rklra1RDTk1Dalg2RVVabW1ndWVhNGhOcWRv?=
 =?utf-8?B?T3oyd1pJaVZsMVoxNTNxeGJSbUdsUXY0b1kyYjRhSm1neEs4TFBpbE9LSDdj?=
 =?utf-8?Q?fsCuiZ?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 03:09:24.7397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cc9694-6937-465f-176b-08dde904f497
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6728



On 2025/8/30 21:31, Manivannan Sadhasivam wrote:
> [Some people who received this message don't often get email from mani@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> EXTERNAL EMAIL
> 
> On Tue, Aug 19, 2025 at 07:52:38PM GMT, hans.zhang@cixtech.com wrote:
>> From: Hans Zhang <hans.zhang@cixtech.com>
>>
>> Add pcie_x*_rc node to support Sky1 PCIe driver based on the
>> Cadence PCIe core.
>>
>> Supports Gen1/Gen2/Gen3/Gen4, 1/2/4/8 lane, MSI/MSI-x interrupts
>> using the ARM GICv3.
>>
>> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
>> ---
>> Changes for v8:
>> - The rcsu register is split into two parts: rcsu_strap and rcsu_status.
>> ---
>>   arch/arm64/boot/dts/cix/sky1.dtsi | 126 ++++++++++++++++++++++++++++++
>>   1 file changed, 126 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
>> index 7dfe7677e649..26c325d8d934 100644
>> --- a/arch/arm64/boot/dts/cix/sky1.dtsi
>> +++ b/arch/arm64/boot/dts/cix/sky1.dtsi
>> @@ -288,6 +288,132 @@ mbox_ap2sfh: mailbox@80a0000 {
>>                        cix,mbox-dir = "tx";
>>                };
>>
>> +             pcie_x8_rc: pcie@a010000 {
>> +                     compatible = "cix,sky1-pcie-host";
>> +                     reg = <0x00 0x0a010000 0x00 0x10000>,
>> +                           <0x00 0x2c000000 0x00 0x4000000>,
>> +                           <0x00 0x0a000300 0x00 0x100>,
>> +                           <0x00 0x0a000400 0x00 0x100>,
>> +                           <0x00 0x60000000 0x00 0x00100000>;
>> +                     reg-names = "reg", "cfg", "rcsu_strap", "rcsu_status", "msg";
>> +                     ranges = <0x01000000 0x0 0x60100000 0x0 0x60100000 0x0 0x00100000>,
>> +                              <0x02000000 0x0 0x60200000 0x0 0x60200000 0x0 0x1fe00000>,
>> +                              <0x43000000 0x18 0x00000000 0x18 0x00000000 0x04 0x00000000>;
>> +                     #address-cells = <3>;
>> +                     #size-cells = <2>;
>> +                     bus-range = <0xc0 0xff>;
> 
> Isn't each controller in separate domain? Or as per the hw design, all
> controllers are under a single domain sharing the busses?
> 
Dear Mani,

Thank you very much for your reply.

No. The design of each of our controller ECAM is fixed in the hardware 
design. This can be reflected in DTS. The specific attribute is: "cfg".

Best regards,
Hans

> - Mani
> 
> --
> மணிவண்ணன் சதாசிவம்

