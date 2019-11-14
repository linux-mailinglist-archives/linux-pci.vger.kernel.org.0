Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5C2FBE7A
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2019 04:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKNDww (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Nov 2019 22:52:52 -0500
Received: from mga11.intel.com ([192.55.52.93]:8089 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbfKNDww (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Nov 2019 22:52:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 19:52:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,302,1569308400"; 
   d="scan'208";a="404840603"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 13 Nov 2019 19:52:51 -0800
Received: from [10.226.39.46] (unknown [10.226.39.46])
        by linux.intel.com (Postfix) with ESMTP id 734FE58049A;
        Wed, 13 Nov 2019 19:52:48 -0800 (PST)
Subject: Re: [PATCH v6 2/3] dwc: PCI: intel: PCIe RC controller driver
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        andrew.murray@arm.com, helgaas@kernel.org, jingoohan1@gmail.com,
        robh@kernel.org, martin.blumenstingl@googlemail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
References: <cover.1573613534.git.eswara.kota@linux.intel.com>
 <897ef494f39291797a92efb87a59961d36384019.1573613534.git.eswara.kota@linux.intel.com>
 <20191113110009.GC32742@smile.fi.intel.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <b369d6b9-004b-66fa-6add-322aba9c806b@linux.intel.com>
Date:   Thu, 14 Nov 2019 11:52:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113110009.GC32742@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/13/2019 7:00 PM, Andy Shevchenko wrote:
> On Wed, Nov 13, 2019 at 03:21:21PM +0800, Dilip Kota wrote:
>> Add support to PCIe RC controller on Intel Gateway SoCs.
>> PCIe controller is based of Synopsys DesignWare PCIe core.
>>
>> Intel PCIe driver requires Upconfigure support, Fast Training
>> Sequence and link speed configurations. So adding the respective
>> helper functions in the PCIe DesignWare framework.
>> It also programs hardware autonomous speed during speed
>> configuration so defining it in pci_regs.h.
>> +#include <linux/of_irq.h>
>> +#include <linux/of_platform.h>
> I hardly see the use of above...
Thanks for pointing it. Yes, it can be removed. I have again cross 
checked all the header files , i see below files can also be removed.
#include <linux/interrupt.h>
#include <linux/of_irq.h>
#include <linux/of_pci.h>

>> +	if (device_property_read_u32(dev, "reset-assert-ms", &lpp->rst_intrvl))
>> +		lpp->rst_intrvl = RESET_INTERVAL_MS;
> ...perhaps you need to add
>
> #include <linux/property.h>
>
> instead.

I see this header file is  already getting included in the driver 
through linux/phy/phy.h => linux/of.h (of.h has #include <linux/property.h>)

Thanks for reviewing the patch, i will update the driver and submit the 
next patch version.

Regards,
Dilip

>
