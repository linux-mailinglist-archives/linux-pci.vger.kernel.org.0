Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBABEADC9
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2019 11:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfJaKrR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Oct 2019 06:47:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:53905 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbfJaKrR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Oct 2019 06:47:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2019 03:47:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,250,1569308400"; 
   d="scan'208";a="401839713"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 31 Oct 2019 03:47:15 -0700
Received: from [10.226.39.46] (unknown [10.226.39.46])
        by linux.intel.com (Postfix) with ESMTP id 24DEE58048F;
        Thu, 31 Oct 2019 03:47:10 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] pci: intel: Add sysfs attributes to configure pcie
 link
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Andrew Murray <andrew.murray@arm.com>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, martin.blumenstingl@googlemail.com,
        linux-pci@vger.kernel.org, hch@infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Rajat Jain <rajatja@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <20191030221436.GA261632@google.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <f49e1e3c-aa26-2d9d-c100-fa073ada958b@linux.intel.com>
Date:   Thu, 31 Oct 2019 18:47:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191030221436.GA261632@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/31/2019 6:14 AM, Bjorn Helgaas wrote:
> [+cc Heiner, Rajat]
>
> On Tue, Oct 29, 2019 at 05:31:18PM +0800, Dilip Kota wrote:
>> On 10/22/2019 8:59 PM, Bjorn Helgaas wrote:
>>> [+cc Rafael, linux-pm, beginning of discussion at
>>> https://lore.kernel.org/r/d8574605f8e70f41ce1e88ccfb56b63c8f85e4df.1571638827.git.eswara.kota@linux.intel.com]
>>>
>>> On Tue, Oct 22, 2019 at 05:27:38PM +0800, Dilip Kota wrote:
>>>> On 10/22/2019 1:18 AM, Bjorn Helgaas wrote:
>>>>> On Mon, Oct 21, 2019 at 02:38:50PM +0100, Andrew Murray wrote:
>>>>>> On Mon, Oct 21, 2019 at 02:39:20PM +0800, Dilip Kota wrote:
>>>>>>> PCIe RC driver on Intel Gateway SoCs have a requirement
>>>>>>> of changing link width and speed on the fly.
>>>>> Please add more details about why this is needed.  Since you're adding
>>>>> sysfs files, it sounds like it's not actually the *driver* that needs
>>>>> this; it's something in userspace?
>>>> We have use cases to change the link speed and width on the fly.
>>>> One is EMI check and other is power saving.  Some battery backed
>>>> applications have to switch PCIe link from higher GEN to GEN1 and
>>>> width to x1. During the cases like external power supply got
>>>> disconnected or broken. Once external power supply is connected then
>>>> switch PCIe link to higher GEN and width.
>>> That sounds plausible, but of course nothing there is specific to the
>>> Intel Gateway, so we should implement this generically so it would
>>> work on all hardware.
>> Agree.
>>> I'm not sure what the interface should look like -- should it be a
>>> low-level interface as you propose where userspace would have to
>>> identify each link of interest, or is there some system-wide
>>> power/performance knob that could tune all links?  Cc'd Rafael and
>>> linux-pm in case they have ideas.
>> To my knowledge sysfs is the appropriate way to go.
>> If there are any other best possible knobs, will be helpful.
> I agree sysfs is the right place for it; my question was whether we
> should have files like:
>
>    /sys/.../0000:00:1f.3/pcie_speed
>    /sys/.../0000:00:1f.3/pcie_width
>
> as I think this patch would add (BTW, please include sample paths like
> the above in the commit log), or whether there should be a more global
> thing that would affect all the links in the system.
Sure, i will add them.
>
> I think the low-level files like you propose would be better because
> one might want to tune link performance differently for different
> types of devices and workloads.
>
> We also have to decide if these files should be associated with the
> device at the upstream or downstream end of the link.  For ASPM, the
> current proposal [1] has the files at the downstream end on the theory
> that the GPU, NIC, NVMe device, etc is the user-recognizable one.
> Also, neither ASPM nor link speed/width make any sense unless there
> *is* a device at the downstream end, so putting them there
> automatically makes them visible only when they're useful.

This patch places the speed and width in the host controller directory.
/sys/.../xxx.pcie/pcie_speed
/sys/.../xxx.pcie/pcie_width

I agree with you partially,  because i am having couple of points making 
me to
keep speed and width change entries in controller directory:

-- For changing the speed/width with device node, software ends up 
traversing to the controller
   from the device and do the operations.
-- Change speed and width are performed at controller level,
-- Keeping speed and width in controller gives a perspective (to the 
user) of changing
them only once irrespective of no. of devices.
-- For speed and link change in Synopsys PCIe controller, specific 
registers need to be configured.
    This prevents or complicates adding the speed and width change 
functionality in pci-sysfs or pci framework.

Regards,
Dilip

