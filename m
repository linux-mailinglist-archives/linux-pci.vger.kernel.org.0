Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80E73ACCDB
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 15:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbhFRN55 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 09:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbhFRN54 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Jun 2021 09:57:56 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BED3C061574;
        Fri, 18 Jun 2021 06:55:47 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gt18so16028323ejc.11;
        Fri, 18 Jun 2021 06:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kS7LsTY4eD7PtOoLcWypfb1WOFaf7PfUkRMKOVYnU+8=;
        b=Mp8tuTYLkmhc2aO3txv/mJbnJaHomRPOnKpHFfGlEj0F5FZMWhn/WejQ5nBaAdZXMU
         iMd6s7lxRWbBhfiuKES3JS+NmSeIksru1Xfe2WVkch95GxeeTAkUDNVfte1AfILCP8eT
         rggyQjstzIm+IOaQhxRXwhAVP/xwM/m+dsvWGyLYU0KhsKsg15rteqVvzcRLQHVOGtaw
         tEDvOh5UDjW5f6H3YWsy8vQMl5I1V9cCfMQW0X8KIYEzdLXqyANtNKf0bco7UK3pxuIf
         qERAVUFHuseSd5OE465zS9IlyYu2QN04S4sy4pkM60b75/Nwrb8k2LfOHvACVRh9Y+0A
         4FiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kS7LsTY4eD7PtOoLcWypfb1WOFaf7PfUkRMKOVYnU+8=;
        b=sE/wIt0KYsgm71UPKq1LjZBIyT9EW7W2Z8LZM8MNVBsjiQftJE46auSmfJ8v/uj8Vw
         7ob/RIV/Br3Uub+vAWG0aWJ1VfHLrBSR4Xdtn2ubyfdJ22J5U2rVHehd4tc0i6Sg5e3J
         EDCoV+Nx0MoSPW0ch+epPjIyNCPGitMU9QcD8GOrNvDAxzzcCnTWgIeJwJlH3qapi4uv
         Hmd4/G7JA4wHPtdgiGiNdZTQo3SF5hR64dqQV99Sjz3F2u/pFw2dNZbk7yCNeUUUmYt1
         r0ICle4l8GxGJMAY4Sklivt76Rk9ziC/PGSHKcy+zLXox4HQdGQo9iQdha1b/LPNR9/A
         xe9w==
X-Gm-Message-State: AOAM532veeLNuh0iuzVdlxibeid2OtxKMkv5UbClf35pSN5PRvyqb58c
        A9++l/0R6Ouq8D15YWkTzko=
X-Google-Smtp-Source: ABdhPJwvfW1ZR5K8R4Kq8/9q1FbEYvOuZOvnuZsxlhZRv8R4PJJ7ikwI4mv3rkJsNxtWK/fFG+YAYg==
X-Received: by 2002:a17:906:6849:: with SMTP id a9mr11363699ejs.415.1624024545629;
        Fri, 18 Jun 2021 06:55:45 -0700 (PDT)
Received: from m4.home (tor-exit-2.zbau.f3netze.de. [2a0b:f4c0:16c:2::1])
        by smtp.gmail.com with ESMTPSA id gz12sm1091362ejc.36.2021.06.18.06.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 06:55:44 -0700 (PDT)
Sender: Domenico Andreoli <domenico.andreoli.it@gmail.com>
Received: from cavok by m4.home with local (Exim 4.94.2)
        (envelope-from <cavok@m4>)
        id 1luEyF-0000bC-CI; Fri, 18 Jun 2021 15:55:43 +0200
Date:   Fri, 18 Jun 2021 15:55:43 +0200
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Punit Agrawal <punitagrawal@gmail.com>, robh+dt@kernel.org,
        maz@kernel.org, leobras.c@gmail.com,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, alexandru.elisei@arm.com, wqu@suse.com,
        robin.murphy@arm.com, pgwipeout@gmail.com, ardb@kernel.org,
        briannorris@chromium.org, shawn.lin@rock-chips.com,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4] PCI: of: Clear 64-bit flag for non-prefetchable
 memory below 4GB
Message-ID: <YMyl31ERhGDE1yGh@m4>
References: <20210614230457.752811-1-punitagrawal@gmail.com>
 <20210616231234.GA3018015@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/GHSmsL4CpCm23nY"
Content-Disposition: inline
In-Reply-To: <20210616231234.GA3018015@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--/GHSmsL4CpCm23nY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 16, 2021 at 06:12:34PM -0500, Bjorn Helgaas wrote:
> On Tue, Jun 15, 2021 at 08:04:57AM +0900, Punit Agrawal wrote:
> > Alexandru and Qu reported this resource allocation failure on
> > ROCKPro64 v2 and ROCK Pi 4B, both based on the RK3399:
> >=20
> >   pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff 64bit]
> >   pci 0000:00:00.0: PCI bridge to [bus 01]
> >   pci 0000:00:00.0: BAR 14: no space for [mem size 0x00100000]
> >   pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
> >=20
> > "BAR 14" is the PCI bridge's 32-bit non-prefetchable window, and our
> > PCI allocation code isn't smart enough to allocate it in a host
> > bridge window marked as 64-bit, even though this should work fine.
> >=20
> > A DT host bridge description includes the windows from the CPU
> > address space to the PCI bus space.  On a few architectures
> > (microblaze, powerpc, sparc), the DT may also describe PCI devices
> > themselves, including their BARs.
> >=20
> > Before 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource
> > flags for 64-bit memory addresses"), of_bus_pci_get_flags() ignored
> > the fact that some DT addresses described 64-bit windows and BARs.
> > That was a problem because the virtio virtual NIC has a 32-bit BAR
> > and a 64-bit BAR, and the driver couldn't distinguish them.
> >=20
> > 9d57e61bf723 set IORESOURCE_MEM_64 for those 64-bit DT ranges, which
> > fixed the virtio driver.  But it also set IORESOURCE_MEM_64 for host
> > bridge windows, which exposed the fact that the PCI allocator isn't
> > smart enough to put 32-bit resources in those 64-bit windows.
> >=20
> > Clear IORESOURCE_MEM_64 from host bridge windows since we don't need
> > that information.
> >=20
> > Fixes: 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags f=
or 64-bit memory addresses")
> > Reported-at: https://lore.kernel.org/lkml/7a1e2ebc-f7d8-8431-d844-41a9c=
36a8911@arm.com/
> > Reported-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > Reported-by: Qu Wenruo <wqu@suse.com>
> > Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
>=20
> Applied with:
>=20
>     Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>
>     Reviewed-by: Rob Herring <robh@kernel.org>
>     Acked-by: Ard Biesheuvel <ardb@kernel.org>
>=20
> to for-linus for v5.13, thanks a lot!

Late-tested-by: Domenico Andreoli <domenico.andreoli@linux.com>

See https://lore.kernel.org/lkml/YMyTUv7Jsd89PGci@m4/T/#u

Thanks!

Dom

--=20
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05

--/GHSmsL4CpCm23nY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE0znebYyV6RAN/q8htwRzp/vsqYEFAmDMpd4ACgkQtwRzp/vs
qYE8bBAAvdg4Ph1fMCdtPFOlq3OJ4H6H+miCxcsoYKa5hAJmPfNoO11Dl/NDCpPt
IBHXANLck5mg3h6JchBflok3uciGEoWsuFeOrc0ZfEd4lZxE4/SlL5PgJXKcFnn0
FepNItnn9UoShx7maGUL+ln0L+ZsPqbVarrKZlisaPOdZWAVEEhvPiZ/nHuc+Ok7
9X9Ak96OhHkNtJ+PAidSkxJt8L2BchSJbF1bkvUCL2gzdhGcNrqmIUvX3fTtMuUF
4ErL36lc1FaLCHpmZO5+TEs4THdlYoPJdmTJ4chYnCLi0kW5tw7b2EEtJ9oglih4
wrxPfuHNheQ+NqXrTGARzuJ9uxuDzE4tbFWd9VDwufuqM5nTyX+UjPHw9UNmrKXx
nT6AoLRfNk4zBwtwrviXOPTRckDiInBOW8zxdNWs28CvtSEkDjk1oXdBVqdMEFrL
tGoJZC5hOOzZokHYNUHtemblVbDqwi/5BHIRK/gKs3ym6mUuAX+3C84tXw9OPVH2
jiJutDbhbqJoqJxdAz9A81CEI5PpHqtkJ+LHcTlGKd+lReb2YafC/GZNGAJK8UEx
fP/GRfn6YKFoP7YwDnh1lIZ+2ReDA8ObkW4MvrqpvFYlCdGBmM/wOS4MDqr+Jp3u
Ys5WekD5aeKo7Xt5p0+ZhIx5RUp90rCz8aw6cfN7grk6Bwexw2c=
=aphM
-----END PGP SIGNATURE-----

--/GHSmsL4CpCm23nY--
