Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F183F6A64
	for <lists+linux-pci@lfdr.de>; Tue, 24 Aug 2021 22:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbhHXUaQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Aug 2021 16:30:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232122AbhHXUaL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Aug 2021 16:30:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2F8B61139;
        Tue, 24 Aug 2021 20:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629836967;
        bh=HQsWvV8TV7qqPx5tkk6zEg6d0THtw0M1zSBYG0+FXmM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=K/Tw7ZlbdNkpIaO6oyzFmAAAzaum09NyvSKjD4CShjnsOppD3snICoDL2XD7AxIgx
         X9I/wCSwHSZaLvWywlpz3HmggK+DRCRIRo3RetksksrcOX8WB2jGnIvac6qevO9O0Q
         2B0GkHQGzqcfrIY936DGo9U3Bx7MZnOI0clsFCIPmcT4D9TMnNoDvGn3Lc9iCDiEOJ
         U1DdzFxyxvZho/calHxj99azcELX4zXrJfDxK8A/XOy2gjNkq0oHRrB3QMxwi7FFKA
         GIenD1Yz9aM7+sSgzUPgG6T3cl5WyBfifMVQ4KjVSgJTUN3zLGSEJAeZr7ElF6ozQ+
         oO60yUJ84jI2g==
Date:   Tue, 24 Aug 2021 15:29:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dwc: Perform host_init() before registering
 msi
Message-ID: <20210824202925.GA3491441@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSVTdedrDSgSYgwm@ripper>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 24, 2021 at 01:15:49PM -0700, Bjorn Andersson wrote:
> On Tue 24 Aug 12:05 PDT 2021, Bjorn Helgaas wrote:
> 
> > On Mon, Aug 23, 2021 at 08:49:57AM -0700, Bjorn Andersson wrote:
> > > On the Qualcomm sc8180x platform the bootloader does something related
> > > to PCI that leaves a pending "msi" interrupt, which with the current
> > > ordering often fires before init has a chance to enable the clocks that
> > > are necessary for the interrupt handler to access the hardware.
> > > 
> > > Move the host_init() call before the registration of the "msi" interrupt
> > > handler to ensure the host driver has a chance to enable the clocks.
> > 
> > Did you audit other drivers for similar issues?  If they do, we should
> > fix them all at once.
> 
> I only looked at the DesignWware drivers, in an attempt to find any
> issues the proposed reordering.
> 
> The set of bugs causes by drivers registering interrupts before critical
> resources tends to be rather visible and I don't know if there's much
> value in speculatively "fixing" drivers.
> 
> E.g. a quick look through the drivers I see a similar pattern in
> pci-tegra.c, but it's unlikely that they have the similar problem in
> practice and I have no way to validate that a change to the order would
> have a positive effect - or any side effects.
> 
> Or am I misunderstanding your request?

That is exactly my request.  I'm not sure if the potential issue you
noticed in pci-tegra.c is similar to the one I mentioned here:

  https://lore.kernel.org/linux-pci/20210624224040.GA3567297@bjorn-Precision-5520/

but I am actually in favor of speculatively fixing drivers even though
they're hard to test.  Code like this tends to get copied to other
places, and fixing several drivers sometimes exposes opportunities for
refactoring and sharing code.

Bjorn
