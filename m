Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED6F7CD98F
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 12:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjJRKuE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 06:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjJRKuE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 06:50:04 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FBABA;
        Wed, 18 Oct 2023 03:50:01 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39IAnjXp024461;
        Wed, 18 Oct 2023 05:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697626185;
        bh=PRR/CchuITDUkyqhMi378r92ynUX/7z2IpkPzLER2ps=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=P8pe9Skphkd88WLDMFQCrLQ4HFuI0hT5g1oOUuqA/yvHmHAisINnAmZAWaAqPHkdA
         bl/w6G634IafqRh1ovqgNIdQWmqaUIQBdxqddmRjjRSbDfvHGRgwy53EQaTIkmuD/Y
         iHOWAa3W3OPMz6886f0sJz4kWMtfXvYEKFOeRq+k=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39IAnjgH058097
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Oct 2023 05:49:45 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Oct 2023 05:49:45 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Oct 2023 05:49:45 -0500
Received: from [172.24.227.9] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39IAnfOZ042587;
        Wed, 18 Oct 2023 05:49:41 -0500
Message-ID: <025ec85f-78be-4b0f-9c5b-f59087610c67@ti.com>
Date:   Wed, 18 Oct 2023 16:19:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     Bjorn Helgaas <helgaas@kernel.org>, <lpieralisi@kernel.org>,
        <robh@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH] PCI: keystone: Don't enable BAR0 if link is not detected
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
References: <20231013184958.GA1118393@bhelgaas>
 <c11f4b9f-8cbe-1fd0-886b-f36547dc8d3c@ti.com>
 <klxzte53bzk774zinhfrdwdwalvv2hlvc2mqiuyecxcneqkdbt@qbkyc4fdlcka>
 <eacc8aa9-7480-f46c-8852-88f1f8f46bff@ti.com>
 <tlx5ysa4jnqzmhq5dpk5yk6uuddpwl5h2ieg6n2h3ozksqyx44@yx5mhvwg5miv>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <tlx5ysa4jnqzmhq5dpk5yk6uuddpwl5h2ieg6n2h3ozksqyx44@yx5mhvwg5miv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 18/10/23 16:12, Serge Semin wrote:
> On Tue, Oct 17, 2023 at 09:44:51AM +0530, Siddharth Vadapalli wrote:
>> Hello,
>>
>> On 17/10/23 02:59, Serge Semin wrote:
>>> Hi Siddharth
>>>
>>
>> ...
>>

...

> 
> Are you really sure that it's 4.90a? Here is what my DW PCIe RC
> _v4.90_ HW databook says about the BARs:
> 
> "Base Address Registers (Offset: 0x10-x14) The Synopsys core does not
> implement the optional BARs for the RC product. This is based on the
> assumption that the RC host probably has registers on some other
> internal bus and has knowledge and setup access to these registers
> already."
> 
> What you cited resides in the _v5.x_ databooks. It makes my thinking
> that in your case the IP-core isn't of 4.90a version.

I reviewed the function ks_pcie_v3_65_add_bus() and it appears clear to me now
that it is applicable only to 3.65a versions. The IP-core however is 4.90a. I
have posted the v2 patch at:
https://lore.kernel.org/r/20231018075038.2740534-1-s-vadapalli@ti.com/

Also, as pointed out by Ravi on the v2 patch's thread at:
https://lore.kernel.org/r/c546f8e9-f6ba-41b8-7dff-4a7921b6705f@ti.com/
the culprit turned out to be:
6ab15b5e7057 (PCI: dwc: keystone: Convert .scan_bus() callback to use add_bus)
which in the process of converting the .scan_bus() callback to .add_bus(), namely:
ks_pcie_v3_65_scan_bus() -> ks_pcie_v3_65_add_bus()
It added the .add_bus() method within "struct pci_ops ks_pcie_ops" which is
actually shared with the 4.90a controller as well. So an "is_am6" check should
have also been added to make it no-op for NON-3.65a controllers.

I will be posting the v3 patch implementing the above fix if there is no further
feedback on the v2 patch from others.

-- 
Regards,
Siddharth.
