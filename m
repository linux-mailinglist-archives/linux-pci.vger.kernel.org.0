Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E044A46DE4F
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 23:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241061AbhLHWZO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 17:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbhLHWZM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 17:25:12 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD40CC061746;
        Wed,  8 Dec 2021 14:21:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 99BEBCE23FC;
        Wed,  8 Dec 2021 22:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960A3C341C7;
        Wed,  8 Dec 2021 22:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639002095;
        bh=uY69kx1ohR33mjesg1ELzGH6hZScHfy0RsrVOFhyAVg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tjSKpqb4Cq9tQhlTKBBG49xxV+5ungHLpAJCON62/mxxy808hNF/wVfs42iKfv0iB
         lyZpzI6hOcMg4V1ouncT5y5Kto4UNm61f7R4QE2pUksQmGDgRi40HsVJ8eL9e+K6we
         3nMGG8QB/62te4/4FBIK7eqiONeqAml2aKoiJtCeF2vrIw0oeHbzmvtCpQ721ggEsX
         s3Pv5v+K2oBdY/6/id6PC4Naty5YcthKX/mjzzXIZC2IIo1kmk07ONS7xe9gXUQuo1
         V+xyjj2VhZjxo1IsvBpl/RGrWTXcT7ANHIDdu69iNvf0cvzRfS+3kXGj+/9QWncbCO
         nyAS4TeVFFt9Q==
Received: by mail-ed1-f52.google.com with SMTP id y13so13185524edd.13;
        Wed, 08 Dec 2021 14:21:35 -0800 (PST)
X-Gm-Message-State: AOAM533MT+vqtoWk5L5HYsxkkHMYCbmletb8SUZdjF8iQ1HaR9Bh6+1Z
        7x/BIkKSJaowCRqmAVGvDo7l4XBQg1Yw+x91lw==
X-Google-Smtp-Source: ABdhPJyp8J2S/aCjidvVlJ1VYH6a2RdUrCwZZcMHnQL388eyM1TL0jyUufgWRIWJEb1BKWZxV3LwiUpCKzT3N+ftEnY=
X-Received: by 2002:a17:907:7f25:: with SMTP id qf37mr10629594ejc.147.1639002093894;
 Wed, 08 Dec 2021 14:21:33 -0800 (PST)
MIME-Version: 1.0
References: <20211208040432.3658355-1-f.fainelli@gmail.com>
 <20211208040432.3658355-7-f.fainelli@gmail.com> <1638971068.781821.3857737.nullmailer@robh.at.kernel.org>
 <536cbdb6-a541-2f86-faa6-acb1a4e1c173@gmail.com>
In-Reply-To: <536cbdb6-a541-2f86-faa6-acb1a4e1c173@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 8 Dec 2021 16:21:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKVnX554xD4bNXk2KsWP2kXR7Lv33Q=7qMvY_gXiEAcWA@mail.gmail.com>
Message-ID: <CAL_JsqKVnX554xD4bNXk2KsWP2kXR7Lv33Q=7qMvY_gXiEAcWA@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] dt-bindings: pci: Convert iProc PCIe to YAML
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Ray Jui <rjui@broadcom.com>, devicetree@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Scott Branden <sbranden@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 8, 2021 at 11:32 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 12/8/21 5:44 AM, Rob Herring wrote:
> > On Tue, 07 Dec 2021 20:04:32 -0800, Florian Fainelli wrote:
> >> Conver the iProc PCIe controller Device Tree binding to YAML now that
> >> all DTS in arch/arm and arch/arm64 have been fixed to be compliant.
> >>
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >> ---
> >>  .../bindings/pci/brcm,iproc-pcie.txt          | 133 -------------
> >>  .../bindings/pci/brcm,iproc-pcie.yaml         | 176 ++++++++++++++++++
> >>  2 files changed, 176 insertions(+), 133 deletions(-)
> >>  delete mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> >>  create mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
> >>
> >
> > Running 'make dtbs_check' with the schema in this patch gives the
> > following warnings. Consider if they are expected or the schema is
> > incorrect. These may not be new warnings.
> >
> > Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> > This will change in the future.
> >
> > Full log is available here: https://patchwork.ozlabs.org/patch/1565076
> >
> >
> > pcie@18012000: msi-controller: 'oneOf' conditional failed, one must be fixed:
> >       arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dt.yaml
> >       arch/arm/boot/dts/bcm911360_entphn.dt.yaml
> >       arch/arm/boot/dts/bcm911360k.dt.yaml
> >       arch/arm/boot/dts/bcm958300k.dt.yaml
> >       arch/arm/boot/dts/bcm958305k.dt.yaml
> >       arch/arm/boot/dts/bcm958522er.dt.yaml
> >       arch/arm/boot/dts/bcm958525er.dt.yaml
> >       arch/arm/boot/dts/bcm958525xmc.dt.yaml
> >       arch/arm/boot/dts/bcm958622hr.dt.yaml
> >       arch/arm/boot/dts/bcm958623hr.dt.yaml
> >       arch/arm/boot/dts/bcm958625hr.dt.yaml
> >       arch/arm/boot/dts/bcm958625k.dt.yaml
> >       arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dt.yaml
> >       arch/arm/boot/dts/bcm958625-meraki-mx64.dt.yaml
> >       arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dt.yaml
> >       arch/arm/boot/dts/bcm958625-meraki-mx64w.dt.yaml
> >       arch/arm/boot/dts/bcm958625-meraki-mx65.dt.yaml
> >       arch/arm/boot/dts/bcm958625-meraki-mx65w.dt.yaml
> >       arch/arm/boot/dts/bcm988312hr.dt.yaml
>
> Those would mean that the binding patch was applied without the DTS
> patches earlier in the series?

Right. I generally don't look at dts patches, but I did look at these
and don't see how this one is fixed (nor caused):

pcie@18012000: Unevaluated properties are not allowed
('linux,pci-domain', 'bus-range', '#address-cells', '#size-cells',
'device_type' were unexpected)
        arch/arm/boot/dts/bcm911360_entphn.dt.yaml
        arch/arm/boot/dts/bcm911360k.dt.yaml
        arch/arm/boot/dts/bcm958300k.dt.yaml
        arch/arm/boot/dts/bcm958305k.dt.yaml
