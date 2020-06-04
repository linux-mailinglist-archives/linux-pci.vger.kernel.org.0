Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8406A1EE566
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jun 2020 15:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgFDNdd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Jun 2020 09:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbgFDNdd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2020 09:33:33 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B37AC08C5C3
        for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2020 06:33:33 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n9so2202478plk.1
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2020 06:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=RAV9/dNL++xiGiHR5A9Oc9TEhWA76VZjoAgyK161SVY=;
        b=zPMPr/YxyP3965QTpRI2+WUxZFPPhZUrUCBk07JsMf7SI3dYonyONF/w0DXsy+H5hG
         o/oJJjSdmpLtc+dJQvwp1leBctiT2Vq3wT+tqHFjb6xHMsfoWEaS9zvqmiv6i6Kypmcz
         NuPrUukPkRrFI2m5XEndHGed2uTmcHb8pnRTofbn4DegJcnfjQFGe7zPoyuv2QGsXbWh
         HH8bumkNPHc1m7ilS8Jcj/cIvN+irGawDlQl1LsOKy9ICdejCXO3r2FVOYnWv/nVXOPx
         WfGKGP7iB52c9x+wjbCYhrs/rUdGBBvxGsKjhZBtuKFDffKB+jr+YPAY9FHogJdNolMo
         B2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RAV9/dNL++xiGiHR5A9Oc9TEhWA76VZjoAgyK161SVY=;
        b=V+Lh1cejq+d3JgpFKN9OPxooTCbq2z+m08DeofP1nhXLtHkd+7sXSeTjLawe6Gg4cO
         nT4yTplP5kJek7oscgjx5APAaBgcaTrtDmHHwJ4ibTjhTRplvBT2S4GAACdQ2QldMBlL
         a13wk8b0M0kRF/zC/4hqo6FzWgPM8ZTczGX5rY78c4IvZks6ipnr4J5G2Dnr3WNhVf3t
         d9CV9C3nxQ4MRNNEjWF+LQN3Pg1Ji0EacorhWA5kEABXbpATpCZyjiTt4owiZt0mVEaC
         sxvYUytGJiI+gjTv+6ayXCewUPL7+fKTFPrm0qKGQZ6pU+80lzgcN4c4K1M+EoOQL0rc
         G/mQ==
X-Gm-Message-State: AOAM533ojMMkl4FCnd17QZMq5Gjpl7Yt5nBgxN24qdLijfh20NA/XFBH
        BHv/vpsG9GgtbX+AWVk54GLZa+m0hiOOeQ==
X-Google-Smtp-Source: ABdhPJyHAP7hdkjk0QRqpIxnyq/8FeJd16IwaXCeqaVfm7NZUPFQxKr/IxN2WFjd4DugkV/BUTo0Ew==
X-Received: by 2002:a17:902:7d85:: with SMTP id a5mr4997837plm.106.1591277612461;
        Thu, 04 Jun 2020 06:33:32 -0700 (PDT)
Received: from [10.158.2.42] ([45.135.186.31])
        by smtp.gmail.com with ESMTPSA id y6sm5569040pjw.15.2020.06.04.06.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 06:33:31 -0700 (PDT)
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
To:     Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
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
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <779f4044-cf6a-b0d3-916f-0274450c07d3@linaro.org>
Date:   Thu, 4 Jun 2020 21:33:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200601174104.GA734973@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020/6/2 上午1:41, Bjorn Helgaas wrote:
> On Thu, May 28, 2020 at 09:33:44AM +0200, Joerg Roedel wrote:
>> On Wed, May 27, 2020 at 01:18:42PM -0500, Bjorn Helgaas wrote:
>>> Is this slowdown significant?  We already iterate over every device
>>> when applying PCI_FIXUP_FINAL quirks, so if we used the existing
>>> PCI_FIXUP_FINAL, we wouldn't be adding a new loop.  We would only be
>>> adding two more iterations to the loop in pci_do_fixups() that tries
>>> to match quirks against the current device.  I doubt that would be a
>>> measurable slowdown.
>> I don't know how significant it is, but I remember people complaining
>> about adding new PCI quirks because it takes too long for them to run
>> them all. That was in the discussion about the quirk disabling ATS on
>> AMD Stoney systems.
>>
>> So it probably depends on how many PCI devices are in the system whether
>> it causes any measureable slowdown.
> I found this [1] from Paul Menzel, which was a slowdown caused by
> quirk_usb_early_handoff().  I think the real problem is individual
> quirks that take a long time.
>
> The PCI_FIXUP_IOMMU things we're talking about should be fast, and of
> course, they're only run for matching devices anyway.  So I'd rather
> keep them as PCI_FIXUP_FINAL than add a whole new phase.
>
Thanks Bjorn for taking time for this.
If so, it would be much simpler.

+++ b/drivers/iommu/iommu.c
@@ -2418,6 +2418,10 @@ int iommu_fwspec_init(struct device *dev, struct 
fwnode_handle *iommu_fwnode,
         fwspec->iommu_fwnode = iommu_fwnode;
         fwspec->ops = ops;
         dev_iommu_fwspec_set(dev, fwspec);
+
+       if (dev_is_pci(dev))
+               pci_fixup_device(pci_fixup_final, to_pci_dev(dev));
+

Then pci_fixup_final will be called twice, the first in pci_bus_add_device.
Here in iommu_fwspec_init is the second time, specifically for iommu_fwspec.
Will send this when 5.8-rc1 is open.

Thanks
