Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA92842C8D6
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 20:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhJMSkN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 14:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhJMSkL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Oct 2021 14:40:11 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854C1C061570
        for <linux-pci@vger.kernel.org>; Wed, 13 Oct 2021 11:38:07 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t2so11424891wrb.8
        for <linux-pci@vger.kernel.org>; Wed, 13 Oct 2021 11:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=+/k2nmajgir53r0pC3X+KB480jRvURLn6mgnm3pa/RE=;
        b=a8ZI+c/w9I71P14jQCujgT/J76zW4b2aP6AHaM95aPrFFqVpKDNAECGSIXF+yfoSlR
         AchTeVuXFOQUIGLa8Y6yAk15ux2B/PxMajwy4fNt95lauXkoMPq/C47FUKRk98zBz6Pw
         HJFOFWfvXNDffQndXlRTBvFkdjY2NLilVC6oEuMI4fUSS/flP+bUcTNAB4Sdb3lN9rYe
         XGZAhqQ2bDAhvIPFKK3PPOkSisBqQXR1PFOKF9Xe3uT5JyVHQU85MugNhT2ihNq6SsLn
         gicS8EFk5ZBqLEIevVb5d8AVQpRet3Whi83sa+h61s0Aawx+wKEp7a+11VCZ7b6sH2sr
         B51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=+/k2nmajgir53r0pC3X+KB480jRvURLn6mgnm3pa/RE=;
        b=ccG8gokPnTubDJ3UkW7XAJUP8Ef+L40wTXNBHPZnysgSS+zMplFYAyek6cTJFh3I9S
         5CKDtUGgdgdlfKHIReLjv01dxoQ2yJ4eo4wVwpgVYHN60dZyNsKPExbGHxXJJSCfm332
         C4QMMqgXlIFFFgTXIh2WFUqD+7FcVh8KdeAvrfUql7eKCF4K3a87QpqLa2Q8NC/9PyIz
         Rc77k2PYJBjLseUw0fs5KsgyLuttb6xJE0ANj9mqxw+ZoODiaTyhe5IrIX9FJA02WdOF
         76sLpw6aNaCy1CSEhcrbIbS6s6VdADYy0H6IK9MgJGp5o2fvXRG2RUucaWKN9LgDyy0l
         EYbQ==
X-Gm-Message-State: AOAM531oHAWCAIvZJ1eFcjaegPPSO+W2RtgEJZkbhjlspADPTGTCgzJ9
        iagTwlc3DncVauZRkviKAeA=
X-Google-Smtp-Source: ABdhPJwXKQQzrZvyS9FxK2at35Rj9vNQ434jeKI2YPovGu8IfNwoGhBRNx+KxYKoB0JL50Mq0FQdAg==
X-Received: by 2002:a05:600c:4fd1:: with SMTP id o17mr14909578wmq.110.1634150286132;
        Wed, 13 Oct 2021 11:38:06 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f22:fa00:49bd:5329:15d2:9218? (p200300ea8f22fa0049bd532915d29218.dip0.t-ipconnect.de. [2003:ea:8f22:fa00:49bd:5329:15d2:9218])
        by smtp.googlemail.com with ESMTPSA id 10sm2273249wme.27.2021.10.13.11.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 11:38:05 -0700 (PDT)
Message-ID: <aaee416c-de56-9bf4-1814-9df0acf1a84c@gmail.com>
Date:   Wed, 13 Oct 2021 20:30:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <135abde5-dc5b-826e-e20d-0f53bf32d2dc@gmail.com>
 <20210917135342.GB1518947@rocinante>
 <371af84d-a709-074e-5424-1870eb1c460c@gmail.com> <YVJFrI2PIRkvMich@rocinante>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] PCI/VPD: Add simple sanity check to pci_vpd_size()
In-Reply-To: <YVJFrI2PIRkvMich@rocinante>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28.09.2021 00:29, Krzysztof Wilczyński wrote:
> Hi Heiner,
> 
>>> [...]
>>>> Instead let's add a simple sanity check on the number of found tags.
>>>> A VPD image conforming to the PCI spec can have max. 4 tags:
>>>> id string, ro section, rw section, end tag.
>>>
>>> It's always nice to check if something is compliant with the specification.
>>>
>>> Would you be able to either cite this part of the official specification or
>>> mention where to find it?  Like we do in other such changes related to some
>>> official standards, mainly for posterity to benefit others that might look
>>> at this commit in the future.
>>>
>> Right, I should have mentioned that:
>> PCI 3.0 I.3.1. VPD Large and Small Resource Data Tags
> 
> Very nice!  Do you have plans to send v2 that include this information or
> you reckon this is something Bjorn could add when merging if he has the
> time, of course.
> 
Back from vacation .. I'll send a v2.

>>> [...]
>>>> +		/* We can have max 4 tags: STRING_ID, RO, RW, END */
>>>> +		if (++num_tags > 4)
>>>> +			goto error;
>>>
>>> Do we want to let someone know that their device (or a device they might
>>> have in the system) has non-compliant and/or malformed VPD which is why we
>>> decided to return an error?  I wonder if this would help with
>>> troubleshooting or just simply had some informative value.  So perhaps
>>> a warning or debug level message?  What do you think?
>>>
>> A message is printed, see code after error label.  We differentiate
>> between "hard" and "soft" error. Soft error here means that the VPD EEPROM
>> is optional, in such a case it's not an actual error that the VPD reads
>> return non-VPD data.
> 
> Got it.  Thank you!
> 
> I had a look and, does the following:
> 
> 	pci_info(dev, "invalid VPD tag %#04x (size %zu) at offset %zu%s\n",
> 		 header[0], size, off, off == 0 ?
> 		 "; assume missing optional EEPROM" : "");
> 
> Still apply to having too many tags?  Would the error make sense?  Forgive
> me for asking about this, especially as I am not a VPD expert, and was
> simply wondering.
> 
The message still is applicable, just that the tag now is invalid in a
different sense.

> Also, does pci_info() there makes sense?  Not pci_warn() or pci_err(), just
> so this message has more appropriate weight and logging level.  What do you
> think?
> 
Only impact typically is that the vpd sysfs attribute isn't available.
Userspace applications like lspci can deal with this and simply report
"can't read vpd". I doubt that it's worth it to add more complexity here.

>>> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> 
> 	Krzysztof
> 

Heiner
