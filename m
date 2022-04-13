Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F92B4FF240
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 10:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbiDMIng (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 04:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbiDMInZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 04:43:25 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D30B4738A
        for <linux-pci@vger.kernel.org>; Wed, 13 Apr 2022 01:41:00 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s25so1014349edi.13
        for <linux-pci@vger.kernel.org>; Wed, 13 Apr 2022 01:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vnyM2Iiv5ssFwZ+YfhSIPkTVc84CfyYTFaqlrMujJwU=;
        b=JIbqyng6xlRV93M1Iu4dTb27ybe+M5EN2beeOTia2QovfKwHZWLGjr66cUx0YdX3/v
         8nbu5XWVqbuUMx1VHW7Jp0LjTMIRW/JvtKlPAPwmC12IguAK8nAZjvST8nPijS6soEVz
         lCEGXpJKRGImWyHRDfmKyn0IwmzTivzO/Vs8MDv+1cJ+MoZ5YxwAJ+kc5wqtfsrfRjlw
         dl24/2CzxrUZbd2CgYUV995GGUYyvDMWOghjruTd1pRrJ7LcOsA6BV8p7XbkZUzO9Tat
         9Hf6SigjF0nx23JEKIGKUT0nPYsQzEA7bWg8dt6IDJV7Ni9PpqpqRJKKkXLn7s8NY1Kj
         Fn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vnyM2Iiv5ssFwZ+YfhSIPkTVc84CfyYTFaqlrMujJwU=;
        b=dYNhODVhR+JNVkBOojZMIaECxr3ZjA5P1pMTDDJHc/1I7us8cb1maIkHQIY3SPjGvw
         hjOgmNan8b33zgnIANwYYjT42zSupdSr+GC04BnJhQH3x9qKein8JqOeGPz/Lj90Qk3W
         2acwuz77f/NjKtq0qCGcFho17dn5VR6Q8N9GAeSVi8wA2D8NFE4AEgMOgbelFy6sP+hn
         N90si4AEgWgzRnXXQ6OF4Q040zg2j1dDiw5C3Rk//dydU9BDgbiep8HyeL5NGfa0tlo6
         YX7clcBXluSniO9P2fZ9YJE4BKLEk3zXlleMsYOBsG5WuKozED3w4aL65PtYeNmk6NWi
         4Btw==
X-Gm-Message-State: AOAM533RZC0SLmtCItFDVO5zZF6bZMeXe5bTNTBWhgrTvZQT9Zg8YwwZ
        3t0gbQTAPjeKmlGpahRQxb4rRQ==
X-Google-Smtp-Source: ABdhPJwtqQ40ij3I2sXCRUOzsMpUdkisZ2t9soK7OyZx79O22lSzuKtXAWN17iTj1ggfo92pAD3X0Q==
X-Received: by 2002:aa7:c40b:0:b0:41d:9886:90a0 with SMTP id j11-20020aa7c40b000000b0041d988690a0mr5089328edq.275.1649839258932;
        Wed, 13 Apr 2022 01:40:58 -0700 (PDT)
Received: from [192.168.0.202] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id o15-20020a50d80f000000b0041cc1f4f5e0sm902910edj.62.2022.04.13.01.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 01:40:58 -0700 (PDT)
Message-ID: <f967f1b2-80a2-8418-d5e8-1e2ac41730a6@linaro.org>
Date:   Wed, 13 Apr 2022 10:40:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 12/12] rpmsg: Fix kfree() of static memory on setting
 driver_override
Content-Language: en-US
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stuart Yoder <stuyoder@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20220403183758.192236-1-krzysztof.kozlowski@linaro.org>
 <20220403183758.192236-13-krzysztof.kozlowski@linaro.org>
 <OS0PR01MB59226666C2C6805C86304BE586ED9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <OS0PR01MB59226666C2C6805C86304BE586ED9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/04/2022 16:10, Biju Das wrote:
> Hi Krzysztof Kozlowski,
> 
> Thanks for the patch.
> 
>> Subject: [PATCH v6 12/12] rpmsg: Fix kfree() of static memory on setting
>> driver_override
>>
>> The driver_override field from platform driver should not be initialized
>> from static memory (string literal) because the core later kfree() it, for
>> example when driver_override is set via sysfs.
>>
>> Use dedicated helper to set driver_override properly.
>>
>> Fixes: 950a7388f02b ("rpmsg: Turn name service into a stand alone driver")
>> Fixes: c0cdc19f84a4 ("rpmsg: Driver for user space endpoint interface")
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> ---
>>  drivers/rpmsg/rpmsg_internal.h | 13 +++++++++++--
>>  drivers/rpmsg/rpmsg_ns.c       | 14 ++++++++++++--
>>  include/linux/rpmsg.h          |  6 ++++--
>>  3 files changed, 27 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/rpmsg/rpmsg_internal.h
>> b/drivers/rpmsg/rpmsg_internal.h index d4b23fd019a8..1a2fb8edf5d3 100644
>> --- a/drivers/rpmsg/rpmsg_internal.h
>> +++ b/drivers/rpmsg/rpmsg_internal.h
>> @@ -94,10 +94,19 @@ int rpmsg_release_channel(struct rpmsg_device *rpdev,
>>   */
>>  static inline int rpmsg_ctrldev_register_device(struct rpmsg_device
>> *rpdev)  {
>> +	int ret;
>> +
>>  	strcpy(rpdev->id.name, "rpmsg_ctrl");
>> -	rpdev->driver_override = "rpmsg_ctrl";
>> +	ret = driver_set_override(&rpdev->dev, &rpdev->driver_override,
>> +				  "rpmsg_ctrl", strlen("rpmsg_ctrl"));
> 
> Is it not possible to use rpdev->id.name instead of "rpmsg_ctrl" ?
> rpdev->id.name has "rpmsg_ctrl" from strcpy(rpdev->id.name, "rpmsg_ctrl");
> 
> Same for "rpmsg_ns" as well

It's possible. I kept the pattern of duplicating the string literal
because original code had it, but I don't mind to change it. In the
output assembler that might be additional instruction - need to
dereference the rpdev pointer - but that does not matter much.


Best regards,
Krzysztof
