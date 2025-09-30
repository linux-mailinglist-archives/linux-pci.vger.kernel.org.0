Return-Path: <linux-pci+bounces-37270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47471BADF7B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 17:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB5B32275D
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 15:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F5D3043DD;
	Tue, 30 Sep 2025 15:47:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D0E303A16
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759247253; cv=none; b=fratLr+NTeY0afDfy4hFaQl2pm+WiUUbdDc17Eqg4k2DamjIKWe8DZegQWnR8aSKPNaNkLUaaI5/MY8r+A7qoEoEI/5y9lj0De5REe7Qw3PvgoMssbuwRJGOxIZn+iCN4BQSKQE34+SvbE9RMWM/RkApZwvcClmfGoG2RW2x5vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759247253; c=relaxed/simple;
	bh=/GTRr+rLD7K2TzCWfU4DUzYHCm/dB5H1CMW4shlEIrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjH+V3hslQqcsXs0nVSCgiexcEJ6xOAjcZhQi8kC2tydiuIleIxJeBrQGSTRnix9PJ2Hqq+yRNgvqUzl6wxo9PoKNr0+9roL99rIlbZefK7wyvE79kSu9796AjVwCMiCmlJ1sqyzraCJ52FZ7saTVCYt1OdbBNOP6kME9cfH3uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-54a86cc950dso1046911e0c.2
        for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 08:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759247249; x=1759852049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1oYdI5DgHZdeROfFJCaPLP7qCG2FJdSJntNb3cbOMs=;
        b=gcl0H59mEb2aQfV3gIbedhe1jxvZaDYqUdV8zQszCtEyX2Z/hq1JFL30I+01033S9z
         PDCT5qTQiFTSzWIxj55Dbv82CJuCfeH47niV1PU1MSW0mtGY4VlbzyoH+vTyuLhDFGoY
         TIXPyjL4mITCGRjUzrGJibVlsMaeLoqdijnKaUC3ZC+ixP4nMlrQIKkfijcVQZySRQcJ
         DxD5oorMpdOGtZ50r4DyA2q+S4pCBDRNekaFhUBJzhStyFGspDnH7EkpOp6gdeKoeHez
         hdMZWsC8TAsDwEYREmSeH0LXvFDx3WnVpBLl4D7FN1rI5o0z3YmPP3ZGj85Svety+ifk
         3t4Q==
X-Gm-Message-State: AOJu0Yy4PSxjJV3Xsdgyd/Czgh0FU8wae0JzXBxnVNsU+D5pNaQdZp6i
	dX78RNbmf2X/mKOptrmqFD9GktclTGnH0YnRC6Io1V/nDd7PpJbhNhkYjYkRDqkk
X-Gm-Gg: ASbGncsNJMwrnNN5/a/idWAlYuL3siizpSn9F9r90i2vGfVOsW0WFr3fLH6TMVqW5am
	5urwErO3Ucvlq9uF3jE/KYImA7r9P3kMB08CUPYfkNjsr94Qt5oduaPNgbxGAFMKhjsuTNLJVWb
	QXtSnsFzxNYuRsagl4JLki2r+EluFp2mKSXPOgr8iv6oKdtK1uv75Af53RUY2uPiyXWkou7h0Zq
	4iXDF0SpSml4SRlW3DtMqUTfGn1+kohb/oAn/rsgn8zR4lAatgnc/xE0rBDcFvBUaLaaIpFsq+D
	S359nXHGwgjqd10VRu3NpNLP3UvLzzfcQeGLtaR0GNvu0XsO+QQ4D77d8CyazdMFGSJtvLstJag
	FMxcTDl3l9eq42OI5pOOiiuLJkaqx15bqK3JNMuQqSHRnRd2WT3BSNqpr0lnlbN0IQnx7r1++Ue
	yQ4bAlSjmhuVZy
X-Google-Smtp-Source: AGHT+IHzzhbUzO11AgXeQmaJXeE10Rac1mWXgyLuhF/bYgKFulxy7z0m76t3hFw+4N8akF+6/lVZQA==
X-Received: by 2002:a05:6122:c2d3:10b0:54a:a782:47de with SMTP id 71dfb90a1353d-5522d3bbe9fmr34283e0c.13.1759247249118;
        Tue, 30 Sep 2025 08:47:29 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54cccc23afbsm1700992e0c.13.2025.09.30.08.47.28
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 08:47:28 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-54a81bf36ebso942227e0c.3
        for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 08:47:28 -0700 (PDT)
X-Received: by 2002:a05:6122:d98:b0:538:d49b:719 with SMTP id
 71dfb90a1353d-5522d1b261emr65053e0c.1.1759247247997; Tue, 30 Sep 2025
 08:47:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com> <20250924134228.1663-3-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20250924134228.1663-3-ilpo.jarvinen@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Sep 2025 17:47:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVtVzcL3AX0uetNhKr-gLij37Ww+fcWXxnYpO3xRAOthA@mail.gmail.com>
X-Gm-Features: AS18NWCo0u0uKjaP0aHUnOkHmV_Iy_nS2MkwIx0vpZfnx2vg_M_a1UQOALbe6hg
Message-ID: <CAMuHMdVtVzcL3AX0uetNhKr-gLij37Ww+fcWXxnYpO3xRAOthA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: Resources outside their window must set IORESOURCE_UNSET
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, 
	Lucas De Marchi <lucas.demarchi@intel.com>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

On Fri, 26 Sept 2025 at 04:40, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
> PNP resources are checked for conflicts with the other resource in the
> system by quirk_system_pci_resources() that walks through all PCI
> resources. quirk_system_pci_resources() correctly filters out resource
> with IORESOURCE_UNSET.
>
> Resources that do not reside within their bridge window, however, are
> not properly initialized with IORESOURCE_UNSET resulting in bogus
> conflicts detected in quirk_system_pci_resources():
>
> pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffffff 64bit pref]
> pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffffff 64bit pref]: contai=
ns BAR 2 for 7 VFs
> ...
> pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x1ffffffff 64bit pref]
> pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x3dffffffff 64bit pref]: cont=
ains BAR 2 for 31 VFs
> ...
> pnp 00:04: disabling [mem 0xfc000000-0xfc00ffff] because it overlaps 0000=
:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> pnp 00:05: disabling [mem 0xc0000000-0xcfffffff] because it overlaps 0000=
:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
> pnp 00:05: disabling [mem 0xfedc0000-0xfedc7fff] because it overlaps 0000=
:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> pnp 00:05: disabling [mem 0xfeda0000-0xfeda0fff] because it overlaps 0000=
:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> pnp 00:05: disabling [mem 0xfeda1000-0xfeda1fff] because it overlaps 0000=
:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> pnp 00:05: disabling [mem 0xc0000000-0xcfffffff disabled] because it over=
laps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> pnp 00:05: disabling [mem 0xfed20000-0xfed7ffff] because it overlaps 0000=
:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> pnp 00:05: disabling [mem 0xfed90000-0xfed93fff] because it overlaps 0000=
:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> pnp 00:05: disabling [mem 0xfed45000-0xfed8ffff] because it overlaps 0000=
:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> pnp 00:05: disabling [mem 0xfee00000-0xfeefffff] because it overlaps 0000=
:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
>
> Mark resources that are not contained within their bridge window with
> IORESOURCE_UNSET in __pci_read_base() which resolves the false
> positives for the overlap check in quirk_system_pci_resources().
>
> Fixes: f7834c092c42 ("PNP: Don't check for overlaps with unassigned PCI B=
ARs")
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Thanks for your patch, which is now commit 06b77d5647a4d6a7 ("PCI:
Mark resources IORESOURCE_UNSET when outside bridge windows") in
linux-next/master next-20250929 pci/next

This replaces the actual resources by their sizes in the boot log on
e.g. on R-Car M2-W:

     pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 ranges:
     pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08ffff
-> 0x00ee080000
     pci-rcar-gen2 ee090000.pci: PCI: revision 11
     pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
     pci_bus 0000:00: root bus resource [bus 00]
     pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
     pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 conventional
PCI endpoint
    -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
    -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]
    +pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
    +pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
     pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310 conventional
PCI endpoint
    -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff]
    +pci 0000:00:01.0: BAR 0 [mem size 0x00001000]
     pci 0000:00:01.0: supports D1 D2
     pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
     pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320 conventional
PCI endpoint
    -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff]
    +pci 0000:00:02.0: BAR 0 [mem size 0x00000100]
     pci 0000:00:02.0: supports D1 D2
     pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
     PCI: bus0: Fast back to back transfers disabled
     pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned
     pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned
     pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ffff]

Is that intentional?

> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -205,6 +205,26 @@ static void __pci_size_rom(struct pci_dev *dev, unsi=
gned int pos, u32 *sizes)
>         __pci_size_bars(dev, 1, pos, sizes, true);
>  }
>
> +static struct resource *pbus_select_window_for_res_addr(
> +                                       const struct pci_bus *bus,
> +                                       const struct resource *res)
> +{
> +       unsigned long type =3D res->flags & IORESOURCE_TYPE_BITS;
> +       struct resource *r;
> +
> +       pci_bus_for_each_resource(bus, r) {
> +               if (!r || r =3D=3D &ioport_resource || r =3D=3D &iomem_re=
source)
> +                       continue;
> +
> +               if ((r->flags & IORESOURCE_TYPE_BITS) !=3D type)
> +                       continue;
> +
> +               if (resource_contains(r, res))
> +                       return r;
> +       }
> +       return NULL;
> +}
> +
>  /**
>   * __pci_read_base - Read a PCI BAR
>   * @dev: the PCI device
> @@ -329,6 +349,18 @@ int __pci_read_base(struct pci_dev *dev, enum pci_ba=
r_type type,
>                          res_name, (unsigned long long)region.start);
>         }
>
> +       if (!(res->flags & IORESOURCE_UNSET)) {
> +               struct resource *b_res;
> +
> +               b_res =3D pbus_select_window_for_res_addr(dev->bus, res);
> +               if (!b_res ||
> +                   b_res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLE=
D)) {
> +                       pci_dbg(dev, "%s %pR: no initial claim (no window=
)\n",
> +                               res_name, res);
> +                       res->flags |=3D IORESOURCE_UNSET;
> +               }
> +       }
> +
>         goto out;
>
>

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

