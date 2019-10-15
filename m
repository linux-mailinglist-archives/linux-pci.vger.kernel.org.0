Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78DBBD7FF7
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 21:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389654AbfJOTUU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 15:20:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfJOTUT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Oct 2019 15:20:19 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83F5B20854;
        Tue, 15 Oct 2019 19:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571167217;
        bh=nm/8Au21VodRlss2uP12IzrkFOHeWZtsigxeMX4xdvg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Y9eQxQ8eeOLe4bEHt5LRnA/jIuE1RuSSEq1ZbkroD6GqEpkEajpxa/6OXzV77b9+N
         4RHncj5xNgL9OTFt7KL2cXmo/RBVCL9jF/CrcxHnlxzwY8fvRh7NbyH0ZjkQZeLtba
         OIexIAahn1cXKgcQKFveVZGW2FqlDpRy7iO5k+QE=
Date:   Tue, 15 Oct 2019 14:20:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Daniel Drake <drake@endlessm.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: PM: Fix pci_power_up()
Message-ID: <20191015192013.GA115182@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5720276.eiOaOx1Qyb@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 14, 2019 at 01:25:00PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There is an arbitrary difference between the system resume and
> runtime resume code paths for PCI devices regarding the delay to
> apply when switching the devices from D3cold to D0.
> 
> Namely, pci_restore_standard_config() used in the runtime resume
> code path calls pci_set_power_state() which in turn invokes
> __pci_start_power_transition() to power up the device through the
> platform firmware and that function applies the transition delay
> (as per PCI Express Base Specification Revision 2.0, Section 6.6.1).
> However, pci_pm_default_resume_early() used in the system resume
> code path calls pci_power_up() which doesn't apply the delay at
> all and that causes issues to occur during resume from
> suspend-to-idle on some systems where the delay is required.
> 
> Since there is no reason for that difference to exist, modify
> pci_power_up() to follow pci_set_power_state() more closely and
> invoke __pci_start_power_transition() from there to call the
> platform firmware to power up the device (in case that's necessary).
> 
> Fixes: db288c9c5f9d ("PCI / PM: restore the original behavior of pci_set_power_state()")
> Reported-by: Daniel Drake <drake@endlessm.com> 
> Link: https://lore.kernel.org/linux-pm/CAD8Lp44TYxrMgPLkHCqF9hv6smEurMXvmmvmtyFhZ6Q4SE+dig@mail.gmail.com/T/#m21be74af263c6a34f36e0fc5c77c5449d9406925
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Daniel, please test this one.
> 
> ---
>  drivers/pci/pci.c |   24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> Index: linux-pm/drivers/pci/pci.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci.c
> +++ linux-pm/drivers/pci/pci.c
> @@ -959,19 +959,6 @@ void pci_refresh_power_state(struct pci_
>  }
>  
>  /**
> - * pci_power_up - Put the given device into D0 forcibly
> - * @dev: PCI device to power up
> - */
> -void pci_power_up(struct pci_dev *dev)
> -{
> -	if (platform_pci_power_manageable(dev))
> -		platform_pci_set_power_state(dev, PCI_D0);
> -
> -	pci_raw_set_power_state(dev, PCI_D0);
> -	pci_update_current_state(dev, PCI_D0);
> -}
> -
> -/**
>   * pci_platform_power_transition - Use platform to change device power state
>   * @dev: PCI device to handle.
>   * @state: State to put the device into.
> @@ -1154,6 +1141,17 @@ int pci_set_power_state(struct pci_dev *
>  EXPORT_SYMBOL(pci_set_power_state);
>  
>  /**
> + * pci_power_up - Put the given device into D0 forcibly

Not specifically for this patch, but what does "forcibly" mean?

> + * @dev: PCI device to power up
> + */
> +void pci_power_up(struct pci_dev *dev)
> +{
> +	__pci_start_power_transition(dev, PCI_D0);
> +	pci_raw_set_power_state(dev, PCI_D0);
> +	pci_update_current_state(dev, PCI_D0);

There's not very much difference between:

  pci_power_up(dev);

and

  pci_set_power_state(dev, PCI_D0);

It looks like the main difference is that pci_set_power_state() calls
__pci_complete_power_transition(), which ultimately calls
acpi_pci_set_power_state() (for ACPI systems).

So maybe "forcibly" means something like "ignoring any platform power
management methods"?  It's not obvious to me when we should skip the
platform stuff or whether the skipping should be done at the high
level (like calling either pci_power_up() or pci_set_power_state()) or
at a lower level (e.g., if everybody called pci_set_power_state() and
it could internally tell whether we're skipping the platform part).

If we could unify the paths as much as possible, that would be nice,
but if it's not feasible, it's not feasible.  If you'd like me to push
this for v5.4, let me know, otherwise you can apply my:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> +}
> +
> +/**
>   * pci_choose_state - Choose the power state of a PCI device
>   * @dev: PCI device to be suspended
>   * @state: target sleep state for the whole system. This is the value
> 
> 
> 
