Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AD57CD653
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 10:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjJRIYi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 04:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjJRIYh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 04:24:37 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F650F7;
        Wed, 18 Oct 2023 01:24:31 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39I8OEa1077613;
        Wed, 18 Oct 2023 03:24:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697617454;
        bh=ZtCVecdF83AGjBhuAEFcCM6NSuKe7HJoHlKbAZhIm1E=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=FjJyTLwkvPFOWcb37XVyA2UqptuUr5wLb/beXhPOYam/dgvFu/UlJg4GEJ/xiafnj
         V/ieGYIOOSCmXuqGpGVwUfy9HlWJt7EKmGyNHqt3TxIVoagJqqMiXIzTT00/i9FzC5
         k9EjhaU10ZLZhlhnsNVdHgR5ExY43kUZJjJFCVdE=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39I8OEW1126017
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Oct 2023 03:24:14 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Oct 2023 03:24:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Oct 2023 03:24:14 -0500
Received: from [172.24.227.9] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39I8OAbx036840;
        Wed, 18 Oct 2023 03:24:11 -0500
Message-ID: <564eead0-9439-4bd0-8281-4539d35bc0fc@ti.com>
Date:   Wed, 18 Oct 2023 13:54:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH v2] PCI: keystone: Fix ks_pcie_v3_65_add_bus() for AM654x
 SoC
Content-Language: en-US
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>, <lpieralisi@kernel.org>,
        <robh@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>
References: <20231018075038.2740534-1-s-vadapalli@ti.com>
 <c546f8e9-f6ba-41b8-7dff-4a7921b6705f@ti.com>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <c546f8e9-f6ba-41b8-7dff-4a7921b6705f@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ravi,

On 18/10/23 13:49, Ravi Gunasekaran wrote:
> Siddharth,
> 
> 
> On 10/18/23 1:20 PM, Siddharth Vadapalli wrote:
>> The ks_pcie_v3_65_add_bus() member of "ks_pcie_ops" was added for
>> platforms using DW PCIe IP-core version 3.65a. The AM654x SoC uses
>> DW PCIe IP-core version 4.90a and ks_pcie_v3_65_add_bus() is not
>> applicable to it.
>>
>> The commit which added support for the AM654x SoC has reused majority
>> of the functions with the help of the "is_am6" flag to handle AM654x
>> separately where applicable. Thus, make use of the "is_am6" flag and
>> change ks_pcie_v3_65_add_bus() to no-op for AM654x SoC.
>>
>> Fixes: 18b0415bc802 ("PCI: keystone: Add support for PCIe RC in AM654x Platforms")
> 
> 6ab15b5e7057 (PCI: dwc: keystone: Convert .scan_bus() callback to use add_bus)
> is that one that seems to have introduced this issue. 
> 
> ks_pcie_v3_65_scan_bus() was for IP version 3.65 and this was renamed and
> added to "ks_pcie_ops" which is used by other IP versions as well.

Thank you for reviewing the patch and pointing this out. I will update the
commit message with the correct Fixes tag as well as the appropriate description
and post the v3 patch if there is no further feedback from others on this patch.

> 
> 
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>> Hello,
>>
>> This patch is based on linux-next tagged next-20231018.
>>
>> The v1 of this patch is at:
>> https://lore.kernel.org/r/20231011123451.34827-1-s-vadapalli@ti.com/

...

>>  		return 0;
>>  
>>  	/* Configure and set up BAR0 */
> 

-- 
Regards,
Siddharth.
