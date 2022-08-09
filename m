Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B176158E0E2
	for <lists+linux-pci@lfdr.de>; Tue,  9 Aug 2022 22:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244980AbiHIUR3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Aug 2022 16:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244696AbiHIURX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Aug 2022 16:17:23 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8206C6E;
        Tue,  9 Aug 2022 13:17:21 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id v7so14126461ljj.4;
        Tue, 09 Aug 2022 13:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=3mJZlwcPuZ9W9ftRRvNLyfL45/YwPQIszBn93QgeHJk=;
        b=TL7Np1LTKvuyqpbYbUW1ACTFwZ6T5Hf3Oix/ypKZhdtd7RPNdSKCjt62U7lBLja915
         jrrXtNj6m1AHhT8WDhRZmf7QCpjRWZnN+aLky18s1MYY080G/X2f2WTiehU0dKN2P0Ms
         zeI6K7byB+4qeHGurE+vK9EteZDP/hE9UAgFEjLZoPVjF2P9PE6HTYQYOjyl9teTXIsu
         Zj+NYfTESkULy0P/mPcOwbDJWdfBJd5prEUGYQ1Qgi3KbSiSBG4YWF7SgsLl0l5k80Yj
         TXcZERlGGVU2+UpKbNinZyDm83BzVa70/4DXjnrLwWH4rZksZxyEKaSRNzlagPNE5kHl
         fWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=3mJZlwcPuZ9W9ftRRvNLyfL45/YwPQIszBn93QgeHJk=;
        b=1LXcVv9w6KPWV14wmLLolyom0sCYXIHWDS4IjuozOpRGRedLkt1phKSCnfI0du6w+q
         QlO4yzGQ9ow5ZM7klWNq4NRYUUfBoZIE14Zu4xf39s6ediRLdzwCFGsu0l3IUBpEaHsS
         OBzdl8rZBnS8TvMflp4aeGGmdC1hOya4C9NXtY0hf8NWZxxR4gACAQTcaAjVTmUZp22U
         TvKhqaeEqvefIwjzC3FZrm7kyLDJGnueBWe/EB9qZBtrJIvrbKV+T1Zzv6Tef7m973q1
         cNW9xzGpwjchTAOL29YSPyXW8P8OB+PqB0n+PECqoDYYCTTsUKtN9yPvewM6UhCtJrCn
         Ekug==
X-Gm-Message-State: ACgBeo3wqBGbpIMToOvCQlCYXgVhThduShskTDgTm/5MoIMBc5YHldqu
        SJf6H7XfUC53iPOOeZqvEPE=
X-Google-Smtp-Source: AA6agR7EQjDbh5FyX3H2TLIPLgFDklraZb1iHpWt/twPEHXFxCqniGw6N1pztZoT2ApgQanAn1ecGw==
X-Received: by 2002:a2e:a99b:0:b0:25e:be66:72f2 with SMTP id x27-20020a2ea99b000000b0025ebe6672f2mr5535835ljq.27.1660076240273;
        Tue, 09 Aug 2022 13:17:20 -0700 (PDT)
Received: from mobilestation (ip1.ibrae.ac.ru. [91.238.191.1])
        by smtp.gmail.com with ESMTPSA id z18-20020a2eb532000000b0025e4a8a8038sm93534ljm.88.2022.08.09.13.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 13:17:19 -0700 (PDT)
Date:   Tue, 9 Aug 2022 23:17:16 +0300
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
Message-ID: <20220809201716.wy7ij2tawmzk7ihe@mobilestation>
References: <20220728143427.13617-1-Sergey.Semin@baikalelectronics.ru>
 <20220728143427.13617-13-Sergey.Semin@baikalelectronics.ru>
 <20220801181311.GA1266390-robh@kernel.org>
 <20220808160118.m5ka7o7gdhei2yzl@mobilestation>
 <CAL_JsqJSYAsotjzvOUy_f7ZRfsSrfZyuEzq7eRwwKk12FBgxYg@mail.gmail.com>
 <20220809192846.ozixf6kgs242dbvl@mobilestation>
 <CAL_JsqJGvZnaV+kRazsb953+RtXadFxhEkw_uSjwR9PUXQeAAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJGvZnaV+kRazsb953+RtXadFxhEkw_uSjwR9PUXQeAAw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 09, 2022 at 02:06:16PM -0600, Rob Herring wrote:
> On Tue, Aug 9, 2022 at 1:28 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > On Tue, Aug 09, 2022 at 09:12:31AM -0600, Rob Herring wrote:
> > > On Mon, Aug 8, 2022 at 10:01 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> > > >
> > > > On Mon, Aug 01, 2022 at 12:13:11PM -0600, Rob Herring wrote:
> > > > > On Thu, Jul 28, 2022 at 05:34:22PM +0300, Serge Semin wrote:
> > > > > > Baikal-T1 SoC is equipped with DWC PCIe v4.60a Root Port controller, which
> > > > > > link can be trained to work on up to Gen.3 speed over up to x4 lanes. The
> > > > > > controller is supposed to be fed up with four clock sources: DBI
> > > > > > peripheral clock, AXI application Tx/Rx clocks and external PHY/core
> > > > > > reference clock generating the 100MHz signal. In addition to that the
> > > > > > platform provide a way to reset each part of the controller:
> > > > > > sticky/non-sticky bits, host controller core, PIPE interface, PCS/PHY and
> > > > > > Hot/Power reset signal. The Root Port controller is equipped with multiple
> > > > > > IRQ lines like MSI, system AER, PME, HP, Bandwidth change, Link
> > > > > > equalization request and eDMA ones. The registers space is accessed over
> > > > > > the DBI interface. There can be no more than four inbound or outbound iATU
> > > > > > windows configured.
> > > > > >
> > > > > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > > > >
> 
> [...]
> 
> > > > > > +  reg-names:
> > > > > > +    minItems: 3
> > > > > > +    maxItems: 3
> > > > > > +    items:
> > > > > > +      enum: [ dbi, dbi2, config ]
> > > > >
> > > >
> > > > > Define the order. Here, and the rest.
> > > >
> > > > Ok. I will, but please answer to my question, I asked you in the
> > > > previous email thread:
> > > >
> > > > Serge Semin wrote:
> > > > > Rob Herring wrote:
> > > > > > ...
> > > > > > Tell me why you need random order.
> > > > >
> > > > > Because I don't see a need in constraining the order. If we get to set
> > > > > the order requirement, then why do we need to have the "*-names"
> > > > > property at all?
> > >
> > > Originally, it was for cases where you have a variable number of
> > > entries and can't determine what each entry is. IOW, when you have
> > > optional entries in the middle of required entries. But then everyone
> > > *loves* -names even when not needed or useful such as 'phy-names =
> > > "pcie"' (the phy subsys requiring names was part of the problem there,
> > > but that's been fixed).
> > >
> 
> > > > > IMO having "reg" with max/minItems restriction plus generic
> > > > > description and "reg-names" with possible values enumerated seems very
> > > > > suitable pattern in this case. Don't you think?
> > >
> > > No, I think this is just as concise and defines the order too:
> > >
> > > reg-names:
> > >   items:
> > >     - const: dbi
> > >     - const: dbi2
> > >     - const: config
> > >
> > > >
> > > > In addition to that what about optional names? How would you suggest
> > > > to handle such case without the non-ordered pattern?
> > >
> >
> > > Sorry, I don't follow.
> >
> > I meant exactly the case you've described as the main goal of the
> > named properties. My worry was that by using the pattern:
> >
> > reg-names:
> >   items:
> >     - const: name
> >     - const: another_name
> >     - const: one_more_name
> >
> > you get to fix the names order, which they were invented to get rid
> > from. If you get to use that pattern the only optional names could be
> > the names at the tail of the array, which isn't always applicable. In
> > that case you'd have no choice but to use the pattern suggested by
> > me.
> 
> For this binding, we use reg-names because the order and what's
> present varies by platform. But for a given platform the order is
> fixed.

Got it. Thanks for your time and for the detailed case clarification.

-Sergey

> 
> Rob
