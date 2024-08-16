Return-Path: <linux-pci+bounces-11773-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7D995513F
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 21:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338D41C227A0
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 19:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099F11C460C;
	Fri, 16 Aug 2024 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdWcYZJZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFFE1C3F25;
	Fri, 16 Aug 2024 19:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723835544; cv=none; b=tu1LN6grxpGYuJ+TQQ7ApbAZsuSlumCvAscTM6/Q5nPoYb6yu3Z0H/6g2uguV9yjrIuLNcpuZSvayKIh3wpoFfdiFe0P1XESvM5C51rT1NGM9iZZ2JofsseUzYGX9BcsBdZWWq+F/UObhOfgJ3KUY+g0LQCqnsRxKiGUIv9pDvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723835544; c=relaxed/simple;
	bh=yHqCmAUyZzww13O+Qa0EgW2aJCxMZVqksQq6+a9X2cA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KmFgOGj6cSoGPlRbiRwjiA+PYKCI4ms0F0D1lmqoha5OBEh0KefULyG2RDiPxgr8cveTfgPwLQsFQPEasxMc3GotsTCDVYfkltiJjV/LubtKvZx+T6vmF2aMDmdK/h0iEpi5iVl1Bq2Kg+7y7MTDAuejhBVZuL+pzw2vKGeCcJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdWcYZJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB2DC4AF12;
	Fri, 16 Aug 2024 19:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723835544;
	bh=yHqCmAUyZzww13O+Qa0EgW2aJCxMZVqksQq6+a9X2cA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SdWcYZJZ0ntMgbvL5K08ActS1yPWgsp6AOKJY5Ve+ka4icuPJRUWRLUDCOPwHKx3U
	 wXNBCiK7n1EFFrEDF5K+AtLM5e4yjT155wLSHoOi/D3L8izNPARmHFZIQ7vZ0ts+8/
	 x8OT/Ww8HM2SCGxHwMmyJnMqFf7nFqpM2bTgcZYdMBnXNQAwecLlIIUvDHDHYFy7Ti
	 Hf6OUACcrkGXu8t8bcFcYY699LU4vhDX+BWPlsZlZo3hpNKi3gN/VKeWlO1RRb1Z95
	 KckwHpLdisrCxfUXUsQR9Gi25hLRHJd30nwjLfdRHEmHV/V6Dwlwd8LNmyty+X2vaS
	 YCOFEAg8IQrUg==
Date: Fri, 16 Aug 2024 14:12:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vidya Sagar <vidyas@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] PCI: qcom-ep: Move controller cleanups to
 qcom_pcie_perst_deassert()
Message-ID: <20240816191222.GA69867@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816050029.GA2331@thinkpad>

On Fri, Aug 16, 2024 at 10:30:29AM +0530, Manivannan Sadhasivam wrote:
> On Thu, Aug 15, 2024 at 05:47:17PM -0500, Bjorn Helgaas wrote:
> > [+cc Vidya, Jon since tegra194 does similar things]
> > 
> > On Mon, Jul 29, 2024 at 05:52:45PM +0530, Manivannan Sadhasivam wrote:
> > > Currently, the endpoint cleanup function dw_pcie_ep_cleanup() and EPF
> > > deinit notify function pci_epc_deinit_notify() are called during the
> > > execution of qcom_pcie_perst_assert() i.e., when the host has asserted
> > > PERST#. But quickly after this step, refclk will also be disabled by the
> > > host.
> > > 
> > > All of the Qcom endpoint SoCs supported as of now depend on the refclk from
> > > the host for keeping the controller operational. Due to this limitation,
> > > any access to the hardware registers in the absence of refclk will result
> > > in a whole endpoint crash. Unfortunately, most of the controller cleanups
> > > require accessing the hardware registers (like eDMA cleanup performed in
> > > dw_pcie_ep_cleanup(), powering down MHI EPF etc...). So these cleanup
> > > functions are currently causing the crash in the endpoint SoC once host
> > > asserts PERST#.
> > > 
> > > One way to address this issue is by generating the refclk in the endpoint
> > > itself and not depending on the host. But that is not always possible as
> > > some of the endpoint designs do require the endpoint to consume refclk from
> > > the host (as I was told by the Qcom engineers).
> > > 
> > > So let's fix this crash by moving the controller cleanups to the start of
> > > the qcom_pcie_perst_deassert() function. qcom_pcie_perst_deassert() is
> > > called whenever the host has deasserted PERST# and it is guaranteed that
> > > the refclk would be active at this point. So at the start of this function,
> > > the controller cleanup can be performed. Once finished, rest of the code
> > > execution for PERST# deassert can continue as usual.
> > 
> > What makes this v6.11 material?  Does it fix a problem we added in
> > v6.11-rc1?
> 
> No, this is not a 6.11 material, but the rest of the patches I
> shared offline.

For reference, the patches you shared offline are:

  PCI: qcom: Use OPP only if the platform supports it
  PCI: qcom-ep: Do not enable resources during probe()
  PCI: qcom-ep: Disable MHI RAM data parity error interrupt for SA8775P SoC
  PCI: qcom-ep: Move controller cleanups to qcom_pcie_perst_deassert()

> > Is there a Fixes: commit?
> 
> Hmm, the controller addition commit could be the valid fixes tag.
> 
> > This patch essentially does this:
> > 
> >   qcom_pcie_perst_assert
> > -   pci_epc_deinit_notify
> > -   dw_pcie_ep_cleanup
> >     qcom_pcie_disable_resources
> > 
> >   qcom_pcie_perst_deassert
> > +   if (pcie_ep->cleanup_pending)
> > +     pci_epc_deinit_notify(pci->ep.epc);
> > +     dw_pcie_ep_cleanup(&pci->ep);
> >     dw_pcie_ep_init_registers
> >     pci_epc_init_notify
> > 
> > Maybe it makes sense to call both pci_epc_deinit_notify() and
> > pci_epc_init_notify() from the PERST# deassert function, but it makes
> > me question whether we really need both.
> 
> There is really no need to call pci_epc_deinit_notify() during the first
> deassert (i.e., during the ep boot) because there are no cleanups to be done.
> It is only needed during a successive PERST# assert + deassert.
> 
> > pcie-tegra194.c has a similar structure:
> > 
> >   pex_ep_event_pex_rst_assert
> >     pci_epc_deinit_notify
> >     dw_pcie_ep_cleanup
> > 
> >   pex_ep_event_pex_rst_deassert
> >     dw_pcie_ep_init_registers
> >     pci_epc_init_notify
> > 
> > Is there a reason to make them different, or could/should a similar
> > change be made to tegra?
> 
> Design wise both drivers are similar, so it could apply. I didn't
> spin a patch because if testing of tegra driver gets delayed (I've
> seen this before), then I do not want to stall merging the whole
> series. 

It can and should be separate patches, one per driver.  But I don't
want to end up with the drivers being needlessly different.

> For Qcom it is important to get this merged asap to avoid
> the crash.

If this is not v6.11 material, there's time to work this out.

> > > +	if (pcie_ep->cleanup_pending) {
> > 
> > Do we really need this flag?  I assume the cleanup functions could
> > tell whether any previous setup was done?
> 
> Not so. Some cleanup functions may trigger a warning if attempted to do it
> before 'setup'. I think dw_edma_remove() that is part of dw_pcie_ep_cleanup()
> does that IIRC.

It looks safe to me:

  dw_pcie_ep_cleanup
    dw_pcie_edma_remove
      dw_edma_remove(chip = &pci->edma)       # struct dw_pcie *pci
        dev = chip->dev
        dw = chip->dw
        if (!dw)
          return -ENODEV

but if not, it could probably be made safe by adding a NULL pointer
check and/or a "chip->dw = NULL" at the right spot.

We hardly have any cleanup functions affected by "cleanup_pending", so
I think we can decide that they should be safe before 'setup' and just
make it so.

Bjorn

