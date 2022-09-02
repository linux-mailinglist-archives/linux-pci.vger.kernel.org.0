Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E8A5ABB7D
	for <lists+linux-pci@lfdr.de>; Sat,  3 Sep 2022 01:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiIBX7a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 19:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiIBX72 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 19:59:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECA4D6C;
        Fri,  2 Sep 2022 16:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662163162; x=1693699162;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5SVxLeD0zbhXVLOjfZ0foEn8yzE1j75Wp+4aNHotkMc=;
  b=JcIExIGMVxLupvu02WX9awW+PP9dGT/rJZ8RmqS05sDf8eFaQHp6iKuY
   MtlDKr/oOvhzC5ehHD7ADC++OqpBJnDuc4nb4wTCOyYnk5Z5fY8HVJo7I
   KvU9WFpwHc3X5VSrBc68rPsdI9AzjgFLP7dVq2FZFoQs54/OzcZ4EyOe7
   PbNcRSDMEA1KBBceWiJqJjuG8Ci9rqZXacxztQV1tT9Ea78R09fO8vq25
   eyZkaydFKAcd0i1XaFSKorU57p4XBNTr8SN6VsQ1Xo4VfahuK+sLppIEc
   d+HdHRDkk+lD03LvKwiSWqqbXwz7RWXu0bP7ME57SdkJq/MkwVbj+N4hd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="279125482"
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="279125482"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 16:59:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="755423027"
Received: from cgoff-mobl1.amr.corp.intel.com (HELO [10.209.53.13]) ([10.209.53.13])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 16:59:21 -0700
Message-ID: <02dd4594-8055-cf14-8c62-ae8080b1caca@linux.intel.com>
Date:   Fri, 2 Sep 2022 16:59:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/3] PCI/PM: Always disable PTM for all devices during
 suspend
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20220902233543.390890-1-helgaas@kernel.org>
 <20220902233543.390890-4-helgaas@kernel.org>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220902233543.390890-4-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/2/22 4:35 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> We want to disable PTM on Root Ports because that allows some chips, e.g.,
> Intel mobile chips since Coffee Lake, to enter a lower-power PM state.
> 
> That means we also have to disable PTM on downstream devices.  PCIe r6.0,
> sec 2.2.8, recommends that functions support generation of messages in
> non-D0 states, so we have to assume Switch Upstream Ports or Endpoints may
> send PTM Requests while in D1, D2, and D3hot.  A PTM message received by a
> Downstream Port (including a Root Port) with PTM disabled must be treated
> as an Unsupported Request (sec 6.21.3).
> 
> PTM was previously disabled only for Root Ports, and it was disabled in
> pci_prepare_to_sleep(), which is not called at all if a driver supports
> legacy PM or does its own state saving.
> 
> Instead, disable PTM early in pci_pm_suspend() and pci_pm_runtime_suspend()
> so we do it in all cases.
> 
> Previously PTM was disabled *after* saving device state, so the state
> restore on resume automatically re-enabled it.  Since we now disable PTM
> *before* saving state, we must explicitly re-enable it.
> 
> Here's a sample of errors that occur when PTM is disabled only on the Root
> Port.  With this topology:
> 
>   0000:00:1d.0 Root Port            to [bus 08-71]
>   0000:08:00.0 Switch Upstream Port to [bus 09-71]
> 
> Kai-Heng reported errors like this:
> 
>   pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: 0000:00:1d.0
>   pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
>   pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
>   pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
>   pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 08000052 00000000 00000000
> 
> Decoding TLP header 0x34...... (0011 0100b) and 0x08000052:
> 
>   Fmt                         001b  4 DW header, no data
>   Type                     1 0100b  Msg (Local - Terminate at Receiver)
>   Requester ID  0x0800              Bus 08 Devfn 00.0
>   Message Code    0x52  0101 0010b  PTM Request
> 
> The 00:1d.0 Root Port logged an Unsupported Request error when it received
> a PTM Request with Requester ID 08:00.0.
> 
> Fixes: a697f072f5da ("PCI: Disable PTM during suspend to save power")
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215453
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=216210
> Based-on: https://lore.kernel.org/r/20220706123244.18056-1-kai.heng.feng@canonical.com
> Based-on-patch-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci-driver.c | 14 ++++++++++++++
>  drivers/pci/pci.c        | 20 --------------------
>  2 files changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 2815922ac525..115febaa7e0b 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -772,6 +772,12 @@ static int pci_pm_suspend(struct device *dev)
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  
> +	/*
> +	 * Disabling PTM allows some systems, e.g., Intel mobile chips
> +	 * since Coffee Lake, to enter a lower-power PM state.
> +	 */
> +	pci_disable_ptm(pci_dev);

I think you can use "if (pci_dev->ptm_enabled)" check for pci_disable_ptm()
as well. This will avoid unnecessary checks in pci_disable_ptm().

> +
>  	pci_dev->skip_bus_pm = false;
>  
>  	if (pci_has_legacy_pm_support(pci_dev))
> @@ -982,6 +988,9 @@ static int pci_pm_resume(struct device *dev)
>  	if (pci_dev->state_saved)
>  		pci_restore_standard_config(pci_dev);
>  
> +	if (pci_dev->ptm_enabled)
> +		pci_enable_ptm(pci_dev, NULL);
> +
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_resume(dev);
>  
> @@ -1269,6 +1278,8 @@ static int pci_pm_runtime_suspend(struct device *dev)
>  	pci_power_t prev = pci_dev->current_state;
>  	int error;
>  
> +	pci_disable_ptm(pci_dev);
> +
>  	/*
>  	 * If pci_dev->driver is not set (unbound), we leave the device in D0,
>  	 * but it may go to D3cold when the bridge above it runtime suspends.
> @@ -1331,6 +1342,9 @@ static int pci_pm_runtime_resume(struct device *dev)
>  	 */
>  	pci_pm_default_resume_early(pci_dev);
>  
> +	if (pci_dev->ptm_enabled)
> +		pci_enable_ptm(pci_dev, NULL);
> +
>  	if (!pci_dev->driver)
>  		return 0;
>  
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 95bc329e74c0..b0e2968c8cca 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2706,16 +2706,6 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
>  	if (target_state == PCI_POWER_ERROR)
>  		return -EIO;
>  
> -	/*
> -	 * There are systems (for example, Intel mobile chips since Coffee
> -	 * Lake) where the power drawn while suspended can be significantly
> -	 * reduced by disabling PTM on PCIe root ports as this allows the
> -	 * port to enter a lower-power PM state and the SoC to reach a
> -	 * lower-power idle state as a whole.
> -	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> -		pci_disable_ptm(dev);
> -
>  	pci_enable_wake(dev, target_state, wakeup);
>  
>  	error = pci_set_power_state(dev, target_state);
> @@ -2764,16 +2754,6 @@ int pci_finish_runtime_suspend(struct pci_dev *dev)
>  	if (target_state == PCI_POWER_ERROR)
>  		return -EIO;
>  
> -	/*
> -	 * There are systems (for example, Intel mobile chips since Coffee
> -	 * Lake) where the power drawn while suspended can be significantly
> -	 * reduced by disabling PTM on PCIe root ports as this allows the
> -	 * port to enter a lower-power PM state and the SoC to reach a
> -	 * lower-power idle state as a whole.
> -	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> -		pci_disable_ptm(dev);
> -
>  	__pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));
>  
>  	error = pci_set_power_state(dev, target_state);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
