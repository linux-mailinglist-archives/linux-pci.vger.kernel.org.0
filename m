Return-Path: <linux-pci+bounces-35215-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8476CB3D719
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 05:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B863AC0C1
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 03:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731CB200BA1;
	Mon,  1 Sep 2025 03:18:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023095.outbound.protection.outlook.com [40.107.44.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C3041C72;
	Mon,  1 Sep 2025 03:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756696682; cv=fail; b=kzKpaOt9UWf0KOlqdVhG9EDA7JZfWhBpIoUD7B34K+mt7SGSDjuUqnTbc4duX6UY64RVR6K03VtjS2xUoIgEVnAD7H+I+qjbSR8u1OKXj0nWJUjQ3RKjquVkQqKpkiT/K2dtQAE9TwkiMH4OGlHpy9UIyRasSbfdmpZ7SMUBwGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756696682; c=relaxed/simple;
	bh=dXUR+kYu/bp9UgyJOruPHqsVZS0lqJgnjItCPdQXC9k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GZeWCOKd7tgF1RgNwZemdqpav80E6RMtkg4IdgTlolzdZ0yqs7JQSexVzZUKsMFP/t1/6hoTMt/9vRO3p8eL8Bwnk1x+09rNAgIZsIl8BjlA/rCS0qLrG16bXmi+36hG8kgcbfaAiGGXSBp77f3QQ0sQwrVHSMEDn+OGHJcUPlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAxGmMUiMauvU9D2rjBQpL6kPdWVi5qIGLGpRQRy+unSvQcSBejn/sCw9tocEElvkLendj4msUlwsQnghPaxNkeQx7qBYm3hGpg8GpIi3tZET2d9rqXRkfcjUOXPeeS66Q597wsV63L2munfPKc4nmjpZWi4fV8bZSV4yd390+eRfV6JWZJ0AmQlwOZ5obsgROAQyE/Qt14aggiWkZgAA3bNsUue7Q01o2qRyZGp7ta6aJEayxFGCsUxNqRElIB3xHjYnAbdpV5ZwVGdnu0KEI6G7d/y9qSh96D3YzNMWPBQPFXrVwEh2/V8zqCP/capg055TkKnOGJzJdg1/o8/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XXkSsO0XhTpqvhKg6Xr66oZTLhqygtZT72qttqbTXE=;
 b=PryY/ljcyzRj97S3R3NJ7QCDK+IpS0V5eN3psGTJ6AjlI0cgTxJoF/m99w1lydfdLY5Qomtd57qFly3KSZj5mLtYqIzAFv077Ix3xVhID0vm2wVHajsvme6IiKeuoNsJSiyYiB5SfL9a/6F6BbGX/qA9BbTlfoPFPYnrLpiszPsjzH8bQZbCr6LqksjGUMR5NWFDzI4Dn7Upf5dq6szQ0TT7n2TYwLSRxrGkGtJ0ROT8vmoNJR9dEbvyFQCTaFNUhm0oTSiyy6s2gMSEP+Ynf5xf2Rxh7yTDWqmbWfMGrdZ9yxDXBbzmq+5bdDIxDb7NBqwm4/WkTBofK7RF4v6eLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR06CA0194.apcprd06.prod.outlook.com (2603:1096:4:1::26) by
 SEYPR06MB6375.apcprd06.prod.outlook.com (2603:1096:101:148::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.26; Mon, 1 Sep 2025 03:17:56 +0000
Received: from SG1PEPF000082E2.apcprd02.prod.outlook.com
 (2603:1096:4:1:cafe::9e) by SG2PR06CA0194.outlook.office365.com
 (2603:1096:4:1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Mon,
 1 Sep 2025 03:17:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E2.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 03:17:54 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id D9EB541604E2;
	Mon,  1 Sep 2025 11:17:53 +0800 (CST)
Message-ID: <7abd8eb3-7ec1-474d-9595-f229cd2c9c68@cixtech.com>
Date: Mon, 1 Sep 2025 11:17:53 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 15/15] arm64: dts: cix: Enable PCIe on the Orion O6
 board
From: Hans Zhang <hans.zhang@cixtech.com>
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
 <011b1e32-10e6-460a-bb9d-95235d926ed6@cixtech.com>
Content-Language: en-US
In-Reply-To: <011b1e32-10e6-460a-bb9d-95235d926ed6@cixtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E2:EE_|SEYPR06MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: 817d8830-1b7f-4828-1f58-08dde906246e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTFqT0RtOWYxSlBKMTdSVUFBZzlMdUpveUdDU2NOSDFWRkdmOEdOc2xKWVdm?=
 =?utf-8?B?MDFVejh4Q0crM2hVZzF0Qzc2UUVHWFJiNlJMSFp2ZktwcWt3NTRMNHZPRFpt?=
 =?utf-8?B?T0ExSkFRWmlRcGVJZHdqNmN5SkJzc0l6VXBQMmJZSTFsUzhPeDMweWQvdnJr?=
 =?utf-8?B?WjZDdFlMek1TOWh0YmVnQm1XWk40d0pVWlB2LzNuM3k0N2Q2NXNnODVPZ0ZE?=
 =?utf-8?B?K09nbVRPdnllMEViWjl1ZGpCNUo4cHg2RHRjL2JtNm1sbm1GVCtIb25Ec2xr?=
 =?utf-8?B?MVpRaGxWM0UxWGoxYWFRVXNhUGc5VXFsM0tZR29SeXl6Tm5kY05leGZuWDhr?=
 =?utf-8?B?T2s4MnRabHFXUTU2MjZBYy9yelFBQTdqclhzYlc2QWZGMnMxYllYVURYdTBr?=
 =?utf-8?B?OHZJTlprT2RtVTZUVWQwaEE3SDBUQ3BscFk0YWJXa2tXM0lkZ3AzTzRBRE9n?=
 =?utf-8?B?dVhDdWtlcGVET1RSTEMyZ0RrVVo1NXUxYmR0cEdsTXVRb1U5SWtpNGh0amNv?=
 =?utf-8?B?S0Q1US82eW96TXJYL1Q5S2lLenJSK29vUzRDakovUVZJNzY5UGdPQ2NmejFO?=
 =?utf-8?B?TDVDaDBpK1VJMnVYYnlHaUlmQW5TWUpEYklpbmFITGVWZXM3ZHI0MXE4TVpN?=
 =?utf-8?B?cXZwbVl1ak5VWmUrTk5qNEN4bW42Z0JqcGcvRjQ2dFkzMjFNYlJ6TGIrdVJj?=
 =?utf-8?B?YWhkTXVTcDJPL09GMi9TbDdHOExBMk04THY1aVM4OHFJUnl3a1BvazZaVDdO?=
 =?utf-8?B?eVo1MGxjTG9EQTJ2c2EzWS9zK3FJNUJuQlNHeWpBZytyUFJLNThkNElmczFL?=
 =?utf-8?B?K0xYMDM4Nm43SlZySlhXdFROSHlnU3BxUGhYRHZaSjMyc2lRdjVLOG93U0Fm?=
 =?utf-8?B?N05rTmVwa2JBZThyR1hsMStDbW5EZUY0VStMMWFBYy8xODZmdUZsTytxeE5N?=
 =?utf-8?B?a0JpLzcyS3FWcy9QM0RESEo4eXpDcjJLc3hIZmM4c2Qyc0lMRm16dER4SGRX?=
 =?utf-8?B?ZmRyaWFCWkVYbkttWmMxTDlERERJSEF2RTFmaEpaNGdNbXVONEljc0xiOFNj?=
 =?utf-8?B?eHR5Zk40alFaWmxqdU1URkNHeWJicXgrOFNZSWU1d1pGZGluSjlKeXJ3RWpu?=
 =?utf-8?B?cmpTcFc2cW0yN0tJNStEdE1YZ0o3NmhJa2ZBWVRMTncwRnoxOUtwV1NVNWRl?=
 =?utf-8?B?dXdJNHRRcEg0VGZ5RWtLS0NSSHBrV1I0S09jWkRKVXpESWxiZ04weUxmL3JU?=
 =?utf-8?B?dEFCeGIzUjIrZTNEMCtBWVMycGpaWWo3dTQ3SmtEbWNjS1hyTzloVE1pM2t1?=
 =?utf-8?B?alRRRnFhYXI4RnExUUIxWTVCcTJleDhUWEM5V1NvNGpWcGhFdUlwQm1uSUNm?=
 =?utf-8?B?QnkyUEJUWDdML0lWdXRucU1VMUZOREZOZlRVc29RTWVadlZkcW9SZ0xTL29j?=
 =?utf-8?B?S01ERUI5dUlOWjZaUFpLVWVXeCtJMVZjREFpelBVeFdCZVRFRWxldXlZMG51?=
 =?utf-8?B?NlRHdlBpN21aUnJKd3lvZFZJYmRUUUIxMEZNQ3ZudmlPM0tYRHZwckYzYyto?=
 =?utf-8?B?eHo5c1FCcnhFZmNZK0VMZ25KSWNROHNNUjBDLzZSb05IREJRQU9BalAyQU04?=
 =?utf-8?B?UzJ1aDJzdG5XSVRCaVJMM3o4bWVpTWMzU1pzYkN1TG5PKzM0dGxYZHFwSENQ?=
 =?utf-8?B?OHpwU0FkTkZsRURPZnlDVVI3Z1NOVDkxd3Jjd1NYNUNUcDk4YkFheEZCTnRL?=
 =?utf-8?B?WXptNU5DSjBOWCtQRXB4bEhYZ3Y3dXFnYXZLN2JJdU5GWTFiSVgrV3V3TnlZ?=
 =?utf-8?B?dnlkVmRGTjB1dm5nVTBGR1dZbExsRFhWM1NUSVZpc2JYdWVuZURkTnVaSkNl?=
 =?utf-8?B?aFpHUW1HaE5QYUR1ZE5BZUwxS2ZETFJZbTFkaVFvN2JzVVdpSkpqSHF2aGoy?=
 =?utf-8?B?L2Nrd2tWSkx0S00wbzY0TGVqNTJvZTR3eWI1S1IrcUxkc2hlOVJNOHNST01M?=
 =?utf-8?B?QWViRkVoWEp1ZlR1djNXUlMvVVo3OGV5anVnak9OOXB6SHZXWHZ3WTlzS2hY?=
 =?utf-8?Q?XT0V9S?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 03:17:54.5178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 817d8830-1b7f-4828-1f58-08dde906246e
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6375



On 2025/9/1 11:14, Hans Zhang wrote:
> 
> 
> On 2025/8/30 21:33, Manivannan Sadhasivam wrote:
>> [Some people who received this message don't often get email from 
>> mani@kernel.org. Learn why this is important at 
>> https://aka.ms/LearnAboutSenderIdentification ]
>>
>> EXTERNAL EMAIL
>>
>> On Tue, Aug 19, 2025 at 07:52:39PM GMT, hans.zhang@cixtech.com wrote:
>>> From: Hans Zhang <hans.zhang@cixtech.com>
>>>
>>> Add PCIe RC support on Orion O6 board.
>>>
>>
>> So with this patch (and dependencies), the endpoints are detected and 
>> usable?
>> Any limitation with not supporting the GPIO and pinctrl should be 
>> documented in
>> the description.
>>
> 
> Dear Mani,
> 
> Thank you very much for your reply.
> 
> We can rely on the initialization of bios. After the GPIO and pinctrl 
> are upstream later, we will add them in.
> 
> Just as I described in the change log of the cover letter, we can 
> enumerate devices normally and use the network normally.
> 
> Just as the first version of this driver also did not have GPIO, 
> pinctrl. Moreover, Arnd also suggested that we could separate the upstream.
> drivers/pci/controller/dwc/pcie-amd-mdb.c
> 
> 
> This is the situation of running the latest linux kernel on our O6 board.
> root@cix-localhost:~# uname -a
> Linux cix-localhost 6.17.0-rc4-00015-g5aaae89e41ab #203 SMP PREEMPT Mon 
> Sep  1 10:54:16 CST 2025 aarch64 GNU/Linux
> root@cix-localhost:~# lspci
> 0000:c0:00.0 PCI bridge: Device 1f6c:0001
> 0000:c1:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 
> 8126 (rev 01)
> 0001:90:00.0 PCI bridge: Device 1f6c:0001
> 0001:91:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd 
> NVMe SSD Controller S4LV008[Pascal]
> 0002:60:00.0 PCI bridge: Device 1f6c:0001
> 0002:61:00.0 Network controller: Realtek Semiconductor Co., Ltd. 
> RTL8852BE PCIe 802.11ax Wireless Network Controller
> 0003:00:00.0 PCI bridge: Device 1f6c:0001
> 0003:01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 
> 8126 (rev 01)
> 0004:30:00.0 PCI bridge: Device 1f6c:0001
> 0004:31:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 
> 8126 (rev 01)
> 
> 

Dear Mani,

In the next version, I will add it in the description.

Best regards,
Hans

> 
> Best regards,
> Hans
> 
> 
>> - Mani
>>
>>> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
>>> ---
>>> Dear Krzysztof,
>>>
>>> Due to the fact that the GPIO, PINCTRL and other modules of our 
>>> platform are
>>> not yet ready for upstream. Attributes that PCIe depends on, such as 
>>> reset-gpios
>>> and pinctrl*, have not been added for the time being. It will be 
>>> added gradually
>>> in the future.
>>>
>>> The following are Arnd's previous comments. We can go to upsteam 
>>> separately.
>>> https://lore.kernel.org/all/422deb4d-db29-48c1-b0c9-7915951df500@app.fastmail.com/
>>> ---
>>>   arch/arm64/boot/dts/cix/sky1-orion-o6.dts | 20 ++++++++++++++++++++
>>>   1 file changed, 20 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts 
>>> b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
>>> index d74964d53c3b..be3ec4f5d11e 100644
>>> --- a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
>>> +++ b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
>>> @@ -34,6 +34,26 @@ linux,cma {
>>>
>>>   };
>>>
>>> +&pcie_x8_rc {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&pcie_x4_rc {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&pcie_x2_rc {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&pcie_x1_0_rc {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&pcie_x1_1_rc {
>>> +     status = "okay";
>>> +};
>>> +
>>>   &uart2 {
>>>        status = "okay";
>>>   };
>>> -- 
>>> 2.49.0
>>>
>>
>> -- 
>> மணிவண்ணன் சதாசிவம்

