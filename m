Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8DB4C354F
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 20:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiBXTFb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 14:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiBXTFa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 14:05:30 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF351E5201;
        Thu, 24 Feb 2022 11:05:00 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p4so417445wmg.1;
        Thu, 24 Feb 2022 11:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aFSvFpoW7B9DJRHLFArsN58BcbVn7XQ4fEO+dHkCaWo=;
        b=fZ0v/Uavza86hMkYeQ88kaG9Ke4iew/K3geHYwkYFX7iQ72z9S+duCZ3M/Cy9OY26T
         7Av4baaaBUWDkQcmej4uRef68cv3FW2nsYO5pDhptA0ymBuT8T81RicWVuqcyYC4jSHX
         JNFHGF5FLz7P7gf4JsZJ7hhvXN1PNVJ4xQ0xQe918/tUKLbYTQSVit/8z5x4st22nrVu
         gEDrBHsIoiIGMEqLFF4sElodexG4L6MPWiMMOwHQgKb03IP3XQw/PyNVbY0sY+4JTbZv
         Iy6vyw/YaPv5SlIXTKd5B9QYz1t+JzRyIcr42NPPPXLzOiuU5hzkVtXQTn8YKoX1NuVw
         vPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aFSvFpoW7B9DJRHLFArsN58BcbVn7XQ4fEO+dHkCaWo=;
        b=fHQMIZxOApzMrXmQAWglj/gND7k4mCJlqyE+wAPLZ4YWApxnMBCguTep++yxp5e1qn
         268wBRDJrz0h+Je94SlXjbQQgjYUKzQR4vq6k/mXc+IBRWjgssPDgb/IQ2X6Vjjr6AO9
         vBwNTT0mTltCwfgBW63S+znRdqaWxDuuRJ8qGj6+uV42O8u1gblLrckPNn2QSixUgGZp
         VKn6iZXwsM03C+XVvj2UgxcCGOW8Iq2+c2RgbopKGpww22cHUmKLYy3lcExjI2LtgWuW
         Mm2Kw6H29b98v0nuI+lUC4PO1EeqFL9kfHWawkPiNj2BMAEumFS6DidanWzoOxbqs8iI
         8jcA==
X-Gm-Message-State: AOAM530joq5jTgauagOFjRnauiOMrmAbQovjmbugCiM0M1lWaOAaqwVN
        GdbqTaZ6wjzvKyuxRIFhwAuCzmvF+aA=
X-Google-Smtp-Source: ABdhPJxEBiw9aeUuGCsx8c5UEPVIxpUCdiZ7rWpSlDfBThBzsm2aLMCXfyQ/P8GC3tsejywBnxc64w==
X-Received: by 2002:a05:600c:500c:b0:37b:b8a5:856c with SMTP id n12-20020a05600c500c00b0037bb8a5856cmr13093838wmr.65.1645729498536;
        Thu, 24 Feb 2022 11:04:58 -0800 (PST)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id f9-20020adffcc9000000b001e9e8163a46sm245157wrs.54.2022.02.24.11.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 11:04:57 -0800 (PST)
Date:   Thu, 24 Feb 2022 20:04:54 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        jonathanh@nvidia.com, kishon@ti.com, vkoul@kernel.org,
        kw@linux.com, p.zabel@pengutronix.de, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1 03/10] dt-bindings: memory: Add Tegra234 PCIe memory
Message-ID: <YhfW1rXr+5/o7E5N@orome>
References: <20220205162144.30240-1-vidyas@nvidia.com>
 <20220205162144.30240-4-vidyas@nvidia.com>
 <4e2bec9b-4759-b699-fa7b-974f5f43da9d@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="P1IEsKe5Ui8//ysj"
Content-Disposition: inline
In-Reply-To: <4e2bec9b-4759-b699-fa7b-974f5f43da9d@canonical.com>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--P1IEsKe5Ui8//ysj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 06, 2022 at 12:33:27PM +0100, Krzysztof Kozlowski wrote:
> On 05/02/2022 17:21, Vidya Sagar wrote:
> > Add the memory client and stream ID definitions for the PCIe hardware
> > found on Tegra234 SoCs.
>=20
> I could not find dependencies or merging strategy in cover letter.
> Please always describe it, so I don't have to go through all the patches
> to figure this out.
>=20
> >=20
> > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > ---
> >  include/dt-bindings/memory/tegra234-mc.h | 64 ++++++++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >=20
> > diff --git a/include/dt-bindings/memory/tegra234-mc.h b/include/dt-bind=
ings/memory/tegra234-mc.h
> > index 2662f70c15c6..60017684858a 100644
> > --- a/include/dt-bindings/memory/tegra234-mc.h
> > +++ b/include/dt-bindings/memory/tegra234-mc.h
> > @@ -7,15 +7,53 @@
> >  #define TEGRA234_SID_INVALID		0x00
> >  #define TEGRA234_SID_PASSTHROUGH	0x7f
> > =20
> > +/* NISO0 stream IDs */
> > +#define TEGRA234_SID_PCIE0	0x12U
> > +#define TEGRA234_SID_PCIE4	0x13U
> > +#define TEGRA234_SID_PCIE5	0x14U
> > +#define TEGRA234_SID_PCIE6	0x15U
> > +#define TEGRA234_SID_PCIE9	0x1FU
> > =20
> >  /* NISO1 stream IDs */
> >  #define TEGRA234_SID_SDMMC4	0x02
> > +#define TEGRA234_SID_PCIE1	0x5U
> > +#define TEGRA234_SID_PCIE2	0x6U
> > +#define TEGRA234_SID_PCIE3	0x7U
> > +#define TEGRA234_SID_PCIE7	0x8U
> > +#define TEGRA234_SID_PCIE8	0x9U
> > +#define TEGRA234_SID_PCIE10	0xBU
>=20
> I don't see usage of these...
>=20
> >  #define TEGRA234_SID_BPMP	0x10
> > =20
> >  /*
> >   * memory client IDs
> >   */
> > =20
> > +/* PCIE6 read clients */
> > +#define TEGRA234_MEMORY_CLIENT_PCIE6AR 0x28
>=20
> I see you use them in DTS but not in mc driver. Don't you miss anything
> here?

This is along the same lines as the APE and HDA patches earlier, so I
would expect Vidya to add a memory controller patch that makes use of
these once the initial Tegra234 memory controller patch was merged.

Meanwhile, I've applied this to the Tegra tree, on top of the other
patches that add memory client definitions and resolved the conflicts
that ensued.

That way, by the time we get around to the next cycle all of these
dependencies will exist and applying the memory controller patches
should become easier.

Thierry

--P1IEsKe5Ui8//ysj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIX1tQACgkQ3SOs138+
s6FaSxAAqaAzeWrUt+ekUE4mYyQm5IsTvaxzM49tL5qE1eNmGPw0X17Th4N5CWV3
2JlZfn6hU7DOFnnsF7geN39pLOgbzhN5HQ/NKCxTeujNG7/yvwk875MYj5o2AmQJ
9EpbM2xiCmzbo0D0hkOds3Dj9WePSeXHm2w7kUUfr9PoA+pVyCfifnkY0edD63Yy
YhzPsJA95elzU1ysJ0o8mk205CKZelQrPDCtxAmlJczjBQBJfUP4t2/oXxRSlVur
IRPs/WSItsh3EL4fvQcaIs24Tac2omhPNtH+qp0cF+YdHiB9pJ6s7DaQ1zRDvvTT
Do5H3/Px+v9Oh6WKAZaJDljinfWB8kUAsQQCTBP9nCYCyP43lfwEJW+4x5L4lC2t
sAW4lGM/Jk2psaIVOpR1i07aw8QlGr3S2PUQwYr/3xTC7LSlDG14u8ss4+oFRZsT
Z3w5J/7de0jirRMlV7MJunUNA9L51VTW9F/k09+yKlfuBNlm3etc0LQGw6W+ntwg
DJTn0vdhIiugRV95QF+BrDUYaFhu6Rmla2+1Rq79+lMWLnIpGNDVV1vfd7wSK4LU
Zz89jqQoBaH47WAxgNkTWMNmZ7KannprydkrX9TEE+u1P0RCpnDsT3iknLylP/R5
fCxa8AkIJZhDsoL9fRD2qpF+qzQELgJyW4yqSEUqPOFnh80bQDA=
=WK2m
-----END PGP SIGNATURE-----

--P1IEsKe5Ui8//ysj--
