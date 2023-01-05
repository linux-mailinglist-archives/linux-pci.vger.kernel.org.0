Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B3665F315
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 18:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbjAERrn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 12:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbjAERrm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 12:47:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC96450154;
        Thu,  5 Jan 2023 09:47:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 891F3B81B82;
        Thu,  5 Jan 2023 17:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155DAC433EF;
        Thu,  5 Jan 2023 17:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672940858;
        bh=0ek3u6JPtigZWyhKVlnAoa2roxxs/vxahhwlpDqMoac=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Sb58kJM4WtCHudLHRRrKMTgW7/1ff6HTBiefJxhznptyAMJqOKk6Bp3gYv6FMVzty
         ptmSrwBKfMLRV86YpCoPQPvy1zMWejFuIXLxdbPZL+IPu9weY5ckN9iEKbgg4tcmnj
         gnfALMV/mAMrsoaxj/hPcwzy11N1AUMn3t2lN4kVW0h5py1VR93PDsHdeVRBcyJDxb
         4z6kdGYoO3JLpaRy7fCFrorUTX9/O4MAOAeK9dfONNFhJB4vWhvzU6X3AeIx26vsNs
         yB7kb7JZzDwOztkvRMCN1X9Adk1U6jKG2Q9d9kOFUrh/BcFkqL0vGZN6busY4CGW/E
         GjcrJ9XMrvAgA==
Date:   Thu, 5 Jan 2023 11:47:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Koba Ko <koba.ko@canonical.com>
Cc:     vsd@suremail.info, Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [Bug 216888] New: "sysfs: cannot create duplicate filename
 /dma/dma0chan0" with 68dbe80f ("crypto: ccp - Release dma channels before
 dmaengine unrgister")
Message-ID: <20230105174736.GA1154719@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-216888-41252@https.bugzilla.kernel.org/>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Per the report, this is a regression and reverting 68dbe80f5b51
("crypto: ccp - Release dma channels before dmaengine unrgister"),
which appeared in v6.1, avoids the problem.

The bugzilla is assigned to PCI, and I know PCI does have similar
sysfs duplicate filename issues, but I don't know whether this
instance is related to 68dbe80f5b51 or to the PCI core.

On Thu, Jan 05, 2023 at 03:12:26PM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=216888
>            Summary: "sysfs: cannot create duplicate filename
>                     /dma/dma0chan0" with 68dbe80f ("crypto: ccp - Release
>                     dma channels before dmaengine unrgister")
> 
> An issue was found in the CCP driver (drivers/crypto/ccp/) that
> the patch 68dbe80f ("crypto: ccp - Release dma channels before
> dmaengine unrgister") causes the following errors/warnings with
> just unloading and loading the CCP driver. I'm not sure if this
> can be reproduced without the CCP hardware:
> 
> # uname -r
> 6.2.0-0.rc2.18.eln124.x86_64
> 
> # lspci | grep 'Encryption controller'
> 02:00.1 Encryption controller: Advanced Micro Devices, Inc. [AMD]
> Zeppelin Cryptographic Coprocessor NTBCCP  ### PCIID: 1022:1468
> Subsystem: 1022:1468
> 03:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD]
> Family 17h (Models 00h-0fh) Platform Security Processor ### PCIID:
> 1022:1456 Subsystem: 1022:1456
> 
> # rmmod kvm_amd ccp ; modprobe ccp
> [  140.965403] sysfs: cannot create duplicate filename
> '/devices/pci0000:00/0000:00:07.1/0000:03:00.2/dma/dma0chan0'
> [  140.975736] CPU: 0 PID: 388 Comm: kworker/0:2 Kdump: loaded Not
> tainted 6.2.0-0.rc2.18.eln124.x86_64 #1
> [  140.985185] Hardware name: HPE ProLiant DL325 Gen10/ProLiant DL325
> Gen10, BIOS A41 07/17/2020
> [  140.993761] Workqueue: events work_for_cpu_fn
> [  140.998151] Call Trace:
> [  141.000613]  <TASK>
> [  141.002726]  dump_stack_lvl+0x33/0x46
> [  141.006415]  sysfs_warn_dup.cold+0x17/0x23
> [  141.010542]  sysfs_create_dir_ns+0xba/0xd0
> [  141.014670]  kobject_add_internal+0xba/0x260
> [  141.018970]  kobject_add+0x81/0xb0
> [  141.022395]  device_add+0xdc/0x7e0
> [  141.025822]  ? complete_all+0x20/0x90
> [  141.029510]  __dma_async_device_channel_register+0xc9/0x130
> [  141.035119]  dma_async_device_register+0x19e/0x3b0
> [  141.039943]  ccp_dmaengine_register+0x334/0x3f0 [ccp]
> [  141.045042]  ccp5_init+0x662/0x6a0 [ccp]
> [  141.049000]  ? devm_kmalloc+0x40/0xd0
> [  141.052688]  ccp_dev_init+0xbb/0xf0 [ccp]
> [  141.056732]  ? __pci_set_master+0x56/0xd0
> [  141.060768]  sp_init+0x70/0x90 [ccp]
> [  141.064377]  sp_pci_probe+0x186/0x1b0 [ccp]
> [  141.068596]  local_pci_probe+0x41/0x80
> [  141.072374]  work_for_cpu_fn+0x16/0x20
> [  141.076145]  process_one_work+0x1c8/0x380
> [  141.080181]  worker_thread+0x1ab/0x380
> [  141.083953]  ? __pfx_worker_thread+0x10/0x10
> [  141.088250]  kthread+0xda/0x100
> [  141.091413]  ? __pfx_kthread+0x10/0x10
> [  141.095185]  ret_from_fork+0x2c/0x50
> [  141.098788]  </TASK>
> [  141.100996] kobject_add_internal failed for dma0chan0 with -EEXIST,
> don't try to register things with the same name in the same directory.
> [  141.113703] ccp 0000:03:00.2: ccp initialization failed
> [  141.118983] ccp 0000:03:00.2: SEV: memory encryption not enabled by BIOS
> [  141.125728] ccp 0000:03:00.2: psp enabled
> [  141.130020] ccp 0000:02:00.1: could not enable MSI-X (-22), trying MSI
> [  141.136939] sysfs: cannot create duplicate filename '/class/dma/dma0chan0'
> [  141.143863] CPU: 0 PID: 388 Comm: kworker/0:2 Kdump: loaded Not
> tainted 6.2.0-0.rc2.18.eln124.x86_64 #1
> [  141.153313] Hardware name: HPE ProLiant DL325 Gen10/ProLiant DL325
> Gen10, BIOS A41 07/17/2020
> [  141.161889] Workqueue: events work_for_cpu_fn
> [  141.166274] Call Trace:
> [  141.168733]  <TASK>
> [  141.170845]  dump_stack_lvl+0x33/0x46
> [  141.174531]  sysfs_warn_dup.cold+0x17/0x23
> [  141.178652]  sysfs_do_create_link_sd+0xcf/0xe0
> [  141.183124]  device_add+0x28a/0x7e0
> [  141.186634]  ? complete_all+0x20/0x90
> [  141.190318]  __dma_async_device_channel_register+0xc9/0x130
> [  141.195925]  dma_async_device_register+0x19e/0x3b0
> [  141.200745]  ccp_dmaengine_register+0x334/0x3f0 [ccp]
> [  141.205838]  ccp5_init+0x662/0x6a0 [ccp]
> [  141.209795]  ? devm_kmalloc+0x40/0xd0
> [  141.213479]  ccp_dev_init+0xbb/0xf0 [ccp]
> [  141.217524]  ? __pci_set_master+0x56/0xd0
> [  141.221559]  sp_init+0x70/0x90 [ccp]
> [  141.225166]  sp_pci_probe+0x186/0x1b0 [ccp]
> [  141.229385]  local_pci_probe+0x41/0x80
> [  141.233159]  work_for_cpu_fn+0x16/0x20
> [  141.236933]  process_one_work+0x1c8/0x380
> [  141.240966]  worker_thread+0x1ab/0x380
> [  141.244737]  ? __pfx_worker_thread+0x10/0x10
> [  141.249032]  kthread+0xda/0x100
> [  141.252192]  ? __pfx_kthread+0x10/0x10
> [  141.255964]  ret_from_fork+0x2c/0x50
> [  141.259563]  </TASK>
> [  141.261902] ccp 0000:02:00.1: ccp initialization failed
> 
> This is reproducible with the latest upstream v6.2-rc2 code,
> "6.2.0-0.rc2.18.eln124.x86_64" is just the v6.2-rc2 code built
> with Fedora/ELN kernel configs. I'm talking about the commit
> 68dbe80f because just reverting it makes the above errors/warnings
> disappear.
