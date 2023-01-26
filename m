Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC29467D7A0
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 22:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjAZVWn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 16:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjAZVWm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 16:22:42 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F53301B9;
        Thu, 26 Jan 2023 13:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674768161; x=1706304161;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cCxPUgucea+LDKCkLYswdeqqJgXYQzc1yiOXRjJnzBI=;
  b=MK0K9dvRso3eLH3EpSczFZTG1L+VqfF6rBP+gt8iZxen+vI+OvfxxoQB
   M+i0ZnHMQAfIfJQwdau04enGkNgG5HhFVnOJ2ZHEYJHajccC/bhWsxz+H
   F1YMyl29hNPw1ngQSe+cGV568EBHjpNJFYrIhmi4Stn64AF3AQ7Xhd1Q1
   8lLXAEPJh7PcJQcl+VRuGS9S1S33sYs8RaMInr9/Pleaj4HGdRPDqBcQw
   XV4v5xGLz2w3hRBPxG36LzpANKaazbi6tV3L+nRRjnq66QgGtBqUXRShi
   oRzfaBk90ObaLaGlSqtX0xCP3ZFBqxCOtwZsr8L/Fza0fLJ0fzdzGpsgB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="413172729"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="413172729"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 13:22:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="726414793"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="726414793"
Received: from jlholden-mobl.amr.corp.intel.com (HELO [10.212.216.202]) ([10.212.216.202])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 13:22:40 -0800
Message-ID: <8888528f-db70-1fef-71bb-8a3dd1f4380f@linux.intel.com>
Date:   Thu, 26 Jan 2023 13:22:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH V1] PCI/ASPM: Update saved buffers with latest ASPM
 configuration
Content-Language: en-US
To:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        rafael.j.wysocki@intel.com, kai.heng.feng@canonical.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20230125133830.20620-1-vidyas@nvidia.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230125133830.20620-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 1/25/23 5:38 AM, Vidya Sagar wrote:
> Many PCIe device drivers save the configuration state of their respective
> devices during probe and restore the same when their 'slot_reset' hook
> is called through PCIe Error Recovery System.
> If the system has a change in ASPM policy after the driver's probe is
> called and before error event occurred, 'slot_reset' hook restores the
> PCIe configuration state to what it was at the time of probe but not with
> what it was just before the occurrence of the error event.
> This effectively leads to a mismatch in the ASPM configuration between
> the device and its upstream parent device.
> This patch addresses that issue by updating the saved configuration state
> of the device with the latest info whenever there is a change w.r.t ASPM
> policy.

Do we need two save/restore calls for ASPM function? Is it not possible
to extend pci_save_aspm_l1ss_state() to meet your need?

> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/pci.h       |  4 ++++
>  drivers/pci/pcie/aspm.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 9ed3b5550043..f4a91d4fe96d 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -566,12 +566,16 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
>  void pcie_aspm_init_link_state(struct pci_dev *pdev);
>  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> +void pci_save_aspm_state(struct pci_dev *dev);
> +void pci_restore_aspm_state(struct pci_dev *dev);
>  void pci_save_aspm_l1ss_state(struct pci_dev *dev);
>  void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
>  #else
>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
> +static inline void pci_save_aspm_state(struct pci_dev *dev) { }
> +static inline void pci_restore_aspm_state(struct pci_dev *dev) { }
>  static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
>  static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
>  #endif
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 53a1fa306e1e..f25e0440d36b 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -151,6 +151,7 @@ static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
>  						   PCI_EXP_LNKCTL_CLKREQ_EN,
>  						   val);
>  	link->clkpm_enabled = !!enable;
> +	pci_save_aspm_state(child);

Add some details about this change to the commit log. Currently, you have talked only
about the ASPM policy change issue.

>  }
>  
>  static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
> @@ -757,6 +758,39 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
>  				PCI_L1SS_CTL1_L1SS_MASK, val);
>  }
>  
> +void pci_save_aspm_state(struct pci_dev *dev)
> +{
> +	int i = 0;
> +	struct pci_cap_saved_state *save_state;
> +	u16 *cap;
> +
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
> +	if (!save_state)
> +		return;
> +
> +	cap = (u16 *)&save_state->cap.data[0];
> +	i++;
> +	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &cap[i++]);
> +}
> +
> +void pci_restore_aspm_state(struct pci_dev *dev)
> +{
> +	int i = 0;
> +	struct pci_cap_saved_state *save_state;
> +	u16 *cap;
> +
> +	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
> +	if (!save_state)
> +		return;
> +
> +	cap = (u16 *)&save_state->cap.data[0];
> +	i++;
> +	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, cap[i++]);
> +}
> +

Don't you need to add this restore call in pci_restore_state()?

>  void pci_save_aspm_l1ss_state(struct pci_dev *dev)
>  {
>  	struct pci_cap_saved_state *save_state;
> @@ -849,6 +883,12 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
>  		pcie_config_aspm_dev(parent, upstream);
>  
>  	link->aspm_enabled = state;
> +
> +	/* Update latest ASPM configuration in saved context */
> +	pci_save_aspm_state(link->downstream);
> +	pci_save_aspm_l1ss_state(link->downstream);
> +	pci_save_aspm_state(parent);
> +	pci_save_aspm_l1ss_state(parent);
>  }
>  
>  static void pcie_config_aspm_path(struct pcie_link_state *link)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
