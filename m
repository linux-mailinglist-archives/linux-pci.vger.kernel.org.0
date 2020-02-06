Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E17E5153CC5
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2020 02:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbgBFBrk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Feb 2020 20:47:40 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:33818 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727170AbgBFBrk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Feb 2020 20:47:40 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F2384BE11826A8E014FC;
        Thu,  6 Feb 2020 09:47:37 +0800 (CST)
Received: from [127.0.0.1] (10.65.58.147) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Thu, 6 Feb 2020
 09:47:27 +0800
Subject: Re: [PATCH 2/6] PCI: Make pci_bus_speed_strings[] public
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20200205183531.GA229621@google.com>
CC:     <linux-pci@vger.kernel.org>, <f.fangjian@huawei.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <366fb267-5fd0-ff1d-70df-61884c1888d5@hisilicon.com>
Date:   Thu, 6 Feb 2020 09:47:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200205183531.GA229621@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/2/6 2:35, Bjorn Helgaas wrote:
> On Wed, Jan 15, 2020 at 05:04:19PM +0800, Yicong Yang wrote:
>> pci_bus_speed_strings[] in slot.c defines universal speed information.
>> Make it public and move to probe.c so that we can use it. Remove "PCIe"
>> suffix of PCIe bus speed strings to reduce redundancy.
> This needs to say exactly where this change will be observed: /proc
> file, /sys file, dmesg, etc.  I would prefer that an observable change
> be in its own patch instead of being a by-product of a structural
> change like this one.

I'll split this patch from this series and send it individually before the series.
And make detailed description in the next version.


>> Use PCI_SPEED_UNKNOWN to judge the unknown speed condition in
>> bus_speed_read() in slot.c, as we cannot get array size from an external
>> array.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>
>> The reason why I don't add a boundary check is illustrated in Patch_4
>>
>>  drivers/pci/pci.h   |  1 +
>>  drivers/pci/probe.c | 29 +++++++++++++++++++++++++++++
>>  drivers/pci/slot.c  | 35 +++--------------------------------
>>  3 files changed, 33 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index a88c316..5fb1d76 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -9,6 +9,7 @@
>>  #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
>>
>>  extern const unsigned char pcie_link_speed[];
>> +extern const char *pci_bus_speed_strings[];
>>  extern bool pci_early_dump;
>>
>>  bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 512cb43..3c70b87 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -678,6 +678,35 @@ const unsigned char pcie_link_speed[] = {
>>  	PCI_SPEED_UNKNOWN		/* F */
>>  };
>>
>> +/* these strings match up with the values in pci_bus_speed */
>> +const char *pci_bus_speed_strings[] = {
>> +	"33 MHz PCI",		/* 0x00 */
>> +	"66 MHz PCI",		/* 0x01 */
>> +	"66 MHz PCI-X",		/* 0x02 */
>> +	"100 MHz PCI-X",	/* 0x03 */
>> +	"133 MHz PCI-X",	/* 0x04 */
>> +	NULL,			/* 0x05 */
>> +	NULL,			/* 0x06 */
>> +	NULL,			/* 0x07 */
>> +	NULL,			/* 0x08 */
>> +	"66 MHz PCI-X 266",	/* 0x09 */
>> +	"100 MHz PCI-X 266",	/* 0x0a */
>> +	"133 MHz PCI-X 266",	/* 0x0b */
>> +	"Unknown AGP",		/* 0x0c */
>> +	"1x AGP",		/* 0x0d */
>> +	"2x AGP",		/* 0x0e */
>> +	"4x AGP",		/* 0x0f */
>> +	"8x AGP",		/* 0x10 */
>> +	"66 MHz PCI-X 533",	/* 0x11 */
>> +	"100 MHz PCI-X 533",	/* 0x12 */
>> +	"133 MHz PCI-X 533",	/* 0x13 */
>> +	"2.5 GT/s",	/* 0x14 */
>> +	"5.0 GT/s",	/* 0x15 */
>> +	"8.0 GT/s",	/* 0x16 */
>> +	"16.0 GT/s",	/* 0x17 */
>> +	"32.0 GT/s",	/* 0x18 */
>> +};
>> +
>>  void pcie_update_link_speed(struct pci_bus *bus, u16 linksta)
>>  {
>>  	bus->cur_bus_speed = pcie_link_speed[linksta & PCI_EXP_LNKSTA_CLS];
>> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
>> index ae4aa0e..140dafb 100644
>> --- a/drivers/pci/slot.c
>> +++ b/drivers/pci/slot.c
>> @@ -49,43 +49,14 @@ static ssize_t address_read_file(struct pci_slot *slot, char *buf)
>>  				slot->number);
>>  }
>>
>> -/* these strings match up with the values in pci_bus_speed */
>> -static const char *pci_bus_speed_strings[] = {
>> -	"33 MHz PCI",		/* 0x00 */
>> -	"66 MHz PCI",		/* 0x01 */
>> -	"66 MHz PCI-X",		/* 0x02 */
>> -	"100 MHz PCI-X",	/* 0x03 */
>> -	"133 MHz PCI-X",	/* 0x04 */
>> -	NULL,			/* 0x05 */
>> -	NULL,			/* 0x06 */
>> -	NULL,			/* 0x07 */
>> -	NULL,			/* 0x08 */
>> -	"66 MHz PCI-X 266",	/* 0x09 */
>> -	"100 MHz PCI-X 266",	/* 0x0a */
>> -	"133 MHz PCI-X 266",	/* 0x0b */
>> -	"Unknown AGP",		/* 0x0c */
>> -	"1x AGP",		/* 0x0d */
>> -	"2x AGP",		/* 0x0e */
>> -	"4x AGP",		/* 0x0f */
>> -	"8x AGP",		/* 0x10 */
>> -	"66 MHz PCI-X 533",	/* 0x11 */
>> -	"100 MHz PCI-X 533",	/* 0x12 */
>> -	"133 MHz PCI-X 533",	/* 0x13 */
>> -	"2.5 GT/s PCIe",	/* 0x14 */
>> -	"5.0 GT/s PCIe",	/* 0x15 */
>> -	"8.0 GT/s PCIe",	/* 0x16 */
>> -	"16.0 GT/s PCIe",	/* 0x17 */
>> -	"32.0 GT/s PCIe",	/* 0x18 */
>> -};
>> -
>>  static ssize_t bus_speed_read(enum pci_bus_speed speed, char *buf)
>>  {
>>  	const char *speed_string;
>>
>> -	if (speed < ARRAY_SIZE(pci_bus_speed_strings))
>> -		speed_string = pci_bus_speed_strings[speed];
>> -	else
>> +	if (speed == PCI_SPEED_UNKNOWN)
>>  		speed_string = "Unknown";
>> +	else
>> +		speed_string = pci_bus_speed_strings[speed];
> This is a little bit problematic because previously we checked the
> actual array index but here we don't, so we may not index past the end
> of the array.
>
> It's possible to specify the array size explicitly in the extern
> declaration, and I *think* that might mean ARRAY_SIZE() would still
> work.  It's not ideal to have to update the extern declaration when
> adding speeds, but at least it's something that would be noticed by
> even the most trivial testing.

Maybe it's possible to add an array size valuable near the bus speed
string array and make it external. Then we can reference it here.

Thanks,
Yang

>>  	return sprintf(buf, "%s\n", speed_string);
>>  }
>> --
>> 2.8.1
>>
> .
>


