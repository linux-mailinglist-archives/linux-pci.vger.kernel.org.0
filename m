Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259991F7009
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jun 2020 00:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgFKWYw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jun 2020 18:24:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgFKWYv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Jun 2020 18:24:51 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C18BD2073E;
        Thu, 11 Jun 2020 22:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591914291;
        bh=FXwAkJHyJUC/gD6pHztvs+RKg3TT97/Vah4I3/Oie7g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OA/si6y9oT3hO42mD7/5rNB+kLrr+ANiFswyR0HXGNtqpZ763owayuV7yL62SV1eV
         GVML72YpHST0jg9gIOvmzUTFXNdPsL106RXuuREQtjUacA31nJz21p24Uw8uhKuvlk
         Y43gueT1EZP5Ec5PP58L1hjX2MY/EEWvDyCbxnf0=
Date:   Thu, 11 Jun 2020 17:24:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     refactormyself@gmail.com
Cc:     bjorn@helgaas.com, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH 3/8] PCI: Convert PCIBIOS_ error codes to non-PCI generic
 error codes
Message-ID: <20200611222449.GA1614818@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609153950.8346-4-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 09, 2020 at 05:39:45PM +0200, refactormyself@gmail.com wrote:
> From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
> 
> restore_pci_variables() and save_pci_variables() return PCIBIOS_ error
> codes from pcie capability accessors.
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
>  drivers/infiniband/hw/hfi1/pcie.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
> index eb53781d0c6a..eb2790e9db36 100644
> --- a/drivers/infiniband/hw/hfi1/pcie.c
> +++ b/drivers/infiniband/hw/hfi1/pcie.c
> @@ -334,7 +334,11 @@ int pcie_speeds(struct hfi1_devdata *dd)
>  	return 0;
>  }
>  
> -/* restore command and BARs after a reset has wiped them out */
> +/**
> + * restore command and BARs after a reset has wiped them out
> + *
> + * Returns 0 on success, otherwise a negative error value
> + */
>  int restore_pci_variables(struct hfi1_devdata *dd)
>  {
>  	int ret = 0;

These initializations are obviously superfluous.  Generally
I wouldn't encourage mixing fixes into a single patch, but
removing the initialization and adding pcibios_err_to_errno()
are both so trivial that I think it would be OK here.

Also, I didn't notice before, but these driver patches need to be cc'd
to the driver maintainers.  In this case, get_maintainers.pl says:

  Mike Marciniszyn <mike.marciniszyn@intel.com> (supporter:HFI1 DRIVER)
  Dennis Dalessandro <dennis.dalessandro@intel.com> (supporter:HFI1 DRIVER)
  Doug Ledford <dledford@redhat.com> (supporter:INFINIBAND SUBSYSTEM)
  Jason Gunthorpe <jgg@ziepe.ca> (supporter:INFINIBAND SUBSYSTEM)
  linux-rdma@vger.kernel.org (open list:HFI1 DRIVER)
  linux-kernel@vger.kernel.org (open list)

I would also cc *all* the driver maintainers for all the patches on
the cover letter and add a note about how we might merge these.
They're all independent, so they *could* go individually via the
separate driver trees, but I think it might make sense to merge them
all together via the PCI tree just so the collection of similar fixes
is merged all at once.

> @@ -386,10 +390,14 @@ int restore_pci_variables(struct hfi1_devdata *dd)
>  
>  error:
>  	dd_dev_err(dd, "Unable to write to PCI config\n");
> -	return ret;
> +	return pcibios_err_to_errno(ret);
>  }
>  
> -/* Save BARs and command to rewrite after device reset */
> +/**
> + * Save BARs and command to rewrite after device reset
> + *
> + * Returns 0 on success, otherwise a negative error value
> + */
>  int save_pci_variables(struct hfi1_devdata *dd)
>  {
>  	int ret = 0;
> @@ -441,7 +449,7 @@ int save_pci_variables(struct hfi1_devdata *dd)
>  
>  error:
>  	dd_dev_err(dd, "Unable to read from PCI config\n");
> -	return ret;
> +	return pcibios_err_to_errno(ret);
>  }
>  
>  /*
> -- 
> 2.18.2
> 
