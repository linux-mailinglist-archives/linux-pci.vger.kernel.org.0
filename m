Return-Path: <linux-pci+bounces-37772-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266D3BCA57E
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 19:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC2D4270A5
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 17:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F3323ED5B;
	Thu,  9 Oct 2025 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfZNt8xq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52259202976
	for <linux-pci@vger.kernel.org>; Thu,  9 Oct 2025 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760029988; cv=none; b=Rdii5dw6E349QcWQjwqoHyDl+zey0a9OZO6dLVxWo7qFkVqfJpx/eCaCTKUBCKajYEsd1mJ2h5ragbeYAx29Zpj8R8UZF3iUkzt+IBh4lXVB0kYMosQ/YywKMbjBKMbV3PfPHfF4fxaWdTeMF7oHUEXLAJduPHBuca9Qn2r3y1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760029988; c=relaxed/simple;
	bh=bTB6nX2n7XAcSgCZIN5w/wYw1ImzrVTnmr4PGKYcGd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNx1Gm5Q6Qoo5BwKzAkW1DYd8BZxz5qH7TUNAZpnqduarXwr6l1i3bDyIaf3o8BjnBj0X9exEDlnJJXV/XcexQ0eiWoN2VmuCr0OZFEKuLA7QXWWxbabbG9rB2KOTfF1vX0DSfFeNCzdCyNDJ8wtWfbWIUFOjHv6ZmAJTjlXwfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfZNt8xq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5A6C116D0
	for <linux-pci@vger.kernel.org>; Thu,  9 Oct 2025 17:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760029987;
	bh=bTB6nX2n7XAcSgCZIN5w/wYw1ImzrVTnmr4PGKYcGd0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mfZNt8xqvdpCTliPpe2xucUF/4/F+DNTSCzJDSRqzoJ6nVbhhZu2FpeU+koIdhrd3
	 Ke7xBLThovOm7N0AOhkLBYJoWHMSnkKWxlGk/D2VsdDGQd6RwfqvRkT11N1kqoWUmX
	 lcX3SQc6dpWVnRW8+czBQF21uBUUSQAUayVY7OUPDRHOQ/4sYbjbFtGyN3xD+k/WFN
	 vdp2pbxAj+NjL7Z+7M1AEfkmXgZf5lSolif3cLj+AdruZzLdOt7ErjxB1Q/ln8mtbu
	 ODKZBtaw7Lbi1WP1NIE544dOO/B6JuehnOVn1ag/gIr88pLg8G1asfYtncp0ZC7+yH
	 RAjnjY8z1WUwg==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-72e565bf2f0so12952317b3.3
        for <linux-pci@vger.kernel.org>; Thu, 09 Oct 2025 10:13:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWg4sI86wZMAvz3AXDY9NCATUdJWEc0X3yKDBJWJaGUfEgBqjTQA2Sxo9d8CsUSA8QHkZL6ypBwUi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLOj6hcL7q8tXjmGJn+w2smzadejVaudBpIn6KLvbZ1Fkib5ts
	MXZA6seVXRfrIHhlx+O+vLvoB2KDB/kvzBoU5klRjFs3OsjYlPvl4guHUWaudWy9haJfcm+moR6
	APd0F36649Aqbnwe8UbeOEbleOjtIkuWYVDlFZ13JEg==
X-Google-Smtp-Source: AGHT+IGvYxKDw71e40j1lde3uPEIM/7eVY+zWC2bZpCm7C1jqNV5j5uAWu76e8vqoG+EQXZTzoREFVL2qq1Yk9qPz+o=
X-Received: by 2002:a05:690e:3c4:b0:627:4520:1374 with SMTP id
 956f58d0204a3-63ccb8bb22cmr6753493d50.30.1760029987009; Thu, 09 Oct 2025
 10:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+CK2bAbB8YsheCwLi0ztY5LLWMyQ6He3sbYru697Ogq5+hR+Q@mail.gmail.com>
 <20250929150425.GA111624@bhelgaas> <CACePvbV+D6nu=gqjavv+hve4tcD+6WxQjC0O9TbNxLCeBhi5nQ@mail.gmail.com>
 <CACePvbUJ6mxgCNVy_0PdMP+-98D0Un8peRhsR45mbr9czfMkEA@mail.gmail.com> <CALzav=devrsJ2=3bt_=Z7BwT2CE1sv7AGDjh4uCC7mWzD7UR4Q@mail.gmail.com>
In-Reply-To: <CALzav=devrsJ2=3bt_=Z7BwT2CE1sv7AGDjh4uCC7mWzD7UR4Q@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 9 Oct 2025 10:12:56 -0700
X-Gmail-Original-Message-ID: <CACePvbVD1qhRzZTbsxOdvmTsTPPxRGs0qD7QrO1pTWevzqhQGg@mail.gmail.com>
X-Gm-Features: AS18NWBoA3GL6CZ9-SXewQlQu9-HnJTfh8iTD7RpkM2_ASr3xKBCEkoXrBXHk64
Message-ID: <CACePvbVD1qhRzZTbsxOdvmTsTPPxRGs0qD7QrO1pTWevzqhQGg@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] LUO: PCI subsystem (phase I)
To: David Matlack <dmatlack@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, Pasha Tatashin <tatashin@google.com>, 
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 4:01=E2=80=AFPM David Matlack <dmatlack@google.com> =
wrote:
>
> On Tue, Oct 7, 2025 at 4:32=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote=
:
> >
> > Thanks to one that provides good feedback on the PCI series.
> >
> > I just want to give an update on the state of the LUO PCI series,
> > based on the feedback I received. The LUO PCI series should be called
> > from the memfd side and remove global subsystem state if possible.
>
> By "memfd side" I believe you are referring to LUO fd preservation
> (likely the VFIO cdev fd).

Yes. I haven't taken a closer look at the recent LUO fd preservation
series. It is on my to do list, now I am depending on it.

> > Which means the PCI series will depend on the VIFO or iommu series.
> > I have some internal alignment with Vipin (for VFIO) and Samiullah
> > (for iommu). Here is the new plan for upstream patch submission:
> >
> > 1)  KHO series go first, which is already happening with additional imp=
rovement.
> >
> > 2) Next is Pasha's LUO series with memfd support, also happening right =
now.
> >
> > 3) Next series will be Vipin's VFIO series with preserving one
> > busmaster bit in the config space of the end point vfio device, there
> > is no PCI layer involved yet. The VFIO will use some driver trick to
> > prevent the native driver from binding to the liveupdate device used
> > by VFIO after kexec. After kexec, the VFIO driver validates that the
> > busmaster in the PCI config register is already set.
>
> Yes. Last we discussed Vipin is planning to just compile out the
> native driver of the device he is using to test. So we don't expect to
> need any kernel code changes to unblock basic testing and posting the
> RFC.

Ack.

>
> >
> > 4) After the VFIO series, the PCI can start to preserve the livedupate
> > device by BDF. Avoid the driver auto probe on the livedupate devices.
> > At this point the VFIO driver in stage 3 will not need the other
> > driver trick to avoid the auto bind of native driver. The PCI layer
> > takes the core of that. This series PCI will have very limited
> > support, most of the driver callback is not needed, no bridge device
> > dependent as well.
>
> I suspect we'll need the new file-lifecycle-bound global state thing
> that Pasha is working on [1] to accomplish this. So please track
> LUOv5+ as a dependency for this.
>
> [1] https://lore.kernel.org/lkml/CA+CK2bB+RdapsozPHe84MP4NVSPLo6vje5hji5M=
KSg8L6ViAbw@mail.gmail.com/

Agree, I need to figure out the boiler plate change to hook up PCI to
the file descriptors.

Thanks for the clarification.

Chris

