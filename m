Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DC22FD27E
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jan 2021 15:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731723AbhATOTL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jan 2021 09:19:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:37710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387660AbhATORV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Jan 2021 09:17:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B45522080D;
        Wed, 20 Jan 2021 14:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611152200;
        bh=ndpmiwAKrdUHGxid8tW9786YKK4wnnB3+ULujE6LZqM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EQYi3fCVs7SGzhO7nuaPbsVifu0OiB7XpazThXZjR4DV7l7swhsM4C67V2lGm9CBk
         lUJI+YOvxc6/XKKxJk1oHM/Z+JJbNEHhPHbmPMtDUMeXpsHw4e7cJpE9oAAaNItc+A
         Qav9O8jl8UotSakMF3k2hqo1AUaBVLHF+ZXgyN76f0cKULdEri4RaP4cy92dK6AOhN
         jqZrf8sfqkzGTAzefXhR8jF2SkRn/lo9+H6Sw7xZw7xI1p2JL/vknSKVtoVoBncbxe
         GQTisu5i+Qy/3Ncs35O9mfxuUaUBwdMB+ygiA4qfu/h+8++ktsv6j40zMRaScMh0ZG
         7ya2c5E6drCnA==
Received: by mail-ed1-f43.google.com with SMTP id g1so25271121edu.4;
        Wed, 20 Jan 2021 06:16:39 -0800 (PST)
X-Gm-Message-State: AOAM530kbGuukMyLOyeMuu+PEmGsCYpmvfAiQQSm+wOEZTqUKSC6224B
        XAWHo1W3tuvzxQIcM/JQj8YWABOYT5ceI+j99g==
X-Google-Smtp-Source: ABdhPJwSt06b9pOrIcgBBFL8fiaiPdePUCBH58SZ+9qnWmdaJJtjskAp3/8ErXHotmxAPn1+2+9tRrR5CxpbVTz1eRE=
X-Received: by 2002:a50:e78b:: with SMTP id b11mr7486457edn.165.1611152198216;
 Wed, 20 Jan 2021 06:16:38 -0800 (PST)
MIME-Version: 1.0
References: <20210118091739.247040-1-xxm@rock-chips.com> <20210118091739.247040-2-xxm@rock-chips.com>
 <e143ad9e-1cfd-e59d-0079-513c036981ba@gmail.com> <2336601.uoxibFcf9D@diego>
 <677c102d-0b9b-1a12-0ac6-4dd0a1023b68@gmail.com> <c9ff67c7-ca1d-d4a6-aef5-4c75688ed6d3@arm.com>
In-Reply-To: <c9ff67c7-ca1d-d4a6-aef5-4c75688ed6d3@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 20 Jan 2021 08:16:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK=roMm7vb=WAcLUsiru5qwFg=Sc_po1gD8oJu=JipZbg@mail.gmail.com>
Message-ID: <CAL_JsqK=roMm7vb=WAcLUsiru5qwFg=Sc_po1gD8oJu=JipZbg@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: rockchip: Add DesignWare based PCIe controller
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Johan Jonker <jbx6244@gmail.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Simon Xue <xxm@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 19, 2021 at 12:40 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-01-19 15:11, Johan Jonker wrote:
> > Hi Simon, Heiko,
> >
> > On 1/19/21 2:14 PM, Heiko St=C3=BCbner wrote:
> >> Hi Johan,
> >>
> >> Am Dienstag, 19. Januar 2021, 14:07:41 CET schrieb Johan Jonker:
> >>> Hi Simon,
> >>>
> >>> Thank you for this patch for rk3568 pcie.
> >>>
> >>> Include the Rockchip device tree maintainer and all other people/list=
s
> >>> to the CC list.
> >>>
> >>> ./scripts/checkpatch.pl --strict <patch1> <patch2>
> >>>
> >>>   ./scripts/get_maintainer.pl --noroles --norolestats --nogit-fallbac=
k
> >>> --nogit <patch1> <patch2>
> >>>
> >>> git send-email --suppress-cc all --dry-run --annotate --to
> >>> heiko@sntech.de --cc <..> <patch1> <patch2>
> >>>
> >>> This SoC has no support in mainline linux kernel yet.
> >>> In all the following yaml documents for rk3568 we need headers with
> >>> defines for clocks and power domains, etc.
> >>>
> >>> For example:
> >>> #include <dt-bindings/clock/rk3568-cru.h>
> >>> #include <dt-bindings/power/rk3568-power.h>
> >>>
> >>> Could Rockchip submit first clocks and power drivers entries and a ba=
sic
> >>> rk3568.dtsi + evb dts?
> >>> Include a patch to this serie with 3 pcie nodes added to rk3568.dtsi.
> >>>
> >>> A dtbs_check only works with a complete dtsi and evb dts.
> >>>
> >>> make ARCH=3Darm64 dtbs_check
> >>> DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/pci/rockchip-dw-p=
cie.yaml
> >>>
> >>> On 1/18/21 10:17 AM, Simon Xue wrote:
> >>>> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> >>>> ---
> >>>>   .../bindings/pci/rockchip-dw-pcie.yaml        | 101 ++++++++++++++=
++++
> >>>>   1 file changed, 101 insertions(+)
> >>>>   create mode 100644 Documentation/devicetree/bindings/pci/rockchip-=
dw-pcie.yaml
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.=
yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> >>>> new file mode 100644
> >>>> index 000000000000..fa664cfffb29
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> >>>> @@ -0,0 +1,101 @@
> >>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>>> +%YAML 1.2
> >>>> +---
> >>>> +$id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
> >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>> +
> >>>> +title: DesignWare based PCIe RC controller on Rockchip SoCs
> >>>> +
> >>>
> >>>> +maintainers:
> >>>> +  - Shawn Lin <shawn.lin@rock-chips.com>
> >>>> +  - Simon Xue <xxm@rock-chips.com>
> >>>
> >>> maintainers:
> >>>    - Heiko Stuebner <heiko@sntech.de>
> >>>
> >>> Add only people with maintainer rights.
> >>
> >> I'd disagree on this ;-)
> >
> > All roads leads to Heiko... ;)
> >
> > It takes long term commitment.
> > Year in, year out.
> > Keeping yourself up to date with the latest pcei development.
> > Communicate in English.
> > Be able to submit patches without errors... ;)
> > Review other peoples patches.
> > Respond in short time.
> > Bug fixing.
>
> Crikey, it's only a DT binding... :/
>
> > If that's what you really want, then you must include a patch to this
> > serie for MAINTAINERS.
>
> I think if Bjorn and Lorenzo want a specifically named sub-maintainer
> for the driver itself, we can let them say so rather than presume.

For the binding it's my call. :)

This should be someone who cares and knows the h/w. IOW, if I want to
delete the binding, someone who will object.

Of course, I'd like that someone to have all the above qualities too.

Rob
