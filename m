Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886D346DE53
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 23:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbhLHW0c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 17:26:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44708 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbhLHW0b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 17:26:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 311A4B8228D;
        Wed,  8 Dec 2021 22:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2345C341CC;
        Wed,  8 Dec 2021 22:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639002176;
        bh=eKFpyZC9BLvX9lVOCVzTFYu6b4aRhjKeW09ndCoDaCQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ev2xuooFgb69FmD7whpWXaPm0KWu6Cve7QUSR+Ie//5dYyRb8B7a2tIKS6zcVxkbo
         2dWLTSem+a8m7AS4SSthCAc7sjW76wInQtk4Sv6Mx3ClklEtFTSZ/tohvSn2FGTV/L
         Bf8lQkqfEnxplOQ/heoJy8Mt+1QvC8woT4dBjdeZkHegdNDLRx2NDCLJGqcx3bO7ns
         Nd2BzH/dklX5K0M9LgLC9JqBD7MOC38N6VShkAmGcDoF7KUm7DfmNb9nqqGgtpwpuW
         7f/JtzvB1V2MQOZjTWK1ml7PUzENfi+bTI46xBHx6grNvE2ydyyyqNdVIGNmEPRuED
         cK7T/ck8Gyv2Q==
Received: by mail-ed1-f46.google.com with SMTP id r25so13256456edq.7;
        Wed, 08 Dec 2021 14:22:56 -0800 (PST)
X-Gm-Message-State: AOAM533TwoaSU3JxEGLI8dB5oL9l55r4As+lKKBwZgTrAdpWY/Y2CW0G
        EIsW9J1bTex+7xIPy1XygZYHlqkHgm3eeN+PNw==
X-Google-Smtp-Source: ABdhPJxHHdaNJfvFi0sI/HjOkrWBWisEFUIu9ryX5hwydJP/Y5X5tZvxQ+QXhTZZyza5lIuAtjB5Y1K6ou/+yx97mFI=
X-Received: by 2002:aa7:dc07:: with SMTP id b7mr22707726edu.327.1639002175205;
 Wed, 08 Dec 2021 14:22:55 -0800 (PST)
MIME-Version: 1.0
References: <20211208040432.3658355-1-f.fainelli@gmail.com>
 <20211208040432.3658355-7-f.fainelli@gmail.com> <1638971068.781821.3857737.nullmailer@robh.at.kernel.org>
 <536cbdb6-a541-2f86-faa6-acb1a4e1c173@gmail.com> <CAL_JsqKVnX554xD4bNXk2KsWP2kXR7Lv33Q=7qMvY_gXiEAcWA@mail.gmail.com>
In-Reply-To: <CAL_JsqKVnX554xD4bNXk2KsWP2kXR7Lv33Q=7qMvY_gXiEAcWA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 8 Dec 2021 16:22:43 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL=M299E4jh6FxuE_TSHK4=71Pt4kc=3nbNj5TpRcsZjA@mail.gmail.com>
Message-ID: <CAL_JsqL=M299E4jh6FxuE_TSHK4=71Pt4kc=3nbNj5TpRcsZjA@mail.gmail.com>
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

On Wed, Dec 8, 2021 at 4:21 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Dec 8, 2021 at 11:32 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> > On 12/8/21 5:44 AM, Rob Herring wrote:
> > > On Tue, 07 Dec 2021 20:04:32 -0800, Florian Fainelli wrote:
> > >> Conver the iProc PCIe controller Device Tree binding to YAML now that
> > >> all DTS in arch/arm and arch/arm64 have been fixed to be compliant.
> > >>
> > >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > >> ---
> > >>  .../bindings/pci/brcm,iproc-pcie.txt          | 133 -------------
> > >>  .../bindings/pci/brcm,iproc-pcie.yaml         | 176 ++++++++++++++++++
> > >>  2 files changed, 176 insertions(+), 133 deletions(-)
> > >>  delete mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> > >>  create mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
> > >>
> > >
> > > Running 'make dtbs_check' with the schema in this patch gives the
> > > following warnings. Consider if they are expected or the schema is
> > > incorrect. These may not be new warnings.
> > >
> > > Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> > > This will change in the future.
> > >
> > > Full log is available here: https://patchwork.ozlabs.org/patch/1565076
> > >
> > >
> > > pcie@18012000: msi-controller: 'oneOf' conditional failed, one must be fixed:
> > >       arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dt.yaml
> > >       arch/arm/boot/dts/bcm911360_entphn.dt.yaml
> > >       arch/arm/boot/dts/bcm911360k.dt.yaml
> > >       arch/arm/boot/dts/bcm958300k.dt.yaml
> > >       arch/arm/boot/dts/bcm958305k.dt.yaml
> > >       arch/arm/boot/dts/bcm958522er.dt.yaml
> > >       arch/arm/boot/dts/bcm958525er.dt.yaml
> > >       arch/arm/boot/dts/bcm958525xmc.dt.yaml
> > >       arch/arm/boot/dts/bcm958622hr.dt.yaml
> > >       arch/arm/boot/dts/bcm958623hr.dt.yaml
> > >       arch/arm/boot/dts/bcm958625hr.dt.yaml
> > >       arch/arm/boot/dts/bcm958625k.dt.yaml
> > >       arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dt.yaml
> > >       arch/arm/boot/dts/bcm958625-meraki-mx64.dt.yaml
> > >       arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dt.yaml
> > >       arch/arm/boot/dts/bcm958625-meraki-mx64w.dt.yaml
> > >       arch/arm/boot/dts/bcm958625-meraki-mx65.dt.yaml
> > >       arch/arm/boot/dts/bcm958625-meraki-mx65w.dt.yaml
> > >       arch/arm/boot/dts/bcm988312hr.dt.yaml
> >
> > Those would mean that the binding patch was applied without the DTS
> > patches earlier in the series?
>
> Right. I generally don't look at dts patches, but I did look at these
> and don't see how this one is fixed (nor caused):

Note that unevaluatedProperties is only enabled in the dtschema main branch.

Rob
