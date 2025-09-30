Return-Path: <linux-pci+bounces-37239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4732BAAF3F
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 04:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C373B57AB
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 02:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1031B207A20;
	Tue, 30 Sep 2025 02:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qr64HeHP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1BC1EC018
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 02:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759198255; cv=none; b=XLLBhDh/7Pn5ooBqhlsn8TzRRapQyETL9OrqNqJMt9p70qaoVWrUb2PIBFbBSd32NOLeOQnWXEDgljAmzd8yO8ZjsBnRgO658rnfrabNQeTZn8WUTz0yrOEVjFuuPhUY1HA7aHOKbhXL7G/saOjDOD/rwRoBgZhhIMddeCR2bao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759198255; c=relaxed/simple;
	bh=pgFQsTF0go03+MO1TNumSWtUMq2/R2Z0cHsYWuoyf8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOXR151ZX9C7i2kehvbSOlpCJEwIf82Z7PdN+77N+kG6LLiIKCDRC4+ZoPkbPiKLIlIe1ESXgvYl7W7DwJj86qC5leGhrYf1GhZ/7A/83tfLcf/ISYB7FSwzUHe5SS1zCTQGyg6CjyhcMN5Erz1u199xlJKdy4a4Q5fAuuwjpsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qr64HeHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79827C19424
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 02:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759198254;
	bh=pgFQsTF0go03+MO1TNumSWtUMq2/R2Z0cHsYWuoyf8E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qr64HeHPoM8jqsaSheaNhPCCPeQ1elbZXo9bp0t5cTex4Ann6+1eSt2AGG5Kj2yde
	 Pt8iqZPbv+Klxp1/Hh87iFjpuGkgaijgr0fX/GsoYQYM3TRIuhtem2zYoHA3Srcvj7
	 opZp9+pRu8nb/D3hnJ/QFEi4D0NgC4dLb5RWai6fGyQwHopmDAZu6s2g2CkSKw0+Z/
	 pafokvJjCgWPsKgPHvKIlCw7koxmCPfSfgX6OLRKHhxl+uu+JhPrXXTL5dDUiX98Vi
	 S6C4BZaW4I6CfrScXfLhRvHYkRsZlT+PmMAaWi4m+/lhjIrHIYnHk1fO+5XE3LRAiW
	 NFf0GIE49VJ3w==
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e2b7eee0dso17915e9.1
        for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 19:10:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHlO4R85TKnYRfKN4T3IkGn9OxJpMAnJCpyFkl12I4ymBFLEF0dM1Cd2QdzsnPFe/bdtf+QOF4HCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAWjpjTFubR0YCWT0u3sfTIcWvA3b8IsWoSJ0MPl8KlP/F2kdU
	7XhtqYEpcT0YMFKVqJl/neQkqVtQepbhP/ere+O3slSIbtsUi/Dh3zEQ+9ijIoIjgxeT5Go90nI
	ZpKPA2mTgChD79AjQyRq5XXTMO++/7eL8KZbirBRJ
X-Google-Smtp-Source: AGHT+IHAG3V5R9Lhg6msr+BcJHqtcjU3Z5BD2NkoFasZmfnaXmoRgIHQcea02VkehcGY/2PxhI1EHOE36OtShOfb0Q8=
X-Received: by 2002:a05:600d:3:b0:46e:1aac:1646 with SMTP id
 5b1f17b1804b1-46e59c09785mr856195e9.0.1759198253081; Mon, 29 Sep 2025
 19:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-6-c494053c3c08@kernel.org> <20250929175704.GK2695987@ziepe.ca>
In-Reply-To: <20250929175704.GK2695987@ziepe.ca>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 29 Sep 2025 19:10:41 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
X-Gm-Features: AS18NWC-vaCgpketj6DWsFpbQIRfi173ydEcEh5SUDIiZOfbAHSC8Mr6R50ydIs
Message-ID: <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] PCI/LUO: Save and restore driver name
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 10:57=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Tue, Sep 16, 2025 at 12:45:14AM -0700, Chris Li wrote:
> > Save the PCI driver name into "struct pci_dev_ser" during the PCI
> > prepare callback.
> >
> > After kexec, use driver_set_override() to ensure the device is
> > bound only to the saved driver.
>
> This doesn't seem like a great idea, driver name should not be made
> ABI.

Let's break it down with baby steps.

1) Do you agree the liveupdated PCI device needs to bind to the exact
same driver after kexec?
To me that is a firm yes. If the driver binds to another driver, we
can't expect the other driver will understand the original driver's
saved state.

2) Assume the 1) is yes from you. Are you just not happy that the
kernel saves the driver name? You want user space to save it, is that
it?
How does it reference the driver after kexec otherwise? If the driver
has a UUID, I am happy to use that driver UUID. But it doesn't. Using
the driver name can match to the kernel PCI driver_override framework.
If we are not using driver_override API, we need some other API to
prevent it from binding to other drivers.

Do you just want the kernel not to save it and the user space(initrd)
to save the driver name? Some one needs to bind that driver_override
when the PCI device is enumerated. Specify in the initrd before the
PCI enumerate would be too early. It hasn't found the PCI saved device
state. After the PCI enumeration would be too late.

> I would drop this patch and punt to the initrd. We need a more
> flexible way to manage driver auto binding for CC under initrd control
> anyhow, the same should be reused for hypervisors to shift driver
> binding policy to userspace.

What is CC stand for?

Once in the liveupdate, the livedupdated device and the binding driver
is fixed. It seems (to me) more complicated to let the initrd fetch
the livedupate saved state and then do stuff with it. The initrd is
not part of the kernel, more like user space programing. It is not
able to get the LUO API to get the list of preserved PCI devices etc.
We can add an API route to the user space accessing preserve data in
the kernel.  But that seems to be extra complexity stuff.

Once it is in the liveupdate, there is no flexible driver binding
policy for the device currently liveupdate, the device needs to bind
to its original driver.

I feel that I am missing something, please help me understand.

Chris

