Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52D12F8982
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2019 08:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfKLHSM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Nov 2019 02:18:12 -0500
Received: from mga11.intel.com ([192.55.52.93]:32500 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbfKLHSM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Nov 2019 02:18:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 23:18:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,295,1569308400"; 
   d="scan'208";a="207023340"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 11 Nov 2019 23:18:11 -0800
Received: from [10.226.39.46] (unknown [10.226.39.46])
        by linux.intel.com (Postfix) with ESMTP id 2FBDA5801E3;
        Mon, 11 Nov 2019 23:18:07 -0800 (PST)
Subject: Re: [PATCH v5 2/3] dwc: PCI: intel: PCIe RC controller driver
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        andrew.murray@arm.com, helgaas@kernel.org, jingoohan1@gmail.com,
        robh@kernel.org, martin.blumenstingl@googlemail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
References: <cover.1572950559.git.eswara.kota@linux.intel.com>
 <ac63d9856323555736c5b361612df3ee49b0f998.1572950559.git.eswara.kota@linux.intel.com>
 <20191106122452.GA32742@smile.fi.intel.com>
 <eee3e6ee-fd55-9c88-a628-34f883b19988@linux.intel.com>
Message-ID: <f7d2c4e6-101d-5f52-f3df-6adb0c8b8396@linux.intel.com>
Date:   Tue, 12 Nov 2019 15:18:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <eee3e6ee-fd55-9c88-a628-34f883b19988@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 11/11/2019 4:08 PM, Dilip Kota wrote:
>
> On 11/6/2019 8:24 PM, Andy Shevchenko wrote:
>> On Wed, Nov 06, 2019 at 11:44:02AM +0800, Dilip Kota wrote:
[...]
>>
>>> +    return ret;
>>> +}
>>> +    platform_set_drvdata(pdev, lpp);
>> I think it makes sense to setup at the end of the function (before 
>> dev_info()
>> call).
> I have done it immediately after the memory allocation.
> Ok, i will move it before dev_info().
>
I ran test with all the changes and kernel panic is hit due to NULL 
pointer access. It is because of platform_set_drvdata() moved before 
dev_info, which resulted in  intel_pcie_get_resources()  doing 
platform_get_drvdata and end up accessing NULL pointer. I will keep 
'platform_set_drvdata()' remain unchanged.

Regards,
Dilip
