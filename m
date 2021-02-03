Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F0F30D4A2
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 09:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbhBCIE4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 03:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbhBCIEv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2021 03:04:51 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E611DC06174A
        for <linux-pci@vger.kernel.org>; Wed,  3 Feb 2021 00:04:10 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v15so23104367wrx.4
        for <linux-pci@vger.kernel.org>; Wed, 03 Feb 2021 00:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=am0KqW9fBPwVrDuzP8VC76/ZM0x7toLVBWQ4oShfx2o=;
        b=syszducIjgUsxVxBJxTbAsuQNzZDl7i4rMW6A/G+cOJE2pmmvaZa3QNXCaCPN6We8T
         qr7n+tPO8G/gBYhJZv+W+LRHEJXTBvASm0khY9eiRnXNy3NTSWh2iwvSWcWnSRUJ+ZmG
         kb4OMXKBp9rWt4SMxWNWZMjWJ/sYHX/ShqKEg8bORz95xAmhX1G3NST6z0fkwe8aqRbX
         7cLw0v7lvy+6pMRU2nmRT89cjd8vZOEr3Px37+l+hg3E7qACjYUzYoYwWK88OPyMB+N3
         3SwJXFSVgRIW7eMOEJlQdLlSNISzB3325qOGJOTaDhxu84AMaa6iv7KrDEJ5PYzo7Ebm
         3rCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=am0KqW9fBPwVrDuzP8VC76/ZM0x7toLVBWQ4oShfx2o=;
        b=Bn6WGxphhemxc8VVwNGhcePANxL9dvLJLbt1bBM8Ze41A5RZsKZMhs/tge2wYLo3i0
         0XZPrUcwBm42ukF6tJWtfrt82ED5me/qJtWMzn+STzENuCbbqtWSuCXNFvD+d7aeJcnm
         sb3FgE3MB4ETXEX1DFfmRS7D8J3ybWRgWUv8zY9BbLbnaEBoTFpNCPr1gBtQrU8CJVct
         dsW/tdB+7H4NcIwlqH692Was5rDZkSj2cZ7YOG77ZxWX76rPsTXLV5MiEMzYP/A5igaw
         QvXD2EY0RF2KWfQVfBLa5m/Uk+fyRDOs0N122wOLiJTMLWcHxDZHWRlQM48lQTzpZjhV
         f7BA==
X-Gm-Message-State: AOAM533qEXLxl67pDudFrhL3mIPcvJltKhVzFfDtik9gEhxXpRlEMU4U
        KnxCLU2PP86rP7IiieYnBut5hW9AjC4=
X-Google-Smtp-Source: ABdhPJwcj6imIolqfNZv9psRcgizsSK6m/9iq7A1xZ9G+we1xxUgsbhXy79R7naqS/UKr7U0+Unudg==
X-Received: by 2002:adf:fd52:: with SMTP id h18mr2011357wrs.295.1612339449486;
        Wed, 03 Feb 2021 00:04:09 -0800 (PST)
Received: from ?IPv6:2003:ea:8f1f:ad00:f08f:200e:76bc:9fee? (p200300ea8f1fad00f08f200e76bc9fee.dip0.t-ipconnect.de. [2003:ea:8f1f:ad00:f08f:200e:76bc:9fee])
        by smtp.googlemail.com with ESMTPSA id o12sm2186164wrx.82.2021.02.03.00.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 00:04:08 -0800 (PST)
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20210202235945.GA151272@bjorn-Precision-5520>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 1/2] PCI/VPD: Remove dead code from sysfs access functions
Message-ID: <1d86f004-d9bd-2668-1086-06137d891970@gmail.com>
Date:   Wed, 3 Feb 2021 08:17:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210202235945.GA151272@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03.02.2021 00:59, Bjorn Helgaas wrote:
> On Thu, Jan 07, 2021 at 10:48:15PM +0100, Heiner Kallweit wrote:
>> Since 104daa71b396 ("PCI: Determine actual VPD size on first access")
>> attribute size is set to 0 (unlimited). So let's remove this now
>> dead code.
> 
> Doesn't the 104daa71b396 commit log say "attr->size == 0" means the
> size is unknown (not unlimited)?
> 
If attr->size == 0, then sysfs code will not check whether a read/write
access is out of bounds. It expects that the respective driver returns
an error or less than the requested data when reading beyond the
actual size. And that's exactly what we do in the VPD code.

> But I don't think vpd.c does anything at all with attr->size other
> than set it to zero.  Is there some reason we can't remove the
> "attr->size = 0" assignment, too?
> 
We could rely on zero-initialization of the allocated memory.
But leaving this assignment makes clear that sysfs code doesn't have
to check length restrictions.

> Maybe the sysfs attribute code uses it?  But I don't see vpd.c doing
> anything that would contribute to that.
> 
Yes, attr->size is used by sysfs code only.

> Sorry, I'm just puzzled.
> 
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/pci/vpd.c | 14 --------------
>>  1 file changed, 14 deletions(-)
>>
>> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
>> index 7915d10f9..a3fd09105 100644
>> --- a/drivers/pci/vpd.c
>> +++ b/drivers/pci/vpd.c
>> @@ -403,13 +403,6 @@ static ssize_t read_vpd_attr(struct file *filp, struct kobject *kobj,
>>  {
>>  	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
>>  
>> -	if (bin_attr->size > 0) {
>> -		if (off > bin_attr->size)
>> -			count = 0;
>> -		else if (count > bin_attr->size - off)
>> -			count = bin_attr->size - off;
>> -	}
>> -
>>  	return pci_read_vpd(dev, off, count, buf);
>>  }
>>  
>> @@ -419,13 +412,6 @@ static ssize_t write_vpd_attr(struct file *filp, struct kobject *kobj,
>>  {
>>  	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
>>  
>> -	if (bin_attr->size > 0) {
>> -		if (off > bin_attr->size)
>> -			count = 0;
>> -		else if (count > bin_attr->size - off)
>> -			count = bin_attr->size - off;
>> -	}
>> -
>>  	return pci_write_vpd(dev, off, count, buf);
>>  }
>>  
>> -- 
>> 2.30.0
>>
>>

