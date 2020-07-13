Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAA321DE9F
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 19:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbgGMRYI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 13:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbgGMRYI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 13:24:08 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF3BC061755;
        Mon, 13 Jul 2020 10:24:07 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g20so14406759edm.4;
        Mon, 13 Jul 2020 10:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=e0LSuR+yshIoYGz+eEEY3hbB8A+14sBty8Ug4yMkgfM=;
        b=nTmeCPcn+ozK+Ag5RxEELeJLLx9ti8jrlnkSeGn+v7o9o0VF9oqTW9mzAjEAFJQnWc
         qy5WrcnWfHjIf32n1rZMIh7sjY+87PmkNyonBFjkMmm/slYoFKySiIDO6+eFTW7DyjhV
         dcAIkLxDSgKq8n2k3M6w/g/AfcEEasZ0+ubo5y3FP86jcAmIC3Bp4bSbEpCr+H2fGieA
         cWR5TAwnj5PuzxwIQ+aw+2sXxWXcbl3OLOr7p1EQo/nTFJ+CtkPPFFCWRh9nn7Mgar9C
         QL2BtaG9MVgA1PHr+APD1CbIGDru+t9rECcfdiYNqx3sePEn6oCyMM3NaVw/Kh7k8nKA
         G6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=e0LSuR+yshIoYGz+eEEY3hbB8A+14sBty8Ug4yMkgfM=;
        b=RD2tz/ij/m0v8W+5GpwBC+wuXC/3ro4urGU59N40sxUdFCsbt6eAGXoTlooaKBpcJu
         70BTLDy2TO5AWlS26+3Qdj2Rw9tr3s+/IuBFamDiWVZjK0JFT18My2qQSWPbfaXtq5+8
         HLF4++GPubqA5KkZ33fguDrwl1ajn2ujIoiCmhv11NMYOiadH8bIZrIDUFvt+oFtHVNQ
         1Tl6GOgntlRfK4+myjWNJSJDR4eDOGndipwnvglNZDKGvpqCf4zWPE0Y0klrzVcBw+8q
         +tHTTD14W8LmTDiDaeryCwwptydBfSsBIfN7+HM1nlTzKc4RwwlR9TNURvx/XPliopFl
         G+Rg==
X-Gm-Message-State: AOAM530kRQWg1l9k6BNW897Lq6gl/L/lLlkAkxjRdmS80HoY7cQwrNfq
        Pn0jWlVPoxtqnKjferCskeo=
X-Google-Smtp-Source: ABdhPJwU6CC1g8gnvm6vkaI0vzF7ML92p+FtcVVEx2//52B6Q3pLKNShFOHB6NyG1tBi9qTBjIHGwg==
X-Received: by 2002:a05:6402:c82:: with SMTP id cm2mr441209edb.293.1594661046520;
        Mon, 13 Jul 2020 10:24:06 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id t25sm10192694ejc.34.2020.07.13.10.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 10:24:05 -0700 (PDT)
Subject: Re: [RFC PATCH 09/35] nvme-pci: Change PCIBIOS_SUCCESSFUL to 0
To:     "Rajashekar, Revanth" <revanth.rajashekar@intel.com>,
        helgaas@kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        bjorn@helgaas.com, linux-kernel-mentees@lists.linuxfoundation.org
References: <20200713122247.10985-1-refactormyself@gmail.com>
 <20200713122247.10985-10-refactormyself@gmail.com>
 <0762f646-90a1-217c-4e4b-6168d85bb08a@intel.com>
From:   Saheed Bolarinwa <refactormyself@gmail.com>
Message-ID: <f48dece5-7483-73ac-38bb-0dce323f404c@gmail.com>
Date:   Mon, 13 Jul 2020 20:24:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0762f646-90a1-217c-4e4b-6168d85bb08a@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/13/20 6:42 PM, Rajashekar, Revanth wrote:
> Hi,
>
> On 7/13/2020 6:22 AM, Saheed O. Bolarinwa wrote:
>> In reference to the PCI spec (Chapter 2), PCIBIOS* is an x86 concept.
>> Their scope should be limited within arch/x86.
>>
>> Change all PCIBIOS_SUCCESSFUL to 0
>>
>> Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
>> ---
>>   drivers/nvme/host/pci.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index b1d18f0633c7..d426efb53f44 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -1185,7 +1185,7 @@ static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
>>   
>>   	result = pci_read_config_word(to_pci_dev(dev->dev), PCI_STATUS,
>>   				      &pci_status);
>> -	if (result == PCIBIOS_SUCCESSFUL)
>> +	if (result == 0)
> How about simplifying the check to if (!result)?

Thank you for the review.  I did in PATCH 10/35. I will merge both.

I wanted to separate the goal from the fix but I see it's confusing.

- Saheed

