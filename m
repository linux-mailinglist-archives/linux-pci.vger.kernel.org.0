Return-Path: <linux-pci+bounces-9007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A800B90FFB5
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 10:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05412B261AE
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 08:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D025017557C;
	Thu, 20 Jun 2024 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="psP1kKjQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2083.outbound.protection.outlook.com [40.92.53.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E0C19DF93;
	Thu, 20 Jun 2024 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873890; cv=fail; b=ILekPZb1vAck5MQbg0rsfdVeXwRnr3aOSkMRGElgyR6idalIsVWg/m4KUs+W5maLGs4BjnQkwUQNldNCPft9ooxGsj43QHi0P8jFomAWXoTOom3Ypq/5A2K+swhWLtRSFdGI7ammqY+3Ed8eJrcuIoDZFmOE9IwJbAhpwfv+tD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873890; c=relaxed/simple;
	bh=6OOHzXQSYUHbhTHqJcRyoEaDqY4JG2DzZ+c8L6BUy/A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nwmPxN7W4nGQHJvres8h0i2we/I7MwL/bxzqWIYj4EgWvJHz1ecbFvUdRNQmav9xPheZNC6FyVuRltLYR7IDPnowA4MrMDu5wCh+tbj2ALoIOS+8MbA6a8gky08FZKH7LOKqqJoIO18KE6U3q1nQjsT1Aw6KsTlo3PYmCybrOso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=psP1kKjQ; arc=fail smtp.client-ip=40.92.53.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDLPS0I27wql3ro637XKJU4LMZ9pyI4emduPf+BJu7Kuh3CvhiRyA6FMqNZ+YPDwlJWP6clyy9KedfPU+tZEBShaIKW0lIC3XD7i+QclpjFaS4qNDusTrKku4CUYlqQseiEX6X75fEr6RXpuMJfGS0sQhw8Vu9nHpeIkW7Qj1vCgL43iL35o0MSJJKvG66eiLx9vfsMF5ar1vMgeXD8SMVMk4v7Djez1spVdrEuLr0+sMUwTYAmxfjQAsRdb5oYqNDuy/2a0WZjxEYAvjIrrJJXx54KkRtiBQFnDayOANF0s6cXoYuQI1c298Rwym0VsFitcW05tguDXBisCDjKB7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjVPP4viMxBr8rF1ApHYw2R7PHV2dcQpSKE8S+iiSAQ=;
 b=YZkggV6za+muKOaVdnSCsaRbz7bxE5FpxexiHzryLp+dn+g6xZw22RcqWHN4kL43Q2d6E3SEzLu40rcd1JqlKGMIiwePcW5LC+HGyCzLt+LFwUICqa8of22X/1YkvDTXo3YspPEN2wqRhDyDC+7THs+Mx8f8GehhVARk4msMbPHh+TMNSv+0dDsSyqVBIeNt2RWsohVem4/b+nlHLwkI9YHNuJq99Ht3uonbGv99tet6cnzF3gcmbdXalNE/44jKj1LdY+LKkngTTU2dhGmzqsYFbibHfWa4AYABKpNLt6819uTUx4BzsN0jKJbP97tps2idvIDbS1l+E9XUoZh1zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjVPP4viMxBr8rF1ApHYw2R7PHV2dcQpSKE8S+iiSAQ=;
 b=psP1kKjQrvu59HjJGwt+AOYjq8oMggKU0wN0mDaYGBLPDG/DlHd+BGKdwt7EAB2fMi4fjVwEfsD/hc4RJUHpLzU+C9tERlvJDnJgIEZbRmfv07L/Xuz8HQXGzS38bRCC4kKADlhLUeNYrJUYJP34p7fSc55Phn1xLVHHgk4z84+RYdv/Ew0N5ljnoDlzC4t4DHn6iPlyGLOlWtQ9rZE2PSf9wZDzKGcqt5BPP3azeH5beZLl4wQnGDEa9XKYNwLpoPD51GZQt6UkhDLBfZrNy/+GkiqoI7SByk7uDcqH7q8B1GxLOWyO8ln1edcS2SfifOqjGq0cPa0J6vRkN0pyAg==
Received: from SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 (2603:1096:101:76::5) by SG2PR01MB4193.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1c8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.34; Thu, 20 Jun
 2024 08:58:02 +0000
Received: from SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 ([fe80::653b:3492:9140:d2bf]) by SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 ([fe80::653b:3492:9140:d2bf%2]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 08:58:02 +0000
Message-ID:
 <SEZPR01MB4527666DDB8BC7C23B141BCDA8C82@SEZPR01MB4527.apcprd01.prod.exchangelabs.com>
Date: Thu, 20 Jun 2024 16:57:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: vmd: Use raw spinlock for cfg_lock
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, sunjw10@lenovo.com,
 ahuang12@lenovo.com, Thomas Gleixner <tglx@linutronix.de>,
 Keith Busch <kbusch@kernel.org>
References: <20240619200039.GA1319210@bhelgaas>
Content-Language: en-US
From: Jiwei Sun <sunjw10@outlook.com>
In-Reply-To: <20240619200039.GA1319210@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [ssjoyWWv9jglKinQKTnrjdFTiqTS0R04]
X-ClientProxiedBy: SI2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:196::19) To SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 (2603:1096:101:76::5)
X-Microsoft-Original-Message-ID:
 <c4fe7a52-1bc8-4434-a6e2-a0d2ecd51e66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR01MB4527:EE_|SG2PR01MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: 58daf77a-69cd-4ebe-d0db-08dc9107177c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|3420499029|1602099009|3412199022|440099025|4302099010;
X-Microsoft-Antispam-Message-Info:
	1vaEDCtDP54v++IicU4Wbi8PlSg0+RyO1NtZPjyHL6ODqi/bghD2GpP35wA02XXGcIhm8w1bQ6wYTjXvbVb2ebo2XzR3+79y02sTXtO7mPfAt21XtKFYF7fFCBszq6yiTpC/uubKTHwHQImg8zWP4aG/lx2FAr+3wM+2x2yUOgZITGXTErQqVxjl6t4EBxeAVwhBMIvPTm3eZrsMNPpPENv84qvtZQ4FM2Q7PLivODV31bQtMGgF613/3tE7n6PYx/mpabCNCbcbyAXwlCxzKLOI1N5yWuVrnjlxf8S/uPfGP9DmwwWGwT477Gkmq03q2JeTbyjkYCXiAE807Z4EVzvgh78TShqUKNfTEOZGix9TEvJyH7hRQ3c8loUV1DWfUcD+emB0IPnXZOm3oW2GNYcdslHoQcOCbkrW9R3kLX5g/2rXpnYWnvH4iA1CuGwZIZSX3RwpshehI26wicPcxu76a1cCQlKuBqcjCd/em6wbAY3KvWTRtKTMGR5apCMBleWZRpR8//MMGh8akVjqGST31xQ98kUwoyUC2WY/uAi1rjAZpUhphFAZnamUNhnDcMBqT7r5HYAsJRVE+l2Qi/erMH+Nu+YO0y2FynT0Z6F81fQ+fCUZyNzh1ZS44KP1oOmNtA7RyfyplpITI0VVJtr4hM9r5DUzPiaRUbE2G7UBsj6ncFxSoA5WZDe3sPwc
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVVwSnhyaUxidUhuaXhXc3JBUkh2SDM0U24vK29nTjB6V3FyU3lOMGl5b2Rr?=
 =?utf-8?B?dStZZGF5WEFkOFpZQi84a2ZyU2xNc3czN3hVL0dHTFFnRGl3S2NpME1EM1dO?=
 =?utf-8?B?Y2MvaE05MGliU05XZUduS0dGemY4eE13dGdMSzBVVFFMemxneE0xcFBXdFMv?=
 =?utf-8?B?b1hmNVhhSy9MUVBzNjZ6b0czUkV6a1Ayb3ArbS9kcEs4NnhkRXNtMS9PcjVu?=
 =?utf-8?B?ZlhXUFgvTW9tM05zaVpGemNhcGc5eEpTeU1pSlFvWHAzOFc5QmYzdU5GdlN6?=
 =?utf-8?B?NjVaMjNNTWVjWTZpWGJtUHM5YWxXN2ZCYXhOYlcySk9HU2tIQVA3NXdrSCto?=
 =?utf-8?B?NlV4RUV3akhVQzVvT0tMd1NLOXBFSW5QV0tnR0JIOEtMcG0ycE9HOXpMZmtU?=
 =?utf-8?B?eVNBY09Sdm95T3JxZ1FJcTg3YWovcnRnVWdRb282OHk5a2xoeEQ3WXg1cGMy?=
 =?utf-8?B?dVUyY1FkQjRldkhKRmFPbEwybDNxWmtQbjZ3VVI3N1VrM25nS3pjd0tadjcz?=
 =?utf-8?B?cy83Tk5GZkFseHV5SGdrVkE0anp4WXk1MWljN2ltUWg5QXdZMnB1Vk1uYTNP?=
 =?utf-8?B?V2NtbGRNQ25sanBrS05Ma2l2S2MySGVlQk9KcklSY0hSM2JrSUVNcDdYUDkx?=
 =?utf-8?B?Y1A2NGZFTTRxcnpQbEtiLzdlc0I5R3ZZQ1p5c3NjTUp5QkszQWVzSGlMamw2?=
 =?utf-8?B?NlRudXM2Z1JucWgySE9yaGpWdnpZb0NiOWROczc1ckZkaG5RUjlWM201WXd0?=
 =?utf-8?B?a0VEdGxTZzVwTnFaeDJlUkxsYkhoRmNkdVFUL3cvNzNGcGtVS1piS29yNGpK?=
 =?utf-8?B?Um1yeGhDbkpPU20ybURZSXhORUtERlNLYkdqNUhJQ2xnb2hyRGhTY2p5QldT?=
 =?utf-8?B?bzNmQ3BvclRwZmZPTmkwMEQrMEpnTmlLRTFwbk1SaGhnNW1KVnNTWGpaVWJx?=
 =?utf-8?B?b2YwaG5OV1ZCaDR0eDltakNuSE96aGtwM3B3RVhqYk5ack55VCtBZ0lMbnV5?=
 =?utf-8?B?Z1lCWm9tOC9PWmxsY0VIbXV3UmNzbWxJT0k5SGljaDMwbmdpTUEwVTIzU0pN?=
 =?utf-8?B?S2UwTUQwNU5KdnorNXFsWVpYcTNYcE5Jcm9tVnJ0c29VZ3Y2Wnk4ZWRhak00?=
 =?utf-8?B?aGJoZ0dGN0VjWFhyd0IxK1NUeVlxMjBxc0dmaEZBQ2FSdUNaU0NZS2hpQWQ2?=
 =?utf-8?B?NjdNRGxxREhQOFpPdjN2L0hOZE9ab1hwUkZ1R3dBbUFlejBDWi9UZm45bUEy?=
 =?utf-8?B?KzRUTzltYXhwcGMyUVQ4ZlZUL3pBTDhPN09KOThYMUlHTUJ5SGk5L25JYWNH?=
 =?utf-8?B?SWxKajJ4NG9DbXliWkZhampzbGtlZFlRY3ZJWlpWUjd2blMxUmdybmFHb2J5?=
 =?utf-8?B?SGNzckYzS3doNjVXdXVxaEVMOE90NHNqcEpscVhBZWNxZk54d3c5YUtldmJD?=
 =?utf-8?B?T2VCNUsyUVIwWVN3YVI2VDFUWmdtNUF3Sm1jeFhTUVg2Q0hYZENJZ3NWV3dt?=
 =?utf-8?B?cmp0WC9lNGFEb3pYMkZDNDRuWGlzZVl2dTNVdHI1SHdCcXAxdE1aMTNQanFU?=
 =?utf-8?B?dDQ0aFZUU2xseTQ3WUVwc3ArMDJuaTFobEZ6ejYrandhUUt6eHAyTFNuYkhl?=
 =?utf-8?Q?zgulIgf4+rM1s+j5o2dM0st4X1NPTM8rpib6pnn3y2aw=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58daf77a-69cd-4ebe-d0db-08dc9107177c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR01MB4527.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 08:58:02.7240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB4193



On 6/20/24 04:00, Bjorn Helgaas wrote:
> [+cc Thomas in case he has msi_lock comment, Keith in case he has
> cfg_lock comment]
> 
> On Wed, Jun 19, 2024 at 07:27:59PM +0800, Jiwei Sun wrote:
>> From: Jiwei Sun <sunjw10@lenovo.com>
>>
>> If the kernel is built with the following configurations and booting
>>   CONFIG_VMD=y
>>   CONFIG_DEBUG_LOCKDEP=y
>>   CONFIG_DEBUG_SPINLOCK=y
>>   CONFIG_PROVE_LOCKING=y
>>   CONFIG_PROVE_RAW_LOCK_NESTING=y
>>
>> The following log appears,
>>
>> =============================
>> [ BUG: Invalid wait context ]
>> 6.10.0-rc4 #80 Not tainted
>> -----------------------------
>> kworker/18:2/633 is trying to lock:
>> ffff888c474e5648 (&vmd->cfg_lock){....}-{3:3}, at: vmd_pci_write+0x185/0x2a0
>> other info that might help us debug this:
>> context-{5:5}
>> 4 locks held by kworker/18:2/633:
>>  #0: ffff888100108958 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0xf78/0x1920
>>  #1: ffffc9000ae1fd90 ((work_completion)(&wfc.work)){+.+.}-{0:0}, at: process_one_work+0x7fe/0x1920
>>  #2: ffff888c483508a8 (&md->mutex){+.+.}-{4:4}, at: __pci_enable_msi_range+0x208/0x800
>>  #3: ffff888c48329bd8 (&dev->msi_lock){....}-{2:2}, at: pci_msi_update_mask+0x91/0x170
>> stack backtrace:
>> CPU: 18 PID: 633 Comm: kworker/18:2 Not tainted 6.10.0-rc4 #80 7c0f2526417bfbb7579e3c3442683c5961773c75
>> Hardware name: Lenovo ThinkSystem SR630/-[7X01RCZ000]-, BIOS IVEL60O-2.71 09/28/2020
>> Workqueue: events work_for_cpu_fn
>> Call Trace:
>>  <TASK>
>>  dump_stack_lvl+0x7c/0xc0
>>  __lock_acquire+0x9e5/0x1ed0
>>  lock_acquire+0x194/0x490
>>  _raw_spin_lock_irqsave+0x42/0x90
>>  vmd_pci_write+0x185/0x2a0
>>  pci_msi_update_mask+0x10c/0x170
>>  __pci_enable_msi_range+0x291/0x800
>>  pci_alloc_irq_vectors_affinity+0x13e/0x1d0
>>  pcie_portdrv_probe+0x570/0xe60
>>  local_pci_probe+0xdc/0x190
>>  work_for_cpu_fn+0x4e/0xa0
>>  process_one_work+0x86d/0x1920
>>  process_scheduled_works+0xd7/0x140
>>  worker_thread+0x3e9/0xb90
>>  kthread+0x2e9/0x3d0
>>  ret_from_fork+0x2d/0x60
>>  ret_from_fork_asm+0x1a/0x30
>>  </TASK>
>>
>> The root cause is that the dev->msi_lock is a raw spinlock, but
>> vmd->cfg_lock is a spinlock.
> 
> Can you expand this a little bit?  This isn't enough unless one
> already knows the difference between raw_spinlock_t and spinlock_t,
> which I didn't.
> 
> Documentation/locking/locktypes.rst says they are the same except when
> CONFIG_PREEMPT_RT is set (might be worth mentioning with the config
> list above?), but that with CONFIG_PREEMPT_RT, spinlock_t is based on
> rt_mutex.
> 
> And I guess there's a rule that you can't acquire rt_mutex while
> holding a raw_spinlock.

Thanks for your review and comments. Sorry for not explaining this clearly.
Yes, you are right, if CONFIG_PREEMPT_RT is not set, the spinlock_t is 
based on raw_spinlock, there is no any question in the above call trace.

But as you mentioned, if CONFIG_PREEMPT_RT is set, the spinlock_t is based
on rt_mutex, a task will be scheduled when waiting for rt_mutex. For example, 
there are two threads are trying to hold a rt_mutex lock, if A hold the
lock firstly, and B will be scheduled in rtlock_slowlock_locked() waiting
for A to release the lock. The raw_spinlock is a real spinning lock, which
is not allowed the task of the raw_spinlock owner is scheduled in its
critical region. In other words, we should not try to acquire rt_mutex lock
in the critical region of the raw_spinlock when CONFIG_PREEMPT_RT is set.

CONFIG_PROVE_LOCKING and CONFIG_PROVE_RAW_LOCK_NESTING options are
used to detect the invalid lock nesting (the raw_spinlock vs. spinlock
nesting checks) [1]. Here is the call path:

  pci_msi_update_mask  ---> hold raw_spinlock dev->msi_lock
    pci_write_config_dword
     pci_bus_write_config_dword
       vmd_pci_write   ---> hold spinlock_t vmd->cfg_lock

The above call path is the invalid lock nesting becuase the vmd driver
tries to acquire the vmd->cfg_lock spinlock within the raw_spinlock
region (dev->msi_lock). That's why the message "BUG: Invalid wait contex"
is shown. 

[1] https://lore.kernel.org/lkml/YBBA81osV7cHN2fb@hirez.programming.kicks-ass.net/

Thanks,
Regards,
Jiwei

> 
> The dev->msi_lock was added by 77e89afc25f3 ("PCI/MSI: Protect
> msi_desc::masked for multi-MSI") and only used in
> pci_msi_update_mask():
> 
>   raw_spin_lock_irqsave(lock, flags);
>   desc->pci.msi_mask &= ~clear;
>   desc->pci.msi_mask |= set;
>   pci_write_config_dword(msi_desc_to_pci_dev(desc), desc->pci.mask_pos,
> 			 desc->pci.msi_mask);
>   raw_spin_unlock_irqrestore(lock, flags);
> 
> The vmd->cfg_lock was added by 185a383ada2e ("x86/PCI: Add driver for
> Intel Volume Management Device (VMD)") and is only used around VMD
> config accesses, e.g.,
> 
>   * CPU may deadlock if config space is not serialized on some versions of this
>   * hardware, so all config space access is done under a spinlock.
> 
>   static int vmd_pci_read(...)
>   {
>     spin_lock_irqsave(&vmd->cfg_lock, flags);
>     switch (len) {
>     case 1:
> 	    *value = readb(addr);
> 	    break;
>     case 2:
> 	    *value = readw(addr);
> 	    break;
>     case 4:
> 	    *value = readl(addr);
> 	    break;
>     default:
> 	    ret = -EINVAL;
> 	    break;
>     }
>     spin_unlock_irqrestore(&vmd->cfg_lock, flags);
>   }
> 
> IIUC those reads turn into single PCIe MMIO reads, so I wouldn't
> expect any concurrency issues there that need locking.
> 
> But apparently there's something weird that can deadlock the CPU.
> 
>> Signed-off-by: Jiwei Sun<sunjw10@lenovo.com>
>> Suggested-by: Adrian Huang <ahuang12@lenovo.com>
>> ---
>>  drivers/pci/controller/vmd.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>> index 87b7856f375a..45d0ebf96adc 100644
>> --- a/drivers/pci/controller/vmd.c
>> +++ b/drivers/pci/controller/vmd.c
>> @@ -125,7 +125,7 @@ struct vmd_irq_list {
>>  struct vmd_dev {
>>  	struct pci_dev		*dev;
>>  
>> -	spinlock_t		cfg_lock;
>> +	raw_spinlock_t		cfg_lock;
>>  	void __iomem		*cfgbar;
>>  
>>  	int msix_count;
>> @@ -402,7 +402,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
>>  	if (!addr)
>>  		return -EFAULT;
>>  
>> -	spin_lock_irqsave(&vmd->cfg_lock, flags);
>> +	raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
>>  	switch (len) {
>>  	case 1:
>>  		*value = readb(addr);
>> @@ -417,7 +417,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
>>  		ret = -EINVAL;
>>  		break;
>>  	}
>> -	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
>> +	raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
>>  	return ret;
>>  }
>>  
>> @@ -437,7 +437,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
>>  	if (!addr)
>>  		return -EFAULT;
>>  
>> -	spin_lock_irqsave(&vmd->cfg_lock, flags);
>> +	raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
>>  	switch (len) {
>>  	case 1:
>>  		writeb(value, addr);
>> @@ -455,7 +455,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
>>  		ret = -EINVAL;
>>  		break;
>>  	}
>> -	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
>> +	raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
>>  	return ret;
>>  }
>>  
>> @@ -1015,7 +1015,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>>  	if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
>>  		vmd->first_vec = 1;
>>  
>> -	spin_lock_init(&vmd->cfg_lock);
>> +	raw_spin_lock_init(&vmd->cfg_lock);
>>  	pci_set_drvdata(dev, vmd);
>>  	err = vmd_enable_domain(vmd, features);
>>  	if (err)
>> -- 
>> 2.27.0
>>

