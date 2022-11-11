Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E996258FA
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 12:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbiKKLBD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 06:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbiKKLAx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 06:00:53 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E756EB7E6;
        Fri, 11 Nov 2022 03:00:51 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b3so7818327lfv.2;
        Fri, 11 Nov 2022 03:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=76BtwbFvEgk2Ooutx96DcencoxzI0YNwdpHtqJ9zpeA=;
        b=nXtR+qxMq0XgeDJtDFVMdSUiQN1YYiLwdpQISUE9AmHgjBSYmDze3Gk+8SFABBQD+G
         OOGZKAeZ51uvcfTozUAjWmulLtvR+IMTNP4pRiwu/4FBsZH0qfbcrsPRUo5wAyxV1kwn
         6HewTOy6jBq0a/Vj8QHi9clu/v6wcfrbIUBBOqDrCLKqX8ppkkMIgJxodwHwlalHXqtU
         K4wHeUCbE2UN2MOTpjg5YOl9MTtV9kWxRZy9R1uh62ocNbBj9GDNgWgMEAX7rxUYpyVq
         tSVA4HI4R7aRc17NKxW0jggLp84KpRroSRLUN1g5GMZx/zfyOZM8S+b5EMug5wUdqtcj
         PzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76BtwbFvEgk2Ooutx96DcencoxzI0YNwdpHtqJ9zpeA=;
        b=COYvxorFmqE52eFnkyOF6doEYpzt5Vxn9lAuAKsBZb+8P8Q6NhvhGrG+9bGGptNyxA
         iw7k6dCiDNMH/gLMWWpIavBBM4YXRtFUJ7LE1T8fAhJ0MFRegbgC6BumR3dEZZOqI7BA
         K18s91fQxm8I9u1ezUV3W4SttglySUIujhie6og4lvvUZJzrg1+5zaun8eHzbt+jUFAD
         L1AjyfDLfjqmeBtefFpK1cPMohVTLHWnl9CrXhdfmKr13hFgkLUBDiu3mNyxZ37EywYx
         GGq1FdmgucnsQM83lwXqfiA36sn0e7vKI2NIFISzDin9pzJgp5Y2Qq458xS9bt3HsQmx
         1wQg==
X-Gm-Message-State: ANoB5pnr1S9bYRzSqfo1UKDLf0nz7ivMlpPem1e4FjS63l0Aqp1uyS/j
        Cky6UL8nMMQZZXIznM7VJGxxIEHfMi488A==
X-Google-Smtp-Source: AA0mqf4JlFbm0dXu05TXiCgPSAqyGH8aeNu8J7BtUnNj5rU3c16j9GEa8NDTrdeqwcBgcn9ruWymuQ==
X-Received: by 2002:a19:500f:0:b0:4a3:9533:f4c9 with SMTP id e15-20020a19500f000000b004a39533f4c9mr580057lfb.615.1668164450136;
        Fri, 11 Nov 2022 03:00:50 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id p3-20020a2eb103000000b002770566d642sm351039ljl.17.2022.11.11.03.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 03:00:49 -0800 (PST)
Date:   Fri, 11 Nov 2022 14:00:46 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        caihuoqing <caihuoqing@baidu.com>, Vinod Koul <vkoul@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 01/20] dt-bindings: imx6q-pcie: Fix clock names for
 imx6sx and imx8mq
Message-ID: <20221111110046.rqjl2zaapipsgkpa@mobilestation>
References: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
 <20221107204934.32655-2-Sergey.Semin@baikalelectronics.ru>
 <20221110210104.GA963064-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110210104.GA963064-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 10, 2022 at 03:01:04PM -0600, Rob Herring wrote:
> On Mon, Nov 07, 2022 at 11:49:15PM +0300, Serge Semin wrote:
> > Originally as it was defined the legacy bindings the pcie_inbound_axi and
> > pcie_aux clock names were supposed to be used in the fsl,imx6sx-pcie and
> > fsl,imx8mq-pcie devices respectively. But the bindings conversion has been
> > incorrectly so now the fourth clock name is defined as "pcie_inbound_axi
> > for imx6sx-pcie, pcie_aux for imx8mq-pcie", which is completely wrong.
> > Let's fix that by conditionally apply the clock-names constraints based on
> > the compatible string content.
> > 
> > Fixes: 751ca492f131 ("dt-bindings: PCI: imx6: convert the imx pcie controller to dtschema")
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > 
> > ---
> > 
> > Changelog v5:
> > - This is a new patch added on the v5 release of the patchset.
> > ---
> >  .../bindings/pci/fsl,imx6q-pcie.yaml          | 47 +++++++++++++++++--
> >  1 file changed, 42 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > index 376e739bcad4..ebfe75f1576e 100644
> > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > @@ -16,6 +16,47 @@ description: |+
> >  
> >  allOf:
> >    - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: fsl,imx6sx-pcie
> > +    then:
> > +      properties:
> > +        clock-names:
> > +          items:
> > +            - const: pcie
> > +            - const: pcie_bus
> > +            - const: pcie_phy
> > +            - const: pcie_inbound_axi
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: fsl,imx8mq-pcie
> > +    then:
> > +      properties:
> > +        clock-names:
> > +          items:
> > +            - const: pcie
> > +            - const: pcie_bus
> > +            - const: pcie_phy
> > +            - const: pcie_aux
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          not:
> > +            contains:
> > +              enum:
> > +                - fsl,imx6sx-pcie
> > +                - fsl,imx8mq-pcie
> > +    then:
> > +      properties:
> > +        clock-names:
> > +          items:
> > +            - const: pcie
> > +            - const: pcie_bus
> > +            - const: pcie_phy
> >  
> >  properties:
> >    compatible:
> > @@ -57,11 +98,7 @@ properties:
> >  
> >    clock-names:
> >      minItems: 3
> > -    items:
> > -      - const: pcie
> > -      - const: pcie_bus
> > -      - const: pcie_phy
> > -      - const: pcie_inbound_axi for imx6sx-pcie, pcie_aux for imx8mq-pcie
> 

> This should have been just 'enum: [ pcie_inbound_axi, pcie_aux ]'
> 
> And then do:
> 
>   - if:
>       properties:
>         compatible:
>           contains:
>             const: fsl,imx8mq-pcie
>     then:
>       properties:
>         clock-names:
>           items:
>             - {}
>             - {}
>             - {}
>             - const: pcie_aux
> 
> 
> And then another if/then with 'maxItems: 3'

Ok. Will fix it in v7. But IMO it looks a bit less descriptive
especially with the '{}' pattern and a need to look in two different
places to comprehend the whole constraint. I understand though what is an
intention of such construction. It's to place as much info into the
schema body and isolate the platform-specific constraints in the allOf
clause. Pretty neat anyway.

-Sergey
