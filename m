Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3684F6CBFAD
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 14:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjC1MtU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 08:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjC1MtE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 08:49:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92FAAD23;
        Tue, 28 Mar 2023 05:48:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id eh3so49146122edb.11;
        Tue, 28 Mar 2023 05:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680007692;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+j/KJFIrlst+m4MnKU1YhwoFJufXJ+qFFR8aaFj9yI=;
        b=qDF0RIo7qEWFpLp1V7zg1nyS0Cz1f0niR5wf1JYgREvT++u/jTQXlrbrR3tekciQNy
         J594QKzqJnW0RS4GCeEsrUgLCtE53jWSGrRuZOfoZUID0U/AyqIqhgRR2Dp6MMIyU2y+
         u4peTJZIEOFU+iPGZXXljyqnwb/gIcehiAxSMTyenCmcivMGAlVGzH8hOqulA9TQ/Nho
         0WUTcOReF5uOPFiB0Zl4HaBHwPn/DWfwn0dj1Wy4kx2nErInpbAEo947n8N7Sl9rKwb0
         zONtFEQeZ6L8GfyOiSRJAVufq1WiZ1mpaGSeVBPSscMia53xEo4GP86qEzeoQShq+4SP
         pSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680007692;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+j/KJFIrlst+m4MnKU1YhwoFJufXJ+qFFR8aaFj9yI=;
        b=7m/GtTyOIEysY//Bylj4uAcmgOWbBquURaRYAakP332ZoCnJuuIwBnFiRDWa3H4mVw
         H7IZurUScTdAkPXkXg6ESixin6sa+FWKZ5iI926wBATBYD7dJBtGD03TFcXsf3ELrNT6
         GBeF1Qh1ZEzudC4fUrcRnAyaYdP72Uz4VjqSHb6Zom13Tl9feo/neaC5DDtNVSOTVrCd
         WhADPBXWLS+Yczc7s+36yOVgq7Uvfw8Pczgh/KW6OUEj4dvOMEzJuyKQWzLSkS10lLwG
         n6B/HhntL6O1w8wNyWru7OWwGCoLVsGPRu6vc/kMA26dUZfu5by0RLCnh5A70oDFbRik
         MVyA==
X-Gm-Message-State: AAQBX9dTevcxVVCdQ6OOwbv9JiSJK0rj++NGb2E0ZTE3YbTgHvDEajSV
        Q2xiJjbpyC0eMgrEGvue38Q=
X-Google-Smtp-Source: AKy350bsYP6Fqx2BMM9UnoL40J+1Zzy9EBO2zL7Vus0MWU2zi2OsOdKythsze4lbrbREF6yEcAMN9g==
X-Received: by 2002:a17:906:3da:b0:933:2f77:ca78 with SMTP id c26-20020a17090603da00b009332f77ca78mr15915436eja.28.1680007691989;
        Tue, 28 Mar 2023 05:48:11 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id l11-20020a1709066b8b00b00939faf4be97sm10258789ejr.215.2023.03.28.05.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 05:48:11 -0700 (PDT)
Date:   Tue, 28 Mar 2023 14:48:09 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sumit Gupta <sumitg@nvidia.com>
Cc:     treding@nvidia.com, dmitry.osipenko@collabora.com,
        viresh.kumar@linaro.org, rafael@kernel.org, jonathanh@nvidia.com,
        robh+dt@kernel.org, lpieralisi@kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, mmaddireddy@nvidia.com, kw@linux.com,
        bhelgaas@google.com, vidyas@nvidia.com, sanjayc@nvidia.com,
        ksitaraman@nvidia.com, ishah@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch v4 01/10] dt-bindings: memory: tegra: add bpmp ref in
 tegra234-mc node
Message-ID: <ZCLiCWRYbO98qwCn@orome>
References: <20230327161426.32639-1-sumitg@nvidia.com>
 <20230327161426.32639-2-sumitg@nvidia.com>
 <787f656a-223d-5eed-e311-9cc7a6c46452@linaro.org>
 <ZCLF6ZRH528pu/r3@orome>
 <79d8044f-ce68-463e-66f7-8755e253bc99@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SOqUr+gSHmGMXo04"
Content-Disposition: inline
In-Reply-To: <79d8044f-ce68-463e-66f7-8755e253bc99@linaro.org>
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


--SOqUr+gSHmGMXo04
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2023 at 01:22:26PM +0200, Krzysztof Kozlowski wrote:
> On 28/03/2023 12:48, Thierry Reding wrote:
> > On Tue, Mar 28, 2023 at 09:23:04AM +0200, Krzysztof Kozlowski wrote:
> >> On 27/03/2023 18:14, Sumit Gupta wrote:
> >>> For Tegra234, add the "nvidia,bpmp" property within the Memory
> >>> Controller (MC) node to reference BPMP node. This is needed in
> >>> the MC driver to pass the client info to the BPMP-FW when memory
> >>> interconnect support is available.
> >>>
> >>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> >>> ---
> >>>  .../bindings/memory-controllers/nvidia,tegra186-mc.yaml    | 7 +++++=
++
> >>>  1 file changed, 7 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvi=
dia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers=
/nvidia,tegra186-mc.yaml
> >>> index 935d63d181d9..398d27bb2373 100644
> >>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,teg=
ra186-mc.yaml
> >>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,teg=
ra186-mc.yaml
> >>> @@ -58,6 +58,10 @@ properties:
> >>>    "#interconnect-cells":
> >>>      const: 1
> >>> =20
> >>> +  nvidia,bpmp:
> >>> +    $ref: /schemas/types.yaml#/definitions/phandle
> >>> +    description: phandle of the node representing the BPMP
> >>
> >> Why do you need this multiple times? Both in parent and all external-mc
> >> children?
> >=20
> > We've had nvidia,bpmp in the external memory controller node since
> > basically the beginning because we've always needed it there. For newer
> > chips we now also need it for the memory controller.
> >=20
> > Ideally I think we would only have this in the MC and have the EMC
> > driver reference it via the EMC's parent (i.e. MC), but that would break
> > backwards-compatibility. Reaching into the EMC's DT node from the MC was
> > another option that we discussed internally, but it didn't look right
> > given how this is also needed by the MC.
> >=20
> > One thing we could potentially do is deprecate the nvidia,bpmp phandle
> > in the EMC and only keep it as a fallback in the drivers in case the
> > parent MC doesn't find it's own in the DT.
>=20
> Yes, deprecation would answer to my question.

Okay, great. Sumit, you can resolve this by adding a "deprecated: true"
to the EMC's nvidia,bpmp property schema. In the driver we can then try
to look at the MC's ->bpmp and if it exists reuse that. If it doesn't
exist, we can keep the existing lookup as a fallback for device trees
that haven't been updated yet.

--SOqUr+gSHmGMXo04
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQi4gkACgkQ3SOs138+
s6G2ZxAAwuGkypHqrXA4QgRFLPxekiFsfb7hu4WNZB/Jrz4Lmvpay4dmkKjHSLA9
cKJUd3WIGmWES3R9F8xKMFS75/novPJukcYSS9a4X3t3xxYlq7hLgNd9fOcbDkOX
v2nxKJ616/Ay3Ili6JlD845nmvnBxd1MWkjsF/i6khyJ7k48x1mD5GIJT/J3CXE/
ikuC7FqzWV2hllEJlqdGu0Y6xzo+84w3sf5BfIvWT4Wvi+LjqJvDfeA7l4nEh9h9
xRjimc2eqsJ8YXF4Lpwcw30raeYvkBqd7N+dtAa5emU61hi8po1OH+VEmhB2qISw
UdciYir/o51oDPboXtMguc3Ei13eYNOrYqjwbPXsewCaWF99jR5nQrNDB/It1Kq7
KJ3P44Qv4x1RMMbWX+cSOtyH+kb9XXJZV1saTu/ns9U+3x54OMM+JGWKCi4ifbJh
QQk2F0tqdGLmxuCtBL0+AowthUOoK13Zw3jAjsRS1F7suOcqV1kyyl+cmQmCu+sl
keKQpdLGxlrPRN/mzsLGM3nNLFW0bRtiKO3SLZLp6G3IGE55Ec9qotGN20kUyQVy
5C0hrICmnEXI4aHt4FCJkiOp55TS9xHO4Nf59oKXJICR8xMHmjQDFf27VaYXKTXR
FrRHds32doXBh0bnV2S4+7m0/QCjPGQHoXXG/xsFkYnv5TPFOgg=
=B8Lm
-----END PGP SIGNATURE-----

--SOqUr+gSHmGMXo04--
