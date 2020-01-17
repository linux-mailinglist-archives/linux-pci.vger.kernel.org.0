Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DABCB141487
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2020 23:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbgAQW4T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jan 2020 17:56:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729147AbgAQW4S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Jan 2020 17:56:18 -0500
Received: from localhost (187.sub-174-234-133.myvzw.com [174.234.133.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCB7E21D56;
        Fri, 17 Jan 2020 22:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579301778;
        bh=zOH3GxylaaahRFvX/KLsn7MZGbiAQnXfpX5+gZcabhM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NdFSQL552vZKxubV7k8BFLa3IvFBOKYOYgo/LJaP2ZooT6BZpGMUavbjow2X9MOI9
         +GD5uGNAc5M4Q2QeJOXzrdijVTEdAHlv0A87Lb5Z8pRoX9DVFzw7hHJ5Ao3TPLKqkd
         LywJfOro6bsZC51/IKdKmRcczpOYFykp3tXRHwKk=
Date:   Fri, 17 Jan 2020 16:56:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, Keith Busch <keith.busch@intel.com>,
        Huong Nguyen <huong.nguyen@dell.com>,
        Austin Bolen <Austin.Bolen@dell.com>
Subject: Re: [PATCH v12 4/8] PCI/DPC: Add Error Disconnect Recover (EDR)
 support
Message-ID: <20200117215454.GA131026@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce9dda76342be3103381a20be4612d1019b1e6c7.1578682741.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jan 12, 2020 at 02:43:58PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
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
>  drivers/pci/pci-acpi.c   |  98 ++++++++++++++++++++++++++++++
>  drivers/pci/pcie/Kconfig |  10 ++++
>  drivers/pci/pcie/dpc.c   | 125 ++++++++++++++++++++++++++++++++++++++-
>  include/linux/pci-acpi.h |  11 ++++
>  4 files changed, 243 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 0c02d500158f..13086518de27 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -103,6 +103,104 @@ int acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
>  }
>  #endif
>  
> +#if defined(CONFIG_PCIE_DPC) && defined(CONFIG_ACPI)

This file is only built if CONFIG_ACPI=y, so you don't need to test it
here.

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
> +	/* As per PCI firmware specification r3.2 Downstream Port Containment
> +	 * Related Enhancements ECN, sec 4.6.12, EDR_PORT_ENABLE_DSM is
> +	 * optional and hence if its not implemented return success.
> +	 */
> +	obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 5,
> +				EDR_PORT_ENABLE_DSM, &argv4);
> +	if (!obj)
> +		return status;

Since you know the value here:

  return 0;

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
> +	 *	7:3 = device
> +	 *	2:0 = function
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
> +int acpi_send_edr_status(struct pci_dev *pdev,  acpi_handle handle, u16 status)
> +{
> +	u32 ost_status;
> +
> +	pci_dbg(pdev, "Sending EDR status :%x\n", status);
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
> +
> +#endif /* CONFIG_PCIE_DPC && CONFIG_ACPI */
> +
>  phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle)
>  {
>  	acpi_status status = AE_NOT_EXIST;
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 6e3c04b46fb1..2db8a3109cb5 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -140,3 +140,13 @@ config PCIE_BW
>  	  This enables PCI Express Bandwidth Change Notification.  If
>  	  you know link width or rate changes occur only to correct
>  	  unreliable links, you may answer Y.
> +
> +config PCIE_EDR
> +	bool "PCI Express Error Disconnect Recover support"
> +	default n
> +	depends on PCIE_DPC && ACPI
> +	help
> +	  This options adds Error Disconnect Recover support as specified
> +	  in PCI firmware specification v3.2 Downstream Port Containment
> +	  Related Enhancements ECN. Enable this if you want to support hybrid
> +	  DPC model which uses both firmware and OS to implement DPC.
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index d29f5d25f3f9..63366344acff 100644
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
>  	return PCI_ERS_RESULT_RECOVERED;
>  }
>  
> @@ -305,13 +315,93 @@ static irqreturn_t dpc_irq(int irq, void *context)
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
> +	struct dpc_dev *dpc = (struct dpc_dev *) data;
> +	struct pci_dev *pdev = dpc->dev->port;
> +	u16 status;
> +
> +	pci_info(pdev, "ACPI event %x received\n", event);
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
> +		if (!(status & PCI_EXP_DPC_STATUS_TRIGGER)) {
> +			pci_err(pdev, "Invalid DPC trigger %x\n", status);
> +			goto edr_unlock;

This skips _OST, but I think we do need to evaluate _OST in this case.
The ECN says:

  If the OS continues operation, the OS must inform the Firmware of
  the status of the recovery operation via the _OST method.

> +		}
> +		dpc_process_error(dpc);
> +	}
> +
> +	/*
> +	 * If recovery is successful, send _OST(0xF, BDF << 16 | 0x80)
> +	 * to firmware. If not successful, send _OST(0xF, BDF << 16 | 0x81).
> +	 */
> +	if (dpc->error_state == PCI_ERS_RESULT_RECOVERED)
> +		status = 0x80;
> +	else
> +		status = 0x81;

There are constants defined in include/linux/acpi.h for similar cases
(ACPI_OST_SC_OS_SHUTDOWN_DENIED, etc).  Can you add definitions for
these EDR _OST cases?

> +	/* Use ACPI handle of DPC event device for sending EDR status */
> +	dpc = (struct dpc_dev *) data;

No cast needed.

> +	acpi_send_edr_status(pdev, dpc->adev->handle, status);
> +
> +edr_unlock:
> +	mutex_unlock(&dpc->edr_lock);
> +done:
> +	pci_dev_put(pdev);
> +}
> +
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
>  
>  	dpc = devm_kzalloc(device, sizeof(*dpc), GFP_KERNEL);
> @@ -324,6 +414,9 @@ static int dpc_probe(struct pcie_device *dev)
>  		dpc->edr_enabled = 1;
>  	set_service_data(dev, dpc);
>  
> +	dpc->error_state = PCI_ERS_RESULT_NONE;
> +	mutex_init(&dpc->edr_lock);
> +
>  	/*
>  	 * As per PCIe spec r5.0, implementation note titled "Determination
>  	 * of DPC Control", to avoid conflicts over whether platform
> @@ -352,6 +445,35 @@ static int dpc_probe(struct pcie_device *dev)
>  		}
>  	}
>  
> +#ifdef CONFIG_ACPI
> +	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);

Did you build this?  It adds a warning:

  drivers/pci/pcie/dpc.c: In function ‘dpc_probe’:
  drivers/pci/pcie/dpc.c:456:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
    ^~~~~~

> +	if (pcie_aer_get_firmware_first(pdev) && adev) {
> +		acpi_status astatus;
> +
> +		dpc->adev = adev;
> +
> +		astatus = acpi_install_notify_handler(adev->handle,
> +						      ACPI_SYSTEM_NOTIFY,
> +						      edr_handle_event,
> +						      dpc);
> +
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
> @@ -403,6 +525,7 @@ static struct pcie_port_service_driver dpcdriver = {
>  	.probe		= dpc_probe,
>  	.remove		= dpc_remove,
>  	.reset_link	= dpc_reset_link,
> +	.error_resume   = dpc_error_resume,
>  };
>  
>  int __init pcie_dpc_init(void)
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index 62b7fdcc661c..36ffe1e16e69 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -117,6 +117,17 @@ static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
>  static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
>  #endif	/* CONFIG_ACPI */
>  
> +#if defined(CONFIG_PCIE_DPC) && defined(CONFIG_ACPI)

Follow the existing style in this file: use "#ifdef CONFIG_PCIE_DPC",
not "#if defined(CONFIG_PCIE_DPC)".

Most of the file is already wrapped with "#ifdef CONFIG_ACPI", so you
shouldn't need to add a new one.  You should be able to place these
additions so they're covered by the existing one.

> +#define EDR_PORT_ENABLE_DSM     0x0C
> +#define EDR_PORT_LOCATE_DSM     0x0D

These constants should be placed right next to the existing constants
for _DSM, e.g., IGNORE_PCI_BOOT_CONFIG_DSM.

> +int acpi_enable_dpc_port(struct pci_dev *pdev, acpi_handle handle,
> +			 bool enable);
> +struct pci_dev *acpi_locate_dpc_port(struct pci_dev *pdev,
> +				     acpi_handle handle);
> +int acpi_send_edr_status(struct pci_dev *pdev,
> +			 acpi_handle handle, u16 status);
> +#endif
> +
>  #ifdef CONFIG_ACPI_APEI
>  extern bool aer_acpi_firmware_first(void);
>  #else
> -- 
> 2.21.0
> 
