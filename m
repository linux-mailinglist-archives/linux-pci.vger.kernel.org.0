Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDEBA1A48D1
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 19:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgDJRNE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Apr 2020 13:13:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34463 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgDJRNE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2020 13:13:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id 65so2987878wrl.1
        for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2020 10:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4+OqSKL5rRrfoKU/1VqAfq4iEHzWI8XxnyhjlWGzoFE=;
        b=ZwfcHmXBeF9+p29iFN8MvbSVYYb7U/FzgvD7kGIoHxtXrtreqCMBTENi+tYMwzhMhV
         KHIv084oKnUYoJKR4A1zG/67MI6VlYBCkZFGeqehbufWvW7hYX3Xn9Tei2R40wS0ZxVW
         ZZVx1Hyu7wqf098N3VowRpc7L8YgpNy0nqh4YxsZ/9rjlGd+TDF+HggJBuVQMp8rWKHH
         Cq5zmAS/pfjNWPBw8V5pyKluF70KpDwkRlIYLNcYOeP/rxpoBGo1lqFrFjYsGMNdp8jc
         r2ZrKIKlPlwhqChHgyGaiR53/k4smwcyFJn1AcXW37lmjZ49auy/ewe/J7M+9ToLnbSZ
         O80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4+OqSKL5rRrfoKU/1VqAfq4iEHzWI8XxnyhjlWGzoFE=;
        b=iezbEc2CIeIQrdram8nUMKuT2fStVVTE8pXwccoyqlnUMSwBifGNQwhtdkA2ymvaYi
         Ixr3MHa/LeOL4eu6OrxQoMAX6qcCxbzlbz58oIMnCIqBLAd7cbEZDaGm4FuUYp7oHQjp
         cTcAJ/VSTrq+T5WfK/xcFoT0IrDu+JwQ2QZd0VYitm+CO2xo3QAARMr5QuAmlv3HjJD+
         g62C+MeEr5bk5OEUl34f9h18+ofBSanG54WEs8YrNKzFEh6hHJmhmggQ1yU4/x7wFE/q
         VMCgpvgzUWSqO/UZYU5nZ2oCsvCi1fUyjbl1z2ECAPKp5FtqAZS9vEsR+6vmvBHJFHa3
         EIDg==
X-Gm-Message-State: AGi0PuYiCoYQBV0C+/nvwFCB8aPLBEVMBtKIy9WOtFHEyJkgCh3ukoHc
        e+pmlldyoO8J7fVtt9bIPm3fWG9FI3IvOA==
X-Google-Smtp-Source: APiQypJzJr3NO4kPMLNCyCIYqYUGdHlBDBGGY9bVFf7RY/wgp3eEWiIARXRl1YMYLah8D3cdh1tcpw==
X-Received: by 2002:adf:fc05:: with SMTP id i5mr5383153wrr.127.1586538782214;
        Fri, 10 Apr 2020 10:13:02 -0700 (PDT)
Received: from net.saheed (51B6D8A0.dsl.pool.telekom.hu. [81.182.216.160])
        by smtp.gmail.com with ESMTPSA id f12sm3456407wrm.94.2020.04.10.10.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 10:13:01 -0700 (PDT)
Subject: Re: [PATCH] Replace -EINVAL with PCIBIOS_BAD_REGISTER_NUMBER
To:     Yicong Yang <yangyicong@hisilicon.com>, helgaas@kernel.org
Cc:     bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org
References: <20200409161609.2034-1-refactormyself@gmail.com>
 <31a43a1a-d271-7652-db62-1a7c55cd135b@hisilicon.com>
From:   Saheed Bolarinwa <refactormyself@gmail.com>
Message-ID: <7a543d6e-4c23-c9d1-7abd-0bbf4031b2c1@gmail.com>
Date:   Fri, 10 Apr 2020 18:13:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <31a43a1a-d271-7652-db62-1a7c55cd135b@hisilicon.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 4/10/20 3:28 AM, Yicong Yang wrote:
> Hi Bolarinwa,
>
> I notice some drivers use these functions and if there is an error, pass the error code
> directly to the userspace. As it's our private error code, is it appropriate to pass or
> should we call pcibios_err_to_errno()(include/linux/pci.h, line 672) to do the conversion?

Hello Yicong,

Thank you for pointing out that function to me. I have resent the patch.

Saheed


> Regards,
> Yicong
>
> On 2020/4/10 0:16, Bolarinwa Olayemi Saheed wrote:
>> Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
>> Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
>> ---
>>   drivers/pci/access.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
>> index 79c4a2ef269a..451f2b8b2b3c 100644
>> --- a/drivers/pci/access.c
>> +++ b/drivers/pci/access.c
>> @@ -409,7 +409,7 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
>>   
>>   	*val = 0;
>>   	if (pos & 1)
>> -		return -EINVAL;
>> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>>   
>>   	if (pcie_capability_reg_implemented(dev, pos)) {
>>   		ret = pci_read_config_word(dev, pci_pcie_cap(dev) + pos, val);
>> @@ -444,7 +444,7 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
>>   
>>   	*val = 0;
>>   	if (pos & 3)
>> -		return -EINVAL;
>> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>>   
>>   	if (pcie_capability_reg_implemented(dev, pos)) {
>>   		ret = pci_read_config_dword(dev, pci_pcie_cap(dev) + pos, val);
