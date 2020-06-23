Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09D7204B95
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jun 2020 09:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbgFWHsw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jun 2020 03:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731585AbgFWHsv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jun 2020 03:48:51 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDFFC061797
        for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2020 00:48:50 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id p11so1015056pff.11
        for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2020 00:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=iXMHLbguntKcuTgr1nAq0fpxZctLmOVLPocRZ01HV1s=;
        b=Dvb9jWrWxYf0cUS7+mre8Ce7N6LCPCbgM4TfzIgO9x/j/Sz44QbFtHYcBvV6YcHykC
         /UOjUDAlRBaipXGhgPtfj5VOhd0MjmoLTxYmHS14ROKFa4k7B6adT6mjHgV2lQZYAb2L
         9lBtnjHKiulqZ7h6mF5QFFytTHA5SEJIAChcsfvKC0+xwvXLEhh4oJ/sXC4FDnOEad0q
         wFvAaXsf3se/vnfb3bW1sYXvPN+QVKdtP6yU8qG9ZHjQx6589ayIzIweyVGj7eNLSCdB
         qISGLxSJaNs+JUUvbM8FXzy2OTirEzU1whLCBwbJsuBLePOiMyrCufoYlY4bb/bJX8TB
         Kruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iXMHLbguntKcuTgr1nAq0fpxZctLmOVLPocRZ01HV1s=;
        b=PNfVItKLmNgAZg3UFV9KHX0e5gU932mHIu4DnCUPgkuFl8aXNxCofmfktwwTm5bRUR
         QBaGIE+9o05Qc1Z+ixm/w5BmMN/qJqwqa+W88PMzU3H1jvZpHkhtT9vn22rymTYgmD6A
         9wnT5tj1OEpbjXSUToEuuY0iXvPTlu4gzQPGWgncSnKMaLGXmPphqOpF2VVEMt2hxr33
         kid/x8bP+y6cA3h2YEgRf8HVapoL8yJpL9Anzk8iBQRxGn/uFViqHISJ0nXg1fQRq3h+
         2Imn8o2xnvGUQcNkbd8edohixQ4vJluZhBia6rzJsyFhBJ4BeivHjMUbvcMO7Z/9PWbG
         w4fw==
X-Gm-Message-State: AOAM532ad9lB7ckIH4CLulP2DSZyOHJNaO8lmcqRTiTHp+f9i2XQf+EZ
        3noevITgp132Eq2JZHAQEyKc/aRKsp09AQ==
X-Google-Smtp-Source: ABdhPJxwJ+AW8uQAXY8Win57SIEKcys5G+XsLikqbv6KNfk0Z4v0oLWW7NunPD5K78dMacn0DXTtuQ==
X-Received: by 2002:a62:f201:: with SMTP id m1mr25533751pfh.198.1592898529334;
        Tue, 23 Jun 2020 00:48:49 -0700 (PDT)
Received: from [10.37.1.30] ([45.135.186.125])
        by smtp.gmail.com with ESMTPSA id u6sm16409369pfc.83.2020.06.23.00.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 00:48:48 -0700 (PDT)
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
References: <20200601174104.GA734973@bjorn-Precision-5520>
 <779f4044-cf6a-b0d3-916f-0274450c07d3@linaro.org>
 <20200622115536.GH3701@8bytes.org>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <d007cbea-85c0-6c75-fc4a-e2872ff59ea4@linaro.org>
Date:   Tue, 23 Jun 2020 15:48:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622115536.GH3701@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Joerg

On 2020/6/22 下午7:55, Joerg Roedel wrote:
> On Thu, Jun 04, 2020 at 09:33:07PM +0800, Zhangfei Gao wrote:
>> +++ b/drivers/iommu/iommu.c
>> @@ -2418,6 +2418,10 @@ int iommu_fwspec_init(struct device *dev, struct
>> fwnode_handle *iommu_fwnode,
>>          fwspec->iommu_fwnode = iommu_fwnode;
>>          fwspec->ops = ops;
>>          dev_iommu_fwspec_set(dev, fwspec);
>> +
>> +       if (dev_is_pci(dev))
>> +               pci_fixup_device(pci_fixup_final, to_pci_dev(dev));
>> +
> That's not going to fly, I don't think we should run the fixups twice,
> and they should not be run from IOMMU code. Is the only reason for this
> second pass that iommu_fwspec is not yet allocated when it runs the
> first time? I ask because it might be easier to just allocate the struct
> earlier then.
Thanks for looking this.

Yes, it is the only reason calling fixup secondly after iommu_fwspec is 
allocated.

The first time fixup final is very early in pci_bus_add_device.
If allocating iommu_fwspec earlier, it maybe in pci_alloc_dev.
And assigning ops still in iommu_fwspec_init.
Have tested it works.
Not sure is it acceptable?

Alternatively, adding can_stall to struct pci_dev is simple but ugly too,
since pci does not know stall now.


Thanks



