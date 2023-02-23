Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D706A06E8
	for <lists+linux-pci@lfdr.de>; Thu, 23 Feb 2023 12:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbjBWLBa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Feb 2023 06:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbjBWLB1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2023 06:01:27 -0500
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C271C53EE5
        for <linux-pci@vger.kernel.org>; Thu, 23 Feb 2023 03:01:24 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=yang.su@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VcKK6sK_1677150081;
Received: from 30.97.48.131(mailfrom:yang.su@linux.alibaba.com fp:SMTPD_---0VcKK6sK_1677150081)
          by smtp.aliyun-inc.com;
          Thu, 23 Feb 2023 19:01:22 +0800
Message-ID: <9aec1d26-60c2-e251-4e8d-ed15bdc0bc7d@linux.alibaba.com>
Date:   Thu, 23 Feb 2023 19:01:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
From:   Yang Su <yang.su@linux.alibaba.com>
Subject: Re: [PATCH v2 2/3] PCI: Unify delay handling for reset and resume
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        shuo.tan@linux.alibaba.com
References: <cover.1673769517.git.lukas@wunner.de>
 <da77c92796b99ec568bd070cbe4725074a117038.1673769517.git.lukas@wunner.de>
In-Reply-To: <da77c92796b99ec568bd070cbe4725074a117038.1673769517.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lucas,


As you describe, Sheng Bi report a bug, the pci_dev_wait() check the 
bridge whether ready rather

than that of a child, I agree with that. I used to use original 
pci_bridge_wait_for_secondary_bus()

to test secondary bus reset (SBR), the func will directly return because 
of no setted bridge_d3.


The pci_dev_wait() in pci_bridge_secondary_bus_reset() check the bridge 
whether ready but ignore

the subordinate device such as the Nvidia GPU T4.


But in your patch the pci_bridge_wait_for_secondary_bus() we only check 
the first subordinate device

of the bridge whether ready via pci_dev_wait().

> Sheng Bi reports that pci_bridge_secondary_bus_reset() may fail to wait
> for devices on the secondary bus to become accessible after reset:
>
> Although it does call pci_dev_wait(), it erroneously passes the bridge's
> pci_dev rather than that of a child.  The bridge of course is always
> accessible while its secondary bus is reset, so pci_dev_wait() returns
> immediately.
>   
>   	child = list_first_entry(&dev->subordinate->devices, struct pci_dev,
> @@ -4993,14 +5000,12 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
>
>
> -	if (!pci_device_is_present(child)) {
> -		pci_dbg(child, "waiting additional %d ms to become accessible\n", delay);
> -		msleep(delay);
> -	}
> +	return pci_dev_wait(child, reset_type, timeout - delay);


Why not wait all the downstream devices become ready? As Sheng Bi 
Introduce pci_bridge_secondary_bus_wait()

to fix 6b2f1351af56 ("PCI: Wait for device to become ready after 
secondary bus reset"), using list_for_each_entry.

https://lore.kernel.org/linux-pci/20220523171517.32407-1-windy.bi.enflame@gmail.com/

> +static int pci_bridge_secondary_bus_wait(struct pci_dev *bridge, int 
> timeout)
>
> +{
>
> +         struct pci_dev *dev;
>
> +         unsigned long start_jiffies;
>
> +
>
> + down_read(&pci_bus_sem);
>
> +
>
> +         if (!bridge->subordinate || 
> list_empty(&bridge->subordinate->devices)) {
>
> + up_read(&pci_bus_sem);
>
> + return 0;
>
> +         }
>
> +
>
> + list_for_each_entry(dev, &bridge->subordinate->devices, bus_list) {
>
> + start_jiffies = jiffies;
>
> +
>
> +                 if (timeout < 0 || pci_dev_wait(dev, "bus reset", 
> timeout)) {
>
> +         up_read(&pci_bus_sem);
>
> +         return -ENOTTY;
>
> +                 }
>
> +
>
> + timeout -= jiffies_to_msecs(jiffies - start_jiffies);
>
> +         }
>
> +
>
> + up_read(&pci_bus_sem);
>
> +
>
> +         return 0;
>
> +}
>
> +
>

Last, I want to know if all the downstrem devices are ready, how can we 
ensure pci bridge is ready?

 From now version_2 series patch, there is lack checking of the pci bridge.


On 2023/1/15 16:20, Lukas Wunner wrote:
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
>    the first device on the secondary bus by calling pci_dev_wait() after
>    performing the prescribed delays.  pci_dev_wait() needs two parameters,
>    a reset reason and a timeout, which callers must now pass to
>    pci_bridge_wait_for_secondary_bus().  The timeout is 1 sec for resume
>    (PCIe r6.0 sec 6.6.1) and 60 sec for reset (commit 821cdad5c46c ("PCI:
>    Wait up to 60 seconds for device to become ready after FLR")).
>    Introduce a PCI_RESET_WAIT macro for the 1 sec timeout.
>
> - Amend pci_bridge_wait_for_secondary_bus() to return 0 on success or
>    -ENOTTY on error for consumption by pci_bridge_secondary_bus_reset().
>
> - Drop an unnecessary 1 sec delay from pci_reset_secondary_bus() which
>    is now performed by pci_bridge_wait_for_secondary_bus().  A static
>    delay this long is only necessary for Conventional PCI, so modern
>    PCIe systems benefit from shorter reset times as a side effect.
>
> Fixes: 6b2f1351af56 ("PCI: Wait for device to become ready after secondary bus reset")
> Reported-by: Sheng Bi<windy.bi.enflame@gmail.com>
> Tested-by: Ravi Kishore Koppuravuri<ravi.kishore.koppuravuri@intel.com>
> Signed-off-by: Lukas Wunner<lukas@wunner.de>
> Reviewed-by: Mika Westerberg<mika.westerberg@linux.intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan<sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc:stable@vger.kernel.org  # v4.17+
> ---
> Changes v1 -> v2:
>   * Introduce PCI_RESET_WAIT macro for 1 sec timeout prescribed by
>     PCIe r6.0 sec 6.6.1 (Bjorn)
>   * Note in kernel-doc of pci_bridge_wait_for_secondary_bus()
>     that timeout parameter is in milliseconds (Bjorn)
>   * Add Reviewed-by tags (Mika, Sathyanarayanan)
>
>   drivers/pci/pci-driver.c |  2 +-
>   drivers/pci/pci.c        | 54 ++++++++++++++++++----------------------
>   drivers/pci/pci.h        | 10 +++++++-
>   3 files changed, 34 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index a2ceeacc33eb..7a19f11daca3 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -572,7 +572,7 @@ static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
>   
>   static void pci_pm_bridge_power_up_actions(struct pci_dev *pci_dev)
>   {
> -	pci_bridge_wait_for_secondary_bus(pci_dev);
> +	pci_bridge_wait_for_secondary_bus(pci_dev, "resume", PCI_RESET_WAIT);
>   	/*
>   	 * When powering on a bridge from D3cold, the whole hierarchy may be
>   	 * powered on into D0uninitialized state, resume them to give them a
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f43f3e84f634..509f6b5c9e14 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1174,7 +1174,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>   			return -ENOTTY;
>   		}
>   
> -		if (delay > 1000)
> +		if (delay > PCI_RESET_WAIT)
>   			pci_info(dev, "not ready %dms after %s; waiting\n",
>   				 delay - 1, reset_type);
>   
> @@ -1183,7 +1183,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>   		pci_read_config_dword(dev, PCI_COMMAND, &id);
>   	}
>   
> -	if (delay > 1000)
> +	if (delay > PCI_RESET_WAIT)
>   		pci_info(dev, "ready %dms after %s\n", delay - 1,
>   			 reset_type);
>   
> @@ -4948,24 +4948,31 @@ static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
>   /**
>    * pci_bridge_wait_for_secondary_bus - Wait for secondary bus to be accessible
>    * @dev: PCI bridge
> + * @reset_type: reset type in human-readable form
> + * @timeout: maximum time to wait for devices on secondary bus (milliseconds)
>    *
>    * Handle necessary delays before access to the devices on the secondary
> - * side of the bridge are permitted after D3cold to D0 transition.
> + * side of the bridge are permitted after D3cold to D0 transition
> + * or Conventional Reset.
>    *
>    * For PCIe this means the delays in PCIe 5.0 section 6.6.1. For
>    * conventional PCI it means Tpvrh + Trhfa specified in PCI 3.0 section
>    * 4.3.2.
> + *
> + * Return 0 on success or -ENOTTY if the first device on the secondary bus
> + * failed to become accessible.
>    */
> -void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
> +int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
> +				      int timeout)
>   {
>   	struct pci_dev *child;
>   	int delay;
>   
>   	if (pci_dev_is_disconnected(dev))
> -		return;
> +		return 0;
>   
>   	if (!pci_is_bridge(dev))
> -		return;
> +		return 0;
>   
>   	down_read(&pci_bus_sem);
>   
> @@ -4977,14 +4984,14 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
>   	 */
>   	if (!dev->subordinate || list_empty(&dev->subordinate->devices)) {
>   		up_read(&pci_bus_sem);
> -		return;
> +		return 0;
>   	}
>   
>   	/* Take d3cold_delay requirements into account */
>   	delay = pci_bus_max_d3cold_delay(dev->subordinate);
>   	if (!delay) {
>   		up_read(&pci_bus_sem);
> -		return;
> +		return 0;
>   	}
>   
>   	child = list_first_entry(&dev->subordinate->devices, struct pci_dev,
> @@ -4993,14 +5000,12 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
>   
>   	/*
>   	 * Conventional PCI and PCI-X we need to wait Tpvrh + Trhfa before
> -	 * accessing the device after reset (that is 1000 ms + 100 ms). In
> -	 * practice this should not be needed because we don't do power
> -	 * management for them (see pci_bridge_d3_possible()).
> +	 * accessing the device after reset (that is 1000 ms + 100 ms).
>   	 */
>   	if (!pci_is_pcie(dev)) {
>   		pci_dbg(dev, "waiting %d ms for secondary bus\n", 1000 + delay);
>   		msleep(1000 + delay);
> -		return;
> +		return 0;
>   	}
>   
>   	/*
> @@ -5017,11 +5022,11 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
>   	 * configuration requests if we only wait for 100 ms (see
>   	 *https://bugzilla.kernel.org/show_bug.cgi?id=203885).
>   	 *
> -	 * Therefore we wait for 100 ms and check for the device presence.
> -	 * If it is still not present give it an additional 100 ms.
> +	 * Therefore we wait for 100 ms and check for the device presence
> +	 * until the timeout expires.
>   	 */
>   	if (!pcie_downstream_port(dev))
> -		return;
> +		return 0;
>   
>   	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
>   		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
> @@ -5032,14 +5037,11 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
>   		if (!pcie_wait_for_link_delay(dev, true, delay)) {
>   			/* Did not train, no need to wait any further */
>   			pci_info(dev, "Data Link Layer Link Active not set in 1000 msec\n");
> -			return;
> +			return -ENOTTY;
>   		}
>   	}
>   
> -	if (!pci_device_is_present(child)) {
> -		pci_dbg(child, "waiting additional %d ms to become accessible\n", delay);
> -		msleep(delay);
> -	}
> +	return pci_dev_wait(child, reset_type, timeout - delay);
>   }
>   
>   void pci_reset_secondary_bus(struct pci_dev *dev)
> @@ -5058,15 +5060,6 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
>   
>   	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
>   	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
> -
> -	/*
> -	 * Trhfa for conventional PCI is 2^25 clock cycles.
> -	 * Assuming a minimum 33MHz clock this results in a 1s
> -	 * delay before we can consider subordinate devices to
> -	 * be re-initialized.  PCIe has some ways to shorten this,
> -	 * but we don't make use of them yet.
> -	 */
> -	ssleep(1);
>   }
>   
>   void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
> @@ -5085,7 +5078,8 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
>   {
>   	pcibios_reset_secondary_bus(dev);
>   
> -	return pci_dev_wait(dev, "bus reset", PCIE_RESET_READY_POLL_MS);
> +	return pci_bridge_wait_for_secondary_bus(dev, "bus reset",
> +						 PCIE_RESET_READY_POLL_MS);
>   }
>   EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
>   
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 9ed3b5550043..ce1fc3a90b3f 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -64,6 +64,13 @@ struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev,
>   #define PCI_PM_D3HOT_WAIT       10	/* msec */
>   #define PCI_PM_D3COLD_WAIT      100	/* msec */
>   
> +/*
> + * Following exit from Conventional Reset, devices must be ready within 1 sec
> + * (PCIe r6.0 sec 6.6.1).  A D3cold to D0 transition implies a Conventional
> + * Reset (PCIe r6.0 sec 5.8).
> + */
> +#define PCI_RESET_WAIT		1000	/* msec */
> +
>   void pci_update_current_state(struct pci_dev *dev, pci_power_t state);
>   void pci_refresh_power_state(struct pci_dev *dev);
>   int pci_power_up(struct pci_dev *dev);
> @@ -86,8 +93,9 @@ void pci_msi_init(struct pci_dev *dev);
>   void pci_msix_init(struct pci_dev *dev);
>   bool pci_bridge_d3_possible(struct pci_dev *dev);
>   void pci_bridge_d3_update(struct pci_dev *dev);
> -void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev);
>   void pci_bridge_reconfigure_ltr(struct pci_dev *dev);
> +int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
> +				      int timeout);
>   
>   static inline void pci_wakeup_event(struct pci_dev *dev)
>   {
