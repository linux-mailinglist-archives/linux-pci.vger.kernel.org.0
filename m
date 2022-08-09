Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1CE58E030
	for <lists+linux-pci@lfdr.de>; Tue,  9 Aug 2022 21:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344080AbiHIT25 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Aug 2022 15:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344056AbiHIT2z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Aug 2022 15:28:55 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A6518384;
        Tue,  9 Aug 2022 12:28:52 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id f20so18294450lfc.10;
        Tue, 09 Aug 2022 12:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=UpQrpm/ApIaRZ0s83gslfbMpGpJb7iuWgZQqWYQz1bo=;
        b=j/wbu5CDa6aI24ATri9dmT+G9srGDf3ToFayz3PQkJXhsOEltEIJC1fGMPe9Gw2OKp
         exOVVYl6h/VeZjg+V+IfnSNiYudOoIsc6For3s3xtD5h17kHDSmQdk3D4dXYKvnlvT/h
         iU26xSi3AiOPDPBuzF1rBLDaFZ0leEjzKLx/XopJFBqvs/+wcmTGkekaRZ8rmq8dVb+7
         XYnGAaAAV5a3UVf3Brzia4mhMAMYFdUSuc4sLOv/g/Fufz4BIZYvKgeMGwsM2chODmK4
         hUIPWFiLVlpC+S/Az6Msw8U/VZ5QqPeTO3U+RjaolOaG7Ypz9jGirUeu8GNHw1p26OcU
         2Bwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=UpQrpm/ApIaRZ0s83gslfbMpGpJb7iuWgZQqWYQz1bo=;
        b=MG8PCuatVECMoDB30A/++JxWP1PVMbhjtrwgUJGkskv14gz5J9QDjBI25PWrmgxpdq
         kBYlzW1XOQpzOC0cOkHKayjxfmec6N2fNeDslu6rEvlOTIv4GuHS00bk/LvaHGZNwsPR
         a8NZ/xPwj724GxvKRCzYJ40jmxufrlecSxONOHqXP57OxjpsG3Pd4j+/NtG6BP8abmFu
         g/4Ttvz0Apqo3lAoYAO9kJaE3vDWHp92so2KcCZrAGZDt82Fq29BPj5pqKWEbsu5q5ii
         PcSUA0xC9WukcpfSkvqs9Ap6xT7zIB5O5Lz3FpGlM3cbHQZM8gbh60JPLGzRsGYUzclq
         C9Iw==
X-Gm-Message-State: ACgBeo3aLDKQ4oDVd67ZiZFebMkZGwZ4HQKOKdejFXI3MVYtwBOUKde+
        YLXp5GRjO64K9M630qvay1nAtnbqXzaHGQ==
X-Google-Smtp-Source: AA6agR7WvusrH8G8KEzjm+A0NlFvp6eT0993uhqXFqv9uiEDstp67r6aTLJP4MiBT8975b71Vv8RXg==
X-Received: by 2002:ac2:5324:0:b0:48b:9643:3838 with SMTP id f4-20020ac25324000000b0048b96433838mr6409291lfh.373.1660073330623;
        Tue, 09 Aug 2022 12:28:50 -0700 (PDT)
Received: from mobilestation (ip1.ibrae.ac.ru. [91.238.191.1])
        by smtp.gmail.com with ESMTPSA id n24-20020a05651203f800b00489da512f5asm72305lfq.86.2022.08.09.12.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 12:28:48 -0700 (PDT)
Date:   Tue, 9 Aug 2022 22:28:46 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 12/17] dt-bindings: PCI: dwc: Add Baikal-T1 PCIe Root
 Port bindings
Message-ID: <20220809192846.ozixf6kgs242dbvl@mobilestation>
References: <20220728143427.13617-1-Sergey.Semin@baikalelectronics.ru>
 <20220728143427.13617-13-Sergey.Semin@baikalelectronics.ru>
 <20220801181311.GA1266390-robh@kernel.org>
 <20220808160118.m5ka7o7gdhei2yzl@mobilestation>
 <CAL_JsqJSYAsotjzvOUy_f7ZRfsSrfZyuEzq7eRwwKk12FBgxYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJSYAsotjzvOUy_f7ZRfsSrfZyuEzq7eRwwKk12FBgxYg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 09, 2022 at 09:12:31AM -0600, Rob Herring wrote:
> On Mon, Aug 8, 2022 at 10:01 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > On Mon, Aug 01, 2022 at 12:13:11PM -0600, Rob Herring wrote:
> > > On Thu, Jul 28, 2022 at 05:34:22PM +0300, Serge Semin wrote:
> > > > Baikal-T1 SoC is equipped with DWC PCIe v4.60a Root Port controller, which
> > > > link can be trained to work on up to Gen.3 speed over up to x4 lanes. The
> > > > controller is supposed to be fed up with four clock sources: DBI
> > > > peripheral clock, AXI application Tx/Rx clocks and external PHY/core
> > > > reference clock generating the 100MHz signal. In addition to that the
> > > > platform provide a way to reset each part of the controller:
> > > > sticky/non-sticky bits, host controller core, PIPE interface, PCS/PHY and
> > > > Hot/Power reset signal. The Root Port controller is equipped with multiple
> > > > IRQ lines like MSI, system AER, PME, HP, Bandwidth change, Link
> > > > equalization request and eDMA ones. The registers space is accessed over
> > > > the DBI interface. There can be no more than four inbound or outbound iATU
> > > > windows configured.
> > > >
> > > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > >
> > > > ---
> > > >
> > > > Changelog v2:
> > > > - Rename 'syscon' property to 'baikal,bt1-syscon'.
> > > > - Fix the 'compatible' property definition to being more specific about
> > > >   what strings are supposed to be used. Due to that we had to add the
> > > >   select property to evaluate the schema against the Baikal-T1 PCIe DT
> > > >   nodes only.
> > > > ---
> > > >  .../bindings/pci/baikal,bt1-pcie.yaml         | 154 ++++++++++++++++++
> > > >  1 file changed, 154 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml b/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
> > > > new file mode 100644
> > > > index 000000000000..23bd1d0aa5c5
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
> > > > @@ -0,0 +1,154 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/pci/baikal,bt1-pcie.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Baikal-T1 PCIe Root Port Controller
> > > > +
> > > > +maintainers:
> > > > +  - Serge Semin <fancer.lancer@gmail.com>
> > > > +
> > > > +description:
> > > > +  Embedded into Baikal-T1 SoC Root Complex controller. It's based on the
> > > > +  DWC RC PCIe v4.60a IP-core, which is configured to have just a single Root
> > > > +  Port function and is capable of establishing the link up to Gen.3 speed
> > > > +  on x4 lanes. It doesn't have embedded clock and reset control module, so
> > > > +  the proper interface initialization is supposed to be performed by software.
> > > > +
> > > > +select:
> > > > +  properties:
> > > > +    compatible:
> > > > +      contains:
> > > > +        const: baikal,bt1-pcie
> > > > +
> > > > +  required:
> > > > +    - compatible
> > > > +
> > > > +allOf:
> > > > +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    items:
> > > > +      - const: baikal,bt1-pcie
> > > > +      - const: snps,dw-pcie-4.60a
> > > > +      - const: snps,dw-pcie
> > >
> >
> > > Again, these fallbacks simply aren't useful.
> >
> > Ok. I give up. You are the boss. I'll drop them =)
> >
> > >
> > > > +
> > > > +  reg:
> > > > +    description:
> > > > +      DBI, DBI2 and at least 4KB outbound iATU-capable region.
> > >
> >
> > > 'iATU-capable region' means config space? That's not very clear.
> >
> > No 'iATU-capable region' means the region, which can be used as a
> > source address for the iATU engine. In general it can be used for any
> > accesses (IO, MEM, CFG). But the DW PCIe driver will indeed use it for
> > the config-space accesses.
> >
> > IMO the 'config' reg space is kind of virtual. Due to the outbound
> > iATU capability the driver could use any free outbound iATU region it
> > found instead.
> 
> It is and in hindsight, we maybe should have described the whole
> address space and let the OS alloc the config space out of it. But
> then again, original OpenFirmware PCI binding reflects what the
> firmware discovered AND how it is configured. So specifying where
> config space is makes sense.
> 
> Bottom line is the binding defines putting the config space region in
> 'reg', not an iATU region.
> 
> > > > +    maxItems: 3
> > > > +
> > > > +  reg-names:
> > > > +    minItems: 3
> > > > +    maxItems: 3
> > > > +    items:
> > > > +      enum: [ dbi, dbi2, config ]
> > >
> >
> > > Define the order. Here, and the rest.
> >
> > Ok. I will, but please answer to my question, I asked you in the
> > previous email thread:
> >
> > Serge Semin wrote:
> > > Rob Herring wrote:
> > > > ...
> > > > Tell me why you need random order.
> > >
> > > Because I don't see a need in constraining the order. If we get to set
> > > the order requirement, then why do we need to have the "*-names"
> > > property at all?
> 
> Originally, it was for cases where you have a variable number of
> entries and can't determine what each entry is. IOW, when you have
> optional entries in the middle of required entries. But then everyone
> *loves* -names even when not needed or useful such as 'phy-names =
> "pcie"' (the phy subsys requiring names was part of the problem there,
> but that's been fixed).
> 
> > > IMO having "reg" with max/minItems restriction plus generic
> > > description and "reg-names" with possible values enumerated seems very
> > > suitable pattern in this case. Don't you think?
> 
> No, I think this is just as concise and defines the order too:
> 
> reg-names:
>   items:
>     - const: dbi
>     - const: dbi2
>     - const: config
> 
> >
> > In addition to that what about optional names? How would you suggest
> > to handle such case without the non-ordered pattern?
> 

> Sorry, I don't follow.

I meant exactly the case you've described as the main goal of the
named properties. My worry was that by using the pattern:

reg-names:
  items:
    - const: name
    - const: another_name
    - const: one_more_name

you get to fix the names order, which they were invented to get rid
from. If you get to use that pattern the only optional names could be
the names at the tail of the array, which isn't always applicable. In
that case you'd have no choice but to use the pattern suggested by
me.

-Sergey

> 
> Rob
