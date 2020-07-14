Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431BD2200F9
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 01:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgGNXS3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 19:18:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbgGNXS2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jul 2020 19:18:28 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8583D2074B;
        Tue, 14 Jul 2020 23:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594768707;
        bh=WbHcOuCS+rj4obHCGdLyDlzJy258Ll6RBipsjc9gqhs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OTYv7SW64RJ7rcBLNLixgDhz1BOtm1ZlPfGu0RW7CKMz/+ee2kQZnsPya33XRsqSZ
         NSY9JKrQ2FHqtYIo/G1nklBOWhlXLpB3Bb80i2eXAScH3Qkvmz4gkSVFZ3xyOmHSB2
         fS1zjaVyGJOhZPsVcQWQD09xHBVeLAHPlnAO/7HE=
Received: by mail-ot1-f47.google.com with SMTP id h13so68081otr.0;
        Tue, 14 Jul 2020 16:18:27 -0700 (PDT)
X-Gm-Message-State: AOAM531sTp1Rzu6UUNRYLmVqQbl0CpurZMh5yerLiQhkx5Ucm1Hde/hl
        nUGH9qkEQoMlwdLXNKEmpqSFXENueBn9VUlgcQ==
X-Google-Smtp-Source: ABdhPJzamyUgo6UiqW59FuZ+b+pvPCuOFw/T+vorF7nM8Yc7QjaPRAdppkgkTdGO/rge6EQOKevq7Mn09VhM3JKnhr0=
X-Received: by 2002:a9d:4002:: with SMTP id m2mr6332092ote.129.1594768706856;
 Tue, 14 Jul 2020 16:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200612171334.26385-1-nsaenzjulienne@suse.de>
 <20200612171334.26385-2-nsaenzjulienne@suse.de> <20200713182356.GA413630@bogus>
 <ed42e27eaf48fd19cc8ccccd15b0b25ba1d836ae.camel@suse.de> <20200714210708.GA2897216@bogus>
 <925bab2c-91e0-bf60-9ec4-286eb53f72ab@gmail.com>
In-Reply-To: <925bab2c-91e0-bf60-9ec4-286eb53f72ab@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 14 Jul 2020 17:18:15 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+BvM+Z_QNkB47_8AQzZ6R3LOCjNWd5MA-9avxp0HHG2w@mail.gmail.com>
Message-ID: <CAL_Jsq+BvM+Z_QNkB47_8AQzZ6R3LOCjNWd5MA-9avxp0HHG2w@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] dt-bindings: reset: Add a binding for the RPi
 Firmware reset controller
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Eric Anholt <eric@anholt.net>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, tim.gover@raspberrypi.org,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 14, 2020 at 3:18 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 7/14/2020 2:07 PM, Rob Herring wrote:
> > On Tue, Jul 14, 2020 at 01:59:21PM +0200, Nicolas Saenz Julienne wrote:
> >> On Mon, 2020-07-13 at 12:23 -0600, Rob Herring wrote:
> >>> On Fri, Jun 12, 2020 at 07:13:25PM +0200, Nicolas Saenz Julienne wrote:
> >>>> The firmware running on the RPi VideoCore can be used to reset and
> >>>> initialize HW controlled by the firmware.
> >>>>
> >>>> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> >>>> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> >>>>
> >>>> ---
> >>>> Changes since v2:
> >>>>  - Add include file for reset IDs
> >>>>
> >>>> Changes since v1:
> >>>>  - Correct cells binding as per Florian's comment
> >>>>  - Change compatible string to be more generic
> >>>>
> >>>>  .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 21 +++++++++++++++++++
> >>>>  .../reset/raspberrypi,firmware-reset.h        | 13 ++++++++++++
> >>>>  2 files changed, 34 insertions(+)
> >>>>  create mode 100644 include/dt-bindings/reset/raspberrypi,firmware-reset.h
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-
> >>>> firmware.yaml
> >>>> b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-
> >>>> firmware.yaml
> >>>> index b48ed875eb8e..23a885af3a28 100644
> >>>> --- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-
> >>>> firmware.yaml
> >>>> +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-
> >>>> firmware.yaml
> >>>> @@ -39,6 +39,22 @@ properties:
> >>>>        - compatible
> >>>>        - "#clock-cells"
> >>>>
> >>>> +  reset:
> >>>
> >>> I'm not really thrilled how this is evolving with a node per provider.
> >>> There's no reason you can't just add #clock-cells and #reset-cells to
> >>> the parent firmware node.
> >>
> >> What are the downsides? The way I see it there is not much difference. And this
> >> way of handling things is feels more intuitive and flexible (overlays can
> >> control what to enable easily, we can take advantage of the platform device
> >> core).
> >
> > What the OS wants can evolve, so designing around the current needs of
> > the OS is not how bindings should be done.
> >
> > Using overlays to add clocks or resets wouldn't really work given they
> > are spread out over the tree. And with clocks in particular, you'd have
> > to replace dummy fixed clocks with actual firmware clocks. Sounds
> > fragile and messy...
> >
> >>> I probably should have complained with the clocks node, but that's only
> >>> pending for 5.9.
> >>
> >> Note that there are more users for this pattern: "raspberrypi,firmware-ts" and
> >> "raspberrypi,firmware-gpio". Actually you were the one to originally propose
> >> this it[1]. :P
> >
> > Sigh, this is why I dislike incomplete examples...
> >
> > Based on that,
> >
> > Acked-by: Rob Herring <robh@kernel.org>
> >
> > And please get gpio and ts converted to schema and referenced here
> > before the next time I look at this.
> >
> >> There already is a fair amount of churn in these drivers because of all the DT
> >> changes we did in the past, and if we need to change how we integrate these
> >> again, I'd really like it to be for good.
> >>
> >>> The bigger issue is this stuff is just trickling in one bit at a time
> >>> which gives no context for review. What's next? Is it really a mystery
> >>> as to what functions the firmware provides?
> >>
> >> We have no control over it, RPi engineers integrate new designs and new
> >> firmware interfaces show up. This is a good example of it.
> >>
> >> I proposed them to use SCMI as it covers most of what they are already
> >> providing here. But no luck so far.
> >
> > Once we get tired of supporting all the different firmware interfaces
> > and the mess they become, we'll just have to start refusing custom ones.
> > Worked for PSCI.
>
> In this particular case, the Raspberry Pi Foundation VPU firmware should
> just implement SCMI and that would avoid having to write new client
> drivers for Linux, it is not clear to me why this has not been done yet.

Writing drivers is fun?

Perhaps we should start refusing new firmware interfaces now.

Rob
