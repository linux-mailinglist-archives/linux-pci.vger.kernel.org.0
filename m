Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67DC497303
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jan 2022 17:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbiAWQbc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 11:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238477AbiAWQbc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Jan 2022 11:31:32 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEBCC06173B;
        Sun, 23 Jan 2022 08:31:31 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id m11so52023048edi.13;
        Sun, 23 Jan 2022 08:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2mDWZm1YmCufIY8Vj8Aka11CV5CFG+KhIi4CxFkJ36k=;
        b=L+FWeDlKb6S6X+S1CIY0h8SBbyqb3/3KlcoOfzpA5c5SWzxChxJsReIP7CvAM0wm+n
         RX9IPfLOKOV8vVIGTA2yhO6wtG6+HfWxULzLM1w+dJEkSsVL41zrpexlapiQ4wtPaSN1
         gvRk8T8V6M7z3fn3wg5mmOR53gj/O02HYLUA8ozi/9p/481aaNApqlap8PSveiErnBvh
         tuyR9d/Th/1jduChoKnyag/e1MctBNh8eNlplZwPDwj0TofmM/DnOw905mWfzYuXa0RN
         0uWWLewLuD1sG/C82Cablj65woyrnoH8tDWFsBevfrAxAFpMFHBApxBywIFCQDe1/rHO
         v6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2mDWZm1YmCufIY8Vj8Aka11CV5CFG+KhIi4CxFkJ36k=;
        b=32HGBwm7cPTGZG0LYhpvAq8ysNlxu++jf3DlkUcUb0cXvBcPTHRE0bOCnR2mUgZrcm
         YBn5wnH5/eN5nV3amRX3nuGoE1GyUdECvEOUiC/i6UMNpqkyJIAl+UabrVw3SNtxkxRw
         Qctt5Ve7lzT3QYLGeYxV3DOEGgZTnGFrIWxxTd0FeRNMMFis1Z+V2j6hLfydVOGBkwe3
         Vuap6qU1eIMBkR1m+G3SJW/htmraXIKGD5lD5OhbEY/fDDciGtNwHOnVPnZqH0vdkQjQ
         828Cf2YoebW0i0HBKR+pKm4aARQ2mNTZl5yGx7VHwlAnUWJfcoGFhbIDyJGuxBmDyOfE
         RwbQ==
X-Gm-Message-State: AOAM533O/ppKhkbbRUIphTEda1vvQ7MWHqeUGo+JxweJCFEiZihaYAAN
        Q84eSBwDNgM9opUWQxBPJAE=
X-Google-Smtp-Source: ABdhPJzS0l+T/7+uvWeGwUsSXBHzEd7PUX8/+QihoqyB8b8FTccnbHJwr/PLLVZqqibKpaoiGPZfbQ==
X-Received: by 2002:a05:6402:524d:: with SMTP id t13mr12295323edd.106.1642955490140;
        Sun, 23 Jan 2022 08:31:30 -0800 (PST)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id z9sm1780446edr.90.2022.01.23.08.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jan 2022 08:31:29 -0800 (PST)
Message-ID: <7ced7370-1853-b52d-7e04-062d1bf3334c@gmail.com>
Date:   Sun, 23 Jan 2022 17:31:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/2] PCI: rcar: Return all Fs from read which triggered
 an exception
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20220122221554.196311-1-marek.vasut@gmail.com>
 <20220122221554.196311-2-marek.vasut@gmail.com>
 <20220123153147.sv6eoayxqvqbaa66@pali>
From:   Marek Vasut <marek.vasut@gmail.com>
In-Reply-To: <20220123153147.sv6eoayxqvqbaa66@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/23/22 16:31, Pali Rohár wrote:
> On Saturday 22 January 2022 23:15:54 marek.vasut@gmail.com wrote:
>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>>
>> In case the controller is transitioning to L1 in rcar_pcie_config_access(),
>> any read/write access to PCIECDR triggers asynchronous external abort. This
>> is because the transition to L1 link state must be manually finished by the
>> driver. The PCIe IP can transition back from L1 state to L0 on its own.
> 
> Hello!
> 
> I must admit that this patch from its initial version evolved into giant hack...
> https://lore.kernel.org/linux-pci/20210514200549.431275-1-marek.vasut@gmail.com/
> 
> During review of the previous patch I have asked some important
> questions but I have not got any answer to them. So I'm reminding it:
> https://lore.kernel.org/linux-pci/20210805183024.ftdwknkttfwwogks@pali/
> 
> So could please answer what happens when PCIe controller is in some
> non-L* state and either MMIO happen or config read happens or config
> write happens?

What kind of non-L state ?

Do you have some specific test which fails ?

This patch addresses the case where the link transition to L1 state has 
to be completed manually. If the CPU accesses the config space before 
that happened, you get an imprecise data abort.

> It is really important to know this fact.
> 
> I'm in impression that this patch still is not enough as similar issues
> are also in other PCIe controllers which I know...

Do you have a suggestion for a patch which would be enough on this 
hardware ?
