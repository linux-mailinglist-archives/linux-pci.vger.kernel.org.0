Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB937CF26C
	for <lists+linux-pci@lfdr.de>; Thu, 19 Oct 2023 10:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbjJSIXR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Oct 2023 04:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbjJSIW7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Oct 2023 04:22:59 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7AA196;
        Thu, 19 Oct 2023 01:22:53 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39J8MWlQ103364;
        Thu, 19 Oct 2023 03:22:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697703752;
        bh=MCTqsq0Y67FnukRcKpRTfcfnyz+Nx3GotxxH4JuMZ5o=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=WqMe0h+uqKXSh2kkLy+uFlJfj4GG7iRUGbMi3P8fHmRj7oOtoO1W+a+K0ltZbPvMJ
         Ls4mgkKNdwXBxUslFY/7P92Q3FOQ5FWq571nW0Wrtifg61cIelPpQvQJKqDExI/8te
         XAyov9dVCfIoHIpMgk0Y+w2xscU4POiyIgVPCFv0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39J8MWsx087196
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Oct 2023 03:22:32 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Oct 2023 03:22:32 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Oct 2023 03:22:32 -0500
Received: from [172.24.227.9] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39J8MS05025990;
        Thu, 19 Oct 2023 03:22:28 -0500
Message-ID: <bd9f3512-3db2-47a7-ba88-b8b935ae6af7@ti.com>
Date:   Thu, 19 Oct 2023 13:52:27 +0530
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
 <6842cdf9-d73b-4895-891f-993eaf5bee6e@ti.com>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <6842cdf9-d73b-4895-891f-993eaf5bee6e@ti.com>
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



On 19/10/23 10:14, Siddharth Vadapalli wrote:
> Hello Bjorn,
> 
> On 18/10/23 22:06, Bjorn Helgaas wrote:
>> [+cc Serge (please cc people who have commented on previous revisions)]
> 
> Sure, I will do so.
> 

...

> 
> Yes, I will follow Serge's suggestion of adding a new pci_ops structure for the
> AM654x SoC which uses the new 4.90a controller. I have described it at:
> https://lore.kernel.org/r/ba217723-1501-4e72-b143-e0047266ea9a@ti.com/
> and am summarizing it below:
> 
> I will add the following:
> static struct pci_ops ks_pcie_am6_ops = {
> 	.map_bus = dw_pcie_own_conf_map_bus,
> 	.read = pci_generic_config_read,
> 	.write = pci_generic_config_write,
> };
> which shall be used for AM654x SoC
> 
> I will also modify the contents of ks_pcie_host_init() as follows:
> if(ks_pcie->is_am6)
> 	pp->bridge->ops = &ks_pcie_am6_ops;
> else
> 	pp->bridge->ops = &ks_pcie_ops;
> 
> which will ensure that the .add_bus() method is no longer applicable to the
> AM654x SoC, which was the case prior to commit 6ab15b5e7057.
> 
> I shall post the v3 patch with the above changes and also Cc Serge.

I have posted the v3 patch at:
https://lore.kernel.org/r/20231019081330.2975470-1-s-vadapalli@ti.com/
and have copied Serge in the mail.

> 

-- 
Regards,
Siddharth.
