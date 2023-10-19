Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC78C7CF49D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Oct 2023 12:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345167AbjJSKFd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Oct 2023 06:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345137AbjJSKFc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Oct 2023 06:05:32 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B480119;
        Thu, 19 Oct 2023 03:05:29 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-504a7f9204eso10398529e87.3;
        Thu, 19 Oct 2023 03:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697709928; x=1698314728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8+Nz2U9dZw4QlBllG5ui7VeAVBM9gkc5Pjs4wNHcHt4=;
        b=bFIQH5otNrUGCjDv6hLKB9fX5maAwSpwqIjAxHJD2wyf7s5uKyH3jDdEY786ndQMZV
         OvO4DKb6Bg7yey0UH03jBEgiMr0/nlQvJ6gEvguVM2lpsCeJveGS00WbRTcAIXlqqz0J
         AuLicBmpsysqZUYkJufpRip2EYTNRZs5z0j+hMbIpNQCFW0E+Q4ueEJANLSFuzL+FB0p
         e2bczhhqD5EsOxjSEFTelFi06rcfXxdEaMbJIRyzSio9W5nxHqksJ3rVNnLazMbAqUFr
         5AoabSdvU/ygcq5LxALlCAHkLzszeTH+s5vsnnMFcWw+yzqXjuvCCLZfE+DgUw0lOnTf
         k/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697709928; x=1698314728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+Nz2U9dZw4QlBllG5ui7VeAVBM9gkc5Pjs4wNHcHt4=;
        b=k3V59Fxp6+HzQKRBi+D0Z5KdzrqhGqwsziBO9xnHTAk9ENQ2AyhRWlXPUoMz3j+syc
         1k6SgmZyhZfebrNFTf/9g6ob8QoOfvPMnYwMdgxQEVWicFbaTu/LJlkRFZlQP3/44q9g
         G1NoONrQK05mKZBnwUnNJJNzsX3ShJU+Trhg+mvEb1Zumiey8ZR4n2LQHiSisxU+d4ad
         Q8HR2Y/GXlAGYio0Rtx4SFStSrM2Hh9e41M3Jbt3prmFFUTiW2B1QCXJujYhiHeapGsb
         c4BAPX4e8S9schyaWTAoD+0doQVhCQmj4332kQpsENlTYLSY1L5ZcEf2TutLXqcXqW3H
         mr3A==
X-Gm-Message-State: AOJu0YxIwK13nuFSkwLcuWcRjmNZBtrl2hQ/SsA+B+LulDk1u9fgLsK1
        +s15q33HwvrUCTAVoV/ZolA=
X-Google-Smtp-Source: AGHT+IE8BafWL8F2ISffR0hrxkJZhB6TRg8FvgZE86gudvsRpzZFjOBdBjLryMwMCqev7LNBes6dgg==
X-Received: by 2002:a05:6512:3d0c:b0:506:87a3:c27c with SMTP id d12-20020a0565123d0c00b0050687a3c27cmr1290792lfv.53.1697709927362;
        Thu, 19 Oct 2023 03:05:27 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id b4-20020a196704000000b005059c4517casm1048552lfc.99.2023.10.19.03.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:05:26 -0700 (PDT)
Date:   Thu, 19 Oct 2023 13:05:24 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, bhelgaas@google.com
Cc:     lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, r-gunasekaran@ti.com,
        srk@ti.com
Subject: Re: [PATCH v3] PCI: keystone: Fix pci_ops for AM654x SoC
Message-ID: <nw5myorissautj3uzhe2h32imu5v7bycjo3studma7v7dt37g6@tffgtog7x3j5>
References: <20231019081330.2975470-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019081330.2975470-1-s-vadapalli@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 19, 2023 at 01:43:30PM +0530, Siddharth Vadapalli wrote:
> In the process of converting .scan_bus() callbacks to .add_bus(), the
> ks_pcie_v3_65_scan_bus() function was changed to ks_pcie_v3_65_add_bus().
> The .scan_bus() method belonged to ks_pcie_host_ops which was specific
> to controller version 3.65a, while the .add_bus() method had been added
> to ks_pcie_ops which is shared between the controller versions 3.65a and
> 4.90a. Neither the older ks_pcie_v3_65_scan_bus() method, nor the newer
> ks_pcie_v3_65_add_bus() method are applicable to the controller version
> 4.90a which is present in AM654x SoCs.
> 
> Thus, fix this by creating ks_pcie_am6_ops for the AM654x SoC which uses DW
> PCIe IP-core version 4.90a controller and omitting the .add_bus() method
> which is not applicable to the 4.90a controller. Update ks_pcie_host_init()
> accordingly in order to set the pci_ops to ks_pcie_am6_ops if the platform
> is AM654x SoC and to ks_pcie_ops otherwise, by making use of the "is_am6"
> flag.
> 
> Fixes: 6ab15b5e7057 ("PCI: dwc: keystone: Convert .scan_bus() callback to use add_bus")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

LGTM. Thanks!
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

One more note is further just to draw attention to possible driver
simplifications.

> ---
> Hello,
> 
> This patch is based on linux-next tagged next-20231018.
> 
> The v2 of this patch is at:
> https://lore.kernel.org/r/20231018075038.2740534-1-s-vadapalli@ti.com/
> 
> Changes since v2:
> - Implemented Serge's suggestion of adding a new pci_ops structure for
>   AM654x SoC using DWC PCIe IP-core version 4.90a controller.
> - Created struct pci_ops ks_pcie_am6_ops for AM654x SoC without the
>   .add_bus method while retaining other ops from ks_pcie_ops.
> - Updated ks_pcie_host_init() to set pci_ops to ks_pcie_am6_ops if the
>   platform is AM654x and to ks_pcie_ops otherwise by making use of the
>   already existing "is_am6" flag.
> - Combined the section:
> 	if (!ks_pcie->is_am6)
>  		pp->bridge->child_ops = &ks_child_pcie_ops;
>   into the newly added ELSE condition.
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
>  drivers/pci/controller/dwc/pci-keystone.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 49aea6ce3e87..66341a0b6c6b 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -487,6 +487,12 @@ static struct pci_ops ks_pcie_ops = {
>  	.add_bus = ks_pcie_v3_65_add_bus,
>  };
>  
> +static struct pci_ops ks_pcie_am6_ops = {
> +	.map_bus = dw_pcie_own_conf_map_bus,
> +	.read = pci_generic_config_read,
> +	.write = pci_generic_config_write,
> +};
> +
>  /**
>   * ks_pcie_link_up() - Check if link up
>   * @pci: A pointer to the dw_pcie structure which holds the DesignWare PCIe host
> @@ -804,9 +810,12 @@ static int __init ks_pcie_host_init(struct dw_pcie_rp *pp)
>  	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
>  	int ret;
>  
> -	pp->bridge->ops = &ks_pcie_ops;
> -	if (!ks_pcie->is_am6)
> +	if (ks_pcie->is_am6) {
> +		pp->bridge->ops = &ks_pcie_am6_ops;
> +	} else {

> +		pp->bridge->ops = &ks_pcie_ops;
>  		pp->bridge->child_ops = &ks_child_pcie_ops;

Bjorn, could you please clarify the next suggestion? I'm not that
fluent in the PCIe core details, but based on the
pci_host_bridge.child_ops and pci_host_bridge.ops names, the first ops
will be utilized for the child (non-root) PCIe buses, meanwhile the
later ones - for the root bus only (see pci_alloc_child_bus()). Right?

If so then either the pci_is_root_bus() check can be dropped from the
ks_pcie_v3_65_add_bus() method since the ops it belong to will be
utilized for the root bus anyway, or the entire ks_child_pcie_ops
instance can be dropped since the ks_pcie_v3_65_add_bus() method will
be no-op for the child buses anyway meanwhile ks_child_pcie_ops
matches to ks_pcie_ops in the rest of the ops. After doing that I
would have also changed the ks_pcie_v3_65_add_bus name to
ks_pcie_v3_65_add_root_bus() in anyway. Am I right?

-Serge(y)

> +	}
>  
>  	ret = ks_pcie_config_legacy_irq(ks_pcie);
>  	if (ret)
> -- 
> 2.34.1
> 
