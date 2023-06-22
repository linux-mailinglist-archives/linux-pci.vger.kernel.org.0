Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB99A73AD22
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jun 2023 01:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjFVXWy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jun 2023 19:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjFVXWy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jun 2023 19:22:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D311739;
        Thu, 22 Jun 2023 16:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687476169; x=1719012169;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IojqZKic5r/WkJFOdy0/gAiJXa7L7cuDCuvjj0Wd/qg=;
  b=LayX0PoGDt96JowdjGr1Dj2u6R1VqWaU3MAqNi0wxazFEQ9ztPQBE1iX
   keuuKUqQudVT6AhFvnBNgunYDRpLxsECzFYUQwrkvf8Uh+3qaHMzwVQzt
   HAtxwHmJsLN7a4caMXCHc/U67U8RE2TK6Slqxh7S2+yVO8jvypAgFMMbV
   ULOKmE7xgfHdEcCbnfFm4GF2tijt5O1qtzM6/ZL1UFka5Po64R6/iXU1Q
   Oou05L8f4nfj7cUJYguSaS4VIl0f6Gf5A//qmKZrdI0KRTS7Hfw9IoMCU
   pNykYUIpB/+jRGrd+v003ADzN+m0ifH8gtadEsfGSu5XKpS0YfYeo6y0f
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="447014215"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="447014215"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 16:22:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="715118504"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="715118504"
Received: from rwtamm-mobl2.amr.corp.intel.com (HELO [10.209.27.111]) ([10.209.27.111])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 16:22:48 -0700
Message-ID: <e7aa803b-2b43-dc43-1d92-38bcca636e62@linux.intel.com>
Date:   Thu, 22 Jun 2023 16:22:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/2] PCI: pciehp: Add support for async hotplug with
 native AER and DPC/EDR
Content-Language: en-US
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Lukas Wunner <lukas@wunner.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
References: <20230621185152.105320-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230621185152.105320-2-Smita.KoralahalliChannabasappa@amd.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230621185152.105320-2-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/21/23 11:51 AM, Smita Koralahalli wrote:
> According to Section 6.7.6 of PCIe Base Specification [1], async removal
> with DPC may result in surprise down error. This error is expected and
> is just a side-effect of async remove.
> 
> Add support to handle the surprise down error generated as a side-effect
> of async remove. Typically, this error is benign as the pciehp handler
> invoked by PDC or/and DLLSC alongside DPC, de-enumerates and brings down
> the device appropriately. But the error messages might confuse users. Get
> rid of these irritating log messages with a 1s delay while pciehp waits
> for dpc recovery.
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

I think this fix is applicable to the EDR code path as well.

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
> ---
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
> ---
>  drivers/pci/pcie/dpc.c | 58 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 3ceed8e3de41..5153ac8ea91c 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -292,10 +292,68 @@ void dpc_process_error(struct pci_dev *pdev)
>  	}
>  }
>  
> +static void pci_clear_surpdn_errors(struct pci_dev *pdev)
> +{
> +	u16 reg16;
> +	u32 reg32;
> +
> +	pci_read_config_dword(pdev, pdev->dpc_cap + PCI_EXP_DPC_RP_PIO_STATUS, &reg32);
> +	pci_write_config_dword(pdev, pdev->dpc_cap + PCI_EXP_DPC_RP_PIO_STATUS, reg32);

It is not clear why you want to clear it.

> +
> +	pci_read_config_word(pdev, PCI_STATUS, &reg16);
> +	pci_write_config_word(pdev, PCI_STATUS, reg16);

Same as above. Can you add some comment about why you are clearing it?

> +
> +	pcie_capability_write_word(pdev, PCI_EXP_DEVSTA, PCI_EXP_DEVSTA_FED);
> +}
> +
> +static void dpc_handle_surprise_removal(struct pci_dev *pdev)
> +{
> +	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev)) {
> +		pci_err(pdev, "failed to retrieve DPC root port on async remove\n");
> +		goto out;
> +	}
> +
> +	pci_aer_raw_clear_status(pdev);
> +	pci_clear_surpdn_errors(pdev);
> +
> +	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS,
> +			      PCI_EXP_DPC_STATUS_TRIGGER);

Don't you need to wait for the link to go down?

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
> +	pci_read_config_word(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS, &status);
> +
> +	if (!pdev->is_hotplug_bridge)
> +		return false;
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
> +	 * According to Section 6.7.6 of the PCIe Base Spec 6.0, since async
> +	 * removal might be unexpected, errors might be reported as a side
> +	 * effect of the event and software should handle them as an expected
> +	 * part of this event.
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
