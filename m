Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49A77170A6F
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2020 22:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbgBZV24 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Feb 2020 16:28:56 -0500
Received: from mga05.intel.com ([192.55.52.43]:27794 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbgBZV2z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Feb 2020 16:28:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 13:28:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,489,1574150400"; 
   d="scan'208";a="256472775"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 26 Feb 2020 13:28:53 -0800
Received: from [10.7.201.16] (skuppusw-desk.jf.intel.com [10.7.201.16])
        by linux.intel.com (Postfix) with ESMTP id 1C2CA580544;
        Wed, 26 Feb 2020 13:28:53 -0800 (PST)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v15 3/5] PCI/EDR: Export AER, DPC and error recovery
 functions
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
References: <20200226211332.GA147989@google.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <2b37ed9b-3d6f-ea94-4591-86f9d5bbe543@linux.intel.com>
Date:   Wed, 26 Feb 2020 13:26:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200226211332.GA147989@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 2/26/20 1:13 PM, Bjorn Helgaas wrote:
> On Wed, Feb 26, 2020 at 11:30:43AM -0800, Kuppuswamy Sathyanarayanan wrote:
>> On 2/25/20 5:02 PM, Bjorn Helgaas wrote:
>>> On Thu, Feb 13, 2020 at 10:20:15AM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>>>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>> ...
>>>> +int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>>>> +{
>>>> +	if (pcie_aer_get_firmware_first(dev))
>>>> +		return -EIO;
>>>> +
>>>> +	return pci_aer_clear_err_status_regs(dev);
>>>> +}
>>> We started with these:
>>>
>>>     pci_cleanup_aer_uncorrect_error_status()
>>>     pci_aer_clear_fatal_status()
>>>     pci_cleanup_aer_error_status_regs()
>>>
>>> This was already a mess.  They do basically similar things, but the
>>> function names are a complete jumble.  Let's start with preliminary
>>> patches to name them consistently, e.g.,
>>>
>>>     pci_aer_clear_nonfatal_status()
>>>     pci_aer_clear_fatal_status()
>>>     pci_aer_clear_status()
>>>
>>> Now, for EDR you eventually add this in edr_handle_event():
>>>
>>>     edr_handle_event()
>>>     {
>>>       ...
>>>       pci_aer_clear_err_uncor_status(pdev);
>>>       pci_aer_clear_err_fatal_status(pdev);
>>>       pci_aer_clear_err_status_regs(pdev);
>>>
>>> I see that this path needs to clear the status even in the
>>> firmware-first case, so you do need some change for that.  But
>>> pci_aer_clear_err_status_regs() does exactly the same thing as
>>> pci_aer_clear_err_uncor_status() and pci_aer_clear_err_fatal_status()
>>> plus a little more (clearing PCI_ERR_ROOT_STATUS), so it should be
>>> sufficient to just call pci_aer_clear_err_status_regs().
>>>
>>> So I don't think you need to make wrappers for
>>> pci_aer_clear_nonfatal_status() and pci_aer_clear_fatal_status() at
>>> all since they're not needed by the EDR path.
>>>
>>> You *do* need a wrapper for pci_aer_clear_status(), but instead of
>>> just adding random words ("err", "regs") to the name, please name it
>>> something like pci_aer_raw_clear_status() as a hint that it skips
>>> some sort of check.
> What do you think about the above?
I agree with your comments.. I will use your recommendation in
naming the wrappers I need.
>
>>> I would split this into a separate patch.  This patch contains a bunch
>>> of things that aren't really related except that they're needed for
>>> EDR.  I think it will be more readable if each patch just does one
>>> piece of it.
>> Ok. I will split it into multiple patches. I just grouped them together
>> as a preparatory patch for adding EDR support.
> Sounds good.
>
>>>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>>>> index 99fca8400956..acae12dbf9ff 100644
>>>> --- a/drivers/pci/pcie/dpc.c
>>>> +++ b/drivers/pci/pcie/dpc.c
>>>> @@ -15,15 +15,9 @@
>>>>    #include <linux/pci.h>
>>>>    #include "portdrv.h"
>>>> +#include "dpc.h"
>>>>    #include "../pci.h"
>>>> -struct dpc_dev {
>>>> -	struct pci_dev		*pdev;
>>>> -	u16			cap_pos;
>>>> -	bool			rp_extensions;
>>>> -	u8			rp_log_size;
>>>> -};
>>> Adding dpc.h shouldn't be in this patch because there's no need for a
>>> separate dpc.h file yet -- it's only included this one place.  I'm not
>>> positive a dpc.h is needed at all -- see comments on patch [4/5].
>> Yes, if we use pdev in dpc functions used by EDR code, we should
>> not need it.
> I think struct dpc_dev might be more trouble than it's worth.  I
> attached a possible patch at the end that folds the 25 bits of
> DPC-related info into the struct pci_dev and gets rid of struct
> dpc_dev completely.  I compiled it but haven't tested it.
That would solve most of my export issues. Do you want me
to add it to my patch list or merge it separately.
>
>>>> -static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>>>> +pci_ers_result_t dpc_reset_link_common(struct dpc_dev *dpc)
>>>>    {
>>> I don't see why you need to split this into dpc_reset_link_common()
>>> and dpc_reset_link().  IIUC, you split it so the DPC driver path can
>>> supply a pci_dev * via
>>>
>>>     dpc_handler
>>>       pcie_do_recovery
>>>         pcie_do_recovery_common(..., NULL, NULL)
>>>           reset_link(..., NULL, NULL)
>>>             driver->reset_link(pdev)
>>>               dpc_reset_link(pdev)
>>>                 dpc = to_dpc_dev(pdev)
>> I have split it mainly because of dpc_dev dependency. If we use
>> dpc_reset_link(pdev) directly it will try to find related dpc_dev using
>> to_dpc_dev() function. But this will not work in FF mode where DPC
>> is handled by firmware and hence we will not have DPC pcie_port
>> service driver enumerated for this device.
> The patch below might help this case.
Yes.
>
>>>> +void dpc_dev_init(struct pci_dev *pdev, struct dpc_dev *dpc)
>>>> +{
>>> Can you include the kzalloc() here so we don't have to do the alloc in
>>> pci_acpi_add_edr_notifier()?
>> Currently dpc driver allocates dpc_dev structure using pcie_port->device
>> reference in its devm_alloc* calls. But if we allocate dpc_dev inside
>> this function we should use pci_dev->dev reference for it. Is it OK to us
>> pci_dev->dev reference for DPC driver allocations ?
> I think the patch below would solve this issue too because we don't
> need the alloc at all.
Agree.
>
>>> I think there's also a leak there: pci_acpi_add_edr_notifier()
>>> kzallocs a struct dpc_dev, but I don't see a corresponding kfree().
>> since we are using devm_allocs, It should be freed when removing
>> the PCI device right?
> Oh, right, sorry.
>
>
> commit 7fb9f4495711 ("PCI/DPC: Move data to struct pci_dev")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Wed Feb 26 08:00:55 2020 -0600
>
>      PCI/DPC: Move data to struct pci_dev
>      
>
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index e06f42f58d3d..6b116d7fdb89 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -17,13 +17,6 @@
>   #include "portdrv.h"
>   #include "../pci.h"
>   
> -struct dpc_dev {
> -	struct pcie_device	*dev;
> -	u16			cap_pos;
> -	bool			rp_extensions;
> -	u8			rp_log_size;
> -};
> -
>   static const char * const rp_pio_error_string[] = {
>   	"Configuration Request received UR Completion",	 /* Bit Position 0  */
>   	"Configuration Request received CA Completion",	 /* Bit Position 1  */
> @@ -46,63 +39,42 @@ static const char * const rp_pio_error_string[] = {
>   	"Memory Request Completion Timeout",		 /* Bit Position 18 */
>   };
>   
> -static struct dpc_dev *to_dpc_dev(struct pci_dev *dev)
> -{
> -	struct device *device;
> -
> -	device = pcie_port_find_device(dev, PCIE_PORT_SERVICE_DPC);
> -	if (!device)
> -		return NULL;
> -	return get_service_data(to_pcie_device(device));
> -}
> -
>   void pci_save_dpc_state(struct pci_dev *dev)
>   {
> -	struct dpc_dev *dpc;
>   	struct pci_cap_saved_state *save_state;
>   	u16 *cap;
>   
>   	if (!pci_is_pcie(dev))
>   		return;
>   
> -	dpc = to_dpc_dev(dev);
> -	if (!dpc)
> -		return;
> -
>   	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
>   	if (!save_state)
>   		return;
>   
>   	cap = (u16 *)&save_state->cap.data[0];
> -	pci_read_config_word(dev, dpc->cap_pos + PCI_EXP_DPC_CTL, cap);
> +	pci_read_config_word(dev, dev->dpc_cap + PCI_EXP_DPC_CTL, cap);
>   }
>   
>   void pci_restore_dpc_state(struct pci_dev *dev)
>   {
> -	struct dpc_dev *dpc;
>   	struct pci_cap_saved_state *save_state;
>   	u16 *cap;
>   
>   	if (!pci_is_pcie(dev))
>   		return;
>   
> -	dpc = to_dpc_dev(dev);
> -	if (!dpc)
> -		return;
> -
>   	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
>   	if (!save_state)
>   		return;
>   
>   	cap = (u16 *)&save_state->cap.data[0];
> -	pci_write_config_word(dev, dpc->cap_pos + PCI_EXP_DPC_CTL, *cap);
> +	pci_write_config_word(dev, dev->dpc_cap + PCI_EXP_DPC_CTL, *cap);
>   }
>   
> -static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
> +static int dpc_wait_rp_inactive(struct pci_dev *pdev)
>   {
>   	unsigned long timeout = jiffies + HZ;
> -	struct pci_dev *pdev = dpc->dev->port;
> -	u16 cap = dpc->cap_pos, status;
> +	u16 cap = pdev->dpc_cap, status;
>   
>   	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
>   	while (status & PCI_EXP_DPC_RP_BUSY &&
> @@ -119,15 +91,13 @@ static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
>   
>   static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>   {
> -	struct dpc_dev *dpc;
>   	u16 cap;
>   
>   	/*
>   	 * DPC disables the Link automatically in hardware, so it has
>   	 * already been reset by the time we get here.
>   	 */
> -	dpc = to_dpc_dev(pdev);
> -	cap = dpc->cap_pos;
> +	cap = pdev->dpc_cap;
>   
>   	/*
>   	 * Wait until the Link is inactive, then clear DPC Trigger Status
> @@ -135,7 +105,7 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>   	 */
>   	pcie_wait_for_link(pdev, false);
>   
> -	if (dpc->rp_extensions && dpc_wait_rp_inactive(dpc))
> +	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev))
>   		return PCI_ERS_RESULT_DISCONNECT;
>   
>   	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
> @@ -147,10 +117,9 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>   	return PCI_ERS_RESULT_RECOVERED;
>   }
>   
> -static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
> +static void dpc_process_rp_pio_error(struct pci_dev *pdev)
>   {
> -	struct pci_dev *pdev = dpc->dev->port;
> -	u16 cap = dpc->cap_pos, dpc_status, first_error;
> +	u16 cap = pdev->dpc_cap, dpc_status, first_error;
>   	u32 status, mask, sev, syserr, exc, dw0, dw1, dw2, dw3, log, prefix;
>   	int i;
>   
> @@ -175,7 +144,7 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
>   				first_error == i ? " (First)" : "");
>   	}
>   
> -	if (dpc->rp_log_size < 4)
> +	if (pdev->dpc_rp_log_size < 4)
>   		goto clear_status;
>   	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG,
>   			      &dw0);
> @@ -188,12 +157,12 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
>   	pci_err(pdev, "TLP Header: %#010x %#010x %#010x %#010x\n",
>   		dw0, dw1, dw2, dw3);
>   
> -	if (dpc->rp_log_size < 5)
> +	if (pdev->dpc_rp_log_size < 5)
>   		goto clear_status;
>   	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_IMPSPEC_LOG, &log);
>   	pci_err(pdev, "RP PIO ImpSpec Log %#010x\n", log);
>   
> -	for (i = 0; i < dpc->rp_log_size - 5; i++) {
> +	for (i = 0; i < pdev->dpc_rp_log_size - 5; i++) {
>   		pci_read_config_dword(pdev,
>   			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG, &prefix);
>   		pci_err(pdev, "TLP Prefix Header: dw%d, %#010x\n", i, prefix);
> @@ -226,10 +195,9 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
>   
>   static irqreturn_t dpc_handler(int irq, void *context)
>   {
> +	struct pci_dev *pdev = context;
> +	u16 cap = pdev->dpc_cap, status, source, reason, ext_reason;
>   	struct aer_err_info info;
> -	struct dpc_dev *dpc = context;
> -	struct pci_dev *pdev = dpc->dev->port;
> -	u16 cap = dpc->cap_pos, status, source, reason, ext_reason;
>   
>   	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
>   	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
> @@ -248,8 +216,8 @@ static irqreturn_t dpc_handler(int irq, void *context)
>   				     "reserved error");
>   
>   	/* show RP PIO error detail information */
> -	if (dpc->rp_extensions && reason == 3 && ext_reason == 0)
> -		dpc_process_rp_pio_error(dpc);
> +	if (pdev->dpc_rp_extensions && reason == 3 && ext_reason == 0)
> +		dpc_process_rp_pio_error(pdev);
>   	else if (reason == 0 &&
>   		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
>   		 aer_get_device_error_info(pdev, &info)) {
> @@ -266,9 +234,8 @@ static irqreturn_t dpc_handler(int irq, void *context)
>   
>   static irqreturn_t dpc_irq(int irq, void *context)
>   {
> -	struct dpc_dev *dpc = (struct dpc_dev *)context;
> -	struct pci_dev *pdev = dpc->dev->port;
> -	u16 cap = dpc->cap_pos, status;
> +	struct pci_dev *pdev = context;
> +	u16 cap = pdev->dpc_cap, status;
>   
>   	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
>   
> @@ -285,7 +252,6 @@ static irqreturn_t dpc_irq(int irq, void *context)
>   #define FLAG(x, y) (((x) & (y)) ? '+' : '-')
>   static int dpc_probe(struct pcie_device *dev)
>   {
> -	struct dpc_dev *dpc;
>   	struct pci_dev *pdev = dev->port;
>   	struct device *device = &dev->device;
>   	int status;
> @@ -294,43 +260,37 @@ static int dpc_probe(struct pcie_device *dev)
>   	if (pcie_aer_get_firmware_first(pdev) && !pcie_ports_dpc_native)
>   		return -ENOTSUPP;
>   
> -	dpc = devm_kzalloc(device, sizeof(*dpc), GFP_KERNEL);
> -	if (!dpc)
> -		return -ENOMEM;
> -
> -	dpc->cap_pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
> -	dpc->dev = dev;
> -	set_service_data(dev, dpc);
> +	pdev->dpc_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
>   
>   	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
>   					   dpc_handler, IRQF_SHARED,
> -					   "pcie-dpc", dpc);
> +					   "pcie-dpc", pdev);
>   	if (status) {
>   		pci_warn(pdev, "request IRQ%d failed: %d\n", dev->irq,
>   			 status);
>   		return status;
>   	}
>   
> -	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CAP, &cap);
> -	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &ctl);
> +	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
> +	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
>   
> -	dpc->rp_extensions = (cap & PCI_EXP_DPC_CAP_RP_EXT);
> -	if (dpc->rp_extensions) {
> -		dpc->rp_log_size = (cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
> -		if (dpc->rp_log_size < 4 || dpc->rp_log_size > 9) {
> +	pdev->dpc_rp_extensions = (cap & PCI_EXP_DPC_CAP_RP_EXT) ? 1 : 0;
> +	if (pdev->dpc_rp_extensions) {
> +		pdev->dpc_rp_log_size = (cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
> +		if (pdev->dpc_rp_log_size < 4 || pdev->dpc_rp_log_size > 9) {
>   			pci_err(pdev, "RP PIO log size %u is invalid\n",
> -				dpc->rp_log_size);
> -			dpc->rp_log_size = 0;
> +				pdev->dpc_rp_log_size);
> +			pdev->dpc_rp_log_size = 0;
>   		}
>   	}
>   
>   	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
> -	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
> +	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
>   
>   	pci_info(pdev, "error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
>   		 cap & PCI_EXP_DPC_IRQ, FLAG(cap, PCI_EXP_DPC_CAP_RP_EXT),
>   		 FLAG(cap, PCI_EXP_DPC_CAP_POISONED_TLP),
> -		 FLAG(cap, PCI_EXP_DPC_CAP_SW_TRIGGER), dpc->rp_log_size,
> +		 FLAG(cap, PCI_EXP_DPC_CAP_SW_TRIGGER), pdev->dpc_rp_log_size,
>   		 FLAG(cap, PCI_EXP_DPC_CAP_DL_ACTIVE));
>   
>   	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_DPC, sizeof(u16));
> @@ -339,13 +299,12 @@ static int dpc_probe(struct pcie_device *dev)
>   
>   static void dpc_remove(struct pcie_device *dev)
>   {
> -	struct dpc_dev *dpc = get_service_data(dev);
>   	struct pci_dev *pdev = dev->port;
>   	u16 ctl;
>   
> -	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &ctl);
> +	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
>   	ctl &= ~(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN);
> -	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
> +	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
>   }
>   
>   static struct pcie_port_service_driver dpcdriver = {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 3840a541a9de..a0b7e7a53741 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -444,6 +444,11 @@ struct pci_dev {
>   	const struct attribute_group **msi_irq_groups;
>   #endif
>   	struct pci_vpd *vpd;
> +#ifdef CONFIG_PCIE_DPC
> +	u16		dpc_cap;
> +	unsigned int	dpc_rp_extensions:1;
> +	u8		dpc_rp_log_size;
> +#endif
>   #ifdef CONFIG_PCI_ATS
>   	union {
>   		struct pci_sriov	*sriov;		/* PF: SR-IOV info */
>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

