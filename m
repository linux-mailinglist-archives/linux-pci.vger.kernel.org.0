Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290D823CE12
	for <lists+linux-pci@lfdr.de>; Wed,  5 Aug 2020 20:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgHESLk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Aug 2020 14:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbgHESJI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Aug 2020 14:09:08 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83853C061757
        for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2020 11:09:07 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t10so20411539plz.10
        for <linux-pci@vger.kernel.org>; Wed, 05 Aug 2020 11:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=QLQQ3+0etev233V3umPOvDVR32FRU3B4OHKUUP2KCtU=;
        b=cJiqL12yAVnWOtPxTPDWYZdMhDSWBAVmkAM12MtrQWair/KCdQo04Q3JIQaoAM68oK
         ktSPgagxplpFLOSivwPxXlyLmZ92ZTz3JVHDcF6/Cz4OlbXaPaTiRZjvjuSzWmWhXBzE
         yzJ+fL6mCIagoCzT1NECUKisLKh6z4D7js2Hf3U7aCoqSrbYX0WVKFekkz4uJhiiIet7
         DhXKPeB7VM8W0WHLbH73QWjOPLzuqi7sEOCCSHiYDjdSCrJo1OD5COzxsMXQtU1T0EOw
         Y2rxz7mQriURh7LCeOKmkx27XTY8t5Uz3lKEJGFq5TO8vbur3wZg1crfB4zhD6bw96lq
         OkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=QLQQ3+0etev233V3umPOvDVR32FRU3B4OHKUUP2KCtU=;
        b=LAquAHgF+tYRlzk1Aw2tEcKvBsjFacoQBAJhHMCOnHZwy9SmY5bXP+nfoLg94UW2Jg
         MLeG1WjaI8BfUd2fNKWzBO1QxN50refJgg37rgCBLFN60cumpYp1NXcAYAbz6kuL8g3t
         6nNJjcY345TfrEpERWwXuXcna+2C1hHVyG8p8Aa48t1tNBYzFwWIqYhxa9K7njMwhG/s
         pZyEFt9vV0uKWk67kiYIaw99Jejj74lupOtwKD+c3amSm0ZT2h+JkQwNe4dnIAWiVYNx
         FXHJvk8UddgOaT7CSupRMw14+1rUoZgEE9isbfmd9/tBGrFuD8R9XDUBBR+So6ec9Vm9
         7EdQ==
X-Gm-Message-State: AOAM533DWuXr690pllXy7atJQX8WmrQZ0Pb5xYx1QA5MWaoCmIwJPtij
        /0sV7et0oR54tQwrmCX5EWO8iA==
X-Google-Smtp-Source: ABdhPJzgLgfCkhTYirh3jlA82isYOiQXoI3I2L0JOH5MsNNl4huINEybPkouEx/HAXGjPugwTQeLcA==
X-Received: by 2002:a17:902:b686:: with SMTP id c6mr4212408pls.133.1596650947056;
        Wed, 05 Aug 2020 11:09:07 -0700 (PDT)
Received: from [10.213.170.159] (fmdmzpr04-ext.fm.intel.com. [192.55.55.39])
        by smtp.gmail.com with ESMTPSA id fv21sm3722351pjb.16.2020.08.05.11.09.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Aug 2020 11:09:06 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>
Cc:     bhelgaas@google.com, rjw@rjwysocki.net, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Qiuxu Zhuo" <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH V2 9/9] PCI/AER: Add RCEC AER error injection support
Date:   Wed, 05 Aug 2020 11:09:04 -0700
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <32674ABF-0189-4477-8BEA-84DA393FD148@intel.com>
In-Reply-To: <20200805185450.0000512d@Huawei.com>
References: <20200804194052.193272-1-sean.v.kelley@intel.com>
 <20200804194052.193272-10-sean.v.kelley@intel.com>
 <20200805185450.0000512d@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5 Aug 2020, at 10:54, Jonathan Cameron wrote:

> On Tue, 4 Aug 2020 12:40:52 -0700
> Sean V Kelley <sean.v.kelley@intel.com> wrote:
>
>> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>
>> The Root Complex Event Collectors(RCEC) appear as peers to Root Ports
>> and also have the AER capability. So add RCEC support to the current AER
>> error injection driver.
>>
>> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
>
> Silly English subtlety inline.
>
>> ---
>>  drivers/pci/pcie/aer_inject.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
>> index c2cbf425afc5..2077dc826fdf 100644
>> --- a/drivers/pci/pcie/aer_inject.c
>> +++ b/drivers/pci/pcie/aer_inject.c
>> @@ -333,8 +333,11 @@ static int aer_inject(struct aer_error_inj *einj)
>>  	if (!dev)
>>  		return -ENODEV;
>>  	rpdev = pcie_find_root_port(dev);
>> +	/* If Root port not found, try to find an RCEC */
>> +	if (!rpdev)
>> +		rpdev = dev->rcec;
>>  	if (!rpdev) {
>> -		pci_err(dev, "Root port not found\n");
>> +		pci_err(dev, "Root port or RCEC not found\n");
>
> That is a bit confusing, could be
>
> RP | !RCEC
>
> "Neither root port nor RCEC found\n" perhaps?

Sounds good to me. Will correct.

Thanks,

Sean

>
>
>>  		ret = -ENODEV;
>>  		goto out_put;
>>  	}
