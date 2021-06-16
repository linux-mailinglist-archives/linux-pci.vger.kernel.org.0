Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34EC63A9538
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 10:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbhFPIoj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 04:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbhFPIoi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jun 2021 04:44:38 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DE5C061574
        for <linux-pci@vger.kernel.org>; Wed, 16 Jun 2021 01:42:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o88-20020a17090a0a61b029016eeb2adf66so3357220pjo.4
        for <linux-pci@vger.kernel.org>; Wed, 16 Jun 2021 01:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=aA4TkrJs6ajMyY8FqDMerCmGUu0LZcHfxFM5uF3oKpQ=;
        b=wCR38/vMYc2wU32kBUYEjbdZJMrPoovqwhEHrfRa1+I9ACdqfzRDejU5tQd4ww5QcZ
         k0b04MZfvPXR0kEeqvB7Vc8KoFtUsXsbj+dPFd2f5qBIYhV0Hf8RKtoH9p0qMvR2v/jh
         8XGrCFdn9gHsctaNNUunzjruwNIXu3DvOtbG7kpKVLt4NDESUsK+2GhQK2cxvmMyTBAX
         e8RLff4fM+9Idv6KQjwEO8chMz2+jwEmm9w4oKE0uC+ZTL+iYh2BGAB24CIej9uIZLCz
         bo9qL8j7tpfWZkscNlH7mR/311TXxrneINKAHp85p1zvOdXPXzFuKHtgDfcUTeH7QWva
         dSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=aA4TkrJs6ajMyY8FqDMerCmGUu0LZcHfxFM5uF3oKpQ=;
        b=oqSshack9N3nityxdUV50LBYqNbi4ISqi5nO8mFq1J7HXBOSDyk5WrCn4TVEM4CkB6
         OX2aNXzoS/fEV1ornte95YHgTPKn06a5bawlH3JiDI9jxHU4S8B3MPTblmyxM88w1jVi
         C4qJ1krOcxf7M9AobOjr0gLbKZXVxWZtnSz6FtwkgI5h2OXyY56+AL93O3tcIbrbsm79
         HGE4rXYwy4LrukCm2DJWSG/1aGOognqGjIGhxvggRDJYqKIHC2GcciF4qtoFYRtkrzvn
         mo0PvRav9A2y/fU9tOQepp8RWBYBXo6ltKm5s5HVTeXnNNAsfRhbdlCgchwvdTtywmR2
         GoMw==
X-Gm-Message-State: AOAM530BEwy2t6AkOjAEOuCHxgkMdTvuRyQnjn9ohxdDD2vTGTyJh3jT
        VGobkkXd9engXgZu2k0giKwAkQ==
X-Google-Smtp-Source: ABdhPJww73zHlet1KdkQFMlG4TuT3HggFDxOPgLGCkIG5dpGaj8DGGOF/gCVGGKjgfcYlVK5QaWsyg==
X-Received: by 2002:a17:903:1043:b029:11e:7489:9bad with SMTP id f3-20020a1709031043b029011e74899badmr3088065plc.34.1623832952255;
        Wed, 16 Jun 2021 01:42:32 -0700 (PDT)
Received: from [10.43.1.6] ([45.135.186.89])
        by smtp.gmail.com with ESMTPSA id p1sm1461370pfn.212.2021.06.16.01.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 01:42:31 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] PCI: Add a quirk to enable SVA for HiSilicon chip
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1623209801-1709-1-git-send-email-zhangfei.gao@linaro.org>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <18e171fe-549b-6fa3-c9a0-c0d869b53445@linaro.org>
Date:   Wed, 16 Jun 2021 16:42:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1623209801-1709-1-git-send-email-zhangfei.gao@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn

On 2021/6/9 上午11:36, Zhangfei Gao wrote:
> HiSilicon KunPeng920 and KunPeng930 have devices appear as PCI but are
> actually on the AMBA bus. These fake PCI devices have PASID capability
> though not supporting TLP.
>
> Add a quirk to set pasid_no_tlp and dma-can-stall for these devices.
>
> Jean's dma-can-stall patchset has been accepted
> https://lore.kernel.org/linux-iommu/162314710744.3707892.6632600736379822229.b4-ty@kernel.org/

Would you mind take a look.
There is no dependence now, since he dependent patch set has been taken.

Thanks

>
> v4:
> Applied to Linux 5.13-rc2, and build successfully with only these three patches.
>
> v3:
> https://lore.kernel.org/linux-pci/1615258837-12189-1-git-send-email-zhangfei.gao@linaro.org/
> Rebase to Linux 5.12-rc1
> Change commit msg adding:
> Property dma-can-stall depends on patchset
> https://lore.kernel.org/linux-iommu/20210302092644.2553014-1-jean-philippe@linaro.org/
>
> By the way the patchset can directly applied on 5.12-rc1 and build successfully though
> without the dependent patchset.
>
> v2:
> Add a new pci_dev bit: pasid_no_tlp, suggested by Bjorn
> "Apparently these devices have a PASID capability.  I think you should
> add a new pci_dev bit that is specific to this idea of "PASID works
> without TLP prefixes" and then change pci_enable_pasid() to look at
> that bit as well as eetlp_prefix_path."
> https://lore.kernel.org/linux-pci/20210112170230.GA1838341@bjorn-Precision-5520/
>
> Zhangfei Gao (3):
>    PCI: PASID can be enabled without TLP prefix
>    PCI: Add a quirk to set pasid_no_tlp for HiSilicon chips
>    PCI: Set dma-can-stall for HiSilicon chips
>
>   drivers/pci/ats.c    |  2 +-
>   drivers/pci/quirks.c | 27 +++++++++++++++++++++++++++
>   include/linux/pci.h  |  1 +
>   3 files changed, 29 insertions(+), 1 deletion(-)
>

