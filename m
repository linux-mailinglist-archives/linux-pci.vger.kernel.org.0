Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BE0319AD5
	for <lists+linux-pci@lfdr.de>; Fri, 12 Feb 2021 08:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhBLHpp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Feb 2021 02:45:45 -0500
Received: from mx.socionext.com ([202.248.49.38]:26054 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229913AbhBLHpa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Feb 2021 02:45:30 -0500
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 12 Feb 2021 16:44:36 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 6797A2059027;
        Fri, 12 Feb 2021 16:44:36 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 12 Feb 2021 16:44:36 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id F12F5B1D40;
        Fri, 12 Feb 2021 16:44:35 +0900 (JST)
Received: from [10.212.20.145] (unknown [10.212.20.145])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 44DE21202F7;
        Fri, 12 Feb 2021 16:44:35 +0900 (JST)
Subject: Re: [PATCH v2] PCI: designware-ep: Fix the reference to
 pci->num_{ib,ob}_windows before setting
To:     Rob Herring <robh@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
References: <1611011439-29881-1-git-send-email-hayashi.kunihiko@socionext.com>
 <CAL_JsqLtcXFktBWWqpbYf3B5BR2eUyBsQQ3Q5S3Ma8hn5T5Z0Q@mail.gmail.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <216818ce-adee-3c08-7410-1d5d1ef5011c@socionext.com>
Date:   Fri, 12 Feb 2021 16:44:34 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLtcXFktBWWqpbYf3B5BR2eUyBsQQ3Q5S3Ma8hn5T5Z0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

I found that this patch would cause null pointer dereference exception
when removing the function link.

If once linking the test function to the controller,
   # ln -s functions/pci_epf_test/test controllers/66000000.pcie-ep/

and unlinking it immediately,
   # rm controllers/66000000.pcie-ep/test

then the driver will occur null pointer access in dw_pcie_ep_clear_bar()
because ep->ib_window_map doesn't have a pointer to allocated memory yet.

To fix the original issue, I strongly recommend to apply Hou's patch [1]
instead of this patch.

Thank you,

[1] https://patchwork.kernel.org/project/linux-pci/patch/20210125044803.4310-1-Zhiqiang.Hou@nxp.com/

On 2021/01/21 0:20, Rob Herring wrote:
> On Mon, Jan 18, 2021 at 5:10 PM Kunihiko Hayashi
> <hayashi.kunihiko@socionext.com> wrote:
>>
>> The commit 281f1f99cf3a ("PCI: dwc: Detect number of iATU windows") gets
>> the values of pci->num_ib_windows and pci->num_ob_windows from iATU
>> registers instead of DT properties in dw_pcie_iatu_detect_regions*() or its
>> unroll version.
>>
>> However, before the values are set, the allocations in dw_pcie_ep_init()
>> refer them to determine the sizes of window_map. As a result, null pointer
>> dereference exception will occur when linking the EP function and the
>> controller.
>>
>>    # ln -s functions/pci_epf_test/test controllers/66000000.pcie-ep/
>>    Unable to handle kernel NULL pointer dereference at virtual address
>>    0000000000000010
>>
>> The call trace is as follows:
>>
>>    Call trace:
>>     _find_next_bit.constprop.1+0xc/0x88
>>     dw_pcie_ep_set_bar+0x78/0x1f8
>>     pci_epc_set_bar+0x9c/0xe8
>>     pci_epf_test_core_init+0xe8/0x220
>>     pci_epf_test_bind+0x1e0/0x378
>>     pci_epf_bind+0x54/0xb0
>>     pci_epc_epf_link+0x58/0x80
>>     configfs_symlink+0x1c0/0x570
>>     vfs_symlink+0xdc/0x198
>>     do_symlinkat+0xa0/0x110
>>     __arm64_sys_symlinkat+0x28/0x38
>>     el0_svc_common+0x84/0x1a0
>>     do_el0_svc+0x38/0x88
>>     el0_svc+0x1c/0x28
>>     el0_sync_handler+0x88/0xb0
>>     el0_sync+0x140/0x180
>>
>> The pci->num_{ib,ob}_windows should be referenced after they are set by
>> dw_pcie_iatu_detect_regions*() called from dw_pcie_setup().
>>
>> Cc: Rob Herring <robh@kernel.org>
>> Fixes: 281f1f99cf3a ("PCI: dwc: Detect number of iATU windows")
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-designware-ep.c | 41 ++++++++++++-------------
>>   1 file changed, 20 insertions(+), 21 deletions(-)
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

-- 
---
Best Regards
Kunihiko Hayashi
