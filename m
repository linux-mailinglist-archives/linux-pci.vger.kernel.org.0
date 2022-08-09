Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A95F58DAD9
	for <lists+linux-pci@lfdr.de>; Tue,  9 Aug 2022 17:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241787AbiHIPMt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Aug 2022 11:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiHIPMq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Aug 2022 11:12:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14275C54;
        Tue,  9 Aug 2022 08:12:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0BC36122D;
        Tue,  9 Aug 2022 15:12:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11484C433B5;
        Tue,  9 Aug 2022 15:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660057964;
        bh=hpr5ncI+B3Zk5lb6IfcPnPBbi/9BzktMcVJlUZHBj4c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QrbA0PBjazR7jAKkBh9YNESdmzoRsWOufqfgetk20DYoQ+uXYGwAgXhpkQiGt7HO0
         BiM+VP0M8Z9Fg8O7tcw8U4RfOxEqddTZFIwUXT/s9CG2Hdx6fSrCeRfK50GWSor6jK
         y0AI9Jr4ozCWTNccB6jkbDqsRDw/LiMn2ZxtJTBTKc1e5Yg0iELoWBRK0X2R/NKYQU
         8fZiW1lOjZFr61cdWct8bzgOVRpLVCy2vdsKfyAb9CPDoP8f8TJpkWAf5sBZKmYMVR
         l8etJ1i0za2xP3junYVcWkVS7IPbQ8HJccucUq0/qGskB6lzo6s+gOi8veEcaF510A
         UvjDgCJlT5KZg==
Received: by mail-vs1-f52.google.com with SMTP id d126so7911021vsd.13;
        Tue, 09 Aug 2022 08:12:44 -0700 (PDT)
X-Gm-Message-State: ACgBeo39JjvFV1QwJG/+yTkrXsD0Y6FsUmM6yLpeCK8Cn5Av1ojC7qEu
        Dqe3bQ4KMsolF7u7X5g+lXeb8d742qiijFPWUQ==
X-Google-Smtp-Source: AA6agR7EW9ojcU7odimGFi3uUkSTkSp9fZBO4oWioSAJV/M+NotpnmIns8Lw20HOIwj/mS+dggjZsX3OEnfgahz/iLc=
X-Received: by 2002:a67:a246:0:b0:388:7e82:1d80 with SMTP id
 t6-20020a67a246000000b003887e821d80mr8570961vsh.26.1660057962908; Tue, 09 Aug
 2022 08:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220728143427.13617-1-Sergey.Semin@baikalelectronics.ru>
 <20220728143427.13617-13-Sergey.Semin@baikalelectronics.ru>
 <20220801181311.GA1266390-robh@kernel.org> <20220808160118.m5ka7o7gdhei2yzl@mobilestation>
In-Reply-To: <20220808160118.m5ka7o7gdhei2yzl@mobilestation>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 9 Aug 2022 09:12:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJSYAsotjzvOUy_f7ZRfsSrfZyuEzq7eRwwKk12FBgxYg@mail.gmail.com>
Message-ID: <CAL_JsqJSYAsotjzvOUy_f7ZRfsSrfZyuEzq7eRwwKk12FBgxYg@mail.gmail.com>
Subject: Re: [PATCH v4 12/17] dt-bindings: PCI: dwc: Add Baikal-T1 PCIe Root
 Port bindings
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 8, 2022 at 10:01 AM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> On Mon, Aug 01, 2022 at 12:13:11PM -0600, Rob Herring wrote:
> > On Thu, Jul 28, 2022 at 05:34:22PM +0300, Serge Semin wrote:
> > > Baikal-T1 SoC is equipped with DWC PCIe v4.60a Root Port controller, which
> > > link can be trained to work on up to Gen.3 speed over up to x4 lanes. The
> > > controller is supposed to be fed up with four clock sources: DBI
> > > peripheral clock, AXI application Tx/Rx clocks and external PHY/core
> > > reference clock generating the 100MHz signal. In addition to that the
> > > platform provide a way to reset each part of the controller:
> > > sticky/non-sticky bits, host controller core, PIPE interface, PCS/PHY and
> > > Hot/Power reset signal. The Root Port controller is equipped with multiple
> > > IRQ lines like MSI, system AER, PME, HP, Bandwidth change, Link
> > > equalization request and eDMA ones. The registers space is accessed over
> > > the DBI interface. There can be no more than four inbound or outbound iATU
> > > windows configured.
> > >
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > >
> > > ---
> > >
> > > Changelog v2:
> > > - Rename 'syscon' property to 'baikal,bt1-syscon'.
> > > - Fix the 'compatible' property definition to being more specific about
> > >   what strings are supposed to be used. Due to that we had to add the
> > >   select property to evaluate the schema against the Baikal-T1 PCIe DT
> > >   nodes only.
> > > ---
> > >  .../bindings/pci/baikal,bt1-pcie.yaml         | 154 ++++++++++++++++++
> > >  1 file changed, 154 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml b/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
> > > new file mode 100644
> > > index 000000000000..23bd1d0aa5c5
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
> > > @@ -0,0 +1,154 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pci/baikal,bt1-pcie.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Baikal-T1 PCIe Root Port Controller
> > > +
> > > +maintainers:
> > > +  - Serge Semin <fancer.lancer@gmail.com>
> > > +
> > > +description:
> > > +  Embedded into Baikal-T1 SoC Root Complex controller. It's based on the
> > > +  DWC RC PCIe v4.60a IP-core, which is configured to have just a single Root
> > > +  Port function and is capable of establishing the link up to Gen.3 speed
> > > +  on x4 lanes. It doesn't have embedded clock and reset control module, so
> > > +  the proper interface initialization is supposed to be performed by software.
> > > +
> > > +select:
> > > +  properties:
> > > +    compatible:
> > > +      contains:
> > > +        const: baikal,bt1-pcie
> > > +
> > > +  required:
> > > +    - compatible
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - const: baikal,bt1-pcie
> > > +      - const: snps,dw-pcie-4.60a
> > > +      - const: snps,dw-pcie
> >
>
> > Again, these fallbacks simply aren't useful.
>
> Ok. I give up. You are the boss. I'll drop them =)
>
> >
> > > +
> > > +  reg:
> > > +    description:
> > > +      DBI, DBI2 and at least 4KB outbound iATU-capable region.
> >
>
> > 'iATU-capable region' means config space? That's not very clear.
>
> No 'iATU-capable region' means the region, which can be used as a
> source address for the iATU engine. In general it can be used for any
> accesses (IO, MEM, CFG). But the DW PCIe driver will indeed use it for
> the config-space accesses.
>
> IMO the 'config' reg space is kind of virtual. Due to the outbound
> iATU capability the driver could use any free outbound iATU region it
> found instead.

It is and in hindsight, we maybe should have described the whole
address space and let the OS alloc the config space out of it. But
then again, original OpenFirmware PCI binding reflects what the
firmware discovered AND how it is configured. So specifying where
config space is makes sense.

Bottom line is the binding defines putting the config space region in
'reg', not an iATU region.

> > > +    maxItems: 3
> > > +
> > > +  reg-names:
> > > +    minItems: 3
> > > +    maxItems: 3
> > > +    items:
> > > +      enum: [ dbi, dbi2, config ]
> >
>
> > Define the order. Here, and the rest.
>
> Ok. I will, but please answer to my question, I asked you in the
> previous email thread:
>
> Serge Semin wrote:
> > Rob Herring wrote:
> > > ...
> > > Tell me why you need random order.
> >
> > Because I don't see a need in constraining the order. If we get to set
> > the order requirement, then why do we need to have the "*-names"
> > property at all?

Originally, it was for cases where you have a variable number of
entries and can't determine what each entry is. IOW, when you have
optional entries in the middle of required entries. But then everyone
*loves* -names even when not needed or useful such as 'phy-names =
"pcie"' (the phy subsys requiring names was part of the problem there,
but that's been fixed).

> > IMO having "reg" with max/minItems restriction plus generic
> > description and "reg-names" with possible values enumerated seems very
> > suitable pattern in this case. Don't you think?

No, I think this is just as concise and defines the order too:

reg-names:
  items:
    - const: dbi
    - const: dbi2
    - const: config

>
> In addition to that what about optional names? How would you suggest
> to handle such case without the non-ordered pattern?

Sorry, I don't follow.

Rob
