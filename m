Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AD85AF852
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 01:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiIFXSe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 19:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiIFXSc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 19:18:32 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6169280EB7;
        Tue,  6 Sep 2022 16:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662506311; x=1694042311;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T5jQoJwMfhrAtxLtijB7as6MbNd9wJMzK7jsC0Yzl3U=;
  b=jmBEkP3kn927guXbAXt0+gc33V13FGMrXkITWVY0iaV2HPb7SkTcaVa3
   KWvoDyASoctip/B/otBZPAl0RNV6IhbX9f7xblVuEftKcOIIcimkfhucs
   I7/VbbmyK6MbGdbtmaMgaVJ3Azj1ABe5s4U23sfy/lX1z5+Fq4i9SMGVn
   ZM5bSSHerOjW3u5q9hNBa+uY5PqsVPVryvQVC2KhkwZMts3l3AhD7PFqS
   rGVYpBzKQSQKITZJedR1oZa4SlcqJdSta4av2yV90lHazGj6YJ9Q4exXp
   gQmvvN/8KSZeNkWoNsJBR0naqmdnjJtb20gDrsw5eYBw++l7bgHGKa4OY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="277127267"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="277127267"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 16:18:31 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="703390337"
Received: from sanekar-mobl.amr.corp.intel.com (HELO [10.212.226.92]) ([10.212.226.92])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 16:18:23 -0700
Message-ID: <def1ed94-273a-11eb-68c3-b0b681f921ca@linux.intel.com>
Date:   Tue, 6 Sep 2022 16:18:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 02/10] PCI/PTM: Cache PTM Capability offset
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
 <20220906222351.64760-3-helgaas@kernel.org>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220906222351.64760-3-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 9/6/22 3:23 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Cache the PTM Capability offset instead of searching for it every time we
> enable/disable PTM or save/restore PTM state.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/ptm.c | 41 +++++++++++++++++------------------------
>  include/linux/pci.h    |  1 +
>  2 files changed, 18 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index b6a417247ce3..6ac7ff48be57 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -31,13 +31,9 @@ static void pci_ptm_info(struct pci_dev *dev)
>  
>  void pci_disable_ptm(struct pci_dev *dev)
>  {
> -	int ptm;
> +	int ptm = dev->ptm_cap;

I think you don't need to store it. Directly use dev->ptm?

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
> +	int ptm = dev->ptm_cap;

Same as above.

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
> +	int ptm = dev->ptm_cap;

It can be u16?

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
> +	int ptm;

Why rename? Also ptm can be u16

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
> +	int ptm;
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
