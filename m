Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450E5437E73
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 21:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhJVTSa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 15:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbhJVTSa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Oct 2021 15:18:30 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415FCC061764
        for <linux-pci@vger.kernel.org>; Fri, 22 Oct 2021 12:16:12 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id y132-20020a1c7d8a000000b0032ca5765d6cso959566wmc.0
        for <linux-pci@vger.kernel.org>; Fri, 22 Oct 2021 12:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oEAmkv1pjl7JjH6MEH5XGy7T6DQ3usFjVUbp0ytNU9A=;
        b=POpdBM5gLe/dm2OSlr6qLVrH8LhMwWMuEqTW7mZGgv2BfnUsxuqUvVIap767IC/W93
         oOCh8IOC+vkYgAagu4iZ38nzjhP8xX1wektHeMQRU9paqAJPepazVluV+bWHOfUTS5Ta
         PNJMIt1P7GyHKKRnz+fg9+Fozhmhb4ETqQiUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oEAmkv1pjl7JjH6MEH5XGy7T6DQ3usFjVUbp0ytNU9A=;
        b=isA7TrFZE9PxvyGCp1a5fZOe3McdSyHAveZpjY9+zrcDC7zX5FbiZ6YWR0OPvb1AZf
         lzpDa2RHq9VJZ5jT4eqE2fWpRdsGxRup+DRWuxtKUnOPfC3sCnjVYFMoHqLKxovhdDOl
         Cb3iNs8lub5ZtBvokXESo52zr+Qjnn2xowEe88THO/7qJZtBTSut4TWgh4KD4gTCcvlx
         egTfi82D0f+UrS/V4PRkEwm8/z/LC9YhF7mSuFVcDGjcadIrXlP57WtX9tG8zOPkh+Kf
         quBVTuC32RPwZNqFSGU/FxXm/pGl5AP/4WV6x1dcJuB7K1gkhIKpK0pl7PmowjhZoeXX
         tvFw==
X-Gm-Message-State: AOAM530M6FENLNJyKJHpoF48072lGpVH2ctQzEArOMlzktkqyd6YO7/H
        K4zdHwdLW6ScMJd6r36SMBzLPUWYthDkBspt8xJiJg==
X-Google-Smtp-Source: ABdhPJxznCu+WcHErA4OK6hbVaioEGVYhtdrI6+wpuzeBvigNepsP6VPg9kfpEKXCCnNxJkRkt1H/M2SiT4zcC9JtEg=
X-Received: by 2002:a1c:750b:: with SMTP id o11mr1742971wmc.5.1634930170743;
 Fri, 22 Oct 2021 12:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <20211022140714.28767-1-jim2101024@gmail.com> <20211022140714.28767-5-jim2101024@gmail.com>
 <YXLLRLwMG7nEwQoi@sirena.org.uk>
In-Reply-To: <YXLLRLwMG7nEwQoi@sirena.org.uk>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Fri, 22 Oct 2021 15:15:59 -0400
Message-ID: <CA+-6iNzmkB5sUL6aqA6229BhxBhF3RKvGsLh0JCYQwP_2wSGaQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] PCI: brcmstb: Add control of subdevice voltage regulators
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 22, 2021 at 10:31 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Oct 22, 2021 at 10:06:57AM -0400, Jim Quinlan wrote:
>
> > +static const char * const supplies[] = {
> > +     "vpcie3v3-supply",
> > +     "vpcie3v3aux-supply",
> > +     "brcm-ep-a-supply",
> > +     "brcm-ep-b-supply",
> > +};
>
> Why are you including "-supply" in the names here?  That will lead to
> a double -supply when we look in the DT which probably isn't what you're
> looking for.
I'm not sure how this got past testing; will fix.

>
> Also are you *sure* that the device has supplies with names like
> "brcm-ep-a"?  That seems rather unidiomatic for electrical engineering,
> the names here are supposed to correspond to the names used in the
> datasheet for the part.
I try to explain this in the commit message of"PCI: allow for callback
to prepare nascent subdev".  Wrt to the names,

       "These regulators typically govern the actual power supply to the
        endpoint chip.  Sometimes they may be a the official PCIe socket
        power -- such as 3.3v or aux-3.3v.  Sometimes they are truly
        the regulator(s) that supply power to the EP chip."

Each different SOC./board we deal with may present different ways of
making the EP device power on.  We are using
an abstraction name "brcm-ep-a"  to represent some required regulator
to make the EP  work for a specific board.  The RC
driver cannot hard code a descriptive name as it must work for all
boards designed by us, others, and third parties.
The EP driver also doesn't know  or care about the regulator name, and
this driver is often closed source and often immutable.  The EP
device itself may come from Brcm, a third party,  or sometimes a competitor.

Basically, we find using a generic name such as "brcm-ep-a-supply"
quite handy and many of our customers embrace this feature.
I know that Rob was initially against such a generic name, but I
vaguely remember him seeing some merit to this, perhaps a tiny bit :-)
Or my memory is shot, which could very well be the case.

>
> > +     /* This is for Broadcom STB/CM chips only */
> > +     if (pcie->type == BCM2711)
> > +             return 0;
>
> It is a relief that other chips have managed to work out how to avoid
> requiring power.
I'm not sure that the other Broadcom groups have our customers, our
customers' requirements, and the amount and variation of boards that
run our PCIe driver on the SOC.

Jim
