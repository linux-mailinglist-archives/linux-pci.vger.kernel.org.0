Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 851951030BC
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 01:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfKTA2j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 19:28:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:58870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbfKTA2j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Nov 2019 19:28:39 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BC5D2084D;
        Wed, 20 Nov 2019 00:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574209718;
        bh=uyR59o43ciPihfOLlm+jFPkrRvHx0fqxk7WTiYtlnDs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VpkH0n93WocNeWy7Qne8PFIEzNfDs+LpLjg+8Bpjr4yUaDrVmOTFp8NbjfwAS69wo
         q81uTL7vivWwT+mJcavxetuQ/6VdbA3GijeYuxs0cOP9WqBSvcU48RG6oyfiFgfFZ+
         764DrcmjHMSWcQTVVryyvLYHL5eKZr16NEzskBX0=
Date:   Tue, 19 Nov 2019 18:28:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daniel Drake <drake@endlessm.com>
Cc:     linux-pci@vger.kernel.org, rafael.j.wysocki@intel.com,
        linux@endlessm.com, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] PCI: increase D3 delay for AMD Ryzen5/7 XHCI controllers
Message-ID: <20191120002836.GA247344@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014061355.29072-1-drake@endlessm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 14, 2019 at 02:13:55PM +0800, Daniel Drake wrote:
> On Asus laptops with AMD Ryzen7 3700U and AMD Ryzen5 3500U,

Can you include specific models here in case we revisit this or find a
generic solution that needs to be tested to make sure we don't regress
these platforms?

Maybe a bugzilla with complete "lspci -vvnn" and dmesg logs?

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

IIUC, we're doing a D3cold-to-D0 transition in this path:

  pci_pm_default_resume_early
    pci_power_up
      platform_pci_set_power_state(PCI_D0)    # turn on via ACPI
      pci_raw_set_power_state(PCI_D0)
        pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr)
        # pmcsr says device is in D3hot
        pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr)
        # sets to D0
        pci_dev_d3_sleep                      # <-- need more time here

I would sort of expect that ACPI would be putting the device in D0,
not leaving it in D3hot, but maybe that's just my ignorance.

In any case, I think you need more time after writing PCI_PM_CTRL to
transition from D3hot to D0.  Right?

> Link: http://lkml.kernel.org/r/CAD8Lp47Vh69gQjROYG69=waJgL7hs1PwnLonL9+27S_TcRhixA@mail.gmail.com
> Signed-off-by: Daniel Drake <drake@endlessm.com>
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

This delay is for a D3hot -> D0 transition, right?  Can you make the
message say "D3hot" explicitly?  And maybe include "d3hot" in the
function name as well?

> +}

This is a nice bit of refactoring; could you split it into a separate
patch that only does the refactor, followed by another that adds the
Ryzen quirk?

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
