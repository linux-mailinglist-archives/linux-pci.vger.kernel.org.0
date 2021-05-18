Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB57387527
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 11:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345265AbhERJcB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 May 2021 05:32:01 -0400
Received: from mail.loongson.cn ([114.242.206.163]:36272 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240100AbhERJcB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 May 2021 05:32:01 -0400
Received: from [10.20.41.56] (unknown [10.20.41.56])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxkOI+iaNgDgMAAA--.61S3;
        Tue, 18 May 2021 17:30:38 +0800 (CST)
Subject: Re: [PATCH 5/5] PCI: Support ASpeed VGA cards behind a misbehaving
 bridge
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20210518030917.GA72161@bjorn-Precision-5520>
From:   suijingfeng <suijingfeng@loongson.cn>
Organization: loongson
Message-ID: <1ebc8c3d-f5dd-55fb-22a3-15fd0449d149@loongson.cn>
Date:   Tue, 18 May 2021 17:30:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210518030917.GA72161@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9BxkOI+iaNgDgMAAA--.61S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4xJF4kKFyfXr1xZrWfGrg_yoW5CF1DpF
        W3uFWUKr48Gr17X3srXr18WF48CrZ3Aa1rKr13X34xuF47CryxWr9rWryvga409r18Xr15
        Kan8X34kKFyDAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
        026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
        JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
        vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
        ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021/5/18 上午11:09, Bjorn Helgaas wrote:

> If VGA Enable is 0 and cannot be set to 1, the bridge should *never*
> forward VGA accesses to its secondary bus.  The generic VGA driver
> that uses the legacy [mem 0xa0000-0xbffff] range should not work with
> the VGA device at 05:00.0, and that device cannot participate in the
> VGA arbitration scheme, which relies on the VGA Enable bit.
> 
> If you have a driver for 05:00.0 that doesn't need the legacy memory
> range, it's possible that it may work.  But VGA arbitration will be
> broken, and if 05:00.0 needs to be initialized by an option ROM, that
> probably won't work either.

We are not using a "generic VGA driver", in user space, we are using the 
modesetting driver come with X server, and it seems work normally. The 
real problems is VGA arbitration will not set 05:00.0 as the default VGA 
which means that when X server read 
/sys/devices/pci0000:00/0000:00:0c.0/0000:04:00.0/0000:05:00.0/boot_vga 
will get a "0". This break Xorg auto-detection. We want the boot_vga 
sysfs file be "1".

> If the 04:00.0 bridge *always* forwards VGA accesses, even though its
> VGA Enable bit is always zero, then the bridge is broken.  In that
> case, the generic VGA driver should work with the 05:00.0 device, but
> VGA arbitration will be limited.  I'm not sure, but the arbiter
> *might* be able to use the VGA Enable bit in the 00:0c.0 bridge to
> control VGA access to 05:00.0.  You wouldn't be able to have more than
> one VGA device below 00:0c.0, and you may not be able have more than
> one in the entire system.

We have only one VGA device(05:00.0) below 00:0c.0, but we do able to 
have more than one in the entire system. We could even mount a AMDGPU
on this server. But in reality, there is a render only GPU and a 
self-designed display controller integrated in LS7A1000 bridge. Both the 
render only GPU and the display controller is PCI device, they are 
located at PCI root bus directly without a PCI-to-PCI bridge in the 
middle. The display controller is blocked by the firmware if ASPEED BMC 
card is present, it can't be accessed under linux kernel. Let me show 
you a updated version of the PCI topology of our server(machine):

        /sys/devices/pci0000:00
        |-- 0000:00:06.0
        |   | -- class (0x040000)
        |   | -- vendor (0x0014)
        |   | -- device (0x7a15)
        |   | -- drm
        |   | -- ...
        |-- 0000:00:0c.0
        |   |-- class (0x060400)
        |   |-- vendor (0x0014)
        |   |-- device (0x7a09)
        |   |-- ...
        |   |-- 0000:04:00.0
        |   |   | -- class (0x060400)
        |   |   | -- device (0x1150)
        |   |   | -- vendor (0x1a03)
        |   |   | -- revision (0x04)
        |   |   | -- ...
        |   |   | -- 0000:05:00.0
        |   |   |    | -- class  (0x030000)
        |   |   |    | -- device (0x2000)
        |   |   |    | -- vendor (0x1a03)
        |   |   |    | -- boot_vga
        |   |   |    | -- i2c-6
        |   |   |    | -- drm
        |   |   |    | -- graphics
        |   |   |    | -- ...
        |   `-- uevent
        `-- ...

Even through the render only GPU(00:06.0) is not a VGA device, it still 
can disturb X server choose a primary device to use. But the root cause 
is the kernel side does not set 05:00.0 as default VGA. In this case X 
server will fallback to the first device found to use. and 00:06.0 is 
always found before 05:00.0. If kernel side set 05:00.0 as default VGA,
all other problems is secondary.

