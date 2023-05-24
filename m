Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC43F70F5E3
	for <lists+linux-pci@lfdr.de>; Wed, 24 May 2023 14:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjEXMFt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 May 2023 08:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjEXMFs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 May 2023 08:05:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64A49D
        for <linux-pci@vger.kernel.org>; Wed, 24 May 2023 05:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684929946; x=1716465946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JgXs2mve2gFzH8BU9hZQcVcsrr6xaxZOkuwZu3gT9b0=;
  b=Y0TzmL0i2LKK7hJB3nreeJuiFMJcfcpp15MmExl/vmBcLVm2ZrB6BVSZ
   1tEuaq4EKLMC9rFpPXro/XIrOEUqQurCOifh/yi0FHo+cRDnPH72It/JG
   qQ4kv9OjGPs31itcZ7cxyTS5WZkv7v1PMSucCHbUH+Kswf5KHdtXIuwCB
   pr9I2FuZJ/7Wlzq9w5cf8x/OSGNfHKZT2eRFlSPTaoAbkMMVk6F2+/fLC
   TU7rPCwCrn0jk1hLa6ylV1wiq9wUJeEDHyuJgs9qX83z9AqNZHDiLrh2U
   nVt9P8bVQ2Jyzy7utMFXcGhMwewe6SeljWq4hjXkN3KvkMFVIjL+RF8Mm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="333899475"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="333899475"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 05:05:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="735175492"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="735175492"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 24 May 2023 05:05:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 3B04B3DA; Wed, 24 May 2023 15:05:45 +0300 (EEST)
Date:   Wed, 24 May 2023 15:05:45 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Mahesh J Salgaonkar <mahesh@linux.ibm.com>, oohall@gmail.com,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>,
        shuo.tan@linux.alibaba.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5] PCI/PM: Shorten pci_bridge_wait_for_secondary_bus()
 wait time for slow links
Message-ID: <20230524120545.GR45886@black.fi.intel.com>
References: <20230425064751.24951-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230425064751.24951-1-mika.westerberg@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Tue, Apr 25, 2023 at 09:47:51AM +0300, Mika Westerberg wrote:
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

Any comments on this? If not can you consider taking this for v6.5?
Thanks!

> ---
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
> -- 
> 2.39.2
