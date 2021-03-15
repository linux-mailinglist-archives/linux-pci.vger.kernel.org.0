Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E4D33B031
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 11:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhCOKpb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Mar 2021 06:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhCOKpN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Mar 2021 06:45:13 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A41C061574;
        Mon, 15 Mar 2021 03:45:12 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id v9so56066161lfa.1;
        Mon, 15 Mar 2021 03:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cf/aVt0Fbhu5WfotxcxutYkGHVlDLmOpmLNNwK3sBZI=;
        b=JRHUUhQSGb7+0j6CspMs/ldU2pmnNnbCn9NrSiMrCatZxgv/saxOBi+FE7tRR4acPo
         kXbX5HeZSs3nWJ8IRz4szlu9ADAbJGeBf7bntPKONeYgAT7WmnMWyvVp128acMDSWGZ2
         Xy2GkqzHrj4ehh2r8yvCGgxLiTTLzgwHSmAq+Vk/8zbreCfh/9RpHJy0U3kR4OgMyd0T
         3Jpz9WxbDwLFrm05tf1aKbTsEb8KZA5m0B0c4b8rmgULcgYrZkkY19WKuOdM3uwFmmDK
         VvJsvSuf4vzsFBbb258wNGIwLjDdo5QFZj6cA4lb7L9xSsuzgJK2ulqmGo8tXqP2sua/
         6X4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cf/aVt0Fbhu5WfotxcxutYkGHVlDLmOpmLNNwK3sBZI=;
        b=YD17oryqZckqLrB6PZdbBNHoB64AsxvAh0BJy1cOxnifMBuuQsW2vxfJbxbTwJTLFX
         um++OQt5q0i1xeGBOK/vEXQ9C3cpT6GfHgE3VtwRHc2+0MriQTaPuIMF7HcziuvgbpdS
         TZsvbcWstCw6iaoo5mZF7GJAWR55xanKd6ZgA8zEK+5Yo8S5Cz66sWtN18aEdZ1EkMfH
         8DhmB6GDZ/YgX3deIAJpPMJPHc2cIUh3dQz9zbC4/LW15mKB6pFhySwwTg2Aocn7+Yyd
         defoM0i8b2AcY3zwfB80p93TlhMz9BK6IwLzd67GMj9NUoK5b2ndxUp7JszCMyneCirb
         c+wg==
X-Gm-Message-State: AOAM531igwWgDYyNRHkDVoLTtEmmzSsukKLHtnjRRV8g7xlUO0p60TKa
        ZT0SABDnMzaq5oVYB46RgHk=
X-Google-Smtp-Source: ABdhPJyWV3azW1LepSI5Vg3RXAIDsYAFaCVM8bICRrBwtSl9boAGzvHH0mTgJhcRbclZbxpYjG1uew==
X-Received: by 2002:a05:6512:38ca:: with SMTP id p10mr7662311lft.46.1615805110967;
        Mon, 15 Mar 2021 03:45:10 -0700 (PDT)
Received: from ?IPv6:2001:14ba:efe:51f0:9841:e955:b419:83eb? (db7-gd8f4kjz1nqy5ts1t-3.rev.dnainternet.fi. [2001:14ba:efe:51f0:9841:e955:b419:83eb])
        by smtp.gmail.com with ESMTPSA id k29sm2607068lfj.125.2021.03.15.03.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 03:45:10 -0700 (PDT)
Subject: Re: [PATCH v3] PCI: Add quirk for preventing bus reset on TI C667X
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     kw@linux.com, alex.williamson@redhat.com, bhelgaas@google.com,
        kishon@ti.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, m-karicheri2@ti.com
References: <20210312210917.GA2290948@bjorn-Precision-5520>
From:   =?UTF-8?Q?Antti_J=c3=a4rvinen?= <antti.jarvinen@gmail.com>
Message-ID: <e1802666-8f99-c7d6-b72c-3fcf960a87e4@gmail.com>
Date:   Mon, 15 Mar 2021 12:45:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210312210917.GA2290948@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12.3.2021 23.09, Bjorn Helgaas wrote:
> On Mon, Mar 08, 2021 at 02:21:30PM +0000, Antti Järvinen wrote:
>> Some TI KeyStone C667X devices do no support bus/hot reset. Its PCIESS
>> automatically disables LTSSM when secondary bus reset is received and
>> device stops working. Prevent bus reset by adding quirk_no_bus_reset to
>> the device. With this change device can be assigned to VMs with VFIO,
>> but it will leak state between VMs.
> 
> s/do no/do/not/ (also in the comment below)
> 

Should be fixed in v4 patch.
 
> Does the user get any indication of this leaking state?  I looked
> through drivers/vfio and drivers/pci, but I haven't found anything
> yet.
> 

I haven't seen any indication too. 

Overall I think all devices having this quirk will leak state, as they
don't get resetted.


> We *could* log something in quirk_no_bus_reset(), but that would just
> be noise for people who don't pass the device through to a VM.  So
> maybe it would be nicer if we logged something when we actually *do*
> pass it through to a VM.
> 
>> Reference: https://e2e.ti.com/support/processors/f/791/t/954382
>> Signed-off-by: Antti Järvinen <antti.jarvinen@gmail.com>
>> ---
>>  drivers/pci/quirks.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 653660e3ba9e..d9201ad1ca39 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -3578,6 +3578,16 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034, quirk_no_bus_reset);
>>   */
>>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset);
>>  
>> +/*
>> + * Some TI keystone C667X devices do no support bus/hot reset.
>> + * Its PCIESS automatically disables LTSSM when secondary bus reset is
>> + * received and device stops working. Prevent bus reset by adding
>> + * quirk_no_bus_reset to the device. With this change device can be
>> + * assigned to VMs with VFIO, but it will leak state between VMs.
>> + * Reference https://e2e.ti.com/support/processors/f/791/t/954382
>> + */
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TI, 0xb005, quirk_no_bus_reset);
>> +
>>  static void quirk_no_pm_reset(struct pci_dev *dev)
>>  {
>>  	/*
>> -- 
>> 2.17.1
>>
