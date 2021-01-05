Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADABB2EADE9
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jan 2021 16:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbhAEPHk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jan 2021 10:07:40 -0500
Received: from halon.esss.lu.se ([194.47.240.54]:17668 "EHLO halon.esss.lu.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbhAEPHk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Jan 2021 10:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ess.eu; s=dec2019;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:references:to:from:subject:from;
        bh=jMTw9SAyhnaXO+achS63p08KlykxJX7YGyDB36FrvlE=;
        b=IP72iD4zQDh/87esWJqnNucmCyagX3QGzLvkK3Tv35NyK+xfHKs4OZ0hF8ZKgP249A398jCfZXnw1
         MlGsGt1z4Wkzq8eqUOgvtZ+aeNl9dzr4FVhNnN2chzWtCs6ho3KhMwHM6tDVTUvaA+ORt3Oy/kOUpk
         5Gj/jNHeOdKmY/XUBouHiex733ps9shAgDSWgtrwuhZQvJCmIdfgaxx1QZMY/WXvenJLQb9Yq1zS6L
         fRfY05sBLpnjLnAfmKiUNeju9RpHeUt95LQ/ltL/oWmRxc0YbIf5/UYVoAl5a5wqjes0dfNsROxw8s
         XWKk3hs6KuTsVjU/hSQV2Rar1Gb9Fag==
Received: from mail.esss.lu.se (it-exch16-4.esss.lu.se [10.0.42.134])
        by halon.esss.lu.se (Halon) with ESMTPS
        id a4f15ccb-4f67-11eb-93c8-005056a66d10;
        Tue, 05 Jan 2021 16:06:53 +0100 (CET)
Received: from [192.168.0.9] (194.47.241.248) by it-exch16-4.esss.lu.se
 (10.0.42.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 5 Jan 2021
 16:06:53 +0100
Subject: Re: [PATCHv2 0/5] aer handling fixups
From:   Hinko Kocevar <hinko.kocevar@ess.eu>
To:     Keith Busch <kbusch@kernel.org>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <20210104230300.1277180-1-kbusch@kernel.org>
 <bcc440b0-0ab9-c25f-e7d5-f7ce65db5019@ess.eu>
Message-ID: <4242a9a9-c881-0af4-1cab-396931fee420@ess.eu>
Date:   Tue, 5 Jan 2021 16:06:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <bcc440b0-0ab9-c25f-e7d5-f7ce65db5019@ess.eu>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [194.47.241.248]
X-ClientProxiedBy: IT-Exch16-1.esss.lu.se (10.0.42.131) To
 it-exch16-4.esss.lu.se (10.0.42.134)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/5/21 3:21 PM, Hinko Kocevar wrote:
> 
> 
> On 1/5/21 12:02 AM, Keith Busch wrote:
>> Changes from v1:
>>
>>    Added received Acks
>>
>>    Split the kernel print identifying the port type being reset.
>>
>>    Added a patch for the portdrv to ensure the slot_reset happens without
>>    relying on a downstream device driver..
>>
>> Keith Busch (5):
>>    PCI/ERR: Clear status of the reporting device
>>    PCI/AER: Actually get the root port
>>    PCI/ERR: Retain status from error notification
>>    PCI/AER: Specify the type of port that was reset
>>    PCI/portdrv: Report reset for frozen channel

I removed the patch 5/5 from this patch series, and after testing again, 
it makes my setup recover from the injected error; same as observed with 
v1 series.

Hope this helps.
//hinko

>>
>>   drivers/pci/pcie/aer.c         |  5 +++--
>>   drivers/pci/pcie/err.c         | 16 +++++++---------
>>   drivers/pci/pcie/portdrv_pci.c |  3 ++-
>>   3 files changed, 12 insertions(+), 12 deletions(-)
>>
> 
> Dear Keith,
> 
> I've tested this v2 series patches on the same setup I have tested the 
> v1 series patches a bit earlier (the same linux-pci GIT tree was used to 
> apply these patches to).
> 
> I'm seeing these messages in the dmesg when after an error is injected 
> and the recovery process starts:
> 
> [  397.434293] watchdog: BUG: soft lockup - CPU#2 stuck for 23s! 
> [irq/122-aerdrv:128]
> [  397.441872] Modules linked in: xdma(O) aer_inject xt_CHECKSUM 
> iptable_mangle xt_MASQUERADE iptable_nat nf_nat xt_conntrack 
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4 tun 
> ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter rfkill 
> sunrpc dm_mirror dm_region_hash dm_log dm_mod x86_pkg_temp_thermal 
> intel_powerclamp coretemp snd_hda_codec_hdmi kvm_intel kvm snd_hda_intel 
> snd_intel_dspcfg irqbypass i2c_designware_platform iTCO_wdt 
> snd_hda_codec i2c_designware_core crct10dif_pclmul crc32_pclmul 
> ghash_clmulni_intel iTCO_vendor_support snd_hda_core snd_hwdep mei_wdt 
> intel_wmi_thunderbolt snd_seq snd_seq_device aesni_intel crypto_simd 
> snd_pcm cryptd glue_helper rapl i2c_i801 snd_timer snd intel_cstate 
> soundcore i2c_smbus pcspkr intel_lpss_pci intel_lpss mei_me idma64 
> virt_dma sg joydev input_leds mei mfd_core intel_pch_thermal plx_dma wmi 
> pinctrl_sunrisepoint intel_pmc_core acpi_pad ie31200_edac ip_tables xfs 
> libcrc32c sd_mod t10_pi i915 cec rc_core
> [  397.441925]  drm_kms_helper igb ptp ahci crc32c_intel syscopyarea 
> serio_raw sysfillrect pps_core libahci sysimgblt dca fb_sys_fops 
> i2c_algo_bit libata drm video
> [  397.542794] CPU: 2 PID: 128 Comm: irq/122-aerdrv Tainted: G S  O      
> 5.10.0-1.keithv2.el7.x86_64 #1
> [  397.552530] Hardware name: AMI AM G6x/msd/AM G6x/msd, BIOS 4.08.01 
> 02/19/2019
> [  397.559663] RIP: 0010:pci_bus_write_config_dword+0x0/0x30
> [  397.565069] Code: c2 01 75 1f 55 48 8b 87 c0 00 00 00 44 0f b7 c1 b9 
> 02 00 00 00 48 8b 40 20 48 89 e5 e8 a9 de 70 00 5d c3 b8 87 00 00 00 c3 
> 90 <0f> 1f 44 00 00 f6 c2 03 75 1e 55 48 8b 87 c0 00 00 00 41 89 c8 b9
> [  397.583819] RSP: 0018:ffffc90000303b88 EFLAGS: 00000297
> [  397.589044] RAX: 0000000000000000 RBX: ffff8881011671cc RCX: 
> 00000000071f1f1f
> [  397.596182] RDX: 00000000000001a4 RSI: 0000000000000008 RDI: 
> ffff8881013d9000
> [  397.603319] RBP: ffffc90000303b90 R08: 0000000000000004 R09: 
> 00000000071f1f00
> [  397.610454] R10: 0000000000000000 R11: ffffc90000303950 R12: 
> ffff888101400000
> [  397.617588] R13: 0000000000000000 R14: ffff8881011671dc R15: 
> 00000000fee98fdc
> [  397.624722] FS:  0000000000000000(0000) GS:ffff88845dc80000(0000) 
> knlGS:0000000000000000
> [  397.632814] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  397.638565] CR2: 00007fe94d450000 CR3: 000000000240a001 CR4: 
> 00000000003706e0
> [  397.645702] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> [  397.652842] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
> 0000000000000400
> [  397.659978] Call Trace:
> [  397.662433]  ? pci_write_config_dword+0x22/0x30
> [  397.666974]  pci_vc_save_restore_dwords+0x59/0x70
> [  397.671682]  pci_vc_do_save_buffer+0x3da/0x5b0
> [  397.676131]  ? pci_read_config_dword+0x23/0x40
> [  397.680583]  pci_restore_vc_state+0x4d/0x70
> [  397.684776]  pci_restore_state.part.44+0x177/0x420
> [  397.689573]  pci_restore_state+0x18/0x20
> [  397.693507]  pcie_portdrv_slot_reset+0x12/0x30
> [  397.697957]  report_slot_reset+0x46/0x80
> [  397.701889]  ? merge_result.part.4+0x40/0x40
> [  397.706163]  pci_walk_bus+0x48/0x90
> [  397.709660]  pci_walk_bridge+0x1d/0x30
> [  397.713415]  pcie_do_recovery+0x1bd/0x270
> [  397.717434]  ? aer_dev_correctable_show+0xd0/0xd0
> [  397.722147]  ? aer_dev_correctable_show+0xd0/0xd0
> [  397.726854]  aer_process_err_devices+0xd0/0xe9
> [  397.731308]  aer_isr.cold.25+0x54/0xa3
> [  397.735067]  ? irq_finalize_oneshot.part.48+0xf0/0xf0
> [  397.740122]  irq_thread_fn+0x24/0x60
> [  397.743713]  irq_thread+0xea/0x170
> [  397.747121]  ? irq_forced_thread_fn+0x80/0x80
> [  397.751481]  ? irq_thread_check_affinity+0xf0/0xf0
> [  397.756280]  kthread+0x126/0x140
> [  397.759521]  ? kthread_park+0x90/0x90
> [  397.763191]  ret_from_fork+0x22/0x30
> [  425.434159] watchdog: BUG: soft lockup - CPU#2 stuck for 23s! 
> [irq/122-aerdrv:128]
> [  425.441727] Modules linked in: xdma(O) aer_inject xt_CHECKSUM 
> iptable_mangle xt_MASQUERADE iptable_nat nf_nat xt_conntrack 
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4 tun 
> ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter rfkill 
> sunrpc dm_mirror dm_region_hash dm_log dm_mod x86_pkg_temp_thermal 
> intel_powerclamp coretemp snd_hda_codec_hdmi kvm_intel kvm snd_hda_intel 
> snd_intel_dspcfg irqbypass i2c_designware_platform iTCO_wdt 
> snd_hda_codec i2c_designware_core crct10dif_pclmul crc32_pclmul 
> ghash_clmulni_intel iTCO_vendor_support snd_hda_core snd_hwdep mei_wdt 
> intel_wmi_thunderbolt snd_seq snd_seq_device aesni_intel crypto_simd 
> snd_pcm cryptd glue_helper rapl i2c_i801 snd_timer snd intel_cstate 
> soundcore i2c_smbus pcspkr intel_lpss_pci intel_lpss mei_me idma64 
> virt_dma sg joydev input_leds mei mfd_core intel_pch_thermal plx_dma wmi 
> pinctrl_sunrisepoint intel_pmc_core acpi_pad ie31200_edac ip_tables xfs 
> libcrc32c sd_mod t10_pi i915 cec rc_core
> [  425.441781]  drm_kms_helper igb ptp ahci crc32c_intel syscopyarea 
> serio_raw sysfillrect pps_core libahci sysimgblt dca fb_sys_fops 
> i2c_algo_bit libata drm video
> [  425.542649] CPU: 2 PID: 128 Comm: irq/122-aerdrv Tainted: G S  O L    
> 5.10.0-1.keithv2.el7.x86_64 #1
> [  425.552383] Hardware name: AMI AM G6x/msd/AM G6x/msd, BIOS 4.08.01 
> 02/19/2019
> [  425.559517] RIP: 0010:clocksource_watchdog+0xb7/0x2b0
> [  425.564581] Code: 44 00 00 48 89 df 48 8b 03 e8 05 ab ad 00 48 8b 3d 
> e6 cc a6 01 49 89 c5 48 8b 07 e8 f3 aa ad 00 49 89 c7 fb 66 0f 1f 44 00 
> 00 <48> 8b 43 50 a8 10 0f 84 2b 01 00 00 8b 15 77 cc a6 01 85 d2 0f 85
> [  425.583332] RSP: 0018:ffffc90000158e98 EFLAGS: 00000206
> [  425.588563] RAX: 000000005b0c2b18 RBX: ffffffff82435c60 RCX: 
> 0000000000000046
> [  425.595702] RDX: 5b0c2b1800000000 RSI: 403a197300000000 RDI: 
> 0000000000000046
> [  425.602839] RBP: ffffc90000158ed8 R08: 0000000000000000 R09: 
> 000000000000001b
> [  425.609978] R10: 0000000000000001 R11: ffff888102db4000 R12: 
> 0000000000000000
> [  425.617120] R13: 000001343b891adb R14: 0000000000000000 R15: 
> 000000005b0c2b18
> [  425.624261] FS:  0000000000000000(0000) GS:ffff88845dc80000(0000) 
> knlGS:0000000000000000
> [  425.632353] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  425.638100] CR2: 00007fe94d450000 CR3: 000000000240a001 CR4: 
> 00000000003706e0
> [  425.645232] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> [  425.652365] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
> 0000000000000400
> [  425.659501] Call Trace:
> [  425.661957]  <IRQ>
> [  425.663981]  ? find_next_bit+0x14/0x20
> [  425.667738]  ? __clocksource_unstable+0x70/0x70
> [  425.672273]  call_timer_fn+0x2e/0x100
> [  425.675945]  run_timer_softirq+0x1d4/0x400
> [  425.680054]  ? execlists_submission_tasklet+0x93/0x180 [i915]
> [  425.685856]  ? tasklet_action_common.isra.23+0x69/0x100
> [  425.691085]  __do_softirq+0xdb/0x29e
> [  425.694669]  asm_call_irq_on_stack+0x12/0x20
> [  425.698950]  </IRQ>
> [  425.701064]  do_softirq_own_stack+0x3d/0x50
> [  425.705262]  irq_exit_rcu+0xd2/0xe0
> [  425.708762]  common_interrupt+0x81/0x150
> [  425.712701]  ? irq_exit_rcu+0x45/0xe0
> [  425.716372]  asm_common_interrupt+0x1e/0x40
> [  425.720563] RIP: 0010:pci_mmcfg_read+0x11/0xe0
> [  425.725023] Code: 89 e0 5b 41 5c 41 5d 5d c3 45 31 e4 eb e2 cc cc cc 
> cc cc cc cc cc cc cc cc 0f 1f 44 00 00 55 81 fa ff 00 00 00 48 89 e5 41 
> 57 <41> 56 41 89 d6 0f 97 c2 81 f9 ff 0f 00 00 0f 9f c0 41 55 08 c2 41
> [  425.743776] RSP: 0018:ffffc90000303b20 EFLAGS: 00000297
> [  425.749006] RAX: ffffffff81980df0 RBX: ffffc90000303b96 RCX: 
> 0000000000000162
> [  425.756141] RDX: 0000000000000008 RSI: 0000000000000002 RDI: 
> 0000000000000000
> [  425.763275] RBP: ffffc90000303b28 R08: 0000000000000002 R09: 
> ffffc90000303b5c
> [  425.770411] R10: 0000000000000008 R11: ffffc90000303950 R12: 
> 0000000000000001
> [  425.777542] R13: 0000000000000162 R14: ffff888101400000 R15: 
> 0000000000000064
> [  425.784678]  ? pcibios_retrieve_fw_addr+0x90/0x90
> [  425.789386]  raw_pci_read+0x35/0x40
> [  425.792885]  pci_read+0x2c/0x30
> [  425.796036]  pci_bus_read_config_word+0x4a/0x70
> [  425.800573]  pci_read_config_word+0x23/0x40
> [  425.804760]  pci_wait_for_pending+0x49/0xb0
> [  425.808946]  ? raw_pci_write+0x36/0x40
> [  425.812700]  pci_vc_do_save_buffer+0x453/0x5b0
> [  425.817152]  ? pci_read_config_dword+0x23/0x40
> [  425.821605]  pci_restore_vc_state+0x4d/0x70
> [  425.825799]  pci_restore_state.part.44+0x177/0x420
> [  425.830601]  pci_restore_state+0x18/0x20
> [  425.834532]  pcie_portdrv_slot_reset+0x12/0x30
> [  425.838991]  report_slot_reset+0x46/0x80
> [  425.842919]  ? merge_result.part.4+0x40/0x40
> [  425.847197]  pci_walk_bus+0x48/0x90
> [  425.850696]  pci_walk_bridge+0x1d/0x30
> [  425.854455]  pcie_do_recovery+0x1bd/0x270
> [  425.858472]  ? aer_dev_correctable_show+0xd0/0xd0
> [  425.863181]  ? aer_dev_correctable_show+0xd0/0xd0
> [  425.867889]  aer_process_err_devices+0xd0/0xe9
> [  425.872334]  aer_isr.cold.25+0x54/0xa3
> [  425.876090]  ? irq_finalize_oneshot.part.48+0xf0/0xf0
> [  425.881144]  irq_thread_fn+0x24/0x60
> [  425.884722]  irq_thread+0xea/0x170
> [  425.888132]  ? irq_forced_thread_fn+0x80/0x80
> [  425.892498]  ? irq_thread_check_affinity+0xf0/0xf0
> [  425.897296]  kthread+0x126/0x140
> [  425.900532]  ? kthread_park+0x90/0x90
> [  425.904204]  ret_from_fork+0x22/0x30
> [  430.737050] rcu: INFO: rcu_sched self-detected stall on CPU
> [  430.742631] rcu:     2-....: (10176 ticks this GP) 
> idle=01a/1/0x4000000000000000 softirq=8276/8276 fqs=13750
> [  430.752283]     (t=60000 jiffies g=12873 q=14518)
> [  430.756732] NMI backtrace for cpu 2
> [  430.760223] CPU: 2 PID: 128 Comm: irq/122-aerdrv Tainted: G S  O L    
> 5.10.0-1.keithv2.el7.x86_64 #1
> [  430.769954] Hardware name: AMI AM G6x/msd/AM G6x/msd, BIOS 4.08.01 
> 02/19/2019
> [  430.777089] Call Trace:
> [  430.779542]  <IRQ>
> [  430.781562]  dump_stack+0x74/0x92
> [  430.784896]  nmi_cpu_backtrace.cold.8+0x32/0x68
> [  430.789435]  ? lapic_can_unplug_cpu+0x80/0x80
> [  430.793798]  nmi_trigger_cpumask_backtrace+0xe6/0xf0
> [  430.798770]  arch_trigger_cpumask_backtrace+0x19/0x20
> [  430.803830]  rcu_dump_cpu_stacks+0xb6/0xe6
> [  430.807937]  rcu_sched_clock_irq.cold.92+0x124/0x3a9
> [  430.812908]  ? account_system_index_time+0x94/0xa0
> [  430.817708]  ? tick_sched_do_timer+0x60/0x60
> [  430.821982]  update_process_times+0x93/0xd0
> [  430.826173]  tick_sched_handle.isra.23+0x25/0x60
> [  430.830798]  tick_sched_timer+0x6b/0x80
> [  430.834638]  __hrtimer_run_queues+0x105/0x240
> [  430.839002]  hrtimer_interrupt+0x101/0x220
> [  430.843112]  __sysvec_apic_timer_interrupt+0x62/0xe0
> [  430.848089]  sysvec_apic_timer_interrupt+0x35/0x90
> [  430.852885]  asm_sysvec_apic_timer_interrupt+0x12/0x20
> [  430.858026] RIP: 0010:clocksource_watchdog+0xb7/0x2b0
> [  430.863086] Code: 44 00 00 48 89 df 48 8b 03 e8 05 ab ad 00 48 8b 3d 
> e6 cc a6 01 49 89 c5 48 8b 07 e8 f3 aa ad 00 49 89 c7 fb 66 0f 1f 44 00 
> 00 <48> 8b 43 50 a8 10 0f 84 2b 01 00 00 8b 15 77 cc a6 01 85 d2 0f 85
> [  430.881838] RSP: 0018:ffffc90000158e98 EFLAGS: 00000206
> [  430.887077] RAX: 000000005b0c2b18 RBX: ffffffff82435c60 RCX: 
> 0000000000000046
> [  430.894216] RDX: 5b0c2b1800000000 RSI: 403a197300000000 RDI: 
> 0000000000000046
> [  430.901355] RBP: ffffc90000158ed8 R08: 0000000000000000 R09: 
> 000000000000001b
> [  430.908491] R10: 0000000000000001 R11: ffff888102db4000 R12: 
> 0000000000000000
> [  430.915631] R13: 000001343b891adb R14: 0000000000000000 R15: 
> 000000005b0c2b18
> [  430.922770]  ? clocksource_watchdog+0xad/0x2b0
> [  430.927221]  ? find_next_bit+0x14/0x20
> [  430.930984]  ? __clocksource_unstable+0x70/0x70
> [  430.935526]  call_timer_fn+0x2e/0x100
> [  430.939198]  run_timer_softirq+0x1d4/0x400
> [  430.943305]  ? execlists_submission_tasklet+0x93/0x180 [i915]
> [  430.949104]  ? tasklet_action_common.isra.23+0x69/0x100
> [  430.954337]  __do_softirq+0xdb/0x29e
> [  430.957921]  asm_call_irq_on_stack+0x12/0x20
> [  430.962196]  </IRQ>
> [  430.964307]  do_softirq_own_stack+0x3d/0x50
> [  430.968500]  irq_exit_rcu+0xd2/0xe0
> [  430.971998]  common_interrupt+0x81/0x150
> [  430.975936]  ? irq_exit_rcu+0x45/0xe0
> [  430.979606]  asm_common_interrupt+0x1e/0x40
> [  430.983795] RIP: 0010:pci_mmcfg_read+0x11/0xe0
> [  430.988257] Code: 89 e0 5b 41 5c 41 5d 5d c3 45 31 e4 eb e2 cc cc cc 
> cc cc cc cc cc cc cc cc 0f 1f 44 00 00 55 81 fa ff 00 00 00 48 89 e5 41 
> 57 <41> 56 41 89 d6 0f 97 c2 81 f9 ff 0f 00 00 0f 9f c0 41 55 08 c2 41
> [  431.007005] RSP: 0018:ffffc90000303b20 EFLAGS: 00000297
> [  431.012232] RAX: ffffffff81980df0 RBX: ffffc90000303b96 RCX: 
> 0000000000000162
> [  431.019366] RDX: 0000000000000008 RSI: 0000000000000002 RDI: 
> 0000000000000000
> [  431.026499] RBP: ffffc90000303b28 R08: 0000000000000002 R09: 
> ffffc90000303b5c
> [  431.033630] R10: 0000000000000008 R11: ffffc90000303950 R12: 
> 0000000000000001
> [  431.040764] R13: 0000000000000162 R14: ffff888101400000 R15: 
> 0000000000000064
> [  431.047897]  ? pcibios_retrieve_fw_addr+0x90/0x90
> [  431.052612]  raw_pci_read+0x35/0x40
> [  431.056111]  pci_read+0x2c/0x30
> [  431.059261]  pci_bus_read_config_word+0x4a/0x70
> [  431.063800]  pci_read_config_word+0x23/0x40
> [  431.067991]  pci_wait_for_pending+0x49/0xb0
> [  431.072180]  ? raw_pci_write+0x36/0x40
> [  431.075939]  pci_vc_do_save_buffer+0x453/0x5b0
> [  431.080386]  ? pci_read_config_dword+0x23/0x40
> [  431.084832]  pci_restore_vc_state+0x4d/0x70
> [  431.089020]  pci_restore_state.part.44+0x177/0x420
> [  431.093821]  pci_restore_state+0x18/0x20
> [  431.097751]  pcie_portdrv_slot_reset+0x12/0x30
> [  431.102205]  report_slot_reset+0x46/0x80
> [  431.106138]  ? merge_result.part.4+0x40/0x40
> [  431.110413]  pci_walk_bus+0x48/0x90
> [  431.113912]  pci_walk_bridge+0x1d/0x30
> [  431.117668]  pcie_do_recovery+0x1bd/0x270
> [  431.121685]  ? aer_dev_correctable_show+0xd0/0xd0
> [  431.126404]  ? aer_dev_correctable_show+0xd0/0xd0
> [  431.131118]  aer_process_err_devices+0xd0/0xe9
> [  431.135568]  aer_isr.cold.25+0x54/0xa3
> [  431.139326]  ? irq_finalize_oneshot.part.48+0xf0/0xf0
> [  431.144388]  irq_thread_fn+0x24/0x60
> [  431.147972]  irq_thread+0xea/0x170
> [  431.151380]  ? irq_forced_thread_fn+0x80/0x80
> [  431.155748]  ? irq_thread_check_affinity+0xf0/0xf0
> [  431.160548]  kthread+0x126/0x140
> [  431.163788]  ? kthread_park+0x90/0x90
> [  431.167460]  ret_from_fork+0x22/0x30
> [  444.669140] pcieport 0000:02:01.0: restoring config space at offset 
> 0x3c (was 0x100, writing 0x12010a)
> [  462.143968] pcieport 0000:02:01.0: restoring config space at offset 
> 0x2c (was 0x0, writing 0x0)
> [  462.152864] pcieport 0000:02:01.0: restoring config space at offset 
> 0x28 (was 0x0, writing 0x0)
> [  462.161752] pcieport 0000:02:01.0: restoring config space at offset 
> 0x24 (was 0x1fff1, writing 0x90e19001)
> 
> 
> This was not observed with the v1 series of patches.
> 
>  From what I can tell, this v2 series introduced a change in the 5/5 
> patch, that the v1 did not.
> 
> BTW, just to be safe and aligned with you, which kernel sources should I 
> be applying this v2 series patches to?
> 
> Let me know if you need more input.
> 
> 
> Thanks,
> Hinko
