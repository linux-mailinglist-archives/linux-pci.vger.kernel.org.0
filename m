Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F633B8EF5
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 10:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbhGAImN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 04:42:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22461 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235427AbhGAImN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jul 2021 04:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625128783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u9jAbsencUUDdK5AITgRqpk4mB/AMqBStj1da/54uyc=;
        b=f96rBK/TT4CLe0Q34bDYMJ2tHFBcg5r9qNK/eNwZgO5R3Tggat82bH4DFuKrE9pXKlK35z
        VTNVateNQ+qMhXZN3jy2gFT3wWFnPLOQH7peWeeDTM4cksadIIVagLvQv7PyBMOvawutVd
        nASmf6R9qjaGeTNfmoUzzSMxS8VOg3A=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-b1tDIi4lM72DzU9nxhD8hg-1; Thu, 01 Jul 2021 04:39:41 -0400
X-MC-Unique: b1tDIi4lM72DzU9nxhD8hg-1
Received: by mail-ed1-f70.google.com with SMTP id w1-20020a0564022681b0290394cedd8a6aso2664913edd.14
        for <linux-pci@vger.kernel.org>; Thu, 01 Jul 2021 01:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u9jAbsencUUDdK5AITgRqpk4mB/AMqBStj1da/54uyc=;
        b=C73x3Epm4Tk1eHffk4avH+l4knTVdCiyE0bXFwO5YhYXineAb5IHO/PiTm1eYmDOfn
         t5GeQ8qGwNjK7oe3tBalefzWbjsP81lVDWBO+WQh83NXxvgfU7Pvn0IBKApTBH/Fhnoc
         sahtiwQHieWX/sbLGE1whcJG091eYBw7Sc695swFsqOuT7IiVmbWFVMsVNhpjbRQoco2
         JNpnD3yuBVpCSGuLR6RyLLO+7w1ifu++XTbwHWX+Wanql4EGh6aA4L48iIC/Cw3x2+J5
         K/6eU2yPx/R7Ovy91BtWoVkjvtIaTNVAzzzjEtJY9cODZBD8s6FUePzv3XeZxivKH7ZQ
         eOHw==
X-Gm-Message-State: AOAM531CxzMS0oiUuT3Zx+6Eq2kNHR9w3vLH2pXTbnHFTISCI62CXChQ
        Wc2YRBECMUK2Y/qTu9rIqw1tQtJcYhj8AfzNann844P4kk6YIzmOqwTEclhO8EP8sz2pww4Qktt
        rySB3mS3G8q1EaVJtLKYU
X-Received: by 2002:a05:6402:176f:: with SMTP id da15mr51597389edb.334.1625128780803;
        Thu, 01 Jul 2021 01:39:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjM9KkxtshOjO1NdUjE9y5FxAxm9cYgDU4y0IKWEB3WTjlpt1wyNiLoAcJdRJ2Lm+4zJaUzQ==
X-Received: by 2002:a05:6402:176f:: with SMTP id da15mr51597374edb.334.1625128780670;
        Thu, 01 Jul 2021 01:39:40 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id q5sm10322484ejc.117.2021.07.01.01.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 01:39:40 -0700 (PDT)
Subject: Re: [PATCH 2/4] MFD: intel_pmt: Remove OOBMSM device
To:     david.e.box@linux.intel.com, Lee Jones <lee.jones@linaro.org>
Cc:     mgross@linux.intel.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20210617215408.1412409-1-david.e.box@linux.intel.com>
 <20210617215408.1412409-3-david.e.box@linux.intel.com>
 <YNxENGGctLXmifzj@dell>
 <f590ee871d0527a12b307f1494cb4c8a91c5e3c2.camel@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e734a968-818a-380d-0ae5-fee41b3db246@redhat.com>
Date:   Thu, 1 Jul 2021 10:39:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f590ee871d0527a12b307f1494cb4c8a91c5e3c2.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 6/30/21 11:11 PM, David E. Box wrote:
> On Wed, 2021-06-30 at 11:15 +0100, Lee Jones wrote:
>> On Thu, 17 Jun 2021, David E. Box wrote:
>>
>>> Unlike the other devices in intel_pmt, the Out of Band Management
>>> Services
>>> Module (OOBMSM) is actually not a PMT dedicated device. It can also
>>> be used
>>> to describe non-PMT capabilities. Like PMT, these capabilities are
>>> also
>>> enumerated using PCIe Vendor Specific registers in config space. In
>>> order
>>> to better support these devices without the confusion of a
>>> dependency on
>>> MFD_INTEL_PMT, remove the OOBMSM device from intel_pmt so that it
>>> can be
>>> later placed in its own driver. Since much of the same code will be
>>> used by
>>> intel_pmt and the new driver, create a new file with symbols to be
>>> used by
>>> both.
>>>
>>> While performing this split we need to also handle the creation of
>>> platform
>>> devices for the non-PMT capabilities. Currently PMT devices are
>>> named by
>>> their capability (e.g. pmt_telemetry). Instead, generically name
>>> them by
>>> their capability ID (e.g. intel_extnd_cap_2). This allows the IDs
>>> to be
>>> created automatically.  However, to ensure that unsupported devices
>>> aren't
>>> created, use an allow list to specify supported capabilities.
>>>
>>> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
>>> ---
>>>  MAINTAINERS                                |   1 +
>>>  drivers/mfd/Kconfig                        |   4 +
>>>  drivers/mfd/Makefile                       |   1 +
>>>  drivers/mfd/intel_extended_caps.c          | 208
>>> +++++++++++++++++++++
>>
>> Please consider moving this <whatever this is> out to either
>> drivers/pci or drivers/platform/x86.
> 
> None of the cell drivers are in MFD, only the PCI drivers from which
> the cells are created. I understood that these should be in MFD. But
> moving it to drivers/platform/x86 would be fine with me. That keeps the
> code together in the same subsystem. Comment from Hans or Andy? 

I'm fine with moving everything to drivers/platform/x86, but AFAIK
usually the actual code which has the MFD cells and creates the
child devices usually lives under drivers/mfd

Regards,

Hans



> 
>>
>> I suggest Andy should also be on Cc.
>>
>>>  drivers/mfd/intel_extended_caps.h          |  40 ++++
>>>  drivers/mfd/intel_pmt.c                    | 198 ++---------------
>>> ---
>>>  drivers/platform/x86/intel_pmt_crashlog.c  |   2 +-
>>>  drivers/platform/x86/intel_pmt_telemetry.c |   2 +-
>>>  8 files changed, 270 insertions(+), 186 deletions(-)
>>>  create mode 100644 drivers/mfd/intel_extended_caps.c
>>>  create mode 100644 drivers/mfd/intel_extended_caps.h
>>
> 
> 

