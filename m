Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB3842731D
	for <lists+linux-pci@lfdr.de>; Fri,  8 Oct 2021 23:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhJHVjo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Oct 2021 17:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhJHVjn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Oct 2021 17:39:43 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A404C061570
        for <linux-pci@vger.kernel.org>; Fri,  8 Oct 2021 14:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=2Mtl2skKVxX8eNy2j6eH+srbK/V2lEHz5HNSFOinQaA=; b=rzg+Z2ep9mIEE+vPZi/2B46pPE
        WR9IVNqSh3iyeNj/zfQMq07Hh21UtobG+Ck1kRa3HOtwLU44JUfu6u26bcEBj1K9aNJmJN/cMejZk
        EZIa0qskLywgZimvrkPwEUsDGYOPG7J8dyQ+r4//8tZZ/WmZ/ZKQ3xyQSWrQBxC4eaD3kWlXtgw6p
        vgXhAiW+7Ok7DZgp+WK3xVRE2UGBSgiCrNx/5rR08IoF3kyEW7ky9ViDg+PhheLA4X1VLnklOO6PF
        71i+Be+ZhB0dqfRj8XYE5N/Fz2SmUNKsQqoOJu/a74XSu9kuafE0hV+DuheXzOjm2Oc/OOuJCLnaI
        fRRRpYhw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYxYl-004E7u-SK; Fri, 08 Oct 2021 21:37:43 +0000
Subject: Re: [PATCH] PCI: vmd: depend on !UML
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "Berg, Johannes" <johannes.berg@intel.com>
References: <20210811162530.affe26231bc3.I131b3c1e67e3d2ead6e98addd256c835fbef9a3e@changeid>
 <a8905276-7b46-cc50-740f-b9d86ec54717@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <613ef347-cafe-8b4e-ed89-8730aad4d6ef@infradead.org>
Date:   Fri, 8 Oct 2021 14:37:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <a8905276-7b46-cc50-740f-b9d86ec54717@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/11/21 7:43 AM, Derrick, Jonathan wrote:
> Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
> 

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Bjorn, can you merge this, please?
or did you expect it to be merged somewhere else?

thanks.

> On 8/11/2021 8:25 AM, Johannes Berg wrote:
>> From: Johannes Berg <johannes.berg@intel.com>
>>
>> With UML having enabled (simulated) PCI on UML, VMD breaks
>> allyesconfig/allmodconfig compilation because it assumes
>> it's running on X86_64 bare metal, and has hardcoded API
>> use of ARCH=x86. Make it depend on !UML to fix this.
>>
>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>> ---
>>   drivers/pci/controller/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
>> index 64e2f5e379aa..297bbd86806a 100644
>> --- a/drivers/pci/controller/Kconfig
>> +++ b/drivers/pci/controller/Kconfig
>> @@ -257,7 +257,7 @@ config PCIE_TANGO_SMP8759
>>   	  config and MMIO accesses.
>>   
>>   config VMD
>> -	depends on PCI_MSI && X86_64 && SRCU
>> +	depends on PCI_MSI && X86_64 && SRCU && !UML
>>   	tristate "Intel Volume Management Device Driver"
>>   	help
>>   	  Adds support for the Intel Volume Management Device (VMD). VMD is a
>>


-- 
~Randy
