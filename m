Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D134E42F1
	for <lists+linux-pci@lfdr.de>; Tue, 22 Mar 2022 16:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbiCVP1k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Mar 2022 11:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiCVP1j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Mar 2022 11:27:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 747007665E;
        Tue, 22 Mar 2022 08:26:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32DD623A;
        Tue, 22 Mar 2022 08:26:11 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A3FF3F73B;
        Tue, 22 Mar 2022 08:26:10 -0700 (PDT)
Message-ID: <d5a18320-6bcc-8f7f-4525-e7139a4039be@arm.com>
Date:   Tue, 22 Mar 2022 15:26:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Panic at pc : _base_readl+0x4/0x20 [mpt3sas] - kernel 5.17.0
Content-Language: en-GB
To:     Bruno Goncalves <bgoncalv@redhat.com>, linux-scsi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc:     CKI Project <cki-project@redhat.com>
References: <CA+QYu4p=6PwferesmnEEknRjigVw-2Qo6SYHA-tx-+Fevezj4w@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CA+QYu4p=6PwferesmnEEknRjigVw-2Qo6SYHA-tx-+Fevezj4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-03-22 13:22, Bruno Goncalves wrote:
> Hello,
> 
> We've observed the panic below when testing a mainline kernel, it is
> not 100% reproducible in our machine though.

FWIW this looks like it's probably a hardware "feature" of the PCIe 
implementation. I'd imagine that reading a register while the device is 
still resetting gets an Unsupported Request or Completer Abort response, 
and the PCIe root complex has chosen to pass that back to the CPU as an 
error (resulting in the external abort) rather than synthesising all 1's 
data. There's generally not much you can do about that.

Robin.

> [  225.507306] mpt3sas_cm0 fault info from func: mpt3sas_base_make_ioc_ready
> [  225.514159] mpt3sas_cm0: fault_state(0x5854)!
> [  225.518509] mpt3sas_cm0: sending diag reset !!
> [  225.916444] Internal error: synchronous external abort: 96000610 [#1] SMP
> [  225.923230] Modules linked in: tls rfkill sunrpc joydev i2c_smbus
> qede qed vfat fat ipmi_ssif ipmi_devintf ipmi_msghandler thunderx2_pmu
> cppc_cpufreq fuse zram xfs ast i2c_algo_bit drm_vram_helper
> drm_kms_helper crct10dif_ce ghash_ce syscopyarea sysfillrect sysimgblt
> fb_sys_fops cec drm_ttm_helper ttm mpt3sas drm raid_class
> scsi_transport_sas gpio_xlp i2c_xlp9xx
> [  225.955353] CPU: 0 PID: 7 Comm: kworker/u448:0 Not tainted 5.17.0 #1
> [  225.961699] Hardware name: Default string MT91-FS1/MT91-FS1, BIOS
> F28 12/27/2019
> [  225.969084] Workqueue: poll_mpt3sas0_statu _base_fault_reset_work [mpt3sas]
> [  225.976070] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  225.983025] pc : _base_readl+0x4/0x20 [mpt3sas]
> [  225.987566] lr : _base_wait_on_iocstate+0x88/0x120 [mpt3sas]
> [  225.993233] sp : ffff80000b5ebc20
> [  225.996537] x29: ffff80000b5ebc20 x28: 0000000000000000 x27: 0000000000000000
> [  226.003668] x26: ffff000814d5a830 x25: 0000000050000000 x24: 0000000040000000
> [  226.010798] x23: 0000000010000000 x22: 0000000000004e1f x21: ffff000814d5a810
> [  226.017927] x20: 0000000000000004 x19: 0000000000000000 x18: ffffffffffffffff
> [  226.025056] x17: 0000000000000000 x16: ffff00080a67bd78 x15: ffff80008b5eb9ef
> [  226.032185] x14: ffffffffffffffff x13: 0000000000000000 x12: ffff8000095df498
> [  226.039313] x11: ffff800009f8f698 x10: 0000000000001d40 x9 : ffff8000090efb98
> [  226.046442] x8 : ffff00080323bf20 x7 : ffff800b62663000 x6 : 0000000e22b02726
> [  226.053570] x5 : 00000000430f0af0 x4 : 0000000000f0000f x3 : 00000000000d42a8
> [  226.060699] x2 : ffff800001203050 x1 : 0000000000000000 x0 : ffff8000151b0000
> [  226.067828] Call trace:
> [  226.070263]  _base_readl+0x4/0x20 [mpt3sas]
> [  226.074456]  _base_diag_reset+0x2f0/0x378 [mpt3sas]
> [  226.079341]  mpt3sas_base_make_ioc_ready.part.0+0xdc/0x1b4 [mpt3sas]
> [  226.085703]  mpt3sas_base_hard_reset_handler+0x140/0x424 [mpt3sas]
> [  226.091891]  _base_fault_reset_work+0x1cc/0x4a0 [mpt3sas]
> [  226.097297]  process_one_work+0x1f0/0x480
> [  226.101303]  worker_thread+0x180/0x500
> [  226.105045]  kthread+0xd4/0xe0
> [  226.108093]  ret_from_fork+0x10/0x20
> [  226.111667] Code: d50323bf d65f03c0 d503201f d503233f (b9400000)
> [  226.117751] ---[ end trace 0000000000000000 ]---
> [  226.122359] Kernel panic - not syncing: synchronous external abort:
> Fatal exception
> [  226.130004] SMP: stopping secondary CPUs
> [  226.133972] Kernel Offset: 0x100000 from 0xffff800008000000
> [  226.139534] PHYS_OFFSET: 0x80000000
> [  226.143011] CPU features: 0x006,0000450d,19001080
> [  226.147705] Memory Limit: none
> [  226.150750] ---[ end Kernel panic - not syncing: synchronous
> external abort: Fatal exception ]---
> 
> 
> Full console.log:
> https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/03/22/497731769/build_aarch64_redhat:2232309798/tests/11656424_aarch64_5_console.log
> 
> 
> Thanks,
> Bruno Goncalves
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
