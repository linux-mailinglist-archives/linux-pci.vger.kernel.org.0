Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB107C2103
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 14:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbfI3MzC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 08:55:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38378 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729810AbfI3MzC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Sep 2019 08:55:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id w12so11206164wro.5;
        Mon, 30 Sep 2019 05:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6mCv5fi+GRWpdJskKXORsVKeMYlozu0f/SDuZJ27kK8=;
        b=o4m0k0ZWFgdgA6s3VsEERB+TNxTG0CvI2PRVkm3Je9EqeWNLbI4U750n58x/iRlC6i
         cwonjl4pIvyMo+hGfb7ytfWRYRQiIVvLa9QTECkj9LE/R/KSaunDjVITz3zI2qnOFdSB
         WxgVvCue7g7YFKbP/YsrmTGDIDNgldNZjxFw2qo1nCXgJkFw8d3QdE7sGlbHF7ARwntd
         L3uAXMueXWPxbQS3+bkyr+7vCV+zFe2mxnJHofcmi8TclWE+TF5w1lU5ISJHRLQWOt2K
         M1JQPM8BUkSeF/jJjHH7g2wbRlJZl40dJYjMom6KuHYAmBVUFpoZYFfkT96rMFrQTCyy
         lQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6mCv5fi+GRWpdJskKXORsVKeMYlozu0f/SDuZJ27kK8=;
        b=He5ZkNv0VOtXhm/MguFQzA4Cg9oRhIF/Wt5rFvQSVjAJpovBTJEkG+nyGkMpqw0gSx
         d9IXQoDSWwa+q533udWV7aEbE0RMnUWm8123V8GRwen5Zeg2+gVahb/jTqCZ4NXsXdt7
         Jx6U4WTbZDoMY9JpgtyDx05CFAnlmvCcoFXRc9GYSAjwqXRly4lIXTyNUshC1RZlsVba
         qgomA1n4rSlIeS64epolMgXL4+tUnTJXo2E8z/c0gdMQt4zzkvYumKhHDt1u/kAyHKyR
         UOCdrehz6bjSvTK/tTuIHeGM7ZDNCZC381vUzJ0/StsvCfaVVVUv+2m0ub1MQBjdUPPg
         WB8Q==
X-Gm-Message-State: APjAAAUCRXXVfpnkYXqRfPZl0aq1Ejo4y/l1E2PLb/C5MUyxs37xARea
        d5touan0LL3Igl/egACr47M=
X-Google-Smtp-Source: APXvYqwUvwaVg/NEeDGQ5s3ewPwwOXZjrkE007ZG6fFaraB6M9/880T6xeJPoy8WFduAy81+EqvUig==
X-Received: by 2002:a5d:620d:: with SMTP id y13mr12587225wru.86.1569848098680;
        Mon, 30 Sep 2019 05:54:58 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id v64sm13868550wmf.12.2019.09.30.05.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 05:54:57 -0700 (PDT)
Subject: Re: [PATCH 00/11] of: dma-ranges fixes and improvements
To:     Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Oza Pawandeep <oza.oza@broadcom.com>
References: <20190927002455.13169-1-robh@kernel.org>
 <106d5b37-5732-204f-4140-8d528256a59b@gmail.com>
 <40bdf7cf-3bb1-24f8-844d-3eefbc761aba@arm.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <807a4f96-cbda-da4d-a3f1-2bfe5788105b@gmail.com>
Date:   Mon, 30 Sep 2019 14:54:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <40bdf7cf-3bb1-24f8-844d-3eefbc761aba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/30/19 2:52 PM, Robin Murphy wrote:
> On 30/09/2019 13:40, Marek Vasut wrote:
>> On 9/27/19 2:24 AM, Rob Herring wrote:
>>> This series fixes several issues related to 'dma-ranges'. Primarily,
>>> 'dma-ranges' in a PCI bridge node does correctly set dma masks for PCI
>>> devices not described in the DT. A common case needing dma-ranges is a
>>> 32-bit PCIe bridge on a 64-bit system. This affects several platforms
>>> including Broadcom, NXP, Renesas, and Arm Juno. There's been several
>>> attempts to fix these issues, most recently earlier this week[1].
>>>
>>> In the process, I found several bugs in the address translation. It
>>> appears that things have happened to work as various DTs happen to use
>>> 1:1 addresses.
>>>
>>> First 3 patches are just some clean-up. The 4th patch adds a unittest
>>> exhibiting the issues. Patches 5-9 rework how of_dma_configure() works
>>> making it work on either a struct device child node or a struct
>>> device_node parent node so that it works on bus leaf nodes like PCI
>>> bridges. Patches 10 and 11 fix 2 issues with address translation for
>>> dma-ranges.
>>>
>>> My testing on this has been with QEMU virt machine hacked up to set PCI
>>> dma-ranges and the unittest. Nicolas reports this series resolves the
>>> issues on Rpi4 and NXP Layerscape platforms.
>>
>> With the following patches applied:
>>        https://patchwork.ozlabs.org/patch/1144870/
>>        https://patchwork.ozlabs.org/patch/1144871/
> 
> Can you try it without those additional patches? This series aims to
> make the parsing work properly generically, such that we shouldn't need
> to add an additional PCI-specific version of almost the same code.

Seems to work even without those.

-- 
Best regards,
Marek Vasut
