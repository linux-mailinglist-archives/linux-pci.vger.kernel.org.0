Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CD87CE2E2
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 18:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjJRQgh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 12:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJRQgg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 12:36:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3953A113;
        Wed, 18 Oct 2023 09:36:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14D7C433C7;
        Wed, 18 Oct 2023 16:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697646993;
        bh=uN4FTt1WJfID/Mn+71JQqnF+ueyE2WBjOZDWcTg9Tt8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dTDtv7a+6jAyDRbZJ7t4ZZEJmkadDCEdEF3hYZtwVRGW+h3m48nUYLh0r5cCTkiLu
         ep0o48YxHgLr85xuKCozOBVkzxOffLao5QQon8j10wlUGT53uzZY4NeZSbwfviiVig
         TboNmRsdZRX2Vd16I77OC9tW/7Z9t2/yIRFlZR7JV2x7pSsM7PyfssILKI/5ONYYeI
         YgO71HUb03rz2fS/3Bt0wAo+rG/uGIV/4WfvhHipzFjOd7fydVFRLUNzEDTcIcPt1v
         OoiHhAOX5ulw82X9vKHeIJHeJz+J1AEXZQPKU4G5GUkB1LEV6hTMExT1qiZj/O6Eom
         4lwYlCHYPWdqA==
Date:   Wed, 18 Oct 2023 11:36:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        r-gunasekaran@ti.com, srk@ti.com,
        Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v2] PCI: keystone: Fix ks_pcie_v3_65_add_bus() for AM654x
 SoC
Message-ID: <20231018163632.GA1364574@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018075038.2740534-1-s-vadapalli@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Serge (please cc people who have commented on previous revisions)]

On Wed, Oct 18, 2023 at 01:20:38PM +0530, Siddharth Vadapalli wrote:
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

Thanks for verifying that this doesn't actually depend on whether the
link is up.

I think that means we should be able to get rid of the
ks_pcie_v3_65_add_bus() callback altogether and instead do this along
with the rest of the Root Port init.

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
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
