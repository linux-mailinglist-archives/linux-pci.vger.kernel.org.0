Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9431707EA
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2020 19:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgBZSpN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Feb 2020 13:45:13 -0500
Received: from mga05.intel.com ([192.55.52.43]:15629 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgBZSpN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Feb 2020 13:45:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 10:45:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,489,1574150400"; 
   d="scan'208";a="231899635"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 26 Feb 2020 10:45:11 -0800
Received: from [10.7.201.16] (skuppusw-desk.jf.intel.com [10.7.201.16])
        by linux.intel.com (Postfix) with ESMTP id DF668580544;
        Wed, 26 Feb 2020 10:45:10 -0800 (PST)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v15 4/5] PCI/DPC: Add Error Disconnect Recover (EDR)
 support
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
References: <20200226010231.GA238440@google.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <c961e365-6a5b-01f7-091a-c374848943fe@linux.intel.com>
Date:   Wed, 26 Feb 2020 10:42:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200226010231.GA238440@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

HI Bjorn,

Thanks for the review.

On 2/25/20 5:02 PM, Bjorn Helgaas wrote:
> On Thu, Feb 13, 2020 at 10:20:16AM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> As per ACPI specification r6.3, sec 5.6.6, when firmware owns Downstream
>> Port Containment (DPC), its expected to use the "Error Disconnect
>> Recover" (EDR) notification to alert OSPM of a DPC event and if OS
>> supports EDR, its expected to handle the software state invalidation and
>> port recovery in OS, and also let firmware know the recovery status via
>> _OST ACPI call. Related _OST status codes can be found in ACPI
>> specification r6.3, sec 6.3.5.2.
>>
>> Also, as per PCI firmware specification r3.2 Downstream Port Containment
>> Related Enhancements ECN, sec 4.5.1, table 4-6, If DPC is controlled by
>> firmware (firmware first mode), firmware is responsible for
>> configuring the DPC and OS is responsible for error recovery. Also, OS
>> is allowed to modify DPC registers only during the EDR notification
>> window.
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   drivers/pci/pci-acpi.c    |   3 +
>>   drivers/pci/pcie/Kconfig  |  10 ++
>>   drivers/pci/pcie/Makefile |   1 +
>>   drivers/pci/pcie/edr.c    | 257 ++++++++++++++++++++++++++++++++++++++
>>   include/linux/pci-acpi.h  |   8 ++
>>   5 files changed, 279 insertions(+)
>>   create mode 100644 drivers/pci/pcie/edr.c
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index 0c02d500158f..6af5d6a04990 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -1258,6 +1258,7 @@ static void pci_acpi_setup(struct device *dev)
>>   
>>   	acpi_pci_wakeup(pci_dev, false);
>>   	acpi_device_power_add_dependent(adev, dev);
>> +	pci_acpi_add_edr_notifier(pci_dev);
>>   }
>>   
>>   static void pci_acpi_cleanup(struct device *dev)
>> @@ -1276,6 +1277,8 @@ static void pci_acpi_cleanup(struct device *dev)
>>   
>>   		device_set_wakeup_capable(dev, false);
>>   	}
>> +
>> +	pci_acpi_remove_edr_notifier(pci_dev);
>>   }
>>   
>>   static bool pci_acpi_bus_match(struct device *dev)
>> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
>> index 6e3c04b46fb1..772b1f4cb19e 100644
>> --- a/drivers/pci/pcie/Kconfig
>> +++ b/drivers/pci/pcie/Kconfig
>> @@ -140,3 +140,13 @@ config PCIE_BW
>>   	  This enables PCI Express Bandwidth Change Notification.  If
>>   	  you know link width or rate changes occur only to correct
>>   	  unreliable links, you may answer Y.
>> +
>> +config PCIE_EDR
>> +	bool "PCI Express Error Disconnect Recover support"
>> +	depends on PCIE_DPC && ACPI
>> +	help
>> +	  This option adds Error Disconnect Recover support as specified
>> +	  in the Downstream Port Containment Related Enhancements ECN to
>> +	  the PCI Firmware Specification r3.2.  Enable this if you want to
>> +	  support hybrid DPC model which uses both firmware and OS to
>> +	  implement DPC.
>> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
>> index efb9d2e71e9e..68da9280ff11 100644
>> --- a/drivers/pci/pcie/Makefile
>> +++ b/drivers/pci/pcie/Makefile
>> @@ -13,3 +13,4 @@ obj-$(CONFIG_PCIE_PME)		+= pme.o
>>   obj-$(CONFIG_PCIE_DPC)		+= dpc.o
>>   obj-$(CONFIG_PCIE_PTM)		+= ptm.o
>>   obj-$(CONFIG_PCIE_BW)		+= bw_notification.o
>> +obj-$(CONFIG_PCIE_EDR)		+= edr.o
>> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
>> new file mode 100644
>> index 000000000000..b3e9103585a1
>> --- /dev/null
>> +++ b/drivers/pci/pcie/edr.c
>> @@ -0,0 +1,257 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * PCI DPC Error Disconnect Recover support driver
>> + * Author: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> + *
>> + * Copyright (C) 2020 Intel Corp.
>> + */
>> +
>> +#define dev_fmt(fmt) "EDR: " fmt
>> +
>> +#include <linux/pci.h>
>> +#include <linux/pci-acpi.h>
>> +
>> +#include "portdrv.h"
>> +#include "dpc.h"
>> +#include "../pci.h"
>> +
>> +#define EDR_PORT_ENABLE_DSM		0x0C
>> +#define EDR_PORT_LOCATE_DSM		0x0D
>> +#define EDR_OST_SUCCESS			0x80
>> +#define EDR_OST_FAILED			0x81
>> +
>> +/*
>> + * _DSM wrapper function to enable/disable DPC port.
>> + * @pdev   : PCI device structure.
>> + * @enable: status of DPC port (0 or 1).
> Either line up these colons or join them with the parameter names
> (also below).
ok. will do it.
>
>> + * returns 0 on success or errno on failure.
>> + */
>> +static int acpi_enable_dpc_port(struct pci_dev *pdev, bool enable)
> We only call this with "true", so the "enable" parameter is pointless.
Makes sense. I will remove it. We can add it if needed in future.
>
>> +{
>> +	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
>> +	union acpi_object *obj, argv4, req;
>> +	int status = 0;
>> +
>> +	req.type = ACPI_TYPE_INTEGER;
>> +	req.integer.value = enable;
>> +
>> +	argv4.type = ACPI_TYPE_PACKAGE;
>> +	argv4.package.count = 1;
>> +	argv4.package.elements = &req;
>> +
>> +	/*
>> +	 * Per the Downstream Port Containment Related Enhancements ECN to
>> +	 * the PCI Firmware Specification r3.2, sec 4.6.12,
>> +	 * EDR_PORT_ENABLE_DSM is optional.  Return success if it's not
>> +	 * implemented.
>> +	 */
>> +	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
>> +				EDR_PORT_ENABLE_DSM, &argv4);
>> +	if (!obj)
>> +		return 0;
>> +
>> +	if (obj->type != ACPI_TYPE_INTEGER || obj->integer.value != enable)
>> +		status = -EIO;
>> +
>> +	ACPI_FREE(obj);
>> +
>> +	return status;
>> +}
>> +
>> +/*
>> + * _DSM wrapper function to locate DPC port.
>> + * @pdev   : Device which received EDR event.
>> + *
>> + * returns pci_dev or NULL.
>> + */
>> +static struct pci_dev *acpi_locate_dpc_port(struct pci_dev *pdev)
>> +{
>> +	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
>> +	union acpi_object *obj;
>> +	u16 port;
>> +
>> +	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
>> +				EDR_PORT_LOCATE_DSM, NULL);
>> +	if (!obj)
>> +		return pci_dev_get(pdev);
>> +
>> +	if (obj->type != ACPI_TYPE_INTEGER) {
> If this happens, it's a firmware defect, isn't it?  I think maybe we
> should warn here.  I know we warn below ("No valid port found"), but
> that doesn't give any clue about the fact that firmware screwed up.
I will add it in next version.
>
>> +		ACPI_FREE(obj);
>> +		return NULL;
>> +	}
>> +
>> +	/*
>> +	 * Firmware returns DPC port BDF details in following format:
>> +	 *	15:8 = bus
>> +	 *	 7:3 = device
>> +	 *	 2:0 = function
>> +	 */
>> +	port = obj->integer.value;
>> +
>> +	ACPI_FREE(obj);
>> +
>> +	return pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
>> +					   PCI_BUS_NUM(port), port & 0xff);
>> +}
>> +
>> +/*
>> + * _OST wrapper function to let firmware know the status of EDR event.
>> + * @pdev   : Device used to send _OST.
>> + * @edev   : Device which experienced EDR event.
>> + * @status: Status of EDR event.
>> + */
>> +static int acpi_send_edr_status(struct pci_dev *pdev, struct pci_dev *edev,
>> +				u16 status)
>> +{
>> +	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
>> +	u32 ost_status;
>> +
>> +	pci_dbg(pdev, "Sending EDR status :%#x\n", status);
>> +
>> +	ost_status =  PCI_DEVID(edev->bus->number, edev->devfn);
>> +	ost_status = (ost_status << 16) | status;
>> +
>> +	status = acpi_evaluate_ost(adev->handle,
>> +				   ACPI_NOTIFY_DISCONNECT_RECOVER,
>> +				   ost_status, NULL);
>> +	if (ACPI_FAILURE(status))
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +pci_ers_result_t edr_dpc_reset_link(void *cb_data)
>> +{
>> +	return dpc_reset_link_common(cb_data);
>> +}
>> +
>> +static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>> +{
>> +	struct dpc_dev *dpc = data, ndpc;
> There's actually very little use of struct dpc_dev in this file.  I
> bet with a little elbow grease, we could remove it completely and just
> use the pci_dev * or maybe an opaque pointer.
Yes, we could remove it. But it might need some more changes to
dpc driver functions. I can think of two ways,

1. Re-factor the DPC driver not to use dpc_dev structure and just use
pci_dev in their functions implementation. But this might lead to
re-reading following dpc_dev structure members every time we
use it in dpc driver functions.

(Currently in dpc driver probe they cache the following device parameters )

   9         u16                     cap_pos;
  10         bool                    rp_extensions;
  11         u8                      rp_log_size;
  12         u16                     ctl;
  13         u16                     cap;

2. We can create a new variant of dpc_process_err() which depends on 
pci_dev
structure and move the dpc_dev initialization to it. Downside is, we 
should do this
initialization every time we get DPC event (which should be rare).

void dpc_process_error(struct pci_dev *pdev)
{
     struct dpc_dev dpc;
     dpc_dev_init(pdev, &dpc);

    ....

}

Let me know your comments.

>
>> +	struct pci_dev *pdev = dpc->pdev;
>> +	pci_ers_result_t estate = PCI_ERS_RESULT_DISCONNECT;
>> +	u16 status;
>> +
>> +	pci_info(pdev, "ACPI event %#x received\n", event);
>> +
>> +	if (event != ACPI_NOTIFY_DISCONNECT_RECOVER)
>> +		return;
>> +
>> +	/*
>> +	 * Check if _DSM(0xD) is available, and if present locate the
>> +	 * port which issued EDR event.
>> +	 */
>> +	pdev = acpi_locate_dpc_port(pdev);
> This function name should include "get" since it's part of the
> pci_dev_get()/pci_dev_put() sequence.
How about acpi_dpc_port_get(pdev) ?
>
>> +	if (!pdev) {
>> +		pci_err(dpc->pdev, "No valid port found\n");
>> +		return;
>> +	}
>> +
>> +	if (pdev != dpc->pdev) {
>> +		pci_warn(pdev, "Initializing dpc again\n");
>> +		dpc_dev_init(pdev, &ndpc);
> This seems...  I'm not sure what.  I guess it's really just reading
> the DPC capability for use by dpc_process_error(), so maybe it's OK.
> But it's a little strange to read.
>
> Is this something we should be warning about?
No this is a valid case. it will only happen if we have a non-acpi based 
switch
attached to root port.
>   I think the ECR says
> it's legitimate to return a child device, doesn't it?
>
>> +		dpc= &ndpc;
> Space before "=".
will fix it in next version.
>
>> +	}
>> +
>> +	/*
>> +	 * If port does not support DPC, just send the OST:
>> +	 */
>> +	if (!dpc->cap_pos)
>> +		goto send_ost;
>> +
>> +	/* Check if there is a valid DPC trigger */
>> +	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS, &status);
>> +	if (!(status & PCI_EXP_DPC_STATUS_TRIGGER)) {
>> +		pci_err(pdev, "Invalid DPC trigger %#010x\n", status);
>> +		goto send_ost;
>> +	}
>> +
>> +	dpc_process_error(dpc);
>> +
>> +	/* Clear AER registers */
>> +	pci_aer_clear_err_uncor_status(pdev);
>> +	pci_aer_clear_err_fatal_status(pdev);
>> +	pci_aer_clear_err_status_regs(pdev);
>> +
>> +	/*
>> +	 * Irrespective of whether the DPC event is triggered by
>> +	 * ERR_FATAL or ERR_NONFATAL, since the link is already down,
>> +	 * use the FATAL error recovery path for both cases.
>> +	 */
>> +	estate = pcie_do_recovery_common(pdev, pci_channel_io_frozen, -1,
>> +					 edr_dpc_reset_link, dpc);
>> +send_ost:
>> +
>> +	/* Use ACPI handle of DPC event device for sending EDR status */
>> +	dpc = data;
> I think it'd be clearer to reserve "dpc" for the device that received
> the notification and to which we send the status, and use a different
> "e_dpc" or something for the dpc_process_error() and related code.
ok. will make this change in next version.
>
>> +	/*
>> +	 * If recovery is successful, send _OST(0xF, BDF << 16 | 0x80)
>> +	 * to firmware. If not successful, send _OST(0xF, BDF << 16 | 0x81).
>> +	 */
>> +	if (estate == PCI_ERS_RESULT_RECOVERED)
>> +		acpi_send_edr_status(dpc->pdev, pdev, EDR_OST_SUCCESS);
>> +	else
>> +		acpi_send_edr_status(dpc->pdev, pdev, EDR_OST_FAILED);
>> +
>> +	pci_dev_put(pdev);
>> +}
>> +
>> +int pci_acpi_add_edr_notifier(struct pci_dev *pdev)
>> +{
>> +	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
>> +	struct dpc_dev *dpc;
>> +	acpi_status astatus;
>> +	int status;
>> +
>> +	/*
>> +	 * Per the Downstream Port Containment Related Enhancements ECN to
>> +	 * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-6, EDR support
>> +	 * can only be enabled if DPC is controlled by firmware.
>> +	 *
>> +	 * TODO: Remove dependency on ACPI FIRMWARE_FIRST bit to
>> +	 * determine ownership of DPC between firmware or OS.
> Extend the comment to say how we *should* determine ownership.
Yes, ownership should be based on _OSC negotiation. I will add necessary
comments here.
>
>> +	 */
>> +	if (!pcie_aer_get_firmware_first(pdev) || pcie_ports_dpc_native)
>> +		return -ENODEV;
>> +
>> +	if (!adev)
>> +		return 0;
>> +
>> +	dpc = devm_kzalloc(&pdev->dev, sizeof(*dpc), GFP_KERNEL);
> This kzalloc should be in dpc.c, not here.
>
> And I don't see a corresponding free.
It will be freed when removing the pdev right ? Do you want to free it 
explicitly in this driver ?
>
>> +	if (!dpc)
>> +		return -ENOMEM;
>> +
>> +	dpc_dev_init(pdev, dpc);
>> +
>> +	astatus = acpi_install_notify_handler(adev->handle,
>> +					      ACPI_SYSTEM_NOTIFY,
>> +					      edr_handle_event, dpc);
>> +	if (ACPI_FAILURE(astatus)) {
>> +		pci_err(pdev, "Install ACPI_SYSTEM_NOTIFY handler failed\n");
>> +		return -EBUSY;
>> +	}
>> +
>> +	status = acpi_enable_dpc_port(pdev, true);
>> +	if (status) {
>> +		pci_warn(pdev, "Enable DPC port failed\n");
>> +		acpi_remove_notify_handler(adev->handle,
>> +					   ACPI_SYSTEM_NOTIFY,
>> +					   edr_handle_event);
>> +		return status;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +void pci_acpi_remove_edr_notifier(struct pci_dev *pdev)
>> +{
>> +	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
>> +
>> +	if (!adev)
>> +		return;
>> +
>> +	acpi_remove_notify_handler(adev->handle, ACPI_SYSTEM_NOTIFY,
>> +				   edr_handle_event);
>> +}
>> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
>> index 62b7fdcc661c..a430e5fc50f3 100644
>> --- a/include/linux/pci-acpi.h
>> +++ b/include/linux/pci-acpi.h
>> @@ -112,6 +112,14 @@ extern const guid_t pci_acpi_dsm_guid;
>>   #define RESET_DELAY_DSM			0x08
>>   #define FUNCTION_DELAY_DSM		0x09
>>   
>> +#ifdef CONFIG_PCIE_EDR
>> +int pci_acpi_add_edr_notifier(struct pci_dev *pdev);
>> +void pci_acpi_remove_edr_notifier(struct pci_dev *pdev);
>> +#else
>> +static inline int pci_acpi_add_edr_notifier(struct pci_dev *pdev) { return 0; }
>> +static inline void pci_acpi_remove_edr_notifier(struct pci_dev *pdev) { }
>> +#endif /* CONFIG_PCIE_EDR */
>> +
>>   #else	/* CONFIG_ACPI */
>>   static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
>>   static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
>> -- 
>> 2.21.0
>>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

