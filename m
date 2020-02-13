Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAB715B949
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 07:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgBMGHS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 01:07:18 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9728 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726052AbgBMGHS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Feb 2020 01:07:18 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9C866F0C65B7837DC20D;
        Thu, 13 Feb 2020 14:07:14 +0800 (CST)
Received: from [127.0.0.1] (10.65.58.147) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Feb 2020
 14:07:05 +0800
Subject: Re: [PATCH v2] PCI: Make pci_bus_speed_strings[] public
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20200212223133.GA177061@google.com>
CC:     <linux-pci@vger.kernel.org>, <f.fangjian@huawei.com>,
        <huangdaode@huawei.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <645746aa-74df-0984-cdb2-67acb4c6b27c@hisilicon.com>
Date:   Thu, 13 Feb 2020 14:07:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200212223133.GA177061@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Seems I've misunderstood the comments. Sorry for that. I'll reorganize
the series and send later.

Thanks,
Yicong Yang

On 2020/2/13 6:31, Bjorn Helgaas wrote:
> On Thu, Feb 06, 2020 at 06:58:07PM +0800, Yicong Yang wrote:
>> pci_bus_speed_strings[] in slot.c defines universal speed information.
>> Currently it is only used to decode bus speed in slot.c, while elsewhere
>> use judgement statements repeatly to decode speed information. For
>> example, in PCIE_SPEED2STR and current_link_speed_show() in sysfs.
>>
>> Make it public and move to probe.c so that we can reuse it for decoding
>> speed information in sysfs or dmesg log. Remove "PCIe" suffix of PCIe
>> bus speed strings to reduce redundancy.
>>
>> Add pci_bus_speed_strings_size for boundary check purpose, to avoid
>> acquiring size of an external array by ARRAY_SIZE macro.
>>
>> Link:https://lore.kernel.org/linux-pci/20200205183531.GA229621@google.com/
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>
>> change since v1:
>> 1. split the patch from series as suggested
> That's not what I said.  What I said was:
>
>   This needs to say exactly where this change will be observed: /proc
>   file, /sys file, dmesg, etc.  I would prefer that an observable
>   change be in its own patch instead of being a by-product of a
>   structural change like this one.
>
> That means I want a tiny patch that changes the strings a user will
> see and a specific example in the commit log to show what change the
> user will see.  For example, if it were in sysfs the changelog could
> say something like:
>
>   -/sys/devices/pci0000:00/0000:00:1c.0/max_link_speed:8 GT/s PCIe
>   +/sys/devices/pci0000:00/0000:00:1c.0/max_link_speed:8 GT/s
>
> I still don't know exactly *where* the change is (it's not in sysfs; I
> just made up the example above).  But something like the above would
> tell me exactly what files are affected and what the change looks
> like.  That's the information people would need to update programs
> that parse the file.
>
> And the patch itself should be something like:
>
>   +       "8.0 GT/s",             /* 0x16 */
>   -       "8.0 GT/s PCIe",        /* 0x16 */
>
> *without* the code moving between files.  This patch is basically
> identical to the first one [1] except that you made it separate from
> the series.
>
> This appears to change the strings *and* move them from slot.c to
> probe.c.  Those are two different things, and putting them together in
> one patch makes it harder for people to figure out what's changing.
>
> There should be one patch that *only* changes the strings and another
> that *only* moves them from slot.c to probe.c.
>
> And I don't want them as separate patches *outside* the series.  That
> just makes the series itself not apply correctly.  They should be *in*
> the series so the whole thing applies cleanly on my "master" brance
> (v5.6-rc1).
>
> [1] https://lore.kernel.org/r/1579079063-5668-3-git-send-email-yangyicong@hisilicon.com
>
>> 2. add pci_bus_speed_strings_size for boundary check in bus_speed_read()
>>
>>  drivers/pci/pci.h   |  2 ++
>>  drivers/pci/probe.c | 30 ++++++++++++++++++++++++++++++
>>  drivers/pci/slot.c  | 31 +------------------------------
>>  3 files changed, 33 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 6394e77..e6bcc06 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -12,6 +12,8 @@
>>  #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
>>
>>  extern const unsigned char pcie_link_speed[];
>> +extern const char *pci_bus_speed_strings[];
>> +extern const int pci_bus_speed_strings_size;
>>  extern bool pci_early_dump;
>>
>>  bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 512cb43..6ce47d8 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -678,6 +678,36 @@ const unsigned char pcie_link_speed[] = {
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
>> +const int pci_bus_speed_strings_size = ARRAY_SIZE(pci_bus_speed_strings);
>> +
>>  void pcie_update_link_speed(struct pci_bus *bus, u16 linksta)
>>  {
>>  	bus->cur_bus_speed = pcie_link_speed[linksta & PCI_EXP_LNKSTA_CLS];
>> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
>> index ae4aa0e..fb7c172 100644
>> --- a/drivers/pci/slot.c
>> +++ b/drivers/pci/slot.c
>> @@ -49,40 +49,11 @@ static ssize_t address_read_file(struct pci_slot *slot, char *buf)
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
>> +	if (speed < pci_bus_speed_strings_size)
>>  		speed_string = pci_bus_speed_strings[speed];
>>  	else
>>  		speed_string = "Unknown";
>> --
>> 2.8.1
>>
> .
>


