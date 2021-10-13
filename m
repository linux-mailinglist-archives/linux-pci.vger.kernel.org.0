Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A1142C9AF
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 21:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhJMTOd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 15:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhJMTOd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Oct 2021 15:14:33 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BA2C061570
        for <linux-pci@vger.kernel.org>; Wed, 13 Oct 2021 12:12:29 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e12so11746811wra.4
        for <linux-pci@vger.kernel.org>; Wed, 13 Oct 2021 12:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RTEuaNVerH44msHPFHkC9nYaFuCv/TdxLnI+ogS+hlY=;
        b=mrZ7ojR0K4y031FBsSTlH8rpbDOTLeUf+3MX27CmkfIrOpbUFzDnJg55znk6UTD/UR
         QyMXjEcHHESpi+PcXwD8OjBI+7O5DgLF/NKVO0tlrZf0LK7eovsrT9RdILfNKhYFvU2+
         0udOa8fm+Ymzt3HD5cWws1zcZhiwNGdMeLj5fYUkMjDTEIudflrrkBNMadZpmNyi1uFX
         bNFHwiV5j4MdyOh9w4DjjXIC48b853vrXGHneAJ1MfptEatS2j5gN5temlOcZVWNEc/h
         LGSL/5rhM+ImkBeFalE3YsMpR2m4e0rZ+nrRINknX8cxInxOnoIeSma9v22qgfkBOepD
         ftNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RTEuaNVerH44msHPFHkC9nYaFuCv/TdxLnI+ogS+hlY=;
        b=Sb+7uK4T0nNBIF7jj09uYzKpI7NvrYwYOarNqfFA1sDsSBmIF5FAH32bOoPArIT6AB
         zIcEHkT4Ja5sS6+TLflWAxvW8T03JReFXN9LcUeXo6Boqf0onZMXdTmfy7/QVAhRI7yA
         vOeC0cc9LDIz7P19VwcqonlT3PCSqtRagOntpBGOrWU1UdvIEW2HNTqeXcnVMo9DsQ0E
         BK2nsOc9IwEfWWczehen7s7GTg1O/OJ8RoOM+k6nUkOE7vpCausLpBCfnhtr3yugjzX1
         RhZvKoHLRyBySqnAlfHY7T76iBE2tiShBDw6GQdz/SVubFARDldh4p8lEE4qmNuJVtVu
         tePQ==
X-Gm-Message-State: AOAM532OQGa54k0UpUgU3i7ysAyo33RuCNEuX3XjehKERw2hIdbfOxbi
        M9FR4HMq1Gw9ycAdxlMUt6U=
X-Google-Smtp-Source: ABdhPJwI1rJ+EZv9TlRZYGR2VuELS8a5gvci6dUoLclG1ZvQ56vjBqG5yMsAMPtvQiuVAeTaIbG5Ow==
X-Received: by 2002:a05:600c:4f96:: with SMTP id n22mr1094744wmq.168.1634152347925;
        Wed, 13 Oct 2021 12:12:27 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f22:fa00:49bd:5329:15d2:9218? (p200300ea8f22fa0049bd532915d29218.dip0.t-ipconnect.de. [2003:ea:8f22:fa00:49bd:5329:15d2:9218])
        by smtp.googlemail.com with ESMTPSA id l2sm6559431wmi.1.2021.10.13.12.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 12:12:27 -0700 (PDT)
Message-ID: <ff35d592-af37-2975-0b8f-9a8e2616d38a@gmail.com>
Date:   Wed, 13 Oct 2021 21:12:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] PCI/VPD: Fix stack overflow caused by pci_read_vpd_any()
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>
References: <20211013185353.GA1909717@bhelgaas>
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20211013185353.GA1909717@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13.10.2021 20:53, Bjorn Helgaas wrote:
> On Wed, Oct 13, 2021 at 08:19:59PM +0200, Heiner Kallweit wrote:
>> Recent bug fix 00e1a5d21b4f ("PCI/VPD: Defer VPD sizing until first
>> access") interferes with the original change, resulting in a stack
>> overflow. The following fix has been successfully tested by Qian
>> and myself.
> 
> What does "the original change" refer to?  80484b7f8db1?  I guess the
> stack overflow is an unintended recursion?  Is there a URL to Qian's
> bug report with more details that we can include here?
> 

1. yes
2. yes
3. https://lore.kernel.org/netdev/e89087c5-c495-c5ca-feb1-54cf3a8775c5@quicinc.com/

>> Fixes: 80484b7f8db1 ("PCI/VPD: Use pci_read_vpd_any() in pci_vpd_size()")
>> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
>> Tested-by: Qian Cai <quic_qiancai@quicinc.com>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/pci/vpd.c | 18 +++++++++++-------
>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
>> index 5108bbd20..a4fc4d069 100644
>> --- a/drivers/pci/vpd.c
>> +++ b/drivers/pci/vpd.c
>> @@ -96,14 +96,14 @@ static size_t pci_vpd_size(struct pci_dev *dev)
>>  	return off ?: PCI_VPD_SZ_INVALID;
>>  }
>>  
>> -static bool pci_vpd_available(struct pci_dev *dev)
>> +static bool pci_vpd_available(struct pci_dev *dev, bool check_size)
>>  {
>>  	struct pci_vpd *vpd = &dev->vpd;
>>  
>>  	if (!vpd->cap)
>>  		return false;
>>  
>> -	if (vpd->len == 0) {
>> +	if (vpd->len == 0 && check_size) {
>>  		vpd->len = pci_vpd_size(dev);
>>  		if (vpd->len == PCI_VPD_SZ_INVALID) {
>>  			vpd->cap = 0;
>> @@ -156,17 +156,19 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
>>  			    void *arg, bool check_size)
>>  {
>>  	struct pci_vpd *vpd = &dev->vpd;
>> -	unsigned int max_len = check_size ? vpd->len : PCI_VPD_MAX_SIZE;
>> +	unsigned int max_len;
>>  	int ret = 0;
>>  	loff_t end = pos + count;
>>  	u8 *buf = arg;
>>  
>> -	if (!pci_vpd_available(dev))
>> +	if (!pci_vpd_available(dev, check_size))
>>  		return -ENODEV;
>>  
>>  	if (pos < 0)
>>  		return -EINVAL;
>>  
>> +	max_len = check_size ? vpd->len : PCI_VPD_MAX_SIZE;
>> +
>>  	if (pos >= max_len)
>>  		return 0;
>>  
>> @@ -218,17 +220,19 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
>>  			     const void *arg, bool check_size)
>>  {
>>  	struct pci_vpd *vpd = &dev->vpd;
>> -	unsigned int max_len = check_size ? vpd->len : PCI_VPD_MAX_SIZE;
>> +	unsigned int max_len;
>>  	const u8 *buf = arg;
>>  	loff_t end = pos + count;
>>  	int ret = 0;
>>  
>> -	if (!pci_vpd_available(dev))
>> +	if (!pci_vpd_available(dev, check_size))
>>  		return -ENODEV;
>>  
>>  	if (pos < 0 || (pos & 3) || (count & 3))
>>  		return -EINVAL;
>>  
>> +	max_len = check_size ? vpd->len : PCI_VPD_MAX_SIZE;
>> +
>>  	if (end > max_len)
>>  		return -EINVAL;
>>  
>> @@ -312,7 +316,7 @@ void *pci_vpd_alloc(struct pci_dev *dev, unsigned int *size)
>>  	void *buf;
>>  	int cnt;
>>  
>> -	if (!pci_vpd_available(dev))
>> +	if (!pci_vpd_available(dev, true))
>>  		return ERR_PTR(-ENODEV);
>>  
>>  	len = dev->vpd.len;
>> -- 
>> 2.33.0
>>

