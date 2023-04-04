Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BFF6D5B5C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 10:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbjDDI72 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Apr 2023 04:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbjDDI7Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2023 04:59:24 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3D52713;
        Tue,  4 Apr 2023 01:59:22 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id b19so23718475oib.7;
        Tue, 04 Apr 2023 01:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680598761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uATusROMiuJEMVEQ1ZavvbntnDc27gCopVhFKiZv8PA=;
        b=XM44dU1oce7TdRzUkPRtZV1DyGdTHDUsiARIAtHC9T/ryv4GAy6D6nO3CfjZl1liIk
         D4wvlR6BS/wDmbmuH7HTx59IhNZf5kDVg9uhLEGY8y73VA8BawRIAU5n01cvJTWIBQ5v
         MUyvTejsSafqBPdnV3NTCPDMn57SGLAGDRXbVN3RzCckfQN9oEh3rr0VHzDb6KAhP/gL
         yavbu5uh0FmuyCimH/zqIqZjvzSGx2QViXX8ZmHA4fjpbjhCI3NzaQYoX2yAU3KuatSB
         gGfWKcKS9b/srp/4wVhdeng6+RxS+NRRcuF4l8/1RQlDPwrurkhSPwGO2xJbgTsF/MYK
         4yPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680598761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uATusROMiuJEMVEQ1ZavvbntnDc27gCopVhFKiZv8PA=;
        b=tvgZYGgtq9WlXRVya/WlB8JsY8XnyNbm0Rq7AojdMc4/yAsjnCoFecucJASolaPZat
         M+soXfyN4nnuLlfnsqECaGfY1EtXx2exZLaVyk1/aFHfnhqI3P/CnIA0wiGaqGs6dojQ
         fOT78RlMEe2klhMXWBFtGvc3utRLV90fYBtUkDQbpEjt0N1IxgACaqXArZo5awnnf28m
         HT4ii8pNpgwXIvScEomyGnNJtQN3iZ1pNEKUvLmIGVn4I+8b9itjh/61YngoNihgQfJ5
         z60iG0DCAYlbh9lAYRIlontFPYjl/I/eIYuxjPcol8o7RwlMcThXpzUq5EBzCGeWHKQ7
         6fYA==
X-Gm-Message-State: AAQBX9fmos10pzsOQd6WrnJhEDV8bn6M8xRgLH5deUcScS0zaO2OLGEp
        VoyUhA+dNg2hQHrefBg1a7lrKcvgkflqLw9kEgc=
X-Google-Smtp-Source: AKy350Y36FztdkSbBQMnp3bYmBLAyiVO43BqI0gGJmFyd0eK3cWh8e2yJYsmlnZ0YMR+c5JtNUiPqj/OWkXMeb0+SmM=
X-Received: by 2002:a05:6808:6294:b0:389:72d5:f15f with SMTP id
 du20-20020a056808629400b0038972d5f15fmr777180oib.10.1680598761439; Tue, 04
 Apr 2023 01:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230404082426.3880812-1-rick.wertenbroek@gmail.com>
 <20230404082426.3880812-7-rick.wertenbroek@gmail.com> <d9afc07f-0346-1fe7-907c-261e4c6f92cd@linaro.org>
In-Reply-To: <d9afc07f-0346-1fe7-907c-261e4c6f92cd@linaro.org>
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date:   Tue, 4 Apr 2023 10:58:45 +0200
Message-ID: <CAAEEuhrnp1QyP498V1wzyLv6KvfRCpNidF9NJpzg+kofWqrJtA@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] dt-bindings: PCI: Update the RK3399 example to a
 valid one
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     alberto.dassatti@heig-vd.ch, damien.lemoal@opensource.wdc.com,
        xxm@rock-chips.com, Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Caleb Connolly <kc@postmarketos.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Lin Huang <hl@rock-chips.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 4, 2023 at 10:45=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 04/04/2023 10:24, Rick Wertenbroek wrote:
> > Update the example in the documentation a valid example.
> > The default max-outbound-regions is 32 but the example showed 16.
>
> This is not reason to be invalid. It is perfectly fine to change default
> values to desired ones. What is not actually obvious is to change some
> value to a default one, instead of removing it...

Hello, the example value <0x0 0x80000000 0x0 0x20000>; is plain wrong
and will crash the kernel. This is a value that point to an address that fa=
lls
in the DDR RAM region but depending on the amount of RAM on the
board this address may not even exist (e.g., board with 2GB or less).

Also this address requires pointing to where the PCIe controller has the
windows from AXI Physical space to PCIe space. This address is
allocated when the SoC address map is created so it can only be that
one unless rockchip refabs the SoC with another address map.

The example never worked with the values given as reported by e.g.,
https://stackoverflow.com/questions/73586703/device-tree-issues-with-rockpr=
o64-pcie-endpoint
and here they set it to 0 (base of the DDR, which is a "valid" address
as to it exists even on boards with less than 2GB) but it is still wrong
to do so.

>
> > Address for mem-base was invalid. Added pinctrl.
> >
> > Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> > ---
> >  .../devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml  | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie=
-ep.yaml b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.ya=
ml
> > index 88386a6d7011..0c67e96096eb 100644
> > --- a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yam=
l
> > +++ b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yam=
l
> > @@ -47,14 +47,15 @@ examples:
> >
> >          pcie-ep@f8000000 {
> >              compatible =3D "rockchip,rk3399-pcie-ep";
> > -            reg =3D <0x0 0xfd000000 0x0 0x1000000>, <0x0 0x80000000 0x=
0 0x20000>;
> > -            reg-names =3D "apb-base", "mem-base";
>
> Reg (and reg-names) is usually second property, why moving it? What is
> incorrect in the placement?

Sorry, I was not aware there was a standard ordering, the reason I moved
so that it follows the ordering I had in the entry I added to the .dtsi fil=
e
(which therefore also is in the non standard order).
Could you be kind enough to share with me the link to the documentation
for the order, so that I can both update the .dtsi and this file, this
way it will
be in order and coherent for both. Thank you.

>
> > +            rockchip,max-outbound-regions =3D <32>;
> >              clocks =3D <&cru ACLK_PCIE>, <&cru ACLK_PERF_PCIE>,
> >                <&cru PCLK_PCIE>, <&cru SCLK_PCIE_PM>;
> >              clock-names =3D "aclk", "aclk-perf",
> >                      "hclk", "pm";
> >              max-functions =3D /bits/ 8 <8>;
> >              num-lanes =3D <4>;
> > +            reg =3D <0x0 0xfd000000 0x0 0x1000000>, <0x0 0xfa000000 0x=
0 0x2000000>;
> > +            reg-names =3D "apb-base", "mem-base";
> >              resets =3D <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
> >                <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE> ,
> >                <&cru SRST_PCIE_PM>, <&cru SRST_P_PCIE>, <&cru SRST_A_PC=
IE>;
> > @@ -62,7 +63,8 @@ examples:
> >                      "pm", "pclk", "aclk";
> >              phys =3D <&pcie_phy 0>, <&pcie_phy 1>, <&pcie_phy 2>, <&pc=
ie_phy 3>;
> >              phy-names =3D "pcie-phy-0", "pcie-phy-1", "pcie-phy-2", "p=
cie-phy-3";
> > -            rockchip,max-outbound-regions =3D <16>;
> > +            pinctrl-names =3D "default";
> > +            pinctrl-0 =3D <&pcie_clkreqnb_cpm>;
> >          };
> >      };
> >  ...
>
> Best regards,
> Krzysztof
>

Thank you for you comments,
Sincerely
Rick
