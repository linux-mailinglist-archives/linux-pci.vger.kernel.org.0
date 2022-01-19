Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4694941D1
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jan 2022 21:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiASUdS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jan 2022 15:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbiASUdS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jan 2022 15:33:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD0FC061574;
        Wed, 19 Jan 2022 12:33:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71196B81BB0;
        Wed, 19 Jan 2022 20:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BB3C004E1;
        Wed, 19 Jan 2022 20:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642624395;
        bh=pDgA0pBQNxjL7yUw6mlhGXKfNWH05iA5ql4ZxhssZI4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fylfd8XOkiuqjJo1lB2TWaquY2pdEB+EhRO45UA+jIDfPj2nd9huoL1G+6rVwXcKi
         4DKiJt1UOxG4VzbjvEpk9lGVFRKULil1IIDiwSlu15YNc4LGq+3S7NOVDX8X7ZV90i
         RmWtT3z3XXQlw4qolpO9XgJ6e9HQRwp9TzyRmw/A3qV4QwmDpKOY5T4QQmlI4czehS
         fR8mFRaNkEBvFA+RV0rIW/uAFXpFNIvO7jCkDbRMV1+3CgHdfpXVN5T4jHxQZCrVKJ
         2xhgklTeBGwL8DA1CDJLSk/jo88CLdiMaPnIT6JCY5c7fCM/aWBea4HTYWWazD6cPt
         Q0mu3g/VowtKQ==
Date:   Wed, 19 Jan 2022 14:33:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Li Chen <lchen@ambarella.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: endpoint: Add prefetch bar support
Message-ID: <20220119203313.GA962011@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR19MB5562C967A2480E2EE980289CA0599@PH7PR19MB5562.namprd19.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 19, 2022 at 10:39:49AM +0000, Li Chen wrote:
> Before this commit, epf cannot set bar to be prefetchable.
> Prefetchable bar can also help epf device to use bridge's
> prefetch memory window.

Please capitalize "BAR" in subject and commit log (as you did in
comment below) so we know it's an acronym.

> Signed-off-by: Li Chen <lchen@ambarella.com>
> Change-Id: I1691a946d715cc161711d6eef56e7a74678a3578

Drop the Change-Id since it is not useful upstream.

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 4 ++++
>  include/linux/pci-epc.h                       | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 90d84d3bc868..96489cfdf58d 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -817,15 +817,19 @@ static void pci_epf_configure_bar(struct pci_epf *epf,
>  {
>  	struct pci_epf_bar *epf_bar;
>  	bool bar_fixed_64bit;
> +	bool bar_prefetch;
>  	int i;
>  
>  	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>  		epf_bar = &epf->bar[i];
>  		bar_fixed_64bit = !!(epc_features->bar_fixed_64bit & (1 << i));
> +		bar_prefetch = !!(epc_features->bar_prefetch & (1 << i));
>  		if (bar_fixed_64bit)
>  			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
>  		if (epc_features->bar_fixed_size[i])
>  			bar_size[i] = epc_features->bar_fixed_size[i];
> +		if (bar_prefetch)
> +			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_PREFETCH;
>  	}
>  }
>  
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index a48778e1a4ee..825632d581d0 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -161,6 +161,7 @@ struct pci_epc {
>   * @msix_capable: indicate if the endpoint function has MSI-X capability
>   * @reserved_bar: bitmap to indicate reserved BAR unavailable to function driver
>   * @bar_fixed_64bit: bitmap to indicate fixed 64bit BARs
> + * @bar_prefetch: bitmap to indicate prefetchable BARs
>   * @bar_fixed_size: Array specifying the size supported by each BAR
>   * @align: alignment size required for BAR buffer allocation
>   */
> @@ -171,6 +172,7 @@ struct pci_epc_features {
>  	unsigned int	msix_capable : 1;
>  	u8	reserved_bar;
>  	u8	bar_fixed_64bit;
> +	u8	bar_prefetch;
>  	u64	bar_fixed_size[PCI_STD_NUM_BARS];
>  	size_t	align;
>  };
> -- 
> 2.34.1
> 
> Regards,
> Li
> 
> **********************************************************************
> This email and attachments contain Ambarella Proprietary and/or Confidential Information and is intended solely for the use of the individual(s) to whom it is addressed. Any unauthorized review, use, disclosure, distribute, copy, or print is prohibited. If you are not an intended recipient, please contact the sender by reply email and destroy all copies of the original message. Thank you.
