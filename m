Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9FF1C602D
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 20:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgEESfL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 14:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgEESfK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 May 2020 14:35:10 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32BFC061A0F;
        Tue,  5 May 2020 11:35:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l18so3928742wrn.6;
        Tue, 05 May 2020 11:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WR4Fi4baKF8fOxJSXJRBPjGc7il3LPg33dM6L7j+uBg=;
        b=jNKkMO5+dQC3N7hxX8QxPumCKU64Y6gV5ngSlMu4x1PT6SmZsp1oOtayv6LlmgWU3W
         nNdi4JaQglRcr/3OnQoNYPhHj3S5qBn3dzm65gsJCfC0mNU8a3Y5qXfoNDA14PJtO+Tx
         FGE9Ks4xXnCowPI19VlYDB7kdKFU5z5lZE0nYZE/UQdNAmhGImOdKhhcQDNWkP5v1HUw
         6//opHaBhDCuSCFVD2BFxNTymbk+4HmM1kKwG7ZfJFBjDAjMd3Heml++J9HFmxjxjUcn
         A1ehIqmcOCI8JptNyc4Ujz8x/4nWrF6QMsmxxEhICkQdIv5kYPXylPReRBZ0XXSC7Hr0
         NJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WR4Fi4baKF8fOxJSXJRBPjGc7il3LPg33dM6L7j+uBg=;
        b=S7cQopO18+PYvtehKokbpSz/bX8Nw6PLORahiTyMMy+W6cZLEcq+O8x9Y5F7JK6u6L
         dY7N8nibruuqO8TSWOLn01FFH4uOr2VAWb3I+oHJsdNg+JaNMZA5TN7r6ZxD2nN2zMao
         z4GtJhcHpCJ9gxOpAujWA1Q2rNCepnvsdmKPGXP5aEMpcquSmffuv1OlrEdHvHjJKmnj
         Jrdnzub6Uwm2OS7kTXG++ohSgAwQtoyT60opOqZoYDkPuWglqcCdg3zorNLdq+FOaoba
         xhbqLfQQ9ClLEVqk44kZ+tw6fEew0NcNJPs8bHuthZBfu4824DEUCIrUm9duaLtghwlp
         ejew==
X-Gm-Message-State: AGi0PuZFMl6xpTMXOlUnP6lJK3zPka42QzqBP4aS8btwcYn+TkAsM4gZ
        bS4uFskCcqGDC+KydH3QmXNKU0h8
X-Google-Smtp-Source: APiQypJH2FSz7b4y5muU7qQxVK+nLiwh6gexINK69wDQu7dV6/W+ZAYrTTqyXvIytCpFN8PwQrq1vg==
X-Received: by 2002:a5d:6712:: with SMTP id o18mr5505009wru.115.1588703706818;
        Tue, 05 May 2020 11:35:06 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id 88sm4783265wrq.77.2020.05.05.11.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 11:35:05 -0700 (PDT)
Subject: Re: [PATCH] PCI: pcie-rcar: Cache PHY init function pointer
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20200426123148.56051-1-marek.vasut@gmail.com>
 <20200428083231.GC12459@e121166-lin.cambridge.arm.com>
 <717765f1-b5be-a436-20d6-d0a95f58cbdc@gmail.com>
 <20200505180214.GA18468@e121166-lin.cambridge.arm.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <a7971547-869a-b3ca-5934-4ce5028aacf1@gmail.com>
Date:   Tue, 5 May 2020 20:35:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200505180214.GA18468@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/5/20 8:02 PM, Lorenzo Pieralisi wrote:
> On Fri, May 01, 2020 at 10:42:06PM +0200, Marek Vasut wrote:
>> On 4/28/20 10:32 AM, Lorenzo Pieralisi wrote:
>>> On Sun, Apr 26, 2020 at 02:31:47PM +0200, marek.vasut@gmail.com wrote:
>>>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>>>>
>>>> The PHY initialization function pointer does not change during the
>>>> lifetime of the driver instance, it is therefore sufficient to get
>>>> the pointer in .probe(), cache it in driver private data, and just
>>>> call the function through the cached pointer in .resume().
>>>>
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>>> Cc: Wolfram Sang <wsa@the-dreams.de>
>>>> Cc: linux-renesas-soc@vger.kernel.org
>>>> ---
>>>> NOTE: Based on git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
>>>>       branch pci/rcar
>>>> NOTE: The driver tag is now 'pcie-rcar' to distinguish it from pci-rcar-gen2.c
>>>> ---
>>>>  drivers/pci/controller/pcie-rcar.c | 10 ++++------
>>>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>>
>>> Squashed in https://patchwork.kernel.org/patch/11438665
>>
>> Thanks
>>
>>> Do you want me to rename the $SUBJECT (and the branch name while at it)
>>> in the patches in my pci/rcar branch ("PCI: pcie-rcar: ...") to start
>>> the commit subject tag renaming from this cycle (and in the interim you
>>> send a rename for the drivers files ?)
>>
>> I don't really have a particular preference either way. I can keep
>> marking the drivers with pcie-rcar and pci-rcar tags if that helps
>> discern them.
> 
> So:
> 
> - "rcar" for the PCIe driver

Wouldn't it be better to mark this rcar-pcie , so it's clear it's the
PCIe driver ?

> - "rcar-pci" or "rcar-legacy" for the pci-rcar-gen2.c (preference ?
>   there is no urgency, no commit queued to rename, it is for future
>   code)

rcar-pci , since the Gen2 controller surely isn't legacy.

> Are we OK with that ? If yes I will rewrite the commits subjects
> and push out an updated pci/rcar branch.
> 
> ...DT bindings commit subjects - should I change their tag subject
> too ?



-- 
Best regards,
Marek Vasut
