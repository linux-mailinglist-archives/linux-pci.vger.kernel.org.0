Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115AA7CEEAF
	for <lists+linux-pci@lfdr.de>; Thu, 19 Oct 2023 06:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjJSEiS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Oct 2023 00:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSEiR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Oct 2023 00:38:17 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA86B11F;
        Wed, 18 Oct 2023 21:38:14 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39J4bsb7034905;
        Wed, 18 Oct 2023 23:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697690274;
        bh=2ee5WpctjPUgoDFDBIHdnJ/ADkHfyWTnAoSZDMH6IJk=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=gJJtgYvz4blRqhUT7S6ylzuJTNZs8gOG31vhzBY1BE0MAdcPubIc61sVSZM/j7Op4
         fJnPJ3xLgdngp9p1o01xKV8LuLOz/WDCWNgBFfv+P037LNDvOt/TOUuuyx9+kJ7BCv
         bNUFhLdF0H4aA4JbziE8kNSQMh4O7EeDTxsa59hY=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39J4bsXP066872
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Oct 2023 23:37:54 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Oct 2023 23:37:53 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Oct 2023 23:37:53 -0500
Received: from [172.24.227.9] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39J4bn51111409;
        Wed, 18 Oct 2023 23:37:50 -0500
Message-ID: <ba217723-1501-4e72-b143-e0047266ea9a@ti.com>
Date:   Thu, 19 Oct 2023 10:07:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <bhelgaas@google.com>, <lpieralisi@kernel.org>, <robh@kernel.org>,
        <kw@linux.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v2] PCI: keystone: Fix ks_pcie_v3_65_add_bus() for AM654x
 SoC
To:     Serge Semin <fancer.lancer@gmail.com>
References: <20231018075038.2740534-1-s-vadapalli@ti.com>
 <zje5t7zbaisyzwgvkdxnqwlcadsyegipxbhsxxpbqlnuu45ria@4sqxpgieoig2>
 <6b74d547-bdaf-41e3-8046-ce295a0ecf03@ti.com>
 <bdsnykgehrgc75cw6rlaog25tuyivj57nwpjh5727fb4yjdrj5@ad3zoftu37bt>
Content-Language: en-US
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <bdsnykgehrgc75cw6rlaog25tuyivj57nwpjh5727fb4yjdrj5@ad3zoftu37bt>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 18/10/23 17:45, Serge Semin wrote:
> On Wed, Oct 18, 2023 at 05:26:53PM +0530, Siddharth Vadapalli wrote:
>>
>>

...

>>
>> Even before commit 6ab15b5e7057, with support for AM654x (using version 4.90a
>> DWC PCIe IP-core) already present, ks_pcie_ops was being used for AM654x. This
>> indicates that prior to commit 6ab15b5e7057, the ks_pcie_ops was applicable to
>> AM654x and there's no problem. However, when commit 6ab15b5e7057 converted the
>> .scan_bus() method in ks_pcie_host_ops (which wasn't used for AM654x) to
>> .add_bus(), it added the method within the shared ks_pcie_ops structure which
>> implicitly, *mistakenly*, assumes that a function named "ks_pcie_v3_65_add_bus"
>> is also applicable to other controller versions (4.90a in this case). Paying
>> attention to the name of the function, it becomes clear that it was added for
>> controller version "3.65", hence the name "...v3_65...". The assumption that the
>> function/method is applicable to other controller versions as well, was
>> incorrect which led to the current issue that can be observed. The commit
>> 6ab15b5e7057 ended up adding a new method for a controller version which *never*
>> used the method. This therefore is a bug.
>>
> 
>> The simplest fix I see is that of exiting ks_pcie_v3_65_add_bus() if:
>> ks_pcie->is_am6 is set, since such checks have been scattered throughout the
>> same driver prior to the addition of commit 6ab15b5e7057 as well.
>>
>> I am open to other implementations of fixing this issue as well. Kindly let me
>> know in case of any suggestions.
> 
> A simplest fix isn't always the best one. As you said yourself the
> ks_pcie_v3_65_add_bus() implies having it called for v3.65. Calling it
> for the newer controllers was a mistake causing the bug. Thus having
> the ks_pcie_ops utilized for both old and new controllers was also a

At the point in time when support for the new controller was added, ks_pcie_ops
was defined as:
static struct pci_ops ks_pcie_ops = {
	.map_bus = dw_pcie_own_conf_map_bus,
	.read = pci_generic_config_read,
	.write = pci_generic_config_write,
};
which did not have anything version specific.

It is only after commit 6ab15b5e7057 that a version specific .add_bus method was
added to ks_pcie_ops, making ks_pcie_ops version-specific since then.

> mistake. Therefor my suggestion to fix the problem by defining the two
> pci_ops structure instances would be more correct at least from the
> code readability point of view. It would make the
> ks_pcie_v3_65_add_bus() function body and name coherent.

Sure. Thank you for the suggestion. I will leave ks_pcie_ops as-is for the older
3.65 controller while adding the ks_pcie_am6_ops without the .add_bus method for
the newer 4.90 controller. I assume this should be acceptable since the
pci-keystone.c driver only has two controller versions, namely 3.65a and 4.90a,
with the new 4.90a controller only applicable to AM654x SoC which is already
being distinguished in the driver using the is_am6 flag.

In the v3 patch, I will add the following:

static struct pci_ops ks_pcie_am6_ops = {
	.map_bus = dw_pcie_own_conf_map_bus,
	.read = pci_generic_config_read,
	.write = pci_generic_config_write,
};

and also update ks_pcie_host_init() to the following:
if(ks_pcie->is_am6)
	pp->bridge->ops = &ks_pcie_am6_ops;
else
	pp->bridge->ops = &ks_pcie_ops;

> 
> Meanwhile your fix look more like a workaround. The
> ks_pcie_v3_65_add_bus() function will be still called for the AM6x
> v4.90 controllers, which based on its semantic would be and will be
> wrong in any case. So instead of noop-ing the function it would be
> better to just drop it being called for the new controllers.

Yes, I will drop it for the new 4.90a controller rather than making it a no-op.

> 
> -Serge(y)
> 
>>
>>>
>>> -Serge(y)
>>>
>>>>  		return 0;
>>>>  
>>>>  	/* Configure and set up BAR0 */
>>>> -- 
>>>> 2.34.1
>>>>
>>
>> -- 
>> Regards,
>> Siddharth.

-- 
Regards,
Siddharth.
