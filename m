Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3626662F16
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 19:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237498AbjAISa2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Jan 2023 13:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237804AbjAIS3v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2023 13:29:51 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD356B5B6
        for <linux-pci@vger.kernel.org>; Mon,  9 Jan 2023 10:27:09 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id s5so4113039qtx.6
        for <linux-pci@vger.kernel.org>; Mon, 09 Jan 2023 10:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ixsystems.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5gCmz8euCYn1vXNsEFOqZgAUmltip8+y5b4mCw2bnZc=;
        b=ZZRIRScYxQbQEDH1H0XSlxUbwD6VtyTvCXNO/ypOcarjPQA5KZYJlpfJhE69x9otJO
         BO63lXo+4621lv5c7APg9QmyeTakSU+6jpH0UgZLj19vG+ImT9PUbGn1YhALx2X9ht5z
         bGLXbXh8gPd24KoTmKaIkRHT9UjojPnhB/dFDKRiJLJfa/T4qJTsSLkDJg2Z30VLi2A1
         QejuH/yKSHbH4QSLprdL14z8t26v6XdEnBI4f3Tkiy/WY5lNVWgOJr+hZoiUNzAzCrDK
         vPceOdsXpX7dNnKUvENBT0y8yBZpqrsOYTAG1Z+cESsqYW+exXNMmWoxYKLjMXvUN13v
         3sOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5gCmz8euCYn1vXNsEFOqZgAUmltip8+y5b4mCw2bnZc=;
        b=WjGpT1QXYJXIrl0W8i9V5bRzkAbue1kbgKQAnDM3FbAfgceOX7CRl77FfINbXiF39l
         OEjEBfWA51yym21lrOfKBGIj8hiUwT1bWheaJGtaMTX3gXJMqYspS8YZjCpnQqjnNQu0
         ehfQmYMD5n1qceUGMqjd8FcUaon4tjnpgUpCd1YECazbhYJaZUsIBAlMBy9e8Hq+Y7Qa
         MYOkxhZQra2BE5wwN7Dw0ptV0EsFEHOSwTF+/3n1cDKFbKIVt0ZfG7lnH3oZuAwDfWU0
         X9DbdVQwFyeyF0XskTkB7kTPNGptbNoEH3dZlN2m26zN4mIWdsFXgHRtPvip+52MkvZT
         2Rhw==
X-Gm-Message-State: AFqh2krFLSgx3Pb7VD1JU4lg5ZjROLnsO8099prgt2oTQcJ3bQ5XI/Tn
        4g7MoVwd3li8FRBNkHAkHWjDPQ==
X-Google-Smtp-Source: AMrXdXt8vhujKrVDGdvpaYijBuV+zv7dgbWxAfdoj+dF6UNzNevOmY/BL+sSgGPNj3EAQ90wFmvZQg==
X-Received: by 2002:ac8:1386:0:b0:3ac:57b4:8af1 with SMTP id h6-20020ac81386000000b003ac57b48af1mr9294658qtj.48.1673288829026;
        Mon, 09 Jan 2023 10:27:09 -0800 (PST)
Received: from [10.230.45.5] ([38.32.73.2])
        by smtp.gmail.com with ESMTPSA id w12-20020a05620a444c00b006f9ddaaf01esm5832677qkp.102.2023.01.09.10.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 10:27:08 -0800 (PST)
Message-ID: <2f33bc51-7473-58fc-0b87-fad3984375d6@ixsystems.com>
Date:   Mon, 9 Jan 2023 13:27:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4 1/2] PCI: Take other bus devices into account when
 distributing resources
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org
References: <Y7bUAaxt6viswdXV@black.fi.intel.com>
 <20230105170413.GA1150738@bhelgaas> <Y7v2XT1N4J1deVEt@black.fi.intel.com>
From:   Alexander Motin <mav@ixsystems.com>
In-Reply-To: <Y7v2XT1N4J1deVEt@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09.01.2023 06:11, Mika Westerberg wrote:
> On Thu, Jan 05, 2023 at 11:04:13AM -0600, Bjorn Helgaas wrote:
>> On Thu, Jan 05, 2023 at 03:43:29PM +0200, Mika Westerberg wrote:
>>> On Thu, Jan 05, 2023 at 11:12:11AM +0200, Mika Westerberg wrote:
>>>>> What happens in a topology like this:
>>>>>
>>>>>    10:00.0 non-hotplug bridge to [bus 20-3f]
>>>>>    10:01.0 non-hotplug bridge to [bus 40]
>>>>>    20:00.0 hotplug bridge
>>>>>    40:00.0 NIC
>>>>>
>>>>> where we're distributing space on "bus" 10, hotplug_bridges == 0 and
>>>>> normal_bridges == 2?  Do we give half the extra space to bus 20 and
>>>>> the other half to bus 40, even though we could tell up front that bus
>>>>> 20 is the only place that can actually use any extra space?
>>>>
>>>> Yes we split it into half.
>>>
>>> Forgot to reply also that would it make sense here to look at below the
>>> non-hotplug bridges and if we find hotplug bridges, distribute the space
>>> equally between those or something like that?
>>
>> Yes, I do think ultimately it would make sense to keep track at every
>> bridge whether it or any descendant is a hotplug bridge so we could
>> distribute extra space only to bridges that could potentially use it.
>>
>> But I don't know if that needs to be done in this series.  This code
>> is so complicated and fragile that I think being ruthless about
>> defining the minimal problem we're solving and avoiding scope creep
>> will improve our chances of success.
>>
>> So treat this as a question to improve my understanding more than
>> anything.
> 
> Okay, undestood ;-)

I was also wondering about this problem.  But my first though was: if we 
are not going to look down through all the tree, may be we should better 
distribute resources between all bridges no this bus, no matter whether 
they are hot-plug or not?  Because behind any non-hotplug bridge may 
appear a hot-plug one.  As a possible trivial approach, give hot-plug 
bridges twice of what is given to non-hot-plug ones. ;)

PS: Thank you, Mika, for working on this.

-- 
Alexander Motin
