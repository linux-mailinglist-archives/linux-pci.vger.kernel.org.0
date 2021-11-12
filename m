Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E9444EE37
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 21:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhKLU7b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 15:59:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:55898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232902AbhKLU7a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Nov 2021 15:59:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53ADD61054;
        Fri, 12 Nov 2021 20:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636750599;
        bh=rzDM62qKUHovQU+MhdVK8d0HgV8lWhPkzWsz2/o9QJc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JmMLeas7ZzygNSJGZRtIeB2WG6WWDiLY3qJYG4ORcnn9gQvKXbTgxuK8Omz/SirEY
         oM6oNbiZjCwCSYeXBI6rKrDHWQZvyoLb7iP+MaTsCApaJJUweTo9o4J0fEX7b3z/U+
         TRVtCWMHxAbADMGgz2T5VgCFzvHu0gHje9byzTFBp2cnf8P19TMstMo8cUVs5bMnvy
         Wj0M89Jmj+tOeOj1GHlYdeFKd7c7RNmhlhM+Zjr8URIF1noERaqdCtETvvk4gfYGAr
         wp/xn2CTcE91NM9MiWWVQ8LMYNYbL5Wt0SmmwE55XwWZRBfj9PVgty5M9x10Nwm3hQ
         BoVBXpVWPg0NQ==
Received: by mail-ed1-f54.google.com with SMTP id b15so42425518edd.7;
        Fri, 12 Nov 2021 12:56:39 -0800 (PST)
X-Gm-Message-State: AOAM5338KyeBRgNkqr3mam0ldMsOuYXhFd9/vuRL+BPKX64yElEUGxpw
        WoaTmfNBXCV7xMqwZIuXdZLXKD+qgFrbqAa5vA==
X-Google-Smtp-Source: ABdhPJyypORhRapjTj1CCJprTyCdzV3vHgZynh25QQfmnHCI4VZ4gdDlaKe4SURbrxJy/nJ6PXpXnQIcsba7VADfWko=
X-Received: by 2002:a17:907:a411:: with SMTP id sg17mr22531942ejc.84.1636750597802;
 Fri, 12 Nov 2021 12:56:37 -0800 (PST)
MIME-Version: 1.0
References: <20211031150706.27873-1-kabel@kernel.org> <YY6HYM4T+A+tm85P@robh.at.kernel.org>
 <20211112153208.s4nuckz7js4fipce@pali> <CAL_JsqJ+FYFFcDEm-_Ow=9TERhhEMVKm3OCHyDdGo02onK7dmg@mail.gmail.com>
 <20211112171249.46xmj5zo3svm4qn2@pali>
In-Reply-To: <20211112171249.46xmj5zo3svm4qn2@pali>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 12 Nov 2021 14:56:26 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+0ByuPqGw0L94qJktMy+J2XyGUQ1ZRjkBoMGX+ggBizw@mail.gmail.com>
Message-ID: <CAL_Jsq+0ByuPqGw0L94qJktMy+J2XyGUQ1ZRjkBoMGX+ggBizw@mail.gmail.com>
Subject: Re: [PATCH dt + pci 1/2] dt-bindings: Add 'slot-power-limit-milliwatt'
 PCIe port property
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        devicetree@vger.kernel.org, PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 12, 2021 at 11:12 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Friday 12 November 2021 10:30:01 Rob Herring wrote:
> > On Fri, Nov 12, 2021 at 9:32 AM Pali Roh=C3=A1r <pali@kernel.org> wrote=
:
> > >
> > > On Friday 12 November 2021 09:25:20 Rob Herring wrote:
> > > > On Sun, Oct 31, 2021 at 04:07:05PM +0100, Marek Beh=C3=BAn wrote:
> > > > > +   If present, this property specifies slot power limit in milli=
watts. Host
> > > > > +   drivers can parse this property and use it for programming Ro=
ot Port or host
> > > > > +   bridge, or for composing and sending PCIe Set_Slot_Power_Limi=
t messages
> > > > > +   through the Root Port or host bridge when transitioning PCIe =
link from a
> > > > > +   non-DL_Up Status to a DL_Up Status.
> > > >
> > > > If your slots are behind a switch, then doesn't this apply to any b=
ridge
> > > > port?
> > >
> > > The main issue here is that pci.txt (and also scheme on github) is
> > > mixing host bridge and root ports into one node. This new property
> > > should be defined at the same place where is supports-clkreq or
> > > reset-gpios, as it belongs to them.
> >
> > Unfortunately that ship has already sailed. So we can split things up,
> > but we still have to allow for the existing cases. I'm happy to take
> > changes splitting up pci-bus.yaml to 2 or 3 schemas (host bridge,
> > root-port, and PCI(e)-PCI(e) bridge?).
>
> Well, no problem. I just need to know how you want to handle backward
> compatibility definitions in YAML. Because it is possible via versioning
> (like in JSONSchema-like structures in OpenAPI versioning) or via

Got a pointer to that?

> deprecated attributes or via defining two schemas (one strict and one
> loose)... There are lot of options and I saw all these options in
> different projects which use YAML or JSON.

The short answer is we don't have a defined way beyond deprecating
properties within a given binding with 'deprecated: true'. The only
versioning we have ATM is the kernel requires a minimum version of
dtschema (which we'll have to bump for all this).

We could have something like:

old-pci-bridge.yaml:
  allOf:
    - $ref: pci-host-bridge.yaml#
    - $ref: pcie-port.yaml#

new-pci-bridge.yaml:
  allOf:
    - $ref: pci-host-bridge.yaml#
  properties:
    pci@0:
      $ref: pcie-port.yaml#

And then both of the above schemas will have $ref to a pci-bridge.yaml
schema which should be most of pci-bus.yaml. linux,pci-domain and
dma-ranges? go to pci-host-bridge.yaml. max-link-speed, num-lanes,
reset-gpios, slot-power-limit-milliwatt, and the pending supply
additions (Broadcom) go to pcie-port.yaml.

> I did not know about github repository, I always looked at schemas and
> definitions only in linux kernel tree and external files which were
> mentioned in kernel tree.
>
> Something I wrote in my RFC email, but I wrote this email patch...
> https://lore.kernel.org/linux-pci/20211023144252.z7ou2l2tvm6cvtf7@pali/

I think we're pretty much in alignment. Look at the Broadcom portdrv
changes proposed if you haven't already. It's all interrelated.

Rob
