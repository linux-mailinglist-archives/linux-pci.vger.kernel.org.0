Return-Path: <linux-pci+bounces-17815-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC1D9E61C7
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 01:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2EA21884A46
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 00:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21177483;
	Fri,  6 Dec 2024 00:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="bItsGeZk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC971C27
	for <linux-pci@vger.kernel.org>; Fri,  6 Dec 2024 00:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443765; cv=none; b=t57ii8+vXb4xUy/ubYejlVBRNMD38iGR7/tRn1ANPW+ME7MkkCizxydpxWUl4/CwF0J4TLSl7saQKRgiIU2Hq6rEqr8BnijsWXMVw0UC8y8rQ1Rg2HUewTIGNjHrchwKYuoAhtjOwWOEGDKdV4jj9yacyl31uerjU16kZLHJGg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443765; c=relaxed/simple;
	bh=dBA47SUie5SwFd03yBmEyKgEIejEfXGA+UqqvehwusI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdWV8dW1ycCIgq/pQQwHWoaCPEBxF8lENZAw3SXs0UObmlVt5wHYyImu/Xsy3bxFMuMa75KjfxSroMUZ+YkQH2IkkUpvaI+OkYnIfSsQdD8imSYOQQEV9Pw4WSciGasQ7UBn/rawBG2CQX9dtDS6OvTU1rBCJG2hwd2u6xp4rao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=bItsGeZk; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 055953F29E
	for <linux-pci@vger.kernel.org>; Fri,  6 Dec 2024 00:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733443760;
	bh=sMurqy6Z4XssLascAqYWalpe3jcOC1OWrus+pdaK60E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=bItsGeZkQk2QihqDXKQmGXwFzGQIM6iTmVa/ZWLaMimwsamNsR5rFuSPdt0Jq19V+
	 mQiK0dCOxO7y5A7Ld0UftNWgJ/a021OsNs6oLOnmti/pU1fcdjvHQBPvqFOiRUjxZ5
	 3tiq6jvmo0DX6DteowQ7aCE0QDQBinpDwHM1QSedCIEWM44YDeiLpIWCH4Qq57w0YS
	 WJHvkHXcs/CZ8xhCWtGm0yiECwxuHB91MhwDGYqCzy6G/5i4ixVpQOpBCF7+/2GHjn
	 D7ZfJw3UY3BEiY+v9OX5AMWa5yVqATSkJvT0F7UzE/Hm6zz9eKfGH+fk0d1r+TsEpT
	 CY3CLD5kx6rOA==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5d10f6dfcfaso1168188a12.0
        for <linux-pci@vger.kernel.org>; Thu, 05 Dec 2024 16:09:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443759; x=1734048559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMurqy6Z4XssLascAqYWalpe3jcOC1OWrus+pdaK60E=;
        b=oELS0y77rkhsJ9S49onGILUQbdb7eHuw2fuWh2AAuWisjlEozSpHX0cYQn85bV/kiH
         Ghf3uhNM4bTpwij14kBqUKEWk2PimftDCYH+Z+pUKYaZd7yLl6bDpTE7OhNPSZFQyVaA
         erIyKYbG1S4k/DiGVptubpNa1qCKf1dpbb9/Aqe+HTWb1Y1NTX+WdROaTCcRve7ogNEa
         04M80x8xodpVNPmMWcv50qA0WFlCfQsM91sNgLZsNz79+aqWwyRXAucuG2y6OhT6gRg+
         3wJxm6Tlxagy5BYQZQkIBfnbk2JtOp5EVtD8Bg+sEU2/i/8mF93Klwgqy9kDJZx+GZtS
         TLbw==
X-Gm-Message-State: AOJu0YyjFGum7WyiN9DR1tCrknx8kPsiAqG9zjK7OEnsm6YZGcZmlI+U
	1h9em+nOOqJE1N0r/Nh2t0Tb2UKvea0atBaxH5kKAo0qFA7dCKYIDePgTB458Iu6wzC2M/Ld15k
	WBxe1Y5W5OIzEdl2iX96dufVD/uh6KCLF4iRHkvyWjmsiWca0OY1e45PXW+IL8CnQa9OYcXoWq9
	sHt0QwUu14REOZT7vt+w9JGuA1GAOtJcXPApCcfgyY0QOlVk0h
X-Gm-Gg: ASbGncvtjg7FuJ27wU4ROPhVEnfmXbDBJ1fVFiV7Sqp874qA5NQPTdS/tv9HDwp/u73
	9VE+uGUR5d4msjsv7vlnjts8OGSyGMg==
X-Received: by 2002:a05:6402:380f:b0:5d0:849c:71c3 with SMTP id 4fb4d7f45d1cf-5d3be466d4fmr1063014a12.0.1733443759490;
        Thu, 05 Dec 2024 16:09:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXpaP6nHDJsgYgKmHtFKSLgJ8MxPTVUzP/aApdPIDtegMmgfU+nkDdyPlw7Ek4gZHguQ66qgFYOTW+lnJYTqI=
X-Received: by 2002:a05:6402:380f:b0:5d0:849c:71c3 with SMTP id
 4fb4d7f45d1cf-5d3be466d4fmr1062984a12.0.1733443759183; Thu, 05 Dec 2024
 16:09:19 -0800 (PST)
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
 <20241203163045.3e068562.alex.williamson@redhat.com>
In-Reply-To: <20241203163045.3e068562.alex.williamson@redhat.com>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Thu, 5 Dec 2024 18:09:08 -0600
Message-ID: <CAHTA-ua5g2ygX_1T=YV7Nf1pRzO8TuqS==CCEpK51Gez9Q5woA@mail.gmail.com>
Subject: Re: drivers/pci: (and/or KVM): Slow PCI initialization during VM boot
 with passthrough of large BAR Nvidia GPUs on DGX H100
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I submitted a patch that addresses this issue that I want to link to
in this thread:
https://lore.kernel.org/all/20241206000351.884656-1-mitchell.augustin@canon=
ical.com/
- everything looks good with it on my end.

-Mitchell Augustin


On Tue, Dec 3, 2024 at 5:30=E2=80=AFPM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Tue, 3 Dec 2024 17:09:07 -0600
> Mitchell Augustin <mitchell.augustin@canonical.com> wrote:
>
> > Thanks for the suggestions!
> >
> > > The calling convention of __pci_read_base() is already changing if we=
're having the caller disable decoding
> >
> > The way I implemented that in my initial patch draft[0] still allows
> > for __pci_read_base() to be called independently, as it was
> > originally, since (as far as I understand) the encode disable/enable
> > is just a mask - so I didn't need to remove the disable/enable inside
> > __pci_read_base(), and instead just added an extra one in
> > pci_read_bases(), turning the __pci_read_base() disable/enable into a
> > no-op when called from pci_read_bases(). In any case...
> >
> > > I think maybe another alternative that doesn't hold off the console w=
ould be to split the BAR sizing and resource processing into separate steps=
.
> >
> > This seems like a potentially better option, so I'll dig into that appr=
oach.
> >
> >
> > Providing some additional info you requested last week, just for more c=
ontext:
> >
> > > Do you have similar logs from that [hotplug] operation
> >
> > Attached [1] is the guest boot output (boot was quick, since no GPUs
> > were attached at boot time)
>
> I think what's happening here is that decode is already disabled on the
> hot-added device (vs enabled by the VM firmware on cold-plug), so in
> practice it's similar to your nested disable solution.  Thanks,
>
> Alex
>


--=20
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering

