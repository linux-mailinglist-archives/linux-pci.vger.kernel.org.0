Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8714C282B28
	for <lists+linux-pci@lfdr.de>; Sun,  4 Oct 2020 16:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgJDOQ0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Oct 2020 10:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgJDOQV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Oct 2020 10:16:21 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0721C0613CE;
        Sun,  4 Oct 2020 07:16:20 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id u21so8221109eja.2;
        Sun, 04 Oct 2020 07:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IuA/GAjAfgWE3DtuJ5FygujATNMhP3IHAbVKTsDiIqA=;
        b=o/7HmuRKvHoJwhtWjEDPwsElHY8U67ts1L70GuxyQaLcoq/K9UwALWeYhgqgqR9gTh
         DlW3EGNRXkGb+il+Y75PVPVjxiY0CuAKmc2Wc+hY0N/FIbtd4hzjitl2fJjrKm82Usxl
         rsJzkn48QvukOqPjsNfH+xWFUYRhn8RTv1fRiaWIprigWm8nKBUSwXfQH3MH6slUHvuX
         KMsyAAl3KL+E9SuFqXeiB34hYyVoQ1we7X6IS0I4KkuFXL5zzIeBrdGRQMyy9CBR7QRM
         btqy6NzkoDxwiuNT4Zs9SqukWaYjm6l2e59cQUM0dAtPELXJxct9q5p7J9qxbzcino49
         46mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IuA/GAjAfgWE3DtuJ5FygujATNMhP3IHAbVKTsDiIqA=;
        b=cnK89Lau1gZOkW38a7cPd13OcU48lU9G0fbBKNQvTXkJ9VhFMlv2gKO4mpwSfJyM3f
         VdQBpJzLy9sGCrlbGDgEKobj+r76mSCBc0Kld9b18b9k6R0mL9TLxHG4ZGN0pO5rIpKQ
         QuYG/yhhma297+dmJzG9f03vexk/hqO3RZZFzYX+V8C3x8KZ6MOXXZwnT2XBbafiswvF
         TQa+ZfuESIhre30g8X+Ca35u0hyOk2qlCxpfccNDfumkWUoy9MI8B+6fO4F4nhAuouls
         h9GL5nbcTHihMRuYIDbUMrBJ44QdaLAVGdhGVDPdcTjBmSBsT8pUTlvqmGrLOpbpxzui
         s03Q==
X-Gm-Message-State: AOAM533HHrr19EwVWhVJyPJmQBSAervjFb23ZRhKk5VaXyaB1QrdjE3/
        Gbxnt6HLQfozoWk5YvFsItC3z4tBmLEd0g==
X-Google-Smtp-Source: ABdhPJxVcQBMVRxjCkWkpnQha2J49swvHCsFgusKO1kbA8gX1qmRU0waTa9C1FlR/6+79kPmYXHX3A==
X-Received: by 2002:a17:906:2301:: with SMTP id l1mr10643720eja.488.1601820979313;
        Sun, 04 Oct 2020 07:16:19 -0700 (PDT)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id j11sm3864780ejk.63.2020.10.04.07.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 07:16:18 -0700 (PDT)
Subject: Re: [PATCH V2] PCI: rcar: Add L1 link state fix into data abort hook
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20200926160934.136182-1-marek.vasut@gmail.com>
 <CAMuHMdURuSsYRwi10FT+s-rVjok0f-FgS6G8rmpg46u98scMkQ@mail.gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <1431d12a-0e19-6795-b2e0-fb652f8a95c1@gmail.com>
Date:   Sun, 4 Oct 2020 16:14:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdURuSsYRwi10FT+s-rVjok0f-FgS6G8rmpg46u98scMkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/28/20 11:35 AM, Geert Uytterhoeven wrote:
[...]
>> +static int __init rcar_pcie_init(void)
>> +{
>> +#ifdef CONFIG_ARM_LPAE
>> +       hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
>> +                       "asynchronous external abort");
>> +#else
>> +       hook_fault_code(22, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
>> +                       "imprecise external abort");
>> +#endif
> 
> As there can be only a single handler, this may interfere with a handler
> for another platform in a multi-platform kernel.
> Hence I think this should not be done unconditionally, but be moved to
> the driver's .probe() callback.

Why is nobody doing this in the probe code then ? It seems all the other
drivers which hook fault code do it in init as well. I can imagine that
something might trip the fault handler even before probe is called, e.g.
some PM handling or simply user accessing that PCIe area using setpci.

[...]
