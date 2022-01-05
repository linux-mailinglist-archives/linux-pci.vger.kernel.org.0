Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828C548514C
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jan 2022 11:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbiAEKnL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 05:43:11 -0500
Received: from mx.socionext.com ([202.248.49.38]:49315 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233068AbiAEKnI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Jan 2022 05:43:08 -0500
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 05 Jan 2022 19:43:06 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id BCB8320584CE;
        Wed,  5 Jan 2022 19:43:06 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 5 Jan 2022 19:43:06 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by iyokan2.css.socionext.com (Postfix) with ESMTP id 2EDCEB6325;
        Wed,  5 Jan 2022 19:43:06 +0900 (JST)
Received: from [10.212.182.75] (unknown [10.212.182.75])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id 0A907214F;
        Wed,  5 Jan 2022 19:43:04 +0900 (JST)
Subject: Re: [PATCH v2 2/2] PCI: designware-ep: Fix the access to DBI/iATU
 registers before enabling controller
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Om Prakash Singh <omp@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1630473361-27198-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1630473361-27198-3-git-send-email-hayashi.kunihiko@socionext.com>
 <576457dd-3e66-a3b9-f51c-ea94bc267fdb@ti.com>
 <20211206112335.GA18520@lpieralisi>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <f4037b9c-9957-8d4c-d2e0-63bb53d5e7ee@socionext.com>
Date:   Wed, 5 Jan 2022 19:43:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211206112335.GA18520@lpieralisi>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon, Lorenzo,

Thank you and sorry for late reply.

On 2021/12/06 20:23, Lorenzo Pieralisi wrote:
> On Fri, Dec 03, 2021 at 10:36:00AM +0530, Kishon Vijay Abraham I wrote:
>> Hi Kunihiko,
>>
>> On 01/09/21 10:46 am, Kunihiko Hayashi wrote:
>>> The driver using core_init_notifier, e.g. pcie-tegra194.c, runs
> according
>>> to the following sequence:
>>>
>>>      probe()
>>>          dw_pcie_ep_init()
>>>
>>>      bind()
>>>          dw_pcie_ep_start()
>>>              enable_irq()
>>>
>>>      (interrupt occurred)
>>>      handler()
>>>          [enable controller]
>>>          dw_pcie_ep_init_complete()
>>>          dw_pcie_ep_init_notify()
>>>
>>> After receiving an interrupt from RC, the handler enables the
> controller
>>> and the controller registers can be accessed.
>>> So accessing the registers should do in dw_pcie_ep_init_complete().
>>>
>>> Currently dw_pcie_ep_init() has functions dw_iatu_detect() and
>>> dw_pcie_ep_find_capability() that include accesses to DWC registers.
>>> As a result, accessing the registers before enabling the controller,
>>> the access will fail.
>>>
>>> The function dw_pcie_ep_init() shouldn't have any access to DWC
> registers
>>> if the controller is enabled after calling bind(). This moves access
> codes
>>> to DBI/iATU registers and depending variables from dw_pcie_ep_init()
> to
>>> dw_pcie_ep_init_complete().
>>
>> Ideally pci_epc_create() should be the last step by the controller
>> driver before handing the control to the core EPC framework. Since
>> after this step the EPC framework can start invoking the epc_ops.
>>
>> Here more stuff is being added to dw_pcie_ep_init_complete() which is
>> required for epc_ops and this could result in aborts for platforms
>> which does not add core_init_notifier.
> 
> This patch needs rework, I will mark the series as "Changes requested".

I understand that relocation of dwc register accesses isn't appropriate,
but I couldn't think of any other rework to dwc, and I confirmed
pcie-qcom-ep driver using core_init_notifier.

In pcie-qcom-ep driver, probe() enables clock and deasserts reset first,
and when PERST# interrupt arrives, the handler enables clock and deasserts
reset again. So, dw_pcie_ep_init() can access DBI registers.

In pcie-tegra194 driver, I think the issue will be solved if probe() also
handles clock and reset control. However, the driver has other register
access between core_clk, core_apb_rst, and core_rst controls.
I think that it's appropriate to leave this fix to the developer at this
point.

As this patch series, I'll resend 1/2 patch only and expect pcie-tegra194
driver to be fixed.

Thank you,

---
Best Regards
Kunihiko Hayashi
