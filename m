Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8C021232D5
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2019 17:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfLQQq0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Dec 2019 11:46:26 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56178 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727958AbfLQQq0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Dec 2019 11:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576601185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aKsNtbLIFJyPIxbIhkuqQwDdLTOvYVf+IcaJaDg+WqE=;
        b=Oeb/ZN3rBkmuzKXHZwq7klgJfPbEideHPVDz0UWz+gH7okkpPN7Cffepr/jmi9ifNQXu14
        4yVyZ38nJeYKUvZoyhZuP/wTxgws2yfvO6QrmgKW+iv0srRdflelPapk6zMOak9lHtUNvh
        bjrtxvuwA2Cpo1tBKN9nQOcyZty5tT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-LUxbjDeDN6Cb23G4hPtXJw-1; Tue, 17 Dec 2019 11:46:23 -0500
X-MC-Unique: LUxbjDeDN6Cb23G4hPtXJw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A25A8005B1;
        Tue, 17 Dec 2019 16:46:19 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 481785D9E1;
        Tue, 17 Dec 2019 16:46:15 +0000 (UTC)
Subject: Re: [PATCH v3 03/13] iommu/arm-smmu-v3: Support platform SSID
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        joro@8bytes.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
        robin.murphy@arm.com, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, robh+dt@kernel.org,
        jonathan.cameron@huawei.com, guohanjun@huawei.com,
        bhelgaas@google.com, zhangfei.gao@linaro.org, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, lenb@kernel.org
References: <20191209180514.272727-1-jean-philippe@linaro.org>
 <20191209180514.272727-4-jean-philippe@linaro.org>
 <e5b9a017-585a-5425-77bd-be40b86010e6@redhat.com>
 <20191217152108.GB2305883@myrica>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <d3ef7adf-4e9e-6b7f-c4eb-52a8f1eaa16c@redhat.com>
Date:   Tue, 17 Dec 2019 17:46:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191217152108.GB2305883@myrica>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean,

On 12/17/19 4:21 PM, Jean-Philippe Brucker wrote:
> Hi Eric,
> 
> On Tue, Dec 17, 2019 at 12:05:18PM +0100, Auger Eric wrote:
>>> +		fwspec = dev_iommu_fwspec_get(dev);
>>> +		if (!err && fwspec)
>>> +			of_property_read_u32(master_np, "pasid-num-bits",
>>> +					     &fwspec->num_pasid_bits);
>>> +	}
>> This patch dedicates to platform devices however I fail to understand,
>> at that stage, how/when do you retrieve/store the same max capability
>> for PCI devices?
> 
> For PCI devices, the max capability is only described by the PCIe PASID
> capability, not by firmware. Patch 13 deals with PCI by setting
> masted->ssid_bits from the PASID capability directly, ignoring
> fwspec->num_pasid_bits.

Get it now. thank you for the explanation.

Eric
> 
>> Besides,
>>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Thanks!
> Jean
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

