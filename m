Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5613D8253
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 00:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhG0WMd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jul 2021 18:12:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232544AbhG0WMb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jul 2021 18:12:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F12D660F91;
        Tue, 27 Jul 2021 22:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627423951;
        bh=JmlO7NqEbIM/TL0jd6rOqhVW4sfGZez92xGKe85sQVw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TPppmHPF3T4i72EyZIxEWd5zLWm6L8yy7b8BDO4L8eZEcTIcQyB1ZIPmJve8+oPhI
         CtNiuSvqUUvUQT1dHyx1t0XXpJOoKhXWnLdjigHU6g3zfT2CZ/Khm0mDgyBNZUEm7I
         pCvehKX8lKgxibVBjYIGFgBZWWAQQraxUxZ3nVhuI+7RFdgtcaXPkkr/v5Hx6U85n8
         /K7s3DniClWi5XZt9tAe71MWd5dJrBoUV0BhgPudYb0F7o9KKj1IiMmxF/YDj1qrzF
         /9PiF7WqRVgsL5pscNHSuudaDBwUqCfUJSk2l/pwc1vUVonYTbnUdf6sq6k1blhKIR
         geLZcFXNun/3w==
Date:   Tue, 27 Jul 2021 17:12:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 1/8] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
Message-ID: <20210727221229.GA750669@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709123813.8700-2-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 09, 2021 at 06:08:06PM +0530, Amey Narkhede wrote:
> Add has_pcie_flr bitfield in struct pci_dev to indicate support for PCIe
> FLR to avoid reading PCI_EXP_DEVCAP multiple times.
> 
> Currently there is separate function pcie_has_flr() to probe if PCIe FLR
> is supported by the device which does not match the calling convention
> followed by reset methods which use second function argument to decide
> whether to probe or not. Add new function pcie_reset_flr() that follows
> the calling convention of reset methods.
> 
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
>  drivers/crypto/cavium/nitrox/nitrox_main.c |  4 +-
>  drivers/pci/pci.c                          | 59 +++++++++++-----------
>  drivers/pci/pcie/aer.c                     | 12 ++---
>  drivers/pci/probe.c                        |  6 ++-
>  drivers/pci/quirks.c                       |  9 ++--
>  include/linux/pci.h                        |  3 +-
>  6 files changed, 45 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
> index facc8e6bc..15d6c8452 100644
> --- a/drivers/crypto/cavium/nitrox/nitrox_main.c
> +++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
> @@ -306,9 +306,7 @@ static int nitrox_device_flr(struct pci_dev *pdev)
>  		return -ENOMEM;
>  	}
>  
> -	/* check flr support */
> -	if (pcie_has_flr(pdev))
> -		pcie_flr(pdev);
> +	pcie_reset_flr(pdev, 0);

I'm not really a fan of exposing the "probe" argument outside
drivers/pci/.  I think this would be the only occurrence.  Is there a
way to avoid that?

Can we just make pcie_flr() do the equivalent of pcie_has_flr()
internally?

>  static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
>  {
> -	if (!pcie_has_flr(dev))
> -		return -ENOTTY;
> +	int ret = pcie_reset_flr(dev, probe);
>  
>  	if (probe)
> -		return 0;
> -
> -	pcie_flr(dev);
> +		return ret;
>  
>  	msleep(250);

Can we structure this like the following?  I think it's easier to
understand.

  if (probe)
    return pcie_reset_flr(dev, 1);

  pcie_reset_flr(dev, 0);
  msleep(250);
  return 0;

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c20211e59..d432428fd 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -337,6 +337,7 @@ struct pci_dev {
>  	u8		msi_cap;	/* MSI capability offset */
>  	u8		msix_cap;	/* MSI-X capability offset */
>  	u8		pcie_mpss:3;	/* PCIe Max Payload Size Supported */
> +	u8		has_pcie_flr:1; /* PCIe FLR supported */

Let's add a devcap member instead.  Then we can use it for some
ASPM-related things as well.  We *could* use it to replace pcie_mpss,
since that comes from PCI_EXP_DEVCAP, too, but for now I think it's
easier to just keep it because it's encoded, and some drivers and
quirks use it so it would be a fair amount of work to change that.
Example patch below that could become the first in the series.


diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index aacf575c15cf..5a99061ea53a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4635,8 +4635,7 @@ bool pcie_has_flr(struct pci_dev *dev)
 	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
 		return false;
 
-	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
-	return cap & PCI_EXP_DEVCAP_FLR;
+	return dev->devcap & PCI_EXP_DEVCAP_FLR;
 }
 EXPORT_SYMBOL_GPL(pcie_has_flr);
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 79177ac37880..52ae26bcc68c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1498,8 +1498,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
 	pdev->pcie_cap = pos;
 	pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &reg16);
 	pdev->pcie_flags_reg = reg16;
-	pci_read_config_word(pdev, pos + PCI_EXP_DEVCAP, &reg16);
-	pdev->pcie_mpss = reg16 & PCI_EXP_DEVCAP_PAYLOAD;
+	pci_read_config_dword(pdev, pos + PCI_EXP_DEVCAP, &pdev->devcap);
+	pdev->pcie_mpss = pdev->devcap & PCI_EXP_DEVCAP_PAYLOAD;
 
 	parent = pci_upstream_bridge(pdev);
 	if (!parent)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 540b377ca8f6..294d1c857a57 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -334,6 +334,7 @@ struct pci_dev {
 	struct pci_dev  *rcec;          /* Associated RCEC device */
 #endif
 	u8		pcie_cap;	/* PCIe capability offset */
+	u32		devcap;		/* PCIe Device Capabilities */
 	u8		msi_cap;	/* MSI capability offset */
 	u8		msix_cap;	/* MSI-X capability offset */
 	u8		pcie_mpss:3;	/* PCIe Max Payload Size Supported */
