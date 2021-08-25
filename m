Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E1A3F7A70
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 18:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhHYQYr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 12:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhHYQYr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Aug 2021 12:24:47 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC0FC061757;
        Wed, 25 Aug 2021 09:24:00 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id qe12-20020a17090b4f8c00b00179321cbae7so196279pjb.2;
        Wed, 25 Aug 2021 09:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uE3J8XQoOGr0ebXuCoHJ9Ffm9rvxHwZfnIkLXfJVSo4=;
        b=sdvJCmILzHOSTUhdFGCbYlzRnuovYxN1Z1w8Xi0YKdkPqZn9RaMMiq2pLK/M5pLJxV
         5Idix/UO0RERCkIHyiVhqthJUyHbpuw3CQfSLSixr8ZeUG7xlBAm3kwOM+LiFpMKlWTm
         UPE2jVcU2Q+HPa3yAZxwCMYf5kYUjn3SkbbWlkMCgWkeBeimHdCoaCJM8uJdp7C6+Ts0
         lTBFUu/mdGYdcxXlTFudrfAdMTeK/WepQZvT7Oj34VtShZUNrO0FgJa6S5jFALdRx+dM
         Jl9GAiAyE75o7kZmqWu4lmIS/jLKRapj7TctiRZo+TWOpR+q/sgkBhJz5ktESgLK/VzU
         xw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uE3J8XQoOGr0ebXuCoHJ9Ffm9rvxHwZfnIkLXfJVSo4=;
        b=kcz0XJivSc6AFTvDIRAxfowtSFS3tgt2e8KcrSus37A+fpOeq7dV3zlJ+FI6JU0+67
         sz6OpZaTUhSLqESRD8CqsSzHstXakUwKzri26GCHmLCg0knLdyr+cerpLaC0nkMFWO23
         aXEwOeCB9QOu6uNYHlhZzrIaKp+ybplPPGDaYh6w7NmRcIvq7qA827duy4LYMuKnuR3D
         Q29payyebEWeypKCUBBdWi/KuRhrm35Ddl7TKWDpoUkP0Om0tts3ZNc2RwWZrUpyiMLX
         CsHVhg+IFW27e2cyrTeWKyaNTCgr105I1uKxiZmSpE15DemPaeOSPod6h4T9un/sEPPF
         IQpA==
X-Gm-Message-State: AOAM533ntvDFDYUgCzrmNLhkjKUxzsEhJtaEXFocnWA9odfJsghsgtrP
        e2BfWmC9ORuAaMZPAe1UeIE=
X-Google-Smtp-Source: ABdhPJw4or/kJhUyzwtXF1xhp2MI7DcbP5ad8eWFOmCpqQqVK8l9X+ehU0dZdCphnqZ78TN7B+WCww==
X-Received: by 2002:a17:90a:d686:: with SMTP id x6mr11481460pju.227.1629908640380;
        Wed, 25 Aug 2021 09:24:00 -0700 (PDT)
Received: from [10.230.31.46] ([192.19.223.252])
        by smtp.gmail.com with UTF8SMTPSA id u21sm252802pfh.163.2021.08.25.09.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 09:23:59 -0700 (PDT)
Message-ID: <0f21622f-2651-d1ca-7b47-4a3060a9539c@gmail.com>
Date:   Wed, 25 Aug 2021 18:23:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.2
Subject: Re: [PATCH v2 3/4] PCI/ACPI: Add Broadcom bcm2711 MCFG quirk
Content-Language: en-US
To:     Jeremy Linton <jeremy.linton@arm.com>, linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, nsaenz@kernel.org, bhelgaas@google.com,
        rjw@rjwysocki.net, lenb@kernel.org, robh@kernel.org, kw@linux.com,
        sdonthineni@nvidia.com, stefan.wahren@i2se.com,
        bcm-kernel-feedback-list@broadcom.com, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210819215655.84866-1-jeremy.linton@arm.com>
 <20210819215655.84866-4-jeremy.linton@arm.com>
 <9796674a-5870-135c-2fdc-fb0d5347d7c7@gmail.com>
 <ddffee4b-8136-9ca1-85f7-bfdbac07bfe7@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <ddffee4b-8136-9ca1-85f7-bfdbac07bfe7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/24/2021 11:39 PM, Jeremy Linton wrote:
> Hi,
> 
> On 8/22/21 3:53 AM, Florian Fainelli wrote:
>>
>>
>> On 8/19/2021 11:56 PM, Jeremy Linton wrote:
>>> Now that there is a bcm2711 quirk, it needs to be enabled when the
>>> MCFG is missing. Use an ACPI namespace _DSD property
>>> "linux-ecam-quirk-id" as an alternative to the MCFG OEM.
>>>
>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>> ---
>>>   drivers/acpi/pci_mcfg.c | 13 +++++++++++++
>>>   1 file changed, 13 insertions(+)
>>>
>>> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
>>> index 53cab975f612..4b991ee5c66c 100644
>>> --- a/drivers/acpi/pci_mcfg.c
>>> +++ b/drivers/acpi/pci_mcfg.c
>>> @@ -169,6 +169,9 @@ static struct mcfg_fixup mcfg_quirks[] = {
>>>       ALTRA_ECAM_QUIRK(1, 13),
>>>       ALTRA_ECAM_QUIRK(1, 14),
>>>       ALTRA_ECAM_QUIRK(1, 15),
>>> +
>>> +    { "bcm2711", "", 0, 0, MCFG_BUS_ANY, &bcm2711_pcie_ops,
>>> +      DEFINE_RES_MEM(0xFD500000, 0xA000) },
>>>   };
>>>   static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
>>> @@ -198,8 +201,18 @@ static void pci_mcfg_apply_quirks(struct 
>>> acpi_pci_root *root,
>>>       u16 segment = root->segment;
>>>       struct resource *bus_range = &root->secondary;
>>>       struct mcfg_fixup *f;
>>> +    const char *soc;
>>>       int i;
>>> +    /*
>>> +     * This may be a machine with a PCI/SMC conduit, which means it 
>>> doesn't
>>> +     * have an MCFG. Use an ACPI namespace definition instead.
>>> +     */
>>> +    if (!fwnode_property_read_string(acpi_fwnode_handle(root->device),
>>> +                     "linux-ecam-quirk-id", &soc)) {
>>> +        memcpy(mcfg_oem_id, soc, ACPI_OEM_ID_SIZE);
>>
>> Being super paranoid here, can we use one of the "safe" string copy 
>> routines here just in case?
> 
> Hmm, I went around with this a bit when I first wrote it, because the 
> OEM fields in the ACPI tables are fixed len and don't have null 
> termination. Maybe the right thing to do here is verify the string size 
> is at least as long as the OEM_ID_SIZE and then continue to use the memcpy.

Sure, sounds entirely reasonable to me.
-- 
Florian
