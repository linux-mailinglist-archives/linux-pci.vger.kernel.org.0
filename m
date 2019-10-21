Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8272DEE19
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 15:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfJUNlR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 09:41:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:25753 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729656AbfJUNlR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Oct 2019 09:41:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 06:41:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,323,1566889200"; 
   d="scan'208";a="209446042"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 21 Oct 2019 06:41:12 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 21 Oct 2019 16:41:11 +0300
Date:   Mon, 21 Oct 2019 16:41:11 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de
Subject: Re: [PATCH v3 2/3] PCI: pciehp: Wait for PDS if in-band presence is
 disabled
Message-ID: <20191021134111.GK2819@lahna.fi.intel.com>
References: <20191017193256.3636-1-stuart.w.hayes@gmail.com>
 <20191017193256.3636-3-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017193256.3636-3-stuart.w.hayes@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 17, 2019 at 03:32:55PM -0400, Stuart Hayes wrote:
> From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> 
> When inband presence is disabled, PDS may come up at any time, or not
> at all. PDS being low may indicate that the card is still mating, and
> we could expect contact bounce to bring down the link as well.
> 
> It is reasonable to assume that most cards will mate in a hotplug slot
> in about a second. Thus, when we know PDS only reflects out-of-band
> presence, it's worthwhile to wait the extra second or so to make sure
> the card is properly mated before loading the driver, and to prevent
> the hotplug code from disabling a device if the presence detect change
> goes active after the device is enabled.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

One nit below.

> ---
> v2:
>   replace while(true) loop with do...while
> v3
>   remove unused variable declaration (pds)
>   modify text of warning message
> 
>  drivers/pci/hotplug/pciehp_hpc.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index dc109d521f30..02eb811a014f 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -242,6 +242,22 @@ static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
>  	return found;
>  }
>  
> +static void pcie_wait_for_presence(struct pci_dev *pdev)
> +{
> +	int timeout = 1250;
> +	u16 slot_status;
> +
> +	do {
> +		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
> +		if (!!(slot_status & PCI_EXP_SLTSTA_PDS))

It is more readable if you write it like:

		if (slot_status & PCI_EXP_SLTSTA_PDS)

> +			return;
> +		msleep(10);
> +		timeout -= 10;
> +	} while (timeout > 0);
> +
> +	pci_info(pdev, "Timeout waiting for Presence Detect state to be set\n");
> +}
> +
>  int pciehp_check_link_status(struct controller *ctrl)
>  {
>  	struct pci_dev *pdev = ctrl_dev(ctrl);
> @@ -251,6 +267,9 @@ int pciehp_check_link_status(struct controller *ctrl)
>  	if (!pcie_wait_for_link(pdev, true))
>  		return -1;
>  
> +	if (ctrl->inband_presence_disabled)
> +		pcie_wait_for_presence(pdev);
> +
>  	found = pci_bus_check_dev(ctrl->pcie->port->subordinate,
>  					PCI_DEVFN(0, 0));
>  
> -- 
> 2.18.1
