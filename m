Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD6951A35E
	for <lists+linux-pci@lfdr.de>; Wed,  4 May 2022 17:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351829AbiEDPQY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 May 2022 11:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350363AbiEDPQX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2022 11:16:23 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DACF41325
        for <linux-pci@vger.kernel.org>; Wed,  4 May 2022 08:12:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e24so2454014wrc.9
        for <linux-pci@vger.kernel.org>; Wed, 04 May 2022 08:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=J/6edDAoGiJvwXrwHfZneoLWTo+GhcZIzXoJ98ClTtc=;
        b=MqH+uACj88R/r3Sqdkwt7CDqlVGvd/Upo14iVij92A/8XnlbBqs9c8x8ZumFEbvceP
         qxXVwbEizXsEaSLDdnGUbP2nX++MB5DR2BEPLW2WGQo6pBbwSCC0wu/CtnfDyCTSJ8iw
         Y1cQ8xtn/QW0J3rzGYR51fr3TMTKaSSPQdwVToV03//tojGc3wvTpcznWrfSwESBE3Fl
         uwDD1MjUMGRXb9VPpPe7cOvqg2WDkG1oLDebHKUha16FCJjegMtn2UvQcibzvCCvqJUc
         zEz2R4g+OHjDzXIM/vtQ0WLJP8b+vsA4UQDiqErG31X6jxkyIthAkZhySdn726Hckloh
         pgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J/6edDAoGiJvwXrwHfZneoLWTo+GhcZIzXoJ98ClTtc=;
        b=jAQC07iWpOOLWU9pWeouu9asudXoLnSZbTYpbOxxjWwLcliYVDOnrb1LSKnPCeLVJC
         IxpQk2eXmPNcOwsndQvkIN0FNKle+WnfCAC/li8tBB9ZnkyOdxS3ofLFVKO20eiBZuX7
         jj+jaio3wQLLib0dP0b0/MTOqADC6G9J6Js3fWPDWMgdFzXKF76JPaQ9wnHIZxHnuuI2
         SFmF/w4G2lOCHkdGSzPuSXjup/HeblqNRX57hl0K5Fkd+VDdAcmceI5R4cLMzkE/bGS4
         SPKPyaMLsWJsCv966gCU5xag8mYX0H5GLM2HTi6/gHJG9qz1GE7lsPFzL9eHU7wfQR2Z
         RI5Q==
X-Gm-Message-State: AOAM532PskonwvJQZPbHvgqrf9K5VdkSbw+Ng3riQifQNIuSK2H9n/nF
        btYCTgp5Rppg6nLhrZgSqFB1pg==
X-Google-Smtp-Source: ABdhPJw3jQ6NzbntELwroQk+0eE2ZdM81gr/DnNhoJVU8cSfyQDlw5mMXVRJl1+CObA5QDQo4561Sg==
X-Received: by 2002:adf:b64c:0:b0:1e3:16d0:3504 with SMTP id i12-20020adfb64c000000b001e316d03504mr16785118wre.333.1651677161589;
        Wed, 04 May 2022 08:12:41 -0700 (PDT)
Received: from [192.168.2.222] ([109.77.36.132])
        by smtp.gmail.com with ESMTPSA id l28-20020a05600c1d1c00b003942a244ed1sm1777942wms.22.2022.05.04.08.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 08:12:41 -0700 (PDT)
Message-ID: <199f5479-b212-e1ac-f9e4-d5d13708cb0c@conchuod.ie>
Date:   Wed, 4 May 2022 16:12:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RESEND PATCH v1 1/1] PCI: microchip: Fix potential race in
 interrupt handling
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     Conor.Dooley@microchip.com, lorenzo.pieralisi@arm.com,
        Daire.McNamara@microchip.com, bhelgaas@google.com,
        Cyril.Jean@microchip.com, david.abdurachmanov@gmail.com,
        linux-pci@vger.kernel.org, robh@kernel.org
References: <20220502192223.GA319570@bhelgaas>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <20220502192223.GA319570@bhelgaas>
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

On 02/05/2022 20:22, Bjorn Helgaas wrote:
> On Sat, Apr 30, 2022 at 12:33:51AM +0100, Marc Zyngier wrote:
>> On Fri, 29 Apr 2022 22:57:33 +0100,
>> Bjorn Helgaas <helgaas@kernel.org> wrote:
>>> On Fri, Apr 29, 2022 at 09:42:52AM +0000, Conor.Dooley@microchip.com wrote:
>>>> On 28/04/2022 10:29, Lorenzo Pieralisi wrote:
>>>>> On Tue, Apr 05, 2022 at 12:17:51PM +0100, daire.mcnamara@microchip.com wrote:
>>>>>> From: Daire McNamara <daire.mcnamara@microchip.com>
>>>>>>
>>>>>> Clear MSI bit in ISTATUS register after reading it before
>>>>>> handling individual MSI bits
> 
>>>> Clear the MSI bit in ISTATUS register after reading it, but before
>>>> reading and handling individual MSI bits from the IMSI register.
>>>> This avoids a potential race where new MSI bits may be set on the
>>>> IMSI register after it was read and be missed when the MSI bit in
>>>> the ISTATUS register is cleared.
> 
>>> Honestly, I don't understand enough about IRQs to determine whether
>>> this is a correct fix.  Hopefully Marc will chime in.  All I really
>>> know how to do is compare all the drivers and see which ones don't fit
>>> the typical patterns.
>>
>> This seems sensible. In general, edge interrupts need an early Ack
>> *before* the handler can be run. If it happens after, you're pretty
>> much guaranteed to lose edges that would be generated between the
>> handler and the late Ack.
>>
>> This can be implemented in HW in a variety of ways (read a register,
>> write a register, or even both).
> 
> Is this something that is or could be documented somewhere under
> Documentation, e.g., "here are the common canonical patterns to use"?
> I feel like an idiot because I have this kind of question all the time
> and I never know how to confidently analyze it.

Daire is still having the IT issues, so before I resend the patch with
a new commit message, how is the following:

Clear the MSI bit in ISTATUS_LOCAL register after reading it, but
before reading and handling individual MSI bits from the ISTATUS_MSI
register. This avoids a potential race where new MSI bits may be set
on the ISTATUS_MSI register after it was read and be missed when the
MSI bit in the ISTATUS_LOCAL register is cleared.

Reported by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/linux-pci/20220127202000.GA126335@bhelgaas/
Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip PolarFire PCIe controller driver")
Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> 
>>> And speaking of that, I looked at all the users of
>>> irq_set_chained_handler_and_data() in drivers/pci.  All the handlers
>>> except mc_handle_intx() and mc_handle_msi() call chained_irq_enter()
>>> and chained_irq_exit().
>>>
>>> Are mc_handle_intx() and mc_handle_msi() just really special, or is
>>> this a mistake?
>>
>> That's just a bug. On the right HW, this would just result in lost
>> interrupts.

Separate issue, separate patch. Do you want them in a series or as
another standalone patch?

Thanks,
Conor.
