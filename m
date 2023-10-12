Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F83D7C6172
	for <lists+linux-pci@lfdr.de>; Thu, 12 Oct 2023 02:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbjJLAJM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 20:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbjJLAJL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 20:09:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CB898;
        Wed, 11 Oct 2023 17:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697069349; x=1728605349;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dhOxj0ih4kfsnHduG10nuunsP/3mw37zmce89rjtOmU=;
  b=hRggkhbF8X56z6AODQTXuPtXBMnCB1YcfWKyFXC9hP4F8ZTyW/hznCml
   AaCfrubfn3JUzkjdl/jMAJRq0g3QH5g3KWH7RupIh9DhExY8jaViCyw9F
   sGfHtVeyFmjpdRhMDe9uE7V+g0298R2qK3nQD0nZr7Z8EkXYPWYmoEs7h
   8IxgLEfO4v6gxrd9Uv2igxt3oX9rsAfcBHIxXYisReL+zGaal6q2uW1h0
   jkon6Xt6Mvh4qIN9srH/8AFIgc5PSqny6Cxfd8D8NyQ3aKTe5xghlenOf
   PIus2OlZvT4iFk+G9SvyIL6vl2s0I3KI8KtKm7lZ8aRWLhDituRq5gnLv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="383663823"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="383663823"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 17:08:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="844775228"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="844775228"
Received: from ddehnert-mobl.amr.corp.intel.com (HELO [10.209.60.189]) ([10.209.60.189])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 17:08:49 -0700
Message-ID: <999e0ab0-ef31-4de7-83ca-0ab9f7658e54@linux.intel.com>
Date:   Wed, 11 Oct 2023 17:08:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] PCI/DPC: Ignore Surprise Down error on hot removal
Content-Language: en-US
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Lukas Wunner <lukas@wunner.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20231011204554.120574-1-Smita.KoralahalliChannabasappa@amd.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20231011204554.120574-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/11/2023 1:45 PM, Smita Koralahalli wrote:
> According to PCIe r6.0 sec 6.7.6 [1], async removal with DPC may result in
> surprise down error. This error is expected and is just a side-effect of
> async remove.
> 
> Ignore surprise down error generated as a side-effect of async remove.
> Typically, this error is benign as the pciehp handler invoked by PDC
> or/and DLLSC alongside DPC, de-enumerates and brings down the device
> appropriately. But the error messages might confuse users. Get rid of
> these irritating log messages with a 1s delay while pciehp waits for
> dpc recovery.
> 
> The implementation is as follows: On an async remove a DPC is triggered
> along with a Presence Detect State change and/or DLL State Change.
> Determine it's an async remove by checking for DPC Trigger Status in DPC
> Status Register and Surprise Down Error Status in AER Uncorrected Error
> Status to be non-zero. If true, treat the DPC event as a side-effect of
> async remove, clear the error status registers and continue with hot-plug
> tear down routines. If not, follow the existing routine to handle AER and
> DPC errors.
> 
> Please note that, masking Surprise Down Errors was explored as an
> alternative approach, but left due to the odd behavior that masking only
> avoids the interrupt, but still records an error per PCIe r6.0.1 Section
> 6.2.3.2.2. That stale error is going to be reported the next time some
> error other than Surprise Down is handled.
> 
> Dmesg before:
> 
>   pcieport 0000:00:01.4: DPC: containment event, status:0x1f01 source:0x0000
>   pcieport 0000:00:01.4: DPC: unmasked uncorrectable error detected
>   pcieport 0000:00:01.4: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
>   pcieport 0000:00:01.4:   device [1022:14ab] error status/mask=00000020/04004000
>   pcieport 0000:00:01.4:    [ 5] SDES (First)
>   nvme nvme2: frozen state error detected, reset controller
>   pcieport 0000:00:01.4: DPC: Data Link Layer Link Active not set in 1000 msec
>   pcieport 0000:00:01.4: AER: subordinate device reset failed
>   pcieport 0000:00:01.4: AER: device recovery failed
>   pcieport 0000:00:01.4: pciehp: Slot(16): Link Down
>   nvme2n1: detected capacity change from 1953525168 to 0
>   pci 0000:04:00.0: Removing from iommu group 49
> 
> Dmesg after:
> 
>  pcieport 0000:00:01.4: pciehp: Slot(16): Link Down
>  nvme1n1: detected capacity change from 1953525168 to 0
>  pci 0000:04:00.0: Removing from iommu group 37
> 
> [1] PCI Express Base Specification Revision 6.0, Dec 16 2021.
>     https://members.pcisig.com/wg/PCI-SIG/document/16609
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> ---

Good summary! It looks fine to me. I have made a small suggestion below, if you
have another spin, consider it. If not, it is fine as it is.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


> v2:
> 	Indentation is taken care. (Bjorn)
> 	Unrelevant dmesg logs are removed. (Bjorn)
> 	Rephrased commit message, to be clear on native vs FW-First
> 	handling. (Bjorn and Sathyanarayanan)
> 	Prefix changed from pciehp_ to dpc_. (Lukas)
> 	Clearing ARI and AtomicOp Requester are performed as a part of
> 	(de-)enumeration in pciehp_unconfigure_device(). (Lukas)
> 	Changed to clearing all optional capabilities in DEVCTL2.
> 	OS-First -> native. (Sathyanarayanan)
> 
> v3:
> 	Added error message when root port become inactive.
> 	Modified commit description to add more details.
> 	Rearranged code comments and function calls with no functional
> 	change.
> 	Additional check for is_hotplug_bridge.
> 	dpc_completed_waitqueue to wakeup pciehp handler.
> 	Cleared only Fatal error detected in DEVSTA.
> 
> v4:
> 	Made read+write conditional on "if (pdev->dpc_rp_extensions)"
> 	for DPC_RP_PIO_STATUS.
> 	Wrapped to 80 chars.
> 	Code comment for clearing PCI_STATUS and PCI_EXP_DEVSTA.
> 	Added pcie_wait_for_link() check.
> 	Removed error message for root port inactive as the message
> 	already existed.
> 	Check for is_hotplug_bridge before registers read.
> 	Section 6.7.6 of the PCIe Base Spec 6.0 -> PCIe r6.0 sec 6.7.6.
> 	Made code comment more meaningful.
> 
> v5:
> 	$SUBJECT correction.
> 	Added "Reviewed-by" tag.
> 	No code changes. Re-spin on latest base to get Bjorn's
> 	attention.
> ---
>  drivers/pci/pcie/dpc.c | 69 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 3ceed8e3de41..25e9ddeeb271 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -292,10 +292,79 @@ void dpc_process_error(struct pci_dev *pdev)
>  	}
>  }
>  
> +static void pci_clear_surpdn_errors(struct pci_dev *pdev)
> +{
> +	u16 reg16;
> +	u32 reg32;
> +
> +	if (pdev->dpc_rp_extensions) {
> +		pci_read_config_dword(pdev, pdev->dpc_cap + PCI_EXP_DPC_RP_PIO_STATUS,
> +				      &reg32);
> +		pci_write_config_dword(pdev, pdev->dpc_cap + PCI_EXP_DPC_RP_PIO_STATUS,
> +				       reg32);
> +	}
> +
> +	/*
> +	 * In practice, Surprise Down errors have been observed to also set
> +	 * error bits in the Status Register as well as the Fatal Error
> +	 * Detected bit in the Device Status Register.
> +	 */
> +	pci_read_config_word(pdev, PCI_STATUS, &reg16);
> +	pci_write_config_word(pdev, PCI_STATUS, reg16);


IMO, you can just write all 1's to clear the error (similar to probe.c)

pci_write_config_word(dev, PCI_STATUS, 0xffff)

> +
> +	pcie_capability_write_word(pdev, PCI_EXP_DEVSTA, PCI_EXP_DEVSTA_FED);
> +}
> +
> +static void dpc_handle_surprise_removal(struct pci_dev *pdev)
> +{
> +	if (!pcie_wait_for_link(pdev, false)) {
> +		pci_info(pdev, "Data Link Layer Link Active not cleared in 1000 msec\n");
> +		goto out;
> +	}
> +
> +	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev))
> +		goto out;
> +
> +	pci_aer_raw_clear_status(pdev);
> +	pci_clear_surpdn_errors(pdev);
> +
> +	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS,
> +			      PCI_EXP_DPC_STATUS_TRIGGER);
> +
> +out:
> +	clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
> +	wake_up_all(&dpc_completed_waitqueue);
> +}
> +
> +static bool dpc_is_surprise_removal(struct pci_dev *pdev)
> +{
> +	u16 status;
> +
> +	if (!pdev->is_hotplug_bridge)
> +		return false;
> +
> +	pci_read_config_word(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS,
> +			     &status);
> +
> +	if (!(status & PCI_ERR_UNC_SURPDN))
> +		return false;
> +
> +	return true;
> +}
> +
>  static irqreturn_t dpc_handler(int irq, void *context)
>  {
>  	struct pci_dev *pdev = context;
>  
> +	/*
> +	 * According to PCIe r6.0 sec 6.7.6, errors are an expected side effect
> +	 * of async removal and should be ignored by software.
> +	 */
> +	if (dpc_is_surprise_removal(pdev)) {
> +		dpc_handle_surprise_removal(pdev);
> +		return IRQ_HANDLED;
> +	}
> +
>  	dpc_process_error(pdev);
>  
>  	/* We configure DPC so it only triggers on ERR_FATAL */

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
