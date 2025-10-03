Return-Path: <linux-pci+bounces-37515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 401FDBB6299
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 09:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84793B9E0F
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 07:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D1623D7E2;
	Fri,  3 Oct 2025 07:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1zIUKHt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF88223CF12
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 07:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759476376; cv=none; b=e1b3DHZHkJuG3ywqgzUl97y7/D45NSWRSCH/bUoIFK+cu90XiNC1ayCBWtEMySxocwF3YVJm+J3lzGPezt5FOzBpV15i2LYTJ5phmp3GiggNsZSoR7+vTT46KNUde4NYWtGoVgM7y8/yl7ugfUZt7QH2I58S4bSXsdMawXVKjxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759476376; c=relaxed/simple;
	bh=2UVfqZBLQy49KOitiBc8tAhkDTA0H0l42JBiq5frpVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gECYD4wnNsEizqZiKEBc+0xupQunB2BjVa6rlpu+Wa1shWofVD2EnMhQYu0FVsdcggKTtpNji3Vg8eT9xCxidwSau3DrHMWbYWKyEzELLKWOFA5R7CDp1BY15MrNL71MxrOIh/CKttzImjta04NVKujJiFDrrxH/NH0XwPws1OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1zIUKHt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FEBC4CEFD
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 07:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759476375;
	bh=2UVfqZBLQy49KOitiBc8tAhkDTA0H0l42JBiq5frpVo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S1zIUKHt3LloFfNANikDd0XW0+ztTpcnpQv8+tIet/DpQC3R28J6N6vl9ur8ExAAY
	 MfNhnWrPkswsYPPX0JCavDZBkMLw/bMlCD+dpYoZPcLmkaJM8gsQCItq+ByUeoFJPH
	 Lm/kNOO5q3556sZIrtw1Xb/ncW1LNl7o3sqwYKfm9VCtdyRArCzeJQTorHUzp7Afnp
	 FtvIlkjSGsgsLGX12VbFO+mvv+QJNpCgz6jmtPUm1ZPzJH+CJSZ5l5eIc0amwQ2FQo
	 9JbEppH4xW1r4Qb14JvOBs+otrtI985gjsm8LQ44pNG7OHHO+zdBso4j9b/uqRsmPc
	 T46T0yP84/OBA==
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e3bcf272aso46675e9.0
        for <linux-pci@vger.kernel.org>; Fri, 03 Oct 2025 00:26:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxTKbRaPwPUy+9MADS1oDUnJxKvx862XtDtEtKv9YibGqVhJDoN86i3WHlGsPY0qBS+kl+0pv6QZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+SwdTXTilQnsv1bAIuv2I0Ds1PJSFk3CoZypgp6WPz5GIMuHU
	ogZnq1DK+lUR45WfVF3t/UbKYoUmYDqDOyVc0g0q1zOXSdi3wwpbSUoJURgqdPzcFsxIGiEgw7b
	VwCTTPScl3JQs9fL7GjczcVeSLoxzR/aUOkgZYq+9
X-Google-Smtp-Source: AGHT+IF0FiWT5gMQo98IhUp4cZtjFyILRjcK8Xaqt1wm42UeFLIWHBRBzQ/OBxCtkYm3PZwpQvfzMjvw6MuNndIW52U=
X-Received: by 2002:a05:600c:a119:b0:46e:251:b1c2 with SMTP id
 5b1f17b1804b1-46e71bcd364mr726825e9.7.1759476373969; Fri, 03 Oct 2025
 00:26:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-3-c494053c3c08@kernel.org> <2025093044-icky-treat-e1c3@gregkh>
 <CACePvbUr42mj0kbcaw4cgKnd7v1f8z8Jhq4+_QN7Z5Nvicd1cw@mail.gmail.com> <2025100323-sneer-perennial-55e1@gregkh>
In-Reply-To: <2025100323-sneer-perennial-55e1@gregkh>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 3 Oct 2025 00:26:01 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNPFbSJezynwXWpMx0ihV32YvAgdfygj7bx1nhxtmB8-w@mail.gmail.com>
X-Gm-Features: AS18NWBHnR4jWer8Ic4JpU49F_9I1u94mBhx82LIn4FVdmymqdVYaus1UMIqdqA
Message-ID: <CAF8kJuNPFbSJezynwXWpMx0ihV32YvAgdfygj7bx1nhxtmB8-w@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
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

On Thu, Oct 2, 2025 at 11:19=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Oct 02, 2025 at 01:38:56PM -0700, Chris Li wrote:
> > On Tue, Sep 30, 2025 at 8:30=E2=80=AFAM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Sep 16, 2025 at 12:45:11AM -0700, Chris Li wrote:
> > > >  include/linux/dev_liveupdate.h |  23 +++++
> > > >  include/linux/device/driver.h  |   6 ++
> > >
> > > Driver core changes under the guise of only PCI changes?  Please no.
> >
> > There is a reason why I use the device struct rather than the pci_dev
> > struct even though liveupdate currently only works with PCI devices.
> > It comes down to the fact that the pci_bus and pci_host_bridge are not
> > pci_dev struct. We need something that is common across all those
> > three types of PCI related struct I care about(pci_dev, pci_bus,
> > pci_host_bridge). The device struct is just common around those. I can
> > move the dev_liveupdate struct into pci_bus, pci_host_bridge and
> > pci_dev independently. That will be more contained inside PCI, not
> > touching the device struct. The patch would be bigger because the data
> > structure is spread into different structs. Do you have a preference
> > which way to go?
>
> If you only are caring about one single driver, don't mess with a
> subsystem or the driver core, just change the driver.  My objection here

It is more than just one driver, we have vfio-pci, idpf, pci-pf-stub
and possible nvme driver.
The change needs to happen in the PCI enumeration and probing as well,
that is outside of the driver code.

> was that you were claiming it was a PCI change, yet it was actually only
> touching the driver core which means that all devices in the systems for

In theory all the devices can be liveupdate preserved. But now we only
support PCI.
I can look into containing the change in PCI only and not touching the
device struct if that is what you mean. I recall I tried that
previously and failed because bus->bridge is a device struct rather
than pci_dev or pci_host_bridge. I can try harder not to touch device
structs. Patch will be bigger and more complex than this right now.
But at least the damage is limited to PCI only if successful.

> all Linux users will be affected.

I understand your concerns. I was wishing one day all devices could
support liveupdate, but that is not the case right now.

> > > Break this series out properly, get the driver core stuff working FIR=
ST,
> > > then show how multiple busses will work with them (i.e. you usually n=
eed
> > > 3 to know if you got it right).
> >
> > Multiple buses you mean different types of bus, e.g. USB, PCI and
> > others or 3 pci_bus is good enough? Right now we have no intention to
> > support bus types other than PCI devices. The liveupdate is about
> > preserving the GPU context cross kernel upgrade. Suggestion welcome.
>
> So all of this is just for one single driver.  Ugh.  Just do it in the
> single driver then, don't mess with the driver core, or even the PCI

Not a single driver. It is the whole PCI core. Or in your book the
whole PCI is just one single driver?

> core.  Just make it specific to the driver and then none of us will even
> notice the mess that this all creates :)

OK. Let me try that PCI only approach again and try it harder. I will
report back.

Thanks for the feedback.

Chris

