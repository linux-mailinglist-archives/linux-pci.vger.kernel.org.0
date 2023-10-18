Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8429F7CD638
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 10:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjJRITw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 04:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjJRITw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 04:19:52 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB939B6;
        Wed, 18 Oct 2023 01:19:49 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39I8JVg1114036;
        Wed, 18 Oct 2023 03:19:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697617171;
        bh=KDxSzjo2VitRXjpaiHK9O5EJrXqIWmeH3Eersa64FuA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=xmKycoSSPuHLTwIkIHEaMn06eq06DZpf7LsjJAmgyy29Yo/UDB3D+nU4boa8VqfPe
         +d1t5N32j1W4w3q54BudR+5vBUZpQvMxC57eK3nMXYjCXy1Nfs5L59jK5hlH8gbZM1
         UmBa1mwR27jpkiaiwT8jFvniBJSNs3mP0El+TAGA=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39I8JUfF122418
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Oct 2023 03:19:31 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Oct 2023 03:19:30 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Oct 2023 03:19:30 -0500
Received: from [172.24.227.83] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39I8JRSI029793;
        Wed, 18 Oct 2023 03:19:28 -0500
Message-ID: <c546f8e9-f6ba-41b8-7dff-4a7921b6705f@ti.com>
Date:   Wed, 18 Oct 2023 13:49:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] PCI: keystone: Fix ks_pcie_v3_65_add_bus() for AM654x
 SoC
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <robh@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
References: <20231018075038.2740534-1-s-vadapalli@ti.com>
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20231018075038.2740534-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Siddharth,


On 10/18/23 1:20 PM, Siddharth Vadapalli wrote:
> The ks_pcie_v3_65_add_bus() member of "ks_pcie_ops" was added for
> platforms using DW PCIe IP-core version 3.65a. The AM654x SoC uses
> DW PCIe IP-core version 4.90a and ks_pcie_v3_65_add_bus() is not
> applicable to it.
> 
> The commit which added support for the AM654x SoC has reused majority
> of the functions with the help of the "is_am6" flag to handle AM654x
> separately where applicable. Thus, make use of the "is_am6" flag and
> change ks_pcie_v3_65_add_bus() to no-op for AM654x SoC.
> 
> Fixes: 18b0415bc802 ("PCI: keystone: Add support for PCIe RC in AM654x Platforms")

6ab15b5e7057 (PCI: dwc: keystone: Convert .scan_bus() callback to use add_bus)
is that one that seems to have introduced this issue. 

ks_pcie_v3_65_scan_bus() was for IP version 3.65 and this was renamed and
added to "ks_pcie_ops" which is used by other IP versions as well.


> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> Hello,
> 
> This patch is based on linux-next tagged next-20231018.
> 
> The v1 of this patch is at:
> https://lore.kernel.org/r/20231011123451.34827-1-s-vadapalli@ti.com/
> 
> While there are a lot of changes since v1 and this patch could have been
> posted as a v1 patch itself, I decided to post it as the v2 of the patch
> mentioned above since it aims to address the issue described by the v1
> patch and is similar in that sense. However, the solution to the issue
> described in the v1 patch appears to be completely different from what
> was implemented in the v1 patch. Thus, the commit message and subject of
> this patch have been modified accordingly.
> 
> Changes since v1:
> - Updated patch subject and commit message.
> - Determined that issue is not with the absence of Link as mentioned in
>   v1 patch. Even with Link up and endpoint device connected, if
>   ks_pcie_v3_65_add_bus() is invoked and executed, all reads to the
>   MSI-X offsets return 0xffffffff when pcieport driver attempts to setup
>   AER and PME services. The all Fs return value indicates that the MSI-X
>   configuration is failing even if Endpoint device is connected. This is
>   because the ks_pcie_v3_65_add_bus() function is not applicable to the
>   AM654x SoC which uses DW PCIe IP-core version 4.90a.
> 
> Regards,
> Siddharth.
> 
>  drivers/pci/controller/dwc/pci-keystone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 0def919f89fa..3abd59335574 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -459,7 +459,7 @@ static int ks_pcie_v3_65_add_bus(struct pci_bus *bus)
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
>  
> -	if (!pci_is_root_bus(bus))
> +	if (!pci_is_root_bus(bus) || ks_pcie->is_am6)
>  		return 0;
>  
>  	/* Configure and set up BAR0 */

-- 
Regards,
Ravi
