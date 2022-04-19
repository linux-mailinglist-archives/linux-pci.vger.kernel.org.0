Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05ABC5076CF
	for <lists+linux-pci@lfdr.de>; Tue, 19 Apr 2022 19:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345069AbiDSRwq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Apr 2022 13:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356089AbiDSRwa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2022 13:52:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E50D9;
        Tue, 19 Apr 2022 10:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650390552;
        bh=MDs+/hTTaszs+7phQ7fP55iuGTCGnxSxNB+AmfhvHuI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=TnDZzT+t51BtIZ3ttWb8yCAiQ+bRXXd/u6G0viY+8w6Ni6c7lHcocNUuBZBnS4674
         6WhQO0gk3GYZKK1EeXd9DNGPdu8vTbAeDU/gR+vtsnJYvfjdA+H3E5RicFlC3T2tAS
         /Cabuc5TQs7rUXlCugCortddBqGUNVZKFqbOjqCc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.157.75] ([217.61.157.75]) by web-mail.gmx.net
 (3c-app-gmx-bap70.server.lan [172.19.172.170]) (via HTTP); Tue, 19 Apr 2022
 19:49:12 +0200
MIME-Version: 1.0
Message-ID: <trinity-597cf8a3-2ad4-41e6-b3c9-b949f8610533-1650390552136@3c-app-gmx-bap70>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Aw: Re: [RFC/RFT 1/6] dt-bindings: phy: rockchip: add pcie3 phy
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 19 Apr 2022 19:49:12 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <38e60bb2-123b-09cf-d6ef-3a07c6984108@linaro.org>
References: <20220416135458.104048-1-linux@fw-web.de>
 <20220416135458.104048-2-linux@fw-web.de>
 <38e60bb2-123b-09cf-d6ef-3a07c6984108@linaro.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:/NkW5UmqezUBTPZZjBz4iBJWrJkbhZBwHKWh0V8Jyr+1pKhoCegGDlCq58zKMqOdmW2O8
 qFWG3xBwI/JlRCsgKDIK8CQBYs6tKtGZZsYo934557XRhtF/eLBlrxHGW+UzzHL29Pk168fbvTc/
 OvR820AunbkK1yc3njh3Sx5eugb5TtM0ugLFARb7bmwQSMoEXbcDtNqwCs1HHLKMQGPDYWPxxyZl
 M74fV0GdY2s7Yh1BotHcRNi9nQgL9KwZxEVXJDSI7OKWmbxEcdT61wl+Hxv3VCTpwtjd+5o892Eg
 Sw=
X-UI-Out-Filterresults: notjunk:1;V03:K0:aqAasQSxCdg=:Z5mk/vux6jXB0lRqbcp7Bk
 UJIJOWyt+bDd1jbTRt28lwBTb27anTGJNthdQC8F0KbTbeldXZ6uPBF1KXCOTiaQuMVtD1U+m
 hnQsLazT8r/MPjhmNW1sEOVKNNGDeRSSq1q6n94Hj5X0T3Csa9tBFfqn917kEsmJ0dz/X3MY6
 Pk7zvjDiDkn0d1KXq2xsqFbUbHykddiuEnvxe1/GsZObmeUy+WdaC1NKl7zG06q0r2nQpLC8P
 u9MSbcKFFnUX7XsXmriHLY0xsYTPQozZgqgyfc5ZM4ouiuPS668cC5jyfkzWDZQtpyytMeceW
 O+p4bn8kIgBzNqZzwkvk8daiwSRkvgl9QvojKWeUYZcxLhnbNOICkSniTGG9xdzr7WphdwgQZ
 V6X22tRIkLgQzxrDi9Iji0l25j0z9ytR+sg4tgNwCjPn6IWljebWjcwrBdqYdCjhOJ6Nu5piy
 vfaOouiSJYlKk03KU7CFw8yhUqkElk3b7fK2RO1KhvihNkcrFZNejEnXXYFur8E4j1+D/MIr2
 4q6UlSWznMyEYZXRW9crGkCR00/85yNxGSLaryFgsnn63K1WLWJMVlKmtPF009fPe6dh0NS5Z
 f1N2k1OWEkQEyfujdvkJziA6iq9oT5quw2EoIIqx/7GTUPZAQ8ZmBS9d6CsKpjTyht8IS7tbJ
 WIN9nu4KWK6d56emVSrxgdtX+kIf7x/3uqMqDlzyEpH5zjL9xHGNVd2cJPFm53xFHgXE/geLu
 A5GmJR47U9xPnXwLPTlmwG7rjN79csWKr502balpYnJSX6BGb94rekgHxR9cQRdj5h2VI3ahs
 kd7tLPH
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Gesendet: Montag, 18. April 2022 um 17:52 Uhr
> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
> > diff --git a/Documentation/devicetree/bindings/phy/rockchip-pcie3-phy.=
yaml b/Documentation/devicetree/bindings/phy/rockchip-pcie3-phy.yaml
> > new file mode 100644
> > index 000000000000..58a8ce175f13
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/rockchip-pcie3-phy.yaml
>
> Filename: vendor,hardware
> so for example "rockchip,pcie3-phy" although Rob proposed recently for
> other bindings using compatible as a base:
> https://lore.kernel.org/linux-devicetree/YlhkwvGdcf4ozTzG@robh.at.kernel=
.org/

ok, i rename

> > @@ -0,0 +1,77 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/rockchip-pcie3-phy.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Rockchip PCIe v3 phy
> > +
> > +maintainers:
> > +  - Heiko Stuebner <heiko@sntech.de>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - rockchip,rk3568-pcie3-phy
> > +      - rockchip,rk3588-pcie3-phy
> > +
> > +  reg:
> > +    maxItems: 2
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 3
> > +
> > +  clock-names:
> > +    contains:
> > +      anyOf:
> > +        - enum: [ refclk_m, refclk_n, pclk ]
>
> The list should be strictly ordered (defined), so:
>   items:
>     - const: ...
>     - const: ...
>     - const: ...
>   minItems: 1
>
> However the question is - why the clocks have different amount? Is it
> per different SoC implementation?

i only know the rk3568, which needs the clocks defined here, don't know ab=
out rk3588 yet.
in rk3568 TPM i have the pcie-part seems missing (at least the specific re=
gister definition), so i had used the driver as i got it from the downstre=
am kernel.

not yet looked if i find a rk3588 TPM and if this part is there as i canno=
t test it (one of the reasons this is a rfc/rft).

> > +
> > +  "#phy-cells":
> > +    const: 0
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  reset-names:
> > +    const: phy
> > +
> > +  rockchip,phy-grf:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: phandle to the syscon managing the phy "general regi=
ster files"
> > +
> > +  rockchip,pipe-grf:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: phandle to the syscon managing the pipe "general reg=
ister files"
> > +
> > +  rockchip,pcie30-phymode:
> > +    $ref: '/schemas/types.yaml#/definitions/uint32'
> > +    description: |
> > +      use PHY_MODE_PCIE_AGGREGATION if not defined
>
> I don't understand the description. Do you mean here a case when the
> variable is missing?

yes, if the property is not set, then value is PHY_MODE_PCIE_AGGREGATION =
=3D 4

> > +    minimum: 0x0
> > +    maximum: 0x4
>
> Please explain these values. Register values should not be part of
> bindings, but instead some logical behavior of hardware or its logic.

it's a bitmask, so maybe

    description: |
      bit0: bifurcation for port 0
      bit1: bifurcation for port 1
      bit2: aggregation
      use PHY_MODE_PCIE_AGGREGATION (4) as default

> > +
> > +
>
> Just one blank line.
>
> > +required:
> > +  - compatible
> > +  - reg
> > +  - rockchip,phy-grf
>
> phy-cells as well
>
> > +
> > +additionalProperties: false
> > +
> > +unevaluatedProperties: false
>
> Just one please, additionalProperties.
ok

> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/rk3568-cru.h>
> > +    pcie30phy: phy@fe8c0000 {
> > +      compatible =3D "rockchip,rk3568-pcie3-phy";
> > +      reg =3D <0x0 0xfe8c0000 0x0 0x20000>;
> > +      #phy-cells =3D <0>;
> > +      clocks =3D <&pmucru CLK_PCIE30PHY_REF_M>, <&pmucru CLK_PCIE30PH=
Y_REF_N>,
> > +       <&cru PCLK_PCIE30PHY>;
>
> Align the entry with opening '<'. Usually the most readable is one clock
> per line.

ok

> > +      clock-names =3D "refclk_m", "refclk_n", "pclk";
> > +      resets =3D <&cru SRST_PCIE30PHY>;
> > +      reset-names =3D "phy";
> > +      rockchip,phy-grf =3D <&pcie30_phy_grf>;
> > +    };

regards Frank
