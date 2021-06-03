Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D153C39A937
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 19:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhFCRc1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 13:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhFCRc0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jun 2021 13:32:26 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C700C06174A;
        Thu,  3 Jun 2021 10:30:41 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d16so5388620pfn.12;
        Thu, 03 Jun 2021 10:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OEEmRrvyAG7HsQxvCTXsvqFaf1IXsLAfiEx1WPpz0iU=;
        b=Oek/Iyf/BMWcXdZg8AGcTY9vNhugpCgwYyy+YNwqTcbwQB3Lt/+obhcVP4dy+tbdmm
         4EgKlAWDIx+E6cFh+Jkm4eKDd0Yz+Jgpr/8exVdfBdWFGKWHw1oSGtdm6hUaFt5ksZ7i
         wr/aOGqWcNo4St3yitpBODuSVq44kqIaxjMPMB14GA/CRIPAMyazqpy6vphSJqlRutMy
         xUBiY+C6634+Av2cYoIvOw6n4L/puHUArA2TcZTMq9+GAbIgnyBbAH3NpqoC7uOtLjCY
         25z0skxycK4NJrTT8CgSeg2UcqRoKHL8w+o99tEPJeS1/hzo87OkMhFks9PeSSn6qRkT
         whwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OEEmRrvyAG7HsQxvCTXsvqFaf1IXsLAfiEx1WPpz0iU=;
        b=GDwZpdRQI5+3ZIIsGOHhjIi/jPSCbaMGVz7D26sLdt2gi0n/S+ihNUmur5Rg7fxB9i
         KqH+Srd882lzF15/H14yjgtBtGjCmIpwZqaYqIeUH1wZH8g3yPHWlUM3XUprujYDlaoK
         eROkZ/a8iasVA0U80HJ2I6be2iB/OXaZ5XsjCwmUMltnHNNXsyzwUXq8ZjjYzg97s7LQ
         xOEU2idRnYQfKOvPFTIbmxZCvtnJLRpJoPv64Km7il1uCfd2x2OdHCFh1tVo4m88warS
         Y6EL65SBbLAJ70YXdGuoRzCHq0vIjvYMvuMt0O7zVF0GMghspfhX4dW8ZQA2Vlo9jYUB
         /tQg==
X-Gm-Message-State: AOAM533uNDghx+7FbnFOHs3bkZf1Z3VQZ3q8QgqdjGCoACzMjwxGPvvr
        TdGb1TgxFtmB3YG9UhoIX4UVBYrhLNA=
X-Google-Smtp-Source: ABdhPJw6cKOan4hAw8pMtRcgDq0oVpE1nVRCul6xqIIl5d2LXMjbe0oR3pa/yaNXUCm52ZUj7TFi8A==
X-Received: by 2002:a05:6a00:88b:b029:2de:33b3:76c9 with SMTP id q11-20020a056a00088bb02902de33b376c9mr248158pfj.30.1622741440660;
        Thu, 03 Jun 2021 10:30:40 -0700 (PDT)
Received: from [10.67.49.104] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d131sm2788059pfd.176.2021.06.03.10.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 10:30:40 -0700 (PDT)
Subject: Re: [PATCH v1 4/4] PCI: brcmstb: add shutdown call to driver
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210603172313.GA2123252@bjorn-Precision-5520>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <dbd96bb2-4873-a37c-567d-ffd731beb927@gmail.com>
Date:   Thu, 3 Jun 2021 10:30:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210603172313.GA2123252@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/3/21 10:23 AM, Bjorn Helgaas wrote:
> On Wed, May 26, 2021 at 10:03:47AM -0700, Florian Fainelli wrote:
>> On 5/25/21 2:18 PM, Bjorn Helgaas wrote:
>>> On Tue, Apr 27, 2021 at 01:51:39PM -0400, Jim Quinlan wrote:
>>>> The shutdown() call is similar to the remove() call except the former does
>>>> not need to invoke pci_{stop,remove}_root_bus(), and besides, errors occur
>>>> if it does.
>>>
>>> This doesn't explain why shutdown() is necessary.  "errors occur"
>>> might be a hint, except that AFAICT, many similar drivers do invoke
>>> pci_stop_root_bus() and pci_remove_root_bus() (several of them while
>>> holding pci_lock_rescan_remove()), without implementing .shutdown().
>>
>> We have to implement .shutdown() in order to meet a certain power budget
>> while the chip is being put into S5 (soft off) state and still support
>> Wake-on-WLAN, for our latest chips this translates into roughly 200mW of
>> power savings at the wall. We could probably add a word or two in a v2
>> that indicates this is done for power savings.
> 
> "Saving power" is a great reason to do this.  But we still need to
> connect this to the driver model and the system-level behavior
> somehow.
> 
> The pci_driver comment says @shutdown is to "stop idling DMA
> operations" and it hooks into reboot_notifier_list in kernel/sys.c.
> That's incorrect or at least incomplete because reboot_notifier_list
> isn't mentioned at all in kernel/sys.c, and I don't see the connection
> between @shutdown and reboot_notifier_list.
> 
> AFAICT, @shutdown is currently used in this path:
> 
>   kernel_restart_prepare or kernel_shutdown_prepare
>     device_shutdown
>       dev->bus->shutdown
>         pci_device_shutdown                     # pci_bus_type.shutdown
>           drv->shutdown
> 
> so we're going to either reboot or halt/power-off the entire system,
> and we're not going to use this device again until we're in a
> brand-new kernel and we re-enumerate the device and re-register the
> driver.
> 
> I'm not quite sure how either of those fits into the power-saving
> reason.  I guess going to S5 is probably via the kernel_power_off()
> path and that by itself doesn't turn off as much power to the PCIe
> controller as it could?  And this new .shutdown() method will get
> called in that path and will turn off more power, but will still leave
> enough for wake-on-LAN to work?  And when we *do* wake from S5,
> obviously that means a complete boot with a new kernel.

Correct, the S5 shutdown is via kernel_power_off() and will turn off all
that we can in the PCIe root complex and its PHY, drop the PCIe link to
the end-point which signals that the end-point can enter its own suspend
logic, too. And yes, when we do wake-up from S5 it means booting a
completely new kernel. S5 is typically implemented in our chips by
keeping just a little bit of logic active to service wake-up events
(infrared remotes, GPIOs, RTC, etc.).
-- 
Florian
