Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF5D48CAD7
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 19:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356172AbiALSVZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 13:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242533AbiALSVX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 13:21:23 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A676FC06173F;
        Wed, 12 Jan 2022 10:21:23 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id h20-20020a9d6f94000000b0059100e01744so3514711otq.4;
        Wed, 12 Jan 2022 10:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=23KA5iUZLzWiXqNKkAFrgRPQ1lq+vFV68S6ClHHYEDw=;
        b=Ix0ggqp8Aod+W7W8IJUqbIw49xsET7431Qhc47iaM3RNRXhVbKn1l0U9U97KBdb83o
         Orrka67W/WX4pSNGWLw5fquddQwQ3IglYWRRC3rXBeXWM85cICbehgAt1VKHZnQakQN9
         catbiuyU+W6GSYLkTML+ZNtNHCEhyCfnevUdnJX6i5GWHDAHG4+TPbqDGj1y1Jwc7BYy
         V3T1uVfhMVmeVrRuO/JQE4kSQxjlqmBTPlCW/LEahX6ARgGiQGsR94FMAAeh4Zib6PRj
         OZJGV4gmxq4LnrrmpW/nJ6JVSrld80UQh6Wy/Pq1VLiKay3CjaSjm8Q7vV17zasqX8vp
         wOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=23KA5iUZLzWiXqNKkAFrgRPQ1lq+vFV68S6ClHHYEDw=;
        b=M2olqhrQF4kNUIpe9sJ2fK3aTMTOKR0eHFrYQ2zorTdPGahHBzFdQd0qK1Zgj6olYH
         MZVuyqdgMTfCP0OHluwMuZonuC8BzQw33f+gBU0TjME2zNXB/A7ArqRg3yNnnDRW9ZgO
         UNyc0r1YJslY+OneTyKh+EYmY1Q0IJYWH1XvSI/VjUhxmwnaT37cGgEF2Wc8CfEE7EQe
         CdcLxEQNopPrcDiRqcUnUp7I+FIyh0gOKLRDR66CEvxaKUXdkqV5Y5/PTMa6ZwIvjOl0
         ieJeMD5WAMYNOV9L+WJo7isZUIezKyy+L3SyFY7FkWxtM41Gb8zQjclSyJ5O4qQvHj1L
         PAFA==
X-Gm-Message-State: AOAM530MTWn9g1ItfUhBoql/ZPJ9P14WO+z60vpdr9lPj/35zx5J9XUZ
        GIcFblSHFpbjTFVJ24zpoW7sDCzNYQw=
X-Google-Smtp-Source: ABdhPJynuiNCiLzA6V8r3e+A7suR8JjLJunwBzKpjz9rIw39EsPpLkwGE45Up6ldxnD+KBxyJbhwkw==
X-Received: by 2002:a05:6830:22c8:: with SMTP id q8mr793406otc.54.1642011682426;
        Wed, 12 Jan 2022 10:21:22 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o18sm123706oik.27.2022.01.12.10.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 10:21:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v3 0/5] PCI: mt7621: Remove specific MIPS code from driver
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20211207104924.21327-1-sergio.paracuellos@gmail.com>
 <CAMhs-H886ZPZED-qmMtZcWFabRLNL14Y7SSz_Ko7d45zXL+v2w@mail.gmail.com>
 <20220112180627.GB1319@lpieralisi>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <d4780c9c-3404-5e18-808f-29108316486b@roeck-us.net>
Date:   Wed, 12 Jan 2022 10:21:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220112180627.GB1319@lpieralisi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/12/22 10:06 AM, Lorenzo Pieralisi wrote:
> On Wed, Jan 12, 2022 at 03:42:56PM +0100, Sergio Paracuellos wrote:
>> Hi Bjorn, Lorenzo,
>>
>> On Tue, Dec 7, 2021 at 11:49 AM Sergio Paracuellos
>> <sergio.paracuellos@gmail.com> wrote:
>>>
>>> Hi all,
>>>
>>> MIPS specific code can be removed from driver and put into ralink mt7621
>>> instead which is a more accurate place to do this. To make this possible
>>> we need to have access to 'bridge->windows' in 'pcibios_root_bridge_prepare()'
>>> which has been implemented for ralink mt7621 platform (there is no real
>>> need to implement this for any other platforms since those ones haven't got
>>> I/O coherency units). This also allow us to properly enable this driver to
>>> completely be enabled for COMPILE_TEST. This patchset appoarch:
>>> - Move windows list splice in 'pci_register_host_bridge()' after function
>>>    'pcibios_root_bridge_prepare()' is called.
>>> - Implement 'pcibios_root_bridge_prepare()' for ralink mt7621.
>>> - Avoid custom MIPs code in pcie-mt7621 driver.
>>> - Add missing 'MODULE_LICENSE()' to pcie-mt7621 driver to avoid compile test
>>>    module compilation to complain (already sent patch from Yanteng Si that
>>>    I have rewrite commit message and long description a bit.
>>> - Remove MIPS conditional code from Kconfig and mark driver as 'tristate'.
>>>
>>> This patchset is a real fix for some errors reported by Kernel Test Robot about
>>> implicit mips functions used in driver code and fix errors in driver when
>>> is compiled as a module [1] (mips:allmodconfig).
>>>
>>> Changes in v3:
>>>   - Rebase the series on the top of the temporal fix sent for v5.16[3] for
>>>     the module compilation problem.
>>>   - Address review comments from Guenter in PATCH 2 (thanks Guenter!):
>>>      - Address TODO in comment about the hardware does not allow zeros
>>>        after 1s for the mask and WARN_ON if that's happend.
>>>      - Be sure mask is real valid upper 16 bits.
>>
>> What are your plans for this series? Can we merge this?
> 
> I was waiting for an ACK on patch (2) since it affects MIPS code.
> 

Presumably not from me, but since some of the code is the result
of my suggestion I just sent a Reviewed-by: tag for patch 2.

Guenter

> It would also be great if Bjorn reviewed it to make sure he agrees
> with the approach.
> 
> I think it is too late for this cycle, apologies, there is a significant
> review backlog.
> 
> Lorenzo
> 
>> Best regards,
>>      Sergio Paracuellos
>>
>>>
>>> Changes in v2:
>>>   - Collect Acked-by from Arnd Bergmann for PATCH 1.
>>>   - Collect Reviewed-by from Krzysztof Wilczyński for PATCH 4.
>>>   - Adjust some patches commit subject and message as pointed out by Bjorn in review of v1 of the series[2].
>>>
>>> This patchset is the good way of properly compile driver as a module removing
>>> all MIPS specific code into arch ralink mt7621 place. To avoid mips:allmodconfig reported
>>> problems for v5.16 the following patch has been sent[3]. This series are rebased onto this patch to provide
>>> a real fix for this problem.
>>>
>>> [0]: https://lore.kernel.org/linux-mips/CAMhs-H8ShoaYiFOOzJaGC68nZz=V365RXN_Kjuj=fPFENGJiiw@mail.gmail.com/T/#t
>>> [1]: https://lkml.org/lkml/2021/11/14/436
>>> [2]: https://lore.kernel.org/r/20211115070809.15529-1-sergio.paracuellos@gmail.com
>>> [3]: https://lore.kernel.org/linux-pci/20211203192454.32624-1-sergio.paracuellos@gmail.com/T/#u
>>>
>>> Thanks in advance for your time.
>>>
>>> Best regards,
>>>     Sergio Paracuellos
>>>
>>> Sergio Paracuellos (5):
>>>    PCI: Let pcibios_root_bridge_prepare() access to 'bridge->windows'
>>>    MIPS: ralink: implement 'pcibios_root_bridge_prepare()'
>>>    PCI: mt7621: Avoid custom MIPS code in driver code
>>>    PCI: mt7621: Add missing 'MODULE_LICENSE()' definition
>>>    PCI: mt7621: Allow COMPILE_TEST for all arches
>>>
>>>   arch/mips/ralink/mt7621.c            | 31 ++++++++++++++++++++++
>>>   drivers/pci/controller/Kconfig       |  4 +--
>>>   drivers/pci/controller/pcie-mt7621.c | 39 ++--------------------------
>>>   drivers/pci/probe.c                  |  4 +--
>>>   4 files changed, 37 insertions(+), 41 deletions(-)
>>>
>>> --
>>> 2.33.0
>>>

