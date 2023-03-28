Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E496CBCCF
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 12:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjC1KsP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 06:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjC1KsO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 06:48:14 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8151BC0;
        Tue, 28 Mar 2023 03:48:12 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b20so47831354edd.1;
        Tue, 28 Mar 2023 03:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680000491;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uz8Pl8WK2K/AxyiPlw/QBeRKltTTW7plDyOjg6UNN7A=;
        b=hTKG3N9oSG9lNz3XYhJXArrzvHRZBPVgp7kMJNOkepNhqNThr9px8JDpLjTuAfhjhi
         UeCeFrVwrQTDtbnLQ9bDb9my4m9JQQnvWnZ7KucFQs9WL3H5pVo+Tgwek+SoTqhXtEaH
         sfFvEMQg9KUu4rMx7qiLXmeotkx4rSHkt7Glvm2jANNh1J85/fKnUqFwtWb9LESAk9Fm
         JS2xnINRueIV9+gvtkSSr2T1HHYKHBnGHhTVaXmcC204ZnTNAsslX5owg8aHLCM9/Nlh
         GPeraieZSv4qiqto1peGe9ufZp1DKVOuG1NdOt4NAq/HLOTLrDk/eSHLqcEjBC9Ct4Iv
         gO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680000491;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uz8Pl8WK2K/AxyiPlw/QBeRKltTTW7plDyOjg6UNN7A=;
        b=xM/vHx2dFxnyG5m26so2O0rL37oLXF2lS6Jj8Inqjk94mG62C5MJlxetwLTiOMnYGs
         5sqjBUwhe4vTqKr85/Sigb4bvl7mvKKdSpZGGsDaXND6BCTb21pm1bQqnDL8Jejt1lgR
         Wx0NvIaitYh9gl05+V/1nEPUB0V/KY683jt8jRdmeRvK0+xt/6dv7+ZZ4u8LrFBve07a
         Qmzy87Py+81vvPpi/l87BdKzYsjPi6k448ujMCHKTyBapM14+eWWqxpLImSie2JLIi7m
         sNJhW78skgXWhMuEC5sS2hhdX24f0NcrfIXwhxuJyfX+Q2uYVk2DV7jXvv/BS/3COtuv
         jlTg==
X-Gm-Message-State: AAQBX9cJL5AM179uk8HRRJgJn4uhl/bimNbq6dtYQjt65m7z78QyiUS7
        Cqg7LwuQmry7phCGefhkQcw=
X-Google-Smtp-Source: AKy350ajJ+7AtREN27j25f/lTyWUssyru0oV3QPRLPWfSQHRbol/vW3kiuHHbkdP/nuHcbn3YuSXyA==
X-Received: by 2002:a17:906:5850:b0:935:3028:ff58 with SMTP id h16-20020a170906585000b009353028ff58mr15239656ejs.55.1680000491234;
        Tue, 28 Mar 2023 03:48:11 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ce20-20020a170906b25400b00929fc8d264dsm15297997ejb.17.2023.03.28.03.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 03:48:10 -0700 (PDT)
Date:   Tue, 28 Mar 2023 12:48:09 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        lpieralisi@kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        mmaddireddy@nvidia.com, kw@linux.com, bhelgaas@google.com,
        vidyas@nvidia.com, sanjayc@nvidia.com, ksitaraman@nvidia.com,
        ishah@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch v4 01/10] dt-bindings: memory: tegra: add bpmp ref in
 tegra234-mc node
Message-ID: <ZCLF6ZRH528pu/r3@orome>
References: <20230327161426.32639-1-sumitg@nvidia.com>
 <20230327161426.32639-2-sumitg@nvidia.com>
 <787f656a-223d-5eed-e311-9cc7a6c46452@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="unaT5uGr1XXNjnaA"
Content-Disposition: inline
In-Reply-To: <787f656a-223d-5eed-e311-9cc7a6c46452@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--unaT5uGr1XXNjnaA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2023 at 09:23:04AM +0200, Krzysztof Kozlowski wrote:
> On 27/03/2023 18:14, Sumit Gupta wrote:
> > For Tegra234, add the "nvidia,bpmp" property within the Memory
> > Controller (MC) node to reference BPMP node. This is needed in
> > the MC driver to pass the client info to the BPMP-FW when memory
> > interconnect support is available.
> >=20
> > Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> > ---
> >  .../bindings/memory-controllers/nvidia,tegra186-mc.yaml    | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidi=
a,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/n=
vidia,tegra186-mc.yaml
> > index 935d63d181d9..398d27bb2373 100644
> > --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra=
186-mc.yaml
> > +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra=
186-mc.yaml
> > @@ -58,6 +58,10 @@ properties:
> >    "#interconnect-cells":
> >      const: 1
> > =20
> > +  nvidia,bpmp:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: phandle of the node representing the BPMP
>=20
> Why do you need this multiple times? Both in parent and all external-mc
> children?

We've had nvidia,bpmp in the external memory controller node since
basically the beginning because we've always needed it there. For newer
chips we now also need it for the memory controller.

Ideally I think we would only have this in the MC and have the EMC
driver reference it via the EMC's parent (i.e. MC), but that would break
backwards-compatibility. Reaching into the EMC's DT node from the MC was
another option that we discussed internally, but it didn't look right
given how this is also needed by the MC.

One thing we could potentially do is deprecate the nvidia,bpmp phandle
in the EMC and only keep it as a fallback in the drivers in case the
parent MC doesn't find it's own in the DT.

Thierry

--unaT5uGr1XXNjnaA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQixegACgkQ3SOs138+
s6E+6A/+LQ807xpRoYSk/O3Els2KulVl39Ed9W6futtmBD/gwAEfsEH6/uoHriVq
rlliNDA64PntpqyTfhMdwMt6WeT/XZkrbp6Gbl5ichCVeSu0V7MsMTedkQqKdhfM
qnruufTe5Vg9pNi7mfp9520gq0Bj6kLPQlBMPiIh3VuzjC0xczw/MREQs1hHfop8
K6U/agFxZ6Od+9u/gxs5PsfncHQ5pBDdBSe+QbfK95VOpWVOG3kRdGO0WwhPo3cx
X9DKKm9YXh/JGzc460OHbnv1a9cRCYFUdAvE/pfheO9uhSEelRR6Me6R2YcnVlRP
SOV6/B0b6i0ax0fijJgsCF96MucF284Dtj9DUD7SLrxTH7Oon4T941eEOx63bz4h
whmS9ayKDJ7ykfuQfzLp0/0fhP4M4R7xXyryKFqFuBO5jnz+96T9QDVhGj2YzYgU
7eI/buACia3BN5BIy/hJQaJxU7aFjrgwAkR/XNvtc2Ub8RUJnbWl3IamrQ4A5Uiw
38lW1xG0MvrhXHdR/kWcmi9fNIos2k9HCPgsItRXHj2qZX0DXLjRcLqhWl0rxCq9
FuvXEc60jca7OeFXt8p3HBzwZIXNRzAXfWD4q9eUCygEiPJbP/hKuW00FSSicIFC
q79aM7CBVjgkazCsNVbJ/hMg3DobMTJ73w4tFYPD6f1sDsEr8s4=
=fGu3
-----END PGP SIGNATURE-----

--unaT5uGr1XXNjnaA--
