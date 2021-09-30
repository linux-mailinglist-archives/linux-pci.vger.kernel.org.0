Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D668341DE5A
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 18:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348026AbhI3QHB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 12:07:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348015AbhI3QHB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 12:07:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 240B5613A9;
        Thu, 30 Sep 2021 16:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633017918;
        bh=2NKb+EOcixlHXFwCusyqun807YKMXY+3F2kog04gvrQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TfG/xEZvsCG8dTUXUGC22WhnRq7LMObNMAKOQoD03HkKVAr4QEwMZG6/QvxXthzk1
         5kGBnL+pCoAuISPPxmRSCrd9k+aC/XPEBGq/y6C+0oNrgNfmrWxmJABxGkplcwheXf
         bbLlrO3Ytnbq8lEBZUTv0KfjxSYvY7eA/HEdzby3RR6vXBU7HMR57+od60aPEKBLhD
         6hpb4w7GfrjN43CTLJloNi4RD/9eC8yv/1LJZmHq/QVn3/6rxwtUi5PODDd65D0HDi
         7ICl5vGOext0eGotriNLD6VtdykPzUvjKrckGuRg81AyEm0RPjkrLhFQ/wra0qZF4F
         jef70G2dvTSWw==
Date:   Thu, 30 Sep 2021 11:05:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 2/4] PCI/ASPM: Remove struct
 pcie_link_state.clkpm_capable
Message-ID: <20210930160516.GA887797@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929004400.25717-3-refactormyself@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 02:43:58AM +0200, Saheed O. Bolarinwa wrote:
> From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>
> 
> The clkpm_capable member of the struct pcie_link_state indicates
> if the device is Clock PM capable. This can be calculated when
> it is needed.

... because it comes from Link Capabilities, a read-only register.

> This patch:
>   - removes clkpm_capable from struct pcie_link_state
>   - moves the calculation of clkpm_capable into
>     pcie_is_clkpm_capable()
>   - replaces references to clkpm_capable with a call to
>     pcie_is_clkpm_capable()

No need to say "this patch"; commit logs *always* refer to "this
patch".  Reword in imperative sentence structure, as if giving
commands, e.g.,

  Remove pcie_link_state.clkpm_capable and replace it with
  pcie_is_clkpm_capable(), which computes the value from Link
  Capabilities as needed.

> Signed-off-by: Bolarinwa O. Saheed <refactormyself@gmail.com>
> ---
>  drivers/pci/pcie/aspm.c | 39 ++++++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index c23da9a4e2fb..9e65da9a22dd 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -61,7 +61,6 @@ struct pcie_link_state {
>  	u32 aspm_disable:7;		/* Disabled ASPM state */
>  
>  	/* Clock PM state */
> -	u32 clkpm_capable:1;		/* Clock PM capable? */
>  	u32 clkpm_enabled:1;		/* Current Clock PM state */
>  	u32 clkpm_disable:1;		/* Clock PM disabled */
>  
> @@ -146,6 +145,25 @@ static int pcie_get_clkpm_state(struct pci_dev *pdev)
>  	return enabled;
>  }
>  
> +static int pcie_is_clkpm_capable(struct pci_dev *pdev)
> +{
> +	int capable = 1;
> +	u32 reg32;
> +	struct pci_dev *child;
> +	struct pci_bus *linkbus = pdev->subordinate;
> +
> +	/* All functions should have the same cap state, take the worst */
> +	list_for_each_entry(child, &linkbus->devices, bus_list) {
> +		pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &reg32);
> +		if (!(reg32 & PCI_EXP_LNKCAP_CLKPM)) {
> +			capable = 0;
> +			break;
> +		}
> +	}
> +
> +	return capable;

  static bool pcie_is_clkpm_capable()
  {
    list_for_each_entry(child, &linkbus->devices, bus_list) {
      pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &cap);
      if (!(cap & PCI_EXP_LNKCAP_CLKPM))
	return false;
    }
    return true;
  }

> +}
> +
>  static int policy_to_clkpm_state(struct pcie_link_state *link)
>  {
>  	switch (aspm_policy) {
> @@ -177,11 +195,12 @@ static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
>  
>  static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
>  {
> +	int capable = pcie_is_clkpm_capable(link->pdev);
>  	/*
>  	 * Don't enable Clock PM if the link is not Clock PM capable
>  	 * or Clock PM is disabled
>  	 */
> -	if (!link->clkpm_capable || link->clkpm_disable)
> +	if (!capable || link->clkpm_disable)

I think I'd just call pcie_is_clkpm_capable() directly in the "if"
condition to avoid the local variable, as you did below in
aspm_ctrl_attrs_are_visible().

>  		enable = 0;
>  	/* Need nothing if the specified equals to current state */
>  	if (link->clkpm_enabled == enable)
> @@ -191,21 +210,7 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
>  
>  static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
>  {
> -	int capable = 1;
> -	u32 reg32;
> -	struct pci_dev *child;
> -	struct pci_bus *linkbus = link->pdev->subordinate;
> -
> -	/* All functions should have the same cap and state, take the worst */
> -	list_for_each_entry(child, &linkbus->devices, bus_list) {
> -		pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &reg32);
> -		if (!(reg32 & PCI_EXP_LNKCAP_CLKPM)) {
> -			capable = 0;
> -			break;
> -		}
> -	}
>  	link->clkpm_enabled = pcie_get_clkpm_state(link->pdev);
> -	link->clkpm_capable = capable;

This makes good sense to me because PCI_EXP_LNKCAP_CLKPM is read-only
and there's no need to cache the boot-time value because we can always
recompute clkpm_capable if we need it.

>  	link->clkpm_disable = blacklist ? 1 : 0;
>  }
>  
> @@ -1346,7 +1351,7 @@ static umode_t aspm_ctrl_attrs_are_visible(struct kobject *kobj,
>  		return 0;
>  
>  	if (n == 0)
> -		return link->clkpm_capable ? a->mode : 0;
> +		return pcie_is_clkpm_capable(link->pdev) ? a->mode : 0;
>  
>  	return link->aspm_capable & aspm_state_map[n - 1] ? a->mode : 0;
>  }
> -- 
> 2.20.1
> 
