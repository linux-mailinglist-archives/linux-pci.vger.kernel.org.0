Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D6030D4A3
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 09:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbhBCIE5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 03:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbhBCIEw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2021 03:04:52 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301E6C0613D6
        for <linux-pci@vger.kernel.org>; Wed,  3 Feb 2021 00:04:12 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id g10so23080181wrx.1
        for <linux-pci@vger.kernel.org>; Wed, 03 Feb 2021 00:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F2p7N9jrEkC2QmwENBB8YK4mFeh0YxEMnPVDtpiql+A=;
        b=Q97z1WGtVIPtmFuNe6yVbmC6mkokgfR9tq8T9EgfIrmWwsP186FprXNiFMRO1MgzLp
         uRO2L4M/IJJWkqlBFGnREoWYkcLEjGqie9EvKQlObOHVYJCWrxBB/A+JX142+F4o/InK
         lp33wycsrtyJmZdQFULjyTh3rPNZ5A9pOxQ2cFHNX6CD4Qz/+hcz8fzpgfnHFkRBE9he
         lXiWFx2z9A3jfb+b+76jQAQbJERmayqYsylgHdISSOZYiyHsmDXyXOLR5m9narm3RZy4
         ozEnCyiwTszxd61bRu7q/OsAkJq9teGkrZFGDjmfOdnAMAi5lu/DEZoMrWwJU6uNAgQb
         b46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F2p7N9jrEkC2QmwENBB8YK4mFeh0YxEMnPVDtpiql+A=;
        b=fFOEIdHgUtpwscWm9VM90Q6lE30SafXQUFZeQuz/A7Nmd8MFDENmmVJtJHjHrVr/rn
         jzgxJBwDe7RI39o5znrt5WmS6iMAmHBLd7KTfTdRdSveIIGDp0hsoukjBkTQ/4iLOCar
         jqZXhkrW5he4WUV7r0dtRtWRWvVX9nBKPLpomaiBK4mFXEgM094SPVpQ7zrmAbLKxb5u
         j9ckB1PesFu2AHsxEnRjJBRQLsd/4pYOolCG30VJz25ijjgEA5gXjARnLujEB5/7cBEt
         EWpW8OlmyW+/68aVssOQtQL+48ar530HqlNtK096Cz6D2rB4Sf/D3NVOV0Z4tHaf8mzO
         gDFA==
X-Gm-Message-State: AOAM530wfHp5hI6hbowUVuBMz5/2gPv7Qfb8Q0KEP2dGRefcjTT5GN1V
        8OwRLirnhna1PO1Ql8rPWD0HDAi0GF4=
X-Google-Smtp-Source: ABdhPJzKeD7zVf3dHVwWo0kbb0TRaO9Lh8RSlbAoLcj/T3r9SXGQmzP6H3EphUBfQfOwjL5Xitrzzg==
X-Received: by 2002:a5d:6c6d:: with SMTP id r13mr2021793wrz.343.1612339450653;
        Wed, 03 Feb 2021 00:04:10 -0800 (PST)
Received: from ?IPv6:2003:ea:8f1f:ad00:f08f:200e:76bc:9fee? (p200300ea8f1fad00f08f200e76bc9fee.dip0.t-ipconnect.de. [2003:ea:8f1f:ad00:f08f:200e:76bc:9fee])
        by smtp.googlemail.com with ESMTPSA id e16sm2290769wrp.24.2021.02.03.00.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 00:04:10 -0800 (PST)
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20210203000952.GA151813@bjorn-Precision-5520>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 2/2] PCI/VPD: Improve handling binary sysfs attribute
Message-ID: <d2b57596-f569-2fdf-0223-005e25929fde@gmail.com>
Date:   Wed, 3 Feb 2021 09:03:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210203000952.GA151813@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03.02.2021 01:09, Bjorn Helgaas wrote:
> On Thu, Jan 07, 2021 at 10:48:55PM +0100, Heiner Kallweit wrote:
>> Since 104daa71b396 ("PCI: Determine actual VPD size on first access")
>> there's nothing that keeps us from using a static attribute.
>> This allows to significantly simplify the code.
> 
> I love this!  A few comments below.
> 
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/pci/vpd.c | 42 +++++++++++-------------------------------
>>  1 file changed, 11 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
>> index a3fd09105..9ef8f400e 100644
>> --- a/drivers/pci/vpd.c
>> +++ b/drivers/pci/vpd.c
>> @@ -21,7 +21,6 @@ struct pci_vpd_ops {
>>  
>>  struct pci_vpd {
>>  	const struct pci_vpd_ops *ops;
>> -	struct bin_attribute *attr;	/* Descriptor for sysfs VPD entry */
>>  	struct mutex	lock;
>>  	unsigned int	len;
>>  	u16		flag;
>> @@ -397,57 +396,38 @@ void pci_vpd_release(struct pci_dev *dev)
>>  	kfree(dev->vpd);
>>  }
>>  
>> -static ssize_t read_vpd_attr(struct file *filp, struct kobject *kobj,
>> -			     struct bin_attribute *bin_attr, char *buf,
>> -			     loff_t off, size_t count)
>> +static ssize_t vpd_read(struct file *filp, struct kobject *kobj,
>> +			struct bin_attribute *bin_attr, char *buf,
>> +			loff_t off, size_t count)
>>  {
>>  	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
>>  
>>  	return pci_read_vpd(dev, off, count, buf);
>>  }
>>  
>> -static ssize_t write_vpd_attr(struct file *filp, struct kobject *kobj,
>> -			      struct bin_attribute *bin_attr, char *buf,
>> -			      loff_t off, size_t count)
>> +static ssize_t vpd_write(struct file *filp, struct kobject *kobj,
>> +			 struct bin_attribute *bin_attr, char *buf,
>> +			 loff_t off, size_t count)
>>  {
>>  	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
>>  
>>  	return pci_write_vpd(dev, off, count, buf);
>>  }
>>  
>> +static const BIN_ATTR_RW(vpd, 0);
> 
> Wow, I'm surprised that there are only 50ish uses of BIN_ATTR_*():
> s390/crypto, w1/slaves/..., and a few other places.  It always makes
> me wonder when we're one of a small number of callers.  Seems OK
> though.
> 
>>  void pcie_vpd_create_sysfs_dev_files(struct pci_dev *dev)
>>  {
>> -	int retval;
>> -	struct bin_attribute *attr;
>> -
>>  	if (!dev->vpd)
>>  		return;
>>  
>> -	attr = kzalloc(sizeof(*attr), GFP_ATOMIC);
>> -	if (!attr)
>> -		return;
>> -
>> -	sysfs_bin_attr_init(attr);
>> -	attr->size = 0;
>> -	attr->attr.name = "vpd";
>> -	attr->attr.mode = S_IRUSR | S_IWUSR;
>> -	attr->read = read_vpd_attr;
>> -	attr->write = write_vpd_attr;
>> -	retval = sysfs_create_bin_file(&dev->dev.kobj, attr);
>> -	if (retval) {
>> -		kfree(attr);
>> -		return;
>> -	}
>> -
>> -	dev->vpd->attr = attr;
> 
> Above is awesome.  Also maybe confirms that we could remove the
> "attr->size = 0" assignment in the previous patch?
> 
Technically this assignment has never been needed, because the
attribute memory is kzalloc'ed. But it makes clear to the
reader that sysfs code isn't supposed to do any length checks.

>> +	if (sysfs_create_bin_file(&dev->dev.kobj, &bin_attr_vpd))
>> +		pci_warn(dev, "can't create VPD sysfs file\n");
> 
> Not sure we need this.  Can't we use the .is_visible() thing and an
> attribute group to get rid of the explicit sysfs_create_bin_file()?
> 
Nice. Let me do this, I'll send a v2 of the series.

>>  }
>>  
>>  void pcie_vpd_remove_sysfs_dev_files(struct pci_dev *dev)
>>  {
>> -	if (dev->vpd && dev->vpd->attr) {
>> -		sysfs_remove_bin_file(&dev->dev.kobj, dev->vpd->attr);
>> -		kfree(dev->vpd->attr);
>> -	}
>> +	sysfs_remove_bin_file(&dev->dev.kobj, &bin_attr_vpd);
>>  }
>>  
>>  int pci_vpd_find_tag(const u8 *buf, unsigned int off, unsigned int len, u8 rdt)
>> -- 
>> 2.30.0
>>
>>

