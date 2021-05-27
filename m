Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C35392427
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 03:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbhE0BN5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 21:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbhE0BNr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 21:13:47 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF18BC061761
        for <linux-pci@vger.kernel.org>; Wed, 26 May 2021 18:12:13 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id u11so3490067oiv.1
        for <linux-pci@vger.kernel.org>; Wed, 26 May 2021 18:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=exJYV0NRFjRQ5VrBRJOpFxRRj/qcZmNhjCFXtwj2b6E=;
        b=Icw3wJ5UXgBm3MmeI9k3ltrfs2V1sytWyQvXRDHJXysgPbWUT9IwPcR1F5ttv5CN6V
         vBVs8hyZhKM997l6WB2joFWsJUXlKJOiojgziv1Ajnj9Q2Y4dd+wuV73X3/ETiwq7HDU
         s0hHaj6kppHH5Nz6KjMhSQfp9UYXiBAlNCuJZunMg7a7C+RKL7cwCGYe7ipJcCse/sDL
         4Do7yF/SDdT6qQdt6jCgLxAqFXKul1dlt9io8Db+Zugp2beO30qquBaxtZC4SZmJrpUF
         MNwfIgzU+RUud7Gm1APLNVBpDpxEyMgdfz76qx2Cn5deb+BKqXT4d79HAW+KHkyUBbs3
         tZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=exJYV0NRFjRQ5VrBRJOpFxRRj/qcZmNhjCFXtwj2b6E=;
        b=ey3vupd8mzqHmfa59kf37WNithpYwUtstwVB3HCwBlItEY+fbKHE9fVAdB02P7HVKV
         iw6NPniC0+xXIh6YOxCOVKBmchkb4oaIlq3EOOCbw41fcjXxtY73L8Qk4Q0xiwkDDX4C
         CkEX5JyPaXTQkZ0peY2WRQc241/RLeljCiGgqjULCqT2bZeoz+t1DQdDLU3pFqiKls9Y
         bz422JDmgrZC7h2uxA2j7fnkKFoqNKQyYBvTEQkxwXWODAwzMk7nKi3WwIPy4wKp+SkX
         GsPfh52qTD/P5uEHQk3av/2RLpRJxCHzElL8yX5NKZzy1qxh+esWHdvneUpC3f1WfA0X
         xGjQ==
X-Gm-Message-State: AOAM533cK/fGRi0c9u0r35JwfTdZ1fVaoXMtxBZ+d3exKeCUZ20XPjTP
        NmHqo46SRer6vtB0gM+bv/90Fk/3rr0=
X-Google-Smtp-Source: ABdhPJxrecfCFR889sRCZxHPd82piHPq3SQP5CK+NN0eeVdXDUS+0pCmpPTrtrE11H9Aavnai7rMdQ==
X-Received: by 2002:aca:3197:: with SMTP id x145mr647941oix.23.1622077932675;
        Wed, 26 May 2021 18:12:12 -0700 (PDT)
Received: from ?IPv6:2603:8081:2802:9dfb:49b3:8e2:3d6d:26c8? (2603-8081-2802-9dfb-49b3-08e2-3d6d-26c8.res6.spectrum.com. [2603:8081:2802:9dfb:49b3:8e2:3d6d:26c8])
        by smtp.gmail.com with ESMTPSA id n11sm201786otf.26.2021.05.26.18.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 18:12:12 -0700 (PDT)
Subject: Re: [PATCH v2] PCI/portdrv: Use link bandwidth notification
 capability bit
To:     Krzysztof Wilczy??ski <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20210512213314.7778-1-stuart.w.hayes@gmail.com>
 <20210514130303.GD9537@rocinante.localdomain>
 <20210514130845.GA26314@wunner.de>
 <20210514131701.GE9537@rocinante.localdomain>
From:   stuart hayes <stuart.w.hayes@gmail.com>
Message-ID: <53c92c86-5fd9-5db4-eacf-954f1f07cecb@gmail.com>
Date:   Wed, 26 May 2021 20:12:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210514131701.GE9537@rocinante.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/14/2021 8:17 AM, Krzysztof Wilczy??ski wrote:
> Hi Lukas,
> 
> [...]
>>> I was wondering - is this fix connected to an issue filled in Bugzilla
>>> or does it fix a known commit that introduced this problem?  Basically,
>>> I am trying to see whether a "Fixes:" would be in order.
>>
>> The fix is for a driver which has been removed from the tree (for now),
>> including in stable kernels.  The fix will prevent an issue that will
>> occur once the driver is re-introduced (once we've found a way to
>> overcome the issues that led to its removal).  A Fixes tag is thus
>> uncalled for.
> 
> Thank you for adding more details.  Much appreciated.
> 
> Krzysztof
> 

I made the patch because it was causing the config space for a 
downstream port to not get restored when a DPC event occurred, and all 
the NVMe drives under it disappeared.  I found that myself, though--I'm 
not aware of anyone else reporting the issue.
