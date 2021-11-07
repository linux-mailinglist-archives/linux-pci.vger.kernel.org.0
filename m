Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A181447651
	for <lists+linux-pci@lfdr.de>; Sun,  7 Nov 2021 23:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhKGWhu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Nov 2021 17:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhKGWhu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Nov 2021 17:37:50 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33857C061570;
        Sun,  7 Nov 2021 14:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=MRREIevuCyytOVATaJkNmAAUMUzKqoc6sIyRICQpIOk=; b=zSIX7nAc210ry/IbGJ7wJc78R3
        /g3dRFZtDlXnbU+k+Xi47Z1SXh/o10ShQdaaotK9Fe5amJBFBMYeU+ZR2hkeyTPEu7Bi7JvHHUKEj
        KGue7lbNUiybCrST4ryUOQlbb8/CsxVvyA5gXBqkjnXZqtz5bIHFEhL8SK+C1Q0khvHBkfiKwK9Qa
        7BiVEiSebh+omkp7zI9Wxxyi9mqFvpGgTkhCyuoAnyzil55ZpUWbmnHjaNOz9woGx7NE9P69wkJtw
        iBU26bxHRUi09rHcayEL9Ne0epJaKclvSftescCfYK6t9xRhz0MLe1wqhliDMI7OmarfJjKqIpQP6
        x5oP7Wzw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by merlin.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjqkg-008eqH-2q; Sun, 07 Nov 2021 22:35:02 +0000
Subject: Re: [PATCH v3] PCI: rcar: Check if device is runtime suspended
 instead of __clk_is_enabled()
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     marek.vasut@gmail.com, linux-pci@vger.kernel.org,
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
 <5c7d3591-4f9e-1598-8bfc-179c5049c379@infradead.org>
 <YYhUNBkCBpNwnjxz@rocinante>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9386e9a1-bf66-2f33-f8aa-6e7584ace53a@infradead.org>
Date:   Sun, 7 Nov 2021 14:34:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YYhUNBkCBpNwnjxz@rocinante>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/7/21 2:33 PM, Krzysztof Wilczyński wrote:
> Hi Randy,
> 
> [...]
>>> Randy sent a patch which aims to fix the same issue, albeit in a slightly
>>> different way.  I wonder if it would make sense for the two of you to look
>>> at which approach should we pick, or even whether we should combine the
>>> two into one patch?
>>>
>>>     https://lore.kernel.org/linux-pci/20211107013703.19995-1-rdunlap@infradead.org/
>>
>> Hi,
>> I saw Marek's patch a couple of hours ago.
>>
>> As long as pm_runtime_suspended() is always available,
>> either live or as a stub (and it looks like it is),
>> I don't see any reason for my patch at all.
> 
> Understood!  I marked it accordingly in Patchwok.  Thank you both!
> 
> By the way, can I count on your Acked-by or Reviewed-by here for Marek?  If
> you agree with the premise of the changes here, etc., of course.

Sure.
Acked-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
~Randy
