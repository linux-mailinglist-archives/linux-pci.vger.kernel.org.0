Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34EBF282B25
	for <lists+linux-pci@lfdr.de>; Sun,  4 Oct 2020 16:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgJDOQV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Oct 2020 10:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgJDOQU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Oct 2020 10:16:20 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F27C0613CE;
        Sun,  4 Oct 2020 07:16:20 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l24so6666962edj.8;
        Sun, 04 Oct 2020 07:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nk55SPUM9RHc7m+tJtoUiO1lBW1OPPh/kv5Dcob7pWg=;
        b=igbWmR7RHK6gXQEWxWfyvQq3FaEV67cFpaZCGMe7nU89pUvZtc1maigYA2eX8nQfcm
         1M0TWKDsdn3PfXjX+v43gNZBiAkZOXn3RHfjweLtQFzWgcvb18WFJ3+mFAZBovWUuv7u
         5MEVDeKhjxBXMZnv/9aL6nswHfduvzswOf5kRhfzZXMMt5EjwQlTaDdIDQEvOslYvHAP
         l+AzL1ehi6a3Ecathn0vn1r5PmzyTAUT8hcYiO04fVAvrqYRlK/HnXMnDC5PdD3LINFh
         qeRydzVCuuijpktKQuIA8duYHFzRW1aQm7M7Hqu8VSq+VhVrikI0FhgDLAvHoqI/RYXn
         kBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nk55SPUM9RHc7m+tJtoUiO1lBW1OPPh/kv5Dcob7pWg=;
        b=qFFXoXZVTtgFnhOuhu5aeAHa1A42o1d8uGT1YH1dUtVSaAEKb2HXqKPUXlTUfZVt4h
         4X6c0YzQGkxncShfnbSdHaE/EkOjjwtK/WyM73uC5FemaXQnyjrprRu3pAGLN/C/jhAP
         UUoN8pARNpKOcsHJ2oB4DeStzKHSqEG1ajZdqsU2renk+7e159WWOUd3JOcYEfb4gl4h
         FnIueybdwovdhiXnfDVcG8m8gF+JJnH4JYAY5IVWefT4CkBKaN0nBaXldeHSIx4GjaO+
         sdFuAqrK1pwhYnoutqBExG65xxu0G0Dh79hlhRLklF2JuXYQkAIHGIen0UQwHLSM3mc6
         jiNA==
X-Gm-Message-State: AOAM532ml9W4AArnoix90FaCoIaY9dpnaf067lI6XASfYoAGlROuw8EJ
        0wBcbRp1HYbnhypEOMYSmp0+BwrQ0wyrDQ==
X-Google-Smtp-Source: ABdhPJzMWETfHNxS1+oldFfgpAHoR7U3mTMvXJfaY7hXnzlQGi9iDgUYOxkOW7FtyXBE208NQKmKJw==
X-Received: by 2002:a50:cdd1:: with SMTP id h17mr12831425edj.94.1601820977450;
        Sun, 04 Oct 2020 07:16:17 -0700 (PDT)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id p24sm1256489edq.35.2020.10.04.07.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 07:16:16 -0700 (PDT)
Subject: Re: [PATCH V2] PCI: rcar: Add L1 link state fix into data abort hook
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20200926160934.136182-1-marek.vasut@gmail.com>
 <7ce58972-2946-0107-2298-c5a6f6e12feb@gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <a7af4067-d585-2e5e-cb1d-12954250dfd1@gmail.com>
Date:   Sun, 4 Oct 2020 16:10:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <7ce58972-2946-0107-2298-c5a6f6e12feb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/27/20 10:29 AM, Sergei Shtylyov wrote:
[...]
>> the ARM 'imprecise external abort' handler is invoked.
>>
>> Just like other PCI controller drivers, here we hook the fault handler,
>> perform the fixup to help the controller enter L1 link state, and then
>> restart the instruction which triggered the fault. Since the controller
> 
>    If this is imprecise or async external abort, how we can re-execute
> the instruction that triggered the fault? It's been probably executed
> already, no?

It has been executed and triggered the fault, because it could not
access the data across the bus. Now the bus is back in operational
state, so restart the instruction, let it access the data and do its task.

[...]
