Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7414EF808
	for <lists+linux-pci@lfdr.de>; Fri,  1 Apr 2022 18:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349565AbiDAQhO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Apr 2022 12:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244385AbiDAQhD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Apr 2022 12:37:03 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F9856C1D;
        Fri,  1 Apr 2022 09:12:03 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso3795143wme.5;
        Fri, 01 Apr 2022 09:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MiR5EPOKkLhhEObk+YmsUARSnRu9/gwuzLaNmeH+HbE=;
        b=PC1r74zw0BaM045emgzXvZ34kFbAVR0vYhGnDMBlSxTxsbRp0q7AJpcgfDz8gomnJA
         56KqY8Qbll1p/J1/OnxHqA0oe0xMxZhdbPJNVWmWI9HVs4gzE3mhGTC9NGw4eEMIcLx2
         WdvLf+ZxlcusfDT4AZlJGYcyLS8RUPafiVxnk5LBvYjxlIcV1y7vfy3xCxMxtyvsFonu
         IAdgll79N6pGq8Lih8WdCocdG8jxqFkxGRq6sS7W8xK/kaagd9IsNBJOoRySkwmrIFkA
         1cdvbDBanw9xnSxEbNt4YAJ56XweOQnYTWeYL/095b0fq4cXvd/3ARqAcDKNYEBwxHAy
         544A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MiR5EPOKkLhhEObk+YmsUARSnRu9/gwuzLaNmeH+HbE=;
        b=d/3pJ3/eT4Z57OpVNzw/sR/odq0PoNUlXRrs8GwlW5QVxZiXpP+W0azMJ7ehje5Be6
         QO7DzxbtUrqSONirKQwd/QwCj9+uqqJrnhV0QYGaKnG/Kd8P+H3KosM591vTBdbTeSu5
         ZMRyLl1qJhDrOEnbhoQQhbaArWE1/UVlqCdoh2WJJRXDqybbDeHT0VsvnR/5CXhp1X4w
         2YxoJMPini6n5Ao8NfyKGb5pjXLpQl/cHftF0xpBP982o6Hf0P1KPCy/mrE4+uwFDToy
         zFtX5/Ag5mMZfhqjXbaO2vPH2XNks2/eOV+s9pHXhQk8Fj1pm5NdV3sAhGkc/Qgp4cDB
         HzoA==
X-Gm-Message-State: AOAM533N63JEk8R9cUAJEthTAlLKDOmUW1Fyu8/d/hV9OlFJijtR3n20
        +TsvlHEcpt5MdM+iz3SRqlE=
X-Google-Smtp-Source: ABdhPJyFiyZhDPEC+rND9soHKz13sCFb9qDf8Mc2AIa/JTh7yxH0ggHH+x0G0Crv+QULy1frYEgG+w==
X-Received: by 2002:a1c:4e19:0:b0:38c:88b8:c1ef with SMTP id g25-20020a1c4e19000000b0038c88b8c1efmr9458436wmh.133.1648829521497;
        Fri, 01 Apr 2022 09:12:01 -0700 (PDT)
Received: from [192.168.1.208] ([87.68.193.190])
        by smtp.gmail.com with ESMTPSA id e12-20020a5d6d0c000000b001a65e479d20sm3023375wrq.83.2022.04.01.09.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 09:12:00 -0700 (PDT)
Message-ID: <707a6991-ba4a-1224-8fb2-ea2d11963bdf@gmail.com>
Date:   Fri, 1 Apr 2022 19:11:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V5 1/1] Intel Sky Lake-E host root ports check.
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew.maier@eideticom.com, logang@deltatee.com,
        bhelgaas@google.com, jgg@nvidia.com,
        Shlomo Pongratz <shlomop@pliops.com>
References: <20220331143101.GA4846@bhelgaas>
From:   Shlomo Pongratz <shlomopongratz@gmail.com>
In-Reply-To: <20220331143101.GA4846@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 31/03/2022 17:31, Bjorn Helgaas wrote:
> On Thu, Mar 31, 2022 at 10:35:39AM +0300, Shlomo Pongratz wrote:
>> In commit 7b94b53db34f ("PCI/P2PDMA: Add Intel Sky Lake-E Root Ports B, C, D to
>> the whitelist")
>> Andrew Maier added the Sky Lake-E additional devices
>> 2031, 2032 and 2033 root ports to the already existing 2030 device.
>>
>> The Intel devices 2030, 2031, 2032 and 2033 which are root ports A, B, C and D,
>> respectively and if all exist they will occupy slots 0 till 3 in that order.
> Please make this a sentence.
>
>> The original code handled only the case where the devices in the whitelist are
>> host bridges and assumed that they will be found on slot 0.
>>
>> This assumption doesn't hold for root ports so an explicit test was added to
>> cover this case.
> Please update the subject line to match the style of previous ones.
>
> Please wrap the commit log to fit in 80 columns (including the 4
> spaces added by "git log") like previous commits.
>
> Please figure out whether you want "Sky Lake-E" or "SkyLake-E" and use
> it consistently in commit log and code comments.  It seems to be
> "Skylake" on intel.com, so I suggest using that.
I think that you are right and Skylake is indeed a better name,
but since Andrew Maier in his original patch used Sky Lake-E it is
better to stick with it. (SkyLake-E will be removed).
>
> Please use imperative mood, e.g., instead of "an explicit test was
> added ...," write "add a test to cover this case."  Do the same in
> code comments.
>
> Bjorn
Shlomo
------------------------------------------------------------------------
*From:* Bjorn Helgaas [mailto:helgaas@kernel.org]
*Sent:* Thursday, March 31, 2022, 5:31 PM
*To:* Shlomo Pongratz
*Cc:* linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
andrew.maier@eideticom.com, logang@deltatee.com, bhelgaas@google.com, 
jgg@nvidia.com, Shlomo Pongratz
*Subject:* [PATCH V5 1/1] Intel Sky Lake-E host root ports check.

> On Thu, Mar 31, 2022 at 10:35:39AM +0300, Shlomo Pongratz wrote:
>> In commit 7b94b53db34f ("PCI/P2PDMA: Add Intel Sky Lake-E Root Ports B, C, D to
>> the whitelist")
>> Andrew Maier added the Sky Lake-E additional devices
>> 2031, 2032 and 2033 root ports to the already existing 2030 device.
>>
>> The Intel devices 2030, 2031, 2032 and 2033 which are root ports A, B, C and D,
>> respectively and if all exist they will occupy slots 0 till 3 in that order.
> Please make this a sentence.
>
>> The original code handled only the case where the devices in the whitelist are
>> host bridges and assumed that they will be found on slot 0.
>>
>> This assumption doesn't hold for root ports so an explicit test was added to
>> cover this case.
> Please update the subject line to match the style of previous ones.
>
> Please wrap the commit log to fit in 80 columns (including the 4
> spaces added by "git log") like previous commits.
>
> Please figure out whether you want "Sky Lake-E" or "SkyLake-E" and use
> it consistently in commit log and code comments.  It seems to be
> "Skylake" on intel.com, so I suggest using that.
>
> Please use imperative mood, e.g., instead of "an explicit test was
> added ...," write "add a test to cover this case."  Do the same in
> code comments.
>
> Bjorn
