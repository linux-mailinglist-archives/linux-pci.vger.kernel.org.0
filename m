Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA955874FD
	for <lists+linux-pci@lfdr.de>; Tue,  2 Aug 2022 03:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbiHBBL7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Aug 2022 21:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiHBBL6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2022 21:11:58 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D472125EAC;
        Mon,  1 Aug 2022 18:11:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VL8sRT9_1659402713;
Received: from 30.178.81.22(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VL8sRT9_1659402713)
          by smtp.aliyun-inc.com;
          Tue, 02 Aug 2022 09:11:54 +0800
Message-ID: <4bff1924-ef4b-2c88-e3d3-a60ed5bf6599@linux.alibaba.com>
Date:   Tue, 2 Aug 2022 09:11:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.3
Subject: Re: [PATCH] PCI: eliminate abnormal characters when reads help
 information of "PCI_P2PDMA" under menuconfig
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
References: <20220801215623.GA676484@bhelgaas>
From:   Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <20220801215623.GA676484@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


在 2022/8/2 05:56, Bjorn Helgaas 写道:
> On Wed, Jul 20, 2022 at 12:23:29PM -0500, Bjorn Helgaas wrote:
>> [+cc Andy, Joe, possible checkpatch question]
>>
>> On Wed, Jul 20, 2022 at 03:22:03PM +0800, Liu Song wrote:
>>> From: Liu Song <liusong@linux.alibaba.com>
>>>
>>> Read the help information of PCI_P2PDMA through make menuconfig,
>>> "Enables" is partially displayed as garbled characters, so fix it.
>>>
>>> Signed-off-by: Liu Song <liusong@linux.alibaba.com>
>>> ---
>>>   drivers/pci/Kconfig | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>>> index 133c732..8102b78 100644
>>> --- a/drivers/pci/Kconfig
>>> +++ b/drivers/pci/Kconfig
>>> @@ -166,7 +166,7 @@ config PCI_P2PDMA
>>>   	depends on ZONE_DEVICE
>>>   	select GENERIC_ALLOCATOR
>>>   	help
>>> -	  Enableѕ drivers to do PCI peer-to-peer transactions to and from
>>> +	  Enables drivers to do PCI peer-to-peer transactions to and from
>> I see this problem ("Enables" renders as "Enable ~U" because the "s"
>> is actually UTF-8 D195, CYRILLIC SMALL LETTER DZE).
>>
>> "file" found the following other Kconfig files that also contain
>> UTF-8:
>>
>>    drivers/pci/Kconfig
>>      D195 CYRILLIC SMALL LETTER DZE, which looks like "s"
>>      "Enables" renders as "Enable ~U"
>>    net/netfilter/ipvs/Kconfig
>>      C2A0 NO-BREAK SPACE
>>      renders fine
>>    drivers/mtd/nand/raw/Kconfig
>>      MTD_NAND_CAFE  C389 LATIN CAPITAL LETTER E WITH ACUTE
>>      "CAFÉ" renders as "CAF ~I"
>>    drivers/mtd/spi-nor/Kconfig
>>      MTD_SPI_NOR_USE_4K_SECTORS
>>      "16 × 4 KiB" renders as "16  ~W 4 KiB"
>>    drivers/net/can/usb/Kconfig
>>    drivers/net/can/peak_canfd/Kconfig
>>    drivers/gpu/drm/panel/Kconfig
>>    drivers/platform/mellanox/Kconfig
>>    kernel/time/Kconfig
>>    crypto/Kconfig
>>    arch/Kconfig
>>
>> Some of these are clearly wrong (Cyrillic letter), some are
>> unnecessary (non-breakable space), some are arguable ("CAFÉ" and "16 ×
>> 4 KiB" -- these take advantage of UTF-8 in useful ways).
>>
>> Not being a charset guru, I dunno if the rendering problem means
>> my terminal is set incorrectly or if they all need to be changed.
>>
>> But I think we should address all of them at the same time.  If we do
>> need to avoid UTF-8 in Kconfig help, maybe checkpatch should look for
>> it.
> Any progress on this problem?  I certainly agree that it should be
> fixed; I would just like to fix all the problems, not just the PCI
> one.
>
> Bjorn


Totally agree, according to your suggestion, I will resubmit with all 
the revisions.


Thanks


