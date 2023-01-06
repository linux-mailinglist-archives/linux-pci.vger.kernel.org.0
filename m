Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEDD65FCE7
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jan 2023 09:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjAFIjJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Jan 2023 03:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjAFIjF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jan 2023 03:39:05 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D6741645;
        Fri,  6 Jan 2023 00:39:03 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pDiFg-0001Op-2f; Fri, 06 Jan 2023 09:39:00 +0100
Message-ID: <7b38ae22-b13d-64af-7c79-a56cdba26754@leemhuis.info>
Date:   Fri, 6 Jan 2023 09:38:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [Bug 216888] New: "sysfs: cannot create duplicate filename
 /dma/dma0chan0" with 68dbe80f ("crypto: ccp - Release dma channels before
 dmaengine unrgister")
Content-Language: en-US, de-DE
To:     Bjorn Helgaas <helgaas@kernel.org>, Koba Ko <koba.ko@canonical.com>
Cc:     vsd@suremail.info, Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev
References: <20230105174736.GA1154719@bhelgaas>
From:   "Linux kernel regression tracking (#adding)" 
        <regressions@leemhuis.info>
Reply-To: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20230105174736.GA1154719@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672994343;0522ff43;
X-HE-SMSGID: 1pDiFg-0001Op-2f
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; all text you find below is based on a few templates
paragraphs you might have encountered already already in similar form.
See link in footer if these mails annoy you.]

On 05.01.23 18:47, Bjorn Helgaas wrote:
> Per the report, this is a regression and reverting 68dbe80f5b51
> ("crypto: ccp - Release dma channels before dmaengine unrgister"),
> which appeared in v6.1, avoids the problem.
> 
> The bugzilla is assigned to PCI, and I know PCI does have similar
> sysfs duplicate filename issues, but I don't know whether this
> instance is related to 68dbe80f5b51 or to the PCI core.
> 
> On Thu, Jan 05, 2023 at 03:12:26PM +0000, bugzilla-daemon@kernel.org wrote:
>> https://bugzilla.kernel.org/show_bug.cgi?id=216888
>>            Summary: "sysfs: cannot create duplicate filename
>>                     /dma/dma0chan0" with 68dbe80f ("crypto: ccp - Release
>>                     dma channels before dmaengine unrgister")
>>
>> An issue was found in the CCP driver (drivers/crypto/ccp/) that
>> the patch 68dbe80f ("crypto: ccp - Release dma channels before
>> dmaengine unrgister") causes the following errors/warnings with
>> just unloading and loading the CCP driver. I'm not sure if this
>> can be reproduced without the CCP hardware:
>>
>> # uname -r
>> 6.2.0-0.rc2.18.eln124.x86_64
>>
>> # lspci | grep 'Encryption controller'
>> 02:00.1 Encryption controller: Advanced Micro Devices, Inc. [AMD]
>> Zeppelin Cryptographic Coprocessor NTBCCP  ### PCIID: 1022:1468
>> Subsystem: 1022:1468
>> 03:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD]
>> Family 17h (Models 00h-0fh) Platform Security Processor ### PCIID:
>> 1022:1456 Subsystem: 1022:1456
>>
>> # rmmod kvm_amd ccp ; modprobe ccp
>> [  140.965403] sysfs: cannot create duplicate filename
>> '/devices/pci0000:00/0000:00:07.1/0000:03:00.2/dma/dma0chan0'
>> [  140.975736] CPU: 0 PID: 388 Comm: kworker/0:2 Kdump: loaded Not
>> tainted 6.2.0-0.rc2.18.eln124.x86_64 #1
>> [  140.985185] Hardware name: HPE ProLiant DL325 Gen10/ProLiant DL325
>> Gen10, BIOS A41 07/17/2020
>> [  140.993761] Workqueue: events work_for_cpu_fn
>> [  140.998151] Call Trace:
>> [  141.000613]  <TASK>
>> [  141.002726]  dump_stack_lvl+0x33/0x46
>> [  141.006415]  sysfs_warn_dup.cold+0x17/0x23
>> [  141.010542]  sysfs_create_dir_ns+0xba/0xd0
>> [  141.014670]  kobject_add_internal+0xba/0x260
>> [  141.018970]  kobject_add+0x81/0xb0
>> [  141.022395]  device_add+0xdc/0x7e0
>> [  141.025822]  ? complete_all+0x20/0x90
>> [  141.029510]  __dma_async_device_channel_register+0xc9/0x130
>> [  141.035119]  dma_async_device_register+0x19e/0x3b0
>> [  141.039943]  ccp_dmaengine_register+0x334/0x3f0 [ccp]
>> [  141.045042]  ccp5_init+0x662/0x6a0 [ccp]
>> [  141.049000]  ? devm_kmalloc+0x40/0xd0
>> [  141.052688]  ccp_dev_init+0xbb/0xf0 [ccp]
>> [  141.056732]  ? __pci_set_master+0x56/0xd0
>> [  141.060768]  sp_init+0x70/0x90 [ccp]
>> [  141.064377]  sp_pci_probe+0x186/0x1b0 [ccp]
>> [  141.068596]  local_pci_probe+0x41/0x80
>> [  141.072374]  work_for_cpu_fn+0x16/0x20
>> [  141.076145]  process_one_work+0x1c8/0x380
>> [  141.080181]  worker_thread+0x1ab/0x380
>> [  141.083953]  ? __pfx_worker_thread+0x10/0x10
>> [  141.088250]  kthread+0xda/0x100
>> [  141.091413]  ? __pfx_kthread+0x10/0x10
>> [  141.095185]  ret_from_fork+0x2c/0x50
>> [  141.098788]  </TASK>
>> [  141.100996] kobject_add_internal failed for dma0chan0 with -EEXIST,
>> don't try to register things with the same name in the same directory.
>> [  141.113703] ccp 0000:03:00.2: ccp initialization failed
>> [  141.118983] ccp 0000:03:00.2: SEV: memory encryption not enabled by BIOS
>> [  141.125728] ccp 0000:03:00.2: psp enabled
>> [  141.130020] ccp 0000:02:00.1: could not enable MSI-X (-22), trying MSI
>> [  141.136939] sysfs: cannot create duplicate filename '/class/dma/dma0chan0'
>> [  141.143863] CPU: 0 PID: 388 Comm: kworker/0:2 Kdump: loaded Not
>> tainted 6.2.0-0.rc2.18.eln124.x86_64 #1
>> [  141.153313] Hardware name: HPE ProLiant DL325 Gen10/ProLiant DL325
>> Gen10, BIOS A41 07/17/2020
>> [  141.161889] Workqueue: events work_for_cpu_fn
>> [  141.166274] Call Trace:
>> [  141.168733]  <TASK>
>> [  141.170845]  dump_stack_lvl+0x33/0x46
>> [  141.174531]  sysfs_warn_dup.cold+0x17/0x23
>> [  141.178652]  sysfs_do_create_link_sd+0xcf/0xe0
>> [  141.183124]  device_add+0x28a/0x7e0
>> [  141.186634]  ? complete_all+0x20/0x90
>> [  141.190318]  __dma_async_device_channel_register+0xc9/0x130
>> [  141.195925]  dma_async_device_register+0x19e/0x3b0
>> [  141.200745]  ccp_dmaengine_register+0x334/0x3f0 [ccp]
>> [  141.205838]  ccp5_init+0x662/0x6a0 [ccp]
>> [  141.209795]  ? devm_kmalloc+0x40/0xd0
>> [  141.213479]  ccp_dev_init+0xbb/0xf0 [ccp]
>> [  141.217524]  ? __pci_set_master+0x56/0xd0
>> [  141.221559]  sp_init+0x70/0x90 [ccp]
>> [  141.225166]  sp_pci_probe+0x186/0x1b0 [ccp]
>> [  141.229385]  local_pci_probe+0x41/0x80
>> [  141.233159]  work_for_cpu_fn+0x16/0x20
>> [  141.236933]  process_one_work+0x1c8/0x380
>> [  141.240966]  worker_thread+0x1ab/0x380
>> [  141.244737]  ? __pfx_worker_thread+0x10/0x10
>> [  141.249032]  kthread+0xda/0x100
>> [  141.252192]  ? __pfx_kthread+0x10/0x10
>> [  141.255964]  ret_from_fork+0x2c/0x50
>> [  141.259563]  </TASK>
>> [  141.261902] ccp 0000:02:00.1: ccp initialization failed
>>
>> This is reproducible with the latest upstream v6.2-rc2 code,
>> "6.2.0-0.rc2.18.eln124.x86_64" is just the v6.2-rc2 code built
>> with Fedora/ELN kernel configs. I'm talking about the commit
>> 68dbe80f because just reverting it makes the above errors/warnings
>> disappear.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot introduced 68dbe80f5b51 ^
https://bugzilla.kernel.org/show_bug.cgi?id=216888
#regzbot title cannot create duplicate filename /dma/dma0chan0
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (see page linked in footer for details).

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
