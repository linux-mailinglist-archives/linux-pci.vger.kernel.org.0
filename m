Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9C9413DE0
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 01:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhIUXOn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Sep 2021 19:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhIUXOn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Sep 2021 19:14:43 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB63C061574;
        Tue, 21 Sep 2021 16:13:14 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c22so2368071edn.12;
        Tue, 21 Sep 2021 16:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7+TMIEcNDti5spyCR8whCCXBXeiNmd/MHUsrn+BQi4k=;
        b=fOsUv+jsDv0r0nf1I8jZ3IPTRrPbKyay0VcopOhfwifDhwvK2DfdArZE/h7iiVYBYu
         7sGwhwe+cickMQz0MhcJ7Vc6thplBpz01DOHYDD7Brh/8VXk7iDDofF7kzGfFMGkBtE/
         Ug5P1oL87wOmtR1kds4fY84VKMiRg536BRxaS+KRPvg/hPw88XJ7L7hGQdQfZNnxbCJk
         Wyv0TxD2sxT83omRF5YmNwMtdSpu6jFs7+JyUtLBnPmZgekdXTrUdi36v5H66l4rN6Ri
         V0RCpqZQrCYwJeVJ9IVXywYTxtiTR6Ql4a/kEu8Cjb5hWkXPCjRiDxMaeipMlGzskCQK
         dK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7+TMIEcNDti5spyCR8whCCXBXeiNmd/MHUsrn+BQi4k=;
        b=mKb0HKZd+DHO526YfIJXlzPqq6UYSUmlukVIo1cr0l+zWeehjR8853tA+LbLp21BvC
         qw1ydGnnpS45rtNyvu/rFJT5PFtLpBxBFPHWavfUtiieNGvXOf1BiwuVf4EkN2GBlvvr
         Gx0td08k210UAyi99b5kpcD/vtdsrvUMZGUnoxFTxa8o8NQpoS62pJO+vqTpPajBq+dv
         ol+hgPPYqjTGuQrfsDYZjW+1IzbiAn0GrEZ65u92g+oNDnwHrwtAAn8uz4Gtoyok/Ylj
         8uuzs1zlztn3Yf6fRzQhtZb/sag37dZGR6SFjekHG3DkliOY2hsd9iGQJxdyaBT4kmg8
         qJqg==
X-Gm-Message-State: AOAM531D0wuJRE61QFeQifdxCPQYbjJPu3WOedJyXvqv0hNq0puE8r7o
        SLERWm1+FP9QtwEpYLEJKK8=
X-Google-Smtp-Source: ABdhPJwbt+ye7PxkuJWOYU68kWg1pThqlf6fTZ1joVZKYcEcWww5JsUqPwp9LV+ITJRTHya9eJH6ng==
X-Received: by 2002:a17:906:7047:: with SMTP id r7mr37029873ejj.342.1632265992943;
        Tue, 21 Sep 2021 16:13:12 -0700 (PDT)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id g6sm169152edr.15.2021.09.21.16.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 16:13:12 -0700 (PDT)
Subject: Re: [PATCH] PCI: rcar: Add missing COMMON_CLK dependency
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20210907144512.5238-1-marek.vasut@gmail.com>
 <CAMuHMdU+QteYhw6xuhuPrX5DVfmPnBgM8JfQoTk-KOP7+fSCWQ@mail.gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <d720b758-109a-434e-b1a4-f49649dd34e9@gmail.com>
Date:   Wed, 22 Sep 2021 01:13:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdU+QteYhw6xuhuPrX5DVfmPnBgM8JfQoTk-KOP7+fSCWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/21/21 6:08 PM, Geert Uytterhoeven wrote:

[...]

>> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
>> index 326f7d13024f..ee6f5e525d3a 100644
>> --- a/drivers/pci/controller/Kconfig
>> +++ b/drivers/pci/controller/Kconfig
>> @@ -66,6 +66,7 @@ config PCI_RCAR_GEN2
>>   config PCIE_RCAR_HOST
>>          bool "Renesas R-Car PCIe host controller"
>>          depends on ARCH_RENESAS || COMPILE_TEST
>> +       depends on COMMON_CLK
> 
> This part is OK.

This part is also identical in the patch from Arnd, so you can just pick 
that one as a fix and be done with it:

[PATCH] PCI: rcar: add COMMON_CLK dependency
https://patchwork.kernel.org/project/linux-pci/patch/20210920095730.1216692-1-arnd@kernel.org/
