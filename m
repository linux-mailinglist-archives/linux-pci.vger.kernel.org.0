Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDA814155C
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2020 02:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgARBML (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jan 2020 20:12:11 -0500
Received: from mga14.intel.com ([192.55.52.115]:50887 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbgARBML (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Jan 2020 20:12:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 17:12:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,332,1574150400"; 
   d="scan'208";a="227442422"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 17 Jan 2020 17:12:07 -0800
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id 4141B5803DA;
        Fri, 17 Jan 2020 17:12:06 -0800 (PST)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v12 0/8] Add Error Disconnect Recover (EDR) support
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
References: <20200117233225.GA143424@google.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <d1571702-b1bb-b956-c1ad-7eb917eae82e@linux.intel.com>
Date:   Fri, 17 Jan 2020 17:10:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200117233225.GA143424@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

HI Bjorn,

On 1/17/20 4:18 PM, Bjorn Helgaas wrote:
> On Sun, Jan 12, 2020 at 02:43:54PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> This patchset adds support for following features:
>>
>> 1. Error Disconnect Recover (EDR) support.
>> 2. _OSC based negotiation support for DPC.
>>
>> You can find EDR spec in the following link.
>>
>> https://members.pcisig.com/wg/PCI-SIG/document/12614
> When you update this, please incorporate the changes I've made below..
Yes, I will add these changes to my next update.
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 134e20474dfd..0cb9df5462c3 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -491,7 +491,13 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>   			control |= OSC_PCI_EXPRESS_AER_CONTROL;
>   	}
>   
> -	if (IS_ENABLED(CONFIG_PCIE_DPC))
> +	/*
> +	 * Per the Downstream Port Containment Related Enhancements ECN to
> +	 * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
> +	 * OSC_PCI_EXPRESS_DPC_CONTROL indicates the OS supports both DPC
> +	 * and EDR.
> +	 */
> +	if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
>   		control |= OSC_PCI_EXPRESS_DPC_CONTROL;
>   
>   	requested = control;
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 13086518de27..547089361d4d 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -103,8 +103,7 @@ int acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
>   }
>   #endif
>   
> -#if defined(CONFIG_PCIE_DPC) && defined(CONFIG_ACPI)
> -
> +#if defined(CONFIG_PCIE_DPC)
>   /*
>    * _DSM wrapper function to enable/disable DPC port.
>    * @dpc   : DPC device structure
> @@ -124,14 +123,15 @@ int acpi_enable_dpc_port(struct pci_dev *pdev, acpi_handle handle, bool enable)
>   	argv4.package.count = 1;
>   	argv4.package.elements = &req;
>   
> -	/* As per PCI firmware specification r3.2 Downstream Port Containment
> -	 * Related Enhancements ECN, sec 4.6.12, EDR_PORT_ENABLE_DSM is
> -	 * optional and hence if its not implemented return success.
> +	/*
> +	 * Per the Downstream Port Containment Related Enhancements ECN to
> +	 * the PCI Firmware Specification r3.2, sec 4.6.12,
> +	 * EDR_PORT_ENABLE_DSM is optional.  Return success if it's not
> +	 * implemented.
>   	 */
> -	obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 5,
> -				EDR_PORT_ENABLE_DSM, &argv4);
> +	obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 5, EDR_PORT_ENABLE_DSM, &argv4);
>   	if (!obj)
> -		return status;
> +		return 0;
>   
>   	if (obj->type != ACPI_TYPE_INTEGER || obj->integer.value != enable)
>   		status = -EIO;
> @@ -152,8 +152,7 @@ struct pci_dev *acpi_locate_dpc_port(struct pci_dev *pdev, acpi_handle handle)
>   	union acpi_object *obj;
>   	u16 port;
>   
> -	obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 5,
> -				EDR_PORT_LOCATE_DSM, NULL);
> +	obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 5, EDR_PORT_LOCATE_DSM, NULL);
This line goes over 80 chars, do you still want to keep them in same line ?
>   	if (!obj)
>   		return pci_dev_get(pdev);
>   
> @@ -165,8 +164,8 @@ struct pci_dev *acpi_locate_dpc_port(struct pci_dev *pdev, acpi_handle handle)
>   	/*
>   	 * Firmware returns DPC port BDF details in following format:
>   	 *	15:8 = bus
> -	 *	7:3 = device
> -	 *	2:0 = function
> +	 *	 7:3 = device
> +	 *	 2:0 = function
>   	 */
>   	port = obj->integer.value;
>   
> @@ -181,11 +180,11 @@ struct pci_dev *acpi_locate_dpc_port(struct pci_dev *pdev, acpi_handle handle)
>    * @dpc   : DPC device structure.
>    * @status: Status of EDR event.
>    */
> -int acpi_send_edr_status(struct pci_dev *pdev,  acpi_handle handle, u16 status)
> +int acpi_send_edr_status(struct pci_dev *pdev, acpi_handle handle, u16 status)
>   {
>   	u32 ost_status;
>   
> -	pci_dbg(pdev, "Sending EDR status :%x\n", status);
> +	pci_dbg(pdev, "Sending EDR status: %#x\n", status);
>   
>   	ost_status =  PCI_DEVID(pdev->bus->number, pdev->devfn);
>   	ost_status = (ost_status << 16) | status;
> @@ -198,8 +197,7 @@ int acpi_send_edr_status(struct pci_dev *pdev,  acpi_handle handle, u16 status)
>   
>   	return 0;
>   }
> -
> -#endif /* CONFIG_PCIE_DPC && CONFIG_ACPI */
> +#endif /* CONFIG_PCIE_DPC */
>   
>   phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle)
>   {
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 2db8a3109cb5..772b1f4cb19e 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -143,10 +143,10 @@ config PCIE_BW
>   
>   config PCIE_EDR
>   	bool "PCI Express Error Disconnect Recover support"
> -	default n
>   	depends on PCIE_DPC && ACPI
>   	help
> -	  This options adds Error Disconnect Recover support as specified
> -	  in PCI firmware specification v3.2 Downstream Port Containment
> -	  Related Enhancements ECN. Enable this if you want to support hybrid
> -	  DPC model which uses both firmware and OS to implement DPC.
> +	  This option adds Error Disconnect Recover support as specified
> +	  in the Downstream Port Containment Related Enhancements ECN to
> +	  the PCI Firmware Specification r3.2.  Enable this if you want to
> +	  support hybrid DPC model which uses both firmware and OS to
> +	  implement DPC.
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 49e020d46ea1..292ce4b69e7a 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -79,7 +79,7 @@ void pci_save_dpc_state(struct pci_dev *dev)
>   
>   	/*
>   	 * If DPC is controlled by firmware then save/restore tasks are also
> -	 * controller by firmware. So skip rest of the function if DPC is
> +	 * controlled by firmware. So skip rest of the function if DPC is
>   	 * controlled by firmware.
>   	 */
>   	if (dpc->edr_enabled)
> @@ -108,7 +108,7 @@ void pci_restore_dpc_state(struct pci_dev *dev)
>   
>   	/*
>   	 * If DPC is controlled by firmware then save/restore tasks are also
> -	 * controller by firmware. So skip rest of the function if DPC is
> +	 * controlled by firmware. So skip rest of the function if DPC is
>   	 * controlled by firmware.
>   	 */
>   	if (dpc->edr_enabled)
> @@ -331,14 +331,13 @@ static void dpc_error_resume(struct pci_dev *dev)
>   }
>   
>   #ifdef CONFIG_ACPI
> -
>   static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>   {
> -	struct dpc_dev *dpc = (struct dpc_dev *) data;
> +	struct dpc_dev *dpc = data;
>   	struct pci_dev *pdev = dpc->dev->port;
>   	u16 status;
>   
> -	pci_info(pdev, "ACPI event %x received\n", event);
> +	pci_info(pdev, "ACPI event %#x received\n", event);
>   
>   	if (event != ACPI_NOTIFY_DISCONNECT_RECOVER)
>   		return;
> @@ -375,7 +374,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>   		pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS,
>   				     &status);
>   		if (!(status & PCI_EXP_DPC_STATUS_TRIGGER)) {
> -			pci_err(pdev, "Invalid DPC trigger %x\n", status);
> +			pci_err(pdev, "Invalid DPC trigger %#010x\n", status);
>   			goto edr_unlock;
>   		}
>   		dpc_process_error(dpc);
> @@ -391,7 +390,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>   		status = 0x81;
>   
>   	/* Use ACPI handle of DPC event device for sending EDR status */
> -	dpc = (struct dpc_dev *) data;
> +	dpc = data;
>   
>   	acpi_send_edr_status(pdev, dpc->adev->handle, status);
>   
> @@ -400,7 +399,6 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>   done:
>   	pci_dev_put(pdev);
>   }
> -
>   #endif
>   
>   #define FLAG(x, y) (((x) & (y)) ? '+' : '-')
> @@ -426,11 +424,12 @@ static int dpc_probe(struct pcie_device *dev)
>   	mutex_init(&dpc->edr_lock);
>   
>   	/*
> -	 * As per PCIe spec r5.0, implementation note titled "Determination
> +	 * PCIe r5.0, sec 6.2.10, implementation note titled "Determination
>   	 * of DPC Control", to avoid conflicts over whether platform
>   	 * firmware or the operating system have control of DPC, it is
> -	 * recommended that platform firmware and operating systems always link
> -	 * the control of DPC to the control of Advanced Error Reporting.
> +	 * recommended that platform firmware and operating systems always
> +	 * link the control of DPC to the control of Advanced Error
> +	 * Reporting.
>   	 *
>   	 * So use AER FF mode check API pcie_aer_get_firmware_first() to decide
>   	 * whether DPC is controlled by software or firmware.
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 0b7c63c7888d..d0739e90f4e7 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -511,8 +511,8 @@ struct pci_host_bridge {
>   	unsigned int	native_pme:1;		/* OS may use PCIe PME */
>   	unsigned int	native_ltr:1;		/* OS may use PCIe LTR */
>   	unsigned int	native_dpc:1;		/* OS may use PCIe DPC */
> -
>   	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
> +
>   	/* Resource alignment requirements */
>   	resource_size_t (*align_resource)(struct pci_dev *dev,
>   			const struct resource *res,
>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

