Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F414475F9
	for <lists+linux-pci@lfdr.de>; Sun,  7 Nov 2021 22:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhKGVD7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Nov 2021 16:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhKGVD6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Nov 2021 16:03:58 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0271C061570;
        Sun,  7 Nov 2021 13:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ypazNIYC+H5uv8k7YFl3GFThyN95Wsm/rjGeHDCjcio=; b=xeT0VGxRJ694kjdut+v44U4I3v
        GJHEyrFG1sdHNchEvB9+UlHsZHkPdlADVKtQ9Ouzv91OOlZXjxst6j2JJd6Cu9hy8kijFOYoZMl8P
        lWQioMCDBAdyH0N7Ver4JKbyfJAT2K8kf65k/2b90+TMobl1GTJnpI7R4pJBTDDscrOTCzg/jG3V1
        Hl3RYaaGpw36FSCCnY+/rMLq/xsdH7OB1HZhrCjdjJdywhpMIE10mRoeAHDBzbR9PosftIqA7m7MK
        duDQEYMIiLUUe7m9PtyfjsovzGsM8daVekiwf+K5iEu3mQ5+FGsKdVEsuucIAvu8npdmxOw7JiDxO
        JmN6XZXQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by merlin.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjpHp-008ef2-AO; Sun, 07 Nov 2021 21:01:09 +0000
Subject: Re: [PATCH v3] PCI: rcar: Check if device is runtime suspended
 instead of __clk_is_enabled()
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20211107191057.145467-1-marek.vasut@gmail.com>
 <YYgy5EbjcOVuzxzu@rocinante>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5c7d3591-4f9e-1598-8bfc-179c5049c379@infradead.org>
Date:   Sun, 7 Nov 2021 13:01:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YYgy5EbjcOVuzxzu@rocinante>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/7/21 12:11 PM, Krzysztof Wilczyński wrote:
> [+CC Randy as he sent a patch to fix the same thing]
> 
> Hi Marek,
> 
>> Replace __clk_is_enabled() with pm_runtime_suspended(),
>> otherwise the following build error occurs:
>>    arm-linux-gnueabi-ld: drivers/pci/controller/pcie-rcar-host.o: in function `rcar_pcie_aarch32_abort_handler':
>>    pcie-rcar-host.c:(.text+0xdd0): undefined reference to `__clk_is_enabled'
>>
>> Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")
> 
> Randy sent a patch which aims to fix the same issue, albeit in a slightly
> different way.  I wonder if it would make sense for the two of you to look
> at which approach should we pick, or even whether we should combine the
> two into one patch?
> 
>    https://lore.kernel.org/linux-pci/20211107013703.19995-1-rdunlap@infradead.org/

Hi,
I saw Marek's patch a couple of hours ago.

As long as pm_runtime_suspended() is always available,
either live or as a stub (and it looks like it is),
I don't see any reason for my patch at all.

thanks.
-- 
~Randy
