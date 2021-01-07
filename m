Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96A52EE8BE
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 23:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbhAGWcJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 17:32:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:42896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbhAGWcI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Jan 2021 17:32:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E84223609;
        Thu,  7 Jan 2021 22:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610058687;
        bh=xqP7nlN10qlLZWYC6/slW68hsvWo6XqMEBM86vXA8PE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SEtDWiETVgcWKJelDtg/DLCmeXACklrk2otAdX9sTUYhhWvnOEPEmr698f2skfryg
         4bF7SzGoXHwoLXAQY1kt2u5Vtnsyw5bzwBNQNwTE/r0w8XopBfZ8dQHtdz+JKC7XWK
         33DZZWTgUENvFkX6zUBo1tOJqbPE4CZMu+knqNoQgGPDAVVP46e0doY8t8gp0FwMK6
         JGR4hR4fpNWG/mwhAtJXw6c0C8/qu0xZFl9hSsobUmX1n5nULwaICDX1G5sX6z4OJo
         Ujmx3RZXCnrymIDmgUmadIKku4LqSxZcH5m7LwUjPKg5scsT2iQGsNwDVzmmix0QE6
         8hrQc9gSa3N4g==
Received: by mail-ej1-f46.google.com with SMTP id lt17so11970896ejb.3;
        Thu, 07 Jan 2021 14:31:27 -0800 (PST)
X-Gm-Message-State: AOAM5307d4FQAWYI7VxDLFcyFPE5AOL59+A65BA7AwGbSQ3bw5Dma8A2
        mRqhym6abDGcM/hHnc96qjE5nzpzhSNvZw+N8g==
X-Google-Smtp-Source: ABdhPJxnu6dyOFmZT8UWWTmOntUJrh4NuvNqwX+ajT8EPvM5XfOIQFMoxWh7cN1XA2tLvNXzv8+fT+OgRjTVfE2v4+E=
X-Received: by 2002:a17:906:1197:: with SMTP id n23mr684003eja.359.1610058685598;
 Thu, 07 Jan 2021 14:31:25 -0800 (PST)
MIME-Version: 1.0
References: <20201130211145.3012-1-james.quinlan@broadcom.com>
 <20201130211145.3012-2-james.quinlan@broadcom.com> <20201209140122.GA331678@robh.at.kernel.org>
 <CANCKTBsFALwF8Hy-=orH8D-nd-qyXqFDopATmKCvbqPbUTC7Sw@mail.gmail.com>
In-Reply-To: <CANCKTBsFALwF8Hy-=orH8D-nd-qyXqFDopATmKCvbqPbUTC7Sw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 7 Jan 2021 15:31:13 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKPKk3cPO8DG3FQVSHrKnO+Zed1R=PV7n7iAC+qJKgHcw@mail.gmail.com>
Message-ID: <CAL_JsqKPKk3cPO8DG3FQVSHrKnO+Zed1R=PV7n7iAC+qJKgHcw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: PCI: Add bindings for Brcmstb EP
 voltage regulators
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 4, 2021 at 3:12 PM Jim Quinlan <jim2101024@gmail.com> wrote:
>
> On Wed, Dec 9, 2020 at 10:07 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Nov 30, 2020 at 04:11:38PM -0500, Jim Quinlan wrote:
> > > Quite similar to the regulator bindings found in "rockchip-pcie-host.txt",
> > > this allows optional regulators to be attached and controlled by the
> > > PCIe RC driver.
> > >
> > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > ---
> > >  .../devicetree/bindings/pci/brcm,stb-pcie.yaml       | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > index 807694b4f41f..baacc3d7ec87 100644
> > > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > @@ -85,6 +85,18 @@ properties:
> > >        minItems: 1
> > >        maxItems: 3
> > >
> > > +  vpcie12v-supply:
> > > +    description: 12v regulator phandle for the endpoint device
> > > +
> > > +  vpcie3v3-supply:
> > > +    description: 3.3v regulator phandle for the endpoint device
> >
> > 12V and 3.3V are standard slot supplies, can you add them to
> > pci-bus.yaml. Then some day maybe we can have common slot handling code.
> >
> > With that, here you just need:
> >
> > vpcie3v3-supply: true
>
> Hi Rob,
>
> Sorry for the delay in responding -- I just came back from vacation.

NP, me too.

> The problem we have is that these regulators are not "slot" supplies
> -- our HW does not support PCI slots, so if and when general slot
> power-handling code came along it would probably screw us up.   If you
> don't think there is a problem then I will submit the two supply-names
> you OKed, even though they may not match the voltages we are using for
> the EPs.

Maybe no slots, but you defined the voltages here and they look like
standard voltages. Given this is at least the 2nd usage of these
properties, it seemed like they should be common. Slot or no physical
slot.

> For us, the supplies are for the EP chip's power.  We have the PCIe
> controller turning them "on" for power-on/resume and "off" for
> power-off/suspend.  We need the "xxx-supply" property in the
> controller's DT node because of the chicken-and-egg situation: if the
> property was in the EP's DT node, the RC  will never discover the EP
> to see that there is a regulator to turn on.   We would be happy with
> a single supply name, something like "ep-power".  We would be ecstatic
> to have two (ep0-power, ep1-power).

The chicken-and-egg problem is nothing new. The same thing has come up
for USB, MDIO, MMC/SD to name a few. If devices on a discoverable bus
are not discoverable, then they need to be described in DT. I've given
suggestions many times how to fix the kernel side.

As Mark said, there's no reason you can't look at other nodes for your
data. The data a driver needs isn't always nicely packaged up into a
single node. The DT structure should match the h/w. The EP is a
different device from the PCI host and its supplies belong in its
node.

Not that if we really wanted to have complete slot support, we'd
probably end up having slot nodes in DT. That's generally where we've
ended up at for other cases.

Now there's a second problem here. If this is not standard PCIe rails
which have a defined power sequencing, then you really need to
describe the EP device in DT. Otherwise, we don't know what the power
sequencing is. I will reject any properties such as delays which try
to poorly describe power sequencing in DT.

>
> I'm not sure if you remember but FlorianF talked to you about this
> situation and concluded that something like the above was the way to
> go forward.

Unless it was last week, assume I don't remember.

>  For the latest pullreq I  just copied Rockchip's bindings
> since you reviewed their bindings commit but it looks like you've
> changed your mind.

Well, no. First, it takes more than one to see a pattern. So yes, how
we describe something might evolve. Second, I didn't ask for anything
different from Rockchip here. Just move what Rockchip had to a common
location to reuse. But your reply has convinced me you need an EP
node.

>   Given the constraints I have described, what is
> the best path forward?
>
> Thanks,
> Jim Quinlan
> Broadcom STB
> >
> > > +
> > > +  vpcie1v8-supply:
> > > +    description: 1.8v regulator phandle for the endpoint device
> > > +
> > > +  vpcie0v9-supply:
> > > +    description: 0.9v regulator phandle for the endpoint device
> >
> > These are not standard. They go to a soldered down device or
> > non-standard connector? For the former, the device should really be
> > described in DT and the supplies added there.
> >
> > Mini PCIe connector also has 1.5V supply.
> >
> > Rob
