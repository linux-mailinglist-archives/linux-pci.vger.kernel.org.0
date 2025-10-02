Return-Path: <linux-pci+bounces-37469-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A220EBB5231
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 22:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A794850BA
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 20:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A9A253F2B;
	Thu,  2 Oct 2025 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moLwMfiQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87D31C1F13
	for <linux-pci@vger.kernel.org>; Thu,  2 Oct 2025 20:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759437549; cv=none; b=D25RhrRDzQkoQJcgCq/Bc9XgEY3ZulefYZBTIGIglzEpDw8OlDximnPfbT213KdtHfTnhZBEj/EjAEzYFEbmT2ZxsQLw+LHqbDMHfLLPtjjD6/NN+QXuS4BisreKT+wiiHaNlBbWiTDaNkNOc7NX/5IeZVWI+aGSLmtORpqYk8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759437549; c=relaxed/simple;
	bh=7/AuhGoWi1V0uAa5z01NsipBf1OVW30L+AI0uY5qLCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hco+GK7pRA4HJLB5LHiBgz+wbVtQB0s55ZtRGcwrIUgY6l059V4SPmPFgXfrVmWFPU7ass1x5ZWTTrgRnIcXXGDRmTDw8iFpUKmXgJ84wbyYXT0FvbKJic8J52X1gPpSIe3BgvLvrPpMpEd0y1vb4MtDIqVXFNI2VaiSrmoyAFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moLwMfiQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFF0C4CEF9
	for <linux-pci@vger.kernel.org>; Thu,  2 Oct 2025 20:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759437548;
	bh=7/AuhGoWi1V0uAa5z01NsipBf1OVW30L+AI0uY5qLCQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=moLwMfiQQN0ZCC+ecnLTENcC5TPm1sfReyCy98sGYt6n2eFyDvcCGxOLUNl9a/stn
	 C93n6kFu5FIDxLblqT/FkLTlSh4aiwP622pp3Ukhp49RoqKj5O9b3PjTwSCSmQXKai
	 hzAKXS/Cvv0YMYP195h0vgXj2fkpvTwrZjC0sKboAS7rM5+/fMvKshImJZzme0dXHS
	 +WOga8zYZoIQUwWZcecPDT8kgssrOxn+thy5Jw3FnDGk8JcH20ef7gicnSmzb2VWEW
	 peWF+3hnQgR9j7CVMcGSZqFod4rxh9oSZ+omSu41dpPWGWGevhlr81N1uoVus9FP2h
	 cOsErPMz4QeKQ==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-74f6974175dso18768647b3.3
        for <linux-pci@vger.kernel.org>; Thu, 02 Oct 2025 13:39:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbX9UNswu9e2Wh/pOf7xVmSSb4O/G/wTFcf6JZJT3/VH2ClvvDaDnu5B4PICFa1iycdOvfN5llNi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEyocIYTuPj0ed1PrSJgPI9XtYeLTFVlpTLuMAo7Wn11uzq2MT
	QO46w5jtpnAWvQCaOmYkoGQ0IHNIzqPXEqeIoqMtegkfjd07cElFgcn5eqRMIXiidiy9EmBwGld
	a1TgxhCkj1GPsW1teQ69a0H5PLapCyconAc9D6M36TQ==
X-Google-Smtp-Source: AGHT+IGDTPBhR6qaSfQtBFveyqgG74j4Ur0lJQ2edVW2LAGHeYnfcwgpDW2WYqwQfIovdxGAn898aHgZBJK2Slh3kr8=
X-Received: by 2002:a05:690e:251c:10b0:635:4ecc:fc2b with SMTP id
 956f58d0204a3-63b9a10bbbcmr497679d50.51.1759437547537; Thu, 02 Oct 2025
 13:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-3-c494053c3c08@kernel.org> <2025093044-icky-treat-e1c3@gregkh>
In-Reply-To: <2025093044-icky-treat-e1c3@gregkh>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 2 Oct 2025 13:38:56 -0700
X-Gmail-Original-Message-ID: <CACePvbUr42mj0kbcaw4cgKnd7v1f8z8Jhq4+_QN7Z5Nvicd1cw@mail.gmail.com>
X-Gm-Features: AS18NWCZM0LPAxyjDszHoc42H9U7_N-0OszxH4rR8NC46m34FcHMMwIeG9Tp_iA
Message-ID: <CACePvbUr42mj0kbcaw4cgKnd7v1f8z8Jhq4+_QN7Z5Nvicd1cw@mail.gmail.com>
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

On Tue, Sep 30, 2025 at 8:30=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 16, 2025 at 12:45:11AM -0700, Chris Li wrote:
> >  include/linux/dev_liveupdate.h |  23 +++++
> >  include/linux/device/driver.h  |   6 ++
>
> Driver core changes under the guise of only PCI changes?  Please no.

There is a reason why I use the device struct rather than the pci_dev
struct even though liveupdate currently only works with PCI devices.
It comes down to the fact that the pci_bus and pci_host_bridge are not
pci_dev struct. We need something that is common across all those
three types of PCI related struct I care about(pci_dev, pci_bus,
pci_host_bridge). The device struct is just common around those. I can
move the dev_liveupdate struct into pci_bus, pci_host_bridge and
pci_dev independently. That will be more contained inside PCI, not
touching the device struct. The patch would be bigger because the data
structure is spread into different structs. Do you have a preference
which way to go?

> Break this series out properly, get the driver core stuff working FIRST,
> then show how multiple busses will work with them (i.e. you usually need
> 3 to know if you got it right).

Multiple buses you mean different types of bus, e.g. USB, PCI and
others or 3 pci_bus is good enough? Right now we have no intention to
support bus types other than PCI devices. The liveupdate is about
preserving the GPU context cross kernel upgrade. Suggestion welcome.

> I'm guessing you will need/want PCI, platform, and something else?

This series only cares about PCI. The LUO series has subsystems. The
PCI livedupate code is registered as an LUO subsystem. I guess the
subsystem is close to the platform you have in mind? LUO also has the
memfd in addition to the subsystem.

Chris

