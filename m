Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E033F9EB1
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 20:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhH0SXJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 14:23:09 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:60399 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhH0SXJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Aug 2021 14:23:09 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id d0378d57;
        Fri, 27 Aug 2021 20:22:17 +0200 (CEST)
Date:   Fri, 27 Aug 2021 20:22:17 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     devicetree@vger.kernel.org, kettenis@openbsd.org,
        tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        marcan@marcan.st, bhelgaas@google.com, jim2101024@gmail.com,
        nsaenz@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        daire.mcnamara@microchip.com, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
In-Reply-To: <YSkn1bMU/xkl2P7e@rosenzweig.io> (message from Alyssa Rosenzweig
        on Fri, 27 Aug 2021 17:58:45 +0000)
Subject: Re: [PATCH v4 3/4] dt-bindings: pci: Add DT bindings for apple,pcie
References: <20210827171534.62380-1-mark.kettenis@xs4all.nl>
 <20210827171534.62380-4-mark.kettenis@xs4all.nl> <YSkn1bMU/xkl2P7e@rosenzweig.io>
Message-ID: <5614206085195f47@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Date: Fri, 27 Aug 2021 17:58:45 +0000
> From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> 
> > +#  msi-ranges:
> > +#    description:
> > +#      A list of pairs <intid span>, where "intid" is the first
> > +#      interrupt number that can be used as an MSI, and "span" the size
> > +#      of that range.
> > +#    $ref: /schemas/types.yaml#/definitions/phandle-array
> 
> Comment intended?

Hmm, no.  I commented it out here in the process of moving it to the
new MSI controller binding schema.  And then forgot about it.  I
suspect I'll need a v5 of the series anyway so I'll fix it there.
