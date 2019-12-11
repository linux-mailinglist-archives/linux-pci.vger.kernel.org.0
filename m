Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE4111A022
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2019 01:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfLKAmT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Dec 2019 19:42:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40530 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfLKAmS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Dec 2019 19:42:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so22126115wrn.7
        for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2019 16:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lFD+ZpUZUg+F/jhKcy7lzpD4UDbalN+oHBrx0ip/YJ8=;
        b=KBIno3bxmCp8Rhsi6n2yKbntK2+CFHXTdzNXT5HPgQhilc4J7C0g3Ply5j2V24oOg8
         070qz4e64sUCsKo+9MjzByPyptF5e2xAf3nYcxBk4WFR0d7wmXeev4zFjXOp6mQ+Lrtp
         EutTYBahV8QovIgCtxSMxbJf9VYhs2Of0FkKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lFD+ZpUZUg+F/jhKcy7lzpD4UDbalN+oHBrx0ip/YJ8=;
        b=O6ste8O2lLDGyyD7xPRyXCndFuAixAy+pDMWs3+1rabgv7l1neMVjFOyzeLGRfLXj9
         CnqrSUYY4tghqXYshIrLbZGqzk2dbrzVt5IfYs7XkIHshkaPTG30M/cltWSjDrTIB9YC
         3s0wFC09Nw1OmirjJYa/h208qsMaRS59nhxYRqER/gcrJPLALb70gSl25dfi314Gj7SV
         1S3r+skUS7jbM/72Zi354LljRQkEzxmkMDdYMy8/F5NGYnpkQCOQsT44+cpm06YBqHbi
         LDEJymj3m2B2EGBUSuUcLIPeU3n0Y1PMfeW3t/i4H7cajdWHZNoZJUa6BeiwcV8U2VL+
         Tuvg==
X-Gm-Message-State: APjAAAV9aouh7J0oWxduQ4NQM889tnF1ceeKGyky6GTGwo1itoq6q/2E
        ntMbeqIWT2RAxSdB7BVM6+ZhRA==
X-Google-Smtp-Source: APXvYqxou0+EKhXinbkqy7uL+xIC+3haBqjgcphOGnG+44fK+uMsvLu4a7Oo7Fpw+xny86MnNmnLQA==
X-Received: by 2002:adf:bc4f:: with SMTP id a15mr368260wrh.160.1576024936387;
        Tue, 10 Dec 2019 16:42:16 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id g21sm363306wmh.17.2019.12.10.16.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 16:42:15 -0800 (PST)
Subject: Re: [PATCH] PCI: build Broadcom PAXC quirks unconditionally
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Wei Liu <wei.liu@kernel.org>, linux-pci@vger.kernel.org,
        rjui@broadcom.com
References: <20191211003433.GA182827@google.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <b3af6b99-fc71-dc21-3fcd-807009559165@broadcom.com>
Date:   Tue, 10 Dec 2019 16:42:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191211003433.GA182827@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/10/19 4:34 PM, Bjorn Helgaas wrote:
> On Tue, Dec 10, 2019 at 04:28:47PM -0800, Ray Jui wrote:
>>
>>
>> On 12/10/19 4:09 PM, Bjorn Helgaas wrote:
>>> On Fri, Nov 15, 2019 at 01:58:42PM +0000, Wei Liu wrote:
>>>> CONFIG_PCIE_IPROC_PLATFORM only gets defined when the driver is built
>>>> in.  Removing the ifdef will allow us to build the driver as a module.
>>>>
>>>> Signed-off-by: Wei Liu <wei.liu@kernel.org>
>>>> ---
>>>> Alternatively, we can change the condition to:
>>>>
>>>>     #ifdef CONFIG_PCIE_IPROC_PLATFORM || CONFIG_PCIE_IPROC_PLATFORM_MODULE
>>>> .
>>>>
>>>> I chose to remove the ifdef because that's what other quirks looked like
>>>> in this file.
>>>> ---
>>>>    drivers/pci/quirks.c | 2 --
>>>>    1 file changed, 2 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>> index 320255e5e8f8..cd0e7c18e717 100644
>>>> --- a/drivers/pci/quirks.c
>>>> +++ b/drivers/pci/quirks.c
>>>> @@ -2381,7 +2381,6 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_BROADCOM,
>>>>    			 PCI_DEVICE_ID_TIGON3_5719,
>>>>    			 quirk_brcm_5719_limit_mrrs);
>>>> -#ifdef CONFIG_PCIE_IPROC_PLATFORM
>>>>    static void quirk_paxc_bridge(struct pci_dev *pdev)
>>>>    {
>>>>    	/*
>>>> @@ -2405,7 +2404,6 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, quirk_paxc_bridge);
>>>>    DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, quirk_paxc_bridge);
>>>>    DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, quirk_paxc_bridge);
>>>>    DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, quirk_paxc_bridge);
>>>> -#endif
>>>
>>> Is there a reason this quirk can't be moved to
>>> drivers/pci/controller/pcie-iproc-platform.c?  That would make it much
>>> less subtle because it would be compiled if and only if the driver
>>> itself is compiled.
>>>
>>> If it needs to be here in quirks.c, please include a note about the
>>> reason.
>>
>> There's no particular reason and yes it could be moved to pcie-iproc.c.
>>
>> If that's preferred (and it sounds like it is) then we can do that.
> 
> Yes, please, that would be great!  No #ifdefs, plus the code won't be
> compiled into x86 and other arches that never use that driver.
> 
> Bjorn
> 

Okay, Wei, let me know if you'd like to help with that? If not, I can 
make the change.

Thanks,

Ray
