Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6B42D691C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Dec 2020 21:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393767AbgLJUtg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Dec 2020 15:49:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:52106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390239AbgLJUtg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Dec 2020 15:49:36 -0500
Date:   Thu, 10 Dec 2020 14:48:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607633335;
        bh=/z/T40Uva+Pg+iPlqLTDfjeJB9MBwhWjej3odgV6F6U=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=dCbz9XPmN1xPNrBwSLrDizhpKOFS8w2IioR+YbxorbAj4BbziF3vhStRN+Mhsy0sv
         1nuLyrSS+5rOXsf+D26msP+N98jJ0HTK0jUeQQeppr9W+P2jjcFKD5XhpqJEBc76Ts
         /06XmQ45LikhCIMSA7c0xfwHHBDLxEMBMWHX5yw69UAMwmw+e6vu6rjbYDjYSSg4fX
         MCK31tmmmnuEWxZLmT85+1x89vUhOClssHhIb+nrURIsRI7km9Fn3pCNxLcb6TsYpJ
         mLBeiqfLXFHnj0kephzOOypg8Eq0EytPz0gf5AGk2Zt57KKvJ1zuj84WeRic2Rjke1
         Vxxlp2i/JDdzQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     bhelgaas@google.com, rafael@kernel.org, len.brown@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2 1/2] Add save/restore of Precision Time Measurement
 capability
Message-ID: <20201210204854.GA52934@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207223951.19667-1-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 07, 2020 at 02:39:50PM -0800, David E. Box wrote:
> The PCI subsystem does not currently save and restore the configuration
> space for the Precision Time Measurement (PTM) PCIe extended capability
> leading to the possibility of the feature returning disabled on S3 resume.
> This has been observed on Intel Coffee Lake desktops. Add save/restore of
> the PTM control register. This saves the PTM Enable, Root Select, and
> Effective Granularity bits.
> 
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

Applied both to pci/ptm for v5.11, thanks!

> ---
> 
> Changes from V1:
> 	- Move save/restore functions to ptm.c
> 	- Move pci_add_ext_cap_sve_buffer() to pci_ptm_init in ptm.c
> 	
>  drivers/pci/pci.c      |  2 ++
>  drivers/pci/pci.h      |  8 ++++++++
>  drivers/pci/pcie/ptm.c | 43 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 53 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e578d34095e9..12ba6351c05b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1566,6 +1566,7 @@ int pci_save_state(struct pci_dev *dev)
>  	pci_save_ltr_state(dev);
>  	pci_save_dpc_state(dev);
>  	pci_save_aer_state(dev);
> +	pci_save_ptm_state(dev);
>  	return pci_save_vc_state(dev);
>  }
>  EXPORT_SYMBOL(pci_save_state);
> @@ -1677,6 +1678,7 @@ void pci_restore_state(struct pci_dev *dev)
>  	pci_restore_vc_state(dev);
>  	pci_restore_rebar_state(dev);
>  	pci_restore_dpc_state(dev);
> +	pci_restore_ptm_state(dev);
>  
>  	pci_aer_clear_status(dev);
>  	pci_restore_aer_state(dev);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index f86cae9aa1f4..62cdacba5954 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -516,6 +516,14 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
>  
>  #endif /* CONFIG_PCI_IOV */
>  
> +#ifdef CONFIG_PCIE_PTM
> +void pci_save_ptm_state(struct pci_dev *dev);
> +void pci_restore_ptm_state(struct pci_dev *dev);
> +#else
> +static inline void pci_save_ptm_state(struct pci_dev *dev) {}
> +static inline void pci_restore_ptm_state(struct pci_dev *dev) {}
> +#endif
> +
>  unsigned long pci_cardbus_resource_alignment(struct resource *);
>  
>  static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index 357a454cafa0..6b24a1c9327a 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -29,6 +29,47 @@ static void pci_ptm_info(struct pci_dev *dev)
>  		 dev->ptm_root ? " (root)" : "", clock_desc);
>  }
>  
> +void pci_save_ptm_state(struct pci_dev *dev)
> +{
> +	int ptm;
> +	struct pci_cap_saved_state *save_state;
> +	u16 *cap;
> +
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
> +	if (!ptm)
> +		return;
> +
> +	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
> +	if (!save_state) {
> +		pci_err(dev, "no suspend buffer for PTM\n");
> +		return;
> +	}
> +
> +	cap = (u16 *)&save_state->cap.data[0];
> +	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, cap);
> +}
> +
> +void pci_restore_ptm_state(struct pci_dev *dev)
> +{
> +	struct pci_cap_saved_state *save_state;
> +	int ptm;
> +	u16 *cap;
> +
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
> +	ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
> +	if (!save_state || !ptm)
> +		return;
> +
> +	cap = (u16 *)&save_state->cap.data[0];
> +	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, *cap);
> +}
> +
>  void pci_ptm_init(struct pci_dev *dev)
>  {
>  	int pos;
> @@ -65,6 +106,8 @@ void pci_ptm_init(struct pci_dev *dev)
>  	if (!pos)
>  		return;
>  
> +	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_PTM, sizeof(u16));
> +
>  	pci_read_config_dword(dev, pos + PCI_PTM_CAP, &cap);
>  	local_clock = (cap & PCI_PTM_GRANULARITY_MASK) >> 8;
>  
> -- 
> 2.20.1
> 
