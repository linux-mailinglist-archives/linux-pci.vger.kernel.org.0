Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6901BD6654
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2019 17:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbfJNPnZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Oct 2019 11:43:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731441AbfJNPnZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Oct 2019 11:43:25 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCE0921848;
        Mon, 14 Oct 2019 15:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571067804;
        bh=ogA0vV9jKYkujrE+XcGevuyHNLI9AnE4kf2je8GMmOo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WQgZ8mYT63jkCOewpVr2XBTJgsYL8Un/tkLweTDniCh3HCsx3KaVEYOvxfOj3Wll5
         APp05yihO1GEw4gLAfZIjFgx2Pe2IM/kHVizYZRuyFJvmml0On7oQDhHM8iY+oAklI
         qgKsJrBiJ2iTTYaHi6EJVEgbaJ3OYcTRN/QlRvgM=
Date:   Mon, 14 Oct 2019 10:43:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daniel Drake <drake@endlessm.com>
Cc:     linux-pci@vger.kernel.org, rafael.j.wysocki@intel.com,
        linux@endlessm.com, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI: increase D3 delay for AMD Ryzen5/7 XHCI controllers
Message-ID: <20191014154322.GA190693@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014061355.29072-1-drake@endlessm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Mika]

On Mon, Oct 14, 2019 at 02:13:55PM +0800, Daniel Drake wrote:
> On Asus laptops with AMD Ryzen7 3700U and AMD Ryzen5 3500U,
> the XHCI controller fails to resume from runtime suspend or s2idle,
> and USB becomes unusable from that point.
> 
> xhci_hcd 0000:03:00.4: Refused to change power state, currently in D3
> xhci_hcd 0000:03:00.4: enabling device (0000 -> 0002)
> xhci_hcd 0000:03:00.4: WARN: xHC restore state timeout
> xhci_hcd 0000:03:00.4: PCI post-resume error -110!
> xhci_hcd 0000:03:00.4: HC died; cleaning up
> 
> The D3-to-D0 transition is successful if the D3 delay is increased
> to 20ms. Add an appropriate quirk for the affected hardware.
> 
> Link: http://lkml.kernel.org/r/CAD8Lp47Vh69gQjROYG69=waJgL7hs1PwnLonL9+27S_TcRhixA@mail.gmail.com
> Signed-off-by: Daniel Drake <drake@endlessm.com>

Can you tell if this is because the Ryzen7 XHCI controller is out of
spec, or is the Linux PCI core missing some delay?  If the latter,
fixing the core might fix other devices as well.

Mika has this patch:
https://lore.kernel.org/r/20190821124519.71594-1-mika.westerberg@linux.intel.com
for similar issues, but I think that patch fixes D3cold->D0
transitions, and your patch appears to be concerned with D3hot->D0
transitions.

> ---
>  drivers/pci/quirks.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 320255e5e8f8..4570439a6a6c 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1871,19 +1871,35 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x2609, quirk_intel_pcie_pm);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x260a, quirk_intel_pcie_pm);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x260b, quirk_intel_pcie_pm);
>  
> +static void quirk_d3_delay(struct pci_dev *dev, unsigned int delay)
> +{
> +	if (dev->d3_delay >= delay)
> +		return;
> +
> +	dev->d3_delay = delay;
> +	pci_info(dev, "extending delay after power-on from D3 to %d msec\n",
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
> +		quirk_d3_delay(dev, 20);
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6741, quirk_radeon_pm);
>  
> +/*
> + * Ryzen7 XHCI controllers fail upon resume from runtime suspend or s2idle
> + * unless an extended D3 delay is used.
> + */
> +static void quirk_ryzen_xhci_d3(struct pci_dev *dev)
> +{
> +	quirk_d3_delay(dev, 20);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e0, quirk_ryzen_xhci_d3);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e1, quirk_ryzen_xhci_d3);
> +
>  #ifdef CONFIG_X86_IO_APIC
>  static int dmi_disable_ioapicreroute(const struct dmi_system_id *d)
>  {
> -- 
> 2.20.1
> 
