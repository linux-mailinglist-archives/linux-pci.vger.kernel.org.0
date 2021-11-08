Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0207C449CB0
	for <lists+linux-pci@lfdr.de>; Mon,  8 Nov 2021 20:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbhKHTyc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Nov 2021 14:54:32 -0500
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:58827 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237645AbhKHTyb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Nov 2021 14:54:31 -0500
Received: from [192.168.1.18] ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id kAgBmHCd3OvR0kAgBmrd8n; Mon, 08 Nov 2021 20:51:45 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 08 Nov 2021 20:51:45 +0100
X-ME-IP: 86.243.171.122
Subject: Re: [PATCH] PCI: brcmstb: Declare a bitmap as a bitmap, not as a
 plain 'unsigned long'
To:     Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     nsaenz@kernel.org, jim2101024@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <e6d9da2112aab2939d1507b90962d07bfd735b4c.1636273671.git.christophe.jaillet@wanadoo.fr>
 <YYh+ldT5wU2s0sWY@rocinante> <4d556ac3-b936-b99c-5a50-9add8607047d@gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <4997ef3c-5867-7ce0-73a2-f4381cf0879b@wanadoo.fr>
Date:   Mon, 8 Nov 2021 20:51:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <4d556ac3-b936-b99c-5a50-9add8607047d@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le 08/11/2021 à 17:28, Florian Fainelli a écrit :
> 
> 
> On 11/7/2021 5:34 PM, Krzysztof Wilczyński wrote:
>> Hi Christophe!
>>
>> [...]
>>> This bitmap can be BRCM_INT_PCI_MSI_LEGACY_NR or BRCM_INT_PCI_MSI_NR 
>>> long.
>>
>> Ahh.  OK.  Given this an option would be to: do nothing (keep current
>> status quo); allocate memory dynamically passing the "msi->nr" after it
>> has been set accordingly; use BRCM_INT_PCI_MSI_NR and waste a little bit
>> of space.
>>
>> Perhaps moving to using the DECLARE_BITMAP() would be fine in this case
>> too, at least to match style of other drivers more closely.
>>
>> Jim, Florian and Lorenzo - is this something that would be OK with you,
>> or you would rather keep things as they were?
> 
> I would be tempted to leave the code as-is, but if we do we are probably 
> bound to seeing patches like Christophe's in the future to address the 

Even if I don't find this report in the Coverity database, it should 
from around April 2018.
So, if you have not already received several patches for that, I doubt 
that you will receive many in the future.


My own feeling is that using a long (and not a long *) as a bitmap, and 
accessing it with &long may look spurious to a reader.
That said, it works.

So, I let you decide if the patch is of any use. Should I need to tweak 
or resend it, let me know.


CJ

> problem, unless we place a coverity specific comment in the source tree, 
> which is probably frowned upon.
> 
> The addition of the BUILD_BUG_ON() is a good addition though.

