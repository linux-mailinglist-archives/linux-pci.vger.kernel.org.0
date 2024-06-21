Return-Path: <linux-pci+bounces-9064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1398912036
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 11:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305D91F230DD
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 09:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2028416D4C9;
	Fri, 21 Jun 2024 09:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="M94R/BZg"
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2104.outbound.protection.outlook.com [40.92.107.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14A73D556;
	Fri, 21 Jun 2024 09:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718961149; cv=fail; b=PLVTIzZ4Eewm4548LnRWed03BZL36EdIcLVdT+jGmDYrrlQ8cWmuQ11irmcniiCaSDQF3OUqIVJoSrELMxe8TyQQQnbdyeADi81EMu3qZhA2I1lwoKQyhelqAzPW+mGMWPtwJCs9ar2L5/3gX0+4QMGl+g8LzFOhq5xYgbktqYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718961149; c=relaxed/simple;
	bh=yIhtpaS7YK039ZZ0h698fYqkwaS/FxQiKjdVfRRlMcE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uDrNisSIdO0ZTzqJLtaSnlqZschpwI2CBv4iZ80lzJb7c2KIewBDSeuaAMgLYrdXCf4+pH6AcLM9LaxRwrecffPOeVyN2vMO+dWXtjtFv0cljI1iAWi0dUd9dEQXbwmXIp4Lrzf0HYIKbPV9DEIQ1BVK6AXqRZg6RuLv6hEF+uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=M94R/BZg; arc=fail smtp.client-ip=40.92.107.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cxj/s3W0/uV6JuA+MHhBscTBLuKIFQtOkCGUvh7X6Vlb/7RiZuNWLu++VD9NeBSss8yfTJvgl//CHre2kLn1P5HN2W8bKW8gr4hNDbRGPAoCLUkXF50SFBFPhkgUI1fyh7DhcbPRruuVZ5XYchlSXHjwEpszzFPyn2U8j2K1cJbd2Nb0yhV5ubNDLLFefxnC9eqMHD7MCvTfRmRdjcYmlzJDbPn65/f8oVsG2ZZ0w+dA9XZOQaRf4U2jMY4xDwK0nAtiZ9tsnb3wMr7Qf6lI8/IPGc6pb8phF7zlk1BNxvKLy/JNZtjzHN28zGHXLUfziYR87iQFDxUHCM9f9F9juA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofBNk2c7o2dTekP+86B28GMvuQ1bmeZs2Iir81udAAs=;
 b=mIsT6mYbn+lA6O/hFdEMpM4f/4reo0BYiQuR8xh4N+kfbmKMgRw9DNlt8WjI8RBVZhfKC1vyR/ZtUo8D1xuTOZTmIi33xqSFdnoSjNemymGB9XHBHNyxpATOvyTrv2hFRaKMs2Qu45XMxK8ISLRRgFp0XpzGERlTMnW7LoknZ+G43WXZsQG4DFuHSBO4IQl9vPJ8qVsZ+S1uiLoKwFevsfADFldVmjm7i+llFRYL1Ior5UO/lJ+yaFcyJooar3hsqQZ1vF+n1zJw3zAtwz/G0NGn0nijKyxosw0WMoFn2Np29oW6JxtVueLA0Jh3Vcskp8IbZYkKyPXUFa0j1RRSng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofBNk2c7o2dTekP+86B28GMvuQ1bmeZs2Iir81udAAs=;
 b=M94R/BZgMhtW0Zt+Y++jX+PA/N7Y06L7BgHSz92amSmMaw33NzcMAQSw1f5kWveLHXV5YcGtu0N/VqEc3Iw5eWD8FWB0nT/QaGBZx8pWQzoABvuyMbUt9F275NTPxbY9sXM2H6Mdktl0dE0Qh/Uzqh38+N2v7okeurwD3425WaBGojxP9vvCcvM5hC/Brf6/hjMr73C4Fr/z4IRUS/PYSGpGggkDYJee2MeTP9ZXfuRy/JxNlAm6c6BiC+0mCE1pm7pkZTVGvQ3iITvR+E1Oy4M5gBAmAZm2sXWfRTAtLFFw1cWX+Df7219FUBuRW+xb9Gftt7nZtKGIHN97MTFYHA==
Received: from SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 (2603:1096:101:76::5) by SEYPR01MB4175.apcprd01.prod.exchangelabs.com
 (2603:1096:101:57::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 09:12:21 +0000
Received: from SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 ([fe80::653b:3492:9140:d2bf]) by SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 ([fe80::653b:3492:9140:d2bf%2]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 09:12:21 +0000
Message-ID:
 <SEZPR01MB452706230710692FDA4D397BA8C92@SEZPR01MB4527.apcprd01.prod.exchangelabs.com>
Date: Fri, 21 Jun 2024 17:12:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: vmd: Use raw spinlock for cfg_lock
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, sunjw10@lenovo.com,
 ahuang12@lenovo.com, Thomas Gleixner <tglx@linutronix.de>,
 Keith Busch <kbusch@kernel.org>
References: <20240619200039.GA1319210@bhelgaas>
 <SEZPR01MB4527666DDB8BC7C23B141BCDA8C82@SEZPR01MB4527.apcprd01.prod.exchangelabs.com>
 <550c50b8-a4dc-4b62-aff2-c90c398778d7@intel.com>
Content-Language: en-US
From: Jiwei Sun <sunjw10@outlook.com>
In-Reply-To: <550c50b8-a4dc-4b62-aff2-c90c398778d7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN: [FUDJ8zPpytZPVuCTAVu6weCfWuw7hI+H]
X-ClientProxiedBy: TYCP286CA0156.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::20) To SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 (2603:1096:101:76::5)
X-Microsoft-Original-Message-ID:
 <991932fb-ff34-45ae-9ccd-172f54145173@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR01MB4527:EE_|SEYPR01MB4175:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ef7157-5386-405b-2d09-08dc91d241a2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|4302099010|3412199022|440099025|3420499029|1602099009;
X-Microsoft-Antispam-Message-Info:
	eqK04x8+4j/jGscRCvv9c/KJU0UFJm3tDOhWPXN4Na9/LyMKCdRCZvSAXoRZrJXpJyP1YqSPCA+5pzgNqr7ugbiRJVt4tt3dC4Ct6uEaSV4MZgGIlH2uiFTjRn5ZzD2ouELLzZ5sC9B+f1THrCp2YULMWEh41t1VO3uUg22kmq68zIxVaYSLgfPH2a69IudmMdKET7rFZ5oUv46WXJCAT3rtL8J30fG1t3sehLIm82Ntt1vSpTDi2JistLrWzhizSJ2dbvVlQjjyd7G9JNtQ9Q0bbx94ohRzJbfahviCKZiEIFWbpa5ynj2g11JbcBtcDhhhfzs4aWKqsuTHRk5NLrf8MWQiadm92+2AwfuinsfclfdELKevr8RyO6WG5+K81OFvoKCqoVS8DOO8lr+Af9PN8QQMmWpXq/1TVs1pXnmrDb6oEslmn/a75rjtGPnI828OlGUNyURjgjdqYUsjI+bxl7YXqtKaKvlHPfkPHksz/l2L48L0G9cLjN3lo1/Mb7k5QhSvfKGdwKAQTpzryi1t0rtnpGg2t/nOYdtzHxHTQrCLT3ZtrBy6hVSBGqOFQ0XFoN9c9qQ7RvHw86IAQOhWQ21a19Wv/Kz43awe4aGZ8EE1G1wztX8eVq8j418rL5T8583ehi48u31q40Zm634phqCIlB6ZrLu4J3+RvnF9KxcomgLJ/+cV1CmV87dD
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEp0UFBEbXhiekdmNUtJZWxuVk45ZnNrUzZzczRMVi80eTcxVkpSTER1ZzFY?=
 =?utf-8?B?eWFYY2N0Zjc2cnFWb2ZyRDZYZmR0ZTQxWnliZW5FZ0JBR29lcVo5UXNGeTNV?=
 =?utf-8?B?UjgwakNkQ0puZmE3anB5VWRrNFF6QW1FUml2YjJ3aEZBb3llTWdVYS9zVzE5?=
 =?utf-8?B?QnUzZ1J6N0pBU3NtVGlHZmNrRlpmcnlpY1NQNVZ1Rm8xWDJQWW1Oemt6MEd6?=
 =?utf-8?B?SnVRYXhHRFN5V2tsbmVzSFJtZEdQQjFrWlZ5K1F6YzEvYmtFeEV1VERpem52?=
 =?utf-8?B?M2V3Y3BFMHZEWVBtN2hVZVduTkk0TFAwTEYreTJIMmtJZlFVc1JxZktvRzNo?=
 =?utf-8?B?aHdoVUE4cjFydUF1ZldpRlhtdTU4K0IrMlpmci9EYm1GSzU1ZWVPZmRNaWhJ?=
 =?utf-8?B?S1gxZVV3L2VicmlwZ0hVV3J3emN4amRMa3BNbWR3bFl5bHlGSEtqc1d6UFRw?=
 =?utf-8?B?UUM2dk1wMThDRGVmNnRUVkpjaWluWTg0elhyOUw5eFpLQk5MZUl4bXB0WTVw?=
 =?utf-8?B?by9hYUljTzkxUWE4VTFkeW1oNjBxekgzQm5zWmhkbmlaZS9NVDgvYW1RZVZU?=
 =?utf-8?B?TzlIdUxCZlFaVEViUEx0WlVyK281bk5SS2dydjJWd08vS0dRS3V6TmFid1Y3?=
 =?utf-8?B?UmUzaXlSZG1qbUpMKzRXRUIveU5JQ2pGajhySWo5UnJEY3hlRGhpWDhGd3dn?=
 =?utf-8?B?NHE0dUZSbkhMU0M3Y1lFY3IwWUFzWU85cUllZGJoYkVrc29BNW1XK09sRS85?=
 =?utf-8?B?eFFOb2xZZnJoZWZ2NXFNQnBzNU56SVhMSW9INEtBYitRSWFJWVRFZW94WlpQ?=
 =?utf-8?B?UkZMNzBGNXFwYjcwSy9WZzYwc1NZQlF1MlNpd2VNZzhhbVFKczloZS85eFZE?=
 =?utf-8?B?OU9NU0dOaldiWDNRY2d3bXZQNDFnUDB0TDhZcGo2UHM2dFBNbkJYQmswQUtB?=
 =?utf-8?B?ZXlXaStNNHJaWUsyMXFzY3kxQXlIU3RoVU1NTjFtL3owWUdpb1BqS0hJOFZD?=
 =?utf-8?B?WmRGd1U5NjBtL0tteG43MUMyUTVIN3pDTHJkSVJ3a3phTU5idjBrdjdIK1R2?=
 =?utf-8?B?RWdLSGRBb201QVdqanlYUFZKeVZPRnRYWXRSbjJ5dWVwbTdSWXU1dW4vSzYy?=
 =?utf-8?B?STF5REU5MHREOTRsMG5oS3A0Y0M1eHFFZ1lpRUNDOUMvRjVtN2VOY05hNWxP?=
 =?utf-8?B?YkhtVzRxQUVrZkZWbGtjeitkUENJTFZDaU00T0RFamx0ZCswOUFNMkxuKzV4?=
 =?utf-8?B?L3l3SVZWelVmemhERHkvTUROQjJ1NFFnNnQrREVoWWZMNDRjRS9zR0c2Vm5X?=
 =?utf-8?B?KytxNCtBSnZvWmNMWDVpcEllSlh6akpTQjkzLzExWGZBNlNJL20xalhEdU5j?=
 =?utf-8?B?ZVEwWGNLK2tEVEcvZ3hTbHFoVWpYMWNidUFWZUg5RmtkK2U3L1NyTEc2R1Zw?=
 =?utf-8?B?bXFhd0NYNGRyV3Bmd2NkQkVZaGFXd1h3UFIwdjNxRVFmdE9KbFh4eDFXQUM0?=
 =?utf-8?B?SU5pM0M2QStIWVJFSWdzdDMxdThWTlZ4bkNsNC9KelJtTC9UcUxVYjhoeGNm?=
 =?utf-8?B?UmQyQ3ovRVFMWXJKM1hMb0Vsbk1sd20wNmUxazlUakJlNHhGNGlaUTJsUDVZ?=
 =?utf-8?Q?9Fq9DRsyWzRyxhfNztgf+Ytpt24sC+LN74Zf1H86W6/s=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ef7157-5386-405b-2d09-08dc91d241a2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR01MB4527.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 09:12:21.2013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB4175

On 6/20/24 23:10, Paul M Stillwell Jr wrote:
> On 6/20/2024 1:57 AM, Jiwei Sun wrote:
>>
>>
>> On 6/20/24 04:00, Bjorn Helgaas wrote:
>>> [+cc Thomas in case he has msi_lock comment, Keith in case he has
>>> cfg_lock comment]
>>>
>>> On Wed, Jun 19, 2024 at 07:27:59PM +0800, Jiwei Sun wrote:
>>>> From: Jiwei Sun <sunjw10@lenovo.com>
>>>>
>>>> If the kernel is built with the following configurations and booting
>>>>    CONFIG_VMD=y
>>>>    CONFIG_DEBUG_LOCKDEP=y
>>>>    CONFIG_DEBUG_SPINLOCK=y
>>>>    CONFIG_PROVE_LOCKING=y
>>>>    CONFIG_PROVE_RAW_LOCK_NESTING=y
>>>>
>>>> The following log appears,
>>>>
>>>> =============================
>>>> [ BUG: Invalid wait context ]
>>>> 6.10.0-rc4 #80 Not tainted
>>>> -----------------------------
>>>> kworker/18:2/633 is trying to lock:
>>>> ffff888c474e5648 (&vmd->cfg_lock){....}-{3:3}, at: vmd_pci_write+0x185/0x2a0
>>>> other info that might help us debug this:
>>>> context-{5:5}
>>>> 4 locks held by kworker/18:2/633:
>>>>   #0: ffff888100108958 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0xf78/0x1920
>>>>   #1: ffffc9000ae1fd90 ((work_completion)(&wfc.work)){+.+.}-{0:0}, at: process_one_work+0x7fe/0x1920
>>>>   #2: ffff888c483508a8 (&md->mutex){+.+.}-{4:4}, at: __pci_enable_msi_range+0x208/0x800
>>>>   #3: ffff888c48329bd8 (&dev->msi_lock){....}-{2:2}, at: pci_msi_update_mask+0x91/0x170
>>>> stack backtrace:
>>>> CPU: 18 PID: 633 Comm: kworker/18:2 Not tainted 6.10.0-rc4 #80 7c0f2526417bfbb7579e3c3442683c5961773c75
>>>> Hardware name: Lenovo ThinkSystem SR630/-[7X01RCZ000]-, BIOS IVEL60O-2.71 09/28/2020
>>>> Workqueue: events work_for_cpu_fn
>>>> Call Trace:
>>>>   <TASK>
>>>>   dump_stack_lvl+0x7c/0xc0
>>>>   __lock_acquire+0x9e5/0x1ed0
>>>>   lock_acquire+0x194/0x490
>>>>   _raw_spin_lock_irqsave+0x42/0x90
>>>>   vmd_pci_write+0x185/0x2a0
>>>>   pci_msi_update_mask+0x10c/0x170
>>>>   __pci_enable_msi_range+0x291/0x800
>>>>   pci_alloc_irq_vectors_affinity+0x13e/0x1d0
>>>>   pcie_portdrv_probe+0x570/0xe60
>>>>   local_pci_probe+0xdc/0x190
>>>>   work_for_cpu_fn+0x4e/0xa0
>>>>   process_one_work+0x86d/0x1920
>>>>   process_scheduled_works+0xd7/0x140
>>>>   worker_thread+0x3e9/0xb90
>>>>   kthread+0x2e9/0x3d0
>>>>   ret_from_fork+0x2d/0x60
>>>>   ret_from_fork_asm+0x1a/0x30
>>>>   </TASK>
>>>>
>>>> The root cause is that the dev->msi_lock is a raw spinlock, but
>>>> vmd->cfg_lock is a spinlock.
>>>
>>> Can you expand this a little bit?  This isn't enough unless one
>>> already knows the difference between raw_spinlock_t and spinlock_t,
>>> which I didn't.
>>>
>>> Documentation/locking/locktypes.rst says they are the same except when
>>> CONFIG_PREEMPT_RT is set (might be worth mentioning with the config
>>> list above?), but that with CONFIG_PREEMPT_RT, spinlock_t is based on
>>> rt_mutex.
>>>
>>> And I guess there's a rule that you can't acquire rt_mutex while
>>> holding a raw_spinlock.
>>
>> Thanks for your review and comments. Sorry for not explaining this clearly.
>> Yes, you are right, if CONFIG_PREEMPT_RT is not set, the spinlock_t is
>> based on raw_spinlock, there is no any question in the above call trace.
>>
>> But as you mentioned, if CONFIG_PREEMPT_RT is set, the spinlock_t is based
>> on rt_mutex, a task will be scheduled when waiting for rt_mutex. For example,
>> there are two threads are trying to hold a rt_mutex lock, if A hold the
>> lock firstly, and B will be scheduled in rtlock_slowlock_locked() waiting
>> for A to release the lock. The raw_spinlock is a real spinning lock, which
>> is not allowed the task of the raw_spinlock owner is scheduled in its
>> critical region. In other words, we should not try to acquire rt_mutex lock
>> in the critical region of the raw_spinlock when CONFIG_PREEMPT_RT is set.
>>
>> CONFIG_PROVE_LOCKING and CONFIG_PROVE_RAW_LOCK_NESTING options are
>> used to detect the invalid lock nesting (the raw_spinlock vs. spinlock
>> nesting checks) [1]. Here is the call path:
>>
>>    pci_msi_update_mask  ---> hold raw_spinlock dev->msi_lock
>>      pci_write_config_dword
>>       pci_bus_write_config_dword
>>         vmd_pci_write   ---> hold spinlock_t vmd->cfg_lock
>>
>> The above call path is the invalid lock nesting becuase the vmd driver
>> tries to acquire the vmd->cfg_lock spinlock within the raw_spinlock
>> region (dev->msi_lock). That's why the message "BUG: Invalid wait contex"
>> is shown.
>>
> 
> It looks like this only happens when CONFIG_PREEMPT_RT is set so I would mention that in the commit message (as Bjorn mentioned). I also think thsi level of detail is helpful and should be in the commit message as well since it's not obvious to the casual observer :)

Thanks for your suggestions and comments, I totally agree with you. 
I will add those key information into V2 patch commit message.

Thanks,
Regards,
Jiwei

> 
> Paul
> 
>> [1] https://lore.kernel.org/lkml/YBBA81osV7cHN2fb@hirez.programming.kicks-ass.net/
>>
>> Thanks,
>> Regards,
>> Jiwei
>>
>>>
>>> The dev->msi_lock was added by 77e89afc25f3 ("PCI/MSI: Protect
>>> msi_desc::masked for multi-MSI") and only used in
>>> pci_msi_update_mask():
>>>
>>>    raw_spin_lock_irqsave(lock, flags);
>>>    desc->pci.msi_mask &= ~clear;
>>>    desc->pci.msi_mask |= set;
>>>    pci_write_config_dword(msi_desc_to_pci_dev(desc), desc->pci.mask_pos,
>>>              desc->pci.msi_mask);
>>>    raw_spin_unlock_irqrestore(lock, flags);
>>>
>>> The vmd->cfg_lock was added by 185a383ada2e ("x86/PCI: Add driver for
>>> Intel Volume Management Device (VMD)") and is only used around VMD
>>> config accesses, e.g.,
>>>
>>>    * CPU may deadlock if config space is not serialized on some versions of this
>>>    * hardware, so all config space access is done under a spinlock.
>>>
>>>    static int vmd_pci_read(...)
>>>    {
>>>      spin_lock_irqsave(&vmd->cfg_lock, flags);
>>>      switch (len) {
>>>      case 1:
>>>         *value = readb(addr);
>>>         break;
>>>      case 2:
>>>         *value = readw(addr);
>>>         break;
>>>      case 4:
>>>         *value = readl(addr);
>>>         break;
>>>      default:
>>>         ret = -EINVAL;
>>>         break;
>>>      }
>>>      spin_unlock_irqrestore(&vmd->cfg_lock, flags);
>>>    }
>>>
>>> IIUC those reads turn into single PCIe MMIO reads, so I wouldn't
>>> expect any concurrency issues there that need locking.
>>>
>>> But apparently there's something weird that can deadlock the CPU.
>>>
>>>> Signed-off-by: Jiwei Sun<sunjw10@lenovo.com>
>>>> Suggested-by: Adrian Huang <ahuang12@lenovo.com>
>>>> ---
>>>>   drivers/pci/controller/vmd.c | 12 ++++++------
>>>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>>>> index 87b7856f375a..45d0ebf96adc 100644
>>>> --- a/drivers/pci/controller/vmd.c
>>>> +++ b/drivers/pci/controller/vmd.c
>>>> @@ -125,7 +125,7 @@ struct vmd_irq_list {
>>>>   struct vmd_dev {
>>>>       struct pci_dev        *dev;
>>>>   -    spinlock_t        cfg_lock;
>>>> +    raw_spinlock_t        cfg_lock;
>>>>       void __iomem        *cfgbar;
>>>>         int msix_count;
>>>> @@ -402,7 +402,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
>>>>       if (!addr)
>>>>           return -EFAULT;
>>>>   -    spin_lock_irqsave(&vmd->cfg_lock, flags);
>>>> +    raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
>>>>       switch (len) {
>>>>       case 1:
>>>>           *value = readb(addr);
>>>> @@ -417,7 +417,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
>>>>           ret = -EINVAL;
>>>>           break;
>>>>       }
>>>> -    spin_unlock_irqrestore(&vmd->cfg_lock, flags);
>>>> +    raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
>>>>       return ret;
>>>>   }
>>>>   @@ -437,7 +437,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
>>>>       if (!addr)
>>>>           return -EFAULT;
>>>>   -    spin_lock_irqsave(&vmd->cfg_lock, flags);
>>>> +    raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
>>>>       switch (len) {
>>>>       case 1:
>>>>           writeb(value, addr);
>>>> @@ -455,7 +455,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
>>>>           ret = -EINVAL;
>>>>           break;
>>>>       }
>>>> -    spin_unlock_irqrestore(&vmd->cfg_lock, flags);
>>>> +    raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
>>>>       return ret;
>>>>   }
>>>>   @@ -1015,7 +1015,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>>>>       if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
>>>>           vmd->first_vec = 1;
>>>>   -    spin_lock_init(&vmd->cfg_lock);
>>>> +    raw_spin_lock_init(&vmd->cfg_lock);
>>>>       pci_set_drvdata(dev, vmd);
>>>>       err = vmd_enable_domain(vmd, features);
>>>>       if (err)
>>>> -- 
>>>> 2.27.0
>>>>
>>
> 

