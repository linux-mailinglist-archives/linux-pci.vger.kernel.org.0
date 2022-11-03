Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F77A617C92
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 13:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiKCMca (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 08:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbiKCMcY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 08:32:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89331007F;
        Thu,  3 Nov 2022 05:32:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7877EB8266F;
        Thu,  3 Nov 2022 12:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304D0C433B5;
        Thu,  3 Nov 2022 12:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667478739;
        bh=N9CqtDSbhFYLYzO+K3V2iDuMV3FCcyceKiq9xxntVjQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qco8SNBxpMu2q9NKkQjVcf/Jb28EELIIffKX74QpJr41SUbUVT8/GvZdCb0zWYprE
         5ZBJAP31kKEz1gczbiBQNPrVB42WSb3apTbPDnTcLDLAXmD7uRXcPoXfdE/SOlJkem
         Udf5o1KbfyLf10E9BLvGIjQqDXAdAM0uD0l+FkCGEk/z1x7rN+3sVG0mEUPLlxwmSu
         XmzxnOl8AVIgGKQ6hBoUCeeR0Xli5L9x1FLGTTcGvW3PXdCqVE7wMOSl0H1mL1SkCY
         1/DYAjGaXkZEfTjy7HP/DYJXdWkhLa8aFNsxcHhcQzU/eJeHLP/fcwYZ2nChZfTmIY
         KpLjFuoX7LW3g==
Received: by mail-lj1-f179.google.com with SMTP id u2so2013302ljl.3;
        Thu, 03 Nov 2022 05:32:19 -0700 (PDT)
X-Gm-Message-State: ACrzQf3LC2BzCb35m3hSE21/1kI7vDfauZpxhMJlYkjZA2jCPTz5V2VF
        0V7Tw642XdYEnpAjV/8a631BuTqijUSeLfXNcA==
X-Google-Smtp-Source: AMsMyM7tdhuudzkai3qH+D0vEp/ybJZTKIeUX9wju8e9WfIP0fStDjZlZQZ+Ydp4HH4nfxMN4ic3ZSeJ8IdzICVZt+4=
X-Received: by 2002:a2e:3508:0:b0:277:611:c251 with SMTP id
 z8-20020a2e3508000000b002770611c251mr11425975ljz.211.1667478737180; Thu, 03
 Nov 2022 05:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221102215729.147335-1-marex@denx.de> <20221102215729.147335-2-marex@denx.de>
 <3645906.iIbC2pHGDl@steina-w>
In-Reply-To: <3645906.iIbC2pHGDl@steina-w>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 3 Nov 2022 07:32:08 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLg893rWwEQhgf_9=78WNiA7bstqPVvP6SQe4SyAhhyUw@mail.gmail.com>
Message-ID: <CAL_JsqLg893rWwEQhgf_9=78WNiA7bstqPVvP6SQe4SyAhhyUw@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: imx6q-pcie: Handle various PD configurations
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 3, 2022 at 3:29 AM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi Marek,
>
> Am Mittwoch, 2. November 2022, 22:57:28 CET schrieb Marek Vasut:
> > The i.MX SoCs have various power domain configurations routed into
> > the PCIe IP. MX6SX is the only one which contains 2 domains and also
> > uses power-domain-names. MX6QDL do not use any domains. All the rest
> > uses one domain and does not use power-domain-names anymore.
> >
> > Document all those configurations in the DT binding document.
> >
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > ---
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: NXP Linux Team <linux-imx@nxp.com>
> > To: devicetree@vger.kernel.org
> > ---
> >  .../bindings/pci/fsl,imx6q-pcie.yaml          | 47 ++++++++++++++-----
> >  1 file changed, 34 insertions(+), 13 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml index
> > 1cfea8ca72576..fc8d4d7b80b38 100644
> > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > @@ -68,19 +68,6 @@ properties:
> >      description: A phandle to an fsl,imx7d-pcie-phy node. Additional
> >        required properties for imx7d-pcie and imx8mq-pcie.
> >
> > -  power-domains:
> > -    items:
> > -      - description: The phandle pointing to the DISPLAY domain for
> > -          imx6sx-pcie, to PCIE_PHY power domain for imx7d-pcie and
> > -          imx8mq-pcie.
> > -      - description: The phandle pointing to the PCIE_PHY power domains
> > -          for imx6sx-pcie.
> > -
> > -  power-domain-names:
> > -    items:
> > -      - const: pcie
> > -      - const: pcie_phy
> > -
> >    resets:
> >      maxItems: 3
> >      description: Phandles to PCIe-related reset lines exposed by SRC
> > @@ -241,6 +228,40 @@ allOf:
> >                  - const: pcie_bus
> >                  - const: pcie_phy
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: fsl,imx6sx-pcie
> > +    then:
> > +      properties:
> > +        power-domains:
> > +          items:
> > +            - description: The phandle pointing to the DISPLAY domain for
> > +                imx6sx-pcie, to PCIE_PHY power domain for imx7d-pcie and
> > +                imx8mq-pcie.
> > +            - description: The phandle pointing to the PCIE_PHY power
> > domains +                for imx6sx-pcie.
> > +        power-domain-names:
> > +          items:
> > +            - const: pcie
> > +            - const: pcie_phy
> > +    else:
> > +      if:
> > +        not:
> > +          properties:
> > +            compatible:
> > +              contains:
> > +                enum:
> > +                  - fsl,imx6q-pcie
> > +                  - fsl,imx6qp-pcie
> > +      then:
> > +        properties:
> > +          power-domains:
> > +            description: |
> > +               The phandle pointing to the DISPLAY domain for imx6sx-pcie,
> > to +               PCIE_PHY power domain for imx7d-pcie and imx8mq-pcie. +
>
> Doesn't it makes more sense to keep the power-domains descriptions in the
> common part on top, as before, but adjust minItems/maxItems for each
> compatible?

Yes. Keep properties defined at the top level.

Rob
