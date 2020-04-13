Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09D51A66C0
	for <lists+linux-pci@lfdr.de>; Mon, 13 Apr 2020 15:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgDMNIr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Apr 2020 09:08:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48738 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727855AbgDMNIq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Apr 2020 09:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586783325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s9m5bEJM55+CCEjTc3mQmvoxvmzLMIrk5m1SdUE6h/k=;
        b=MnQMaJK6r2zJotLsf6zKzRQoltuyneIEB0QV6PCeAXaZJVVv2M8XOKbhJvRIpl+x871lB3
        KaGthnnXS1HVWiDaUpM2HXskgvPC+wi0L3oKbovrsKPJkwF+37i4OxOx2rOvEWbm6MBi9B
        l25diGuJAIETiTR56EQDZWIcgkQf3gw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-FvGzow3ANGGBOjd8gi109w-1; Mon, 13 Apr 2020 09:08:44 -0400
X-MC-Unique: FvGzow3ANGGBOjd8gi109w-1
Received: by mail-wm1-f70.google.com with SMTP id f128so1011451wmf.8
        for <linux-pci@vger.kernel.org>; Mon, 13 Apr 2020 06:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s9m5bEJM55+CCEjTc3mQmvoxvmzLMIrk5m1SdUE6h/k=;
        b=EaBIgHYgIxHYHeb9qLzH0YVkl8q5JX963cLWUVP0hKlAcaQ2bZSy9dZVncy+rZD/4b
         rBic8bZtWSYweWFE/1A1tbCOL6TkI0siCjJxaxdiq4vc8TLjptWzwIaQOxAhzkr+duFn
         //AUaGwZ2EHwTDSyHafIDLVzJgl/LsavALMxRlO5ZVtRCkcxKuunVrMgv7iYKkiTC5NY
         UgflA13C7H9SJOkzEw1vYdQaWgZMftK/fioxvm1DiPJDlEznSGoKKcgBrS7lJ7TcVMVX
         +6fMnmYz5PsNJVTKYtabQ4TdTIqc+uTCzY0NmCeXUTceubv1wBN3m2DlyiY0UMq2lGf7
         SJdw==
X-Gm-Message-State: AGi0PuZ5xwgXsirqFQicXXaN7dWR4lTLgQFbNoqu6QcBks2kNB+9liB5
        OyhPG7mO99w5IH94qt7bgu1xhwT3XBzaJNvZLnfxshInkIsuEQJ/2FkZzSjxrEWSe0/DOTrMwsN
        //xJloTFaxfVlAFEQobjr
X-Received: by 2002:a5d:522c:: with SMTP id i12mr1051157wra.215.1586783322945;
        Mon, 13 Apr 2020 06:08:42 -0700 (PDT)
X-Google-Smtp-Source: APiQypKJSH7viqtLUiSYWLMN2+J0c6+yVIDg8r4gEnWrO7CZ/ceQ5+EZ5b1PZUTdcQFfUQRJNgizuQ==
X-Received: by 2002:a5d:522c:: with SMTP id i12mr1051139wra.215.1586783322746;
        Mon, 13 Apr 2020 06:08:42 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id e1sm3845350wrc.12.2020.04.13.06.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 06:08:41 -0700 (PDT)
Subject: Re: [PATCH] ACPI/PCI: pci_link: use extended_irq union member when
 setting ext-irq shareable
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20200410194547.GA7293@google.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <abaa91fa-12a4-e273-c983-7d1153dab9a2@redhat.com>
Date:   Mon, 13 Apr 2020 15:08:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200410194547.GA7293@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 4/10/20 9:45 PM, Bjorn Helgaas wrote:
> On Fri, Apr 10, 2020 at 03:14:42PM +0200, Hans de Goede wrote:
>> The case ACPI_RESOURCE_TYPE_EXTENDED_IRQ inside acpi_pci_link_set()
>> is correctly using resource->res.data.extended_irq.foo for most settings,
>> but for the sharable setting it sofar has accidentally been using
>> resource->res.data.irq.shareable instead of
>> resource->res.data.extended_irq.shareable.
>>
>> Note that the old code happens to also work because the sharable field
>> offset is the same for both the acpi_resource_irq and
>> acpi_resource_extended_irq structs.
> 
> s/sharable/shareable/ several times above
> s/sofar/so far/
> 
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks, I'll send out a v2 with the spelling issues in the commit-msg fixed.

Regards,

Hans



> 
>> ---
>>   drivers/acpi/pci_link.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
>> index 00a6da2121be..ed3d2182cf2c 100644
>> --- a/drivers/acpi/pci_link.c
>> +++ b/drivers/acpi/pci_link.c
>> @@ -322,10 +322,10 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
>>   		resource->res.data.extended_irq.polarity =
>>   		    link->irq.polarity;
>>   		if (link->irq.triggering == ACPI_EDGE_SENSITIVE)
>> -			resource->res.data.irq.shareable =
>> +			resource->res.data.extended_irq.shareable =
>>   			    ACPI_EXCLUSIVE;
>>   		else
>> -			resource->res.data.irq.shareable = ACPI_SHARED;
>> +			resource->res.data.extended_irq.shareable = ACPI_SHARED;
> 
> Ouch, looks like that copy/paste error has been there since the
> beginning of git.  Nice catch!
> 
>>   		resource->res.data.extended_irq.interrupt_count = 1;
>>   		resource->res.data.extended_irq.interrupts[0] = irq;
>>   		/* ignore resource_source, it's optional */
>> -- 
>> 2.26.0
>>
> 

