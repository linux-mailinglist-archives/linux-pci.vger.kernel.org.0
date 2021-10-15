Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B7842EA9E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 09:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbhJOHzd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 03:55:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60162 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229686AbhJOHz3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 03:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634284402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WSCdihYmmS0IN1GmuVO1Ycrr/Th2rhDypmITMXSUWgM=;
        b=gyYvNvWquL5ckRL2C5AnQL4CpQ1rAuDDRs1O0F0dv3ylrvUdxCQYt5JxnY3kfUkIeCufe/
        gbfJKL/c2Gb7Q6an3YuHbVoxKH5IWqF0T6Z3iaeXMJ2D0E5xQPjE3j0KuNGc/q0tbuF/ZT
        w6npF8ljPMGHHZFpiJid5ECLN3FAFHs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-L2kUOFQ6NLaBHl3L-V3Svg-1; Fri, 15 Oct 2021 03:53:21 -0400
X-MC-Unique: L2kUOFQ6NLaBHl3L-V3Svg-1
Received: by mail-ed1-f72.google.com with SMTP id u17-20020a50d511000000b003daa3828c13so7461886edi.12
        for <linux-pci@vger.kernel.org>; Fri, 15 Oct 2021 00:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WSCdihYmmS0IN1GmuVO1Ycrr/Th2rhDypmITMXSUWgM=;
        b=j3tU4lRSJ7u2DfWq9YAVZSmUb70/fgrQTjis7206j5Mg4ejr9jYpV78fH7DEt/kXKI
         q+iHm1nJFkAE4fwkmQuiSToYNtKSutVcMRvc8Vm4kExPpSsRhMPWk4+f5Hh9uRNs2qxH
         VHEqYW/pksA9At0+fqnEbX57EGxns8+ygDQ1Go4jZavzujnFuA/5Xrtr84kBYvLo/g4M
         u4+vxFAZC6+45sTb8BYYXo9QuYPq4suhomaOHpTHPsQXyq0+zHkXMA5jKxMaAh5cqSpH
         Ow5zEvWuFfZukDJvCivsKa1PyMAjVndhjueNA+nuyFHy8I0k+F7BuavTBLOnW2+FjyVk
         +uIw==
X-Gm-Message-State: AOAM5330uZQ4PtB+/MfbJh+faBw17tT2iL5xT3iSZR9BroVpNZ5OqVZH
        9yN1KLx3br0g6X64gvlDSQdPINxyT2zkotSEfGIq3mPMY83hnpDfARqbbiX9VDXzMoy2sRAqlPN
        jTU0GJRJE9zXYIUev8ugG
X-Received: by 2002:a50:da4e:: with SMTP id a14mr15561994edk.154.1634284400315;
        Fri, 15 Oct 2021 00:53:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKwzRN7rZPYuvP0ikraKZR0NQIEUYRQJlDmLs7FqK/noKjG07rVbr2fRTQwVGXutgUYCgiRA==
X-Received: by 2002:a50:da4e:: with SMTP id a14mr15561982edk.154.1634284400178;
        Fri, 15 Oct 2021 00:53:20 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id a9sm4080539edr.96.2021.10.15.00.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 00:53:19 -0700 (PDT)
Subject: Re: [PATCH v4 0/1] x86/PCI: Ignore E820 reservations for bridge
 windows on newer systems
To:     Bjorn Helgaas <helgaas@kernel.org>
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
        linux-kernel@vger.kernel.org
References: <20211014211104.GA2048701@bhelgaas>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8761ccf4-ee6a-348e-0d9f-531adc5dd73a@redhat.com>
Date:   Fri, 15 Oct 2021 09:53:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211014211104.GA2048701@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 10/14/21 11:11 PM, Bjorn Helgaas wrote:
> On Thu, Oct 14, 2021 at 05:39:07PM +0200, Hans de Goede wrote:
>> Hi All,
>>
>> Here is v4 of my patch to address the E820 reservations vs PCI host bridge
>> ranges issue which are causing touchpad and/or thunderbolt issues on many
>> different laptop models.
>>
>> I believe that this is ready for merging now.
>>
>> Bjorn, can you review/ack this please ?
>>
>> x86/tip folks it would be ideal if you can pick this up and send it out
>> as a fix to Linus for 5.15. This fixes a bug which has been plaguing a
>> lot of users (see all the bug links in the commit msg).
> 
> FWIW, I think there's a v5 coming.

Yes I posted a v5 yesterday evening (CEST).

Regards,

Hans

