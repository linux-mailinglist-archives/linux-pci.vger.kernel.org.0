Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F7E5ABB74
	for <lists+linux-pci@lfdr.de>; Sat,  3 Sep 2022 01:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiIBX4n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 19:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIBX4m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 19:56:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBE3DDA9A;
        Fri,  2 Sep 2022 16:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662163001; x=1693699001;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BnSeA2s0ZqwQIAEryzw/fkfvhxBxnJlfAEFdXa5WICQ=;
  b=jPUEcjzTE9lQOcKuGLRiu34gVyCr5Jb9FCexe13QGlEz4nmM+YdQ1dK6
   8MNt1TrLn/bwhK4I0gCvlmpVxoFExRitcq0cs7AsAOhsMMs8UnpwrMIrW
   w5D1BMifxm3YuNty3/iBX2ajg5UIqwsQ6C2Ks1c4WK85Bhz8mUUZsGVjc
   /Cy3P86C5pw+myLZPyGximifulgKod4tccIAHcNg63mHe8FLC/rhrpHvf
   c7fY80a9+2dLOsiIv5wC7STY71dcKACxiIhpiqAD1qkFtTjhVdakGHzoi
   9iGAYAYUZ4bNPFedqjgR21POSx1EZNNCgOkfW/uw9/srOGCX/zmtkjlyQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="279125309"
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="279125309"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 16:56:41 -0700
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="755422551"
Received: from cgoff-mobl1.amr.corp.intel.com (HELO [10.209.53.13]) ([10.209.53.13])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 16:56:40 -0700
Message-ID: <8f4c3040-392e-f64d-4f30-a4e6838f9a1d@linux.intel.com>
Date:   Fri, 2 Sep 2022 16:56:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/3] PCI/PTM: Implement pci_enable_ptm() for Root
 Ports, Switch Upstream Ports
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
References: <20220902233543.390890-1-helgaas@kernel.org>
 <20220902233543.390890-3-helgaas@kernel.org>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220902233543.390890-3-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/2/22 4:35 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/ptm.c | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index b6a417247ce3..ad283818f37b 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -167,11 +167,11 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
>  	if (!pos)
>  		return -EINVAL;
>  
> -	pci_read_config_dword(dev, pos + PCI_PTM_CAP, &cap);
> -	if (!(cap & PCI_PTM_CAP_REQ))
> -		return -EINVAL;
> -

May be saving PCI_PTM_CAP_REQ enabled state here and using it below only for
endpoints checks will reduce the code duplication?

>  	/*
> +	 * Root Ports and Switch Upstream Ports have been configured
> +	 * by pci_ptm_init(), so preserve their PCI_PTM_CTRL_ROOT and
> +	 * granularity.
> +	 *
>  	 * For a PCIe Endpoint, PTM is only useful if the endpoint can
>  	 * issue PTM requests to upstream devices that have PTM enabled.
>  	 *
> @@ -179,19 +179,39 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
>  	 * device, so there must be some implementation-specific way to
>  	 * associate the endpoint with a time source.
>  	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT) {
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> +	    pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM) {
> +		if (pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM) {
> +			ups = pci_upstream_bridge(dev);
> +			if (!ups || !ups->ptm_enabled)
> +				return -EINVAL;
> +		}
> +
> +		pci_read_config_dword(dev, pos + PCI_PTM_CTRL, &ctrl);

Why read PCI_PTM_CTRL state only for root and upstream ports? The same logic
will work for endpoints and RC endpoints right? 

What not use dev->ptm_granularity for root ports?

> +		ctrl |= PCI_PTM_CTRL_ENABLE;
> +	} else if (pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT) {
> +		pci_read_config_dword(dev, pos + PCI_PTM_CAP, &cap);
> +		if (!(cap & PCI_PTM_CAP_REQ))
> +			return -EINVAL;
> +
>  		ups = pci_upstream_bridge(dev);
>  		if (!ups || !ups->ptm_enabled)
>  			return -EINVAL;
>  
>  		dev->ptm_granularity = ups->ptm_granularity;
> +		ctrl = PCI_PTM_CTRL_ENABLE;
> +		ctrl |= dev->ptm_granularity << 8;
>  	} else if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
> +		pci_read_config_dword(dev, pos + PCI_PTM_CAP, &cap);
> +		if (!(cap & PCI_PTM_CAP_REQ))
> +			return -EINVAL;
> +
>  		dev->ptm_granularity = 0;
> +		ctrl = PCI_PTM_CTRL_ENABLE;
> +		ctrl |= dev->ptm_granularity << 8;
>  	} else
>  		return -EINVAL;
>  
> -	ctrl = PCI_PTM_CTRL_ENABLE;
> -	ctrl |= dev->ptm_granularity << 8;
>  	pci_write_config_dword(dev, pos + PCI_PTM_CTRL, ctrl);
>  	dev->ptm_enabled = 1;
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
