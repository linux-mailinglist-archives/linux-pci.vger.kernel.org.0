Return-Path: <linux-pci+bounces-26764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EF5A9CD23
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 17:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944354A686C
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 15:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC73926C3AE;
	Fri, 25 Apr 2025 15:33:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022113.outbound.protection.outlook.com [40.107.75.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB9F25DD17;
	Fri, 25 Apr 2025 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745595198; cv=fail; b=lAXWg7o674ZNm54sDvfd/tc61SAN5D5Ym9UlLT/uWF9MTdIB7WWNvylUqg1aJ9N3f7RUO5Aa0ftU6+DVShi764Hx//RUU0inC7BCBbCnlG+jPiEM1x1trASKgnnVRkr722yjGmcrEnrk5z1TTtVK/7yps4auNhu+BpD2H60GPZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745595198; c=relaxed/simple;
	bh=QGYbkcGqsKONHSy9/yVc5p1c/uc6S/EqyW5RdGOO/8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DWXG+WJZKWutoulxVMfdIeOh0ALzLEsmy6e/F5cIjUU2RSQvjES4Y3yUXrtqlK6obLiqZGFnNZ2ZRCX8vlrUBoWRSyDVCYSampRduv0512aeeQ21s9mAswCXwixNXnjuTLLkb+p8+u6vSPqPL9mba98o/qgOyGWdIaJ+rgjrLnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPhOGipnQoFWxiKr+dJtqeXwsM3Oqj6kP0OeGSO2sksXGXdMR3bz0YM6KwzZJiiDcH5wS7gZwTXTPrrkIdq+Wbk38QMtsy0AcGOpGPo4vRacnKnDXWTh2XTkWaThGAOFMr2f0RaNP6gz97sweODAgUqhpvjb0jqUnz4AaCiHoTucWn1CnT7B0+/slJGvvY9+Ku0/P0W5qIF6cqkinL/N3yV41wIOR+Q4lwUGlrZMQW43vpK4auzNb2DXc+iZWzpixE/vGIBmimRKlu4jZ86V4FZ92yfF0osAcfdJOg/F4l/l6FbKRsMIYrHv38Dc06GyVm1ya1yQBuLjmprUnZL4Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJNrcF0FIHXEYZsntD5pbLhkeUZCY2pTGoUPqBRsYCs=;
 b=u9tF0SobfPSoNcULH2DZWKksiIzFTiTU14pdeVmLphv4QtzR+SlKLvjdC3W1tuDEt2NEcx5lShXuNJ/r3Y/5EU2izFEZK1lmMJCi9vMtGWH4T4ejkTQ5NtD0PuPKyk80MM5J9HGJkjayFS21vqeIZuViXDn2/P6e3XYx1k1TFszMlDkoJJHZNcQRKKjk1NEEDLl3tFTSnPbv4CqGS5nZ2Fg08qq2w0mHm+HP323YsWrIkX+ykNLvcX2HsTaXun6C+a2ZP4EaOyNhiYS8C5ZGh4xg7NXQkyjkWNmbs3NgcI9New5YgftnA/HkFoeQG9Af5912n4H9BycgSjlnJSsW3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP286CA0056.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2b5::17)
 by TY1PPFDEC2C26D0.apcprd06.prod.outlook.com (2603:1096:408::92c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.25; Fri, 25 Apr
 2025 15:33:08 +0000
Received: from TY2PEPF0000AB87.apcprd03.prod.outlook.com
 (2603:1096:400:2b5:cafe::78) by TYCP286CA0056.outlook.office365.com
 (2603:1096:400:2b5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.39 via Frontend Transport; Fri,
 25 Apr 2025 15:33:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB87.mail.protection.outlook.com (10.167.253.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 15:33:07 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id E645441604E7;
	Fri, 25 Apr 2025 23:33:05 +0800 (CST)
Message-ID: <5334e87c-edf3-4dd9-a6d5-265cd279dbdc@cixtech.com>
Date: Fri, 25 Apr 2025 23:33:02 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] dt-bindings: pci: cadence: Extend compatible for
 new EP configurations
To: Conor Dooley <conor@kernel.org>,
 Manikandan Karunakaran Pillai <mpillai@cadence.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
 <kw@linux.com>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "peter.chen@cixtech.com" <peter.chen@cixtech.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250424010445.2260090-1-hans.zhang@cixtech.com>
 <20250424010445.2260090-3-hans.zhang@cixtech.com>
 <20250424-elm-magma-b791798477ab@spud>
 <20250424-proposal-decrease-ba384a37efa6@spud>
 <CH2PPF4D26F8E1CB9CA518EE12AFDA8B047A2842@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <20250425-drained-flyover-4275720a1f5a@spud>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <20250425-drained-flyover-4275720a1f5a@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB87:EE_|TY1PPFDEC2C26D0:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ece377-799c-41e3-88d7-08dd840e7a69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkRETHhkdUlneFQyQ0NFWEtlVXEwckNheEFnWEpiZFlpbVlBS2VWYm5oSW9w?=
 =?utf-8?B?TUVRQm8vT0FQMS8yNWpFZi9HWHFOd055b284ek44SmJsZlN1dVpLVVhDVXhp?=
 =?utf-8?B?M3ZsVVQzVEdjNkhVU0MvOFFiSy9tWmpSSHM4b2dmc0JuVXg5TFJYRldPb3Na?=
 =?utf-8?B?SmJxT3drb3JoY25zdU1ZNDZwTDduZUtEcG16blBsT1NKb2VqczZOMUNwSm9F?=
 =?utf-8?B?MHJ3ZGk4cFhxcEwvRjQ4UC9PU003NEpsYTB1bEpET3h6Y25ZaFRKNnUxTUpl?=
 =?utf-8?B?QW9DUGVLRitRZHZRbVB6aXcwYU1tclp6MXVhRHNMK09mNm13SFJRcmJoOHRI?=
 =?utf-8?B?WlRXVm1VNVZQU0V6NUQwNFRMWFJBTndiTHhQSFVOQ0dxaHhjTHZyR3U5Q2Ji?=
 =?utf-8?B?c29qamk4S2tWSXNPRjlabXZUanU0ZnBsMVBHbEFFbGd6b0hWK21vU1NSb1hN?=
 =?utf-8?B?RGxSbEsrMkZnbWM1elVGWVR4cFZkcVg2aXdEa2JObElxVEUrcnFpbE5BemUz?=
 =?utf-8?B?L1JSZXRMWnBibm03OXFtVEpSTXM5elVLSEljY0hiQ0tzQVdvRnV0U3NyK0dH?=
 =?utf-8?B?UEswWFZGM3hjQzNOOXJYcXN3Z1JHSzBuSk40Q1RpdW15OWFHN3Q0MmtjNWxQ?=
 =?utf-8?B?ekV3ZGVMTXNrckFvQlJ4NkRTZ2NRNVg4emdPRE8vSlM0WmpQZmpmanRNYm9Y?=
 =?utf-8?B?N0IxeU1kdnVwZUlPaGlsR0Z6YzdScUpYNWZPSjhEZjFZN0lCYXZBOVFaZDBp?=
 =?utf-8?B?aGI2WDRwTmRVcmhRUzc5ZTlrcjMvY3pYV2U3eWFXRSs4aVdWMUFQK3R5TkQy?=
 =?utf-8?B?aWlxUWt2bzRLRmtwYXFIcWRNa1VTT1FLeUtqSUFpWmNIUGZ1Q3Q5VWNrQzZL?=
 =?utf-8?B?eG5FSmFqM2x6UXZucUhLRTJtZWpCeWprQmVIcmQyQjU0NTByZXRqcVFGSytE?=
 =?utf-8?B?aVM1b0h6YmNyR2svOWc0QnJFa1B0RUlEUmNsZ0dDc3JoYmJiWXMwREpMWjA4?=
 =?utf-8?B?OHpVVFdjZVF3VzVDeXJyTVVFOG1pSld0aVcweFNwYjU2WUVJSlpDTFAxQnBB?=
 =?utf-8?B?cnVSaE0xZk9BOXJYZEMvSEMybncveXJvS2JINVhRSTV4eld4U1hvV2VZTDJ5?=
 =?utf-8?B?enQ0cDUzczQ0dHVEelMrSlhXT0FpL3gwRWZCQWFTbDdJSHAwNjRkOXB6ZGRr?=
 =?utf-8?B?THV5aVlnNWxsKzhkck9FcmlPMnRJWFM2dGM5dUd3VGZsNzdsNHdNc0w0bThC?=
 =?utf-8?B?SXN6MVVWdkcxNmxrVGZwYnNZU2lOblFLUGZUNnRLaktSUWVhRlFGa011am1r?=
 =?utf-8?B?UmwybTdncXJVQjVMUHdNeXk2QVg1ZHhvMU05ckI1cHY4T3dGZ2dheVMzSlBi?=
 =?utf-8?B?ZHE0T3pmR3QwOWdwOTVqeHJDYmt5dVBpQ1VaK1VmczBiSVh2MkZCYWhqaW1M?=
 =?utf-8?B?bzFaZXZBeEVuN21aUGxiVjF5QmhjeHJhZzEzOUFFMkFuRm1rdWgrZkhpMlBL?=
 =?utf-8?B?M3RybnJIYW1aZHAySTN4ajJJem44djNscW52aE5kWTJ2bFI0VDRwYnp1RWxH?=
 =?utf-8?B?QTlKR3ExN0FJc2ZVRUJuWG4wSlZyUURiZEpmWld6dDV6NlhuZ29mL2xFNFlC?=
 =?utf-8?B?NFpLOHJNRENoZ0VPOUF1bWU2MTloZ1FqRVp0Z2Z4SGpzcWErcVVkNDFTVldt?=
 =?utf-8?B?L0FrMHBPL3NjcldOc3k5b0NsUHFpOGoxUUZocG8xOXBjbzlhRVltNTM5ZEFh?=
 =?utf-8?B?by91VnVtWjBrRTYrL2hBMXRZZWRpcExhRFVpN2d6Y25oNmFCMU5VaUl2T0lS?=
 =?utf-8?B?M1IwOENCbDJ4OTJXVmZFQ0svR3hSWklUTFV2WTVPUGJBajlRQU1NdnllaWlo?=
 =?utf-8?B?Ym4wMExoTytPSFdpdEhPdjVCQVRtRk5tZ1k4Sml2WVZlN3lVelo0cXJrQnRH?=
 =?utf-8?B?UDQ0R0Qwdko3ZE9MR3VYYTJXbGpyLzFybFlFVEUxRFJlSzZOMEZGaXRKZU1H?=
 =?utf-8?B?b2QyMkNOcFdIT2JVVVo3Skt5KzE5TWM3TC9DNGplOUtpR1NKYjlqa1pPRGpP?=
 =?utf-8?B?cUFDWXpMdGdtTTZQZTgrZjZTcjkrUlQ2bVpkdz09?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 15:33:07.0715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ece377-799c-41e3-88d7-08dd840e7a69
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF0000AB87.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFDEC2C26D0



On 2025/4/25 22:48, Conor Dooley wrote:
> On Fri, Apr 25, 2025 at 02:19:11AM +0000, Manikandan Karunakaran Pillai wrote:
>>>
>>> On Thu, Apr 24, 2025 at 04:29:35PM +0100, Conor Dooley wrote:
>>>> On Thu, Apr 24, 2025 at 09:04:41AM +0800,hans.zhang@cixtech.com  wrote:
>>>>> From: Manikandan K Pillai<mpillai@cadence.com>
>>>>>
>>>>> Document the compatible property for HPA (High Performance
>>> Architecture)
>>>>> PCIe controller EP configuration.
>>>> Please explain what makes the new architecture sufficiently different
>>>> from the existing one such that a fallback compatible does not work.
>>>>
>>>> Same applies to the other binding patch.
>>> Additionally, since this IP is likely in use on your sky1 SoC, why is a
>>> soc-specific compatible for your integration not needed?
>>>
>> The sky1 SoC support patches will be developed and submitted by the Sky1
>> team separately.
> Why? Cixtech sent this patchset, they should send it with their user.

Hi Conor,

Please look at the communication history of this website.

https://patchwork.kernel.org/project/linux-pci/patch/CH2PPF4D26F8E1C1CBD2A866C59AA55CD7AA2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com/


Best regards,
Hans

