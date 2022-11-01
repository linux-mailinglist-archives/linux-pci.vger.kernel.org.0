Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E936615085
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 18:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiKARWe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 13:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiKARWd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 13:22:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0DE1B1DF;
        Tue,  1 Nov 2022 10:22:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B391616D3;
        Tue,  1 Nov 2022 17:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF73AC43470;
        Tue,  1 Nov 2022 17:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667323351;
        bh=rgPGhUUt+Eyr0PadTOMg/b3hGIEIFxFAmO+UgjHuXjg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sKK7JjMNpUp0pB4xBhlrCB4Q5PsVPhMCuyQFP06qzMwkOZUXClGjTp3ioNusBPvql
         pDtDKVjcSDhLImjrE/4+pfjgfeKpoiwXm8zeNcEqJ1EFd6Cug6V7NB9nvzk1a0uVrH
         BtykVR53Ni8+BOFwtc4crxEVkaPeh+fugsdv+R6OvwPluKc9IdrKOyC7j3NquziIFo
         vHX9Ihlt44Bb7XSnnoXrBY3rAjA7NcMCwTtw1yCRr+JgXLrElPcW3llcNItoaTBOic
         qYSC32+9pLwAChCVilgLXhHX+7rFAqLR5aLRDIj6lAJ3zBuFmKvxvtZNdIRsZydwsi
         1aczXvTT8+SZQ==
Received: by mail-lj1-f177.google.com with SMTP id j14so21856352ljh.12;
        Tue, 01 Nov 2022 10:22:31 -0700 (PDT)
X-Gm-Message-State: ACrzQf3lago/N2nUOKtze1SsdGJflAI5zrkhEjTvXSQSSnETNLr2i5ja
        lO4M5KEVj/Q9YoJC7rF8MoBRO/El4ubAEeNozA==
X-Google-Smtp-Source: AMsMyM5vOg74NIWBfxSPaEbGXTsm2QqL0KeMr1dNQn0vaGrKgq5wWdu76VnqemjN8nO91mLCT9GkD3PgA7n9FTpeu5A=
X-Received: by 2002:a2e:9a85:0:b0:275:1343:df71 with SMTP id
 p5-20020a2e9a85000000b002751343df71mr1163621lji.215.1667323349671; Tue, 01
 Nov 2022 10:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221029211312.929862-1-dmitry.baryshkov@linaro.org>
 <20221029211312.929862-2-dmitry.baryshkov@linaro.org> <20221031214055.GA3613285-robh@kernel.org>
 <CAA8EJpqt+UvWHwd90Cdm3iCi2sbxbwbC3ADY6PW053Tw8r94VA@mail.gmail.com>
In-Reply-To: <CAA8EJpqt+UvWHwd90Cdm3iCi2sbxbwbC3ADY6PW053Tw8r94VA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 1 Nov 2022 12:22:20 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLVzPawSFh9e6b3nVfn+dNDFooVgOa7B_iTGU13tzXTRQ@mail.gmail.com>
Message-ID: <CAL_JsqLVzPawSFh9e6b3nVfn+dNDFooVgOa7B_iTGU13tzXTRQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] dt-bindings: PCI: qcom: Add sm8350 to bindings
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 31, 2022 at 4:47 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, 1 Nov 2022 at 00:40, Rob Herring <robh@kernel.org> wrote:
> >
> > On Sun, Oct 30, 2022 at 12:13:06AM +0300, Dmitry Baryshkov wrote:
> > > Add bindings for two PCIe hosts on SM8350 platform. The only difference
> > > between them is in the aggre0 clock, which warrants the oneOf clause for
> > > the clocks properties.
> > >
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >  .../devicetree/bindings/pci/qcom,pcie.yaml    | 54 +++++++++++++++++++
> > >  1 file changed, 54 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > index 54f07852d279..55bf5958ef79 100644
> > > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > @@ -32,6 +32,7 @@ properties:
> > >        - qcom,pcie-sdm845
> > >        - qcom,pcie-sm8150
> > >        - qcom,pcie-sm8250
> > > +      - qcom,pcie-sm8350
> > >        - qcom,pcie-sm8450-pcie0
> > >        - qcom,pcie-sm8450-pcie1
> > >        - qcom,pcie-ipq6018
> > > @@ -185,6 +186,7 @@ allOf:
> > >                - qcom,pcie-sc8180x
> > >                - qcom,pcie-sc8280xp
> > >                - qcom,pcie-sm8250
> > > +              - qcom,pcie-sm8350
> > >                - qcom,pcie-sm8450-pcie0
> > >                - qcom,pcie-sm8450-pcie1
> > >      then:
> > > @@ -540,6 +542,57 @@ allOf:
> > >            items:
> > >              - const: pci # PCIe core reset
> > >
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - qcom,pcie-sm8350
> > > +    then:
> > > +      oneOf:
> > > +          # Unfortunately the "optional" ref clock is used in the middle of the list
> > > +        - properties:
> > > +            clocks:
> > > +              maxItems: 13
> > > +            clock-names:
> > > +              items:
> > > +                - const: pipe # PIPE clock
> > > +                - const: pipe_mux # PIPE MUX
> > > +                - const: phy_pipe # PIPE output clock
> > > +                - const: ref # REFERENCE clock
> > > +                - const: aux # Auxiliary clock
> > > +                - const: cfg # Configuration clock
> > > +                - const: bus_master # Master AXI clock
> > > +                - const: bus_slave # Slave AXI clock
> > > +                - const: slave_q2a # Slave Q2A clock
> > > +                - const: tbu # PCIe TBU clock
> > > +                - const: ddrss_sf_tbu # PCIe SF TBU clock
> > > +                - const: aggre0 # Aggre NoC PCIe0 AXI clock
> >
> > 'enum: [ aggre0, aggre1 ]' and 'minItems: 12' would eliminate the 2nd
> > case. There's a implicit requirement that string names are unique (by
> > default).
>
> Wouldn't it also allow a single 'aggre0' string?

No, because it's only for the 12th entry in the list.

Rob
