Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9CC6EE42A
	for <lists+linux-pci@lfdr.de>; Tue, 25 Apr 2023 16:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbjDYOqz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Apr 2023 10:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbjDYOqz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Apr 2023 10:46:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB70626BD
        for <linux-pci@vger.kernel.org>; Tue, 25 Apr 2023 07:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682434003; x=1713970003;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qHEu7Hqut+vyAmHrBraR3uDGHnBCmcoD7+ub35Sk+D0=;
  b=GsAtlCJuafkcNXvTe70eWBB4UiqiGkNKTnUsq7qpi7VUqArTEc+fcSAd
   9Ak6Hr5dg4gn4p6zGgorxQ6WmVJU9rXvfw6Zlf5yNpLvsQpLOmP4GAy+4
   tWbDHyBVgObZAa7ShLsyY/pY/OeB1bVBmaF31wRwLCeaeKh9iRcsOsrgu
   SBEABDQ4XAitGsTYR/a7WTHfSHbEebSe/orqckExBviV4Y/6pgFf/xA1o
   EppashriU+emGDw1trhGvBJOZF6B3gt3CcErzoIqU1my/C3sesiro2XSA
   a4x7psMpr/RXUVrrTXQ4FZJejYwdClLlG7rmdV1fP6ANeIk4tesLRw4jP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="348698867"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="348698867"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 07:46:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="867897754"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="867897754"
Received: from json-mobl1.amr.corp.intel.com (HELO [10.251.28.43]) ([10.251.28.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 07:46:25 -0700
Message-ID: <79308cdd-5261-2908-683c-24ec85619709@linux.intel.com>
Date:   Tue, 25 Apr 2023 07:46:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v5] PCI/PM: Shorten pci_bridge_wait_for_secondary_bus()
 wait time for slow links
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Mahesh J Salgaonkar <mahesh@linux.ibm.com>, oohall@gmail.com,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>,
        shuo.tan@linux.alibaba.com, linux-pci@vger.kernel.org
References: <20230425064751.24951-1-mika.westerberg@linux.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230425064751.24951-1-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/24/23 11:47 PM, Mika Westerberg wrote:
> With slow links (<= 5GT/s) active link reporting is not mandatory, so if
> a device is disconnected during system sleep we might end up waiting for
> it to respond for ~60s slowing down resume time. PCIe spec r6.0 sec
> 6.6.1 mandates that the system software must wait for at least 1s before
> it can determine the device as broken device so use the minimum
> requirement for slow links and bail out if we do not get reply within
> 1s. However, if the port supports active link reporting we can continue
> the wait following what we do with the fast links.
> 
> This should make system resume time faster for slow links as well while
> still following the PCIe spec.
> 
> While there move the PCI_RESET_WAIT constant into pci.c because it is
> not used outside of that file anymore.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> Hi all,
> 
> The previous version of the patch can be found here:
> 
>   https://lore.kernel.org/linux-pci/20230418072808.10431-1-mika.westerberg@linux.intel.com/
> 
> Changes from the previous version:
> 
>   * Observe the mandatory 1s delay before looking at the active link
>     reporting as suggesteed by Lukas.
> 
>  drivers/pci/pci.c | 49 +++++++++++++++++++++++++++++++++++------------
>  drivers/pci/pci.h |  7 -------
>  2 files changed, 37 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 0b4f3b08f780..6bc0eeeb37fa 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -64,6 +64,13 @@ struct pci_pme_device {
>  
>  #define PME_TIMEOUT 1000 /* How long between PME checks */
>  
> +/*
> + * Following exit from Conventional Reset, devices must be ready within 1 sec
> + * (PCIe r6.0 sec 6.6.1).  A D3cold to D0 transition implies a Conventional
> + * Reset (PCIe r6.0 sec 5.8).
> + */
> +#define PCI_RESET_WAIT 1000 /* msec */
> +
>  /*
>   * Devices may extend the 1 sec period through Request Retry Status
>   * completions (PCIe r6.0 sec 2.3.1).  The spec does not provide an upper
> @@ -5012,11 +5019,9 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>  	 *
>  	 * However, 100 ms is the minimum and the PCIe spec says the
>  	 * software must allow at least 1s before it can determine that the
> -	 * device that did not respond is a broken device. There is
> -	 * evidence that 100 ms is not always enough, for example certain
> -	 * Titan Ridge xHCI controller does not always respond to
> -	 * configuration requests if we only wait for 100 ms (see
> -	 * https://bugzilla.kernel.org/show_bug.cgi?id=203885).
> +	 * device that did not respond is a broken device. Also device can
> +	 * take longer than that to respond if it indicates so through Request
> +	 * Retry Status completions.
>  	 *
>  	 * Therefore we wait for 100 ms and check for the device presence
>  	 * until the timeout expires.
> @@ -5025,16 +5030,36 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>  		return 0;
>  
>  	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
> +		u16 status;
> +
>  		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
>  		msleep(delay);
> -	} else {
> -		pci_dbg(dev, "waiting %d ms for downstream link, after activation\n",
> -			delay);
> -		if (!pcie_wait_for_link_delay(dev, true, delay)) {
> -			/* Did not train, no need to wait any further */
> -			pci_info(dev, "Data Link Layer Link Active not set in 1000 msec\n");
> +
> +		if (!pci_dev_wait(child, reset_type, PCI_RESET_WAIT - delay))
> +			return 0;
> +
> +		/*
> +		 * If the port supports active link reporting we now check
> +		 * whether the link is active and if not bail out early with
> +		 * the assumption that the device is not present anymore.
> +		 */
> +		if (!dev->link_active_reporting)
>  			return -ENOTTY;
> -		}
> +
> +		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
> +		if (!(status & PCI_EXP_LNKSTA_DLLLA))
> +			return -ENOTTY;
> +
> +		return pci_dev_wait(child, reset_type,
> +				    PCIE_RESET_READY_POLL_MS - PCI_RESET_WAIT);
> +	}
> +
> +	pci_dbg(dev, "waiting %d ms for downstream link, after activation\n",
> +		delay);
> +	if (!pcie_wait_for_link_delay(dev, true, delay)) {
> +		/* Did not train, no need to wait any further */
> +		pci_info(dev, "Data Link Layer Link Active not set in 1000 msec\n");
> +		return -ENOTTY;
>  	}
>  
>  	return pci_dev_wait(child, reset_type,
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 67005a0ee381..42ce4c6e738f 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -64,13 +64,6 @@ struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev,
>  #define PCI_PM_D3HOT_WAIT       10	/* msec */
>  #define PCI_PM_D3COLD_WAIT      100	/* msec */
>  
> -/*
> - * Following exit from Conventional Reset, devices must be ready within 1 sec
> - * (PCIe r6.0 sec 6.6.1).  A D3cold to D0 transition implies a Conventional
> - * Reset (PCIe r6.0 sec 5.8).
> - */
> -#define PCI_RESET_WAIT		1000	/* msec */
> -
>  void pci_update_current_state(struct pci_dev *dev, pci_power_t state);
>  void pci_refresh_power_state(struct pci_dev *dev);
>  int pci_power_up(struct pci_dev *dev);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
