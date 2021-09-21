Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F4C41393D
	for <lists+linux-pci@lfdr.de>; Tue, 21 Sep 2021 19:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhIURxv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Sep 2021 13:53:51 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:51995 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhIURxv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Sep 2021 13:53:51 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id eddbe515;
        Tue, 21 Sep 2021 19:52:18 +0200 (CEST)
Date:   Tue, 21 Sep 2021 19:52:18 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, alyssa@rosenzweig.io,
        kettenis@openbsd.org, tglx@linutronix.de, maz@kernel.org,
        marcan@marcan.st, bhelgaas@google.com, jim2101024@gmail.com,
        nsaenz@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        daire.mcnamara@microchip.com, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
In-Reply-To: <YS6cEkDn5IAVW/xQ@robh.at.kernel.org> (message from Rob Herring
        on Tue, 31 Aug 2021 16:16:02 -0500)
Subject: Re: [PATCH v4 2/4] dt-bindings: interrupt-controller: msi: Add
 msi-ranges property
References: <20210827171534.62380-1-mark.kettenis@xs4all.nl>
 <20210827171534.62380-3-mark.kettenis@xs4all.nl> <YS6cEkDn5IAVW/xQ@robh.at.kernel.org>
Message-ID: <56147407e10f61cb@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Date: Tue, 31 Aug 2021 16:16:02 -0500
> From: Rob Herring <robh@kernel.org>
> 
> On Fri, Aug 27, 2021 at 07:15:27PM +0200, Mark Kettenis wrote:
> > From: Mark Kettenis <kettenis@openbsd.org>
> > 
> > Update the MSI controller binding to add an msi-ranges property
> > that specifies how MSIs map onto regular interrupts on some other
> > interrupt controller.
> > 
> > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> > ---
> >  .../bindings/interrupt-controller/msi-controller.yaml     | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml b/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
> > index 5ed6cd46e2e0..bf8b8a7dba09 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
> > @@ -31,4 +31,12 @@ properties:
> >        Identifies the node as an MSI controller.
> >      $ref: /schemas/types.yaml#/definitions/flag
> >  
> > +  msi-ranges:
> > +    description:
> > +      A list of pairs <intid span>, where "intid" is the specification
> 
> It's not really 'pairs' and 'interrupt specifier' is the terminology the 
> spec uses. How about:
> 
> A list of <phandle intspec span>, where "phandle" is parent interrupt 
> controller, "intspec" is the starting/base interrupt specifier, and 
> "span" is the size of that range (typically multiples of 32).
> 
> The 'multiples of 32' part is what Marc told me.

Thanks Rob!  That sounds good.  But 32 is what's typical for the Apple
hardware, and I expect that different hardware that might use this
property will use a different value, so I left that last bit out.  I
also kept the bit that states that multiple ranges are allowed.

> > +      of the first interrupt (including the phandle for the interrupt
> > +      controller) that can be used as an MSI, and "span" the size of
> > +      that range. Multiple ranges can be provided.
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +
> >  additionalProperties: true
> > -- 
> > 2.32.0
> > 
> > 
> 
