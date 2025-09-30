Return-Path: <linux-pci+bounces-37304-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 821C9BAEC8E
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 01:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D82A3A7058
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 23:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6602D1931;
	Tue, 30 Sep 2025 23:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tT+DMFav"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9A92C3251
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 23:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759275542; cv=none; b=s5+5zA/eQEPHQ4MAd9DTSjfX8h1FXRBNHIl9x6jaUE8GNsVU7LLIXGi9sSkq7X0GWnhA5kR8GxmJpqU/OpzRTMQIluB4mkHxM0GxIXc2/BdO7eQtuUva6dWG10EJGb9N6q9S5LMHu90OEIA+RWs2UZLiThTtHk+XYiN3Dcvz6oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759275542; c=relaxed/simple;
	bh=uoEaags9cvj4V9dXTIwpOjvo5TRbqVrRX+MjXZnzWmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNVP5NBGHlchJjL+cvP8LcpatBA0TX97vJfI7ynVDMxS/w7ppl9tQihe3ILel5B61r5HtidvXsLUA4J0zko44NfXadvbNeEraTpo+ejCODD5MtPs45L3SsM4xIOBLfXyD98MJvsY5JYpejPZVXnf+jr9of9/UxOWdqDW+xaqEqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tT+DMFav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F60C2BCB0
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 23:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759275542;
	bh=uoEaags9cvj4V9dXTIwpOjvo5TRbqVrRX+MjXZnzWmw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tT+DMFav2SKIcffHWszSEBTJkLenbg0LY5P3EtljDtV9tivPOw2a0ZAuIsWvejumj
	 Xcvkbu/ZQ0b7q5+v6CSuYDn18iP5m7pBz76KjVV/TSmXhLJktGJveSb1sklgKfsnl2
	 VevDH/gnLH3PhNjZ1qrVMQwbGJ9+skVOQGhdlV6IeweujomYDm2M3da2ahBX/rXZnN
	 ORBr76YYyzh2ScNZO/T8bmDwnaWJu9hGvyogJ6XiqpoBAPYOqO7Jq82Z7cX2ukp/lc
	 7C0hBTaaabO/PDM6C3pd5b1Oh2VoOpzdKt6sbzOHb/qcUIrVuIq5lVisBGkM00n+H/
	 0le6spp1E58ZQ==
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e3bcf272aso26585e9.0
        for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 16:39:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEAjesVHsn3XxUzUwnY5Q+El50M8hWxAlwFvoGUXHNqWJh5q1L1UDR3Or46VjRcbqAoq9s+VCjLa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnucDNbNuxerFAVrKFt6Mgc8J1sJhHNwcY+7OcPU4GbZ+MPx5Q
	Gl2FH0wZKCSZ/NZBZhtaTQ4WuRARaziZ6XBQC5B2UQy2achv9EZF0RVQtnb2RQvq7uGzUaHgv1v
	uDVfrVixMQpoCRkGJotOlk+9SpzxutCEC8Xu5sG8L
X-Google-Smtp-Source: AGHT+IGW2/qdhioiWERpaECvrg9VQsaWlrzDEBJ3gDhsR0VtryFnP36E7HLr3RLdANnbgkm+pmRQW55NN3zTH4k4qSk=
X-Received: by 2002:a05:600c:a10b:b0:453:672b:5b64 with SMTP id
 5b1f17b1804b1-46e61b8a883mr619555e9.2.1759275540420; Tue, 30 Sep 2025
 16:39:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-1-c494053c3c08@kernel.org> <2025093014-qualify-scoop-c406@gregkh>
In-Reply-To: <2025093014-qualify-scoop-c406@gregkh>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 30 Sep 2025 16:38:48 -0700
X-Gmail-Original-Message-ID: <CAF8kJuMXJ+JE=mJCNyz6ETNQ5evMh15VKo2wFreuZ=6Jz0aGWg@mail.gmail.com>
X-Gm-Features: AS18NWAUSgFUxtTB2q7O9k-Pi7VfFzzfrFZp7BtTF7h7cgw0DwnfuCv6HX1IMTE
Message-ID: <CAF8kJuMXJ+JE=mJCNyz6ETNQ5evMh15VKo2wFreuZ=6Jz0aGWg@mail.gmail.com>
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
> > +     return 0;
> > +}
> > +
> > +static int pci_liveupdate_freeze(void *arg, u64 *data)
> > +{
> > +     pr_info("freeze data[%llx]\n", *data);
> > +     return 0;
> > +}
> > +
> > +static void pci_liveupdate_cancel(void *arg, u64 data)
> > +{
> > +     pr_info("cancel data[%llx]\n", data);
> > +}
> > +
> > +static void pci_liveupdate_finish(void *arg, u64 data)
> > +{
> > +     pr_info("finish data[%llx]\n", data);
> > +}
> > +
> > +struct liveupdate_subsystem pci_liveupdate_ops =3D {
> > +     .prepare =3D pci_liveupdate_prepare,
> > +     .freeze =3D pci_liveupdate_freeze,
> > +     .cancel =3D pci_liveupdate_cancel,
> > +     .finish =3D pci_liveupdate_finish,
> > +     .name =3D PCI_SUBSYSTEM_NAME,
> > +};
> > +
> > +static int __init pci_liveupdate_init(void)
> > +{
> > +     int ret;
> > +
> > +     ret =3D liveupdate_register_subsystem(&pci_liveupdate_ops);
> > +     if (ret && liveupdate_state_updated())
> > +             panic("PCI liveupdate: Register subsystem failed: %d", re=
t);
> > +     WARN(ret, "PCI liveupdate: Register subsystem failed %d", ret);
>
> But this didn't fail.
>
> And you just crashed the box if panic-on-warn is enabled, so if some
> test infrastructure builds this first patch, boom.

Sorry that the second WARN should be removed. That is something during
the rebase conflict resolution somehow slipped through the crack.

I will remove the second WARN() there.

Thanks for catching it.

>
> {sigh}
>
> If you are going to do a "dummy" driver, please make it at least work
> and not do anything bad.

I did test it with a real machine and real PCI device, but I did not
have the panic-on-warn.

Again my bad. Sorry about that.

Chris

