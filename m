Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 286F4194921
	for <lists+linux-pci@lfdr.de>; Thu, 26 Mar 2020 21:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgCZU1n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Mar 2020 16:27:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34938 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgCZU1n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Mar 2020 16:27:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id m3so9085109wmi.0
        for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2020 13:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jktZmsbVaYfCQgFOQaxsmSKFGgjNxgTE596K7P299tE=;
        b=NW6aBYcPaS+mV12mZI3RwuGwl661E+UeEa0aLD0xlene0yT8jFuQjiyMO8Egf9E1/J
         hW5U6XeM9hERkrwd9JblHkbFP/0Pd/TA5sixZ8NXNoA7UTXPJTjRjvCSqBZGo6ZC98mD
         8U0G0eT/ySTliP/NyqtRXcichG/ZtK3sg0q0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jktZmsbVaYfCQgFOQaxsmSKFGgjNxgTE596K7P299tE=;
        b=tswV6BLIGUw4JTd6NvmLHNhMn6ZBYc3EshPiYcfhjSoHqipJo7mPjTGf0PnHJnJc1H
         lgkITj3yzbg/oJ/WyA4LAV64erDRF6D8a9Q6cVDhlN5DgekU8WLe2Sz3THnX4X2XFLdy
         EWQhvXBMLiERPPZYaq4jwNXRWYb7s+9BXBixPfQIFPD4FJKOt9vgK5/SFprQEFkdGyEv
         FY7adhLaDLL/FJgycVXhZK9WJWOHeSxZ4V3DJotfCMdKkzIVCPF7OA505QYFzSemK57M
         2ELi+X+P6qlNLAUbcbzKlYJf8czMGYILA0yCDNStRmJoRaPdxve8qsyWkIi2oQkKieY9
         ozlw==
X-Gm-Message-State: ANhLgQ1wHZ4F6LHTzyEX5PL4Cek8iAHRfKU8wkzCGKjhIfjzaLNIy8Nv
        6rNIafUawpqy9BYAIigqp6O0sQ==
X-Google-Smtp-Source: ADFU+vtPU+HGPWL46bllQ2v2aFSum+2CVfuDGlxDWR+RJJM/9IcDZhej6z0Z7gBtu6+LExlU9PYARw==
X-Received: by 2002:adf:d4ce:: with SMTP id w14mr11426931wrk.101.1585254461368;
        Thu, 26 Mar 2020 13:27:41 -0700 (PDT)
Received: from [10.230.26.36] ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id f14sm5010601wmb.3.2020.03.26.13.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 13:27:40 -0700 (PDT)
Subject: Re: [PATCH 1/3] PCI: iproc: fix out of bound array access
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Andrew Murray <andrew.murray@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bharat Gooty <bharat.gooty@broadcom.com>
References: <20200326194810.GA11112@google.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <4a836faf-645d-a1ab-d525-738a318758a0@broadcom.com>
Date:   Thu, 26 Mar 2020 13:27:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326194810.GA11112@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 3/26/2020 12:48 PM, Bjorn Helgaas wrote:
> Change subject to match convention, e.g.,
> 
>   PCI: iproc: Fix out-of-bound array accesses
> 
> On Thu, Mar 26, 2020 at 12:37:25PM +0530, Srinath Mannam wrote:
>> From: Bharat Gooty <bharat.gooty@broadcom.com>
>>
>> Declare the full size array for all revisions of PAX register sets
>> to avoid potentially out of bound access of the register array
>> when they are being initialized in the 'iproc_pcie_rev_init'
>> function.
> 
> s/the 'iproc_pcie_rev_init' function/iproc_pcie_rev_init()/
> 
> It's outside the scope of this patch, but I'm not really a fan of the
> pcie->reg_offsets[] scheme this driver uses to deal with these
> differences.  There usually seems to be *something* that keeps the
> driver from referencing registers that don't exist, but it doesn't
> seem like the mechanism is very consistent or robust:
> 
>   - IPROC_PCIE_LINK_STATUS is implemented by PAXB but not PAXC.
>     iproc_pcie_check_link() avoids using it if "ep_is_internal", which
>     is set for PAXC and PAXC_V2.  Not an obvious connection.
> 
>   - IPROC_PCIE_CLK_CTRL is implemented for PAXB and PAXC_V1, but not
>     PAXC_V2.  iproc_pcie_perst_ctrl() avoids using it ep_is_internal",
>     so it *doesn't* use it for PAXC_V1, which does implement it.
>     Maybe a bug, maybe intentional; I can't tell.
> 
>   - IPROC_PCIE_INTX_EN is only implemented by PAXB (not PAXC), but
>     AFAICT, we always call iproc_pcie_enable() and rely on
>     iproc_pcie_write_reg() silently drop the write to it on PAXC.
> 
>   - IPROC_PCIE_OARR0 is implemented by PAXB and PAXB_V2 and used by
>     iproc_pcie_map_ranges(), which is called if "need_ob_cfg", which
>     is set if there's a "brcm,pcie-ob" DT property.  No clear
>     connection to PAXB.
> 
> I think it would be more readable if we used a single variant
> identifier consistently, e.g., the "pcie->type" already used in
> iproc_pcie_msi_steer(), or maybe a set of variant-specific function
> pointers as pcie-qcom.c does.
> 

It is not possible to use a single variant identifier consistently,
i.e., 'pcie->type'. Many of these features are controller revision
specific, and certain revisions of the controllers may all have a
certain feature, while other revisions of the controllers do not. In
addition, there are overlap in features across different controllers.

IMO, it makes sense to have feature specific flags or booleans, and have
those features enabled or disabled based on 'pcie->type', which is what
the current driver does, but like you pointed out, what the driver
failed is to do this consistently.

The IPROC_PCIE_INTX_EN example you pointed out is a good example. I
agree with you that we shouldn't rely on iproc_pcie_write_reg to
silently drop the operation for PAXC. We should add code to make it
explictly obvious that legacy interrupt is not supported in all PAXC
controllers.

pcie->pcie->reg_offsets[] scheme was not intended to be used to silently
drop register access that are activated based on features. It's a
mistake that should be fixed if some code in the driver is done that
way, as you pointed out. The intention of reg_offsets[] is to allow many
of the code in this driver be made generic, and shared between different
revisions of the driver.

Thanks,

Ray

>> Fixes: 06324ede76cdf ("PCI: iproc: Improve core register population")
>> Signed-off-by: Bharat Gooty <bharat.gooty@broadcom.com>
>> ---
>>  drivers/pci/controller/pcie-iproc.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
>> index 0a468c7..6972ca4 100644
>> --- a/drivers/pci/controller/pcie-iproc.c
>> +++ b/drivers/pci/controller/pcie-iproc.c
>> @@ -307,7 +307,7 @@ enum iproc_pcie_reg {
>>  };
>>  
>>  /* iProc PCIe PAXB BCMA registers */
>> -static const u16 iproc_pcie_reg_paxb_bcma[] = {
>> +static const u16 iproc_pcie_reg_paxb_bcma[IPROC_PCIE_MAX_NUM_REG] = {
>>  	[IPROC_PCIE_CLK_CTRL]		= 0x000,
>>  	[IPROC_PCIE_CFG_IND_ADDR]	= 0x120,
>>  	[IPROC_PCIE_CFG_IND_DATA]	= 0x124,
>> @@ -318,7 +318,7 @@ static const u16 iproc_pcie_reg_paxb_bcma[] = {
>>  };
>>  
>>  /* iProc PCIe PAXB registers */
>> -static const u16 iproc_pcie_reg_paxb[] = {
>> +static const u16 iproc_pcie_reg_paxb[IPROC_PCIE_MAX_NUM_REG] = {
>>  	[IPROC_PCIE_CLK_CTRL]		= 0x000,
>>  	[IPROC_PCIE_CFG_IND_ADDR]	= 0x120,
>>  	[IPROC_PCIE_CFG_IND_DATA]	= 0x124,
>> @@ -334,7 +334,7 @@ static const u16 iproc_pcie_reg_paxb[] = {
>>  };
>>  
>>  /* iProc PCIe PAXB v2 registers */
>> -static const u16 iproc_pcie_reg_paxb_v2[] = {
>> +static const u16 iproc_pcie_reg_paxb_v2[IPROC_PCIE_MAX_NUM_REG] = {
>>  	[IPROC_PCIE_CLK_CTRL]		= 0x000,
>>  	[IPROC_PCIE_CFG_IND_ADDR]	= 0x120,
>>  	[IPROC_PCIE_CFG_IND_DATA]	= 0x124,
>> @@ -363,7 +363,7 @@ static const u16 iproc_pcie_reg_paxb_v2[] = {
>>  };
>>  
>>  /* iProc PCIe PAXC v1 registers */
>> -static const u16 iproc_pcie_reg_paxc[] = {
>> +static const u16 iproc_pcie_reg_paxc[IPROC_PCIE_MAX_NUM_REG] = {
>>  	[IPROC_PCIE_CLK_CTRL]		= 0x000,
>>  	[IPROC_PCIE_CFG_IND_ADDR]	= 0x1f0,
>>  	[IPROC_PCIE_CFG_IND_DATA]	= 0x1f4,
>> @@ -372,7 +372,7 @@ static const u16 iproc_pcie_reg_paxc[] = {
>>  };
>>  
>>  /* iProc PCIe PAXC v2 registers */
>> -static const u16 iproc_pcie_reg_paxc_v2[] = {
>> +static const u16 iproc_pcie_reg_paxc_v2[IPROC_PCIE_MAX_NUM_REG] = {
>>  	[IPROC_PCIE_MSI_GIC_MODE]	= 0x050,
>>  	[IPROC_PCIE_MSI_BASE_ADDR]	= 0x074,
>>  	[IPROC_PCIE_MSI_WINDOW_SIZE]	= 0x078,
>> -- 
>> 2.7.4
>>
