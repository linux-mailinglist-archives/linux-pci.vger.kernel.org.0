Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6B91F700D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jun 2020 00:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgFKW1l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jun 2020 18:27:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbgFKW1l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Jun 2020 18:27:41 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69C8E2073E;
        Thu, 11 Jun 2020 22:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591914460;
        bh=GErajIiGc7tpBSW/pcJdxf16+3Swr/6GsOmqMy80LQ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gtLsz5hCNP8h0jSwdDqMas7Z4meIXc5aMlaMJT2uDRS6sWwqNArjUkdkpPFG+Mx8D
         jlS4e+Zo/PZgEWqj+rqzO9G+N/C1ezs+Zd+pdZHXrbINUm96nYsa8MSf6Rlp9T/CNy
         glTPm7rZQL57NhqkrRjrxsOoCRO75KuwKOoQcvAY=
Date:   Thu, 11 Jun 2020 17:27:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     refactormyself@gmail.com
Cc:     bjorn@helgaas.com, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH 7/8] PCI: Convert PCIBIOS_ error codes to non-PCI generic
 error codes
Message-ID: <20200611222739.GA1615487@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609153950.8346-8-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 09, 2020 at 05:39:49PM +0200, refactormyself@gmail.com wrote:
> From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
> 
> pci_disable_pcie_error_reporting() returns PCIBIOS_ error code which were
> passed down the call heirarchy from pcie capability accessors.
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
> index 95d480a52078..53e2ecb64c72 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -365,11 +365,15 @@ EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
>  
>  int pci_disable_pcie_error_reporting(struct pci_dev *dev)
>  {
> +	int rc;
> +
>  	if (pcie_aer_get_firmware_first(dev))
>  		return -EIO;
>  
> -	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
> +	rc = pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
>  					  PCI_EXP_AER_FLAGS);
> +
> +	return rc;

Also missing pcibios_err_to_errno()?

>  }
>  EXPORT_SYMBOL_GPL(pci_disable_pcie_error_reporting);
>  
> -- 
> 2.18.2
> 
