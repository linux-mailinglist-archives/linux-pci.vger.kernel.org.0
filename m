Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6172822F679
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 19:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbgG0RVy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 13:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgG0RVy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2020 13:21:54 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E621AC061794;
        Mon, 27 Jul 2020 10:21:53 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id v22so1950984edy.0;
        Mon, 27 Jul 2020 10:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JQFg/tuqC69nq4syC+NIzcUchGfUtpXP0Ly9EEV6q9w=;
        b=bR0FASMjL4z+0B/JjcAOfYteJgbqeP8phEzKi5euWMWPMmwA5lazWKCYGAUdocKlAy
         tSc2QXxiNeAOixUwttglaxM+a+/PR/UpTPyn54J/dxBCixJsirZ47GVR6s7O9zitXJeY
         fRk3QXB1fXKsPfFnQEw2g65ENidyRLvCIcnzvFoivqHwd67q5QlgbYUC6EGysfYlFvL9
         cpdB8JtsNFnbHDZfpAYLA+a64bb8SP89P+ICFtmLlR4Hsv2aHCME4WQYTqspXHW3ZzRN
         Vzso4Zpa4m51BFx71j8YLd3z1E9Ssc7RCVgixRBQJP10x+uljl7nRWLeJfDdl9Th80vJ
         U5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JQFg/tuqC69nq4syC+NIzcUchGfUtpXP0Ly9EEV6q9w=;
        b=tmv9GhBpilzZnky/DaAj9BkPfiuP838MthiQ7WayqpwL3V6xVDtHZcSwCuLef7gy0w
         BCEqyMcCPutqAySILeXwVQ6vKE8dhqaauR7zFGsynnIEVIJD2E68G3kmS8hMfdhlSgZb
         oJOIv2qJs9mZMu2d+RGB/XxcTijc6s/2dZqqK3vMbmIozZfD3LGap2vHlILRshrJPjDZ
         tYeNCtRCRld5AAYjTkHPj3FQh1FUZOqQPFOcseth3zzHO+F8L5DQ8s7JsN3+TEOHI+1X
         lY4sRjkAizFbu+Uwx/Z7uT5F0vJ+ju+8qGLeLbqiPG2EaKCU1B2nCUINzCKZhn03Vxr8
         2Nxg==
X-Gm-Message-State: AOAM532f8m+vrn1t75KbiOlbrKQoA4HfQ0/VH4PM2HnamZH02+e9fxMr
        nZsp1gMyDLJE23B3y2Ps6UA=
X-Google-Smtp-Source: ABdhPJyKry89myng9wQIUC9m3H7em+oOGI6l4RFO9E36aaGOh8XqIHdY+ObjRip7xj/46V7E1bZ3SQ==
X-Received: by 2002:a05:6402:1841:: with SMTP id v1mr22405337edy.198.1595870512455;
        Mon, 27 Jul 2020 10:21:52 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id h24sm7373165ejg.53.2020.07.27.10.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 10:21:50 -0700 (PDT)
Date:   Mon, 27 Jul 2020 19:21:49 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] PCI: tegra: Remove PLL power supplies
Message-ID: <20200727172149.GA3683017@ulmo>
References: <20200623145528.1658337-1-thierry.reding@gmail.com>
 <20200623145528.1658337-2-thierry.reding@gmail.com>
 <CAL_Jsq+u=oFUAuURy-f8wCzagA-xKJES8RRf=kUSXJHoxOipBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+u=oFUAuURy-f8wCzagA-xKJES8RRf=kUSXJHoxOipBQ@mail.gmail.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2020 at 10:21:42AM -0600, Rob Herring wrote:
> On Tue, Jun 23, 2020 at 8:55 AM Thierry Reding <thierry.reding@gmail.com>=
 wrote:
> >
> > From: Thierry Reding <treding@nvidia.com>
> >
> > The Tegra PCI controller driver doesn't need to control the PLL power
> > supplies directly, but rather uses the pads provided by the XUSB pad
> > controller, which in turn is responsible for supplying power to the
> > PLLs.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/pci/controller/pci-tegra.c | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
>=20
> What's going to happen here with a new dtb and an old kernel? Is it
> going to error out due to missing supplies?

It's not going to error out but fallback to the "dummy" regulator, so
this should be fine from a forwards-compatibility point of view. Though
I didn't think we technically cared about that direction very much.

Thierry

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl8fDSgACgkQ3SOs138+
s6EHIQ//UL8Gqkmrx9PPmLdqE+raOpVdcOGUKg7dNSa1S/7o856UKMNFSJ9L+T2+
Wyziy5ouGiB162Z/EH6mCLkOmen9IZ58HDuTYu4jLH8MY3Pr4u8+zRpbri+c2AVc
joPgC+9jtfShilhBRy462g9LyDhKtW7PVuv1yjAcQEA2k6Xm9F8gt96m/UJBJltP
SdcHo9apg6ilNdZj8MqM93ZwYL2++a7d7PGvmwh+gZlCpO9IVKrNATilvSJHwBWy
0/RjxtZf7ZprY+izjvOarG8iQNU5Ag6bI2FrZ2k8N/zte696QcABU+5B78HTkLan
iJ/230/yHsbiFBTJAU3K09KUIEh4GzGLBnOk+/6OiJjTwXuDDkmIu4Ua0QSTYqwq
2NAUf3ivUwHMjmwfrhxM1RzLjBQ2dCCMVZuaRGFOyOMS8IkQsWv4ELQajETE0MCp
4dofQK+ilqLjn8nMgQIha0enV8O7MlvBK958IJQLffRLm2itj4pWGKDdEtE9XALq
oJrLfx6WL698hZj7VoeMz5c/QOaaw929kx9OL6q8bX9x2smLAIXLzxg3udn4t04V
ZZdGct5NLlSNOV4ycAF51754TGZt6n+jZDYIDHC7i882n83wRxrKpVvmZ0jqkNor
xAd+iGsSvDnJOaRq7ePZQU4CBK39293YuBU9vWEZXL1C+lGKa0c=
=Da08
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
