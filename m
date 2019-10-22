Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87A88DF966
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2019 02:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbfJVANf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 20:13:35 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41805 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730472AbfJVANf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Oct 2019 20:13:35 -0400
Received: by mail-ot1-f65.google.com with SMTP id g13so12626988otp.8;
        Mon, 21 Oct 2019 17:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M+6bF5g/YSE/QuOb6sBnF/qNNP/gyev5JR5+wvN0sXw=;
        b=b2c8gm4Bbd0OmbDp99yDuCcsXVVEsGL2SvjN68dqGEwR+KknD5UpRk/6NszK4b2rg5
         aw/bUjPfQlOepsOnIbFhSwBtvsP6o8/05dNHbcKmg9DkogYhX3KtZApt+vF09kl5+4xA
         IX9oz+GTfHKpW8xlAnEfaS6VkdWK9+Tgy4n6CKpcm8OZK0lmpYHwlnZhldhtOGObSlxi
         MBD8kc8J2bU+78fxZTVkJ0qFxCD+0BamvidGtVlyBF+L3QqCakODr4lD04jOpB6FYWyY
         QlGIATUJieZik7oOPlgwyGlGXO+/mmrVAE5mSd/N9upD7h+Q49gGxSrxOaW3VXHz2kPA
         7/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M+6bF5g/YSE/QuOb6sBnF/qNNP/gyev5JR5+wvN0sXw=;
        b=mawwIV8ZzoB+oHKB4CAmwWR+LmHudPyG+axAg9/34JnwNySBA9Dy5oxwrGjE3pn8mz
         0tYIH0DGAVBfhyu6hibstZpNdAYULxWT7dW2y/p/Tf7zmdxICOHcCiZyQelTQ3gBo4Iw
         f8kk5Bl3i1rhtyRmsgsakCHNoZvROpq8WzwpnLv8Dj5cVS7FiddP7q7Q1FkLEBKmrX7D
         /fobe6X3GCskVoWzi05HaMl75CVReFIaEKFtZaXFC4vsLgaQMzsuNrueXhRPYmnZOp7u
         bsVGcaWy+ElgBkfRiDdFwLkRMpWXsFZYVNSpzX4t7nfCZr9xU/G2QiY8/OisrvGbhhHm
         uLNA==
X-Gm-Message-State: APjAAAWCdPd0ZJVNfzuYata3fETU7ozLCjSApYsG+y8ZuBun2nRA0U8d
        P2KEq6Toy7Lx+EFSFOx3jpE=
X-Google-Smtp-Source: APXvYqwA8kBZTBbWwYarMvf9QjlqphWph1OVZOn7BM2jiojzIiQ/xZOfEy0+BTJfGiWPwn8d49SCvw==
X-Received: by 2002:a05:6830:1aef:: with SMTP id c15mr474833otd.200.1571703214113;
        Mon, 21 Oct 2019 17:13:34 -0700 (PDT)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id k24sm4198786oic.29.2019.10.21.17.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 17:13:33 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] PCI: pciehp: Add dmi table for in-band presence
 disabled
To:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de
References: <20191017193256.3636-1-stuart.w.hayes@gmail.com>
 <20191017193256.3636-4-stuart.w.hayes@gmail.com>
 <20191021134729.GL2819@lahna.fi.intel.com>
 <f4ace3ab-1b39-8a82-4cb6-a7a5d3bfbc72@gmail.com>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <d41c69c6-fa7b-d271-95e0-bf6e51b981ec@gmail.com>
Date:   Mon, 21 Oct 2019 19:13:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f4ace3ab-1b39-8a82-4cb6-a7a5d3bfbc72@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/21/19 1:19 PM, Stuart Hayes wrote:
> 
> 
> On 10/21/19 8:47 AM, Mika Westerberg wrote:
>> On Thu, Oct 17, 2019 at 03:32:56PM -0400, Stuart Hayes wrote:
>>> Some systems have in-band presence detection disabled for hot-plug PCI
>>> slots, but do not report this in the slot capabilities 2 (SLTCAP2) register.
>>> On these systems, presence detect can become active well after the link is
>>> reported to be active, which can cause the slots to be disabled after a
>>> device is connected.
>>>
>>> Add a dmi table to flag these systems as having in-band presence disabled.
>>>
>>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
>>> ---
>>>   drivers/pci/hotplug/pciehp_hpc.c | 14 ++++++++++++++
>>>   1 file changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
>>> index 02eb811a014f..4d377a2a62ce 100644
>>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>>> @@ -14,6 +14,7 @@
>>>   
>>>   #define dev_fmt(fmt) "pciehp: " fmt
>>>   
>>> +#include <linux/dmi.h>
>>>   #include <linux/kernel.h>
>>>   #include <linux/types.h>
>>>   #include <linux/jiffies.h>
>>> @@ -26,6 +27,16 @@
>>>   #include "../pci.h"
>>>   #include "pciehp.h"
>>>   
>>> +static const struct dmi_system_id inband_presence_disabled_dmi_table[] = {
>>> +	{
>>> +		.ident = "Dell System",
>>> +		.matches = {
>>> +			DMI_MATCH(DMI_OEM_STRING, "Dell System"),
>>
>> Sorry if this has been discussed previously already but isn't this going
>> to apply on all Dell systems, not just the affected ones? Is this the
>> intention?
>>
> 
> Yes, that is the intention. Applying this just makes the hotplug code wait for
> the presence detect bit to be set before proceeding, which ideally wouldn't hurt
> anything--for devices that don't have inband presence detect disabled, presence
> detect should already be up when the code in patch 2/3 starts to wait for it.
> 
> The only issue should be with broken hotplug implementations that don't ever
> bring presence detect active (these apparently exist)--but even those would still
> work, they would just take an extra second to come up.
> 
> On the other hand, a number of Dell systems have (and will have) NVMe
> implementations that have inband presence detect disabled (but they won't have
> the new bit implemented to report that), and they don't work correctly without
> this.

I think it's clearer if this is explained in a comment. That it doesn't 
break anything, and we're okay this applies to all hotplug ports, even 
those that are not in front of an NVMe backplane.

Alex
