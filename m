Return-Path: <linux-pci+bounces-19576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31694A0693C
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 00:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690593A6CDE
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 23:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B516F2040B9;
	Wed,  8 Jan 2025 23:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="miMBigcr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B429F204692
	for <linux-pci@vger.kernel.org>; Wed,  8 Jan 2025 23:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736377600; cv=none; b=Xb85LqQHUiWIr2RwqysShs5b1tahkIpqb/Kw5WNpi4jmuOAZLfMPSZ5Z4eAPlW34BKEeWGBq/1hhiPFPV9MB8qmvk2I5Q5SGqiJDQWoqpa7ClOC/Y/egQiKFtiogbpCpFSrQO6q7PpQGWWcwv0fRtcIhjKr6rMXvUSRK9PUeXFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736377600; c=relaxed/simple;
	bh=aB0CXxIokhvkC57xHWo5H49NtK4Hw4Lwfh2W3E5LB10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1gMTiPP+ILzC52gbJEykqdKh7fdcG1ydCbQt2ZYlnQY+c6UpW+OviDMgVJ7dh4no4uGjIV+uqw2zocxJVwf3gvWkbOHKPA8dKLcmqNTpoZFF+egALLYAm+g5WNEpkNiIrxGXrgQptorC8QFYPWmyzxCT3rQPinfv84JGhqiCSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=miMBigcr; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B3C833F29B
	for <linux-pci@vger.kernel.org>; Wed,  8 Jan 2025 23:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1736377590;
	bh=/2uznUkAqjnP0Z9uvgDXWb7hJkSM5A3/75TWvET5IXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=miMBigcrD3fFtlmW5l4x+mPzcnGsQu/dwz25p4iaMHBvmQ5CzAdSeZ8JYcC2KLa4O
	 AQqy9zWAkzkyATgpPQZP9kEaqiZ391MpOT+gJu3EbzfyumLSK6ktzjhEpUTDwvuXoO
	 7rJi0f8rsmAD5wTC/5pB2fwYUoFlQb0fnZBpXnCyiQEvZCs8BpxvHFuRDuqTIvaQhj
	 0swAMUTR3xKSVKy4kMGJwaacPPQ/a9K1GzoTnH6w3IJA3lIcCAg+4J/Dv8lcBJ3Kg+
	 kLCgq5t4KUwQ7smfE44OLdhCyIKOaniCK4QK+tuIQrtpqB0HlzqDvnmMeT8BFYqwC/
	 dxOJ+GMyNIMww==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa683e90dd3so24989766b.3
        for <linux-pci@vger.kernel.org>; Wed, 08 Jan 2025 15:06:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736377590; x=1736982390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2uznUkAqjnP0Z9uvgDXWb7hJkSM5A3/75TWvET5IXg=;
        b=t1vOQmvpXtKIjAxQ+n2o1X2Z9uUqGUe0lhUkF0UBVzvJGv3IRrdP2K8Ee6m+A2aT2v
         ahulYW52vqH4lmYS5N+5YROPm/QU0nt7bcht+DPnlgW3+Yv7uQHp1pEnI3U+K7KEL1Ex
         OQOy3Khlw8ffoYKJowqD39tdBrU6/j2YPxFOunCrE+sU4opPYV3PSQOSIXBDMiwRLsnH
         Rc0bnt7DrOCz6bjmzcXj2UXfA6SWmc0urzXBPstn5N3FOrC/wdQA8DUJKNH/nJxnLaoo
         /naW5poHMx0zEDAJN26kr0b522UfVZ1nykKIwZNPDKoQiTm7cOBrsNHUrmDXxBSAPZxM
         XwhQ==
X-Gm-Message-State: AOJu0YwTdQgGByNaGRLk8OzybFSwbJ9Lh1wyIAwYfaXTdbZHRVA4bFJI
	u61oV/rC/dE9v/Vo9zJ40a1UQTx4WnjxCzKDqxMvxH8yWF/aoml3kXio2pIyCsnDJnKATjnosoY
	vl76JQabBNQQKj1cwd+EM0FilSaAgWa0iZQA06KOloV/KKhBwKNXOO03cpB1KpOR7ZHsCCKFN7m
	10zqOXQcjQN8oDWawjIzvM4sjuHGS9/KQPryReqfhitnf8tkFF
X-Gm-Gg: ASbGncuMbhzBXydgD942gCzniRgD//knZABauddWi/bQI2TSfUq7qpqbnat94md72eP
	di3UpfKEvdpX9E33c8p3zu1Y2sPGICkWNdSQZ
X-Received: by 2002:a17:907:7e83:b0:aa6:9eac:4b8e with SMTP id a640c23a62f3a-ab2abc6de91mr392176766b.41.1736377590076;
        Wed, 08 Jan 2025 15:06:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvwWlclDYYEbYBSiP/WDt5laFXGS8tFE0XxhvZP2Qfrj+WPfVMinCdtVnOxEdQ+WpwgE1q+7FaQZAki91ik/4=
X-Received: by 2002:a17:907:7e83:b0:aa6:9eac:4b8e with SMTP id
 a640c23a62f3a-ab2abc6de91mr392175966b.41.1736377589723; Wed, 08 Jan 2025
 15:06:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHTA-uYp07FgM6T1OZQKqAdSA5JrZo0ReNEyZgQZub4mDRrV5w@mail.gmail.com>
 <20241126103427.42d21193.alex.williamson@redhat.com> <CAHTA-ubXiDePmfgTdPbg144tHmRZR8=2cNshcL5tMkoMXdyn_Q@mail.gmail.com>
 <20241126154145.638dba46.alex.williamson@redhat.com> <CAHTA-uZp-bk5HeE7uhsR1frtj9dU+HrXxFZTAVeAwFhPen87wA@mail.gmail.com>
 <20241126170214.5717003f.alex.williamson@redhat.com> <CAHTA-uY3pyDLH9-hy1RjOqrRR+OU=Ko6hJ4xWmMTyoLwHhgTOQ@mail.gmail.com>
 <20241127102243.57cddb78.alex.williamson@redhat.com> <CAHTA-uaGZkQ6rEMcRq6JiZn8v9nZPn80NyucuSTEXuPfy+0ccw@mail.gmail.com>
 <20241203122023.21171712.alex.williamson@redhat.com> <CAHTA-uZWGmoLr0R4L608xzvBAxnr7zQPMDbX0U4MTfN3BAsfTQ@mail.gmail.com>
 <20241203150620.15431c5c.alex.williamson@redhat.com> <CAHTA-uZD5_TAZQkxdJRt48T=aPNAKg+x1tgpadv8aDbX5f14vA@mail.gmail.com>
 <20241203163045.3e068562.alex.williamson@redhat.com> <CAHTA-ua5g2ygX_1T=YV7Nf1pRzO8TuqS==CCEpK51Gez9Q5woA@mail.gmail.com>
In-Reply-To: <CAHTA-ua5g2ygX_1T=YV7Nf1pRzO8TuqS==CCEpK51Gez9Q5woA@mail.gmail.com>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Wed, 8 Jan 2025 17:06:18 -0600
X-Gm-Features: AbW1kvaRQ-oa_KJM1tWVzxUFSIUJcSVrhNBaTG5oM6r7TSvw5QWEt2Pk6CXw7pQ
Message-ID: <CAHTA-uZtRzFOuo7vZCjoLF3_n0CCy3+0U0r_deB3jFF0cPivnw@mail.gmail.com>
Subject: Re: drivers/pci: (and/or KVM): Slow PCI initialization during VM boot
 with passthrough of large BAR Nvidia GPUs on DGX H100
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

While waiting for
https://lore.kernel.org/all/20241218224258.2225210-1-mitchell.augustin@cano=
nical.com/
to be reviewed, I was thinking more about the slowness of
pci_write_config_<size>() itself in my use case.

You mentioned this earlier in the thread:

> It doesn't take into account that toggling the command register bit is no=
t a trivial operation in a virtualized environment.

The thing that I don't understand about this is why the speed for this
toggle (an individual pci_write_config_*() call) would be different
for one passed-through GPU than for another. On one of my other
machines with a different GPU, I didn't see any PCI config register
write slowness during boot with passthrough. Notably, that other GPU
does have much less VRAM (and is not an Nvidia GPU). While scaling
issues due to larger GPU memory space would make sense to me if the
slowdown was in some function whose number of operations was bound by
device memory, it is unclear to me if that is relevant here, since as
far as I can tell, no such relationship exists in pci_write_config_*()
itself since it is just writing a single value to a single
configuration register regardless of the underlying platform. (It
appears entirely atomic, and only bound by how long it takes to
acquire the lock around the register.)  All I can hypothesize is that
maybe that lock acquisition needs to wait for some
hardware-implemented operation whose runtime is bound by memory size,
but that is just my best guess.

Is there anything you can think of that is triggered by the
pci_write_config_*() alone that you think might cause device-dependent
behavior here, or is this likely something that I will just need to
raise with Nvidia?

Thanks,
Mitchell Augustin

On Thu, Dec 5, 2024 at 6:09=E2=80=AFPM Mitchell Augustin
<mitchell.augustin@canonical.com> wrote:
>
> I submitted a patch that addresses this issue that I want to link to
> in this thread:
> https://lore.kernel.org/all/20241206000351.884656-1-mitchell.augustin@can=
onical.com/
> - everything looks good with it on my end.
>
> -Mitchell Augustin
>
>
> On Tue, Dec 3, 2024 at 5:30=E2=80=AFPM Alex Williamson
> <alex.williamson@redhat.com> wrote:
> >
> > On Tue, 3 Dec 2024 17:09:07 -0600
> > Mitchell Augustin <mitchell.augustin@canonical.com> wrote:
> >
> > > Thanks for the suggestions!
> > >
> > > > The calling convention of __pci_read_base() is already changing if =
we're having the caller disable decoding
> > >
> > > The way I implemented that in my initial patch draft[0] still allows
> > > for __pci_read_base() to be called independently, as it was
> > > originally, since (as far as I understand) the encode disable/enable
> > > is just a mask - so I didn't need to remove the disable/enable inside
> > > __pci_read_base(), and instead just added an extra one in
> > > pci_read_bases(), turning the __pci_read_base() disable/enable into a
> > > no-op when called from pci_read_bases(). In any case...
> > >
> > > > I think maybe another alternative that doesn't hold off the console=
 would be to split the BAR sizing and resource processing into separate ste=
ps.
> > >
> > > This seems like a potentially better option, so I'll dig into that ap=
proach.
> > >
> > >
> > > Providing some additional info you requested last week, just for more=
 context:
> > >
> > > > Do you have similar logs from that [hotplug] operation
> > >
> > > Attached [1] is the guest boot output (boot was quick, since no GPUs
> > > were attached at boot time)
> >
> > I think what's happening here is that decode is already disabled on the
> > hot-added device (vs enabled by the VM firmware on cold-plug), so in
> > practice it's similar to your nested disable solution.  Thanks,
> >
> > Alex
> >
>
>
> --
> Mitchell Augustin
> Software Engineer - Ubuntu Partner Engineering



--=20
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering

