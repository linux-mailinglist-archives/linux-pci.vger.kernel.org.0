Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BBF5AD6DC
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 17:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbiIEPuH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 11:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237925AbiIEPuF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 11:50:05 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C414D15FEF;
        Mon,  5 Sep 2022 08:50:03 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t3so3776852ply.2;
        Mon, 05 Sep 2022 08:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date;
        bh=3XrVUU9T8R4LO8OA1f5h+alUXAX2S0TQoRT3c9Li0zE=;
        b=fb+biuem+7b7djICmUqeW/BHTeNp/mSIkZ0RvN2SXnaFs/5YyeMU+evecpiT94v82W
         Wxfn0CSNmSmyFNdPp1gzvwV0fM9AjmN0MOmTdZboebJPVCoX17sG9lmzebM9ao53ceUW
         yVd7msO4mdC3TWp+151flO1HCijMCEaMLiYb6sFX8Glvs7ZTTgoL3lCtGTKQ7fyXm+Gg
         pHh/glh3NMkFwNQZT6QZHQG62OtYie95f/rnYvvh4Y8aPOmfyT9Ar+2EHwInZ1j+1+j+
         Oy+Ig/euXQdz3oHAXN56OD5BQH1j8orR8xHQaKEnUQLjJ5W8lICDNDnwnI3x7eyp41JE
         4G+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3XrVUU9T8R4LO8OA1f5h+alUXAX2S0TQoRT3c9Li0zE=;
        b=hHJgc5TAzDP2StbI84l5K++P9LI6cA0wdfIuqRNmYwprvXNfSGmRIZHXjdhs10aF+a
         NAeRtAKt1VTR5sK9YDy62ZJfyqmID3XON7MxSVQnYY/B8rEHgp5yHK/h7MOeqKw4Z9NM
         lUU5ez8gA/0DB2awELe+nIm1ygW4MdugFPRDxeKQYH4dNWhlkGGrc2v8z4bBJC11pYEm
         CraelHcL2vggAnqf3yP4pKVYL0Yvw+rYPB8Hi5lLOXZWVha9aBT4SL2fOebJA6GNyGd3
         r6wUkjFQuKz8USFZN09KiNM5RMBtFtjyXMX3RQAmCIDsjgMaH/VkWa03XE4zy/h2AnXJ
         jkpw==
X-Gm-Message-State: ACgBeo3wMIO3o1CdQFyFWh2irfNwn4mlGIyNkdUQgBqnvieVchG38a3/
        +h7uhQ1triWJNlWLoUqT0Fo=
X-Google-Smtp-Source: AA6agR5VS25L+Z4dRUGvyFsOt5wkYCTLrQ7nt81wIVLfBBuODfZGLGcvsv14A7LgAxNP1Gl1OohTXw==
X-Received: by 2002:a17:90a:c706:b0:1fd:e21e:7cb1 with SMTP id o6-20020a17090ac70600b001fde21e7cb1mr20626775pjt.234.1662393003052;
        Mon, 05 Sep 2022 08:50:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p1-20020a17090a348100b001faa4a6691asm10512410pjb.30.2022.09.05.08.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 08:50:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c696b9bf-d0ce-1c6a-0ee3-939b180891be@roeck-us.net>
Date:   Mon, 5 Sep 2022 08:49:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Marc Zyngier <maz@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-10-b29adfb27a6c@gmail.com>
 <CAHp75Vd35EOy=mP25=9fmYfqQnbafgotHw1fxk-TdGk6Oc8g8Q@mail.gmail.com>
 <75e60144-9fa2-d6ba-bc92-edd23f7e7189@roeck-us.net>
 <CAHp75VcisCTYoRp-=713YKtwi7BQyPKGiUhF4DkpfAFtvDXCiQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1 10/11] watchdog: bd9576_wdt: switch to using
 devm_fwnode_gpiod_get()
In-Reply-To: <CAHp75VcisCTYoRp-=713YKtwi7BQyPKGiUhF4DkpfAFtvDXCiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/5/22 08:21, Andy Shevchenko wrote:
> On Mon, Sep 5, 2022 at 6:13 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> On 9/5/22 04:09, Andy Shevchenko wrote:
>>> On Mon, Sep 5, 2022 at 9:33 AM Dmitry Torokhov
>>> <dmitry.torokhov@gmail.com> wrote:
> 
> ...
> 
>>>> +       count = device_property_count_u32(dev->parent, "rohm,hw-timeout-ms");
>>>> +       if (count < 0 && count != -EINVAL)
>>>> +               return count;
>>>> +
>>>> +       if (count > 0) {
>>>
>>>> +               if (count > ARRAY_SIZE(hw_margin))
>>>> +                       return -EINVAL;
>>>
>>> Why double check? You may move it out of the (count > 0).
>>
>> Two checks will always be needed, so I don't entirely see
>> how that would be better.
> 
> But not nested. That's my point:
> 
> if (count > ARRAY_SIZE())
>    return ...
> if (count > 0)
>    ...
> 

The old code has either 1 or two checks if there is no error.
Your suggested code has always two checks. I don't see how that
is an improvement.

>>>> -       if (ret == 1)
>>>> -               hw_margin_max = hw_margin[0];
>>>
>>>> +               ret = device_property_read_u32_array(dev->parent,
>>>> +                                                    "rohm,hw-timeout-ms",
>>>> +                                                    hw_margin, count);
>>>> +               if (ret < 0)
>>>> +                       return ret;
>>>
>>> So, only this needs the count > 0 check since below already has it implicitly.
>>>
>> Sorry, I don't understand this comment.
> 
> if (count > 0) {
>    ret = device_property_read_u32_array(...);
>    ...
> }
> if (count == 1)
>   ...
> if (count == 2)
>   ...
> 
> But here it might be better to have the nested conditionals.
> 

We know that count is either 1 or 2 here, so strictly speaking
	if (count == 1) {
	} else {
	}
would be sufficient. On the other side, that depends on ARRAY_SIZE() being
exactly 2, so
	if (count == 1) {
	} else if (count == 2) {
	}
would also make sense. Either way is fine with me. I'll leave it up
to Dmitry to decide what he wants to do.

Thanks,
Guenter

>>>> -       if (ret == 2) {
>>>> -               hw_margin_max = hw_margin[1];
>>>> -               hw_margin_min = hw_margin[0];
>>>> +               if (count == 1)
>>>> +                       hw_margin_max = hw_margin[0];
>>>> +
>>>> +               if (count == 2) {
>>>> +                       hw_margin_max = hw_margin[1];
>>>> +                       hw_margin_min = hw_margin[0];
>>>> +               }
>>>>           }
> 

