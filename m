Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2FF355953
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 18:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346497AbhDFQjA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 12:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346496AbhDFQi7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Apr 2021 12:38:59 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E0CC06174A;
        Tue,  6 Apr 2021 09:38:50 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id k8so10779251pgf.4;
        Tue, 06 Apr 2021 09:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hm55f+wMNrLLLXsDJfgnrjHRXDjxwW49AbjwzREWMxA=;
        b=DtcxrFaBoeivbflo7LEoLP0o71c6qCM/HG8b0iGP9rp/n8NSD3E5R8nv+ONVGTKMSJ
         aE67dzQawDRvHyJ89T7w4PkRjulX8P2YrCOU9vNi/0WAsa0c/E37bucNp+Z41xzF2auQ
         46sNK8ejFU0ud2ymiiioss+f9SSabe7cuJCi2BTU1F9X4zMpbYuvmRXZs28X+rzh3V+0
         +Y4bS7D/HhdlNXdm5PuB236X5ktzr6Nj5LTO5z/j1JhoB4jrSdlD8cegJZB34e4TcISo
         lozezLAGKRmlYWxlGTaHbSICl+vrLUNYi3dybBSfZuDvmM504YfWUDaMY0Mrc9O5p6GS
         QbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hm55f+wMNrLLLXsDJfgnrjHRXDjxwW49AbjwzREWMxA=;
        b=B147fKZKjiSpSKiMjKpRqGUSxBSkNkozq9EQ9srBtx3+x9ONShyKzHoP38M93EC9iS
         KDdPlJ2Px0MY6m1xr8dIl5m8cClFv+gxnbC/YYHyA4CyxRQlaExkU6iFRnFOTH/sWuyF
         MvrEFNm0+MyyWRO2NImJ2asFkoVY2hzG76VP+0CiA79xzFZQ6fjsnGAjmGd1G6pLMExJ
         36HkNtOGXQhD3k94i+4bbAgF3buY0zKiCu0Q9ouK39BVSpHm+U5x3MVMlVArqos5y+Yh
         JS6duzSPDnyE1IKSSLtiHwkVh2bBXJ5ojfPuJ8W9q8Ya64vtwMXVbEK6mXrRFB+7tou6
         9FGg==
X-Gm-Message-State: AOAM531Hppdu/Z78S23QGCpv05WlfMY8tRJXMZnuxNbUsAp0vSkaXh9c
        IafkgOWztkcgzEc5dyf2IXqFbaYbU8s=
X-Google-Smtp-Source: ABdhPJwd6gf26SVn6vGXZnrrFka8G84S2Cc+5RdSKHjumAZeeoF+/jhY9yTV5BNC2rqWnl3CdAOJXw==
X-Received: by 2002:a62:1757:0:b029:23e:9917:7496 with SMTP id 84-20020a6217570000b029023e99177496mr4047391pfx.51.1617727129891;
        Tue, 06 Apr 2021 09:38:49 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x9sm13178189pfd.158.2021.04.06.09.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 09:38:48 -0700 (PDT)
Subject: Re: [PATCH v5 0/2] ata: ahci_brcm: Fix use of BCM7216 reset
 controller
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, james.quinlan@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Jim Quinlan <jim2101024@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Jim Quinlan <jquinlan@broadcom.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:LIBATA SUBSYSTEM Serial and Parallel ATA drivers" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210312204556.5387-1-jim2101024@gmail.com>
 <161772368880.12349.1551046998078695154.b4-ty@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <be8892ed-cba6-e8c3-6e1d-5a9940af9440@gmail.com>
Date:   Tue, 6 Apr 2021 09:38:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <161772368880.12349.1551046998078695154.b4-ty@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/6/2021 8:42 AM, Lorenzo Pieralisi wrote:
> On Fri, 12 Mar 2021 15:45:53 -0500, Jim Quinlan wrote:
>> v5 -- Improved (I hope) commit description (Bjorn).
>>    -- Rnamed error labels (Krzyszt).
>>    -- Fixed typos.
>>
>> v4 -- does not rely on a pending commit, unlike v3.
>>
>> v3 -- discard commit from v2; instead rely on the new function
>>       reset_control_rearm provided in a recent commit [1] applied
>>       to reset/next.
>>    -- New commit to correct pcie-brcmstb.c usage of a reset controller
>>       to use reset/rearm verses deassert/assert.
>>
>> [...]
> 
> Applied to pci/brcmstb, thanks!
> 
> [1/2] ata: ahci_brcm: Fix use of BCM7216 reset controller
>       https://git.kernel.org/lpieralisi/pci/c/92b9cb55a9
> [2/2] PCI: brcmstb: Use reset/rearm instead of deassert/assert
>       https://git.kernel.org/lpieralisi/pci/c/a24fd1d646

Thanks a lot!
-- 
Florian
