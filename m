Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA156E847B
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 10:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732793AbfJ2Jb3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 05:31:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:24077 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfJ2Jb3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 05:31:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 02:31:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="202787906"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 29 Oct 2019 02:31:27 -0700
Received: from [10.226.39.46] (ekotax-MOBL.gar.corp.intel.com [10.226.39.46])
        by linux.intel.com (Postfix) with ESMTP id A1C6A5802C4;
        Tue, 29 Oct 2019 02:31:19 -0700 (PDT)
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
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
References: <20191022125950.GA133170@google.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <c1aadeea-7904-1455-5393-c4998fbd8037@linux.intel.com>
Date:   Tue, 29 Oct 2019 17:31:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191022125950.GA133170@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/22/2019 8:59 PM, Bjorn Helgaas wrote:
> [+cc Rafael, linux-pm, beginning of discussion at
> https://lore.kernel.org/r/d8574605f8e70f41ce1e88ccfb56b63c8f85e4df.1571638827.git.eswara.kota@linux.intel.com]
>
> On Tue, Oct 22, 2019 at 05:27:38PM +0800, Dilip Kota wrote:
>> On 10/22/2019 1:18 AM, Bjorn Helgaas wrote:
>>> On Mon, Oct 21, 2019 at 02:38:50PM +0100, Andrew Murray wrote:
>>>> On Mon, Oct 21, 2019 at 02:39:20PM +0800, Dilip Kota wrote:
>>>>> PCIe RC driver on Intel Gateway SoCs have a requirement
>>>>> of changing link width and speed on the fly.
>>> Please add more details about why this is needed.  Since you're adding
>>> sysfs files, it sounds like it's not actually the *driver* that needs
>>> this; it's something in userspace?
>> We have use cases to change the link speed and width on the fly.
>> One is EMI check and other is power saving.  Some battery backed
>> applications have to switch PCIe link from higher GEN to GEN1 and
>> width to x1. During the cases like external power supply got
>> disconnected or broken. Once external power supply is connected then
>> switch PCIe link to higher GEN and width.
> That sounds plausible, but of course nothing there is specific to the
> Intel Gateway, so we should implement this generically so it would
> work on all hardware.
Agree.
>
> I'm not sure what the interface should look like -- should it be a
> low-level interface as you propose where userspace would have to
> identify each link of interest, or is there some system-wide
> power/performance knob that could tune all links?  Cc'd Rafael and
> linux-pm in case they have ideas.

To my knowledge sysfs is the appropriate way to go.
If there are any other best possible knobs, will be helpful.

Regards,
Dilip

>
> Bjorn
