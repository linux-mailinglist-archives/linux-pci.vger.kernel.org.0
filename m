Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6053C59642A
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 23:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237407AbiHPVGB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 17:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbiHPVGA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 17:06:00 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0BB75389
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 14:05:58 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v3so14069262wrp.0
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 14:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=2f/85arcP0Ku1kgJpVBVLo1xiYoiCycNRFXo4qwF5Xo=;
        b=j7RxzFnx4NHVX9l/AUFSE1Ml0ekwRXfROWEusMchscf8rtR5xzICK5XqQg9YnaBef6
         vas7FGeF58leFjCuB8JbsTZQErXoYTFytYrpPtfMRS5SjO3jzosSw4LFkOK4+S0kEnn4
         A3qPH3JygQkCXgx0/19Rn4qpL3FwvyX1sEmBKk0leIkDA07Aas1KIRnzYICGSfwJmV6f
         N9YNnjYP7L+NG6sZNIHEzd9C/zb/VB1MnHqW1A5ZizhZ5w6YH0+C9g2xDalyRK5CkWeb
         aZ0XcFuaKpQYrTdJrxvIFqpQ5BEch3wm2afPlk4467jq2snOOaXSB0LuFTSZYQCP2oNo
         Jdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=2f/85arcP0Ku1kgJpVBVLo1xiYoiCycNRFXo4qwF5Xo=;
        b=wlDi5azsHE6dhm2bJsR6AFZbZHremPpHrTdNzBdZkJpRwos9mVnyPv5lA2NK9nIyG1
         Fw9JCsiXF5LhHmbXt5d6xEtXKo5csjbSWmQVOsi65Nn0gA5UIdhDFixZbDeqY/DTXbBM
         on3fKOSEO8qaq1op77IHspYuAACkY2KBDRHNKkunFSufzN3BJLU5wRZVIIRKDdZrwNvx
         xIsfHnEFss1JcIUmFYmAuqjAguBlG1usmU46ecWneHKHObAtHIHeck5758OieK0pDWJa
         tz+ydehzSJ98vvLpZBy1DZ7VXtz2rke49iVipjwoJaHUvVTAI6D1VJXyGvSRdrcjHILf
         JNRA==
X-Gm-Message-State: ACgBeo1bgeCQRH/qNitNsH93JgXXSpOJn9o0h23k5DbdkZg4lCjP2e36
        AkVc5oMZsQmbaNTcpfmOkrM6YVc4NH5Ws0by
X-Google-Smtp-Source: AA6agR58u8cM3dGXK/53eWyziPV3maDwklbC3ReiAvrslrsNxTN31+j/21RFXv2OwnjVFyzyeoSp5Q==
X-Received: by 2002:adf:fb4c:0:b0:225:2033:b745 with SMTP id c12-20020adffb4c000000b002252033b745mr1296556wrs.447.1660683957068;
        Tue, 16 Aug 2022 14:05:57 -0700 (PDT)
Received: from smtpclient.apple (global-5-141.n-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id x15-20020a5d490f000000b002205a5de337sm10889363wrq.102.2022.08.16.14.05.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Aug 2022 14:05:56 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v2 1/6] dt-bindings: PCI: fu740-pci: fix missing
 clock-names
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20220816182547.3454843-2-mail@conchuod.ie>
Date:   Tue, 16 Aug 2022 22:05:55 +0100
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F62BE8A7-2023-497B-9BBC-AE54E7C5B08A@jrtc27.com>
References: <20220816182547.3454843-1-mail@conchuod.ie>
 <20220816182547.3454843-2-mail@conchuod.ie>
To:     Conor Dooley <mail@conchuod.ie>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 16 Aug 2022, at 19:25, Conor Dooley <mail@conchuod.ie> wrote:
>=20
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> The commit b92225b034c0 ("dt-bindings: PCI: designware: Fix
> 'unevaluatedProperties' warnings") removed the clock-names property as
> a requirement and from the example as it triggered unevaluatedProperty
> warnings. dtbs_check was not able to pick up on this at the time, but
> now can:
>=20
> arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dtb: pcie@e00000000: =
Unevaluated properties are not allowed ('clock-names' was unexpected)
>        =46rom schema: =
linux/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
>=20
> The property was already in use by the FU740 DTS and the clock must be
> enabled. The Linux driver does not use this property, but outside of
> the kernel this property may have users. Re-add the property and its
> "clocks" dependency.

Are you sure about this? I see a devm_clk_get("pcie_aux") that surely
won't without the property. FreeBSD=E2=80=99s similarly relies on the =
name,
though it also has a fallback to the U-Boot pcieaux name (because the
world is terrible and people can=E2=80=99t even agree on that) so it =
works
with the U-Boot-provided FDT (it would be nice if Linux had this as a
goal, and people worked with U-Boot devs to get everything needed for
newly-exposed devices merged back there so I don=E2=80=99t have to be =
the one
to notice and do it...).

Jess

> Fixes: b92225b034c0 ("dt-bindings: PCI: designware: Fix =
'unevaluatedProperties' warnings")
> Fixes: 43cea116be0b ("dt-bindings: PCI: Add SiFive FU740 PCIe host =
controller")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> v2022.08 of dt-schema is required.
> ---
> .../devicetree/bindings/pci/sifive,fu740-pcie.yaml          | 6 ++++++
> 1 file changed, 6 insertions(+)
>=20
> diff --git =
a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml =
b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
> index 195e6afeb169..c7a9a2dc0fa6 100644
> --- a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
> @@ -51,6 +51,12 @@ properties:
>     description: A phandle to the PCIe power up reset line.
>     maxItems: 1
>=20
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: pcie_aux
> +
>   pwren-gpios:
>     description: Should specify the GPIO for controlling the PCI bus =
device power on.
>     maxItems: 1
> --=20
> 2.37.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

