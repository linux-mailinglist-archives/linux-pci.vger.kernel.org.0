Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DCB358BC3
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 19:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbhDHRzx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 13:55:53 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:36360 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbhDHRzw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 13:55:52 -0400
Received: by mail-ot1-f50.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso3152015otq.3;
        Thu, 08 Apr 2021 10:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3TOQkf6y0+tFgPWi7wzwRS6LltZgb6boVG0kZSOaui4=;
        b=X0Zx5yK67Zf0G1bruCrpGs5h+aMSCC0yh9asIQIiUKgFhsFTUQqaWD/mXbGi5yl7pg
         bmdRaNrcLtmFMZ1MviNAi4aP0TuGcnjuHi9AwBqCDOYJSd0pSY256JjAnpPcA31Y4ur2
         aOCDwFLcfpdxWBmNHkVXd3Z/Hvy1hFb6MPaR7IZG7y1aCguB0Sng7rhyEPbBcwYq0oF9
         jdvQSerGRMmSbZqCOnMNvrwvnUk2kWFHzBiIdRenRg/+wewxoY13b3rhCjGvg82AhQVT
         TxPKOR1Z0/gsT+K2bccVwX1Nr8wygovYgR0JZoZUdHd0TNK+ZRkbccik3lsgkWcqPOOI
         8Tww==
X-Gm-Message-State: AOAM5335tbM2+6vM7Ms3r0Y95ijc2+evGE+7e5GtDp2RFHkhS6cPifZ8
        4GRdWsKe7uGWSFeUgg8Qfg==
X-Google-Smtp-Source: ABdhPJyTErOlUI7ErNldOV1VbI5u50JYPHqEBsBBiIsIzHTTwtqaeKL04S8AQSgLdnIEjy+UfHL9fg==
X-Received: by 2002:a9d:3423:: with SMTP id v32mr8860415otb.168.1617904539749;
        Thu, 08 Apr 2021 10:55:39 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j10sm29616oos.27.2021.04.08.10.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 10:55:39 -0700 (PDT)
Received: (nullmailer pid 1706321 invoked by uid 1000);
        Thu, 08 Apr 2021 17:55:38 -0000
Date:   Thu, 8 Apr 2021 12:55:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/6] dt-bindings: PCI: Add bindings for Brcmstb
 endpoint device voltage regulators
Message-ID: <20210408175538.GA1688320@robh.at.kernel.org>
References: <20210401212148.47033-1-jim2101024@gmail.com>
 <20210401212148.47033-3-jim2101024@gmail.com>
 <20210406164708.GM6443@sirena.org.uk>
 <CANCKTBsiujTkOdh60etBqF_hE8exg6m9TDxkGHVVAGVS2SFCcQ@mail.gmail.com>
 <20210406173211.GP6443@sirena.org.uk>
 <CANCKTBv63b4bGepZbDp1wmFrOeddiDikoXbheMjHhbguAbR2sA@mail.gmail.com>
 <20210408162016.GA1556444@robh.at.kernel.org>
 <CANCKTBv_g9FPcBCOi-JxEDrrQWFhNcdsfDATFBydwnLiebj-HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANCKTBv_g9FPcBCOi-JxEDrrQWFhNcdsfDATFBydwnLiebj-HA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 08, 2021 at 12:58:05PM -0400, Jim Quinlan wrote:
> On Thu, Apr 8, 2021 at 12:20 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Apr 06, 2021 at 02:25:49PM -0400, Jim Quinlan wrote:
> > > On Tue, Apr 6, 2021 at 1:32 PM Mark Brown <broonie@kernel.org> wrote:
> > > >
> > > > On Tue, Apr 06, 2021 at 01:26:51PM -0400, Jim Quinlan wrote:
> > > > > On Tue, Apr 6, 2021 at 12:47 PM Mark Brown <broonie@kernel.org> wrote:
> > > >
> > > > > > No great problem with having these in the controller node (assming it
> > > > > > accurately describes the hardware) but I do think we ought to also be
> > > > > > able to describe these per slot.
> >
> > PCIe is effectively point to point, so there's only 1 slot unless
> > there's a PCIe switch in the middle. If that's the case, then it's all
> > more complicated.
> >
> > > > > Can you explain what you think that would look like in the DT?
> > > >
> > > > I *think* that's just some properties on the nodes for the endpoints,
> > > > note that the driver could just ignore them for now.  Not sure where or
> > > > if we document any extensions but child nodes are in section 4 of the
> > > > v2.1 PCI bus binding.
> > >
> > > Hi Mark,
> > >
> > > I'm a little confused -- here is how I remember the chronology of the
> > > "DT bindings" commit reviews, please correct me if I'm wrong:
> > >
> > > o JimQ submitted a pullreq for using voltage regulators in the same
> > > style as the existing "rockport" PCIe driver.
> > > o After some deliberation, RobH preferred that the voltage regulators
> > > should go into the PCIe subnode device's DT node.
> >
> > IIRC, that's because you said there isn't a standard slot.
> Admittedly, I'm not exactly sure what you mean by a "standard slot".
> Our PCIIe HW does not support  hotplug or have a presence bit or
> anything like that.  Our root complex has one port; it can only
> directly connect to a single switch or endpoint. This connection shows
> up as slot0.  The voltage regulator(s) involved depend on a GPIO that
> turns the power  on/off for the connected device/chip.  The gpio pin
> can vary from board to board but this is easily handled in our DT.
> Some boards have regulators that are always on and not associated with
> a GPIO pin -- these have no representation in our DT.

By standard slot, I mean you have standard voltage rails 12V and 3.3V 
(or 1.5 and 3.3 for mini PCIe) and PERST# signal, no other extra 
things to make a device discoverable, and the timing for 
those rails and PERST# follow what the spec defines.

There's also CLKREQ, WAKE, and hotplug detect signals, but I think those 
are all optional and could be tied off. I think most PCI h/w is not 
hotplug capable.

Rob
