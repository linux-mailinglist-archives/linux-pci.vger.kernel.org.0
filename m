Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9EC3DED2E
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 13:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbhHCLtf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 07:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbhHCLtc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Aug 2021 07:49:32 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96F9C061384;
        Tue,  3 Aug 2021 04:49:01 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id z3so22056448plg.8;
        Tue, 03 Aug 2021 04:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=E3p7QBANfnDXzug1HVnf+mR89WyeHhHNhX08lGOpqhc=;
        b=D/gLHBoFNb2XOZsMW/v2FKQrEt5kyE7XVPWKo2mvVaHKAl+7uKURgt0+RLULamecm+
         Rwf64sqgFRpmSzJaZiUJJVs3DlJO6VHJLaTzrf1EITiGscPPag+Q7WIPrt2LU99SRAxS
         oEkoE7+pSceTGX7Pqocaikhl0myY5jimV9JQYzsuAZ345DDfnynCQ/IPdO28Qwslbx+M
         hyN2zzBVRa1f056Bhiw9Kv6Z1QF2gUfccZrRsuF+cD6YTA2I9W3S4NunW8DO24J9MnxK
         fmZYuLKYhnNDSE0B3h1EUtlkd3DjzafBnEyS9+s7zRLdsv5d+1IhBlD8+WcNEhZ4Bbxy
         dRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=E3p7QBANfnDXzug1HVnf+mR89WyeHhHNhX08lGOpqhc=;
        b=PyKPRLnCYiyr+ralJEh9fhppnx2LYMsZkwTjAW7yKBxhZLkAd7z00B2henmhVqOstG
         3LZ1ezQGBYKJhniwcOjqmnTfpYn5yM8zPh3nbBT5h0+mr+GmqUzTaC2tLmlrCe/5zy8y
         3bnWiOLH0oUg1NyGQzo/KUOk7wfGmjjp0mpdL9Mpgnb7daBDjE2dc/ibFHzpljG7U7pW
         0I9tnCSsH7cLnmchI/n1iyXNh0JF0HESZ9Nhb758xULy5iJwTXNXc1DwTcEUHcDGcdR7
         Tuah/r6BjYYhOxBqr8J+dCbHLsZGLSphAIrclTxo15tlV95M1XXFescK7j+dR8E5oJxI
         0KPA==
X-Gm-Message-State: AOAM530xIrYAazvxbtthltxGcGT/Gz/zys4OZYVIZ3+MebEo/6pbVoLk
        BQRSKoW4m560YJmOiB/KJ5+thsRyMBRZnoRkHw==
X-Google-Smtp-Source: ABdhPJzNN2Gicr5jDqIcr5dqxlDmX+VPFcujfZWBaTU9JRp7YfxAW9iKltVroPdqRFdRmRr9MKUFuA==
X-Received: by 2002:aa7:8387:0:b029:395:a683:a0e6 with SMTP id u7-20020aa783870000b0290395a683a0e6mr21876161pfm.12.1627991341117;
        Tue, 03 Aug 2021 04:49:01 -0700 (PDT)
Received: from [10.144.0.6] ([154.16.166.154])
        by smtp.gmail.com with ESMTPSA id n33sm17054942pgm.55.2021.08.03.04.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 04:49:00 -0700 (PDT)
Subject: Re: [PATCH v2] tools: PCI: Zero-initialize param
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, kw@linux.com,
        leon@kernel.org, kishon@ti.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210714132331.5200-1-yang.shunyong@gmail.com>
 <9e40fd4c-6aec-db3e-f323-0f2cfb67d58c@ti.com>
From:   Shunyong Yang <yang.shunyong@gmail.com>
Message-ID: <2017bdfe-b053-0dbe-82e3-b5533dbe372e@gmail.com>
Date:   Tue, 3 Aug 2021 19:48:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9e40fd4c-6aec-db3e-f323-0f2cfb67d58c@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

    Would you please help to review and put this tiny fix (for 
tools/pci/pcitest.c) in your merge queue? Kishon has acked.

Thanks.

Shunyong

On 2021/7/14 21:32, Kishon Vijay Abraham I wrote:
>
> On 14/07/21 6:53 pm, Shunyong Yang wrote:
>> The values in param may be random if they are not initialized, which
>> may cause use_dma flag set even when "-d" option is not provided
>> in command line. Initializing all members to 0 to solve this.
>>
>> Signed-off-by: Shunyong Yang <yang.shunyong@gmail.com>
> Thanks for the fix.
>
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>
>
>> ---
>> v2: Change {0} to {} as Leon Romanovsky's comment.
>> ---
>>   tools/pci/pcitest.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
>> index 0a1344c45213..441b54234635 100644
>> --- a/tools/pci/pcitest.c
>> +++ b/tools/pci/pcitest.c
>> @@ -40,7 +40,7 @@ struct pci_test {
>>   
>>   static int run_test(struct pci_test *test)
>>   {
>> -	struct pci_endpoint_test_xfer_param param;
>> +	struct pci_endpoint_test_xfer_param param = {};
>>   	int ret = -EINVAL;
>>   	int fd;
>>   
>>
