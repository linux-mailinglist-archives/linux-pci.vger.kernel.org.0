Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C205BB4C5
	for <lists+linux-pci@lfdr.de>; Sat, 17 Sep 2022 01:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiIPXU5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Sep 2022 19:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiIPXU4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Sep 2022 19:20:56 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F554AE9F2;
        Fri, 16 Sep 2022 16:20:54 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id g23so12559855qtu.2;
        Fri, 16 Sep 2022 16:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=funh6DJxWPKQkGfqUouZIN3Ckh5ufZaw1R0aisyo43c=;
        b=l328SO8TvVV7UOhz1dOPe/bmFOmHvWUkrjVaJ0F+GwdsDP9wYS2oYd9MHN5CT8x/rB
         syWkCxANnXOc2rELuAzgablk5E4p6BNFm0CPmEYWY8DmwmBI0A0HZL3Vk7TgBdJKiSBJ
         YJ/I7CYHd75D24Wdti8hQPslJKIpTk/28AWSqIt96mFCPlkrE9XieXfJdH0JZbsA22v5
         ER1OfvGZARJK0aidVc/4zhtH5Rbl+jO6hrYm8uy9AlHJDucPWZcbDos2UtZUNzSPBo6Y
         hxIe1p4Rlp73HP48R9EK74OdoG16Xx5e8404+ELuZsyuwZy+gDLdR9mhl0bCoaH18dfQ
         L+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=funh6DJxWPKQkGfqUouZIN3Ckh5ufZaw1R0aisyo43c=;
        b=xAq//KuCmUzpekyGytY4l28RpZSpJ9OOTNXnt9pVEF+UEDNeBydT+XkaPKxivI02mb
         mnF4cb7IslQ7QFBoPt7rIXhfaziPnVFVjN9rD6202CvwtengDA0dYF4h/I/P8sIsgIpZ
         O7I57b7sx01s+h1QY2spIUGal9lk0nWGE6uC7oecs56eckvEPlo9GY/skMCliKcJjKgT
         y094KT649ZvdMXKD1Uscrpb5AUHqnHJvzDgUiyrlSRFTU0ZWuJchGyBza+o1YFCIRu2i
         2wRb4KUT0ywiI2tql76YeWp1q9YCY+jwX2a8eMjZh6LbGxsdXoI1LfELTk9g5FeXup3I
         1//w==
X-Gm-Message-State: ACrzQf3f0hUWQIdAUZMPpdtGN9qYB9hdUOL+jT5sFg4eBywI4fqESHAV
        pSV/oJt862rgRsu80FP7kZI=
X-Google-Smtp-Source: AMsMyM4J7SATRwEjRfc/V0Dc1cogL1hJjn0iSCjjwp7Qe/DFPqAU16QehsKCVvs3nobNbaBaW+iRmg==
X-Received: by 2002:a05:622a:141:b0:35c:d7b7:62c1 with SMTP id v1-20020a05622a014100b0035cd7b762c1mr3179178qtw.376.1663370453665;
        Fri, 16 Sep 2022 16:20:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:90c9:b1c1:5c9e:9030? ([2600:1700:2442:6db0:90c9:b1c1:5c9e:9030])
        by smtp.gmail.com with ESMTPSA id f12-20020a05620a408c00b006bb78d095c5sm7916099qko.79.2022.09.16.16.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 16:20:53 -0700 (PDT)
Message-ID: <1a4381ea-53a6-1ed0-100f-e622457ccc87@gmail.com>
Date:   Fri, 16 Sep 2022 18:20:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC 2/2] pci: create device tree node for selected devices
Content-Language: en-US
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh@kernel.org>, Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, helgaas@kernel.org,
        clement.leger@bootlin.com, max.zhen@amd.com, sonal.santan@amd.com,
        larry.liu@amd.com, brian.xu@amd.com, stefano.stabellini@xilinx.com,
        trix@redhat.com
References: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
 <1661809417-11370-3-git-send-email-lizhi.hou@amd.com>
 <20220902185403.GA173255-robh@kernel.org>
 <dd823b9c-fe7f-7c47-520c-bad5a798efc2@gmail.com>
 <63c31198-ac4d-f3c7-9259-ea7dc6373b23@gmail.com>
In-Reply-To: <63c31198-ac4d-f3c7-9259-ea7dc6373b23@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/13/22 02:03, Frank Rowand wrote:
> On 9/12/22 01:33, Frank Rowand wrote:
>> On 9/2/22 13:54, Rob Herring wrote:
>>> On Mon, Aug 29, 2022 at 02:43:37PM -0700, Lizhi Hou wrote:
>>>> The PCI endpoint device such as Xilinx Alveo PCI card maps the register
>>>> spaces from multiple hardware peripherals to its PCI BAR. Normally,
>>>> the PCI core discovers devices and BARs using the PCI enumeration process.
>>>> And the process does not provide a way to discover the hardware peripherals
>>>> been mapped to PCI BARs.
>>
>> < snip >
>>
>>>
>>> The above bits aren't really particular to PCI, so they probably 
>>> belong in the DT core code. Frank will probably have thoughts on what 
>>> this should look like.
>>
>> < snip >
>>
>> I will try to look through this patch series later today (Monday 9/12
>> USA time - I will not be in Dublin for the conferences this week.)
>>
>> -Frank
> 
> I have collected nearly 500 emails on the history behind this patch and
> also another set of patch series that has been trying to achieve some
> somewhat similar functionality.  Expect me to take a while to wade through
> all of this.

I'm still working at understanding the full picture of patch 2/2.

-Frank

> 
> -Frank

