Return-Path: <linux-pci+bounces-729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF7980BAB4
	for <lists+linux-pci@lfdr.de>; Sun, 10 Dec 2023 13:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19D01F20FEB
	for <lists+linux-pci@lfdr.de>; Sun, 10 Dec 2023 12:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A266BE7E;
	Sun, 10 Dec 2023 12:35:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E46110A;
	Sun, 10 Dec 2023 04:35:52 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rCJ2E-0002b3-Qg; Sun, 10 Dec 2023 13:35:50 +0100
Message-ID: <daa0c12e-49be-4047-933f-26823117b3db@leemhuis.info>
Date: Sun, 10 Dec 2023 13:35:50 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] PCI: Fix deadlocks when enabling ASPM
Content-Language: en-US, de-DE
To: Linux kernel regressions list <regressions@lists.linux.dev>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231128081512.19387-1-johan+linaro@kernel.org>
 <ZXHHrCDKKQbGIxli@hovoldconsulting.com>
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZXHHrCDKKQbGIxli@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1702211752;201925f3;
X-HE-SMSGID: 1rCJ2E-0002b3-Qg

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 07.12.23 14:25, Johan Hovold wrote:
> On Tue, Nov 28, 2023 at 09:15:06AM +0100, Johan Hovold wrote:
>> The pci_enable_link_state() helper is currently only called from
>> pci_walk_bus(), something which can lead to a deadlock as both helpers
>> take a pci_bus_sem read lock.
>>
>> Add a new locked helper which can be called with the read lock held and
>> fix up the two current users (the second is new in 6.7-rc1).
>>
>> Note that there are no users left of the original unlocked variant after
>> this series, but I decided to leave it in place for now (e.g. to mirror
>> the corresponding helpers to disable link states).
>>
>> Included are also a couple of related cleanups.
> 
>> Johan Hovold (6):
>>   PCI/ASPM: Add locked helper for enabling link state
>>   PCI: vmd: Fix deadlock when enabling ASPM
>>   PCI: qcom: Fix deadlock when enabling ASPM
>>   PCI: qcom: Clean up ASPM comment
>>   PCI/ASPM: Clean up disable link state parameter
>>   PCI/ASPM: Add lockdep assert to link state helper
> 
> Could we get this merged for 6.7-rc5? Even if the risk of a deadlock is
> not that great, this bug prevents using lockdep on Qualcomm platforms so
> that more locking issues can potentially make their way into the kernel.
> 
> And for Qualcomm platforms, this is a regression in 6.7-rc1.
> 
> #regzbot introduced: 9f4f3dfad8cf

Fixes are now here:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=for-linus

#regzbot fix: 075268be58232b0a2ae
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

