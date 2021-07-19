Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A173CE54D
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jul 2021 18:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347365AbhGSPsh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jul 2021 11:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350175AbhGSPpi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jul 2021 11:45:38 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151ACC0A1FFE;
        Mon, 19 Jul 2021 08:33:38 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id m2so22710543wrq.2;
        Mon, 19 Jul 2021 08:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VEk/ygZOiOE9Oi0CxELPfCpAh9zJBHh+8UX4QsKnZmI=;
        b=MBGlYJGJllJcYsrCiau99JenjNqQlZzJ2/dQf7AaiZA5CQcSRv7g+g4B5aphZM4E7s
         5oQMAVfC587hYUrjrLeRWX2T6KmHI/9nBY+t9A5jPbwkvrY1yKvEkjjANfptJxjt5G8H
         cIZiACUf8TXDH1Rtf76o8LJWuu4x4R3X5+s23K1klZLy8DbMyfxCQoR8XZnBAc7fP6X7
         GvanyrcWrJzrbFsSXUN1gle/LkFdaFvX6kN79m3PGTymlCtaG7Dhn37M+k2KzVuzq1dH
         Cewh+y4e3QU0lCXuAdw4hgNGr03aPL/b9CExnoBwiUuKft1Fy2ZABDic7sGhlSCdlzys
         9jNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VEk/ygZOiOE9Oi0CxELPfCpAh9zJBHh+8UX4QsKnZmI=;
        b=fBYHOFYugfpWebQ9aNWd8OAqOuNWAPenj/+IJ1NmkTeDX7jf7P5s2zPyjKi/qU1JXh
         0NfJ8KS9IArL/mGnEjhw6+SuIehFRixcP0kOlouJV6K5ECzU+wcxHq0/izevXpEKlkTk
         QbAYRD1sAo+R75ZMvPc652E9mCCYEXlFaxSvOb6bXJzxhL9HBUL035IlsLVNwhGZ8f3G
         lDInxOEVtwygyx/p/BTSI2dm2FNOpNQuUk6pk1gI7e4eQbaK64armxm2PA6AJ99JbUWj
         QcBEqW2cLCglnXGlQvr5Z4iBJtU47HYICKMrWXnkXnWxILT9A696+2XPeSqiyywdl8R2
         YtOg==
X-Gm-Message-State: AOAM5328MTz7/a63C7Tc5AYjGbJoNRp55CRf3wJDMYpfa/J8yfCVY8XZ
        oEG1Gj58R60bu46tUbmlVac=
X-Google-Smtp-Source: ABdhPJxDjJLyfDlhjaBhe6E5/GWiEdh2HLfb1Ndh+Ut118QXrWIvPtqncE61VIxdlahRKNDtSGkkwA==
X-Received: by 2002:a5d:6ac8:: with SMTP id u8mr31153742wrw.30.1626710382489;
        Mon, 19 Jul 2021 08:59:42 -0700 (PDT)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id m4sm20984782wrs.14.2021.07.19.08.59.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 08:59:42 -0700 (PDT)
Subject: Re: [PATCH V6] PCI: rcar: Add L1 link state fix into data abort hook
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org, pali@kernel.org
References: <20210514200549.431275-1-marek.vasut@gmail.com>
 <20210717173334.GA2232818@bjorn-Precision-5520>
 <20210719085953.GA17481@lpieralisi>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <59d5a3bd-9b31-0203-ca99-46a92ffc9895@gmail.com>
Date:   Mon, 19 Jul 2021 17:38:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210719085953.GA17481@lpieralisi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/19/21 10:59 AM, Lorenzo Pieralisi wrote:
> [+Pali]
> 
> On Sat, Jul 17, 2021 at 12:33:34PM -0500, Bjorn Helgaas wrote:
>> On Fri, May 14, 2021 at 10:05:49PM +0200, marek.vasut@gmail.com wrote:
>>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>>>
>>> The R-Car PCIe controller is capable of handling L0s/L1 link states.
>>> While the controller can enter and exit L0s link state, and exit L1
>>> link state, without any additional action from the driver, to enter
>>> L1 link state, the driver must complete the link state transition by
>>> issuing additional commands to the controller.
>>>
>>> The problem is, this transition is not atomic. The controller sets
>>> PMEL1RX bit in PMSR register upon reception of PM_ENTER_L1 DLLP from
>>> the PCIe card, but then the controller enters some sort of inbetween
>>> state. The driver must detect this condition and complete the link
>>> state transition, by setting L1IATN bit in PMCTLR and waiting for
>>> the link state transition to complete.
>>>
>>> If a PCIe access happens inside this window, where the controller
>>> is between L0 and L1 link states, the access generates a fault and
>>> the ARM 'imprecise external abort' handler is invoked.
>>>
>>> Just like other PCI controller drivers, here we hook the fault handler,
>>> perform the fixup to help the controller enter L1 link state, and then
>>> restart the instruction which triggered the fault. Since the controller
>>> is in L1 link state now, the link can exit from L1 link state to L0 and
>>> successfully complete the access.
>>>
>>> While it was suggested to disable L1 link state support completely on
>>> the controller level, this would not prevent the L1 link state entry
>>> initiated by the link partner. This happens e.g. in case a PCIe card
>>> enters D3Hot state, which could be initiated from pci_set_power_state()
>>> if the card indicates D3Hot support, which in turn means link must enter
>>> L1 state. So instead, fix up the L1 link state after all.
>>>
>>> Note that this fixup is applicable only to Aarch32 R-Car controllers,
>>> the Aarch64 R-Car perform the same fixup in TFA, see TFA commit [1]
>>> 0969397f2 ("rcar_gen3: plat: Prevent PCIe hang during L1X config access")
>>> [1] https://github.com/ARM-software/arm-trusted-firmware/commit/0969397f295621aa26b3d14b76dd397d22be58bf
>>
>> This patch is horribly ugly but it's working around a horrible
>> hardware problem, and I don't have any better suggestions, so I guess
>> we don't really have much choice.
> 
> Pali is doing some work on the matter (in particular [1] above) and I
> was following that up to see if there was any outcome before merging
> this code, I could not follow up myself for lack of time.

arm32 r-car does NOT use atf, so this does not apply here.
