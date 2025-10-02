Return-Path: <linux-pci+bounces-37474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC7EBB578A
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 23:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A479D481AD7
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 21:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565B11A9FB5;
	Thu,  2 Oct 2025 21:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="leSJZgKT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA021494DB
	for <linux-pci@vger.kernel.org>; Thu,  2 Oct 2025 21:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759440700; cv=none; b=JdGP+8PAwFDjSr3+1BDGzZyxxT0QnD0S8MI9tQi1jQZUl3AX3gKdZQ7y8UxIFA1r4ykVe05F9IWS//eDwSDPHUddFFPoMM3Um68d3jd7VixxJQljY0z1mNV8nI2BrpyeOkasfDj0jSGu+0x/6do7Q/Cwtafl690SoMeIaRLp3og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759440700; c=relaxed/simple;
	bh=itk4JTr0R9w+ryfFEx6v9H8EbW8HCfP0tJpr3hyKIJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OuT80TnhJsE0S0C5W5+2EZN91B7cgJtfs/aQ16jyeTUzlwsb1VgSKw1Fx9YDeaHxJu+v9UJaxdQY/RP5RbmigFO8qkIM7q26iAHcerjM37b7UDvWrScEgPO23OF/R69plfrXiVaaMJQazMTs7E/J2ICUqilf5BHWxSf3OvqW2+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=leSJZgKT; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-36a6a397477so16239011fa.3
        for <linux-pci@vger.kernel.org>; Thu, 02 Oct 2025 14:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759440696; x=1760045496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itk4JTr0R9w+ryfFEx6v9H8EbW8HCfP0tJpr3hyKIJc=;
        b=leSJZgKTYu/cYmlosOYJWSuUgIJByvSWiE8Wpq9rLLpmtZtSI38C1DYLHMEPad2l2B
         P48tAKWMnu7HNPJ9iUVsHO00onXf08yQSAvb9UeZppQz4y1GbaPxvivVQKW7IfSIDqmK
         iKl2lFPWGB5BdeMCv0fAGA/ZFFNRGtQVj6kan/Nz9Z2E+g78SPhq1PwryxxponNDGrJt
         7B1hqJpTjy3fGBlsnkusz+Eb7bp4hYB4eEa083+qP8oFnaeJA4OuYp5/8D3+bZeipGoI
         +X3qT5yUJ64cwWVI+idH3ySb/KSj8ZHyqtrCndu5+LmEn9BSeiEkf+Mkr/v/13kORDcr
         adtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759440696; x=1760045496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itk4JTr0R9w+ryfFEx6v9H8EbW8HCfP0tJpr3hyKIJc=;
        b=AaoqTCPI2rkqyX6m7Ltc3nINHN4DcJytBADoVh+tooTuLsCISWz5mmz7NmDDCUHWz8
         ZhGqKXxZR1j51VeJwmhxJRZFvk2yhAbF9CQ06oM5q645ihcHm38IVuarAD1+Lpj4aUME
         j1sVVTbuH2KffZQUQd4uRAuy25TwTFgdOL0aBWKNBJ2AnbbrhgVAgYM9QhPrnZfjEMz6
         tvS/r14si0rqMWwBzUfdWGPmEwpVRoY6XGhlDzOapBmf1QpGjuNU4sasfobXIkkXjFx3
         XztexLiKMTo9Mhl4+VAtjOxQBWRtU+6yMhx+iMfFf4RbpFw7FDeh/NgLNY3rsemVE/w6
         RTCg==
X-Forwarded-Encrypted: i=1; AJvYcCXDHUjbwMHe1s2OCWkoW3Q58AauIt8XMs6ca3RxOJShG8shFYGyyr2QgndbtPbQZ3yU45PdXTVAG3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjq5Ve01y6rhCeDsoOOyHTXpPF2galzbcaqG8DzYOP+Ks1+fjx
	YPMN41XWnoLPYZzeds7F+UojvoY+Sufz6gi3sw9wtaxAdN7PerXvbMjkrF97bW9waGs1BEs3gpp
	g5CtGmlu41s+R5AG9YJVHiK8otLbuecf2fMiTBEOQ
X-Gm-Gg: ASbGncvMIKrrQhWNrFW0qXxYA5ubp5aFukpLG8OqDjJfykifYu7ta+0Udsn3jOFoCdo
	WJP72K/ADkznjO7d04tMSJUFY6xD+s8covoJGoqzKrUA+YhmNQC82IXYSFTBiUn1OqK0JLZBLGM
	0/J+APX6S21oH1hyR2szxWqla2e+d5IYBlR3zgXzdzsHgxrmdWq0apVkx6Ip6SPAnUNZeeLXPcM
	LJiCuLY+LXU9QGNzypDlWhmhlVScM2vNJBT147UbhvEynTr
X-Google-Smtp-Source: AGHT+IGqjPSbdv+ZUi3yMiGuc9N7zqmKCD3B8wX71eOesWI9OIA6bqd9TOHwES7cpcuQpfMsKlDzOa1kGS+aG9lC8Nc=
X-Received: by 2002:a2e:bd12:0:b0:36c:47c8:b618 with SMTP id
 38308e7fff4ca-374c36cbefbmr1975911fa.18.1759440696211; Thu, 02 Oct 2025
 14:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-3-c494053c3c08@kernel.org> <20250929174831.GJ2695987@ziepe.ca>
 <CAF8kJuNZPYxf2LYTPYVzho_NM-Rtp8i+pP3bFTwkM_h3v=LwbQ@mail.gmail.com>
 <20250930163837.GQ2695987@ziepe.ca> <aN7KUNGoHrFHzagu@google.com> <CACePvbX6GfThDnwLdOUsdQ_54eqF3Ff=4hrGhDJ0Ba00-Q1qBw@mail.gmail.com>
In-Reply-To: <CACePvbX6GfThDnwLdOUsdQ_54eqF3Ff=4hrGhDJ0Ba00-Q1qBw@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 2 Oct 2025 14:31:08 -0700
X-Gm-Features: AS18NWAy9po3EvK7NxstdG5nipkcvqO50Z428EI8mycdiPXEf_eyQsgpsavXlKU
Message-ID: <CALzav=cKoG4QLp6YtqMLc9S_qP6v9SpEt5XVOmJN8WVYLxRmRw@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
To: Chris Li <chrisl@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 1:58=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Thu, Oct 2, 2025 at 11:54=E2=80=AFAM David Matlack <dmatlack@google.co=
m> wrote:
> > > Then don't do generic devices until we get iommufd done and you have =
a
> > > meaningful in-tree driver to consume what you are adding.
> >
> > I agree with Jason. I don't think we can reasonably make the argument
> > that we need this series until we have actualy use-cases for it.
> >
> > I think we should focus on vfio-pci device preservation next, and use
> > that to incrementally drive whatever changes are necessary to the PCI
> > and generic device layer bit by bit.
>
> The feedback I got for the PCI V1 was to make it as minimal as
> possible. We agree preserving the BUS MASTER bit is the first minimal
> step. That is what I did in the V2 phase I series. Only the bus
> master. I think the pci-lu-test driver did demo the bus master bit, it
> is not vfio yet. At least that was the plan shared in the upstream
> alignment meeting.

What do the driver callbacks in patch 3 and patches 5-8 have to do
with preserving the bus master bit? That's half the series.

>
> > For example, once we a basic vfio-pci device preservation working, we
> > can start thinking about how to handle when that device is a VF, and we
> > have to start also preserving the SR-IOV state on the PF and get the PF
>
> SR-IOV is a much bigger step than the BUS Master bit. I recall at one
> point in the upstream discussion meeting that we don't do SR-IOV as
> the first step. I am not opposed to it, we need to get to vfio and
> SR-IOV eventually. I just feel that the PCI + VFIO + SR-IOV will be a
> much bigger series. I worry the series size is not friendly for
> reviewers. I wish there could be smaller incremental steps digestible.

SR-IOV is not a first step, of course. That's not what I said. I'm
saying SR-IOV is future work that could justify some of the larger
changes in this series (e.g. driver callbacks). So I am suggesting we
revisit those changes when we are working on SR-IOV.

>
> > driver involved in the process. At that point we can discuss how to
> > solve that specific problem. Maybe the solution will look something lik=
e
> > this series, maybe it will look like something else. There is open
> > design space.
>
> Yes doable, just will delay the LUO/PCI series by a bit and a much
> bigger series.

There will not be one "LUO/PCI series". There will be many incremental step=
s.

>
> > Without approaching it this way, I don't see how we can't reasonably
> > argue that anything in this series is necessary. And I suspect some
> > parts of this series truly are unnecessary, at least in the short term.
>
> You have me on the double negatives, always not very good at those.
> If the bigger series is what we want, I can do that. Just will have
> some latency to get the VFIO.

Oops, typo on my end. I meant "I don't see how we _can_ reasonably
argue". I am saying we don't have enough justification (yet) for a lot
of the code changes in this series.

>
> > In our internal implementation, the only dependent device that truly
> > needed to participate is the PF driver when a VF is preserved.
> > Everything else (e.g. pcieport callbacks) have just been no-ops.
>
> Your VF device does not need to preserve DMA? If you want to preserve
> DMA the bus master bit is required, and the pcieport driver for the
> PCI-PCI bridge is also required. I am not sure pure VF and PF without
> any DMA makes practical sense.

I'm saying the only drivers that actually needed to implement Live
Update driver callbacks have been vfio-pci and PF drivers. The
vfio-pci support doesn't exist yet upstream, and we are planning to
use FD preservation there. So we don't know if driver callbacks will
be needed for that. And we don't care about PF drivers until we get to
supporting SR-IOV. So the driver callbacks all seem unnecessary at
this point.

I totally agree we need to avoid clearing the bus master bit. Let's
focus on that.

