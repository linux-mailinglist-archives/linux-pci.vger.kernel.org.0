Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB0D2D3170
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 18:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbgLHRqS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 12:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730646AbgLHRqS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2020 12:46:18 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0870C061749;
        Tue,  8 Dec 2020 09:45:37 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id x16so25783687ejj.7;
        Tue, 08 Dec 2020 09:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yvzI8/WCuRpDQuxHVx4+pIV6+cQEeFhC2G2HqUdaLy4=;
        b=GPMdvwivc3GbSV7jQ6gNgrNcjP65ZYTJaqIFKzHv/RVfLUD9mZhcdEV+VEnw9IEgI2
         OdUUTPyU0xdXyGTZVXn932T3CWYTZjLcC21saMyfI9as9iocRXWKWFWe2RmpNXfK94fu
         S61x2tsaWGpA1uQBVF8KeQ6hP/T9iL+/INu/eLZmK+NwiApRTkNVXDzuJCX0s+XjJgWC
         q6d3Gt3miR7yAuLaHNgRz/GEEv5pInh51PWTl+SSxIlmMxw1ImOvKvCZwzyVJf1oLBv9
         ca86Vob24hk1IjyN5j7mnd0DMJQEePEA9pJXVSCGmtTUg2SFBfZy0pigswYTBaDH2lFG
         kR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yvzI8/WCuRpDQuxHVx4+pIV6+cQEeFhC2G2HqUdaLy4=;
        b=nw4IYubMhcRQe6B06Xh+8wicOhgoYvx1mMp60clVnakTLA4RyPRVgBajKkdIThfT/z
         ngGKLd2dM3V0vbfJZht/M3j+4jyAzZPH3uh1mWLs575tCikPfLGvrWdPNImuRHuorSao
         dDhc9p92Um/LBc7bQ3rJ6CCQIOnP0tSLF4TAtJgor7+AgPQSUhlYdhpEYzSc4FJkJVjc
         0QcGUEHKwH4SgYxzBxb91iKIrGuSuOVadwe87ctVMGlBXwvfd8iAopDRMhmPoOVUF4ed
         1QP94EohMqhMGlvN+n8hzqwxppljWXgiVCvyy2qgL/yWxtmi57MssmcYn+UoFgE1C9nU
         8nLQ==
X-Gm-Message-State: AOAM533qN4hfWYv00tQ7rRvIP1HjtWA3pdRoMFMhPNbpxc/fb08xoSao
        KGZ2hVUMOV13JpPFDr7JsPSo8Nxby4gqPg==
X-Google-Smtp-Source: ABdhPJyCTLVlXyRMGgkSW1b2JaYZGDsPsPyWNurIsaCqKg4YMeEs+L54Cyy0pCr6Hkq82hLwq7CQ2Q==
X-Received: by 2002:a17:907:447d:: with SMTP id oo21mr24494172ejb.367.1607449536353;
        Tue, 08 Dec 2020 09:45:36 -0800 (PST)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id a12sm17466699edu.89.2020.12.08.09.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 09:45:35 -0800 (PST)
Subject: Re: [PATCH V4] PCI: rcar: Add L1 link state fix into data abort hook
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20201016120416.7008-1-marek.vasut@gmail.com>
 <20201119173553.GB23852@e121166-lin.cambridge.arm.com>
 <57358982-ef8c-ed91-c011-00b8a48c4ebd@gmail.com>
 <20201208101823.GA30579@e121166-lin.cambridge.arm.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <529ff24a-dcb5-6c9e-2825-b2fbd0fbcd70@gmail.com>
Date:   Tue, 8 Dec 2020 18:45:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201208101823.GA30579@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/8/20 11:18 AM, Lorenzo Pieralisi wrote:
[...]
>>> I suppose a fault on multiple cores can happen simultaneously, if it
>>> does this may not work well either - I assume all config/io/mem would
>>> trigger a fault.
>>>
>>> As I mentioned in my reply to v1, is there a chance we can move
>>> this quirk into config accessors (if the PM_ENTER_L1_DLLP is
>>> subsequent to a write into PMCSR to programme a D state) ?
>>
>> I don't think we can, since the userspace can do such a config space write
>> with e.g. setpci and then this fixup is still needed.
> 
> 
> Userspace goes via the kernel config accessors anyway, right ?

As far as I can tell, you can just write the register with devmem, so 
no. You cannot assume everything will go through the accessors. I don't 
think setpci does either.

> I would like to avoid having arch specific hooks in PCI drivers so
> if we can work around it somehow it is much better.

I think we had this discussion before, which ultimately led to hiding 
the workaround in ATF on Gen3. On Gen2, there is no ATF, so the work 
around must be in Linux.

> I can still merge this patch this week but I would like to explore
> alternatives before committing it.

Please merge it as-is.
