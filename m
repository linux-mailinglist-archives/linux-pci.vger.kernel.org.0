Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FE71F700C
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jun 2020 00:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgFKW0e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jun 2020 18:26:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbgFKW0e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Jun 2020 18:26:34 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1706C2073E;
        Thu, 11 Jun 2020 22:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591914394;
        bh=Tvo4L41/ZP0XOQLp/hEw66Wp28IvCE514KgIDjH/IU4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=wg0p5vBVj1LQbnPpLecmRd8RuH5aNgxbvOgnv5Ojg8w88XRlMIaqjyoeAOK4Dhtly
         tBIITetSrjfkfjuckJs+XM09gbAbYvoWya13bxaeMYZdEMEKHZiopbvTXBQ265z9d9
         vNFhEwbxXFMUwYweFAGsxqRucy/fmJXjCg7nyEKg=
Date:   Thu, 11 Jun 2020 17:26:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     refactormyself@gmail.com
Cc:     bjorn@helgaas.com, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH 6/8] PCI: Convert PCIBIOS_ error codes to non-PCI generic
 error codes
Message-ID: <20200611222632.GA1615301@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609153950.8346-7-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 09, 2020 at 05:39:48PM +0200, refactormyself@gmail.com wrote:
> From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
> 
> pci_enable_pcie_error_reporting() return PCIBIOS_ error codes which were
> passed on down the call heirarchy pcie capability accessors.
> 
> PCIBIOS_ error codes have positive values. Passing on these values is
> inconsistent with functions which return only a negative value on failure.
> 
> Before passing on return value of pcie capability accessors, call
> pcibios_err_to_errno() to convert any positive PCIBIOS_ error codes to
> negative non-PCI generic error values.
> 
> Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
> Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
> ---
>  drivers/pci/pcie/aer.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index f4274d301235..95d480a52078 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -349,13 +349,17 @@ bool aer_acpi_firmware_first(void)
>  
>  int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>  {
> +	int rc;
> +
>  	if (pcie_aer_get_firmware_first(dev))
>  		return -EIO;
>  
>  	if (!dev->aer_cap)
>  		return -EIO;
>  
> -	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
> +	rc = pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
> +
> +	return rc;

I think this is missing the pcibios_err_to_errno()?

>  }
>  EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
>  
> -- 
> 2.18.2
> 
