Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8D1264958
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 18:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgIJQJo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 12:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731453AbgIJQHJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 12:07:09 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BCBC061795
        for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2020 09:07:08 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d6so4882134pfn.9
        for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2020 09:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=LfE73yOOahYubZuB90a7b8ODoJ2hGtXRmEbov2Aw4Ko=;
        b=OIVqx+btR+JejqM8zDT5mHEu5X2WoQw+caZP4YpE/sSrHl0EVKFGCkKjam+acqyOX3
         Tx30ZTl/rSn0zxpdBa/+DQ8s2aNwuaeghoRZ5zzWs7MVo+qiBrs+jnu3cuMJKB4wKew+
         mUecQ+9yCqMBm5bNZ2/ToNf2i02SG2W6XBxNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LfE73yOOahYubZuB90a7b8ODoJ2hGtXRmEbov2Aw4Ko=;
        b=pJWIIkOpFBq/TjBj9ukfOmvK7QBUbY7oTK01U4Ldiw1mDTcGJVSDjt/06yLTIj1sPc
         RZtFllQGvDa+bOswGbzRUMdDBoVhLCWlWZC+ElriiFVLTTg15qOHzCR7igagGWO0UsFA
         m5lhGEBCZrRLi8h/IJmmgOVJnHCe7/2ZpwqSGfXxzDGrVCD+WWvp1eZpYA80Uape9jO4
         Se6si2uglwoExY6ZVOd2kCBZn5H4mOqtLGr1gZ7v8NkvqL34ZLfBR1hV2LA8cJ0Qky1e
         2FA060O2yoiu9I7OiUdua7HJCPuKvaZQTya5RrwuOevVTSURwG++DuYGqQguRkuw79Cd
         uyqA==
X-Gm-Message-State: AOAM533/EpILC817QOCFyCt9X6gn4eRca8eKuliIPLobgLXKwCXIPHbf
        aydfx+zPdLaoiz72zFALauKuQw==
X-Google-Smtp-Source: ABdhPJx/Y2FsDJnyr8fyoG/+/PqQ0cFCxFJMcBPH8lXVKia75C2ynOwRNxM6KBi2ATPpANYBDzMs5A==
X-Received: by 2002:a63:ec4c:: with SMTP id r12mr4964334pgj.74.1599754027805;
        Thu, 10 Sep 2020 09:07:07 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id d20sm2414327pjv.39.2020.09.10.09.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 09:07:06 -0700 (PDT)
Subject: Re: [PATCH] PCI: Don't use Printk in raw_spinlocks
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Xingxing Su <suxingxing@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
        Florian Fainelli <f.fainelli@gmail.com>
References: <1596245149-28628-1-git-send-email-suxingxing@loongson.cn>
 <20200910020742.GA748627@bjorn-Precision-5520>
 <CAL_JsqKVn+e-eX+=kkSXxdwAmJUahrTdhuBKfVCXVZ8bQJ5MUw@mail.gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <3ec38bf3-8ffa-455d-4a06-bd99b2e6cac5@broadcom.com>
Date:   Thu, 10 Sep 2020 09:07:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKVn+e-eX+=kkSXxdwAmJUahrTdhuBKfVCXVZ8bQJ5MUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-CA
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-09-10 7:21 a.m., Rob Herring wrote:
> On Wed, Sep 9, 2020 at 8:07 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>> [+cc Mark, Florian, Rob, Scott]
>>
>> On Sat, Aug 01, 2020 at 09:25:49AM +0800, Xingxing Su wrote:
>>> Do not use printk in raw_spinlocks,
>>> it will cause BUG: Invalid wait context.
>>>
>>> The trace reported by lockdep follows.
>>>
>>> [    2.986113] =============================
>>> [    2.986115] [ BUG: Invalid wait context ]
>>> [    2.986116] 5.8.0-rc1+ #11 Not tainted
>>> [    2.986118] -----------------------------
>>> [    2.986120] swapper/0/1 is trying to lock:
>>> [    2.986122] ffffffff80f5ddd8 (console_owner){....}-{3:3}, at: console_unlock+0x284/0x820
>>> [    2.986130] other info that might help us debug this:
>>> [    2.986132] context-{5:5}
>>> [    2.986134] 3 locks held by swapper/0/1:
>>> [    2.986135]  #0: 98000007fa03c990 (&dev->mutex){....}-{0:0}, at: device_driver_attach+0x28/0x90
>>> [    2.986144]  #1: ffffffff80fb83a8 (pci_lock){....}-{2:2}, at: pci_bus_write_config_word+0x60/0xb8
>>> [    2.986152]  #2: ffffffff80f5ded0 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x1b0/0x3b8
>>> [    2.986161] stack backtrace:
>>> [    2.986163] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc1+ #11
>>> [    2.986164] Stack : 0000000000001d67 98000000030be9b0 0000000000000001 7b2aba74f6c4785b
>>> [    2.986172]         7b2aba74f6c4785b 0000000000000000 98000007f89cb438 ffffffff80e7dc80
>>> [    2.986181]         0000000000000001 000000000000000a 0000000000000001 0000000000000001
>>> [    2.986189]         ffffffff80f4e156 fffffffffffffffd ffffffff80cc2d98 fffffffff8000000
>>> [    2.986197]         0000000024000000 ffffffff80f40000 0000000000000000 0000000000000000
>>> [    2.986205]         ffffffff9500cce0 0000000000000000 ffffffff80f50000 ffffffff81546318
>>> [    2.986213]         ffffffff81c4c3c0 0000000000000018 ffffffffbc000000 0000000000000000
>>> [    2.986221]         ffffffff81340000 98000007f89c8000 98000007f89cb430 98000007f8a00000
>>> [    2.986229]         ffffffff806be568 0000000000000000 0000000000000000 0000000000000000
>>> [    2.986237]         0000000000000000 0000000000000000 ffffffff80211c1c 7b2aba74f6c4785b
>>> [    2.986245]         ...
>>> [    2.986250] Call Trace:
>>> [    2.986251] [<ffffffff80211c1c>] show_stack+0x9c/0x130
>>> [    2.986253] [<ffffffff806be568>] dump_stack+0xe8/0x150
>>> [    2.986255] [<ffffffff802ad408>] __lock_acquire+0x570/0x3250
>>> [    2.986257] [<ffffffff802abed0>] lock_acquire+0x118/0x558
>>> [    2.986259] [<ffffffff802be764>] console_unlock+0x2e4/0x820
>>> [    2.986261] [<ffffffff802c0a68>] vprintk_emit+0x1c0/0x3b8
>>> [    2.986263] [<ffffffff807f45a8>] dev_vprintk_emit+0x1c8/0x210
>>> [    2.986265] [<ffffffff807f462c>] dev_printk_emit+0x3c/0x60
>>> [    2.986267] [<ffffffff807f499c>] _dev_warn+0x5c/0x80
>>> [    2.986269] [<ffffffff806eea9c>] pci_generic_config_write32+0x154/0x160
>>> [    2.986271] [<ffffffff806edca4>] pci_bus_write_config_word+0x84/0xb8
>>> [    2.986273] [<ffffffff806f1664>] pci_setup_device+0x22c/0x768
>>> [    2.986275] [<ffffffff806f26a0>] pci_scan_single_device+0xc8/0x100
>>> [    2.986277] [<ffffffff806f2788>] pci_scan_slot+0xb0/0x178
>>> [    2.986279] [<ffffffff806f3ae4>] pci_scan_child_bus_extend+0x5c/0x370
>>> [    2.986281] [<ffffffff806f407c>] pci_scan_root_bus_bridge+0x6c/0xf0
>>> [    2.986283] [<ffffffff806f411c>] pci_host_probe+0x1c/0xd8
>>> [    2.986285] [<ffffffff807fa03c>] platform_drv_probe+0x54/0xb8
>>> [    2.986287] [<ffffffff807f71f8>] really_probe+0x130/0x388
>>> [    2.986289] [<ffffffff807f7594>] driver_probe_device+0x64/0xd8
>>> [    2.986291] [<ffffffff807f7844>] device_driver_attach+0x84/0x90
>>> [    2.986293] [<ffffffff807f7918>] __driver_attach+0xc8/0x128
>>> [    2.986295] [<ffffffff807f4cac>] bus_for_each_dev+0x74/0xd8
>>> [    2.986297] [<ffffffff807f6408>] bus_add_driver+0x170/0x250
>>> [    2.986299] [<ffffffff807f899c>] driver_register+0x84/0x150
>>> [    2.986301] [<ffffffff80200b08>] do_one_initcall+0x98/0x458
>>> [    2.986303] [<ffffffff810212dc>] kernel_init_freeable+0x2c0/0x36c
>>> [    2.986305] [<ffffffff80be7540>] kernel_init+0x10/0x128
>>> [    2.986307] [<ffffffff80209d44>] ret_from_kernel_thread+0x14/0x1c
>>>
>>> Signed-off-by: Xingxing Su <suxingxing@loongson.cn>
>>> ---
>>>  drivers/pci/access.c | 3 ---
>>>  1 file changed, 3 deletions(-)
>>>
>>> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
>>> index 79c4a2e..b3fc164 100644
>>> --- a/drivers/pci/access.c
>>> +++ b/drivers/pci/access.c
>>> @@ -160,9 +160,6 @@ int pci_generic_config_write32(struct pci_bus *bus, unsigned int devfn,
>>>        * write happen to have any RW1C (write-one-to-clear) bits set, we
>>>        * just inadvertently cleared something we shouldn't have.
>>>        */
>>> -     dev_warn_ratelimited(&bus->dev, "%d-byte config write to %04x:%02x:%02x.%d offset %#x may corrupt adjacent RW1C bits\n",
>>> -                          size, pci_domain_nr(bus), bus->number,
>>> -                          PCI_SLOT(devfn), PCI_FUNC(devfn), where);
>> We just changed this printk (see [1]), but I think we still have this
>> lockdep problem even after Mark's change.  So I guess we need another
>> think about this.
>>
>> Maybe we can print something when registering pci_ops that use
>> pci_generic_config_write32()?
> That was my suggestion, but as Mark pointed out that doesn't work if
> pci_generic_config_write32 is wrapped (which is 4 out of 8 cases).
>
> Also, 3 of the cases are only for the root bus (bridge). Are 32-bit
> writes to a bridge going to cause problems? For xgene, interestingly,
> with DT _write32 is needed, but for ACPI it is not (only _read32). I
> think xgene is practically dead though a few people still have
> systems, but likely xgene with DT is really dead. The ECAM case was
> for QCom server which is also pretty much dead. SA1100 nano-engine is
> really old and something only a few people have at most (Russell
> King). So ignoring all those, we're left with just loongson and iproc.
> Maybe just remove the warning?
Yes, removing the warning works fine.
>
> Rob

