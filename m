Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3E0FAADB4
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 23:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388359AbfIEVQL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 17:16:11 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35918 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfIEVQK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 17:16:10 -0400
Received: by mail-ed1-f68.google.com with SMTP id g24so4275170edu.3;
        Thu, 05 Sep 2019 14:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ke7ZiPqKDeHvlrOFd98Cv/8z7gFqetiE/M/oVJxGJv8=;
        b=Nz21zDiPk1fH/DW15Q2R1V1IEkIvjk7dw3bLBTuwOY6qlkDW5O8rOONi9bGtaeCBbD
         4tpVsWSE+QFnuZXoSJDePNyb+LORYtbGc3rMGVyFuW+9cmCnTmL577qUciD18aYC2SvQ
         jc+SRjWRo0KW8I7RW6yrYK7ywP6FEm0b6LP/xV3mwOsOVEuYKjARvfj7xydO4CY4BmZN
         WoK5zEqJhhujko1NCZCBtelpxVnI96RziJWGftgeZAd/OV71xqN1ZNPlYqC6kCHRGP0c
         JhLhb0DqL9WQge7O3fZLqdLHzdM73pOkWhh8SMq5bU24DVl8VWMHk8YLm1vJ3Ev9A6nW
         Fbag==
X-Gm-Message-State: APjAAAU3l+FR4wKnrb/aVpMbvgoY3RnON70eE7D6uLlGHKuUzS8BctWv
        5JapVvRJXXGQbaYoiVPZdX64+TxiO4U=
X-Google-Smtp-Source: APXvYqxOuRTdfEcN5G+oqBahkGBcnt2M2uKQnJ013r2UU5HDk85O8jrPzFGaRykws6WjTWilnv8NGQ==
X-Received: by 2002:a50:c10a:: with SMTP id l10mr6045903edf.79.1567718168828;
        Thu, 05 Sep 2019 14:16:08 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.gmail.com with ESMTPSA id f23sm568892edd.39.2019.09.05.14.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2019 14:16:08 -0700 (PDT)
Subject: Re: [PATCH v4 0/4] Simplify PCIe hotplug indicator control
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20190903111021.1559-1-efremov@linux.com>
 <20190905210102.GG103977@google.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <3e5cbc0f-ca9f-bbbe-5486-05915fe4ec63@linux.com>
Date:   Fri, 6 Sep 2019 00:16:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190905210102.GG103977@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 06.09.2019 00:01, Bjorn Helgaas wrote:
> On Tue, Sep 03, 2019 at 02:10:17PM +0300, Denis Efremov wrote:
>> PCIe defines two optional hotplug indicators: a Power indicator and an
>> Attention indicator. Both are controlled by the same register, and each
>> can be on, off or blinking. The current interfaces
>> (pciehp_green_led_{on,off,blink}() and pciehp_set_attention_status()) are
>> non-uniform and require two register writes in many cases where we could
>> do one.
>>
>> This patchset introduces the new function pciehp_set_indicators(). It
>> allows one to set two indicators with a single register write. All
>> calls to previous interfaces (pciehp_green_led_* and
>> pciehp_set_attention_status()) are replaced with a new one. Thus,
>> the amount of duplicated code for setting indicators is reduced.
>>
>> Changes in v4:
>>   - Changed the inputs validation in pciehp_set_indicators()
>>   - Moved PCI_EXP_SLTCTL_ATTN_IND_NONE, PCI_EXP_SLTCTL_PWR_IND_NONE
>>     to drivers/pci/hotplug/pciehp.h and set to -1 for not interfering
>>     with reserved values in the PCIe Base spec
>>   - Added set_power_indicator define
>>
>> Changes in v3:
>>   - Changed pciehp_set_indicators() to work with existing
>>     PCI_EXP_SLTCTL_* macros
>>   - Reworked the inputs validation in pciehp_set_indicators()
>>   - Removed pciehp_set_attention_status() and pciehp_green_led_*()
>>     completely
>>
>> Denis Efremov (4):
>>   PCI: pciehp: Add pciehp_set_indicators() to jointly set LED indicators
>>   PCI: pciehp: Switch LED indicators with a single write
>>   PCI: pciehp: Remove pciehp_set_attention_status()
>>   PCI: pciehp: Remove pciehp_green_led_{on,off,blink}()
>>
>>  drivers/pci/hotplug/pciehp.h      | 12 ++++--
>>  drivers/pci/hotplug/pciehp_core.c |  7 ++-
>>  drivers/pci/hotplug/pciehp_ctrl.c | 26 +++++------
>>  drivers/pci/hotplug/pciehp_hpc.c  | 72 +++++++------------------------
>>  include/uapi/linux/pci_regs.h     |  1 +
>>  5 files changed, 45 insertions(+), 73 deletions(-)
> 
> Thanks, Denis, I applied these to pci/pciehp for v5.4.  I think this
> is a great improvement.
> 
> I tweaked a few things:
> 
>   - Updated comments to refer to "Power" intead of "green",
>     "Attention" instead of "amber", and "Indicator" instead of "LED".
> 
>   - Replaced PCI_EXP_SLTCTL_ATTN_IND_NONE and
>     PCI_EXP_SLTCTL_PWR_IND_NONE with INDICATOR_NOOP because I didn't
>     want them to look like definitions from the spec.
> 
>   - Dropped set_power_indicator().  It does make things locally easier
>     to read, but I think the overall benefit of having fewer
>     interfaces outweighs that.
> 
> The interdiff from your v4 is below.  Let me know if I broke anything.

Thank you for the improvements. Looks good to me.

Regards,
Denis
