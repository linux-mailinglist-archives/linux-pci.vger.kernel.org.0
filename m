Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9263F114C5C
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2019 07:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbfLFGgA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Dec 2019 01:36:00 -0500
Received: from mga05.intel.com ([192.55.52.43]:7544 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfLFGgA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Dec 2019 01:36:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2019 22:35:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,283,1571727600"; 
   d="scan'208";a="243533297"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 05 Dec 2019 22:35:59 -0800
Received: from [10.226.39.7] (unknown [10.226.39.7])
        by linux.intel.com (Postfix) with ESMTP id A9EE55802C8;
        Thu,  5 Dec 2019 22:35:55 -0800 (PST)
Subject: Re: [PATCH v1 0/1]Fix build warning and errors
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, gustavo.pimentel@synopsys.com,
        andrew.murray@arm.com, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, rdunlap@infradead.org,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
References: <cover.1574929426.git.eswara.kota@linux.intel.com>
 <20191205162356.GA19365@e121166-lin.cambridge.arm.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <0bc42fb8-4ff5-4ecf-ddf4-305de2186efc@linux.intel.com>
Date:   Fri, 6 Dec 2019 14:35:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191205162356.GA19365@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 12/6/2019 12:23 AM, Lorenzo Pieralisi wrote:
> On Thu, Nov 28, 2019 at 04:31:12PM +0800, Dilip Kota wrote:
>> Mark Intel PCIe driver depends on MSI IRQ Domain to fix
>> the below warnings and respective build errors.
>>
>> WARNING: unmet direct dependencies detected for PCIE_DW_HOST
>>    Depends on [n]: PCI [=y] && PCI_MSI_IRQ_DOMAIN [=n]
>>    Selected by [y]:
>>    - PCIE_INTEL_GW [=y] && PCI [=y] && OF [=y] && (X86 [=y] || COMPILE_TEST [=n])
>>
>> Dilip Kota (1):
>>    PCI: dwc: Kconfig: Mark intel PCIe driver depends on MSI IRQ Domain
>>
>>   drivers/pci/controller/dwc/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
> Hi Dilip,
>
> would you mind squashing this patch into the initial series and repost
> it (rebase it against current mainline) straight away ? I will
> rebase it to -rc1 and push it out next week (I am asking since then
> I am afk for a month so I would like to get your code queued asap,
> it is ready).
Sure, i will do it.
Thanks for prioritizing.

Regards,
Dilip
>
> Thanks,
> Lorenzo
