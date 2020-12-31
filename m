Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942972E7F08
	for <lists+linux-pci@lfdr.de>; Thu, 31 Dec 2020 10:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgLaJjD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Dec 2020 04:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgLaJjC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Dec 2020 04:39:02 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9E0C061575;
        Thu, 31 Dec 2020 01:38:21 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id 91so19616841wrj.7;
        Thu, 31 Dec 2020 01:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O6IJOe9HmxCHaX/k/8Hvdu+gPK5vYpkTDbanSinpp2A=;
        b=kP7/Leay91zU77bhoq7jIC0+9u7y5IcDcjMut2mX5JWCR0YYvbHOZciooJ+EUW7tpo
         MB1f/Z8wOQc1lu+GCrnXrQ7YjR5fUXw1sF7OC4w03S43ToIEjcqtX6mlqtkBuZt5JQpb
         oZthpMtDNYZiAhed/aBIJ0a8GLapv+m5OEIXtIq8/Hax9TDmDOoPVQL+0ygIjEsTEg0T
         GbObUTZ/44cld0wGPeSQhUvUO6tPBpL2XBVt3E7Fsn3xi46L9+08DwLdHLIElMlxfApZ
         48dvrpZK80/WyIdkW+9EcXEVUArdaAQiH6myA1+u1XUKc9HUPo9gafphmUdcLuHjtF1a
         IDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O6IJOe9HmxCHaX/k/8Hvdu+gPK5vYpkTDbanSinpp2A=;
        b=jQHH5vQtQzPhKz0hWpysLD9JoZlboBlxTEXtCfVUFrIRvNZAa/JYHaOd9Vv3Axkz0r
         jOke7xpvJwS6rPGo0y7O4q62R/wkVsvIlwDN26Jk3zIHNm2lCxTedvlRRNBduPB+9OIa
         n5z1+thClyGP0NFGmOEZBiypJ8TN5YptgS+Mpv00UU7dH22+O6qiIRVl7KPeAbaRSPV2
         O8y+xSpGTPdyWBxCpcH+d1geDAwzFV7J29/4co75p9Tebw3XYmqlbdlY1kzwtjdCcoQZ
         FeZT8oPKi2U4ZHMtyCEOAcNE3O454mI+UTYuAaeGn6NI90RR3zn+JUik92v6NiG3RT5u
         2EVA==
X-Gm-Message-State: AOAM530rz0vpOwWNJBx6hX72Z13k/s0pfpVl7sSwmKfJqhg6mkrsny/w
        25WnSMRke+Z+sv3GJaXPWOKPzjUekKU=
X-Google-Smtp-Source: ABdhPJziqU8LAgVK0q6CnB1EZecZAEQh+BPxq9A6nKG2F71ac7q/j//HJLddWOLnWuMPYO8jNhAppA==
X-Received: by 2002:adf:8b15:: with SMTP id n21mr62275317wra.426.1609407500303;
        Thu, 31 Dec 2020 01:38:20 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:d936:bdcf:7b64:bfc4? (p200300ea8f065500d936bdcf7b64bfc4.dip0.t-ipconnect.de. [2003:ea:8f06:5500:d936:bdcf:7b64:bfc4])
        by smtp.googlemail.com with ESMTPSA id b10sm11575105wmj.5.2020.12.31.01.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Dec 2020 01:38:19 -0800 (PST)
Subject: Re: Time to re-enable Runtime PM per default for PCI devcies?
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <79940973-b631-90f9-dbc4-9579c6000816@gmail.com>
 <20201117163817.GA1397220@bjorn-Precision-5520>
 <CAJZ5v0ipMJ1gCB7okpROG_yAUi5Q8LknqeH+Jpdrjbb4D_vfuQ@mail.gmail.com>
 <9ca0fb46-9e65-31e2-103f-1c98ce8362c7@gmail.com>
 <20201231040735.GA2075@wunner.de>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <4eb10092-e3f9-c9be-2dec-e6de8aeedf97@gmail.com>
Date:   Thu, 31 Dec 2020 10:38:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201231040735.GA2075@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 31.12.2020 05:07, Lukas Wunner wrote:
> On Wed, Dec 30, 2020 at 11:56:04PM +0100, Heiner Kallweit wrote:
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3024,7 +3024,9 @@ void pci_pm_init(struct pci_dev *dev)
>>  	u16 status;
>>  	u16 pmc;
>>  
>> -	pm_runtime_forbid(&dev->dev);
>> +	if (pci_acpi_forbid_runtime_pm())
>> +		pm_runtime_forbid(&dev->dev);
>> +
> 
> Generic PCI code usually does not call ACPI-specific functions directly,
> but rather through a pci_platform_pm_ops callback.
> 
> FWIW, if platform_pci_power_manageable() returns true, it can probably
> be assumed that allowing runtime PM by default is okay.  So as a first
> step, you may want to call that instead of adding a new callback.
> 
I don't think that's sufficient. Most likely all the broken old systems
return true for platform_pci_power_manageable(). So yes, most likely
we'd need a new callback if we want to have the platform ops abstraction.
But it could be an optional callback, something like: forbid_runtime_pm
The question is just: is it worth it?

By the way: pci_set_platform_pm() returns an error if a callback isn't
set, but no existing caller bothers to check the return code.

> Thanks,
> 
> Lukas
> 
Heiner
