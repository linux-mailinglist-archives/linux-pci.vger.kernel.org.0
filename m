Return-Path: <linux-pci+bounces-182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8D77FA342
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 15:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFED91C20D36
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 14:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34961A286;
	Mon, 27 Nov 2023 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Iy3bQCz7"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E5585;
	Mon, 27 Nov 2023 06:44:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOrn4pWLF35zwDaTVwJp22nvtp0WHZYbomQW/DucgDWs7u20en3KANVY8pe3m3FxFK+gCLxbPcuSe2uV593ElWgDpIboRVR4/fia6aXzpO3C8qctxYA8TAKRzO7KIk3l5EdDlAiMeyaFBGinm6L+iV0PRVJ/RK2LjTVTl07tpbLygALeTaBqIlcDThizlAIJmY9EgJjQrumJL/Fe0El/KjRYMqn5dVftJXRPgRlt/tEBqUCB02bg9mukur5tUDhkJyLJomCJ+7W9WB3LD0FxmSuOsesCfckFgaZeUFmhY0GPNMgjDeHw+qYDnXVx9OM1ZqYXozKjyaF1tHFjSryVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zmamiHI5OHP+cUqLH3OwxHhVonZV/uWA5uvKbt6cX4=;
 b=mu2/9Kq3Z2UINBetu/EYsTnafgrtklNdc9UrMU6wjJx9ttaWPU/GcD7f5nYxJvELVBKTALHeDWdRUaWYT4JmyO5w7tZt7gEFcRV5QojpZGFmQTb3GQ64fyWAQC1lxltHtCfpaRpHOPpWVf9VxFthy/2Zt4PLp93/qFjfkAv2v6EvDV7eA/aUdNbwg8Y6RzyS+EN+WXJWg34qM0NhnHDjC9ixqibNviBcOy1g12BlvnmgA40G/JpZdOGKcaS1nhYrjNLUMzFaAdg4XXEg2UdhygKS//T4XOrHpX58vdsVNXvoDUMO7w41gpaSNVQ7t0dLpfgKqJX9GHrGLsCKNvIS1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zmamiHI5OHP+cUqLH3OwxHhVonZV/uWA5uvKbt6cX4=;
 b=Iy3bQCz7rcCDPB8SX30KSIIvUhUuhqYhkHBTFzWkA6qQZGyEFLuQMRtGZh2Zt/ozQwWtkpGW5uk/0rWSjuFQsNgm+ys8Fapb7a9DEP5WiRFyNjUhFV9Fp1MnYgcOYUYKe30w/l1aJn37WltbTGycT7ylgO3Hb+IiTSAWMWkkDEPrSznyntzji4NOOSudSoNs0ayEC9sshEB1IOIOOWO1eS7l3/zSJDWuKzxxlMTCbgQq+YdrIVZi7WYVUTDynC6iReDuumIs+yPU/c/Iq4i1fOWZItsDf07mryHy0223mOl7RXWISUne1JLuN7TLGLsCXwRKUTyfE3NhVK9NKBpUrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by IA0PR12MB8696.namprd12.prod.outlook.com (2603:10b6:208:48f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 14:43:59 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::eda4:8c67:893f:3d13]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::eda4:8c67:893f:3d13%5]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 14:43:59 +0000
Message-ID: <a73a2156-124b-47f7-b545-6751f6e87d54@nvidia.com>
Date: Mon, 27 Nov 2023 20:13:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Race b/w pciehp and FirmwareFirst DPC->EDR flow - Reg
From: Vidya Sagar <vidyas@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>
Cc: Vikram Sethi <vsethi@nvidia.com>, Krishna Thota <kthota@nvidia.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 sagar.tv@gmail.com
References: <BN8PR12MB290002441CA3C24D1FA742D2B8AEA@BN8PR12MB2900.namprd12.prod.outlook.com>
 <529acc15-1932-4785-9edf-c5327db64ab1@nvidia.com>
Content-Language: en-US
In-Reply-To: <529acc15-1932-4785-9edf-c5327db64ab1@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::16) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|IA0PR12MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c643172-66da-4d73-6e4e-08dbef574a85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nBuU0I0Fl19oYM7cIU5tujbBGzJfeMItpI3CoN7IbViUxudPF8Kqet0hm92YOutpqb+KJqN0UpmD0iB7tmiD6yykxbgCKCI6TuxoI6Zm2FzF7ZsAO9u4lwYdbkciE8ogxZIIXF8aGgIg67XT5r+GeDbX7ulmjrwGdM+epp/rWv7cZPnq9sFPULKrHvkfX8IBh9K4I5Bc9ELQjGGiHhMaScfGwtveiUwWyfQ9q6hTugALYgXYFuTHggQEPQP1arnZ2Aa5mbYuOBCOU9j21Crc8AOrAzpA8hU79SUaqr6y939CpNj9qRiASA8YrDP0KEIEwUS8yzJwdeq2xGF72DQEWFccP2GrYPcXo02SrKcdld/PvqV+t7JXPl5lg0BVPEHU7Q6xazXwx86yeZ7QCirokfOOcPOmfBRlpVcQausTdiTq3PrmUdJh+A0PgP1i0TLXuxd9zDXD+Shy2vrsfspq7JdyLA6olyMRAiGA8JpUN7TQZ66zFoLSwjfa6Sr7PS7fx72Jk8j9FQJ8ZprBceibcKLyPGuSl8DaWdwPeq6M9qmZa3lYq8rIr9obLrDRav7D7N5aBco4HnUy59L3ek0k3GGADGk9PSX2Iif9WBxilqK4ctfRGJtUIqzFdq4jhaeceK6VMxdOm2t94W5angZ/hQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(366004)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6666004)(8676002)(8936002)(4326008)(31696002)(6512007)(6506007)(53546011)(66476007)(110136005)(54906003)(66556008)(66946007)(316002)(6486002)(478600001)(2906002)(38100700002)(41300700001)(36756003)(31686004)(86362001)(26005)(2616005)(83380400001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzNnQU5ibVhYSVNwWmlLcjFyY2pRdWl3TXY4Ly9jcytIaWNvM2xMbEJpSkJ6?=
 =?utf-8?B?ZDBBNkI5YXRjbExLUEJzZHUrcHJVZDFvVysrN2wxVFlKdmJyTnNiRERzbVMv?=
 =?utf-8?B?YnVsWldKQmJCNTY2WnNwdk11TUpKK2NtUDc4ZVFZTmVBL3JNNTF6WFhMdTkw?=
 =?utf-8?B?aDd5WVBNdjkwTFdpaW1RenNVZjVraXNtZjZZOENudVU5Z0orMVowQXFGVGZP?=
 =?utf-8?B?eGhMZC9hMGxxN3Z3MkMxa0l4N29yN2dXL3NqUWxlaVBJRWxLUUNkd2VIc0FM?=
 =?utf-8?B?TS9ocWZLTUJzRVJxd2pNOFV3c2lhOGMzaW54OGhiVk96RHQ4Q241bVBQWkpw?=
 =?utf-8?B?a3dZbStYMHEvOXJOaVN1U2cvTTg1T1ZxMGI4VmxuSjRwVkRYMnpLekRLZWUv?=
 =?utf-8?B?MUJHZitkMC9idFgxdG9WOXhmdDdhNW8rMGFtQjZNaUlYZW91UTNNL01yU0Vu?=
 =?utf-8?B?ajhzd3dycGQza20wT1J0MUd1M256V0NkUlVxQXZ2Rm9nN0RBbUsrTHRzcHVs?=
 =?utf-8?B?a1V6M1BxNWJONTEzQk01VlJEKzNRU3hiUUZEQ09xNk1mSHErNExTb2lMTmdm?=
 =?utf-8?B?VEI0RGY5MXJESUs0dnlqY2NCRDNycGMvZkF0RlI2aWhYME1zN1JxV2dpbmRy?=
 =?utf-8?B?RGtsUGhUWlBPTHJOR1dncVdSc0Y3di9KYXM2M1FLUm8zWktGbnRYZTRHOG8w?=
 =?utf-8?B?eGJrcGV3Yk5mb3puYjRMMWdJSndxd3AyY2RJLzdvenE1VEw1VzdNU0VHUXNH?=
 =?utf-8?B?SjZkN2d2aWxHSHZVbytTT25JcDdYYVFGc2tpenYvQ2NDWGxpNnduc0pIYXg5?=
 =?utf-8?B?QVFValdXOE1Zd0RpUC9GVlpEeHNYa2hjYnMyRG8xZFArK3dNY0c1NXQ0Wjc5?=
 =?utf-8?B?Mi9JUjRSOFBjYUl2MCtDeGNkbHZWbHI2Mk0rMytwR3dRU0k4bCtQM3dKK1hN?=
 =?utf-8?B?Mjh3YW1jRzRUMXBqTmtZT2tUY1VrK1U0NG9kdTJ4SStiQ3VId1ZUSjhyQmFq?=
 =?utf-8?B?SnRaWXRodVBRLzhZZ2F1OC9LV0tSR0FIUDZJbUpPM01mMGZuM0ZkT3B4VUJz?=
 =?utf-8?B?aHgzWFZHUGMrdy9VOEpDeUpRalhucS9tZUhJTk1SdGNrZ2FjVkVmOEpOV2k3?=
 =?utf-8?B?RGQ2aTdYdjd6TC9ZT1VvZTB2T25EK0ZucGd2N1J4VWlaR0EyS3FJSXZVNkd5?=
 =?utf-8?B?eDd5RWNPaFV1dUxkL01nQXFlS3g5dzZGOFltMXl2WmJkVXJrOTFsZ01JWjAw?=
 =?utf-8?B?SWZaY3pOWGsrS0V1dGtScXg1WW9yOVYzcjQzeEZ4N3hFWTVzOEkvZjlXMGVT?=
 =?utf-8?B?SDJ3eG0zOHJ0Ukd3S2hGRGh5ZjkzMmJMRXpoNXRRZnBKRVc1VDdmcnl3eWp6?=
 =?utf-8?B?YUt0NjI1UHhabkExVUE4N2g0endQeXNneU56UzZzdWhnQitvUTBHYnlscVVN?=
 =?utf-8?B?VjMzUlVzUVl5VTVvdVNReU5VRDdKbWZwcUFsZ3BORGJpM0lmSDIxTk52T0lU?=
 =?utf-8?B?M2hNcGdHVGRtSWFtRXpDdS9vK3A4NHZrN0Q1cTlkdXRldk5PaDlmSmhDV1V1?=
 =?utf-8?B?cGZFUEFCOWVPSUFxbEZaRDE1dHFXZVhwVVRZbTI5ZzZVUytKeUp3YnBOTEFP?=
 =?utf-8?B?WnJRbDFnM0g1UDMzMlBGcFZRMFQwc2ZMY2YxK2daOTZqNkJaaHdzK2sxcDk5?=
 =?utf-8?B?T1ZHVXVTS21pUDBleVR6alZrVkFZM3ZzVFRrTExVVTdiNWVKOU5oK2l2aVc3?=
 =?utf-8?B?dU82V3JJRUxUQVNES2FkdUJHZmluN1UzUGlLbzNzcUt0UGNIWDdhbk9kcnJC?=
 =?utf-8?B?VVlnVEpFZmFpQVRaczJxd2IraThFVFlYTHhDQlV5Z2sxVXY3MTVWeTBROHJy?=
 =?utf-8?B?dlJLN2dHNjFQb2d0eUNEd1V5ZFJETDlHa0RQKzQwOVVkcjJLdFJTYklxVlhx?=
 =?utf-8?B?aTR1a3RiME9hdVA5OVo4a3JQSklLdkRTQUV5MkJwdENyZVJ5ZjJ1bEZEMWtz?=
 =?utf-8?B?YUoyZi9EaXBNcCtWWDBNT2g0aDQ4YVJBNlBkWjNRTGUvWEk2OFJJK2tZRXlC?=
 =?utf-8?B?RXcyRlo5RFdWdVUyanJManBkdE51TklteDdEa08yOFRLVDNjbXcwMTJkQ1JP?=
 =?utf-8?Q?JRiC3vL9rIdpAAQwL0r+bRdHt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c643172-66da-4d73-6e4e-08dbef574a85
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 14:43:59.8401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oF8RsT/sqbv0bwc6v+jQaL8xsNTqJf0fckeJPTRp5Bc81PraQiPixS11NrFg88zqtjc4Bv38xcDDbZCjArM01g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8696

Hi Bjorn and others,
Could you please share your thoughts on this?

Thanks,
Vidya Sagar

On 11/10/2023 10:31 PM, Vidya Sagar wrote:
> There was a typo. Corrected it.
> 
> s/If DPC->EDR flow checks DPC also/If DPC->EDR flow checks 'PD Change' also
> 
> On 11/10/2023 6:30 PM, Vidya Sagar wrote:
>> Hi folks,
>> Here are the platform details.
>> - System with a Firmware First approach for both AER and DPC
>> - CPERs are sent to the OS for the AER events
>> - DPC is notified to the OS through EDR mechanism
>> - System doesn't have support for in-band PD and supports only OOB PD 
>> where writing to a private register would set the PD state
>> - System has this design where PD state gets cleared whenever there is 
>> a link down (without even writing to the private register)
>>
>> In this system, if the root port has to experience a DPC because of 
>> any right reasons (say SW trigger of DPC for time being), I'm 
>> observing the following flow which is causing a race.
>> 1. Since DPC brings the link down, there is a DLLSC and an MSI is sent 
>> to the OS hence PCIe HP ISR is invoked.
>> 2. ISR then takes stock of the Slot_Status register to see what all 
>> events caused the MSI generation.
>> 3. It sees both DLLSC and PDC bits getting set.
>> 4. PDC is set because of the aforementioned hardware design where for 
>> every link down, PD state gets cleared and since this is considered as 
>> a change in the PD state, PDC also gets set.
>> 5. PCIe HP ISR flow transitions to the PCIe HP IST (interrupt 
>> thread/bottom half) and waits for the DPC_EDR to complete (because 
>> DLLSC is one of the events)
>> 6. Parallel to the PCIe HP ISR/IST, DPC interrupt is raised to the 
>> firmware and that would then send an EDR event to the OS. Firmware 
>> also sets the PD state to '1' before that, as the endpoint device is 
>> still available.
>> 7. Firmware programming of the private register to set the PD state 
>> raises second interrupt and PCIe HP ISR takes stock of the events and 
>> this time it is only the PDC and not DLLSC. ISR sends a wake to the 
>> IST, but since there is an IST in progress already, nothing much 
>> happens at this point.
>> 8. Once the DPC is completed and link comes back up again, DPC 
>> framework asks the endpoint drivers to handle it by calling the 
>> 'pci_error_handlers' callabacks registered by the endpoint device 
>> drivers.
>> 9. The PCIe HP IST (of the very first MSI) resumes after receiving the 
>> completion from the DPC framework saying that DPC recovery is successful.
>> 10. Since PDC (Presence Detect Change) bit is also set for the first 
>> interrupt, IST attempts to remove the devices (as part of 
>> pciehp_handle_presence_or_link_change())
>>
>> At this point, there is a race between the device driver that is 
>> trying to work with the device (through pci_error_handlers callback) 
>> and the IST that is trying to remove the device.
>> To be fair to pciehp_handle_presence_or_link_change(), after removing 
>> the devices, it checks for the link-up/PD being '1' and scans the 
>> devices again if the device is still available. But unfortunately, IST 
>> is deadlocked (with the device driver) while removing the devices 
>> itself and won't go to the next step.
>>
>> The rationale given in the form of a comment in 
>> pciehp_handle_presence_or_link_change() for removing the devices first 
>> (without checking PD/link-up) and adding them back after checking 
>> link-up/PD is that, since there is a change in PD, the new link-up 
>> need not be with the same old device rather it could be with a 
>> different device. So, it justifies in removing the existing devices 
>> and then scanning for new ones. But this is causing deadlock with the 
>> already initiated DPC recovery process.
>>
>> I see two ways to avoid the deadlock in this scenario.
>> 1. When PCIe HP IST is looking at both DLLSC and PDC, why should 
>> DPC->EDR flow look at only DLLSC and not DPC? If DPC->EDR flow checks 
>> 'PD Change' also (along with DLL) and declares that the DPC recovery 
>> can't happen (as there could be a change of device) hence returning 
>> DPC recovery failure, then, the device driver's pci_error_handlers 
>> callbacks won't be called and there won't be any deadlock.
>> 2. Check for the possibility of a common lock so that PCIe HP IST and 
>> device driver's pci_error_handlers callbacks don't race.
>>
>> Let me know your comments on this.
>>
>> Thanks,
>> Vidya Sagar

