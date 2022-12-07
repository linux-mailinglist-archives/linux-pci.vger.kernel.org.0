Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F1B645777
	for <lists+linux-pci@lfdr.de>; Wed,  7 Dec 2022 11:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiLGKVS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Dec 2022 05:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLGKVR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 05:21:17 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320B92A418;
        Wed,  7 Dec 2022 02:21:16 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id fc4so12771553ejc.12;
        Wed, 07 Dec 2022 02:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p54kr6XUM0LRLqIjTVn0CPDFtPyqLbkkQUh9q3552DI=;
        b=S2BFtZ+3NPCaUBNKF22a46YMW7aMP5lZx8tZGvY6X+Rf+wD0HhOj+/9SzIsB7HcXbd
         5zBMR/Vxrj4613kVGfvS4KZj0JO2NVGHuJTiROPOkyFj2hwy/BSJ6/KW0oA4SgPmd7vN
         7jVckzQpzAlF7+tIRA2mbfW3F/U9VZIkgc18/34f6ZntTAMlXmONQ+dG3OUdBOVOZIDw
         2R3ftysSJ4WYcMBIptJn78ekaCFaCTHWWQMWYFTyaEjJ1LC9WU5in/M64/DUZ8VvSnvg
         oS2odjnPEY4Rts0LSK8c1wv0R1cbzIU381jsbvPqxI71UQCibDMiIguL120pfZmQnzSy
         JV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p54kr6XUM0LRLqIjTVn0CPDFtPyqLbkkQUh9q3552DI=;
        b=CwGjQk3yOWzuPqdVqw1L6rlevAAJqPdoZv2ErzdmmPA7Oc51Q1dNH4yu3/dg7MdK98
         bBNpG+Gx/KNChaWcYvljZr2k/J5WkmXPPVm+m0VmHYxooClx9bvmkyy9oW0pnCNd2QkL
         qnuGleYmXitRhvDi0mv1a6oGphmHsGwWUIDMMuFTfC5XWAtYzA4QV+r/gIYjvQFhB4DI
         KPbMs4Io9tQjuzHpcPIjM5d9O2To+m0pjZcuRuqW/KWyP6Wgk4qkXQTmE3HRlfpDvr7C
         oxX2q2jcSBehywTS4fr86qwUI4X05nMIi2AnZp5uprgmjBf+saAumhsGAfV3G0YQnl1D
         IfsQ==
X-Gm-Message-State: ANoB5pnkhoUtNoLoyoUgeKdKesNtrbe14zJ3UEN/jMNQXMvlyJjVjuMT
        hAkjvL3nWUfNU0++RV2gFVeNe3GMyt4=
X-Google-Smtp-Source: AA0mqf5+dEXoo7ludv6+++sopFs8nmWAS7QKTjnEBCH1nZTV99BqOy9xsK0DaWABnme2mn/v0DUXPg==
X-Received: by 2002:a17:906:3b11:b0:7c0:cb36:d6eb with SMTP id g17-20020a1709063b1100b007c0cb36d6ebmr17121707ejf.736.1670408474491;
        Wed, 07 Dec 2022 02:21:14 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id p10-20020a170906838a00b007c0dacbe00bsm4723394ejx.115.2022.12.07.02.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 02:21:13 -0800 (PST)
Date:   Wed, 7 Dec 2022 11:21:12 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
        Jon Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, vidyas@nvidia.com,
        mmaddireddy@nvidia.com
Subject: Re: [PATCH V3 1/2] dt-bindings: PCI: tegra234: Add ECAM support
Message-ID: <Y5BpGMS+D8T94Uha@orome>
References: <20221114155333.234496-1-jonathanh@nvidia.com>
 <20221114155333.234496-2-jonathanh@nvidia.com>
 <Y3ap1o2SbNvFw8Vd@orome>
 <CAL_JsqKpyn=mWXv4tuS4U8AahNPkL6hpNQCfyRdf9bDY1EqSJg@mail.gmail.com>
 <Y49xg7wptRweHd4I@orome>
 <CAL_JsqK+BxHB8__aN=84R4xpoJtf4_7xHeTkbgPakdNqzywJWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="23iUAqCOz/Oa7AeD"
Content-Disposition: inline
In-Reply-To: <CAL_JsqK+BxHB8__aN=84R4xpoJtf4_7xHeTkbgPakdNqzywJWw@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--23iUAqCOz/Oa7AeD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2022 at 03:14:58PM -0600, Rob Herring wrote:
> On Tue, Dec 6, 2022 at 10:44 AM Thierry Reding <thierry.reding@gmail.com>=
 wrote:
> >
> > On Mon, Dec 05, 2022 at 05:41:55PM -0600, Rob Herring wrote:
> > > On Thu, Nov 17, 2022 at 3:38 PM Thierry Reding <thierry.reding@gmail.=
com> wrote:
> > > >
> > > > On Mon, Nov 14, 2022 at 03:53:32PM +0000, Jon Hunter wrote:
> > > > > From: Vidya Sagar <vidyas@nvidia.com>
> > > > >
> > > > > Add support for ECAM aperture that is only supported for Tegra234
> > > > > devices.
> > > > >
> > > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > > Co-developed-by: Jon Hunter <jonathanh@nvidia.com>
> > > > > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> > > > > ---
> > > > > Changes since V2:
> > > > > - Avoid duplication of reg items and reg-names
> > > > > Changes since V1:
> > > > > - Restricted the ECAM aperture to only Tegra234 devices that supp=
ort it.
> > > > >
> > > > >  .../bindings/pci/nvidia,tegra194-pcie.yaml    | 34 +++++++++++++=
++++--
> > > > >  .../devicetree/bindings/pci/snps,dw-pcie.yaml |  2 +-
> > > > >  2 files changed, 33 insertions(+), 3 deletions(-)
> > > >
> > > > Both patches applied now.
> > >
> > > linux-next now fails with this. I suspect it is due to Sergey's
> > > changes to the DWC schema.
> > >
> > > /builds/robherring/linux-dt/Documentation/devicetree/bindings/pci/nvi=
dia,tegra194-pcie.example.dtb:
> > > pcie@14160000: reg-names:4: 'oneOf' conditional failed, one must be
> > > fixed:
> > >         'dbi' was expected
> > >         'dbi2' was expected
> > >         'ecam' is not one of ['elbi', 'app']
> > >         'atu' was expected
> > >         'dma' was expected
> > >         'phy' was expected
> > >         'config' was expected
> > >         /builds/robherring/linux-dt/Documentation/devicetree/bindings=
/pci/nvidia,tegra194-pcie.example.dtb:
> > > pcie@14160000: reg-names:4: 'oneOf' conditional failed, one must be
> > > fixed:
> > >                 'ecam' is not one of ['apb', 'mgmt', 'link', 'ulreg',=
 'appl']
> > >                 'ecam' is not one of ['atu_dma']
> > >                 'ecam' is not one of ['smu', 'mpu']
> > >         From schema:
> > > /builds/robherring/linux-dt/Documentation/devicetree/bindings/pci/nvi=
dia,tegra194-pcie.yaml
> >
> > Stephen reported the other day that he wasn't able to resolve this
> > conflict in linux-next, so he dropped the ECAM bits. The ECAM patch has
> > now propagated to ARM SoC so it can't be easily backed out, but I guess
> > we could revert on that tree and instead apply the patch to the DT tree
> > and resolve the conflict there.
> >
> > I guess the better alternative would be to try and resolve the merge
> > properly and let Stephen (and Linus) know.
>=20
> Instead, can you prepare a patch on top of Sergey's adding a 'oneOf'
> entry with 'ecam'. As this is a new thing, it should have its own
> entry. Then when merging, we just throw out the change from your side.
>=20
> I'd really prefer that bindings don't go thru the soc tree unless
> there's some strong reason. The default is to go via the subsystem
> trees. Beyond 'we are running the dtschema checks on all our dts files
> and can't have the warnings', I don't know what that would be. I wish
> everyone was doing that, but I'm pretty sure most are not.

That's actually the reason why I wanted this to go through ARM SoC, so
that the validation tools wouldn't accumulate even more errors. For some
time now I've been working on getting at least Tegra to validate
properly and on 64-bit ARM I have a local tree on top of linux-next that
has no warnings left, though I do need to flush out quite a few bindings
conversions.

Until those are all upstream, that argument is a little moot and don't
feel strongly about where the DT bindings ultimately end up.

Thierry

--23iUAqCOz/Oa7AeD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmOQaRUACgkQ3SOs138+
s6GGVw/9FLMaA71ADVuIEGZDxPrS0U2XPAreBd4q8Iqmh4NSo5OSqo845l8MExFt
76b7J5cSkyWagKiIZHTxHJ+NwG+q+viUNuhYwMDK9eR74r7EpT7tpBHCW1uU28rq
G+dHbM570lJxQZVjwcYiKfTglfwSFx/wYGPep5BdQcttKMeG/QeOAdCcqSEDmXGa
eKkCpUCnz45g2yvJ6T0iBlacuUA1xOAnZrwSnWvANGz8hc7u4d5flF9rcugw1i4V
IyIDU8w+J0A2I5SMto/lOoSAZ4S40FLQL1HVR1AhmziGqMZ7E4K6E3uwKr6JfGnI
FuES7aCmcjc7pwKbJbVUjfXNqg9YCDpiBaTTD20xwlJ5iSW1/LFGMt8q2L5mEI6L
KAJPSOh+VPkGpkpqXBenZnGMVJDhlW7oRkbtoGOsaOabTyhfJrIGBUN/9W/PxYoW
oDeqMu104qb2sBwaCs8Dd1YoHQVl8I5F2OUdskPdPhIMFWh7+9eYix1t/hVXAKP+
jxy5+/BMXXPfX1ctD1FhsHDKCtaGzjqYnOsocdhILCQBa857qEi2W85pfmNQHpzy
OChHGdLPZp56Ih5Gnrmk0ZRvEW1RqYdEr/17sUX/BuNtP+eJCtZcuIIErdh04mpR
c8ecjtvtIwuJAX9hHhW5mOac+9XF9xMW1dDvV3k5+aDmtWGpvOA=
=fiac
-----END PGP SIGNATURE-----

--23iUAqCOz/Oa7AeD--
