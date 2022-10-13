Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BA65FDEEA
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 19:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiJMR2r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 13:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJMR2q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 13:28:46 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1C745F70;
        Thu, 13 Oct 2022 10:28:45 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id q18so1294804ils.12;
        Thu, 13 Oct 2022 10:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xW1hGhhG1a+jZESpJXTZ+May2tEDBDYQoIz1i9vNh40=;
        b=da5n71lPLMztDLCID6RIPDr1X+8jEDhO2W9JXZdaE3MGwAgs7L1PSlKod5ZxNQkrjS
         6Knk4TplvnW+sE+2v0fm1SfX6bSMlHMFcQ001NUp5kG0oXbXQfC61ldVV1HoOBXZrnQX
         P6diRw2Pi2wSFnix/OhE5xfTdMVBgQ5vRVn5f5q6DJGEKK1li2ULILktzQ5DPmop45as
         TM/Dt2tz7NcvB2sIphw16IxZxDU92RVg5lBawhiYQe1i2C9nHozcF6qdg0WyH/0te4Y4
         3va8lA5pwaqPrb7RuAySh5latEgxV+RgQbO8lXToFNNZx78P+HPmrBjnXul9KBCfoXxE
         IS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xW1hGhhG1a+jZESpJXTZ+May2tEDBDYQoIz1i9vNh40=;
        b=K09cyOC2PHNeDuHggEKG6dzxS0KeXiQFQk3kkmOpcwOUqcvq5dF93CqOn4P8XoyT21
         rSEems0smuIWObQuyg5K+dCUj0jkyWhkQwmc85BYg04/2Q+XMorgNYBoJDghLiDaUTX/
         hc4yBvcFAkhYClAd1yaKpBJ5HRtruCWJFr8T4Qwd00owOAJgZM6sOI6BMZ0Orrt0gvgn
         EXfzhbvi3IxpbdR3/UGvOAUocbe1tMcAB+Wd8euC/LUukSBY8QuSOITlaGkZrBPORt82
         d7jJd9U97NhgJCyvJLyR36pVCGkhAWHNDD6UvtPofVF5Wh2dtQfznhSJ33qqDHkDJTTz
         +FqA==
X-Gm-Message-State: ACrzQf12KPpXviA+YUtBC3B5mHqMdoBWGlDz25pSy1370Pky3/EUPGRS
        h0iU1LMBxTwsHrCyqm4/MdY=
X-Google-Smtp-Source: AMsMyM5tMJzDXtwtLS2rKteGqKwUTreLeuR4hV29JfDDw9coo46UJ7wQ18NLhDrAUGUmhG0ddURaaw==
X-Received: by 2002:a05:6e02:19ce:b0:2fc:3a29:f89f with SMTP id r14-20020a056e0219ce00b002fc3a29f89fmr524762ill.219.1665682125034;
        Thu, 13 Oct 2022 10:28:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:dfd:8f05:49f2:c057? ([2600:1700:2442:6db0:dfd:8f05:49f2:c057])
        by smtp.gmail.com with ESMTPSA id z44-20020a0293af000000b00363a5566a3bsm178635jah.90.2022.10.13.10.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 10:28:44 -0700 (PDT)
Message-ID: <c427fd85-3746-bf26-e4a3-9b2aa53f6572@gmail.com>
Date:   Thu, 13 Oct 2022 12:28:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC 0/2] Generate device tree node for pci devicesgain,
Content-Language: en-US
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, helgaas@kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, larry.liu@amd.com, brian.xu@amd.com,
        stefano.stabellini@xilinx.com, trix@redhat.com
References: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
 <1d9faa2e-e3fc-d104-c85f-4035233848d6@gmail.com>
 <ca35a14d-501d-265e-b196-a87e1e994cd0@amd.com>
 <78211af5-171c-ef4f-a8c2-17f63dc479bc@gmail.com>
 <20221010104210.68edf825@fixe.home>
 <0d571d21-507d-fcc5-bf58-d02f958de28a@gmail.com>
 <20221013100245.14c509ec@fixe.home>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20221013100245.14c509ec@fixe.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/13/22 03:02, Clément Léger wrote:
> Le Thu, 13 Oct 2022 01:05:26 -0500,
> Frank Rowand <frowand.list@gmail.com> a écrit :
> 
>>> This would also require two different descriptions of the same card
>>> (for ACPI and device-tree) and would require the final user to create a
>>> specific overlay for its device based on the PCI slots the card is
>>> plugged in.  
>>
>> One of the many missing pieces of overlay support.  There have been several
>> discussion of how to describe a "socket" in a device tree that a device
>> could be plugged into, where a single device tree subtree .dtb could be
>> relocated to one or more different socket locations.  Thus in this
>> case a single overlay could be relocated to various PCI slots.
>>
>> I don't expect be getting involved in any future efforts around sockets
>> (see my following comment for why).
>>
>>>
>>> The solution we proposed (Lizhi and I) allows to overcome these
>>> problems and is way easier to use. Fixing the potential bugs that might
>>> exists in the overlay layer seems a way better idea that just pushing  
>>
>> It is not potential bugs.  The current run time overlay implementation is
>> proof of concept quality and completeness.  It is not production ready.
>>
>> I got an opportunity for early retirement a couple of weeks ago.  My first
>> inclination was to continue the same level of device tree maintainership,
>> but I am quickly realizing that there are other activities that I would
>> like to devote my time and energy to.  I will continue to support Rob with
>> minor patch reviews and testing, and potentially finishing up some
>> improvements to unittest.  On the other hand, bringing run time overlay
>> support to product quality would be a major investment of my time that I
>> am not willing to continue.
> 
> Hi Frank,
> 
> This explains your position on the overlay support and I can
> certainly understand it ! Regarding the fact that it would enter

No, my position on the technical aspects of overlay support is totally
unchanged.

The only thing that has changed is that my time will not be available to
assist in future overlay related work.  The burden for this will fall
more on Rob than it has in the past.


> "production", the devices we are talking about are not really
> widespread yet? This would be a good opportunity to gather feedback
> early and improve the support gradually. We could probably even be able
> to support improvements in the overlay code if needed I guess.

That is avoiding my point about the current implementation being
proof of concept.

-Frank

> 
> Thanks for your honest answer,
> 
> Clément
> 
>>
>> So I am leaving major overlay issues in the capable hands of Rob.  I may
>> chime in from time to time when I can do so without requiring too much of
>> my time.
>>
>> -Frank
>>
>>> that away to the bootloader level. Moreover, this kind of devices is
>>> likely to be more common with the increasing popularity of FPGA and a
>>> proper solution must be found.
>>>   
> 
> 
> 

