Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D77840BAED
	for <lists+linux-pci@lfdr.de>; Wed, 15 Sep 2021 00:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbhINWIJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 18:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbhINWIF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Sep 2021 18:08:05 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7474AC061574;
        Tue, 14 Sep 2021 15:06:47 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q26so587593wrc.7;
        Tue, 14 Sep 2021 15:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UMpn+tbd0ftiqAD98wWsQls44qyzCE7DMKG8RQ3tyw4=;
        b=LQctDsB3JPRn/BhYiI8JTdYbSu4W2ogN7OOlsnvLcVDw6s8noolFDwBWeqwj0zhzuA
         UTw8hyWZycHET1xOspbME5/jqoFm5iLnw5EPpGA6RhIq/Ht+ItGGNWng+u88Ee0R5+sP
         HI/B+/UYsPwyJwRZjvNZRMneYBvPXW4A/W7p/zq/0x0vXNzTfHUj83Zv9RjcWyZdq6p6
         dOEIhJDzTW0LNYscZXhXG8e3Z6L4Rhzk9H4Q+tfXmhcUtwStFbPvk+WebQbS7Ox+tXG5
         5Pc6mzLbWDOjoheK+GcKn1AmxAdXrdOim7wAZPAb4dmDxT7rXSPTxce+Ns2jsOTVTis1
         nPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UMpn+tbd0ftiqAD98wWsQls44qyzCE7DMKG8RQ3tyw4=;
        b=ankmvHq0ZkameYSuZrTesdj+/Eo2UIGiBQKNlnZTuY0/25B7Cm6rC+F+HMc2mUgbW+
         YOvZLtZvJfnhCrVIbfX4ccGIEUNddOxLzikLEdkevs54eu/wkzCCRiK/uyAOaSpPfc14
         IZ3C19cKXtyCow9c56RAUVF+8R50cPPmkrTWhjxJTZ0Z9s8IKpFoJYuxx32t5ZoW6wZc
         nP2jzqOJO7jICoollBUqDHhUHNtCfMMx2ogi2vYd1H4AkuhZ29/7MQ4W6To+NgbyPfTk
         lTNKh4V9GU11FEs5HtO/NhRlqUTGrwIxH29gfL5UDMHD6aQFfNZ01gBPQ9fky2tgdDDk
         HG+Q==
X-Gm-Message-State: AOAM530ToHg4Vb+rbgX6sWBmCz6iCh0PZcn9QgKEoueCiO/054viBLe9
        Z5Je4TinwbtqxrfCIzmL5pmomKi3sUY=
X-Google-Smtp-Source: ABdhPJzH0hsBTQ/EoF4+1hvZQVsbN8V13TtXJ8KkFtGS6gLO2YHI2XWbz+yXR6nTt1rTfWZen4nbUg==
X-Received: by 2002:a5d:608e:: with SMTP id w14mr1430308wrt.18.1631657205849;
        Tue, 14 Sep 2021 15:06:45 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f08:4500:c837:110a:7a08:9f75? (p200300ea8f084500c837110a7a089f75.dip0.t-ipconnect.de. [2003:ea:8f08:4500:c837:110a:7a08:9f75])
        by smtp.googlemail.com with ESMTPSA id z17sm12142861wrh.66.2021.09.14.15.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 15:06:45 -0700 (PDT)
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20210914215543.GA1437800@bjorn-Precision-5520>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: Linux 5.15-rc1
Message-ID: <4f0aa389-439a-750d-a9ac-1b24ae74aacf@gmail.com>
Date:   Wed, 15 Sep 2021 00:06:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210914215543.GA1437800@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14.09.2021 23:55, Bjorn Helgaas wrote:
> On Tue, Sep 14, 2021 at 07:07:40PM +0200, Heiner Kallweit wrote:
>> On 14.09.2021 13:26, Bjorn Helgaas wrote:
>>> On Tue, Sep 14, 2021 at 08:21:46AM +0200, Heiner Kallweit wrote:
>>>> On 14.09.2021 01:46, Bjorn Helgaas wrote:
>>>
>>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID, quirk_blacklist_vpd);
>>>>>  /*
>>>>
>>>> Leaving the quirks in FIXUP_HEADER stage would have the advantage that for
>>>> blacklisted devices the vpd sysfs attribute isn't visibale. The needed
>>>> changes to the patch are minimal.
>>>
>>> What do you have in mind?  The only thing I can think of would be to
>>> add a "pci_dev.no_vpd" bit.  "vpd.cap == 0" means the device has no
>>> VPD, and "vpd.len == 0" means we haven't determined the size yet.  All
>>> devices start off with vpd.cap == 0 and vpd.len == 0, so a
>>> FIXUP_HEADER quirk would have to set a sentinel value or some other
>>> bit.
>>
>> Why not leave vpd.len == PCI_VPD_SZ_INVALID as sentinel?
> 
> Sentinel values aren't really my favorite thing, but it certainly does
> have the advantage of hiding the sysfs attribute.
> 
>> And one more question: Why do you move the "if (!vpd->cap)" check from
>> pci_vpd_read() to pci_read_vpd()? At a first glance I see no benefit.
> 
> I'm pretty sure I *had* a reason, but I can't remember right now :(
> Moving it sure does uglify pci_read_vpd() and pci_write_vpd(), though.
> 
> What do you think of the following?  (This is a diff from v5.15-rc1.)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 25557b272a4f..4be24890132e 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -99,6 +99,24 @@ static size_t pci_vpd_size(struct pci_dev *dev)
>  	return off ?: PCI_VPD_SZ_INVALID;
>  }
>  
> +static bool pci_vpd_available(struct pci_dev *dev)
> +{
> +	struct pci_vpd *vpd = &dev->vpd;
> +
> +	if (!vpd->cap)
> +		return false;
> +
> +	if (vpd->len == 0) {
> +		vpd->len = pci_vpd_size(dev);
> +		if (vpd->len == PCI_VPD_SZ_INVALID) {
> +			vpd->cap = 0;
> +			return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +
>  /*
>   * Wait for last operation to complete.
>   * This code has to spin since there is no other notification from the PCI
> @@ -145,7 +163,7 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
>  	loff_t end = pos + count;
>  	u8 *buf = arg;
>  
> -	if (!vpd->cap)
> +	if (!pci_vpd_available(dev))
>  		return -ENODEV;
>  
>  	if (pos < 0)
> @@ -206,7 +224,7 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
>  	loff_t end = pos + count;
>  	int ret = 0;
>  
> -	if (!vpd->cap)
> +	if (!pci_vpd_available(dev))
>  		return -ENODEV;
>  
>  	if (pos < 0 || (pos & 3) || (count & 3))
> @@ -242,14 +260,11 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
>  
>  void pci_vpd_init(struct pci_dev *dev)
>  {
> +	if (dev->vpd.len == PCI_VPD_SZ_INVALID)
> +		return;
> +
>  	dev->vpd.cap = pci_find_capability(dev, PCI_CAP_ID_VPD);
>  	mutex_init(&dev->vpd.lock);
> -
> -	if (!dev->vpd.len)
> -		dev->vpd.len = pci_vpd_size(dev);
> -
> -	if (dev->vpd.len == PCI_VPD_SZ_INVALID)
> -		dev->vpd.cap = 0;
>  }
>  
>  static ssize_t vpd_read(struct file *filp, struct kobject *kobj,
> @@ -294,13 +309,14 @@ const struct attribute_group pci_dev_vpd_attr_group = {
>  
>  void *pci_vpd_alloc(struct pci_dev *dev, unsigned int *size)
>  {
> -	unsigned int len = dev->vpd.len;
> +	unsigned int len;
>  	void *buf;
>  	int cnt;
>  
> -	if (!dev->vpd.cap)
> +	if (!pci_vpd_available(dev))
>  		return ERR_PTR(-ENODEV);
>  
> +	len = dev->vpd.len;
>  	buf = kmalloc(len, GFP_KERNEL);
>  	if (!buf)
>  		return ERR_PTR(-ENOMEM);
> 

This looks very good to me.
