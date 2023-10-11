Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14D57C5160
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 13:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346282AbjJKLQY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 07:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346207AbjJKLP7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 07:15:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D24DE;
        Wed, 11 Oct 2023 04:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697022951; x=1728558951;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=266a6aSFHUu8uZRca24nvff3KrxQw8xpLceNtAp6Bgg=;
  b=FG0ltLKZAyI756Pcv6/hWP2zzdXRpj0emJJ7rs9U1Pblt0TlJKbbShiu
   lgqePE60+RdeCO+rOhMaueiA1EET8txZk2QzfA00KopTcLpxe6Zhpv4g2
   acTMDMoUvLriAWiHyMF6vTtwnd4KXHKgSdjNvUMuGU0OPAMwQMh63d/ey
   GtWoW96U0Q+r2+Lp8IKdgLJ3GCziu0iaaJMdHd8lipvRfXJFzd8Jhop+Q
   Zc2wFMZTZ7LJm3d48v79P7vl8mxbevsGlCCmO0e1U/Cc+ctaMFAijd4j9
   pBkaNWlkS3I9pzkorelTZjHjKMk6E0RRA5MJjBIuhHXzeHwLkVcuJJmru
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="451126614"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="451126614"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:15:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="870106924"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="870106924"
Received: from opipikin-mobl2.ger.corp.intel.com (HELO sdodaev-mobl.ger.corp.intel.com) ([10.252.57.154])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:15:38 -0700
Date:   Wed, 11 Oct 2023 14:15:36 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     linux-pci@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 08/10] PCI/PTM: Use FIELD_GET()
In-Reply-To: <20231010204436.1000644-9-helgaas@kernel.org>
Message-ID: <638694d-969a-1076-1d28-b4271f4ed68b@linux.intel.com>
References: <20231010204436.1000644-1-helgaas@kernel.org> <20231010204436.1000644-9-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 10 Oct 2023, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Use FIELD_GET() to remove dependences on the field position, i.e., the
> shift value.  No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

You seem to be using FIELD_PREP() too below.


> ---
>  drivers/pci/pcie/ptm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index b4e5f553467c..7cfb6c0d5dcb 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -4,6 +4,7 @@
>   * Copyright (c) 2016, Intel Corporation.
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/pci.h>
> @@ -53,7 +54,7 @@ void pci_ptm_init(struct pci_dev *dev)
>  	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_PTM, sizeof(u32));
>  
>  	pci_read_config_dword(dev, ptm + PCI_PTM_CAP, &cap);
> -	dev->ptm_granularity = (cap & PCI_PTM_GRANULARITY_MASK) >> 8;
> +	dev->ptm_granularity = FIELD_GET(PCI_PTM_GRANULARITY_MASK, cap);
>  
>  	/*
>  	 * Per the spec recommendation (PCIe r6.0, sec 7.9.15.3), select the
> @@ -146,7 +147,7 @@ static int __pci_enable_ptm(struct pci_dev *dev)
>  
>  	ctrl |= PCI_PTM_CTRL_ENABLE;
>  	ctrl &= ~PCI_PTM_GRANULARITY_MASK;
> -	ctrl |= dev->ptm_granularity << 8;
> +	ctrl |= FIELD_PREP(PCI_PTM_GRANULARITY_MASK, dev->ptm_granularity);
>  	if (dev->ptm_root)
>  		ctrl |= PCI_PTM_CTRL_ROOT;
>  
> 


-- 
 i.

