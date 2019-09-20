Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1CC2B8C56
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2019 10:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405078AbfITIFF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Sep 2019 04:05:05 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36127 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404886AbfITIFF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Sep 2019 04:05:05 -0400
Received: by mail-ed1-f65.google.com with SMTP id h2so5534904edn.3;
        Fri, 20 Sep 2019 01:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GKB2cZsFSODM3FIuz4Y4YZ1vEc5k6RufqQEYaxRbI0w=;
        b=qssZ7g5N4GQ7we9G9GowQLEHsAeYBpthajNHNMfdpjwWM3CI42L+Y59RfzoSUMLMyX
         isxmD0xThXBNEu33QcEMe05n9Bbu7KSRopgvC7J1b3KvpRTg8br7L70CKYX5xDt1VSRR
         bQzfEHqhrohgARd/gWxFix72DEEdysHmLnFfN7Vh/9UrFSGqdOB6alUN/8m0512g45Xd
         y2LH7jjHxq6LQnxXZ20e/OjWAA2nUb0bgy6KnRMnhMS3KzNgQkFckB6N/uCCpi2oW6Qh
         KHTjKQOlB/3TRWd2fniB/EZsmIN4aPgO27fa5oo2ooBNjI2uOKbBdQE2d+pfqE2zx2uO
         QFVQ==
X-Gm-Message-State: APjAAAUUaidcLDCjiVO6GDeR2lhos6J+7QE/GnaVH8AnG/njKRabgeKf
        Cdl0n7W6uVxsQcqqkhcEWFE=
X-Google-Smtp-Source: APXvYqwa+eS8V/8ubME5E0fy+R+976vJecAYytDHWT4EoYhpSFETPExd2G+R6Y8Y8OBdlIRne6gRzg==
X-Received: by 2002:aa7:d38e:: with SMTP id x14mr21018641edq.102.1568966703382;
        Fri, 20 Sep 2019 01:05:03 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.gmail.com with ESMTPSA id h7sm191025edn.73.2019.09.20.01.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 01:05:02 -0700 (PDT)
Subject: Re: [PATCH v3 23/26] memstick: use PCI_STD_NUM_BARS
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Andrew Murray <andrew.murray@arm.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>
References: <20190916204158.6889-1-efremov@linux.com>
 <20190916204158.6889-24-efremov@linux.com>
 <CAPDyKFoVEMex2_p1M-cFZnGLuwgK0wZk-kL_eZ=eDiT1tjvDGA@mail.gmail.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <1bbe2bb0-1d3a-9151-eb2a-d2bb2c79250e@linux.com>
Date:   Fri, 20 Sep 2019 11:05:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoVEMex2_p1M-cFZnGLuwgK0wZk-kL_eZ=eDiT1tjvDGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 20.09.2019 10:42, Ulf Hansson wrote:
> On Mon, 16 Sep 2019 at 22:47, Denis Efremov <efremov@linux.com> wrote:
>>
>> Use define PCI_STD_NUM_BARS instead of PCI_ROM_RESOURCE for the number of
>> PCI BARs.
>>
>> Cc: Maxim Levitsky <maximlevitsky@gmail.com>
>> Cc: Alex Dubov <oakad@yahoo.com>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Denis Efremov <efremov@linux.com>
> 
> Assuming this depends on other changes in the series?

Yes, the first patch introduce define PCI_STD_NUM_BARS.

> Thus this is
> probably for PCI maintainers to pick up?

Yes, this is for Bjorn's tree.

> 
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Kind regards
> Uffe
> 
>> ---
>>  drivers/memstick/host/jmb38x_ms.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
>> index 32747425297d..fd281c1d39b1 100644
>> --- a/drivers/memstick/host/jmb38x_ms.c
>> +++ b/drivers/memstick/host/jmb38x_ms.c
>> @@ -848,7 +848,7 @@ static int jmb38x_ms_count_slots(struct pci_dev *pdev)
>>  {
>>         int cnt, rc = 0;
>>
>> -       for (cnt = 0; cnt < PCI_ROM_RESOURCE; ++cnt) {
>> +       for (cnt = 0; cnt < PCI_STD_NUM_BARS; ++cnt) {
>>                 if (!(IORESOURCE_MEM & pci_resource_flags(pdev, cnt)))
>>                         break;
>>
>> --
>> 2.21.0
>>
