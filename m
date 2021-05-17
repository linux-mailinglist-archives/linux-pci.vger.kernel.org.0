Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0F6383A55
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 18:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbhEQQsH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 12:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239204AbhEQQr7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 12:47:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C268FC04A05C;
        Mon, 17 May 2021 09:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=D5eX4KgU6Q08BtWp0alaF4iGc+iWIBQF2uar2PYOHUc=; b=SI8qiQJ1mPwMO363pwJu6urylo
        dLs5oVmPYyYQJxH0M1j2e3hH8leGyGkM/aLk85T0JYMfNn6Dh8I6P9wKyX5YSHihLveMVX+uRf6qo
        i69reejNSy04FIaaTdaoGTCO55CN0piXkKCTw54D8AQYTKypDPc87uE+oY58EU6oaHM7OZBh2Ihp0
        fQP1dMCLrqCzCCbZABuxwI8LR8beOuTV5sUxeDi80I93uD7CDMq/+NrUc/aONsiahjlNxKWO7kUO8
        g8gJugo/4buid2pRgyeFg50OFUPIguZgXlERSd4qmd8lvJJjxkPlmmrWwcgJ1+x4bFYYy8v6/1e6l
        G0kYb5VQ==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lifuj-00DyRK-6J; Mon, 17 May 2021 16:16:17 +0000
Subject: Re: [PATCH] PCI: ftpci100: rename macro name collision
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
References: <20210516190014.25664-1-rdunlap@infradead.org>
 <CACRpkdbcN4d2sdCDjqqW7txDm7--_B2MX10CDA6z8FOq4mQ7=g@mail.gmail.com>
 <20210517103435.GA179901@rocinante.localdomain>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2a5204be-7761-2d0b-e1a6-af5b6d4fdb0d@infradead.org>
Date:   Mon, 17 May 2021 09:16:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210517103435.GA179901@rocinante.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/17/21 3:34 AM, Krzysztof Wilczyński wrote:
> Hi Randy and Linus,
> 
> [...]
>>> PCI_IOSIZE is defined in mach-loongson64/spaces.h, so change the name
>>> of this macro in pci-ftpci100.c.
> [...]
>> Though I suspect the real solution is to prefix all macros with FTPCI_*?

I'm willing to go that far.

> Agreed, especially since some of the constants and macros in this
> driver already prefix various names using "FARADAY_".  We could keep
> this pattern and apply this prefix to other things.  There are also
> other constants and macros named starting with "PCI_" that could
> potentially be renamed too.
> 
> Having said that, I actually wonder if some of these constants and
> macros are would be something we already have declared (people tend to
> often solve the same problems)and could be reused, as per:
> 
>   #define PCI_IOSIZE	0x00
>   #define PCI_PROT	0x04 /* AHB protection */
>   #define PCI_CTRL	0x08 /* PCI control signal */
>   #define PCI_SOFTRST	0x10 /* Soft reset counter and response error enable */
>   #define PCI_CONFIG	0x28 /* PCI configuration command register */
>   #define PCI_DATA	0x2C
> 
> Or these:
> 
>   #define PCI_CONF_ENABLE	BIT(31)
>   #define PCI_CONF_WHERE(r)	((r) & 0xFC)
>   #define PCI_CONF_BUS(b)	(((b) & 0xFF) << 16)
>   #define PCI_CONF_DEVICE(d)	(((d) & 0x1F) << 11)
>   #define PCI_CONF_FUNCTION(f)	(((f) & 0x07) << 8)


If you would like to take that and run with it, please go ahead.

thanks.
-- 
~Randy

