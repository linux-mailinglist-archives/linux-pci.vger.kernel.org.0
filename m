Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDFC521D91
	for <lists+linux-pci@lfdr.de>; Tue, 10 May 2022 17:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiEJPL7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 May 2022 11:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345889AbiEJPLh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 May 2022 11:11:37 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876EB1CB0D;
        Tue, 10 May 2022 07:43:46 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so18526827fac.7;
        Tue, 10 May 2022 07:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uf96CY0LPjS+h4UfVS3lB/0311lJnoJ53zmPiP7k4Ww=;
        b=0KpFGF75NDGN7LocsKdZuzhBcm42XVG62tAaPLQCECmSvnmqPY7rgiGMHKNPYPYq0M
         BAQTSjybDc0ZYMOivdPOeGf6PAwnhbouhoIA2kkZ92iRNjliASTFsSIV0712SdlXo4oE
         7V6WjcH6c7dHEIiXBkni93VDgJvtRUNvKM58ss4s7AyK60F2tsXlpE6VQ8wRj0Mw2+7x
         ox1U2e02w+/CSmYn0c5ytBj3EezFddEc97d5On+VSLwcsBmoEbGK8qQWjPiJfXnnmNqd
         QMEW1zvu/boK92BRIi1CxP7bny1D5oAD9bDzPrAJW7zqkMEBTqhA5MV36P58SPd9XYpS
         E7IQ==
X-Gm-Message-State: AOAM533RtvvaXW0fXm3Bf0VG+pAUlb4PPZnyyIQesrRBr7jjZjhNgGP1
        9FXUakLyuPu6qt1wiQ8OPA==
X-Google-Smtp-Source: ABdhPJwpGVOxGXwxh0k1YVLdC2QbR/EOmppKl7fXV2FRo2r1dRrzyqPrXIQvjOSd/fP9XJTXGepiew==
X-Received: by 2002:a05:6870:a2cd:b0:ed:754:a2c6 with SMTP id w13-20020a056870a2cd00b000ed0754a2c6mr224227oak.270.1652193825489;
        Tue, 10 May 2022 07:43:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p16-20020a4ae150000000b0035f498be272sm5567046oot.13.2022.05.10.07.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 07:43:45 -0700 (PDT)
Received: (nullmailer pid 1973733 invoked by uid 1000);
        Tue, 10 May 2022 14:43:44 -0000
Date:   Tue, 10 May 2022 09:43:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazonni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 0/3] add dynamic PCI device of_node creation for overlay
Message-ID: <Ynp6IO9UREcX0k9C@robh.at.kernel.org>
References: <20220427094502.456111-1-clement.leger@bootlin.com>
 <96db62bb-18be-f44a-6f53-05b22319f23a@gmail.com>
 <20220509141634.16158c38@xps-bootlin>
 <f9b0cbf1-dde2-ff97-cca0-5d2895734f91@gmail.com>
 <CAL_Jsq+jnz3SAc+m5RRN9cOs+5k=CC4Fud9gsmquVjv2zVv6pQ@mail.gmail.com>
 <50d044ca-8d46-17a5-0a16-541e079af933@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50d044ca-8d46-17a5-0a16-541e079af933@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 09, 2022 at 03:35:45PM -0500, Frank Rowand wrote:
> On 5/9/22 13:36, Rob Herring wrote:
> > On Mon, May 9, 2022 at 10:56 AM Frank Rowand <frowand.list@gmail.com> wrote:
> >>
> >> On 5/9/22 07:16, Clément Léger wrote:
> >>> Le Fri, 6 May 2022 13:33:22 -0500,
> >>> Frank Rowand <frowand.list@gmail.com> a écrit :
> >>>
> >>>> On 4/27/22 04:44, Clément Léger wrote:
> >>>>> This series adds foundation work to support the lan9662 PCIe card.
> >>>>> This card is meant to be used an ethernet switch with 2 x RJ45
> >>>>> ports and 2 x 2.5G SFPs. The lan966x SoCs can be used in two
> >>>>> different ways:

[...]

> >>> This work uses the kernel space interface (of_overlay_fdt_apply())
> >>> and the device tree overlay is builtin the driver. This interface was
> >>> used until recently by rcu-dcar driver. While the only user (sic),
> >>> this seems to work pretty well and I was able to use it successfully.
> >>
> >> Yes, of_overlay_fdt_apply() was used by one driver.  But that driver
> >> was explicitly recognized as a grandfathered exception, and not an
> >> example for other users.  It was finally removed in 5.18-rc1.
> > 
> > What API are folks supposed to use exactly? That's the only API to
> > apply an overlay.
> 
> Yes, that is the API to designed to be used if overlays are applied
> after the kernel has booted.
> 
> > I thought the FPGA mgr code was using it too, but
> 
> That was my understanding too.
> 
> > it's not. It doesn't look to me like the upstream code there even
> > works as nothing applies the overlays AFAICT. If there are no in
> > kernel users applying overlays, then let's remove the overlay code. I
> > hear it has lots of problems.
> 
> I would not object to doing that.  But I suspect there are other people
> who might.  I much prefer that overlays be applied before boot.

Strictly speaking, we don't keep APIs with no users. Perhaps removing or 
threatening to remove would spur on some work in your overlay issues 
list. :)


> >>> Moreover, this support targets at using this with PCI devices. This
> >>> devices are really well contained and do not interfere with other
> >>> devices. This actually consists in adding a complete subtree into the
> >>> existing device-tree and thus it limits the interactions between
> >>> potentially platform provided devices and PCI ones.
> >>
> >> Yes, that it is very important that you have described this fact, both
> >> here and in other emails.  Thank you for that information, it does help
> >> understanding the alternatives.
> >>
> >> I've hesitated in recommending a specific solution before better
> >> understanding the architecture of your pcie board and drivers, but
> >> I've delayed too long, so I am going to go ahead and mention one
> >> possibility at the risk of not yet fully understanding the situation.
> >>
> >> On the surface, it appears that your need might be well met by having
> >> a base devicetree that describes all of the pcie nodes, but with each
> >> node having a status of "disabled" so that they will not be used.
> >> Have a devicetree overlay describing the pcie card (as you proposed),
> >> where the overlay also includes a status of "ok" for the pcie node.
> >> Applying the overlay, with a method of redirecting the target to a
> >> specific pcie node would change the status of the pcie node to enable
> >> its use.  (You have already proposed a patch to modify of_overlay_fdt_apply()
> >> to allow a modified target, so not a new concept from me.)  My suggestion
> >> is to apply the overlay devicetree to the base devicetree before the
> >> combined FDT devicetree is passed to the kernel at boot.  The overlay
> >> apply could be done by several different entities.  It could be before
> >> the bootloader executes, it could be done by the bootloader, it could
> >> be done by a shim between the bootloader and the kernel.  This method
> >> avoids all of the issues of applying an overlay to a running system
> >> that I find problematic.  It is also a method used by the U-boot
> >> bootloader, as an example.
> > 
> > Adding a layer, the solution to all problems...
> 
> < insert xkcd reference here >  :-)
> 
> > 
> > I don't think that's a workable solution unless all the components are
> > in one party's control. Given the desire to work on ACPI and DT based
> > systems, that doesn't sound like the case here.
> 
> That is the motivation behind my questions of how generic or targeted
> the use of this one specific card is.
> 
> A pre-boot shim that discovers the card and applies the overlay could
> be somewhat generic to ACPI systems.
> 
> Is the overlay approach also being proposed for DT based systems?

Yes, the intent is it would work for either.

Another usecase I have in mind are USB to serial chips with downstream 
GPIOs, I2C, SPI, etc. where you want to describe downstream devices. And 
then you plug in more than 1...

> >> The other big issue is mixing ACPI and devicetree on a single system.
> >> Historically, the Linux devicetree community has not been receptive
> >> to the ides of that mixture.  Your example might be a specific case
> >> where the two can be isolated from each other, or maybe not.  (For
> >> disclosure, I am essentially ACPI ignorant.)  I suspect that mixing
> >> ACPI and devicetree is a recipe for disaster in the general case.
> > 
> > The idea here is what is described by ACPI and DT are disjoint which I
> > think we can enforce. Enforcement comes from fwnode assuming it has
> > either an ACPI or a DT handle, but not both.
> 
> I thought the intent was to use DT API drivers, not fwnode API drivers.

Yes.

> And I thought the card was not to be described by ACPI, so there would
> not be any ACPI fwnode info for the card _and_ fwnode is somewhat
> irrelevant since the drivers are using the DT API.

The card would not be described, but the PCI host bridge would likely 
be and that may be where the conflict is. Though I think PCI hosts are 
described differently from devices that end up with a fwnode handle in 
ACPI. 

My current thinking is the whole PCI bus structure from the card 
device up the tree needs to be created in the base DT. Maybe we could 
create just a fake parent for the device and avoid the above issue, but 
I'd guess that would just create other issues.

>  So the enforcement
> you mention could be implemented by the overlay apply code verifying
> that there is no ACPI fwnode for any DT node in the overlay.  So not
> an _assumption_, but a testable rule.

I think we'd need something where ever device fwnode ptrs are getting 
set. Not entirely sure yet.

> That is a long way of essentially agreeing with you.
> 
> > 
> >> More to come later as I finish reading through the various threads.
> > 
> > There is also the Xilinx folks wanting to support their PCI FPGA card
> > with DT for the FPGA contents on both ACPI and DT systems.
> 
> Is that the XRT Alveo driver infrastructure thread?  I was not cc:ed
> on that thread, and just recently stumbled upon it.  Yet another
> thread that is on my to-read list.

Yes, and I've had a call about it in the 'system DT' call. 

Rob
