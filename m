Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C4C2EA07C
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jan 2021 00:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbhADXLI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 18:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbhADXLH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jan 2021 18:11:07 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0B0C061798;
        Mon,  4 Jan 2021 15:10:27 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 15so20053735pgx.7;
        Mon, 04 Jan 2021 15:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EYAJw8Jkvja+H1Il8/QPXasuWT7ihY2NKiRrqtBOYhE=;
        b=EU5+/zGNmLnazQA00lsreeF6e96nhloc9kjJsUKo8E/DTlNFb0JRYaFHJjx6u9ddti
         FwqvdB6Xvthg9H/YqdGepIIBfz0D6R9C6iOmvQ8IE4Q5XgANE+Qkjg6B9oWr59qAxspx
         vKQVpTeVpW4R4JdnyJxJqaqvohWttvBuUZOEoQKw+tdv0zm35/rVqkPayVxEaFcCu1wa
         brt6yRGZwvIs5usqik4vzNqwH0W7k1qXK5MYHmFAWxIWPODCyyUMsDvsM4FEQ/sf8sLD
         1GjLNCDXSiJe4TRkKbletoYiMJ12E+Qszh4wFRlZ4YvoaCUj6+TuvVBaYi2oUq2To5Ej
         spOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EYAJw8Jkvja+H1Il8/QPXasuWT7ihY2NKiRrqtBOYhE=;
        b=jyZzDZ4uM1cDzA721EHJ0i7kIwDUkHXU+KM4GdYWgiKzDP+iB8B/mwoESpZnet4/+K
         I0KZKkZsrEhApbRjFmJfEhGjjztR0vvihTvLqb5kgHwq/18oYzoRbrMkfZNS1kaDptaU
         lWDI/qxYd9yzjLzk/ANuwaOz1Sx4pBgtdoU3Lz/llyMDO4lh5YlwTL4h7N8g5lqHwggW
         f/J3f4OjaLRd33YQh5nqaKtnrKHOt+ww23aGJb0olEIcAmmKi+aVasJQ7MbuFJ63N+QT
         SKV6gT+2W/66uhz8Pip6lGsDWYeVl8E2aJzUCCNaNRaZv/USMA7foYjN3w63DJN9mGpA
         kmNg==
X-Gm-Message-State: AOAM533hzsa3SCzI54jH5BRvnFNbeoVuM8nq81ERY3d5PJuFdGbn+Xmw
        t2r6uibukVA7ltGblofon0k2ozPBnrHujrgA4LQ/6NRiZPU=
X-Google-Smtp-Source: ABdhPJyJfVFDpPQdGreIkx4Ux4Fdc/NG4LPonPnhtJzwAMlrvPqb9aPgh89Pcasw6Ty/qu3PnqG0fjgZQBwhcwc+67g=
X-Received: by 2002:a63:fc42:: with SMTP id r2mr54405755pgk.234.1609798342739;
 Mon, 04 Jan 2021 14:12:22 -0800 (PST)
MIME-Version: 1.0
References: <20201130211145.3012-1-james.quinlan@broadcom.com>
 <20201130211145.3012-2-james.quinlan@broadcom.com> <20201209140122.GA331678@robh.at.kernel.org>
In-Reply-To: <20201209140122.GA331678@robh.at.kernel.org>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Mon, 4 Jan 2021 17:12:11 -0500
Message-ID: <CANCKTBsFALwF8Hy-=orH8D-nd-qyXqFDopATmKCvbqPbUTC7Sw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: PCI: Add bindings for Brcmstb EP
 voltage regulators
To:     Rob Herring <robh@kernel.org>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        broonie@kernel.org,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 9, 2020 at 10:07 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Nov 30, 2020 at 04:11:38PM -0500, Jim Quinlan wrote:
> > Quite similar to the regulator bindings found in "rockchip-pcie-host.txt",
> > this allows optional regulators to be attached and controlled by the
> > PCIe RC driver.
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > ---
> >  .../devicetree/bindings/pci/brcm,stb-pcie.yaml       | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > index 807694b4f41f..baacc3d7ec87 100644
> > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > @@ -85,6 +85,18 @@ properties:
> >        minItems: 1
> >        maxItems: 3
> >
> > +  vpcie12v-supply:
> > +    description: 12v regulator phandle for the endpoint device
> > +
> > +  vpcie3v3-supply:
> > +    description: 3.3v regulator phandle for the endpoint device
>
> 12V and 3.3V are standard slot supplies, can you add them to
> pci-bus.yaml. Then some day maybe we can have common slot handling code.
>
> With that, here you just need:
>
> vpcie3v3-supply: true

Hi Rob,

Sorry for the delay in responding -- I just came back from vacation.

The problem we have is that these regulators are not "slot" supplies
-- our HW does not support PCI slots, so if and when general slot
power-handling code came along it would probably screw us up.   If you
don't think there is a problem then I will submit the two supply-names
you OKed, even though they may not match the voltages we are using for
the EPs.

For us, the supplies are for the EP chip's power.  We have the PCIe
controller turning them "on" for power-on/resume and "off" for
power-off/suspend.  We need the "xxx-supply" property in the
controller's DT node because of the chicken-and-egg situation: if the
property was in the EP's DT node, the RC  will never discover the EP
to see that there is a regulator to turn on.   We would be happy with
a single supply name, something like "ep-power".  We would be ecstatic
to have two (ep0-power, ep1-power).

I'm not sure if you remember but FlorianF talked to you about this
situation and concluded that something like the above was the way to
go forward.  For the latest pullreq I  just copied Rockchip's bindings
since you reviewed their bindings commit but it looks like you've
changed your mind.   Given the constraints I have described, what is
the best path forward?

Thanks,
Jim Quinlan
Broadcom STB
>
> > +
> > +  vpcie1v8-supply:
> > +    description: 1.8v regulator phandle for the endpoint device
> > +
> > +  vpcie0v9-supply:
> > +    description: 0.9v regulator phandle for the endpoint device
>
> These are not standard. They go to a soldered down device or
> non-standard connector? For the former, the device should really be
> described in DT and the supplies added there.
>
> Mini PCIe connector also has 1.5V supply.
>
> Rob
