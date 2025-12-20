Return-Path: <linux-pci+bounces-43467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B8052CD2F0C
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 13:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 303AA300182B
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 12:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA77B2868B5;
	Sat, 20 Dec 2025 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVuDnhwR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002D5274676
	for <linux-pci@vger.kernel.org>; Sat, 20 Dec 2025 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766235185; cv=none; b=hsUnRcZxFA26GnONdo1jCSn9TrNpxfT3kt8Pv05fxd4qMFhsIKyQ92JA3b9yqwKnS+JIGnxWNvDIGdIL4fjkr52VjGsoMv3vHA7HfvI0Moj/5Ab99C+YrvGUWuTWl7M3WGGkO7I0CDp7OlcgVNcjj9nWYuq3hntlqcEbyfeSjok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766235185; c=relaxed/simple;
	bh=PY5QEUZ84yrW7eEPBxGZ9EOts18G5r+CK8aLshItUmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pk2OY3rkUP3eeLjSHYPfGN64AEwx/iShjMRY/3kWvPDdQJ11nlKofcUThOrHFe8Xa8pctTrNwpOR6aiPLCXiq/mHmGfkzvy0MdtbqF/sHw9Ap9ixjlhHi5gLHJrcN9f2Pmj8xj0Ff5969yuNiw/dgjr0RgdMbgvNGxVYfJm0Ggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVuDnhwR; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37d13ddaa6aso19399681fa.1
        for <linux-pci@vger.kernel.org>; Sat, 20 Dec 2025 04:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766235182; x=1766839982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2D/o029XJg6GKOLuV3uuch4kHBbvpaS8vrJbhVBDdVw=;
        b=DVuDnhwRiKUhcabQEDjs6GKs+lYaDLiPAfeHoA5ffYeV6yocljdYnJDvzo+oDTCHIc
         hhAhHk7dTYuaAIFhG5lui+d4xrL3YQHiGKaRbdIUbih+GXT9eI96xbj1vkhMWPP6vupD
         b4LW/liVmoQIiSnBDRtE86ihnbOFjsPM35Md8S69jG9KzGCBqYtWX0zKKLJwmQKPIbSC
         uBud27cBVjkJZiurGy7K0rU0Ea/9qfOB+A2aE+af1KAv8ZpmDmDqdFVb2SYA25C1rhx1
         q/Qt19aAizyubNdJG01Ea3clDAadnpnsBvGmx/fBABHD7qIO+X8Bj4dDDHUnl2VEWwqB
         lY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766235182; x=1766839982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2D/o029XJg6GKOLuV3uuch4kHBbvpaS8vrJbhVBDdVw=;
        b=KESNCMHwpoJ4CZcIwkoeHnE2r6Yx6Yy7xUp7rrSGp5ao65QeE1s5qg7CjfopD2y9ul
         XwWd43JyfBeJ9zOVMnNxo1VikazaUxe2Fy4pV0vIn1Xp2pubY0yzMGGsiuzVhh70WObK
         2ek5HAGbxLNeTJsbo519y6d4IXEJDqu3NCy8D/fIk66CDan9XheYXitTW1YPbQtl0gYv
         sGSecd+knO6Ca+7H7tsky/pLhG26J0ewaSolTBLBuKxGJlYIohoDlsfFH+Y8L8/4V3Jj
         08uyrbcdws/gzl1P8FPS6D9dfFmsaapMskN9maSyj5SMpg86ixVYZBrmagu8dK2M0K6y
         84zw==
X-Forwarded-Encrypted: i=1; AJvYcCW6y76m9OE4U1M3QNScm7QQsLtVbHj70ZtrK9QFKmn8RDTleboT3Py7ceEboiohKVQ0WskSrDfyxgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrYRCu48o6nt40G7XIjZdY+wKrk90P4HmXcWtwG68vjhiZb8cL
	KH9TrJyzIu9TtXcOC2mbkVw+NaVn1zA4dN6lAQwMXuZeXOC8a1PdqxCUc349Rjdu8pE2ecB4U1D
	Q0n7GSixIvdMYvG0lLBzph0IUafh6ybnnjA==
X-Gm-Gg: AY/fxX7AiXHBYSRKs3NSKns3tpvrhRUeiZs9RE4JnwmxUa28h99MWFgDhOYa8PjwRdB
	6LBOZbo/7RNO8GvUXJYEZBOr7feUEANA7qRn/bmfD/tF9a9Stnth463YC2qh9EOhQTMduJ0+UjF
	8xzWt76ZOd4qgNirC6dRn7n5xyT+/QdkABglPxNdbMYJbnAZD9sPFDfpWR9ytFbexaMw7SQxYjH
	ZFUPGEmkhswM5d5T5ze42/NDzQBTk2KZw4uEVIclpfFHyMGcBkP3y2WswqwYbvUNw5SsuRB
X-Google-Smtp-Source: AGHT+IHCxcL5gYfOSHzRRx8CVPImqoJt0QOor+vzDuvuPFXZ4Onm/sAyjrKEFkur+UpJml+SCx7vg2DUaaGHDsxBm5w=
X-Received: by 2002:a2e:be84:0:b0:37f:b6bc:e792 with SMTP id
 38308e7fff4ca-3812156a2b6mr21545441fa.7.1766235181716; Sat, 20 Dec 2025
 04:53:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHP4M8Uy7HLiKjnMCdNG+QG+0cizN82c_G87AuzDL6qDCBG5vg@mail.gmail.com>
 <20251215045203.13d96d09.alex@shazbot.org> <CAHP4M8WeHz-3VbzKb_54C5UuWW-jtqvE=X37CSssUa5gti41GQ@mail.gmail.com>
 <CAHP4M8X=e+dP-T_if5eA=gccdbxkkObYvcrwA3qUBONKWW3W_w@mail.gmail.com> <20251219170637.2c161b7b.alex@shazbot.org>
In-Reply-To: <20251219170637.2c161b7b.alex@shazbot.org>
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Sat, 20 Dec 2025 18:22:49 +0530
X-Gm-Features: AQt7F2r-v-5pLlad59UuVktFvgC2k1L0bWuBPbaBXXchxJQseBIZnmHXFKcS8dw
Message-ID: <CAHP4M8Ud_tm+SPmZtnSi1--zf=MTsbvSqDYdAfPdAXUj+Ormkg@mail.gmail.com>
Subject: Re: A lingering doubt on PCI-MMIO region of PCI-passthrough-device
To: Alex Williamson <alex@shazbot.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, iommu@lists.linux-foundation.org, 
	linux-pci@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Alex.

I was/am aware of GPA-ranges backed by mmap'ed HVA-ranges.
On further thought, I think I have all the missing pieces (except one,
as mentioned at last in current email).

I'll list the steps below :

a)
There are three stages :

   * pre-configuration by host/qemu.
   * guest-vm bios.
   * guest-vm kernel.

b)
Host procures following memory-slots (amongst others) via mmap :

  * guest-ram
  * pci-config-space       : via vfio's ioctls' help.
  * pci-bar-mmio-space : via vfio's ioctls' help.

For the above memory-slots,

*
guest-ram physical-address is known (0), so ept-mappings for guest-ram
are set up even before guest-vm begins to boot up.

*
there is no concept of guest-physical-address for pci-config-space.

*
pci-bar-mmio-space physical address is not known yet, so ept-mappings
for pci-bar-mmio-space are not set up (yet).

c)
qemu starts the guest, and guest-vm-bios runs next.

This bios is "owned by qemu", and is "definitely different" from the
host-bios (qemu is an altogether different "hardware"). qemu-bios and
host-bios handle pci bus/enumeration "completely differently".

When the pci-enumeration runs during this guest-vm-bios stage, it
accesses the pci-device config-space (backed on the host by mmap'ed
mappings). Note that guest-kernel is still not in picture.

"OBVIOUSLY", all accesses (reads/writes) to pci-config space go to the
pci-config-space memory-slot (handled purely by qemu-bios code).

Once the guest-vm bios carves out guest-physical-addresses for the
pci-device-bars, it programs the bars by writing to bars-offsets in
the pci-config-space. qemu detects this, and does the following :

   * does not relay the actual-writes to physical bars on the host.
   * since the bar-guest-physical-addresses are now known, so now the
missing ept-mappings
     for pci-bar-mmio-space are now set up.

d)
Finally, guest-kernel takes over, and

   * all accesses to ram go through vanilla two-stages translation.
   * all accesses to pci-bars-mmio go through vanilla two-stages translatio=
n.


Requests :

i)
Alex / QEMU-experts : kindly correct me if I am wrong :) till now.

ii)
Once kernel boots up, how are accesses to pci-config-space handled? Is
again qemu-bios involved in pci-config-space accesses after
guest-kernel has booted up?


Once again, many thanks to everyone for their time and help.

Thanks and Regards,
Ajay


On Sat, Dec 20, 2025 at 5:36=E2=80=AFAM Alex Williamson <alex@shazbot.org> =
wrote:
>
> On Fri, 19 Dec 2025 11:53:56 +0530
> Ajay Garg <ajaygargnsit@gmail.com> wrote:
>
> > Hi Alex.
> > Kindly help if the steps listed in the previous email are correct.
> >
> > (Have added qemu mailing-list too, as it might be a qemu thing too as
> > virtual-pci is in picture).
> >
> > On Mon, Dec 15, 2025 at 9:20=E2=80=AFAM Ajay Garg <ajaygargnsit@gmail.c=
om> wrote:
> > >
> > > Thanks Alex.
> > >
> > > So does something like the following happen :
> > >
> > > i)
> > > During bootup, guest starts pci-enumeration as usual.
> > >
> > > ii)
> > > Upon discovering the "passthrough-device", guest carves the physical
> > > MMIO regions (as usual) in the guest's physical-address-space, and
> > > starts-to/attempts to program the BARs with the
> > > guest-physical-base-addresses carved out.
> > >
> > > iii)
> > > These attempts to program the BARs (lying in the
> > > "passthrough-device"'s config-space), are intercepted by the
> > > hypervisor instead (causing a VM-exit in the interim).
> > >
> > > iv)
> > > The hypervisor uses the above info to update the EPT, to ensure GPA =
=3D>
> > > HPA conversions go fine when the guest tries to access the PCI-MMIO
> > > regions later (once gurst is fully booted up). Also, the hypervisor
> > > marks the operation as success (without "really" re-programming the
> > > BARs).
> > >
> > > v)
> > > The VM-entry is called, and the guest resumes with the "impression"
> > > that the BARs have been "programmed by guest".
> > >
> > > Is the above sequencing correct at a bird's view level?
>
> It's not far off.  The key is simply that we can create a host virtual
> mapping to the device BARs, ie. an mmap.  The guest enumerates emulated
> BARs, they're only used for sizing and locating the BARs in the guest
> physical address space.  When the guest BAR is programmed and memory
> enabled, the address space in QEMU is populated at the BAR indicated
> GPA using the mmap backing.  KVM memory slots are used to fill the
> mappings in the vCPU.  The same BAR mmap is also used to provide DMA
> mapping of the BAR through the IOMMU in the legacy type1 IOMMU backend
> case.  Barring a vIOMMU, the IOMMU IOVA space is the guest physical
> address space.  Thanks,
>
> Alex

