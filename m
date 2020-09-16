Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95C126CE48
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 00:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgIPWFc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 18:05:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgIPWFb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Sep 2020 18:05:31 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBF7A21941;
        Wed, 16 Sep 2020 21:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600292797;
        bh=8YExeebFYjGD6iWEtSRHpDG9C6se09q+jMParqrrJs0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FGlZ2APPc29PMaSjdWXxmhHR6wy7u+vpeNqYZVstAkzzvUGDCctx58RLy1mBGrjHV
         Xeqmdo6DTNYOrM1j7nIe0dcmh+hibme00WoKWuuwGBBP+E90PpyVBZyxf5FUxSk2cI
         fNWWIK2oCJdaIGnM8r/hxCC3max/XJjpg7/ieWJo=
Date:   Wed, 16 Sep 2020 16:46:35 -0500
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
Subject: Re: [PATCH v4 4/4] PCI/ACS: Enable PCI_ACS_TB for
 untrusted/external-facing devices
Message-ID: <20200916214635.GA1586835@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707224604.3737893-4-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 07, 2020 at 03:46:04PM -0700, Rajat Jain wrote:
> When enabling ACS, enable translation blocking for external facing ports
> and untrusted devices.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>

Applied (slightly modified) to pci/acs for v5.10, thanks!

I think the warning is superfluous because every external_facing
device is a Root Port or Switch Downstream Port, and if those support
ACS at all, they are required to support Translation Blocking.  So we
should only see the warning if the device is defective, and I don't
think we need to go out of our way to look for those.

> ---
> v4: Add braces to avoid warning from kernel robot
>     print warning for only external-facing devices.
> v3: print warning if ACS_TB not supported on external-facing/untrusted ports.
>     Minor code comments fixes.
> v2: Commit log change
> 
>  drivers/pci/pci.c    |  8 ++++++++
>  drivers/pci/quirks.c | 15 +++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 73a8627822140..a5a6bea7af7ce 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -876,6 +876,14 @@ static void pci_std_enable_acs(struct pci_dev *dev)
>  	/* Upstream Forwarding */
>  	ctrl |= (cap & PCI_ACS_UF);
>  
> +	/* Enable Translation Blocking for external devices */
> +	if (dev->external_facing || dev->untrusted) {
> +		if (cap & PCI_ACS_TB)
> +			ctrl |= PCI_ACS_TB;
> +		else if (dev->external_facing)
> +			pci_warn(dev, "ACS: No Translation Blocking on external-facing dev\n");
> +	}
> +
>  	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
>  }
>  
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b341628e47527..bb22b46c1d719 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4934,6 +4934,13 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
>  	}
>  }
>  
> +/*
> + * Currently this quirk does the equivalent of
> + * PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF
> + *
> + * TODO: This quirk also needs to do equivalent of PCI_ACS_TB,
> + * if dev->external_facing || dev->untrusted
> + */
>  static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
>  {
>  	if (!pci_quirk_intel_pch_acs_match(dev))
> @@ -4973,6 +4980,14 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
>  	ctrl |= (cap & PCI_ACS_CR);
>  	ctrl |= (cap & PCI_ACS_UF);
>  
> +	/* Enable Translation Blocking for external devices */
> +	if (dev->external_facing || dev->untrusted) {
> +		if (cap & PCI_ACS_TB)
> +			ctrl |= PCI_ACS_TB;
> +		else if (dev->external_facing)
> +			pci_warn(dev, "ACS: No Translation Blocking on external-facing dev\n");
> +	}
> +
>  	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
>  
>  	pci_info(dev, "Intel SPT PCH root port ACS workaround enabled\n");
> -- 
> 2.27.0.212.ge8ba1cc988-goog
> 
