Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F73C3F91D3
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 03:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243862AbhH0BDl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Aug 2021 21:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243853AbhH0BDk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Aug 2021 21:03:40 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866C0C061757
        for <linux-pci@vger.kernel.org>; Thu, 26 Aug 2021 18:02:52 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id e15so2863242plh.8
        for <linux-pci@vger.kernel.org>; Thu, 26 Aug 2021 18:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=F5BzeZ88DeAznGZnAgIyJZY67dtGOyYliO+MCNuSyrA=;
        b=rj5QPst7X8pNRivio/Yqg0Ah/9xYKsD9tPSJcodLTJEG1pEHf2IR6MLm0iz7zxpVXD
         7GSCeOLSGNwjbpmzRQj/JFj9+bA2uQi8D1ajj0lg5054e4ZVG1ytI4Ige6EyUZaz/l9k
         Y8G/jJvqX6d3tavN0EOJvzAJL2Vk/npgqQG2gKu3rZGFZtjCMN+t4o+yF7Y/iSIeemVm
         G8yMlH6D48HXOKaq1pfpcAcUqOmVQAOuxwNS0ElSdKAZ7df7hcPvBJ1A/pgvbTg6dekH
         Itwb2KfXDvj8CDAMpltCu/iTxiWzH1SS1/jVadDPzIQeaZ0/+6xNzmJFOebOK9qh0Whh
         nEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=F5BzeZ88DeAznGZnAgIyJZY67dtGOyYliO+MCNuSyrA=;
        b=Eq/4TArEf4whzykPQXh3/o1L0yL70uUEhi9yFMLHrDL5g2M4vcB2BmhzRWIupT7Mn8
         Lm8ysNkWHj+at+T1Ya3ik1qIUqkJ13Tpko53dBheNxg/rFrWiKxXY3OzlT6Y85yP8IEb
         IQiG5XT2sWxc367mV1nC1YU5VcKhfHmaP9gzU2qoJn6DtbA8IyQIj82m9AEcggStz4K6
         YWwJl7DaKOBJ6raZLWhBWOk1d/Bo2IdLGDcg33UpTUNu2gB9MsQG6HdKR4wAMHrNv3TH
         446IiJ/dzU3x3ChzPQMGg1oppO5dM6K17hY6JB0wwha+loAahBBg+ZmHRy4lP2l2yqOF
         pZmQ==
X-Gm-Message-State: AOAM5315b7dnWOAdbw6mRsitv5BGrr0vuYtG/GjyYP0BXwwd6P5U38aC
        CUQcGi957XJ/39iJ1SWk5iRTwQ==
X-Google-Smtp-Source: ABdhPJzzAZU32hWnG7tGHNj4MLnmQ2A+LyMwHrmScoFqiOb0x7c3S7VytjGBLCUUhtfteRUDSbwt/w==
X-Received: by 2002:a17:90a:c984:: with SMTP id w4mr7750050pjt.124.1630026171308;
        Thu, 26 Aug 2021 18:02:51 -0700 (PDT)
Received: from [10.189.0.6] ([45.135.186.38])
        by smtp.gmail.com with ESMTPSA id c12sm3877296pfl.56.2021.08.26.18.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 18:02:50 -0700 (PDT)
Subject: Re: [PATCH v5 0/3] PCI: Add a quirk to enable SVA for HiSilicon chip
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210826193020.GA3703737@bjorn-Precision-5520>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <70356556-0772-6faf-57ef-899e59cc796c@linaro.org>
Date:   Fri, 27 Aug 2021 09:02:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210826193020.GA3703737@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021/8/27 上午3:30, Bjorn Helgaas wrote:
> On Tue, Jul 13, 2021 at 10:54:33AM +0800, Zhangfei Gao wrote:
>> HiSilicon KunPeng920 and KunPeng930 have devices appear as PCI but are
>> actually on the AMBA bus. These fake PCI devices have PASID capability
>> though not supporting TLP.
>>
>> Add a quirk to set pasid_no_tlp and dma-can-stall for these devices.
>>
>> v5:
>> no change, base on 5.14-rc1
>>
>> v4:
>> Applied to Linux 5.13-rc2, and build successfully with only these three patches.
>>
>> v3:
>> https://lore.kernel.org/linux-pci/1615258837-12189-1-git-send-email-zhangfei.gao@linaro.org/
>> Rebase to Linux 5.12-rc1
>> Change commit msg adding:
>> Property dma-can-stall depends on patchset
>> https://lore.kernel.org/linux-iommu/20210302092644.2553014-1-jean-philippe@linaro.org/
>>
>> By the way the patchset can directly applied on 5.12-rc1 and build successfully though
>> without the dependent patchset.
>>
>> v2:
>> Add a new pci_dev bit: pasid_no_tlp, suggested by Bjorn
>> "Apparently these devices have a PASID capability.  I think you should
>> add a new pci_dev bit that is specific to this idea of "PASID works
>> without TLP prefixes" and then change pci_enable_pasid() to look at
>> that bit as well as eetlp_prefix_path."
>> https://lore.kernel.org/linux-pci/20210112170230.GA1838341@bjorn-Precision-5520/
>>
>> Zhangfei Gao (3):
>>    PCI: PASID can be enabled without TLP prefix
>>    PCI: Add a quirk to set pasid_no_tlp for HiSilicon chips
>>    PCI: Set dma-can-stall for HiSilicon chips
>>
>>   drivers/pci/ats.c    |  2 +-
>>   drivers/pci/quirks.c | 27 +++++++++++++++++++++++++++
>>   include/linux/pci.h  |  1 +
>>   3 files changed, 29 insertions(+), 1 deletion(-)
> Applied with Robin's ack to pci/iommu for v5.15, thanks!
Great, thanks  Bjorn and Robin.

