Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD54562333F
	for <lists+linux-pci@lfdr.de>; Wed,  9 Nov 2022 20:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiKITMk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 14:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiKITMj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 14:12:39 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BD52612E;
        Wed,  9 Nov 2022 11:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668021158; x=1699557158;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SPbhVDAKk6gRLbtqoFLov/gNp3OFU1qPyC9j3nPb9XM=;
  b=cPltkB74NCj2N3ZHzscCbwNGrGnHBa2rqx9bhOpPEXN5KOesYPDn13R3
   SYLMei5eb52MrHIzDKQu1NtULEBbbdiHUmp+OEeAwvNu5QctdlDyl+G/v
   GRhDkZmvFgEoegwi6o5+mzfFSBPm34NWnyzIGW7HxCJCy4hU6aTr0X+ZJ
   Da9T2c2md8HP3onXFLJ8/ZpXWsbwKOjL2Pztej6UPV8qaXiTecZtkR6mN
   s2IhcNtcuvicf92lzkTFzy/zzMwUPGmJj7Zo3VnbdD/Yc4qdS7sffQAqj
   N5Oeebb3C5bctF8nLKEnOS4sysQskYgtkcLgDDsfBVNu75vszzL18lrpF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="311072752"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="311072752"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 11:12:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="966111150"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="966111150"
Received: from dmurray1-mobl1.amr.corp.intel.com (HELO [10.209.100.117]) ([10.209.100.117])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 11:12:36 -0800
Message-ID: <cabb5fa2-d1ba-581c-8ccb-79ca8188962a@linux.intel.com>
Date:   Wed, 9 Nov 2022 11:12:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] PCI: pciehp: Add support for OS-First Hotplug and
 AER/DPC
Content-Language: en-US
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Lukas Wunner <lukas@wunner.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
References: <20221101000719.36828-1-Smita.KoralahalliChannabasappa@amd.com>
 <20221101000719.36828-2-Smita.KoralahalliChannabasappa@amd.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20221101000719.36828-2-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 10/31/22 5:07 PM, Smita Koralahalli wrote:
> Current systems support Firmware-First model for hot-plug. In this model,
> firmware holds the responsibilty for executing the HW sequencing actions on
> an async or surprise add and removal events. Additionally, according to
> Section 6.7.6 of PCIe Base Specification [1], firmware must also handle
> the side-effects (DPC/AER events) reported on an async removal and is
> abstract to the OS.

I don't see anything about hotplug firmware-first info in the above
specification reference and I don't think firmware first logic exists for
hotplug. Are you referring to AER/DPC firmware handling support?

> 
> This model however, poses issues while rolling out updates or fixing bugs
> as the servers need to be brought down for firmware updates. Hence,
> introduce support for OS-First hot-plug and AER/DPC. Here, OS is
> responsible for handling async add and remove along with handling of
> AER/DPC events which are generated as a side-effect of async remove.

I think for OS handling we use "native" term. So use it instead of "OS-First".

> 
> The implementation is as follows: On an async remove a DPC is triggered as
> a side-effect along with an MSI to the OS. Determine it's an async remove
> by checking for DPC Trigger Status in DPC Status Register and Surprise
> Down Error Status in AER Uncorrected Error Status to be non-zero. If true,
> treat the DPC event as a side-effect of async remove, clear the error
> status registers and continue with hot-plug tear down routines. If not,
> follow the existing routine to handle AER/DPC errors.

I am wondering why your recovery fails below? Even if the device is disconnected,
error report handler will return PCI_ERS_RESULT_NEED_RESET and then attempt to do
reset using report_slot_reset(). This should work for your case, right?

> 
> Dmesg before:
> 
> pcieport 0000:00:01.4: DPC: containment event, status:0x1f01 source:0x0000
> pcieport 0000:00:01.4: DPC: unmasked uncorrectable error detected
> pcieport 0000:00:01.4: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
> pcieport 0000:00:01.4:   device [1022:14ab] error status/mask=00000020/04004000
> pcieport 0000:00:01.4:    [ 5] SDES (First)
> nvme nvme2: frozen state error detected, reset controller
> pcieport 0000:00:01.4: DPC: Data Link Layer Link Active not set in 1000 msec
> pcieport 0000:00:01.4: AER: subordinate device reset failed
> pcieport 0000:00:01.4: AER: device recovery failed
> pcieport 0000:00:01.4: pciehp: Slot(16): Link Down
> nvme2n1: detected capacity change from 1953525168 to 0
> pci 0000:04:00.0: Removing from iommu group 49
> 
> Dmesg after:
> 
> pcieport 0000:00:01.4: pciehp: Slot(16): Link Down
> nvme1n1: detected capacity change from 1953525168 to 0
> pci 0000:04:00.0: Removing from iommu group 37
> pcieport 0000:00:01.4: pciehp: Slot(16): Card present
> pci 0000:04:00.0: [8086:0a54] type 00 class 0x010802
> pci 0000:04:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
> pci 0000:04:00.0: Max Payload Size set to 512 (was 128, max 512)
> pci 0000:04:00.0: enabling Extended Tags
> pci 0000:04:00.0: Adding to iommu group 37
> pci 0000:04:00.0: BAR 0: assigned [mem 0xf2400000-0xf2403fff 64bit]
> pcieport 0000:00:01.4: PCI bridge to [bus 04]
> pcieport 0000:00:01.4:   bridge window [io 0x1000-0x1fff]
> pcieport 0000:00:01.4:   bridge window [mem 0xf2400000-0xf24fffff]
> pcieport 0000:00:01.4:   bridge window [mem 0x20080800000-0x200809fffff 64bit pref]
> nvme nvme1: pci function 0000:04:00.0
> nvme 0000:04:00.0: enabling device (0000 -> 0002)
> nvme nvme1: 128/0/0 default/read/poll queues
> 
> [1] PCI Express Base Specification Revision 6.0, Dec 16 2021.
>     https://members.pcisig.com/wg/PCI-SIG/document/16609
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/pci/pcie/dpc.c | 61 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index f5ffea17c7f8..e422876f51ad 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -293,10 +293,71 @@ void dpc_process_error(struct pci_dev *pdev)
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
> +static void pciehp_handle_surprise_removal(struct pci_dev *pdev)
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
> +	/*
> +	 * According to Section 6.13 and 6.15 of the PCIe Base Spec 6.0,
> +	 * following a hot-plug event, clear the ARI Forwarding Enable bit
> +	 * and AtomicOp Requester Enable as its not determined whether the
> +	 * next device inserted will support these capabilities. AtomicOp
> +	 * capabilities are not supported on PCI Express to PCI/PCI-X Bridges
> +	 * and any newly added component may not be an ARI device.
> +	 */
> +	pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL2,
> +				   (PCI_EXP_DEVCTL2_ARI | PCI_EXP_DEVCTL2_ATOMIC_REQ));
> +
> +	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS,
> +			      PCI_EXP_DPC_STATUS_TRIGGER);
> +}
> +
> +static bool pciehp_is_surprise_removal(struct pci_dev *pdev)
> +{
> +	u16 status;
> +
> +	pci_read_config_word(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS, &status);
> +
> +	if (!(status & PCI_ERR_UNC_SURPDN))
> +		return false;
> +
> +	pciehp_handle_surprise_removal(pdev);
> +
> +	return true;
> +}
> +
>  static irqreturn_t dpc_handler(int irq, void *context)
>  {
>  	struct pci_dev *pdev = context;
>  
> +	if (pciehp_is_surprise_removal(pdev))
> +		return IRQ_HANDLED;
> +
>  	dpc_process_error(pdev);
>  
>  	/* We configure DPC so it only triggers on ERR_FATAL */

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
