Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8495AFBBE
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 07:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiIGF3e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Sep 2022 01:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIGF3d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Sep 2022 01:29:33 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BE9E59;
        Tue,  6 Sep 2022 22:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662528567; x=1694064567;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L9IlGAwWCSc+q+1uTqPN/KSwghsMK2ewtGzB40wFVQ0=;
  b=TbiSIsZr6IMwGdZo0WTzQZCenK3c9IiQbiJkn7VkRMf+y61s+jfvTSyE
   hj1s17FMJOPry+QnOQ6Lq/oqxVswVmdsd3KKf50xiDaTS9MzzvmVlY4yn
   LfmK+IJRk10PnKMmkW2jElrxSqkxPtLiWFFm0eOq9ynNhqw/+jDoxt/h7
   MCQYEWNGe3HFpajpLVd++TZe+RNJ5d6FmWPBUsNjRqRHMP06yifQ3pFqd
   pl+LYsXs2wZCvOjxt6gf10ZhLeT2xsNUYisZf1q4VN2MRdGk8syJWhMQ5
   ibgviVev+xZGJSov225CLNFDKpkOO8/aAe2mIz9246zkZd4tXnXMgooNG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="276523210"
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="276523210"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 22:29:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="676018074"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 06 Sep 2022 22:29:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A5553F7; Wed,  7 Sep 2022 08:29:40 +0300 (EEST)
Date:   Wed, 7 Sep 2022 08:29:40 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Koba Ko <koba.ko@canonical.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 06/10] PCI/PTM: Add pci_enable_ptm() wrapper
Message-ID: <YxgsRH8Er9OPCZea@black.fi.intel.com>
References: <20220906222351.64760-1-helgaas@kernel.org>
 <20220906222351.64760-7-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906222351.64760-7-helgaas@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 06, 2022 at 05:23:47PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Implement pci_enable_ptm() as a wrapper around an internal
> __pci_enable_ptm() that we can use during resume to enable PTM without
> emitting log messages.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/ptm.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index 762299984469..4a9f045126ca 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -152,7 +152,7 @@ void pci_ptm_init(struct pci_dev *dev)
>  		pci_enable_ptm(dev, NULL);
>  }
>  
> -int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
> +static int __pci_enable_ptm(struct pci_dev *dev)
>  {
>  	int ptm = dev->ptm_cap;
>  	struct pci_dev *ups;
> @@ -177,6 +177,17 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
>  		ctrl |= PCI_PTM_CTRL_ROOT;
>  
>  	pci_write_config_dword(dev, ptm + PCI_PTM_CTRL, ctrl);
> +	return 0;
> +}
> +

Same comment here about kernel-doc.

> +int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
> +{
> +	int rc;
> +
> +	rc = __pci_enable_ptm(dev);
> +	if (rc)
> +		return rc;
> +
>  	dev->ptm_enabled = 1;
>  
>  	pci_ptm_info(dev);
> -- 
> 2.25.1
