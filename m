Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F313120146C
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jun 2020 18:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391478AbgFSQKL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Jun 2020 12:10:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:61879 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404125AbgFSQKK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Jun 2020 12:10:10 -0400
IronPort-SDR: TKMhlxq6sLTSpi9FX4kfvgLNITpE5/PdVeD9BsRnIYz78t+yJaMW5/SewWfbt1RcU7qqSSLnYN
 W9GP4tfEVi8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9657"; a="142922485"
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="142922485"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 09:10:09 -0700
IronPort-SDR: 7RubQq9VxRUfRzuPMeOWSStaHKgmrTEFu3KNxl6djYfk5OGCi6GIlI27lydbeTOfyd4+aOyEOX
 VW8+JfhjviTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="274323199"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
  by orsmga003.jf.intel.com with ESMTP; 19 Jun 2020 09:10:09 -0700
Date:   Fri, 19 Jun 2020 09:10:09 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, lalithambika.krishnakumar@intel.com,
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
        oohall@gmail.com, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 3/4] pci: acs: Enable PCI_ACS_TB for
 untrusted/external-facing devices
Message-ID: <20200619161009.GH42799@otc-nc-03>
References: <20200616011742.138975-1-rajatja@google.com>
 <20200616011742.138975-3-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616011742.138975-3-rajatja@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rajat


On Mon, Jun 15, 2020 at 06:17:41PM -0700, Rajat Jain wrote:
> When enabling ACS, currently the bit "translation blocking" was
> not getting changed at all. Set it to disable translation blocking

Maybe you meant "enable translation blocking" ?

Keep the commit log simple:

When enabling ACS, enable translation blocking for external facing ports
and untrusted devices.

> too for all external facing or untrusted devices. This is OK
> because ATS is only allowed on internal devces.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
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
> 2.27.0.290.gba653c62da-goog
> 
