Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A33421FF8F
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 23:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgGNVHM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 17:07:12 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:45095 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbgGNVHL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2020 17:07:11 -0400
Received: by mail-il1-f193.google.com with SMTP id o3so28430ilo.12;
        Tue, 14 Jul 2020 14:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=44rgaqhFkzmsZwbVO86LUWD8tYa+oZDKAUnPu8DtF0A=;
        b=obyH1Wp8YCGaEV/1EhBs5wXCpuYHcJ8+/XgClIxH2yTWpF1UTSQ66pmkvIUHz2BRSa
         +NNwLC3pOetrscJ+6JIKGWMOa+H9CRkM/aq63yDZZIuW884piqWfvWgicizmNhREURkp
         7QWIwpIU2px1xqSQAFj1j1cGxilXpr+dUWY3IS+mce4bWYurOQpQDPfotbtkXXjaVWqs
         YSXWIA6wSCiWYEpxAQwxunbErBMNgmB6GvmylZsxisfss8jkZojk5rLzgbn/vCbjRiL7
         0bwptpWKrHnVESj2dndSXVyVYqe+rL9eQR2wGUnfTJeymFD53EuAGO9YIBi1XeLzXBYf
         K5JQ==
X-Gm-Message-State: AOAM532MplrqRt+Ywfzx+4ye8EMxT+HoFyEgq/mjd2p9MoCvUUOjAMqO
        Tx4XJwqAFz2sZHGrMyBwHw==
X-Google-Smtp-Source: ABdhPJwRUCmm6JdxtWi64zjLurr/8NPWpWA7Tt02AKgPi/2ixQ9QM1CkDUriigx8+xKYEukMuEniJQ==
X-Received: by 2002:a92:c530:: with SMTP id m16mr6856827ili.300.1594760830527;
        Tue, 14 Jul 2020 14:07:10 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id w82sm52739ili.42.2020.07.14.14.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:07:09 -0700 (PDT)
Received: (nullmailer pid 2917820 invoked by uid 1000);
        Tue, 14 Jul 2020 21:07:08 -0000
Date:   Tue, 14 Jul 2020 15:07:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>, linux-usb@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        andy.shevchenko@gmail.com, mathias.nyman@linux.intel.com,
        lorenzo.pieralisi@arm.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/9] dt-bindings: reset: Add a binding for the RPi
 Firmware reset controller
Message-ID: <20200714210708.GA2897216@bogus>
References: <20200612171334.26385-1-nsaenzjulienne@suse.de>
 <20200612171334.26385-2-nsaenzjulienne@suse.de>
 <20200713182356.GA413630@bogus>
 <ed42e27eaf48fd19cc8ccccd15b0b25ba1d836ae.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed42e27eaf48fd19cc8ccccd15b0b25ba1d836ae.camel@suse.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 14, 2020 at 01:59:21PM +0200, Nicolas Saenz Julienne wrote:
> On Mon, 2020-07-13 at 12:23 -0600, Rob Herring wrote:
> > On Fri, Jun 12, 2020 at 07:13:25PM +0200, Nicolas Saenz Julienne wrote:
> > > The firmware running on the RPi VideoCore can be used to reset and
> > > initialize HW controlled by the firmware.
> > > 
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> > > 
> > > ---
> > > Changes since v2:
> > >  - Add include file for reset IDs
> > > 
> > > Changes since v1:
> > >  - Correct cells binding as per Florian's comment
> > >  - Change compatible string to be more generic
> > > 
> > >  .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 21 +++++++++++++++++++
> > >  .../reset/raspberrypi,firmware-reset.h        | 13 ++++++++++++
> > >  2 files changed, 34 insertions(+)
> > >  create mode 100644 include/dt-bindings/reset/raspberrypi,firmware-reset.h
> > > 
> > > diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-
> > > firmware.yaml
> > > b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-
> > > firmware.yaml
> > > index b48ed875eb8e..23a885af3a28 100644
> > > --- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-
> > > firmware.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-
> > > firmware.yaml
> > > @@ -39,6 +39,22 @@ properties:
> > >        - compatible
> > >        - "#clock-cells"
> > >  
> > > +  reset:
> > 
> > I'm not really thrilled how this is evolving with a node per provider. 
> > There's no reason you can't just add #clock-cells and #reset-cells to 
> > the parent firmware node.
> 
> What are the downsides? The way I see it there is not much difference. And this
> way of handling things is feels more intuitive and flexible (overlays can
> control what to enable easily, we can take advantage of the platform device
> core).

What the OS wants can evolve, so designing around the current needs of 
the OS is not how bindings should be done.

Using overlays to add clocks or resets wouldn't really work given they 
are spread out over the tree. And with clocks in particular, you'd have 
to replace dummy fixed clocks with actual firmware clocks. Sounds 
fragile and messy...

> > I probably should have complained with the clocks node, but that's only 
> > pending for 5.9.
> 
> Note that there are more users for this pattern: "raspberrypi,firmware-ts" and
> "raspberrypi,firmware-gpio". Actually you were the one to originally propose
> this it[1]. :P

Sigh, this is why I dislike incomplete examples...

Based on that,

Acked-by: Rob Herring <robh@kernel.org>

And please get gpio and ts converted to schema and referenced here 
before the next time I look at this.

> There already is a fair amount of churn in these drivers because of all the DT
> changes we did in the past, and if we need to change how we integrate these
> again, I'd really like it to be for good.
> 
> > The bigger issue is this stuff is just trickling in one bit at a time 
> > which gives no context for review. What's next? Is it really a mystery 
> > as to what functions the firmware provides?
> 
> We have no control over it, RPi engineers integrate new designs and new
> firmware interfaces show up. This is a good example of it.
> 
> I proposed them to use SCMI as it covers most of what they are already
> providing here. But no luck so far.

Once we get tired of supporting all the different firmware interfaces 
and the mess they become, we'll just have to start refusing custom ones. 
Worked for PSCI.

> > You don't have to have a driver in place for every function.
> 
> I see your point, it could be more monolithic, that said, having a driver is
> essential. See the reverts I managed to pull off at the end of the series.
> 
> [1] https://patchwork.kernel.org/patch/10166783/#21421571
> 


