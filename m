Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496F42193A0
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 00:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgGHWj5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jul 2020 18:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGHWjw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jul 2020 18:39:52 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96BFC061A0B
        for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2020 15:39:52 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id k4so323691oik.2
        for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2020 15:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wOWN8L070EigXY4W0zpDVe/62XS6pe5wAcEVKIDeRjA=;
        b=onz/lPxKe0lFOGCgje2A+FzJJnGxW+lqAZOPiLpIuWADeT1FNlFrHdNhSPD7JI61dK
         7beIY48aobkTd/cjzF0mRKNK6Kq3gey/GB2EPAmlUE2AcPJnDQiJ4cKpSoXrBdwkCe/e
         opGjZjp4I7S0HpmxZjL9ort5BCnC2je0XNmE9dj7X7AAttU0gQUQgj9EtZHoKWeCIXYY
         YF+nXCvqImwq276URA7ySInAG1oVLMqO9wKjTXKA70WjxRyjfPkDw49Iif+0+GpngzIQ
         oYgnxmXnlBaSTuSv01qMfmW3aZ0nEgHFY5NCQFiL01GJtS5GCZ+SgfTHvpHd/eO08Jo0
         vwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wOWN8L070EigXY4W0zpDVe/62XS6pe5wAcEVKIDeRjA=;
        b=aiZaTFn5qc4IL8j9HHONQAo5ASm3+NWxF/+8PxUsiCYh1S5VCYR6BiYQTxQ+8yeKuv
         O4ad93yuAAjPszeh70RkwVDIQfPnZtd/F4/QXBWTl5KMDm5QdQO02G+Nk03mgMB0fObB
         7DGCshLJzS4Y+7NEB9yNeUG7c3bKkuJZ1WtgacqFg0D75M5tSdd+KDt9uxA3rT1fJvFl
         elxMUHDxsmqR0wtO7BgAYiCQKcQwuTef8L+YBeJFUzZZnfIr3x/0dKsrP9vJEFazsban
         sH+COssZel2GmaCeXKkcaEyT9uHdE0loSeaOOd4JJ2pf1/iRAO+LYMqpWzeIc1HWgC8U
         MyCw==
X-Gm-Message-State: AOAM530bkBA/l1W6Y2f0o+7KhsfvJqAawOOGo9VbLitrWy6Nc0ak6gng
        Sji2SawwWRAOsO1lb/leOuTy9ZSjngA=
X-Google-Smtp-Source: ABdhPJz3dRkOuZ1r4womn3PSGDF8YUy4pSJUtYCjqossBlgUFnaBmY7lGaSjwl+NCcl14yWgNw1bgQ==
X-Received: by 2002:aca:aacb:: with SMTP id t194mr9534754oie.19.1594247991402;
        Wed, 08 Jul 2020 15:39:51 -0700 (PDT)
Received: from [100.71.96.87] ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id v6sm249111oou.2.2020.07.08.15.39.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 15:39:50 -0700 (PDT)
Subject: Re: [PATCH] PCI: pciehp: Don't enable slot unless link or presence up
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20200310182100.102987-1-stuart.w.hayes@gmail.com>
 <20200329123643.eeqervkxcxzc3kjn@wunner.de>
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
Message-ID: <d8c4c36a-9eb9-33c6-556a-2a2d55e127ec@gmail.com>
Date:   Wed, 8 Jul 2020 17:39:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200329123643.eeqervkxcxzc3kjn@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/29/20 7:36 AM, Lukas Wunner wrote:
> On Tue, Mar 10, 2020 at 01:21:00PM -0500, Stuart Hayes wrote:
>> When a pciehp slot is powered down via /sys/bus/pci/slots/<slot>/power,
>> and then the card is physically removed, the kernel will sometimes try to
>> enable the slot as the card is removed, which results in an error in the
>> kernel log.
>>
>> This can happen if the presence detect and link active bits don't go down
>> at the exact same time. When the card is disabled via /sys/.../power, the
>> card is placed in OFF_STATE, but the presence detect and link active bits
>> can still be up.  Then, when, say, presence detect goes down, an interrupt
>> reports that the presence detect has changed, and the code in
>> pciehp_handle_presence_or_link_change() will see that the link is up
>> (because it hasn't gone down yet), and it will try to enable the slot.
>>
>> This patch modifies that code so it won't try to enable a slot in OFF_STATE
>> unless it sees the presence detect changed bit with presence detect active,
>> or the link status changed bit with an active link. This will prevent the
>> unwanted attempts to enable a card that's being removed, but will still
>> allow the slot to come up if the slot is re-enabled by writing to
>> /sys/.../power, or if a new card is added to the slot.
>>
>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
>> ---
>>  drivers/pci/hotplug/pciehp_ctrl.c | 24 ++++++++++++++----------
>>  1 file changed, 14 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
>> index 6503d15effbb..f6cbf21711e0 100644
>> --- a/drivers/pci/hotplug/pciehp_ctrl.c
>> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
>> @@ -267,16 +267,20 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>>  		cancel_delayed_work(&ctrl->button_work);
>>  		/* fall through */
>>  	case OFF_STATE:
>> -		ctrl->state = POWERON_STATE;
>> -		mutex_unlock(&ctrl->state_lock);
>> -		if (present)
>> -			ctrl_info(ctrl, "Slot(%s): Card present\n",
>> -				  slot_name(ctrl));
>> -		if (link_active)
>> -			ctrl_info(ctrl, "Slot(%s): Link Up\n",
>> -				  slot_name(ctrl));
>> -		ctrl->request_result = pciehp_enable_slot(ctrl);
>> -		break;
>> +		if ((events & PCI_EXP_SLTSTA_PDC && present) ||
>> +		    (events & PCI_EXP_SLTSTA_DLLSC && link_active)) {
>> +			ctrl->state = POWERON_STATE;
>> +			mutex_unlock(&ctrl->state_lock);
>> +			if (present)
>> +				ctrl_info(ctrl, "Slot(%s): Card present\n",
>> +					  slot_name(ctrl));
>> +			if (link_active)
>> +				ctrl_info(ctrl, "Slot(%s): Link Up\n",
>> +					  slot_name(ctrl));
>> +			ctrl->request_result = pciehp_enable_slot(ctrl);
>> +			break;
>> +		}
>> +		/* fall through */
>>  	default:
>>  		mutex_unlock(&ctrl->state_lock);
>>  		break;
> 
> First of all:
> 
> Up until now, when the controller is in BLINKINGON_STATE and a PDC or
> DLLSC event is received and PDS or DLLLA is on, the button_work is
> canceled and the slot is brought up immediately.  The rationale is
> that is doesn't make much sense to wait until the 5 second delay has
> elapsed if we know there's a card in the slot or the link is already up.
> 
> However with the above change, it could happen that the button_work is
> canceled even though the slot *isn't* brought up.  If the slot is only
> brought up if ((PDC && PDS) || (DLLSC && DLLLA)) and those conditions
> aren't satisfied at the moment, they might be once the 5 seconds have
> elapsed.  So I think we should continue blinking and not cancel the
> button_work.
> > Secondly, I'm wondering if this change might break hardware which doesn't
> behave well.  If the slot signals e.g. PDC but takes a little while to
> set PDS even though DLLLA is already set, then the current code will react
> tolerantly, whereas the change proposed above may result in the slot not
> being brought up at all.  Not sure if such hardware exists, just slightly
> concerned.
> > IIUC, the only downside of the current code is an error message in dmesg
> when trying to bring up a slot after the card has already been removed.
> Maybe just toning down the message to KERN_INFO would be appropriate?
> 
> Thanks,
> 
> Lukas
> 

(Sorry it has taken me so long to reply.)

I could easily change the patch so that the behavior is unchanged when the
controller is in the BLINKINGON_STATE.  My concern is only when it is in
the OFF_STATE (after being disabled via sysfs).

It's more than just the "Link Up" message.  When I "power down" an NVMe
drive via sysfs (on a system that doesn't actually shut off the power to
the slot), and then I physically remove the drive, I get this ugly string
of messages:

pcieport 0000:3c:06.0: pciehp: Slot(180): Link Up
pcieport 0000:3c:06.0: pciehp: Timeout waiting for Presence Detect
pcieport 0000:3c:06.0: pciehp: link training error: status 0x0001
pcieport 0000:3c:06.0: pciehp: Failed to check link status

But I've given it a lot of thought, and I don't see a good way to avoid
that, unless we can assume that PDS/DLLLA will get set no later than PDC/
DLLLA.  Without that assumption, even if we put the controller in a
new state like ON_BUT_DISABLED_STATE after it is disabled but there's no
hardware to actually turn off the power to the slot, we won't know when
we get a PDC if that's because the card has been removed, or if the card
was removed and re-inserted, and the PDS just hasn't gone active yet.

Even without this patch, the pciehp code could fail to connect newly-
inserted cards, if they don't set PDS/DLLLA before PDC/DLLSC.  For
example, if both PDC & DLLSC occur at about the same time, but neither
PDS nor DLLLA are set yet when pciehp_handle_presence_or_link_change()
runs, it will return without trying to bring the slot up.  And cards
that don't ever bother to turn on PDS would never connect automatically
if DLLLA comes up after DLLLC.

I would think that it would be worth making that assumption to get rid
of those ugly messages, since these messages could be quite common, but
it is (I suspect) very unlikely than any hardware would set PDC/DLLSC
before the corresponding status bits.

I did think of one other potential issue:  Right now, a fake PDC event
is used to trigger connecting of occupied slots during probe, resume, or
enabling via sysfs... I could change that to PDC | DLLSC to make
sure it connects cards that don't ever set PDS.

Would you consider the patch if I rework it to separate the
BLINKINGON_STATE so that its behavior isn't changed, and change the
fake PDC events to PDC | DLLSC?

Thanks,
Stuart

