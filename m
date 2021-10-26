Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE67D43A916
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 02:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbhJZAIt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 20:08:49 -0400
Received: from mx.socionext.com ([202.248.49.38]:31078 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233433AbhJZAIs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Oct 2021 20:08:48 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 26 Oct 2021 09:06:24 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id D2764205D965;
        Tue, 26 Oct 2021 09:06:24 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 26 Oct 2021 09:06:24 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 776B6B62AC;
        Tue, 26 Oct 2021 09:06:24 +0900 (JST)
Received: from [10.212.183.182] (unknown [10.212.183.182])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id 0D3A5B6291;
        Tue, 26 Oct 2021 09:06:24 +0900 (JST)
Subject: Re: PCI/VPD: recursive loop issue with lspci
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jakub Kicinski <kuba@kernel.org>
References: <20211025170645.GA10265@bhelgaas>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <e7fb3279-b02d-33f7-4dcf-07deb35ad3bd@socionext.com>
Date:   Tue, 26 Oct 2021 09:06:23 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211025170645.GA10265@bhelgaas>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 2021/10/26 2:06, Bjorn Helgaas wrote:
> On Tue, Oct 26, 2021 at 12:51:07AM +0900, Kunihiko Hayashi wrote:
>> Hi all,
>>
>> I found that "lspci -vv" causes a recursive loop in the linux-next
> kernel.
>> As a result, the kernel crashed on stack overflow.
>>
>> This issue was reproduced using Akebi96 board with UniPhier LD20 and
> DWC3 PCIe
>> controller, and R8169 ethernet card.
>>
>> # lspci -s 01:00.0 -vv
>> 01:00.0 Class 0200: Device 10ec:8168 (rev 06)
>> [   19.152157] Insufficient stack space to handle exception!
>> ...
>> [   19.152449] Hardware name: Akebi96 (DT)
>> [   19.152455] Call trace:
>> [   19.152458]  dump_backtrace+0x0/0x1b0
>> [   19.152484]  show_stack+0x20/0x30
>> [   19.152503]  dump_stack_lvl+0x68/0x84
>> [   19.152525]  dump_stack+0x18/0x34
>> [   19.152542]  panic+0x154/0x34c
>> [   19.152556]  nmi_panic+0x94/0x98
>> [   19.152577]  panic_bad_stack+0xec/0x100
>> [   19.152590]  handle_bad_stack+0x38/0x68
>> [   19.152606]  __bad_stack+0x8c/0x90
>> [   19.152620]  pci_vpd_read+0xc/0x1f8
>> [   19.152639]  pci_vpd_size+0x58/0x1a0
>> [   19.152651]  pci_vpd_read+0x1a0/0x1f8
>> [   19.152669]  __pci_read_vpd+0x94/0xc0
>> [   19.152681]  pci_vpd_size+0x58/0x1a0
>> [   19.152692]  pci_vpd_read+0x1a0/0x1f8
>> [   19.152710]  __pci_read_vpd+0x94/0xc0
>> [   19.152722]  pci_vpd_size+0x58/0x1a0
>> [   19.152734]  pci_vpd_read+0x1a0/0x1f8
>> [   19.152752]  __pci_read_vpd+0x94/0xc0
>> ...
>> [   19.155039]  pci_vpd_size+0x58/0x1a0
>> [   19.155051]  pci_vpd_read+0x1a0/0x1f8
>> [   19.155069]  __pci_read_vpd+0x94/0xc0
>> [   19.155081]  pci_vpd_size+0x58/0x1a0
>> [   19.155093]  pci_vpd_read+0x1a0/0x1f8
>> [   19.155111]  __pci_read_vpd+0x94/0xc0
>> [   19.155124]  pci_vpd_size+0x58/0x1a0
>> [   19.155136]  pci_vpd_read+0x1a0/0x1f8
>> [   19.155153]  __pci_read_vpd+0x94/0xc0
>> [   19.155166]  vpd_read+0x28/0x38
>> [   19.155177]  sysfs_kf_bin_read+0x74/0x98
>>
>> In the following commit, initialization of dev->vpd.len has been
> removed.
>>
>>      commit 80484b7f8db101119928c73e7ce09ae6be54e45c
>>          PCI/VPD: Use pci_read_vpd_any() in pci_vpd_size()
>>
>> When calling pci_read_vpd_any(), if dev->vpd.len is zero, pci_vpd_size()
>> will continue to be called recursively.
>>
>>      pci_vpd_available()			// dev->vpd.len == 0
>>       -> pci_vpd_size()
>>          -> pci_read_vpd_any()
>>             -> __pci_read_vpd()
>>                -> pci_vpd_read()
>>                   -> pci_vpd_available()	// dev->vpd.len == 0
>>                      -> pci_vpd_size()
>>                         ...
>>
>> This issue didn't occur before applying this commit.
>> Does anyone run into the same issue?
> 
> Likely this patch:
> 
>    https://lore.kernel.org/r/6211be8a-5d10-8f3a-6d33-af695dc35caf@gmail.com
> 
> which I obviously need to move to the top of my list.  If you can
> confirm that this fixes it, that would be awesome!

Thank you for your information.
I confirmed that the issue was fixed after applying the patch.

Thank you,

---
Best Regards
Kunihiko Hayashi
