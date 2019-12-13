Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14E2711EC74
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 22:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfLMVEs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 16:04:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:43278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbfLMVEr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Dec 2019 16:04:47 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DC0E24671;
        Fri, 13 Dec 2019 21:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576271086;
        bh=jGaknKI2p6ySPPNrx4LgH2LEzLiiBRKmoA+G6qX4sg8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=V5qO4dpTOr+Y0MyaI985XkHn6hStk1ZCBgjBEmRsdxbCSaizywPoA9ofNJvPpXDL3
         iU+FnCV7XBd01K3zCdRWCQQUwTZP6gEVlzn53URnNZoK8O+vmprUx6SY7dA4dsukj1
         ujR86f/lLDtqi1ixHox4uQRzllvNOoOwnqdrO2M8=
Date:   Fri, 13 Dec 2019 15:04:45 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daniel Drake <drake@endlessm.com>
Cc:     linux-pci@vger.kernel.org, rafael.j.wysocki@intel.com,
        linux@endlessm.com, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, mika.westerberg@linux.intel.com
Subject: Re: [PATCH v2 1/2] PCI: add generic quirk function for increasing
 D3hot delay
Message-ID: <20191213210445.GA199960@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127053836.31624-1-drake@endlessm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 27, 2019 at 01:38:35PM +0800, Daniel Drake wrote:
> Separate the D3 delay increase functionality out of quirk_radeon_pm() into
> its own function so that it can be shared with other quirks, including
> the AMD Ryzen XHCI quirk that will be introduced in a followup commit.
> 
> Tweak the function name and message to indicate more clearly that the
> delay relates to a D3hot-to-D0 transition.
> 
> Signed-off-by: Daniel Drake <drake@endlessm.com>

I applied both of these to pci/misc for v5.6, thanks!

> ---
>  drivers/pci/quirks.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> v2: tweaked function name and message to emphasize D3hot state
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 320255e5e8f89..3b4021e719530 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1871,16 +1871,21 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x2609, quirk_intel_pcie_pm);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x260a, quirk_intel_pcie_pm);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x260b, quirk_intel_pcie_pm);
>  
> +static void quirk_d3hot_delay(struct pci_dev *dev, unsigned int delay)
> +{
> +	if (dev->d3_delay >= delay)
> +		return;
> +
> +	dev->d3_delay = delay;
> +	pci_info(dev, "extending delay after power-on from D3hot to %d msec\n",
> +		 dev->d3_delay);
> +}
> +
>  static void quirk_radeon_pm(struct pci_dev *dev)
>  {
>  	if (dev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
> -	    dev->subsystem_device == 0x00e2) {
> -		if (dev->d3_delay < 20) {
> -			dev->d3_delay = 20;
> -			pci_info(dev, "extending delay after power-on from D3 to %d msec\n",
> -				 dev->d3_delay);
> -		}
> -	}
> +	    dev->subsystem_device == 0x00e2)
> +		quirk_d3hot_delay(dev, 20);
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6741, quirk_radeon_pm);
>  
> -- 
> 2.20.1
> 
