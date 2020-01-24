Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBB81148ADE
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2020 16:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387823AbgAXPEx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jan 2020 10:04:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:53980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387432AbgAXPEx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Jan 2020 10:04:53 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E6C920704;
        Fri, 24 Jan 2020 15:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579878291;
        bh=Wi7I7JKN46kMpMMyrfBotqJI7kOmWSOMLNFxvWd+2Q8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=givE0kBtW02/5fQl6b//chOekyscohCHQn6+DINgcY6V+OpEwOGqUQhciUJF0P6m6
         5ZGzYxr+69Cp7s64tBWqOVbq5HQUChD3k/hLBvo4aJ4ao+SuO8wLqCrCWQvHbJIkC3
         8KxJTupHkRf5C2yiUSOs7PSZXHz8q0yo98bj27cE=
Date:   Fri, 24 Jan 2020 09:04:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, Keith Busch <keith.busch@intel.com>,
        Huong Nguyen <huong.nguyen@dell.com>,
        Austin Bolen <Austin.Bolen@dell.com>
Subject: Re: [PATCH v13 4/8] PCI/DPC: Add Error Disconnect Recover (EDR)
 support
Message-ID: <20200124150450.GA15183@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9b8a3e79fd7f2e732ce2f712ad399734eadef84.1579406227.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jan 18, 2020 at 08:00:33PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> As per ACPI specification r6.3, sec 5.6.6, when firmware owns Downstream
> Port Containment (DPC), its expected to use the "Error Disconnect
> Recover" (EDR) notification to alert OSPM of a DPC event and if OS
> supports EDR, its expected to handle the software state invalidation and
> port recovery in OS, and also let firmware know the recovery status via
> _OST ACPI call. Related _OST status codes can be found in ACPI
> specification r6.3, sec 6.3.5.2.
> 
> Also, as per PCI firmware specification r3.2 Downstream Port Containment
> Related Enhancements ECN, sec 4.5.1, table 4-6, If DPC is controlled by
> firmware (firmware first mode), firmware is responsible for
> configuring the DPC and OS is responsible for error recovery. Also, OS
> is allowed to modify DPC registers only during the EDR notification
> window. So with EDR support, OS should provide DPC port services even in
> firmware first mode.
> 
> Cc: Keith Busch <keith.busch@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Acked-by: Keith Busch <keith.busch@intel.com>
> Tested-by: Huong Nguyen <huong.nguyen@dell.com>
> Tested-by: Austin Bolen <Austin.Bolen@dell.com>
> ---
>  drivers/pci/pci-acpi.c   |  99 +++++++++++++++++++++++++++++++
>  drivers/pci/pcie/Kconfig |  10 ++++
>  drivers/pci/pcie/dpc.c   | 123 ++++++++++++++++++++++++++++++++++++++-
>  include/linux/pci-acpi.h |  13 +++++
>  4 files changed, 244 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 0c02d500158f..920928f0d55c 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -103,6 +103,105 @@ int acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
>  }
>  #endif
>  
> +#if defined(CONFIG_PCIE_DPC)
> +
> +/*
> + * _DSM wrapper function to enable/disable DPC port.
> + * @dpc   : DPC device structure
> + * @enable: status of DPC port (0 or 1).
> + *
> + * returns 0 on success or errno on failure.
> + */
> +int acpi_enable_dpc_port(struct pci_dev *pdev, acpi_handle handle, bool enable)
> +{
> +	union acpi_object *obj, argv4, req;
> +	int status = 0;
> +
> +	req.type = ACPI_TYPE_INTEGER;
> +	req.integer.value = enable;
> +
> +	argv4.type = ACPI_TYPE_PACKAGE;
> +	argv4.package.count = 1;
> +	argv4.package.elements = &req;
> +
> +	/*
> +	 * Per the Downstream Port Containment Related Enhancements ECN to
> +	 * the PCI Firmware Specification r3.2, sec 4.6.12,
> +	 * EDR_PORT_ENABLE_DSM is optional.  Return success if it's not
> +	 * implemented.
> +	 */
> +	obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 5,
> +				EDR_PORT_ENABLE_DSM, &argv4);
> +	if (!obj)
> +		return 0;
> +
> +	if (obj->type != ACPI_TYPE_INTEGER || obj->integer.value != enable)
> +		status = -EIO;
> +
> +	ACPI_FREE(obj);
> +
> +	return status;
> +}
> +
> +/*
> + * _DSM wrapper function to locate DPC port.
> + * @dpc   : DPC device structure
> + *
> + * returns pci_dev or NULL.
> + */
> +struct pci_dev *acpi_locate_dpc_port(struct pci_dev *pdev, acpi_handle handle)
> +{
> +	union acpi_object *obj;
> +	u16 port;
> +
> +	obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 5,
> +				EDR_PORT_LOCATE_DSM, NULL);
> +	if (!obj)
> +		return pci_dev_get(pdev);
> +
> +	if (obj->type != ACPI_TYPE_INTEGER) {
> +		ACPI_FREE(obj);
> +		return NULL;
> +	}
> +
> +	/*
> +	 * Firmware returns DPC port BDF details in following format:
> +	 *	15:8 = bus
> +	 *	 7:3 = device
> +	 *	 2:0 = function
> +	 */
> +	port = obj->integer.value;
> +
> +	ACPI_FREE(obj);
> +
> +	return pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
> +					   PCI_BUS_NUM(port), port & 0xff);
> +}
> +
> +/*
> + * _OST wrapper function to let firmware know the status of EDR event.
> + * @dpc   : DPC device structure.
> + * @status: Status of EDR event.
> + */
> +int acpi_send_edr_status(struct pci_dev *pdev, acpi_handle handle, u16 status)
> +{
> +	u32 ost_status;
> +
> +	pci_dbg(pdev, "Sending EDR status :%#x\n", status);
> +
> +	ost_status =  PCI_DEVID(pdev->bus->number, pdev->devfn);
> +	ost_status = (ost_status << 16) | status;
> +
> +	status = acpi_evaluate_ost(handle,
> +				   ACPI_NOTIFY_DISCONNECT_RECOVER,
> +				   ost_status, NULL);
> +	if (ACPI_FAILURE(status))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +#endif /* CONFIG_PCIE_DPC */

I think we should try collecting all this stuff into a new pcie/edr.c
file.  It could contain all the above, plus edr_handle_event() and
maybe something like a "pci_acpi_add_edr_notifier()" that could be
called from pci_acpi_setup() to install the notify handler.

I think the ACPI EDR stuff in dpc.c kind of clutters it up, especially
for the non-ACPI systems that use dpc.c.

Obviously this would require some sort of interface exported from
dpc.c to do the guts of edr_handle_event(), i.e., reading
PCI_EXP_DPC_STATUS and calling dpc_process_error().

>  phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle)
>  {
>  	acpi_status status = AE_NOT_EXIST;
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 6e3c04b46fb1..772b1f4cb19e 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -140,3 +140,13 @@ config PCIE_BW
>  	  This enables PCI Express Bandwidth Change Notification.  If
>  	  you know link width or rate changes occur only to correct
>  	  unreliable links, you may answer Y.
> +
> +config PCIE_EDR
> +	bool "PCI Express Error Disconnect Recover support"
> +	depends on PCIE_DPC && ACPI
> +	help
> +	  This option adds Error Disconnect Recover support as specified
> +	  in the Downstream Port Containment Related Enhancements ECN to
> +	  the PCI Firmware Specification r3.2.  Enable this if you want to
> +	  support hybrid DPC model which uses both firmware and OS to
> +	  implement DPC.
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 9f58e91f8852..8a8ee374d9b1 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -13,6 +13,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/init.h>
>  #include <linux/pci.h>
> +#include <linux/acpi.h>
> +#include <linux/pci-acpi.h>
>  
>  #include "portdrv.h"
>  #include "../pci.h"
> @@ -23,6 +25,11 @@ struct dpc_dev {
>  	bool			rp_extensions;
>  	u8			rp_log_size;
>  	bool			edr_enabled; /* EDR mode is supported */
> +	pci_ers_result_t	error_state;
> +	struct mutex		edr_lock;
> +#ifdef CONFIG_ACPI
> +	struct acpi_device	*adev;
> +#endif
>  };
>  
>  static const char * const rp_pio_error_string[] = {
> @@ -161,6 +168,9 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>  	if (!pcie_wait_for_link(pdev, true))
>  		return PCI_ERS_RESULT_DISCONNECT;
>  
> +	/* Since the device recovery is done just update the error state */
> +	dpc->error_state = PCI_ERS_RESULT_RECOVERED;
> +
>  	return PCI_ERS_RESULT_RECOVERED;
>  }
>  
> @@ -305,14 +315,94 @@ static irqreturn_t dpc_irq(int irq, void *context)
>  	return IRQ_HANDLED;
>  }
>  
> +static void dpc_error_resume(struct pci_dev *dev)
> +{
> +	struct dpc_dev *dpc = to_dpc_dev(dev);
> +
> +	dpc->error_state = PCI_ERS_RESULT_RECOVERED;
> +}
> +
> +#ifdef CONFIG_ACPI
> +
> +static void edr_handle_event(acpi_handle handle, u32 event, void *data)
> +{
> +	struct dpc_dev *dpc = data;
> +	struct pci_dev *pdev = dpc->dev->port;
> +	u16 status;
> +
> +	pci_info(pdev, "ACPI event %#x received\n", event);
> +
> +	if (event != ACPI_NOTIFY_DISCONNECT_RECOVER)
> +		return;
> +
> +	/*
> +	 * Check if _DSM(0xD) is available, and if present locate the
> +	 * port which issued EDR event.
> +	 */
> +	pdev = acpi_locate_dpc_port(pdev, dpc->adev->handle);
> +	if (!pdev) {
> +		pdev = dpc->dev->port;
> +		pci_err(pdev, "No valid port found\n");

This message should include the bus/device/function that we looked for.

> +		return;
> +	}
> +
> +	dpc = to_dpc_dev(pdev);
> +	if (!dpc) {
> +		pci_err(pdev, "DPC port is NULL\n");
> +		goto done;
> +	}
> +
> +	mutex_lock(&dpc->edr_lock);
> +
> +	dpc->error_state = PCI_ERS_RESULT_DISCONNECT;
> +
> +	/*
> +	 * Check if the port supports DPC:
> +	 *
> +	 * If port supports DPC, then fall back to default error
> +	 * recovery.
> +	 */
> +	if (dpc->cap_pos) {
> +		/* Check if there is a valid DPC trigger */
> +		pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS,
> +				     &status);
> +		if ((status & PCI_EXP_DPC_STATUS_TRIGGER))
> +			dpc_process_error(dpc);
> +		else
> +			pci_err(pdev, "Invalid DPC trigger %#010x\n", status);
> +	}
> +
> +	/*
> +	 * If recovery is successful, send _OST(0xF, BDF << 16 | 0x80)
> +	 * to firmware. If not successful, send _OST(0xF, BDF << 16 | 0x81).
> +	 */
> +	if (dpc->error_state == PCI_ERS_RESULT_RECOVERED)
> +		status = EDR_OST_SUCCESS;
> +	else
> +		status = EDR_OST_FAILED;
> +
> +	/* Use ACPI handle of DPC event device for sending EDR status */
> +	dpc = data;
> +
> +	acpi_send_edr_status(pdev, dpc->adev->handle, status);
> +
> +	mutex_unlock(&dpc->edr_lock);
> +done:
> +	pci_dev_put(pdev);
> +}
> +#endif
> +
>  #define FLAG(x, y) (((x) & (y)) ? '+' : '-')
>  static int dpc_probe(struct pcie_device *dev)
>  {
>  	struct dpc_dev *dpc;
>  	struct pci_dev *pdev = dev->port;
>  	struct device *device = &dev->device;
> -	int status;
> +	int status = 0;
>  	u16 ctl, cap;
> +#ifdef CONFIG_ACPI
> +	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
> +#endif
>  
>  	dpc = devm_kzalloc(device, sizeof(*dpc), GFP_KERNEL);
>  	if (!dpc)
> @@ -321,6 +411,9 @@ static int dpc_probe(struct pcie_device *dev)
>  	dpc->cap_pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
>  	dpc->dev = dev;
>  
> +	dpc->error_state = PCI_ERS_RESULT_NONE;
> +	mutex_init(&dpc->edr_lock);
> +
>  	/*
>  	 * As per PCIe r5.0, sec 6.2.10, implementation note titled
>  	 * "Determination of DPC Control", to avoid conflicts over whether
> @@ -358,6 +451,33 @@ static int dpc_probe(struct pcie_device *dev)
>  		}
>  	}
>  
> +#ifdef CONFIG_ACPI
> +	if (pcie_aer_get_firmware_first(pdev) && adev) {

I'm not convinced about using pcie_aer_get_firmware_first() here yet.
AFAICT the spec doesn't actually say anything like this (I'm looking
at the ECN sec 4.5.1 description of "Error Disconnect Recover
Supported".

> +		acpi_status astatus;
> +
> +		dpc->adev = adev;
> +
> +		astatus = acpi_install_notify_handler(adev->handle,
> +						      ACPI_SYSTEM_NOTIFY,
> +						      edr_handle_event,
> +						      dpc);

I think there are a couple issues with the ECN here:

  - The ECN allows EDR notifications on host bridges (sec 4.5.1, table
    4-4), but it does not allow the "Locate" _DSM under host bridges
    (sec 4.6.13).

  - The ECN allows EDR notifications on root ports or switch ports
    that do not support DPC (sec 4.5.1), but it does not allow the
    "Locate" _DSM on those ports (sec 4.6.13).

> +		if (ACPI_FAILURE(astatus)) {
> +			pci_err(pdev,
> +				"Install ACPI_SYSTEM_NOTIFY handler failed\n");
> +			return -EBUSY;
> +		}
> +
> +		status = acpi_enable_dpc_port(pdev, adev->handle, true);
> +		if (status) {
> +			pci_warn(pdev, "Enable DPC port failed\n");
> +			acpi_remove_notify_handler(adev->handle,
> +						   ACPI_SYSTEM_NOTIFY,
> +						   edr_handle_event);
> +			return status;
> +		}
> +	}
> +#endif
>  	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CAP, &cap);
>  	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &ctl);
>  
> @@ -409,6 +529,7 @@ static struct pcie_port_service_driver dpcdriver = {
>  	.probe		= dpc_probe,
>  	.remove		= dpc_remove,
>  	.reset_link	= dpc_reset_link,
> +	.error_resume   = dpc_error_resume,
>  };
>  
>  int __init pcie_dpc_init(void)
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index 62b7fdcc661c..f4e0d5d984b0 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -111,6 +111,19 @@ extern const guid_t pci_acpi_dsm_guid;
>  #define DEVICE_LABEL_DSM		0x07
>  #define RESET_DELAY_DSM			0x08
>  #define FUNCTION_DELAY_DSM		0x09
> +#ifdef CONFIG_PCIE_DPC
> +#define EDR_PORT_ENABLE_DSM		0x0C
> +#define EDR_PORT_LOCATE_DSM		0x0D
> +#define EDR_OST_SUCCESS			0x80
> +#define EDR_OST_FAILED			0x81
> +
> +int acpi_enable_dpc_port(struct pci_dev *pdev, acpi_handle handle,
> +			 bool enable);
> +struct pci_dev *acpi_locate_dpc_port(struct pci_dev *pdev,
> +				     acpi_handle handle);
> +int acpi_send_edr_status(struct pci_dev *pdev,
> +			 acpi_handle handle, u16 status);
> +#endif /* CONFIG_PCIE_DPC */
>  
>  #else	/* CONFIG_ACPI */
>  static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
> -- 
> 2.21.0
> 
