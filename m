Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22A96FBB2A
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 22:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfKMV6z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Nov 2019 16:58:55 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33578 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfKMV6y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Nov 2019 16:58:54 -0500
Received: by mail-oi1-f193.google.com with SMTP id m193so3316276oig.0;
        Wed, 13 Nov 2019 13:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sXC6pCx2CEyXJ5FQx/AIt/Xl4t7ohdqg7BEaLHc3ehA=;
        b=Wo/x4pXYonVbYF4u6GisOO8OinqI7zDkt2jd+UmCAXqo513p7D8sAPjQgPR95sV5/c
         7D49o1ng8wwRK/F52/EnPzQemWW9YgHcXVaUcP6xvggBcJeaXQ2Ga7WT/AmRKz6gW2yT
         9oCOyMZXGgZ88XoPu0qG+aprmi0FBE3AX4MfBhtdaQCxiGl2yVdEt2He4B1HxXHeuM/M
         5QJM1RNeeWiLifGkgj3HNgWyn9uJZxaAfPxe1WK23/6OkeGjxHR4gyMyeLAv0yh/MDCF
         LaeauF0ZzpPv/t2vyTQKd1Tpw0e3L3v31HoKEeQBlfgbi9ACmbxoMOo2YqZcVc/ZOAW+
         OhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sXC6pCx2CEyXJ5FQx/AIt/Xl4t7ohdqg7BEaLHc3ehA=;
        b=CwoRHSk0jWaJJaIRUirDhJgbqd2l7HIKKbYISc2r16M6HffQvrk9s8+UCTTqUSLEuk
         cOaJKw7dgx9US50Y9+o7n49oqo6D19W4NcPl4uWLPShml6kaGm9JmUQLT4uuEtsjxTU0
         SJbqodxQUr1uilGLhJshPmTEA7VNwDxLdQ43IGjbHTpjkkU3AtzshW/x3chrBWDKdLa3
         XZdVb7X0gw/a2Y2d27TY8rp+9axw/RrWBG1tejv9WHVszUKktLbBUpO+xI/V9Ho9LcTw
         vGiMBL/b//o0U4g+EXhLdTRFfeflsDSL1mW2bj4DG3uRUfjZE4IEu6gds+GMAJ/eePph
         IB3w==
X-Gm-Message-State: APjAAAUxuK5ggD2Jk1s4VJorhfkRUNDLWmHCB001GR8w+zKwYZFWQu/d
        ZmrIWy6XqX4ybht9AEMmkdTJ6c87Vzgt8w==
X-Google-Smtp-Source: APXvYqyPmHRJluv3a2S4FUMKILMpGc0FEnfyqJ4xgE9+uz6/wdXp6hXpPKoQFLbmd84HCsXaGA2FYw==
X-Received: by 2002:aca:5cd5:: with SMTP id q204mr734308oib.14.1573682333351;
        Wed, 13 Nov 2019 13:58:53 -0800 (PST)
Received: from [100.71.96.87] ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id h22sm1019866otr.36.2019.11.13.13.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 13:58:52 -0800 (PST)
Subject: Re: [PATCH] PCI: pciehp: Make sure pciehp_isr clears interrupt events
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191112215938.1145-1-stuart.w.hayes@gmail.com>
 <20191113045939.hhmzfbx46vkgmsvn@wunner.de>
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
Message-ID: <0712ed46-e4ba-46d0-05b5-81b258829f38@gmail.com>
Date:   Wed, 13 Nov 2019 15:58:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191113045939.hhmzfbx46vkgmsvn@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 11/12/19 10:59 PM, Lukas Wunner wrote:
> On Tue, Nov 12, 2019 at 04:59:38PM -0500, Stuart Hayes wrote:
>> The pciehp interrupt handler pciehp_isr() will read the slot status
>> register and then write back to it to clear just the bits that caused the
>> interrupt. If a different interrupt event bit gets set between the read and
>> the write, pciehp_isr() will exit without having cleared all of the
>> interrupt event bits, so we will never get another hotplug interrupt from
>> that device.
> 
> The IRQ is masked when it occurs and unmasked after it's been handled.
> See the invocation of mask_ack_irq() in handle_edge_irq() and
> handle_level_irq() in kernel/irq/chip.c.
> 
> If the IRQ has fired in-between, the IRQ chip is expected to invoke
> the IRQ handler again.  There is some support for IRQ chips not
> capable of replaying interrupts in kernel/irq/resend.c, but in general,
> if you do not get another hotplug interrupt, the hardware is broken.
> What kind of IRQ chip are you using and what kind of chip is the
> hotplug port built into?
> 
> I'm not opposed to quirks to support such broken hardware but the
> commit message shouldn't purport that it's normal behavior and the
> quirk should only be executed where necessary and be made explicit
> in the code to be a quirk.
> 
> Thanks,
> 
> Lukas
 
Thank you for the feedback!

The hotplug port I'm seeing the issue with is an AMD "Starship/Matisse GPP
Bridge" (1022/1483), which uses an MSI interrupt (PCI-MSI chip).

I don't think that the masking and unmasking will make any difference in this
case, because this pciehp port does not support MSI per-vector masking.

The PCI spec says:

"If the Port is enabled for edge-triggered interrupt signaling using MSI or MSI-X,
an interrupt message must be sent every time the logical AND of the following
conditions transitions from FALSE to TRUE:

• The associated vector is unmasked (not applicable if MSI does not support PVM).

• The Hot-Plug Interrupt Enable bit in the Slot Control register is set to 1b.

• At least one hot-plug event status bit in the Slot Status register and its
associated enable bit in the Slot Control register are both set to 1b."

Because the AMD port does not support PVM (per vector masking), the first
condition will always be true.

Because the hot-plug interrupt enable bit isn't cleared on each interrupt, the
second condition is true.

And because individual event enable bits in the slot control register aren't
cleared on each interrupt, I interpret this to mean that an interrupt message
will be sent every time that the event status bits in the slot status register
transition from all zeros to at least one event status bit being 1.  Once one
of those event status bits is 1, the logical AND of the three conditions above
will not transition from FALSE to TRUE again until all of the (enabled) event
status bits in the slot status register all go to zero, which is what my patch
is intended to ensure.

(I noticed too late that I have a compile warning with the ctrl_warn() call, so
I'll have to make a V2 of the patch for that, at least.)

Thanks,
Stuart
