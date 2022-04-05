Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B5A4F3418
	for <lists+linux-pci@lfdr.de>; Tue,  5 Apr 2022 15:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbiDEI0E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Apr 2022 04:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239476AbiDEIUG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2022 04:20:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0896986FA
        for <linux-pci@vger.kernel.org>; Tue,  5 Apr 2022 01:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649146426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MDCSuTBfZwtRffPeKzfeIlKrYFRcwDiHhiO8PXpP4fk=;
        b=PPA9GOM9rMKzBsTE5UzwxOv1I+8rXBVAsbdk2wgCTEa3rHOTvMzFZMAUEI13JtqvoRS54v
        PArtYSTNAm68TDWFl35nVckElf5Nlzh4pjXlgulYoDeU5s0+QuI8mb6/1KJyVfgxTBhSYa
        QF5AGuHbfakYmB8b8ScdWYd/eYd+QCo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-51npIlZYOVaB71r2FFG1JA-1; Tue, 05 Apr 2022 04:13:43 -0400
X-MC-Unique: 51npIlZYOVaB71r2FFG1JA-1
Received: by mail-ej1-f72.google.com with SMTP id sa22-20020a1709076d1600b006e810a004dbso167246ejc.19
        for <linux-pci@vger.kernel.org>; Tue, 05 Apr 2022 01:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MDCSuTBfZwtRffPeKzfeIlKrYFRcwDiHhiO8PXpP4fk=;
        b=74jpO56VfIPdqMPXR9TUpUs+RTPBHu6RUWepMft/Qnk9w4A+HVER3BvxBTqpF1aGVX
         x3Ab8VdmRvdM52378X7W4rbQGzfnaqOepRpxiKsstt0+Ylw9ARrnWolhUubyDbfJ8OaP
         g/oC8C77V50KS8x4F5lJiHSb68ESmKlIdZWfV6CHVS429SsehXbytuTUcN4CSVXPjKJg
         qym+zw/yWDIz9CSqN0xt6/y0w09I3bNxS6jdcvL8kyo+HxcYP9OVbP6L9f0G6PEBj2VP
         dGFfAxOLkEZPDvNbOs7TkUy+cyLzIwy1YKvQ96TV7RcJ+xT1llTa5pL4o/hsvE7LXlIO
         gzug==
X-Gm-Message-State: AOAM531aqLCUZLjFExdaOyleywTtoELx4QPzqlV1DwPJoePk8QHqmK6r
        DuY/G3F3hEBGECzaZ20/eXNo8Hfv8PVem3TlfboCTrleZOWBTIsGMRwx0EY5Mav9KWufklehPtO
        g2ShB4OIWTZkqz7XyhEAG
X-Received: by 2002:a17:907:1c93:b0:6e7:fbc3:fc8 with SMTP id nb19-20020a1709071c9300b006e7fbc30fc8mr2324639ejc.34.1649146422412;
        Tue, 05 Apr 2022 01:13:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNyJ6aCkxKPqKF/ZdcQT/1oCGQurxvdYPi1lP4cGo0YlAy5ao336ZE4lnTOo9tKJERKoXCLg==
X-Received: by 2002:a17:907:1c93:b0:6e7:fbc3:fc8 with SMTP id nb19-20020a1709071c9300b006e7fbc30fc8mr2324623ejc.34.1649146422201;
        Tue, 05 Apr 2022 01:13:42 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id g9-20020aa7c849000000b00412fc6bf26dsm6440114edt.80.2022.04.05.01.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 01:13:41 -0700 (PDT)
Message-ID: <36e9f346-cbea-a821-a00e-5399247a54bb@redhat.com>
Date:   Tue, 5 Apr 2022 10:13:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: next/master bisection: baseline.login on asus-C523NA-A20057-coral
Content-Language: en-US
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org,
        "kernelci@groups.io" <kernelci@groups.io>,
        "kernelci-results@groups.io" <kernelci-results@groups.io>
References: <623c13ec.1c69fb81.8cbdb.5a7a@mx.google.com>
 <Yjyv03JsetIsTJxN@sirena.org.uk>
 <4e9fca2f-0af1-3684-6c97-4c35befd5019@redhat.com>
 <Yjzua8Wye/3DHBKx@sirena.org.uk>
 <f8e96f8a-c19c-6acd-2f54-688924f491e8@redhat.com>
 <28699579-8384-ff3b-5662-fb56d8ced766@collabora.com>
 <28ee7ff8-5b21-9154-74e9-efd59da4a498@collabora.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <28ee7ff8-5b21-9154-74e9-efd59da4a498@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

On 4/4/22 21:44, Guillaume Tucker wrote:
> +kernelci
> 
> On 29/03/2022 19:44, Guillaume Tucker wrote:
>> On 28/03/2022 13:54, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 3/24/22 23:19, Mark Brown wrote:
>>>> On Thu, Mar 24, 2022 at 09:34:30PM +0100, Hans de Goede wrote:
>>>>
>>>>> Mark, if one of use writes a test patch, can you get that Asus machine to boot a
>>>>> kernel build from next + the test patch ?
>>>>
>>>> I can't directly unfortunately as the board is in Collabora's lab but
>>>> Guillaume (who's already CCed) ought to be able to, and I can generally
>>>> prod and try to get that done.
>>>
>>> Ok, Guillaume, can you try a kernel with commit 5949965ec9340cfc0e65f7d8a576b660b26e2535
>>> ("x86/PCI: Preserve host bridge windows completely covered by E820") + the 
>>> attached patch added on top a try on the asus-C523NA-A20057-coral machine please
>>> and see if that makes it boot again ?
>>
>> Sorry I've been busy with a conference.  Sure, will put that
>> through KernelCI tomorrow and let you know the outcome.
> 
> Well the issue seems to have been fixed on mainline, unless it's
> intermittent.  In any case, next-20220404 is booting fine:
> 
>   https://linux.kernelci.org/test/plan/id/624aed811a5acd09adae071e/
> 
> Last time it was seen to fail was next-20220330:
> 
>   https://linux.kernelci.org/test/plan/id/62442f68e30d6f89a4ae06b7/
> 
> 
> Ironically, the KernelCI staging linux-next job with the patches
> mentioned in your previous email applied is now failing:
> 
>   https://staging.kernelci.org/test/plan/id/624b2d3b923f532dc305f4c7/
> 
> The kernel branch being used is:
> 
>   https://github.com/kernelci/linux/commits/staging-next
> 
> 
> I haven't checked the logs or investigated any further, this is
> just a quick summary based on the boot test results.
> 
> Please let us know if we should drop these patches or try
> anything else.  I'll be on holiday for the rest of the week but
> others can pick things up if needed.

The reason why next and mainline are building now is because
the patch the bisect pointed out never made it into mainline
and Bjorn has dropped it from -next.

I fully expect that -next with 

https://lore.kernel.org/linux-acpi/20220304035110.988712-4-helgaas@kernel.org/

or mainline with the entire series from that link applied will
still not boot.

But we do need that last patch to fix various issues on
other boards.

See my previous reply in this thread:
https://lore.kernel.org/linux-pci/76c5de03-a3a4-8444-d7f6-496fa119d830@redhat.com/

for some further analysis of what I think is happening here.

As mentioned there I believe this can be fixed by merging
back-to-back resources into a single resource before calling
remove_e820_regions() but I could not find a good example / helper
code to do the merging of the resources.

If someone can give me some pointers wrt this I can try to
come up with something and then provide a set of patches
for testing on the asus-C523NA-A20057-coral .

Regards,

Hans

