Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B9C331D50
	for <lists+linux-pci@lfdr.de>; Tue,  9 Mar 2021 04:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhCIDJR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 22:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhCIDJA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Mar 2021 22:09:00 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE1DC06174A
        for <linux-pci@vger.kernel.org>; Mon,  8 Mar 2021 19:08:49 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id t9so99077pjl.5
        for <linux-pci@vger.kernel.org>; Mon, 08 Mar 2021 19:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1f54qJQKKtvlakY95tjpl5zo+WDWW7TdvI10megSvQE=;
        b=K/muuUVkZlrwNYYBFXG/K8BvAX+eeomCZVKSDtUf1wyuXmVKtXNEwT0QVrOI6NOXDd
         JaxVuGQ8rFg91vZsfsdOfdcTysBCTbs8bPX+EZwmC3PRtoltUvQUFOQm6ppqrTFL7KXv
         dVCq8ikrum1zCtGIamk85s3/X2hd1tjdMPVlb9Kc0qOqDl6+zgnezTW2HrpKcgCmPY/f
         ZBiAwa9XJecyt3b+F+7RHz+tnTfnMqSc0+/16ZhU1UaC2gy36oAK3Cbb9Zyqcab8U2WS
         0hxIAeKnce0ru+/oDSLcFTJPltPQX3BES5KHoWw/UEMCXFpSh9RdrHaA4L+14/uLFcxn
         6wKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1f54qJQKKtvlakY95tjpl5zo+WDWW7TdvI10megSvQE=;
        b=f0GPocn/EAFK7CQaIDEtl3ygSiyCXimnD1Itu3BhioSoJLNgKue6TWLdYCVfedSxPH
         afD8LD/b/EIfhmZHD0a8p9ILhzbkrsDyPogdwoAdOUJ9amarpu3qApfu525f8EbnYIAX
         B0hJcyceKVLMnuAkX0axQAee15t+1z0zY2B6x/MQQ0e9FMDt0tuqymODyzaegaqR+tpo
         vAPkmnP0g9omaZaYtqBNyHdHhEWGjcMBUIztUQD5XxswrkHhPCU88pTJJcmhnVydhtp5
         I7Wt8WJNjF6PyXEpWIRwZs01b67neeOJ7DyojVu+dD953PrSre2luVm8y/wDKaLb00mO
         omtA==
X-Gm-Message-State: AOAM5318Aw7JXIoh7+ShIxeEM+MYvbcVyQTueeknRqgtVYSZDM9eNfFt
        kbYlrUAsVej7qhnlHzRSTAl95A==
X-Google-Smtp-Source: ABdhPJylK1/BB4HJp6U0wF+YbvVUYcsRPBJUM0OMsvdfCXHQzCdFZwmUG2DGdRD9eO7phoeVXivXag==
X-Received: by 2002:a17:90a:5d09:: with SMTP id s9mr2230559pji.172.1615259329130;
        Mon, 08 Mar 2021 19:08:49 -0800 (PST)
Received: from ?IPv6:240e:362:435:6a00:e593:6e0:bfb4:a65f? ([240e:362:435:6a00:e593:6e0:bfb4:a65f])
        by smtp.gmail.com with ESMTPSA id n24sm11395920pgl.27.2021.03.08.19.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 19:08:48 -0800 (PST)
Subject: Re: [PATCH v2 3/3] PCI: set dma-can-stall for HiSilicon chip
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, wangzhou1@hisilicon.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1610960316-28935-1-git-send-email-zhangfei.gao@linaro.org>
 <1610960316-28935-4-git-send-email-zhangfei.gao@linaro.org>
 <YEUTTEHYx0ZxB3Ia@rocinante>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <6608a986-5bb8-5c49-03b2-8af47d63ae1e@linaro.org>
Date:   Tue, 9 Mar 2021 11:08:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YEUTTEHYx0ZxB3Ia@rocinante>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Krzysztof

On 2021/3/8 上午1:54, Krzysztof Wilczyński wrote:
> Hi,
>
> [...]
>> Property dma-can-stall depends on patchset
>> https://lore.kernel.org/linux-iommu/20210108145217.2254447-1-jean-philippe@linaro.org/
> [...]
>
> If you plan to post another version of this patch to include the above
> link into the commit message or reference to the commit itself, as
> Jean-Philippe's series can already be included in the mainline (since it
> has been a while now from when this series was originally posted), then
> I have a favour to ask - would you also be able to also capitalise the
> subject line (so that it's consistent) and change "chip" to "chips"
> since there are two you mention in the commit message.
>
>
Have sent another version with the changes, thanks for the remind.
I was waiting for Jean's patchest,
https://lore.kernel.org/linux-iommu/20210302092644.2553014-1-jean-philippe@linaro.org/
Though the quirks patches can be applied and build directly on 5.12-rc1.

Thanks
