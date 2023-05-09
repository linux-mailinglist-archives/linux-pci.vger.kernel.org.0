Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C495C6FD08C
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 23:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbjEIVKM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 17:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbjEIVKL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 17:10:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0202A138;
        Tue,  9 May 2023 14:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683666610; x=1715202610;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KjPYSE1JbH8g/utPpcER5AfLTVzK93rKvQog1KIojnc=;
  b=V/TkuqhO8sve2R7CrfS53t8DiybQtO/lQZuJUoJHMUZh6Nwba2o/Ih7P
   HTZUXAYXIXo8sflplinzEcNheOlkKPGIIXVHHDBFIqEX0mi0DNJrR0MHy
   1zCfW2oq1EiRoKqgN1n5n9eCf8LTkKIPuEkGI5DzX9UrTIZPpWxFcQvl9
   j+UBGOAVgsPQyY+PUlhRIMcyMSeE5exh6dnJnI6mzdKm9vloRXHQxxM1t
   l8bGU7zJ5RxkoBvNZDxqVBgz3PFmLyA+qlpkwO4nJbzh19r0lheEZZhA9
   /F4n/DPIexhHqn2pXXR11Lh9kdvTPHvjfRIIgTdIJJv9bC9F7Gl6g0a69
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="334511305"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="334511305"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 14:10:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="731892083"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="731892083"
Received: from kvnguye3-mobl1.amr.corp.intel.com (HELO [10.212.145.31]) ([10.212.145.31])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 14:10:09 -0700
Message-ID: <8e1e8daa-f6d5-3cb9-e2d1-cb4ef8f7f3ad@linux.intel.com>
Date:   Tue, 9 May 2023 14:10:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] PCI: pciehp: Add support for async hotplug with
 native AER and DPC/EDR
Content-Language: en-US
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Lukas Wunner <lukas@wunner.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
References: <20230418210526.36514-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230418210526.36514-2-Smita.KoralahalliChannabasappa@amd.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230418210526.36514-2-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/18/23 2:05 PM, Smita Koralahalli wrote:
> According to Section 6.7.6 of PCIe Base Specification [1], async removal
> with DPC and EDR may be unexpected and may result in a Surprise Down error.
> This error is just a side effect of hot remove. Most of the time, these
> errors will be abstract to the OS as current systems rely on Firmware-First
> model for AER and DPC, where the error handling (side effects of async
> remove) and other necessary HW sequencing actions is taken care by the FW
> and is abstract to the OS. However, FW-First model poses issues while
> rolling out updates or fixing bugs as the servers need to be brought down
> for firmware updates.
> 
> Add support for async hot-plug with native AER and DPC/EDR. Here, OS is
> responsible for handling async add and remove along with handling of AER
> and DPC events which are generated as a side-effect of async remove.

PCIe spec r6.0, sec 6.7.6 mentions that the async removal can be handled
via DPC. So why treat it as a special case here? What do we gain with this
patch other than preventing the error recovery process?

> 
> The implementation is as follows: On an async remove a DPC is triggered
> along with a Presence Detect State change. Determine it's an async remove
> by checking for DPC Trigger Status in DPC Status Register and Surprise Down
> Error Status in AER Uncorrected Error Status to be non-zero. If true, treat
> the DPC event as a side-effect of async remove, clear the error status
> registers and continue with hot-plug tear down routines. If not, follow the
> existing routine to handle AER and DPC errors.
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
> Please note that, I have provided explanation why I'm not setting the
> Surprise Down bit in uncorrectable error mask register in AER.
> https://lore.kernel.org/all/fba22d6b-c225-4b44-674b-2c62306135ed@amd.com/
> 
> Also, while testing I noticed PCI_STATUS and PCI_EXP_DEVSTA will be set
> on an async remove and will not be cleared while the device is brought
> down. I have included clearing them here in order to mask any kind of
> appearance that there was an error and as well duplicating our BIOS
> functionality. I can remove if its not necessary.
> 
> On AMD systems we observe Presence Detect State change along with DPC
> event on an async remove. Hence, the errors observed are benign on AMD
> systems and the device will be brought down normally with PDSC. But the
> errors logged might confuse users.
> ---
>  drivers/pci/pcie/dpc.c | 50 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index a5d7c69b764e..78559188b9ac 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -293,10 +293,60 @@ void dpc_process_error(struct pci_dev *pdev)
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
> +
> +	pci_read_config_word(pdev, PCI_STATUS, &reg16);
> +	pci_write_config_word(pdev, PCI_STATUS, reg16);
> +
> +	pcie_capability_read_word(pdev, PCI_EXP_DEVSTA, &reg16);
> +	pcie_capability_write_word(pdev, PCI_EXP_DEVSTA, reg16);
> +}
> +
> +static void dpc_handle_surprise_removal(struct pci_dev *pdev)
> +{
> +	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev))
> +		return;
> +
> +	/*
> +	 * According to Section 6.7.6 of the PCIe Base Spec 6.0, since async
> +	 * removal might be unexpected, errors might be reported as a side
> +	 * effect of the event and software should handle them as an expected
> +	 * part of this event.
> +	 */
> +	pci_aer_raw_clear_status(pdev);
> +	pci_clear_surpdn_errors(pdev);
> +
> +	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS,
> +			      PCI_EXP_DPC_STATUS_TRIGGER);
> +}
> +
> +static bool dpc_is_surprise_removal(struct pci_dev *pdev)
> +{
> +	u16 status;
> +
> +	pci_read_config_word(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS, &status);
> +
> +	if (!(status & PCI_ERR_UNC_SURPDN))
> +		return false;
> +
> +	dpc_handle_surprise_removal(pdev);
> +
> +	return true;
> +}
> +
>  static irqreturn_t dpc_handler(int irq, void *context)
>  {
>  	struct pci_dev *pdev = context;
>  
> +	if (dpc_is_surprise_removal(pdev))
> +		return IRQ_HANDLED;
> +
>  	dpc_process_error(pdev);
>  
>  	/* We configure DPC so it only triggers on ERR_FATAL */

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
