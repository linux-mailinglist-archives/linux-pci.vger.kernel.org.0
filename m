Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A070B64A568
	for <lists+linux-pci@lfdr.de>; Mon, 12 Dec 2022 18:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbiLLRBT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Dec 2022 12:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbiLLRBN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2022 12:01:13 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E5755AD
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 09:01:08 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-14449b7814bso9136778fac.3
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 09:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6OFNwOVEvjonocdKLd3uOtuOYuKpHMlsyaaoacS/Uy4=;
        b=apShNOquL44hqhSrtfmjvxs/zc/3PtIpb0UBcsyiwgDuLze7oIdZfJS0S5BjnkT+k/
         Q8AWG4z8sNQ4GVoHLe8RQgvOTN3Xp1REy7C1+WcRVAF2gg3ofJamKBAMx+lZvsMEUSKi
         XGLnlU9Hx9PuZV3U73HTMjxlou2GYDcIyLect2NXIsIA4m1GFHZ44ON25vGCdPd0PxYy
         tvN4a472lIBxXOmyXH9LrVoENRp1P/4C250zHggEbWwLS5bNdCwMGrRWXh3Fehj9Iokg
         z+Hw4hQ6DTaR1N2O9HnSlGjUvK+tUK0KxivY5bId+OJsfrnDDR5eg5WI5voYUH0bLxxT
         VXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6OFNwOVEvjonocdKLd3uOtuOYuKpHMlsyaaoacS/Uy4=;
        b=zZH81Qaf3OSVx/mlTLkdNAxkl1X7QZYm/Odfsgfcg5NbXoPZicf1Y+5onfTGGyqgau
         Hu/EQUbyJNoVaqy+/nm6ESnOP5ZTEJAJ79TbqYUwG0jTd0m9Q/6eo6hbSl9Gvh4c9mzx
         LtBDR839pQI0wfXHgiwSws9zUa48vS7ZBW2/zxSuQGKnuQUERTUIlQwB5NaZreTdsDDr
         4a+LH+Jm4mW0ZpErz0aSQT/dUp06mnFIV914COK2KtUKQRqg17M1VrZdBCpqpwInf0S/
         7ddFK/KF/DCup1iDl5EZumLJXTf/S697B4UVtJZrNBxnT9s99ROHOaQu9ltVUKbReR3V
         DHOA==
X-Gm-Message-State: ANoB5pnwzrcWJQMYxWG6d5MAyGWcCJHwVGHoQJwMUqXxLApmDy/OyRI5
        prI57+vZbucQsQzpnIMRMPM=
X-Google-Smtp-Source: AA0mqf5wgeRby5TRoMTROPnVRYMnMGQTVB0jbLCSJLjmWKTmZs4usj1YMJbnQB8jwCpIc3XikW+YDg==
X-Received: by 2002:a05:6870:3118:b0:13c:2b53:a0e8 with SMTP id v24-20020a056870311800b0013c2b53a0e8mr8543160oaa.54.1670864465841;
        Mon, 12 Dec 2022 09:01:05 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f43-20020a056871072b00b00144bb1013e6sm165969oap.4.2022.12.12.09.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 09:01:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3f83e874-3d7c-cc97-2207-a47dbcfe960f@roeck-us.net>
Date:   Mon, 12 Dec 2022 09:01:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean Delvare <jdelvare@suse.com>
References: <20221212142454.3225177-1-alvaro.karsz@solid-run.com>
 <20221212142454.3225177-4-alvaro.karsz@solid-run.com>
 <848cc714-b152-8cec-ce03-9b606f268aef@roeck-us.net>
 <CAJs=3_AdgWS23-t6dELgSfz7DS4U0eXuXP_UZ3Fn21VCEwA-4w@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 3/3 v4] virtio: vdpa: new SolidNET DPU driver.
In-Reply-To: <CAJs=3_AdgWS23-t6dELgSfz7DS4U0eXuXP_UZ3Fn21VCEwA-4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/12/22 08:29, Alvaro Karsz wrote:
> Hi Guenter,
> Thanks for your comments.
> 
>> This is wrong. It should be possible to build the driver without it, and
>> without forcing everyone to enable hwmon just to get support for this device -
>> even more so since hwmon support is explicitly marked as optional below.
>> Why force people to compile it if it is not mandatory ?
>>
>>
>> Yes, I know, "select HWMON" is done elsewhere as well, but it is just as wrong
>> there. No one should be forced to enable HWMON support just to get, say, support
>> for the IDT PCIe-switch Non-Transparent Bridge.
> 
> 
> You have a good point.
> I will remove it from the Kconfig file, and I will add:
> #if IS_REACHABLE(CONFIG_HWMON)
> in relevant places
> 
> Something like:
> 
> solidrun/Makefile:
> obj-$(CONFIG_SNET_VDPA) += snet_vdpa.o
> snet_vdpa-$(CONFIG_SNET_VDPA) += snet_main.o
> #if IS_REACHABLE(CONFIG_HWMON)

I don't think that works in Makefiles. It would have to be ifdef.

> snet_vdpa-$(CONFIG_SNET_VDPA) += snet_hwmon.o
> #endif
> 

Even better would be a separate CONFIG_SNET_VDPA_HWMON Kconfig option.

> solidrun/snet_main.c, snet_vdpa_probe_pf function:
> 
> if (PSNET_FLAG_ON(psnet, SNET_CFG_FLAG_HWMON)) {
> #if IS_REACHABLE(CONFIG_HWMON)
>          psnet_create_hwmon(pdev);
> #else
>          SNET_ERR(pdev, "Can't start HWMON, CONFIG_HWMON is not reachable\n");
> #endif

Per your own statement, that is not an error, and thus should not be logged
as one.

> }
> 
> solidrun/snet_vdpa.h, snet_vdpa_probe_pf function:
> #if IS_REACHABLE(CONFIG_HWMON)
> void psnet_create_hwmon(struct pci_dev *pdev);
> #endif
> 
> What do you think?
> 

It would be much better to add a shim function in the include file.

There should be a dependency

	depends on HWMON || HWMON=n

in Kconfig, and the shim function would then be

#if IS_REACHABLE(CONFIG_HWMON)
void psnet_create_hwmon(struct pci_dev *pdev);
#else
void psnet_create_hwmon(struct pci_dev *pdev) {}
#endif

>> I do not see why the second include would be needed.
> 
> You're right, I'll remove it.
> 
>>
>> Tpecast seems unnecessary.
> 
> I'll remove it.
> 
>> Kind of obvious.
> 
> Ok, I'll remove the comment.
> 
>> Badly misleading indent. No idea why checkpatch doesn't report it.
>>
>>
>> That makes me wonder: Did you not run checkpatch --strict, or did you choose
>> to ignore what it reports ?
> 
> I did run checkpatch (without --strict).
> I tried now with --strict. and I'm not getting any indent
> errors/warnings, this is strange..
> I will fix it.
> 

I referred to the other problems it reports, such as using macro arguments
without ().

>> FWIW, a _hwmon ending in a hwmon driver device name is redundant.
>> What else would it be ? Why not just use pci_name() ?
> 
> I'll change it to "snet_%s", pci_name(pdev)
> 
>> devm_hwmon_device_register_with_info() returns an ERR_PTR on error,
>> not NULL.
> 
> Ok, I'll fix it.
> 
>> I hope you know what you are doing here. This may result in people wondering
>> why hwmon support doesn't work if they expect it to work. No one looks
>> into the kernel log. Besides, ignoring the error doesn't really help
>> much because that error return means that something serious is wrong.
> 
> You have a point, but the hwmon is not the "main" functionality of
> this device, so I don't want to fail the entire device because of a
> "side" functionality.
> Now that the SNET vdpa driver doesn't select CONFIG_HWMON, we may have
> a situation when the SNET_CFG_FLAG_HWMON flag is set, but the kernel
> is compiled without CONFIG_HWMON.
> I don't think that I should fail probe in this case.
> 
>> Wow, a 5-second hot loop. Not my responsibility to accept or reject this
>> part of the code, but personally I think this is completely unaccceptable.
> 
> The SNET DPU may require some time to become ready.
> If the driver is compiled as a module, this is not a problem, but if
> the driver is builtin in the kernel, we may need to wait a little for
> the DPU.
> But you're right, 5 secs is indeed a big number, I'll change it to 2 secs.
> 

That isn't the point. A 2-second hot loop is just as bad.
There should be a usleep_range() or similar between loop iterations.

Guenter

>> Memory allocation failures are not commonly logged since the low level code
>> already does that.
> 
> Right, I'll remove the error log.
> 
> Alvaro

