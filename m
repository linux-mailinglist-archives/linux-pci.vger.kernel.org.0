Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C231A2FD44F
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jan 2021 16:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbhATPiu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 20 Jan 2021 10:38:50 -0500
Received: from gloria.sntech.de ([185.11.138.130]:60590 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390174AbhATOz0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Jan 2021 09:55:26 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1l2EsV-0001oX-0b; Wed, 20 Jan 2021 15:54:35 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>, Simon Xue <xxm@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH 2/3] dt-bindings: rockchip: Add DesignWare based PCIe controller
Date:   Wed, 20 Jan 2021 15:54:34 +0100
Message-ID: <3792680.3daJWjYHZt@diego>
In-Reply-To: <CAL_JsqK=roMm7vb=WAcLUsiru5qwFg=Sc_po1gD8oJu=JipZbg@mail.gmail.com>
References: <20210118091739.247040-1-xxm@rock-chips.com> <c9ff67c7-ca1d-d4a6-aef5-4c75688ed6d3@arm.com> <CAL_JsqK=roMm7vb=WAcLUsiru5qwFg=Sc_po1gD8oJu=JipZbg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Mittwoch, 20. Januar 2021, 15:16:25 CET schrieb Rob Herring:
> On Tue, Jan 19, 2021 at 12:40 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 2021-01-19 15:11, Johan Jonker wrote:
> > > Hi Simon, Heiko,
> > >
> > > On 1/19/21 2:14 PM, Heiko Stübner wrote:
> > >> Hi Johan,
> > >>
> > >> Am Dienstag, 19. Januar 2021, 14:07:41 CET schrieb Johan Jonker:
> > >>> Hi Simon,
> > >>>
> > >>> Thank you for this patch for rk3568 pcie.
> > >>>
> > >>> Include the Rockchip device tree maintainer and all other people/lists
> > >>> to the CC list.
> > >>>
> > >>> ./scripts/checkpatch.pl --strict <patch1> <patch2>
> > >>>
> > >>>   ./scripts/get_maintainer.pl --noroles --norolestats --nogit-fallback
> > >>> --nogit <patch1> <patch2>
> > >>>
> > >>> git send-email --suppress-cc all --dry-run --annotate --to
> > >>> heiko@sntech.de --cc <..> <patch1> <patch2>
> > >>>
> > >>> This SoC has no support in mainline linux kernel yet.
> > >>> In all the following yaml documents for rk3568 we need headers with
> > >>> defines for clocks and power domains, etc.
> > >>>
> > >>> For example:
> > >>> #include <dt-bindings/clock/rk3568-cru.h>
> > >>> #include <dt-bindings/power/rk3568-power.h>
> > >>>
> > >>> Could Rockchip submit first clocks and power drivers entries and a basic
> > >>> rk3568.dtsi + evb dts?
> > >>> Include a patch to this serie with 3 pcie nodes added to rk3568.dtsi.
> > >>>
> > >>> A dtbs_check only works with a complete dtsi and evb dts.
> > >>>
> > >>> make ARCH=arm64 dtbs_check
> > >>> DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > >>>
> > >>> On 1/18/21 10:17 AM, Simon Xue wrote:
> > >>>> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> > >>>> ---
> > >>>>   .../bindings/pci/rockchip-dw-pcie.yaml        | 101 ++++++++++++++++++
> > >>>>   1 file changed, 101 insertions(+)
> > >>>>   create mode 100644 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > >>>>
> > >>>> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > >>>> new file mode 100644
> > >>>> index 000000000000..fa664cfffb29
> > >>>> --- /dev/null
> > >>>> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > >>>> @@ -0,0 +1,101 @@
> > >>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > >>>> +%YAML 1.2
> > >>>> +---
> > >>>> +$id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
> > >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > >>>> +
> > >>>> +title: DesignWare based PCIe RC controller on Rockchip SoCs
> > >>>> +
> > >>>
> > >>>> +maintainers:
> > >>>> +  - Shawn Lin <shawn.lin@rock-chips.com>
> > >>>> +  - Simon Xue <xxm@rock-chips.com>
> > >>>
> > >>> maintainers:
> > >>>    - Heiko Stuebner <heiko@sntech.de>
> > >>>
> > >>> Add only people with maintainer rights.
> > >>
> > >> I'd disagree on this ;-)
> > >
> > > All roads leads to Heiko... ;)
> > >
> > > It takes long term commitment.
> > > Year in, year out.
> > > Keeping yourself up to date with the latest pcei development.
> > > Communicate in English.
> > > Be able to submit patches without errors... ;)
> > > Review other peoples patches.
> > > Respond in short time.
> > > Bug fixing.
> >
> > Crikey, it's only a DT binding... :/
> >
> > > If that's what you really want, then you must include a patch to this
> > > serie for MAINTAINERS.
> >
> > I think if Bjorn and Lorenzo want a specifically named sub-maintainer
> > for the driver itself, we can let them say so rather than presume.
> 
> For the binding it's my call. :)
> 
> This should be someone who cares and knows the h/w. IOW, if I want to
> delete the binding, someone who will object.
>
> Of course, I'd like that someone to have all the above qualities too.

I guess that would be separate entites then ...

Shawn and Simon know the hardware way better, though I'm not sure if their
work commitments will allow them to keep track of binding deletions

So maybe all 3 of us ;-)

Heiko


