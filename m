Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0E042360A
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 04:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237204AbhJFCo4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 22:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237247AbhJFCoo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Oct 2021 22:44:44 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9322C061764;
        Tue,  5 Oct 2021 19:42:52 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id n63so1983027oif.7;
        Tue, 05 Oct 2021 19:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tr0KYPe/fVnye4FXnhAw6KNaRDHoNdlOdPISm56lTCA=;
        b=U5I5AmxYEc5yD2ELups+oMphFtDx+oq8kT9WSwWOBuaPURT4l7bPTOUv3scQxHHPvw
         T+bww/MLjFaytQBhkQojoPPjSzeWqILp3fY7C4ElETgAqqSvbIOVGctgBIUgVBN255bd
         eosQeqiCc0Loq+ycYYqi6bWx3wQ+drNOCygsrY1fr2z/F7K3UU+9GfMoVhJuO2/N5G9d
         eqrlwFeCtq1oWHEyxb9QmUQBq2tJW54C410HsF+89H1ADfsMtQoTnEAMABdFNVccalxd
         DGsRRJFTTZ5CjWDYDw5M5SodT3Eo/OcS5Tnf0ynInn9lk/4ApISECfWw1y2fMMcPwaUv
         EACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tr0KYPe/fVnye4FXnhAw6KNaRDHoNdlOdPISm56lTCA=;
        b=4afrVVP7wiG+2ogzyMB6m58th83aqT3KwXv6RfBfX/xFPPFSAnCGXy6bSILrCKCXWg
         KwQIO/YjDHrOqJoOEk39IqO8mn14pKxTFwbqy/fKFd+LNm8D542EGB6OIdthzp6+ShCg
         Bxdzm/DS278OrOSrHYHztUvLe4D65jUcXCc+IGUSRXpxCKp3GL7YZ+GJh0Jt9Z3NPMBp
         cc1/3NTlxFcHisY3fDS4XqEyNeZYaH19uuP7A70YOHIMVnBPSI/DR8GrnUu+/bzKN+Ey
         5cZ4letd/dLhQApNcIJOH2M5oA9F4eyAruZFR4x1cjBsp3VoBublQg96W8qU2X0zpda/
         wYfw==
X-Gm-Message-State: AOAM533RnDC5iDOoc9b6CXjxvC5d26vsxXpxp5lNtL9TFcz4Tjy0YMnQ
        ytLWUvweh436fFvvXqc66nPoXnHiUyY=
X-Google-Smtp-Source: ABdhPJx5+bhlvz3kWOCLCp8qd2czFYvPWx8/Eu7DwkX9gP3SSR+QeGEl9hYArGF3Al0T7afyzmynEQ==
X-Received: by 2002:aca:af8e:: with SMTP id y136mr5588698oie.119.1633488171568;
        Tue, 05 Oct 2021 19:42:51 -0700 (PDT)
Received: from ?IPv6:2603:8081:2802:9dfb:49b3:8e2:3d6d:26c8? (2603-8081-2802-9dfb-49b3-08e2-3d6d-26c8.res6.spectrum.com. [2603:8081:2802:9dfb:49b3:8e2:3d6d:26c8])
        by smtp.gmail.com with ESMTPSA id g21sm3939305ooc.31.2021.10.05.19.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 19:42:51 -0700 (PDT)
Subject: Re: [PATCH v3] Add support for PCIe SSD status LED management
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Cc:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "lukas@wunner.de" <lukas@wunner.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
References: <20210813213653.3760-1-stuart.w.hayes@gmail.com>
 <5d1eb958c13553d70e4bee7a7b342febcf1c02ee.camel@intel.com>
From:   stuart hayes <stuart.w.hayes@gmail.com>
Message-ID: <4bb26dc0-9b82-21d6-0257-d50ec206a130@gmail.com>
Date:   Tue, 5 Oct 2021 21:42:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <5d1eb958c13553d70e4bee7a7b342febcf1c02ee.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/5/2021 12:14 AM, Williams, Dan J wrote:
> On Fri, 2021-08-13 at 17:36 -0400, Stuart Hayes wrote:
>> This patch adds support for the PCIe SSD Status LED Management
>> interface, as described in the "_DSM Additions for PCIe SSD Status LED
>> Management" ECN to the PCI Firmware Specification revision 3.2.
>>
>> It will add (led_classdev) LEDs to each PCIe device that has a supported
>> _DSM interface (one off/on LED per supported state). Both PCIe storage
>> devices, and the ports to which they are connected, can support this
>> interface.
> 
> Can you describe why this chose the drivers/leds/led-class.c route
> instead of drivers/misc/enclosure.c? Or, something simple / open-coded
> like drivers/ata/libata-sata.c? If that was already discussed in a
> previous posting just point me over there. My initial take away is that
> this is spending effort on gear matching with the led_classdev
> interface.
> 
> The comments that follow are just an initial pass based on being
> suprised about the led_classdev choice and the desire for NPEM support.
> 
> 

Thank you for the comments, Dan.

I originally did submit something simple that just added a couple of 
sysfs attributes to allow userspace access to the _DSM, but Greg K-H 
said (1) that I shouldn't create new driver-specific sysfs files that do 
things that existing class drivers do, and that if I'm allowing LEDs to 
be controlled by the user, I have to use the LED subsystem, so I went 
with that. (See the end of 
https://patchwork.ozlabs.org/project/linux-pci/patch/20201110153735.58587-1-stuart.w.hayes@gmail.com/)

I tried to make my code very similar to drivers/input/input-leds.c, 
where up to 11 LEDs per input device are registered.  Since NPEM/_DSM 
allows any of the states to be independently set or cleared, and any of 
the states may or may not be supported, it seemed very similar to me 
(except, as Pavel points out, the NPEM/_DSM states probably won't have 
one LED per state like the keyboard LEDs typically do).

I will look into drivers/misc/enclosure.c.  I think I didn't go that 
route initially as it appeared to be quite old and not widely used, and 
the states don't completely overlap.  More about it below.

>>
>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
>> ---
>> V2:
>>          * Simplified interface to a single "states" attribute under the LED
>>            classdev using only state names
>>          * Reworked driver to separate _DSM specific code, so support for
>>            NPEM (or other methods) could be easily be added
>>          * Use BIT macro
>> V3:
>>          * Changed code to use a single LED per supported state
>>          * Moved to drivers/pci/pcie
>>          * Changed Kconfig dependency to LEDS_CLASS instead of NEW_LEDS
>>          * Added PCI device class check before _DSM presence check
>>          * Other cleanups that don't affect the function
>>
>> ---
>>   drivers/pci/pcie/Kconfig    |  11 +
>>   drivers/pci/pcie/Makefile   |   1 +
>>   drivers/pci/pcie/ssd-leds.c | 419 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 431 insertions(+)
>>   create mode 100644 drivers/pci/pcie/ssd-leds.c
>>
>> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
>> index 45a2ef702b45..b738d473209f 100644
>> --- a/drivers/pci/pcie/Kconfig
>> +++ b/drivers/pci/pcie/Kconfig
>> @@ -142,3 +142,14 @@ config PCIE_EDR
>>            the PCI Firmware Specification r3.2.  Enable this if you want to
>>            support hybrid DPC model which uses both firmware and OS to
>>            implement DPC.
>> +
>> +config PCIE_SSD_LEDS
>> +       tristate "PCIe SSD status LED support"
>> +       depends on ACPI && LEDS_CLASS
> 
> This "depends on ACPI" is awkward when this grows NPEM support. I feel
> like NPEM is the first class citizen and then ACPI optionally overrides
> NPEM support if present.
> 
> 

I didn't actually think about NPEM when I originally submitted this... 
and even now, as I submitted it, it only uses the _DSM method, so it is 
useless without ACPI.  The ACPI dependency could go if NPEM support was 
added, for sure.

>> +       help
>> +         Driver for PCIe SSD status LED management as described in a PCI
>> +         Firmware Specification, Revision 3.2 ECN.
> 
> The auxiliary bus [1] was recently added as a way for drivers to carve
> off functionality into sub-device / sub-driver pairs. One benefit from
> the auxiliary bus organization is that the NPEM driver gets a propoer
> alias and auto-loading support. As is this driver appears to need to be
> manually loaded.
> 
> [1]: Documentation/driver-api/auxiliary_bus.rst
> 

Yes, unfortunately, it would need to be manually loaded.  I flip-flopped 
multiple times on making this just a library that the nvme driver could 
call to register the LEDs (if the _DSM was present).  It would be 
simpler, it wouldn't need a module to be manulaly loaded, it would 
resulted in better LED names (if the _DSM was on the NVMe PCI device), 
and it would mean that the driver that owns the PCI device would also 
own the LEDs.

The only reason I didn't do that, is that the _DSM can be on the PCIe 
port that the NVMe device is connected to, rather than on the NVMe drive 
PCI device.  And I'm not sure how to deal with the latter situation, 
except maybe change the pcie port bus driver to also call in to the 
library to register LEDs somehow.  But maybe it would be worth trying to 
figure that out.

I was not aware of the auxiliary bus, thanks for pointing it out.  I 
glanced over it, and I'm not sure how it would help over just having a 
library that nvme, pcie port bus driver, CXL, or whatever could call into.


>> +
>> +         When enabled, LED interfaces will be created for supported drive
>> +         states for each PCIe device that has the ACPI _DSM method described
>> +         in the referenced specification.
>> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
>> index b2980db88cc0..fbcb8c2d1dc1 100644
>> --- a/drivers/pci/pcie/Makefile
>> +++ b/drivers/pci/pcie/Makefile
>> @@ -13,3 +13,4 @@ obj-$(CONFIG_PCIE_PME)                += pme.o
>>   obj-$(CONFIG_PCIE_DPC)         += dpc.o
>>   obj-$(CONFIG_PCIE_PTM)         += ptm.o
>>   obj-$(CONFIG_PCIE_EDR)         += edr.o
>> +obj-$(CONFIG_PCIE_SSD_LEDS)    += ssd-leds.o
>> diff --git a/drivers/pci/pcie/ssd-leds.c b/drivers/pci/pcie/ssd-leds.c
>> new file mode 100644
>> index 000000000000..cacb77e5da2d
>> --- /dev/null
>> +++ b/drivers/pci/pcie/ssd-leds.c
>> @@ -0,0 +1,419 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Module to provide LED interfaces for PCIe SSD status LED states, as
>> + * defined in the "_DSM additions for PCIe SSD Status LED Management" ECN
>> + * to the PCI Firmware Specification Revision 3.2, dated 12 February 2020.
>> + *
>> + * The "_DSM..." spec is functionally similar to Native PCIe Enclosure
>> + * Management, but uses a _DSM ACPI method rather than a PCIe extended
>> + * capability.
>> + *
>> + * Copyright (c) 2021 Dell Inc.
>> + *
>> + * TODO: Add NPEM support
>> + */
>> +
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/leds.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/pci.h>
>> +#include <uapi/linux/uleds.h>
>> +
>> +#define DRIVER_NAME    "pcie-ssd-leds"
>> +#define DRIVER_VERSION "v1.0"
>> +
>> +struct led_state {
>> +       char *name;
>> +       int bit;
>> +};
>> +
>> +static struct led_state led_states[] = {
>> +       { .name = "ok",         .bit = 2 },
>> +       { .name = "locate",     .bit = 3 },
>> +       { .name = "failed",     .bit = 4 },
>> +       { .name = "rebuild",    .bit = 5 },
>> +       { .name = "pfa",        .bit = 6 },
>> +       { .name = "hotspare",   .bit = 7 },
>> +       { .name = "ica",        .bit = 8 },
>> +       { .name = "ifa",        .bit = 9 },
>> +       { .name = "invalid",    .bit = 10 },
>> +       { .name = "disabled",   .bit = 11 },
>> +};
> 
> include/linux/enclosure.h has common ABI definitions of industry
> standard enclosure LED settings. The above looks to be open coding the
> same?
>

The LED states in inluce/linux/enclosure.h aren't exactly the same... 
there are states defined in NPEM/_DSM that aren't defined in 
enclosure.h.  In addition, while the enclosure driver allows "locate" to 
be controlled independently, it looks like it will only allow a single 
state (unsupported/ok/critical/etc) to be active at a time, while the 
NPEM/_DSM allow all of the state bits to be independently set or 
cleared.  Maybe only one of those states would need to be set at a time, 
I don't know, but that would impose a limitation on what NPEM/_DSM can 
do.  I'll take a closer look at this as an alternative to using 
drivers/leds/led-class.c.


>> +
>> +struct drive_status_led_ops {
>> +       int (*get_supported_states)(struct pci_dev *pdev, u32 *states);
>> +       int (*get_current_states)(struct pci_dev *pdev, u32 *states);
>> +       int (*set_current_states)(struct pci_dev *pdev, u32 states);
>> +};
>> +
>> +struct drive_status_state_led {
>> +       struct led_classdev cdev;
>> +       struct drive_status_dev *dsdev;
>> +       int bit;
>> +};
>> +
>> +/*
>> + * drive_status_dev->dev could be the drive itself or its PCIe port
>> + */
>> +struct drive_status_dev {
>> +       struct list_head list;
>> +       /* PCI device that has the LED controls */
>> +       struct pci_dev *pdev;
>> +       /* _DSM (or NPEM) LED ops */
>> +       struct drive_status_led_ops *ops;
>> +       /* currently active states */
>> +       u32 states;
>> +       int num_leds;
>> +       struct drive_status_state_led leds[];
>> +};
>> +
>> +struct mutex drive_status_dev_list_lock;
>> +struct list_head drive_status_dev_list;
>> +
>> +/*
>> + * _DSM LED control
>> + */
>> +const guid_t pcie_ssd_leds_dsm_guid =
>> +       GUID_INIT(0x5d524d9d, 0xfff9, 0x4d4b,
>> +                 0x8c, 0xb7, 0x74, 0x7e, 0xd5, 0x1e, 0x19, 0x4d);
>> +
>> +#define GET_SUPPORTED_STATES_DSM       0x01
>> +#define GET_STATE_DSM                  0x02
>> +#define SET_STATE_DSM                  0x03
>> +
>> +struct ssdleds_dsm_output {
>> +       u16 status;
>> +       u8 function_specific_err;
>> +       u8 vendor_specific_err;
>> +       u32 state;
>> +};
>> +
>> +static void dsm_status_err_print(struct pci_dev *pdev,
>> +                                struct ssdleds_dsm_output *output)
>> +{
>> +       switch (output->status) {
>> +       case 0:
>> +               break;
>> +       case 1:
>> +               pci_dbg(pdev, "_DSM not supported\n");
>> +               break;
>> +       case 2:
>> +               pci_dbg(pdev, "_DSM invalid input parameters\n");
>> +               break;
>> +       case 3:
>> +               pci_dbg(pdev, "_DSM communication error\n");
>> +               break;
>> +       case 4:
>> +               pci_dbg(pdev, "_DSM function-specific error 0x%x\n",
>> +                       output->function_specific_err);
>> +               break;
>> +       case 5:
>> +               pci_dbg(pdev, "_DSM vendor-specific error 0x%x\n",
>> +                       output->vendor_specific_err);
>> +               break;
>> +       default:
>> +               pci_dbg(pdev, "_DSM returned unknown status 0x%x\n",
>> +                       output->status);
>> +       }
>> +}
>> +
>> +static int dsm_set(struct pci_dev *pdev, u32 value)
>> +{
>> +       acpi_handle handle;
>> +       union acpi_object *out_obj, arg3[2];
>> +       struct ssdleds_dsm_output *dsm_output;
>> +
>> +       handle = ACPI_HANDLE(&pdev->dev);
>> +       if (!handle)
>> +               return -ENODEV;
>> +
>> +       arg3[0].type = ACPI_TYPE_PACKAGE;
>> +       arg3[0].package.count = 1;
>> +       arg3[0].package.elements = &arg3[1];
>> +
>> +       arg3[1].type = ACPI_TYPE_BUFFER;
>> +       arg3[1].buffer.length = 4;
>> +       arg3[1].buffer.pointer = (u8 *)&value;
>> +
>> +       out_obj = acpi_evaluate_dsm_typed(handle, &pcie_ssd_leds_dsm_guid,
>> +                               1, SET_STATE_DSM, &arg3[0], ACPI_TYPE_BUFFER);
>> +       if (!out_obj)
>> +               return -EIO;
>> +
>> +       if (out_obj->buffer.length < 8) {
>> +               ACPI_FREE(out_obj);
>> +               return -EIO;
>> +       }
>> +
>> +       dsm_output = (struct ssdleds_dsm_output *)out_obj->buffer.pointer;
>> +
>> +       if (dsm_output->status != 0) {
>> +               dsm_status_err_print(pdev, dsm_output);
>> +               ACPI_FREE(out_obj);
>> +               return -EIO;
>> +       }
>> +       ACPI_FREE(out_obj);
>> +       return 0;
>> +}
>> +
>> +static int dsm_get(struct pci_dev *pdev, u64 dsm_func, u32 *output)
>> +{
>> +       acpi_handle handle;
>> +       union acpi_object *out_obj;
>> +       struct ssdleds_dsm_output *dsm_output;
>> +
>> +       handle = ACPI_HANDLE(&pdev->dev);
>> +       if (!handle)
>> +               return -ENODEV;
>> +
>> +       out_obj = acpi_evaluate_dsm_typed(handle, &pcie_ssd_leds_dsm_guid, 0x1,
>> +                                         dsm_func, NULL, ACPI_TYPE_BUFFER);
>> +       if (!out_obj)
>> +               return -EIO;
>> +
>> +       if (out_obj->buffer.length < 8) {
>> +               ACPI_FREE(out_obj);
>> +               return -EIO;
>> +       }
>> +
>> +       dsm_output = (struct ssdleds_dsm_output *)out_obj->buffer.pointer;
>> +       if (dsm_output->status != 0) {
>> +               dsm_status_err_print(pdev, dsm_output);
>> +               ACPI_FREE(out_obj);
>> +               return -EIO;
>> +       }
>> +
>> +       *output = dsm_output->state;
>> +       ACPI_FREE(out_obj);
>> +       return 0;
>> +}
>> +
>> +static int get_supported_states_dsm(struct pci_dev *pdev, u32 *states)
>> +{
>> +       return dsm_get(pdev, GET_SUPPORTED_STATES_DSM, states);
>> +}
>> +
>> +static int get_current_states_dsm(struct pci_dev *pdev, u32 *states)
>> +{
>> +       return dsm_get(pdev, GET_STATE_DSM, states);
>> +}
>> +
>> +static int set_current_states_dsm(struct pci_dev *pdev, u32 states)
>> +{
>> +       return dsm_set(pdev, states);
>> +}
>> +
>> +static bool pdev_has_dsm(struct pci_dev *pdev)
>> +{
>> +       acpi_handle handle;
>> +
>> +       handle = ACPI_HANDLE(&pdev->dev);
>> +       if (!handle)
>> +               return false;
>> +
>> +       return acpi_check_dsm(handle, &pcie_ssd_leds_dsm_guid, 0x1,
>> +                             1 << GET_SUPPORTED_STATES_DSM ||
>> +                             1 << GET_STATE_DSM ||
>> +                             1 << SET_STATE_DSM);
>> +}
>> +
>> +struct drive_status_led_ops dsm_drive_status_led_ops = {
>> +       .get_supported_states = get_supported_states_dsm,
>> +       .get_current_states = get_current_states_dsm,
>> +       .set_current_states = set_current_states_dsm,
>> +};
>> +
>> +/*
>> + * code not specific to method (_DSM/NPEM)
>> + */
>> +
>> +static int set_brightness(struct led_classdev *led_cdev,
>> +                                      enum led_brightness brightness)
>> +{
>> +       struct drive_status_state_led *led;
>> +       int err;
>> +
>> +       led = container_of(led_cdev, struct drive_status_state_led, cdev);
>> +
>> +       if (brightness == LED_OFF)
>> +               clear_bit(led->bit, (unsigned long *)&(led->dsdev->states));
>> +       else
>> +               set_bit(led->bit, (unsigned long *)&(led->dsdev->states));
>> +       err = led->dsdev->ops->set_current_states(led->dsdev->pdev,
>> +                                                 led->dsdev->states);
>> +       if (err < 0)
>> +               return err;
>> +       return 0;
>> +}
>> +
>> +static enum led_brightness get_brightness(struct led_classdev *led_cdev)
>> +{
>> +       struct drive_status_state_led *led;
>> +
>> +       led = container_of(led_cdev, struct drive_status_state_led, cdev);
>> +       return test_bit(led->bit, (unsigned long *)&led->dsdev->states)
>> +               ? LED_ON : LED_OFF;
>> +}
>> +
>> +static struct drive_status_dev *to_drive_status_dev(struct pci_dev *pdev)
>> +{
>> +       struct drive_status_dev *dsdev;
>> +
>> +       mutex_lock(&drive_status_dev_list_lock);
>> +       list_for_each_entry(dsdev, &drive_status_dev_list, list)
>> +               if (pdev == dsdev->pdev) {
>> +                       mutex_unlock(&drive_status_dev_list_lock);
>> +                       return dsdev;
>> +               }
>> +       mutex_unlock(&drive_status_dev_list_lock);
>> +       return NULL;
>> +}
>> +
>> +static void remove_drive_status_dev(struct drive_status_dev *dsdev)
>> +{
>> +       if (dsdev) {
>> +               int i;
>> +
>> +               mutex_lock(&drive_status_dev_list_lock);
>> +               list_del(&dsdev->list);
>> +               mutex_unlock(&drive_status_dev_list_lock);
>> +               for (i = 0; i < dsdev->num_leds; i++)
>> +                       led_classdev_unregister(&dsdev->leds[i].cdev);
>> +               kfree(dsdev);
>> +       }
>> +}
>> +
>> +static void add_drive_status_dev(struct pci_dev *pdev,
>> +                                struct drive_status_led_ops *ops)
>> +{
>> +       u32 supported;
>> +       int ret, num_leds, i;
>> +       struct drive_status_dev *dsdev;
>> +       char name[LED_MAX_NAME_SIZE];
>> +       struct drive_status_state_led *led;
>> +
>> +       if (to_drive_status_dev(pdev))
>> +               /*
>> +                * leds have already been added for this dev
>> +                */
>> +               return;
>> +
>> +       if (ops->get_supported_states(pdev, &supported) < 0)
>> +               return;
>> +       num_leds = hweight32(supported);
>> +       if (num_leds == 0)
>> +               return;
>> +
>> +       dsdev = kzalloc(struct_size(dsdev, leds, num_leds), GFP_KERNEL);
>> +       if (!dsdev)
>> +               return;
>> +
>> +       dsdev->num_leds = 0;
>> +       dsdev->pdev = pdev;
>> +       dsdev->ops = ops;
>> +       dsdev->states = 0;
>> +       if (ops->set_current_states(pdev, dsdev->states)) {
>> +               kfree(dsdev);
>> +               return;
>> +       }
>> +       INIT_LIST_HEAD(&dsdev->list);
>> +       /*
>> +        * add LEDs only for supported states
>> +        */
>> +       for (i = 0; i < ARRAY_SIZE(led_states); i++) {
>> +               if (!test_bit(led_states[i].bit, (unsigned long *)&supported))
>> +                       continue;
>> +
>> +               led = &dsdev->leds[dsdev->num_leds];
>> +               led->dsdev = dsdev;
>> +               led->bit = led_states[i].bit;
>> +
>> +               snprintf(name, sizeof(name), "%s::%s",
>> +                        pci_name(pdev), led_states[i].name);
>> +               led->cdev.name = name;
>> +               led->cdev.max_brightness = LED_ON;
>> +               led->cdev.brightness_set_blocking = set_brightness;
>> +               led->cdev.brightness_get = get_brightness;
>> +               ret = 0;
>> +               ret = led_classdev_register(&pdev->dev, &led->cdev);
>> +               if (ret) {
>> +                       pr_warn("Failed to register LEDs for %s\n", pci_name(pdev));
>> +                       remove_drive_status_dev(dsdev);
>> +                       return;
>> +               }
>> +               dsdev->num_leds++;
>> +       }
>> +
>> +       mutex_lock(&drive_status_dev_list_lock);
>> +       list_add_tail(&dsdev->list, &drive_status_dev_list);
>> +       mutex_unlock(&drive_status_dev_list_lock);
>> +}
>> +
>> +/*
>> + * code specific to PCIe devices
>> + */
>> +static void probe_pdev(struct pci_dev *pdev)
>> +{
>> +       /*
>> +        * This is only supported on PCIe storage devices and PCIe ports
>> +        */
>> +       if (pdev->class != PCI_CLASS_STORAGE_EXPRESS &&
>> +           pdev->class != PCI_CLASS_BRIDGE_PCI)
>> +               return;
>> +       if (pdev_has_dsm(pdev))
>> +               add_drive_status_dev(pdev, &dsm_drive_status_led_ops);
>> +}
>> +
>> +static int ssd_leds_pci_bus_notifier_cb(struct notifier_block *nb,
>> +                                          unsigned long action, void *data)
>> +{
>> +       struct pci_dev *pdev = to_pci_dev(data);
>> +
>> +       if (action == BUS_NOTIFY_ADD_DEVICE)
>> +               probe_pdev(pdev);
>> +       else if (action == BUS_NOTIFY_DEL_DEVICE)
>> +               remove_drive_status_dev(to_drive_status_dev(pdev));
>> +       return NOTIFY_DONE;
>> +}
>> +
>> +static struct notifier_block ssd_leds_pci_bus_nb = {
>> +       .notifier_call = ssd_leds_pci_bus_notifier_cb,
>> +       .priority = INT_MIN,
>> +};
>> +
>> +static void initial_scan_for_leds(void)
>> +{
>> +       struct pci_dev *pdev = NULL;
>> +
>> +       for_each_pci_dev(pdev)
>> +               probe_pdev(pdev);
> 
> 
> This looks odd to me. Why force enable every occurrence these leds, and
> do so indepdendently of the bind state of the driver for the associated
> PCI device? I would expect that this support would be a library called
> by the NVME driver, or the CXL driver. A library just like the
> led_classdev infrastructure.
> 

I guess I didn't know of any reason why they shouldn't be enabled even 
if the nvme driver wasn't bound, if this driver was stand-alone, since 
the LED function doesn't depend on the nvme driver.  But yes, maybe it 
would be better to make this a library that the nvme driver (or pcie 
port bus driver, or CXL driver) calls to register LEDs.

Thank you for taking a look at this... I'm very glad for any help to get 
this done.

> 
>> +}
>> +
>> +static int __init ssd_leds_init(void)
>> +{
>> +       mutex_init(&drive_status_dev_list_lock);
>> +       INIT_LIST_HEAD(&drive_status_dev_list);
>> +
>> +       bus_register_notifier(&pci_bus_type, &ssd_leds_pci_bus_nb);
>> +       initial_scan_for_leds();
>> +       return 0;
>> +}
>> +
>> +static void __exit ssd_leds_exit(void)
>> +{
>> +       struct drive_status_dev *dsdev, *temp;
>> +
>> +       bus_unregister_notifier(&pci_bus_type, &ssd_leds_pci_bus_nb);
>> +       list_for_each_entry_safe(dsdev, temp, &drive_status_dev_list, list)
>> +               remove_drive_status_dev(dsdev);
>> +}
>> +
>> +module_init(ssd_leds_init);
>> +module_exit(ssd_leds_exit);
>> +
>> +MODULE_AUTHOR("Stuart Hayes <stuart.w.hayes@gmail.com>");
>> +MODULE_DESCRIPTION("Support for PCIe SSD Status LEDs");
>> +MODULE_LICENSE("GPL");
> 
