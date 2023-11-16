Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC767EDB21
	for <lists+linux-pci@lfdr.de>; Thu, 16 Nov 2023 06:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjKPFWb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Nov 2023 00:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjKPFWa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Nov 2023 00:22:30 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC50E1A3
        for <linux-pci@vger.kernel.org>; Wed, 15 Nov 2023 21:22:25 -0800 (PST)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EE3AD3FDEC
        for <linux-pci@vger.kernel.org>; Thu, 16 Nov 2023 05:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1700112144;
        bh=fr9ynEVsHoa7ae6x3+SEy8aQYynppv18RGOoPksmpuo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ZOd9sezC5ahaMtZGgLIb3wXG0t6Pi1n9aSm+Y6OBBOqajl/moKGkxZP6mbWCqn1RA
         axNeI9336x8u2XDY3c+i0zM72qCWYhE/NmT8xJvzQ2qk206zkNislfF7I9oUWOYHsK
         xls/PuDj8FYQTIaUkP2gAPUC2Uv/2lv4yuwGM1kaiDq6Y7wV4YOnzjHfqWMAz9yzHN
         Sv1XujpBt/OqacS7XXDzEKsY2YejDZacPEfys7XSWsz4wZOTZB52wdElTnHC3TOJGr
         5Y0C4V5dch2oBkXqQDk5laAfsOcOj2lB0APuohNIqScohQy8+vJnKIXko/c+90Gd+M
         Z4ywfneMPSFYg==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-28043db47ebso447984a91.1
        for <linux-pci@vger.kernel.org>; Wed, 15 Nov 2023 21:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700112142; x=1700716942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fr9ynEVsHoa7ae6x3+SEy8aQYynppv18RGOoPksmpuo=;
        b=LfFCRxRFgfv2Eny4mh1LTt93pjoD3sRp1Sp5B6xDyNUHlos2R/m3LH+1Q541DJ0j7p
         f2ylhfWthhw2tKeDWstw2rOucn7RXPyYmro4UyBkYs9er6zF1z3eUCLyZOflPLj1srrG
         TtRsEGkhFpZCRpDpvzuOFaFDlQ1qVdvqK0lp4jd4s/+cu6+eAXLWotf0ZW8qyqmd2OJ+
         MRzkLfNoLs5QtTlr0Lir6XWGaamFqAJz5SZB4mnf/GqICXrH3d85/tvbJdrMCCfBKBe0
         g3mASams07msG3mTKD8qhAsRwOc/VDFEt7BMuWmzMHuP93QYHEFap3dTaRFJ/bJO6b/M
         0P0g==
X-Gm-Message-State: AOJu0YzQaCYjSzON7ErPo76AgVEq9FGUFC/2hFMrxVDO4GnKFqZUiWw9
        Z1nB8l7dtNAglFwGgrWP6WVxUO7eVLYezt9IPIFjtC8mytjPU0gxZvadA1O7e21L0lu3Rna4jFn
        R4PhjUjH8e84ETM1u/zfPSNuPZ0VLvc9IedNrth9d+OW67/Dfjd322Q==
X-Received: by 2002:a17:90b:38c8:b0:280:15a3:89c3 with SMTP id nn8-20020a17090b38c800b0028015a389c3mr12951089pjb.27.1700112142221;
        Wed, 15 Nov 2023 21:22:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLC/4acj0McErWz60wZejZap8B3iqii7Bt//IL+u/LsPxNLf+dbpSHr4r38hr46JezIPdNZztQhciZUIS2ZCc=
X-Received: by 2002:a17:90b:38c8:b0:280:15a3:89c3 with SMTP id
 nn8-20020a17090b38c800b0028015a389c3mr12951075pjb.27.1700112141806; Wed, 15
 Nov 2023 21:22:21 -0800 (PST)
MIME-Version: 1.0
References: <20231016040132.23824-1-kai.heng.feng@canonical.com>
 <20231016093210.GA22952@wunner.de> <263982e90fc046cf977ecb8727003690@realtek.com>
 <20231018094435.GA21090@wunner.de> <02ee7e47166a463d8d4e491b61cdd33f@realtek.com>
 <20231019143504.GA25140@wunner.de> <CAAd53p7jx=_Yh8sPwdsu-6Bc-hNgiExscMNGhgcbH=rzOBMOXQ@mail.gmail.com>
 <d7cc9e658b114da7a9c32b383f06adc9@realtek.com>
In-Reply-To: <d7cc9e658b114da7a9c32b383f06adc9@realtek.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 16 Nov 2023 13:22:09 +0800
Message-ID: <CAAd53p6bRnhGOfLHBz4WyTQVKocZPK0d5m4oRdeLhWxkx-5tLw@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Prevent child devices from doing RPM on PCIe
 Link Down
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ricky,

On Fri, Nov 10, 2023 at 10:41=E2=80=AFAM Ricky WU <ricky_wu@realtek.com> wr=
ote:
>
> > Hi Lukas and Ricky,
> >
> > I think the following approach should cover all the cases?
> > Ricky, can you please give it a try?
> >
>
> This patch is invalid for this issue,
> Problem reappears after plugging and unplugging twice
> Dmesg as below,

My bad. The pm_runtime_barrier() should be called earlier.
Can you please give the following a try:

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index d749ea8250d6..c69b4ce5dbfd 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/pci.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include "pci.h"

 static void pci_free_resources(struct pci_dev *dev)
@@ -18,6 +19,7 @@ static void pci_stop_dev(struct pci_dev *dev)
  pci_pme_active(dev, false);

  if (pci_dev_is_added(dev)) {
+ pm_runtime_barrier(&dev->dev);

  device_release_driver(&dev->dev);
  pci_proc_detach_device(dev);


> [...]
> [  360.771161] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> [  360.771165] pcieport 0000:00:1c.0: pciehp: Slot(8): Card not present
> [  361.986932] pcieport 0000:00:1c.0: pciehp: Slot(8): Card present
> [  361.986937] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Up
> [  362.120635] pci 0000:01:00.0: [15b7:5007] type 00 class 0x010802
> [  362.120691] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64b=
it]
> [  362.120747] pci 0000:01:00.0: reg 0x20: [mem 0x00000000-0x000000ff 64b=
it]
> [  362.121606] pci 0000:01:00.0: BAR 0: assigned [mem 0xa3b00000-0xa3b03f=
ff 64bit]
> [  362.121646] pci 0000:01:00.0: BAR 4: assigned [mem 0xa3b04000-0xa3b040=
ff 64bit]
> [  362.121686] pcieport 0000:00:1c.0: PCI bridge to [bus 01]
> [  362.121702] pcieport 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
> [  362.121743] pcieport 0000:00:1c.0:   bridge window [mem 0xa3b00000-0xa=
44fffff]
> [  362.121761] pcieport 0000:00:1c.0:   bridge window [mem 0xa0a00000-0xa=
13fffff 64bit pref]
> [  362.171709] nvme nvme0: pci function 0000:01:00.0
> [  362.171726] nvme 0000:01:00.0: enabling device (0000 -> 0002)
> [  362.256724] nvme nvme0: 4/0/0 default/read/poll queues
> [  362.261656]  nvme0n1: p1 p2
> [  369.343246] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> [  369.457450] pcieport 0000:00:1c.0: pciehp: Slot(8): Card present
> [  369.457462] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Up
> [  369.592600] pci 0000:01:00.0: [10ec:5261] type 00 class 0xff0000
> [  369.592654] pci 0000:01:00.0: reg 0x10: [mem 0xa3b00000-0xa3b00fff]
> [  369.592776] pci 0000:01:00.0: Upstream bridge's Max Payload Size set t=
o 128 (was 256, max 256)
> [  369.592797] pci 0000:01:00.0: Max Payload Size set to 128 (was 128, ma=
x 128)
> [  369.592964] pci 0000:01:00.0: supports D1 D2
> [  369.592970] pci 0000:01:00.0: PME# supported from D1 D2 D3hot D3cold
> [  369.593642] pci 0000:01:00.0: BAR 0: assigned [mem 0xa3b00000-0xa3b00f=
ff]
> [  369.593662] pcieport 0000:00:1c.0: PCI bridge to [bus 01]
> [  369.593679] pcieport 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
> [  369.593692] pcieport 0000:00:1c.0:   bridge window [mem 0xa3b00000-0xa=
44fffff]
> [  369.593703] pcieport 0000:00:1c.0:   bridge window [mem 0xa0a00000-0xa=
13fffff 64bit pref]
> [  372.573757] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> [  372.586620] BUG: unable to handle page fault for address: ffffc9000008=
9010
> [  372.586624] #PF: supervisor read access in kernel mode
> [  372.586626] #PF: error_code(0x0000) - not-present page
> [  372.586627] PGD 100000067 P4D 100000067 PUD 10020a067 PMD 10020b067 PT=
E 0
> [  372.586632] Oops: 0000 [#1] PREEMPT SMP PTI
> [  372.586634] CPU: 2 PID: 157 Comm: kworker/2:2 Not tainted 6.6.0-rc4 #1=
2
> [  372.586637] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.=
M./H370M Pro4, BIOS P3.40 10/25/2018
> [  372.586639] Workqueue: pm pm_runtime_work
> [  372.586644] RIP: 0010:ioread32+0x2e/0x70
> [  372.586647] Code: ff 03 00 77 25 48 81 ff 00 00 01 00 77 14 8b 15 98 a=
c 52 01 b8 ff ff ff ff 85 d2 75 14 c3 cc cc cc cc 89 fa ed c3 cc cc cc cc <=
8b> 07 c3 cc cc cc cc 55 83 ea 01 48 89 fe 48 c7 c7 f8 97 57 86 48
> [  372.586649] RSP: 0018:ffffc90000543d50 EFLAGS: 00010296
> [  372.586652] RAX: ffffc90000089000 RBX: 000000000000032f RCX: 000000000=
000007f
> [  372.586653] RDX: 000000000000ff00 RSI: ffffc90000089010 RDI: ffffc9000=
0089010
> [  372.586655] RBP: ffffc90000543d70 R08: ffffc90000089010 R09: ffff88816=
a132368
> [  372.586656] R10: 0000000000000000 R11: 0000000000000003 R12: 000000000=
000007f
> [  372.586657] R13: ffff8881060ed000 R14: ffff8881060ed100 R15: 000000000=
0009003
> [  372.586659] FS:  0000000000000000(0000) GS:ffff88816a100000(0000) knlG=
S:0000000000000000
> [  372.586661] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  372.586662] CR2: ffffc90000089010 CR3: 0000000043032006 CR4: 000000000=
03706e0
> [  372.586664] Call Trace:
> [  372.586665]  <TASK>
> [  372.586667]  ? show_regs+0x68/0x70
> [  372.586671]  ? __die_body+0x20/0x70
> [  372.586674]  ? __die+0x2b/0x40
> [  372.586677]  ? page_fault_oops+0x160/0x480
> [  372.586680]  ? search_bpf_extables+0x63/0x90
> [  372.586684]  ? ioread32+0x2e/0x70
> [  372.586686]  ? search_exception_tables+0x5f/0x70
> [  372.586689]  ? kernelmode_fixup_or_oops+0xa2/0x120
> [  372.586692]  ? __bad_area_nosemaphore+0x179/0x230
> [  372.586696]  ? bad_area_nosemaphore+0x16/0x20
> [  372.586698]  ? do_kern_addr_fault+0x8b/0xa0
> [  372.586701]  ? exc_page_fault+0xe5/0x180
> [  372.586705]  ? asm_exc_page_fault+0x27/0x30
> [  372.586710]  ? ioread32+0x2e/0x70
> [  372.586714]  ? rtsx_pci_write_register+0x5b/0x90 [rtsx_pci]
> [  372.586723]  rtsx_set_l1off_sub+0x1c/0x30 [rtsx_pci]
> [  372.586731]  rts5261_set_l1off_cfg_sub_d0+0x36/0x40 [rtsx_pci]
> [  372.586740]  rtsx_pci_runtime_idle+0xc7/0x160 [rtsx_pci]
> [  372.586748]  ? __pfx_pci_pm_runtime_idle+0x10/0x10
> [  372.586751]  pci_pm_runtime_idle+0x34/0x70
> [  372.586753]  rpm_idle+0xc4/0x2b0
> [  372.586756]  pm_runtime_work+0x93/0xc0
> [  372.586759]  process_scheduled_works+0x9a/0x390
> [  372.586762]  ? __pfx_worker_thread+0x10/0x10
> [  372.586764]  worker_thread+0x15b/0x2d0
> [  372.586767]  ? __pfx_worker_thread+0x10/0x10
> [  372.586769]  kthread+0x106/0x140
> [  372.586771]  ? __pfx_kthread+0x10/0x10
> [  372.586774]  ret_from_fork+0x39/0x60
> [  372.586776]  ? __pfx_kthread+0x10/0x10
> [  372.586778]  ret_from_fork_asm+0x1b/0x30
> [  372.586783]  </TASK>
> [  372.586784] Modules linked in: nvme nvme_core snd_hda_codec_hdmi snd_h=
da_codec_realtek snd_hda_codec_generic ledtrig_audio nls_iso8859_1 snd_sof_=
pci_intel_cnl snd_sof_intel_hda_common snd_soc_hdac_hda soundwire_intel sou=
ndwire_generic_allocation snd_sof_intel_hda_mlink soundwire_cadence snd_sof=
_intel_hda snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_hda_ext=
_core snd_soc_acpi_intel_match snd_soc_acpi soundwire_bus intel_rapl_msr in=
tel_rapl_common snd_soc_core x86_pkg_temp_thermal intel_powerclamp coretemp=
 snd_compress ac97_bus kvm_intel snd_pcm_dmaengine i915 snd_hda_intel snd_i=
ntel_dspcfg snd_intel_sdw_acpi kvm snd_hda_codec snd_hda_core mei_hdcp crct=
10dif_pclmul ghash_clmulni_intel snd_hwdep snd_pcm sha512_ssse3 aesni_intel=
 snd_seq_midi crypto_simd snd_seq_midi_event cryptd rapl snd_rawmidi intel_=
cstate drm_buddy binfmt_misc ttm snd_seq drm_display_helper joydev input_le=
ds cec snd_seq_device wmi_bmof snd_timer ee1004 mei_me rc_core snd drm_kms_=
helper mei intel_pch_thermal i2c_algo_bit soundcore mac_hid
> [  372.586834]  acpi_tad acpi_pad sch_fq_codel msr parport_pc ppdev lp pa=
rport drm ramoops reed_solomon efi_pstore ip_tables x_tables autofs4 hid_ge=
neric usbhid hid rtsx_pci_sdmmc ahci i2c_i801 e1000e crc32_pclmul rtsx_pci =
i2c_smbus xhci_pci libahci xhci_pci_renesas video wmi
> [  372.586856] CR2: ffffc90000089010
> [  372.586858] ---[ end trace 0000000000000000 ]---
> [  372.746808] RIP: 0010:ioread32+0x2e/0x70
> [  372.746816] Code: ff 03 00 77 25 48 81 ff 00 00 01 00 77 14 8b 15 98 a=
c 52 01 b8 ff ff ff ff 85 d2 75 14 c3 cc cc cc cc 89 fa ed c3 cc cc cc cc <=
8b> 07 c3 cc cc cc cc 55 83 ea 01 48 89 fe 48 c7 c7 f8 97 57 86 48
> [  372.746818] RSP: 0018:ffffc90000543d50 EFLAGS: 00010296
> [  372.746821] RAX: ffffc90000089000 RBX: 000000000000032f RCX: 000000000=
000007f
> [  372.746823] RDX: 000000000000ff00 RSI: ffffc90000089010 RDI: ffffc9000=
0089010
> [  372.746825] RBP: ffffc90000543d70 R08: ffffc90000089010 R09: ffff88816=
a132368
> [  372.746826] R10: 0000000000000000 R11: 0000000000000003 R12: 000000000=
000007f
> [  372.746828] R13: ffff8881060ed000 R14: ffff8881060ed100 R15: 000000000=
0009003
> [  372.746830] FS:  0000000000000000(0000) GS:ffff88816a100000(0000) knlG=
S:0000000000000000
> [  372.746832] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  372.746833] CR2: ffffc90000089010 CR3: 000000010a564004 CR4: 000000000=
03706e0
> [  372.746835] note: kworker/2:2[157] exited with irqs disabled
>
> > diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c index
> > d749ea8250d6..907d60587227 100644
> > --- a/drivers/pci/remove.c
> > +++ b/drivers/pci/remove.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <linux/pci.h>
> >  #include <linux/module.h>
> > +#include <linux/pm_runtime.h>
> >  #include "pci.h"
> >
> >  static void pci_free_resources(struct pci_dev *dev) @@ -89,6 +90,8 @@
> > static void pci_remove_bus_device(struct pci_dev *dev)
> >         struct pci_bus *bus =3D dev->subordinate;
> >         struct pci_dev *child, *tmp;
> >
> > +       pm_runtime_barrier(&dev->dev);
> > +
> >         if (bus) {
> >                 list_for_each_entry_safe(child, tmp,
> >                                          &bus->devices, bus_list)
> >
> >
>
