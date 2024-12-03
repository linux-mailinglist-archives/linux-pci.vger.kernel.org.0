Return-Path: <linux-pci+bounces-17590-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6DB9E2D2E
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 21:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BBA116134F
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 20:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0216E1F75B3;
	Tue,  3 Dec 2024 20:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ppUdLvKE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F911AF0AA
	for <linux-pci@vger.kernel.org>; Tue,  3 Dec 2024 20:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733258006; cv=none; b=FL3vxN0ui5Wja6vJ+86co66MK9fYqkpVqIiWWV7hNU92ZY8KDF9AYzdQPyWaevrJBdr3SiP+SuDz1m1TMGPTQhGhMb2rMInoYYC8pRH6VMaVZ04RbRfbu+hiZpBbbJmE03m0sZRQ1AhMWybov0RA8uFHKFpdU4azNzfm50dhXHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733258006; c=relaxed/simple;
	bh=e4jpFCaXU2nz/gwRkL8QZ7m8jv9KOqtZsjcyN4++KHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBPtO24ECC3OB+4Mu6y135cDAcNpPVFj7izlC2e4nCnR7HXr0+7rOjEHcPL9udw5Co/LNiMQiid2LYtZcs+p+aTbCBP/fzyy8gkl3rplhVnZ+NuVdIor1HQ2frQEyi6NRtjyHVXjyjBIPGMMGFdAclMNdSzSzBeEsZQYBjb9wdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ppUdLvKE; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3074A3F851
	for <linux-pci@vger.kernel.org>; Tue,  3 Dec 2024 20:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733258002;
	bh=4uNsVaUUplUBTIHeAwkHPLSzbCBzZJflgTjvuz4/qJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=ppUdLvKEMoIIeLnutg1tXVF+IJPSe2y0Oj4sJ1MfJLzmN7/K9PmUJ/4GpdoyszHrM
	 V/kCXq1OE6YednxXwiK4vCAHv7mtnpyajNRvLWpMaGbmTH9xVi2F4cXZAJ6kICg4vF
	 sCsJLGOTyUNNGfEVvpGxJLE+zTabjJnJyfLf44ZLcnUnRIH0LSU04iwcpwhU3xhMfL
	 d8U211epsuuzX3CUgz5mCbSeupzRUjwMML9I8hCLzkCJi6ot0ghdoF/j6B9ApNfUpR
	 tlSjkwictX4SBdGIkqLUiLiGQlY0PjUfYYnP55KTe1tjbEaDNaxZ8oVyvsVN6UnnSv
	 6nWKL6aTNimiQ==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa5449e1d9cso382695866b.2
        for <linux-pci@vger.kernel.org>; Tue, 03 Dec 2024 12:33:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733258002; x=1733862802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uNsVaUUplUBTIHeAwkHPLSzbCBzZJflgTjvuz4/qJ4=;
        b=n+QG2fYWe/B/NEUbpQFPW01L6LrcGWKWGdN6gev5+ss60gHlwFLXyqWBbfoiy0HtG2
         vMUoWZFuRzXO8xryNqO35JOpBMlfKwX9HHkhg1dw1FHSQDZxIomqgRxDmcjL5tVDNTKT
         6de/9HoGCOKdFypwyG1GZYxz6SxF3VXmA6UTrklwTChVA/s5bxjjYV/B+qm4QOqIG+r0
         Oy73MkYJc7u93tXYLGHia2o8KEyUvJxVZ621fDLWmyGG7yptXMkkaw52eFM6CSNEGhY4
         2t9RJnLDsqtV8PITCW6ZKKq+LuSZ+KkmLXg7iplV52wgec9c0JMRx3bUjUM99vypYKJw
         WgvA==
X-Gm-Message-State: AOJu0YzdFJV1UYn4zrqf9MpWcnBw5lY2g1rIR6EkkG0VWkwGRysrKgMD
	d3wkLJqPjfpzMNzvhwvAip3mIaeDsX/azGdkdVpMmsM9zLk0Qvkc12ydsUoOUQrqHEIFNQUqoqw
	qegYczT71bFdHCJqk9Xh4KIwCEEA59WgXursFJ70hlNB9QljtcmOcbspE3XxcuuXh7E7V2eepX+
	34I/5z7w48kNpkz8Lax4NnN0P7dJpjmJcn/Y6Ea2FgFLWwJuGN
X-Gm-Gg: ASbGnct97Bad2dD5GYOraHEKb6vsRDG3TdHgDnjXkXzQcwF+2BtDrP2whAbllUQZWXQ
	rxlIKtyi8ACDb3jMvvadS79hvVx3nXw==
X-Received: by 2002:a05:6402:270c:b0:5d0:c9ab:e03b with SMTP id 4fb4d7f45d1cf-5d10cb9a4c0mr2988850a12.33.1733258001678;
        Tue, 03 Dec 2024 12:33:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFahZb8758MP2RttPa8AXIQXQS50GmG8gIk8MGGsBpTnaaVZkT60EhxOhmn7qNtBwnx1ucQOKQixiEO5+h2CzM=
X-Received: by 2002:a05:6402:270c:b0:5d0:c9ab:e03b with SMTP id
 4fb4d7f45d1cf-5d10cb9a4c0mr2988839a12.33.1733258001334; Tue, 03 Dec 2024
 12:33:21 -0800 (PST)
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
 <20241203122023.21171712.alex.williamson@redhat.com>
In-Reply-To: <20241203122023.21171712.alex.williamson@redhat.com>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Tue, 3 Dec 2024 14:33:10 -0600
Message-ID: <CAHTA-uZWGmoLr0R4L608xzvBAxnr7zQPMDbX0U4MTfN3BAsfTQ@mail.gmail.com>
Subject: Re: drivers/pci: (and/or KVM): Slow PCI initialization during VM boot
 with passthrough of large BAR Nvidia GPUs on DGX H100
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks.

I'm thinking about the cleanest way to accomplish this:

1. I'm wondering if replacing the pci_info() calls with equivalent
printk_deferred() calls might be sufficient here. This works in my
initial test, but I'm not sure if this is definitive proof that we
wouldn't have any issues in all deployments, or if my configuration is
just not impacted by this kind of deadlock.

2. I did also draft a patch that would just eliminate the redundancy
and disable the impacted logs by default, and allow them to be
re-enabled with a new kernel command line option
"pci=3Dbar_logging_enabled" (at the cost of the performance gains due to
reduced redundancy). This works well in all of my tests.

Do you think either of those approaches would work / be appropriate?
Ultimately I am trying to avoid messy changes that would require
actually propagating all of the info needed for these logs back up to
pci_read_bases(), if at all possible, since there seems like no
obvious way to do that without changing the signature of
__pci_read_base() or tracking additional state.

-Mitchell Augustin


On Tue, Dec 3, 2024 at 1:20=E2=80=AFPM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Mon, 2 Dec 2024 13:36:25 -0600
> Mitchell Augustin <mitchell.augustin@canonical.com> wrote:
>
> > Thanks!
> >
> > This approach makes sense to me - the only concern I have is that I
> > see this restriction in a comment in __pci_read_base():
> >
> > `/* No printks while decoding is disabled! */`
> >
> > At the end of __pci_read_base(), we do have several pci_info() and
> > pci_err() calls - so I think we would need to also print that info one
> > level up after the new decode enable if we do decide to move decode
> > disable/enable one level up. Let me know if you agree, or if there is
> > a more straightforward alternative that I am missing.
>
> Nope, I agree.  The console might be the device we've disabled for
> sizing or might be downstream of that device.  The logging would need
> to be deferred until the device is enabled.  Thanks,
>
> Alex
>
> > On Wed, Nov 27, 2024 at 11:22=E2=80=AFAM Alex Williamson
> > <alex.williamson@redhat.com> wrote:
> > >
> > > On Tue, 26 Nov 2024 19:12:35 -0600
> > > Mitchell Augustin <mitchell.augustin@canonical.com> wrote:
> > >
> > > > Thanks for the breakdown!
> > > >
> > > > > That alone calls __pci_read_base() three separate times, each tim=
e
> > > > > disabling and re-enabling decode on the bridge. [...] So we're
> > > > > really being bitten that we toggle decode-enable/memory enable
> > > > > around reading each BAR size
> > > >
> > > > That makes sense to me. Is this something that could theoretically =
be
> > > > done in a less redundant way, or is there some functional limitatio=
n
> > > > that would prevent that or make it inadvisable? (I'm still new to p=
ci
> > > > subsystem debugging, so apologies if that's a bit vague.)
> > >
> > > The only requirement is that decode should be disabled while sizing
> > > BARs, the fact that we repeat it around each BAR is, I think, just th=
e
> > > way the code is structured.  It doesn't take into account that toggli=
ng
> > > the command register bit is not a trivial operation in a virtualized
> > > environment.  IMO we should push the command register manipulation up=
 a
> > > layer so that we only toggle it once per device rather than once per
> > > BAR.  Thanks,
> > >
> > > Alex
> > >
> >
> >
>


--=20
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering

