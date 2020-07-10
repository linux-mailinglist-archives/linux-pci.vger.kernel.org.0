Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD2C21BEAA
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jul 2020 22:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgGJUjL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 16:39:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbgGJUjK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jul 2020 16:39:10 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F3322078B;
        Fri, 10 Jul 2020 20:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594413549;
        bh=CnULaI9ELEBbbUKasyXBx7S1yYTMAfrX6S5PK1vzqPc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gXwmLksh2phrQuh3r16fXH2dSS+qJLkUVFIFOQ7fs+LmrslitdklFssUpLoYz9I8Y
         lUrIIXu5nceiiz6Ng+acnL1PBISNLpHxHzziPuyEXZFF+3BmBvoleu9x8bQfWWOOKM
         aXWIxklG362XQ5JOsbI4ldpWDFcyAHfMCNnrf6sI=
Date:   Fri, 10 Jul 2020 15:39:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        oohall@gmail.com, Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v4 1/4] PCI: Move pci_enable_acs() and its dependencies
 up in pci.c
Message-ID: <20200710203908.GA78277@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707224604.3737893-1-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 07, 2020 at 03:46:01PM -0700, Rajat Jain wrote:
> Move pci_enable_acs() and the functions it depends on, further up in the
> source code to avoid having to forward declare it when we make it static
> in near future (next patch).
> 
> No functional changes intended.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>

Applied patches 1-3 to pci/enumeration for v5.9, thanks!

I held off on patch 4 (enabling PCI_ACS_TB) until we have a little
more conversation on the impact of it.

> ---
> v4: Same as v3
> v3: Initial version of the patch, created per Bjorn's suggestion
> 
>  drivers/pci/pci.c | 254 +++++++++++++++++++++++-----------------------
>  1 file changed, 127 insertions(+), 127 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ce096272f52b1..eec625f0e594e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -777,6 +777,133 @@ int pci_wait_for_pending(struct pci_dev *dev, int pos, u16 mask)
>  	return 0;
>  }
>  
> +static int pci_acs_enable;
> +
> +/**
> + * pci_request_acs - ask for ACS to be enabled if supported
> + */
> +void pci_request_acs(void)
> +{
> +	pci_acs_enable = 1;
> +}
> +
> +static const char *disable_acs_redir_param;
> +
> +/**
> + * pci_disable_acs_redir - disable ACS redirect capabilities
> + * @dev: the PCI device
> + *
> + * For only devices specified in the disable_acs_redir parameter.
> + */
> +static void pci_disable_acs_redir(struct pci_dev *dev)
> +{
> +	int ret = 0;
> +	const char *p;
> +	int pos;
> +	u16 ctrl;
> +
> +	if (!disable_acs_redir_param)
> +		return;
> +
> +	p = disable_acs_redir_param;
> +	while (*p) {
> +		ret = pci_dev_str_match(dev, p, &p);
> +		if (ret < 0) {
> +			pr_info_once("PCI: Can't parse disable_acs_redir parameter: %s\n",
> +				     disable_acs_redir_param);
> +
> +			break;
> +		} else if (ret == 1) {
> +			/* Found a match */
> +			break;
> +		}
> +
> +		if (*p != ';' && *p != ',') {
> +			/* End of param or invalid format */
> +			break;
> +		}
> +		p++;
> +	}
> +
> +	if (ret != 1)
> +		return;
> +
> +	if (!pci_dev_specific_disable_acs_redir(dev))
> +		return;
> +
> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
> +	if (!pos) {
> +		pci_warn(dev, "cannot disable ACS redirect for this hardware as it does not have ACS capabilities\n");
> +		return;
> +	}
> +
> +	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
> +
> +	/* P2P Request & Completion Redirect */
> +	ctrl &= ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC);
> +
> +	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> +
> +	pci_info(dev, "disabled ACS redirect\n");
> +}
> +
> +/**
> + * pci_std_enable_acs - enable ACS on devices using standard ACS capabilities
> + * @dev: the PCI device
> + */
> +static void pci_std_enable_acs(struct pci_dev *dev)
> +{
> +	int pos;
> +	u16 cap;
> +	u16 ctrl;
> +
> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
> +	if (!pos)
> +		return;
> +
> +	pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
> +	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
> +
> +	/* Source Validation */
> +	ctrl |= (cap & PCI_ACS_SV);
> +
> +	/* P2P Request Redirect */
> +	ctrl |= (cap & PCI_ACS_RR);
> +
> +	/* P2P Completion Redirect */
> +	ctrl |= (cap & PCI_ACS_CR);
> +
> +	/* Upstream Forwarding */
> +	ctrl |= (cap & PCI_ACS_UF);
> +
> +	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> +}
> +
> +/**
> + * pci_enable_acs - enable ACS if hardware support it
> + * @dev: the PCI device
> + */
> +void pci_enable_acs(struct pci_dev *dev)
> +{
> +	if (!pci_acs_enable)
> +		goto disable_acs_redir;
> +
> +	if (!pci_dev_specific_enable_acs(dev))
> +		goto disable_acs_redir;
> +
> +	pci_std_enable_acs(dev);
> +
> +disable_acs_redir:
> +	/*
> +	 * Note: pci_disable_acs_redir() must be called even if ACS was not
> +	 * enabled by the kernel because it may have been enabled by
> +	 * platform firmware.  So if we are told to disable it, we should
> +	 * always disable it after setting the kernel's default
> +	 * preferences.
> +	 */
> +	pci_disable_acs_redir(dev);
> +}
> +
>  /**
>   * pci_restore_bars - restore a device's BAR values (e.g. after wake-up)
>   * @dev: PCI device to have its BARs restored
> @@ -3230,133 +3357,6 @@ void pci_configure_ari(struct pci_dev *dev)
>  	}
>  }
>  
> -static int pci_acs_enable;
> -
> -/**
> - * pci_request_acs - ask for ACS to be enabled if supported
> - */
> -void pci_request_acs(void)
> -{
> -	pci_acs_enable = 1;
> -}
> -
> -static const char *disable_acs_redir_param;
> -
> -/**
> - * pci_disable_acs_redir - disable ACS redirect capabilities
> - * @dev: the PCI device
> - *
> - * For only devices specified in the disable_acs_redir parameter.
> - */
> -static void pci_disable_acs_redir(struct pci_dev *dev)
> -{
> -	int ret = 0;
> -	const char *p;
> -	int pos;
> -	u16 ctrl;
> -
> -	if (!disable_acs_redir_param)
> -		return;
> -
> -	p = disable_acs_redir_param;
> -	while (*p) {
> -		ret = pci_dev_str_match(dev, p, &p);
> -		if (ret < 0) {
> -			pr_info_once("PCI: Can't parse disable_acs_redir parameter: %s\n",
> -				     disable_acs_redir_param);
> -
> -			break;
> -		} else if (ret == 1) {
> -			/* Found a match */
> -			break;
> -		}
> -
> -		if (*p != ';' && *p != ',') {
> -			/* End of param or invalid format */
> -			break;
> -		}
> -		p++;
> -	}
> -
> -	if (ret != 1)
> -		return;
> -
> -	if (!pci_dev_specific_disable_acs_redir(dev))
> -		return;
> -
> -	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
> -	if (!pos) {
> -		pci_warn(dev, "cannot disable ACS redirect for this hardware as it does not have ACS capabilities\n");
> -		return;
> -	}
> -
> -	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
> -
> -	/* P2P Request & Completion Redirect */
> -	ctrl &= ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC);
> -
> -	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> -
> -	pci_info(dev, "disabled ACS redirect\n");
> -}
> -
> -/**
> - * pci_std_enable_acs - enable ACS on devices using standard ACS capabilities
> - * @dev: the PCI device
> - */
> -static void pci_std_enable_acs(struct pci_dev *dev)
> -{
> -	int pos;
> -	u16 cap;
> -	u16 ctrl;
> -
> -	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
> -	if (!pos)
> -		return;
> -
> -	pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
> -	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
> -
> -	/* Source Validation */
> -	ctrl |= (cap & PCI_ACS_SV);
> -
> -	/* P2P Request Redirect */
> -	ctrl |= (cap & PCI_ACS_RR);
> -
> -	/* P2P Completion Redirect */
> -	ctrl |= (cap & PCI_ACS_CR);
> -
> -	/* Upstream Forwarding */
> -	ctrl |= (cap & PCI_ACS_UF);
> -
> -	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> -}
> -
> -/**
> - * pci_enable_acs - enable ACS if hardware support it
> - * @dev: the PCI device
> - */
> -void pci_enable_acs(struct pci_dev *dev)
> -{
> -	if (!pci_acs_enable)
> -		goto disable_acs_redir;
> -
> -	if (!pci_dev_specific_enable_acs(dev))
> -		goto disable_acs_redir;
> -
> -	pci_std_enable_acs(dev);
> -
> -disable_acs_redir:
> -	/*
> -	 * Note: pci_disable_acs_redir() must be called even if ACS was not
> -	 * enabled by the kernel because it may have been enabled by
> -	 * platform firmware.  So if we are told to disable it, we should
> -	 * always disable it after setting the kernel's default
> -	 * preferences.
> -	 */
> -	pci_disable_acs_redir(dev);
> -}
> -
>  static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
>  {
>  	int pos;
> -- 
> 2.27.0.212.ge8ba1cc988-goog
> 
