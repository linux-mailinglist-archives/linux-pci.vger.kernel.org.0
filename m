Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED27B36FF16
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 19:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhD3RCm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 13:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231150AbhD3RCm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Apr 2021 13:02:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F394F613D9;
        Fri, 30 Apr 2021 17:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619802113;
        bh=CJZScALS9cnd+GBYjBOkKMx4s0KKYFVf2f3/B/tAj7k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mUA0u5f4u4cvG3Yb23XgtGYv4+mGVrXjlY8dinVe9xz+vGpui6NwcOKloR1UdmG2u
         MYs/qHUtdcSQyfqtEqROjFmBmjzZx06nUNLJ457Htz4tmn1CjreaQ0QTkWCzg+2vFO
         Y0zyREmuI+q5C0MSuUBiN6Goprjmc0T1XZ9zXwoc6MhGKuCoouVhHg7E0uzauisZzF
         q2gL63RYq1xJNWW8+S4eLV/unomdUNCBwFAKbP/SkBiVOsO69mJs5ZAFnEVYNp5DDK
         Rc762pGC0ACXRsfy9TG90m0wSLcr+cPqrn1dPtceNRrPfApG+tPd/hTBmmol6MmWnN
         wN0IQTLcXPPOw==
Date:   Fri, 30 Apr 2021 12:01:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shanker Donthineni <sdonthineni@nvidia.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: Re: [PATCH v4 2/2] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
Message-ID: <20210430170151.GA660969@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429004907.29044-2-sdonthineni@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 28, 2021 at 07:49:07PM -0500, Shanker Donthineni wrote:
> On select platforms, some Nvidia GPU devices do not work with SBR.
> Triggering SBR would leave the device inoperable for the current
> system boot. It requires a system hard-reboot to get the GPU device
> back to normal operating condition post-SBR. For the affected
> devices, enable NO_BUS_RESET quirk to fix the issue.

Since 1/2 adds _RST support, should I infer that _RST works on these
Nvidia GPUs even though SBR does not?  If so, how does _RST do the
reset?

Do you have a root cause for why SBR doesn't work?  I'm not super
confident that we perform resets correctly in general, and if the
problem is an issue in Linux, it'd be nice to fix that.

> This issue will be fixed in the next generation of hardware.
> 
> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
> ---
> Changes since v1:
>  - Split patch into 2, code for handling _RST and SBR specific quirk
>  - The RST based reset is called as a first-class mechanism in the reset code path
> 
>  drivers/pci/quirks.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 8f47d139c381..e1216a8165df 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3910,6 +3910,18 @@ static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
>  	return 0;
>  }
>  
> +/*
> + * Some Nvidia GPU devices do not work with bus reset, SBR needs to be
> + * prevented for those affected devices.
> + */
> +static void quirk_nvidia_no_bus_reset(struct pci_dev *dev)
> +{
> +	if ((dev->device & 0xffc0) == 0x2340)
> +		dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> +			 quirk_nvidia_no_bus_reset);

Can you move this next to the existing quirk_no_bus_reset(), and maybe
even just call quirk_no_bus_reset(), e.g.,

  if ((dev->device & 0xffc0) == 0x2340)
    quirk_no_bus_reset(dev);

It doesn't look connected to this spot.

>  static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
>  		 reset_intel_82599_sfp_virtfn },
> -- 
> 2.17.1
> 
