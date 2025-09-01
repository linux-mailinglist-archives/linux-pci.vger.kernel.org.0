Return-Path: <linux-pci+bounces-35214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6FAB3D714
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 05:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4261C3A7FE4
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 03:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159D621B9C5;
	Mon,  1 Sep 2025 03:15:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023125.outbound.protection.outlook.com [52.101.127.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F3E218AD1;
	Mon,  1 Sep 2025 03:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756696505; cv=fail; b=cgWvLgFq/Bl4iN4j95E8AuxIo6MAx5EBJY9CU6q+a8YXP+4Gwdu5Ch8z2iSB24krBpNUhVDyKqFH3TRh0ZdIXFnciOTqp4KQVrCx8XYM57lWlLbuAPvJlmFo8VAT2xGkraaQRzJc5HSdYexGPQLZ+kfc6j+oiKnYGCTPc98WfFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756696505; c=relaxed/simple;
	bh=OgGNUL+azVFyNqSdr9I7szM99hqbUqsr0GRxFAT3OTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mY9Zdt9FpZNhUDXMYkZhutkiEEiwyd6uBvwyCgI+7WaThytFWILVnAPQEb0wtfF9qQs8FVtoqwWcSVgn8TyD6P463cgvb27So2n5w6r8RSiCWqzde6M5Nlsmm46XmKX0PjTNinljrBnKt7SM91EHJ6q6r8IyoGbk29SdV3GVbU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndaKcKtuJ/DBXVSumu7r9WuTSaYjnmFB4TbetvGfmASHrAlzAIJgZSTnI5/GedXZkryNY4w5ocM0kkbWt7HyYSBJbC+YMEJmkdZm/fxtjz3bjyXED6gyvOWkomxAjO2ifqhgBJEosR2HbftFFp6rTvtJ9jZNgkfWqHE4KSVjjnFAXckQiaHPGORAGVzd/1dQcWaNn3B+QAxQv30WwdF3AEnf6p5ERbg4Lh8IlcOYCQfIngqs2V04OFWVjpGOn8hIpEzk81khAhlt4SIGFbV6FbJ8EBkUKHJtMbS4QF4NqUnY9JJiZvM5nVnfdkoIZN08gz7zgsZV4ep7XN4i4MBKnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uM1u2qoa7DsySqulOiuRRROFTyCTJHXS2g3w1pXTbCs=;
 b=ydssNGkVc8/X8Ov0DgTK7G+xz8aZ0NQiBdiTNLjVIVIBLksN3IcAkkHnzGPQk9sSKUJoLbKaSPtPjswiVuHv++B+N144k/Nj6bvEyyiooJwTDElyvdPkg/X71o+mDx0yodWjlmSTu5qoVLJYFFiJr0fMKJ1yAbFwu/fjaRNZ+tUNZHQNsl7fPIjXKKbM1ar1bJTN1bRsK5zAbQpIRdZlGma+NyX4ojhKaJrCAGj49KUZ6RuitSZfNaGHu5NQAji1C15RcV5aINrG1a10Xp6CkXikqkYVf9hWL5RAue4Nv+uFZhAKbUl17Rllr1xtug/LhnRvkSZnAmVzW+5l6+q76Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP286CA0035.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:29d::8)
 by SEYPR06MB5253.apcprd06.prod.outlook.com (2603:1096:101:87::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 03:14:57 +0000
Received: from TY2PEPF0000AB85.apcprd03.prod.outlook.com
 (2603:1096:400:29d:cafe::73) by TYCP286CA0035.outlook.office365.com
 (2603:1096:400:29d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Mon,
 1 Sep 2025 03:14:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB85.mail.protection.outlook.com (10.167.253.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 03:14:56 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id CE38541C0144;
	Mon,  1 Sep 2025 11:14:54 +0800 (CST)
Message-ID: <011b1e32-10e6-460a-bb9d-95235d926ed6@cixtech.com>
Date: Mon, 1 Sep 2025 11:14:54 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 15/15] arm64: dts: cix: Enable PCIe on the Orion O6
 board
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mpillai@cadence.com, fugang.duan@cixtech.com,
 guoyin.chen@cixtech.com, peter.chen@cixtech.com,
 cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
 <20250819115239.4170604-16-hans.zhang@cixtech.com>
 <2gc5kikpaljgfkh3zeikvbtgttdbaejrhn7gjc35q4ih67eeje@o7bjvmt3o26n>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <2gc5kikpaljgfkh3zeikvbtgttdbaejrhn7gjc35q4ih67eeje@o7bjvmt3o26n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB85:EE_|SEYPR06MB5253:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ee6afaf-c483-4fec-91e7-08dde905ba2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXgvbEdSd3A5RVZGTnUvNm81ZTIzWGN3Q1c3TXgwRVFtbWEvc3FaTENRM0lN?=
 =?utf-8?B?M3lGV2F6NWVLYjM2QVQ5c0RnUTN2eHNNTXVKMUI3TFNuVGNpenM4S0I1RGxz?=
 =?utf-8?B?TlF2Rzl6bjBudGZ1UkZ2S1A0NnVubXcxbEdjRkFuR0thT0lHUDZuSEZSYlRI?=
 =?utf-8?B?UXQwWCtQcmVoLzRRaGV1eURjaVVndGx4aWtHTlkyUGxmUlRhRXZPVmVlSDZH?=
 =?utf-8?B?aTJGakFsd21WRkhJN2ZuQUEyd1dsVVYvZk8rSjYvTlZEZHRZdUdtRThRNmYy?=
 =?utf-8?B?MUVrMXVZS3E5Y3JuWGl6ZWlGZkhRdkswNTNwZjlobHI3QnRDa2V5L3ZxZzNW?=
 =?utf-8?B?cGJMZVlXLzUrQ0FEbkk1aUp0SlBidjBFcEhMVTZHWEJIVUdBZmhpTStPOWhZ?=
 =?utf-8?B?K1VWYkpJUHFTVmlBMSsvTzhBWmVCK1hOOUlzb29WZHhTSHc0WEszU1NZZDRC?=
 =?utf-8?B?TytTWWh1VTc5c25abDFZTXVlT3dVenV3ZmlhNC9GUkFpYmIraTR5UHNWaEJP?=
 =?utf-8?B?djNEdThLWkRwZHpveUNFYnFrQjZqdFJlOVZVRzJmVFUvZXc0aVFkaHlkVVpT?=
 =?utf-8?B?b0E2QndsbkFhb2pBd2FhWkR4cUVTZlc0bTQzOEo5QitXZWxFdmZlaCtKVVlj?=
 =?utf-8?B?V3UrOXdwODgvN0VSc010cEZISGxjdU1sWHNJVi9haVREMm0rS2ZCRXJLYkoz?=
 =?utf-8?B?eHArY2xMbWhrV0lYcnE0cy9vWmlNbG91eVQvVG5hRnZUMVhISFhlNm1VVlk2?=
 =?utf-8?B?S0wwWS9iTm5vZkhzZHo5eklOY2c0TWpwczlXc1UrektCMzJyK215VzNGUFhP?=
 =?utf-8?B?dmU3cTRjd0gvcnVMNVJmZlhGSzRoSHpLeHc2OTV3Vjgwb3ZLRmRwNXpoakha?=
 =?utf-8?B?UGhlYjNvNDdpckFjYTFYODZFdStoMTNIR2k4VExneVRrUmM0NEZjYU9adEli?=
 =?utf-8?B?SHppUmZKNXBDMUNoT29vOU4rZERlYTFLM0wzL2h5cDA2VU90M1lGWHNERkFq?=
 =?utf-8?B?b0tzRWFzWFBaWVU4RUdXOXZjUWtJOGpaalNHNjA5RkYydGZ2czZTVFNjdzhY?=
 =?utf-8?B?a3hkNDFxN1Y1cHM4TFI4VldaaWRlV1NISVcxRmNMdk9nRXdIUXJUbGEwVWRu?=
 =?utf-8?B?VjBPbHhuUTRqdzlZdDlFeXRQelFiNVN6SEtORFIxSW8zdXJkbloyRm5Ga1dG?=
 =?utf-8?B?L3JmLzVIQlF0QkRSaGY1c25wY1hwK3NRVDlObXR5dUFaUTlYR0VDNVRaTmVx?=
 =?utf-8?B?Y2s5SnN4THJ4QjhNbE9LdVhzL25odTRoN0swZHdTYitKUWFrU0kzR3FEMmQx?=
 =?utf-8?B?NmdKYStIazlHNmZkTDFyYkhDK0tmUGN5dGtVR1A4b2k5Q29Zb3FLYy8rNi9Q?=
 =?utf-8?B?dlZVNzZwMXkrcEN1MnY1bmxESTB5aXk5aVRDdkgxL0diTWt5aHB4NWtaeEZZ?=
 =?utf-8?B?NXNZaGkxYjgrMTRiT2pPREtVNjVWZndDaUdDLzhaTU03TlM1dDBqdlM3Y2ht?=
 =?utf-8?B?Mm02VWNTYVdWMWxUSm01VTlvRm9vU20vMHh1V3BBUDZENnlORFNlWmc4cndE?=
 =?utf-8?B?dE5jZEZTanNadWFsd3VoUG5EcHJhZHpJczB4RzJLYjUwSVp3c1c2aDlWWkJk?=
 =?utf-8?B?WXJrUFZJL0ZJdGpJNHRXajB3MTdkK0JXTXQwM05DUjBRdUM3NzBjTEwxMzNp?=
 =?utf-8?B?elVFUVlDU2lRcDlmZ01YMDFFcG5BQUN2alkzaHVnOTFiTXNVWjdoUkxqQTFp?=
 =?utf-8?B?NG40U0pydUk1T2xrdGFsOWdGM0hpMlYzTnQyTkFVRnBYeXRZY1BDRWtJeXhR?=
 =?utf-8?B?OW9ZNlVUczE3T0d3SDBkVlE2WHo4Rzh0S3VtK216RXVnK0gyVmkxM09Zb0lE?=
 =?utf-8?B?MUFFUm5tc2V0Tm9sRGwzTTlwQjFjMTh5SndEekVCeHl3bTMyMVdVWmJmTTh2?=
 =?utf-8?B?TWlGcjBtZjZZK0VDU0lHVEROWE1nNDZaRE9Vcm1Rem5oK2FLSmk3Sm5GQUF6?=
 =?utf-8?B?ZENhNG9RZkNGQTRoL0tJeDRWL3VDRTZSSVQ2TjJBVDlUMmtTWkw4ZkNZa1cr?=
 =?utf-8?Q?nPqr6M?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 03:14:56.0233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee6afaf-c483-4fec-91e7-08dde905ba2e
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB85.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5253



On 2025/8/30 21:33, Manivannan Sadhasivam wrote:
> [Some people who received this message don't often get email from mani@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> EXTERNAL EMAIL
> 
> On Tue, Aug 19, 2025 at 07:52:39PM GMT, hans.zhang@cixtech.com wrote:
>> From: Hans Zhang <hans.zhang@cixtech.com>
>>
>> Add PCIe RC support on Orion O6 board.
>>
> 
> So with this patch (and dependencies), the endpoints are detected and usable?
> Any limitation with not supporting the GPIO and pinctrl should be documented in
> the description.
> 

Dear Mani,

Thank you very much for your reply.

We can rely on the initialization of bios. After the GPIO and pinctrl 
are upstream later, we will add them in.

Just as I described in the change log of the cover letter, we can 
enumerate devices normally and use the network normally.

Just as the first version of this driver also did not have GPIO, 
pinctrl. Moreover, Arnd also suggested that we could separate the upstream.
drivers/pci/controller/dwc/pcie-amd-mdb.c


This is the situation of running the latest linux kernel on our O6 board.
root@cix-localhost:~# uname -a
Linux cix-localhost 6.17.0-rc4-00015-g5aaae89e41ab #203 SMP PREEMPT Mon 
Sep  1 10:54:16 CST 2025 aarch64 GNU/Linux
root@cix-localhost:~# lspci
0000:c0:00.0 PCI bridge: Device 1f6c:0001
0000:c1:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 
8126 (rev 01)
0001:90:00.0 PCI bridge: Device 1f6c:0001
0001:91:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd 
NVMe SSD Controller S4LV008[Pascal]
0002:60:00.0 PCI bridge: Device 1f6c:0001
0002:61:00.0 Network controller: Realtek Semiconductor Co., Ltd. 
RTL8852BE PCIe 802.11ax Wireless Network Controller
0003:00:00.0 PCI bridge: Device 1f6c:0001
0003:01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 
8126 (rev 01)
0004:30:00.0 PCI bridge: Device 1f6c:0001
0004:31:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 
8126 (rev 01)



Best regards,
Hans


> - Mani
> 
>> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
>> ---
>> Dear Krzysztof,
>>
>> Due to the fact that the GPIO, PINCTRL and other modules of our platform are
>> not yet ready for upstream. Attributes that PCIe depends on, such as reset-gpios
>> and pinctrl*, have not been added for the time being. It will be added gradually
>> in the future.
>>
>> The following are Arnd's previous comments. We can go to upsteam separately.
>> https://lore.kernel.org/all/422deb4d-db29-48c1-b0c9-7915951df500@app.fastmail.com/
>> ---
>>   arch/arm64/boot/dts/cix/sky1-orion-o6.dts | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
>> index d74964d53c3b..be3ec4f5d11e 100644
>> --- a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
>> +++ b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
>> @@ -34,6 +34,26 @@ linux,cma {
>>
>>   };
>>
>> +&pcie_x8_rc {
>> +     status = "okay";
>> +};
>> +
>> +&pcie_x4_rc {
>> +     status = "okay";
>> +};
>> +
>> +&pcie_x2_rc {
>> +     status = "okay";
>> +};
>> +
>> +&pcie_x1_0_rc {
>> +     status = "okay";
>> +};
>> +
>> +&pcie_x1_1_rc {
>> +     status = "okay";
>> +};
>> +
>>   &uart2 {
>>        status = "okay";
>>   };
>> --
>> 2.49.0
>>
> 
> --
> மணிவண்ணன் சதாசிவம்

