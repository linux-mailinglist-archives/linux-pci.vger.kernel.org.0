Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039D4397D1B
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jun 2021 01:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbhFAXll (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Jun 2021 19:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbhFAXll (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Jun 2021 19:41:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4B4C061574;
        Tue,  1 Jun 2021 16:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=9UJf1jj7FP6DA4MoZ2+i8x7SoI+XY+q0lSUWu2+yQAk=; b=2r/lj0FnrzCE8Asrp+xsTs2af7
        2JzLNBYgyDUwP/2vtP28uOSZEKpixR3LRE4mGp91VyxbHOAKHS8rMwlj0oLx/hx8bjxHbTSfheE0M
        lmEDGRYb4JiaxL5FmziMlf9ppN4Zc2cv36v+xu5yOzzP5VJ8PEueYd/KyOmKcA2A98KgGb2DamVvN
        pmR54Oba+2d9MIMAXyB1COIFsQGQe9/SXrjihuX4/uaJbNph+oi15Bj5YCX2hMIk5QGTJ1A4d9H8I
        Ti9GJte5YzkVJqz+2sGdhPJKzDa039HfMPTDhfhfYOMQMHphyAtUFeokVJzszvl9vk6nW4mvPEWkR
        bC9wbWsQ==;
Received: from [2601:1c0:6280:3f0::ce7d]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1loDzK-001GLa-C2; Tue, 01 Jun 2021 23:39:58 +0000
Subject: Re: [PATCH v2] Add support for PCIe SSD status LED management
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>, kw@linux.com,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>
References: <20210601203820.3647-1-stuart.w.hayes@gmail.com>
 <3d1272b8-4edc-f2b1-85ea-f5cea65b4871@infradead.org>
Message-ID: <0a8cf89b-43e0-147f-d9d9-dad17f6b9985@infradead.org>
Date:   Tue, 1 Jun 2021 16:39:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <3d1272b8-4edc-f2b1-85ea-f5cea65b4871@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/1/21 2:20 PM, Randy Dunlap wrote:
> Hi,
> 
> On 6/1/21 1:38 PM, Stuart Hayes wrote:
>> This patch adds support for the PCIe SSD Status LED Management
>> interface, as described in the "_DSM Additions for PCIe SSD Status LED
>> Management" ECN to the PCI Firmware Specification revision 3.2.
>>
>> It will add a single (led_classdev) LED for any PCIe device that has the
>> relevant _DSM--presumably only drives or drive slots will have this. The
>> available and active status states are exposed using attribute "states"
>> under the LED device. Reading this attribute will show the states supported
>> by the interface, and those states which are currently active are shown
>> in brackets, like this:
>>
>>  # echo "ok locate" >/sys/class/leds/0000:88:00.0::drive_status/states
>>  # cat /sys/class/leds/0000:88:00.0::drive_status/states
>>  [ok] [locate] failed rebuild pfa hotspare ica ifa invalid disabled
>>
>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
>> ---
>> V2:
>> 	* Simplified interface to a single "states" attribute under the LED
>> 	  classdev using only state names
>> 	* Reworked driver to separate _DSM specific code, so support for
>> 	  NPEM (or other methods) could be easily be added
>> 	* Use BIT macro
>>
>>  .../sysfs-class-led-driver-pcie-ssd-leds      |  18 +
>>  drivers/pci/Kconfig                           |  12 +
>>  drivers/pci/Makefile                          |   1 +
>>  drivers/pci/pcie-ssd-leds.c                   | 457 ++++++++++++++++++
>>  4 files changed, 488 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-pcie-ssd-leds
>>  create mode 100644 drivers/pci/pcie-ssd-leds.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-pcie-ssd-leds b/Documentation/ABI/testing/sysfs-class-led-driver-pcie-ssd-leds
>> new file mode 100644
>> index 000000000000..1f07733b6f35
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-led-driver-pcie-ssd-leds
>> @@ -0,0 +1,18 @@
>> +What:		/sys/class/leds/<led>/states
>> +Date:		April 2021
>> +Contact:	linux-pci@vger.kernel.org
>> +Description:
>> +		This attribute indicates the status states supported by a drive
>> +		or drive slot's LEDs, as defined in the "_DSM additions for PCIe
>> +		SSD Status LED Management" ECN to the PCI Firmware Specification
>> +		Revision 3.2, dated 12 February 2020, and in "Native PCIe
>> +		Enclosure Management", section 6.29 of the PCIe Base Spec 5.0.
>> +
>> +		Only supported states will be shown, and the currently active
>> +		states are shown in brackets.  The active state(s) can be written
>> +		by echoing a space or comma separated string of states to this
>> +		attribute.  For example:
>> +
>> +		# echo "ok locate" >/sys/class/leds/0000:88:00.0::drive_status/states
>> +		# cat /sys/class/leds/0000:88:00.0::drive_status/states
>> +		[ok] [locate] failed rebuild pfa hotspare ica ifa invalid disabled
>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>> index 0c473d75e625..f4acf1ad0fb5 100644
>> --- a/drivers/pci/Kconfig
>> +++ b/drivers/pci/Kconfig
>> @@ -190,6 +190,18 @@ config PCI_HYPERV
>>  	  The PCI device frontend driver allows the kernel to import arbitrary
>>  	  PCI devices from a PCI backend to support PCI driver domains.
>>  
>> +config PCIE_SSD_LEDS
>> +	tristate "PCIe SSD status LED support"
>> +	depends on ACPI && NEW_LEDS
> 
> I expect that should be LEDS_CLASS instead of NEW_LEDS.
> Did you test it with NEW_LEDS=y and LEDS_CLASS not set?
> 

ERROR: modpost: "led_classdev_register_ext" [drivers/pci/pcie-ssd-leds.ko] undefined!
ERROR: modpost: "led_classdev_unregister" [drivers/pci/pcie-ssd-leds.ko] undefined!

Yes, just change it to depends on LEDS_CLASS instead.

> 
> [adding Pavel and linux-leds m.l. for other review]
> 
>> +	help
>> +	  Driver for PCIe SSD status LED management as described in a PCI
>> +	  Firmware Specification, Revision 3.2 ECN.
>> +
>> +	  When enabled, an LED interface will be created for each PCIe device
>> +	  that has the ACPI method described in the referenced specification,
>> +	  to allow the device status LEDs for that PCIe device (presumably a
>> +	  solid state storage device or its slot) to be seen and controlled.
>> +
>>  choice
>>  	prompt "PCI Express hierarchy optimization setting"
>>  	default PCIE_BUS_DEFAULT
> 
> thanks.
> 


-- 
~Randy

