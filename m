Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE9D4EE836
	for <lists+linux-pci@lfdr.de>; Fri,  1 Apr 2022 08:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbiDAGat (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Apr 2022 02:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbiDAGas (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Apr 2022 02:30:48 -0400
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:1::465:107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3355C64B
        for <linux-pci@vger.kernel.org>; Thu, 31 Mar 2022 23:28:58 -0700 (PDT)
Received: from smtp2.mailbox.org (unknown [91.198.250.124])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4KV9HD2NHKz9sSS;
        Fri,  1 Apr 2022 08:28:56 +0200 (CEST)
Message-ID: <473f6f13-cf01-4065-5a92-998b651f11db@denx.de>
Date:   Fri, 1 Apr 2022 08:28:51 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/2] Add support to register platform service IRQ
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
References: <20220331153019.GA10982@bhelgaas>
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <20220331153019.GA10982@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/31/22 17:30, Bjorn Helgaas wrote:
> On Thu, Mar 24, 2022 at 05:52:54PM +0100, Stefan Roese wrote:
>> On 1/14/22 08:58, Stefan Roese wrote:
>>> Some platforms have dedicated IRQ lines for platform-specific System Errors
>>> like AER/PME etc. The root complex on these platform will use these seperate
>>> IRQ lines to report AER/PME etc., interrupts and will not generate
>>> MSI/MSI-X/INTx interrupts for these services.
>>>
>>> These patches will add new method for these kind of platforms to register the
>>> platform IRQ number with respective PCIe services.
>>>
>>> Changes in v4 (Stefan):
>>> - Remove 2nd check for PCI_EXP_TYPE_ROOT_PORT
>>> - Change init_platform_service_irqs() from void to return int
>>>
>>> Changes in v3 (Stefan):
>>> - Restructure patches from 4 patches in v2 to now 2 patches in v3
>>> - Rename of functions names
>>> - init_platform_service_irqs() now uses "struct pci_dev *" instead of
>>>     "struct pci_host_bridge *"
>>> - pcie_init_platform_service_irqs() is called before pcie_init_service_irqs()
>>> - Use more PCIe spec terminology as suggested by Bjorn (hopefully enough, I
>>>     don't have the spec at hand)
>>
>> Bjorn, what's the status of this patchset? I was under the impression,
>> that it would make it into v5.18. Please let me know if something is
>> missing.
> 
> Sorry, I didn't get to it in time for v5.18, but it's on my list for
> v5.19.
> 
> I thought maybe it got assigned to Lorenzo because it touches
> drivers/pci/controller/, but I can't find it in patchwork
> (https://patchwork.kernel.org/project/linux-pci/list/) at all.

Both patches are in patchwork:

https://patchwork.kernel.org/project/linux-pci/patch/20220114075834.1938409-2-sr@denx.de/
https://patchwork.kernel.org/project/linux-pci/patch/20220114075834.1938409-3-sr@denx.de/

The first one is assigned to you and the 2nd one to Lorenzo.

> Would you mind posting it again to make sure patchwork picks it up?
> If it's not in patchwork, it's very likely to get missed.

Since it's already on patchwork, I did not post the patches again.
Please let me know if I should re-post them nevertheless.

Thanks,
Stefan

> Bjorn
> 
>>> Bharat Kumar Gogada (2):
>>>     PCI/portdrv: Add option to setup IRQs for platform-specific Service
>>>       Errors
>>>     PCI: xilinx-nwl: Add method to init_platform_service_irqs hook
>>>
>>>    drivers/pci/controller/pcie-xilinx-nwl.c | 18 +++++++++++
>>>    drivers/pci/pcie/portdrv_core.c          | 39 +++++++++++++++++++++++-
>>>    include/linux/pci.h                      |  2 ++
>>>    3 files changed, 58 insertions(+), 1 deletion(-)
>>>
>>
>> Viele Grüße,
>> Stefan Roese
>>
>> -- 
>> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
>> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>> Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
