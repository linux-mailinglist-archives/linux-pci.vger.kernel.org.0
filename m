Return-Path: <linux-pci+bounces-33502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B463B1CFDE
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 02:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E813E18C29EF
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 00:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4406849641;
	Thu,  7 Aug 2025 00:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTz9IEpv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F30E136E
	for <linux-pci@vger.kernel.org>; Thu,  7 Aug 2025 00:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754527851; cv=none; b=lFroqzXrQZZGbn766po9xgQj6A7ofBSHOYHUWsOW572L8oBar8GEAT3q3vpoWmse0UzGxKj+OBYb3uHZQznQqUtOpN/LKVfJ2itJ70oOYfKva0fSUruMl6ifLbxrrpkQGr/0mRj+lvx+El3s1MWJaftJI3hodheuOi1tfDXJ79A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754527851; c=relaxed/simple;
	bh=grPj4nUiqlg/GvMehvwd/PM7Ps+66XCt4iskjSNeqTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NtjbB7Rxnww6j4Bz82sIiK/xA1e3vOmz6bKfNezgRd/jCVzVhM5kZFpeo32oca+fYNUES7sIfPOJGf5xuPIg4rcFFW/oNrnaroADvuy4Vxqrz95DHskGup4s7ZQJ5poNCqtbxcL/TfedAT6S0FDb6DNATl3yXZOozKzFoLjlMrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTz9IEpv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42C4C4CEF9
	for <linux-pci@vger.kernel.org>; Thu,  7 Aug 2025 00:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754527850;
	bh=grPj4nUiqlg/GvMehvwd/PM7Ps+66XCt4iskjSNeqTI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HTz9IEpvRGU5Kag0/OLxpBfg31H/M5cMUEZ3opwD93imc7f4sGxKgs3oUex89I2nb
	 hxzO6iowo+ZbiQ70YFpfKaBTo/wZ1uDMb3ImAwgkUtrprdBZ/C7w1GSZ85i9S2wINF
	 flqmfWsLLtA7qsIVS5IR2pkuUqjXvBh9SIoIkJcYGTgIpPKsPLM58AvSkhXVLjzvPk
	 qvejLXRMKRvkwtIY9Dyp2rSxbxSOZPw0Dnu4di3x/SBgqtzC0fYPSfeTTUGajbYr2d
	 k840k1dNkB+jRAMX/wnJPz4hATkHNcA5iGcyQR9p+xJkmaG4YiRPu88jd0T5Z69vR5
	 xgQphFzj9cBCQ==
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-459b3904fdeso18235e9.1
        for <linux-pci@vger.kernel.org>; Wed, 06 Aug 2025 17:50:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXPlBaefbS4lTWOVAOI8NZO44GuYK3vvlTrMMGaHV9a9aPfJvbitSTl5YwgBY6cM5p3pT6y25kd7x0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKzM3O0mx9P4c8iK6sjVHxnsp4gLfNnb/DqNH+GjW8nQ9ao+PF
	Zpa/OUqKUuOcca991goNr1YSM1lvcjHWBmxJHjaKVw5WlxaeR//wfquAPFp++e9bvOkTxzcnMSp
	p6jgMbSC9XAGiGwIjk5aMW+j7LOnFj62f2Dc69fqN
X-Google-Smtp-Source: AGHT+IGd7AVqzUBj3ViITTLxWIkbOiciEeiGJAqp3Zj3Tc1+LEEggLoa5F5uWFg80218MiuBPCcZLN8HDT/+zDOogCY=
X-Received: by 2002:a05:600c:a215:b0:453:65f4:f4c8 with SMTP id
 5b1f17b1804b1-459eee38e99mr254455e9.3.1754527849296; Wed, 06 Aug 2025
 17:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
 <20250728-luo-pci-v1-20-955b078dd653@kernel.org> <87zfconsaw.ffs@tglx>
 <CAF8kJuOM=2oEFP20xWtQ==ECwF_vNB032Os3-N12zY1xVau-yw@mail.gmail.com>
 <20250731150132.GV26511@ziepe.ca> <CAF8kJuPbJWea+o=GTFEM6KRCq4DxDad+83+vM0Np+n=Mmzqzag@mail.gmail.com>
 <20250802135034.GJ26511@ziepe.ca>
In-Reply-To: <20250802135034.GJ26511@ziepe.ca>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 6 Aug 2025 17:50:37 -0700
X-Gmail-Original-Message-ID: <CAF8kJuN4yjBzaTuAA9wERbxbJQs=YSf-1RY_nHu+XvMybpYbfA@mail.gmail.com>
X-Gm-Features: Ac12FXwr_lgsbosoQEiUbhniouBJKo-bOKc3xyjaNCaRQ66umGk7SeForY_LB9o
Message-ID: <CAF8kJuN4yjBzaTuAA9wERbxbJQs=YSf-1RY_nHu+XvMybpYbfA@mail.gmail.com>
Subject: Re: [PATCH RFC 20/25] PCI/LUO: Avoid write to liveupdate devices at boot
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, Junaid Shahid <junaids@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jason,

Thanks for your feedback.

On Sat, Aug 2, 2025 at 6:50=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Fri, Aug 01, 2025 at 04:04:39PM -0700, Chris Li wrote:
> > My philosophy is that the LUO PCI subsystem is for service of the PCI
> > device driver. Ultimately it is the PCI device driver who decides what
> > part of the config space they want to preserve or overwrite. The PCI
> > layer is just there to facilitate that service.
>
> I don't think this makes any sense at all. There is nothing the device
> driver can contribute here.

I am considering that the device driver owner will know a lot more
device internal knowledge, e.g. why it needs to reserve this and that
register where the PCI layer might not know much about the internal
device behavior.

> > If you still think it is unjustifiable to have one test try to
> > preserve all config space for liveupdate.
>
> I do think it is unjustifiable, it is architecurally wrong. You only
> should be preserving the absolute bare minimum of config space bits
> and everything else should be rewritten by the next kernel in the
> normal way. This MSI is a prime example of a nonsensical outcome if
> you take the position the config space should not be written to.

OK. Let me rework the V2 with your approach.

>
> > > Only some config accesse are bad. Each and every "bad" one needs to b=
e
> > > clearly explained *why* it is bad and only then mitigated.
> >
> > That is exactly the reason why we have the conservative test that
> > preserves every config space test as a starting point.
>
> That is completely the opposite of what I said. Preserving everything
> is giving up on the harder job of identifying which bits cannot be
> changed, explaining why they can't be changed, and then mitigating
> only those things.

We can still preserve every thing then work backwards to preserve
less.  As I said, I will rework V2 with your approach preserving bare
minimum as the starting place.

> > Another constraint is that the data center servers are dependent on
> > the network device able to connect to the network appropriately. Take
> > diorite NIC  for example, if I try only preserving ATS/PASID did not
> > finish the rest of liveupdate, the nic wasn't able to boot up and
> > connect to the network all the way. Even if the test passes for the
> > ATS part, the over test fails because the server is not back online. I
> > can't include that test into the test dashboard, because it brings
> > down the server. The only way to recover from that is rebooting the
> > server, which takes a long time for a big server. I can only keep that
> > non-passing test as my own private developing test, not the regression
> > test set.
>
> I have no idea what this is trying to say and it sounds like you also
> can't explain exactly what is "wrong" and justify why things are being
> preserved.

I know what register is causing the trouble but I think we are under a
different philosophy of addressing the problem from different ends.
Another consideration is the device testing matrixs. The kexec with
device liveupdate is a rare event. With that many device state
re-initializing might trigger some very rare bug in the device or
firmware. So it might be due to the device internal implementation,
even though PCI spec might say otherwise or undefined.

Anyway, let me do it your way in V2 then.

> Again, your series should be starting simpler. Perserve the dumbest
> simplest PCI configuration. Certainly no switches, P2P, ATS or
> PASID. When that is working you can then add on more complex PCI
> features piece by piece.

With the V1 the patch series deliverable is having an Intel diorite
NVMe device preserve every config space access and pass to the vfio
and iommu people to build the vfio and iommu on top of it. Let's
forget about V1.

With V2 I want to start with the minimal end. No switches,P2P, ATS or
PASID. I need some help to define what is deliverable in such a
minimal preserve. e.g. Do I be able to read back the config value not
changed then call it a day. Or do I expect to see the device fully
initialized, it is able to be used by the user space. Will the device
need to perform any DMA? Interrupt?

I will probably find a device as simple as possible and it is attached
to the root PCI host bridge, not the PCI-PCI bridge.
Maybe no interrupt as the first step. One possibility is using the
Intel DSA device that does the DMA streaming.

If you have any other feedback on the candidate device and deliverable
test for V2, I am looking forward to it.

Thanks.

Chris

