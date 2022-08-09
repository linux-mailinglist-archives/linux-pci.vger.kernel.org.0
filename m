Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3AB58E09C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Aug 2022 22:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbiHIUGw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Aug 2022 16:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346382AbiHIUGd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Aug 2022 16:06:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74C71EAED;
        Tue,  9 Aug 2022 13:06:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65FBEB8188F;
        Tue,  9 Aug 2022 20:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1811BC433D7;
        Tue,  9 Aug 2022 20:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660075590;
        bh=MIIwPKYeCY6xQVNh67CE4Q95JJM0xKp1VkVucRBEEhw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uioKG0xFyuoCpbPknJ9jIhfjd5R/fVcI4EknjDnSp7aXG5NbuM4koZfrICBBtPj50
         pqxFmnoj5GQ4ovgLvrXYwSYFhh8GcaF6k5VipraZVdu3a9QtNM6psAPNnjytUsf2nE
         fpyQf0S159aM4Ir6mWqHmDab6lzQieygtQNzF7JO5YqZxT3e0GEApVRnZ/7qjOpJHQ
         zM5TpjBc1WDQYeFUtQNX0prj+pjZImPj6umo7g1v32JUv6F5Wc5+TjI7F/CPAwnX93
         W5FDijl//V6CfkjEeHfb65X8Tw54Ne2XJ/m5fdtk9JI4ASJXJGzrgxVB3U5/r5vWXE
         SoKd8k6gglEvw==
Received: by mail-vk1-f171.google.com with SMTP id r4so6445359vkf.0;
        Tue, 09 Aug 2022 13:06:30 -0700 (PDT)
X-Gm-Message-State: ACgBeo38y4Jz4e3WCefc1Q7u5r0DZTdCWOSUspyK0j+oAYRlCUmg5rsb
        5Xt0J7ux0GAYZdQeXTNwPyTQTGYYiuN26CybRQ==
X-Google-Smtp-Source: AA6agR5GCIbyX1Q6ChwUEznoJGoPzfhHZVJD6o2DrVfw04lmi8QrnDskxL+aBt+PP2stIK8NRD6ajYH7e+5CQ/zhsuE=
X-Received: by 2002:a05:6122:4f9:b0:377:f03a:23df with SMTP id
 s25-20020a05612204f900b00377f03a23dfmr10301125vkf.19.1660075589061; Tue, 09
 Aug 2022 13:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220728143427.13617-1-Sergey.Semin@baikalelectronics.ru>
 <20220728143427.13617-13-Sergey.Semin@baikalelectronics.ru>
 <20220801181311.GA1266390-robh@kernel.org> <20220808160118.m5ka7o7gdhei2yzl@mobilestation>
 <CAL_JsqJSYAsotjzvOUy_f7ZRfsSrfZyuEzq7eRwwKk12FBgxYg@mail.gmail.com> <20220809192846.ozixf6kgs242dbvl@mobilestation>
In-Reply-To: <20220809192846.ozixf6kgs242dbvl@mobilestation>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 9 Aug 2022 14:06:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJGvZnaV+kRazsb953+RtXadFxhEkw_uSjwR9PUXQeAAw@mail.gmail.com>
Message-ID: <CAL_JsqJGvZnaV+kRazsb953+RtXadFxhEkw_uSjwR9PUXQeAAw@mail.gmail.com>
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

On Tue, Aug 9, 2022 at 1:28 PM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> On Tue, Aug 09, 2022 at 09:12:31AM -0600, Rob Herring wrote:
> > On Mon, Aug 8, 2022 at 10:01 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> > >
> > > On Mon, Aug 01, 2022 at 12:13:11PM -0600, Rob Herring wrote:
> > > > On Thu, Jul 28, 2022 at 05:34:22PM +0300, Serge Semin wrote:
> > > > > Baikal-T1 SoC is equipped with DWC PCIe v4.60a Root Port controller, which
> > > > > link can be trained to work on up to Gen.3 speed over up to x4 lanes. The
> > > > > controller is supposed to be fed up with four clock sources: DBI
> > > > > peripheral clock, AXI application Tx/Rx clocks and external PHY/core
> > > > > reference clock generating the 100MHz signal. In addition to that the
> > > > > platform provide a way to reset each part of the controller:
> > > > > sticky/non-sticky bits, host controller core, PIPE interface, PCS/PHY and
> > > > > Hot/Power reset signal. The Root Port controller is equipped with multiple
> > > > > IRQ lines like MSI, system AER, PME, HP, Bandwidth change, Link
> > > > > equalization request and eDMA ones. The registers space is accessed over
> > > > > the DBI interface. There can be no more than four inbound or outbound iATU
> > > > > windows configured.
> > > > >
> > > > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > > >

[...]

> > > > > +  reg-names:
> > > > > +    minItems: 3
> > > > > +    maxItems: 3
> > > > > +    items:
> > > > > +      enum: [ dbi, dbi2, config ]
> > > >
> > >
> > > > Define the order. Here, and the rest.
> > >
> > > Ok. I will, but please answer to my question, I asked you in the
> > > previous email thread:
> > >
> > > Serge Semin wrote:
> > > > Rob Herring wrote:
> > > > > ...
> > > > > Tell me why you need random order.
> > > >
> > > > Because I don't see a need in constraining the order. If we get to set
> > > > the order requirement, then why do we need to have the "*-names"
> > > > property at all?
> >
> > Originally, it was for cases where you have a variable number of
> > entries and can't determine what each entry is. IOW, when you have
> > optional entries in the middle of required entries. But then everyone
> > *loves* -names even when not needed or useful such as 'phy-names =
> > "pcie"' (the phy subsys requiring names was part of the problem there,
> > but that's been fixed).
> >

> > > > IMO having "reg" with max/minItems restriction plus generic
> > > > description and "reg-names" with possible values enumerated seems very
> > > > suitable pattern in this case. Don't you think?
> >
> > No, I think this is just as concise and defines the order too:
> >
> > reg-names:
> >   items:
> >     - const: dbi
> >     - const: dbi2
> >     - const: config
> >
> > >
> > > In addition to that what about optional names? How would you suggest
> > > to handle such case without the non-ordered pattern?
> >
>
> > Sorry, I don't follow.
>
> I meant exactly the case you've described as the main goal of the
> named properties. My worry was that by using the pattern:
>
> reg-names:
>   items:
>     - const: name
>     - const: another_name
>     - const: one_more_name
>
> you get to fix the names order, which they were invented to get rid
> from. If you get to use that pattern the only optional names could be
> the names at the tail of the array, which isn't always applicable. In
> that case you'd have no choice but to use the pattern suggested by
> me.

For this binding, we use reg-names because the order and what's
present varies by platform. But for a given platform the order is
fixed.

Rob
