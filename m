Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9864324100
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2019 21:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbfETTQc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 May 2019 15:16:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44286 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfETTQc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 May 2019 15:16:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id w13so5089095wru.11
        for <linux-pci@vger.kernel.org>; Mon, 20 May 2019 12:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3I7/OE0He33wSOLnEZT4X4+0u6jrjhRmm+4qL0YNMS4=;
        b=ETqLeGGePlPXhuxljIqRWHoN0lQdOTwhW4d8liUs6NfBt43ILGxdY6ELFxDrddg/CH
         PrV/aDuZA5yRHYqKDzD1c9nGY3nh1HzRqaImKybbrWnqTPxTRPmSHRo5mdKh6qX2V5jd
         ATzMerdiFuEI7AQ3zz282DqvPv47fHUXK2OKGsEI2Mcc1jQIahHYdqsI++gwkzrgvKUV
         pa/oVDpdrb9T783iSl1jlsGLYZ10QGiUtYFxge2/QCGVkMl+C9cZfqQxT+K5Tb1enNty
         xnKkDPE+Ix9wDc0k+u/ujexuflBhd/muJ9HAoLUY8W4LSaD9Fi7TU4HDBAxTQzXlZ+dz
         SO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3I7/OE0He33wSOLnEZT4X4+0u6jrjhRmm+4qL0YNMS4=;
        b=gM1zqEjfs/M2WR5g3o1QiT1cyYWNualQ39YiFd5FxPm41MmDhAgnrz3WkaL93UlQJc
         Nr1on4e3ubj0YqZR+RYZs/1IEp+610jPK+AWfoo5o3cAJ70qSOhUme1l2Z1XJOBEnpCW
         A7Ar7nE54OgzgFv8L5niuGUGT0onBgQscaZyPIS38nELkUIw8Q4UkSywZdpDzUGCsncX
         H2nU0yHZQIV8WgnGsUCoxJ7kLujOFgNHmWXv0XEWb8WPy0UbXS1gFTBVsqak0wD1ObE3
         9AGoliG4MdZ+KylGcpM/V2NQEx+leiBDKlYt0iDUwCxv0Ruy9zOKVybw3S0v7O6sQctR
         sjiA==
X-Gm-Message-State: APjAAAXLrdQonGawBEQpfVK160R4BhNxyU9zr5TZoPrK6Cg0TOUtvjHv
        uHI+4rF6hdEfXbV/ApyOhFun3oon
X-Google-Smtp-Source: APXvYqxr4YcejPX2J/pn+FmQQKjOdKXVMCrlQLEarCEQYImq9VbbYfrkY2NoPYlPaU8uZibEvcJnYA==
X-Received: by 2002:adf:ea8d:: with SMTP id s13mr30721508wrm.292.1558379790725;
        Mon, 20 May 2019 12:16:30 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:18ac:8b5c:4f46:603f? (p200300EA8BD4570018AC8B5C4F46603F.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:18ac:8b5c:4f46:603f])
        by smtp.googlemail.com with ESMTPSA id a128sm692794wmc.13.2019.05.20.12.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 12:16:29 -0700 (PDT)
Subject: Re: [PATCH RFC v3 3/3] PCI/ASPM: add sysfs attribute for controlling
 ASPM
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <bde6db67-b432-f23c-5a44-d2cbb794ad40@gmail.com>
 <061c2def-8998-d62e-a268-c5d1426b14f9@gmail.com>
 <9bc7c84f-5508-46b1-9f61-7ea8023e65ee@fredlawl.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <5f00fc62-063d-4dd5-d808-4047eab70709@gmail.com>
Date:   Mon, 20 May 2019 21:16:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9bc7c84f-5508-46b1-9f61-7ea8023e65ee@fredlawl.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 17.05.2019 02:12, Frederick Lawler wrote:
> Heiner,
> 
> Heiner Kallweit wrote on 5/12/19 8:54 AM:> [snip]
>> +static ssize_t aspm_link_states_show(struct device *dev,
>> +                     struct device_attribute *attr, char *buf)
>> +{
>> +    struct pci_dev *pdev = to_pci_dev(dev);
>> +    struct pcie_link_state *link;
>> +    int len = 0, i;
>> +
>> +    link = aspm_get_parent_link(pdev);
>> +    if (!link)
>> +        return -EOPNOTSUPP;
>> +
>> +    mutex_lock(&aspm_lock);
>> +
>> +    for (i = 0; i < ARRAY_SIZE(aspm_sysfs_states); i++) {
>> +        const struct aspm_sysfs_state *st = aspm_sysfs_states + i;
>> +
>> +        if (link->aspm_enabled & st->mask)
>> +            len += scnprintf(buf + len, PAGE_SIZE - len, "[%s] ",
>> +                     st->name);
>> +        else
>> +            len += scnprintf(buf + len, PAGE_SIZE - len, "%s ",
>> +                     st->name);
>> +    }
> 
>   # echo "-L1" > aspm_link_states
>   # cat aspm_link_states
>   L0S L1 L1.1 L1.2 [CLKPM]
> 
>   # echo "+L1" > aspm_link_states
>   # cat aspm_link_states
>   L0S [L1] L1.1 L1.2 [CLKPM]
> 
> In v1 & v2 [STATE] was used to show that a state was disabled, now [STATE] is used to show enabled. Is that intended?
> 
Yes, based on a review comment from you from May 12th:
"If we avoid the double negative, the documentation about to be written will be more clear and use of the sysfs file will be more intuitive."

>> +
>> +    if (link->clkpm_enabled)
>> +        len += scnprintf(buf + len, PAGE_SIZE - len, "[CLKPM] ");
>> +    else
>> +        len += scnprintf(buf + len, PAGE_SIZE - len, "CLKPM ");
>> +
> 
> Same as above...
> 
>> +    mutex_unlock(&aspm_lock);
>> +
>> +    len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
>> +
>> +    return len;
>> +}
> 
> Other than the above, v3 works as expected on my machine. Good work :)
> 
Great, thanks for the feedback!

OK, then let's see what still needs to be done to finish the patch series:
The new sysfs attribute needs to be documented. Anything else?

> Frederick Lawler
> 
> 
Heiner
