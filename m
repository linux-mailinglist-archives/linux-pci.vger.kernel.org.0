Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1649E5A114B
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 15:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242083AbiHYNBM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 09:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242119AbiHYNBL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 09:01:11 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F94D3AB2A;
        Thu, 25 Aug 2022 06:01:10 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bt10so15156794lfb.1;
        Thu, 25 Aug 2022 06:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=HXz5r5nARBDUrWmq5bMXUBc88dL0Gf53fHnzPY0C8Cw=;
        b=IjmH3eKJZsmSiWXRk8UD08OLLxfyc+keRxdrSyGSHQ8Kff1Q/6Sl/2/m8sqXaXtvht
         UUxmjcry5A4cPm7BAu22lFkLN1r7vxyr73y7AZcakr+awqp3Vtwxo1ps50ip7cp1Y2hQ
         QsAQ75lX1XILbbUqI2CIZCahqKuNRzapBWsPLLy6+Vo2KA0hqRVIWcbULMrxgJQwkSut
         +2uqpY1fbk20Jsi/PEb3B87aqI6jrCMswf14s//6+KwYiHHZXN5zWZ1fsIzoIsaqCeAr
         nCgEqb7tC+DzAPax4zjzPTuKIZBNOWj7REm3X00HpWgNa4COV+vcOiFkMbrz1ULx0+V3
         ZlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=HXz5r5nARBDUrWmq5bMXUBc88dL0Gf53fHnzPY0C8Cw=;
        b=q3Owb7QEiybE61UNsuy5m7CYfzQeJJh5tVA40YM/fhIiJ2iCYNasFHml1aiNoh3dQx
         ImzaDpL1Jcc95ZT+CfauF6poIItoX/yOvC7NFOQt+UKrQXsaqlgO7NDCvBQV3awP+PHd
         mH5DhkbFvRognvfo776iqdLzpG2GFSWh6NIb7a42ohrpO8/QyyuBrNZF5ESeoMsbbsG5
         6S38nbgK0zIzsxC98DHI/g/z+7kwSRuVDKNyWBtLpKUEeqvZiuPLHUPJthDx2mpKfdro
         Qcc3Rr4wNm/cxrsRlFFNMw4BObTpG80gRrl4VqMN261VDNI5zURV94vaBr8w7CdEvc7X
         pR5w==
X-Gm-Message-State: ACgBeo3o1K9Npaq9GyqBBN+RiuGJcewOD8hy9uXrWnYBbvb2KfhBwlCW
        ybcVZT4NbJvi/1/dRnRo9GA=
X-Google-Smtp-Source: AA6agR5E2VLJ311lYr2Z6ZX+fqdNCc+e5s1M3RyjO6AfhBJqTxKKgSoQHjbqmVNivcVedLapoj+S1Q==
X-Received: by 2002:a05:6512:c10:b0:492:d263:f918 with SMTP id z16-20020a0565120c1000b00492d263f918mr1092408lfu.501.1661432468639;
        Thu, 25 Aug 2022 06:01:08 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id b9-20020ac25e89000000b00489e812f05asm497832lfq.21.2022.08.25.06.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 06:01:07 -0700 (PDT)
Date:   Thu, 25 Aug 2022 16:01:05 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/20] dt-bindings: imx6q-pcie: Fix clock names for
 imx6sx and imx8mq
Message-ID: <20220825130105.s5lj3h3pqlntns2f@mobilestation>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
 <20220822184701.25246-2-Sergey.Semin@baikalelectronics.ru>
 <8354660.EvYhyI6sBW@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8354660.EvYhyI6sBW@steina-w>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alexander,

On Thu, Aug 25, 2022 at 09:55:56AM +0200, Alexander Stein wrote:
> Hello Serge,
> 
> Am Montag, 22. August 2022, 20:46:42 CEST schrieb Serge Semin:
> > Originally as it was defined the legacy bindings the pcie_inbound_axi and
> > pcie_aux clock names were supposed to be used in the fsl,imx6sx-pcie and
> > fsl,imx8mq-pcie devices respectively. But the bindings conversion has been
> > incorrectly so now the fourth clock name is defined as "pcie_inbound_axi
> > for imx6sx-pcie, pcie_aux for imx8mq-pcie", which is completely wrong.
> > Let's fix that by conditionally apply the clock-names constraints based on
> > the compatible string content.
> > 
> > Fixes: 751ca492f131 ("dt-bindings: PCI: imx6: convert the imx pcie
> > controller to dtschema")
> > Signed-off-by: Serge Semin
> > <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Changelog v5:
> > - This is a new patch added on the v5 release of the patchset.
> > ---
> >  .../bindings/pci/fsl,imx6q-pcie.yaml          | 47 +++++++++++++++++--
> >  1 file changed, 42 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml index
> > 376e739bcad4..ebfe75f1576e 100644
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
> 
> I'm not so sure about this list essentially copying the (for now) two 
> compatibles from above, but no hard from my side. I have a quite similar patch 
> nesting the following structure:

> if imx6sx
> then
>   <4 clocks including pcie_inbound_axi>
> else if imx8mq
>   then
>     <4 clocks including pcie_aux> 
>   else
>     <3 clocks>

The schema above looks a bit different in your case:
+ if:
+ then:
+ else:
+   if:
+   then:
+   else:

Anyway the main point is each new statement adds one more indentation
level, which in case of updating the schema with new clocks setup will
get to be even more right shifted. Note for that reason you'd need to
fully update the last else block. So the corresponding patch will get
to be bulky and less readable.

Another point for my approach is that the if-else-if-else-etc
statement much harder to read than just multiple if-statements
combined in the allOf property.

IMO that's why more often you get to see the allOf-if-if-etc pattern than
the allOf-if-else-if-else one.

> 
> In the end I'm fine with both approaches, whatever DT bindings maintainer find 
> superior.
> Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Thanks.

-Sergey

> 
> 
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
> > +    maxItems: 4
> > 
> >    num-lanes:
> >      const: 1
> 
> 
> 
> 
