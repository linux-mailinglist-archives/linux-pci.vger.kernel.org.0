Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436FB523025
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 12:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiEKKCD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 06:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241697AbiEKKBw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 06:01:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B7BDCD
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 03:01:50 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u3so2229259wrg.3
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 03:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=B3PUC31Mlz5mEBY3Iz6lfGSbpuDsx653MliipHqDJLk=;
        b=cTOTkUy7wKXpnc+uyqxqz4A4zvUQy5Vre4nYaAIDtgHuRtrRf5AW6wDQAfQ+Vx1TGC
         ZMfg7jlRenLpWsh/BGJERUmxOLlDv3G4D1V9Z/13hMPvAvrKcthGrESj2JBIoyHVFG1E
         u5/LZ3ShkkbWj7H4DKy6ys4FXbrpdxA+P77tfR/7V1Ji0zZCaLK8LOYQClAz5limd5M/
         RbEWnaE718cRAw6B3ubtUZkLbaycarVrd/eMqVcLSPXL0sletOtiQrLr9Q4TJYQ3Euvq
         tqLXluEhrCGlXkUIg9TZ9Xw5hwTUNgyY7tqE3uv7mpElq9B2ioQNImDK6ucNDOx6rB1b
         reNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B3PUC31Mlz5mEBY3Iz6lfGSbpuDsx653MliipHqDJLk=;
        b=K8ok0f1sAmMEHsTStvFNkhCWweV3ZiEeiJNLKdUpMkI5wXMHFbsM7QLGHPJA3Azldt
         ylNEX6pdUpuggf2JgBVnIALdOXfkYhvoEJnrMtNdjn6O9r1x83FJJ5tegsGnjEfvc8RO
         +252SvXHuj6WuSV9EjvFBrukvNQTENs4iPxCZYOE5Bbv256qpzdqLvqol27pUh5IbJFO
         5VTV1o+yPBuD2oWIJVN9HOBKYdKb5HGrHYZosMpXia0H00aYohkKPEx8aY7g7zf/38fM
         BFOmdgmO9UQ15c8Ny+mZSvEgnQStAyjlCwW9fsIMJ4s2p0WFrIXXfrVFw6AmE8O0639M
         2D9A==
X-Gm-Message-State: AOAM5332Pb6iIWEVvxwP0ayYGcRf7/memJtjgOW6QUA7IFqTnQWvC9XO
        ldQAZI40/i4k7m26lqaqfXrzG67Ls6UgCsQZ
X-Google-Smtp-Source: ABdhPJyS37WrZqxkVmYDqqiLrMUtxVbfy6vtsfZ3hS1On8WaeCKU2zBShqvpOT3AMk5KFkRowZ+fZg==
X-Received: by 2002:a5d:5505:0:b0:20a:ce51:1c48 with SMTP id b5-20020a5d5505000000b0020ace511c48mr22509329wrv.351.1652263308937;
        Wed, 11 May 2022 03:01:48 -0700 (PDT)
Received: from [10.205.160.53] ([95.83.233.54])
        by smtp.gmail.com with ESMTPSA id r5-20020adfdc85000000b0020c5253d8d2sm1227690wrj.30.2022.05.11.03.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 03:01:48 -0700 (PDT)
Message-ID: <5afbd996-ba2b-9b12-4ab2-ff3e0c23d1f5@conchuod.ie>
Date:   Wed, 11 May 2022 11:00:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RESEND PATCH v1 1/1] PCI: microchip: Fix potential race in
 interrupt handling
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, lorenzo.pieralisi@arm.com
Cc:     Marc Zyngier <maz@kernel.org>, Conor.Dooley@microchip.com,
        Daire.McNamara@microchip.com, bhelgaas@google.com,
        Cyril.Jean@microchip.com, david.abdurachmanov@gmail.com,
        linux-pci@vger.kernel.org, robh@kernel.org
References: <20220504165924.GA453752@bhelgaas>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <20220504165924.GA453752@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 04/05/2022 17:59, Bjorn Helgaas wrote:
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
> 
> Restoring the context here:
> 
>>>>> "ISTATUS" doesn't appear in the code as a register name.
>>>>> Neither does "IMSI".  Please use names that match the code.
> 
>> Daire is still having the IT issues, so before I resend the patch with
>> a new commit message, how is the following:
>>
>> Clear the MSI bit in ISTATUS_LOCAL register after reading it, but
>> before reading and handling individual MSI bits from the ISTATUS_MSI
>> register. This avoids a potential race where new MSI bits may be set
>> on the ISTATUS_MSI register after it was read and be missed when the
>> MSI bit in the ISTATUS_LOCAL register is cleared.
> 
> Looks good, thank you!

Hmm, there's now a response saying that the proposed commit message is
fine and one saying it isn't. Which is it?

> 
>>>>> And speaking of that, I looked at all the users of
>>>>> irq_set_chained_handler_and_data() in drivers/pci.  All the handlers
>>>>> except mc_handle_intx() and mc_handle_msi() call chained_irq_enter()
>>>>> and chained_irq_exit().
>>>>>
>>>>> Are mc_handle_intx() and mc_handle_msi() just really special, or is
>>>>> this a mistake?
>>>>
>>>> That's just a bug. On the right HW, this would just result in lost
>>>> interrupts.
>>
>> Separate issue, separate patch. Do you want them in a series or as
>> another standalone patch?
> 
> Agreed, should be a separate patch.  Doesn't need to be a series
> unless that patch only applies correctly on top of this one.

Cool, just sent one:
https://lore.kernel.org/linux-pci/20220511095504.2273799-1-conor.dooley@microchip.com/

Thanks,
Conor.
