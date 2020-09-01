Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B56258795
	for <lists+linux-pci@lfdr.de>; Tue,  1 Sep 2020 07:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgIAFln (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Sep 2020 01:41:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:15326 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgIAFln (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Sep 2020 01:41:43 -0400
IronPort-SDR: n6PWLXtLQcSF8fS698tgyqk4ZdwIdFZW+A4qA+wgrLcmjcLjb+0va6Ic+HbWqCG+Cka9Fo5cE4
 P3bXrzNvK8AQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="156368003"
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="156368003"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 22:41:42 -0700
IronPort-SDR: vAJa7izK3M6m55eqowXVzXQaizdSNGk2Is0UH91JUpv/cUg+lwN2tlpMALQZq9hbYg1PsfgO3h
 yjwAP6TbOnjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="333603812"
Received: from myalaman-mobl1.amr.corp.intel.com (HELO [10.255.229.207]) ([10.255.229.207])
  by fmsmga002.fm.intel.com with ESMTP; 31 Aug 2020 22:41:41 -0700
Subject: Re: [PATCH v3 1/1] PCI/ERR: Fix reset logic in pcie_do_recovery()
 call
To:     20200714230803.GA92891@bjorn-Precision-5520, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, Jay Vosburgh <jay.vosburgh@canonical.com>
References: <cbba08a5e9ca62778c8937f44eda2192a2045da7.1595617529.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <56ad4901-725f-7b88-2117-b124b28b027f@linux.intel.com>
Date:   Mon, 31 Aug 2020 22:41:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cbba08a5e9ca62778c8937f44eda2192a2045da7.1595617529.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 7/24/20 12:07 PM, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Current pcie_do_recovery() implementation has following two issues:
> 
> 1. Fatal (DPC) error recovery is currently broken for non-hotplug
> capable devices. Current fatal error recovery implementation relies
> on PCIe hotplug (pciehp) handler for detaching and re-enumerating
> the affected devices/drivers. pciehp handler listens for DLLSC state
> changes and handles device/driver detachment on DLLSC_LINK_DOWN event
> and re-enumeration on DLLSC_LINK_UP event. So when dealing with
> non-hotplug capable devices, recovery code does not restore the state
> of the affected devices correctly. Correct implementation should
> restore the device state and call report_slot_reset() function after
> resetting the link to restore the state of the device/driver.
> 
> You can find fatal non-hotplug related issues reported in following links:
> 
> https://lore.kernel.org/linux-pci/20200527083130.4137-1-Zhiqiang.Hou@nxp.com/
> https://lore.kernel.org/linux-pci/12115.1588207324@famine/
> https://lore.kernel.org/linux-pci/0e6f89cd6b9e4a72293cc90fafe93487d7c2d295.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com/
> 
> 2. For non-fatal errors if report_error_detected() or
> report_mmio_enabled() functions requests PCI_ERS_RESULT_NEED_RESET then
> current pcie_do_recovery() implementation does not do the requested
> explicit device reset, instead just calls the report_slot_reset() on all
> affected devices. Notifying about the reset via report_slot_reset()
> without doing the actual device reset is incorrect.
> 
> To fix above issues, use PCI_ERS_RESULT_NEED_RESET as error state after
> successful reset_link() operation. This will ensure ->slot_reset() be
> called after reset_link() operation for fatal errors. Also call
> pci_bus_reset() to do slot/bus reset() before triggering device specific
> ->slot_reset() callback. Also, using pci_bus_reset() will restore the state
> of the devices after performing the reset operation.
> 
> Even though using pci_bus_reset() will do redundant reset operation after
> ->reset_link() for fatal errors, it should should affect the functional
> behavior.
Any comment on this patch?
> 
> [original patch is from jay.vosburgh@canonical.com]
> [original patch link https://lore.kernel.org/linux-pci/12115.1588207324@famine/]
> Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
> Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
> 
> Changes since v2:
>   * Changed the subject of patch to "PCI/ERR: Fix reset logic in
>     pcie_do_recovery() call". v2 patch link is,
>     https://lore.kernel.org/linux-pci/ce417fbf81a8a46a89535f44b9224ee9fbb55a29.1591307288.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>   * Squashed "PCI/ERR: Add reset support for non fatal errors" patch.
> 
>   drivers/pci/pcie/err.c | 41 +++++++++++++++++++++++++++++++++++++----
>   1 file changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 14bb8f54723e..b5eb6ba65be1 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -165,8 +165,29 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   	pci_dbg(dev, "broadcast error_detected message\n");
>   	if (state == pci_channel_io_frozen) {
>   		pci_walk_bus(bus, report_frozen_detected, &status);
> +		/*
> +		 * After resetting the link using reset_link() call, the
> +		 * possible value of error status is either
> +		 * PCI_ERS_RESULT_DISCONNECT (failure case) or
> +		 * PCI_ERS_RESULT_NEED_RESET (success case).
> +		 * So ignore the return value of report_error_detected()
> +		 * call for fatal errors.
> +		 *
> +		 * In EDR mode, since AER and DPC Capabilities are owned by
> +		 * firmware, reported_error_detected() will return error
> +		 * status PCI_ERS_RESULT_NO_AER_DRIVER. Continuing
> +		 * pcie_do_recovery() with error status as
> +		 * PCI_ERS_RESULT_NO_AER_DRIVER will report recovery failure
> +		 * irrespective of recovery status. But successful reset_link()
> +		 * call usually recovers all fatal errors. So ignoring the
> +		 * status result of report_error_detected() also helps EDR based
> +		 * error recovery.
> +		 */
>   		status = reset_link(dev);
> -		if (status != PCI_ERS_RESULT_RECOVERED) {
> +		if (status == PCI_ERS_RESULT_RECOVERED) {
> +			status = PCI_ERS_RESULT_NEED_RESET;
> +		} else {
> +			status = PCI_ERS_RESULT_DISCONNECT;
>   			pci_warn(dev, "link reset failed\n");
>   			goto failed;
>   		}
> @@ -182,10 +203,22 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   
>   	if (status == PCI_ERS_RESULT_NEED_RESET) {
>   		/*
> -		 * TODO: Should call platform-specific
> -		 * functions to reset slot before calling
> -		 * drivers' slot_reset callbacks?
> +		 * TODO: Optimize the call to pci_reset_bus()
> +		 *
> +		 * There are two components to pci_reset_bus().
> +		 *
> +		 * 1. Do platform specific slot/bus reset.
> +		 * 2. Save/Restore all devices in the bus.
> +		 *
> +		 * For hotplug capable devices and fatal errors,
> +		 * device is already in reset state due to link
> +		 * reset. So repeating platform specific slot/bus
> +		 * reset via pci_reset_bus() call is redundant. So
> +		 * can optimize this logic and conditionally call
> +		 * pci_reset_bus().
>   		 */
> +		pci_reset_bus(dev);
> +
>   		status = PCI_ERS_RESULT_RECOVERED;
>   		pci_dbg(dev, "broadcast slot_reset message\n");
>   		pci_walk_bus(bus, report_slot_reset, &status);
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
