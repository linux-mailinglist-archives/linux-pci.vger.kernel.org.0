Return-Path: <linux-pci+bounces-37306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0318ABAECB3
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 01:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C7A16DF02
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 23:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646A52D2385;
	Tue, 30 Sep 2025 23:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSbsHI+w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB662D130C
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 23:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759275717; cv=none; b=gd2X+W8487jfzW3vDpkLaP8SbDdzrs+764QD61glySy/SdRrZQsgevN3Q2VLAfxntzJvdeEvh906S009GCCkw7+PYN/a//3pvL9jEQMnKjC6FV4DASDyW0YdCpEQZnwjBNbLW28tWjqxufNN2yiqXrv+IFFZne21YYPTK50BWCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759275717; c=relaxed/simple;
	bh=ou8zqcPR7U4f86dX0hDK17PGEqR25IhF/uTAk3Ga9Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dRV28+KjGHFyQ0Bi9DAjXj6fxhB4/Kad/Kwx8WGH1+PUW51AnKy+6IzY3SMUhN0u91c8OQ138JcBLW3p9GrIhqKhKPFPym30k5NPHgux0FxlZ0MTNjQ6wABDDrNpWEUXtcb0VugRWYV5vZrnxuJfUG7Lv7N05RKWJDt773xcM6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSbsHI+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B58C4AF09
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 23:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759275716;
	bh=ou8zqcPR7U4f86dX0hDK17PGEqR25IhF/uTAk3Ga9Is=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GSbsHI+wZr83ZAR/Y34kVjxLMA9vohcAKZIbQ6P00EKhal6S7NAmu4FJ2iFEPKts0
	 3Qtdr6bBijcC8kcPSZxP4EZo4TyvZrBIIHiNVYuM8OteoOo8goYotexG/P/6CmLWsV
	 HAdJZGWaQHuSr0MxcdfEu8WZHHknCESqTwnwlRTd0TYqgPENGRa1TuxeBq55AP7wEH
	 e30qMuaKRQy0S7KXnHQgUyAwhFxuG18jgBHJfr2A5M+Bf2uH4j/XAf843gCSlykr7S
	 qHOA2PQ/vLRXk9V6ge5Q0AlrpJN2XwevhiPhvuS3yczHbfUITyNupVMtEVOUXHe7+j
	 MSTmWYOeAtoiw==
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e2b7eee0dso11465e9.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 16:41:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxyemNEe0BQeq8cMYpetina4nTK81kWQKp7rxY5FNcuUoFUjhNYnLoW2Q0ZLQPXbOWhpgImwcDxGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6wbCNMNBI39IfT9cL2wCroCXwi2mVIyyq52K7RgUzKl+uCzd8
	yRbOaiqCnYuYk/fSqciVer3FCe0gXYQDGCaErG5y0bcQKOvQDDzv0BOQGNiW7NTCnqRNn7x+dJQ
	Va9wDJSLdAJ8H+gWXSJ0jRf6vpc0sOysvxOKbfdz1
X-Google-Smtp-Source: AGHT+IHmIOQHJd86DZ4BzMyUX1T3L8l+LnN+ww//qAg6d+wkwbceHhSERLMH66FgHpSRc9v38ZwtMo6hKcUWcN0a0xE=
X-Received: by 2002:a05:600c:a40a:b0:45f:2949:7aa9 with SMTP id
 5b1f17b1804b1-46e61bde4c4mr662715e9.6.1759275715534; Tue, 30 Sep 2025
 16:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-1-c494053c3c08@kernel.org> <2025093018-snugly-twisty-91b1@gregkh>
In-Reply-To: <2025093018-snugly-twisty-91b1@gregkh>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 30 Sep 2025 16:41:43 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNLtqcMtKa0v_UVtw3Zd2o+1d0j+kM5+UOfJA_52PNSiQ@mail.gmail.com>
X-Gm-Features: AS18NWBb2I2szZCT5I-rvN0Zf16cBHJfCErKNR81663S2r6pIKbltxfL16vpcxI
Message-ID: <CAF8kJuNLtqcMtKa0v_UVtw3Zd2o+1d0j+kM5+UOfJA_52PNSiQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] PCI/LUO: Register with Liveupdate Orchestrator
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 8:31=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 16, 2025 at 12:45:09AM -0700, Chris Li wrote:
> > Register PCI subsystem with the Liveupdate Orchestrator
> > and provide noop liveupdate callbacks.
> >
> > Signed-off-by: Chris Li <chrisl@kernel.org>
> > ---
> >  MAINTAINERS              |  2 ++
> >  drivers/pci/Makefile     |  1 +
> >  drivers/pci/liveupdate.c | 54 ++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 57 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 91cec3288cc81aea199f730924eee1f5fda1fd72..85749a5da69f88544ccc749=
e9d723b1b54c0e3b7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14014,11 +14014,13 @@ F:  tools/testing/selftests/livepatch/
> >
> >  LIVE UPDATE
> >  M:   Pasha Tatashin <pasha.tatashin@soleen.com>
> > +M:   Chris Li <chrisl@kernel.org>
> >  L:   linux-kernel@vger.kernel.org
> >  S:   Maintained
> >  F:   Documentation/ABI/testing/sysfs-kernel-liveupdate
> >  F:   Documentation/admin-guide/liveupdate.rst
> >  F:   drivers/misc/liveupdate/
> > +F:   drivers/pci/liveupdate/
> >  F:   include/linux/liveupdate.h
> >  F:   include/uapi/linux/liveupdate.h
> >  F:   tools/testing/selftests/liveupdate/
> > diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> > index 67647f1880fb8fb0629d680398f5b88d69aac660..aa1bac7aed7d12c641a6b55=
e56176fb3cdde4c91 100644
> > --- a/drivers/pci/Makefile
> > +++ b/drivers/pci/Makefile
> > @@ -37,6 +37,7 @@ obj-$(CONFIG_PCI_DOE)               +=3D doe.o
> >  obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) +=3D of_property.o
> >  obj-$(CONFIG_PCI_NPEM)               +=3D npem.o
> >  obj-$(CONFIG_PCIE_TPH)               +=3D tph.o
> > +obj-$(CONFIG_LIVEUPDATE)     +=3D liveupdate.o
> >
> >  # Endpoint library must be initialized before its users
> >  obj-$(CONFIG_PCI_ENDPOINT)   +=3D endpoint/
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..86b4f3a2fb44781c6e323ba=
029db510450556fa9
> > --- /dev/null
> > +++ b/drivers/pci/liveupdate.c
> > @@ -0,0 +1,54 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Copyright (c) 2025, Google LLC.
> > + * Chris Li <chrisl@kernel.org>
> > + */
> > +
> > +#define pr_fmt(fmt) "PCI liveupdate: " fmt
> > +
> > +#include <linux/liveupdate.h>
> > +
> > +#define PCI_SUBSYSTEM_NAME "pci"
> > +
> > +static int pci_liveupdate_prepare(void *arg, u64 *data)
> > +{
> > +     pr_info("prepare data[%llx]\n", *data);
>
> You do know that's a security bug, right?

Right, it is useful during debugging and inspecting the preserved data.

My bad and will remove the raw pointer.

>
> Please don't do this, even in "debug" code, as it can escape into the
> wild...

Fully agree. Thanks for catching it.

Chris

