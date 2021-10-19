Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C27E43418B
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 00:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhJSWqW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 18:46:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229899AbhJSWqV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 18:46:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3854361154;
        Tue, 19 Oct 2021 22:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634683448;
        bh=/g+wgF+JF3O4Y6H7+V152kAnH9oMhD3tFztz/AZaDXg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=taEdq55I88noCQArDJFBVRb0y+GQm4nLIF+JwfjphkxyTiBMTKaqaVO1LMP9l6ipk
         4xcojsdBrhqBwSlCLOoC0rFkNH5do224KYikvGw/YgXbOOUG/LlgwrLUAOxjU2648E
         FByVYoLxGsqr66Oyr72t+89CrEGLH7+J62Xy8LLgTjjBeQS8te+R29y0rTaJBjOqp5
         CUMVsVLQb8lX/+nf714wjxSPC226yspKH3RO87A9Oj9n/TSyaJKuNbeUez6meaXdTM
         /io3xit3dWXLz/TUpP3Ut6yydOTJ9rHukCFP10z1FZeJqbn5tgrojmQW2aynd9qglr
         lUXhh4/tVJqyw==
Date:   Tue, 19 Oct 2021 17:44:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Naveen Naidu <naveennaidu479@gmail.com>
Cc:     bhelgaas@google.com, tsbogend@alpha.franken.de, ruscur@russell.cc,
        oohall@gmail.com, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 1/6] PCI/AER: Enable COR/UNCOR error reporting in
 set_device_error_reporting()
Message-ID: <20211019224406.GA2414443@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b583172ece1fb1dab3d75c6007ec8c443323158d.1633369560.git.naveennaidu479@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 04, 2021 at 11:29:27PM +0530, Naveen Naidu wrote:
> The (PCIe r5.0, sec 7.6.4.3, Table 7-101) and  (PCIe r5.0, sec 7.8.4.6,
> Table 7-104) 

s/7.6.4.3/7.8.4.3/

Cite it like this:

  Per PCIe r5.0, sec 7.8.4.3 and sec 7.8.4.6, the default values ...

> states that the default values for the Uncorrectable Error
> Mask and Correctable Error Mask should be 0b. But the current code does
> not set the default value of these registers when the PCIe bus loads the
> AER service driver.

The defaults specified here are for hardware designers -- this is what
the registers must contain after power-up or reset.  This section of
the spec isn't telling us what the OS is required to write.

If we want to clear these masks, I think we have to:

  1) Analyze every other place that writes the masks to make sure we
  don't break any of them.  There aren't very many, and most of them
  are in drivers, which would be after the aer_probe() path.  There
  might be a conflict with program_hpx_type2(), though.

  2) Make it dependent on pcie_aer_is_native().  Ownership of the AER
  capability can be retained by the platform, in which case the OS
  shouldn't touch it.

> Enable reporting of all correctable and uncorrectable errors during
> aer_probe()
> 
> Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> ---
>  drivers/pci/pcie/aer.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 9784fdcf3006..88c4ca6098fb 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1212,6 +1212,7 @@ static int set_device_error_reporting(struct pci_dev *dev, void *data)
>  {
>  	bool enable = *((bool *)data);
>  	int type = pci_pcie_type(dev);
> +	int aer = dev->aer_cap;
>  
>  	if ((type == PCI_EXP_TYPE_ROOT_PORT) ||
>  	    (type == PCI_EXP_TYPE_RC_EC) ||
> @@ -1223,8 +1224,18 @@ static int set_device_error_reporting(struct pci_dev *dev, void *data)
>  			pci_disable_pcie_error_reporting(dev);
>  	}
>  
> -	if (enable)
> +	if (enable) {
> +
> +		/* Enable reporting of all uncorrectable errors */
> +		/* Uncorrectable Error Mask - turned on bits disable errors */
> +		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, 0);
> +
> +		/* Enable reporting of all correctable errors */
> +		/* Correctable Error Mask - turned on bits disable errors */
> +		pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, 0);
> +
>  		pcie_set_ecrc_checking(dev);
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 
> _______________________________________________
> Linux-kernel-mentees mailing list
> Linux-kernel-mentees@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees
