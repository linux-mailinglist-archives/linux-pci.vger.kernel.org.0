Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA82318A074
	for <lists+linux-pci@lfdr.de>; Wed, 18 Mar 2020 17:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgCRQ1V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Mar 2020 12:27:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58522 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRQ1V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Mar 2020 12:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=NY1miO+lrBEnnEy4f4Wvx3tix9jouZXLdbd/w2LB1Qs=; b=sTWfpvsQ1gpKVGIv2HPSbdWlgh
        wozRAzDSV9B6yRa6asXTEM5ilD5y21A94mjWcITGYwjipPy2rtFG+YFTIgJfIlP1y8s2qr3uTXD2V
        iVd8U2CdiaU/d6PcAc0o2xBawKx1eI0znNA9R2UO5b0Vo2i8JYl3IuMP6WkDOtskjywcUQxAteP+3
        5UA3yMElaAuxW4qIBTwVXln0/Ne73bb3dIt1QY++uZ874NJCI+e9lWWFEbGcqLawJ7aHsyZV8u4RF
        iLD6Utrdoexhb4jifZwP1K37lVrtOgnoj0Nf7dUeqQNEXeEQVHTtldmda3kA32xuSXynTie8nnxoe
        TvwvTuFw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEbXL-0001Si-PO; Wed, 18 Mar 2020 16:27:19 +0000
Subject: Re: [PATCH] PCI: mobiveil: Fix unmet dependency warning for
 PCIE_MOBIVEIL_PLAT
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        amurray@thegoodpenguin.co.uk, bhelgaas@google.com
References: <20200318093312.49004-1-Zhiqiang.Hou@nxp.com>
 <20200318103504.GA13361@e121166-lin.cambridge.arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <be11bc21-4079-f53a-21dc-6121290b9899@infradead.org>
Date:   Wed, 18 Mar 2020 09:27:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318103504.GA13361@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/18/20 3:35 AM, Lorenzo Pieralisi wrote:
> On Wed, Mar 18, 2020 at 05:33:12PM +0800, Zhiqiang Hou wrote:
>> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>>
>> Fix the follow warning by adding the dependency PCI_MSI_IRQ_DOMAIN
>> into PCIE_MOBIVEIL_PLAT.
>>
>> WARNING: unmet direct dependencies detected for PCIE_MOBIVEIL_HOST
>>   Depends on [n]: PCI [=y] && PCI_MSI_IRQ_DOMAIN [=n]
>>   Selected by [y]:
>>   - PCIE_MOBIVEIL_PLAT [=y] && PCI [=y] && (ARCH_ZYNQMP || COMPILE_TEST [=y]) && OF [=y]
>>
>> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>> ---
>>  drivers/pci/controller/mobiveil/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
> 
> I have applied it to pci/mobiveil for v5.7.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> Thanks,
> Lorenzo
> 
>> diff --git a/drivers/pci/controller/mobiveil/Kconfig b/drivers/pci/controller/mobiveil/Kconfig
>> index 7439991ee82c..a62d247018cf 100644
>> --- a/drivers/pci/controller/mobiveil/Kconfig
>> +++ b/drivers/pci/controller/mobiveil/Kconfig
>> @@ -15,6 +15,7 @@ config PCIE_MOBIVEIL_PLAT
>>  	bool "Mobiveil AXI PCIe controller"
>>  	depends on ARCH_ZYNQMP || COMPILE_TEST
>>  	depends on OF
>> +	depends on PCI_MSI_IRQ_DOMAIN
>>  	select PCIE_MOBIVEIL_HOST
>>  	help
>>  	  Say Y here if you want to enable support for the Mobiveil AXI PCIe
>> -- 
>> 2.17.1
>>


-- 
~Randy
