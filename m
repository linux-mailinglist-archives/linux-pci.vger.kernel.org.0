Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F4558C684
	for <lists+linux-pci@lfdr.de>; Mon,  8 Aug 2022 12:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242340AbiHHKgS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Aug 2022 06:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbiHHKgQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Aug 2022 06:36:16 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4705F54;
        Mon,  8 Aug 2022 03:36:15 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bq11so12045978lfb.5;
        Mon, 08 Aug 2022 03:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=GOY9zupAtO8m7NwOCJ2N5qzs5R1+JU0a+1359ZZ0XfQ=;
        b=XbrMofQUvIiFzg6r0NnMAy7pY5aAeUrDka6vHJkoXXgrL3RnNFC2OZrho94X2SYS7D
         03EG/ZSkkXq+9Z3DCMFk9j9l4CC3WXwzNO9uBkEhvLxjMlduj/ICgNCsPQSFV6PE0F0J
         ry43FGpIzexk3RY9lLsTI7Nlv8rsKyTfM8YX9qePAY7/cvN9CiSG6fXiub71jvri2Gcj
         HSFccu7wh2QSuWn2HWlm+aXP+ygdvxOhXVXmuVqaCDz0UGUFjBZxgrLJB2TRwWezpQ0H
         SwgdqwgO8fylZJQS4ijcjvTaUMKiRc+RiyTSHJGZHb364kmLqx9fuCPN1ECc/noopDxt
         /3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=GOY9zupAtO8m7NwOCJ2N5qzs5R1+JU0a+1359ZZ0XfQ=;
        b=ICIJ0OPRC51pM4hOdmcx21dkQ6HWSFRrJdQpre2CdUkzZDGI2yM2FOP9gtO0oQiaRC
         7N07kWAPfnZhtJUfMefrwx7DVoqG1YL2BTwH8zgNxbYy64kskGYwfhPNlgNpI7fhjK1A
         gLBkddcjGtMmAeeQTPlNRG10rTJ9AgN1HeRbRrYukHvb7vVPNlSIUAaK8xcH0HwiigO/
         M+m4OUhVr3ZMfD/eYIuverB40MZzREO+QQe+pb5r3ZV9S4dJh7rGXAQFcX+xwQpNCN4V
         L53py2rNSFJAhL3LfGaxq/ZAxG+anp+d4DAu86lATKsCRv+o1V/v9gLFYLagnLOU/ryg
         oeYg==
X-Gm-Message-State: ACgBeo35TQutdBEb/aC8RZxij3XQjHZlzdQOd1Zxc2Uop1KR8MhpiY3P
        xBjdZTIMrra7Wpy+LM09b6s=
X-Google-Smtp-Source: AA6agR4XNILyDmhA4H93r36EStc4pdn2H4O+wBx1SYj6DQte+H+EQ4qnlK4lyFtM/wUGJPm7kNaj0Q==
X-Received: by 2002:a05:6512:b2a:b0:48a:2aaf:2ad3 with SMTP id w42-20020a0565120b2a00b0048a2aaf2ad3mr6943885lfu.552.1659954973745;
        Mon, 08 Aug 2022 03:36:13 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id b28-20020a19671c000000b0048afd0c496fsm1380504lfc.156.2022.08.08.03.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 03:36:13 -0700 (PDT)
Date:   Mon, 8 Aug 2022 13:36:10 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/17] dt-bindings: PCI: dwc: Add phys/phy-names
 common properties
Message-ID: <20220808103610.3mv3mzlbzlqz4itz@mobilestation>
References: <20220728143427.13617-1-Sergey.Semin@baikalelectronics.ru>
 <20220728143427.13617-4-Sergey.Semin@baikalelectronics.ru>
 <20220801175636.GA1234403-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801175636.GA1234403-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 01, 2022 at 11:56:36AM -0600, Rob Herring wrote:
> On Thu, Jul 28, 2022 at 05:34:13PM +0300, Serge Semin wrote:
> > It's normal to have the DW PCIe RP/EP DT-nodes equipped with the explicit
> > PHY phandle references. There can be up to 16 PHYs attach in accordance
> > with the maximum number of supported PCIe lanes. Let's extend the common
> > DW PCIe controller schema with the 'phys' and 'phy-names' properties
> > definition. The PHY names are defined with the regexp pattern
> > '^pcie([0-9]+|-?phy[0-9]*)?$' so to match the names currently supported by
> > the DW PCIe platform drivers ("pcie": meson; "pciephy": qcom, imx6;
> > "pcie-phy": uniphier, rockchip, spear13xx; "pcie": intel-gw; "pcie-phy%d":
> > keystone, dra7xx; "pcie": histb, etc). Though the "pcie%d" format would
> > the most preferable in this case.
> 

> No phy-names is my preference. Some string plus an index is utterly 
> pointless. Oh well...

Mine too, but we have no choice in this case since the named
PHY-properties support has already been advertised by the platform
drivers. This patch just provides the bindings for them. Just note
the string patterns have been designed in a way to match these bindings.

Anyway thanks for telling about the preferred option. Keeping that in
mind I won't have doubts what approach to select for the new
driver/bindings development.

> 
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Changelog v3:
> > - This is a new patch unpinned from the next one:
> >   https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
> >   by the Rob' request. (@Rob)
> > ---
> >  .../bindings/pci/snps,dw-pcie-common.yaml         | 15 +++++++++++++++
> >  .../devicetree/bindings/pci/snps,dw-pcie-ep.yaml  |  3 +++
> >  .../devicetree/bindings/pci/snps,dw-pcie.yaml     |  3 +++
> >  3 files changed, 21 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > index 3e992b653d12..627a5d6625ba 100644
> > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > @@ -17,6 +17,21 @@ description:
> >  select: false
> >  
> >  properties:
> > +  phys:
> > +    description:
> > +      There can be up to the number of possible lanes PHYs specified.
> 

> This needs something about being in order of lane number.

Ok.

> 
> > +      Obviously each specified PHY is supposed to be able to work in the
> > +      PCIe mode with a speed implied by the DWC PCIe controller it is
> > +      attached to.
> > +    minItems: 1
> > +    maxItems: 16
> > +
> > +  phy-names:
> > +    minItems: 1
> > +    maxItems: 16
> > +    items:
> > +      pattern: '^pcie([0-9]+|-?phy[0-9]*)?$'
> 

> Please comment here that pcie[0-9] is the preferred form.

What about a bit more sophisticated update?
phy-names:
  minItems: 1
  maxItems: 16
  oneOf:
    - items:
        pattern: '^pcie[0-9]+$'
    - deprecated: true
      items:
        pattern: '^pcie(-?phy[0-9]*)?$'

-Sergey

> 
> Rob
