Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EA252C627
	for <lists+linux-pci@lfdr.de>; Thu, 19 May 2022 00:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiERWSe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 18:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiERWSe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 18:18:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2423C209B7B;
        Wed, 18 May 2022 15:18:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B592261624;
        Wed, 18 May 2022 22:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0345C385A9;
        Wed, 18 May 2022 22:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652912312;
        bh=1BE7QoEPoRv0SPcn20p4AnFm8hcFxjR8MT1AIyyGM5E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eWelHZ0gWDLOdAb4yIc8otFLq/7/SstVjEPMrNM5OY/ixhWrfGsLoOJrA7cqGaUc+
         OOT5LJFUhIh39Uadm23ojBqe1kIz33mRCBucZOj7kwEw89qf9l8rJfsZyL00MEg8fw
         EBMDxY0/0QDdEvOnzrGp5EAIq4hielcEeJFD33evSn0R05BHwx7yLaEBlyPRMMjzBA
         dgWHntw69PJYQFVW0xsALZ6gdsFX//zK3JfsSKSlfc4UPynE0zoilgGi3pRS2622Kb
         8gPrWUiA3mkQuKBpCVNc/ye/2FLPe1/lq47+1fyLWxioFrTVfZ0mI/OUJd/A3JRGU/
         H9KOU66/TWDsA==
Date:   Wed, 18 May 2022 17:18:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Cyril Brulebois <kibi@debian.org>,
        Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, james.dutton@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] PCI: brcmstb: Fix regression regarding missing PCIe
 linkup
Message-ID: <20220518221830.GA12467@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518194211.20143-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+to Cyril]

Cyril, if you have a chance to test this and verify that it fixes the
regression, we may still be able to squeeze this into v5.18.

I can add the Reported-by and Tested-by tags myself.

On Wed, May 18, 2022 at 03:42:11PM -0400, Jim Quinlan wrote:
> commit 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage regulators")
> 
> introduced a regression on the PCIe RPi4 Compute Module.  If the PCIe
> endpoint node described in [2] was missing, no linkup would be attempted,
> and subsequent accesses would cause a panic because this particular PCIe HW
> causes a CPU abort on illegal accesses (instead of returning 0xffffffff).
> 
> We fix this by allowing the DT endpoint subnode to be missing.  This is
> important for platforms like the CM4 which have a standard PCIe socket and
> the endpoint device is unknown.
> 
> Please do not accept this commit until someone with a CM4 has tested
> this solution; I have only emulated the problem and fix on different
> platform.
> 
> Note that a bisection identified
> 
> commit 830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup() into two funcs")
> 
> as the first failing commit.  This commit is a regression, but is unrelated
> and was fixed by a subsequent commit in the original patchset.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=215925
> [2] Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> 
> Fixes: 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage regulators")
> Fixes: 830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup() into two funcs")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215925
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index ba5c120816b2..adca74e235cb 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -540,16 +540,18 @@ static int pci_subdev_regulators_add_bus(struct pci_bus *bus)
>  
>  static int brcm_pcie_add_bus(struct pci_bus *bus)
>  {
> -	struct device *dev = &bus->dev;
>  	struct brcm_pcie *pcie = (struct brcm_pcie *) bus->sysdata;
>  	int ret;
>  
> -	if (!dev->of_node || !bus->parent || !pci_is_root_bus(bus->parent))
> +	/* Only busno==1 requires us to linkup */
> +	if ((int)bus->number != 1)
>  		return 0;
>  
>  	ret = pci_subdev_regulators_add_bus(bus);
> -	if (ret)
> +	if (ret) {
> +		pcie->refusal_mode = true;
>  		return ret;
> +	}
>  
>  	/* Grab the regulators for suspend/resume */
>  	pcie->sr = bus->dev.driver_data;
> 
> base-commit: ef1302160bfb19f804451d0e919266703501c875
> prerequisite-patch-id: 23a425390a4226bd70bbff459148c80f5e28379c
> prerequisite-patch-id: e3f2875124b46b2b1cf9ea28883bf0c864b79479
> prerequisite-patch-id: 9cdd706ee2038c7b393c4d65ff76a1873df1ca03
> prerequisite-patch-id: 332ac90be6e4e4110e27bdd1caaff212c129f547
> prerequisite-patch-id: 32a74f87cbfe9e8d52c34a4edeee6d271925665a
> prerequisite-patch-id: f57cdf7ec7080bb8c95782bc7c3ec672db8ec1ce
> prerequisite-patch-id: 18dc9236aed47f708f5c854afd832f3c80be5ea7
> prerequisite-patch-id: dd147c6854c4ca12a9a8bd4f5714968a59d60e4e
> -- 
> 2.17.1
> 
