Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9D965C7B9
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jan 2023 20:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbjACTu7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Jan 2023 14:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238476AbjACTuf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2023 14:50:35 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B1E14007
        for <linux-pci@vger.kernel.org>; Tue,  3 Jan 2023 11:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672775434; x=1704311434;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PBdEkbWoFxmIeASwsU0YuMHdj5fuNL724BPhX2WkrAE=;
  b=GcoN+/7Z3Nm0Bd/jhWQQvTgcrzYpfZbxcU4NSRM2jGwzwYUDBHDucEep
   s3wxScev/zmcYlhuaIX3r6bnSOSI7vF3xQtKFRRddwzuOMnlIvCPMGSjH
   MTgNrmgXU/6qDiLN0lxrxHdJEgqik1pEbqL2p6IfDkRWfWEHDylQmgWsS
   vyUpTcwKS8Hhw6AXKxsjBCxeOP7RZdZcOU77MLJ5FPvEg42Zs/yj5Vlh3
   imQfpT72LJ149rn4wT2S8P78QsGmFiosrXsKM6pXuht2Mjbv2oxo6aES2
   mhz7vlMt8xnDGZsOBNvbCmd/LbcMlIJoAfw/9jSHJhAwSS1ymdRl9TpOZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="348964020"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="348964020"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 11:50:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="654908728"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="654908728"
Received: from jjha-mobl1.amr.corp.intel.com (HELO [10.209.61.244]) ([10.209.61.244])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 11:50:32 -0800
Message-ID: <f9da4dad-19ce-19bc-3724-74e7f96eba30@linux.intel.com>
Date:   Tue, 3 Jan 2023 11:50:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 2/3] PCI: Unify delay handling for reset and resume
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>
References: <cover.1672511016.git.lukas@wunner.de>
 <bd6ac49d60c1ca6fe5c27c2fa54b78d70a8ba07b.1672511017.git.lukas@wunner.de>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <bd6ac49d60c1ca6fe5c27c2fa54b78d70a8ba07b.1672511017.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/31/22 10:33 AM, Lukas Wunner wrote:
> Sheng Bi reports that pci_bridge_secondary_bus_reset() may fail to wait
> for devices on the secondary bus to become accessible after reset:
> 
> Although it does call pci_dev_wait(), it erroneously passes the bridge's
> pci_dev rather than that of a child.  The bridge of course is always
> accessible while its secondary bus is reset, so pci_dev_wait() returns
> immediately.
> 
> Sheng Bi proposes introducing a new pci_bridge_secondary_bus_wait()
> function which is called from pci_bridge_secondary_bus_reset():
> 
> https://lore.kernel.org/linux-pci/20220523171517.32407-1-windy.bi.enflame@gmail.com/
> 
> However we already have pci_bridge_wait_for_secondary_bus() which does
> almost exactly what we need.  So far it's only called on resume from
> D3cold (which implies a Fundamental Reset per PCIe r6.0 sec 5.8).
> Re-using it for Secondary Bus Resets is a leaner and more rational
> approach than introducing a new function.
> 
> That only requires a few minor tweaks:
> 
> - Amend pci_bridge_wait_for_secondary_bus() to await accessibility of
>   the first device on the secondary bus by calling pci_dev_wait() after
>   performing the prescribed delays.  pci_dev_wait() needs two parameters,
>   a reset reason and a timeout, which callers must now pass to
>   pci_bridge_wait_for_secondary_bus().  The timeout is 1 sec for resume
>   (PCIe r6.0 sec 6.6.1) and 60 sec for reset (commit 821cdad5c46c ("PCI:
>   Wait up to 60 seconds for device to become ready after FLR")).
> 
> - Amend pci_bridge_wait_for_secondary_bus() to return 0 on success or
>   -ENOTTY on error for consumption by pci_bridge_secondary_bus_reset().
> 
> - Drop an unnecessary 1 sec delay from pci_reset_secondary_bus() which
>   is now performed by pci_bridge_wait_for_secondary_bus().  A static
>   delay this long is only necessary for Conventional PCI, so modern
>   PCIe systems benefit from shorter reset times as a side effect.
> 
> Fixes: 6b2f1351af56 ("PCI: Wait for device to become ready after secondary bus reset")
> Reported-by: Sheng Bi <windy.bi.enflame@gmail.com>
> Tested-by: Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v4.17+
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/pci/pci-driver.c |  2 +-
>  drivers/pci/pci.c        | 50 ++++++++++++++++++----------------------
>  drivers/pci/pci.h        |  3 ++-
>  3 files changed, 25 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index a2ceeacc33eb..02e84c87f41a 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -572,7 +572,7 @@ static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
>  
>  static void pci_pm_bridge_power_up_actions(struct pci_dev *pci_dev)
>  {
> -	pci_bridge_wait_for_secondary_bus(pci_dev);
> +	pci_bridge_wait_for_secondary_bus(pci_dev, "resume", 1000);
>  	/*
>  	 * When powering on a bridge from D3cold, the whole hierarchy may be
>  	 * powered on into D0uninitialized state, resume them to give them a
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f43f3e84f634..b0b49243a908 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4948,24 +4948,31 @@ static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
>  /**
>   * pci_bridge_wait_for_secondary_bus - Wait for secondary bus to be accessible
>   * @dev: PCI bridge
> + * @reset_type: reset type in human-readable form
> + * @timeout: maximum time to wait for devices on secondary bus
>   *
>   * Handle necessary delays before access to the devices on the secondary
> - * side of the bridge are permitted after D3cold to D0 transition.
> + * side of the bridge are permitted after D3cold to D0 transition
> + * or Conventional Reset.
>   *
>   * For PCIe this means the delays in PCIe 5.0 section 6.6.1. For
>   * conventional PCI it means Tpvrh + Trhfa specified in PCI 3.0 section
>   * 4.3.2.
> + *
> + * Return 0 on success or -ENOTTY if the first device on the secondary bus
> + * failed to become accessible.
>   */
> -void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
> +int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
> +				      int timeout)
>  {
>  	struct pci_dev *child;
>  	int delay;
>  
>  	if (pci_dev_is_disconnected(dev))
> -		return;
> +		return 0;
>  
>  	if (!pci_is_bridge(dev))
> -		return;
> +		return 0;
>  
>  	down_read(&pci_bus_sem);
>  
> @@ -4977,14 +4984,14 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
>  	 */
>  	if (!dev->subordinate || list_empty(&dev->subordinate->devices)) {
>  		up_read(&pci_bus_sem);
> -		return;
> +		return 0;
>  	}
>  
>  	/* Take d3cold_delay requirements into account */
>  	delay = pci_bus_max_d3cold_delay(dev->subordinate);
>  	if (!delay) {
>  		up_read(&pci_bus_sem);
> -		return;
> +		return 0;
>  	}
>  
>  	child = list_first_entry(&dev->subordinate->devices, struct pci_dev,
> @@ -4993,14 +5000,12 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
>  
>  	/*
>  	 * Conventional PCI and PCI-X we need to wait Tpvrh + Trhfa before
> -	 * accessing the device after reset (that is 1000 ms + 100 ms). In
> -	 * practice this should not be needed because we don't do power
> -	 * management for them (see pci_bridge_d3_possible()).
> +	 * accessing the device after reset (that is 1000 ms + 100 ms).
>  	 */
>  	if (!pci_is_pcie(dev)) {
>  		pci_dbg(dev, "waiting %d ms for secondary bus\n", 1000 + delay);
>  		msleep(1000 + delay);
> -		return;
> +		return 0;
>  	}
>  
>  	/*
> @@ -5017,11 +5022,11 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
>  	 * configuration requests if we only wait for 100 ms (see
>  	 * https://bugzilla.kernel.org/show_bug.cgi?id=203885).
>  	 *
> -	 * Therefore we wait for 100 ms and check for the device presence.
> -	 * If it is still not present give it an additional 100 ms.
> +	 * Therefore we wait for 100 ms and check for the device presence
> +	 * until the timeout expires.
>  	 */
>  	if (!pcie_downstream_port(dev))
> -		return;
> +		return 0;
>  
>  	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
>  		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
> @@ -5032,14 +5037,11 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
>  		if (!pcie_wait_for_link_delay(dev, true, delay)) {
>  			/* Did not train, no need to wait any further */
>  			pci_info(dev, "Data Link Layer Link Active not set in 1000 msec\n");
> -			return;
> +			return -ENOTTY;
>  		}
>  	}
>  
> -	if (!pci_device_is_present(child)) {
> -		pci_dbg(child, "waiting additional %d ms to become accessible\n", delay);
> -		msleep(delay);
> -	}
> +	return pci_dev_wait(child, reset_type, timeout - delay);
>  }
>  
>  void pci_reset_secondary_bus(struct pci_dev *dev)
> @@ -5058,15 +5060,6 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
>  
>  	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
>  	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
> -
> -	/*
> -	 * Trhfa for conventional PCI is 2^25 clock cycles.
> -	 * Assuming a minimum 33MHz clock this results in a 1s
> -	 * delay before we can consider subordinate devices to
> -	 * be re-initialized.  PCIe has some ways to shorten this,
> -	 * but we don't make use of them yet.
> -	 */
> -	ssleep(1);
>  }
>  
>  void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
> @@ -5085,7 +5078,8 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
>  {
>  	pcibios_reset_secondary_bus(dev);
>  
> -	return pci_dev_wait(dev, "bus reset", PCIE_RESET_READY_POLL_MS);
> +	return pci_bridge_wait_for_secondary_bus(dev, "bus reset",
> +						 PCIE_RESET_READY_POLL_MS);
>  }
>  EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 9ed3b5550043..40758248dd80 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -86,8 +86,9 @@ void pci_msi_init(struct pci_dev *dev);
>  void pci_msix_init(struct pci_dev *dev);
>  bool pci_bridge_d3_possible(struct pci_dev *dev);
>  void pci_bridge_d3_update(struct pci_dev *dev);
> -void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev);
>  void pci_bridge_reconfigure_ltr(struct pci_dev *dev);
> +int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
> +				      int timeout);
>  
>  static inline void pci_wakeup_event(struct pci_dev *dev)
>  {

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
