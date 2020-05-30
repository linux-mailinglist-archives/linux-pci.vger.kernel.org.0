Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DFE1E8E31
	for <lists+linux-pci@lfdr.de>; Sat, 30 May 2020 08:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgE3Gd7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 30 May 2020 02:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgE3Gd7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 May 2020 02:33:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA17C03E969;
        Fri, 29 May 2020 23:33:58 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e1so6283617wrt.5;
        Fri, 29 May 2020 23:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gW/FZE6q5oj2sxtuDtz4g00RRdOKFAShl0dwbYvRAAk=;
        b=HYJI8j+jtLKfhkp88J0NnTNLRtDgxbGZvDEyGeUkc3mA9A8Xk5g1wp979jIVnP89Tw
         Yui5fnLdHhbsNjI+exy8meHwdP04zsLso7H1pNh6nvkX2cfMqUQ0A8iPKiQFTt3ILY3c
         ycuzXxMORwnn2PgdO/RtkkiAeiRQnMOaI0gobNWE5gNu52PkVBBuV/fBeB9bVvGV0JpF
         f4Pf+2NfQtat5MtpdE3TGoInB7oDtFWwer5BrXg3Xu1H3xtVfuKycQKa21z51dzc3MNe
         YvJNtZybpqW6gIRJQCHiO+yWa+n3FCJR13SRBzJok9TxTbK4JnJ/+OLd5SLHj6iMpyOY
         Q4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gW/FZE6q5oj2sxtuDtz4g00RRdOKFAShl0dwbYvRAAk=;
        b=kDs6jeTra52LIqvaYouK+bvvM3tpSfnOXhIh59i2N50ilPR05xRzLixhgRKA001yZ9
         1ntDxgJNggbxN4gkYDPjw08kPIOiOHb3SmRCNNtkUoXhecXEtTnR4Pfa7sNerwSi1EZl
         NL5SHU5pgkeoXlt1OvnRG1u5fzV8Mz0CHPymI2qE23bXeK2WgTaKr9I+OBa9GYqeZQeU
         zQPQdNN7j39XzBiV2lWFoYUqcVg5yWM854zfvgtQ7UfRXscL41N1g/9u0Ma2KjWNABpi
         vGT2BaYdb/7Y9ihSHJY/OGKzTNan5Os8pnia7yVGdWe56m8wSgHrJj2ZJ2mDdKo0Mv2a
         BfEg==
X-Gm-Message-State: AOAM532g6oiKUHsokdeHNaSbyvnyFCCfTtqgwcStt2y+/YJrR4aAWuUU
        LNy2mass5/utIhQjy/DDqtMCujA9
X-Google-Smtp-Source: ABdhPJyNfdIFJKGNxG0jcc76V+H+fL2KydwatgVRbXcm/IBQ0JQp1oMo6gmhNhmMps0nrHWtSFI5tg==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr11851190wrv.174.1590820437383;
        Fri, 29 May 2020 23:33:57 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f23:5700:e4f5:72c7:87fa:d045? (p200300ea8f235700e4f572c787fad045.dip0.t-ipconnect.de. [2003:ea:8f23:5700:e4f5:72c7:87fa:d045])
        by smtp.googlemail.com with ESMTPSA id v7sm2519252wme.46.2020.05.29.23.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 23:33:56 -0700 (PDT)
Subject: Re: Lost PCIe PME after a914ff2d78ce ("PCI/ASPM: Don't select
 CONFIG_PCIEASPM by default")
To:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <bdc33be8-1db6-b147-cbc4-90fa0dc3d999@gmail.com>
 <20200529202135.GA461617@bjorn-Precision-5520>
 <20200529205900.whx3mxuvt6ijlqwg@srcf.ucam.org>
 <824d63d8-668c-22c8-a303-b44e30e805e1@gmail.com>
 <20200529225801.szl4obsas6ndilz4@srcf.ucam.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <7c8cab08-e2d4-1952-1923-aa023ea67657@gmail.com>
Date:   Sat, 30 May 2020 08:33:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200529225801.szl4obsas6ndilz4@srcf.ucam.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30.05.2020 00:58, Matthew Garrett wrote:
> On Sat, May 30, 2020 at 12:26:17AM +0200, Heiner Kallweit wrote:
>  
>> Current situation means that PME is unusable on all systems where
>> pcie_aspm_support_enabled() returns false, what is basically every
>> system except EXPERT mode is enabled and CONFIG_PCIEASPM is set.
>> So we definitely need to do something.
> 
> CONFIG_PCIEASPM is default y. I don't think there's huge value in 
> adding complexity to deal with it being disabled, given that the kernel 
> is then in a configuration that no vendor is testing against. There are 
> existing runtime mechanisms to disable it at runtime.
>  
> 
It *was* default y. This changed with a914ff2d78ce ("PCI/ASPM: Don't
select CONFIG_PCIEASPM by default") and that's what triggered the
problem. If there's no easy solution, then maybe it's best to revert
the change for now.
