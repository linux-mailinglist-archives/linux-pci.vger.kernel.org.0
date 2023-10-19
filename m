Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8D17CF246
	for <lists+linux-pci@lfdr.de>; Thu, 19 Oct 2023 10:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjJSISW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Oct 2023 04:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjJSISV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Oct 2023 04:18:21 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B85912D;
        Thu, 19 Oct 2023 01:18:20 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39J8Hh66099414;
        Thu, 19 Oct 2023 03:17:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697703463;
        bh=Wa8s9G9TX8ZZJjeLXajpX2z+m7oQdM2kGBrLbOxOhTw=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=Tkz+6AUQhgQbQ/hnXyO4Wkp3GG9ldhyXBYB4/mA6tr8qomMwbGNLUUWMiXzySNYwi
         IYpBqDdkGOAZF7i5l9for5+ZZ9gJPo3VosbMFOH+KOIqGnJnkW/Nj/JtUfeuCJZjh1
         FFoTAujZsa0UAehJ3NLOdyrobqp773m0KRobTY30=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39J8Hhdm067675
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Oct 2023 03:17:43 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Oct 2023 03:17:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Oct 2023 03:17:43 -0500
Received: from [172.24.227.9] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39J8Hc0u107836;
        Thu, 19 Oct 2023 03:17:39 -0500
Message-ID: <08cb761b-e6ca-446a-9594-bc5a9733b470@ti.com>
Date:   Thu, 19 Oct 2023 13:47:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <bhelgaas@google.com>, <lpieralisi@kernel.org>, <robh@kernel.org>,
        <kw@linux.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v2] PCI: keystone: Fix ks_pcie_v3_65_add_bus() for AM654x
 SoC
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
References: <20231018075038.2740534-1-s-vadapalli@ti.com>
 <zje5t7zbaisyzwgvkdxnqwlcadsyegipxbhsxxpbqlnuu45ria@4sqxpgieoig2>
 <6b74d547-bdaf-41e3-8046-ce295a0ecf03@ti.com>
 <bdsnykgehrgc75cw6rlaog25tuyivj57nwpjh5727fb4yjdrj5@ad3zoftu37bt>
 <ba217723-1501-4e72-b143-e0047266ea9a@ti.com>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <ba217723-1501-4e72-b143-e0047266ea9a@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Serge,

On 19/10/23 10:07, Siddharth Vadapalli wrote:
> 
> 
> On 18/10/23 17:45, Serge Semin wrote:
>> On Wed, Oct 18, 2023 at 05:26:53PM +0530, Siddharth Vadapalli wrote:

...

> 
> Sure. Thank you for the suggestion. I will leave ks_pcie_ops as-is for the older
> 3.65 controller while adding the ks_pcie_am6_ops without the .add_bus method for
> the newer 4.90 controller. I assume this should be acceptable since the
> pci-keystone.c driver only has two controller versions, namely 3.65a and 4.90a,
> with the new 4.90a controller only applicable to AM654x SoC which is already
> being distinguished in the driver using the is_am6 flag.
> 
> In the v3 patch, I will add the following:
> 
> static struct pci_ops ks_pcie_am6_ops = {
> 	.map_bus = dw_pcie_own_conf_map_bus,
> 	.read = pci_generic_config_read,
> 	.write = pci_generic_config_write,
> };
> 
> and also update ks_pcie_host_init() to the following:
> if(ks_pcie->is_am6)
> 	pp->bridge->ops = &ks_pcie_am6_ops;
> else
> 	pp->bridge->ops = &ks_pcie_ops;
> 
>>
>> Meanwhile your fix look more like a workaround. The
>> ks_pcie_v3_65_add_bus() function will be still called for the AM6x
>> v4.90 controllers, which based on its semantic would be and will be
>> wrong in any case. So instead of noop-ing the function it would be
>> better to just drop it being called for the new controllers.
> 
> Yes, I will drop it for the new 4.90a controller rather than making it a no-op.

I have posted the v3 patch at:
https://lore.kernel.org/r/20231019081330.2975470-1-s-vadapalli@ti.com/
implementing your suggestion of adding a new pci_ops structure.

Please review it and let me know in case of any feedback.

-- 
Regards,
Siddharth.
