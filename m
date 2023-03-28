Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274AF6CBCB2
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 12:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjC1KmG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 06:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjC1KmF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 06:42:05 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B806184;
        Tue, 28 Mar 2023 03:42:04 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r11so47705973edd.5;
        Tue, 28 Mar 2023 03:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680000123;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ynr5Gc8TJTXozi1CcIVdlcGkAdeP7juyzEqKu/8mAM4=;
        b=Z/O97aA9J13eQcteDS6l+Zx+PUiE41PX+ochkiIVu0R137xgDh58BTExIGr1MKeiPz
         MQ1vDamf0bl1to0uFk0MzNXul/DJXgVqsZmHgHAesJfn9PxxpWr9yXs6m3g0mMFg1/z3
         +wfxx18AsJOP6d7D+MuVy5+zKMIK8kAyQqCVXDHrV0f8PlBtxUh2mF5fWnh5LgA66bSi
         dqR6DOzqtQDb8SvJ+BzW9VxzXLHdbpT3j9oe/VCTZqTPzXVAk3LaptM63lfdYDW48orj
         Mg0TLhE+f5td+DRKI3voT+c171kSNpG9/lHbchrZBoO/ikMD13XmBQwYVaDqH7eZhAFX
         1HcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680000123;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ynr5Gc8TJTXozi1CcIVdlcGkAdeP7juyzEqKu/8mAM4=;
        b=Km/fFSaHumjYzCMQWNHsfv3FMRMnz7zIfc1cL+TMa1sw0//tLHwXqaDDt5JOdDCCSg
         jtblpMLj83pYIqLxk5dKsTD+RMcYoQn9/Be2Z8omOlqCIOq1hVV42byndI8VlBaBhjSx
         cy80fB85Tkf1WqUtWMbgCoEodadrLO/uteHrhAcREnjBNFRkuZvZpJS7essZKegxppaP
         6rqtHIjcmcLn33AyAJ7Wk9/74xMUdJ4fBSzlOnh9RZC2D1zX2Ferl646a2+powN+KVT4
         PoaCQpoUmxISl1/jSAv3pKOEMHHVSGBDt5Hjrd0TiuFaZSbJp7teYIMNHNMF6ro3MnEj
         ddkA==
X-Gm-Message-State: AAQBX9dQvlzEVohzfGaP9BQq0oceMFXivXZ2P6PpwY8uymVxPnqvkzvu
        F+owb5qvlqWZoHInEqkvBa5ThBZTlsc=
X-Google-Smtp-Source: AKy350bruWB9oU9V6zbqhojVKn2vtnkt+mYjtaIieKDNScKJHUzl51pxAzvw9zKCyDZRsjY0KzCEcw==
X-Received: by 2002:a17:906:3a45:b0:932:8dc:5bf4 with SMTP id a5-20020a1709063a4500b0093208dc5bf4mr15898961ejf.61.1680000122687;
        Tue, 28 Mar 2023 03:42:02 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id sd24-20020a170906ce3800b00931024e96c5sm15350868ejb.99.2023.03.28.03.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 03:42:02 -0700 (PDT)
Date:   Tue, 28 Mar 2023 12:42:00 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     treding@nvidia.com, krzysztof.kozlowski@linaro.org,
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
Message-ID: <ZCLEeABPtzXqpZdY@orome>
References: <20230327161426.32639-1-sumitg@nvidia.com>
 <20230327161426.32639-2-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wf4WgXMFCZE62Nbf"
Content-Disposition: inline
In-Reply-To: <20230327161426.32639-2-sumitg@nvidia.com>
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


--wf4WgXMFCZE62Nbf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2023 at 09:44:17PM +0530, Sumit Gupta wrote:
> For Tegra234, add the "nvidia,bpmp" property within the Memory
> Controller (MC) node to reference BPMP node. This is needed in
> the MC driver to pass the client info to the BPMP-FW when memory
> interconnect support is available.
>=20
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra186-mc.yaml    | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,=
tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvi=
dia,tegra186-mc.yaml
> index 935d63d181d9..398d27bb2373 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra18=
6-mc.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra18=
6-mc.yaml
> @@ -58,6 +58,10 @@ properties:
>    "#interconnect-cells":
>      const: 1
> =20
> +  nvidia,bpmp:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle of the node representing the BPMP
> +
>  patternProperties:
>    "^external-memory-controller@[0-9a-f]+$":
>      description:
> @@ -220,6 +224,9 @@ allOf:
>              - const: ch14
>              - const: ch15
> =20
> +        nvidia,bpmp:
> +          description: phandle of the node representing the BPMP
> +

Why do we need this one? There's already an nvidia,bpmp phandle defined
in the patternProperties section for external memory controllers.

Thierry

--wf4WgXMFCZE62Nbf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQixHgACgkQ3SOs138+
s6FPyhAAnZhwTSvoZp45DLHq9a51QzbNzm2ftllz08w6ApGhG4loPBoceTxA5SN/
02806+yYIHfJNlu5G0x8x6U6W9rXg0/QLeTITWx0XbpU6FuiEashzDJD+Kg7eSpe
4+yJSRjSYilYNatKfPiXpil1pvLXtmQ2YAPJ2SFFRiVYBcqvBUS6xXyOpXa6eJCr
1hh9QqMTsnxTxx1D+FGKAZYT8M+E2kBowkQ/vIpAg1UMlXD3lWa2crfEJQq744R+
K3rDfOkLaeVzFrN8XMUCTX5ZcTR1FHwqCpLFjaSY9qytJYyimEhyARb0jr43iVKF
yRuNqLfDEUDyYvCxDjFCGYgQca1jRhGyzrWAXF9yfz5EuEBWoIIRooeru5VRscsB
OD3I+iD5V8DNGwDnD94WQXgcTBSD8aGCPrCzIxGCAyOqBO1pSfGsu1LiMElBQ+aF
2gs4gVUMvAOytfVpNZpJ4PpikMSsxLSu27XDJM+GCEL7pQwiW5oUHs1nSoIDUGt2
K9CoJeVKKsikMz1LzzrAsL53rH8/blh7ozoHDXTUKH7xAZVtQzHd9yIRF5RINyOY
8neVsEo7nTSn1naWJt5pHnWKgmcKkZI0CZnxLPII/x3v6LySyOHtF+oY0J0TqFdz
LqZCsEaDfElewKibVzJM2jxrd5A2Rh3ybti7Me5xj5m13n8WzKI=
=xsrS
-----END PGP SIGNATURE-----

--wf4WgXMFCZE62Nbf--
