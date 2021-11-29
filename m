Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37E1461509
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 13:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239035AbhK2Man (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 07:30:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59671 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239557AbhK2M2n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 07:28:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638188725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fbLRMSTFzjNXMAIb9l/Um0Ew3pAD94nKgUFKycrBk0o=;
        b=SQzw4Kq2SQEohexmAFD8MdTLHoWjtwk5/b+VeZpnAPWWD4KrMbBwok8B4zDK1kR4R1SlOd
        WIxHIIyf3bNYozQsz2PAnSuPYvAibbC2bMcbA7+XtJVcgS/cxG4zLD+nxiC/iKWB3Q1kVy
        9UNVnWAXAZSf0l1JnHaX8aDj4kqb4VI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-qLxgo4f5NkmgKV0JF05rgw-1; Mon, 29 Nov 2021 07:25:23 -0500
X-MC-Unique: qLxgo4f5NkmgKV0JF05rgw-1
Received: by mail-ed1-f70.google.com with SMTP id m17-20020aa7d351000000b003e7c0bc8523so13555294edr.1
        for <linux-pci@vger.kernel.org>; Mon, 29 Nov 2021 04:25:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=fbLRMSTFzjNXMAIb9l/Um0Ew3pAD94nKgUFKycrBk0o=;
        b=LqVU/3PIJKq1h1kYXkloV/tWA6MRuIxs/lAEsHdoYpDMewFMREA18w62/yhRLM3QON
         H7cKxCnHKK++W+66Y/4HhmR4ZYKDfJiNAg4VC2PHGS7CvUpuK5MMaqKy4ZH5nqvb7Bez
         fvwIxH74sHAqDDNPlvPOP5OKcduhNYaLglPssU6M+jotpRykHKcOvxqA/eX6spLdnN5d
         Q7dvG1L/xVu+aCPQ8XEbvLjUHXoYE72utvKu1xo5aWzAbfBOYFzYFxjPRAFn71DiKTvG
         zO1U12g6iIyPwN65KWQhIGTBxoKD+cWW2Db0d5nlinh44Vm4GoVRaxrABC83F50YsvAV
         kOwQ==
X-Gm-Message-State: AOAM532oYCwoCxbnObkic36pvbRMP5U895LI1KyVjGhLN4OpvjOl3T+R
        NX6RDq0kXWr1hP4/btnTwvtJSuqpfb8VDjilx6r0/Ic35vZ+8ay9cGyJ+O8SMh2ZbYWRG8suStQ
        2UPsEawD0ywOuMiPATq0t
X-Received: by 2002:a05:6402:42c6:: with SMTP id i6mr75615004edc.223.1638188722782;
        Mon, 29 Nov 2021 04:25:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLNVeeOMg0EFF6YQklGTUg84zccH26xvOXT+D6LqAQX4Irz2hbtH9SJogLXIETFVgVVDqjcQ==
X-Received: by 2002:a05:6402:42c6:: with SMTP id i6mr75614987edc.223.1638188722643;
        Mon, 29 Nov 2021 04:25:22 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id t3sm9065577edr.63.2021.11.29.04.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 04:25:22 -0800 (PST)
Message-ID: <6ea88158-2ef1-daec-56c4-59302d775928@redhat.com>
Date:   Mon, 29 Nov 2021 13:25:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: Lockdep warning about ctrl->reset_lock in
 pciehp_check_presence/pciehp_ist on TB3 dock unplug
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
References: <de684a28-9038-8fc6-27ca-3f6f2f6400d7@redhat.com>
 <20211122212943.GA2176134@bhelgaas> <20211124041317.GA1887@wunner.de>
 <8abe5147-f468-01a4-6ea6-1a01cde5f1b9@redhat.com>
In-Reply-To: <8abe5147-f468-01a4-6ea6-1a01cde5f1b9@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 11/24/21 15:31, Hans de Goede wrote:
> Hi,
> 
> On 11/24/21 05:13, Lukas Wunner wrote:
>> On Mon, Nov 22, 2021 at 03:29:43PM -0600, Bjorn Helgaas wrote:
>>> On Mon, Nov 22, 2021 at 05:45:32PM +0100, Hans de Goede wrote:
>>>> With 5.16-rc2 I'm getting the following lockdep warning when unplugging
>>>> a Lenovo X1C8 from a Lenovo 2nd gen TB3 dock:
>>
>> Thanks for the report.  I'm aware of this issue, it's still on my todo
>> list.  Theodore already came across it a while ago:
>>
>> https://lore.kernel.org/linux-pci/20190402021933.GA2966@mit.edu/
>>
>> It's a false positive, we need to use a separate lockdep class either
>> for each hotplug port or for each level in the PCI hierarchy.
> 
> Can we easily determine what the level in the PCI hierarchy is ?
> 
> If yes; and if having a separate lock class per level is enough,
> then the code could simply switch to down_read_nested
> (and other xxx_nested) functions passing the level as
> "subclass" parameter.
> 
> If no, maybe we should add an "int level" member to
> struct controller ?
> 
> And then make the switch to the foo_nested locking functions
> based on that ?

So I've given the above idea a shot and fixes the false-positive
lockdep warning for me. I've posted a 2 patch series fixing this
upstream:

https://lore.kernel.org/linux-pci/20211129121934.4963-1-hdegoede@redhat.com/T/#t

Note the 2nd patch can probably use a Fixes: tag but I had no
idea which commit to put there. Or maybe add a Cc: stable to
both patches?

Regards,

Hans

