Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C74073772A
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jun 2023 00:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjFTWAg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 18:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjFTWAf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 18:00:35 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC85E69;
        Tue, 20 Jun 2023 15:00:34 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-77e2df49a91so156510239f.2;
        Tue, 20 Jun 2023 15:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687298433; x=1689890433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkvWnaNInIKYQwmLtqQyrYXWIuuVDNI4W1xbI4+bKeE=;
        b=JXaILNa3MoZWrR2rHXGWFk7wOxPf9eZ+0vZMHyKPlHOdMdDipmtR+3XhttyoFRzONa
         G22V+BukJaaGnOKAnS1kqsJn+ZhUuE1HaEKl8xr79hhvEKDrXFG6Qb92W3FfllUq4zxb
         d0KE/6COb581HlV8RZPaT/l5h8tS2i4rOIhMWtM/b7wzZ2+ZsVl67YXcmDVozAm0bteG
         jyqr8+tWh4oi6xPwQerVr1Fe9sjOLZD97LVq7RLSP2nFhdu33jmnoQ/TBBCsgWDpdEg6
         /WcT6V47/lGhWZDC/Q6YO0TV0rIdxPSEyQ2HP5VKam/Idv5spDtriM7nddpLY4vzWqX6
         c27g==
X-Gm-Message-State: AC+VfDxddViKlJbTvAyZlz9OPZEZvAnc+aY9QnxjBOsaX61ZaddkfNZ6
        L811xtu/3wYWt3Hdl4pRYs/SJZaxaA==
X-Google-Smtp-Source: ACHHUZ5at612OHC/BW9tJh9UamKyFCTk9abmHhxBPb2vcmMYzrmfS2mUTOYPzxEKk1eBHFvqM95i7A==
X-Received: by 2002:a6b:a14:0:b0:777:aa2c:c2ab with SMTP id z20-20020a6b0a14000000b00777aa2cc2abmr10535634ioi.12.1687298433323;
        Tue, 20 Jun 2023 15:00:33 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h13-20020a02cd2d000000b0041a9022c3dasm853702jaq.118.2023.06.20.15.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 15:00:32 -0700 (PDT)
Received: (nullmailer pid 411428 invoked by uid 1000);
        Tue, 20 Jun 2023 22:00:31 -0000
Date:   Tue, 20 Jun 2023 16:00:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, stefano.stabellini@xilinx.com
Subject: Re: [PATCH V9 4/6] PCI: Add ranges property for pci endpoint
Message-ID: <20230620220031.GA384833-robh@kernel.org>
References: <1686847842-33780-1-git-send-email-lizhi.hou@amd.com>
 <1686847842-33780-5-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1686847842-33780-5-git-send-email-lizhi.hou@amd.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 15, 2023 at 09:50:40AM -0700, Lizhi Hou wrote:
> For PCI endpoint defined quirks to generate device tree node, it requires
> 'ranges' property to translate iomem addresses for its downstream devices.

I'm not following why this patch is separate from patch 2 nor how patch 
3 would function without it.

> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>  drivers/pci/of_property.c | 33 ++++++++++++++++++++++-----------
>  drivers/pci/quirks.c      |  1 +
>  2 files changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> index bdd756c8d7de..08654740f314 100644
> --- a/drivers/pci/of_property.c
> +++ b/drivers/pci/of_property.c
> @@ -84,15 +84,22 @@ static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
>  	struct of_pci_range *rp;
>  	struct resource *res;
>  	int i = 0, j, ret;
> +	u32 flags, num;
>  	u64 val64;
> -	u32 flags;
>  
> -	rp = kcalloc(PCI_BRIDGE_RESOURCE_NUM, sizeof(*rp), GFP_KERNEL);
> +	if (pci_is_bridge(pdev)) {
> +		num = PCI_BRIDGE_RESOURCE_NUM;
> +		res = &pdev->resource[PCI_BRIDGE_RESOURCES];
> +	} else {
> +		num = PCI_STD_NUM_BARS;
> +		res = &pdev->resource[PCI_STD_RESOURCES];
> +	}
> +
> +	rp = kcalloc(num, sizeof(*rp), GFP_KERNEL);
>  	if (!rp)
>  		return -ENOMEM;
>  
> -	res = &pdev->resource[PCI_BRIDGE_RESOURCES];
> -	for (j = 0; j < PCI_BRIDGE_RESOURCE_NUM; j++) {
> +	for (j = 0; j < num; j++) {
>  		if (!resource_size(&res[j]))
>  			continue;
>  
> @@ -102,8 +109,12 @@ static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
>  		val64 = res[j].start;
>  		of_pci_set_address(pdev, rp[i].parent_addr, val64, 0, flags,
>  				   false);
> -		memcpy(rp[i].child_addr, rp[i].parent_addr,
> -		       sizeof(rp[i].child_addr));
> +		if (pci_is_bridge(pdev)) {
> +			memcpy(rp[i].child_addr, rp[i].parent_addr,
> +			       sizeof(rp[i].child_addr));
> +		} else {
> +			rp[i].child_addr[0] = j;

A comment that child address lower 64-bits is always 0x0 would be 
helpful here.

> +		}
>  
>  		val64 = resource_size(&res[j]);
>  		rp[i].size[0] = upper_32_bits(val64);
> @@ -161,13 +172,13 @@ int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
>  	if (pci_is_bridge(pdev)) {
>  		ret |= of_changeset_add_prop_string(ocs, np, "device_type",
>  						    "pci");
> -		ret |= of_changeset_add_prop_u32(ocs, np, "#address-cells",
> -						 OF_PCI_ADDRESS_CELLS);
> -		ret |= of_changeset_add_prop_u32(ocs, np, "#size-cells",
> -						 OF_PCI_SIZE_CELLS);
> -		ret |= of_pci_prop_ranges(pdev, ocs, np);
>  	}
>  
> +	ret |= of_pci_prop_ranges(pdev, ocs, np);
> +	ret |= of_changeset_add_prop_u32(ocs, np, "#address-cells",
> +					 OF_PCI_ADDRESS_CELLS);
> +	ret |= of_changeset_add_prop_u32(ocs, np, "#size-cells",
> +					 OF_PCI_SIZE_CELLS);
>  	ret |= of_pci_prop_reg(pdev, ocs, np);
>  	ret |= of_pci_prop_compatible(pdev, ocs, np);
>  
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index c8f3acea752d..51945b631628 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6052,3 +6052,4 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
>   */
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
> -- 
> 2.34.1
> 
