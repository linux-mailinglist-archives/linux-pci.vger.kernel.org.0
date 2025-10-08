Return-Path: <linux-pci+bounces-37743-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2906CBC6D46
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 01:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 130841887D4F
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 23:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F8E2472AE;
	Wed,  8 Oct 2025 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4k+zav9v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2667A253944
	for <linux-pci@vger.kernel.org>; Wed,  8 Oct 2025 23:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759964469; cv=none; b=vAomlO1fy5tEjGtOoi7Qi4JzOv3SsGtDjjs49EShD4O7L6qiRShflaeW99f/28jfORix1KZS2+zZAHmeAdO5Y9QnXaqsxmrz3mHChrWgmYAZHUlxmiFdPon3Wpusr475LNTc3+PW0YL1zW0IuL2V8Fh9CauKVJ6h9+NizMlEoLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759964469; c=relaxed/simple;
	bh=xSCzZSoFNIVVMMvqJmANRd4RPNUZrD1tSLMY1xNEJts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NdXA7vDH9nmLpeAw1jcjnhoBijmgfeWMGFevGy90p8mlIDLnFQgW1guHS7pJJy6v350IdYfNst0s0ergIbv40RPQWFC9MM45Qj9d2O71PFyab+ikX/38cTwucF5JyOuzyITb1mONKPzvw0PErBJKKABbPS5wbXpA8VkGHp4ZrYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4k+zav9v; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59054fc6a45so511433e87.3
        for <linux-pci@vger.kernel.org>; Wed, 08 Oct 2025 16:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759964463; x=1760569263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3Qsmd18hGmmRv7FNEbGBjan8dX6PZa1OjOazixrrCY=;
        b=4k+zav9vjOBp5VM4dctXf9DqQtKdVov5dFtIdtxNsrALqdXFCnKm57CV6X8P50lkNo
         5HFnzGCcZx3vACPpAY4C37hw0+xBA9Yd20T4oNFVIRJg1q/FFJKCPgz1gljtDvtgm+Hn
         LSnD4WhIlRIWwRJVGFs8TqvRbdA9cw9o+8RZ0d6P729LMS24p34Sitxv0Eb30Atmzhwg
         Y7d0Aa6ozhbZr/xW5QHD4lbHGsnD0IOB6eyELNj4tGUs2ThWYV3b6DQv5H1vn/uKZoUT
         DFYwN8EOljn1+jiwtm9gGgKK+Rtb91QYdLcwmKSckrcPeEdpd7iZZQi/bms3j0hZ0L4l
         0h/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759964463; x=1760569263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3Qsmd18hGmmRv7FNEbGBjan8dX6PZa1OjOazixrrCY=;
        b=PGOaanTPEQGv3ce0ZYzUXIh6JrVNKnSOV4GiNHt5L0yWLjLYOUEx+/4TXu3evU8N1R
         v3FMYiHJh5mT70H2qGKAdXpSDlqlBhZNn1JSKN6ihOcLBh/cU1w0rLtwKAp+MmTXrGhF
         7wdqE0YSP1FTA6wef3vWe1DtEFEaNI4y8cr547u7Qpd7P5IgcyifT0/lUBFM9SIDbbOI
         oD+gzfDR5tyTQrdnkmLH8tNqlbJusWDsChykJ42ljUbFzpV3bjHyoJRnKUSvw6c1tdm/
         GYs8Yfe7UXmzPvBY+13eud24XEdw2Bmbk030YFVoQVm6eRKtnWurU3DVLAZHHRboQaOH
         2owQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQVD0vT9mczCr6cKho6G0fq1PQqeB1vO9dDX1XYADoBjJH92aYXO9rSqjprrWmSnmPx72MUgoXwlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAFSYceIfo1LqYvawOgQ9sW6E1UrZWhEPrby6Eao7NbBzH3GJn
	aBCW4P0py31uOfAt3LomjyS/kkNipdnLSZa3l58GOs5E9lHTrI5FrnSOdIMLfrz8u5mJfIo6qqf
	CxwgYVHFBhR2Q4cLlE+6Ml0poHyKp3g6aWVhgctyO
X-Gm-Gg: ASbGncuU0uBI3/0cwM1dLbmlhkzyK8blSsntyeeutiPe2yxAHevAAefmpiBO94gRlwo
	s4yNRNAKauKZoIyafCTGTGnQLQl4bYOUOHcGlFYMxWL5rd4aw4MvgQn0e5nKx3wx7LIlub6ZReE
	3IsEshfnynjKc7IlxWXVbn5KbXLTlTB/+hRNmlHW74pAafa+iTf6X4N7EXEdCJ6UZBB1Mjf9pu8
	573EdElaEb9NPzzSBBrv/1Sk1gOhwD6QKiDBjyIk9uukBkM
X-Google-Smtp-Source: AGHT+IGn3n7+tZovmOItuQsHB5LGTD1j9lG4aTPWXuOisPskCZnCaF4xryD7H+T/JqZ0aZPU5JOtkM6IhnqYlnZLvHg=
X-Received: by 2002:a05:6512:2251:b0:57c:2474:3733 with SMTP id
 2adb3069b0e04-5906dd7071emr1427501e87.42.1759964462828; Wed, 08 Oct 2025
 16:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+CK2bAbB8YsheCwLi0ztY5LLWMyQ6He3sbYru697Ogq5+hR+Q@mail.gmail.com>
 <20250929150425.GA111624@bhelgaas> <CACePvbV+D6nu=gqjavv+hve4tcD+6WxQjC0O9TbNxLCeBhi5nQ@mail.gmail.com>
 <CACePvbUJ6mxgCNVy_0PdMP+-98D0Un8peRhsR45mbr9czfMkEA@mail.gmail.com>
In-Reply-To: <CACePvbUJ6mxgCNVy_0PdMP+-98D0Un8peRhsR45mbr9czfMkEA@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 8 Oct 2025 16:00:33 -0700
X-Gm-Features: AS18NWCCGj6lm1VXnx1KasvZ4Kw3YH-VoT-EjN1gpen7EluaWzIhxfjufDibnTo
Message-ID: <CALzav=devrsJ2=3bt_=Z7BwT2CE1sv7AGDjh4uCC7mWzD7UR4Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] LUO: PCI subsystem (phase I)
To: Chris Li <chrisl@kernel.org>
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

On Tue, Oct 7, 2025 at 4:32=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> Thanks to one that provides good feedback on the PCI series.
>
> I just want to give an update on the state of the LUO PCI series,
> based on the feedback I received. The LUO PCI series should be called
> from the memfd side and remove global subsystem state if possible.

By "memfd side" I believe you are referring to LUO fd preservation
(likely the VFIO cdev fd).

> Which means the PCI series will depend on the VIFO or iommu series.
> I have some internal alignment with Vipin (for VFIO) and Samiullah
> (for iommu). Here is the new plan for upstream patch submission:
>
> 1)  KHO series go first, which is already happening with additional impro=
vement.
>
> 2) Next is Pasha's LUO series with memfd support, also happening right no=
w.
>
> 3) Next series will be Vipin's VFIO series with preserving one
> busmaster bit in the config space of the end point vfio device, there
> is no PCI layer involved yet. The VFIO will use some driver trick to
> prevent the native driver from binding to the liveupdate device used
> by VFIO after kexec. After kexec, the VFIO driver validates that the
> busmaster in the PCI config register is already set.

Yes. Last we discussed Vipin is planning to just compile out the
native driver of the device he is using to test. So we don't expect to
need any kernel code changes to unblock basic testing and posting the
RFC.

>
> 4) After the VFIO series, the PCI can start to preserve the livedupate
> device by BDF. Avoid the driver auto probe on the livedupate devices.
> At this point the VFIO driver in stage 3 will not need the other
> driver trick to avoid the auto bind of native driver. The PCI layer
> takes the core of that. This series PCI will have very limited
> support, most of the driver callback is not needed, no bridge device
> dependent as well.

I suspect we'll need the new file-lifecycle-bound global state thing
that Pasha is working on [1] to accomplish this. So please track
LUOv5+ as a dependency for this.

[1] https://lore.kernel.org/lkml/CA+CK2bB+RdapsozPHe84MP4NVSPLo6vje5hji5MKS=
g8L6ViAbw@mail.gmail.com/

>
> 5) VFIO device will continue DMA across the kexec. This series will
> require the IOMMU series for DMA mapping support. The PCI will hook up
> with the VFIO and build the list of the liveupdate device, which
> includes the PCI bridge with bus master big preserved as well.
>
> So I will pause the LUO PCI series a bit to wait for the integration
> with VFIO series.
> Meanwhile, I will continue to fix up the LUO PCI series internally for
> the other feedback I have received:
> - Clean up device info printing, remove raw address value (Greg KH, Jason=
).
> - Remove the device format string (Greg KH).
> - Remove the liveupdate struct from struct device, move it to the PCI (Gr=
eg KH).
> - Remove LUO call back forwarding and hook it up with the VFIO (Jason, Da=
vid)
> - Drive the PCI from memfd context on VFIO or iommu, no subsystem
> registration. (Jason)
> - up_read(&pci_bus_sem); instead of up_write (Greg KH)
> - Avoid preserving the driver name, just avoid auto-probing the
> liveupdate devices. Let user space do the driver loading in initrd
> (Jason).
>
> That will keep me busy for a while waiting for the VFIO series.

Sounds good. Thanks for the update Chris!

