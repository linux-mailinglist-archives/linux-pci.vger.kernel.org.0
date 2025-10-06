Return-Path: <linux-pci+bounces-37604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF7EBBDA4E
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 12:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35CBE3BA46C
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 10:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0B8221FA8;
	Mon,  6 Oct 2025 10:14:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17294220F37
	for <linux-pci@vger.kernel.org>; Mon,  6 Oct 2025 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745681; cv=none; b=TSPvb36o2y3MZ9XFHHRTEfZE5c3+lcisXSs7YSPjE1gNx48bfGxdttcewNAUdM0/9zZuvFheISUiqt3cum/TYG7NWzRSgxQhiE7A19ISqn9WN5Osipif8eGO8S3QjBMdw7uYoKSRJImi4P6H1jaNGIraWDR4T+VT1AgucKW/lVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745681; c=relaxed/simple;
	bh=XZnovD9+nymn12V7AXrPYQiRH1IOD3wcDXY2Idatmfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWOAfmg4TJXDz6NlOmHFIOUa/rPGyOKyuQsbIWo3m8ucjY6kpT7+kOgokQZvBsNxdPyTZN0oIJrbcLD7cyWjc+oi2KQjksdJBBHQAMjTcngNw894LNvwMKBvS2q3gPWEL23EG6kN7Ve0yvm8DJozhIP8YHgU8m7D/Oiyy1ypaa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-890190d9f89so3425246241.2
        for <linux-pci@vger.kernel.org>; Mon, 06 Oct 2025 03:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759745678; x=1760350478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emGKq5esaOCR6QcuD6e5Jr27p5l/28YLXvcPEsHL2VQ=;
        b=kuVOdKTFPdKtxVEz7Ukmb8xtlKhZo1KyXSC5s9IZqTfTVCODhaMNR+QgBhNDB1Mkpr
         HBL4uiEx+u8ZkneGoepmm9k0DTCasx8YTs1xlQh3AlvQDtbWKzyRObDJwQKwBLiLJ2pM
         SyB2h7mykNEOhEVbdWsTg+NfOSWEUeCkMEL5m3CtIccGltiZTN5eMJmvk/DoIN+IQWOo
         A7DrtWnghw4H89T4hV6NrCY/Jc6HE4f8wwv55QgVqA94oo+vguNb9LDuW7haDC7Tkdod
         99nQTOSdoy+odipiT43sff242t39s0WZLg+wv1isjY2uDdXLqDMyD7XlNffhvk6Um3bi
         Gp8w==
X-Gm-Message-State: AOJu0Yy5sk578apZtVzMAvSxzI+rGf8lkR/Ij6/qVWGEqqcYcQGslHA8
	MjraUxbJ27IjL75gk9QmBHgeRSST5ac/s2FYqt9kjlEolNavh0/lPnrTXlXzfbfr
X-Gm-Gg: ASbGnctylfMMOb2eNZx8j4dLJ7JS9EYUIQL2n/8JyrEuKwtBHo+usLA990o3iYz7ShJ
	OLVt4RBkX2Z6fWzhgZwSgYuaQzS9qMWyi5adQZreb0yniedpbgtFM0D8TJVUa19ESNkFXwVBy7O
	M3zQ+oXqmP+ztLmKYLCxOfQGxKm5Kmj/YvXcaOtfMBxGpB6AmoW/XAEmRE3Bsxi2U9mOIhIImob
	8yZd4/qjJ/uPDOlKIWPcRSQJt3pLSDjy47hV6qLnIl8azEiOPucnja/OaIhaX2Q5xPKned3W+od
	82HQfEv08FevRa5schvnSxHPI/wzG9sN/SAxlAW9zLAGnACY5n0DGgHcNspoH9elt+/s5P8lYPo
	3GaKJcHXZjBjjmZ/megv3vgxYAfUak+ZihySHZLm+mGlcQPakyiQz+6JiCs56LR8RCXUEzwzP3i
	Um1GfsfOGv+ZGStIBEbgU=
X-Google-Smtp-Source: AGHT+IHFWceAIkqGrmmrXTa3fWTWvjHcdzhp79A8LELHCBXmVKIsC3S8hRWJjUTukJBrjqsfyYNYCA==
X-Received: by 2002:a05:6102:5088:b0:534:cfe0:f85b with SMTP id ada2fe7eead31-5d41d0e8972mr4024646137.20.1759745677402;
        Mon, 06 Oct 2025 03:14:37 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-92eb4d83b81sm2866473241.3.2025.10.06.03.14.37
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 03:14:37 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-92cbfab6c0dso2985304241.3
        for <linux-pci@vger.kernel.org>; Mon, 06 Oct 2025 03:14:37 -0700 (PDT)
X-Received: by 2002:a05:6102:8090:b0:538:dc93:e3c4 with SMTP id
 ada2fe7eead31-5d41d0e90a7mr4852980137.16.1759745676680; Mon, 06 Oct 2025
 03:14:36 -0700 (PDT)
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
 <8b46093f-82bc-1c25-5607-ee40923b51af@linux.intel.com>
In-Reply-To: <8b46093f-82bc-1c25-5607-ee40923b51af@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 6 Oct 2025 12:14:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUjhq2ZLFyMYv9KYRW8brsvXMH5xb5NW8shsHJmx7w2QQ@mail.gmail.com>
X-Gm-Features: AS18NWC5KGWvrz_HHf0tySLbjqGr7D7lZMasWqPn_OGCm63JWuDYeuOET_mZI-c
Message-ID: <CAMuHMdUjhq2ZLFyMYv9KYRW8brsvXMH5xb5NW8shsHJmx7w2QQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: Resources outside their window must set IORESOURCE_UNSET
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

On Fri, 3 Oct 2025 at 16:58, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
> On Fri, 3 Oct 2025, Geert Uytterhoeven wrote:
> > On Thu, 2 Oct 2025 at 18:59, Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > > On Thu, 2 Oct 2025, Geert Uytterhoeven wrote:
> > > > On Thu, 2 Oct 2025 at 16:54, Ilpo J=C3=A4rvinen
> > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > On Wed, 1 Oct 2025, Geert Uytterhoeven wrote:
> > > > > > On Wed, 1 Oct 2025 at 15:06, Ilpo J=C3=A4rvinen
> > > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > > On Wed, 1 Oct 2025, Geert Uytterhoeven wrote:
> > > > > > > > On Tue, 30 Sept 2025 at 18:32, Ilpo J=C3=A4rvinen
> > > > > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > > > > On Tue, 30 Sep 2025, Geert Uytterhoeven wrote:
> > > > > > > > > > On Fri, 26 Sept 2025 at 04:40, Ilpo J=C3=A4rvinen
> > > > > > > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > > > > > > PNP resources are checked for conflicts with the othe=
r resource in the
> > > > > > > > > > > system by quirk_system_pci_resources() that walks thr=
ough all PCI
> > > > > > > > > > > resources. quirk_system_pci_resources() correctly fil=
ters out resource
> > > > > > > > > > > with IORESOURCE_UNSET.
> > > > > > > > > > >
> > > > > > > > > > > Resources that do not reside within their bridge wind=
ow, however, are
> > > > > > > > > > > not properly initialized with IORESOURCE_UNSET result=
ing in bogus
> > > > > > > > > > > conflicts detected in quirk_system_pci_resources():
> > > > > > > > > > >
> > > > > > > > > > > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffffff=
 64bit pref]
> > > > > > > > > > > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffffff=
 64bit pref]: contains BAR 2 for 7 VFs
> > > > > > > > > > > ...
> > > > > > > > > > > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x1fffffff=
f 64bit pref]
> > > > > > > > > > > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x3dffffff=
ff 64bit pref]: contains BAR 2 for 31 VFs
> > > > > > > > > > > ...
> > > > > > > > > > > pnp 00:04: disabling [mem 0xfc000000-0xfc00ffff] beca=
use it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > > > > pnp 00:05: disabling [mem 0xc0000000-0xcfffffff] beca=
use it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
> > > > > > > > > > > pnp 00:05: disabling [mem 0xfedc0000-0xfedc7fff] beca=
use it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > > > > pnp 00:05: disabling [mem 0xfeda0000-0xfeda0fff] beca=
use it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > > > > pnp 00:05: disabling [mem 0xfeda1000-0xfeda1fff] beca=
use it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > > > > pnp 00:05: disabling [mem 0xc0000000-0xcfffffff disab=
led] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64=
bit pref]
> > > > > > > > > > > pnp 00:05: disabling [mem 0xfed20000-0xfed7ffff] beca=
use it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > > > > pnp 00:05: disabling [mem 0xfed90000-0xfed93fff] beca=
use it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > > > > pnp 00:05: disabling [mem 0xfed45000-0xfed8ffff] beca=
use it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > > > > pnp 00:05: disabling [mem 0xfee00000-0xfeefffff] beca=
use it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > > > >
> > > > > > > > > > > Mark resources that are not contained within their br=
idge window with
> > > > > > > > > > > IORESOURCE_UNSET in __pci_read_base() which resolves =
the false
> > > > > > > > > > > positives for the overlap check in quirk_system_pci_r=
esources().
> > > > > > > > > > >
> > > > > > > > > > > Fixes: f7834c092c42 ("PNP: Don't check for overlaps w=
ith unassigned PCI BARs")
> > > > > > > > > > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linu=
x.intel.com>
> > > > > > > > > >
> > > > > > > > > > Thanks for your patch, which is now commit 06b77d5647a4=
d6a7 ("PCI:
> > > > > > > > > > Mark resources IORESOURCE_UNSET when outside bridge win=
dows") in
> > > > > > > > > > linux-next/master next-20250929 pci/next
> > > > > > > >
> > > > > > > > > > This replaces the actual resources by their sizes in th=
e boot log on
> > > > > > > > > > e.g. on R-Car M2-W:
> > > > > > > > > >
> > > > > > > > > >      pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@e=
e090000 ranges:
> > > > > > > > > >      pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000.=
.0x00ee08ffff -> 0x00ee080000
> > > > > > > > > >      pci-rcar-gen2 ee090000.pci: PCI: revision 11
> > > > > > > > > >      pci-rcar-gen2 ee090000.pci: PCI host bridge to bus=
 0000:00
> > > > > > > > > >      pci_bus 0000:00: root bus resource [bus 00]
> > > > > > > > > >      pci_bus 0000:00: root bus resource [mem 0xee080000=
-0xee08ffff]
> > > > > > > > > >      pci 0000:00:00.0: [1033:0000] type 00 class 0x0600=
00 conventional PCI endpoint
> > > > > > > > > >     -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff=
]
> > > > > > > > > >     -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff=
 pref]
> > > > > > > > >
> > > > > > > > > What is going to be the parent of these resources? They d=
on't seem to fall
> > > > > > > > > under the root bus resource above in which case the outpu=
t change is
> > > > > > > > > intentional so they don't appear as if address range woul=
d be "okay".
> > > > > > > >
> > > > > > > > >From /proc/iomem:
> > > > > > > >
> > > > > > > >     ee080000-ee08ffff : pci@ee090000
> > > > > > > >       ee080000-ee080fff : 0000:00:01.0
> > > > > > > >         ee080000-ee080fff : ohci_hcd
> > > > > > > >       ee081000-ee0810ff : 0000:00:02.0
> > > > > > > >         ee081000-ee0810ff : ehci_hcd
> > > > > > > >     ee090000-ee090bff : ee090000.pci pci@ee090000
> > > > > > >
> > > > > > > Okay, so this seem to appear in the resource tree but not amo=
ng the root
> > > > > > > bus resources.
> > > > > > >
> > > > > > > >     ee0c0000-ee0cffff : pci@ee0d0000
> > > > > > > >       ee0c0000-ee0c0fff : 0001:01:01.0
> > > > > > > >         ee0c0000-ee0c0fff : ohci_hcd
> > > > > > > >       ee0c1000-ee0c10ff : 0001:01:02.0
> > > > > > > >         ee0c1000-ee0c10ff : ehci_hcd
> > > > > > > >
> > > > > > > > > When IORESOURCE_UNSET is set in a resource, %pR does not =
print the start
> > > > > > > > > and end addresses.
> > > > > > > >
> > > > > > > > Yeah, that's how I found this commit, without bisecting ;-)
> > > > > > > >
> > > > > > > > > >     +pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
> > > > > > > > > >     +pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
> > > > > > > > > >      pci 0000:00:01.0: [1033:0035] type 00 class 0x0c03=
10 conventional PCI endpoint
> > > > > > > > > >     -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff=
]
> > > > > > > > > >     +pci 0000:00:01.0: BAR 0 [mem size 0x00001000]
> > > > > > > > >
> > > > > > > > > For this resource, it's very much intentional. It's a zer=
o-based BAR which
> > > > > > > > > was left without IORESOURCE_UNSET prior to my patch leadi=
ng to others part
> > > > > > > > > of the kernel to think that resource range valid and in u=
se (in your
> > > > > > > > > case it's so small it wouldn't collide with anything but =
it wasn't
> > > > > > > > > properly set up resource, nonetheless).
> > > > > > > > >
> > > > > > > > > >      pci 0000:00:01.0: supports D1 D2
> > > > > > > > > >      pci 0000:00:01.0: PME# supported from D0 D1 D2 D3h=
ot
> > > > > > > > > >      pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c03=
20 conventional PCI endpoint
> > > > > > > > > >     -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff=
]
> > > > > > > > > >     +pci 0000:00:02.0: BAR 0 [mem size 0x00000100]
> > > > > > > > >
> > > > > > > > > And this as well is very much intentional.
> > > > > > > > >
> > > > > > > > > >      pci 0000:00:02.0: supports D1 D2
> > > > > > > > > >      pci 0000:00:02.0: PME# supported from D0 D1 D2 D3h=
ot
> > > > > > > > > >      PCI: bus0: Fast back to back transfers disabled
> > > > > > > > > >      pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff=
]: assigned
> > > > > > > > > >      pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff=
]: assigned
> > > > > > > > > >      pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08=
ffff]
> > > > > > > > > >
> > > > > > > > > > Is that intentional?
> > > > > > > > >
> > > > > > > > > There's also that pci_dbg() in the patch which would show=
 the original
> > > > > > > > > addresses (print the resource before setting IORESOURCE_U=
NSET) but to see
> > > > > > > > > it one would need to enable it with dyndbg=3D... Bjorn wa=
s thinking of
> > > > > > > > > making that pci_info() though so it would appear always.
> > > > > > > > >
> > > > > > > > > Was this the entire PCI related diff? I don't see those 0=
000:00:00.0 BARs
> > > > > > > > > getting assigned anywhere.
> > > > > > > >
> > > > > > > > The above log is almost complete (lacked enabling the devic=
e afterwards).
> > > > > > > >
> > > > > > > > AFAIU, the BARs come from the reg and ranges properties in =
the
> > > > > > > > PCI controller nodes;
> > > > > > > > https://elixir.bootlin.com/linux/v6.17/source/arch/arm/boot=
/dts/renesas/r8a7791.dtsi#L1562
> > > > > > >
> > > > > > > Thanks, although I had already found this line by grep. I was=
 just
> > > > > > > expecting the address appear among root bus resources too.
> > > > > > >
> > > > > > > Curiously enough, pci_register_host_bridge() seems to try to =
add some
> > > > > > > resource from that list into bus and it's what prints those "=
root bus
> > > > > > > resource" lines and ee090000 is not among the printed lines d=
espite
> > > > > > > appearing in /proc/iomem. As is, the resource tree and PCI bu=
s view on the
> > > > > > > resources seems to be in disagreement and I'm not sure what t=
o make of it.
> > > > > > >
> > > > > > > But before considering going into that direction or figuring =
out why this
> > > > > > > ee090000 resource does not appear among root bus resources, c=
ould you
> > > > > > > check if the attached patch changes behavior for the resource=
 which are
> > > > > > > non-zero based?
> > > > > >
> > > > > > This patch has no impact on dmesg, lspci output, or /proc/iomem
> > > > > > for pci-rcar-gen2.
> > > > >
> > > > > It would have been too easy... :-(
> > > > >
> > > > > I'm sorry I don't really know these platform well and I'm current=
ly trying
> > > > > to understand what adds that ee090000 resource into the resource =
tree
> > > > > and so far I've not been very successful.
> > > > >
> > > > > Perhaps it would be easiest to print a stacktrace when the resour=
ce is
> > > > > added but there are many possible functions. I think all of them
> > > > > converge in __request_resource() so I suggest adding:
> > > > >
> > > > > WARN_ON(new->start =3D=3D 0xee090000);
> > > > >
> > > > > before __request_resource() does anything.
> > > >
> > > >     Call trace:
> > > >      unwind_backtrace from show_stack+0x10/0x14
> > > >      show_stack from dump_stack_lvl+0x7c/0xb0
> > > >      dump_stack_lvl from __warn+0x80/0x198
> > > >      __warn from warn_slowpath_fmt+0xc0/0x124
> > > >      warn_slowpath_fmt from __request_resource+0x38/0xc8
> > > >      __request_resource from __request_region+0xc4/0x1e8
> > > >      __request_region from __devm_request_region+0x80/0xac
> > > >      __devm_request_region from __devm_ioremap_resource+0xcc/0x160
> > > >      __devm_ioremap_resource from rcar_pci_probe+0x58/0x350
> > > >      rcar_pci_probe from platform_probe+0x58/0x90
> > > >
> > > > I.e. the call to devm_platform_get_and_ioremap_resource() in
> > > > drivers/pci/controller/pci-rcar-gen2.c:rcar_pci_probe().
> > >
> > > Thanks, the patch below might help BAR0 (but I'm not sure if it's the
> > > correct solution due to being so unfamiliar with these kind of platfo=
rms
> > > and how they're initialized).
> >
> > Thanks, that has the following impact on dmesg:
> >
> >      pci-rcar-gen2 ee090000.pci: PCI: revision 11
> >      pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
> >      pci_bus 0000:00: root bus resource [bus 00]
> >     -pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
> >     +pci_bus 0000:00: root bus resource [mem 0xee080000-0xee090bff]
> >      pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 conventional
> > PCI endpoint
> >     -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]: no initial
> > claim (no window)
> >     -pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
> >     -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no
> > initial claim (no window)
> >     +pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
> >      pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
> >      pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310 conventional
> > PCI endpoint
> >     -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff]: no initial
> > claim (no window)
> >      pci 0000:00:01.0: BAR 0 [mem size 0x00001000]
> >      pci 0000:00:01.0: supports D1 D2
> >      pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
> >      pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320 conventional
> > PCI endpoint
> >     -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff]: no initial
> > claim (no window)
>
> Did you e.g. forget to change pci_dbg() to pci_info() as these all went
> away, I cannot see why it should disappear because of my patch?
>
> (No need to apologize if that was the case, just confirming if that
> explains it is enough. :-))

I indeed dropped that change. Adding it back...

> >      pci 0000:00:02.0: BAR 0 [mem size 0x00000100]
> >      pci 0000:00:02.0: supports D1 D2
> >      pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
> >      PCI: bus0: Fast back to back transfers disabled
> >      pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned
> >      pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned
>
> Perhaps print here what's the parent resource of these resource.

pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned (parent
[mem 0xee080000-0xee08ffff])
pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned (parent
[mem 0xee080000-0xee08ffff])

>
> >     -pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ffff]
> >     +pci_bus 0000:00: resource 4 [mem 0xee080000-0xee090bff]
> >      pci-rcar-gen2 ee0d0000.pci: adding to PM domain always-on
> >      PM: genpd_add_device: Add ee0d0000.pci to always-on
> >      pci-rcar-gen2 ee0d0000.pci: host bridge /soc/pci@ee0d0000 ranges:
> >     @@ -414,26 +416,22 @@ PM: =3D=3D=3D=3D always-on/ee0d0000.pci: star=
t
> >      pci-rcar-gen2 ee0d0000.pci: PCI: revision 11
> >      pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0001:01
> >      pci_bus 0001:01: root bus resource [bus 01]
> >     -pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0cffff]
> >     +pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0d0bff]
> >      pci 0001:01:00.0: [1033:0000] type 00 class 0x060000 conventional =
PCI endpoint
> >     -pci 0001:01:00.0: BAR 0 [mem 0xee0d0800-0xee0d0bff]: no initial cl=
aim (no window)
> >     -pci 0001:01:00.0: BAR 0 [mem size 0x00000400]
> >     -pci 0001:01:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no initi=
al claim (no window)
> >     +pci 0001:01:00.0: BAR 0 [mem 0xee0d0800-0xee0d0bff]
> >      pci 0001:01:00.0: BAR 1 [mem size 0x40000000 pref]
> >      pci 0001:01:01.0: [1033:0035] type 00 class 0x0c0310 conventional =
PCI endpoint
> >     -pci 0001:01:01.0: BAR 0 [mem 0x00000000-0x00000fff]: no initial cl=
aim (no window)
> >      pci 0001:01:01.0: BAR 0 [mem size 0x00001000]
> >      pci 0001:01:01.0: supports D1 D2
> >      pci 0001:01:01.0: PME# supported from D0 D1 D2 D3hot
> >      pci 0001:01:02.0: [1033:00e0] type 00 class 0x0c0320 conventional =
PCI endpoint
> >     -pci 0001:01:02.0: BAR 0 [mem 0x00000000-0x000000ff]: no initial cl=
aim (no window)
> >      pci 0001:01:02.0: BAR 0 [mem size 0x00000100]
> >      pci 0001:01:02.0: supports D1 D2
> >      pci 0001:01:02.0: PME# supported from D0 D1 D2 D3hot
> >      PCI: bus1: Fast back to back transfers disabled
> >      pci 0001:01:01.0: BAR 0 [mem 0xee0c0000-0xee0c0fff]: assigned
> >      pci 0001:01:02.0: BAR 0 [mem 0xee0c1000-0xee0c10ff]: assigned
> >     -pci_bus 0001:01: resource 4 [mem 0xee0c0000-0xee0cffff]
> >     +pci_bus 0001:01: resource 4 [mem 0xee0c0000-0xee0d0bff]
> >      rcar-pcie fe000000.pcie: adding to PM domain always-on
> >      PM: genpd_add_device: Add fe000000.pcie to always-on
> >      rcar-pcie fe000000.pcie: host bridge /soc/pcie@fe000000 ranges:
> >
> > and on /proc/iomem (I used "diff -w" to reduce clutter):
> >
> >      ec700000-ec70ffff : ec700000.dma-controller dma-controller@ec70000=
0
> >      ec720000-ec72ffff : ec720000.dma-controller dma-controller@ec72000=
0
> >      ec740000-ec7401ff : ec500000.sound audmapp
> >     -ee080000-ee08ffff : pci@ee090000
>
> So what did add this previous? (Maybe use the same WARN_ON() trick as
> previously to find out.)

First call:

    + __request_resource from request_resource_conflict+0x24/0x3c
    + request_resource_conflict from devm_request_resource+0x48/0x9c
    + devm_request_resource from devm_request_pci_bus_resources+0x5c/0x70
    + devm_request_pci_bus_resources from devm_of_pci_bridge_init+0x7c/0x1c=
0
    + devm_of_pci_bridge_init from devm_pci_alloc_host_bridge+0x44/0x6c
    + devm_pci_alloc_host_bridge from rcar_pci_probe+0x34/0x384
    + rcar_pci_probe from platform_probe+0x58/0x90

Second call:

    + __request_resource from allocate_resource+0x1b8/0x1d4
    + allocate_resource from pci_bus_alloc_from_region+0x1e0/0x220
    + pci_bus_alloc_from_region from pci_bus_alloc_resource+0x84/0xb8
    + pci_bus_alloc_resource from _pci_assign_resource+0x78/0x150
    + _pci_assign_resource from pci_assign_resource+0x10c/0x310
    + pci_assign_resource from assign_requested_resources_sorted+0x78/0xac
    + assign_requested_resources_sorted from
__assign_resources_sorted+0x74/0x5c4
    + __assign_resources_sorted from __pci_bus_assign_resources+0x50/0x1f0
    + __pci_bus_assign_resources from
pci_assign_unassigned_root_bus_resources+0xa8/0x190
    + pci_assign_unassigned_root_bus_resources from pci_host_probe+0x5c/0xb=
0
    + pci_host_probe from rcar_pci_probe+0x2e0/0x384
    + rcar_pci_probe from platform_probe+0x58/0x90

Third call:

    + __request_resource from __request_region+0xc4/0x1e8
    + __request_region from __devm_request_region+0x80/0xac
    + __devm_request_region from usb_hcd_pci_probe+0x15c/0x35c
    + usb_hcd_pci_probe from pci_device_probe+0x94/0x104
    + pci_device_probe from really_probe+0x128/0x28c

Fourth call:

    + __request_region from __devm_request_region+0x80/0xac
    + __devm_request_region from usb_hcd_pci_probe+0x15c/0x35c
    + usb_hcd_pci_probe from pci_device_probe+0x94/0x104
    + pci_device_probe from really_probe+0x128/0x28c

Fifth call:

    + __request_region from __devm_request_region+0x80/0xac
    + __devm_request_region from usb_hcd_pci_probe+0x15c/0x35c
    + usb_hcd_pci_probe from pci_device_probe+0x94/0x104
    + pci_device_probe from really_probe+0x128/0x28c

> It might have gotten broken because the coalesed resource
> ee080000-ee090bff overlaps with that other resource in the resource tree.
> But I don't see anything to that effect in the log so it's either silent
> failure or there's much filtered from the log.
>
> >     -  ee080000-ee080fff : 0000:00:01.0
> >          ee080000-ee080fff : ohci_hcd
> >     -  ee081000-ee0810ff : 0000:00:02.0
> >          ee081000-ee0810ff : ehci_hcd
> >      ee090000-ee090bff : ee090000.pci pci@ee090000
> >     -ee0c0000-ee0cffff : pci@ee0d0000
> >     -  ee0c0000-ee0c0fff : 0001:01:01.0
> >          ee0c0000-ee0c0fff : ohci_hcd
> >     -  ee0c1000-ee0c10ff : 0001:01:02.0
> >          ee0c1000-ee0c10ff : ehci_hcd
> >      ee0d0000-ee0d0bff : ee0d0000.pci pci@ee0d0000
> >      ee100000-ee100327 : ee100000.mmc mmc@ee100000
> >
> > Removing the pci@ee0x0000 and 000x:0x:0x.0 entries doesn't look
> > right to me? Or am I missing something?
>
> I cannot understand this output, these resources seem to have been now
> left without a parent and due to -w I don't know what's their real
> indentation level.

The *_hcd resources are now at the top level.

     ec700000-ec70ffff : ec700000.dma-controller dma-controller@ec700000
     ec720000-ec72ffff : ec720000.dma-controller dma-controller@ec720000
     ec740000-ec7401ff : ec500000.sound audmapp
    -ee080000-ee08ffff : pci@ee090000
    -  ee080000-ee080fff : 0000:00:01.0
    -    ee080000-ee080fff : ohci_hcd
    -  ee081000-ee0810ff : 0000:00:02.0
    -    ee081000-ee0810ff : ehci_hcd
    +ee080000-ee080fff : ohci_hcd
    +ee081000-ee0810ff : ehci_hcd
     ee090000-ee090bff : ee090000.pci pci@ee090000
    -ee0c0000-ee0cffff : pci@ee0d0000
    -  ee0c0000-ee0c0fff : 0001:01:01.0
    -    ee0c0000-ee0c0fff : ohci_hcd
    -  ee0c1000-ee0c10ff : 0001:01:02.0
    -    ee0c1000-ee0c10ff : ehci_hcd
    +ee0c0000-ee0c0fff : ohci_hcd
    +ee0c1000-ee0c10ff : ehci_hcd
     ee0d0000-ee0d0bff : ee0d0000.pci pci@ee0d0000
     ee100000-ee100327 : ee100000.mmc mmc@ee100000
     ee140000-ee1400ff : ee140000.mmc mmc@ee140000

I assume the others are gone because they now conflict with the *_hcd
resources at the top level.

> > > If this works, we'll also have to decide what to do with the BAR1 (it
> > > didn't appear in your (partial?) /proc/iomem quote so I'm left unsure=
 how
> > > to approach it).
> >
> > That is indeed not visible in /proc/iomem.
>
> I meant before the commit 06b77d5647a4d6a7 ("PCI Mark resources
> IORESOURCE_UNSET when outside bridge windows"), was it present?

No, it was not present.

> > I tried the following (whitespace-damaged):
> >
> > --- a/drivers/pci/controller/pci-rcar-gen2.c
> > +++ b/drivers/pci/controller/pci-rcar-gen2.c
> > @@ -179,6 +179,7 @@ static void rcar_pci_setup(struct rcar_pci *priv)
> >         unsigned long window_size;
> >         unsigned long window_addr;
> >         unsigned long window_pci;
> > +       struct resource res;
> >         u32 val;
> >
> >         entry =3D resource_list_first_type(&bridge->dma_ranges, IORESOU=
RCE_MEM);
> > @@ -191,6 +192,8 @@ static void rcar_pci_setup(struct rcar_pci *priv)
> >                 window_pci =3D entry->res->start - entry->offset;
> >                 window_size =3D resource_size(entry->res);
> >         }
> > +       resource_set_range(&res, window_addr, window_size);
>
> You need to set flags properly too as this now tried to insert BUS, not
> MEM resource (DEFINE_RES() might be the more appropriate in that case
> anyway).
>
> However, if there's not &bridge->dma_ranges ranges entry, rcar_pci_setup(=
)
> seems to initialize the resource to 0x40000000-0x7fffffff and I'm not sur=
e

I guess the not &bridge->dma_ranges case dates back to the time the
DTS didn't have dma-ranges yet.  However, upon closer look, the DTS
still doesn't have dma_ranges, thus always using the default.

> how it's supposed to work if there's more than one of these devices as pe=
r
> the log above.

Upon closer look, this is not a resource of the device, but an inbound
memory region.  Hence there is no issue if multiple devices use the
same region.

>
> > +       pci_add_resource(&bridge->windows, &res);
>
> What would be the backing resource in the resource tree for this? I'm not
> sure if pci_add_resource() is going to result in adding one into the
> resource tree.

Likewise, it should not appear in /proc/ioem.
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

