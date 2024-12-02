Return-Path: <linux-pci+bounces-17555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AB99E0C38
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 20:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C3F164EA9
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 19:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECD01DE4CC;
	Mon,  2 Dec 2024 19:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="cSvd9z+b"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75B31DE3BF
	for <linux-pci@vger.kernel.org>; Mon,  2 Dec 2024 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168203; cv=none; b=Fzo6dc8nsFcCiEEmJ9+t/YiWygZcfHOgsLxpm2bDcmA4XKD3Rt8SYYjw6tCs9XvjVQjGhI4f/kmGt+jAiXLaMv5s4gMnHIHQRfVVz2P3l4eqfW7FVPMs52aZVy9gaTo9bRIjyCpNDDFO2+skAdEiPA+nIZ97Crn0est2yrI5jlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168203; c=relaxed/simple;
	bh=PMsUv+q/+JfREQxpfuAbt3/PvDuUR3+8vgcngJw4L0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMyIIqH19eYCdwh8D8ov+B2XONdLJMSyqNk0y2yNeztwX2QRgo4+cFhM3Axmu0D2Xlm/NfncDZMHnKBP0Ho/3YMf/80J9uzcZkr2Zr0f1p1oMymi6R/614GGSRYJfOXapNPgIFDmJSyNMQxT0Qmwr1E+O45hyCKA3ZDigLNg/nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=cSvd9z+b; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C86013F28C
	for <linux-pci@vger.kernel.org>; Mon,  2 Dec 2024 19:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733168198;
	bh=W6aZlMtP8KSsoitzGDR7wpyoQGNVRJRxSI2L2J9zakA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=cSvd9z+bD+4PUlhD36l6d3fWAPthzbffNvTerhXVq3zHKB7ZBIGxLEE5BFQv29F03
	 sdRKoRlB/6rdhdwOeUak/bCNYGhZcVr2YVA6PToadRPKZFI72hWh/rGwkV+Nnh7Pd3
	 MtJxG4uYkBCKeSW4vNFhsVNknUHksh8N1zcX3LoB8RV3QV9L7dfZVHtiml9KCaACvx
	 PrMhiwHl0O/F3NNSBSiHxTptb8xIoP67IhrwVGjwuGljR8A+Nb1ZIZ5MA4gdGOeXzF
	 b881IE7tkdZJszDpwKIGIq3mJ7x7+cgvcNtZ5sKwG8lx37pSe8CXuzhBhwD407qcn8
	 gAKif4d15spJg==
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ffe1ddca04so37181521fa.1
        for <linux-pci@vger.kernel.org>; Mon, 02 Dec 2024 11:36:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733168196; x=1733772996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6aZlMtP8KSsoitzGDR7wpyoQGNVRJRxSI2L2J9zakA=;
        b=NLB7hURQBpe5TC/sNrM6pC4GN7T8YLqkyF77cV3DhBxTeSYtAXZRiznzB3DINE5+2s
         uRe3ofddF9cbrwsQg4/isL/p2MqynuCAwqtkugmFhgLyASCPb7c4enTaES94Jh7SFHn3
         0e1CFMDMwGsA2ka7EXvy/fi0svBHmDYmAv8fQVPAiriu+Aoik+a3QroBHg1b1ALXS4KK
         RW1vm1t1FEXAinsvXEhLQL0Bqr2bqQWqqDYJ53XBPlsYzW/sGlsSyoTZzFqzNj4yJKUp
         gxX0VhuOK06K/TTS/pWfiH2Qshxj6xtLNOFDayKvc8fF2o0j/Repb6b93kjmdnN02q1/
         Qn+w==
X-Gm-Message-State: AOJu0YzVI7x9avD0MSCY0MKYajg52eKJkr/neQrESoYzsAQuAUk7I9/G
	Z3S6UDHoN5WNYlHZ8PHqx1M8ulWPWlvU3hlGAZn9iqAdatDzTM2aGNUOPm42z3+dY5HyqxOkRgI
	TFT+Y+fUVKNrP+zY8m1xOYAaaqzN2zhKqiouNa53Ys5pYwwNt1Cgp2v3tQE/r8/DR6JMImrWUJA
	AUjBHD2RYVRHPU9wXOayF7nDSN9XJO3wd6EliIvZUE5qT9uoda4Lu1gcGjvfY=
X-Gm-Gg: ASbGncsQM8FwANQqTeYJmm4+tGx3TWrc/tRO2FT4gncGeT+dpLN3HOrIeotGfQB4KXJ
	Y84FAY/XPURGZL74T7PUAHYNoenaOEw==
X-Received: by 2002:a05:6512:1249:b0:53d:b4ab:13ba with SMTP id 2adb3069b0e04-53df00d953cmr13276677e87.27.1733168196283;
        Mon, 02 Dec 2024 11:36:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNSC28E6FM3qQ6WZTcAg556PxdrO7zI2Cs8OXWZhXXHB0JJrG1uq2dPIWuLVrFidClqbG+uIzIJVnnP73V5RM=
X-Received: by 2002:a05:6512:1249:b0:53d:b4ab:13ba with SMTP id
 2adb3069b0e04-53df00d953cmr13276668e87.27.1733168195915; Mon, 02 Dec 2024
 11:36:35 -0800 (PST)
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
 <20241127102243.57cddb78.alex.williamson@redhat.com>
In-Reply-To: <20241127102243.57cddb78.alex.williamson@redhat.com>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Mon, 2 Dec 2024 13:36:25 -0600
Message-ID: <CAHTA-uaGZkQ6rEMcRq6JiZn8v9nZPn80NyucuSTEXuPfy+0ccw@mail.gmail.com>
Subject: Re: drivers/pci: (and/or KVM): Slow PCI initialization during VM boot
 with passthrough of large BAR Nvidia GPUs on DGX H100
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks!

This approach makes sense to me - the only concern I have is that I
see this restriction in a comment in __pci_read_base():

`/* No printks while decoding is disabled! */`

At the end of __pci_read_base(), we do have several pci_info() and
pci_err() calls - so I think we would need to also print that info one
level up after the new decode enable if we do decide to move decode
disable/enable one level up. Let me know if you agree, or if there is
a more straightforward alternative that I am missing.

- Mitchell Augustin


On Wed, Nov 27, 2024 at 11:22=E2=80=AFAM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Tue, 26 Nov 2024 19:12:35 -0600
> Mitchell Augustin <mitchell.augustin@canonical.com> wrote:
>
> > Thanks for the breakdown!
> >
> > > That alone calls __pci_read_base() three separate times, each time
> > > disabling and re-enabling decode on the bridge. [...] So we're
> > > really being bitten that we toggle decode-enable/memory enable
> > > around reading each BAR size
> >
> > That makes sense to me. Is this something that could theoretically be
> > done in a less redundant way, or is there some functional limitation
> > that would prevent that or make it inadvisable? (I'm still new to pci
> > subsystem debugging, so apologies if that's a bit vague.)
>
> The only requirement is that decode should be disabled while sizing
> BARs, the fact that we repeat it around each BAR is, I think, just the
> way the code is structured.  It doesn't take into account that toggling
> the command register bit is not a trivial operation in a virtualized
> environment.  IMO we should push the command register manipulation up a
> layer so that we only toggle it once per device rather than once per
> BAR.  Thanks,
>
> Alex
>


--=20
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering

