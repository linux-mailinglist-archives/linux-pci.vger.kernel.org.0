Return-Path: <linux-pci+bounces-33321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C316CB1894A
	for <lists+linux-pci@lfdr.de>; Sat,  2 Aug 2025 01:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE64B165DBA
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 23:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605CC229B1F;
	Fri,  1 Aug 2025 23:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZK3uZiUV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0081FBEB9
	for <linux-pci@vger.kernel.org>; Fri,  1 Aug 2025 23:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754089492; cv=none; b=ans31dJav3H6rwzYXO2QDVCfJJopiVhuj+uM2v14QJiyqyMEn6nyEBLExOYimttOmTCUWZ33pkqoMRqIKUpYBxdg5Gz5YyW9+VBdYFjc6S1en6l3u+93QF3XZGTBxo40JHay9K8irKn1LwWHfQ53nG0qaPM3G6OhpscYgf++22g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754089492; c=relaxed/simple;
	bh=9KR/tNiOgAxan+X0qaqlPVk+bks29bd7diAxAiAcQGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvkZDytMjavOX3Hbe1T8u2FsSwoqzq1jvQUfh6MGSVDoyM0U3h3E4jnFPmq7bnTcKSn9L/ThoXKhRm4SVaKNQoRLd+Ab3p2IG5f/+vsRh/Mmm5kz/VLNjZdqL0ajYLAM9eT/hLEzNaGt1P7Xnl6vCVnoBaxZIVsFnqdMJCLEuoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZK3uZiUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC92DC4CEFA
	for <linux-pci@vger.kernel.org>; Fri,  1 Aug 2025 23:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754089491;
	bh=9KR/tNiOgAxan+X0qaqlPVk+bks29bd7diAxAiAcQGQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZK3uZiUVFwAWl30Yexuz/b/kEsVFNgxSShy0KDZ3dcj+PGh+5hZPIa7116Kw56oRi
	 xIUPfRhFO9abHI4foqY/U5fQcE+wR8hESz1RfQjERV2ELkGNIkPTGqrY+dDNr3l2iW
	 g/gdAulYF0jeO7UeLdLzIiQszVTsqmKrWSApYsDK01p5fhx0gYu08K5CuPgHuLXv5l
	 vJ7le98Img26C37dCWrsuOjRxMHZPfD5xU1rJj7CW1rRugCVokQX74RR554JHt/Nib
	 UJG3i6GTw0Rg78g5Vkig3L9XXjOKuHlQ6Sf6F0RPKZI+3yhElmAqPE+ZRBqAToRWhz
	 493UTA+fTfY8w==
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-456007cfcd7so11795e9.1
        for <linux-pci@vger.kernel.org>; Fri, 01 Aug 2025 16:04:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYc/1OPujfhjhoIl6aneRPMNkl/6LdeU3pF+k1GOlmOYydFDLLm+pdaVtyVL7de4ARrV6MFWiz9tM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIf8Uh/k2p/iCyDCMJPp8S2O54Y3pVK9Bm/q5mKath1LQZab/y
	tsb3zeH5GMuD0LhTvIlCHn3JgVKYSHulIrJUvhyuHvDJ9kuj2owGKLrXUtyJ1dillu8dOGaWxlV
	iZ+mOpNctP/l+vTbhet0y4cfI3K3YwsyNScC/tw3R
X-Google-Smtp-Source: AGHT+IHCeGxdJGl6Rwma71WQbR98WU5ymsS87qBsgPEiwP1y/FmbZ2BSVF4t0BFrnDfmre4oNRzorh3ZwFlO3Q8Byh0=
X-Received: by 2002:a05:600c:1c25:b0:439:8f59:2c56 with SMTP id
 5b1f17b1804b1-458b6e822b0mr517815e9.2.1754089490309; Fri, 01 Aug 2025
 16:04:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
 <20250728-luo-pci-v1-20-955b078dd653@kernel.org> <87zfconsaw.ffs@tglx>
 <CAF8kJuOM=2oEFP20xWtQ==ECwF_vNB032Os3-N12zY1xVau-yw@mail.gmail.com> <20250731150132.GV26511@ziepe.ca>
In-Reply-To: <20250731150132.GV26511@ziepe.ca>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 1 Aug 2025 16:04:39 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPbJWea+o=GTFEM6KRCq4DxDad+83+vM0Np+n=Mmzqzag@mail.gmail.com>
X-Gm-Features: Ac12FXzFtHTJHakYV4RYMb4cJgU-1h5y9qOlDd4pooYwaMDWI_1OEJfpSnDXlvk
Message-ID: <CAF8kJuPbJWea+o=GTFEM6KRCq4DxDad+83+vM0Np+n=Mmzqzag@mail.gmail.com>
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

On Thu, Jul 31, 2025 at 8:02=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Jul 29, 2025 at 06:51:27PM -0700, Chris Li wrote:
>
> > They follow a pattern that the original kernel needs to write to the
> > device and change the device state. The liveupdate device needs to
> > maintain the previous state not changed, therefore needs to prevent
> > such write initialization in liveupdate case.
>
> No, I fundamentally reject this position and your testing methodology.
>
> The new kernel *should* be writing to config space and it *should* be
> doing things like clearing and gaining control over MSI. It is fully
> wrong to be blocking it like you are doing just to satify some
> incorrect qemu based test checking for no config access.

First of all, let me clarify that the PCI PF and VF tests I mention in
the cover letter are run on the real data center servers, not qemu.
QEMU does not have the correct IOMMU simulation for my workstation
anyway. I do use qemu in development to quickly check if I screwed up
something badly. The real test is always on the real machine. Our
internal test dashboard has reached a high two digit number now, all
with real hardware.

With that out of the way. Let me explain why we did it the way we did.
I believe you and I eventually want the same thing, just different
ways to get there. I am also working on a series that allows fine
grain control of  PCI preservation. It allows the driver to select
exactly what needs to be preserved, rather than the current
"preserved" vs "depended" control. With the fine grain control, it can
basically do what you described, allow new kernel writes to config
space they don't want to preserve. However this RFC series is already
getting very long, that is why I did not include the fine grain
control series in this RFC. Keep in mind that this is just RFC, I want
to demonstrate the problem space, and what source code needs to be
modified in order to preserve all config space. It is not the final
version that gets merged. Your feedback is important to us.

My philosophy is that the LUO PCI subsystem is for service of the PCI
device driver. Ultimately it is the PCI device driver who decides what
part of the config space they want to preserve or overwrite. The PCI
layer is just there to facilitate that service.

Regarding the testing. There are many different tests we can write and
run. Preserving all config space is just one of them.  We also have
other tests that partially preserve the config space and write to some
config as it needs to. That is why I need to have the fine grain
control series.

If you still think it is unjustifiable to have one test try to
preserve all config space for liveupdate. Please elaborate your
reasoning. I am very curious.
With the fine grained control we let the driver decide what the driver
wants to preserve vs not, will that remove your objection?

> Only some config accesse are bad. Each and every "bad" one needs to be
> clearly explained *why* it is bad and only then mitigated.

That is exactly the reason why we have the conservative test that
preserves every config space test as a starting point. It does not
mean that is the ending point.  We also have tests that only partially
preserve the config space driver actually needs. When things break, we
can quickly compare to find out not preserving which register will
break which device. This incremental approach is very effective to
deal with very complex devices.

Another constraint is that the data center servers are dependent on
the network device able to connect to the network appropriately. Take
diorite NIC  for example, if I try only preserving ATS/PASID did not
finish the rest of liveupdate, the nic wasn't able to boot up and
connect to the network all the way. Even if the test passes for the
ATS part, the over test fails because the server is not back online. I
can't include that test into the test dashboard, because it brings
down the server. The only way to recover from that is rebooting the
server, which takes a long time for a big server. I can only keep that
non-passing test as my own private developing test, not the regression
test set.

That is the reason we to have some conservative tests passing first,
then expand to the more risky tests. We are actually quickly expanding
our test metrics for doing more and more interesting(and risky) stuff.

I hope that clarifies the eventual end goal and the development
approach we take.

> Most mitigation are far harder than just if'ing around the config
> write. My ATS/PASID/etc example for instance.

Exactly why we can't add those risky(non working) tests into the
dashboard before the conservative passing one.

Chris

