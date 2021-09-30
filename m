Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655F341DF05
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 18:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351048AbhI3Qak (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 12:30:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350390AbhI3Qaj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 12:30:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6069615A2;
        Thu, 30 Sep 2021 16:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633019337;
        bh=h13uQ1EWLRKHyHC6YygYqklFpBEzNTt4uGMAdUKEMqo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XQvEycRN0dYR+LyhAPO+j6JK+ylD0+gajchvaAVGHiRLhO88MbUYNpbYWCr0OGDYO
         qxSXQgqIPsZSYJob171o7VrJsgSAf0A+1ojVvGlJOkPhmndLGgyvrYlf+D2Z3A3+lm
         WGzgNyTh3JgDhzr1r1Kj/bxnFMRU5LZgcUBlOv1cQGyzoJn63re9eNOm7AaohySBvs
         x2M0pDm7eCGuBDBxeoHjF1WCsFvd9WA3+49RI6iOBUi5jufYsqKPzEIHJUWKWp2UGV
         1QnkWnM0zrFd5Cys3B/LmpalwYgWVl1O1i078Pvdzf0r1GGhz7RDAFIiMKWZdmUj+r
         pAZxbMhe1GUBw==
Date:   Thu, 30 Sep 2021 11:28:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 3/4] PCI/ASPM: Remove struct
 pcie_link_state.clkpm_enabled
Message-ID: <20210930162854.GA888559@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929004400.25717-4-refactormyself@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 02:43:59AM +0200, Saheed O. Bolarinwa wrote:
> From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>
> 
> The clkpm_enabled member of the struct pcie_link_state stores the
> current Clock PM state for the device. However, when the state changes
> it is persisted and can be retrieve by calling pcie_get_clkpm_state()
> introduced in patch [1/3] in this series.
> 
> This patch:
>    - removes clkpm_enabled from the struct pcie_link_state
>    - removes all instance where clkpm_enable is set
>    - replaces references to clkpm_enabled with a call to
>      pcie_get_clkpm_state()

Similar commit log comments as previous patch.

> Signed-off-by: Bolarinwa O. Saheed <refactormyself@gmail.com>
> ---
>  drivers/pci/pcie/aspm.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 9e65da9a22dd..368828cd427d 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -61,7 +61,6 @@ struct pcie_link_state {
>  	u32 aspm_disable:7;		/* Disabled ASPM state */
>  
>  	/* Clock PM state */
> -	u32 clkpm_enabled:1;		/* Current Clock PM state */
>  	u32 clkpm_disable:1;		/* Clock PM disabled */
>  
>  	/* Exit latencies */
> @@ -190,7 +189,6 @@ static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
>  		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
>  						   PCI_EXP_LNKCTL_CLKREQ_EN,
>  						   val);
> -	link->clkpm_enabled = !!enable;
>  }
>  
>  static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
> @@ -203,14 +201,13 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
>  	if (!capable || link->clkpm_disable)
>  		enable = 0;
>  	/* Need nothing if the specified equals to current state */
> -	if (link->clkpm_enabled == enable)
> +	if (pcie_get_clkpm_state(link->pdev) == enable)

Instead of pcie_get_clkpm_state(), I think I would add this:

  static int pcie_clkpm_enabled(struct pci_dev *pdev)
  {
    struct pci_dev *child;
    struct pci_bus *linkbus = pdev->subordinate;
    u16 ctl;

    /* CLKREQ_EN is only applicable for Upstream Ports */
    list_for_each_entry(child, &linkbus->devices, bus_list) {
      pcie_capability_read_word(PCI_EXP_LNKCTL, &ctl);
      if (!(ctl & PCI_EXP_LNKCTL_CLKREQ_EN))
        return 0;
    }
    return 1;
  }

And I would rename pcie_is_clkpm_capable() from the previous patch to
match, i.e., pcie_clkpm_capable().  I suggested "bool" for it, but maybe
it should stay "int" to match this.  They both could be "bool", but
that seems a little messy because "enable" comes from
policy_to_clkpm_state(), so it would involve quite a few more changes.

>  		return;
>  	pcie_set_clkpm_nocheck(link, enable);
>  }
>  
>  static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
>  {
> -	link->clkpm_enabled = pcie_get_clkpm_state(link->pdev);
>  	link->clkpm_disable = blacklist ? 1 : 0;
>  }
>  
> @@ -1287,7 +1284,7 @@ static ssize_t clkpm_show(struct device *dev,
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
>  
> -	return sysfs_emit(buf, "%d\n", link->clkpm_enabled);
> +	return sysfs_emit(buf, "%d\n", pcie_get_clkpm_state(link->pdev));
>  }
>  
>  static ssize_t clkpm_store(struct device *dev,
> -- 
> 2.20.1
> 
