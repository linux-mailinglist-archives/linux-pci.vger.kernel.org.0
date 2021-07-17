Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22363CC539
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jul 2021 20:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbhGQSTG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Jul 2021 14:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbhGQSTF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Jul 2021 14:19:05 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429DBC061762;
        Sat, 17 Jul 2021 11:16:07 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso10135426wmh.4;
        Sat, 17 Jul 2021 11:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ehuacrsuMdw3ygvYbFrzQAQ54kh2HQeMKN3gD1G8z+U=;
        b=Nb5VvJgfneGO/G+bdkhc9N5rMBAxari3skk+QcqSEuPiXkfe6K07RqI0Wpwu6JeAtB
         H7sgoBAMcpwoWESQQE2fLftWggE/7m3lNPdzBJX27bdnLDVJ2DRRJV/oCwfXFxO72e5Y
         46kICeF5ocbSRZAZmddDnEa/ncB0iNspfHzO3BOS+ldjaHoHk6U/fpGArEsk9uDNUMJK
         TSRODU1+Bn7tI97fkHzmErtjnvT16JHcrN+jCB7eK92kVdMaKJTrdwA/vXrBY8Jn8bWj
         0Qaz7wXZmZ3rzCCphR/wkDPM2kqEXQKX4Mu+Agcer8Uc3WAwYMdjV/x3A43y4Sd+//Pt
         m95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ehuacrsuMdw3ygvYbFrzQAQ54kh2HQeMKN3gD1G8z+U=;
        b=L9UUh+Ywm9UjhhTARz+1pimTbFaHgAouHiLmAotNlIABbaa+NIsaAC8UZBEQI3ReU6
         IRwosePnoOALTByymIjnXycmpVl2yEzoz11x0lQ20stenRKNGgRLgCJovXahT4JNjh+w
         4RUP8B4/jgVOXtO1pfTjTGjARsACAkTh3fjSQdi4UMkoc7pq0f2RDS8bT9WfcWjFxk8y
         XFd9F/srgdKiggVxipEBeW3wSvsFn5Zj7m49bAs6909HDcmO91RGC/zBC6nkzsppSUS6
         HembauI46F7gT9UO35haMuRsgt4JxEl8UOjRpD5Ju/dCieFBF6ADzY7UFQ8PIr/QcNy9
         WWwA==
X-Gm-Message-State: AOAM530JPCAqCJVzxF845+pDKxMtjlR76IgqN5oMpwQC1pL98uA0Yf5F
        ArEPRX7RGcuQaBUMp3EjAfZKxJxpY00=
X-Google-Smtp-Source: ABdhPJyZ6bm6lxYhybCMhlRpJgSdyArUypy4ayj+uNLIYMdz8H+5dm/WNFw/nf4JazLc5a1tI2eeCg==
X-Received: by 2002:a05:600c:4401:: with SMTP id u1mr3080320wmn.49.1626545765857;
        Sat, 17 Jul 2021 11:16:05 -0700 (PDT)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id d29sm17716495wrb.63.2021.07.17.11.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jul 2021 11:16:05 -0700 (PDT)
From:   Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH V6] PCI: rcar: Add L1 link state fix into data abort hook
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20210717173334.GA2232818@bjorn-Precision-5520>
Message-ID: <19265a67-20e0-f049-ee75-6ce3caa184ad@gmail.com>
Date:   Sat, 17 Jul 2021 20:14:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210717173334.GA2232818@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/17/21 7:33 PM, Bjorn Helgaas wrote:
[...]

>> Note that this fixup is applicable only to Aarch32 R-Car controllers,
>> the Aarch64 R-Car perform the same fixup in TFA, see TFA commit [1]
>> 0969397f2 ("rcar_gen3: plat: Prevent PCIe hang during L1X config access")
>> [1] https://github.com/ARM-software/arm-trusted-firmware/commit/0969397f295621aa26b3d14b76dd397d22be58bf
> 
> This patch is horribly ugly but it's working around a horrible
> hardware problem, and I don't have any better suggestions, so I guess
> we don't really have much choice.
> 
> I do think the commit log is a bit glib:

Should I reword the commit message one more time and send V7 ?

>    - "The R-Car PCIe controller is capable of handling L0s/L1 link
>      states."  AFAICT every PCIe device is required to handle L0 and L1
>      without software assistance.  So saying R-Car is "capable" puts a
>      better face on this than seems warranted.
> 
>      L0s doesn't seem relevant at all; at least it doesn't seem to play
>      a role in the patch.  There's no such thing as "returning to L0s"
>      as mentioned in the comment below; L0s is only reachable from L0.
>      Returns from L1 only go to L0 (PCIe r5.0, fig 5-1).
> 
>    - "The problem is, this transition is not atomic."  I think the
>      *problem* is the hardware is broken in the first place.  This
>      transition is supposed to be invisible to software.
> 
>    - "Just like other PCI controller drivers ..." suggests that this is
>      an ordinary situation that we shouldn't be concerned about.  This
>      patch may be the best we can do to work around a bad hardware
>      defect, but it's definitely not ordinary.
> 
>      I think the other hook_fault_code() uses are for reporting
>      legitimate PCIe errors, which most controllers log and turn
>      into ~0 data responses without generating an abort or machine
>      check, not things caused by hardware defects, so they're not
>      really comparable.
> 
> Has Renesas documented this as an erratum?

They are aware of this.

> Will future devices
> require additions to rcar_pcie_abort_handler_of_match[]?

No, this change is for legacy arm32 SoCs only.

> It'd be nice if the commit log mentioned the user-visible effect of
> this problem.  I guess it does mention external aborts -- I assume you
> see those when downstream devices go to D3hot or when ASPM puts the
> link in L1?  And the abort results in a reboot?

It results in a hang.

> To be clear, I'm not objecting to the patch.  It's a hardware problem
> and we should work around it as best we can.

[...]
