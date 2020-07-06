Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D122215CA5
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jul 2020 19:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgGFRHj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 13:07:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729478AbgGFRHj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jul 2020 13:07:39 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B60621582;
        Mon,  6 Jul 2020 17:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594055258;
        bh=cgNaJHVbncoKaqoIbXTBer9BB2nT8TXGZr+shQ3g/Xs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bTn70ba/xuVwnxBCjc4lESFrm5pgWMuOMTIBxZY74YZ8UuoFBHzJvM0rbGpRChWZP
         /If90R9yPSWmBDE8XSdiC23JSZBjzIoDHXMltHgbv1FswHQbry2CAC1qVeO8AiYWog
         PhOIsaTPF8/VDgpwRsVq2HtQZIguzla6VUrLfzwg=
Date:   Mon, 6 Jul 2020 12:07:36 -0500
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
Subject: Re: [PATCH v2 3/7] PCI/ACS: Enable PCI_ACS_TB for
 untrusted/external-facing devices
Message-ID: <20200706170736.GA125844@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630044943.3425049-4-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 29, 2020 at 09:49:39PM -0700, Rajat Jain wrote:
> When enabling ACS, enable translation blocking for external facing ports
> and untrusted devices.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v2: Commit log change 
> 
>  drivers/pci/pci.c    |  4 ++++
>  drivers/pci/quirks.c | 11 +++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d2ff987585855..79853b52658a2 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3330,6 +3330,10 @@ static void pci_std_enable_acs(struct pci_dev *dev)
>  	/* Upstream Forwarding */
>  	ctrl |= (cap & PCI_ACS_UF);
>  
> +	if (dev->external_facing || dev->untrusted)
> +		/* Translation Blocking */
> +		ctrl |= (cap & PCI_ACS_TB);
> +
>  	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
>  }
>  
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b341628e47527..6294adeac4049 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4934,6 +4934,13 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
>  	}
>  }
>  
> +/*
> + * Currently this quirk does the equivalent of
> + * PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_SV

Nit: Reorder these as in c8de8ed2dcaa ("PCI: Make ACS quirk
implementations more uniform") so they match other similar lists in
the code.

But more to the point: we have a bunch of other quirks for devices
that do not have an ACS capability but *do* provide some ACS-like
features.  Most of them support

  PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF

because that's what we usually want.  But I bet some of them also
actually provide the equivalent of PCI_ACS_TB.

REQ_ACS_FLAGS doesn't include PCI_ACS_TB.  Is there anything we need
to do on the pci_acs_enabled() side to check for PCI_ACS_TB, and
consequently, to update any of the quirks for devices that provide it?

> + *
> + * Currently missing, it also needs to do equivalent of PCI_ACS_TB,
> + * if dev->external_facing || dev->untrusted
> + */
>  static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
>  {
>  	if (!pci_quirk_intel_pch_acs_match(dev))
> @@ -4973,6 +4980,10 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
>  	ctrl |= (cap & PCI_ACS_CR);
>  	ctrl |= (cap & PCI_ACS_UF);
>  
> +	if (dev->external_facing || dev->untrusted)
> +		/* Translation Blocking */
> +		ctrl |= (cap & PCI_ACS_TB);
> +
>  	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
>  
>  	pci_info(dev, "Intel SPT PCH root port ACS workaround enabled\n");
> -- 
> 2.27.0.212.ge8ba1cc988-goog
> 
