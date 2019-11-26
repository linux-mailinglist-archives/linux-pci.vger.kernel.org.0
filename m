Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D161710A6F0
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2019 00:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfKZXKo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Nov 2019 18:10:44 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37289 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726984AbfKZXKo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2019 18:10:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574809843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UV/NQ5f0seWf1WcGiet+f3Jl6IUuzX9/tcYHoRhFa38=;
        b=IfaOema3tiv1fgAcbQGAvPmfhXDqxU3/nwK4AYrzAJDoj55pngDIm7navNo4837NhYN5ij
        aS410JlD+nJrS/fyui7F2GOtDNmnqe23LwbpSCwkpIdI5IKJtEIxRLacewn3SlxE0JmuQ3
        E6v7N+pYJAsBRCAAdcMdaQiTLE7sLLo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-MJQGrHOqN0iNmnw6r9EmIA-1; Tue, 26 Nov 2019 18:10:42 -0500
Received: by mail-qt1-f197.google.com with SMTP id f31so13602960qta.0
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2019 15:10:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=UV/NQ5f0seWf1WcGiet+f3Jl6IUuzX9/tcYHoRhFa38=;
        b=PELntV8j2EtSR/K2ba9v1XDhkmAsnCANa/Q9ng4jw/pfQZ6DuvXOGiECHHzCgyyP7E
         qy6vGkw7ZljAhc9Xl/cR4h/W3hqh+ex7ipSrMI0CYN9Kh6QowK8vKaJCiSR42dOkVKi9
         wrvZFpRHbx6QxsECw7lJpkSAwoolMrv/P6oR3lZV8x3U3QciL6iYUDnEGI70p2rN5xv9
         JF07i/XC60a7Ua1IG51RsL4yGcq6pgN1hWLJ9og0wKqDfyYB+/LcjlIG4s98fwahmdfr
         tqri3JAJa79HnLH8TmwnnY8nQd6WuioO5DeMljv4d/6c/vqy8iK+z+3Ir8GoLTRBnhrX
         uSjQ==
X-Gm-Message-State: APjAAAUKzsm+UP2cb95TcWe9No/ywwzjdkuL41MHse1qIKZ8qHUFTBsK
        bVHg/k7hTg3zL54UkIEFekSP4yJ9K+ClvkQL6zBaGJA91xvlyIM4em8mopiQpg//KV+osQjEGYo
        O0hP/hRu9QADX68oc41t0
X-Received: by 2002:a37:8a05:: with SMTP id m5mr982372qkd.181.1574809839602;
        Tue, 26 Nov 2019 15:10:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqznyM00BT7/k/MdWTTGUiiaeayBJLR99zKoLo7NNmQtMjgBk3fcXO+bjDTRndnJbHifOoRjog==
X-Received: by 2002:a37:8a05:: with SMTP id m5mr982327qkd.181.1574809839106;
        Tue, 26 Nov 2019 15:10:39 -0800 (PST)
Received: from dhcp-10-20-1-90.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id a3sm5751585qkf.76.2019.11.26.15.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 15:10:37 -0800 (PST)
Message-ID: <e0eeddf4214f54dfac08e428dfb30cbd39f20680.camel@redhat.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
From:   Lyude Paul <lyude@redhat.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Karol Herbst <kherbst@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
Date:   Tue, 26 Nov 2019 18:10:36 -0500
In-Reply-To: <CAJZ5v0jbh7jz+YQcw-gC5ztmMOc4E9+KFBCy4VGRsRFxBw-gnw@mail.gmail.com>
References: <20191120120913.GE11621@lahna.fi.intel.com>
         <CACO55tsHy6yZQZ8PkdW8iPA7+uc5rdcEwRJwYEQ3iqu85F8Sqg@mail.gmail.com>
         <20191120151542.GH11621@lahna.fi.intel.com>
         <CACO55tvo3rbPtYJcioEgXCEQqVXcVAm-iowr9Nim=bgTdMjgLw@mail.gmail.com>
         <20191120155301.GL11621@lahna.fi.intel.com>
         <CAJZ5v0hkT-fHFOQKzp2qYPyR+NUa4c-G-uGLPZuQxqsG454PiQ@mail.gmail.com>
         <CACO55ttTPi2XpRRM_NYJU5c5=OvG0=-YngFy1BiR8WpHkavwXw@mail.gmail.com>
         <CAJZ5v0h=7zu3A+ojgUSmwTH0KeXmYP5OKDL__rwkkWaWqcJcWQ@mail.gmail.com>
         <20191121112821.GU11621@lahna.fi.intel.com>
         <CAJZ5v0hQhj5Wf+piU11abC4pF26yM=XHGHAcDv8Jsgdx04aN-w@mail.gmail.com>
         <20191121114610.GW11621@lahna.fi.intel.com>
         <CACO55ttXJgXG32HzYP_uJDfQ6T-d8zQaGjXK_AZD3kF0Rmft4g@mail.gmail.com>
         <CAJZ5v0ibzcLEm44udUxW2uVgaF9NapdNBF8Ag+RE++u7gi2yNA@mail.gmail.com>
         <CACO55ttBkZD9dm0Y_jT931NnzHHtDFyLz28aoo+ZG0pnLzPgbA@mail.gmail.com>
         <CAJZ5v0jbh7jz+YQcw-gC5ztmMOc4E9+KFBCy4VGRsRFxBw-gnw@mail.gmail.com>
Organization: Red Hat
User-Agent: Evolution 3.34.1 (3.34.1-1.fc31)
MIME-Version: 1.0
X-MC-Unique: MJQGrHOqN0iNmnw6r9EmIA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[big snip]
> There is a sysfs attribute called "d3cold_allowed" which can be used
> for "blocking" D3cold, so can you please retest using that?
> 

Hey-this is almost certainly not the right place in this thread to respond,
but this thread has gotten so deep evolution can't push the subject further to
the right, heh. So I'll just respond here.

I've been following this and helping out Karol with testing here and there.
They had me test Bjorn's PCI branch on the X1 Extreme 2nd generation, which
has a turing GPU and 8086:1901 PCI bridge.

I was about to say "the patch fixed things, hooray!" but it seems that after
trying runtime suspend/resume a couple times things fall apart again:

[   27.680433] nouveau 0000:01:00.0: enabling device (0000 -> 0003)
[   27.680578] nouveau 0000:01:00.0: NVIDIA TU117 (167000a1)
[   27.763967] nouveau 0000:01:00.0: bios: version 90.17.20.00.16
[   27.764664] nouveau 0000:01:00.0: fb: 4096 MiB GDDR5
[   27.806115] vga_switcheroo: enabled
[   27.806221] [TTM] Zone  kernel: Available graphics memory: 16244510 KiB
[   27.806222] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
[   27.806222] [TTM] Initializing pool allocator
[   27.806224] [TTM] Initializing DMA pool allocator
[   27.806249] nouveau 0000:01:00.0: DRM: VRAM: 4096 MiB
[   27.806249] nouveau 0000:01:00.0: DRM: GART: 536870912 MiB
[   27.806250] nouveau 0000:01:00.0: DRM: BIT table 'A' not found
[   27.806251] nouveau 0000:01:00.0: DRM: BIT table 'L' not found
[   27.806251] nouveau 0000:01:00.0: DRM: TMDS table version 2.0
[   27.806252] nouveau 0000:01:00.0: DRM: DCB version 4.1
[   27.806253] nouveau 0000:01:00.0: DRM: DCB outp 00: 02800f66 04600020
[   27.806253] nouveau 0000:01:00.0: DRM: DCB outp 01: 02011f52 00020010
[   27.806254] nouveau 0000:01:00.0: DRM: DCB outp 02: 01022f36 04600010
[   27.806254] nouveau 0000:01:00.0: DRM: DCB outp 03: 01033f46 04600020
[   27.806255] nouveau 0000:01:00.0: DRM: DCB conn 00: 00020047
[   27.806255] nouveau 0000:01:00.0: DRM: DCB conn 01: 00010161
[   27.806256] nouveau 0000:01:00.0: DRM: DCB conn 02: 00001248
[   27.806256] nouveau 0000:01:00.0: DRM: DCB conn 03: 00002348
[   27.806257] nouveau 0000:01:00.0: DRM: Pointer to flat panel table invalid
[   27.806415] nouveau 0000:01:00.0: DRM: failed to create kernel channel, -22
[   27.806530] nouveau 0000:01:00.0: DRM: MM: using COPY for buffer copies
[   28.114808] nouveau 0000:01:00.0: DRM: unknown connector type 48
[   28.114943] nouveau 0000:01:00.0: DRM: unknown connector type 48
[   28.115026] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   28.115027] [drm] Driver supports precise vblank timestamp query.
[   28.116611] [drm] Cannot find any crtc or sizes
[   28.117452] [drm] Initialized nouveau 1.3.1 20120801 for 0000:01:00.0 on minor 1
[   28.118074] [drm] Cannot find any crtc or sizes
[   28.119523] [drm] Cannot find any crtc or sizes
[   34.081503] nouveau 0000:01:00.0: DRM: suspending console...
[   34.081508] nouveau 0000:01:00.0: DRM: suspending display...
[   34.081528] nouveau 0000:01:00.0: DRM: evicting buffers...
[   34.081531] nouveau 0000:01:00.0: DRM: waiting for kernel channels to go idle...
[   34.081551] nouveau 0000:01:00.0: DRM: suspending fence...
[   34.091173] nouveau 0000:01:00.0: DRM: suspending object tree...
[   37.729746] nouveau 0000:01:00.0: DRM: resuming object tree...
[   38.042076] nouveau 0000:01:00.0: DRM: resuming fence...
[   38.042167] nouveau 0000:01:00.0: DRM: resuming display...
[   38.042175] nouveau 0000:01:00.0: DRM: resuming console...
[   44.309325] nouveau 0000:01:00.0: DRM: suspending console...
[   44.309331] nouveau 0000:01:00.0: DRM: suspending display...
[   44.309349] nouveau 0000:01:00.0: DRM: evicting buffers...
[   44.309352] nouveau 0000:01:00.0: DRM: waiting for kernel channels to go idle...
[   44.309371] nouveau 0000:01:00.0: DRM: suspending fence...
[   44.318938] nouveau 0000:01:00.0: DRM: suspending object tree...
[   76.577644] nouveau 0000:01:00.0: DRM: resuming object tree...
[   76.890266] nouveau 0000:01:00.0: DRM: resuming fence...
[   76.890362] nouveau 0000:01:00.0: DRM: resuming display...
[   76.890379] nouveau 0000:01:00.0: DRM: resuming console...
[   82.721356] nouveau 0000:01:00.0: DRM: suspending console...
[   82.721361] nouveau 0000:01:00.0: DRM: suspending display...
[   82.721380] nouveau 0000:01:00.0: DRM: evicting buffers...
[   82.721383] nouveau 0000:01:00.0: DRM: waiting for kernel channels to go idle...
[   82.721403] nouveau 0000:01:00.0: DRM: suspending fence...
[   82.730483] nouveau 0000:01:00.0: DRM: suspending object tree...
[  681.369950] nouveau 0000:01:00.0: DRM: resuming object tree...
[  681.690464] nouveau 0000:01:00.0: DRM: resuming fence...
[  681.690555] nouveau 0000:01:00.0: DRM: resuming display...
[  681.690568] nouveau 0000:01:00.0: DRM: resuming console...
[  686.873629] nouveau 0000:01:00.0: DRM: suspending console...
[  686.873634] nouveau 0000:01:00.0: DRM: suspending display...
[  686.873653] nouveau 0000:01:00.0: DRM: evicting buffers...
[  686.873656] nouveau 0000:01:00.0: DRM: waiting for kernel channels to go idle...
[  686.873676] nouveau 0000:01:00.0: DRM: suspending fence...
[  686.883247] nouveau 0000:01:00.0: DRM: suspending object tree...
[  752.866484] ACPI Error: Aborting method \_SB.PCI0.PEG0.PEGP.NVPO due to previous error (AE_AML_LOOP_TIMEOUT) (20190816/psparse-529)
[  752.866508] ACPI Error: Aborting method \_SB.PCI0.PGON due to previous error (AE_AML_LOOP_TIMEOUT) (20190816/psparse-529)
[  752.866521] ACPI Error: Aborting method \_SB.PCI0.PEG0.PG00._ON due to previous error (AE_AML_LOOP_TIMEOUT) (20190816/psparse-529)
[  752.866542] acpi device:00: Failed to change power state to D0
[  754.209030] video LNXVIDEO:00: Cannot transition to power state D0 for parent in (unknown)
[  755.848894] nouveau 0000:01:00.0: not ready 1023ms after Switch to D0; waiting
[  756.936876] nouveau 0000:01:00.0: not ready 2047ms after Switch to D0; waiting
[  759.048849] nouveau 0000:01:00.0: not ready 4095ms after Switch to D0; waiting
[  763.208807] nouveau 0000:01:00.0: not ready 8191ms after Switch to D0; waiting
[  771.912692] nouveau 0000:01:00.0: not ready 16383ms after Switch to D0; waiting
[  788.808505] nouveau 0000:01:00.0: not ready 32767ms after Switch to D0; waiting

752.866542 is where I start trying to resume the GPU. lspci -nn:

00:00.0 Host bridge [0600]: Intel Corporation Device [8086:3e20] (rev 0d)
00:01.0 PCI bridge [0604]: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor PCIe Controller (x16) [8086:1901] (rev 0d)
00:02.0 VGA compatible controller [0300]: Intel Corporation UHD Graphics 630 (Mobile) [8086:3e9b] (rev 02)
00:04.0 Signal processing controller [1180]: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem [8086:1903] (rev 0d)
00:08.0 System peripheral [0880]: Intel Corporation Xeon E3-1200 v5/v6 / E3-1500 v5 / 6th/7th/8th Gen Core Processor Gaussian Mixture Model [8086:1911]
00:12.0 Signal processing controller [1180]: Intel Corporation Cannon Lake PCH Thermal Controller [8086:a379] (rev 10)
00:14.0 USB controller [0c03]: Intel Corporation Cannon Lake PCH USB 3.1 xHCI Host Controller [8086:a36d] (rev 10)
00:14.2 RAM memory [0500]: Intel Corporation Cannon Lake PCH Shared SRAM [8086:a36f] (rev 10)
00:15.0 Serial bus controller [0c80]: Intel Corporation Cannon Lake PCH Serial IO I2C Controller #0 [8086:a368] (rev 10)
00:16.0 Communication controller [0780]: Intel Corporation Cannon Lake PCH HECI Controller [8086:a360] (rev 10)
00:1b.0 PCI bridge [0604]: Intel Corporation Cannon Lake PCH PCI Express Root Port #17 [8086:a340] (rev f0)
00:1b.4 PCI bridge [0604]: Intel Corporation Cannon Lake PCH PCI Express Root Port #21 [8086:a32c] (rev f0)
00:1c.0 PCI bridge [0604]: Intel Corporation Cannon Lake PCH PCI Express Root Port #1 [8086:a338] (rev f0)
00:1d.0 PCI bridge [0604]: Intel Corporation Cannon Lake PCH PCI Express Root Port #9 [8086:a330] (rev f0)
00:1d.6 PCI bridge [0604]: Intel Corporation Cannon Lake PCH PCI Express Root Port #15 [8086:a336] (rev f0)
00:1e.0 Communication controller [0780]: Intel Corporation Device [8086:a328] (rev 10)
00:1f.0 ISA bridge [0601]: Intel Corporation Device [8086:a30e] (rev 10)
00:1f.3 Audio device [0403]: Intel Corporation Cannon Lake PCH cAVS [8086:a348] (rev 10)
00:1f.4 SMBus [0c05]: Intel Corporation Cannon Lake PCH SMBus Controller [8086:a323] (rev 10)
00:1f.5 Serial bus controller [0c80]: Intel Corporation Cannon Lake PCH SPI Controller [8086:a324] (rev 10)
00:1f.6 Ethernet controller [0200]: Intel Corporation Ethernet Connection (7) I219-LM [8086:15bb] (rev 10)
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation Device [10de:1f91] (rev a1)
01:00.1 Audio device [0403]: NVIDIA Corporation Device [10de:10fa] (rev a1)
02:00.0 Non-Volatile memory controller [0108]: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983 [144d:a808]
04:00.0 PCI bridge [0604]: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] [8086:15ea] (rev 06)
05:00.0 PCI bridge [0604]: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] [8086:15ea] (rev 06)
05:01.0 PCI bridge [0604]: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] [8086:15ea] (rev 06)
05:02.0 PCI bridge [0604]: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] [8086:15ea] (rev 06)
05:04.0 PCI bridge [0604]: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] [8086:15ea] (rev 06)
06:00.0 System peripheral [0880]: Intel Corporation JHL7540 Thunderbolt 3 NHI [Titan Ridge 4C 2018] [8086:15eb] (rev 06)
2c:00.0 USB controller [0c03]: Intel Corporation JHL7540 Thunderbolt 3 USB Controller [Titan Ridge 4C 2018] [8086:15ec] (rev 06)
52:00.0 Network controller [0280]: Intel Corporation Wi-Fi 6 AX200 [8086:2723] (rev 1a)
53:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS525A PCI Express Card Reader [10ec:525a] (rev 01)
-- 
Cheers,
	Lyude Paul

