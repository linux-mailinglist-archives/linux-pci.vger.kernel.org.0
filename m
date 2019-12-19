Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC69B126153
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2019 12:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLSLyf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 06:54:35 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54060 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfLSLyd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 06:54:33 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBJBsQ7f094692;
        Thu, 19 Dec 2019 05:54:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576756466;
        bh=0wneAsr2dIRQgUOU8O6OrKktT1aM0VMh6k8EH1G2T9g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Y7nKHasEJ0XxpznpaLYRknLdxcb/F01l1qO5LxRpjmiOVw6au+fi8WVMOUDtSJv9q
         MJQPniruZNRrVnECnrhvByY91xGTWQwfx16eiu4iP1OTXQ5j03qJFV4H2GRna4sT2W
         +r2J7HHMI2KErdjfWqrKaBMvFqB/jzCYK93oJoOE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBJBsQ4L001524;
        Thu, 19 Dec 2019 05:54:26 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 19
 Dec 2019 05:54:25 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 19 Dec 2019 05:54:25 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBJBsMcp080167;
        Thu, 19 Dec 2019 05:54:23 -0600
Subject: Re: [PATCH 05/13] PCI: cadence: Add read and write accessors to
 perform only 32-bit accesses
To:     Andrew Murray <andrew.murray@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-6-kishon@ti.com>
 <20191216144932.GY24359@e119886-lin.cambridge.arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <d1ee4579-a3da-6a73-3516-a6d264f80995@ti.com>
Date:   Thu, 19 Dec 2019 17:26:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216144932.GY24359@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andrew,

On 16/12/19 8:19 pm, Andrew Murray wrote:
> On Mon, Dec 09, 2019 at 02:51:39PM +0530, Kishon Vijay Abraham I wrote:
>> Certain platforms like TI's J721E allow only 32-bit register accesses.
> 
> When I first read this I thought you meant only 32-bit accesses are allowed
> and not other sizes (such as 64-bit). However the limitation you address
> here is that the J721E allows only 32-bit *aligned* register accesses.

It's both, it allows only 32-bit aligned accesses and the size should be
only 32 bits. That's why I always use "readl" in the APIs below.
> 
> It would be helpful to make this clearer in the commit message.
> 
> You can also shorten the commit subject to 'PCI: cadence: Add read/write
> accessors for 32-bit aligned accesses' or similar.
> 
>> Add read and write accessors to perform only 32-bit accesses in order to
>> support platfroms like TI's J721E.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/controller/cadence/pcie-cadence.c | 40 +++++++++++++++++++
>>  drivers/pci/controller/cadence/pcie-cadence.h |  2 +
>>  2 files changed, 42 insertions(+)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
>> index cd795f6fc1e2..de5b3b06f2d0 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence.c
>> @@ -7,6 +7,46 @@
>>  
>>  #include "pcie-cadence.h"
>>  
>> +u32 cdns_pcie_read32(void __iomem *addr, int size)
> 
> Given there is already a cdns_pcie_readl in pcie-cadence.h it may help
> to name this in a way that doesn't cause confusion. Here 32 is perhaps
> being used to suggest the size of the actual read performed, the
> maximum size of 'size' or the alignment.
> 
> 
>> +{
>> +	void __iomem *aligned_addr = PTR_ALIGN_DOWN(addr, 0x4);
>> +	unsigned int offset = (unsigned long)addr & 0x3;
>> +	u32 val = readl(aligned_addr);
>> +
>> +	if (!IS_ALIGNED((uintptr_t)addr, size)) {
>> +		pr_err("Invalid Address in function:%s\n", __func__);
> 
> Would this be better as a BUG? Without a BUG this error could get ignored
> and yet the device may not behave as expected.

yeah.
> 
> 
>> +		return 0;
>> +	}
>> +
>> +	if (size > 2)
>> +		return val;
> 
> I think you make the assumption here that if size > 2 then it's 4. It could
> be 3 (though unlikely) in which case you'd want to fall through to the next
> line.

This assumption is used elsewhere too (e.g drivers/pci/access.c). I
generally don't prefer adding handlers for non-occurring error
scenarios, but If you insist I can fix that.

Thanks
Kishon
