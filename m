Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1014837021D
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 22:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhD3Uga (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 16:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbhD3Ug3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Apr 2021 16:36:29 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFA8C06174A
        for <linux-pci@vger.kernel.org>; Fri, 30 Apr 2021 13:35:40 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t18so14360124wry.1
        for <linux-pci@vger.kernel.org>; Fri, 30 Apr 2021 13:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NXDMPTvKhA4SLNR/aWMxRfWFqJiEC2m6N38OSkay0CI=;
        b=tMFr1X9bVqMembS/CISib0Nz6MHXXajYMc5tbw8qR6rxscqqJIzIrxkRoSW8NANrHj
         cE5AuoqK9mFW2n+cdxdvXeeVjV2H6xsWaS6d7g6cU7+ZmstKqbqLcwW54YOpiKCxzGwt
         8X7QsQZ0wBLqpgfgU8oVJ7ixV5dN+DMiXzLt/iIyJxLVDZ8vaOna4XKMo8FLsaDje03J
         f9Hvyg6jjI4d5K3HJKPiC+E/GkR1Px0gnQzNXkVkRrbADnEcZeKia57oB1dBteHPXP1j
         rHvj1ApWOobfXV3etOruYkksaB5ByEwfuM+mA9bzevCrnf6q14TT4XDaGz+KMuHQ64v3
         EuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NXDMPTvKhA4SLNR/aWMxRfWFqJiEC2m6N38OSkay0CI=;
        b=tcv6b2Kg8wP3joSsUfWMGlkbj7ejE/DWXZtC/N45xhhJpgNfGaT9B7Tk0w+y+lTUlM
         /t+D7P/yaQcdexAYW3krz93QRkebQH01xO1w+cHLv9W+eYKlxdEpbq+euK6hpRJtq4wu
         wUCntc20DNWJ+Tm/C9SktUakgbSkKVqwvxhbL5CJ9bpeybzWCQNyhv48SZzc5QFwW9B3
         5821AOhYFmHr8rC3kqwz48tfFI5iwU02bkTbAPaS0VQSEUEl0YbwcHhlgf/Rbg/Ei+nF
         Iddc74hWsX9HzchDAFJSnn9n3zbS6k6NoP4tZvZbI2fdPd7F4AWeQbdr66BJ9VGBzMSU
         Bv3g==
X-Gm-Message-State: AOAM531pDa+OrTwTTWB2w1OTL3HvQBmgyAJKu48QX3ieG4P4BiEfew+x
        iGuJE2GcMsOWMyPPWemkWJVLv+92xFWC3Q==
X-Google-Smtp-Source: ABdhPJyOEd8NVKGTtC7gXye60+BPI2po3UPptmKBJKqLkQlXPUS7dg6pRHE7el+gMYYaqZmTCp4rKA==
X-Received: by 2002:a5d:6352:: with SMTP id b18mr9575769wrw.76.1619814937868;
        Fri, 30 Apr 2021 13:35:37 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:ad00:f6bf:8c3b:84f1? (p200300ea8f384600ad00f6bf8c3b84f1.dip0.t-ipconnect.de. [2003:ea:8f38:4600:ad00:f6bf:8c3b:84f1])
        by smtp.googlemail.com with ESMTPSA id f6sm3467429wrt.19.2021.04.30.13.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 13:35:37 -0700 (PDT)
Subject: Re: [PATCH] PCI/VPD: Use unaligned access helper in pci_vpd_write
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20210430202933.GA678605@bjorn-Precision-5520>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <a721c852-ff90-f254-07a2-42ff834af0fa@gmail.com>
Date:   Fri, 30 Apr 2021 22:35:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210430202933.GA678605@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30.04.2021 22:29, Bjorn Helgaas wrote:
> On Sun, Apr 18, 2021 at 11:19:29AM +0200, Heiner Kallweit wrote:
>> Use helper get_unaligned_le32() to simplify the code.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/pci/vpd.c | 15 +++++----------
>>  1 file changed, 5 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
>> index 60573f27a..2888bb300 100644
>> --- a/drivers/pci/vpd.c
>> +++ b/drivers/pci/vpd.c
>> @@ -9,6 +9,7 @@
>>  #include <linux/delay.h>
>>  #include <linux/export.h>
>>  #include <linux/sched/signal.h>
>> +#include <asm/unaligned.h>
>>  #include "pci.h"
>>  
>>  /* VPD access through PCI 2.2+ VPD capability */
>> @@ -235,10 +236,9 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
>>  }
>>  
>>  static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
>> -			     const void *arg)
>> +			     const void *buf)
>>  {
>>  	struct pci_vpd *vpd = dev->vpd;
>> -	const u8 *buf = arg;
>>  	loff_t end = pos + count;
>>  	int ret = 0;
>>  
>> @@ -264,14 +264,8 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
>>  		goto out;
>>  
>>  	while (pos < end) {
>> -		u32 val;
>> -
>> -		val = *buf++;
>> -		val |= *buf++ << 8;
>> -		val |= *buf++ << 16;
>> -		val |= *buf++ << 24;
>> -
>> -		ret = pci_user_write_config_dword(dev, vpd->cap + PCI_VPD_DATA, val);
>> +		ret = pci_user_write_config_dword(dev, vpd->cap + PCI_VPD_DATA,
>> +						  get_unaligned_le32(buf));
> 
> If I understand correctly, get_unaligned_le32() is equivalent to the
> open-coded "val = *buf++; ..."  In other words, this doesn't fix a bug
> on any platforms, and it doesn't change the bits written to VPD.
> Right?
> 
Right.

> If so, this makes sense.  I'd like it better if we could also make
> pci_vpd_read() look more symmetric, since it has similar byte
> order-related code.  The read side is a little more complicated since
> the size need not be 4-byte aligned.  But maybe there's a way?  Seems
> like there should be other examples of this sort of thing, but my
> quick look didn't find one.
> 
I also find the read side a little bit hard to understand.
Let me check whether I find some way to improve the code.


>>  		if (ret < 0)
>>  			break;
>>  		ret = pci_user_write_config_word(dev, vpd->cap + PCI_VPD_ADDR,
>> @@ -286,6 +280,7 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
>>  			break;
>>  
>>  		pos += sizeof(u32);
>> +		buf += sizeof(u32);
>>  	}
>>  out:
>>  	mutex_unlock(&vpd->lock);
>> -- 
>> 2.31.1
>>

