Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2265F32454F
	for <lists+linux-pci@lfdr.de>; Wed, 24 Feb 2021 21:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbhBXUgH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Feb 2021 15:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbhBXUfw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2021 15:35:52 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DFEC06174A;
        Wed, 24 Feb 2021 12:35:11 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id a4so2244954pgc.11;
        Wed, 24 Feb 2021 12:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dwXPld6nOFTuWhGOerwlEGswoQzrvgmRePkazAcWQqg=;
        b=IjoI7O3Mos8SKOm8G0+dZwI3mHT0NnTmZ+KzR1JMJ8kQEs2C3zC4a0HYaF9cSKWiws
         WWQU0rC6h86wT+o2wSb2m3qG6KgxaJQEU2UW7FrIyxcNaOXfhSukTT5pQYcDyPyr0KbD
         B8YyEwO2b7wZse1DlQDhTCPxqMvM3iyXD1oynvfmqJ3haQgm+D0MSwvsgMeDLMeYof5H
         fcRlPBkxw5wyUD6xxWbWysQ9H/NhBnQujJ1gznR+8ur0LdtsGx0S8CO26T/4pOcOJ6Cg
         0OPBLrt7j7Ts/H6U/imw/aJMlek+r2ZTLSY5GAJAWL5vduZfjlABAG0hv33bONfhNWW0
         A7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dwXPld6nOFTuWhGOerwlEGswoQzrvgmRePkazAcWQqg=;
        b=faqitTdOzE6va3vTDhepsS/DTs2y4G0df9YIWL1gCb8xX9xnbMRqlgMlf2xuuBdKDz
         ozDmojQlrrLRTuOweBamDfDiG6hqCq7LNhONXwaSU0j5GrBXKBYoxE30JfvKTG8p+OVS
         UZjWgTz6VGVE5GiItQbfCEcLhbINEA952SmERFao7fpZCuA0iz7OQ8pSDgQZHSFefy8s
         mR3REJ5tl9HUQfwkn61gqq4o/dRQkcxUF6npua6eA33jxxvRr4ikntBPK+U0LEfTx3b0
         LztLTcyrUrdEQ92F165ymxoscoXitrgY2L5kgAlvQrcRHN4ZD68QwsbWq3EIeFREj3R0
         SlcQ==
X-Gm-Message-State: AOAM53396nDcsu4aetCvxbdjKuvbgXJCo0bJHgfDg6lqbyKtII2P9ZOM
        NIk5tUHmMn9U/XF8PdAXTHc=
X-Google-Smtp-Source: ABdhPJwMGFqprrKsSadO7Fa8Tetxr6OGipXG6UdixtyBdjTZdyyn83sA0z9A+UX5QU89Eag5Eq0iqQ==
X-Received: by 2002:aa7:98ca:0:b029:1ed:4469:f03c with SMTP id e10-20020aa798ca0000b02901ed4469f03cmr8754741pfm.78.1614198911280;
        Wed, 24 Feb 2021 12:35:11 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6sm3272890pgv.70.2021.02.24.12.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 12:35:10 -0800 (PST)
Subject: Re: RPi4 can't deal with 64 bit PCI accesses
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Robin Murphy <robin.murphy@arm.con>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
References: <c188698ca0de3ed6c56a0cf7880e1578aa753077.camel@suse.de>
 <2220c875-f327-586c-79c7-eadff87e4b4d@arm.com>
 <6088038a-2366-2f63-0678-c65a0d2efabd@gmail.com>
 <20210224202538.GA2346950@infradead.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <0142a12e-8637-5d8e-673a-20953807d0d4@gmail.com>
Date:   Wed, 24 Feb 2021 12:35:07 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210224202538.GA2346950@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/24/2021 12:25 PM, Christoph Hellwig wrote:
> On Wed, Feb 24, 2021 at 08:55:10AM -0800, Florian Fainelli wrote:
>>> Working around kernel I/O accessors is all very well, but another
>>> concern for PCI in particular is when things like framebuffer memory can
>>> get mmap'ed into userspace (or even memremap'ed within the kernel). Even
>>> in AArch32, compiled code may result in 64-bit accesses being generated
>>> depending on how the CPU and interconnect handle LDRD/STRD/LDM/STM/etc.,
>>> so it's basically not safe to ever let that happen at all.
>>
>> Agreed, this makes finding a generic solution a tiny bit harder. Do you
>> have something in mind Nicolas?
> 
> The only workable solution is a new
> 
> bool 64bit_mmio_supported(void)
> 
> check that is used like:
> 
> 	if (64bit_mmio_supported())
> 		readq(foodev->regs, REG_OFFSET);
> 	else
> 		lo_hi_readq(foodev->regs, REG_OFFSET);
> 
> where 64bit_mmio_supported() return false for all 32-bit kernels,
> true for all non-broken 64-bit kernels and is an actual function
> for arm64 multiplatforms builds that include te RPi quirk.
> 
> The above would then replace the existing magic from the
> <linux/io-64-nonatomic-lo-hi.h> and <linux/io-64-nonatomic-hi-lo.h>
> headers.

That would work. The use case described by Robin is highly unlikely to
exist on the Pi4 given that you cannot easily access the PCIe bus and
plug an arbitrary GPU, so maybe there is nothing to do for framebuffer
memory.
-- 
Florian
