Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751DF364097
	for <lists+linux-pci@lfdr.de>; Mon, 19 Apr 2021 13:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbhDSLc1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Apr 2021 07:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbhDSLc1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Apr 2021 07:32:27 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF640C06174A
        for <linux-pci@vger.kernel.org>; Mon, 19 Apr 2021 04:31:57 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so17850422wmj.2
        for <linux-pci@vger.kernel.org>; Mon, 19 Apr 2021 04:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f6mZGi0/BvwUvuCE6AlawPJOV9eZxif5Bp7LIwOSPpk=;
        b=K84RPcA0qmCiNPdxz+R5J9I3JFN6Jl2IerFk71lhspm3KDmVTdlHTFiUu+WdsAeFcq
         Y8y0L1Vs21Z0mnQuGkvKx/9koayqfogwe8DSBQGKPMt/k/92oMl1VmIoSoziYutptosf
         69n2dMwAj7zjLrAtYdF5gwVSXqE0qDBlHDbZmMwZiwYiXCj3VHEaCiqlInRcqtaLbSie
         S7fsaCbwgOgT9e1VGPZRzvXuNargjzXnVssRMK8dniVYEQRHtAQXq0LkcaldIQ6DnY1m
         DmhjLhVF3G0X0g2nER9XALEzX+3cMqU2ytHVyEMU+c0iHzZ5YF2oiUywIT2Kk79jS97v
         U4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f6mZGi0/BvwUvuCE6AlawPJOV9eZxif5Bp7LIwOSPpk=;
        b=puGA0iO+toq1xhx6AlADy2VveLKY4aM65/bt9sBC6ZICT4f62w6xg0kOgkp502GksC
         wePdVlKhn2DShJAqSj34NrPkIwiHBMgVcGsHCbEvxWJF1HlxxtvYIKFFF1SQUSNNHCms
         CCDaEpibTkHJnznd2MIOIoA6uZX7mUr8nDV1twB0YJ5rhAhJKjabmeOxvuFsdh+mWXu3
         8I49HdJlL+iY4asmtvkZ/Kcoq6/a+WC6dKf8hXSoxdwnAHaFNJeXgwxK4scQHmSG4CVi
         SsPqF+WSGO4hg9unhKTqHH1AK8Y+gNTDLnFthGbWgRvV5QfSeKanXnBHFKQkFL5RnuqH
         Z+PQ==
X-Gm-Message-State: AOAM53322vWKp1yhTVanwYyigLtYEQULohO06y0EDLUUd9/YshhOyQT9
        iXqS1d52zDUDR20xzNDtnnkCkRRUlhToZQ==
X-Google-Smtp-Source: ABdhPJyYRb7gpuGXZEbzb9tsQ87yRQUgoBP+YgH+pEuT7uA9XQ86DtI04dExht3axdCZSwANU7HHVQ==
X-Received: by 2002:a1c:6186:: with SMTP id v128mr2076755wmb.173.1618831916301;
        Mon, 19 Apr 2021 04:31:56 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:cc84:7538:8299:9b35? (p200300ea8f384600cc84753882999b35.dip0.t-ipconnect.de. [2003:ea:8f38:4600:cc84:7538:8299:9b35])
        by smtp.googlemail.com with ESMTPSA id p13sm21519332wrt.0.2021.04.19.04.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 04:31:55 -0700 (PDT)
Subject: Re: [PATCH] PCI/VPD: Use unaligned access helper in pci_vpd_write
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <79d337f4-25d6-9024-2cbd-63801cbd9992@gmail.com>
 <f66dc844-0b2e-3508-1c68-2433fe6576ea@gmail.com>
Message-ID: <e4f2fba8-ef27-6a7b-3344-52a66da661dd@gmail.com>
Date:   Mon, 19 Apr 2021 13:31:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <f66dc844-0b2e-3508-1c68-2433fe6576ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19.04.2021 13:10, Heiner Kallweit wrote:
> On 18.04.2021 11:19, Heiner Kallweit wrote:
>> Use helper get_unaligned_le32() to simplify the code.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/pci/vpd.c | 15 +++++----------
>>  1 file changed, 5 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
>> index 60573f27a..2888bb300 100644
>> --- a/drivers/pci/vpd.c
>> +++ b/drivers/pci/vpd.c
>> @@ -9,6 +9,7 @@
>>  #include <linux/delay.h>
>>  #include <linux/export.h>
>>  #include <linux/sched/signal.h>
>> +#include <asm/unaligned.h>
>>  #include "pci.h"
>>  
>>  /* VPD access through PCI 2.2+ VPD capability */
>> @@ -235,10 +236,9 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
>>  }
>>  
>>  static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
>> -			     const void *arg)
>> +			     const void *buf)
>>  {
>>  	struct pci_vpd *vpd = dev->vpd;
>> -	const u8 *buf = arg;
>>  	loff_t end = pos + count;
>>  	int ret = 0;
>>  
>> @@ -264,14 +264,8 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
>>  		goto out;
>>  
>>  	while (pos < end) {
>> -		u32 val;
>> -
>> -		val = *buf++;
>> -		val |= *buf++ << 8;
>> -		val |= *buf++ << 16;
>> -		val |= *buf++ << 24;
>> -
>> -		ret = pci_user_write_config_dword(dev, vpd->cap + PCI_VPD_DATA, val);
>> +		ret = pci_user_write_config_dword(dev, vpd->cap + PCI_VPD_DATA,
>> +						  get_unaligned_le32(buf));
>>  		if (ret < 0)
>>  			break;
>>  		ret = pci_user_write_config_word(dev, vpd->cap + PCI_VPD_ADDR,
>> @@ -286,6 +280,7 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
>>  			break;
>>  
>>  		pos += sizeof(u32);
>> +		buf += sizeof(u32);
>>  	}
>>  out:
>>  	mutex_unlock(&vpd->lock);
>>
> 
> Please disregard this patch. According to PCI 2.2 spec the address needs to be dword-aligned.
> I will address this in a separate patch.
> 
Sorry, I just confused something and wrote before finished thinking. The change is correct.
