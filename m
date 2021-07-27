Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7026A3D6F9F
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jul 2021 08:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhG0Grl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jul 2021 02:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbhG0Grl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jul 2021 02:47:41 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47C6C061757
        for <linux-pci@vger.kernel.org>; Mon, 26 Jul 2021 23:47:41 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso3522904pjf.4
        for <linux-pci@vger.kernel.org>; Mon, 26 Jul 2021 23:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=65KIbsnpzYM5mfPE0TJvCN9EOvry3vUT+u5Kpu/73IQ=;
        b=ehrjQ0FZwr1OclBYEjPGrrj+AX19htMeLZGrqcS4cMQUfWKN/jtvBldUThYlOM56o8
         EGwGgwztsKeheznf/n2YGbMhfMbSmsaJSDxhQuHvyv0gx8FgoeYc4UHoKECVQbIMwiAQ
         mImR9vEMZJuQc8Ak6v/z4OtlhXLj5bBUBtNOFtQcysJpQwB7qUzvT0p1T8wzanrSb0oA
         t0RViL780nR0PB4bwsbMNtPaxIBHLd72cH67BES0hpP0i2Vd0IiJg71ZWyogM4v0C/tU
         63xKwHqDYHTo6n0Wy2LuQXbvPKGMEds68I51sIJqWsZwaHLTAf9URb7XtshDvAzJwCcv
         SfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=65KIbsnpzYM5mfPE0TJvCN9EOvry3vUT+u5Kpu/73IQ=;
        b=fXAj0g4nGtmt4MIevuGJ075J8AVE3FmMVObsnv3r03j+kduior9QrPBjPvEzIHsYpZ
         z6ek6/Beqm4de7//FF8SKpgVK382sQr3uyBEQRd0yJXQn0hAcFnEQlwjMSi50P3gnn7R
         5eDh+xleVPxk/HNfUQaKlJKbsHlxsholXrd0BVhpnNl7LF8QuFbv7V7PnpY8gqsTNc6G
         JqrAhaCB0BNQWHaAr91Bjt3JZNNIXE49B2oJ1FuN5f4rLntgELpiec+GjuaCLNZLkp1X
         agU2egHn6C4nEYH9QlKuUDiK/AK1KC1AICwupBJSTcxcOmfeLhsjWXvYtR54iW+YosDI
         NEsw==
X-Gm-Message-State: AOAM532R3bu0n9MmBKEkc07uCSdsAzMiC44d2+pj6ui+L2XyGyN9acEb
        1U25iV/gHBHiJL85Mzj+j3M/Zg==
X-Google-Smtp-Source: ABdhPJx2NgTnKjWvVaPBpx8p56jc+dx3eBcjIThy5Nd30T+2v0KiLSAlChhqo/PBOXXsDbVnTVWkpQ==
X-Received: by 2002:a17:90a:d486:: with SMTP id s6mr21513447pju.142.1627368461272;
        Mon, 26 Jul 2021 23:47:41 -0700 (PDT)
Received: from [10.193.0.222] ([45.135.186.130])
        by smtp.gmail.com with ESMTPSA id q14sm2311937pfn.73.2021.07.26.23.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 23:47:40 -0700 (PDT)
Subject: Re: [PATCH v5 0/3] PCI: Add a quirk to enable SVA for HiSilicon chip
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1626144876-11352-1-git-send-email-zhangfei.gao@linaro.org>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <1796ac2a-b068-467e-804e-163f9e1f3c41@linaro.org>
Date:   Tue, 27 Jul 2021 14:47:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1626144876-11352-1-git-send-email-zhangfei.gao@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn

On 2021/7/13 上午10:54, Zhangfei Gao wrote:
> HiSilicon KunPeng920 and KunPeng930 have devices appear as PCI but are
> actually on the AMBA bus. These fake PCI devices have PASID capability
> though not supporting TLP.
>
> Add a quirk to set pasid_no_tlp and dma-can-stall for these devices.
>
> v5:
> no change, base on 5.14-rc1

Would you mind take a look at this patchset.
We need the quirk to enable sva feature of devices on HiSilicon 
KunPeng920 and KunPeng930.

Thanks

