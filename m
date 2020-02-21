Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5C52168557
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2020 18:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgBURqq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Feb 2020 12:46:46 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37426 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgBURqq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Feb 2020 12:46:46 -0500
Received: by mail-oi1-f193.google.com with SMTP id q84so2388665oic.4;
        Fri, 21 Feb 2020 09:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EKUd7UioVe+wLWleg71Im0gMVwH1ISdDgRdo1WPTdxk=;
        b=OvcWEiAp8dO0LI6N25e3Y1211vcphy46GaLXWeNdXnBRoworZf2ISKE5up40fhYRYg
         /4sUja3J3lyyoCuo3XIeUTEypniD8dFgQmbIHSJk+3KD+mUF6G9y753pEP4OvRPLM8JL
         kR4qV6J/3bXcUu/0YO8fWY5lTx2bHSCO1fIOKy2CvObA2Don+o48MS3gNnFga8Yfz/vY
         dhJhIR29YQkN2xPEN5oq6HVjDJOWylRkUNIdlJ9tfls27CNj7YNGIxGKkFp/F07oDEx7
         w7MY0VvnoRxPHrsvud+qkD6PTJcV00nh5TvjLhHJekOaxYF0JeQcE1KkgZeJEf+H2j+G
         +m0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EKUd7UioVe+wLWleg71Im0gMVwH1ISdDgRdo1WPTdxk=;
        b=dHh74atssvaG4tfJuh/HwWnPC1RBcG4tF5cKUaW3kR0epQO6WoehMS3yX5VeMMtLwp
         zeRLcX5Dh4i/tNhKV2hmV0q6NjLzd/BFtrDnvX8nZN2nYFk5N6pIErxeq8vmaJDqgjzD
         hMDnqZ4w5InIIlwpNLnt+h/QenCx295u3IDl8vibqKEbw8khTDXl3Mjjiteed1IR6rob
         vEkVRdq+keb7o9aKaFI034CYQO0PCOrZj/l81CBRuW5exH4QYV7bu4qruUug1W6uppqM
         Qn2p3Ff7QeBqIgDqWcQCfaCrIeUuT1K+5lf3CV+VnWI4RQmZFYeI/25viV/kiZzACYsF
         M1/w==
X-Gm-Message-State: APjAAAX5ci7xEg9NQChOC+LWkrA5T+cO0uzTTJPEfW6pq1GTggPO086D
        HiFNPZCCglvAJ1ijSqTVqlE=
X-Google-Smtp-Source: APXvYqyYzvw3WT+zD2PvuzMClixE+WxBbl6dWb5asAbFFW4vQ4J6d6gR0l49nYEZTiRUg9oevcUqaA==
X-Received: by 2002:aca:2b04:: with SMTP id i4mr2937701oik.21.1582307205048;
        Fri, 21 Feb 2020 09:46:45 -0800 (PST)
Received: from [100.71.96.87] ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id e21sm1123944oib.16.2020.02.21.09.46.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2020 09:46:44 -0800 (PST)
Subject: Re: [PATCH v4 3/3] PCI: pciehp: Add dmi table for in-band presence
 disabled
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de
References: <20200221052147.GA154040@google.com>
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
Message-ID: <2311143b-d01c-2c03-614f-89093f8e5978@gmail.com>
Date:   Fri, 21 Feb 2020 11:46:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200221052147.GA154040@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/20/20 11:21 PM, Bjorn Helgaas wrote:
> On Fri, Oct 25, 2019 at 03:00:47PM -0400, Stuart Hayes wrote:
>> Some systems have in-band presence detection disabled for hot-plug PCI
>> slots, but do not report this in the slot capabilities 2 (SLTCAP2) register.
> 
> This doesn't seem quite accurate to me.  PCI_EXP_SLTCAP2_IBPD does not
> actually tell us whether in-band presence detection is disabled.  It
> only tells us whether it *can* be disabled.
> 
> I think I know what you mean, but this text suggests that
> PCI_EXP_SLTCAP2_IBPD not being set is the defect, and I don't think it
> is.  IIUC, even if PCI_EXP_SLTCAP2_IBPD were set,
> PCI_EXP_SLTCTL_IBPD_DISABLE would have no effect because in-band
> presence detect just isn't supported at all regardless of how we set
> PCI_EXP_SLTCTL_IBPD_DISABLE.
> 

I agree, the patch notes aren't quite correct.  Many Dell systems use
out-of-band presence detect, and there is no way to enable in-band presence
detection.

So I guess the notes would be more accurate if they said something like this:

Some systems use out-of-band presence detection exclusively, and do not
support the SLTCAP2_IBPD and SLTCTL_IBPD_DISABLE bits, but they still need
to have "inband_presence_disabled" set.

Add a dmi table to flag these systems as having in-band presence disabled.

>> On these systems, presence detect can become active well after the link is
>> reported to be active, which can cause the slots to be disabled after a
>> device is connected.
>>
>> Add a dmi table to flag these systems as having in-band presence disabled.
>>
>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
>> ---
>> v4
>>   add comment to dmi table
>>
>>  drivers/pci/hotplug/pciehp_hpc.c | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
>> index 02d95ab27a12..9541735bd0aa 100644
>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>> @@ -14,6 +14,7 @@
>>  
>>  #define dev_fmt(fmt) "pciehp: " fmt
>>  
>> +#include <linux/dmi.h>
>>  #include <linux/kernel.h>
>>  #include <linux/types.h>
>>  #include <linux/jiffies.h>
>> @@ -26,6 +27,24 @@
>>  #include "../pci.h"
>>  #include "pciehp.h"
>>  
>> +static const struct dmi_system_id inband_presence_disabled_dmi_table[] = {
>> +	/*
>> +	 * Match all Dell systems, as some Dell systems have inband
>> +	 * presence disabled on NVMe slots (but don't support the bit to
> 
> Is there something that restricts these slots to being used only for
> NVMe?  If not, I'd rather simply say that some Root Ports don't
> support in-band presence detect.  You say it's "disabled", which
> suggests that it could be *enabled*.  But I have the impression that
> it's actually just not supported at all (or maybe it's disabled by the
> BIOS via some non-architected mechanism).
> 

These slots are in the backplane that is meant for hard drives, so the
I don't know that there would be any other devices that would fit in them.
But, if some other device did fit physically and had the right connector,
I believe it would work.

I'm not sure if in-band presence detection is disabled by firmware, or
hardwired that way in the circuitry somehow, but you are correct, in-band
presence detect can't be enabled on these systems.

>> +	 * report it). Setting inband presence disabled should have no
>> +	 * negative effect, except on broken hotplug slots that never
>> +	 * assert presence detect--and those will still work, they will
>> +	 * just have a bit of extra delay before being probed.
>> +	 */
>> +	{
>> +		.ident = "Dell System",
>> +		.matches = {
>> +			DMI_MATCH(DMI_OEM_STRING, "Dell System"),
>> +		},
>> +	},
>> +	{}
>> +};
>> +
>>  static inline struct pci_dev *ctrl_dev(struct controller *ctrl)
>>  {
>>  	return ctrl->pcie->port;
>> @@ -895,6 +914,9 @@ struct controller *pcie_init(struct pcie_device *dev)
>>  		ctrl->inband_presence_disabled = 1;
>>  	}
>>  
>> +	if (dmi_first_match(inband_presence_disabled_dmi_table))
>> +		ctrl->inband_presence_disabled = 1;
> 
> This doesn't seem quite right: the DMI table should only apply to
> built-in ports, not to ports on plugin cards.
> 
> If we plug in a switch with hotplug-capable downstream ports, and
> those ports do not advertise PCI_EXP_SLTCAP2_IBPD, I think this code
> sets "inband_presence_disabled" for those ports even though it is not
> disabled.
> 
> IIUC, that will make this plugin card behave differently in a Dell
> system than it will in other systems, and that doesn't seem right to
> me.
> 

Setting "inband_presence_disabled" will only make a hotplug-capable slot
behave differently in two situations:

(1) The slot is using out-of-band presence detection instead of in-band,
in which case the hotplug code will correctly wait for the presence detect
bit to be active (after the link goes active) before proceeding to add the
device.

(2) The slot is broken and the presence detect bit never goes high in spite
of the PCI spec saying "This bit must be implemented on all Downstream Ports
that implement slots" (pcie base spec 5.0r1.0, section 7.5.3.11, slot status
register).  In this case, the hotplug slot will still work when
"inband_presence_disabled" is set, but it will take it a second or so longer
for the device to be added in linux because it will timeout waiting for the
presence detect bit to go active, instead of adding the device as soon as
the link goes active.

Since Dell doesn't support any plugin cards that provide hot plug slots that
are broken in that way, setting "inband_presence_disabled" shouldn't make any
difference.  But even if someone did use a card that was broken in this way,
it would still function.

If you think this is important, I could try to find a way to set
"inband_presence_disabled" just for built-in ports.  I'm not sure it would
be of any practical benefit, though.


>>  	/*
>>  	 * If empty slot's power status is on, turn power off.  The IRQ isn't
>>  	 * requested yet, so avoid triggering a notification with this command.
>> -- 
>> 2.18.1
>>
