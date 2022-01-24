Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07CA4978AC
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 06:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241300AbiAXFqv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jan 2022 00:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241243AbiAXFqu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jan 2022 00:46:50 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70342C06173B;
        Sun, 23 Jan 2022 21:46:50 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ka4so18239290ejc.11;
        Sun, 23 Jan 2022 21:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HkSnuS44LOPC+JgKYRieiRulO3DJyDOtuSthHUwp9II=;
        b=P48wyIytu8V6vbAkSzwSLeJ3w66HMxF8/+xyLajrMsMelRRkt7dIEoFrgEbWOraeGd
         izlZi5qtNvpmouGKA0cRUllGSZ7XN+Wgmdhe/xxSAe5l9rYuIGqstkKVoXmF8myv1sQX
         yrWyCkU1j3AbnrndpJfD/al37mm9KOtmy/NesFjc0KkCTn8CZygoeM0frNROb0i+YtoW
         aU4D/8TIZW7MVBsiSYo0qo2ASrb5q9Y0y2S0h8kASO9Z4DdjFVX7zWbCYqrd1+gdWHGA
         CznYfdMMkIQZvlqol3YCgHlWXlvl0TwD6r3K6SMlB40aLz2xtMfB+QL2gowjnqpqbNYV
         6SaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HkSnuS44LOPC+JgKYRieiRulO3DJyDOtuSthHUwp9II=;
        b=eX4TLN5D+/4m7KdMrkff+yQR7GzqxM6sllgE2znMDr67tOVdmJ4AX1wMuC7Dlz/IRG
         uA3htxFlQfV95PN9ugHJhfgR/gIngcqWQSj3ROHu7DvLmqYB4bhZB+2QlMjIJJH9r64Y
         PhFmBqKQ3ZoF7TfG6mmpX9kpaSPvXOBqwezD784etDqd5eHGLO8HXmFRUh35cPvVaX86
         hda15rObf/8JptMlZPDmRalMoFzRO/LzEmH3qkxnIb8HJVu5KqrJ8WVxKagJIeuVP10B
         3b37vYIp+6Dk2iBuPpAI+qrJFw5sC2765K8eUqNxtd+jZQEaogNSYf0ewiKwt0QJBsMc
         Adlw==
X-Gm-Message-State: AOAM5321bU7iKoyyV8y1VgpZWlAKD2uVZiBmBECxrdEkjN9km02RD+O3
        ZOrxJKQcMFYn23lqb8p7xts=
X-Google-Smtp-Source: ABdhPJzauLFpRG9IXo056rR3+62+2H10wFaDgOVv2qwDodGm311TrIRCS4ymtpMibZzgw54YpkRpiA==
X-Received: by 2002:a17:906:1e01:: with SMTP id g1mr11894889ejj.298.1643003208934;
        Sun, 23 Jan 2022 21:46:48 -0800 (PST)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id u6sm4446233ejn.181.2022.01.23.21.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jan 2022 21:46:48 -0800 (PST)
Message-ID: <9d89314c-8757-8965-0f5d-14fd95669320@gmail.com>
Date:   Mon, 24 Jan 2022 06:46:47 +0100
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
 <7ced7370-1853-b52d-7e04-062d1bf3334c@gmail.com>
 <20220123164936.cmzvkkkuw5chz3ek@pali>
From:   Marek Vasut <marek.vasut@gmail.com>
In-Reply-To: <20220123164936.cmzvkkkuw5chz3ek@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/23/22 17:49, Pali Rohár wrote:

Hi,

[...]

>>> I must admit that this patch from its initial version evolved into giant hack...
>>> https://lore.kernel.org/linux-pci/20210514200549.431275-1-marek.vasut@gmail.com/
>>>
>>> During review of the previous patch I have asked some important
>>> questions but I have not got any answer to them. So I'm reminding it:
>>> https://lore.kernel.org/linux-pci/20210805183024.ftdwknkttfwwogks@pali/
>>>
>>> So could please answer what happens when PCIe controller is in some
>>> non-L* state and either MMIO happen or config read happens or config
>>> write happens?
>>
>> What kind of non-L state ?
> 
> E.g. Hot Reset, Detect, Polling, Configuration or Recovery.
> 
>> Do you have some specific test which fails ?
> 
> Yes, by putting PCIe controller into one of those states. I have already
> wrote you in some previous email to trigger hot reset as this is the
> easiest test and can be done also by userspace (setpci).
> 
> Link goes to Recovery state automatically when doing link retraining
> (e.g. by setting RT bit in PCIe Root Port config space) and from
> Recovery to Configuration or directly back to L0. So testing this path
> needs precise timing and repeating it more times to trigger.
> 
> So the easiest test is really via PCIe Hot Reset by setting Secondary
> Bus Reset bit in Bridge Control register of PCIe Root Port. After this
> is link in Hot Reset and does not go back to L0 until you clear that
> bit. So in this state you can do all these operations which cause
> aborts, like calling that kernel function which is reading from config
> space which belongs to device on the other end of the PCIe link or doing
> MMIO read / write operation of mapped memory which again belongs to
> other end of PCIe link.
> 
> Or instead of Hot Reset, you can set link disable bit in config space of
> PCIe Root Port. Then link also would not be in L0 state (until you clear
> that bit), so again you have lot of time to do same tests.

Can you give me the exact setpci invocation ? If so, then I can test 
this for you on the hardware.

>> This patch addresses the case where the link transition to L1 state has to
>> be completed manually. If the CPU accesses the config space before that
>> happened, you get an imprecise data abort.
> 
> Yes, I see. But it does not have to complete and the question how is
> handled this case... And that is why is needed to know what happens in
> such cases.
> 
> And IIRC you cannot go from L1 state directly to L0, but only via
> Recovery state. And from Recovery you may end up in Detect state.
> (e.g. after hot unplug or if some buggy card with kernel quirk is used)
> 
>>> It is really important to know this fact.
>>>
>>> I'm in impression that this patch still is not enough as similar issues
>>> are also in other PCIe controllers which I know...
>>
>> Do you have a suggestion for a patch which would be enough on this hardware
>> ?
> 
> I do not have enough information.

I see
