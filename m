Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7B143A65D
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 00:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbhJYWS7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 18:18:59 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:36594 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbhJYWS7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Oct 2021 18:18:59 -0400
Received: by mail-ot1-f45.google.com with SMTP id p6-20020a9d7446000000b0054e6bb223f3so16993063otk.3;
        Mon, 25 Oct 2021 15:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=08LHlZWok2cQ+wKG6iqHm59kti7V0FbDXHEgXCU1sN0=;
        b=NHxgZMieGAUKxpclh6E+QQ3hO0rvlUxf4hX7uqqN23tmH/bDpokzwFoG7sU9eRiu35
         h8mhD+8zJQZ7R9JTQa3jnBRJwSCxJTRLtozhCwqcmv1/WFfTtKVjN4kXPZC45tmI7LCF
         BwFvnCvMY5xG1m78Ex5YiRWwQAlPPuRSw3B+Ql65maBlXHCd6sdg2C+/TrNKvZaBgIMf
         TATvHDMFrj7af5H034A9ktg82lycFwwGMnsXIRjSURenK/ybUOdENMeJJbshguakXTd9
         WVNOvwdgEgghy4i+IwIWoe5zxwTfeShi44rTCwgRuMz4rZ9mDx1PMRtTYTV+pBRyx5yl
         +b4A==
X-Gm-Message-State: AOAM533w12EJ5VhyoFekDgPc+Ycgp9UO80sMtxUl9QLq7+ZLSA1zk951
        bSM4YP0zIo8bPQP658fxiQ==
X-Google-Smtp-Source: ABdhPJwuWM0273S1Z+z63K2KqAhOFpRuOY9ecdszfdaTEl33r7hEZmIj1AusOBFj9m5MZ2a40Gh+AQ==
X-Received: by 2002:a9d:1b4f:: with SMTP id l73mr16215619otl.200.1635200196169;
        Mon, 25 Oct 2021 15:16:36 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bf3sm4380920oib.34.2021.10.25.15.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:16:35 -0700 (PDT)
Received: (nullmailer pid 1182134 invoked by uid 1000);
        Mon, 25 Oct 2021 22:16:34 -0000
Date:   Mon, 25 Oct 2021 17:16:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
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
Message-ID: <YXcswoP6fLiMs7G5@robh.at.kernel.org>
References: <20211022140714.28767-1-jim2101024@gmail.com>
 <20211022140714.28767-5-jim2101024@gmail.com>
 <YXLLRLwMG7nEwQoi@sirena.org.uk>
 <CA+-6iNzmkB5sUL6aqA6229BhxBhF3RKvGsLh0JCYQwP_2wSGaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNzmkB5sUL6aqA6229BhxBhF3RKvGsLh0JCYQwP_2wSGaQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 22, 2021 at 03:15:59PM -0400, Jim Quinlan wrote:
> On Fri, Oct 22, 2021 at 10:31 AM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Fri, Oct 22, 2021 at 10:06:57AM -0400, Jim Quinlan wrote:
> >
> > > +static const char * const supplies[] = {
> > > +     "vpcie3v3-supply",
> > > +     "vpcie3v3aux-supply",
> > > +     "brcm-ep-a-supply",
> > > +     "brcm-ep-b-supply",
> > > +};
> >
> > Why are you including "-supply" in the names here?  That will lead to
> > a double -supply when we look in the DT which probably isn't what you're
> > looking for.
> I'm not sure how this got past testing; will fix.
> 
> >
> > Also are you *sure* that the device has supplies with names like
> > "brcm-ep-a"?  That seems rather unidiomatic for electrical engineering,
> > the names here are supposed to correspond to the names used in the
> > datasheet for the part.
> I try to explain this in the commit message of"PCI: allow for callback
> to prepare nascent subdev".  Wrt to the names,
> 
>        "These regulators typically govern the actual power supply to the
>         endpoint chip.  Sometimes they may be a the official PCIe socket
>         power -- such as 3.3v or aux-3.3v.  Sometimes they are truly
>         the regulator(s) that supply power to the EP chip."
> 
> Each different SOC./board we deal with may present different ways of
> making the EP device power on.  We are using
> an abstraction name "brcm-ep-a"  to represent some required regulator
> to make the EP  work for a specific board.  The RC
> driver cannot hard code a descriptive name as it must work for all
> boards designed by us, others, and third parties.
> The EP driver also doesn't know  or care about the regulator name, and
> this driver is often closed source and often immutable.  The EP
> device itself may come from Brcm, a third party,  or sometimes a competitor.
> 
> Basically, we find using a generic name such as "brcm-ep-a-supply"
> quite handy and many of our customers embrace this feature.
> I know that Rob was initially against such a generic name, but I
> vaguely remember him seeing some merit to this, perhaps a tiny bit :-)
> Or my memory is shot, which could very well be the case.

I don't recall being in favor of this. If you've got standard rails 
(3.3V and 12V), then I'm fine with standard properties for them with or 
without a slot.

Rob
