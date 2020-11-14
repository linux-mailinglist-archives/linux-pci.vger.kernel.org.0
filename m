Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2552B2E12
	for <lists+linux-pci@lfdr.de>; Sat, 14 Nov 2020 16:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgKNPhV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Nov 2020 10:37:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:49014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgKNPhU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 14 Nov 2020 10:37:20 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63A6F2225E;
        Sat, 14 Nov 2020 15:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605368239;
        bh=0QQjOZf4D4SVwccLj/aJIBnygTFf1R5dUqD3/D9jq0M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=14M7Fah1YRrTNNkq2dUW4ypphcd3dv/uPxQNfQ99a7mcjrzDgiWeWIHAWtMOG6SEy
         YrGwDV0zU2Sl3d+26H0n4SVSHyTVjxsq+kcnafViS5DDW1HafZn00+hu/fGGxpPoO0
         MXZaxI3daAjIkZIQwLM5yeIGAySelZv4y+tA3sk0=
Date:   Sat, 14 Nov 2020 09:37:18 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <sean.v.kelley@intel.com>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        xerces.zhao@gmail.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] AER: aer_root_reset() non-native handling
Message-ID: <20201114153718.GA1170994@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104232244.434115-1-sean.v.kelley@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 04, 2020 at 03:22:44PM -0800, Sean V Kelley wrote:
> If an OS has not been granted AER control via _OSC, then
> the OS should not make changes to PCI_ERR_ROOT_COMMAND and
> PCI_ERR_ROOT_STATUS related registers. Per section 4.5.1 of
> the System Firmware Intermediary (SFI) _OSC and DPC Updates
> ECN [1], this bit also covers these aspects of the PCI
> Express Advanced Error Reporting. Based on the above and
> earlier discussion [2], make the following changes:
> 
> Add a check for the native case (i.e., AER control via _OSC)
> 
> Note that the current "clear, reset, enable" order suggests that the
> reset might cause errors that we should ignore. Lacking historical
> context, these will be retained.
> 
> [1] System Firmware Intermediary (SFI) _OSC and DPC Updates ECN, Feb 24,
>     2020, affecting PCI Firmware Specification, Rev. 3.2
>     https://members.pcisig.com/wg/PCI-SIG/document/14076
> [2] https://lore.kernel.org/linux-pci/20201020162820.GA370938@bjorn-Precision-5520/
> 
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>

What do I do with this patch in combination with "[PATCH v10 00/16]
Add RCEC handling to PCI/AER"?  I tried applying this and the RCEC
series on top, but they conflict.

I was thinking it would be easiest to include this as the first patch
in the series so I wouldn't have to resolve the conflicts, but maybe
you had something else in mind?

> ---
> Changes since V2 :
> 
> Fixed an unfortunate copy/paste error.
> 
> Changes since V1 [1]:
> 
> Noted lack of historical context on isolation of both the
> pci_bus_error_reset() and the clearing of Root Error Status. In fact,
> the call to aer_enable_rootport() likewise disables system error generation
> in response to error messages around the clearing of the error status. So
> retained the wrapping of the  "clear, reset, enable".
> 
> [1] https://lore.kernel.org/linux-pci/20201030223443.165783-1-sean.v.kelley@intel.com/
> 
> Thanks,
> 
> Sean
> ---
>  drivers/pci/pcie/aer.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 65dff5f3457a..4ab379fa1506 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1358,26 +1358,29 @@ static int aer_probe(struct pcie_device *dev)
>  static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>  {
>  	int aer = dev->aer_cap;
> +	int rc = 0;

Unnecessary init, I think.

>  	u32 reg32;
> -	int rc;
> -
> 
> -	/* Disable Root's interrupt in response to error messages */
> -	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> -	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> -	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +	if (pcie_aer_is_native(dev)) {
> +		/* Disable Root's interrupt in response to error messages */
> +		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> +		reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> +		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +	}
> 
>  	rc = pci_bus_error_reset(dev);
> -	pci_info(dev, "Root Port link has been reset\n");
> +	pci_info(dev, "Root Port link has been reset (%d)\n", rc);
> 
> -	/* Clear Root Error Status */
> -	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
> -	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, reg32);
> +	if (pcie_aer_is_native(dev)) {
> +		/* Clear Root Error Status */
> +		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
> +		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, reg32);
> 
> -	/* Enable Root Port's interrupt in response to error messages */
> -	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> -	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> -	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +		/* Enable Root Port's interrupt in response to error messages */
> +		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> +		reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> +		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +	}
> 
>  	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
>  }
> --
> 2.29.2
> 
