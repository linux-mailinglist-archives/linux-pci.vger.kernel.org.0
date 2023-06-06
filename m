Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE71724F85
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 00:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239638AbjFFWYe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 18:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbjFFWYd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 18:24:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C36F10F1
        for <linux-pci@vger.kernel.org>; Tue,  6 Jun 2023 15:24:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12A9363821
        for <linux-pci@vger.kernel.org>; Tue,  6 Jun 2023 22:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DD5C433EF;
        Tue,  6 Jun 2023 22:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686090270;
        bh=7FbH8o23+lHuIHS4dOxrIl25BT7n5LcFPATbVwoSzDk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PKICIF6+0rtI671ImkbO+4YhmVgIUZh/v3/y2Ta27OD+SuQZQZuKZUePhqtzTPwOh
         a0pMm77nbNooU2OFb+meEJJq6c1ENs/QXOn9cCMm04nyTNtO9RQlnPqujOBmK/IcXG
         x5YNeDoJYex7rWxdwCZlXQoXIWmCqfl1WNxj07xDoqphnU5zFhiTatPTbMBS5sn+Qf
         C6RagUoY7jjW+MEBRvxNNac4HIFeIHYtExtRUkW2dDXs4AH/9d/wJE92fVeNTmEVHv
         DDaJ04uF24tx8OQDhTBhhM0qTx8VScaE9k9NYW8FRlRiI5dkMId6WM4IEr5Khrd2xj
         e2GligXDM39KQ==
Date:   Tue, 6 Jun 2023 17:24:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>, oohall@gmail.com,
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
Message-ID: <20230606222428.GA1147488@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425064751.24951-1-mika.westerberg@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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

Applied with acks from Lukas and Sathy to pci/pm for v6.5, thanks!

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
> 
