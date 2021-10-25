Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02E343A6C5
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 00:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbhJYWqG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 18:46:06 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:35664 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbhJYWqF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Oct 2021 18:46:05 -0400
Received: by mail-oi1-f170.google.com with SMTP id r6so17751145oiw.2;
        Mon, 25 Oct 2021 15:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1zjj/3+jDmSGNtrIuN16WKRctTcCSeqDtgzJGB+OWrs=;
        b=EC5i5hZG54RJvYi14ujjWVQobf6GQCkBeHojvzOzxq9E7CaCtAeW4uYBDaFz6NdQ6X
         JaPtiH5ih8ZpsTsc+bd9ayToZC6YZbJ/bp9bgKZl5q3y9EacYcei9HOM5k+dhX+BiFef
         ajuhtExVOylbNyn+B8ku4hShlpFewqcA/NpZ9OMrAItGIi8z8k4OPId5CVmryaiZFhX0
         WYfm5+J0AaSxbCUIQIzON3VViI7uZje4vg40w4F57ojVUh6jq461lyNU5Vi00v5OX7Yk
         mEdgs/oKibhhsqcE3hEsAdetUuJ34LmPdW/wsYSmRkItwEZx3KQ6UJ4KA+4tX6zFiGDI
         nBhA==
X-Gm-Message-State: AOAM5311RnDUclRgxZXJkWBSdLteI3vlbF3d5tmzwzciK0tPNvyt1Cv6
        Nvbp9sOlAQnz1x6nUM6PEw==
X-Google-Smtp-Source: ABdhPJxslTyNOctaJkhkls43SqUyyiF/zFw3Q/U2zDEfYhotZ16/ogssJrH6Prv1gdTLP8j5+iDZDQ==
X-Received: by 2002:a05:6808:243:: with SMTP id m3mr15025428oie.14.1635201822105;
        Mon, 25 Oct 2021 15:43:42 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l1sm4025475oic.30.2021.10.25.15.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:43:41 -0700 (PDT)
Received: (nullmailer pid 1222123 invoked by uid 1000);
        Mon, 25 Oct 2021 22:43:40 -0000
Date:   Mon, 25 Oct 2021 17:43:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/6] PCI: brcmstb: Add control of subdevice voltage
 regulators
Message-ID: <YXczHKg77Z5oIJX3@robh.at.kernel.org>
References: <20211022140714.28767-1-jim2101024@gmail.com>
 <20211022140714.28767-5-jim2101024@gmail.com>
 <YXLLRLwMG7nEwQoi@sirena.org.uk>
 <CA+-6iNzmkB5sUL6aqA6229BhxBhF3RKvGsLh0JCYQwP_2wSGaQ@mail.gmail.com>
 <YXMVSVpeC1Kqsg5x@sirena.org.uk>
 <CA+-6iNxQAekCQTJKE5L7LO6QF+UC6xnyE=XVq_7z3=4hp8ASXQ@mail.gmail.com>
 <YXbF+VxZKkiHEu9c@sirena.org.uk>
 <2eec973e-e9f0-1ef7-a090-734dab5db815@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2eec973e-e9f0-1ef7-a090-734dab5db815@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 25, 2021 at 03:04:34PM -0700, Florian Fainelli wrote:
> On 10/25/21 7:58 AM, Mark Brown wrote:
> > On Mon, Oct 25, 2021 at 09:50:09AM -0400, Jim Quinlan wrote:
> >> On Fri, Oct 22, 2021 at 3:47 PM Mark Brown <broonie@kernel.org> wrote:
> >>> On Fri, Oct 22, 2021 at 03:15:59PM -0400, Jim Quinlan wrote:
> > 
> >>> That sounds like it just shouldn't be a regulator at all, perhaps the
> >>> board happens to need a regulator there but perhaps it needs a clock,
> >>> GPIO or some specific sequence of actions.  It sounds like you need some
> >>> sort of quirking mechanism to cope with individual boards with board
> >>> specific bindings.
> > 
> >> The boards involved may have no PCIe sockets, or run the gamut of the different
> >> PCIe sockets.  They all offer gpio(s) to turn off/on their power supply(s) to
> >> make their PCIe device endpoint functional.  It is not viable to add
> >> new Linux quirk or DT
> >> code for each board.  First is the volume and variety of the boards
> >> that use our SOCs.. Second, is
> >> our lack of information/control:  often, the board is designed by one
> >> company (not us), and
> >> given to another company as the middleman, and then they want the
> >> features outlined
> >> in my aforementioned commit message.
> > 
> > Other vendors have plenty of variation in board design yet we still have
> > device trees that describe the hardware, I can't see why these systems
> > should be so different.  It is entirely normal for system integrators to
> > collaborate on this and even upstream their own code, this happens all
> > the time, there is no need for everything to be implemented directly the
> > SoC vendor.
> 
> This is all well and good and there is no disagreement here that it
> should just be that way but it does not reflect what Jim and I are
> confronted with on a daily basis. We work in a tightly controlled
> environment using a waterfall approach, whatever we come up with as a
> SoC vendor gets used usually without further modification by the OEMs,
> when OEMs do change things we have no visibility into anyway.
> 
> We have a boot loader that goes into great lengths to tailor the FDT
> blob passed to the kernel to account for board-specific variations, PCIe
> voltage regulators being just one of those variations. This is usually
> how we quirk and deal with any board specific details, so I fail to
> understand what you mean by "quirks that match a common pattern".
> 
> Also, I don't believe other vendors are quite as concerned with
> conserving power as we are, it could be that they are just better at it
> through different ways, or we have a particular sensitivity to the subject.
> 
> > 
> > If there are generic quirks that match a common pattern seen in a lot of
> > board then properties can be defined for those, this is in fact the
> > common case.  This is no reason to just shove in some random thing that
> > doesn't describe the hardware, that's a great way to end up stuck with
> > an ABI that is fragile and difficult to understand or improve.
> 
> I would argue that at least 2 out of the 4 supplies proposed do describe
> hardware signals. The latter two are more abstract to say the least,
> however I believe it is done that way because they are composite
> supplies controlling both the 12V and 3.3V supplies coming into a PCIe
> device (Jim is that right?). So how do we call the latter supply then?
> vpcie12v3v...-supply?
> 
> > Potentially some of these things should be being handled in the bindings
> > and drivers drivers for the relevant PCI devices rather than in the PCI
> > controller.
> 
> The description and device tree binding can be and should be in a PCI
> device binding rather than pci-bus.yaml.
> 
> The handling however goes back to the chicken and egg situation that we
> talked about multiple times before: no supply -> no link UP -> no
> enumeration -> no PCI device, therefore no driver can have a chance to
> control the regulator. These are not hotplug capable systems by the way,
> but even if they were, we would still run into the same problem. Given
> that most reference boards do have mechanical connectors that people can
> plug random devices into, we cannot provide a compatible string
> containing the PCI vendor/device ID ahead of time because we don't know
> what will be plugged in. 

I thought you didn't have connectors or was it just they are 
non-standard? If the latter case, what are the supply rails for the 
connector?

I'd be okay if there's no compatible as long as there's not a continual 
stream of DT properties trying to describe power sequencing 
requirements.

> In the case of a MCM, we would, but then we
> only solved about 15% of the boards we need to support, so we have not
> really progressed much.

MCM is multi-chip module?

Rob
