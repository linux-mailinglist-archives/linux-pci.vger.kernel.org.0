Return-Path: <linux-pci+bounces-33858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24464B22596
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 13:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20E73B766B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 11:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BA91EF391;
	Tue, 12 Aug 2025 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kr54Bh1L"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770822E9EC2
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754997057; cv=none; b=ntnwkvznXpu6VJRgfMHJyLFWmw4xyGskkW3lJvF80iS9IKvwf2F/6UI4v0MrBOusg0BL9vSSx0Otdzm3Q3MjOGChMDnR8sUO97I6nEUy34ICew0gGQ7cOovjK78XqIsEBcbj+xbUp2tz52vhCwehMQ+zZuHbBVbFxgGiKuEJy2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754997057; c=relaxed/simple;
	bh=oHtOO7liWTwT072ugwLl6XJotdj5AsKuf7C45hj4oFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fueh9AlX2fGaAmjd89z1n3h06OAJR4Z91UUBIhA+qiUSh+30ZYubSP/mXjeoUfXQSfR0GxeegsFa69uLJaGJvTtA1pu4ikc5HixGTbwr6XTEwT9ar+FTAXs03mKdVv2y4hztf/ojh82vzWS9gXf4AbaeeLCzV0fSRXxjKN2phxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kr54Bh1L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754997054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uPJ8Lxt3BleEOvsSUBjkL40gEZfMUtcuZAKrb/YcBdY=;
	b=Kr54Bh1LjdmcYuDic06b20T9Sgk+JDFtpuTXMs6ffNaDJRnf7cCg/R8bYXLSHqwAt0UhdT
	3Eo3nVg3QMiDpy/K6pKKU6SFDhGQ9c2SewNg6eMrjZfCBtygOFYtQtrKVGjothQMxgwoZG
	qjUhvHKd1lhUT6y9pJxVttNbOX1Fno8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-QbQ3fFKaPGGHqMxPwUw2SQ-1; Tue, 12 Aug 2025 07:10:53 -0400
X-MC-Unique: QbQ3fFKaPGGHqMxPwUw2SQ-1
X-Mimecast-MFC-AGG-ID: QbQ3fFKaPGGHqMxPwUw2SQ_1754997051
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2400b28296fso81322335ad.1
        for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 04:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754997051; x=1755601851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPJ8Lxt3BleEOvsSUBjkL40gEZfMUtcuZAKrb/YcBdY=;
        b=gnjS0ZJ4Q4kprNzTDBqcaM1S00gWmjkXu/D1ud5bRMWfOW6iwFqUGcucmWPQDD/vtR
         CXS8RbONrxtfSOiRa3EklH6t8ywzMYB3AhZp34inAffB+qOQxm5IRivinFRZnU0py0Cm
         jkb/ULKgG5KQ8Lnq7CHZNAZ8GpZA2SJQIvyURJMrCxhoz7rRpZbOi1N++evxjUzowifK
         dCkpAHJowz9eBYJ6Yf8vTPOEhaz7bM2X/qwrsUe/O9e1G7bhVcrmvtQQt/V1cfictqgs
         l4dW2O2cpTY1LhtITyBWxBLcDdg8HbeRiu57jlkMATtI/9qWZdrKglUT83icLs2w6IQs
         jrMw==
X-Forwarded-Encrypted: i=1; AJvYcCUZVIzzubEPQPi9qzoaVcxFV/cXpD9zp9dX2LhwVA/ba2v4SgAgi8S/RYF7ep2W1mfDZe3g6JnSuho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdIzsUsn0d/FU7kPBuXbJJdBCgNAfPBT7ehuE9G7vTlRXJ2F4Z
	tR1Ze9FUUO6M2LHDiMRn53U0snBjQbKNsP5ow65nb/WzKQ3NDxxTyNlF7lhyN9Qe+ZEyPKuwmaV
	L9nPlBfWC7wgEgy6O2Nxpfd/bZ5PXVB1KcP9gQGJfO5EskPldjdq0k4/r4CexEg==
X-Gm-Gg: ASbGncvlOTeYy2ovw6RynO8HiBfPOwNTxEDkyFMvuEuQYc0OYt8sYdvQpqfaNOIz+f5
	t7FWV9ERQbfNw7i/uuqWk2BThSmbwSK7qQMZyvaA3F9r1WiRwGdCxnOo5U6MTba22AkozMvTLFg
	64nSE95nxNBuYizSaYcNYl4u4BSYEyEAZoevP25eKqJfMFh0QPZVKUinlVh/fEmC4f7FIGm7Dxj
	fDLHmkJ3616XxHYHXf6lWsBmOzVV1/oc4gKUA+FR0jMjSSudxdA3Q6wkiDMLGZ3bXLzyri/7s9Z
	60t+a8RVQxFW8W+3PDbg5TmQ5ihyblI=
X-Received: by 2002:a17:902:d58c:b0:242:9bbc:6017 with SMTP id d9443c01a7336-242fc372b34mr41461365ad.55.1754997050795;
        Tue, 12 Aug 2025 04:10:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJVKxxP3qAclSLG5krLKovafdMdrQyd8bvZiT7pPhzWqWVFBiBgJYCXhmR+aHa6BbxpO2Hew==
X-Received: by 2002:a17:902:d58c:b0:242:9bbc:6017 with SMTP id d9443c01a7336-242fc372b34mr41461085ad.55.1754997050394;
        Tue, 12 Aug 2025 04:10:50 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24309a18411sm2476495ad.146.2025.08.12.04.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 04:10:50 -0700 (PDT)
Date: Tue, 12 Aug 2025 19:07:56 +0800
From: Coiby Xu <coxu@redhat.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [Regression] kdump fails to get DHCP address unless booting with
 pci=nomsi or without nr_cpus=1
Message-ID: <gec2yl5wx6vvt67smx5emhcoifvtp4orw6sub24b2nrqwryhp2@i4h7qbtwjo3r>
References: <x5dwuzyddiasdkxozpjvh3usd7b5zdgim2ancrcbccfjxq7qwn@i6b24w22sy6s>
 <87bjom8106.ffs@tglx>
 <878qjq80yu.ffs@tglx>
 <86v7mt9ai3.wl-maz@kernel.org>
 <i2l2ujhqjd6akzosvzj4njv2vemsfuvywz4gsnj2nwo3fwyjyz@cfhekxpartf2>
 <86ms84974v.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <86ms84974v.wl-maz@kernel.org>

On Tue, Aug 12, 2025 at 11:17:04AM +0100, Marc Zyngier wrote:
>On Tue, 12 Aug 2025 11:09:12 +0100,
>Coiby Xu <coxu@redhat.com> wrote:
>>
>> On Mon, Aug 11, 2025 at 03:52:04PM +0100, Marc Zyngier wrote:
>> > On Mon, 11 Aug 2025 14:03:21 +0100,
>> > Thomas Gleixner <tglx@linutronix.de> wrote:
>> >>
>> >> On Mon, Aug 11 2025 at 15:02, Thomas Gleixner wrote:
>> >>
>> >> CC+ Marc
>> >>
>> >> > On Mon, Aug 11 2025 at 11:23, Coiby Xu wrote:
>> >> >> Recently I met an issue that on certain virtual machines, the kdump
>> >> >> kernel fails to get DHCP IP address most of times starting from
>> >> >> 6.11-rc2. git bisection shows commit b5712bf89b4b ("irqchip/gic-v3-its:
>> >> >> Provide MSI parent for PCI/MSI[-X]") is the 1st bad commit,
>> >> >>
>> >> >>      # good: [7d189c77106ed6df09829f7a419e35ada67b2bd0] PCI/MSI: Provide
>> >> >>      # MSI_FLAG_PCI_MSI_MASK_PARENT
>> >> >>      git bisect good 7d189c77106ed6df09829f7a419e35ada67b2bd0
>> >> >>      # good: [48f71d56e2b87839052d2a2ec32fc97a79c3e264] irqchip/gic-v3-its:
>> >> >>      # Provide MSI parent infrastructure
>> >> >>      git bisect good 48f71d56e2b87839052d2a2ec32fc97a79c3e264
>> >> >>      # good: [8c41ccec839c622b2d1be769a95405e4e9a4cb20] irqchip/irq-msi-lib:
>> >> >>      # Prepare for PCI MSI/MSIX
>> >> >>      git bisect good 8c41ccec839c622b2d1be769a95405e4e9a4cb20
>> >> >>      # first bad commit: [b5712bf89b4bbc5bcc9ebde8753ad222f1f68296]
>> >> >>      # irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]
>> >> >
>> >> > There were follow up fixes on this, so isolating this one is not really
>> >> > conclusive.
>> >> >
>> >> > Is the problem still there on v6.16 and v6.17-rc1?
>> >
>> > Yeah, there are way too many things that have been addressed since.
>> > kdump is also a particularly nasty case, as it tends to rely on the
>> > redistributor tables programmed by the previous kernel.
>>
>> Thanks for providing a clue. This may also explain explain why I fails
>> to reproduce this issue against 1st kernel even with the same cmdline of
>> the kdump kernel.
>
>I'm not sure that's a clue. It's only an indication that things are
>not necessarily easy to spot.
>
>Has it ever been reproduced on bare metal? Have you tried v6.16 as
>instructed?

Thanks for replying so quickly!

No, I haven't reproduced it on a bare metal machine and our QE engineers
haven't noticed this issue on any bare metal machine either. 

And I can confirm this issue still happens to 6.16.0-200.fc42.aarch64
and 6.17.0-0.rc1.17.fc43.aarch64 on the type of KVM VMS (QEMU PnP device
PNP0c02) where the issue was found.

>
>>
>> >
>> > Also, this says "virtual machines". What's the hypervisor?
>>
>> I'll contact the lab administrator. What kinds of info I should collect
>> to help you narrow down the issue?
>
>Surely you know what hypervisor you're running on, right?

Yes, the hypervisor is KVM. Sorry, I thought merely providing the
hypervisor info isn't sufficient and also misunderstood your request as
providing more details on the host machine.

>
>>
>> > How hard is it to reproduce?
>>
>> It can be reproduced reliably on certain machines. But as of writing I
>> haven't reproduced it on other KVM virtual machines on three different
>> host machines.
>
>Which machines? I'm sorry, but if you want help on this, you'll have
>to provide actual information.

Sorry, I didn't mean to be vague. I thought you question is on how
reproducible this issue is and there is no need to provide the details
on the machines where I can't reproduce this issue. Since you explicitly
request it, I'll be glad to share the details.

I just grabbed three arbitrary bare metal machines having Fedora-42
installed and launched some KVM VMs to see if this issue can be
reproduced easily. Two host machines are as follows (sorry I can't find
the info of the 3rd one)
- GIGABYTE PnP device PNP0c02, ARMv8 (M128-30)
- LTHPCSR112 (01234567890123456789AB), ARMv8 (Q80-30)

The virtual machine image is downloaded from
https://download.fedoraproject.org/pub/fedora/linux/releases/42/Cloud/aarch64/images/Fedora-Cloud-Base-Generic-42-1.1.aarch64.qcow2.
I tried different vCPUs (2, 4), different RAM (4G, 35G) and also two
different UEFI firmware (the default one and one from edk2-experimental
package) but haven't reproduced this issue so far.

>
>Thanks,
>
>	M.
>
>-- 
>Without deviation from the norm, progress is not possible.
>

-- 
Best regards,
Coiby


