Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2969A6A2BF8
	for <lists+linux-pci@lfdr.de>; Sat, 25 Feb 2023 22:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBYV6d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Feb 2023 16:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBYV6c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Feb 2023 16:58:32 -0500
Received: from smtp-outbound3.duck.com (smtp-outbound3.duck.com [20.67.221.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302ACCC34
        for <linux-pci@vger.kernel.org>; Sat, 25 Feb 2023 13:58:31 -0800 (PST)
MIME-Version: 1.0
Subject: Re: ASMedia ASM1812 PCIe switch causes system to freeze hard
References: <9B577F97-4E03-4D1D-B6F2-909897F938CC.1@smtp-inbound1.duck.com>
 <20230225210220.GA17261@wunner.de>
 <FC4B5703-B454-4BEB-9E9C-6841FBD2CD60.1@smtp-inbound1.duck.com>
Content-Type: text/plain;
        charset=US-ASCII;
        format=flowed
Content-Transfer-Encoding: 7bit
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Received: by smtp-inbound1.duck.com; Sat, 25 Feb 2023 16:58:29 -0500
Message-ID: <1EE3A2B7-F0E4-43AE-A9DC-EC0DED4B2993.1@smtp-inbound1.duck.com>
Date:   Sat, 25 Feb 2023 16:58:29 -0500
From:   fk1xdcio@duck.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duck.com; h=From:
 Date: Message-ID: Cc: To: Content-Transfer-Encoding: Content-Type:
 References: Subject: MIME-Version; q=dns/txt; s=postal-KpyQVw;
 t=1677362309; bh=XiB0cnyQ6j8i4Wv7JHYxVZ4EIsLbCR71Q5dRSvj2VCo=;
 b=NcVexdDQhYVRKA9GOiW5XxVGa9f9auc/eL3oj7JwdM60VDyKVZsn/NfnMSCTu2Ydt9zwrdmh/
 DE7UjgdgChNL6utX3CUiShn/3oUxyYlWHvAibsJysky4Tq4RT0t37hBWGr113KH3yLpU/Cs/1cn
 EfFtGwnqCIGsVBwVTLVApYI=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023-02-25 16:02, Lukas Wunner wrote:
> On Sat, Feb 25, 2023 at 01:37:23PM -0500, fk1xdcio@duck.com wrote:
>> I'm testing a generic 4-port PCIe x4 2.5Gbps Ethernet NIC. It uses an
>> ASM1812 for the PCI packet switch to four RTL8125BG network 
>> controllers.
>> 
>> The more load I put on the NIC the faster the system freezes. For 
>> example if
>> I activate four 2.5Gbps fully saturated network connections then the 
>> system
>> hard freezes almost immediately. When the system freezes it seems 
>> completely
>> dead. SysRq doesn't work, serial consoles are dead, etc. so I haven't 
>> been
>> able to get much debugging information. I have tested on various 
>> different
>> physical systems, Xeon E5, Xeon E3, i7, and they all behave the same 
>> so it
>> doesn't seem like a system hardware issue.
>> 
>> Disabling IOMMU makes it run for a little longer before crashing.
>> 
>> The tiny bit of error information I have been able to get under 
>> various
>> conditions (eg. disabling ASPM, forcing D0, etc):
>>   Test #1:
>>   pcieport 0000:04:02.0: Unable to change power state from D3hot to 
>> D0,
>> device inaccessible
> 
> Have you tried adding pcie_port_pm=off to the kernel command line?


Thanks for the suggestion. I have tried many of those type options. In 
fact I tried disabling every single power management feature for every 
device on the entire system and it didn't fix the issue.

I couldn't remember if I tried that specific option so I tried it but 
experienced the same freeze. See messages below.

---

[    0.000000] microcode: microcode updated early to revision 0x28, date 
= 2019-11-12
[    0.000000] Linux version 6.1.12-arch1-1 (linux@archlinux) (gcc (GCC) 
12.2.1 20230201, GNU ld (GNU Binutils) 2.40) #1 SMP PREEMPT_DYNAMIC Tue, 
14 Feb 2023 22:08:08 +0000
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-linux root=xxxx rw 
loglevel=9 sysrq_always_enabled consoleblank=300 max_loop=64 
intel_iommu=on iommu=pt debug pcie_port_pm=off

---

4,1590,363523897,-;------------[ cut here ]------------
6,1591,363524036,-;NETDEV WATCHDOG: enp9s0 (r8169): transmit queue 0 
timed out
4,1592,363524118,-;WARNING: CPU: 5 PID: 0 at net/sched/sch_generic.c:525 
dev_watchdog+0x20b/0x220
4,1593,363524150,-;Modules linked in: intel_rapl_msr vfat 
intel_rapl_common fat x86_pkg_temp_thermal intel_powerclamp coretemp 
kvm_intel snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi 
kvm snd_hda_intel snd_intel_dspcfg irqbypass snd_intel_sdw_acpi spi_nor 
crct10dif_pclmul snd_hda_codec polyval_clmulni mtd polyval_generic 
snd_hda_core gf128mul spi_intel_platform ghash_clmulni_intel r8169 
snd_hwdep ppdev at24 iTCO_wdt intel_pmc_bxt realtek eeepc_wmi spi_intel 
snd_pcm iTCO_vendor_support mdio_devres asus_wmi snd_timer rapl libphy 
intel_cstate i2c_i801 snd ledtrig_audio intel_uncore e1000e 
sparse_keymap wmi_bmof platform_profile i2c_smbus soundcore pcspkr 
lpc_ich parport_pc cfg80211 mousedev parport rfkill mac_hid dm_mod fuse 
loop bpf_preload ip_tables x_tables ext4 crc32c_generic crc16 mbcache 
jbd2 amdgpu gpu_sched uas usb_storage usbhid i915 radeon crc32_pclmul 
crc32c_intel sha512_ssse3 drm_ttm_helper drm_buddy aesni_intel 
crypto_simd ttm cryptd drm_display_helper xhci_pci video
4,1594,363524300,c; intel_gtt
47,1595,363524364,-;systemd-journald[301]: Compressed data object 996 -> 
565 using ZSTD
4,1596,363524454,c; xhci_pci_renesas cec wmi
4,1597,363524482,-;CPU: 5 PID: 0 Comm: swapper/5 Not tainted 
6.1.12-arch1-1 #1 0ae38246365c3d8e63089e881d5fe91f13843017
4,1598,363524508,-;Hardware name: ASUS All Series/Q87M-E, BIOS 3801 
03/22/2019
4,1599,363524521,-;RIP: 0010:dev_watchdog+0x20b/0x220
4,1600,363524533,-;Code: ff e9 40 ff ff ff 48 89 df c6 05 8a 9f 5c 01 01 
e8 9a 50 f9 ff 44 89 e9 48 89 de 48 c7 c7 e0 74 34 85 48 89 c2 e8 eb 47 
1c 00 <0f> 0b e9 22 ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 
f3
4,1601,363524561,-;RSP: 0018:ffffb15080218e88 EFLAGS: 00010282
4,1602,363524572,-;RAX: 0000000000000000 RBX: ffff99438df80000 RCX: 
000000000000083f
4,1603,363524584,-;RDX: 0000000000000000 RSI: 00000000000000f6 RDI: 
000000000000083f
4,1604,363524596,-;RBP: ffff99438df804c8 R08: 0000000000000000 R09: 
ffffb15080218d10
4,1605,363524607,-;R10: 0000000000000003 R11: ffffffff85acc7e8 R12: 
ffff99438df8041c
4,1606,363524619,-;R13: 0000000000000000 R14: ffffffff84602b70 R15: 
ffff99438df804c8
4,1607,363524632,-;FS:  0000000000000000(0000) GS:ffff994a92140000(0000) 
knlGS:0000000000000000
4,1608,363524645,-;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
4,1609,363524655,-;CR2: 00007f17b92f0000 CR3: 00000005c1e10005 CR4: 
00000000001706e0
4,1610,363524668,-;Call Trace:
4,1611,363524674,-; <IRQ>
4,1612,363525712,-; ? pfifo_fast_reset+0x140/0x140
4,1613,363526734,-; call_timer_fn+0x27/0x130
4,1614,363527815,-; __run_timers+0x21c/0x2a0
4,1615,363528804,-; run_timer_softirq+0x1d/0x40
4,1616,363529819,-; __do_softirq+0xd4/0x2c9
4,1617,363530828,-; ? sched_clock_cpu+0xd/0xb0
4,1618,363531794,-; __irq_exit_rcu+0xb7/0xe0
4,1619,363532743,-; sysvec_apic_timer_interrupt+0x72/0x90
4,1620,363533680,-; </IRQ>
4,1621,363534612,-; <TASK>
4,1622,363535534,-; asm_sysvec_apic_timer_interrupt+0x1a/0x20
4,1623,363536452,-;RIP: 0010:cpuidle_enter_state+0xe2/0x420
4,1624,363537389,-;Code: 00 00 31 ff e8 0f 80 7c ff 45 84 ff 74 16 9c 58 
0f 1f 40 00 f6 c4 02 0f 85 25 03 00 00 31 ff e8 44 3e 83 ff fb 0f 1f 44 
00 00 <45> 85 f6 0f 88 85 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 
8d
4,1625,363539257,-;RSP: 0018:ffffb150800fbe90 EFLAGS: 00000246
4,1626,363540222,-;RAX: ffff994a92172e40 RBX: ffff994a9217de00 RCX: 
0000000000000000
4,1627,363541208,-;RDX: 0000000000000005 RSI: ffffffeadfcbe862 RDI: 
0000000000000000
4,1628,363542180,-;RBP: 0000000000000005 R08: 0000000000000002 R09: 
000000002962cdac
4,1629,363543152,-;R10: 0000000000000010 R11: 0000000000000c05 R12: 
ffffffff85b4c920
4,1630,363544149,-;R13: 00000054a3b61723 R14: 0000000000000005 R15: 
0000000000000000
4,1631,363545113,-; cpuidle_enter+0x2d/0x40
4,1632,363546071,-; do_idle+0x1ed/0x270
4,1633,363547021,-; cpu_startup_entry+0x1d/0x20
4,1634,363547998,-; start_secondary+0x115/0x140
4,1635,363548949,-; secondary_startup_64_no_verify+0xe5/0xeb
4,1636,363549896,-; </TASK>
4,1637,363550877,-;---[ end trace 0000000000000000 ]---
3,1638,368861144,-;r8169 0000:0a:00.0 enp10s0: rtl_chipcmd_cond == 1 
(loop: 100, delay: 100).
  SUBSYSTEM=pci
  DEVICE=+pci:0000:0a:00.0
47,1639,370063740,-;systemd-journald[301]: Sent WATCHDOG=1 notification.
3,1640,374173221,-;r8169 0000:0a:00.0 enp10s0: rtl_ephyar_cond == 1 
(loop: 100, delay: 10).
  SUBSYSTEM=pci
  DEVICE=+pci:0000:0a:00.0

---

The first part is just the Ethernet controller being locked up with the 
rest of the system. The error messages at the end (rtl_chipcmd_cond) are 
one version of what I've seen before depending on which options I have 
tried. The machine locks so hard that even the motherboard hardware 
reset button doesn't work and the machine has to be forced power-off.

I did try first going to the Linux netdev list but due to all the PCI 
related messages it was suggested it might be related to that. Which 
also seems indicated because disabling MMCONFIG fixes it. I'm not sure 
though.
