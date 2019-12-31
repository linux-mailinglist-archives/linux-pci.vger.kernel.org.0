Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52D5F12DBFB
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2019 23:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfLaWGy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Dec 2019 17:06:54 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38867 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbfLaWGx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Dec 2019 17:06:53 -0500
Received: by mail-pj1-f65.google.com with SMTP id l35so1632147pje.3;
        Tue, 31 Dec 2019 14:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UyKWBjTYtMhvO9CkUZXNZDev/n9QRhV/4KmWAGx3d9M=;
        b=BXl4VwVPTLF4wJmXzKQRGjKLNC916gV7fQJmv+Bcfrxb3AYMAMwq5uiSf0LyAt4rHf
         MgaSse7K2QcJNXjp5m7kxZLoqdkwjVhXCwjJEJZpMqKsMw+PYbI97+4rMU5Bm1nTX+4s
         r0iX7RqJUGVOQcbGQLW8bdafTQnzqCPINxM6ST3FMLLPlcB7iehwU4E7eP0v0WTuwgZy
         kDBIcpjyae1f4cke7KvavQiOw7OzhueQNifXvwE9OA6rdP+bO8wk3PeWnuNwZ3qdIa1n
         QuYKUWomZLLaR25nCLZ6pMpedHYhOkkGvbW+1sWxKxmtJN+8tTQV/m/qhZX8TC6sz1UB
         3O7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UyKWBjTYtMhvO9CkUZXNZDev/n9QRhV/4KmWAGx3d9M=;
        b=WwmQ9K/0c+X6DdTmF6myj/YpV8UJJr+71ZzMQdc8wcfgIZtPU1z8ZXjqmrpnlEqoDy
         PvGk+8ude5TSfbG7VvjGURMLNhjJA9akjl6PHT1/A2iMyIyJr9ak/xPymbRNBFYDjp3r
         jRW+79vxxhz5eMFSCUElEq//aeWcUxtUKYwsmDqcsD97nZY0ZPklPcL4VZsUn1Klbyoe
         5Qv2Z/PX5QZ6FuZnKt+NDa5m32XEkcAjlLz6agghPjCK36+sn8x2fYYp6DIRKGJu0nsF
         ElVrqSSc6VrI8W0ThfDCucN0trRmYUHWnjr3sBkmqTBPQGYgUlw9CJ3f8K/ayckltTTC
         qwug==
X-Gm-Message-State: APjAAAVT6PH1d+8t5b+tUM3EYbKOblftSDzoTM0J8YMy7vnw1S/npXc4
        7LnR6IQ0+kbJv8az1O72X1A=
X-Google-Smtp-Source: APXvYqybjvAuvXhX2zdUwKAnSrs4yjN/Tdp8vKgaeiN/DvOw2nnIGGWQAFL9xkVY7rgADrIhlamMGw==
X-Received: by 2002:a17:90b:4004:: with SMTP id ie4mr8971773pjb.49.1577830013234;
        Tue, 31 Dec 2019 14:06:53 -0800 (PST)
Received: from [100.71.96.87] ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 3sm54207358pfi.13.2019.12.31.14.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Dec 2019 14:06:52 -0800 (PST)
Subject: Re: [PATCH v4 1/3] PCI: pciehp: Add support for disabling in-band
 presence
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Austin Bolen <austin_bolen@dell.com>,
        Keith Busch <keith.busch@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
References: <20191025190047.38130-2-stuart.w.hayes@gmail.com>
 <20191127013613.GA233706@google.com>
 <CAL5oW00Lh4v2YpX2GcDoRS2fFJjvHRsdhNjtvyYGpWOpgL=TCg@mail.gmail.com>
Message-ID: <f14d8325-8635-329f-cdc7-fd27a52b2704@gmail.com>
Date:   Tue, 31 Dec 2019 16:06:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL5oW00Lh4v2YpX2GcDoRS2fFJjvHRsdhNjtvyYGpWOpgL=TCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/26/19 8:19 PM, Stuart Hayes wrote:
> On Tue, Nov 26, 2019 at 7:36 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> On Fri, Oct 25, 2019 at 03:00:45PM -0400, Stuart Hayes wrote:
>>> From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>>>
>>> The presence detect state (PDS) is normally a logical or of in-band and
>>> out-of-band presence. As of PCIe 4.0, there is the option to disable
>>> in-band presence so that the PDS bit always reflects the state of the
>>> out-of-band presence.
>>>
>>> The recommendation of the PCIe spec is to disable in-band presence
>>> whenever supported.
>>
>> I think I'm fine with this patch, but I would like to include the
>> specific reference for this recommendation.  If you have it handy, I
>> can just insert it.
>>
> 
> The PCI Express Base Specification Revision 5.0, Version 1.0, in the
> implementation note under Appendix I ("Async Hot-Plug Reference
> Model"), it says "If OOB PD is being used and the associated DSP
> supports In-Band PD Disable, it is recommended that the In-Band PD
> Disable bit be Set, ..."
> 
> 

Is that what you were looking for?  Please let me know if there's anything
else I can do to help.

