Return-Path: <linux-pci+bounces-37711-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A39BC5544
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 15:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C03189F489
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 13:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1303B289E17;
	Wed,  8 Oct 2025 13:57:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50024235C01
	for <linux-pci@vger.kernel.org>; Wed,  8 Oct 2025 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931867; cv=none; b=H7QlHTScuuefmBkkPJ7oaZk999DMgYKcuk56N/bHGn9gFg2R8FWXoaqhASwsYiVpChtRiYCCX9Asag1ZGUB90ALqBgrdYBIzhdDIZPfsCZ78bwT/MykCXbecOdUpzNsCTTJNvKhXz2POUO0zefmVqrG3LKAkPRLl4Ldl45AntLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931867; c=relaxed/simple;
	bh=wi7nv0TmmgzRBhNcZR59aFmt5RlhONwX+bBW9c6smTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5xOdofDc9pR74czEFj3RWHEMoSmswtnR6IHacUWBBqf9Pb/FUJ0Un1nI8mCwP+s4dxfbxT8sNbVuQ3BM8L2MgpakKC8u0i8pmLrY5dgsJnTJIDnCz/Txqoi8W35TD/xw/WPchwAGmqOtVLcenqFkFE3J866s1fslG6WW5IMfwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-54b21395093so630070e0c.0
        for <linux-pci@vger.kernel.org>; Wed, 08 Oct 2025 06:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759931863; x=1760536663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZ7XOckRrA/rE7fezNf6XCWKqsh/sn5CQ0xAL3N0olQ=;
        b=FvoqWSLlyUDDBJc5IETUIjHxOPymchStxCPL4NIgTxTEM+7Kj6n2iiIW2AGcj2t1DD
         QyzEQukHeGlydR8h1w8pk1eQMfsN91ZyFK5vhmnHMMeboodhJAZDr4cGfbkAzQ4DOQkV
         c2RzzZLqVwo48EDXwvXxokyzV9pcn0iPJvqG7txNjxW6/0rQEhhzO6WJUW/6zu3HIhQD
         WQvprxtFqvzocYbG4jUaxYmNEKgCShhIWdFXh0l8578tr4xZ7Tr/lIC6O5eO35DhfrDj
         Xu7uR5Qlx0JZYvv+m2SaQ0/edOg2OdD7Hllje1/93UV6Jh49mNctcM1THcWV3wjPIAAy
         yrDA==
X-Forwarded-Encrypted: i=1; AJvYcCV1CRy/KXN1uR/1y6gqBaCGLFq+3YMTjmM4myvz5QVt5mLYtZXOUFczqaBQA7vYX2lf0fTbv5SvlxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDDk0rnUavm3oIrmoW67yZiv4F/qJd88PRVbIbVYYzMI8lt3VP
	apGIMGfwBfAKtXmpc5wWx4vueC99QzT8Q84VVMmEtfldg1qhKPZI7ZMAvM882MW+
X-Gm-Gg: ASbGncv4mHmHAv0PNTSD8RLVq5ifXji09CLjEeP/fGNVjarO1+tMd41NNGfS9201pIz
	+fqIpwX3EAFEwkNrsECooQHayuEO4CcqUtchat956+hhoUhkKzYpwbP/jV2nlcWKQMklNqYkO/R
	FYH9FDrj8aY6vmbnbkzlxcyTn727D802fNaLXFxmjclCjWAiUsOW9V2vSi9u3WIs6lj5tCzoy1m
	dm5jqsdPcBduUh5obA/XqQwfZu1XZFO+g1X9SySBduXzaIADCR4HOylFLWC4hnSZixydIhy81ld
	MxA/RFkDQq83fSrxshX93jxHfDPgy+JgHOJkSsA7BHWHOwq02N2wx3XKvyvWfqXNuGcHogwDRQJ
	7cBrjMO34EgMC7v8m6XIv1P0cL2pQtg/SGTonZ+W/ANBb5WUH4JI3QUxE2wVoIpJGcCTJ/yE2MA
	wC9Zm9e1ps0Pg/Zbz2RPU=
X-Google-Smtp-Source: AGHT+IEJOhSTc1THzzPaZoRzTCLIIuq2+hkIhqvFbrSRThmEmWAARTsU3kemdkKqMEU6cM+Y4ZDkvQ==
X-Received: by 2002:a05:6122:e1dc:b0:54a:89a2:21ad with SMTP id 71dfb90a1353d-554a8a81b61mr2693235e0c.0.1759931862685;
        Wed, 08 Oct 2025 06:57:42 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523ce1c31dsm4525552e0c.1.2025.10.08.06.57.41
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 06:57:41 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5565a83f796so886662137.1
        for <linux-pci@vger.kernel.org>; Wed, 08 Oct 2025 06:57:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXlR++2tVH20Wne9b5BZzPxZKdUjAnTlyd6F/lPnFGeO69KRrjeYtVmXgzkh3FBE7iiUHQdPWzkp8E=@vger.kernel.org
X-Received: by 2002:a05:6102:3a0e:b0:51c:4443:16c7 with SMTP id
 ada2fe7eead31-5d5e2591dc5mr1447964137.6.1759931861384; Wed, 08 Oct 2025
 06:57:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com>
 <20250924134228.1663-3-ilpo.jarvinen@linux.intel.com> <CAMuHMdVtVzcL3AX0uetNhKr-gLij37Ww+fcWXxnYpO3xRAOthA@mail.gmail.com>
 <4c28cd58-fd0d-1dff-ad31-df3c488c464f@linux.intel.com> <CAMuHMdUbaQDXsowZETimLJ-=gLCofeP+LnJp_txetuBQ0hmcPQ@mail.gmail.com>
 <c17c5ec1-132d-3588-2a4d-a0e6639cf748@linux.intel.com> <CAMuHMdVbyKdzbptA10F82Oj=6ktxnGAk4fz7dBLVdxALb8-WWg@mail.gmail.com>
 <2d5e9b78-8a90-3035-ff42-e881d61f4b7c@linux.intel.com> <CAMuHMdU_tPmQd=9dCzNs+dEt3fHNsYpYPFnT6QZk546o-J-y9g@mail.gmail.com>
 <7640a03e-dfea-db9c-80f5-d80fa2c505b7@linux.intel.com> <CAMuHMdVgCHU80mRm1Vwo6GFgNAtQcf50yHBz_oAk4TrtjcMpYg@mail.gmail.com>
 <8b46093f-82bc-1c25-5607-ee40923b51af@linux.intel.com> <CAMuHMdUjhq2ZLFyMYv9KYRW8brsvXMH5xb5NW8shsHJmx7w2QQ@mail.gmail.com>
 <bd1810d7-3e37-b599-5105-02902e6edf33@linux.intel.com> <CAMuHMdUrM+WJm2JAPuLmUjA0wWpipdqTfW6mu7cQdAHEyCAwdw@mail.gmail.com>
 <cadef017-c330-888b-a092-04d0b42ff686@linux.intel.com>
In-Reply-To: <cadef017-c330-888b-a092-04d0b42ff686@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Oct 2025 15:57:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWkNNJHxJNFc_1xgmAwWznnw_AOZV2t4o_ztDH-G3LjnQ@mail.gmail.com>
X-Gm-Features: AS18NWCR-BzkS4gbErISz0OqUIrLRfZj_zLU1e5GxN9kZLCo7aVvbeadGA1FEbs
Message-ID: <CAMuHMdWkNNJHxJNFc_1xgmAwWznnw_AOZV2t4o_ztDH-G3LjnQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: Resources outside their window must set IORESOURCE_UNSET
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Kai-Heng Feng <kaihengf@nvidia.com>, Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

On Tue, 7 Oct 2025 at 19:30, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
> On Mon, 6 Oct 2025, Geert Uytterhoeven wrote:
> > On Mon, 6 Oct 2025 at 14:37, Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > > On Mon, 6 Oct 2025, Geert Uytterhoeven wrote:
> > > > On Fri, 3 Oct 2025 at 16:58, Ilpo J=C3=A4rvinen
> > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > On Fri, 3 Oct 2025, Geert Uytterhoeven wrote:
> > > > > > On Thu, 2 Oct 2025 at 18:59, Ilpo J=C3=A4rvinen
> > > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > > On Thu, 2 Oct 2025, Geert Uytterhoeven wrote:
> > > > > > > > On Thu, 2 Oct 2025 at 16:54, Ilpo J=C3=A4rvinen
> > > > > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > > > > On Wed, 1 Oct 2025, Geert Uytterhoeven wrote:
> > > > > > > > > > On Wed, 1 Oct 2025 at 15:06, Ilpo J=C3=A4rvinen
> > > > > > > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > > > > > > On Wed, 1 Oct 2025, Geert Uytterhoeven wrote:
> > > > > > > > > > > > On Tue, 30 Sept 2025 at 18:32, Ilpo J=C3=A4rvinen
> > > > > > > > > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > > > > > > > > On Tue, 30 Sep 2025, Geert Uytterhoeven wrote:
> > > > > > > > > > > > > > On Fri, 26 Sept 2025 at 04:40, Ilpo J=C3=A4rvin=
en
> > > > > > > > > > > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > > > > > > > > > > PNP resources are checked for conflicts with =
the other resource in the
> > > > > > > > > > > > > > > system by quirk_system_pci_resources() that w=
alks through all PCI
> > > > > > > > > > > > > > > resources. quirk_system_pci_resources() corre=
ctly filters out resource
> > > > > > > > > > > > > > > with IORESOURCE_UNSET.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Resources that do not reside within their bri=
dge window, however, are
> > > > > > > > > > > > > > > not properly initialized with IORESOURCE_UNSE=
T resulting in bogus
> > > > > > > > > > > > > > > conflicts detected in quirk_system_pci_resour=
ces():
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x=
1fffffff 64bit pref]
> > > > > > > > > > > > > > > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x=
dfffffff 64bit pref]: contains BAR 2 for 7 VFs
> > > > > > > > > > > > > > > ...
> > > > > > > > > > > > > > > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x=
1ffffffff 64bit pref]
> > > > > > > > > > > > > > > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x=
3dffffffff 64bit pref]: contains BAR 2 for 31 VFs
> > > > > > > > > > > > > > > ...
> > > > > > > > > > > > > > > pnp 00:04: disabling [mem 0xfc000000-0xfc00ff=
ff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64b=
it pref]
> > > > > > > > > > > > > > > pnp 00:05: disabling [mem 0xc0000000-0xcfffff=
ff] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit=
 pref]
> > > > > > > > > > > > > > > pnp 00:05: disabling [mem 0xfedc0000-0xfedc7f=
ff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64b=
it pref]
> > > > > > > > > > > > > > > pnp 00:05: disabling [mem 0xfeda0000-0xfeda0f=
ff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64b=
it pref]
> > > > > > > > > > > > > > > pnp 00:05: disabling [mem 0xfeda1000-0xfeda1f=
ff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64b=
it pref]
> > > > > > > > > > > > > > > pnp 00:05: disabling [mem 0xc0000000-0xcfffff=
ff disabled] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dfff=
fffff 64bit pref]
> > > > > > > > > > > > > > > pnp 00:05: disabling [mem 0xfed20000-0xfed7ff=
ff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64b=
it pref]
> > > > > > > > > > > > > > > pnp 00:05: disabling [mem 0xfed90000-0xfed93f=
ff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64b=
it pref]
> > > > > > > > > > > > > > > pnp 00:05: disabling [mem 0xfed45000-0xfed8ff=
ff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64b=
it pref]
> > > > > > > > > > > > > > > pnp 00:05: disabling [mem 0xfee00000-0xfeefff=
ff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64b=
it pref]
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Mark resources that are not contained within =
their bridge window with
> > > > > > > > > > > > > > > IORESOURCE_UNSET in __pci_read_base() which r=
esolves the false
> > > > > > > > > > > > > > > positives for the overlap check in quirk_syst=
em_pci_resources().
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Fixes: f7834c092c42 ("PNP: Don't check for ov=
erlaps with unassigned PCI BARs")
> > > > > > > > > > > > > > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvi=
nen@linux.intel.com>
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Thanks for your patch, which is now commit 06b7=
7d5647a4d6a7 ("PCI:
> > > > > > > > > > > > > > Mark resources IORESOURCE_UNSET when outside br=
idge windows") in
> > > > > > > > > > > > > > linux-next/master next-20250929 pci/next
> > > > > > > > > > > >
> > > > > > > > > > > > > > This replaces the actual resources by their siz=
es in the boot log on
> > > > > > > > > > > > > > e.g. on R-Car M2-W:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >      pci-rcar-gen2 ee090000.pci: host bridge /s=
oc/pci@ee090000 ranges:
> > > > > > > > > > > > > >      pci-rcar-gen2 ee090000.pci:      MEM 0x00e=
e080000..0x00ee08ffff -> 0x00ee080000
> > > > > > > > > > > > > >      pci-rcar-gen2 ee090000.pci: PCI: revision =
11
> > > > > > > > > > > > > >      pci-rcar-gen2 ee090000.pci: PCI host bridg=
e to bus 0000:00
> > > > > > > > > > > > > >      pci_bus 0000:00: root bus resource [bus 00=
]
> > > > > > > > > > > > > >      pci_bus 0000:00: root bus resource [mem 0x=
ee080000-0xee08ffff]
> > > > > > > > > > > > > >      pci 0000:00:00.0: [1033:0000] type 00 clas=
s 0x060000 conventional PCI endpoint
> > > > > > > > > > > > > >     -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0x=
ee090bff]
> > > > > > > > > > > > > >     -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x=
7fffffff pref]
> > > > > > > > > > > > >
> > > > > > > > > > > > > What is going to be the parent of these resources=
? They don't seem to fall
> > > > > > > > > > > > > under the root bus resource above in which case t=
he output change is
> > > > > > > > > > > > > intentional so they don't appear as if address ra=
nge would be "okay".
> > > > > > > > > > > >
> > > > > > > > > > > > >From /proc/iomem:
> > > > > > > > > > > >
> > > > > > > > > > > >     ee080000-ee08ffff : pci@ee090000
> > > > > > > > > > > >       ee080000-ee080fff : 0000:00:01.0
> > > > > > > > > > > >         ee080000-ee080fff : ohci_hcd
> > > > > > > > > > > >       ee081000-ee0810ff : 0000:00:02.0
> > > > > > > > > > > >         ee081000-ee0810ff : ehci_hcd
> > > > > > > > > > > >     ee090000-ee090bff : ee090000.pci pci@ee090000
> > > > > > > > > > >
> > > > > > > > > > > Okay, so this seem to appear in the resource tree but=
 not among the root
> > > > > > > > > > > bus resources.
> > > > > > > > > > >
> > > > > > > > > > > >     ee0c0000-ee0cffff : pci@ee0d0000
> > > > > > > > > > > >       ee0c0000-ee0c0fff : 0001:01:01.0
> > > > > > > > > > > >         ee0c0000-ee0c0fff : ohci_hcd
> > > > > > > > > > > >       ee0c1000-ee0c10ff : 0001:01:02.0
> > > > > > > > > > > >         ee0c1000-ee0c10ff : ehci_hcd
> > > > > > > > > > > >
> > > > > > > > > > > > > When IORESOURCE_UNSET is set in a resource, %pR d=
oes not print the start
> > > > > > > > > > > > > and end addresses.
> > > > > > > > > > > >
> > > > > > > > > > > > Yeah, that's how I found this commit, without bisec=
ting ;-)
> > > > > > > > > > > >
> > > > > > > > > > > > > >     +pci 0000:00:00.0: BAR 0 [mem size 0x000004=
00]
> > > > > > > > > > > > > >     +pci 0000:00:00.0: BAR 1 [mem size 0x400000=
00 pref]
> > > > > > > > > > > > > >      pci 0000:00:01.0: [1033:0035] type 00 clas=
s 0x0c0310 conventional PCI endpoint
> > > > > > > > > > > > > >     -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x=
00000fff]
> > > > > > > > > > > > > >     +pci 0000:00:01.0: BAR 0 [mem size 0x000010=
00]
> > > > > > > > > > > > >
> > > > > > > > > > > > > For this resource, it's very much intentional. It=
's a zero-based BAR which
> > > > > > > > > > > > > was left without IORESOURCE_UNSET prior to my pat=
ch leading to others part
> > > > > > > > > > > > > of the kernel to think that resource range valid =
and in use (in your
> > > > > > > > > > > > > case it's so small it wouldn't collide with anyth=
ing but it wasn't
> > > > > > > > > > > > > properly set up resource, nonetheless).
> > > > > > > > > > > > >
> > > > > > > > > > > > > >      pci 0000:00:01.0: supports D1 D2
> > > > > > > > > > > > > >      pci 0000:00:01.0: PME# supported from D0 D=
1 D2 D3hot
> > > > > > > > > > > > > >      pci 0000:00:02.0: [1033:00e0] type 00 clas=
s 0x0c0320 conventional PCI endpoint
> > > > > > > > > > > > > >     -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x=
000000ff]
> > > > > > > > > > > > > >     +pci 0000:00:02.0: BAR 0 [mem size 0x000001=
00]
> > > > > > > > > > > > >
> > > > > > > > > > > > > And this as well is very much intentional.
> > > > > > > > > > > > >
> > > > > > > > > > > > > >      pci 0000:00:02.0: supports D1 D2
> > > > > > > > > > > > > >      pci 0000:00:02.0: PME# supported from D0 D=
1 D2 D3hot
> > > > > > > > > > > > > >      PCI: bus0: Fast back to back transfers dis=
abled
> > > > > > > > > > > > > >      pci 0000:00:01.0: BAR 0 [mem 0xee080000-0x=
ee080fff]: assigned
> > > > > > > > > > > > > >      pci 0000:00:02.0: BAR 0 [mem 0xee081000-0x=
ee0810ff]: assigned
> > > > > > > > > > > > > >      pci_bus 0000:00: resource 4 [mem 0xee08000=
0-0xee08ffff]
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Is that intentional?
> > > > > > > > > > > > >
> > > > > > > > > > > > > There's also that pci_dbg() in the patch which wo=
uld show the original
> > > > > > > > > > > > > addresses (print the resource before setting IORE=
SOURCE_UNSET) but to see
> > > > > > > > > > > > > it one would need to enable it with dyndbg=3D... =
Bjorn was thinking of
> > > > > > > > > > > > > making that pci_info() though so it would appear =
always.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Was this the entire PCI related diff? I don't see=
 those 0000:00:00.0 BARs
> > > > > > > > > > > > > getting assigned anywhere.
> > > > > > > > > > > >
> > > > > > > > > > > > The above log is almost complete (lacked enabling t=
he device afterwards).
> > > > > > > > > > > >
> > > > > > > > > > > > AFAIU, the BARs come from the reg and ranges proper=
ties in the
> > > > > > > > > > > > PCI controller nodes;
> > > > > > > > > > > > https://elixir.bootlin.com/linux/v6.17/source/arch/=
arm/boot/dts/renesas/r8a7791.dtsi#L1562
> > > > > > > > > > >
> > > > > > > > > > > Thanks, although I had already found this line by gre=
p. I was just
> > > > > > > > > > > expecting the address appear among root bus resources=
 too.
> > > > > > > > > > >
> > > > > > > > > > > Curiously enough, pci_register_host_bridge() seems to=
 try to add some
> > > > > > > > > > > resource from that list into bus and it's what prints=
 those "root bus
> > > > > > > > > > > resource" lines and ee090000 is not among the printed=
 lines despite
> > > > > > > > > > > appearing in /proc/iomem. As is, the resource tree an=
d PCI bus view on the
> > > > > > > > > > > resources seems to be in disagreement and I'm not sur=
e what to make of it.
> > > > > > > > > > >
> > > > > > > > > > > But before considering going into that direction or f=
iguring out why this
> > > > > > > > > > > ee090000 resource does not appear among root bus reso=
urces, could you
> > > > > > > > > > > check if the attached patch changes behavior for the =
resource which are
> > > > > > > > > > > non-zero based?
> > > > > > > > > >
> > > > > > > > > > This patch has no impact on dmesg, lspci output, or /pr=
oc/iomem
> > > > > > > > > > for pci-rcar-gen2.
> > > > > > > > >
> > > > > > > > > It would have been too easy... :-(
> > > > > > > > >
> > > > > > > > > I'm sorry I don't really know these platform well and I'm=
 currently trying
> > > > > > > > > to understand what adds that ee090000 resource into the r=
esource tree
> > > > > > > > > and so far I've not been very successful.
> > > > > > > > >
> > > > > > > > > Perhaps it would be easiest to print a stacktrace when th=
e resource is
> > > > > > > > > added but there are many possible functions. I think all =
of them
> > > > > > > > > converge in __request_resource() so I suggest adding:
> > > > > > > > >
> > > > > > > > > WARN_ON(new->start =3D=3D 0xee090000);
> > > > > > > > >
> > > > > > > > > before __request_resource() does anything.
> > > > > > > >
> > > > > > > >     Call trace:
> > > > > > > >      unwind_backtrace from show_stack+0x10/0x14
> > > > > > > >      show_stack from dump_stack_lvl+0x7c/0xb0
> > > > > > > >      dump_stack_lvl from __warn+0x80/0x198
> > > > > > > >      __warn from warn_slowpath_fmt+0xc0/0x124
> > > > > > > >      warn_slowpath_fmt from __request_resource+0x38/0xc8
> > > > > > > >      __request_resource from __request_region+0xc4/0x1e8
> > > > > > > >      __request_region from __devm_request_region+0x80/0xac
> > > > > > > >      __devm_request_region from __devm_ioremap_resource+0xc=
c/0x160
> > > > > > > >      __devm_ioremap_resource from rcar_pci_probe+0x58/0x350
> > > > > > > >      rcar_pci_probe from platform_probe+0x58/0x90
> > > > > > > >
> > > > > > > > I.e. the call to devm_platform_get_and_ioremap_resource() i=
n
> > > > > > > > drivers/pci/controller/pci-rcar-gen2.c:rcar_pci_probe().
> > > > > > >
> > > > > > > Thanks, the patch below might help BAR0 (but I'm not sure if =
it's the
> > > > > > > correct solution due to being so unfamiliar with these kind o=
f platforms
> > > > > > > and how they're initialized).
> > > > > >
> > > > > > Thanks, that has the following impact on dmesg:
> > > > > >
> > > > > >      pci-rcar-gen2 ee090000.pci: PCI: revision 11
> > > > > >      pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
> > > > > >      pci_bus 0000:00: root bus resource [bus 00]
> > > > > >     -pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08f=
fff]
> > > > > >     +pci_bus 0000:00: root bus resource [mem 0xee080000-0xee090=
bff]
> > > > > >      pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 conve=
ntional
> > > > > > PCI endpoint
> > > > > >     -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]: no in=
itial
> > > > > > claim (no window)
> > > > > >     -pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
> > > > > >     -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: =
no
> > > > > > initial claim (no window)
> > > > > >     +pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
> > > > > >      pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
> > > > > >      pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310 conve=
ntional
> > > > > > PCI endpoint
> > > > > >     -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff]: no in=
itial
> > > > > > claim (no window)
> > > > > >      pci 0000:00:01.0: BAR 0 [mem size 0x00001000]
> > > > > >      pci 0000:00:01.0: supports D1 D2
> > > > > >      pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
> > > > > >      pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320 conve=
ntional
> > > > > > PCI endpoint
> > > > > >     -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff]: no in=
itial
> > > > > > claim (no window)
> > > > >
> > > > > Did you e.g. forget to change pci_dbg() to pci_info() as these al=
l went
> > > > > away, I cannot see why it should disappear because of my patch?
> > > > >
> > > > > (No need to apologize if that was the case, just confirming if th=
at
> > > > > explains it is enough. :-))
> > > >
> > > > I indeed dropped that change. Adding it back...
> > > >
> > > > > >      pci 0000:00:02.0: BAR 0 [mem size 0x00000100]
> > > > > >      pci 0000:00:02.0: supports D1 D2
> > > > > >      pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
> > > > > >      PCI: bus0: Fast back to back transfers disabled
> > > > > >      pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assig=
ned
> > > > > >      pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assig=
ned
> > > > >
> > > > > Perhaps print here what's the parent resource of these resource.
> > > >
> > > > pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned (pare=
nt
> > > > [mem 0xee080000-0xee08ffff])
> > > > pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned (pare=
nt
> > > > [mem 0xee080000-0xee08ffff])
> > >
> > > Were these from a kernel without the problematic commit at all or wit=
h the
> > > problematic commit and my fix? They look like the former case. The fu=
ll
> > > /proc/iomem also shows all the parent resources I think.
> >
> > With commit 06b77d5647a4d6a7 ("PCI: Mark resources IORESOURCE_UNSET whe=
n
> > outside bridge windows"), but without adding
> > "pci_add_resource(&bridge->windows, cfg_res);" in .probe().
> >
> > > > > >     -pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ffff]
> > > > > >     +pci_bus 0000:00: resource 4 [mem 0xee080000-0xee090bff]
> > > > > >      pci-rcar-gen2 ee0d0000.pci: adding to PM domain always-on
> > > > > >      PM: genpd_add_device: Add ee0d0000.pci to always-on
> > > > > >      pci-rcar-gen2 ee0d0000.pci: host bridge /soc/pci@ee0d0000 =
ranges:
> > > > > >     @@ -414,26 +416,22 @@ PM: =3D=3D=3D=3D always-on/ee0d0000.p=
ci: start
> > > > > >      pci-rcar-gen2 ee0d0000.pci: PCI: revision 11
> > > > > >      pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0001:01
> > > > > >      pci_bus 0001:01: root bus resource [bus 01]
> > > > > >     -pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0cf=
fff]
> > > > > >     +pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0d0=
bff]
> > > > > >      pci 0001:01:00.0: [1033:0000] type 00 class 0x060000 conve=
ntional PCI endpoint
> > > > > >     -pci 0001:01:00.0: BAR 0 [mem 0xee0d0800-0xee0d0bff]: no in=
itial claim (no window)
> > > > > >     -pci 0001:01:00.0: BAR 0 [mem size 0x00000400]
> > > > > >     -pci 0001:01:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: =
no initial claim (no window)
> > > > > >     +pci 0001:01:00.0: BAR 0 [mem 0xee0d0800-0xee0d0bff]
> > > > > >      pci 0001:01:00.0: BAR 1 [mem size 0x40000000 pref]
> > > > > >      pci 0001:01:01.0: [1033:0035] type 00 class 0x0c0310 conve=
ntional PCI endpoint
> > > > > >     -pci 0001:01:01.0: BAR 0 [mem 0x00000000-0x00000fff]: no in=
itial claim (no window)
> > > > > >      pci 0001:01:01.0: BAR 0 [mem size 0x00001000]
> > > > > >      pci 0001:01:01.0: supports D1 D2
> > > > > >      pci 0001:01:01.0: PME# supported from D0 D1 D2 D3hot
> > > > > >      pci 0001:01:02.0: [1033:00e0] type 00 class 0x0c0320 conve=
ntional PCI endpoint
> > > > > >     -pci 0001:01:02.0: BAR 0 [mem 0x00000000-0x000000ff]: no in=
itial claim (no window)
> > > > > >      pci 0001:01:02.0: BAR 0 [mem size 0x00000100]
> > > > > >      pci 0001:01:02.0: supports D1 D2
> > > > > >      pci 0001:01:02.0: PME# supported from D0 D1 D2 D3hot
> > > > > >      PCI: bus1: Fast back to back transfers disabled
> > > > > >      pci 0001:01:01.0: BAR 0 [mem 0xee0c0000-0xee0c0fff]: assig=
ned
> > > > > >      pci 0001:01:02.0: BAR 0 [mem 0xee0c1000-0xee0c10ff]: assig=
ned
> > > > > >     -pci_bus 0001:01: resource 4 [mem 0xee0c0000-0xee0cffff]
> > > > > >     +pci_bus 0001:01: resource 4 [mem 0xee0c0000-0xee0d0bff]
> > > > > >      rcar-pcie fe000000.pcie: adding to PM domain always-on
> > > > > >      PM: genpd_add_device: Add fe000000.pcie to always-on
> > > > > >      rcar-pcie fe000000.pcie: host bridge /soc/pcie@fe000000 ra=
nges:
> > > > > >
> > > > > > and on /proc/iomem (I used "diff -w" to reduce clutter):
> > > > > >
> > > > > >      ec700000-ec70ffff : ec700000.dma-controller dma-controller=
@ec700000
> > > > > >      ec720000-ec72ffff : ec720000.dma-controller dma-controller=
@ec720000
> > > > > >      ec740000-ec7401ff : ec500000.sound audmapp
> > > > > >     -ee080000-ee08ffff : pci@ee090000
> > > > >
> > > > > So what did add this previous? (Maybe use the same WARN_ON() tric=
k as
> > > > > previously to find out.)
> > > >
> > > > First call:
> > > >
> > > >     + __request_resource from request_resource_conflict+0x24/0x3c
> > > >     + request_resource_conflict from devm_request_resource+0x48/0x9=
c
> > > >     + devm_request_resource from devm_request_pci_bus_resources+0x5=
c/0x70
> > > >     + devm_request_pci_bus_resources from devm_of_pci_bridge_init+0=
x7c/0x1c0
> > > >     + devm_of_pci_bridge_init from devm_pci_alloc_host_bridge+0x44/=
0x6c
> > > >     + devm_pci_alloc_host_bridge from rcar_pci_probe+0x34/0x384
> > > >     + rcar_pci_probe from platform_probe+0x58/0x90
> > >
> > > Thanks. So this is the call of interest, the rest are just the childs=
 of
> > > it with the same address.
> > >
> > > I'm looking devm_of_pci_get_host_bridge_resources(), it seems to read
> > > "ranges" property but not "reg" at all.
> > >
> > > I wonder if devm_of_pci_get_host_bridge_resources() should also loop
> > > through "reg" addresses and add those to host resources which are out=
side
> > > of the "ranges"? Or if there should be a "range" that covers all what=
's
> > > in "reg" to get them added into host bridge resources? That would see=
m the
> > > generic solution instead of trying to do this in rcar_pci_probe().
> > >
> > > (Perhaps these are stupid questions, please excuse my lack of knowled=
ge
> > > about OF things.)
> > >
> > > While looking at another issue report, I also notice of_pci_prop_rang=
es()
> > > assumes there are only bridge windows or BARs, but not both (not sure=
 if
> > > this relates to anything, just an observation while reading these cod=
e
> > > paths).
> >
> > We still have Rob in CC...
>
> While we wait, can you simply try to make the "ranges" large enough to fi=
t
> the BAR0 too?

Sure, so I changed:

    --- a/arch/arm/boot/dts/renesas/r8a7791.dtsi
    +++ b/arch/arm/boot/dts/renesas/r8a7791.dtsi
    @@ -1577,7 +1577,7 @@ pci0: pci@ee090000 {
                            #address-cells =3D <3>;
                            #size-cells =3D <2>;
                            #interrupt-cells =3D <1>;
    -                       ranges =3D <0x02000000 0 0xee080000 0
0xee080000 0 0x00010000>;
    +                       ranges =3D <0x02000000 0 0xee080000 0
0xee080000 0 0x00020000>;
                            interrupt-map-mask =3D <0xf800 0 0 0x7>;
                            interrupt-map =3D <0x0000 0 0 1 &gic GIC_SPI
108 IRQ_TYPE_LEVEL_HIGH>,
                                            <0x0800 0 0 1 &gic GIC_SPI
108 IRQ_TYPE_LEVEL_HIGH>,

> I think it will results in making the larger "ranges" entry the parent of
> ee090000-ee090bff : ee090000.pci pci@ee090000 entry in the resource tree

Correct!

Impact on dmesg:

     pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 ranges:
    -pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08ffff
-> 0x00ee080000
    +pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee09ffff
-> 0x00ee080000
     rcar_pci_setup:187: No dma_ranges, using default!
     pci-rcar-gen2 ee090000.pci: PCI: revision 11
     pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
    -Has parent [mem 0xee080000-0xee08ffff]
    +Has parent [mem 0xee080000-0xee09ffff]
     pci_bus 0000:00: root bus resource [bus 00]
    -pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
    +pci_bus 0000:00: root bus resource [mem 0xee080000-0xee09ffff]
     pci_bus 0000:00: root bus resource [mem 0xee090000-0xee090bff]
     pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 conventional
PCI endpoint
     pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
    @@ -397,9 +398,9 @@ pci 0000:00:02.0: BAR 0 [mem size 0x0000
     pci 0000:00:02.0: supports D1 D2
     pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
     PCI: bus0: Fast back to back transfers disabled
    -pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned
(parent [mem 0xee080000-0xee08ffff])
    -pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned
(parent [mem 0xee080000-0xee08ffff])
    -pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ffff]
    +pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned
(parent [mem 0xee080000-0xee09ffff])
    +pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned
(parent [mem 0xee080000-0xee09ffff])
    +pci_bus 0000:00: resource 4 [mem 0xee080000-0xee09ffff]
     pci_bus 0000:00: resource 5 [mem 0xee090000-0xee090bff]


Impact on /proc/iomem:

     ec700000-ec70ffff : ec700000.dma-controller dma-controller@ec700000
     ec720000-ec72ffff : ec720000.dma-controller dma-controller@ec720000
     ec740000-ec7401ff : ec500000.sound audmapp
    -ee080000-ee08ffff : pci@ee090000
    +ee080000-ee09ffff : pci@ee090000
       ee080000-ee080fff : 0000:00:01.0
         ee080000-ee080fff : ohci_hcd
       ee081000-ee0810ff : 0000:00:02.0
         ee081000-ee0810ff : ehci_hcd
    -ee090000-ee090bff : ee090000.pci pci@ee090000
    +  ee090000-ee090bff : ee090000.pci pci@ee090000
     ee0c0000-ee0cffff : pci@ee0d0000
       ee0c0000-ee0c0fff : 0001:01:01.0
         ee0c0000-ee0c0fff : ohci_hcd


> which would also avoid the coalescing issue.

Also correct: I can remove the coalescing workaround again without
having any impact on /proc/iomem.

> Again, I'm not entirely sure if that would be an acceptable solution.

I am afraid not, as it should keep on working with existing DTBs,
as per the stable DT ABI rule.
Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

