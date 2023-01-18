Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D1D671A59
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jan 2023 12:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjARLUU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 06:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjARLSk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 06:18:40 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04CD457F2
        for <linux-pci@vger.kernel.org>; Wed, 18 Jan 2023 02:33:56 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id k18so12420924pll.5
        for <linux-pci@vger.kernel.org>; Wed, 18 Jan 2023 02:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S5FkcmWc4Vga+pPOybEWy6+7SA1iVavl4uDEeNULrMI=;
        b=wAGIUjhhAOdClQfmVJIVZ/wlUnqkhd7XzlX8pd+D1t3PJUni3MwHmLvieZZbiYYC0D
         1uOOaFJ8jkHLvLueIkjVwWgeJOqSHuwSMDU8yIGFhVGyjb0wNcy+CiysiKf0Y6S43Umv
         lS/cT/qG1A0G3DLVxVL1VSIdq1XAPIEvmK+Daip9zYXLUH0L1zIpA5uqaP6w7e8LosWJ
         YzsThEA/r69nkOETtBMVNpQXu/tEiWtuEeQI3PCzIwEwS35mWaP0TdDRWW7HdReYSkUx
         S0Hnec565F7+5Wsfy/tZqrcCpx7al8V64m1qjO3EGRa/Gr5ttbl7ek2TEaubTof9Tj2o
         4kKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S5FkcmWc4Vga+pPOybEWy6+7SA1iVavl4uDEeNULrMI=;
        b=5ct7yGEHfj3WSmNI/fekCsCSdRW+e6w5vjhJbIz5el1mJZmFsStxyahO1HXzXUTgna
         4LEJQGgf6ANiLgwvQpdmg4l5EX6WgiHkOKK280kQOia9iyWV8yz6WV2fFv/EmpSjhvGG
         OdrFJTKkMFcZihrnlFOgza+CkUoRK7/pcnA04HCIMIimypR+Lx70Wa/QphS7JSk95df+
         yRNaXrYGPha4Cq/1T/j56+tVbtjJv8g24ySLPIyTDIKiyAaUua8vdU9RDVOLCrXlZnDu
         Xwlhm4wP6b9q6cEz4NZoydfod9k8zn/Gm9i1AoBnRFzNDkJnlMveS7xCuhKeK3lTQuaI
         Vy2w==
X-Gm-Message-State: AFqh2kqZuCZ14GmGq+kMay5YzYghdc1Rv1HixdboMFudtfw0hFOE2gGg
        AlYH2xDApU8rMv5gOhwkreJJS/sSKmCwsu2y68M=
X-Google-Smtp-Source: AMrXdXtX45t86W7xZiRJIdmxkLa3KehQKQPiRPHi1ed+/Yo0xHWCcPRFI78HkW2R6fX24CJtDTrscQ==
X-Received: by 2002:a17:90a:2fca:b0:227:b49:6233 with SMTP id n10-20020a17090a2fca00b002270b496233mr6518931pjm.45.1674038036202;
        Wed, 18 Jan 2023 02:33:56 -0800 (PST)
Received: from [10.16.128.218] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id rm10-20020a17090b3eca00b00229b00cc8desm1510122pjb.0.2023.01.18.02.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 02:33:55 -0800 (PST)
Message-ID: <5a87a5b1-270c-5756-f3f1-ecbd01c4091b@igel.co.jp>
Date:   Wed, 18 Jan 2023 19:33:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 1/3] PCI: endpoint: support an alignment aware
 map/unmaping
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Frank Li <Frank.Li@nxp.com>, Li Chen <lchen@ambarella.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230117204131.GA145312@bhelgaas>
From:   Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <20230117204131.GA145312@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2023/01/18 5:41, Bjorn Helgaas wrote:
> On Fri, Jan 13, 2023 at 06:03:48PM +0900, Shunsuke Mie wrote:
>> Add an align_mem operation to the EPC ops, which function is used to
>> pci_epc_map/unmap_addr(). These change to enable mapping for any alignment
>> restriction of EPC. The map function maps an aligned memory to include a
>> requested memory region.
> I think this does two things: 1) add the .align_mem() function
> pointer, and 2) move the pci_epc_mem_alloc_addr() call into
> pci_epc_map_addr().  For 2), I would expect to see
> pci_epc_mem_alloc_addr() being *removed* from somewhere else.
>
> Anyway, both are significant and should be mentioned in the commit
> log.  Possibly they could even be separate commits: move the
> alloc/free first, then add .align_mem().
I understood. I attempt to arrange commits as your mention.
>
> Another question below.
>
>> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
>> ---
>>   drivers/pci/endpoint/pci-epc-core.c | 57 ++++++++++++++++++++++++-----
>>   include/linux/pci-epc.h             | 10 +++--
>>   2 files changed, 53 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
>> index 2542196e8c3d..60d586e05e7d 100644
>> --- a/drivers/pci/endpoint/pci-epc-core.c
>> +++ b/drivers/pci/endpoint/pci-epc-core.c
>> @@ -430,8 +430,12 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msix);
>>    * Invoke to unmap the CPU address from PCI address.
>>    */
>>   void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>> -			phys_addr_t phys_addr)
>> +			phys_addr_t phys_addr, void __iomem *virt_addr, size_t size)
>>   {
>> +	u64 aligned_phys;
>> +	void __iomem *aligned_virt;
>> +	size_t offset;
>> +
>>   	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>   		return;
>>   
>> @@ -441,9 +445,22 @@ void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>   	if (!epc->ops->unmap_addr)
>>   		return;
>>   
>> +	if (epc->ops->align_mem) {
>> +		mutex_lock(&epc->lock);
>> +		aligned_phys = epc->ops->align_mem(epc, phys_addr, &size);
>> +		mutex_unlock(&epc->lock);
>> +	} else {
>> +		aligned_phys = phys_addr;
>> +	}
>> +
>> +	offset = phys_addr - aligned_phys;
>> +	aligned_virt = virt_addr - offset;
>> +
>>   	mutex_lock(&epc->lock);
>> -	epc->ops->unmap_addr(epc, func_no, vfunc_no, phys_addr);
>> +	epc->ops->unmap_addr(epc, func_no, vfunc_no, aligned_phys);
>>   	mutex_unlock(&epc->lock);
>> +
>> +	pci_epc_mem_free_addr(epc, aligned_phys, aligned_virt, size);
>>   }
>>   EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
>>   
>> @@ -458,26 +475,46 @@ EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
>>    *
>>    * Invoke to map CPU address with PCI address.
>>    */
>> -int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>> -		     phys_addr_t phys_addr, u64 pci_addr, size_t size)
>> +void __iomem *pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>> +		u64 pci_addr, phys_addr_t *phys_addr, size_t size)
>>   {
>>   	int ret;
>> +	u64 aligned_addr;
>> +	size_t offset;
>> +	void __iomem *virt_addr;
>>   
>>   	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>> -		return -EINVAL;
>> +		return ERR_PTR(-EINVAL);
>>   
>>   	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
>> -		return -EINVAL;
>> +		return ERR_PTR(-EINVAL);
>>   
>>   	if (!epc->ops->map_addr)
>> -		return 0;
>> +		return ERR_PTR(-ENOPTSUPP);
>> +
>> +	if (epc->ops->align_mem) {
>> +		mutex_lock(&epc->lock);
>> +		aligned_addr = epc->ops->align_mem(epc, pci_addr, &size);
>> +		mutex_unlock(&epc->lock);
>> +	} else {
>> +		aligned_addr = pci_addr;
>> +	}
>> +
>> +	offset = pci_addr - aligned_addr;
>> +
>> +	virt_addr = pci_epc_mem_alloc_addr(epc, phys_addr, size);
>> +	if (!virt_addr)
>> +		return ERR_PTR(-ENOMEM);
>>   
>>   	mutex_lock(&epc->lock);
>> -	ret = epc->ops->map_addr(epc, func_no, vfunc_no, phys_addr, pci_addr,
>> -				 size);
>> +	ret = epc->ops->map_addr(epc, func_no, vfunc_no, *phys_addr, aligned_addr, size);
>>   	mutex_unlock(&epc->lock);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>>   
>> -	return ret;
>> +	*phys_addr += offset;
>> +
>> +	return virt_addr + offset;
>>   }
>>   EXPORT_SYMBOL_GPL(pci_epc_map_addr);
>>   
>> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
>> index a48778e1a4ee..8f29161bce80 100644
>> --- a/include/linux/pci-epc.h
>> +++ b/include/linux/pci-epc.h
>> @@ -84,6 +84,7 @@ struct pci_epc_ops {
>>   			       phys_addr_t phys_addr, u8 interrupt_num,
>>   			       u32 entry_size, u32 *msi_data,
>>   			       u32 *msi_addr_offset);
>> +	u64	(*align_mem)(struct pci_epc *epc, u64 addr, size_t *size);
> Is there a requirement for multiple implementations of .align_mem()?
> There's only one implementation in this series
> (dw_pcie_ep_align_mem()), and it only needs pci->region_align.  That
> *value* might be DWC-specific, but the concept really isn't, so maybe
> there could be a generic function that uses the device-specific value.

That is the correct way, but some handlers require different implementation.

Sorry, this patch could have been misleading. it is my fault. I'll add 
the other

handlers to a next version.

>
>>   	int	(*start)(struct pci_epc *epc);
>>   	void	(*stop)(struct pci_epc *epc);
>>   	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
>> @@ -218,11 +219,12 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>   		    struct pci_epf_bar *epf_bar);
>>   void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>   		       struct pci_epf_bar *epf_bar);
>> -int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>> -		     phys_addr_t phys_addr,
>> -		     u64 pci_addr, size_t size);
>> +void __iomem *pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>> +			       u64 pci_addr, phys_addr_t *phys_addr,
>> +			       size_t size);
>>   void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>> -			phys_addr_t phys_addr);
>> +			phys_addr_t phys_addr, void __iomem *virt_addr,
>> +			size_t size);
>>   int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>   		    u8 interrupts);
>>   int pci_epc_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
>> -- 
>> 2.25.1
>>
Best,

Shunsuke

