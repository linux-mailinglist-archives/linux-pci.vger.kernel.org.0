Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88F32D9FA1
	for <lists+linux-pci@lfdr.de>; Mon, 14 Dec 2020 19:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502179AbgLNSxB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Dec 2020 13:53:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:50404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502160AbgLNSws (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Dec 2020 13:52:48 -0500
Date:   Tue, 15 Dec 2020 03:51:57 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607971923;
        bh=OT6eIOaIJZw5REUbP4MkZ+0RtLFxCnFwcEP7g0w2rEo=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZQ95iMVv/qQ20RGROm48kxcfFr08nMiMJ6/PHX5pMCAvk6Cog0J/6o3RU5BK20ETZ
         14V5QhjXzd9p/d39vhFUtTzNp9A1yd4YUdBbzD6elhLrR5B6e1DKOck3A9OZZ5ioW9
         GuvnsaAZ3o88TK2wH1ii2b46/l2BIJJzuvv1V0qU9Si1u3ijCN1+zkP2o7FUBy2YzX
         ou3bHslb4yHmbxA58UkXavVvVphlk8T3oZXgNiqovWYsFkwS0dY5AtLkoUJZiKuT8U
         ZgPpQuSmEPrfkW4fL4oCWTyL+sQLZI25LtwazvxQPijDD2gkU0ePNtaXfPz2sgIrPR
         zzrk2TdaLwpAA==
From:   Keith Busch <kbusch@kernel.org>
To:     Hinko Kocevar <Hinko.Kocevar@ess.eu>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Kernel oops while using AER inject
Message-ID: <20201214185157.GA22809@redsun51.ssa.fujisawa.hgst.com>
References: <c4bf0e02cd7d4ec49462245a315f882f@ess.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4bf0e02cd7d4ec49462245a315f882f@ess.eu>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 03, 2020 at 04:00:04PM +0000, Hinko Kocevar wrote:
> Note that I had to manually remove following devices to make the recovery report success:
> 
> echo 1 > /sys/bus/pci/devices/0000\:02\:02.0/remove 
> echo 1 > /sys/bus/pci/devices/0000\:02\:08.0/remove 
> echo 1 > /sys/bus/pci/devices/0000\:02\:09.0/remove 
> echo 1 > /sys/bus/pci/devices/0000\:02\:0a.0/remove 
> echo 1 > /sys/bus/pci/devices/0000\:01\:00.1/remove 
> echo 1 > /sys/bus/pci/devices/0000\:01\:00.2/remove 
> echo 1 > /sys/bus/pci/devices/0000\:01\:00.3/remove 
> echo 1 > /sys/bus/pci/devices/0000\:01\:00.4/remove 
> 
> After that, the PCI device tree looks like this:
> 
> 00:01.0 root_port, "J6B2", slot 1, device present, speed 8GT/s, width x8
>  └─01:00.0 upstream_port, PLX Technology, Inc. (10b5), device 8725
>     └─02:01.0 downstream_port, slot 1, device present, power: Off, speed 8GT/s, width x4
>        └─03:00.0 upstream_port, PLX Technology, Inc. (10b5) PEX 8748 48-Lane, 12-Port PCI Express Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (8748)
>           ├─04:00.0 downstream_port, slot 10, power: Off
>           ├─04:01.0 downstream_port, slot 4, device present, power: Off, speed 8GT/s, width x4
>           │  └─06:00.0 endpoint, Research Centre Juelich (1796), device 0024
>           ├─04:02.0 downstream_port, slot 9, power: Off
>           ├─04:03.0 downstream_port, slot 3, device present, power: Off, speed 8GT/s, width x4
>           │  └─08:00.0 endpoint, Research Centre Juelich (1796), device 0024
>           ├─04:08.0 downstream_port, slot 5, device present, power: Off, speed 2.5GT/s, width x4
>           │  └─09:00.0 endpoint, current speed 2.5GT/s target speed 8GT/s, Research Centre Juelich (1796), device 0024
>           ├─04:09.0 downstream_port, slot 11, power: Off
>           ├─04:0a.0 downstream_port, slot 6, device present, power: Off, speed 2.5GT/s, width x4
>           │  └─0b:00.0 endpoint, current speed 2.5GT/s target speed 8GT/s, Research Centre Juelich (1796), device 0024
>           ├─04:0b.0 downstream_port, slot 12, power: Off
>           ├─04:10.0 downstream_port, slot 8, power: Off
>           ├─04:11.0 downstream_port, slot 2, device present, power: Off, speed 2.5GT/s, width x1
>           │  └─0e:00.0 endpoint, Xilinx Corporation (10ee), device 7011
>           └─04:12.0 downstream_port, slot 7, power: Off
> 00:01.1 root_port, slot 2, device present
> 00:1c.0 root_port, slot 4, device present, speed 2.5GT/s, width x1
>  └─15:00.0 endpoint, Intel Corporation (8086) I210 Gigabit Network Connection (1533)
> 00:1c.1 root_port, slot 5, device present, speed 2.5GT/s, width x1
>  └─16:00.0 endpoint, Intel Corporation (8086) I210 Gigabit Backplane Connection (1537)
> 00:1c.2 root_port, slot 6, device present, speed 2.5GT/s, width x1
>  └─17:00.0 endpoint, Intel Corporation (8086) I210 Gigabit Backplane Connection (1537)
> 00:1c.3 root_port, "J6B1", slot 7, device present, speed 2.5GT/s, width x1
>  └─18:00.0 endpoint, Intel Corporation (8086) I210 Gigabit Network Connection (1533)
> 
> Finally, here is the result of the AER recovery taking place upon injecting the fatal uncorrectable error into the 00:01.0 slot.
> 
> Dec  3 15:25:30 bd-cpu18 kernel: aer 0000:00:01.0:pcie002: aer_inject: Injecting errors 00000000/00004000 into device 0000:00:01.0
> Dec  3 15:25:30 bd-cpu18 kernel: pcieport 0000:00:01.0: AER: Uncorrected (Fatal) error received: id=0008
> Dec  3 15:25:30 bd-cpu18 kernel: pcieport 0000:00:01.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, id=0008(Requester ID)
> Dec  3 15:25:30 bd-cpu18 kernel: pcieport 0000:00:01.0:   device [8086:1901] error status/mask=00004000/00000000
> Dec  3 15:25:30 bd-cpu18 kernel: pcieport 0000:00:01.0:    [14] Completion Timeout    
> Dec  3 15:25:30 bd-cpu18 kernel: sis8300 0000:06:00.0: [aer_error_detected] called .. state=2
> Dec  3 15:25:30 bd-cpu18 kernel: sis8300 0000:08:00.0: [aer_error_detected] called .. state=2
> Dec  3 15:25:30 bd-cpu18 kernel: sis8300 0000:09:00.0: [aer_error_detected] called .. state=2
> Dec  3 15:25:30 bd-cpu18 kernel: sis8300 0000:0b:00.0: [aer_error_detected] called .. state=2
> Dec  3 15:25:30 bd-cpu18 kernel: mrf-pci 0000:0e:00.0: [aer_error_detected] called .. state=2
> Dec  3 15:25:31 bd-cpu18 kernel: sis8300 0000:06:00.0: [aer_result_none] called..
> Dec  3 15:25:31 bd-cpu18 kernel: sis8300 0000:08:00.0: [aer_result_none] called..
> Dec  3 15:25:31 bd-cpu18 kernel: sis8300 0000:09:00.0: [aer_result_none] called..
> Dec  3 15:25:31 bd-cpu18 kernel: sis8300 0000:0b:00.0: [aer_result_none] called..
> Dec  3 15:25:31 bd-cpu18 kernel: mrf-pci 0000:0e:00.0: [aer_result_none] called..
> Dec  3 15:25:31 bd-cpu18 kernel: sis8300 0000:06:00.0: [aer_resume] called..
> Dec  3 15:25:31 bd-cpu18 kernel: sis8300 0000:06:00.0: [aer_resume] UC errors cleared!
> Dec  3 15:25:31 bd-cpu18 kernel: sis8300 0000:08:00.0: [aer_resume] called..
> Dec  3 15:25:31 bd-cpu18 kernel: sis8300 0000:08:00.0: [aer_resume] UC errors cleared!
> Dec  3 15:25:31 bd-cpu18 kernel: sis8300 0000:09:00.0: [aer_resume] called..
> Dec  3 15:25:31 bd-cpu18 kernel: sis8300 0000:09:00.0: [aer_resume] UC errors cleared!
> Dec  3 15:25:31 bd-cpu18 kernel: sis8300 0000:0b:00.0: [aer_resume] called..
> Dec  3 15:25:31 bd-cpu18 kernel: sis8300 0000:0b:00.0: [aer_resume] UC errors cleared!
> Dec  3 15:25:31 bd-cpu18 kernel: mrf-pci 0000:0e:00.0: [aer_resume] called..
> Dec  3 15:25:31 bd-cpu18 kernel: pcieport 0000:00:01.0: AER: Device recovery successful
> Dec  3 15:25:33 bd-cpu18 kernel: sis8300 0000:08:00.0: [sis8300_open] available = 1
> Dec  3 15:25:33 bd-cpu18 kernel: sis8300 0000:08:00.0: [sis8300_release] available = 1, count = 0
> Dec  3 15:25:33 bd-cpu18 kernel: sis8300 0000:06:00.0: [sis8300_open] available = 1
> Dec  3 15:25:33 bd-cpu18 kernel: sis8300 0000:06:00.0: [sis8300_release] available = 1, count = 0
> Dec  3 15:25:33 bd-cpu18 kernel: sis8300 0000:09:00.0: [sis8300_open] available = 1
> Dec  3 15:25:33 bd-cpu18 kernel: sis8300 0000:09:00.0: [sis8300_release] available = 1, count = 0
> Dec  3 15:25:33 bd-cpu18 kernel: sis8300 0000:0b:00.0: [sis8300_open] available = 1
> Dec  3 15:25:33 bd-cpu18 kernel: sis8300 0000:0b:00.0: [sis8300_release] available = 1, count = 0
> Dec  3 15:25:34 bd-cpu18 kernel: sis8300 0000:08:00.0: [sis8300_open] available = 1
> Dec  3 15:25:34 bd-cpu18 kernel: sis8300 0000:08:00.0: [sis8300_release] available = 1, count = 0
> Dec  3 15:25:34 bd-cpu18 kernel: sis8300 0000:06:00.0: [sis8300_open] available = 1
> Dec  3 15:25:34 bd-cpu18 kernel: sis8300 0000:06:00.0: [sis8300_release] available = 1, count = 0
> Dec  3 15:25:34 bd-cpu18 kernel: sis8300 0000:09:00.0: [sis8300_open] available = 1
> Dec  3 15:25:34 bd-cpu18 kernel: sis8300 0000:09:00.0: [sis8300_release] available = 1, count = 0
> Dec  3 15:25:34 bd-cpu18 kernel: sis8300 0000:0b:00.0: [sis8300_open] available = 1
> Dec  3 15:25:34 bd-cpu18 kernel: sis8300 0000:0b:00.0: [sis8300_release] available = 1, count = 0
> Dec  3 15:25:47 bd-cpu18 dbus[1266]: [system] Activating service name='org.freedesktop.problems' (using servicehelper)
> Dec  3 15:25:47 bd-cpu18 dbus[1266]: [system] Successfully activated service 'org.freedesktop.problems'
> 
> At this point the PCI space reads for the AMCs returns 0xFFFFFFFF.
> 
> Below are messages captured after issuing 'echo 1 > /sys/bus/pci/rescan'. After that the CPU card rebooted by itself.
> 
> Dec  3 15:25:59 bd-cpu18 kernel: pci 0000:01:00.1: Max Payload Size set to 256 (was 128, max 1024)
> Dec  3 15:25:59 bd-cpu18 kernel: pci 0000:01:00.2: Max Payload Size set to 256 (was 128, max 1024)
> Dec  3 15:25:59 bd-cpu18 kernel: pci 0000:01:00.3: Max Payload Size set to 256 (was 128, max 1024)
> Dec  3 15:25:59 bd-cpu18 kernel: pci 0000:01:00.4: Max Payload Size set to 256 (was 128, max 1024)
> Dec  3 15:25:59 bd-cpu18 kernel: pcieport 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> Dec  3 15:25:59 bd-cpu18 kernel: pcieport 0000:02:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> Dec  3 15:25:59 bd-cpu18 kernel: pci 0000:02:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> Dec  3 15:25:59 bd-cpu18 kernel: pci 0000:02:08.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> Dec  3 15:25:59 bd-cpu18 kernel: pci 0000:02:09.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> Dec  3 15:25:59 bd-cpu18 kernel: pci 0000:02:0a.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> Dec  3 15:25:59 bd-cpu18 kernel: pcieport 0000:03:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> Dec  3 15:25:59 bd-cpu18 kernel: pcieport 0000:04:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> Dec  3 15:25:59 bd-cpu18 kernel: pcieport 0000:04:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> Dec  3 15:25:59 bd-cpu18 kernel: pcieport 0000:04:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> Dec  3 15:25:59 bd-cpu18 kernel: pcieport 0000:04:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> Dec  3 15:25:59 bd-cpu18 kernel: pcieport 0000:04:08.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> Dec  3 15:25:59 bd-cpu18 kernel: pcieport 0000:04:09.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> Dec  3 15:25:59 bd-cpu18 kernel: pcieport 0000:04:0a.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> Dec  3 15:25:59 bd-cpu18 kernel: pcieport 0000:04:0b.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> Dec  3 15:25:59 bd-cpu18 kernel: pcieport 0000:04:10.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> Dec  3 15:25:59 bd-cpu18 kernel: pcieport 0000:04:11.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> Dec  3 15:25:59 bd-cpu18 kernel: pcieport 0000:04:12.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> Dec  3 15:25:59 bd-cpu18 kernel: BUG: unable to handle kernel NULL pointer dereference at           (null)
> Dec  3 15:25:59 bd-cpu18 kernel: IP: [<ffffffffc0b182f7>] aer_inj_read_config+0x87/0x160 [aer_inject]
> Dec  3 15:25:59 bd-cpu18 kernel: PGD 80000001767c4067 PUD 431939067 PMD 0 
> Dec  3 15:25:59 bd-cpu18 kernel: Oops: 0000 [#1] SMP 
> Dec  3 15:25:59 bd-cpu18 kernel: Modules linked in: aer_inject sis8300drv(OE) xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 devlink tun bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod iTCO_wdt iTCO_vendor_support mei_wdt intel_wmi_thunderbolt intel_pmc_core snd_hda_codec_hdmi intel_powerclamp coretemp intel_rapl kvm_intel snd_hda_intel snd_hda_codec kvm snd_hda_core irqbypass crc32_pclmul snd_hwdep ghash_clmulni_intel snd_seq snd_seq_device aesni_intel lrw gf128mul snd_pcm glue_helper ablk_helper cryptd pcspkr snd_timer snd i2c_i801 soundcore sg i2c_designware_platform i2c_designware_core mei_me mei ie31200_edac
> Dec  3 15:25:59 bd-cpu18 kernel: wmi pinctrl_sunrisepoint pinctrl_intel tpm_crb acpi_pad ip_tables xfs libcrc32c sd_mod crc_t10dif crct10dif_generic i915 iosf_mbi drm_kms_helper ahci syscopyarea sysfillrect sysimgblt fb_sys_fops crct10dif_pclmul igb libahci crct10dif_common crc32c_intel drm libata serio_raw ptp pps_core dca i2c_algo_bit drm_panel_orientation_quirks mrf(OE) parport uio i2c_hid video [last unloaded: sis8300drv]
> Dec  3 15:25:59 bd-cpu18 kernel: CPU: 4 PID: 8150 Comm: bash Kdump: loaded Tainted: G           OE  ------------   3.10.0-1160.6.1.el7.x86_64.debug #1
> Dec  3 15:25:59 bd-cpu18 kernel: Hardware name: AMI AM G6x/msd/AM G6x/msd, BIOS 4.08.01 02/19/2019
> Dec  3 15:25:59 bd-cpu18 kernel: task: ffff9b22b5f88000 ti: ffff9b22b5bc4000 task.ti: ffff9b22b5bc4000
> Dec  3 15:25:59 bd-cpu18 kernel: RIP: 0010:[<ffffffffc0b182f7>]  [<ffffffffc0b182f7>] aer_inj_read_config+0x87/0x160 [aer_inject]
> Dec  3 15:25:59 bd-cpu18 kernel: RSP: 0018:ffff9b22b5bc7a30  EFLAGS: 00010046
> Dec  3 15:25:59 bd-cpu18 kernel: RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000004
> Dec  3 15:25:59 bd-cpu18 kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9b25718ab000
> Dec  3 15:25:59 bd-cpu18 kernel: RBP: ffff9b22b5bc7a68 R08: ffff9b22b5bc7a84 R09: ffffffffc0b1a0b0
> Dec  3 15:25:59 bd-cpu18 kernel: R10: 0000000000000001 R11: 69c1fefdd26da26d R12: 0000000000000000
> Dec  3 15:25:59 bd-cpu18 kernel: R13: ffffffffc0b1a050 R14: ffff9b22b5bc7a84 R15: ffff9b25718ab000
> Dec  3 15:25:59 bd-cpu18 kernel: FS:  00007f3d00e8b740(0000) GS:ffff9b259ce00000(0000) knlGS:0000000000000000
> Dec  3 15:25:59 bd-cpu18 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Dec  3 15:25:59 bd-cpu18 kernel: CR2: 0000000000000000 CR3: 0000000175796000 CR4: 00000000003607e0
> Dec  3 15:25:59 bd-cpu18 kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Dec  3 15:25:59 bd-cpu18 kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Dec  3 15:25:59 bd-cpu18 kernel: Call Trace:
> Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c61a9c>] pci_bus_read_config_dword+0x8c/0xb0
> Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c63a68>] pci_bus_read_dev_vendor_id+0x28/0xe0
> Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c65e04>] pci_scan_single_device+0x74/0xf0
> Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c65eba>] pci_scan_slot+0x3a/0x140
> Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c6711d>] pci_scan_child_bus_extend+0x4d/0x2f0
> Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c62bcb>] ? pci_bus_write_config_dword+0x6b/0x80
> Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c66f4b>] pci_scan_bridge_extend+0x47b/0x5e0
> Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c65e04>] ? pci_scan_single_device+0x74/0xf0
> Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c67286>] pci_scan_child_bus_extend+0x1b6/0x2f0
> Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c66f4b>] pci_scan_bridge_extend+0x47b/0x5e0
> Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c67286>] pci_scan_child_bus_extend+0x1b6/0x2f0
> Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c673d0>] pci_scan_child_bus+0x10/0x20
> Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c66f01>] pci_scan_bridge_extend+0x431/0x5e0
> Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c65e04>] ? pci_scan_single_device+0x74/0xf0
> Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c671e7>] pci_scan_child_bus_extend+0x117/0x2f0
> Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c674b6>] pci_rescan_bus+0x16/0x40
> Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c70d78>] bus_rescan_store+0x78/0xa0
> Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2d56909>] bus_attr_store+0x29/0x30
> Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2b5272a>] sysfs_kf_write+0x4a/0x60
> Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2b51ff6>] kernfs_fop_write+0x106/0x190
> Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2aaf3fc>] vfs_write+0xdc/0x240
> Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2ad5984>] ? fget_light+0x3c4/0x550
> Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2ab029a>] SyS_write+0x8a/0x100
> Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa3098b12>] system_call_fastpath+0x25/0x2a
> Dec  3 15:25:59 bd-cpu18 kernel: Code: 81 f9 b0 a0 b1 c0 74 5c 4d 3b 79 10 75 ee 49 8b 41 18 4d 8b af b8 00 00 00 89 de 49 89 87 b8 00 00 00 4d 89 f0 44 89 e2 4c 89 ff <48> 8b 00 e8 41 f3 10 e2 48 8b 75 d0 89 c3 4d 89 af b8 00 00 00 

I believe this is a known issue with aer_inject when you re-enumerate
devices below a bridge with injected errors. I reported it here:

  https://lore.kernel.org/linux-pci/20180918235848.26694-3-keith.busch@intel.com/

Essentially, the re-enumerated devices inherit the injected bus_ops, but
aer_inject doesn't know about those devices.

The solution I proposed, however, had some CPU architectural and kernel
config limitations that made it less appealing.
