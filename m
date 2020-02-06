Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58AEB153CC7
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2020 02:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgBFBuX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Feb 2020 20:50:23 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42864 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727170AbgBFBuX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Feb 2020 20:50:23 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D890461041343AB14862;
        Thu,  6 Feb 2020 09:50:21 +0800 (CST)
Received: from [127.0.0.1] (10.65.58.147) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Thu, 6 Feb 2020
 09:50:15 +0800
Subject: Re: [PATCH 4/6] PCI: Improve and rename PCIE_SPEED2STR macro
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20200205185057.GA230486@google.com>
CC:     <linux-pci@vger.kernel.org>, <f.fangjian@huawei.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <c5f68421-808a-1718-4b08-84a9a0c69ef6@hisilicon.com>
Date:   Thu, 6 Feb 2020 09:50:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200205185057.GA230486@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/2/6 2:50, Bjorn Helgaas wrote:
> On Wed, Jan 15, 2020 at 05:04:21PM +0800, Yicong Yang wrote:
>> Use pci_bus_speed_strings[] array to refactor PCIE_SPEED2STR macro.
>> Rename PCIE_SPEED2STR with PCI_SPEED2STR as it's also used to
>> decode non-PCIe speeds. Modify bus_speed_read() and
>> __pcie_print_link_status() with PCI_SPEED2STR macro.
> This looks like it should be split into two or three patches.
>
>   - Rename
>   - Fiddle with the "PCIe" suffix
>   - Refactor with pci_bus_speed_strings[]
>
> I don't know the right order for these.

I'll split this patch in next version.


>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>
>> I don't add a boundary check in PCI_SPEED2STR macro because:
>> 1. we cannot get the array size of an extern one using ARRAY_SIZE
>> 2. It is the *speed* should be check valid or not when assigned,
>> rather than checking it here. Actually we do make it valid when
>> assigned, the speed is either a valid value or PCI_SPEED_UNKNOWN.
>> And it's ensured in pcie_get_speed_cap(), pci_set_bus_speed()
>> when probe, and pcie_link_speed[] array. Please check again for
>> sure.
> I'm a little nervous about this because bus->cur_bus_speed and
> bus->max_bus_speed are set several places where we can't validate them
> (powerpc, s390, faraday_pci_probe(), cpqhpc_probe(), get_max_bus_speed
> (ibmphp), shpc_get_max_bus_speed(), etc).

Seems I didn't consider such situation. I'll add the boundary check in
next version.

Thanks,
Yang


>
> I don't think we can avoid out-of-bounds references by relying on all
> those places to get it right, especially since some of these can read
> speeds from hardware, so new hardware can give us a bus speed that old
> software won't know about.
>
>>  drivers/pci/pci-sysfs.c |  2 +-
>>  drivers/pci/pci.c       |  6 +++---
>>  drivers/pci/pci.h       | 10 +++-------
>>  drivers/pci/slot.c      | 10 +++-------
>>  4 files changed, 10 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>> index 13f766d..f4eafbc 100644
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
>> @@ -156,7 +156,7 @@ static ssize_t max_link_speed_show(struct device *dev,
>>  {
>>  	struct pci_dev *pdev = to_pci_dev(dev);
>>
>> -	return sprintf(buf, "%s\n", PCIE_SPEED2STR(pcie_get_speed_cap(pdev)));
>> +	return sprintf(buf, "%s\n", PCI_SPEED2STR(pcie_get_speed_cap(pdev)));
>>  }
>>  static DEVICE_ATTR_RO(max_link_speed);
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index e87196c..dce32ce 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -5868,14 +5868,14 @@ void __pcie_print_link_status(struct pci_dev *dev, bool verbose)
>>  	if (bw_avail >= bw_cap && verbose)
>>  		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth (%s x%d link)\n",
>>  			 bw_cap / 1000, bw_cap % 1000,
>> -			 PCIE_SPEED2STR(speed_cap), width_cap);
>> +			 PCI_SPEED2STR(speed_cap), width_cap);
>>  	else if (bw_avail < bw_cap)
>>  		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth, limited by %s x%d link at %s (capable of %u.%03u Gb/s with %s x%d link)\n",
>>  			 bw_avail / 1000, bw_avail % 1000,
>> -			 PCIE_SPEED2STR(speed), width,
>> +			 PCI_SPEED2STR(speed), width,
>>  			 limiting_dev ? pci_name(limiting_dev) : "<unknown>",
>>  			 bw_cap / 1000, bw_cap % 1000,
>> -			 PCIE_SPEED2STR(speed_cap), width_cap);
>> +			 PCI_SPEED2STR(speed_cap), width_cap);
>>  }
>>
>>  /**
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 5fb1d76..5e1f810 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -291,13 +291,9 @@ struct pci_bus *pci_bus_get(struct pci_bus *bus);
>>  void pci_bus_put(struct pci_bus *bus);
>>
>>  /* PCIe link information */
>> -#define PCIE_SPEED2STR(speed) \
>> -	((speed) == PCIE_SPEED_32_0GT ? "32 GT/s" : \
>> -	 (speed) == PCIE_SPEED_16_0GT ? "16 GT/s" : \
>> -	 (speed) == PCIE_SPEED_8_0GT ? "8 GT/s" : \
>> -	 (speed) == PCIE_SPEED_5_0GT ? "5 GT/s" : \
>> -	 (speed) == PCIE_SPEED_2_5GT ? "2.5 GT/s" : \
>> -	 "Unknown speed")
>> +#define PCI_SPEED2STR(speed) \
>> +	((speed) == PCI_SPEED_UNKNOWN ? "Unknown speed" : \
>> +	 pci_bus_speed_strings[speed])
>>
>>  /* PCIe speed to Mb/s reduced by encoding overhead */
>>  #define PCIE_SPEED2MBS_ENC(speed) \
>> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
>> index 140dafb..871d598 100644
>> --- a/drivers/pci/slot.c
>> +++ b/drivers/pci/slot.c
>> @@ -51,14 +51,10 @@ static ssize_t address_read_file(struct pci_slot *slot, char *buf)
>>
>>  static ssize_t bus_speed_read(enum pci_bus_speed speed, char *buf)
>>  {
>> -	const char *speed_string;
>> +	if (speed <= PCI_SPEED_133MHz_PCIX_533)
>> +		return sprintf(buf, "%s\n", PCI_SPEED2STR(speed));
>>
>> -	if (speed == PCI_SPEED_UNKNOWN)
>> -		speed_string = "Unknown";
>> -	else
>> -		speed_string = pci_bus_speed_strings[speed];
>> -
>> -	return sprintf(buf, "%s\n", speed_string);
>> +	return sprintf(buf, "%s PCIe\n", PCI_SPEED2STR(speed));
>>  }
>>
>>  static ssize_t max_speed_read_file(struct pci_slot *slot, char *buf)
>> --
>> 2.8.1
>>
> .
>


