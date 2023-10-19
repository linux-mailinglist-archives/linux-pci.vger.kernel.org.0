Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CD07CEEB9
	for <lists+linux-pci@lfdr.de>; Thu, 19 Oct 2023 06:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjJSEon (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Oct 2023 00:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSEom (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Oct 2023 00:44:42 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CDA121;
        Wed, 18 Oct 2023 21:44:40 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39J4iTpu075127;
        Wed, 18 Oct 2023 23:44:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697690669;
        bh=Nsm65Fiol2e3YajEvGcp8ncLHLBMOOiaEhHW/ifzT4A=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=OZF5XvK6HnY3lGOXwzP6YLbwtuTKUmu54W7gfaRbMFnGjPacrcHv/IkbnvZQQ5ZWA
         YIIq5i0GWXSRmktAQ4xnW+wY2sIEnU6Sg6ROjlZ+kBcQn2J9f2s+IW7dxFwoXSNOPh
         pbrkh0fBIK0VM0VzydQQtzpe6GOJLPK8oMj2BQXA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39J4iTvW083272
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Oct 2023 23:44:29 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Oct 2023 23:44:29 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Oct 2023 23:44:29 -0500
Received: from [172.24.227.9] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39J4iPhO008594;
        Wed, 18 Oct 2023 23:44:25 -0500
Message-ID: <6842cdf9-d73b-4895-891f-993eaf5bee6e@ti.com>
Date:   Thu, 19 Oct 2023 10:14:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <srk@ti.com>, Serge Semin <fancer.lancer@gmail.com>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH v2] PCI: keystone: Fix ks_pcie_v3_65_add_bus() for AM654x
 SoC
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20231018163632.GA1364574@bhelgaas>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20231018163632.GA1364574@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,

On 18/10/23 22:06, Bjorn Helgaas wrote:
> [+cc Serge (please cc people who have commented on previous revisions)]

Sure, I will do so.

> 
> On Wed, Oct 18, 2023 at 01:20:38PM +0530, Siddharth Vadapalli wrote:

...

>>
>> Changes since v1:
>> - Updated patch subject and commit message.
>> - Determined that issue is not with the absence of Link as mentioned in
>>   v1 patch. Even with Link up and endpoint device connected, if
>>   ks_pcie_v3_65_add_bus() is invoked and executed, all reads to the
>>   MSI-X offsets return 0xffffffff when pcieport driver attempts to setup
>>   AER and PME services. The all Fs return value indicates that the MSI-X
>>   configuration is failing even if Endpoint device is connected. This is
>>   because the ks_pcie_v3_65_add_bus() function is not applicable to the
>>   AM654x SoC which uses DW PCIe IP-core version 4.90a.
> 
> Thanks for verifying that this doesn't actually depend on whether the
> link is up.
> 
> I think that means we should be able to get rid of the
> ks_pcie_v3_65_add_bus() callback altogether and instead do this along
> with the rest of the Root Port init.

Yes, I will follow Serge's suggestion of adding a new pci_ops structure for the
AM654x SoC which uses the new 4.90a controller. I have described it at:
https://lore.kernel.org/r/ba217723-1501-4e72-b143-e0047266ea9a@ti.com/
and am summarizing it below:

I will add the following:
static struct pci_ops ks_pcie_am6_ops = {
	.map_bus = dw_pcie_own_conf_map_bus,
	.read = pci_generic_config_read,
	.write = pci_generic_config_write,
};
which shall be used for AM654x SoC

I will also modify the contents of ks_pcie_host_init() as follows:
if(ks_pcie->is_am6)
	pp->bridge->ops = &ks_pcie_am6_ops;
else
	pp->bridge->ops = &ks_pcie_ops;

which will ensure that the .add_bus() method is no longer applicable to the
AM654x SoC, which was the case prior to commit 6ab15b5e7057.

I shall post the v3 patch with the above changes and also Cc Serge.

-- 
Regards,
Siddharth.
