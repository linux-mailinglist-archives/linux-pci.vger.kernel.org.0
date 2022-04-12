Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9E24FDDD4
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 13:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237419AbiDLLTP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 07:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbiDLLRT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 07:17:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAFD6EB19;
        Tue, 12 Apr 2022 03:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649757809; x=1681293809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vXfqR3J+ewcUKrWmgqPbzdtQRKO0k6H6IwIIS0tSB5I=;
  b=DuJEg4JlGR5SvcZgxA/ZUOVe3ifi4+5Z9WJ5T1n7wNOzX5KZmHjVAa4k
   KWEDmQys/7aU3qVxlWAsJ8KCs4a/XGSkmNe52iQKCcfdmzT4uza8Z+ErT
   lw7MZvYUxAE3lDBrZYdPNoRCLdrHgGUaQfYLJsG282HuREUQFxX7dJZD0
   Fz9gbhn9lYpa0VlyScyT7CvPkbrAdJaO2MoutZM9c22QgTxVHS7e6zakm
   rwPmVICEyRclZ605LE/Sl7ssp3OJWH9woSRQXsDEq7YWMo7KeqSFGF9JM
   za9R6OSZC/1R21F9PDtROBwhFLEyxeWycsrOZ6rguPKsuTzAKANNml+6I
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261184302"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="261184302"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 03:03:18 -0700
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="660425110"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 03:03:14 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 12 Apr 2022 13:00:45 +0300
Date:   Tue, 12 Apr 2022 13:00:45 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 4/9] PCI/PM: Rework changing power states of PCI
 devices
Message-ID: <YlVNzZRHW58QRD3c@lahna>
References: <4419002.LvFx2qVVIh@kreacher>
 <11975904.O9o76ZdvQC@kreacher>
 <13011315.uLZWGnKmhe@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13011315.uLZWGnKmhe@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 11, 2022 at 04:25:12PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There are some issues related to changing power states of PCI
> devices, mostly related to carrying out unnecessary actions in some
> places, and the code is generally hard to follow.
> 
>  1. pci_power_up() has two callers, pci_set_power_state() and
>     pci_pm_default_resume_early().  The latter updates the current
>     power state of the device right after calling pci_power_up()
>     and it restores the entire config space of the device right
>     after that, so pci_power_up() itself need not read the
>     PCI_PM_CTRL register or restore the BARs after programming the
>     device into D0 in that case.
>  
>  2. It is generally hard to get a clear view of the pci_power_up()
>     code flow, especially in some corner cases, due to all of the
>     involved PCI_PM_CTRL register reads and writes occurring in
>     pci_platform_power_transition() and in pci_raw_set_power_state(),
>     some of which are redundant.
> 
>  3. The transitions from low-power states to D0 and the other way
>     around are unnecessarily tangled in pci_raw_set_power_state()
>     which causes it to use a redundant local variable and makes it
>     rather hard to follow.
> 
> To address the above shortcomings, make the following changes:
> 
>  a. Remove the code handling transitions into D0

Should this be D3?

>     from pci_raw_set_power_state() and rename it as
>     pci_set_low_power_state().
> 
>  b. Add the code handling transitions into D0 directly
>     to pci_power_up() and to a new wrapper function
>     pci_set_full_power_state() calling it internally that is
>     only used in pci_set_power_state().
> 
>  c. Make pci_power_up() avoid redundant PCI_PM_CTRL register reads
>     and make it work in the same way for transitions from any
>     low-power states (transitions from D1 and D2 are handled
>     slightly differently before the change).
> 
>  d. Put the restoration of the BARs and the PCI_PM_CTRL
>     register read confirming the power state change into
>     pci_set_full_power_state() to avoid doing that in
>     pci_pm_default_resume_early() unnecessarily.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2:
>    * Do not add a redundant check to pci_set_low_power_state().
> 
> ---
>  drivers/pci/pci.c |  154 +++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 101 insertions(+), 53 deletions(-)
> 
> Index: linux-pm/drivers/pci/pci.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci.c
> +++ linux-pm/drivers/pci/pci.c
> @@ -1068,10 +1068,9 @@ static inline bool platform_pci_bridge_d
>  }
>  
>  /**
> - * pci_raw_set_power_state - Use PCI PM registers to set the power state of
> - *			     given PCI device
> + * pci_set_low_power_state - Program the given device into a low-power state
>   * @dev: PCI device to handle.
> - * @state: PCI power state (D0, D1, D2, D3hot) to put the device into.
> + * @state: PCI power state (D1, D2, D3hot) to put the device into.
>   *
>   * RETURN VALUE:
>   * -EINVAL if the requested state is invalid.
> @@ -1080,10 +1079,9 @@ static inline bool platform_pci_bridge_d
>   * 0 if device already is in the requested state.
>   * 0 if device's power state has been successfully changed.
>   */
> -static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
> +static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state)
>  {
>  	u16 pmcsr;
> -	bool need_restore = false;
>  
>  	/* Check if we're already there */
>  	if (dev->current_state == state)
> @@ -1092,7 +1090,7 @@ static int pci_raw_set_power_state(struc
>  	if (!dev->pm_cap)
>  		return -EIO;
>  
> -	if (state < PCI_D0 || state > PCI_D3hot)
> +	if (state < PCI_D1 || state > PCI_D3hot)
>  		return -EINVAL;
>  
>  	/*
> @@ -1101,8 +1099,7 @@ static int pci_raw_set_power_state(struc
>  	 * we can go from D1 to D3, but we can't go directly from D3 to D1;
>  	 * we'd have to go from D3 to D0, then to D1.
>  	 */
> -	if (state != PCI_D0 && dev->current_state <= PCI_D3cold
> -	    && dev->current_state > state) {
> +	if (dev->current_state <= PCI_D3cold && dev->current_state > state) {
>  		pci_err(dev, "invalid power transition (from %s to %s)\n",
>  			pci_power_name(dev->current_state),
>  			pci_power_name(state));
> @@ -1122,29 +1119,8 @@ static int pci_raw_set_power_state(struc
>  		return -EIO;
>  	}
>  
> -	/*
> -	 * If we're (effectively) in D3, force entire word to 0.
> -	 * This doesn't affect PME_Status, disables PME_En, and
> -	 * sets PowerState to 0.
> -	 */
> -	switch (dev->current_state) {
> -	case PCI_D0:
> -	case PCI_D1:
> -	case PCI_D2:
> -		pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
> -		pmcsr |= state;
> -		break;
> -	case PCI_D3hot:
> -	case PCI_D3cold:
> -	case PCI_UNKNOWN: /* Boot-up */
> -		if ((pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D3hot
> -		 && !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
> -			need_restore = true;
> -		fallthrough;	/* force to D0 */
> -	default:
> -		pmcsr = 0;
> -		break;
> -	}
> +	pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
> +	pmcsr |= state;
>  
>  	/* Enter specified state */
>  	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
> @@ -1153,9 +1129,9 @@ static int pci_raw_set_power_state(struc
>  	 * Mandatory power management transition delays; see PCI PM 1.1
>  	 * 5.6.1 table 18
>  	 */
> -	if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
> +	if (state == PCI_D3hot)
>  		pci_dev_d3_sleep(dev);
> -	else if (state == PCI_D2 || dev->current_state == PCI_D2)
> +	else if (state == PCI_D2)
>  		udelay(PCI_PM_D2_DELAY);
>  
>  	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> @@ -1165,22 +1141,6 @@ static int pci_raw_set_power_state(struc
>  			 pci_power_name(dev->current_state),
>  			 pci_power_name(state));
>  
> -	/*
> -	 * According to section 5.4.1 of the "PCI BUS POWER MANAGEMENT
> -	 * INTERFACE SPECIFICATION, REV. 1.2", a device transitioning
> -	 * from D3hot to D0 _may_ perform an internal reset, thereby
> -	 * going to "D0 Uninitialized" rather than "D0 Initialized".
> -	 * For example, at least some versions of the 3c905B and the
> -	 * 3c556B exhibit this behaviour.
> -	 *
> -	 * At least some laptop BIOSen (e.g. the Thinkpad T21) leave
> -	 * devices in a D3hot state at boot.  Consequently, we need to
> -	 * restore at least the BARs so that the device will be
> -	 * accessible to its driver.
> -	 */
> -	if (need_restore)
> -		pci_restore_bars(dev);
> -
>  	if (dev->bus->self)
>  		pcie_aspm_pm_state_change(dev->bus->self);
>  
> @@ -1312,8 +1272,54 @@ static int pci_dev_wait(struct pci_dev *
>   */
>  int pci_power_up(struct pci_dev *dev)
>  {
> -	pci_platform_power_transition(dev, PCI_D0);
> -	return pci_raw_set_power_state(dev, PCI_D0);
> +	int ret;
> +
> +	ret = pci_platform_power_transition(dev, PCI_D0);
> +	if (ret) {

Here pci_platform_power_transition() returned an error so we go and read
back the PM_CTRL to check in which power state the device is in? Perhaps
add a comment here explaining why we need to do this?

> +		u16 pmcsr;
> +
> +		/*
> +		 * The PCI_PM_CTRL register has not been read above, so read it
> +		 * now and bail out if that fails.
> +		 */
> +		pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> +		if (PCI_POSSIBLE_ERROR(pmcsr)) {
> +			dev->current_state = PCI_D3cold;
> +			goto fail;
> +		}
> +		dev->current_state = pmcsr & PCI_PM_CTRL_STATE_MASK;
> +	} else if (dev->current_state == PCI_D3cold) {
> +		/*
> +		 * Since current_state is PCI_D3cold here, the power state seen
> +		 * by the platform is still D3cold or the PCI_PM_CTRL register
> +		 * read in pci_update_current_state() has failed, so assume the
> +		 * device to be inaccessible.
> +		 */
> +		goto fail;
> +	}
> +
> +	/* There's nothing more to do if current_state is D0 at this point. */
> +	if (dev->current_state == PCI_D0)
> +		return 0;
> +
> +	/*
> +	 * Program the device into PCI_D0 by forcing the entire word to 0 (this
> +	 * doesn't affect PME_Status, disables PME_En, and sets PowerState to 0)
> +	 * and wait for the prescribed amount of time.  Assume success.
> +	 */
> +	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
> +
> +	if (dev->current_state == PCI_D3hot)
> +		pci_dev_d3_sleep(dev);
> +	else if (dev->current_state == PCI_D2)
> +		udelay(PCI_PM_D2_DELAY);
> +
> +	dev->current_state = PCI_D0;
> +	return 0;
> +
> +fail:
> +	pci_err(dev, "Unable to change power state to D0, device inaccessible\n");
> +	return -ENODEV;
>  }
>  
>  /**
> @@ -1340,6 +1346,48 @@ void pci_bus_set_current_state(struct pc
>  		pci_walk_bus(bus, __pci_dev_set_current_state, &state);
>  }
>  

Probably good to add some sort of kernel-doc to explain when this
function should be used since we have pci_power_up() too (that this one
calls).

> +static int pci_set_full_power_state(struct pci_dev *dev)
> +{
> +	pci_power_t old_state = dev->current_state;
> +	u16 pmcsr;
> +	int ret;
> +
> +	ret = pci_power_up(dev);
> +	if (ret)
> +		return ret;
> +
> +	if (!dev->pm_cap)
> +		return 0;
> +
> +	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> +
> +	dev->current_state = pmcsr & PCI_PM_CTRL_STATE_MASK;
> +	if (dev->current_state != PCI_D0) {
> +		pci_info_ratelimited(dev, "Refused to change power state from %s to D0\n",
> +				     pci_power_name(dev->current_state));
> +	} else if (old_state >= PCI_D3hot && !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET)) {
> +		/*
> +		 * According to section 5.4.1 of the "PCI BUS POWER MANAGEMENT
> +		 * INTERFACE SPECIFICATION, REV. 1.2", a device transitioning
> +		 * from D3hot to D0 _may_ perform an internal reset, thereby
> +		 * going to "D0 Uninitialized" rather than "D0 Initialized". For
> +		 * example, at least some versions of the 3c905B and the 3c556B
> +		 * exhibit this behaviour.
> +		 *
> +		 * At least some laptop BIOSen (e.g. the Thinkpad T21) leave
> +		 * devices in a D3hot state at boot. Consequently, we need to
> +		 * restore at least the BARs so that the device will be
> +		 * accessible to its driver.
> +		 */
> +		pci_restore_bars(dev);
> +	}
> +
> +	if (dev->bus->self)
> +		pcie_aspm_pm_state_change(dev->bus->self);
> +
> +	return 0;
> +}
> +
>  /**
>   * pci_set_power_state - Set the power state of a PCI device
>   * @dev: PCI device to handle.
> @@ -1381,7 +1429,7 @@ int pci_set_power_state(struct pci_dev *
>  		return 0;
>  
>  	if (state == PCI_D0)
> -		return pci_power_up(dev);
> +		return pci_set_full_power_state(dev);
>  
>  	/*
>  	 * This device is quirked not to be put into D3, so don't put it in
> @@ -1394,7 +1442,7 @@ int pci_set_power_state(struct pci_dev *
>  	 * To put device in D3cold, we put device into D3hot in native
>  	 * way, then put device into D3cold with platform ops
>  	 */
> -	error = pci_raw_set_power_state(dev, state > PCI_D3hot ?
> +	error = pci_set_low_power_state(dev, state > PCI_D3hot ?
>  					PCI_D3hot : state);
>  
>  	if (pci_platform_power_transition(dev, state))
> 
> 
