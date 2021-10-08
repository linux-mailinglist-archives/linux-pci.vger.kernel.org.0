Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A306426FBB
	for <lists+linux-pci@lfdr.de>; Fri,  8 Oct 2021 19:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhJHRuK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Oct 2021 13:50:10 -0400
Received: from foss.arm.com ([217.140.110.172]:38918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231217AbhJHRuH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Oct 2021 13:50:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8332B1063;
        Fri,  8 Oct 2021 10:48:11 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6FFC3F766;
        Fri,  8 Oct 2021 10:48:09 -0700 (PDT)
Date:   Fri, 8 Oct 2021 18:48:03 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vidyas@nvidia.com
Subject: Re: [PATCH v2 1/2] PCI: dwc: Perform host_init() before registering
 msi
Message-ID: <20211008174803.GA32277@lpieralisi>
References: <YSVTdedrDSgSYgwm@ripper>
 <20210824202925.GA3491441@bjorn-Precision-5520>
 <YSVjQgDmatkkCxtn@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSVjQgDmatkkCxtn@ripper>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Vidya]

On Tue, Aug 24, 2021 at 02:23:14PM -0700, Bjorn Andersson wrote:
> On Tue 24 Aug 13:29 PDT 2021, Bjorn Helgaas wrote:
> 
> > On Tue, Aug 24, 2021 at 01:15:49PM -0700, Bjorn Andersson wrote:
> > > On Tue 24 Aug 12:05 PDT 2021, Bjorn Helgaas wrote:
> > > 
> > > > On Mon, Aug 23, 2021 at 08:49:57AM -0700, Bjorn Andersson wrote:
> > > > > On the Qualcomm sc8180x platform the bootloader does something related
> > > > > to PCI that leaves a pending "msi" interrupt, which with the current
> > > > > ordering often fires before init has a chance to enable the clocks that
> > > > > are necessary for the interrupt handler to access the hardware.
> > > > > 
> > > > > Move the host_init() call before the registration of the "msi" interrupt
> > > > > handler to ensure the host driver has a chance to enable the clocks.
> > > > 
> > > > Did you audit other drivers for similar issues?  If they do, we should
> > > > fix them all at once.
> > > 
> > > I only looked at the DesignWware drivers, in an attempt to find any
> > > issues the proposed reordering.
> > > 
> > > The set of bugs causes by drivers registering interrupts before critical
> > > resources tends to be rather visible and I don't know if there's much
> > > value in speculatively "fixing" drivers.
> > > 
> > > E.g. a quick look through the drivers I see a similar pattern in
> > > pci-tegra.c, but it's unlikely that they have the similar problem in
> > > practice and I have no way to validate that a change to the order would
> > > have a positive effect - or any side effects.
> > > 
> > > Or am I misunderstanding your request?
> > 
> > That is exactly my request.
> 
> Okay.
> 
> > I'm not sure if the potential issue you
> > noticed in pci-tegra.c is similar to the one I mentioned here:
> > 
> >   https://lore.kernel.org/linux-pci/20210624224040.GA3567297@bjorn-Precision-5520/
> > 
> 
> As I still have the tegra driver open, I share your concern about the
> use of potentially uninitialized variables.
> 
> The problem I was concerned about was however the same as in my patch
> and the rockchip one, that if the tegra hardware isn't clocked the
> pm_runtime_get_sync() (which would turn on power and clock) happens
> after setting up the msi chain handler...
> 
> > but I am actually in favor of speculatively fixing drivers even though
> > they're hard to test.  Code like this tends to get copied to other
> > places, and fixing several drivers sometimes exposes opportunities for
> > refactoring and sharing code.
> > 
> 
> Looking through the other cases mentioned in your reply above certainly
> gives a feeling that this problem has been inherited from driver to
> driver...
> 
> I've added a ticket to my backlog to take a deeper look at this.

Vidya, can you look into this please ? In the meantime I would merge
this series.

Thanks,
Lorenzo

> 
> Regards,
> Bjorn
