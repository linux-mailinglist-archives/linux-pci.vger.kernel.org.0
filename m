Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E690645E2EB
	for <lists+linux-pci@lfdr.de>; Thu, 25 Nov 2021 23:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhKYWSv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Nov 2021 17:18:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:46872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233438AbhKYWQu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Nov 2021 17:16:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F137A6112D;
        Thu, 25 Nov 2021 22:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637878418;
        bh=RFXhoo0xHg4VMabIX9scPHIOIhA3BwHFHqNRwyi1wtk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Rbn0Ft5QW4Zu9W92AkAXWk4NeXHlwagP1ExTmvEvUBqwloeHXqNj+bPf+o0P8Jpt8
         a0rzX0WY+CI0h5awg3Ra8Ltvr2Q1eRVyyOdF/oZV3YiEYYaijenx5e6ayQnNpr0I6u
         yDnA51wWm8Tm0/wPIa4BNlGSoGugjGIGY4KEX/iDJWP2Qt0bSfnbeNA4gB+r9TZU9r
         jkLQRhDtED3PYQD70zM0c6xxYpgpPoB+4uPKKQLER64VX2k9DFRaPKhdgDROEYY2/y
         XOvzsrBImiKrS7IG3AViM8eVAcO0uXZXf6WEvgF8rW3STn2SN5r6elRlsfhIICOfl3
         4GydaI4XrXV+g==
Date:   Thu, 25 Nov 2021 16:13:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <kbusch@kernel.org>, kw@linux.com, pavel@ucw.cz
Subject: Re: [PATCH v3] Add support for PCIe SSD status LED management
Message-ID: <20211125221336.GA2316181@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813213653.3760-1-stuart.w.hayes@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 13, 2021 at 05:36:53PM -0400, Stuart Hayes wrote:
> This patch adds support for the PCIe SSD Status LED Management
> interface, as described in the "_DSM Additions for PCIe SSD Status LED
> Management" ECN to the PCI Firmware Specification revision 3.2.

I think r3.3 has been released, so we can cite that now.

> It will add (led_classdev) LEDs to each PCIe device that has a supported
> _DSM interface (one off/on LED per supported state). Both PCIe storage
> devices, and the ports to which they are connected, can support this
> interface.

To be OCD, we should tighten up the "ports to which they are
connected" part (see details below).

> + * drive_status_dev->dev could be the drive itself or its PCIe port

I assume you mean "drive_status_dev->pdev" (not "->dev")?

"... drive itself or its PCIe port" is ambiguous because switches and
endpoints both have Ports.  It sounds like this refers to either the
endpoint or the switch downstream port leading to it, which would
match the PCI Firmware spec language about the _DSM being "under the
ACPI object representing the embedded PCIe device/function or under
the ACPI PCIe description representing the add-in PCI Express slot."

> +struct drive_status_dev {
> +	struct list_head list;
> +	/* PCI device that has the LED controls */
> +	struct pci_dev *pdev;
> +	/* _DSM (or NPEM) LED ops */
> +	struct drive_status_led_ops *ops;
> +	/* currently active states */
> +	u32 states;
> +	int num_leds;
> +	struct drive_status_state_led leds[];
> +};

I think this would be easier to read if you can fit the comments to
the right on the same line, e.g.,

        struct pci_dev *pdev;           /* dev with controls */

> +static void dsm_status_err_print(struct pci_dev *pdev,
> +				 struct ssdleds_dsm_output *output)
> +{
> +	switch (output->status) {
> +	case 0:
> +		break;
> +	case 1:
> +		pci_dbg(pdev, "_DSM not supported\n");

pci_dbg() often goes nowhere.  Seems like these might be pci_info()?

> +static int dsm_set(struct pci_dev *pdev, u32 value)
> +{
> +	acpi_handle handle;
> +	union acpi_object *out_obj, arg3[2];
> +	struct ssdleds_dsm_output *dsm_output;
> +
> +	handle = ACPI_HANDLE(&pdev->dev);
> +	if (!handle)
> +		return -ENODEV;
> +
> +	arg3[0].type = ACPI_TYPE_PACKAGE;
> +	arg3[0].package.count = 1;
> +	arg3[0].package.elements = &arg3[1];
> +
> +	arg3[1].type = ACPI_TYPE_BUFFER;
> +	arg3[1].buffer.length = 4;
> +	arg3[1].buffer.pointer = (u8 *)&value;
> +
> +	out_obj = acpi_evaluate_dsm_typed(handle, &pcie_ssd_leds_dsm_guid,
> +				1, SET_STATE_DSM, &arg3[0], ACPI_TYPE_BUFFER);
> +	if (!out_obj)
> +		return -EIO;
> +
> +	if (out_obj->buffer.length < 8) {
> +		ACPI_FREE(out_obj);
> +		return -EIO;
> +	}
> +
> +	dsm_output = (struct ssdleds_dsm_output *)out_obj->buffer.pointer;
> +
> +	if (dsm_output->status != 0) {
> +		dsm_status_err_print(pdev, dsm_output);
> +		ACPI_FREE(out_obj);
> +		return -EIO;
> +	}
> +	ACPI_FREE(out_obj);
> +	return 0;
> +}
> +
> +static int dsm_get(struct pci_dev *pdev, u64 dsm_func, u32 *output)
> +{
> +	acpi_handle handle;
> +	union acpi_object *out_obj;
> +	struct ssdleds_dsm_output *dsm_output;
> +
> +	handle = ACPI_HANDLE(&pdev->dev);
> +	if (!handle)
> +		return -ENODEV;
> +
> +	out_obj = acpi_evaluate_dsm_typed(handle, &pcie_ssd_leds_dsm_guid, 0x1,
> +					  dsm_func, NULL, ACPI_TYPE_BUFFER);
> +	if (!out_obj)
> +		return -EIO;
> +
> +	if (out_obj->buffer.length < 8) {
> +		ACPI_FREE(out_obj);
> +		return -EIO;
> +	}
> +
> +	dsm_output = (struct ssdleds_dsm_output *)out_obj->buffer.pointer;
> +	if (dsm_output->status != 0) {
> +		dsm_status_err_print(pdev, dsm_output);
> +		ACPI_FREE(out_obj);
> +		return -EIO;
> +	}
> +
> +	*output = dsm_output->state;
> +	ACPI_FREE(out_obj);
> +	return 0;
> +}
> +
> +static int get_supported_states_dsm(struct pci_dev *pdev, u32 *states)
> +{
> +	return dsm_get(pdev, GET_SUPPORTED_STATES_DSM, states);
> +}
> +
> +static int get_current_states_dsm(struct pci_dev *pdev, u32 *states)
> +{
> +	return dsm_get(pdev, GET_STATE_DSM, states);
> +}
> +
> +static int set_current_states_dsm(struct pci_dev *pdev, u32 states)
> +{
> +	return dsm_set(pdev, states);
> +}
> +
> +static bool pdev_has_dsm(struct pci_dev *pdev)
> +{
> +	acpi_handle handle;
> +
> +	handle = ACPI_HANDLE(&pdev->dev);
> +	if (!handle)
> +		return false;
> +
> +	return acpi_check_dsm(handle, &pcie_ssd_leds_dsm_guid, 0x1,
> +			      1 << GET_SUPPORTED_STATES_DSM ||
> +			      1 << GET_STATE_DSM ||
> +			      1 << SET_STATE_DSM);
> +}
> +
> +struct drive_status_led_ops dsm_drive_status_led_ops = {
> +	.get_supported_states = get_supported_states_dsm,
> +	.get_current_states = get_current_states_dsm,
> +	.set_current_states = set_current_states_dsm,
> +};
> +
> +/*
> + * code not specific to method (_DSM/NPEM)
> + */
> +
> +static int set_brightness(struct led_classdev *led_cdev,
> +				       enum led_brightness brightness)
> +{
> +	struct drive_status_state_led *led;
> +	int err;
> +
> +	led = container_of(led_cdev, struct drive_status_state_led, cdev);
> +
> +	if (brightness == LED_OFF)
> +		clear_bit(led->bit, (unsigned long *)&(led->dsdev->states));
> +	else
> +		set_bit(led->bit, (unsigned long *)&(led->dsdev->states));
> +	err = led->dsdev->ops->set_current_states(led->dsdev->pdev,
> +						  led->dsdev->states);
> +	if (err < 0)
> +		return err;
> +	return 0;

Looks currently equivalent to simply "return err" (or
"return led->dsdev->ops->set_current_states(...)").

Is there a case where the ops might return something positive?

> +}
> +
> +static enum led_brightness get_brightness(struct led_classdev *led_cdev)
> +{
> +	struct drive_status_state_led *led;
> +
> +	led = container_of(led_cdev, struct drive_status_state_led, cdev);
> +	return test_bit(led->bit, (unsigned long *)&led->dsdev->states)
> +		? LED_ON : LED_OFF;
> +}
> +
> +static struct drive_status_dev *to_drive_status_dev(struct pci_dev *pdev)
> +{
> +	struct drive_status_dev *dsdev;
> +
> +	mutex_lock(&drive_status_dev_list_lock);
> +	list_for_each_entry(dsdev, &drive_status_dev_list, list)
> +		if (pdev == dsdev->pdev) {
> +			mutex_unlock(&drive_status_dev_list_lock);
> +			return dsdev;
> +		}

Even though the four-line body is technically a single statement, I
think braces around those lines would improve readability.

> +	mutex_unlock(&drive_status_dev_list_lock);
> +	return NULL;
> +}
> +
> +static void remove_drive_status_dev(struct drive_status_dev *dsdev)
> +{
> +	if (dsdev) {
> +		int i;

  if (!dsdev)
    return;

so you can unindent the usual path.

> +
> +		mutex_lock(&drive_status_dev_list_lock);
> +		list_del(&dsdev->list);
> +		mutex_unlock(&drive_status_dev_list_lock);
> +		for (i = 0; i < dsdev->num_leds; i++)
> +			led_classdev_unregister(&dsdev->leds[i].cdev);
> +		kfree(dsdev);
> +	}
> +}
> +
> +static void add_drive_status_dev(struct pci_dev *pdev,
> +				 struct drive_status_led_ops *ops)
> +{
> +	u32 supported;
> +	int ret, num_leds, i;
> +	struct drive_status_dev *dsdev;
> +	char name[LED_MAX_NAME_SIZE];
> +	struct drive_status_state_led *led;
> +
> +	if (to_drive_status_dev(pdev))
> +		/*
> +		 * leds have already been added for this dev

s/leds/LEDs/ to match other usage.

> +		 */
> +		return;
> +
> +	if (ops->get_supported_states(pdev, &supported) < 0)
> +		return;
> +	num_leds = hweight32(supported);
> +	if (num_leds == 0)
> +		return;
> +
> +	dsdev = kzalloc(struct_size(dsdev, leds, num_leds), GFP_KERNEL);
> +	if (!dsdev)
> +		return;
> +
> +	dsdev->num_leds = 0;
> +	dsdev->pdev = pdev;
> +	dsdev->ops = ops;
> +	dsdev->states = 0;
> +	if (ops->set_current_states(pdev, dsdev->states)) {
> +		kfree(dsdev);
> +		return;
> +	}
> +	INIT_LIST_HEAD(&dsdev->list);
> +	/*
> +	 * add LEDs only for supported states
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(led_states); i++) {
> +		if (!test_bit(led_states[i].bit, (unsigned long *)&supported))
> +			continue;
> +
> +		led = &dsdev->leds[dsdev->num_leds];
> +		led->dsdev = dsdev;
> +		led->bit = led_states[i].bit;
> +
> +		snprintf(name, sizeof(name), "%s::%s",
> +			 pci_name(pdev), led_states[i].name);
> +		led->cdev.name = name;
> +		led->cdev.max_brightness = LED_ON;
> +		led->cdev.brightness_set_blocking = set_brightness;
> +		led->cdev.brightness_get = get_brightness;
> +		ret = 0;
> +		ret = led_classdev_register(&pdev->dev, &led->cdev);
> +		if (ret) {
> +			pr_warn("Failed to register LEDs for %s\n", pci_name(pdev));

pci_warn().  Maybe include the led_states[i].name?

> +			remove_drive_status_dev(dsdev);
> +			return;
> +		}
> +		dsdev->num_leds++;
> +	}
> +
> +	mutex_lock(&drive_status_dev_list_lock);
> +	list_add_tail(&dsdev->list, &drive_status_dev_list);
> +	mutex_unlock(&drive_status_dev_list_lock);
> +}
> +
> +/*
> + * code specific to PCIe devices
> + */
> +static void probe_pdev(struct pci_dev *pdev)
> +{
> +	/*
> +	 * This is only supported on PCIe storage devices and PCIe ports
> +	 */
> +	if (pdev->class != PCI_CLASS_STORAGE_EXPRESS &&
> +	    pdev->class != PCI_CLASS_BRIDGE_PCI)

I don't see this restriction in the spec.  Did I miss it?

> +		return;
> +	if (pdev_has_dsm(pdev))
> +		add_drive_status_dev(pdev, &dsm_drive_status_led_ops);
> +}
> +
> +static int ssd_leds_pci_bus_notifier_cb(struct notifier_block *nb,
> +					   unsigned long action, void *data)
> +{
> +	struct pci_dev *pdev = to_pci_dev(data);
> +
> +	if (action == BUS_NOTIFY_ADD_DEVICE)
> +		probe_pdev(pdev);
> +	else if (action == BUS_NOTIFY_DEL_DEVICE)
> +		remove_drive_status_dev(to_drive_status_dev(pdev));
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block ssd_leds_pci_bus_nb = {
> +	.notifier_call = ssd_leds_pci_bus_notifier_cb,
> +	.priority = INT_MIN,
> +};
> +
> +static void initial_scan_for_leds(void)
> +{
> +	struct pci_dev *pdev = NULL;
> +
> +	for_each_pci_dev(pdev)
> +		probe_pdev(pdev);
> +}
> +
> +static int __init ssd_leds_init(void)
> +{
> +	mutex_init(&drive_status_dev_list_lock);
> +	INIT_LIST_HEAD(&drive_status_dev_list);
> +
> +	bus_register_notifier(&pci_bus_type, &ssd_leds_pci_bus_nb);
> +	initial_scan_for_leds();

This is the only way to deal with (a) making this a module that can be
loaded later and (b) handling hot-added devices, so I see why this is
here.  But it's ugly.  IMO, for_each_pci_dev() is a symptom of
something that should have been done during enumeration, but wasn't.

> +	return 0;
> +}
> +
> +static void __exit ssd_leds_exit(void)
> +{
> +	struct drive_status_dev *dsdev, *temp;
> +
> +	bus_unregister_notifier(&pci_bus_type, &ssd_leds_pci_bus_nb);
> +	list_for_each_entry_safe(dsdev, temp, &drive_status_dev_list, list)
> +		remove_drive_status_dev(dsdev);
> +}
> +
> +module_init(ssd_leds_init);
> +module_exit(ssd_leds_exit);
> +
> +MODULE_AUTHOR("Stuart Hayes <stuart.w.hayes@gmail.com>");
> +MODULE_DESCRIPTION("Support for PCIe SSD Status LEDs");
> +MODULE_LICENSE("GPL");
> -- 
> 2.27.0
> 
