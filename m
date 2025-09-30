Return-Path: <linux-pci+bounces-37238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85948BAAE9F
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 03:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD1D37A1CB2
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 01:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA62919CC3E;
	Tue, 30 Sep 2025 01:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VENu9R5T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9DC14F121
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 01:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759196955; cv=none; b=df3Q7l+7Ly/KcRwLbOkUDXvo1CbkeGnnoB+OhnjV3KX1Dfc2JA1EpBzf1ZW9YbgA10i09QE3RTm96Xab2GW1qYqB7x4wW/q7yOyGxsCDhY031DWWxPCmhz9SsliJllr5aRWdQ8IHq/oGkRkzRpFj0p8iHjddT+FM9AZU9c6+MX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759196955; c=relaxed/simple;
	bh=tDBBezcPYlp7FmqilK/rpFOYzXgomJ6GsoGy48Fxknc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zv1xcEXgmDJ6OAqYP5PEwE+DDRwn75U5Wunt1xDi7eSDh6WMBRO9pKMaYAwdHbjgnyDiBn6vCQQNk8Sis17syNpAJFpcMXFsmiE4kSDCFQbmLQwXnaYMbRiRRjXrQz09vSbYirvZE4Qbt+Cy2cxmDBMBLAwBLxSX3BuT+bF2HgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VENu9R5T; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-28832ad6f64so21959265ad.1
        for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 18:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759196953; x=1759801753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s95NyL2H6y5qz+puhM9dU0vSSqG26p81gIOvv61Fd4I=;
        b=VENu9R5TS0L0rJoHqJHQNnF9BYN5p4MgfEWaj4E02tCNQ7erB9cQyHQ1BziJlCE5Lv
         We6MWI6VvkHzOilOHUiS54ujweABhSFy+azDLV5AvnXVtOkEXEZWAfWazFqkcCwyIaeo
         mUXWxyUn8eT5GCsi7x9FKC7K8KvDmmCiDZ50ueCuif6vvSvoB4eMmDIkVgRgfcj5+acm
         ifDLvBfSkPBq9lPiC/bvHqF63QOLgB8+R4eKtwWeV9xovK04FL2C9kl9LmFUQZmiNBQ3
         8Xnndgw7iU0CyT/dSjNsnv6xVHRyiiA7R8g+FakxhKyxJucB9DdDgU439d0gdah5hXvr
         s38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759196953; x=1759801753;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s95NyL2H6y5qz+puhM9dU0vSSqG26p81gIOvv61Fd4I=;
        b=aTNlv8lZguoLtyPuTxGGBynS6SrdSXCvMwtFSKz58AfEfUY1ladbJjU1mllYXJvjxd
         uY0LQL1ZCq1Ga4QDKCrNUqkDbZG9PKl+LNvR4UNktBulmJcBT922GEhtwmWHSWmX46OM
         Sam7inxernEAr/p2jxCao9bUkg0UooglOPuFDmrNXmRmwo8TRFXfBNa0rOgKYCOXBAek
         inNMCyZT1pX4jOYNP2KCq6tyM5lfeUM8OIC/YnEga7qnrfoT7cjx4XOAvSC35WX6P2aZ
         jnoF+6OjBKB5oD9POWSRP7QezQp0RPlz1Q6A8tgoKh7TxbMNRqM0KX619gEbYZR7wiDA
         Bu0A==
X-Forwarded-Encrypted: i=1; AJvYcCUMYqwKolYoj/x+Ek3trH6dCv5lbgEYrAbCwaPs6GoZvOWWUcYrjYJID9RDSp5Hvy3IMKcD4vKUk2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKNkt3SVM69JRkXGIwJft8lEc4KX6IbHcz6oH4gT0CIpbNcnnF
	m1DoSA5WtR94OJm/TLRy4V9EWzBcvUM6EqlofpNbt/ZkRKDnu+iM+5sd
X-Gm-Gg: ASbGnct2ecEBzQI3ncmqBs6ix34Ns0qpZ3o/Q/CGWiEjq7FhflD0ZPPvCM3gdt4lrJa
	eIfFfXFsBKCda6aeHyvzcoJiM2hdegoCWsFpUm84inc/z4BSfLc0GUGx2qCWTlUkvqo/ThRy/Ae
	Vii00a03qESuggvMAQnssWNxSuRyQRGJLkE0eKChllMdrh9pJ4KaRz0QRZI6IShyyZuoCDZ8+DX
	Nq5Y9k791U9orYu2m5XISJfTfyfd0OS9nClFlhcwWmzgvFonMupOfXcYht/rOhiQYR9UbjCdn17
	iLPq7w3sOTlCynQOaPMd2d/7s8HlCcVO2MuyvNB7d0PeoQ7oRzVNKH2D0ZeBmXOJt0PpT9FbQ14
	fQay6014moj6IhzekkIlfniTeTgWeloBK6kMbeFRI8IAqMqwSSDDvWGEDbGKAJG+vAtiUT+WBK9
	KbCTgkbQ==
X-Google-Smtp-Source: AGHT+IHzKvtC312CNJHcPe3ofw05o8d9J5ChUEJRc4azx7isiQPUjOFoLRuYybPURIbTEG+xme86tQ==
X-Received: by 2002:a17:903:1b63:b0:269:a4ed:13c3 with SMTP id d9443c01a7336-27ed49df688mr248573895ad.5.1759196953248;
        Mon, 29 Sep 2025 18:49:13 -0700 (PDT)
Received: from [10.0.2.15] ([157.50.103.22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6702cf9sm142315065ad.38.2025.09.29.18.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 18:49:12 -0700 (PDT)
Message-ID: <6d6d18be-69ab-41f0-bae5-db7d0a12196d@gmail.com>
Date: Tue, 30 Sep 2025 07:19:06 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Fix sleeping function being
 called from atomic context
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Petr Mladek <pmladek@suse.com>,
 Tejun Heo <tj@kernel.org>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>, Frank Li <Frank.Li@nxp.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org
References: <20250917161817.15776-1-bhanuseshukumar@gmail.com>
 <te2mzunvwphcoiypwdb6oee3m54jquxk4br6f4tjxlp625whbr@kzzhai5eg2xv>
Content-Language: en-US
From: bhanuseshukumar <bhanuseshukumar@gmail.com>
In-Reply-To: <te2mzunvwphcoiypwdb6oee3m54jquxk4br6f4tjxlp625whbr@kzzhai5eg2xv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/09/25 23:23, Manivannan Sadhasivam wrote:
> On Wed, Sep 17, 2025 at 09:48:17PM +0530, Bhanu Seshu Kumar Valluri wrote:
>> When Root Complex(RC) triggers a Doorbell MSI interrupt to Endpoint(EP) it triggers a warning
>> in the EP. pci_endpoint kselftest target is compiled and used to run the Doorbell test in RC.
>>
>> [  474.686193] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:271
>> [  474.694656] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/0
>> [  474.702473] preempt_count: 10001, expected: 0
>> [  474.706819] RCU nest depth: 0, expected: 0
>> [  474.710913] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.17.0-rc5-g7aac71907bde #12 PREEMPT
>> [  474.710926] Hardware name: Texas Instruments AM642 EVM (DT)
>> [  474.710934] Call trace:
>> [  474.710940]  show_stack+0x20/0x38 (C)
>> [  474.710969]  dump_stack_lvl+0x70/0x88
>> [  474.710984]  dump_stack+0x18/0x28
>> [  474.710995]  __might_resched+0x130/0x158
>> [  474.711011]  __might_sleep+0x70/0x88
>> [  474.711023]  mutex_lock+0x2c/0x80
>> [  474.711036]  pci_epc_get_msi+0x78/0xd8
>> [  474.711052]  pci_epf_test_raise_irq.isra.0+0x74/0x138
>> [  474.711063]  pci_epf_test_doorbell_handler+0x34/0x50
>> [  474.711072]  __handle_irq_event_percpu+0xac/0x1f0
>> [  474.711086]  handle_irq_event+0x54/0xb8
>> [  474.711096]  handle_fasteoi_irq+0x150/0x220
>> [  474.711110]  handle_irq_desc+0x48/0x68
>> [  474.711121]  generic_handle_domain_irq+0x24/0x38
>> [  474.711131]  gic_handle_irq+0x4c/0xc8
>> [  474.711141]  call_on_irq_stack+0x30/0x70
>> [  474.711151]  do_interrupt_handler+0x70/0x98
>> [  474.711163]  el1_interrupt+0x34/0x68
>> [  474.711176]  el1h_64_irq_handler+0x18/0x28
>> [  474.711189]  el1h_64_irq+0x6c/0x70
>> [  474.711198]  default_idle_call+0x10c/0x120 (P)
>> [  474.711208]  do_idle+0x128/0x268
>> [  474.711220]  cpu_startup_entry+0x3c/0x48
>> [  474.711231]  rest_init+0xe0/0xe8
>> [  474.711240]  start_kernel+0x6d4/0x760
>> [  474.711255]  __primary_switched+0x88/0x98
>>
> 
> You do not need to use full call trace. Refer:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.17#n761
> 
>> Warnings can be reproduced by following steps below.
>> *On EP side:
>> 1. Configure the pci-epf-test function using steps given below
>>    mount -t configfs none /sys/kernel/config
>>    cd /sys/kernel/config/pci_ep/
>>    mkdir functions/pci_epf_test/func1
>>    echo 0x104c > functions/pci_epf_test/func1/vendorid
>>    echo 0xb010 > functions/pci_epf_test/func1/deviceid
>>    echo 32 > functions/pci_epf_test/func1/msi_interrupts
>>    echo 2048 > functions/pci_epf_test/func1/msix_interrupts
>>    ln -s functions/pci_epf_test/func1 controllers/f102000.pcie-ep/
>>    echo 1 > controllers/f102000.pcie-ep/start
>>
>> *On RC side:
>> 1. Once EP side configuration is done do pci rescan.
>>    echo 1 > /sys/bus/pci/rescan
>> 2. Run Doorbell MSI test using pci_endpoint_test kselftest app.
>>   ./pci_endpoint_test -r pcie_ep_doorbell.DOORBELL_TEST
> 
> This info is already part of the kernel documentation. So it is redundant here.
> It could be probably added in the comment section (where you added the Note).
> 
>>   Note: Kernel is compiled with CONFIG_DEBUG_KERNEL enabled.
>>
>> The BUG arises because the EP's Doorbell MSI hard interrupt handler is making an
>> indirect call to pci_epc_get_msi, which uses mutex inside, from interrupt context.
>>
>> This patch converts hard irq handler to a threaded irq handler to allow it
>> to call functions that can sleep during bottom half execution. The threaded
>> irq handler is registered with IRQF_ONESHOT and keeps interrupt line disabled
>> until the threaded irq handler completes execution.
>>
>> Fixes: eff0c286aa916221a69126 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
> 
> Use 12 char commit SHA.
> 
>> -static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
>> +static irqreturn_t pci_epf_test_doorbell_irq_thread(int irq, void *data)
> 
> No need to change the function name.

Thank you Mani for your helpful comments on the patch. I will send a v2 patch to address above review comments.

-Bhanu Seshu Kumar Valluri


