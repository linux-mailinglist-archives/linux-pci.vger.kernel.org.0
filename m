Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53B37E8020
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 07:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732303AbfJ2GOh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 02:14:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:8598 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727462AbfJ2GOh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 02:14:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 23:14:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,242,1569308400"; 
   d="scan'208";a="211040815"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 28 Oct 2019 23:14:35 -0700
Received: from [10.226.39.46] (ekotax-MOBL.gar.corp.intel.com [10.226.39.46])
        by linux.intel.com (Postfix) with ESMTP id 1A5BF580372;
        Mon, 28 Oct 2019 23:14:29 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] dwc: PCI: intel: PCIe RC controller driver
To:     "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cheol.yong.kim@intel.com" <cheol.yong.kim@intel.com>,
        "chuanhua.lei@linux.intel.com" <chuanhua.lei@linux.intel.com>,
        "qi-ming.wu@intel.com" <qi-ming.wu@intel.com>
References: <cover.1571638827.git.eswara.kota@linux.intel.com>
 <c46ba3f4187fe53807948b4f10996b89a75c492c.1571638827.git.eswara.kota@linux.intel.com>
 <CH2PR12MB400751D01BCEE7ABB708280BDA690@CH2PR12MB4007.namprd12.prod.outlook.com>
 <28b5a21b-b636-f7e4-2d27-23c5d900b0d3@linux.intel.com>
 <e86116b7-b65f-f31e-abb7-a4533aa6d592@linux.intel.com>
 <20191022114413.GG32742@smile.fi.intel.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <1ac70f92-c148-ca88-a2c1-ec90741ac123@linux.intel.com>
Date:   Tue, 29 Oct 2019 14:14:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191022114413.GG32742@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/22/2019 7:44 PM, andriy.shevchenko@intel.com wrote:
> On Tue, Oct 22, 2019 at 06:18:57PM +0800, Dilip Kota wrote:
>> On 10/21/2019 6:44 PM, Dilip Kota wrote:
>>> On 10/21/2019 4:29 PM, Gustavo Pimentel wrote:
>>>> On Mon, Oct 21, 2019 at 7:39:19, Dilip Kota
>>>> <eswara.kota@linux.intel.com>
>>>> wrote:
> First of all, it's a good behaviour to avoid way long quoting.
(Sorry for the late reply, I am back today from sick leave.)
Noted. Will take care of it.

>
>>>>> +static void pcie_update_bits(void __iomem *base, u32 mask, u32
>>>>> val, u32 ofs)
>>>>> +{
>>>>> +    u32 orig, tmp;
>>>>> +
>>>>> +    orig = readl(base + ofs);
>>>>> +
>>>>> +    tmp = (orig & ~mask) | (val & mask);
>>>>> +
>>>>> +    if (tmp != orig)
>>>>> +        writel(tmp, base + ofs);
>>>>> +}
>>>> I'd suggest to the a take on FIELD_PREP() and FIELD_GET() and use more
>>>> intuitive names such as new and old, instead of orig and tmp.
>>> Sure, i will update it.
>> I tried using FIELD_PREP and FIELD_GET but it is failing because FIELD_PREP
>> and FIELD_GET
>> are expecting mask should be constant macro. u32 or u32 const are not
>> accepted.
> If you look at bitfield.h carefully you may find in particular
> u32_replace_bits().

Thanks for pointing it.
But, I found bitfields are not contiguous during few function calls, so 
cannot use them here.

Regards,
Dilip

>
