Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B45651A852
	for <lists+linux-pci@lfdr.de>; Wed,  4 May 2022 19:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355527AbiEDRK0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 May 2022 13:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357169AbiEDRKA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2022 13:10:00 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FC44924D
        for <linux-pci@vger.kernel.org>; Wed,  4 May 2022 09:57:06 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 1-20020a05600c248100b00393fbf11a05so3583616wms.3
        for <linux-pci@vger.kernel.org>; Wed, 04 May 2022 09:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CzFQdBAVymLNDuNAsoBhl3Tfx7wzWa0NoFyiQoVzgrY=;
        b=H4+JoY1Lspd2eWdgO1EYeeW+Uf284/fO3PrmxoT5pOYeCN4pIFVYjnZEgZ62p1IIzw
         yWk6XaXkv2Vyd/+WEdejfYngfqBUCPUwaEBcsMy9WK8WRkqoXbhQkVGjR2x1dvqWZC9b
         OPFsnLNhQBUGys9bqgQ67ojeZy7Cl4i0M+e1QNznLTJllJ2qDVsKBad/u1mvDqXSg9d8
         JNgAmCY04mGoCE2WZJ9+2fTAkntjcDI0lDS19b12ZxHuctJPkZZ1bS5tIGd9o+gJTEPU
         2j8g8KelxSRxGo9pgSf9enCA0BpkqH45NaGaJcqDCXC3Hr4gENWw+xGAXN2dfIEEHtTf
         XFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CzFQdBAVymLNDuNAsoBhl3Tfx7wzWa0NoFyiQoVzgrY=;
        b=rtxo2djmC/rXt8XF1GyQoccXxNJtc/7fNgfeej9I2hgB8SIf2QqlztqvcUF0VjwRy7
         aeoQ3+WEGkSa/m4nh8Xqz6Iosw5o5mTbyO3TmbW7uMYVVIaWwd/D01rbDm8Wr2+t4cGE
         ceYIWY599oHfkzIVU5V3F9vL351Yt6RGfR511WWGW+GQeg5G8ltNnPwKy3SJ4/4qeisj
         JMJtwdFTHYM3COan0Hja2uEHvehE1VeN5seq9Lt8sjzWD/JAwmd3x5ISTgpHdf4XsyYX
         PVl9B90ZvDHxNfLRUOhI9TnJntNPBVnRofy4/Uev1HnFNaWd6c4ZT5mdAWxfx64jQY3e
         tgOQ==
X-Gm-Message-State: AOAM531kavBVddFWPnl1L9QJmK9qVVEHeZ5GzGxYFaJ+Gl5PMvF4m70m
        18R+hIxVDNFqEaDmevXnONi5aw==
X-Google-Smtp-Source: ABdhPJzC0r3IdSMa44UgYEJ96l1ndGUDAmyh8akegbtuibHbHpEGMqr2tAlgB7dVnducaXTvi4yeDQ==
X-Received: by 2002:a1c:a101:0:b0:392:942f:3aa with SMTP id k1-20020a1ca101000000b00392942f03aamr278174wme.1.1651683425395;
        Wed, 04 May 2022 09:57:05 -0700 (PDT)
Received: from [192.168.2.222] ([109.77.36.132])
        by smtp.gmail.com with ESMTPSA id l184-20020a1c25c1000000b003943558a976sm4112947wml.29.2022.05.04.09.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 09:57:04 -0700 (PDT)
Message-ID: <3257dbdc-1f96-3baa-426d-9e834327dd21@conchuod.ie>
Date:   Wed, 4 May 2022 17:57:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RESEND PATCH v1 1/1] PCI: microchip: Fix potential race in
 interrupt handling
Content-Language: en-US
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Conor.Dooley@microchip.com, Daire.McNamara@microchip.com,
        bhelgaas@google.com, Cyril.Jean@microchip.com,
        david.abdurachmanov@gmail.com, linux-pci@vger.kernel.org,
        robh@kernel.org
References: <20220502192223.GA319570@bhelgaas>
 <199f5479-b212-e1ac-f9e4-d5d13708cb0c@conchuod.ie>
 <20220504165307.GA19115@lpieralisi>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <20220504165307.GA19115@lpieralisi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 04/05/2022 17:53, Lorenzo Pieralisi wrote:
> On Wed, May 04, 2022 at 04:12:39PM +0100, Conor Dooley wrote:
>> On 02/05/2022 20:22, Bjorn Helgaas wrote:
>>> On Sat, Apr 30, 2022 at 12:33:51AM +0100, Marc Zyngier wrote:
>>>> On Fri, 29 Apr 2022 22:57:33 +0100,
>>>> Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>> On Fri, Apr 29, 2022 at 09:42:52AM +0000, Conor.Dooley@microchip.com wrote:
>>>>>> On 28/04/2022 10:29, Lorenzo Pieralisi wrote:
>>>>>>> On Tue, Apr 05, 2022 at 12:17:51PM +0100, daire.mcnamara@microchip.com wrote:
>>>>>>>> From: Daire McNamara <daire.mcnamara@microchip.com>
>>>>>>>>
>>>>>>>> Clear MSI bit in ISTATUS register after reading it before
>>>>>>>> handling individual MSI bits
>>>
>>>>>> Clear the MSI bit in ISTATUS register after reading it, but before
>>>>>> reading and handling individual MSI bits from the IMSI register.
>>>>>> This avoids a potential race where new MSI bits may be set on the
>>>>>> IMSI register after it was read and be missed when the MSI bit in
>>>>>> the ISTATUS register is cleared.
>>>
>>>>> Honestly, I don't understand enough about IRQs to determine whether
>>>>> this is a correct fix.  Hopefully Marc will chime in.  All I really
>>>>> know how to do is compare all the drivers and see which ones don't fit
>>>>> the typical patterns.
>>>>
>>>> This seems sensible. In general, edge interrupts need an early Ack
>>>> *before* the handler can be run. If it happens after, you're pretty
>>>> much guaranteed to lose edges that would be generated between the
>>>> handler and the late Ack.
>>>>
>>>> This can be implemented in HW in a variety of ways (read a register,
>>>> write a register, or even both).
>>>
>>> Is this something that is or could be documented somewhere under
>>> Documentation, e.g., "here are the common canonical patterns to use"?
>>> I feel like an idiot because I have this kind of question all the time
>>> and I never know how to confidently analyze it.
>>
>> Daire is still having the IT issues, so before I resend the patch with
>> a new commit message, how is the following:
>>
>> Clear the MSI bit in ISTATUS_LOCAL register after reading it, but
>> before reading and handling individual MSI bits from the ISTATUS_MSI
>> register. This avoids a potential race where new MSI bits may be set
>> on the ISTATUS_MSI register after it was read and be missed when the
>> MSI bit in the ISTATUS_LOCAL register is cleared.
> 
> It is still unclear. You should translate what Marc said above into
> how ISTATUS_MSI and ISTATUS_LOCAL work (ie describe how HW works).
> 
> Please describe what the registers do and use that to describe
> the fix.

Sure, best to wait until the IT issues are resolved so!

Conor.
