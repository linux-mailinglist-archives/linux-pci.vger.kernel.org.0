Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8357D3BF1C7
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jul 2021 23:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhGGWAK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jul 2021 18:00:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229717AbhGGWAK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Jul 2021 18:00:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C88E61C4C;
        Wed,  7 Jul 2021 21:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625695049;
        bh=v0LNti4luoXSnbee2IcWr5yKje765uzZmtzhwYLqE9A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E3v080lZEtlKuiacrMg2W/HJoyoZXYdSjsMnEo0i3b8V7kPoJryIB7mBvTH07eJ4l
         hYD4UOyR7aURJLfTFO5UQ5SwDMsuOeAsn2rhEVAnxkMN3I6qczwwSGKcgMzey3Fr6v
         UGw6RAcfr01tyZj/O8jywfEQn/M4OcrgyJBC12qOL65gD2xNxgxSWziJ7s/5gz8HSp
         5wE9tCwnWvOfJoXAZt14BOOe6xjudHyw7h/R6oVArBJe6IHh5WiCjN+28nS3UmodcS
         ezBN3C501mRZ360I29Hx0A7IefJ3JCmQnQU82c3+dOTm4Jq5F9dplSwfmIXl+6cxFd
         XcpVMjAXGRD9g==
Date:   Wed, 7 Jul 2021 16:57:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        Koba Ko <koba.ko@canonical.com>,
        Rajat Jain <rajatja@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4] PCI/PM: Target PM state is D3hot if device can only
 generate PME from D3cold
Message-ID: <20210707215728.GA214645@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617123653.58640-1-mika.westerberg@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 17, 2021 at 03:36:53PM +0300, Mika Westerberg wrote:
> Some PCIe devices only support PME (Power Management Event) from D3cold.
> One example is ASMedia xHCI controller:
> 
> 11:00.0 USB controller: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller (prog-if 30 [XHCI])
>   ...
>   Capabilities: [78] Power Management version 3
>   	  Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
> 	  Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> 
> With such devices, if it has wake enabled, the kernel selects lowest
> possible power state to be D0 in pci_target_state(). This is problematic
> because it prevents the root port it is connected to enter low power
> state too which makes the system consume more energy than necessary.

IIUC this is because the loop that checks which states support PME
starts with D3hot and doesn't even look at D3cold.

> The problem in pci_target_state() is that it only accounts the "current"
> device state, so when the bridge above it (a root port for instance) is
> transitioned into D3hot the device transitions into D3cold. This is
> because when the root port is first transitioned into D3hot then the
> ACPI power resource is turned off which puts the PCIe link to L2/L3 (and
> the root port and the device are in D3cold). If the root port is kept in
> D3hot it still means that the device below it is still effectively in
> D3cold as no configuration messages pass through. Furthermore the
> implementation note of PCIe 5.0 sec 5.3.1.4 says that the device should
> expect to be transitioned into D3cold soon after its link transitions
> into L2/L3 Ready state.
> 
> Taking the above into consideration, instead of forcing the device stay
> in D0 we modify pci_target_state() to return D3hot in this special case
> and make __pci_enable_wake() to enable PME too in this case.
> 
> Reported-by: Utkarsh H Patel <utkarsh.h.patel@intel.com>
> Reported-by: Koba Ko <koba.ko@canonical.com>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> The previous version of the patch is here:
> 
> https://lore.kernel.org/linux-pm/20210616150516.28242-1-mika.westerberg@linux.intel.com/
> 
> Changes from the previous version:
> 
>   * Dropped redundant test in pci_target_state().
> 
>  drivers/pci/pci.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b717680377a9..043c5c304308 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2485,7 +2485,13 @@ static int __pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable
>  	if (enable) {
>  		int error;
>  
> -		if (pci_pme_capable(dev, state))
> +		/*
> +		 * Enable PME if device is capable from given state.
> +		 * Special case is device that can only generate PME
> +		 * from D3cold then we enable PME too.
> +		 */
> +		if (pci_pme_capable(dev, state) ||
> +		    (state == PCI_D3hot && pci_pme_capable(dev, PCI_D3cold)))
>  			pci_pme_active(dev, true);
>  		else
>  			ret = 1;
> @@ -2595,6 +2601,14 @@ static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
>  		 * PME#.
>  		 */
>  		if (dev->pme_support) {
> +			/*
> +			 * Special case if device supports only PME from
> +			 * D3cold but not from D3hot we still return D3hot.
> +			 */
> +			if (target_state == PCI_D3hot &&
> +				(dev->pme_support & (1 << PCI_D3cold)))
> +				return target_state;

I've spent quite a bit of time trying to understand this, and I'm kind
of dragging my feet on it because I haven't been able to really
connect this with the specs.  It also seems unfortunate to have to add
this special case in two places.

It seems like we're basically lying and *saying* we're going to put
the device in D3hot, but due to some magic invisible assumption, we
*actually* put it in D3cold.

>  			while (target_state
>  			      && !(dev->pme_support & (1 << target_state)))
>  				target_state--;

Nit 1: "if (target_state == PCI_D3hot && ...) return target_state;"
means "if (...) return PCI_D3hot;".  When we're returning a constant
value that we already know, I think it's clearer to use the constant.

Nit 2: it looks like both these tests should use pci_pme_capable(),
which would match the other special case in __pci_enable_wake().
