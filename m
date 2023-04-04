Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70D26D6F09
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 23:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbjDDVhD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Apr 2023 17:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbjDDVhB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2023 17:37:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C384335AC
        for <linux-pci@vger.kernel.org>; Tue,  4 Apr 2023 14:36:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3367A639B3
        for <linux-pci@vger.kernel.org>; Tue,  4 Apr 2023 21:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6176DC433EF;
        Tue,  4 Apr 2023 21:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680644217;
        bh=o/X/PV/4UMtcejA51uaOP1bq7uB8lDaIUPNqyHNMqI4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FgbMELrhl/+dtMLSikZixHUM/wXwlnQCWLrQmj6IsJ6X3iXQsUfUD/QdMcPCUJjCp
         oPGhi3KwxF3vN+ZpmqBwEFsie6scWj0lwdAWDn3BApz6P41P30BQNhJbGYpkTk8UTM
         whqUEXPwEHYNGyKAPBrpbdwGGIKFAmHCuPubDPfwjwg0kUuJQujZsGKcg2Xc8jslGQ
         lnXbmuFeco1We5zztFpnr5QxFP3txY2dx8qKZ77G/5U9/B1V1DcIIOx0IELdIOJvjd
         mhAQiVFyLtmfUiwloHpSIN7TboE39GrgRTVXnLftDNDnADGpccGH6O1IMDKv63ODM+
         tgpeDsdQ12fJw==
Date:   Tue, 4 Apr 2023 16:36:55 -0500
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
Subject: Re: [PATCH v2 2/2] PCI/PM: Decrease wait time for devices behind
 slow links
Message-ID: <20230404213655.GA3568295@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404052714.51315-3-mika.westerberg@linux.intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mika,

I need some help because I have a hard time applying sec 6.6.1.

On Tue, Apr 04, 2023 at 08:27:14AM +0300, Mika Westerberg wrote:
> In order speed up reset and resume time of devices behind slow links,
> decrease the wait time to 1s. This should give enough time for them to
> respond.

Is there some spec language behind this?  In sec 6.6.1, I see that all
devices "must be able to receive a Configuration Request and return a
Successful Completion".

A preceding rule says devices with slow links must enter LTSSM Detect
within 20ms, but I don't see a direct connection from that to a
shorter wait time.

> While doing this, instead of looking at the speed we check if
> the port supports active link reporting.

Why check dev->link_active_reporting (i.e., PCI_EXP_LNKCAP_DLLLARC)
instead of the link speed described by the spec?

DLLLARC is required for fast links, but it's not prohibited for slower
links and it's *required* for hotplug ports with slow links, so
dev->link_active_reporting is not completely determined by link speed.

IIUC, the current code basically has these cases:

  1) All devices on secondary bus have zero D3cold delay:
       return immediately; no delay at all

  2) Non-PCIe bridge:
       sleep 1000ms
       sleep  100ms (typical, depends on downstream devices)

  3) Speed <= 5 GT/s:
       sleep 100ms (typical)
       sleep up to 59.9s (typical) waiting for valid config read

  4) Speed > 5 GT/s (DLLLARC required):
       sleep 20ms
       sleep up to 1000ms waiting for DLLLA
       sleep 100ms (typical)
       sleep up to 59.9s (typical) waiting for valid config read

This patch changes cases 3) and 4) to:

  3) DLLLARC not supported:
       sleep 100ms (typical)
       sleep up to 1.0s (typical) waiting for valid config read

  4) DLLLARC supported:
       no change in wait times, ~60s total

And testing dev->link_active_reporting instead of speed means slow
hotplug ports (and possibly other slow ports that implement DLLLARC)
that previously were in case 3) will now be in case 4).

> If it does we can wait longer
> but if it does not we wait for the 1s prescribed in the PCIe spec.
> 
> Since pci_bridge_wait_for_secondary_bus() handles all the delays
> internally now move the wait constants from drivers/pci/pci.h into
> drivers/pci/pci.c.
> 
> Cc: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/pci-driver.c |  3 +--
>  drivers/pci/pci.c        | 42 ++++++++++++++++++++++++++--------------
>  drivers/pci/pci.h        | 16 +--------------
>  drivers/pci/pcie/dpc.c   |  3 +--
>  4 files changed, 30 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 6b5b2a818e65..1a5ee65edb10 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -572,8 +572,7 @@ static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
>  
>  static void pci_pm_bridge_power_up_actions(struct pci_dev *pci_dev)
>  {
> -	pci_bridge_wait_for_secondary_bus(pci_dev, "resume",
> -					  PCIE_RESET_READY_POLL_MS);
> +	pci_bridge_wait_for_secondary_bus(pci_dev, "resume");
>  	/*
>  	 * When powering on a bridge from D3cold, the whole hierarchy may be
>  	 * powered on into D0uninitialized state, resume them to give them a
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7a67611dc5f4..5302d900dbe7 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -64,6 +64,19 @@ struct pci_pme_device {
>  
>  #define PME_TIMEOUT 1000 /* How long between PME checks */
>  
> +/*
> + * Following exit from Conventional Reset, devices must be ready within 1 sec
> + * (PCIe r6.0 sec 6.6.1).  A D3cold to D0 transition implies a Conventional
> + * Reset (PCIe r6.0 sec 5.8).
> + */
> +#define PCI_RESET_WAIT		1000	/* msec */
> +/*
> + * Devices may extend the 1 sec period through Request Retry Status completions
> + * (PCIe r6.0 sec 2.3.1).  The spec does not provide an upper limit, but 60 sec
> + * ought to be enough for any device to become responsive.
> + */
> +#define PCIE_RESET_READY_POLL_MS 60000	/* msec */
> +
>  static void pci_dev_d3_sleep(struct pci_dev *dev)
>  {
>  	unsigned int delay_ms = max(dev->d3hot_delay, pci_pm_d3hot_delay);
> @@ -4939,7 +4952,6 @@ static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
>   * pci_bridge_wait_for_secondary_bus - Wait for secondary bus to be accessible
>   * @dev: PCI bridge
>   * @reset_type: reset type in human-readable form
> - * @timeout: maximum time to wait for devices on secondary bus (milliseconds)
>   *
>   * Handle necessary delays before access to the devices on the secondary
>   * side of the bridge are permitted after D3cold to D0 transition
> @@ -4952,8 +4964,7 @@ static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
>   * Return 0 on success or -ENOTTY if the first device on the secondary bus
>   * failed to become accessible.
>   */
> -int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
> -				      int timeout)
> +int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>  {
>  	struct pci_dev *child;
>  	int delay;
> @@ -5018,20 +5029,22 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
>  	if (!pcie_downstream_port(dev))
>  		return 0;
>  
> -	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
> +	if (!dev->link_active_reporting) {

>  		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
>  		msleep(delay);
> -	} else {
> -		pci_dbg(dev, "waiting %d ms for downstream link, after activation\n",
> -			delay);
> -		if (!pcie_wait_for_link_delay(dev, true, delay)) {
> -			/* Did not train, no need to wait any further */
> -			pci_info(dev, "Data Link Layer Link Active not set in 1000 msec\n");
> -			return -ENOTTY;
> -		}
> +
> +		return pci_dev_wait(child, reset_type, PCI_RESET_WAIT - delay);
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
> -	return pci_dev_wait(child, reset_type, timeout - delay);
> +	return pci_dev_wait(child, reset_type, PCIE_RESET_READY_POLL_MS - delay);
>  }
>  
>  void pci_reset_secondary_bus(struct pci_dev *dev)
> @@ -5068,8 +5081,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
>  {
>  	pcibios_reset_secondary_bus(dev);
>  
> -	return pci_bridge_wait_for_secondary_bus(dev, "bus reset",
> -						 PCIE_RESET_READY_POLL_MS);
> +	return pci_bridge_wait_for_secondary_bus(dev, "bus reset");
>  }
>  EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index d2c08670a20e..f2d3aeab91f4 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -64,19 +64,6 @@ struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev,
>  #define PCI_PM_D3HOT_WAIT       10	/* msec */
>  #define PCI_PM_D3COLD_WAIT      100	/* msec */
>  
> -/*
> - * Following exit from Conventional Reset, devices must be ready within 1 sec
> - * (PCIe r6.0 sec 6.6.1).  A D3cold to D0 transition implies a Conventional
> - * Reset (PCIe r6.0 sec 5.8).
> - */
> -#define PCI_RESET_WAIT		1000	/* msec */
> -/*
> - * Devices may extend the 1 sec period through Request Retry Status completions
> - * (PCIe r6.0 sec 2.3.1).  The spec does not provide an upper limit, but 60 sec
> - * ought to be enough for any device to become responsive.
> - */
> -#define PCIE_RESET_READY_POLL_MS 60000	/* msec */
> -
>  void pci_update_current_state(struct pci_dev *dev, pci_power_t state);
>  void pci_refresh_power_state(struct pci_dev *dev);
>  int pci_power_up(struct pci_dev *dev);
> @@ -100,8 +87,7 @@ void pci_msix_init(struct pci_dev *dev);
>  bool pci_bridge_d3_possible(struct pci_dev *dev);
>  void pci_bridge_d3_update(struct pci_dev *dev);
>  void pci_bridge_reconfigure_ltr(struct pci_dev *dev);
> -int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
> -				      int timeout);
> +int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type);
>  
>  static inline void pci_wakeup_event(struct pci_dev *dev)
>  {
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index a5d7c69b764e..3ceed8e3de41 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -170,8 +170,7 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>  	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
>  			      PCI_EXP_DPC_STATUS_TRIGGER);
>  
> -	if (pci_bridge_wait_for_secondary_bus(pdev, "DPC",
> -					      PCIE_RESET_READY_POLL_MS)) {
> +	if (pci_bridge_wait_for_secondary_bus(pdev, "DPC")) {
>  		clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
>  		ret = PCI_ERS_RESULT_DISCONNECT;
>  	} else {
> -- 
> 2.39.2
> 
