Return-Path: <linux-pci+bounces-4429-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCB8870457
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 15:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C741C20C62
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 14:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBF945C14;
	Mon,  4 Mar 2024 14:38:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B1741775;
	Mon,  4 Mar 2024 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709563132; cv=none; b=qJK0ZOd8cKQZzn7Pjv/loOpQ1imkW4inPSHQFsC/7YlcTKMOmQkBB280WpWfcSrUc+dI5Hmd/e67g+AEApOv185SjiA5V+7AKei+JNcdojUPmMY9nSDrjzhR/eDR/jqsUddzH+VvdRY+owZirgR5IeAfvoc1E+HYUqJYzfzGC7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709563132; c=relaxed/simple;
	bh=rhQCSPu6mcc8XXUwVN2mBNHh4E974r1nCbbZw61JAqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRmzdRxm3LytlXrinT1JFsgZCMxlk/8nIySB0vgpie16x/tNNiXzqXs/wNXhf3Gjios31N2v8ofEZjRYVUkmR4PVFYWseoOevlOZTMUr9QVYRS3KIQml0HYc/un0y9iN+qlZ/XaUPRIOI5omJF2nrpZJOuFsomTJBh4cgr7Px7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a12c00535dso20336eaf.1;
        Mon, 04 Mar 2024 06:38:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709563130; x=1710167930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofTq2zKY4bfnoJNRVZUW1kyLP6uW7hH/ZcSsKKkYj38=;
        b=ivadzsuTAIRPpqdlO9lnacZNfAhIsISQm0F0sGTYLlOHOwpc8PZq3kqhy8QBd8UAQP
         lsVtm7kT6GytvA7V8OAOLAi47//N+91nUgUr1X23BhDCGQp9lxJmyW/4Sw6yyn3KBHoU
         syFCjeJrjQ+eGDgk5sAR0Ct9OUftSp63vrDyfQIGSJXXefNqp8D8Q4jzZrelpXlPcuOx
         HIuTxB2YgJkA7ReXSxUwKzAFPlb4Uh74cB+mbfUSwTztYr+M378O2MGBGK5HR/TcT7sq
         EsNu2FwIc6qfc13AvkuunIMOftn0uW7jtk5TbleVooy9cxo67p4YL80f2VQfgJAAobPF
         1BMA==
X-Forwarded-Encrypted: i=1; AJvYcCVvcP74Qhh33SNWEt5MMRAOo9qFqgPd+NjgWWg5yQHOC6L71qdJf+Ijolaapuy/1Rtd8CvGsuO36tdHwOdZ65/+LSBnhpp1fu7yOnHWoVWPstZywyAWCY8fp4ZrU6ygRSQ2VcshTofTKAHYuTjqh3tDuGLCKPfBguNpAgig0CokXMHq1Wan6QBjHWIi2TVynz/5ONw8HYd9KueIhPYB
X-Gm-Message-State: AOJu0Yz7WY648uTKVW6igjeJQxzoo11wBZ2OqpAbLvxcMKQXYf1Nrnqf
	3XwWQfz0Zyi+p05/quTrU7ihA/a9aWFI9MYSPuD1Qz7oIesIYY1xuwRH4Sy97EhJrpnAku0s092
	8JkyUlXZ5otx+rrGhLqOHhvH9/3g=
X-Google-Smtp-Source: AGHT+IFtrXsRrJJ824rbc3zaIiVGz6OjQyruiv9UXoJLimYFAUSK5VEE6mo0fjREsKclUaFgAkqRAOektuu8HkLWeWY=
X-Received: by 2002:a05:6820:611:b0:5a1:2cfe:1585 with SMTP id
 e17-20020a056820061100b005a12cfe1585mr4587616oow.1.1709563130267; Mon, 04 Mar
 2024 06:38:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229062201.49500-1-kai.heng.feng@canonical.com>
In-Reply-To: <20240229062201.49500-1-kai.heng.feng@canonical.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 4 Mar 2024 15:38:38 +0100
Message-ID: <CAJZ5v0grDNJkEcgw+34SBmNFL7qhSTz8ydC7BSkM7DiCatkKSA@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: Cancel scheduled pm_runtime_idle() on
 device removal
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ricky Wu <ricky_wu@realtek.com>, Kees Cook <keescook@chromium.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	linux-hardening@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 7:23=E2=80=AFAM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> When inserting an SD7.0 card to Realtek card reader, the card reader
> unplugs itself and morph into a NVMe device. The slot Link down on hot
> unplugged can cause the following error:
>
> pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> BUG: unable to handle page fault for address: ffffb24d403e5010
> PGD 100000067 P4D 100000067 PUD 1001fe067 PMD 100d97067 PTE 0
> Oops: 0000 [#1] PREEMPT SMP PTI
> CPU: 3 PID: 534 Comm: kworker/3:10 Not tainted 6.4.0 #6
> Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./H370M Pro4, =
BIOS P3.40 10/25/2018
> Workqueue: pm pm_runtime_work
> RIP: 0010:ioread32+0x2e/0x70
> Code: ff 03 00 77 25 48 81 ff 00 00 01 00 77 14 8b 15 08 d9 54 01 b8 ff f=
f ff ff 85 d2 75 14 c3 cc cc cc cc 89 fa ed c3 cc cc cc cc <8b> 07 c3 cc cc=
 cc cc 55 83 ea 01 48 89 fe 48 c7 c7 98 6f 15 99 48
> RSP: 0018:ffffb24d40a5bd78 EFLAGS: 00010296
> RAX: ffffb24d403e5000 RBX: 0000000000000152 RCX: 000000000000007f
> RDX: 000000000000ff00 RSI: ffffb24d403e5010 RDI: ffffb24d403e5010
> RBP: ffffb24d40a5bd98 R08: ffffb24d403e5010 R09: 0000000000000000
> R10: ffff9074cd95e7f4 R11: 0000000000000003 R12: 000000000000007f
> R13: ffff9074e1a68c00 R14: ffff9074e1a68d00 R15: 0000000000009003
> FS:  0000000000000000(0000) GS:ffff90752a180000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffb24d403e5010 CR3: 0000000152832006 CR4: 00000000003706e0
> Call Trace:
>  <TASK>
>  ? show_regs+0x68/0x70
>  ? __die_body+0x20/0x70
>  ? __die+0x2b/0x40
>  ? page_fault_oops+0x160/0x480
>  ? search_bpf_extables+0x63/0x90
>  ? ioread32+0x2e/0x70
>  ? search_exception_tables+0x5f/0x70
>  ? kernelmode_fixup_or_oops+0xa2/0x120
>  ? __bad_area_nosemaphore+0x179/0x230
>  ? bad_area_nosemaphore+0x16/0x20
>  ? do_kern_addr_fault+0x8b/0xa0
>  ? exc_page_fault+0xe5/0x180
>  ? asm_exc_page_fault+0x27/0x30
>  ? ioread32+0x2e/0x70
>  ? rtsx_pci_write_register+0x5b/0x90 [rtsx_pci]
>  rtsx_set_l1off_sub+0x1c/0x30 [rtsx_pci]
>  rts5261_set_l1off_cfg_sub_d0+0x36/0x40 [rtsx_pci]
>  rtsx_pci_runtime_idle+0xc7/0x160 [rtsx_pci]
>  ? __pfx_pci_pm_runtime_idle+0x10/0x10
>  pci_pm_runtime_idle+0x34/0x70
>  rpm_idle+0xc4/0x2b0
>  pm_runtime_work+0x93/0xc0
>  process_one_work+0x21a/0x430
>  worker_thread+0x4a/0x3c0
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0x106/0x140
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x29/0x50
>  </TASK>
> Modules linked in: nvme nvme_core snd_hda_codec_hdmi snd_sof_pci_intel_cn=
l snd_sof_intel_hda_common snd_hda_codec_realtek snd_hda_codec_generic snd_=
soc_hdac_hda soundwire_intel ledtrig_audio nls_iso8859_1 soundwire_generic_=
allocation soundwire_cadence snd_sof_intel_hda_mlink snd_sof_intel_hda snd_=
sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_hda_ext_core snd_soc_a=
cpi_intel_match snd_soc_acpi soundwire_bus snd_soc_core snd_compress ac97_b=
us snd_pcm_dmaengine snd_hda_intel i915 snd_intel_dspcfg snd_intel_sdw_acpi=
 intel_rapl_msr snd_hda_codec intel_rapl_common snd_hda_core x86_pkg_temp_t=
hermal intel_powerclamp snd_hwdep coretemp snd_pcm kvm_intel drm_buddy ttm =
mei_hdcp kvm drm_display_helper snd_seq_midi snd_seq_midi_event cec crct10d=
if_pclmul ghash_clmulni_intel sha512_ssse3 aesni_intel crypto_simd rc_core =
cryptd rapl snd_rawmidi drm_kms_helper binfmt_misc intel_cstate i2c_algo_bi=
t joydev snd_seq snd_seq_device syscopyarea wmi_bmof snd_timer sysfillrect =
input_leds snd ee1004 sysimgblt mei_me soundcore
>  mei intel_pch_thermal mac_hid acpi_tad acpi_pad sch_fq_codel msr parport=
_pc ppdev lp ramoops drm parport reed_solomon efi_pstore ip_tables x_tables=
 autofs4 hid_generic usbhid hid rtsx_pci_sdmmc crc32_pclmul ahci e1000e i2c=
_i801 i2c_smbus rtsx_pci xhci_pci libahci xhci_pci_renesas video wmi
> CR2: ffffb24d403e5010
> ---[ end trace 0000000000000000 ]---
>
> This happens because scheduled pm_runtime_idle() is not cancelled.

But rpm_resume() changes dev->power.request to RPM_REQ_NONE and if
pm_runtime_work() sees this, it will not run rpm_idle().

However, rpm_resume() doesn't deactivate the autosuspend timer if it
is running (see the comment in rpm_resume() regarding this), so it may
queue up a runtime PM work later.

If this is not desirable, you need to stop the autosuspend timer
explicitly in addition to calling pm_runtime_get_sync().

> So before releasing the device, stop all runtime power managements by
> using pm_runtime_barrier() to fix the issue.
>
> Link: https://lore.kernel.org/all/2ce258f371234b1f8a1a470d5488d00e@realte=
k.com/
> Cc: Ricky Wu <ricky_wu@realtek.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v3:
>   Move the change the device driver core.
>
> v2:
>   Cover more cases than just pciehp.
>
>  drivers/base/dd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 85152537dbf1..38c815e2b3a2 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -1244,6 +1244,7 @@ static void __device_release_driver(struct device *=
dev, struct device *parent)
>
>         drv =3D dev->driver;
>         if (drv) {
> +               pm_runtime_barrier(dev);

This prevents the crash from occurring because pm_runtime_barrier()
calls pm_runtime_deactivate_timer() unconditionally AFAICS.

>
>                 while (device_links_busy(dev)) {
> --

Overall, the issue appears to be in the driver that forgets to
deactivate the autosuspend timer in its remove callback.

