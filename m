Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C0D58CBB8
	for <lists+linux-pci@lfdr.de>; Mon,  8 Aug 2022 17:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243790AbiHHP7O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Aug 2022 11:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243808AbiHHP7M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Aug 2022 11:59:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30C81580A;
        Mon,  8 Aug 2022 08:59:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 486B9B80FE4;
        Mon,  8 Aug 2022 15:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2583C4347C;
        Mon,  8 Aug 2022 15:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659974348;
        bh=CB8GEk6vrbmCRypZeJSBIKCFthK8v+Ye1fo/yFOFCnY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JJUUb6F6FbmPuI7Pkoevuis2N8VJzDGFDlKmrFe/6IkrTsAUyh3t3ozpYG3UAKuhU
         uNwhOsP5EG9aAzcDWtTUrGmDK/t+8/6lOhdFtYh3tKV5SIbuutqyUvVK/I+3lXmyII
         iG/UvtDPc28pCwT8Eq1tjhY2zwZbsXT3er4eMkSp8H9EOeC/knH1mEKc3SRnYYVm0S
         0U8ZTlEF7TX/ol8IbXXPQ0IKzmIVJVHT110O+YmFbVqhQN8WaxR3U6wv/WJjks/epD
         0wAF+rAcaL8OX4k1NyKymK8lXnm3ShISFWRt3l7A4WME1MA20h5/wAFy9GiCuy1uGG
         Z/VSmi2j28bAw==
Received: by mail-vs1-f41.google.com with SMTP id 67so1866546vsv.2;
        Mon, 08 Aug 2022 08:59:08 -0700 (PDT)
X-Gm-Message-State: ACgBeo35exy8iWdD5i4ilkZdgTzg9E4JFD4X6T6qwp9Wd0vyoNflo+me
        XasIcaMlhLbQAqT23bmH1cp+UMdJEQCxx8IpFQ==
X-Google-Smtp-Source: AA6agR7B/cC2PaD3jHCZZwdzxoo79bfvI7Uvngrp1T2ma4YJRXtUhqhJkTAenRqqzr9LWCVNQnoAnENr/fuMjInK2PE=
X-Received: by 2002:a67:a246:0:b0:388:7e82:1d80 with SMTP id
 t6-20020a67a246000000b003887e821d80mr6508681vsh.26.1659974347774; Mon, 08 Aug
 2022 08:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220728143427.13617-1-Sergey.Semin@baikalelectronics.ru>
 <20220728143427.13617-4-Sergey.Semin@baikalelectronics.ru>
 <20220801175636.GA1234403-robh@kernel.org> <20220808103610.3mv3mzlbzlqz4itz@mobilestation>
In-Reply-To: <20220808103610.3mv3mzlbzlqz4itz@mobilestation>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 8 Aug 2022 09:58:56 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+1FX2YtaQjQfvLhBN60yvRM7VF-bxL7+O7jtK0d9XZBA@mail.gmail.com>
Message-ID: <CAL_Jsq+1FX2YtaQjQfvLhBN60yvRM7VF-bxL7+O7jtK0d9XZBA@mail.gmail.com>
Subject: Re: [PATCH v4 03/17] dt-bindings: PCI: dwc: Add phys/phy-names common properties
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 8, 2022 at 4:36 AM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> On Mon, Aug 01, 2022 at 11:56:36AM -0600, Rob Herring wrote:
> > On Thu, Jul 28, 2022 at 05:34:13PM +0300, Serge Semin wrote:
> > > It's normal to have the DW PCIe RP/EP DT-nodes equipped with the explicit
> > > PHY phandle references. There can be up to 16 PHYs attach in accordance
> > > with the maximum number of supported PCIe lanes. Let's extend the common
> > > DW PCIe controller schema with the 'phys' and 'phy-names' properties
> > > definition. The PHY names are defined with the regexp pattern
> > > '^pcie([0-9]+|-?phy[0-9]*)?$' so to match the names currently supported by
> > > the DW PCIe platform drivers ("pcie": meson; "pciephy": qcom, imx6;
> > > "pcie-phy": uniphier, rockchip, spear13xx; "pcie": intel-gw; "pcie-phy%d":
> > > keystone, dra7xx; "pcie": histb, etc). Though the "pcie%d" format would
> > > the most preferable in this case.
> >
>
> > No phy-names is my preference. Some string plus an index is utterly
> > pointless. Oh well...
>
> Mine too, but we have no choice in this case since the named
> PHY-properties support has already been advertised by the platform
> drivers. This patch just provides the bindings for them. Just note
> the string patterns have been designed in a way to match these bindings.
>
> Anyway thanks for telling about the preferred option. Keeping that in
> mind I won't have doubts what approach to select for the new
> driver/bindings development.
>
> >
> > >
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > >
> > > ---
> > >
> > > Changelog v3:
> > > - This is a new patch unpinned from the next one:
> > >   https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
> > >   by the Rob' request. (@Rob)
> > > ---
> > >  .../bindings/pci/snps,dw-pcie-common.yaml         | 15 +++++++++++++++
> > >  .../devicetree/bindings/pci/snps,dw-pcie-ep.yaml  |  3 +++
> > >  .../devicetree/bindings/pci/snps,dw-pcie.yaml     |  3 +++
> > >  3 files changed, 21 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > > index 3e992b653d12..627a5d6625ba 100644
> > > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > > @@ -17,6 +17,21 @@ description:
> > >  select: false
> > >
> > >  properties:
> > > +  phys:
> > > +    description:
> > > +      There can be up to the number of possible lanes PHYs specified.
> >
>
> > This needs something about being in order of lane number.
>
> Ok.
>
> >
> > > +      Obviously each specified PHY is supposed to be able to work in the
> > > +      PCIe mode with a speed implied by the DWC PCIe controller it is
> > > +      attached to.
> > > +    minItems: 1
> > > +    maxItems: 16
> > > +
> > > +  phy-names:
> > > +    minItems: 1
> > > +    maxItems: 16
> > > +    items:
> > > +      pattern: '^pcie([0-9]+|-?phy[0-9]*)?$'
> >
>
> > Please comment here that pcie[0-9] is the preferred form.
>
> What about a bit more sophisticated update?
> phy-names:
>   minItems: 1
>   maxItems: 16
>   oneOf:
>     - items:
>         pattern: '^pcie[0-9]+$'
>     - deprecated: true
>       items:
>         pattern: '^pcie(-?phy[0-9]*)?$'

Sure.

Rob
