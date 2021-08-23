Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C0D3F42B8
	for <lists+linux-pci@lfdr.de>; Mon, 23 Aug 2021 03:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhHWBCy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Aug 2021 21:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhHWBCy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Aug 2021 21:02:54 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DB6C061575
        for <linux-pci@vger.kernel.org>; Sun, 22 Aug 2021 18:02:12 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id b9so4801147plx.2
        for <linux-pci@vger.kernel.org>; Sun, 22 Aug 2021 18:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PQyq0/mVTcHHR3kWPuGNHdEp5dRrFDPoWILopvZPKCY=;
        b=Aym8TDB5JHD/5Lr6oDIjoO9ZQjzTdmBusHnz8XJAsjfStp8QrIZN96f0J/h7wQzzJM
         lAvsMqbJ9N1FHpeFAWUurojBGPNsQSvfT50tLjMhnnAnyf/n8AmNtM8MyX00LLPSdmgW
         LcNAcrUZ103l3fPnkMKfEkJAj/ZXeAUmDJBCPdZHTOn2RvMnPX+Z49UpTQ3/7MMWNHJd
         H+MRf2HAqusgzeZ9H1Oyqgh2xD+zF3/E5YcLMUsnJnLuOdYJHFrOHUFn05mQMQbx8xKd
         FE1+9SaIzFjSYmlFyrkb2YUsGpBXuNBrRnOXtXcwb4UhC7Wiwnxx7Y1VxpZN3EJhcgRs
         kW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PQyq0/mVTcHHR3kWPuGNHdEp5dRrFDPoWILopvZPKCY=;
        b=Jd9RW3xlugm53cmI7joPeR6m4aNOf3abICPFCVEoZNxHmdyaLWCmpIYFlf0jhu3l/P
         KC1vuqwyhvCWYd5cnf4uRpbYKbAj6tlzymaj465H7AWNnwCXu+ophah6A5tgyQFsScv/
         7gT6oYjAhh0kf7yQnAjtf190O8fyWLXYOznn7S5I7j3TdG2RKz7eHYNqi3nhwTw1SFR1
         JUwQ14ai7MkB0UXK9+2Yiw2nMIoOb34wb4C5c2thoCBasnbmMXsicqMXlt4qW4SrE86d
         70sP/BFx+vq13/at9MpIPvWoV7n+yD20wI26HY51QTtC6YAYYGFcdRvMJNSfOQ4rOqZL
         5liw==
X-Gm-Message-State: AOAM533rz13YAZ69ETmYHqpe5nUfxU45L36KjmEEuqNWzDTL+gP3+VOL
        MuGUEpLDDCFpRtD5nLhgQfv1OQ==
X-Google-Smtp-Source: ABdhPJyu/wpLxNB8SEq2XcHDaiK93Ex4V8Kz7PZdRsM6hvEe3guh/ya/2nT2D47T8XqNttkS/NSrNQ==
X-Received: by 2002:a17:90a:bc8d:: with SMTP id x13mr4585879pjr.66.1629680532120;
        Sun, 22 Aug 2021 18:02:12 -0700 (PDT)
Received: from [10.75.0.6] ([45.135.186.133])
        by smtp.gmail.com with ESMTPSA id s32sm14239643pfw.84.2021.08.22.18.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 18:02:11 -0700 (PDT)
Subject: Re: [PATCH v5 0/3] PCI: Add a quirk to enable SVA for HiSilicon chip
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1626144876-11352-1-git-send-email-zhangfei.gao@linaro.org>
 <1796ac2a-b068-467e-804e-163f9e1f3c41@linaro.org>
Message-ID: <9ab85a0a-80a7-4ccb-0657-a77c8a657089@linaro.org>
Date:   Mon, 23 Aug 2021 09:02:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1796ac2a-b068-467e-804e-163f9e1f3c41@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn

On 2021/7/27 下午2:47, Zhangfei Gao wrote:
> Hi, Bjorn
>
> On 2021/7/13 上午10:54, Zhangfei Gao wrote:
>> HiSilicon KunPeng920 and KunPeng930 have devices appear as PCI but are
>> actually on the AMBA bus. These fake PCI devices have PASID capability
>> though not supporting TLP.
>>
>> Add a quirk to set pasid_no_tlp and dma-can-stall for these devices.
>>
>> v5:
>> no change, base on 5.14-rc1
>
> Would you mind take a look at this patchset.
> We need the quirk to enable sva feature of devices on HiSilicon 
> KunPeng920 and KunPeng930.

Any comments about this patchset.
Is it possible to catch up the 5.15?

Thanks
