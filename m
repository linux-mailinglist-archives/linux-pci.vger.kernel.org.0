Return-Path: <linux-pci+bounces-2834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7867C842D30
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 20:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0F71C23C2E
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 19:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE1A383BA;
	Tue, 30 Jan 2024 19:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSDbgjF0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF59C7B3FD;
	Tue, 30 Jan 2024 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643806; cv=none; b=c5W8YZxMlsKlrVjO/oAYA8zxL8OLoPqjFnLwAiROvI0CUGLBfP1iH42JCrnmSElLHPzDhzKOdAOLJhr69rg8ae4LDbdxEg8MOFahBQp5l11bQMzUNnbYeJQLEnwcUDeeXfHsM2BkBONEQrkJXvgHyyW7jJYJttS0xH3243h62Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643806; c=relaxed/simple;
	bh=3Ug59DhsbWtaDECOUP7MC980BUbagoeBB9DWV2TKW0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cqFwGc828gdmZRpkMFZlljxLlksu5nnb52dJ8Eu6qwbCROBDtJkH3FWze6X96IoZ5QGhUxcW4s1Ezf3Ac6FVNZHXLwg2+QBfXyCGseXlZastqMEnkQJeM6R+vfVSJWeLlXxDcwidCdRGiPT0NNe2+z0X+YgydBnfZux2j9qMZOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSDbgjF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D96C433F1;
	Tue, 30 Jan 2024 19:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706643805;
	bh=3Ug59DhsbWtaDECOUP7MC980BUbagoeBB9DWV2TKW0Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sSDbgjF0W89p/dcFPgm6mKD97ZFchWjPBuDxEkvuSpSHPxDJN/iiS33YnOj85WDC4
	 HBqS8uVeBKVAoHZ1SIltT4H+zvW6ES7lmODpbcVDOgQXM4cKHiiwdO1xgQq4whm/to
	 sot91kYUd5kUjchvfPzaaHu0jplIHO71ohZ3K9p+ZkIazvqxRpuG1xj9ozXcYuOU6y
	 Xw/ACEHvQYZsSO0v8QQkGJTqEDiB8w6XoeLTgHKEG7uXvj24MKc5Cn00OKdZILGbyX
	 SQbHdInjTrz1TC6PQMHfg1kPcFdJqzSomYJx/qJVV/XyQ71Pi/8AzvCKICkIzqB1ZP
	 I3DO+uVMVfqyw==
Date: Tue, 30 Jan 2024 13:43:23 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Fix another deadlock when enabling ASPM
Message-ID: <20240130194323.GA530736@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130100243.11011-1-johan+linaro@kernel.org>

On Tue, Jan 30, 2024 at 11:02:43AM +0100, Johan Hovold wrote:
> A last minute revert in 6.7-final introduced a potential deadlock when
> enabling ASPM during probe of Qualcomm PCIe controllers as reported by
> lockdep:
> 
>    ============================================
>    WARNING: possible recursive locking detected
>    6.7.0 #40 Not tainted
>    --------------------------------------------
>    kworker/u16:5/90 is trying to acquire lock:
>    ffffacfa78ced000 (pci_bus_sem){++++}-{3:3}, at: pcie_aspm_pm_state_change+0x58/0xdc
> 
>                but task is already holding lock:
>    ffffacfa78ced000 (pci_bus_sem){++++}-{3:3}, at: pci_walk_bus+0x34/0xbc
> 
>                other info that might help us debug this:
>     Possible unsafe locking scenario:
> 
>           CPU0
>           ----
>      lock(pci_bus_sem);
>      lock(pci_bus_sem);
> 
>                 *** DEADLOCK ***
> 
>    Call trace:
>     print_deadlock_bug+0x25c/0x348
>     __lock_acquire+0x10a4/0x2064
>     lock_acquire+0x1e8/0x318
>     down_read+0x60/0x184
>     pcie_aspm_pm_state_change+0x58/0xdc
>     pci_set_full_power_state+0xa8/0x114
>     pci_set_power_state+0xc4/0x120
>     qcom_pcie_enable_aspm+0x1c/0x3c [pcie_qcom]
>     pci_walk_bus+0x64/0xbc
>     qcom_pcie_host_post_init_2_7_0+0x28/0x34 [pcie_qcom]
> 
> The deadlock can easily be reproduced on machines like the Lenovo
> ThinkPad X13s by adding a delay to increase the race window during
> asynchronous probe where another thread can take a write lock.
> 
> Add a new pci_set_power_state_locked() and associated helper functions
> that can be called with the PCI bus semaphore held to avoid taking the
> read lock twice.
> 
> Fixes: f93e71aea6c6 ("Revert "PCI/ASPM: Remove pcie_aspm_pm_state_change()"")
> Cc: stable@vger.kernel.org	# 6.7
> Link: https://lore.kernel.org/r/ZZu0qx2cmn7IwTyQ@hovoldconsulting.com
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Applied to for-linus for v6.8, thanks!

> ---
>  drivers/pci/bus.c                      | 50 +++++++++++------
>  drivers/pci/controller/dwc/pcie-qcom.c |  2 +-
>  drivers/pci/pci.c                      | 78 +++++++++++++++++---------
>  drivers/pci/pci.h                      |  4 +-
>  drivers/pci/pcie/aspm.c                | 13 +++--
>  include/linux/pci.h                    |  5 ++
>  6 files changed, 102 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 9c2137dae429..116415f91195 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -386,21 +386,8 @@ void pci_bus_add_devices(const struct pci_bus *bus)
>  }
>  EXPORT_SYMBOL(pci_bus_add_devices);
>  
> -/** pci_walk_bus - walk devices on/under bus, calling callback.
> - *  @top      bus whose devices should be walked
> - *  @cb       callback to be called for each device found
> - *  @userdata arbitrary pointer to be passed to callback.
> - *
> - *  Walk the given bus, including any bridged devices
> - *  on buses under this bus.  Call the provided callback
> - *  on each device found.
> - *
> - *  We check the return of @cb each time. If it returns anything
> - *  other than 0, we break out.
> - *
> - */
> -void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
> -		  void *userdata)
> +static void __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
> +			   void *userdata, bool locked)
>  {
>  	struct pci_dev *dev;
>  	struct pci_bus *bus;
> @@ -408,7 +395,8 @@ void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
>  	int retval;
>  
>  	bus = top;
> -	down_read(&pci_bus_sem);
> +	if (!locked)
> +		down_read(&pci_bus_sem);
>  	next = top->devices.next;
>  	for (;;) {
>  		if (next == &bus->devices) {
> @@ -431,10 +419,38 @@ void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
>  		if (retval)
>  			break;
>  	}
> -	up_read(&pci_bus_sem);
> +	if (!locked)
> +		up_read(&pci_bus_sem);
> +}
> +
> +/**
> + *  pci_walk_bus - walk devices on/under bus, calling callback.
> + *  @top      bus whose devices should be walked
> + *  @cb       callback to be called for each device found
> + *  @userdata arbitrary pointer to be passed to callback.
> + *
> + *  Walk the given bus, including any bridged devices
> + *  on buses under this bus.  Call the provided callback
> + *  on each device found.
> + *
> + *  We check the return of @cb each time. If it returns anything
> + *  other than 0, we break out.
> + *
> + */
> +void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *), void *userdata)
> +{
> +	__pci_walk_bus(top, cb, userdata, false);
>  }
>  EXPORT_SYMBOL_GPL(pci_walk_bus);
>  
> +void pci_walk_bus_locked(struct pci_bus *top, int (*cb)(struct pci_dev *, void *), void *userdata)
> +{
> +	lockdep_assert_held(&pci_bus_sem);
> +
> +	__pci_walk_bus(top, cb, userdata, true);
> +}
> +EXPORT_SYMBOL_GPL(pci_walk_bus_locked);
> +
>  struct pci_bus *pci_bus_get(struct pci_bus *bus)
>  {
>  	if (bus)
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 10f2d0bb86be..2ce2a3bd932b 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -972,7 +972,7 @@ static int qcom_pcie_enable_aspm(struct pci_dev *pdev, void *userdata)
>  	 * Downstream devices need to be in D0 state before enabling PCI PM
>  	 * substates.
>  	 */
> -	pci_set_power_state(pdev, PCI_D0);
> +	pci_set_power_state_locked(pdev, PCI_D0);
>  	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
>  
>  	return 0;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d8f11a078924..9ab9b1008d8b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1354,6 +1354,7 @@ int pci_power_up(struct pci_dev *dev)
>  /**
>   * pci_set_full_power_state - Put a PCI device into D0 and update its state
>   * @dev: PCI device to power up
> + * @locked: whether pci_bus_sem is held
>   *
>   * Call pci_power_up() to put @dev into D0, read from its PCI_PM_CTRL register
>   * to confirm the state change, restore its BARs if they might be lost and
> @@ -1363,7 +1364,7 @@ int pci_power_up(struct pci_dev *dev)
>   * to D0, it is more efficient to use pci_power_up() directly instead of this
>   * function.
>   */
> -static int pci_set_full_power_state(struct pci_dev *dev)
> +static int pci_set_full_power_state(struct pci_dev *dev, bool locked)
>  {
>  	u16 pmcsr;
>  	int ret;
> @@ -1399,7 +1400,7 @@ static int pci_set_full_power_state(struct pci_dev *dev)
>  	}
>  
>  	if (dev->bus->self)
> -		pcie_aspm_pm_state_change(dev->bus->self);
> +		pcie_aspm_pm_state_change(dev->bus->self, locked);
>  
>  	return 0;
>  }
> @@ -1428,10 +1429,22 @@ void pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state)
>  		pci_walk_bus(bus, __pci_dev_set_current_state, &state);
>  }
>  
> +static void __pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state, bool locked)
> +{
> +	if (!bus)
> +		return;
> +
> +	if (locked)
> +		pci_walk_bus_locked(bus, __pci_dev_set_current_state, &state);
> +	else
> +		pci_walk_bus(bus, __pci_dev_set_current_state, &state);
> +}
> +
>  /**
>   * pci_set_low_power_state - Put a PCI device into a low-power state.
>   * @dev: PCI device to handle.
>   * @state: PCI power state (D1, D2, D3hot) to put the device into.
> + * @locked: whether pci_bus_sem is held
>   *
>   * Use the device's PCI_PM_CTRL register to put it into a low-power state.
>   *
> @@ -1442,7 +1455,7 @@ void pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state)
>   * 0 if device already is in the requested state.
>   * 0 if device's power state has been successfully changed.
>   */
> -static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state)
> +static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool locked)
>  {
>  	u16 pmcsr;
>  
> @@ -1496,29 +1509,12 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state)
>  				     pci_power_name(state));
>  
>  	if (dev->bus->self)
> -		pcie_aspm_pm_state_change(dev->bus->self);
> +		pcie_aspm_pm_state_change(dev->bus->self, locked);
>  
>  	return 0;
>  }
>  
> -/**
> - * pci_set_power_state - Set the power state of a PCI device
> - * @dev: PCI device to handle.
> - * @state: PCI power state (D0, D1, D2, D3hot) to put the device into.
> - *
> - * Transition a device to a new power state, using the platform firmware and/or
> - * the device's PCI PM registers.
> - *
> - * RETURN VALUE:
> - * -EINVAL if the requested state is invalid.
> - * -EIO if device does not support PCI PM or its PM capabilities register has a
> - * wrong version, or device doesn't support the requested state.
> - * 0 if the transition is to D1 or D2 but D1 and D2 are not supported.
> - * 0 if device already is in the requested state.
> - * 0 if the transition is to D3 but D3 is not supported.
> - * 0 if device's power state has been successfully changed.
> - */
> -int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
> +static int __pci_set_power_state(struct pci_dev *dev, pci_power_t state, bool locked)
>  {
>  	int error;
>  
> @@ -1542,7 +1538,7 @@ int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>  		return 0;
>  
>  	if (state == PCI_D0)
> -		return pci_set_full_power_state(dev);
> +		return pci_set_full_power_state(dev, locked);
>  
>  	/*
>  	 * This device is quirked not to be put into D3, so don't put it in
> @@ -1556,16 +1552,16 @@ int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>  		 * To put the device in D3cold, put it into D3hot in the native
>  		 * way, then put it into D3cold using platform ops.
>  		 */
> -		error = pci_set_low_power_state(dev, PCI_D3hot);
> +		error = pci_set_low_power_state(dev, PCI_D3hot, locked);
>  
>  		if (pci_platform_power_transition(dev, PCI_D3cold))
>  			return error;
>  
>  		/* Powering off a bridge may power off the whole hierarchy */
>  		if (dev->current_state == PCI_D3cold)
> -			pci_bus_set_current_state(dev->subordinate, PCI_D3cold);
> +			__pci_bus_set_current_state(dev->subordinate, PCI_D3cold, locked);
>  	} else {
> -		error = pci_set_low_power_state(dev, state);
> +		error = pci_set_low_power_state(dev, state, locked);
>  
>  		if (pci_platform_power_transition(dev, state))
>  			return error;
> @@ -1573,8 +1569,38 @@ int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>  
>  	return 0;
>  }
> +
> +/**
> + * pci_set_power_state - Set the power state of a PCI device
> + * @dev: PCI device to handle.
> + * @state: PCI power state (D0, D1, D2, D3hot) to put the device into.
> + *
> + * Transition a device to a new power state, using the platform firmware and/or
> + * the device's PCI PM registers.
> + *
> + * RETURN VALUE:
> + * -EINVAL if the requested state is invalid.
> + * -EIO if device does not support PCI PM or its PM capabilities register has a
> + * wrong version, or device doesn't support the requested state.
> + * 0 if the transition is to D1 or D2 but D1 and D2 are not supported.
> + * 0 if device already is in the requested state.
> + * 0 if the transition is to D3 but D3 is not supported.
> + * 0 if device's power state has been successfully changed.
> + */
> +int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
> +{
> +	return __pci_set_power_state(dev, state, false);
> +}
>  EXPORT_SYMBOL(pci_set_power_state);
>  
> +int pci_set_power_state_locked(struct pci_dev *dev, pci_power_t state)
> +{
> +	lockdep_assert_held(&pci_bus_sem);
> +
> +	return __pci_set_power_state(dev, state, true);
> +}
> +EXPORT_SYMBOL(pci_set_power_state_locked);
> +
>  #define PCI_EXP_SAVE_REGS	7
>  
>  static struct pci_cap_saved_state *_pci_find_saved_cap(struct pci_dev *pci_dev,
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2336a8d1edab..e9750b1b19ba 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -571,12 +571,12 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
>  #ifdef CONFIG_PCIEASPM
>  void pcie_aspm_init_link_state(struct pci_dev *pdev);
>  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
> -void pcie_aspm_pm_state_change(struct pci_dev *pdev);
> +void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked);
>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
>  #else
>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
> -static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
> +static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked) { }
>  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
>  #endif
>  
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 5a0066ecc3c5..bc0bd86695ec 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1003,8 +1003,11 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>  	up_read(&pci_bus_sem);
>  }
>  
> -/* @pdev: the root port or switch downstream port */
> -void pcie_aspm_pm_state_change(struct pci_dev *pdev)
> +/*
> + * @pdev: the root port or switch downstream port
> + * @locked: whether pci_bus_sem is held
> + */
> +void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked)
>  {
>  	struct pcie_link_state *link = pdev->link_state;
>  
> @@ -1014,12 +1017,14 @@ void pcie_aspm_pm_state_change(struct pci_dev *pdev)
>  	 * Devices changed PM state, we should recheck if latency
>  	 * meets all functions' requirement
>  	 */
> -	down_read(&pci_bus_sem);
> +	if (!locked)
> +		down_read(&pci_bus_sem);
>  	mutex_lock(&aspm_lock);
>  	pcie_update_aspm_capable(link->root);
>  	pcie_config_aspm_path(link);
>  	mutex_unlock(&aspm_lock);
> -	up_read(&pci_bus_sem);
> +	if (!locked)
> +		up_read(&pci_bus_sem);
>  }
>  
>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index add9368e6314..7ab0d13672da 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1422,6 +1422,7 @@ int pci_load_and_free_saved_state(struct pci_dev *dev,
>  				  struct pci_saved_state **state);
>  int pci_platform_power_transition(struct pci_dev *dev, pci_power_t state);
>  int pci_set_power_state(struct pci_dev *dev, pci_power_t state);
> +int pci_set_power_state_locked(struct pci_dev *dev, pci_power_t state);
>  pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state);
>  bool pci_pme_capable(struct pci_dev *dev, pci_power_t state);
>  void pci_pme_active(struct pci_dev *dev, bool enable);
> @@ -1625,6 +1626,8 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
>  
>  void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
>  		  void *userdata);
> +void pci_walk_bus_locked(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
> +			 void *userdata);
>  int pci_cfg_space_size(struct pci_dev *dev);
>  unsigned char pci_bus_max_busnr(struct pci_bus *bus);
>  void pci_setup_bridge(struct pci_bus *bus);
> @@ -2025,6 +2028,8 @@ static inline int pci_save_state(struct pci_dev *dev) { return 0; }
>  static inline void pci_restore_state(struct pci_dev *dev) { }
>  static inline int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>  { return 0; }
> +static inline int pci_set_power_state_locked(struct pci_dev *dev, pci_power_t state)
> +{ return 0; }
>  static inline int pci_wake_from_d3(struct pci_dev *dev, bool enable)
>  { return 0; }
>  static inline pci_power_t pci_choose_state(struct pci_dev *dev,
> -- 
> 2.43.0
> 

