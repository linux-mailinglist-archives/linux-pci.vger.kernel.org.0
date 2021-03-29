Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C409534D896
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 21:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhC2TtX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 15:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhC2Ts7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Mar 2021 15:48:59 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE66C061574;
        Mon, 29 Mar 2021 12:48:59 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 68-20020a9d0f4a0000b02901b663e6258dso13370102ott.13;
        Mon, 29 Mar 2021 12:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZJVh4jd4a7TViDLcP04oFUzaFvaj6RI7ATnPFJO1yM=;
        b=H2a94AgTvVjaw6KwaLPzrKcmZfLzLo8GlBiQgL3VcBNcBQSR+1bLTOyLcsqLiVGGgp
         punqsas8H2DOguJtqgkIotHyJHlnPQoc1/19aaMm1IeOZEv6jvEhEsJYWFR2m0KNC7S1
         dO996YPCv4bKaD62O3HIxuY6Re7lcI6hRidHNN6y7Db/yRyIyNBBMczh9/lbfXI0xpfN
         SCWJe9eIq6paiXR5nFzl5YIz892oGsfvrwV1JN8LArztC168jssSDg6Vum5TJkiqfAIU
         ESLdqQNuBLqIBxEp78hfAN+RKPaaxUqhinvC20FUnpBH5WkTgHP5nD+8B1mFz3O5Gusp
         tybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZJVh4jd4a7TViDLcP04oFUzaFvaj6RI7ATnPFJO1yM=;
        b=c2RPovby7cBnWxkE65mPJvnCZRKIjJ7ygZ8QPhXS/xNE6af2aY9iNivnK9d6R01mOs
         gEfvA0EhHPehlXIorlBcfQvl3vdTyFBQbGLgiHfZPV69WP9gRwHor3fFMEDalnLRU9eD
         Kc/mokN/xX42nYEq7lihp1nQaFGQu754498z2N8k1fGzodFizSAaB9ZMGk+ALQ8KDxC6
         hmThLvwHasU6LROpqQQrGDTYSsuqYvgkHHm79MHeY1IiYIVtwpZhgM/hrT1h0HxE+Ho4
         YAusJqN5tl8x/CiI+o96GzORVXB2i6bi3mBr3r5FxRiOaF4q4V+zqSUTLGBH9rfCmrOE
         djeg==
X-Gm-Message-State: AOAM532zVgGksrTwQs0iqYRnB1FWKZMEsVGrzP6jc1m8xX3fv0Nw7iky
        AeWnhbBhpKVR7z4ZUq7nMIFmiU3rgbnXgIBsKAE=
X-Google-Smtp-Source: ABdhPJzZr4eOPtKELL2M99QxmfoGY3CfOePRuNX1fBdWQkPJxQeBu1FOT9tfG6nTvVdBvg+isR+dM1b84PqhQW4p2Ms=
X-Received: by 2002:a9d:5508:: with SMTP id l8mr24687829oth.233.1617047338712;
 Mon, 29 Mar 2021 12:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210326191906.43567-1-jim2101024@gmail.com> <20210326191906.43567-3-jim2101024@gmail.com>
 <20210329162539.GG5166@sirena.org.uk> <CANCKTBsBNhwG8VQQAQfAfw9jaWLkT+yYJ0oG-HBhA9xiO+jLvA@mail.gmail.com>
 <20210329171613.GI5166@sirena.org.uk>
In-Reply-To: <20210329171613.GI5166@sirena.org.uk>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Mon, 29 Mar 2021 15:48:46 -0400
Message-ID: <CANCKTBvwWdVgjgTf620KqaAyyMwPkRgO3FHOqs_Gen+bnYTJFw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] PCI: brcmstb: Add control of EP voltage regulators
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

    /* Pmap_idx to avs pmap number */
    const uint8_t pmap_idx_to_avs_id[20];

On Mon, Mar 29, 2021 at 1:16 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Mar 29, 2021 at 12:39:50PM -0400, Jim Quinlan wrote:
> > On Mon, Mar 29, 2021 at 12:25 PM Mark Brown <broonie@kernel.org>
>
> > > Here you are figuring out a device local supply name...
>
> > > > +     /*
> > > > +      * Get the regulators that the EP devianswerces require.  We cannot use
> > > > +      * pcie->dev as the device argument in regulator_bulk_get() since
> > > > +      * it will not find the regulators.  Instead, use NULL and the
> > > > +      * regulators are looked up by their name.
> > > > +      */
> > > > +     return regulator_bulk_get(NULL, pcie->num_supplies, pcie->supplies);
>
> > > ...and here you are trying to look up that device local name in the
> > > global namespace.  That's not going to work well, the global names that
> > > supplies are labelled with may be completely different to what the chip
> > > designer called them and there could easily be naming collisions between
> > > different chips.
>
> > "devm_regulator_bulk_get(pcie->dev, ...)"; is your concern about the
> > NULL for the device and if so does this fix it?  If not, what do you
> > suggest that I do?
>
> If you use the struct device for the PCIe controller then that's going
> to first try the PCIe controller then the global namespace so you still
> have all the same problems.  You really need to use the struct device
> for the device that is being supplied not some random other struct
> device you happened to find in the system.
Hello Mark,
I'm not concerned about a namespace collision and I don't think you
should be concerned either.  First, this driver is for Broadcom STB
PCIe chips and boards, and we also deliver the DT to the customers.
We typically do not have any other regulators in the DT besides the
ones I am proposing.  For example, the 7216 SOC DT has 0 other
regulators -- no namespace collision possible.  Our DT-generating
scripts also flag namespace issues.  I admit that this driver is also
used by RPi chips, but I can easily exclude this feature from the RPI
if Nicolas has any objection.

Further, if you want, I can restrict the search to the two regulators
I am proposing to add to pci-bus.yaml:  "vpcie12v-supply" and
"vpcie3v3-supply".

Is the above enough to alleviate your concerns about global namespace collision?

>
> As I said in my earlier reply I think either the driver core or PCI
> needs something like Soundwire has which lets it create struct devices
> for things that have been enumerated via software but not enumerated by
> hardware and a callback or something which lets those devices take
> whatever steps are needed to trigger probe.

Can you please elaborate this further and in detail?  This sounds like
a decent-size undertaking, and the last time I followed a review
suggestion that was similar in spirit to this, the pullreq was
ironically NAKed by the person who suggested it.  Do you really think
it is necessary to construct such a subsystem just to avoid the  very
remote possibility of a namespace collision which is our (Broadcom
STB) responsibility and consequence to avoid?

Regards,
Jim Quinlan
Broadcom STB
