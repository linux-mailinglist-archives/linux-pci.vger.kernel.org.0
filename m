Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B80EC7C81C
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2019 18:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbfGaQEl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Jul 2019 12:04:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47068 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728795AbfGaQEk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Jul 2019 12:04:40 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hsr5j-0003S0-4U
        for linux-pci@vger.kernel.org; Wed, 31 Jul 2019 16:04:39 +0000
Received: by mail-pg1-f198.google.com with SMTP id n3so33304193pgh.12
        for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2019 09:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=1UTn4h2zeGRodRaDrd/JZgv2Q6Zf253Lel/s2dvM0/U=;
        b=gbPARaZx7llQ0iv4BdVAoAB/LUs99roPWHcB3SRPQVu3r80dImJJsrYLy4G6P4979u
         g0oWyo+VOQfce/M0/nI2OxRmXqch67gfTWH7QmD5pFEncI0ppS9mwHWGOcEIIg7q2G0f
         3g5DQcJ8jp384wbp3jSJZSnNOXJvOeQjDbGsaRH9YCkLS81Nw/Xjp8SGD2uPG5ENn/ud
         fmjwGwftfIg7be762xTywEPpuOWgT2CmCeJHdn5VKZd/F+XhLCkfqt5W16l4XKWHAW0B
         +sMXc14rOjdv530Q3QQ+gCAlfckwzyjk5KmEVcZVmRJGJIznvzffnw37vuAO8vTvSfAC
         B9jw==
X-Gm-Message-State: APjAAAX2Ff7v9EpVjlMp0LMji5PuqSrF8TEJ2sgqsfLdeZ30e3PtEYMv
        X1sZlRD0NkDRkqBb7kHVr3hmT0QqmbAtx5QQOGv22MwYoP5swY/nLK+If277i/vEWoCG1fV/vHZ
        DINMC0ymrOTeFKu8EgVaOFKnz9kfTtxPCkIw2Ag==
X-Received: by 2002:a62:e815:: with SMTP id c21mr50061075pfi.244.1564589076752;
        Wed, 31 Jul 2019 09:04:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxfp/AISVBO9OllPlTac1N2vWloiHtDLFWvJDUKmnAU4yATIMuMP8tamfQmB+D+PUzxu+qKEA==
X-Received: by 2002:a62:e815:: with SMTP id c21mr50061017pfi.244.1564589076270;
        Wed, 31 Jul 2019 09:04:36 -0700 (PDT)
Received: from 2001-b011-380f-37d3-f52e-c69b-5d89-c245.dynamic-ip6.hinet.net (2001-b011-380f-37d3-f52e-c69b-5d89-c245.dynamic-ip6.hinet.net. [2001:b011:380f:37d3:f52e:c69b:5d89:c245])
        by smtp.gmail.com with ESMTPSA id d14sm85185308pfo.154.2019.07.31.09.04.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 09:04:35 -0700 (PDT)
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 8bit
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: [Regression] Commit "ACPI: PM: Allow transitions to D0 to occur in
 special cases"
Message-Id: <578BD3F1-B185-471B-A3EB-FF71BA34B822@canonical.com>
Date:   Thu, 1 Aug 2019 00:04:29 +0800
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

After commit "ACPI: PM: Allow transitions to D0 to occur in special cases”,  
Thunderbolt on XPS 9380 spews the following when it runtime resumes:
[   36.136554] pci_raw_set_power_state: 25 callbacks suppressed
[   36.136558] pcieport 0000:03:00.0: Refused to change power state,  
currently in D3
[   36.143850] pcieport 0000:04:04.0: Refused to change power state,  
currently in D3
[   36.150796] pcieport 0000:04:00.0: Refused to change power state,  
currently in D3
[   36.157138] pcieport 0000:04:01.0: Refused to change power state,  
currently in D3
[   36.162635] pcieport 0000:04:02.0: Refused to change power state,  
currently in D3
[   36.166711] pcieport 0000:04:01.0: pciehp: pcie_do_write_cmd: no  
response from device
[   36.166818] pcieport 0000:04:01.0: pciehp: Slot(1): Card present
[   36.166820] pcieport 0000:04:01.0: pciehp: Slot(1): Link Up
[   36.167122] pcieport 0000:04:04.0: pciehp: pcie_do_write_cmd: no  
response from device
[   36.167179] pcieport 0000:04:04.0: pciehp: Slot(4): Card present
[   36.167181] pcieport 0000:04:04.0: pciehp: Slot(4): Link Up
[   36.196453] usb 1-6: new high-speed USB device number 4 using xhci_hcd
[   36.436436] usb 1-6: New USB device found, idVendor=058f,  
idProduct=6387, bcdDevice= 1.03
[   36.436438] usb 1-6: New USB device strings: Mfr=1, Product=2,  
SerialNumber=3
[   36.436439] usb 1-6: Product: Mass Storage
[   36.436441] usb 1-6: Manufacturer: Generic
[   36.436442] usb 1-6: SerialNumber: 7632C867
[   37.276751] thunderbolt 0000:05:00.0: Refused to change power state,  
currently in D3
[   37.343078] xhci_hcd 0000:39:00.0: Refused to change power state,  
currently in D3
[   37.407135] ------------[ cut here ]------------
[   37.407136] thunderbolt 0000:05:00.0: interrupt for TX ring 0 is already  
enabled
[   37.407167] WARNING: CPU: 0 PID: 1830 at drivers/thunderbolt/nhi.c:104  
ring_interrupt_active+0x1f6/0x240 [thunderbolt]
[   37.407167] Modules linked in: rfcomm ccm cmac bnep nls_iso8859_1  
snd_hda_codec_hdmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel  
kvm snd_hda_codec_realtek irqbypass snd_hda_codec_generic dell_laptop  
ledtrig_audi
o sof_pci_dev dell_wmi snd_sof_intel_hda_common dell_smbios  
snd_sof_intel_byt snd_sof_intel_ipc mei_hdcp snd_sof snd_sof_xtensa_dsp  
snd_soc_skl wmi_bmof intel_wmi_thunderbolt dell_wmi_descriptor  
snd_soc_hdac_hda snd_hda_ext_cor
e intel_rapl_msr crct10dif_pclmul snd_soc_skl_ipc snd_soc_sst_dsp  
snd_soc_sst_ipc snd_soc_core snd_soc_acpi_intel_match snd_soc_acpi  
crc32_pclmul ghash_clmulni_intel joydev snd_hda_intel snd_hda_codec  
snd_hwdep snd_hda_core snd
_pcm aesni_intel aes_x86_64 glue_helper crypto_simd iwlmvm cryptd mac80211  
dcdbas snd_seq i915 libarc4 intel_cstate intel_rapl_perf uvcvideo snd_timer  
input_leds btusb snd_seq_device btrtl iwlwifi serio_raw btbcm btintel videob
uf2_vmalloc i2c_algo_bit videobuf2_memops snd bluetooth drm_kms_helper  
videobuf2_v4l2
[   37.407181]  videobuf2_common videodev syscopyarea mc sysfillrect  
soundcore sysimgblt cfg80211 fb_sys_fops drm rtsx_pci_ms memstick mei_me  
ecdh_generic ecc mei hid_multitouch processor_thermal_device idma64  
ucsi_acpi intel_p
ch_thermal typec_ucsi intel_soc_dts_iosf virt_dma intel_rapl_common typec  
mac_hid wmi video int3403_thermal int3400_thermal int340x_thermal_zone  
intel_hid acpi_pad acpi_thermal_rel sparse_keymap sch_fq_codel parport_pc  
ppdev lp
  parport ip_tables x_tables autofs4 hid_generic rtsx_pci_sdmmc nvme psmouse nvme_core thunderbolt i2c_i801 rtsx_pci intel_lpss_pci i2c_hid intel_lpss hid pinctrl_cannonlake pinctrl_intel
[   37.407192] CPU: 0 PID: 1830 Comm: kworker/0:4 Not tainted 5.3.0-rc2+ #47
[   37.407192] Hardware name: Dell Inc. XPS 13 9380/0SSY11, BIOS 1.5.0  
06/03/2019
[   37.407195] Workqueue: pm pm_runtime_work
[   37.407198] RIP: 0010:ring_interrupt_active+0x1f6/0x240 [thunderbolt]
[   37.407199] Code: 4c 89 4d c8 44 89 45 d4 e8 c7 cd 73 fd 4c 8b 4d c8 44  
8b 45 d4 4c 89 e1 48 89 c6 4c 89 f2 48 c7 c7 20 11 1a c0 e8 35 f0 10 fd  
<0f> 0b e9 17 ff ff ff 41 0f b6 47 78 d3 e0 09 c7 e9 d7 fe ff ff 44
[   37.407199] RSP: 0018:ffffbf8701c1fc70 EFLAGS: 00010082
[   37.407200] RAX: 0000000000000000 RBX: 00000000ffffffff RCX:  
0000000000000006
[   37.407200] RDX: 0000000000000007 RSI: 0000000000000092 RDI:  
ffff9d5264417440
[   37.407201] RBP: ffffbf8701c1fca8 R08: 000000000000047b R09:  
0000000000000004
[   37.407201] R10: 0000000000000000 R11: 0000000000000001 R12:  
ffffffffc01a0641
[   37.407202] R13: 0000000000038200 R14: ffff9d52620c3d60 R15:  
ffff9d525faa1300
[   37.407202] FS:  0000000000000000(0000) GS:ffff9d5264400000(0000)  
knlGS:0000000000000000
[   37.407203] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.407203] CR2: 00007ffe0858de38 CR3: 000000013b20a001 CR4:  
00000000003606f0
[   37.407204] DR0: 0000000000000000 DR1: 0000000000000000 DR2:  
0000000000000000
[   37.407204] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:  
0000000000000400
[   37.407204] Call Trace:
[   37.407208]  tb_ring_start+0xd4/0x1c0 [thunderbolt]
[   37.407210]  tb_ctl_start+0x2d/0xa0 [thunderbolt]
[   37.407213]  tb_domain_runtime_resume+0x1a/0x40 [thunderbolt]
[   37.407215]  nhi_runtime_resume+0x28/0x30 [thunderbolt]
[   37.407217]  pci_pm_runtime_resume+0x75/0xd0
[   37.407218]  ? pci_restore_standard_config+0x50/0x50
[   37.407218]  __rpm_callback+0x8c/0x150
[   37.407219]  ? pci_restore_standard_config+0x50/0x50
[   37.407220]  rpm_callback+0x24/0x80
[   37.407221]  ? pci_restore_standard_config+0x50/0x50
[   37.407222]  rpm_resume+0x568/0x780
[   37.407223]  pm_runtime_work+0x7d/0xa0
[   37.407225]  process_one_work+0x1db/0x380
[   37.407226]  worker_thread+0x4d/0x400
[   37.407227]  kthread+0x104/0x140
[   37.407228]  ? process_one_work+0x380/0x380
[   37.407229]  ? kthread_park+0x80/0x80
[   37.407231]  ret_from_fork+0x1f/0x40
[   37.407232] ---[ end trace 33a816af30ee403d ]---
[   37.407251] ------------[ cut here ]------------
[   37.407252] thunderbolt 0000:05:00.0: interrupt for RX ring 0 is already  
enabled
[   37.407262] WARNING: CPU: 0 PID: 1830 at drivers/thunderbolt/nhi.c:104  
ring_interrupt_active+0x1f6/0x240 [thunderbolt]
[   37.407262] Modules linked in: rfcomm ccm cmac bnep nls_iso8859_1  
snd_hda_codec_hdmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel  
kvm snd_hda_codec_realtek irqbypass snd_hda_codec_generic dell_laptop  
ledtrig_audio sof_pci_dev dell_wmi snd_sof_intel_hda_common dell_smbios  
snd_sof_intel_byt snd_sof_intel_ipc mei_hdcp snd_sof snd_sof_xtensa_dsp  
snd_soc_skl wmi_bmof intel_wmi_thunderbolt dell_wmi_descriptor  
snd_soc_hdac_hda snd_hda_ext_core intel_rapl_msr crct10dif_pclmul  
snd_soc_skl_ipc snd_soc_sst_dsp snd_soc_sst_ipc snd_soc_core  
snd_soc_acpi_intel_match snd_soc_acpi crc32_pclmul ghash_clmulni_intel  
joydev snd_hda_intel snd_hda_codec snd_hwdep snd_hda_core snd_pcm  
aesni_intel aes_x86_64 glue_helper crypto_simd iwlmvm cryptd mac80211  
dcdbas snd_seq i915 libarc4 intel_cstate intel_rapl_perf uvcvideo snd_timer  
input_leds btusb snd_seq_device btrtl iwlwifi serio_raw btbcm btintel  
videobuf2_vmalloc i2c_algo_bit videobuf2_memops snd bluetooth  
drm_kms_helper videobuf2_v4l2
[   37.407270]  videobuf2_common videodev syscopyarea mc sysfillrect  
soundcore sysimgblt cfg80211 fb_sys_fops drm rtsx_pci_ms memstick mei_me  
ecdh_generic ecc mei hid_multitouch processor_thermal_device idma64  
ucsi_acpi intel_pch_thermal typec_ucsi intel_soc_dts_iosf virt_dma  
intel_rapl_common typec mac_hid wmi video int3403_thermal int3400_thermal  
int340x_thermal_zone intel_hid acpi_pad acpi_thermal_rel sparse_keymap  
sch_fq_codel parport_pc ppdev lp parport ip_tables x_tables autofs4  
hid_generic rtsx_pci_sdmmc nvme psmouse nvme_core thunderbolt i2c_i801  
rtsx_pci intel_lpss_pci i2c_hid intel_lpss hid pinctrl_cannonlake  
pinctrl_intel
[   37.407277] CPU: 0 PID: 1830 Comm: kworker/0:4 Tainted: G         
W         5.3.0-rc2+ #47
[   37.407278] Hardware name: Dell Inc. XPS 13 9380/0SSY11, BIOS 1.5.0  
06/03/2019
[   37.407279] Workqueue: pm pm_runtime_work
[   37.407281] RIP: 0010:ring_interrupt_active+0x1f6/0x240 [thunderbolt]
[   37.407281] Code: 4c 89 4d c8 44 89 45 d4 e8 c7 cd 73 fd 4c 8b 4d c8 44  
8b 45 d4 4c 89 e1 48 89 c6 4c 89 f2 48 c7 c7 20 11 1a c0 e8 35 f0 10 fd  
<0f> 0b e9 17 ff ff ff 41 0f b6 47 78 d3 e0 09 c7 e9 d7 fe ff ff 44
[   37.407282] RSP: 0018:ffffbf8701c1fc70 EFLAGS: 00010082
[   37.407282] RAX: 0000000000000000 RBX: 00000000ffffffff RCX:  
0000000000000006
[   37.407283] RDX: 0000000000000007 RSI: 0000000000000092 RDI:  
ffff9d5264417440
[   37.407283] RBP: ffffbf8701c1fca8 R08: 00000000000004a4 R09:  
0000000000000004
[   37.407284] R10: 0000000000000000 R11: 0000000000000001 R12:  
ffffffffc01a0649
[   37.407284] R13: 0000000000038200 R14: ffff9d52620c3d60 R15:  
ffff9d525faa1000
[   37.407284] FS:  0000000000000000(0000) GS:ffff9d5264400000(0000)  
knlGS:0000000000000000
[   37.407285] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.407285] CR2: 00007ffe0858de38 CR3: 000000013b20a001 CR4:  
00000000003606f0
[   37.407286] DR0: 0000000000000000 DR1: 0000000000000000 DR2:  
0000000000000000
[   37.407286] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:  
0000000000000400
[   37.407286] Call Trace:
[   37.407288]  tb_ring_start+0xd4/0x1c0 [thunderbolt]
[   37.407290]  tb_ctl_start+0x36/0xa0 [thunderbolt]
[   37.407293]  tb_domain_runtime_resume+0x1a/0x40 [thunderbolt]
[   37.407295]  nhi_runtime_resume+0x28/0x30 [thunderbolt]
[   37.407296]  pci_pm_runtime_resume+0x75/0xd0
[   37.407296]  ? pci_restore_standard_config+0x50/0x50
[   37.407297]  __rpm_callback+0x8c/0x150
[   37.407298]  ? pci_restore_standard_config+0x50/0x50
[   37.407299]  rpm_callback+0x24/0x80
[   37.407300]  ? pci_restore_standard_config+0x50/0x50
[   37.407300]  rpm_resume+0x568/0x780
[   37.407302]  pm_runtime_work+0x7d/0xa0
[   37.407303]  process_one_work+0x1db/0x380
[   37.407304]  worker_thread+0x4d/0x400
[   37.407305]  kthread+0x104/0x140
[   37.407305]  ? process_one_work+0x380/0x380
[   37.407306]  ? kthread_park+0x80/0x80
[   37.407307]  ret_from_fork+0x1f/0x40
[   37.407308] ---[ end trace 33a816af30ee403e ]---
[   37.424608] xhci_hcd 0000:39:00.0: Refused to change power state,  
currently in D3
[   37.424702] xhci_hcd 0000:39:00.0: WARN: xHC restore state timeout
[   37.424703] xhci_hcd 0000:39:00.0: PCI post-resume error -110!
[   37.424705] xhci_hcd 0000:39:00.0: HC died; cleaning up
[   37.704717] pcieport 0000:04:04.0: pciehp: link training error: status  
0xffff
[   37.704721] pcieport 0000:04:01.0: pciehp: link training error: status  
0xffff
[   37.704725] pcieport 0000:04:01.0: pciehp: Failed to check link status
[   37.704731] pcieport 0000:04:04.0: pciehp: Failed to check link status
[   37.704776] pcieport 0000:04:01.0: pciehp: pcie_do_write_cmd: no  
response from device
[   37.704778] pcieport 0000:04:04.0: pciehp: pcie_do_write_cmd: no  
response from device

Kai-Heng

