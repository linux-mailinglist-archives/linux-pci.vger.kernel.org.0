Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54ADE2CF398
	for <lists+linux-pci@lfdr.de>; Fri,  4 Dec 2020 19:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgLDSG6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Dec 2020 13:06:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:43268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgLDSG6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Dec 2020 13:06:58 -0500
Date:   Fri, 4 Dec 2020 12:06:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607105177;
        bh=QS9EvxgSDBt+zlI3phsUbCb83smeF/LJi7Hz73NfY3w=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=jgIvb+yMl+m3ZUbHiYmVYtzLrr5JDIZ4aAcm2tcVepvnPNd0ycUoUTRjFCRhTwUWm
         Qvl1lmBR37/xl2q8wccWlBK5nTEpYY3PTbs2kDlLauoje6jm8WZ85pz3DRpmR3j96n
         /O5MK21ABp4Fsv2FiWLVEAH2sG7/s6wWLXD9GPnJ0CCOP6sfy1/a5wGnnzcRQXEeWT
         sSDHDKDsczcFK6I6FtBXHWWRHZhHHki6I5kyLC04a32hL2VtVUGKh28H3chrbqySDa
         7ig4JmkkKffuLlt8YUMTt2dZa1/gQPub7bxzQSzHhNIlsHVWUwjnC4pEBJyIvgt+RL
         WEDKPheyH+m5g==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     bhelgaas@google.com, ruscur@russell.cc, linux-pci@vger.kernel.org
Subject: Re: [RFC] pci: aer: Disable corrected error reporting by default
Message-ID: <20201204180615.GA1754610@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607102932-10384-1-git-send-email-loic.poulain@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 04, 2020 at 06:28:52PM +0100, Loic Poulain wrote:
> It appears to be very common that people complain about kernel log
> (and irq) flooding because of reported corrected errors by AER.

Do you have any pointers to these handy?

I'm pretty sure there's an issue in our AER handling where we don't
clear the error correctly, so we keep complaining about the same error
again and again.

My preferences for how to handle this situation:

  1) Fix our AER handling (if it's indeed broken; I could be wrong)
  2) Automatically rate-limit corrected error reporting
  3) As a last resort, some parameter like this patch

Reports like https://bugzilla.kernel.org/show_bug.cgi?id=111601
have been around for an embarrassingly long time, but I guess nobody
has had time to really dig into them.

My theory about our AER problem is here:
https://lore.kernel.org/linux-pci/20160215171423.GA12641@localhost/

> An usual reply/solution is to completely disable aer with 'noaer' pci
> parameter. This is a big hammer tip since it also prevents reporting of
> 'real' non corrected PCI errors, that need to be handled by the kernel.
> 
> A PCI correctable error is an error corrected at hardware level by the
> PCI protocol (e.g. with retry mechanism), the OS can then totally live
> without being notified about that hardware event.
> 
> A simple change would then consist in not enabling correctable error
> reporting at all, but it can remain useful in some cases, such as for
> determining health of the PCI link.
> 
> This patch changes the default AER mask to not enable correctable error
> reporting by default, and introduce a new pci parameter, 'aerfull' that
> can be used to re-enable all error reports, including correctable ones.
> 
> Note: Alternatively, if changing the legacy behavior is not desirable,
> that can be done the other way, with a 'noaer_correctable' parameter to
> only disable correctable error reporting.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
>  drivers/pci/pci.c      |  2 ++
>  drivers/pci/pci.h      |  2 ++
>  drivers/pci/pcie/aer.c | 12 +++++++++++-
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 6d4d5a2..c67ec709 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6498,6 +6498,8 @@ static int __init pci_setup(char *str)
>  				pcie_ats_disabled = true;
>  			} else if (!strcmp(str, "noaer")) {
>  				pci_no_aer();
> +			} else if (!strcmp(str, "aerfull")) {
> +				pci_aer_full();
>  			} else if (!strcmp(str, "earlydump")) {
>  				pci_early_dump = true;
>  			} else if (!strncmp(str, "realloc=", 8)) {
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index f86cae9..36306a1 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -662,6 +662,7 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
>  
>  #ifdef CONFIG_PCIEAER
>  void pci_no_aer(void);
> +void pci_aer_full(void);
>  void pci_aer_init(struct pci_dev *dev);
>  void pci_aer_exit(struct pci_dev *dev);
>  extern const struct attribute_group aer_stats_attr_group;
> @@ -670,6 +671,7 @@ int pci_aer_clear_status(struct pci_dev *dev);
>  int pci_aer_raw_clear_status(struct pci_dev *dev);
>  #else
>  static inline void pci_no_aer(void) { }
> +static inline void pci_aer_full(void) { }
>  static inline void pci_aer_init(struct pci_dev *d) { }
>  static inline void pci_aer_exit(struct pci_dev *d) { }
>  static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 65dff5f..e0ec7047 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -102,6 +102,7 @@ struct aer_stats {
>  #define ERR_UNCOR_ID(d)			(d >> 16)
>  
>  static int pcie_aer_disable;
> +static int pcie_aer_full;
>  static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
>  
>  void pci_no_aer(void)
> @@ -109,6 +110,11 @@ void pci_no_aer(void)
>  	pcie_aer_disable = 1;
>  }
>  
> +void pci_aer_full(void)
> +{
> +	pcie_aer_full = 1;
> +}
> +
>  bool pci_aer_available(void)
>  {
>  	return !pcie_aer_disable && pci_msi_enabled();
> @@ -224,12 +230,16 @@ int pcie_aer_is_native(struct pci_dev *dev)
>  
>  int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>  {
> +	u16 flags = PCI_EXP_AER_FLAGS;
>  	int rc;
>  
>  	if (!pcie_aer_is_native(dev))
>  		return -EIO;
>  
> -	rc = pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
> +	if (!pcie_aer_full)
> +		flags &= ~PCI_EXP_DEVCTL_CERE;
> +
> +	rc = pcie_capability_set_word(dev, PCI_EXP_DEVCTL, flags);
>  	return pcibios_err_to_errno(rc);
>  }
>  EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
> -- 
> 2.7.4
> 
