Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C565E5E72
	for <lists+linux-pci@lfdr.de>; Sat, 26 Oct 2019 20:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfJZSGm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Oct 2019 14:06:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39623 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfJZSGm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Oct 2019 14:06:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id a11so5722451wra.6;
        Sat, 26 Oct 2019 11:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1zAlr4sErex79x9Z4Q4GWkec7C6gUtbO/zStZ0PB9mY=;
        b=KVp3H+YnddgfFZXKq7V9vuKT8OWgA9iKAvfw/kRJVUs2HS6ggnJ4ciCl1EB4xNUtuG
         bEIty5flPbhZlPfkOZRv57ZcSRq+rxizAss7nF35t3m/ELgUF22PvXgqS27tTj4MrxJf
         XGoPu7Eywhf6r+iQo+xJlJ4PFHhk44+oDRkesia1aCNuMFSUMo+AT3MCJBht0klN5kIk
         6fGBAzmv9XdGLKLA7OMCbldugGCXxk9I71kd3ljNKcW7hkioutyiBBeN51h1tZHE3lod
         uDRvrtnQm/22/akofuf/YWn4BwYPuR92JXwxpoNJGqT8Qw/vvRDRw/XID2g/FqwNm6mL
         xtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1zAlr4sErex79x9Z4Q4GWkec7C6gUtbO/zStZ0PB9mY=;
        b=DV8uVRudSU5qKW5ltBpvSbGiz2LFWi2chOiB7dUwyj6/YNKT2PK3cYfeCmpV55i0OY
         fnReEdVaakIkPYWilVdQvmSmzLNxxLQ1R8FrpwiDSmDV2NR26SL/gSPm9N06xiiEatxZ
         IRMUhl+XaAY4RyG8CzobS5NmmgVYs9c67i8inZQRgm7sEAibLzsfqnZVHSjuTYWLB8vz
         N6+9MUfNUFU16xhb6kYOpY+7kOr2msRKHPiyeNzubMMaTf4IJN1GVZUd3ihOVV6zgxO9
         9i4GovT9Ns5a4bnrz7Jdm/SmMVn84xoEvLMG4VetjCNxoLYAEc21n4t3ODbFwH+ANSpA
         FKxQ==
X-Gm-Message-State: APjAAAV+nfL2u3d6GPBoh2HoeDnZJetPBkk2m3mSw/ps8/0z6nYUxfrh
        i988gazAUBdV20H2Ue6mA7D0OLx3
X-Google-Smtp-Source: APXvYqyDa6iMDIxlwT3yI7rXWJqPUih8LosVCXzjmKTBStzeiKe3SmiCgJ1qZuYNj32TnFJU1J571w==
X-Received: by 2002:adf:ea50:: with SMTP id j16mr7934048wrn.295.1572113200321;
        Sat, 26 Oct 2019 11:06:40 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id l22sm10686043wrb.45.2019.10.26.11.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2019 11:06:39 -0700 (PDT)
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound
 dma-ranges
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Simon Horman <horms@verge.net.au>, linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20190809175741.7066-1-marek.vasut@gmail.com>
 <20190809175741.7066-2-marek.vasut@gmail.com>
 <20190816132305.gyyml5r3xsimmoor@verge.net.au>
 <8f1871ed-4820-1985-0090-bb9e2d8803d8@gmail.com>
 <20191021101805.GM47056@e119886-lin.cambridge.arm.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <fef9502f-d51c-b922-afb3-8891267ae6c3@gmail.com>
Date:   Sat, 26 Oct 2019 20:03:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021101805.GM47056@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/21/19 12:18 PM, Andrew Murray wrote:
[...]
>>>> In case the "dma-ranges" DT property contains either too many ranges
>>>> or the range start address is unaligned in such a way that populating
>>>> the range into the controller requires multiple entries, a situation
>>>> may occur where all ranges cannot be loaded into the controller.
>>>>
>>>> Currently, the driver refuses to probe in such a situation. Relax this
>>>> behavior, load as many ranges as possible and warn if some ranges do
>>>> not fit anymore.
>>>
>>> What is the motivation for relaxing this?
>>
>> U-Boot can fill the ranges in properly now, the list would be longer in
>> such a case and the driver would fail to probe (because the list is
>> longer than what the hardware can support).
> 
> Is this the U-Boot patch you refer to:
> 
> https://patchwork.ozlabs.org/patch/1129436/

Yes.

> As pci_set_region is called with the same address for PCI and CPU memory
> this implies there is a 1:1 mapping - therefore I don't see a need for
> multiple mappings for each DRAM bank. (Also if this controller has a
> 32 bit limitation, shouldn't this code limit the addresses before calling
> pci_set_region?).
It would certainly be helpful to know about this dma-ranges detail
earlier, this whole thing could've been avoided. Now all I can do is get
that patch reverted for the next U-Boot release.

But this still leaves me with one open question -- how do I figure out
what to program into the PCI controller inbound windows, so that the
controller correctly filters inbound transfers which are targetting
nonexisting memory ?

-- 
Best regards,
Marek Vasut
