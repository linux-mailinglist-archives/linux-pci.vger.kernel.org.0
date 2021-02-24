Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604363242AE
	for <lists+linux-pci@lfdr.de>; Wed, 24 Feb 2021 17:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbhBXQ4m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Feb 2021 11:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbhBXQz4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2021 11:55:56 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2555C061786;
        Wed, 24 Feb 2021 08:55:14 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d16so1570361plg.0;
        Wed, 24 Feb 2021 08:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sx6Ve1ZAgC7zpnSkPGaLyuXqgIMq03+1rZhqf02CyBE=;
        b=no7R2nT3HYyiyjOTvM2qMT8JGX7Curx4dR+cpYIDk91FgLHfT9sFJ6p+jtrpI8ffhg
         BBZdfJacTzC0lUlV1HnsSq53RJZyh3l+RdBgqJP1WZ2iId5UGtBGSuA012ZZknFFtdhn
         BS3BjYrYvVgNSQs+3RYCj//TFrY8q1lDUvpYpARCrPtF6pNIl8TK9lQw25w4iqPHWA/+
         /WQeNt4UYC2pE8qR/gjn/LMl4+DJz3SD8bfrq3us7Fs6oyragU9izIXnH0dR/Ekeo/3i
         g3aal2A/hyTowskiHKCk4UIYKT5dPhartziSCMp6wU2GMwT2oew+HSvp60F3AWNS+5an
         h1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sx6Ve1ZAgC7zpnSkPGaLyuXqgIMq03+1rZhqf02CyBE=;
        b=OnSuyxP18gM9ksJRn5PeBju6qRMPNIAXVmnfshDb7p0g7TZDVpvQRJsYoP0NaasGvO
         fcOb2R8xZYTzYbCtac7avHhj4AHDiJnt3c5IFyu4KcDWV2gzwE7Cay8iADsueb7NXOHk
         OQTP1SoxYR8WmBp96BnbPMh4f/fCahysy0uq1PZCWw/uMGX0/vMjxoL+byo7Rjz/MXMU
         80txq196naMF5LM2o1tCWflfVqnyveDvpttFsOAhEdQhvT6DbZ1J0z4dC4hZ5zIPVjEM
         Hms0PceREtPsytqc8ho9bT727uF2QRdY2EL4kehKd6cF50bim5CPYRq426Eq58OUQKdP
         5QMQ==
X-Gm-Message-State: AOAM5327nTNU6R0RerOXO1faE9l5RaCBVu4NwSnbnPmaEKArdilRfPhO
        FTLDZcV7EL+AimNMf2yObuKBLlAw6po=
X-Google-Smtp-Source: ABdhPJwiNZlWw9HVoKpnfJQqb1N5ze4o2nvh2VhP3EYTfFd2DKtJhfW+yvJjMawYI0hSSco6+b7ODg==
X-Received: by 2002:a17:90a:dc82:: with SMTP id j2mr5430372pjv.99.1614185714059;
        Wed, 24 Feb 2021 08:55:14 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t7sm3164666pgr.53.2021.02.24.08.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 08:55:13 -0800 (PST)
Subject: Re: RPi4 can't deal with 64 bit PCI accesses
To:     Robin Murphy <robin.murphy@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Robin Murphy <robin.murphy@arm.con>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
References: <c188698ca0de3ed6c56a0cf7880e1578aa753077.camel@suse.de>
 <2220c875-f327-586c-79c7-eadff87e4b4d@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6088038a-2366-2f63-0678-c65a0d2efabd@gmail.com>
Date:   Wed, 24 Feb 2021 08:55:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <2220c875-f327-586c-79c7-eadff87e4b4d@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/22/2021 8:56 AM, Robin Murphy wrote:
> On 2021-02-22 15:47, Nicolas Saenz Julienne wrote:
>> Hi everyone,
>> Raspberry Pi 4, a 64bit arm system on chip, contains a PCIe bus that
>> can't
>> handle 64bit accesses to its MMIO address space, in other words,
>> writeq() has
>> to be split into two distinct writel() operations. This isn't ideal,
>> as it
>> misrepresents PCI's promise of being able to treat device memory as
>> regular
>> memory, ultimately breaking a bunch of PCI device drivers[1].
>>
>> I'd like to have a go at fixing this in a way that can be distributed
>> in a
>> generic distro without prejudice to other users.
>>
>> AFAIK there is no way to detect this limitation through generic PCIe
>> capabilities, so one solution would be to expose it through firmware
>> (devicetree in this case), and pass the limitations through 'struct
>> device' so
>> as for the drivers to choose the right access method in a way that
>> doesn't
>> affect performance much[2]. All in all, most of this doesn't need to be
>> PCI-centric as the property could be applied to any MMIO bus.
> 
> It is indeed something that people can get wrong with internal buses as
> well - for example commit f2d9848aeb9f is such a workaround, also
> conveniently illustrating the case of significant functionality having
> to be disabled where the device *does* require 64-bit atomicity for
> correctness.
> 
> Working around kernel I/O accessors is all very well, but another
> concern for PCI in particular is when things like framebuffer memory can
> get mmap'ed into userspace (or even memremap'ed within the kernel). Even
> in AArch32, compiled code may result in 64-bit accesses being generated
> depending on how the CPU and interconnect handle LDRD/STRD/LDM/STM/etc.,
> so it's basically not safe to ever let that happen at all.

Agreed, this makes finding a generic solution a tiny bit harder. Do you
have something in mind Nicolas?
-- 
Florian
