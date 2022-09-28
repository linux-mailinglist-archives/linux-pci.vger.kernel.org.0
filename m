Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B635ED3D3
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 06:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiI1EUm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 00:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiI1EUl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 00:20:41 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7230F1D35B2
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 21:20:39 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y136so11484827pfb.3
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 21:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=yFiQRqenBnP9hKkiD46tWPwfT0QDu8/bSPBGZoBlzgg=;
        b=hooLisGajE4+4MwjNaS+l0+/mZZQz4+CXmfDaAvTbcp9Vb50hZQ8aJX/wZVVTmklb8
         n6kAK0pb7T39ni+nyQij+Z33mFANX2gP59HOmQ2XVe9TpjPpvoK1f31TcXv/n0YN4Bbg
         oS0dvXxSAH+KGgT83rhf206mzkxGsmpGkXwP3xhud1dynDIW1Yi7bNpwtojs8D5EWod6
         3xDmV6JqIpMjZ3OETd+JUcNTA6KSjVFhr1gGxbBi0ltsZvxy/Lu2xv4k9gusJ2nJ0p2J
         1TEuv26ILz7fv5H1uHRQbi5VKSiuCyR7YSF24qohAlC1hw9HPvEcGBSYype8ptPffYj2
         W0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yFiQRqenBnP9hKkiD46tWPwfT0QDu8/bSPBGZoBlzgg=;
        b=XjTOYto3vjMXsB2/wWjVYQjGsPacgVDHu2l/0nYjJ9jNUjaa5FoGKoshKY5YDu0bsF
         WcQsJ0VLfkI6mneveG6zEP8spxSejdt2pRWwoJBF1JYeg6IW6+zcuT3DnLlFZF8BdGW7
         V1hKOEvdKSZi6Qhn0o7pKIzZG+uiEj5ifwLyDPQr1x9Bx6+vuPOgfE+aZ0ZqaPkSCZV0
         z6CadqzN3pX7X9WOX7lb4YG5l54ffPPyv18JTLMaC6VBAIYvXrK/pbo6Z/hGJwL2XI5G
         KzGyvlRvKqq+j74NB0tm3fWu5kQ6HcaRSO/RBMJ0zopEK0cMWUmFdlfVN6cH7oEj6Coi
         bc2w==
X-Gm-Message-State: ACrzQf3LzvZoDoDKFVW2Cf5sNTjhLquOqwSvdkko9IWw/2KuZ+7dntTy
        ophRsmRBJUMTqM/VQsGm+m0w1A==
X-Google-Smtp-Source: AMsMyM50itfQ0DRAQQIEThIt2ysECjrFQ4ghVKeFxS0QdAhHPdJh+YEyANskKckc0yUejONhTF50Sg==
X-Received: by 2002:a65:644c:0:b0:43c:e614:ae0e with SMTP id s12-20020a65644c000000b0043ce614ae0emr7481081pgv.491.1664338839008;
        Tue, 27 Sep 2022 21:20:39 -0700 (PDT)
Received: from ?IPV6:fdbd:ff1:ce00:f:181d:9138:3f2b:d59e? ([2400:8800:1f02:83:4000::7])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902680800b0017a018221e2sm324111plk.70.2022.09.27.21.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 21:20:38 -0700 (PDT)
Message-ID: <1d62d0ac-b47c-94b5-dd75-b7df71817d0d@bytedance.com>
Date:   Wed, 28 Sep 2022 12:20:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [External] Re: [PATCH v2 3/9] NTB: Change to use
 pci_aer_clear_uncorrect_error_status()
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>, bhelgaas@google.com,
        ruscur@russell.cc, oohall@gmail.com, fancer.lancer@gmail.com,
        jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ntb@lists.linux.dev,
        linux-scsi@vger.kernel.org
References: <20220927153524.49172-1-chenzhuo.1@bytedance.com>
 <20220927153524.49172-4-chenzhuo.1@bytedance.com>
 <d8123aa3-a5e0-6131-bd0d-109f67923ff2@linux.intel.com>
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
In-Reply-To: <d8123aa3-a5e0-6131-bd0d-109f67923ff2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/28/22 3:39 AM, Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 9/27/22 8:35 AM, Zhuo Chen wrote:
>> Status bits for ERR_NONFATAL errors only are cleared in
>> pci_aer_clear_nonfatal_status(), but we want clear uncorrectable
>> error status in idt_init_pci(), so we change to use
>> pci_aer_clear_uncorrect_error_status().
> 
> You mean currently driver does not clear fatal errors now, and it is
> a problem? Any error reported?
> 
Hi Sathyanarayanan,

No error reports yet, I just changes the behavior back to what it was 
before commit e7b0b847de6d ("PCI/AER: Clear only ERR_NONFATAL bits 
during non-fatal recovery"), because this commit change the original 
function in commit bf2a952d31d2 ("NTB: Add IDT 89HPESxNTx PCIe-switches 
support").

> Also, I am wondering why is it required to clear errors during init
> code. Is it a norm?
> 
I think there is no need to clear errors during init code.
>>
>> Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
>> ---
>>   drivers/ntb/hw/idt/ntb_hw_idt.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
>> index 0ed6f809ff2e..d5f0aa87f817 100644
>> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
>> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
>> @@ -2657,8 +2657,8 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
>>   	ret = pci_enable_pcie_error_reporting(pdev);
>>   	if (ret != 0)
>>   		dev_warn(&pdev->dev, "PCIe AER capability disabled\n");
>> -	else /* Cleanup nonfatal error status before getting to init */
>> -		pci_aer_clear_nonfatal_status(pdev);
>> +	else /* Cleanup uncorrectable error status before getting to init */
>> +		pci_aer_clear_uncorrect_error_status(pdev);
>>   
>>   	/* First enable the PCI device */
>>   	ret = pcim_enable_device(pdev);
> 

-- 
Thanks,
Zhuo Chen
