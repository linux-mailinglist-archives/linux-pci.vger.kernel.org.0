Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A2542DE08
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 17:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbhJNP0X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 11:26:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52812 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231161AbhJNP0W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Oct 2021 11:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634225057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dD5eJKWl6u8Q3eVDhZmh0TWejBpBRiryD3uLwCemlOQ=;
        b=QUHow9nyufPF1VYKDNcAcNYLqCnFsV5bePH7zYdfJeWPvz1kO0OANdAsr0FwRtUTPWtgve
        Cwfmrp686zHPOyBuRajUO4wORLGvMCyI2Xf+KXJweElGtGpPlmIS9WnIjD+vq8wmz/aXTn
        F/co76bw2zJERpI/v65WFZfoZp/RUKQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-ldP0E2SbNjuLHVitpXBQjQ-1; Thu, 14 Oct 2021 11:24:15 -0400
X-MC-Unique: ldP0E2SbNjuLHVitpXBQjQ-1
Received: by mail-ed1-f71.google.com with SMTP id c25-20020a056402143900b003dc19782ea8so1960785edx.3
        for <linux-pci@vger.kernel.org>; Thu, 14 Oct 2021 08:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dD5eJKWl6u8Q3eVDhZmh0TWejBpBRiryD3uLwCemlOQ=;
        b=sFZlPfoUAwBWnUwJ771PpyW3eCTUSEGUHQQ7qzisC6/mGICWojwZpKP8eC15fJJdzq
         TzzaIqZ21TG8NA5bA5Zg8+QwRYPxYo/Lrnh/5SNizZhe76QRQ3R0zCLXczU7hlQVYMzp
         R2EfABvQ6tVOf0cBuvFQbtRrtAqjLbvw48j8lbUdFppepE6VqDc64aWr6t+NmztCuJIX
         3dK7XxJoHjFQIzs4qdIgMrXnp9Sdm+gjs2fgATa1+PsGG6Pui7cQ7BjBwTHYC1rYWS+W
         yHknHHSCik/XaBM+sOcfi8mCrsnHHDhC6oA3oyBjnR6Wzty9N0xJVkthz3990SvT4IX9
         kTuA==
X-Gm-Message-State: AOAM5315Ank3wADx9BmvUGHOPPjGk/TZEv9c7dlJ7Onkw5wcnWRG6DI7
        Oyhkaj2XpamMq0pK7fSlsj23MKJw+2Zcj2SEE4g0naTR+T1po/RvPxiR4S1e0rj2lTRQBNCNhjM
        DeBvHLJooQxVhkA5vevmE
X-Received: by 2002:a05:6402:5252:: with SMTP id t18mr9266732edd.129.1634225054520;
        Thu, 14 Oct 2021 08:24:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz90txXkiw/a/Ag6xrnNLNCQ9RzFwBreiI35q+8iDdAryAu9rkiWD6hDaMbYYbCdJm+Lo51dw==
X-Received: by 2002:a05:6402:5252:: with SMTP id t18mr9266713edd.129.1634225054375;
        Thu, 14 Oct 2021 08:24:14 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id y22sm2870813edc.76.2021.10.14.08.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 08:24:14 -0700 (PDT)
Subject: Re: [PATCH v3] x86/PCI: Ignore E820 reservations for bridge windows
 on newer systems
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>
References: <20211014110357.17957-1-hdegoede@redhat.com>
 <YWgzaa9Z4elzoRwL@infradead.org>
 <40549939-e4c2-7b20-6bb6-0b5a46731b1c@redhat.com>
 <YWhJ2kmGzNMVY+cP@infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <77705ec1-eaf9-efc1-79db-c2c1c03abe65@redhat.com>
Date:   Thu, 14 Oct 2021 17:24:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YWhJ2kmGzNMVY+cP@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 10/14/21 5:16 PM, Christoph Hellwig wrote:
> On Thu, Oct 14, 2021 at 05:15:02PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 10/14/21 3:40 PM, Christoph Hellwig wrote:
>>> On Thu, Oct 14, 2021 at 01:03:57PM +0200, Hans de Goede wrote:
>>>> +	 * Some BIOS-es contain a bug where they add addresses which map to system
>>>> +	 * RAM in the PCI bridge memory window returned by the ACPI _CRS method,
>>>
>>> Please avoid the overly long lines in your comments.
>>
>> ?
>>
>> These lines are easily within the new 100 char line-length-limit ?
> 
> That is an exceptional limit if exceeding 80 improves readability for
> individual lines.

Ok, I'll send out a v4 adjusting the comment-block to fit in 80 columns.

Regards,

Hans

