Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5565841DE14
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 17:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346658AbhI3Pzp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 11:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346582AbhI3Pzp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 11:55:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F1F661411;
        Thu, 30 Sep 2021 15:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633017242;
        bh=4FLgrYfiAV1mkDxGMwPnsUgIYDlrsX1nBmoYjQHKOrs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LQ/9JqDQ6td04d9li5F/dooPp/dOE3SlVNgF7u9Si5Kjew50vR+hVWBfsIIzJ+014
         N8v+vCGq5AXzoCrCt+vTQHnjT6aXmqePpBODEjc3u2H1yZyKPneMl6p+EB3ZEKnRWC
         t7KR/gFlY+F11CcGQOEVWeiDpHjkDxX27wH4n4ITAcmyYSd/M0WjR38k7hAfepJB76
         iu3JWBvAMASHhgc8rAkbZ2Y9JGoNfsoaS9ng6IJsQGmJMTFzKDeQO5O5nHTC1SRTE+
         FeVov8TjM9GUqeg+iWrn8GbDlAo46roW84eAQr+B+Zms1vXcwM1DlF1mHu7jNb+lnM
         wHHzoZnoflP5Q==
Date:   Thu, 30 Sep 2021 10:54:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/4] [PCI/ASPM:] Remove struct
 pcie_link_state.clkpm_default
Message-ID: <20210930155400.GA886716@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929004400.25717-2-refactormyself@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 02:43:57AM +0200, Saheed O. Bolarinwa wrote:
> From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>
> 
> The clkpm_default member of the struct pcie_link_state stores the
> value of the default clkpm state as it is in the BIOS.
> 
> This patch:
> - Removes clkpm_default from struct pcie_link_state
> - Creates pcie_get_clkpm_state() which return the clkpm state
>   obtained the BIOS
> - Replaces references to clkpm_default with call to
>   pcie_get_clkpm_state()
> 
> Signed-off-by: Bolarinwa O. Saheed <refactormyself@gmail.com>
> ---
>  drivers/pci/pcie/aspm.c | 37 +++++++++++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 013a47f587ce..c23da9a4e2fb 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -63,7 +63,6 @@ struct pcie_link_state {
>  	/* Clock PM state */
>  	u32 clkpm_capable:1;		/* Clock PM capable? */
>  	u32 clkpm_enabled:1;		/* Current Clock PM state */
> -	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
>  	u32 clkpm_disable:1;		/* Clock PM disabled */
>  
>  	/* Exit latencies */
> @@ -123,6 +122,30 @@ static int policy_to_aspm_state(struct pcie_link_state *link)
>  	return 0;
>  }
>  
> +static int pcie_get_clkpm_state(struct pci_dev *pdev)
> +{
> +	int enabled = 1;
> +	u32 reg32;
> +	u16 reg16;
> +	struct pci_dev *child;
> +	struct pci_bus *linkbus = pdev->subordinate;
> +
> +	/* All functions should have the same clkpm state, take the worst */
> +	list_for_each_entry(child, &linkbus->devices, bus_list) {
> +		pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &reg32);
> +		if (!(reg32 & PCI_EXP_LNKCAP_CLKPM)) {
> +			enabled = 0;
> +			break;
> +		}
> +
> +		pcie_capability_read_word(child, PCI_EXP_LNKCTL, &reg16);
> +		if (!(reg16 & PCI_EXP_LNKCTL_CLKREQ_EN))
> +			enabled = 0;
> +	}
> +
> +	return enabled;
> +}
> +
>  static int policy_to_clkpm_state(struct pcie_link_state *link)
>  {
>  	switch (aspm_policy) {
> @@ -134,7 +157,7 @@ static int policy_to_clkpm_state(struct pcie_link_state *link)
>  		/* Enable Clock PM */
>  		return 1;
>  	case POLICY_DEFAULT:
> -		return link->clkpm_default;
> +		return pcie_get_clkpm_state(link->pdev);
>  	}
>  	return 0;
>  }
> @@ -168,9 +191,8 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
>  
>  static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
>  {
> -	int capable = 1, enabled = 1;
> +	int capable = 1;
>  	u32 reg32;
> -	u16 reg16;
>  	struct pci_dev *child;
>  	struct pci_bus *linkbus = link->pdev->subordinate;
>  
> @@ -179,15 +201,10 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
>  		pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &reg32);
>  		if (!(reg32 & PCI_EXP_LNKCAP_CLKPM)) {
>  			capable = 0;
> -			enabled = 0;
>  			break;
>  		}
> -		pcie_capability_read_word(child, PCI_EXP_LNKCTL, &reg16);
> -		if (!(reg16 & PCI_EXP_LNKCTL_CLKREQ_EN))
> -			enabled = 0;
>  	}
> -	link->clkpm_enabled = enabled;
> -	link->clkpm_default = enabled;
> +	link->clkpm_enabled = pcie_get_clkpm_state(link->pdev);

I love the idea of removing clkpm_default, but I need a little more
convincing.  Before this patch, this code computes clkpm_default from
PCI_EXP_LNKCAP_CLKPM and PCI_EXP_LNKCTL_CLKREQ_EN of all the functions
of the device.

PCI_EXP_LNKCAP_CLKPM is a read-only value, so we can re-read that any
time.  But PCI_EXP_LNKCTL_CLKREQ_EN is writable, so if we want to know
the value that firmware put there, we need to read and save it before
we modify it.

Why is it safe to remove this init-time read of
PCI_EXP_LNKCTL_CLKREQ_EN and instead re-read it any time we need the
"default" settings from firmware?

>  	link->clkpm_capable = capable;
>  	link->clkpm_disable = blacklist ? 1 : 0;
>  }
> -- 
> 2.20.1
> 
