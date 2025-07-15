Return-Path: <linux-pci+bounces-32122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D6AB0521F
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 08:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0743AFFE4
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 06:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD7F26B97D;
	Tue, 15 Jul 2025 06:46:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022142.outbound.protection.outlook.com [40.107.75.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2162C147;
	Tue, 15 Jul 2025 06:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752562017; cv=fail; b=M/tbFuZK1+CO0oFeSCm9Mwm59VeyoUIeMPyTNI47rwqJ2SLfzey7CuWnJXrJ2VaW9n49sGwwvCupR8x11/+9vezxO4yfz17fStooPKNhSsw1KuSPnPXUiyu6yQVkbxUInTzquMDmowYlial4YGDWvwvaBoYQ3HXTlpvzumt7+Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752562017; c=relaxed/simple;
	bh=pHmc+YRLfQPY6PhtvELDL4jE+wE0y6y+s7O7lIDfV9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMH0vt7VXHqHkNgCoSTWv3t69G2lwydaTmHObZbjtjPFXf8UT7PI121KMsxRKnuqHPKdCzzShpwLz8OHMDiRy8l2psP2oP8dhc33CL8Gk98thBUxNPnblOrlPo5jjleTcynWGEKuu0duo/HLoeiIA36BS4+YCUhE2J+r8c2CXM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWgMsjSs+IQRJW/CvWJ5I0U0KLDsFp8CZt4rpLihKCdGqR51hh1E59zvk5Zg0OBCZxtYBEPBlR40OT0ovgRb9MHlnaHi/syR5Bo9/dCM0c1ZUy84S7m30XlS7J1T8f5Et6UVcj7oaCshhv1V7Q8FfsZh/r4kUV/s22vPbWRUbNvML+c5HEPD+cwZnB8qAPA9GhHREDmtWycVnKelbG2DO+sYTF5GkgMnzoKnkTAMczX/attbrB51qyF2Ez6jE8noPMMr73E6ifhGUcQyyX0XsNNw1+Oetrgob4UchctMfp3RcWDXRlSN8F2EK4LvotMjHy52EAnQSXHFl7gSWmNMQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v30TV5eWaGPMHlKrC2GyDPq6i/rqBhn2Roh2pAOcGYs=;
 b=jUzBfS2NMS3qfP3QR3PEbY6/cJBaku/psqnwUCQgr/s1mZMhA55VddaLQsAvJzrnme5J34un/rpgfULxypPYcrTj9yDrAe5rPzdVb6OWD94Aa0HKsYURbtOgeGiJBJas3WSpT5zkCjtP4E7QvOkKGBNskoRefun/RFTw2X+URyB848nkXeUY6mQhfbQakYCJbTuLCfcE+YyEqPoIKjjT/qfNQaySuR+ILh631pys1PJgkEz9EmkPqjxnRJ5HG8O7NDaI/CnQWiDkm3iMgVoF3rOLoaPKRlobcsQQCR07Mx/H1+EZTJ7jqTQm7Cf/zJhanj9LFBt3qYsQGwljzJ5miA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP286CA0152.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:383::14)
 by TY0PR06MB5610.apcprd06.prod.outlook.com (2603:1096:400:328::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 06:46:50 +0000
Received: from OSA0EPF000000C6.apcprd02.prod.outlook.com
 (2603:1096:400:383:cafe::9f) by TYCP286CA0152.outlook.office365.com
 (2603:1096:400:383::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Tue,
 15 Jul 2025 06:46:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C6.mail.protection.outlook.com (10.167.240.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 06:46:48 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 9987441604F0;
	Tue, 15 Jul 2025 14:46:46 +0800 (CST)
Message-ID: <4b902e2e-9cbc-4c3c-8318-fb7d6e86545e@cixtech.com>
Date: Tue, 15 Jul 2025 14:46:46 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/14] dt-bindings: PCI: Add CIX Sky1 PCIe Root Complex
 bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mpillai@cadence.com,
 fugang.duan@cixtech.com, guoyin.chen@cixtech.com, peter.chen@cixtech.com,
 cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
 <20250630041601.399921-11-hans.zhang@cixtech.com>
 <20250630-graceful-horse-of-science-eecc53@krzk-bin>
 <bb4889ca-ec99-4677-9ddc-28905b6fcc14@cixtech.com>
 <5b182268-d64c-424c-9ada-0c3f120d2817@kernel.org>
 <2b608302-c4a6-404d-9cc5-d1ab9a6712bd@cixtech.com>
 <a7aac65e-848b-4bb3-bd52-963766410698@kernel.org>
 <50592fad-850c-4dab-92d8-a71cb89daf58@cixtech.com>
 <e3f6da47-25bb-450c-8660-f1406ed590e6@kernel.org>
 <d6083e62-318f-4879-bac3-97ad26615458@cixtech.com>
 <eddf1e77-10b5-424c-b082-846bd2646f42@kernel.org>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <eddf1e77-10b5-424c-b082-846bd2646f42@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C6:EE_|TY0PR06MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d07951f-41f9-4592-78ea-08ddc36b5fb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTF2elR1UjhBb3hNbXRaUllibzRiSTVIdEVxam9FOGhaTkJPMnRNYXRVYnEr?=
 =?utf-8?B?SWZmVkRZZzJka2MyVWZ2QkNNRS9jZFdXRmpnNG5SNnp1S3ZoK0tUZjFwUmJG?=
 =?utf-8?B?MXRmcTVNSytCUjA1RHhqMVFZcGxxWWpIYmhkUGpBS2pQOVFWV2JiRG9lcVMw?=
 =?utf-8?B?RVFYdkpWemdaWDF6UzhxODlJdWd4dkVCWFE3WDkzdHJVS1pZRE13dzY1UGNw?=
 =?utf-8?B?MUJacjlISFEwNjFsWUpkZ0JSY1dqblJsMFB3RkY4ZWlPd3I0RjJCeGpRREMz?=
 =?utf-8?B?QWt2RVhIWW5qYlFxK0p1SEh5aGV1K3J0RXBBK21tUGNVOFB0M2xNNzdyeUZr?=
 =?utf-8?B?bEVJaEllZXZqSVRWRmQva3dtN0h1U1hmVXlXNVIzWkNiUHN0OG45OWRBVkcx?=
 =?utf-8?B?QXc2N3hzS3RVSWcyVDZzMkxWVXJySCtZMkxSQUhCSjhVYTZZZzFYN0J6a2Uz?=
 =?utf-8?B?anNtcTJUaWMyMm5KZEZxK0lkUzY0bG42RHZReWpoMTlkMm9HVWRDc1JpOGlh?=
 =?utf-8?B?ZHJaQkIvQXo2WXZ5WXo0TXRCTWNHYVd0eXF2VFhvbzA2dFJPRFJvUS94ZzEw?=
 =?utf-8?B?dnVYaDlWd2pNdFFueFVhbXRiOWtYamFIVm9tb1k1dVFFTlBsZTcvSWpmZm5t?=
 =?utf-8?B?YmIyVFJHcEVZRGdaOERjSUNwd3V1emRRZE9vWnU3YTdQRWEyK3RPMEFCTklH?=
 =?utf-8?B?elNaY2pkQ0UxVS8wWnhYeXV1Tit0Mlo0bmZxTitFYnBzYlhZTWc1WEkwM0lr?=
 =?utf-8?B?ZFp2OUVjTzIvVnRnM2RFeU9NdFBoSkdtb25jUGxUTHFoTUppV01DRnZZWExp?=
 =?utf-8?B?ZXZRTG94dTFJU2NaRVN3NTMwaWJLQXlkWUJrV2wyNEpJYUdNSjZhdVlLNjNk?=
 =?utf-8?B?RDRpVXZOTVV0TmJjbXo5SWFPS01rWCthWWhmc2NCalJqWmJ5c1p6ZXN1S3pm?=
 =?utf-8?B?S2FiTGpxVUJ5R1JUQWh3aW1RYndIZ3dZRzhaNS92WU5VMEtsYm9yRldYaURx?=
 =?utf-8?B?Yld4MHorK2hvaTBucE9xMEhlWFhNa2gycWNEcHdqNkRtOXFqREZ4WEhqQUtN?=
 =?utf-8?B?Q1M4U000RS8xZkVRTTJIVVhYSW1oKzQxd2cvQnRWbFNFMjg2ZHI5VjZ4alEz?=
 =?utf-8?B?QlQwd29HTi80N284SllJcDVyeVpHZk1nRHhlL3hnMFlQcVRCM2VsZlVNaDIr?=
 =?utf-8?B?NzA0WFJBdFcxZXBWaDhDSWNjNGpIT0U0dG8xVEdzS0N4VDRYaFUxVXhXUDR1?=
 =?utf-8?B?M2l3U0YyeC9rTjltMVpHS3phcjNjTFl5dnovL21ERi9xbWdzZU45WVllUDFO?=
 =?utf-8?B?SC9aRXkwaFJ3M1ZCakRhZGRvTVdaZ1ZLVCtyN2NnRXhENjdHZG1jQmgzcEhL?=
 =?utf-8?B?SHZKemZoMjdVbWprNzg0eGtudFhVaFFkb1pRWkpMd0paNnZUTUVaL1dwNEVL?=
 =?utf-8?B?b0d3T0Z5NnhVM2ZXUDFnTllXQy9mYUlFeDU0b09Ob3BRcGlzSVFoaFN0NEpx?=
 =?utf-8?B?WGZ0dGtkWFkrTHg5TWZiMG40UUhFV1JYcXNQb095YWp6TTRPUytENEJwZ0J4?=
 =?utf-8?B?WnFwakZTVzA4SWlXYnE2YXg4cWRkUVhUVllRZUhQeEVtVmk0VzdoRjIrdmpV?=
 =?utf-8?B?dzRDMUJZTkNZR3hqbnFJK1pNOFN0TGVIZnBRMW50U2hMc3AzUkRSVER3TXZl?=
 =?utf-8?B?aThPc1dGZWhGODJRdlk0SjB6THhEcnlHMWR4OERkVFVuTWxCZWF3RFdUYWtx?=
 =?utf-8?B?TWV1d1JSajYvWTNNeERsVWswQ25TZ3hIalhFZytJNkJFMzNwbkN2QnBwRHVs?=
 =?utf-8?B?OXZDMUpmNE9WeDl5RU1XeWFraHVNUjF0SkViS29aZWxycTRyU0JtVW56NVZ5?=
 =?utf-8?B?V0lYUGFBcmFEaWhNTHlEcCtGbFoyRENZSlErT1EvYTRsZmdDWlhlaHp4MGw0?=
 =?utf-8?B?WkpQQzFlRlRxMys5cjV3T25ZK1lPKzNIaTNHV0NaQWpKUlhLZlU1S0hBcGRx?=
 =?utf-8?B?Q1pFVFpQTjhDakU1L0VBMjlQcXNFSXFQL0RhYlRrb2duZzdpb0FNR0IyUWZR?=
 =?utf-8?Q?6OgzIi?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 06:46:48.2711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d07951f-41f9-4592-78ea-08ddc36b5fb6
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5610



On 2025/7/15 14:40, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On 14/07/2025 10:03, Hans Zhang wrote:
>>
>>
>> On 2025/7/14 15:43, Krzysztof Kozlowski wrote:
>>> EXTERNAL EMAIL
>>>
>>> On 03/07/2025 03:47, Hans Zhang wrote:
>>>>>>
>>>>>> We initially used the logic of Cadence common driver as follows:
>>>>>> drivers/pci/controller/cadence/pcie-cadence-host.c
>>>>>> of_property_read_u32(np, "vendor-id", &rc->vendor_id);
>>>>>>
>>>>>> of_property_read_u32(np, "device-id", &rc->device_id);
>>>>>>
>>>>>> So, can the code in Cadence be deleted?
>>>>>
>>>>> Don't know. If this is ABI, then not.
>>>>>
>>>>
>>>> According to my understanding, this is not ABI.
>>>
>>> Huh? Then what is ABI, by your understanding?
>>>
>>
>> Dear Krzysztof,
>>
>> I understand kernel ABI primarily refers to the stable binary contract
>> between the kernel and userspace (e.g., syscalls, /sys/proc interfaces).
>> Device tree properties are part of the boot-time hardware description
>> consumed by drivers during initialization. They are not directly exposed
>> to userspace as ABI interfaces.
>>
>> If I understand wrongly, please correct me.
> 
> 
> Then that's wrong understanding.
> 
> The DT interface, documented explicitly and one implied by kernel
> drivers in case it differs, is the ABI, as explained in docs in the
> kernel and what we said on the lists thousands of times.
> 

Dear Krzysztof,

Thank you very much for your reply and explanation. Now I understand 
that I have been discussing issues in the linux community for about half 
a year. I didn't pay attention to it before. Thank you again.

Best regards,
Hans

