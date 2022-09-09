Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581325B4315
	for <lists+linux-pci@lfdr.de>; Sat, 10 Sep 2022 01:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiIIXiI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 19:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiIIXiH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 19:38:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C901E27B36;
        Fri,  9 Sep 2022 16:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662766686; x=1694302686;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ILRHn3MKvB8RyQjvMGsntlXVH8r+Xk52Vw/Er5hMxqY=;
  b=YOc8dShIQ1i8BnM57/zp/laQPHfJzd827wepfIsHvDslYpwuO+tI3nAQ
   CgoF3RunLDwHn+5lRdbTYgofpL8gpOYaBxcU2oTxQNmER7fobqI5LZngH
   hhNmr9h4UcGk7UUqLjUMl0nxaF2xHxK7XFFBD12vraDNOuTS786UL6rxr
   JvoV9RPR/j/8V9RklVhJ6341cvtMfkCQBZIVbD+koGX7ympA9ib0LyFDE
   OHoSl5Qubrmfmzxy45rr78/UE/NOg6D9Qmxu/fYf5AsjP7k+TGqKqRwZz
   RVtFoldWrHXq/XswcrYv1g2eidc/Jqdfp3ZBYkDvvmQa1xQXE/i8eKnqd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="280611409"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="280611409"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:38:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="677363673"
Received: from gtpedreg-mobl.amr.corp.intel.com (HELO [10.209.57.19]) ([10.209.57.19])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:38:05 -0700
Message-ID: <05208cb8-32a7-dd58-1d01-ce07c815bd64@linux.intel.com>
Date:   Fri, 9 Sep 2022 16:38:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/9] PCI/PTM: Cache PTM Capability offset
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
References: <20220909202505.314195-1-helgaas@kernel.org>
 <20220909202505.314195-2-helgaas@kernel.org>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220909202505.314195-2-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 9/9/22 1:24 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Cache the PTM Capability offset instead of searching for it every time we
> enable/disable PTM or save/restore PTM state.  No functional change
> intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> ---
>  drivers/pci/pcie/ptm.c | 41 +++++++++++++++++------------------------
>  include/linux/pci.h    |  1 +
>  2 files changed, 18 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index 368a254e3124..85382c135885 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -31,13 +31,9 @@ static void pci_ptm_info(struct pci_dev *dev)
>  
>  void pci_disable_ptm(struct pci_dev *dev)
>  {
> -	int ptm;
> +	u16 ptm = dev->ptm_cap;
>  	u16 ctrl;
>  
> -	if (!pci_is_pcie(dev))
> -		return;
> -
> -	ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
>  	if (!ptm)
>  		return;
>  
> @@ -48,14 +44,10 @@ void pci_disable_ptm(struct pci_dev *dev)
>  
>  void pci_save_ptm_state(struct pci_dev *dev)
>  {
> -	int ptm;
> +	u16 ptm = dev->ptm_cap;
>  	struct pci_cap_saved_state *save_state;
>  	u16 *cap;
>  
> -	if (!pci_is_pcie(dev))
> -		return;
> -
> -	ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
>  	if (!ptm)
>  		return;
>  
> @@ -69,16 +61,15 @@ void pci_save_ptm_state(struct pci_dev *dev)
>  
>  void pci_restore_ptm_state(struct pci_dev *dev)
>  {
> +	u16 ptm = dev->ptm_cap;
>  	struct pci_cap_saved_state *save_state;
> -	int ptm;
>  	u16 *cap;
>  
> -	if (!pci_is_pcie(dev))
> +	if (!ptm)
>  		return;
>  
>  	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
> -	ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
> -	if (!save_state || !ptm)
> +	if (!save_state)
>  		return;
>  
>  	cap = (u16 *)&save_state->cap.data[0];
> @@ -87,7 +78,7 @@ void pci_restore_ptm_state(struct pci_dev *dev)
>  
>  void pci_ptm_init(struct pci_dev *dev)
>  {
> -	int pos;
> +	u16 ptm;
>  	u32 cap, ctrl;
>  	u8 local_clock;
>  	struct pci_dev *ups;
> @@ -117,13 +108,14 @@ void pci_ptm_init(struct pci_dev *dev)
>  		return;
>  	}
>  
> -	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
> -	if (!pos)
> +	ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
> +	if (!ptm)
>  		return;
>  
> +	dev->ptm_cap = ptm;
>  	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_PTM, sizeof(u16));
>  
> -	pci_read_config_dword(dev, pos + PCI_PTM_CAP, &cap);
> +	pci_read_config_dword(dev, ptm + PCI_PTM_CAP, &cap);
>  	local_clock = (cap & PCI_PTM_GRANULARITY_MASK) >> 8;
>  
>  	/*
> @@ -148,7 +140,7 @@ void pci_ptm_init(struct pci_dev *dev)
>  	}
>  
>  	ctrl |= dev->ptm_granularity << 8;
> -	pci_write_config_dword(dev, pos + PCI_PTM_CTRL, ctrl);
> +	pci_write_config_dword(dev, ptm + PCI_PTM_CTRL, ctrl);
>  	dev->ptm_enabled = 1;
>  
>  	pci_ptm_info(dev);
> @@ -156,18 +148,19 @@ void pci_ptm_init(struct pci_dev *dev)
>  
>  int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
>  {
> -	int pos;
> +	u16 ptm;
>  	u32 cap, ctrl;
>  	struct pci_dev *ups;
>  
>  	if (!pci_is_pcie(dev))
>  		return -EINVAL;
>  
> -	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
> -	if (!pos)
> +	ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
> +	if (!ptm)
>  		return -EINVAL;
>  
> -	pci_read_config_dword(dev, pos + PCI_PTM_CAP, &cap);
> +	dev->ptm_cap = ptm;
> +	pci_read_config_dword(dev, ptm + PCI_PTM_CAP, &cap);
>  	if (!(cap & PCI_PTM_CAP_REQ))
>  		return -EINVAL;
>  
> @@ -192,7 +185,7 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
>  
>  	ctrl = PCI_PTM_CTRL_ENABLE;
>  	ctrl |= dev->ptm_granularity << 8;
> -	pci_write_config_dword(dev, pos + PCI_PTM_CTRL, ctrl);
> +	pci_write_config_dword(dev, ptm + PCI_PTM_CTRL, ctrl);
>  	dev->ptm_enabled = 1;
>  
>  	pci_ptm_info(dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 060af91bafcd..54be939023a3 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -475,6 +475,7 @@ struct pci_dev {
>  	unsigned int	broken_cmd_compl:1;	/* No compl for some cmds */
>  #endif
>  #ifdef CONFIG_PCIE_PTM
> +	u16		ptm_cap;		/* PTM Capability */
>  	unsigned int	ptm_root:1;
>  	unsigned int	ptm_enabled:1;
>  	u8		ptm_granularity;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
