Return-Path: <linux-pci+bounces-22682-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1E3A4A66A
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 00:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A683AF043
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 23:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C26157A55;
	Fri, 28 Feb 2025 23:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ay2VsXoK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A2F23F372
	for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2025 23:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740783724; cv=none; b=g1+NlObDnGD5CG+vA6vaGyKSExHHHiTWs+yv+Ier0Wpit7rhRA5M9lcmdSWNEZFSyOuUS9L5diJ+xo9muoAGprW5/5SpVbt4uaEnYZaR2gOoOlG8QyoIEnEprBNRtjBsFF98QmKVwHLSkNqDZvsTExLLIU8HAaqQJI8KI07SBYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740783724; c=relaxed/simple;
	bh=Qa5uTdOGKEDXrk8jHmw/bafDymyCCFGvNgUPNfP71Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auZLOIw7VUsYTWbLb1xtPAtmz06+olldfr3IZUbsDf8G2UKCQmiw+OeeQkI7DC8o3V7wua8PxNLtugvrwmX0ka595qJz6eCgDFOrjoqMY4SzVVMj3FxoQx39VE7razhEvdD9zriZT0a5GJjZLQhn3FcjecS+MEeU6ckZdgjhE/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ay2VsXoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E994FC4CEE2
	for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2025 23:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740783723;
	bh=Qa5uTdOGKEDXrk8jHmw/bafDymyCCFGvNgUPNfP71Q4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ay2VsXoKe2LaFB2shOPR2BmtGWvU+38DHIJ77c441Pq48LcFkhiCysWQM9bA0Kbm6
	 dgOXMz3nsrr6fvX7jdKfrEOj9gDYpU9RxMKxuZqnncPEwGFn49YlSo4ZVyMBQhVeGG
	 +4oX1OFORCR52enMd+DPLRNRufQ/3Kq27xmBt2ukVOeUn6DuEb+VZLhkQxKbtN0YUv
	 8ql4dpoWyFG7q+M7Z9+J9kyw9uBVDTPjeDUvs0TEcrVFmz0vDrwtEoKJ6RsiU2kRjT
	 DP7Ph5o974tDAlA77VUPT3jheWNBsRm7HTRU2QeEWWwWlxsMzKtXp0V1gdMq2N544G
	 TLovBbN9CpaWQ==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abee54ae370so373229666b.3
        for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2025 15:02:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWlpZYYmjkBDWAc63Bq4ENZI0fVakR1+zIv6nptv4z+OI++UOQDMRvtGCPgRA/U8KAZZN+fKhuqd8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy3gtT6HKE56ttL5RYWEMwldT7kq2+4ccD7v43gFLsWha0TVtA
	Mgk4XKfb+9L82bXKSWj/3vHTYt/KhldDuEBONbMrJXv2L1iCy1N9bTQ9d5ohSbvbxMEh3WxNqti
	q73GW5DhoYSE17VHCMrB0SMbCLA==
X-Google-Smtp-Source: AGHT+IErOJJwOba5+/Kwxm+od8pXMoYGQHv39ul8SpLffRrZ46iVwFNm1+/r6TtsJkfDNBaelNkklKqhBZ6Xm6snwa0=
X-Received: by 2002:a17:907:d8d:b0:abe:cecc:727 with SMTP id
 a640c23a62f3a-abf269bbaebmr460977666b.53.1740783722467; Fri, 28 Feb 2025
 15:02:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PA4PR07MB883875A86213C568BC2E08E2FD5B2@PA4PR07MB8838.eurprd07.prod.outlook.com>
 <20250228182730.GA59475@bhelgaas>
In-Reply-To: <20250228182730.GA59475@bhelgaas>
From: Rob Herring <robh@kernel.org>
Date: Fri, 28 Feb 2025 17:01:51 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLzic6b_Bnwf9EOJvsb-HjXnu46czqGntwZyh6M4jZ9pA@mail.gmail.com>
X-Gm-Features: AQ5f1JqMYYn5HLB1RXYy01ZwuQ98yD_0eUE__5jQQv2jXG7Q4W_quUO87GhN7ic
Message-ID: <CAL_JsqLzic6b_Bnwf9EOJvsb-HjXnu46czqGntwZyh6M4jZ9pA@mail.gmail.com>
Subject: Re: Subject: [PATCH 1/1] PCI: of: avoid warning for 4 GiB non-prefetchable
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Wannes Bouwen (Nokia)" <wannes.bouwen@nokia.com>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Vidya Sagar <vidyas@nvidia.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 12:27=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> [+cc Vidya and reviewers of fede8526cc48]
>
> On Thu, Nov 14, 2024 at 02:05:08PM +0000, Wannes Bouwen (Nokia) wrote:
> > Subject: [PATCH 1/1] PCI: of: avoid warning for 4 GiB non-prefetchable
> > windows.
> >
> > According to the PCIe spec, non-prefetchable memory supports only 32-bi=
t
> > BAR registers and are hence limited to 4 GiB. In the kernel there is a
> > check that prints a warning if a non-prefetchable resource exceeds the
> > 32-bit limit.
> >
> > This check however prints a warning when a 4 GiB window on the host
> > bridge is used. This is perfectly possible according to the PCIe spec,
> > so in my opinion the warning is a bit too strict. This changeset
> > subtracts 1 from the resource_size to avoid printing a warning in the
> > case of a 4 GiB non-prefetchable window.
> >
> > Signed-off-by: Wannes Bouwen <wannes.bouwen@nokia.com>
> > ---
> >  drivers/pci/of.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index dacea3fc5128..ccbb1f1c2212 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -622,7 +622,7 @@ static int pci_parse_request_of_pci_ranges(struct d=
evice *dev,
> >             res_valid |=3D !(res->flags & IORESOURCE_PREFETCH);
> >
> >             if (!(res->flags & IORESOURCE_PREFETCH))
> > -               if (upper_32_bits(resource_size(res)))
> > +               if (upper_32_bits(resource_size(res) - 1))
> >                     dev_warn(dev, "Memory resource size exceeds max for=
 32 bits\n");
>
> I guess this relies on the fact that BARs must be a power of two in
> size, right?  So anything where the upper 32 bits of the size are
> non-zero is either 0x1_0000_0000 (4GiB window that we shouldn't warn
> about), or 0x2_0000_0000 or bigger (where we *do* want to warn about
> it).
>
> But it looks like this is used for host bridge resources, which are
> windows, not BARs, so they don't have to be a power of two size.  A
> window of size 0x1_8000_0000 is perfectly legal and would fit the
> criteria for this warning, but this patch would turn off the warning.

0x1_8000_0000 - 1 =3D 0x1_7fff_ffff

So that would still work. Maybe you read it as the subtract being
after upper_32_bits()?


> I don't really understand this warning in the first place, though.  It
> was added by fede8526cc48 ("PCI: of: Warn if non-prefetchable memory
> aperture size is > 32-bit").  But I think the real issue would be
> related to the highest address, not the size.  For example, an
> aperture of 0x0_c000_0000 - 0x1_4000_0000 is only 0x8000_0000 in size,
> but the upper half of it it would be invalid for non-prefetchable
> 32-bit BARs.

Are we talking CPU addresses or PCI addresses? For CPU addresses, it
would be perfectly fine to be above 4G as long as PCI addresses are
below 4G, right?

Rob

