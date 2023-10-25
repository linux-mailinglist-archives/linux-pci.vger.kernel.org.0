Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44A67D69A0
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 12:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjJYK6w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 06:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJYK6w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 06:58:52 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E329DA6;
        Wed, 25 Oct 2023 03:58:49 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39PAwT3K062646;
        Wed, 25 Oct 2023 05:58:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698231509;
        bh=1TPsUdXjm7Vpn4Ig1Vrcn9B/Y380Qufn7tJcHsIyp4I=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=oGFhvcwjQQwe5uHZEZTOjXNgg5cc0c2fTSQlOXVcJuxTg3ExgRiGITAgNI6fm7kmj
         77J2aOqBD2a9CZX7AqYqRf+LE7EmMk8HmppDUhYughb9618nJKPP9UnEm29yAxXpmj
         QPi4ugf5pO93LEYNujIOeYziWeMpkywV0cRSEksk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39PAwTUw062342
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Oct 2023 05:58:29 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 25
 Oct 2023 05:58:29 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 25 Oct 2023 05:58:29 -0500
Received: from [172.24.227.9] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39PAwOBV018686;
        Wed, 25 Oct 2023 05:58:25 -0500
Message-ID: <6e40c4ee-e549-4b41-8a12-65b474b8ef24@ti.com>
Date:   Wed, 25 Oct 2023 16:28:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <bhelgaas@google.com>, <lpieralisi@kernel.org>, <robh@kernel.org>,
        <kw@linux.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v3] PCI: keystone: Fix pci_ops for AM654x SoC
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
References: <20231023212628.GA1627567@bhelgaas>
 <c7851172-f474-42f3-9730-1f323f9e6c73@ti.com>
 <3szgydgz7ege5h75mwdket5lniwy4oe52dq2uqehf74il5hc5j@oaqcbmfuf6de>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <3szgydgz7ege5h75mwdket5lniwy4oe52dq2uqehf74il5hc5j@oaqcbmfuf6de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Serge,

On 25/10/23 15:58, Serge Semin wrote:
> Hi Siddharth, Bjorn
> 
> On Wed, Oct 25, 2023 at 10:32:50AM +0530, Siddharth Vadapalli wrote:

...

>>
> 
>> ks_pcie_probe()
>>     dw_pcie_host_init()
>>         pci_host_probe()
>>     ks_pcie_v3_65_add_bus()
> 
> I guess what Bjorn implied was to add the ks_pcie_v3_65_add_bus()
> invocation to the host_init() callback, i.e. in ks_pcie_host_init().

I misunderstood the term "host_init()", and interpret it as
"dw_pcie_host_init()", due to which I thought I will add it after
dw_pcie_host_init() invocation in ks_pcie_probe. Thank you for clarifying.

> Moreover initializing the BARs/MSI after all the PCIe hierarchy has
> been probed will eventually cause problems since MSI's won't work
> until the ks_pcie_v3_65_add_bus() is called.
> 
>>
>> Since the .add_bus() method will be removed following this change, I suppose
>> that the patch I post for it can be applied instead of this v3 patch which fixes
>> pci_ops.
>>
> 
>> The patch I plan to post as a replacement for the current patch which shall also
>> remove the ks_pcie_v3_65_add_bus() and the .add_bus() method is:
> 
> Just a note. Seeing the Bjorn's suggestion may cause a regression on
> the Keystone PCIe Host v3.65 I would suggest to merge in the original
> fix as is and post an additional cleanup patch, like below with proper
> modifications, on top of it. Thus we'll minimize a risk to break
> things at least on the stable kernels.

I will post it as a separate cleanup patch in that case and this v3 patch can be
merged independently as you suggested.

-- 
Regards,
Siddharth.
