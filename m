Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9643B39BD
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 01:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhFXXbD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 19:31:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbhFXXbC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 19:31:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F6726109D;
        Thu, 24 Jun 2021 23:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624577322;
        bh=ldX9RoquT9Rh15kfP3FoVZ10xacgMSNt/9jIwP+BvEY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SsYrM7WMbzNsbAGWMcs0kcP8ECXwziLWX8RgMfJCnKWub1yrt5UXYJL9w3VUEykjL
         3uxLK5T/08vZg1d34q7VgSuXohvkB3WpNf7zjH7ZZrPSzQxvzY7pYfO+BDG6Q+S2BK
         HdtYhARYSiPn3GDJDU/7ZOZEdrDCNlVqWIIxeow45bKDtxQw/6g5dz7h5EFZMYEVLD
         kOE3Gr9bm2E30hnODihqtIAvU98kS7Fzdb0V6Q8DGPF56D3k3+bMdbOZbtOZk+6m/p
         dACxFFLrh0nqm8nIrNNU9GDxmkQ9iBe2ZK1eI4SxocJCnEZ13pPkBFluQ3h8I3I8yD
         esQ/F6WP/heoA==
Date:   Thu, 24 Jun 2021 18:28:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] PCI: rockchip: Avoid accessing PCIe registers with
 clocks gated
Message-ID: <20210624232841.GA3579021@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44c551d7-fee4-13cf-2929-6d2383dd5497@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 25, 2021 at 12:18:48AM +0100, Robin Murphy wrote:
> On 2021-06-24 22:57, Bjorn Helgaas wrote:
> > On Tue, Jun 08, 2021 at 10:04:09AM +0200, Javier Martinez Canillas wrote:
> > > IRQ handlers that are registered for shared interrupts can be called at
> > > any time after have been registered using the request_irq() function.
> > > 
> > > It's up to drivers to ensure that's always safe for these to be called.
> > > 
> > > Both the "pcie-sys" and "pcie-client" interrupts are shared, but since
> > > their handlers are registered very early in the probe function, an error
> > > later can lead to these handlers being executed before all the required
> > > resources have been properly setup.
> > > 
> > > For example, the rockchip_pcie_read() function used by these IRQ handlers
> > > expects that some PCIe clocks will already be enabled, otherwise trying
> > > to access the PCIe registers causes the read to hang and never return.
> > 
> > The read *never* completes?  That might be a bit problematic because
> > it implies that we may not be able to recover from PCIe errors.  Most
> > controllers will timeout eventually, log an error, and either
> > fabricate some data (typically ~0) to complete the CPU's read or cause
> > some kind of abort or machine check.
> > 
> > Just asking in case there's some controller configuration that should
> > be tweaked.
> 
> If I'm following correctly, that'll be a read transaction to the native side
> of the controller itself; it can't complete that read, or do anything else
> either, because it's clock-gated, and thus completely oblivious (it might be
> that if another CPU was able to enable the clocks then everything would
> carry on as normal, or it might end up totally deadlocking the SoC
> interconnect). I think it's safe to assume that in that state nothing of
> importance would be happening on the PCIe side, and even if it was we'd
> never get to know about it.

Oh, right, that makes sense.  I was thinking about the PCIe side, but
if the controller itself isn't working, of course we wouldn't get that
far.

I would expect that the CPU itself would have some kind of timeout for
the read, but that's far outside of the PCI world.

Bjorn
