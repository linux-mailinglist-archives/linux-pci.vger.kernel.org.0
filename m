Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DF330D262
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 05:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhBCEPZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 23:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhBCEPW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Feb 2021 23:15:22 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEC7C061573
        for <linux-pci@vger.kernel.org>; Tue,  2 Feb 2021 20:14:42 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id l11so11079389qvt.1
        for <linux-pci@vger.kernel.org>; Tue, 02 Feb 2021 20:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u1Kmi6mnBkkCqSWXEJQ15LYAb6ytoT8kO+7cz71e1rU=;
        b=da6AATUe8y4TboRqC4zCieDv8D8OTBREivy/rggxnLrmM4ziQ7FHrIaC9xbR1/gg6b
         T2QplsYjhFngkMCxETRmRDh/+TpN7R0t24Lad14wuzuax/Di+7OfttDIADXD+QsfYaI6
         U0+nahdPRrKwTQF3SbyyONb6rncuE7am214uqugNs324lrx7TVD9MMv5VpmPsJsJB4rl
         IcfI1VUwSiM0KXr9Hq7HDhU0IDXi3E95taL5v7cTTQ6PRZI1Ki2y/9NHL0MWlrHeO4y8
         oL+iFyip3MeYsxKTfqaEaJkVnRUyE3gr9ijr+OLsbdUZulStbY0hJ7suCupZfEN9mGKF
         09Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u1Kmi6mnBkkCqSWXEJQ15LYAb6ytoT8kO+7cz71e1rU=;
        b=nwuiz9Dx8jSUT++i9wh+jZlkqpEiAuBad4JFTFlLCAalZBaiJsYsld8yGAfSb6KgU4
         GItte3mfjckEcgUaeWz+MfnBXtSq8z8gsFf79RkpOVXm7zFOpQ1X51dt82gASgIxcP/7
         k7qXwuKB1Ja3t4ckauBfbgk5mU+OvrKghH766uVnrAg1BRyaLODB7sOpQVKL3Ei+6hvP
         2xOwJNzeb9NsHsam92k+oDifdgEi2Fc1fXbEhR5Pmbkf1fw0gCvl25V//f2/buGTcbZx
         bHSBXUK7laD8ogtaUM3N22x3JiOWBobB5BgwG5G++xYNAZeemdes3FN8cmUDPy+vvC4n
         Qirg==
X-Gm-Message-State: AOAM530uzVpp3MN8kpU93w5OygLBtH/P+Nty6yY72YjDE8u+8xRR2hTX
        3PnqfNIhLfTfW8f61iiBZo9ogGN1RuM/MemRRU+GSg==
X-Google-Smtp-Source: ABdhPJxjosTt4MD6QbAu3MNnxE3G5OB3RpNdWyI4h5AYp07kKinJhX1QGim1Veu0tQDQNyij7ZBP8TFf51YhyE1Uj1g=
X-Received: by 2002:a0c:b912:: with SMTP id u18mr1348119qvf.2.1612325681056;
 Tue, 02 Feb 2021 20:14:41 -0800 (PST)
MIME-Version: 1.0
References: <da0ac373-4edb-0230-b264-49697fa3d86a@linaro.org>
 <20210129215024.GA113900@bjorn-Precision-5520> <CAA8EJpoPsv5tfsaiJq4UnBYt3o+gJanWzy8aaZRK=V8yOk3mJQ@mail.gmail.com>
 <YBTYKLi81Cf65yUB@builder.lan> <CAA8EJprwBKbGrh-BjrzkQTxoboUi470wYcn-gTBHdNQ1Af7DKA@mail.gmail.com>
 <YBmsjDiKnpQjYeQh@builder.lan> <CAL_JsqJoKEVUs0f7rP87M3Wh6yVvB-bYi7vBprti8hoim3-e-A@mail.gmail.com>
In-Reply-To: <CAL_JsqJoKEVUs0f7rP87M3Wh6yVvB-bYi7vBprti8hoim3-e-A@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 3 Feb 2021 07:14:30 +0300
Message-ID: <CAA8EJpq6A28RHSD7YVz_AAdWnnvtCEAh1XcPyUTu0Ufp67M1XA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] pcie-qcom: provide a way to power up qca6390 chip
 on RB5 platform
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Gross <agross@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 3 Feb 2021 at 00:37, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Feb 2, 2021 at 1:48 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Sat 30 Jan 10:14 CST 2021, Dmitry Baryshkov wrote:
> >
> > > On Sat, 30 Jan 2021 at 06:53, Bjorn Andersson
> > > <bjorn.andersson@linaro.org> wrote:
> > > >
> > > > On Fri 29 Jan 16:19 CST 2021, Dmitry Baryshkov wrote:
> > > >
> > > > > On Sat, 30 Jan 2021 at 00:50, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > >
> > > > > > On Fri, Jan 29, 2021 at 06:45:21AM +0300, Dmitry Baryshkov wrote:
> > > > > > > On 28/01/2021 22:26, Rob Herring wrote:
> > > > > > > > On Thu, Jan 28, 2021 at 11:52 AM Dmitry Baryshkov
> > > > > > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > Some Qualcomm platforms require to power up an external device before
> > > > > > > > > probing the PCI bus. E.g. on RB5 platform the QCA6390 WiFi/BT chip needs
> > > > > > > > > to be powered up before PCIe0 bus is probed. Add a quirk to the
> > > > > > > > > respective PCIe root bridge to attach to the power domain if one is
> > > > > > > > > required, so that the QCA chip is started before scanning the PCIe bus.
> > > > > > > >
> > > > > > > > This is solving a generic problem in a specific driver. It needs to be
> > > > > > > > solved for any PCI host and any device.
> > > > > > >
> > > > > > > Ack. I see your point here.
> > > > > > >
> > > > > > > As this would require porting code from powerpc/spark of-pci code and
> > > > > > > changing pcie port driver to apply power supply before bus probing happens,
> > > > > > > I'd also ask for the comments from PCI maintainers. Will that solution be
> > > > > > > acceptable to you?
> > > > > >
> > > > > > I can't say without seeing the code.  I don't know enough about this
> > > > > > scenario to envision how it might look.
> > > > > >
> > > > > > I guess the QCA6390 is a PCIe device?  Why does it need to be powered
> > > > > > up before probing?  Shouldn't we get a link-up interrupt when it is
> > > > > > powered up so we could probe it then?
> > > > >
> > > > > Not quite. QCA6390 is a multifunction device, with PCIe and serial
> > > > > parts. It has internal power regulators which once enabled will
> > > > > powerup the PCIe, serial and radio parts. There is no need to manage
> > > > > regulators. Once enabled they will automatically handle device
> > > > > suspend/resume, etc.
> > > > >
> > > >
> > > > So what you're saying is that if either the PCI controller or bluetooth
> > > > driver probes these regulators will be turned on, indefinitely?
> > > >
> > > > If so, why do we need a driver to turn them on, rather than just mark
> > > > them as always-on?
> > > >
> > > > What's the timing requirement wrt regulators vs WL_EN/BT_EN?
> > >
> > > According to the documentation I have, they must be enabled right
> > > after enabling powering the chip and they must stay enabled all the
> > > time.
> > >
> >
> > So presumably just marking these things always-on and flipping the GPIO
> > statically won't be good enough due to the lack of control over the
> > timing.
> >
> > This really do look like a simplified case of what we see with the
> > PCIe attached modems, where similar requirements are provided, but also
> > the ability to perform a device specific reset sequence in case the
> > hardware has locked up. I'm slightly worried about the ability of
> > extending your power-domain model to handle the restart operation
> > though.
>
> I think this is an abuse of 'power-domains'. Just define the
> regulators in both WiFi and BT nodes and have each driver enable them.

I think it is too late to enable regulators in the WiFi driver. Even
if I modify the/pci code to register devices basing on the OF nodes
(like we do for PPC and Sparc), necessary link training/hotplug
handling should happen outside of the WiFi driver.

> They're refcounted. If that's still not enough control over the power
> sequencing, then create a 3rd entity to do it, but that doesn't need
> to leak into DT. You already have all the information you need.

From my point of view the proposed design (with three nodes) exactly
represents the hardware: the power-handling part, the WiFi part and
the BT part. If you don't like the power domains, would regulators be
better from your point of view? The "power" device providing a
regulator to be used by the child nodes. For the BT part the regulator
is fine, while for the WiFi...

The major problem with regulators in this case is that they are
typically enabled by the device driver itself, rather than by parent
device/bus code. And in the WiFi driver case the WiFi chip should be
already up and running before probing the ath11k driver.

Maybe it would still be better to take a step back and just introduce
'vcc-child-supply' entry to the pcie-qcom device tree node or to the
PCIe bridge node? This would also cover cases of PCIe mezzanine boards
when the on-mezzanine devices are visible through the PCIe bus, but
the mezzanine is powered by a separate voltage regulator. It would not
be possible to describe child devices in the device tree node, but
rather it would be possible to describe that there might be devices
behind the PCIe bridge, they must be powered on using a referenced
regulator. This starts to sound like a kind of PCI hotplug.

This would result in the following nodes:

pcie0: pci@1c0000 {
   compatible = "qcom,pcie-sm8250";
   [....]
   bridge@0,0 {
        compatible = "pci17cb,010b", "linux,regulator-hotplug";
        [....]
        vcc-children-supply = <&qca6390>;
        /* known WiFi card */
   };
};

pce1: pci@1c08000 {
   compatible = "qcom,pcie-sm8250";
   [....]
   bridge@1,0 {
        compatible = "pci17cb,010b", "linux,regulator-hotplug";
        [....]
        vcc-children-supply = <&vdc_gpio13>;
        /* unpredictable devices on the mezzanine card */
   };
};

-- 
With best wishes
Dmitry
