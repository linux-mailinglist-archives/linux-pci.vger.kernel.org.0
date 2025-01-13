Return-Path: <linux-pci+bounces-19683-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9658FA0BF21
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 18:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643533A50DE
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 17:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1B91494A7;
	Mon, 13 Jan 2025 17:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vDgj3bEX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FF32563
	for <linux-pci@vger.kernel.org>; Mon, 13 Jan 2025 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736790413; cv=none; b=JFnrMQhJNb9v5UTQbzvCnk00iaWoiBN0JpP759hksIheuroKeINYQ2MasNZYZ0zX9muqXyBrV7+z7GPwWgFBrM64nW1LS5vmEjoG2KQMZTb4UhiYePcid7I63AUq+fHBjdI3zKUFueOGqunlfRbxe4d91GVFYcsMZ5DlQYnlhYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736790413; c=relaxed/simple;
	bh=/guJ/M42fCKp013Gudm68uOTLZGnw3KpHZnMsc5/g1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llmIq8S6Slprpgn4X4igbTmc/7YDx5r2ELJ7PlCUMDIT/rVX+L57Ts7OAslfWZydEK2xlr6iRR2PL2CJuNj5P2l0+Ofo9mRAK/Jo4AC0UIhJOUbRstc/1yLmsmIjlZIqVAFDz82cnBVwIESeE0Fz5y/Qs0fQDLKnO6kukgXwcfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=vDgj3bEX; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E776D3F182
	for <linux-pci@vger.kernel.org>; Mon, 13 Jan 2025 17:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1736790401;
	bh=6k0i6EU4zIKytxSyi+AYexibSaDxfBRX/r0OE+Sv1PQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=vDgj3bEX13yiD53XpHUVWMYeZ2L0mvFfPMDt/Frphf7Nd69P7TDrfWgJYxrqhAmp/
	 IntbNaHTWKvftuc9NRDgZs9fQHFh/D0wTx2RylvXcYDvIq9LF1ADfEd1u+a+0WN2KH
	 azWCM4qx1api8pO+aoi8K/vti72lzFfDA03RH/2zIuTztVZ7ZnU0znrJinAaUiuj/v
	 q39Jc7wUa2kzKovqqe9dQ/yziTN41Jl4mcnzPuH13LiZZWvzZTFZ8tAS0ydfyDEoWo
	 HR+9oHivNrZCTotyOU+yvXYbUG8dvupR35svjGAP66voviLlaQ0+S7LCZAS2esBdfZ
	 /E0RI+2S2yVAw==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5d3cff6aedbso5308102a12.0
        for <linux-pci@vger.kernel.org>; Mon, 13 Jan 2025 09:46:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736790401; x=1737395201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6k0i6EU4zIKytxSyi+AYexibSaDxfBRX/r0OE+Sv1PQ=;
        b=XF5b5pJ70q6+nJQPR0+2UX5bBxi5fTlYpUNtPN91W8rZaIRpzRe6kyInUmOBo1BGfb
         PgaHYpqtXNj/2GLsm3K/oitsJiibZUzBBdtdxT7B/3nt7a7NUacprtpzmfnPSzKTYakv
         U9vXJF9jaObqHyxWJiROL6l6RiAVsUXhiScYpK6JmcSRKliy1Sn/jKKPi1v/lO187f0h
         j174G0si/FNO0MB04j58Lz2O1fFcSphacQOcCnNRx1+kLVSo80cMqTLuzUeOpTALBIo/
         u8vnobdWcXCxCrV4h7pRkp12ksPX34x6Ph2x8jcbbrPrIQxvEKG4vs4Io6OqdAIJIo4d
         cdmA==
X-Forwarded-Encrypted: i=1; AJvYcCV/+msbVEUQyOj03PPFtPOk7J8oj8HYsk8Q+fdPfo/hEqRarn1Koi4WoGTqV9l9DvwYcfsNZeJWcH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg0CLxLMvyAcsYTmjT03gjWmh3HW3uNjQQAqUJiGzte3ilhZoB
	CKlUum/rxXxYG/AgDOGbF3fk46INgE3vTmPd35rBv5ImRS5UyTAPhOGc0fO58TLBiTdhlYoVmic
	r2Y5anhyMqjMtjAQZIUPq5qJZOQl7QIN7JIFkicF2gjrwK8AR6QrOi1bE3mwZ8ONzVJsWZ8gIS0
	WRm9xiOU92BoSF95GTrV2ZT88H7xg3/9mMGvMoJzIiJXmL71wc
X-Gm-Gg: ASbGncs6tZnSW4TryzVWlwEWzQYlvQwkRaZv8XmNlY55ihIYtcgo1MEKlrjP7H/nEEG
	l75Ov3f4op/o0YmN97BIII3Rd0RzqbFBRMFWj
X-Received: by 2002:a05:6402:40c4:b0:5d9:f0d8:22d5 with SMTP id 4fb4d7f45d1cf-5d9f0d82554mr1206378a12.13.1736790401214;
        Mon, 13 Jan 2025 09:46:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7sEjW3WgnFo0NICjs9wU1BijRhGaNHZs+hz4F/7xIc4DXiG+D3iryKgccv24ha9+NPM6go9uo2j9qrRyKeDw=
X-Received: by 2002:a05:6402:40c4:b0:5d9:f0d8:22d5 with SMTP id
 4fb4d7f45d1cf-5d9f0d82554mr1206339a12.13.1736790400706; Mon, 13 Jan 2025
 09:46:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111210652.402845-1-alex.williamson@redhat.com>
In-Reply-To: <20250111210652.402845-1-alex.williamson@redhat.com>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Mon, 13 Jan 2025 11:46:29 -0600
X-Gm-Features: AbW1kvbZcVZwXu9f19rM7VnmWWme2P2bdmbnhG6bB4PqwXphtqsQ-CGvAP4xrJI
Message-ID: <CAHTA-uYxwKc_Y_u_APCqB1cOBrthJXqtG-4-n=dYihNe1ZFkxA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Batch BAR sizing operations
To: Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Alex.

Your approach is a bit cleaner than mine, and I verified that it
results in the same performance boost as my patch on my setup without
any noticeable regressions, so from my POV, either patch would be a
good solution.

Reviewed-by: "Mitchell Augustin" <mitchell.augustin@canonical.com>
Tested-by: "Mitchell Augustin" <mitchell.augustin@canonical.com>


On Sat, Jan 11, 2025 at 3:07=E2=80=AFPM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> Toggling memory enable is free on bare metal, but potentially expensive
> in virtualized environments as the device MMIO spaces are added and
> removed from the VM address space, including DMA mapping of those spaces
> through the IOMMU where peer-to-peer is supported.  Currently memory
> decode is disabled around sizing each individual BAR, even for SR-IOV
> BARs while VF Enable is cleared.
>
> This can be better optimized for virtual environments by sizing a set
> of BARs at once, stashing the resulting mask into an array, while only
> toggling memory enable once.  This also naturally improves the SR-IOV
> path as the caller becomes responsible for any necessary decode disables
> while sizing BARs, therefore SR-IOV BARs are sized relying only on the
> VF Enable rather than toggling the PF memory enable in the command
> register.
>
> Reported-by: Mitchell Augustin <mitchell.augustin@canonical.com>
> Link: https://lore.kernel.org/all/CAHTA-uYp07FgM6T1OZQKqAdSA5JrZo0ReNEyZg=
QZub4mDRrV5w@mail.gmail.com
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>
> This is an alternative to the patch proposed by Mitchell[1] and more
> in line with my suggestion in the original report thread[2].  It makes
> more sense to me to stash all the BAR sizing values into an array on
> the front end of parsing them into resources than it does to pass
> multiple arrays on the backend for status printing purposes.  We can
> discuss in either of these patches which is the better approach or
> if someone has a better yet alternative.
>
> I don't have quite the config Mitchell has for testing, but this
> should make effectively the same improvement and does show a
> significant improvement in guest boot time even with a single 24GB
> GPU attached.  There are of course further improvements to investigate
> in the VMM, but disabling memory decode per BAR is a good start to
> making Linux be a friendlier guest.  Further testing appreciate.
> Thanks,
>
> Alex
>
> [1]https://lore.kernel.org/all/20241218224258.2225210-1-mitchell.augustin=
@canonical.com/
> [2]https://lore.kernel.org/all/20241203150620.15431c5c.alex.williamson@re=
dhat.com/
>
>  drivers/pci/iov.c   |   8 ++-
>  drivers/pci/pci.h   |   4 +-
>  drivers/pci/probe.c | 132 +++++++++++++++++++++++++++++---------------
>  3 files changed, 97 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 4be402fe9ab9..9e4770cdd4d5 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -747,6 +747,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
>         struct resource *res;
>         const char *res_name;
>         struct pci_dev *pdev;
> +       u32 sriovbars[PCI_SRIOV_NUM_BARS];
>
>         pci_read_config_word(dev, pos + PCI_SRIOV_CTRL, &ctrl);
>         if (ctrl & PCI_SRIOV_CTRL_VFE) {
> @@ -783,6 +784,10 @@ static int sriov_init(struct pci_dev *dev, int pos)
>         if (!iov)
>                 return -ENOMEM;
>
> +       /* Sizing SR-IOV BARs with VF Enable cleared - no decode */
> +       __pci_size_stdbars(dev, PCI_SRIOV_NUM_BARS,
> +                          pos + PCI_SRIOV_BAR, sriovbars);
> +
>         nres =3D 0;
>         for (i =3D 0; i < PCI_SRIOV_NUM_BARS; i++) {
>                 res =3D &dev->resource[i + PCI_IOV_RESOURCES];
> @@ -796,7 +801,8 @@ static int sriov_init(struct pci_dev *dev, int pos)
>                         bar64 =3D (res->flags & IORESOURCE_MEM_64) ? 1 : =
0;
>                 else
>                         bar64 =3D __pci_read_base(dev, pci_bar_unknown, r=
es,
> -                                               pos + PCI_SRIOV_BAR + i *=
 4);
> +                                               pos + PCI_SRIOV_BAR + i *=
 4,
> +                                               &sriovbars[i]);
>                 if (!res->flags)
>                         continue;
>                 if (resource_size(res) & (PAGE_SIZE - 1)) {
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2e40fc63ba31..6f27651c2a70 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -315,8 +315,10 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci_b=
us *bus, int devfn, u32 *pl,
>  int pci_idt_bus_quirk(struct pci_bus *bus, int devfn, u32 *pl, int rrs_t=
imeout);
>
>  int pci_setup_device(struct pci_dev *dev);
> +void __pci_size_stdbars(struct pci_dev *dev, int count,
> +                       unsigned int pos, u32 *sizes);
>  int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
> -                   struct resource *res, unsigned int reg);
> +                   struct resource *res, unsigned int reg, u32 *sizes);
>  void pci_configure_ari(struct pci_dev *dev);
>  void __pci_bus_size_bridges(struct pci_bus *bus,
>                         struct list_head *realloc_head);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2e81ab0f5a25..5ca96280d698 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -164,50 +164,75 @@ static inline unsigned long decode_bar(struct pci_d=
ev *dev, u32 bar)
>
>  #define PCI_COMMAND_DECODE_ENABLE      (PCI_COMMAND_MEMORY | PCI_COMMAND=
_IO)
>
> +/**
> + * __pci_size_bars - Read the raw BAR mask for a range of PCI BARs
> + * @dev: the PCI device
> + * @count: number of BARs to size
> + * @pos: starting config space position
> + * @sizes: array to store mask values
> + * @rom: indicate whether to use ROM mask, which avoids enabling ROM BAR=
s
> + *
> + * Provided @sizes array must be sufficiently sized to store results for
> + * @count u32 BARs.  Caller is responsible for disabling decode to speci=
fied
> + * BAR range around calling this function.  This function is intended to=
 avoid
> + * disabling decode around sizing each BAR individually, which can resul=
t in
> + * non-trivial overhead in virtualized environments with very large PCI =
BARs.
> + */
> +static void __pci_size_bars(struct pci_dev *dev, int count,
> +                           unsigned int pos, u32 *sizes, bool rom)
> +{
> +       u32 orig, mask =3D rom ? PCI_ROM_ADDRESS_MASK : ~0;
> +       int i;
> +
> +       for (i =3D 0; i < count; i++, pos +=3D 4, sizes++) {
> +               pci_read_config_dword(dev, pos, &orig);
> +               pci_write_config_dword(dev, pos, mask);
> +               pci_read_config_dword(dev, pos, sizes);
> +               pci_write_config_dword(dev, pos, orig);
> +
> +               /*
> +                * All bits set in size means the device isn't working pr=
operly.
> +                * If the BAR isn't implemented, all bits must be 0.  If =
it's a
> +                * memory BAR or a ROM, bit 0 must be clear; if it's an i=
o BAR,
> +                * bit 1 must be clear.
> +                */
> +               if (PCI_POSSIBLE_ERROR(*sizes))
> +                       *sizes =3D 0;
> +       }
> +}
> +
> +void __pci_size_stdbars(struct pci_dev *dev, int count,
> +                       unsigned int pos, u32 *sizes)
> +{
> +       __pci_size_bars(dev, count, pos, sizes, false);
> +}
> +
> +static void __pci_size_rom(struct pci_dev *dev, unsigned int pos, u32 *s=
izes)
> +{
> +       __pci_size_bars(dev, 1, pos, sizes, true);
> +}
> +
>  /**
>   * __pci_read_base - Read a PCI BAR
>   * @dev: the PCI device
>   * @type: type of the BAR
>   * @res: resource buffer to be filled in
>   * @pos: BAR position in the config space
> + * @sizes: array of one or more pre-read BAR masks
>   *
>   * Returns 1 if the BAR is 64-bit, or 0 if 32-bit.
>   */
>  int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
> -                   struct resource *res, unsigned int pos)
> +                   struct resource *res, unsigned int pos, u32 *sizes)
>  {
> -       u32 l =3D 0, sz =3D 0, mask;
> +       u32 l =3D 0;
>         u64 l64, sz64, mask64;
> -       u16 orig_cmd;
>         struct pci_bus_region region, inverted_region;
>         const char *res_name =3D pci_resource_name(dev, res - dev->resour=
ce);
>
> -       mask =3D type ? PCI_ROM_ADDRESS_MASK : ~0;
> -
> -       /* No printks while decoding is disabled! */
> -       if (!dev->mmio_always_on) {
> -               pci_read_config_word(dev, PCI_COMMAND, &orig_cmd);
> -               if (orig_cmd & PCI_COMMAND_DECODE_ENABLE) {
> -                       pci_write_config_word(dev, PCI_COMMAND,
> -                               orig_cmd & ~PCI_COMMAND_DECODE_ENABLE);
> -               }
> -       }
> -
>         res->name =3D pci_name(dev);
>
>         pci_read_config_dword(dev, pos, &l);
> -       pci_write_config_dword(dev, pos, l | mask);
> -       pci_read_config_dword(dev, pos, &sz);
> -       pci_write_config_dword(dev, pos, l);
> -
> -       /*
> -        * All bits set in sz means the device isn't working properly.
> -        * If the BAR isn't implemented, all bits must be 0.  If it's a
> -        * memory BAR or a ROM, bit 0 must be clear; if it's an io BAR, b=
it
> -        * 1 must be clear.
> -        */
> -       if (PCI_POSSIBLE_ERROR(sz))
> -               sz =3D 0;
>
>         /*
>          * I don't know how l can have all bits set.  Copied from old cod=
e.
> @@ -221,35 +246,30 @@ int __pci_read_base(struct pci_dev *dev, enum pci_b=
ar_type type,
>                 res->flags |=3D IORESOURCE_SIZEALIGN;
>                 if (res->flags & IORESOURCE_IO) {
>                         l64 =3D l & PCI_BASE_ADDRESS_IO_MASK;
> -                       sz64 =3D sz & PCI_BASE_ADDRESS_IO_MASK;
> +                       sz64 =3D *sizes & PCI_BASE_ADDRESS_IO_MASK;
>                         mask64 =3D PCI_BASE_ADDRESS_IO_MASK & (u32)IO_SPA=
CE_LIMIT;
>                 } else {
>                         l64 =3D l & PCI_BASE_ADDRESS_MEM_MASK;
> -                       sz64 =3D sz & PCI_BASE_ADDRESS_MEM_MASK;
> +                       sz64 =3D *sizes & PCI_BASE_ADDRESS_MEM_MASK;
>                         mask64 =3D (u32)PCI_BASE_ADDRESS_MEM_MASK;
> +
> +                       if (res->flags & IORESOURCE_MEM_64) {
> +                               pci_read_config_dword(dev, pos + 4, &l);
> +                               sizes++;
> +
> +                               l64 |=3D ((u64)l << 32);
> +                               sz64 |=3D ((u64)*sizes << 32);
> +                               mask64 |=3D ((u64)~0 << 32);
> +                       }
>                 }
>         } else {
>                 if (l & PCI_ROM_ADDRESS_ENABLE)
>                         res->flags |=3D IORESOURCE_ROM_ENABLE;
>                 l64 =3D l & PCI_ROM_ADDRESS_MASK;
> -               sz64 =3D sz & PCI_ROM_ADDRESS_MASK;
> +               sz64 =3D *sizes & PCI_ROM_ADDRESS_MASK;
>                 mask64 =3D PCI_ROM_ADDRESS_MASK;
>         }
>
> -       if (res->flags & IORESOURCE_MEM_64) {
> -               pci_read_config_dword(dev, pos + 4, &l);
> -               pci_write_config_dword(dev, pos + 4, ~0);
> -               pci_read_config_dword(dev, pos + 4, &sz);
> -               pci_write_config_dword(dev, pos + 4, l);
> -
> -               l64 |=3D ((u64)l << 32);
> -               sz64 |=3D ((u64)sz << 32);
> -               mask64 |=3D ((u64)~0 << 32);
> -       }
> -
> -       if (!dev->mmio_always_on && (orig_cmd & PCI_COMMAND_DECODE_ENABLE=
))
> -               pci_write_config_word(dev, PCI_COMMAND, orig_cmd);
> -
>         if (!sz64)
>                 goto fail;
>
> @@ -320,7 +340,11 @@ int __pci_read_base(struct pci_dev *dev, enum pci_ba=
r_type type,
>
>  static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, in=
t rom)
>  {
> +       u32 rombar, stdbars[PCI_STD_NUM_BARS];
>         unsigned int pos, reg;
> +       u16 orig_cmd;
> +
> +       BUILD_BUG_ON(howmany > PCI_STD_NUM_BARS);
>
>         if (dev->non_compliant_bars)
>                 return;
> @@ -329,10 +353,28 @@ static void pci_read_bases(struct pci_dev *dev, uns=
igned int howmany, int rom)
>         if (dev->is_virtfn)
>                 return;
>
> +       /* No printks while decoding is disabled! */
> +       if (!dev->mmio_always_on) {
> +               pci_read_config_word(dev, PCI_COMMAND, &orig_cmd);
> +               if (orig_cmd & PCI_COMMAND_DECODE_ENABLE) {
> +                       pci_write_config_word(dev, PCI_COMMAND,
> +                               orig_cmd & ~PCI_COMMAND_DECODE_ENABLE);
> +               }
> +       }
> +
> +       __pci_size_stdbars(dev, howmany, PCI_BASE_ADDRESS_0, stdbars);
> +       if (rom)
> +               __pci_size_rom(dev, rom, &rombar);
> +
> +       if (!dev->mmio_always_on &&
> +           (orig_cmd & PCI_COMMAND_DECODE_ENABLE))
> +               pci_write_config_word(dev, PCI_COMMAND, orig_cmd);
> +
>         for (pos =3D 0; pos < howmany; pos++) {
>                 struct resource *res =3D &dev->resource[pos];
>                 reg =3D PCI_BASE_ADDRESS_0 + (pos << 2);
> -               pos +=3D __pci_read_base(dev, pci_bar_unknown, res, reg);
> +               pos +=3D __pci_read_base(dev, pci_bar_unknown,
> +                                      res, reg, &stdbars[pos]);
>         }
>
>         if (rom) {
> @@ -340,7 +382,7 @@ static void pci_read_bases(struct pci_dev *dev, unsig=
ned int howmany, int rom)
>                 dev->rom_base_reg =3D rom;
>                 res->flags =3D IORESOURCE_MEM | IORESOURCE_PREFETCH |
>                                 IORESOURCE_READONLY | IORESOURCE_SIZEALIG=
N;
> -               __pci_read_base(dev, pci_bar_mem32, res, rom);
> +               __pci_read_base(dev, pci_bar_mem32, res, rom, &rombar);
>         }
>  }
>
> --
> 2.47.1
>


--
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering

