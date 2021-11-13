Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B2C44F2D0
	for <lists+linux-pci@lfdr.de>; Sat, 13 Nov 2021 12:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbhKMLeC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 Nov 2021 06:34:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:49344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235645AbhKMLeA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 13 Nov 2021 06:34:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BA17610A1;
        Sat, 13 Nov 2021 11:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636803068;
        bh=XD9U/1UlQ6iSuhkw4eiK4tnbUtH1nThZThfSxL7aWn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H4LU1sgyhBT5JLHGo8LaR0CtYpEy6aI4hSTvLabIJI9B5KHEReKADes5gbIUxDoB6
         UHALvNA5cLAazZThIovEwUebFzEp5p9ZLULFF9kIuHYL/7j/rlWxssRX6zLDiZG53m
         w4V5SKJzc4j75Q9SdYnxCFQ7foj1TvaO6Wrmnn6GDQNR8Je11F4WTn6vYh1AaPx1Sf
         ZVk0HRQr5zgr/GWfvdrDKO9lp3qSEIR39J8o0vwsoT5moWymYUr7RzL+/LNyWv8obK
         yx+G8zmqPmDV3nzgJcwHEQEfOZq06LLWPoLQqDIbDj8m2svBHoi4LN0+JUOU1yYXjw
         +P1XH1rwqy/8w==
Received: by pali.im (Postfix)
        id 45A81819; Sat, 13 Nov 2021 12:31:06 +0100 (CET)
Date:   Sat, 13 Nov 2021 12:31:06 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        devicetree@vger.kernel.org, PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH dt + pci 1/2] dt-bindings: Add
 'slot-power-limit-milliwatt' PCIe port property
Message-ID: <20211113113106.a3ludtlycnrmbvnh@pali>
References: <20211031150706.27873-1-kabel@kernel.org>
 <YY6HYM4T+A+tm85P@robh.at.kernel.org>
 <20211112153208.s4nuckz7js4fipce@pali>
 <CAL_JsqJ+FYFFcDEm-_Ow=9TERhhEMVKm3OCHyDdGo02onK7dmg@mail.gmail.com>
 <20211112171249.46xmj5zo3svm4qn2@pali>
 <CAL_Jsq+0ByuPqGw0L94qJktMy+J2XyGUQ1ZRjkBoMGX+ggBizw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+0ByuPqGw0L94qJktMy+J2XyGUQ1ZRjkBoMGX+ggBizw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 12 November 2021 14:56:26 Rob Herring wrote:
> On Fri, Nov 12, 2021 at 11:12 AM Pali Rohár <pali@kernel.org> wrote:
> >
> > On Friday 12 November 2021 10:30:01 Rob Herring wrote:
> > > On Fri, Nov 12, 2021 at 9:32 AM Pali Rohár <pali@kernel.org> wrote:
> > > >
> > > > On Friday 12 November 2021 09:25:20 Rob Herring wrote:
> > > > > On Sun, Oct 31, 2021 at 04:07:05PM +0100, Marek Behún wrote:
> > > > > > +   If present, this property specifies slot power limit in milliwatts. Host
> > > > > > +   drivers can parse this property and use it for programming Root Port or host
> > > > > > +   bridge, or for composing and sending PCIe Set_Slot_Power_Limit messages
> > > > > > +   through the Root Port or host bridge when transitioning PCIe link from a
> > > > > > +   non-DL_Up Status to a DL_Up Status.
> > > > >
> > > > > If your slots are behind a switch, then doesn't this apply to any bridge
> > > > > port?
> > > >
> > > > The main issue here is that pci.txt (and also scheme on github) is
> > > > mixing host bridge and root ports into one node. This new property
> > > > should be defined at the same place where is supports-clkreq or
> > > > reset-gpios, as it belongs to them.
> > >
> > > Unfortunately that ship has already sailed. So we can split things up,
> > > but we still have to allow for the existing cases. I'm happy to take
> > > changes splitting up pci-bus.yaml to 2 or 3 schemas (host bridge,
> > > root-port, and PCI(e)-PCI(e) bridge?).
> >
> > Well, no problem. I just need to know how you want to handle backward
> > compatibility definitions in YAML. Because it is possible via versioning
> > (like in JSONSchema-like structures in OpenAPI versioning) or via
> 
> Got a pointer to that?

I'm not sure which pointer you want. OpenAPI is used for defining
application APIs which use either JSON or YAML (or something other)
content over HTTP protocol. Specification of OpenAPI is here:

https://swagger.io/specification/

Lot of times API schemas are written in YAML format (even when API
content is JSON) and OpenAPI uses JSONSchema-like schemas (at least in
version 3.0, they are not same as JSONSchema, it is some subset with own
extensions) and looks very similar to DT schemas.

> > deprecated attributes or via defining two schemas (one strict and one
> > loose)... There are lot of options and I saw all these options in
> > different projects which use YAML or JSON.
> 
> The short answer is we don't have a defined way beyond deprecating
> properties within a given binding with 'deprecated: true'.

Is there any formal definition what this 'deprecated: true' means? It
throw some warning during validation? Or it is disallowed to use
deprecated properties in newly written DTS files? Or it is just a
syntax decorator without any semantic meaning?

> The only
> versioning we have ATM is the kernel requires a minimum version of
> dtschema (which we'll have to bump for all this).
> 
> We could have something like:
> 
> old-pci-bridge.yaml:
>   allOf:
>     - $ref: pci-host-bridge.yaml#
>     - $ref: pcie-port.yaml#
> 
> new-pci-bridge.yaml:
>   allOf:
>     - $ref: pci-host-bridge.yaml#
>   properties:
>     pci@0:
>       $ref: pcie-port.yaml#
> 
> And then both of the above schemas will have $ref to a pci-bridge.yaml
> schema which should be most of pci-bus.yaml. linux,pci-domain and
> dma-ranges? go to pci-host-bridge.yaml. max-link-speed, num-lanes,
> reset-gpios, slot-power-limit-milliwatt, and the pending supply
> additions (Broadcom) go to pcie-port.yaml.

This looks like a nice solution.

I would propose just one other thing: Do not allow new kernel drivers
to use old-pci-bridge.yaml schema, so new drivers would not use old
"deprecated" APIs...

So should I prepare some schemas and send it for review via github pull
request mechanism? (I'm not sure how is that github project related to
kernel DTS bindings and how is reviewing on it going...)

> > I did not know about github repository, I always looked at schemas and
> > definitions only in linux kernel tree and external files which were
> > mentioned in kernel tree.
> >
> > Something I wrote in my RFC email, but I wrote this email patch...
> > https://lore.kernel.org/linux-pci/20211023144252.z7ou2l2tvm6cvtf7@pali/
> 
> I think we're pretty much in alignment. Look at the Broadcom portdrv
> changes proposed if you haven't already. It's all interrelated.

Do you have link to DTS file, how it looks like in real usage?
