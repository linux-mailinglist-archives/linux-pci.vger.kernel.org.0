Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB20B1F4FDA
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 10:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgFJIAe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 04:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFJIAd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jun 2020 04:00:33 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF46C03E96B
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2020 01:00:33 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh7so651109plb.11
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2020 01:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FigR6Fu5ol375mSGWPn8xPCDdjv0gWOe2L/pdNKXlMU=;
        b=JfDwzSE1KL+Q3A2TyU/jrhZCyadqfoBvLT8/R1PiG7xIUCM9Np6BoUuvUThDVaPg8g
         BBcjRPSEvm7MKSwK6/6K9Fi+fCJ6glJxWTocuPbALAaJDHZUB6U1FgovZ/xxExGhG8rF
         fHpATrWhTB88V6xY/+U6CWxgy9fQoMI0/C9fbgUiK3NcPhIzEYHxXDsCeNaWpUUiovtO
         AdPGmoG+P5SK0964eCJdCf5aB102wsxPXShkx84U+V5Oa74EJJp7p/5s40c6MbV3Hxpp
         2u40QuCnikfdSGIoh9UWqCCr6ZWo/IZYU78O8pz787ZET6ttaHdTHxNsRh/bwm/YG+Z+
         y2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FigR6Fu5ol375mSGWPn8xPCDdjv0gWOe2L/pdNKXlMU=;
        b=esPxOl5f+d93lJvTHzKqADHLmNN93vrFNkMFJN6OMSFWn8PbwvZMENoZRPe0WoNfWb
         C+LFM1UaKvOQGBNVDHLH7wcySN0eHUCcp5PN3ZKwp5KZLOPiyMIg9BXoUV+AMXHjnyjS
         z1vOKIp8AFNh2G5U8jltTbEAvBo0wVdcv+lvJXrn8KNZUuCOpLbsIxsik5t4dcpi3kWd
         U3dqdzM5wESnt/w6hGo5UzX2yiX8UmzqtLPDu5GJpa2Yaum0M7hP1UZDIdNSJb02kk4I
         y8PtVJtG5lvXajbDDygRs3Dq0ps6tkA7Xw8mNYZ7Ik5NjDvMy+huLvOPy07JUVfzvswP
         to8w==
X-Gm-Message-State: AOAM530ZT93xwlsoddKYlfcXtV3TS03RVxRkOTQ7c6HB061i1wteFgLm
        MDuJSOK0RCTF4XU3UDAF/cdyYg==
X-Google-Smtp-Source: ABdhPJzY4RL5uoL9pRdeLuYeuNjs4x/6PpiYJXQajEAvHLXl1ObfWln4wZQ6tkSwkGLsn5ipTX/Fqw==
X-Received: by 2002:a17:902:ee12:: with SMTP id z18mr1884864plb.274.1591776032640;
        Wed, 10 Jun 2020 01:00:32 -0700 (PDT)
Received: from [10.175.1.226] ([45.135.186.20])
        by smtp.gmail.com with ESMTPSA id g19sm11992320pfo.209.2020.06.10.01.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 01:00:32 -0700 (PDT)
Subject: Re: [RFC PATCH] PCI: Remove End-End TLP as PASID dependency
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, kenneth-lee-2012@foxmail.com,
        Wangzhou <wangzhou1@hisilicon.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1591762694-9131-1-git-send-email-zhangfei.gao@linaro.org>
 <20200610074633.GA6844@myrica>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <f59c5a39-b13e-8232-57cb-089a8d62a2a7@linaro.org>
Date:   Wed, 10 Jun 2020 16:00:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610074633.GA6844@myrica>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020/6/10 下午3:46, Jean-Philippe Brucker wrote:
> On Wed, Jun 10, 2020 at 12:18:14PM +0800, Zhangfei Gao wrote:
>> Some platform devices appear as PCI and have PCI cfg space,
>> but are actually on the AMBA bus.
>> They can support PASID via smmu stall feature, but does not
>> support tlp since they are not real pci devices.
>> So remove tlp as a PASID dependency.
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> ---
>>   drivers/pci/ats.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>> index 390e92f..8e31278 100644
>> --- a/drivers/pci/ats.c
>> +++ b/drivers/pci/ats.c
>> @@ -344,9 +344,6 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
>>   	if (WARN_ON(pdev->pasid_enabled))
>>   		return -EBUSY;
>>   
>> -	if (!pdev->eetlp_prefix_path)
>> -		return -EINVAL;
>> -
> This check is useful, and follows the PCI specification (4.0r1.0
> 2.2.10.2 End-End TLP Prefix Processing: "Software should ensure that TLPs
> containing End-End TLP Prefixes are not sent to components that do not
> support them.")
Thanks Jean,
>
> Why not set the eetlp_prefix_path bit from a PCI quirk?  Unlike the stall
> problem from the other thread, this one looks like a simple design mistake
> that can be fixed easily in future iterations of the platform: just set
> the "End-End TLP Prefix Supported" bit in the Device Capability 2 Register
> of all bridges.
Yes, we can still set eetlp_prefix_path bit from a PCI quirk.

And we also have considered adding this bit in Device Capability 2 
Register in future silicon.
But we hesitated that it does reflect the real function: from register, 
it can support tlp, but in fact, it does not.

Thanks

