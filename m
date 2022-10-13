Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0205D5FD477
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 08:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiJMGFb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 02:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiJMGF3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 02:05:29 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED65C22B1F;
        Wed, 12 Oct 2022 23:05:28 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id u2so479661ilv.6;
        Wed, 12 Oct 2022 23:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DDj4+uRODjMr45xNf5pLX6OxTEFFbTj3Pj7jweavBZ0=;
        b=kfyDKIfq0/UXndb7SbP3gaHrwAylkoI9zsC4F1QAe6tR9hx5djcgf4lnCSH/cHOyVa
         f70TBwbfsS6kRnsxjRrOR5qS4I0UG6Qc629O/I0QZwgQ9UC7t3zmMljELIvsEridOC6z
         IvgTE1LqAjTJ+xw2EHQj0T7pkqNsNSoQevlqS74KC2ZwLmRwKNDcwAR0HoJ7nRIn040g
         dppmvfzGKaMiZbvosBbkxPnAo8ByYbcx/JLXBI4021HPujdz/zvsUiudFBl663j1wsbj
         LI/57Bsurpb8HNPwCp6S7aQ+S+bStpp5E7P9+LpMcuVkp5DNlKT3r52cRe3LUQYfrPP4
         FVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DDj4+uRODjMr45xNf5pLX6OxTEFFbTj3Pj7jweavBZ0=;
        b=imJ10IHZEp0qaZKTPXke6EWwVa186qigRhhQ2Ci83DRFGmzmZ1ARSoREhNy4wYyvDX
         kOusDVyBYc/g+lyLjijHxTH9CaOX61r/NVKuzfufCQVkOOpAUVwzjM+HAA+YPv0SZTgV
         ogSiIqWMjwrCWcv+Z1i4ZHsp3MsBNpKU+0dicC1N7aurjJ+69CnoNZPqaIsPX5TX8Co3
         hrH4FyGOGfaiXF19aXr90n4XbRyjvaVQnRgwFR99MHqqZuppJ+xoH7oU1gSLnZrAUklM
         P0/z2RgWKChP8xooRoRzox6ozv2aj1l2J5lUw0AHEKKTFrpwpDOErGurwboYaXjL22DP
         2wCg==
X-Gm-Message-State: ACrzQf1+rrlWFo4cBrf4DYFDhccDdlxAPJzphhbfOcHHgznF0Jv+TIaO
        FIt6z5RTbvafYd4GVQUPbek=
X-Google-Smtp-Source: AMsMyM6oNwKP1DHKsPbdJNJ5Qmy7dnImH5E9N9HvRQGLTT+J6m/lx6L0kNC3FXg2uni2RnCEigVdFg==
X-Received: by 2002:a92:d484:0:b0:2fc:3a29:f8a9 with SMTP id p4-20020a92d484000000b002fc3a29f8a9mr9298488ilg.235.1665641128259;
        Wed, 12 Oct 2022 23:05:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:9085:f814:ae2e:a9b4? ([2600:1700:2442:6db0:9085:f814:ae2e:a9b4])
        by smtp.gmail.com with ESMTPSA id d6-20020a05663802a600b00363781b551csm7087606jaq.146.2022.10.12.23.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 23:05:27 -0700 (PDT)
Message-ID: <0d571d21-507d-fcc5-bf58-d02f958de28a@gmail.com>
Date:   Thu, 13 Oct 2022 01:05:26 -0500
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
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20221010104210.68edf825@fixe.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/10/22 03:42, Clément Léger wrote:
> Le Tue, 13 Sep 2022 12:41:28 -0500,
> Frank Rowand <frowand.list@gmail.com> a écrit :
> 
>>>> I am not positive what part of what I wrote above is correct and would appreciate
>>>> some confirmation of what is correct or incorrect.  
>>>
>>> There are 2 series devices rely on this patch:
>>>
>>>     1) Xilinx Alveo Accelerator cards (FPGA based device)
>>>
>>>     2) lan9662 PCIe card
>>>
>>>           please see: https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/  
>>
>> Thanks.  Please include this information in future versions of the patch series.
>>
>> For device 2 I have strongly recommended using pre-boot apply of the overlay to the base
>> device tree.  I realize that this suggestion is only a partial solution if one wants to
>> use hotplug to change system configuration (as opposed to using hotplug only to replace
>> an existing device (eg a broken device) with another instance of the same device).  I
>> also realize that this increased the system administration overhead.  On the other hand
>> an overlay based solution is likely to be fragile and possibly flaky.
> 
> Again, applying overlays pre-boot is not an acceptable solution. Some
> systems are not based on device-tree (x86 platforms with ACPI based
> description, and I'm not even sure this is doable by modifying ACPI
> tables). PCI is meant to be plug-and-play, so patching the ACPI
> tables or device-tree pre-boot is likely not the correct answer to this
> problem.
> 


> This would also require two different descriptions of the same card
> (for ACPI and device-tree) and would require the final user to create a
> specific overlay for its device based on the PCI slots the card is
> plugged in.

One of the many missing pieces of overlay support.  There have been several
discussion of how to describe a "socket" in a device tree that a device
could be plugged into, where a single device tree subtree .dtb could be
relocated to one or more different socket locations.  Thus in this
case a single overlay could be relocated to various PCI slots.

I don't expect be getting involved in any future efforts around sockets
(see my following comment for why).

> 
> The solution we proposed (Lizhi and I) allows to overcome these
> problems and is way easier to use. Fixing the potential bugs that might
> exists in the overlay layer seems a way better idea that just pushing

It is not potential bugs.  The current run time overlay implementation is
proof of concept quality and completeness.  It is not production ready.

I got an opportunity for early retirement a couple of weeks ago.  My first
inclination was to continue the same level of device tree maintainership,
but I am quickly realizing that there are other activities that I would
like to devote my time and energy to.  I will continue to support Rob with
minor patch reviews and testing, and potentially finishing up some
improvements to unittest.  On the other hand, bringing run time overlay
support to product quality would be a major investment of my time that I
am not willing to continue.

So I am leaving major overlay issues in the capable hands of Rob.  I may
chime in from time to time when I can do so without requiring too much of
my time.

-Frank

> that away to the bootloader level. Moreover, this kind of devices is
> likely to be more common with the increasing popularity of FPGA and a
> proper solution must be found.
> 

