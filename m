Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FDD6D5F60
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 13:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbjDDLoj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Apr 2023 07:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbjDDLog (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2023 07:44:36 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433E02D43;
        Tue,  4 Apr 2023 04:44:35 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l37so18816694wms.2;
        Tue, 04 Apr 2023 04:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680608674;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7kQfcXnw7GUCoA+1zbPCx2uufroYTZoUTjGf+7ErLE=;
        b=HkVY4bLRuFSwCgIeePRqemIzJl2fv2XsOFJVuUxKVcCIn4cW+wmERO+aeSlHRbqJsn
         slEH+6RJgAAyTVkFLE4SwNRq4anVXk+GPK7+4KzPZvKSJZDMY3UEhmT5MHm5OUd1sFod
         4Au0rOhIrsU6Ex5xzk0XyqOprqUtz5UxsGAoKYGaQ2qF33XVGzXhGIkP/bmcaJR4yY/F
         w1fa5UKHDHvK3eTHxskYF2lljEuGpn7F1bPYpioJU3DKZ/vh771ttNLFBufiVXcRrScG
         E/+dE5m7xA6RUSoJs02maSqAY3I4+OYORGZjNU4wFu4zrInG0biCyXW9ALJ8bN237cR0
         vYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680608674;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7kQfcXnw7GUCoA+1zbPCx2uufroYTZoUTjGf+7ErLE=;
        b=b8s7N50DNQz03kJEWY7WuZtn7KOwb/VKLz7w+zZCtgZJFlKDXSARYKyoduM9QyKKE8
         JEJhrxRbXdypDY0MT9R16Q3sCYTqWbIBkxyGCYVqQoSx4NSqPJzlz9h08TwtqTYxFD8/
         /ER7Prx66rEGJDo9BNp/lRAdDN2bd4rhQffwXjFS4LMCyPlF+cHCJGgPB72sXOdhCLhK
         Vt8/s8MZDC9ZEBwokPwLyBzi183qkhhA+eBziZtPV1hFgYK5Yld7KX0F864ziqeF5hH3
         5crQCuSkovjGyRVPNEiFsr8AhSK311YI4WAsTA/xRj3O/TIiYDDXIdVSe8v/pol4ypt7
         Mq2Q==
X-Gm-Message-State: AAQBX9ceATfBB54BHsZz6et3ymUrhRDKzf2R7Yqhjiv1ekKXzz5jjhA2
        4ysSYiKKolKNcLFte0DFXP4=
X-Google-Smtp-Source: AKy350YSeFBa7rZpqJbanvqLzzoSMljyJ7LfWiAre2vC7CCl5pSZrTKnAjVLZnX9m0nAscV8KKphbA==
X-Received: by 2002:a05:600c:2247:b0:3f0:3ce2:1e3d with SMTP id a7-20020a05600c224700b003f03ce21e3dmr1939124wmm.12.1680608673499;
        Tue, 04 Apr 2023 04:44:33 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600c46cf00b003ede2c59a54sm22466552wmo.37.2023.04.04.04.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 04:44:33 -0700 (PDT)
Date:   Tue, 4 Apr 2023 13:44:31 +0200
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
Message-ID: <ZCwNn0xaBTKfZJmV@orome>
References: <20230327161426.32639-1-sumitg@nvidia.com>
 <20230327161426.32639-2-sumitg@nvidia.com>
 <787f656a-223d-5eed-e311-9cc7a6c46452@linaro.org>
 <ZCLF6ZRH528pu/r3@orome>
 <79d8044f-ce68-463e-66f7-8755e253bc99@linaro.org>
 <ZCLiCWRYbO98qwCn@orome>
 <0b393600-3f08-c2e8-9b02-664c6a984de1@nvidia.com>
 <8a22aea9-5027-e8a4-db80-ce79f3830e10@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="csCqp3FIJlXiL6kB"
Content-Disposition: inline
In-Reply-To: <8a22aea9-5027-e8a4-db80-ce79f3830e10@linaro.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--csCqp3FIJlXiL6kB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 02, 2023 at 12:47:01PM +0200, Krzysztof Kozlowski wrote:
> On 29/03/2023 19:12, Sumit Gupta wrote:
> >=20
> >=20
> > On 28/03/23 18:18, Thierry Reding wrote:
> >> On Tue, Mar 28, 2023 at 01:22:26PM +0200, Krzysztof Kozlowski wrote:
> >>> On 28/03/2023 12:48, Thierry Reding wrote:
> >>>> On Tue, Mar 28, 2023 at 09:23:04AM +0200, Krzysztof Kozlowski wrote:
> >>>>> On 27/03/2023 18:14, Sumit Gupta wrote:
> >>>>>> For Tegra234, add the "nvidia,bpmp" property within the Memory
> >>>>>> Controller (MC) node to reference BPMP node. This is needed in
> >>>>>> the MC driver to pass the client info to the BPMP-FW when memory
> >>>>>> interconnect support is available.
> >>>>>>
> >>>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> >>>>>> ---
> >>>>>>   .../bindings/memory-controllers/nvidia,tegra186-mc.yaml    | 7 +=
++++++
> >>>>>>   1 file changed, 7 insertions(+)
> >>>>>>
> >>>>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/=
nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controll=
ers/nvidia,tegra186-mc.yaml
> >>>>>> index 935d63d181d9..398d27bb2373 100644
> >>>>>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,=
tegra186-mc.yaml
> >>>>>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,=
tegra186-mc.yaml
> >>>>>> @@ -58,6 +58,10 @@ properties:
> >>>>>>     "#interconnect-cells":
> >>>>>>       const: 1
> >>>>>>  =20
> >>>>>> +  nvidia,bpmp:
> >>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
> >>>>>> +    description: phandle of the node representing the BPMP
> >>>>>
> >>>>> Why do you need this multiple times? Both in parent and all externa=
l-mc
> >>>>> children?
> >>>>
> >>>> We've had nvidia,bpmp in the external memory controller node since
> >>>> basically the beginning because we've always needed it there. For ne=
wer
> >>>> chips we now also need it for the memory controller.
> >>>>
> >>>> Ideally I think we would only have this in the MC and have the EMC
> >>>> driver reference it via the EMC's parent (i.e. MC), but that would b=
reak
> >>>> backwards-compatibility. Reaching into the EMC's DT node from the MC=
 was
> >>>> another option that we discussed internally, but it didn't look right
> >>>> given how this is also needed by the MC.
> >>>>
> >>>> One thing we could potentially do is deprecate the nvidia,bpmp phand=
le
> >>>> in the EMC and only keep it as a fallback in the drivers in case the
> >>>> parent MC doesn't find it's own in the DT.
> >>>
> >>> Yes, deprecation would answer to my question.
> >>
> >> Okay, great. Sumit, you can resolve this by adding a "deprecated: true"
> >> to the EMC's nvidia,bpmp property schema. In the driver we can then try
> >> to look at the MC's ->bpmp and if it exists reuse that. If it doesn't
> >> exist, we can keep the existing lookup as a fallback for device trees
> >> that haven't been updated yet.
> >=20
> > We can't use MC's->bpmp in the EMC driver's probe as it will be NULL.=
=20
> > This is because MC driver uses "arch_initcall" and gets probed earlier=
=20
> > than BPMP. We can do this in another way as below change. This way we=
=20
> > can use the existing "nvidia,bpmp" property from EMC node and don't nee=
d=20
> > to move it to the MC node. Please share if this change sounds OK.
>=20
> Then rather it sounds like time to fix these
> orderings/arch_initcall/missing defer.

We can't fix this because there's a circular dependency between MC and
BPMP. Essentially BPMP requires the IOMMU for mappings and the IOMMU
needs the MC to do some register programming in order for the mappings
to take effect.

The MC programming isn't required for BPMP, but it is required for other
devices that are hooked up to an IOMMU. The dependency from MC on BPMP
is also a different area of functionality, so we know that there's no
actual problem.

If there was something like a "transitive" dependency we might be able
to resolve this (i.e. if creating the IOMMU mapping itself would trigger
the probe deferral chain, rather than the driver binding). However, all
dependencies are modelled between devices, so not much we can do in this
case other than try to work around it.

Thierry

--csCqp3FIJlXiL6kB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQsDZ0ACgkQ3SOs138+
s6EGFA//TqfQs2jpFYVw+fgLrm1D2nktfHkrjQqbwtjRla2jw7rOifjpq/ved0Dh
dcaGyN1P0mi0dfZ8iMR51P8APYHIxY7MRNuk+C/zTm9vZ8cfE3sEVQ3PW7WZnWRY
e6uZ19sRVK7bG9V7NOtBOAVRJB3pMvbw7vjL9n2fpnK3Y+p46pxz5fiHKSzU0m0M
JD94leqOK/yAkfjvzbpaAiPL1qrZbyGA6sUPnCEBtBUOCEzwnCDgh3hG5KPhQlWJ
5cFke/g/DCXLp0E5BPCJCldmuH37EOGq6xdAgijQlqmv6AkwQy9IEUDmE0IMw9yS
L2a1pqhnBVGKBacPnmDyZBSEanTRrlk3NDXaM0OrMyboczBbgWMJoELnRgHMaodC
U94vRO0OuyPHRNBbb9mgSQ0RGjUNSpdOiIm0Orgd0MXWj0khNU5/d8ohu0AelHO0
CWwaoppXdQXIMQkh/OyZ7lPnO7vndS+2X4BYLNepM6WzBQvhA5wyvgdncU27l1ul
U+EJUs8qqxaZEIVleblykZppvKd7MJujoxS0Hrfx5ScjRnsG+SHo+Z14xB2lnkcz
yC1gNZLNAYTEyyo0MI+Luat9AGjilV3KBdHN8deRtTQzCoCH4RZNHaku9nQhL+4O
rjqdMconJuojbISPr0oqodggbHHiQ0/fQFA0BMeofc7j9puw5Cs=
=K80k
-----END PGP SIGNATURE-----

--csCqp3FIJlXiL6kB--
