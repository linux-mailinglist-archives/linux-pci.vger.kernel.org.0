Return-Path: <linux-pci+bounces-33150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B78B15807
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 06:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE66188EC92
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 04:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9881ACED7;
	Wed, 30 Jul 2025 04:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A11oTT8m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5443D6D
	for <linux-pci@vger.kernel.org>; Wed, 30 Jul 2025 04:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753848821; cv=none; b=DWomVogh2kZGCXgTtY6dNJoIC7Z0C9XvC2gTX12xHUojTVD/dUn6JtorvdfeerjrfZSa3FvLX7+U2VpY6zd2wz7NmR3TLAjdRMwlnpHf69y/Ts/oVCRPj14WzyMLurjNtoFIuv1Fi/Gwj8IcA+E1NAOG0Fo9wSJJcU7bTPJbMrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753848821; c=relaxed/simple;
	bh=u4ONMPNV1e226IoRdk+0SxrMUIZ9edw6CLFRloHunaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W6VCIQ2MXwY2lFU/3wNPU16zIZgCFQs+zmImnr9dydltPfOPBxxMajajFT/qu6ItnxGWO47am2xElaCRCayuoayOpaIt7oChFRqF/1XF4t7n2jQyGwtM7Hbpp7x/T7O5FI1MsMMdJ7JI/kGBfAYe8tm7fEap7PCfw7QrJa7xpH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A11oTT8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB192C116D0
	for <linux-pci@vger.kernel.org>; Wed, 30 Jul 2025 04:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753848820;
	bh=u4ONMPNV1e226IoRdk+0SxrMUIZ9edw6CLFRloHunaU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A11oTT8mqDuV3dTYJKjyr5dRTThCPjcoaXlGWWvzrPFsA6FhRIvIIxEVcz35FHtta
	 YnQm62emkU712aTZph3kpbiqI0A5li/jRxU2Sf1NzAaNvvKaA90l6akmdxjcXDFnJB
	 EaARRwt8rgdeo4wXuJ7B0mdjZQFiLIAzP25b1ZjmwPhcWTKsGsDAHBYCqVRmkN1GSD
	 qbrTsSwQmsvbT6PToDg+Cxj12fkcgHPC8SBg723mmixw5HR4SRxf8sBjZpxLdxuWe9
	 mliVDKEjPkGiLGhxVJzXZ76wdM82/ESD9l9kCn+Q51cQkNQATOkUi6nYK3wBinnQS8
	 llzjgEWf0W8Iw==
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-455b63bfa52so25355e9.0
        for <linux-pci@vger.kernel.org>; Tue, 29 Jul 2025 21:13:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlIdfV02bRPgSFub9M+ypOpOt2PAFH+Wo/jvbSX/iyRgmkzEA98RZYMkAl7Oatg0J11jcEKs+USyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXyzLs6F0fD/Mjla8jD4FPYqcqOcUHOdd1yal2W8J8cE0iMP4R
	J3wOnH3bmZf26UMmlnEFAgjMQSxv9WTEHzNa1OoaNuwI1i7owHrGavVgsWgRli0JV7Rfia5lWST
	pVN593m/78j7QULqr+yHbU8kofGqc+NIer0deldY4
X-Google-Smtp-Source: AGHT+IE86cxrjgiol61D7GGyywcZ5JoURqNhCrxZQgzpT94Yq0vxKz4CPMhrZ/PhWQ0NhFkt7FhNODDGLjzx7fV9eaw=
X-Received: by 2002:a05:600c:4694:b0:442:feea:622d with SMTP id
 5b1f17b1804b1-458953ca864mr685235e9.1.1753848819043; Tue, 29 Jul 2025
 21:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
 <20250728-luo-pci-v1-20-955b078dd653@kernel.org> <87zfconsaw.ffs@tglx> <20250728235032.GE26511@ziepe.ca>
In-Reply-To: <20250728235032.GE26511@ziepe.ca>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 29 Jul 2025 21:13:27 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPQSHdh_ybGt1N2Tr_keqfGHikXeJj=XMR9H_Xh8SV5tA@mail.gmail.com>
X-Gm-Features: Ac12FXyJzD-mt_VBqytZx7EWbsvZ9f59z1jq9EVVC4AoeuOkfYjVI_F6eyC-iJg
Message-ID: <CAF8kJuPQSHdh_ybGt1N2Tr_keqfGHikXeJj=XMR9H_Xh8SV5tA@mail.gmail.com>
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
	Leon Romanovsky <leon@kernel.org>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 4:50=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
> > Then you sprinkle this stuff into files, which have completely differen=
t
> > purposes, without any explanation for the particular instances why they
> > are supposed to be correct and how this works.
>
> Yeah, everyting needs to be very carefully explained.

Agree. I did some explanation in my last email reply to Thomas. Will
add a document for the next version.

>
> For instance I'm not sure we should be doing *anything* to the
> MSI. Why did you think so?
>
> MSI should be fully cleared by the new kernel and the new VFIO should
> re-establish all the MSI routing from scratch as part of adopting the
> device. We already accept that any interrupts are lost during the
> kexec process so what reason is there to do anything except start up the
> new kernel with a fully disabled MSI and cleared MSI?

The current approach is that we fake/inject a spurious interrupt to
the device to allow the device driver to have a chance to process any
pending action for the interrupt. There is also a possibility there is
nothing the device driver needs to do due to no interrupt having ever
triggered in the kexec window.  We expect the driver can tolerate that
spurious interrupt.

The alternative is to try to (partially) process the interrupt during
kexec. e.g. remember which IRQ has the interrupt triggered. It will
make things much more complicated. Invoke interrupt handler in the
early boot stage before IOMMU is very tricky.
>
> If otherwise it should be explained why we can't work this way - and
> then explain how the new kernel will adopt the inherited operating MSI
> (hint: I doubt it can) without disrupting it.

Agree.

>
> Same remark for everything. Explain in the commits and perhaps a well
> placed comment why anything needs to be done and why exactly we can't
> use the cold boot flow for each item.

We certainly can do that.

I am trying to see if we can agree on the VFIO_PCI device used by the
VM. We don't want any config space register to change during the
liveupdate kexec (before finish). We can certainly change what config
space register might or might not break stuff. But it is going to be
very hard to test and verify what can break if we change this.

If we can draw a line and say, there is no config space to write to
the device between freeze and finish. It is much easier to reason from
the device point of view, the device should continue working. The
device has no way of knowing the host kernel has been changed. The
device has only a limited view of their config space, the DMA area it
can read/write to. If we preserve enough stuff, the device should
continue working. For most of the devices, we can reason with the
model that keeping the status quo will not break things.

There is an obvious exception to that, e.g. if the device has a
watchdog timer it needs to kick at regular intervals, if that interval
is shorter than the kexec cycle. It should be pretty rare and we can
deal with those when we actually encounter one.

>
> eg "we can't use the cold boot flow for BAR sizing because BAR sizing
> requires changing the BAR register and that will break ongoing P2P
> DMAs"
>
> "we can't use the cold boot flow for bridge windows because changing
> the bridge windows in any way will break ongoing P2P DMAs" (though you
> also need to explain why the cold boot flow would change the bridge
> windows)
>
> etc etc.

There will be some config space register hard to make sure changing it
will break things or not.
e.g. The base BAR register, if we change to a new memory region, and
all follow up write to the device using a BAR new address, should
things continue working? Will have a lot of corner case like this, it
is much easier to just avoid changing anything to make things
consistent.

>
> There is also some complication here as the iommu driver technically
> owns some of the PCI state, and we really don't want the PCI Core to
> change it, but we do need theiommu driver to affirm what the in-use
> state should be because it is responsible to clean it up.

Yes, there is overlap between PCI and IOMMU, more than just config
space write. The IOMMU needs to know which PCI device participates,
which set of groups it needs to save. CC Samiullah here, he knows more
about the IOMMU side of the liveupdate than I do.

> This may actually require some restructing of the iommu driver/pci
> core interfaces to switch from an enable/disbale language to a 'target
> state' language. Ie "ATS shall be on and ATS page size shall be X".
>
Ack.

I have some ideas to make the PCI initialization cleaner for this
usage as well. Instead of directly initiating and turning on features
if found. We can do in 3 stages:
1) enumerate PCI capability and get the list of capability available
but don't turn them on yet.
2) determine what capability needs to be turned on/off. For the normal
initiation without liveupdate, the current behavior mostly turns on
whatever can be turned on. For liveupdate devices, it would be
inherent the on/off from what the previous kernel hands off to the new
kernel. By either 1) reading the device state (assume reading state is
possible and does not change device state) or 2) previous kernel save
state into preserved folio and new kernel reads the state from
preserved folio.
3) Perform the action to turn on/off the according the result from 2).
For live update devices the most common case is skip write, that will
be noop. For normal initialization without liveupdate, it will turn on
the capability.

> This series is very big, so I would probably try to break it up into
> smaller chunks. Like you don't need to preserve bridge windows and
> BARs if you don't support P2P. You don't need to worry about ATS and
> PASID if you don't support those, etc, etc.

Yes, I can break it to smaller chunks.

One of the deliverables of this patch series is that I can test the
liveupdate with the pci-lu-stub and pci-lub-stub-pf driver. Having
additional patch to verify no PCI config space write has performed on
the requested PCI device during shutdown and kexec boot up.

> Yes, in the end all needs to be supported, but going bit by bit will
> be easier for people to understand. Basic VFIO support with a basic
> IOMMU using basic PCI with no P2P is the simplest thing you can do,
> and I think it needs surprisingly little preservation.

Yes, that is certainly possible ;-)

Because I am working on the PCI side of the liveupdate, there are
other developers working on VFIO and IOMMU depending on my PCI
changes. From the project development point of view the PCI change
needs to happen first, to unblock others. That is how I get here.

I can certainly break it down to smaller chunks.

Chris

