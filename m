Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195DD5B278F
	for <lists+linux-pci@lfdr.de>; Thu,  8 Sep 2022 22:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiIHUSc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 16:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiIHUSY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 16:18:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C4D103013;
        Thu,  8 Sep 2022 13:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662668303; x=1694204303;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5mvv7AfRVzao2S2qwFNLndbkSYY1jqXMk8GzJurm9Kw=;
  b=OiUblsdpXxyJ3zGg1xzWU1jcZ/Eap++6pXu0YjjbkmcNQ+r0L81UnFKh
   CujzDSCwdDa117m94GMfMewBkmDXPwSNO5Jw+YKOmU+e2ckF1yhLHtMAU
   76oQDq0s5kJl0Oa0RXvgwSl+WCHwSKrxgPBXpz/uQ+8Wer2fYFUzQ7aiK
   BpXws14hdYhHk8WnZwuWOqiIGkvD0INC68nJ4JSYJTB2BLDawFW2VhlV1
   uAAYJFM0w1nsl2skicFs2QU9rOJauYHcuynhjq6QBIqXILJAjOEI4Rp6k
   pi6m6QLkGH4nhUH+7U1iUwubEQM+NtblnxyTqu2coRk0Nw5fyULxbo55a
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="359044519"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="359044519"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 13:18:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="740808691"
Received: from duttamou-mobl1.amr.corp.intel.com (HELO [10.209.109.184]) ([10.209.109.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 13:18:23 -0700
Message-ID: <9a15eb73-0f80-1081-dce2-8357628252f0@linux.intel.com>
Date:   Thu, 8 Sep 2022 13:18:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 06/10] PCI/PTM: Add pci_enable_ptm() wrapper
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20220906222351.64760-1-helgaas@kernel.org>
 <20220906222351.64760-7-helgaas@kernel.org>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220906222351.64760-7-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/6/22 3:23 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Implement pci_enable_ptm() as a wrapper around an internal
> __pci_enable_ptm() that we can use during resume to enable PTM without
> emitting log messages.

Also add a note about not updating ptm_enabled in __pci_enable_ptm()

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

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
