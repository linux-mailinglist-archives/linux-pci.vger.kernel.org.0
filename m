Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E70B282560
	for <lists+linux-pci@lfdr.de>; Sat,  3 Oct 2020 18:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbgJCQoY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Oct 2020 12:44:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgJCQoX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 3 Oct 2020 12:44:23 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6113206DD;
        Sat,  3 Oct 2020 16:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601743463;
        bh=S3sAnQDBNabe+nq9DeDE2jPRh1gT/Xyn37oT63FKG1g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=b62gbR04EigLrKIktqropCmaOLCU5DfeNDHXXDqUww+AWwnsUfUqo8PJiv6mAXcnS
         ikJFfoRMM9yC1gNora4BaDXzLsAOYL349CqhaJuZalRE4RLpBQne4sHjUaQDtonnCR
         KgQE/MX66StK57BQDYedeEuhD5Tno9RntxLVR0Eg=
Date:   Sat, 3 Oct 2020 11:44:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ethan Zhao <haifeng.zhao@intel.com>
Cc:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@linux.intel.com,
        sathyanarayanan.kuppuswamy@intel.com, xerces.zhao@gmail.com
Subject: Re: [PATCH v7 4/5] PCI: only return true when dev io state is really
 changed
Message-ID: <20201003164421.GA2883839@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201003075514.32935-5-haifeng.zhao@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 03, 2020 at 03:55:13AM -0400, Ethan Zhao wrote:
> When uncorrectable error happens, AER driver and DPC driver interrupt
> handlers likely call
> 
>    pcie_do_recovery()
>    ->pci_walk_bus()
>      ->report_frozen_detected()
> 
> with pci_channel_io_frozen the same time.
>    If pci_dev_set_io_state() return true even if the original state is
> pci_channel_io_frozen, that will cause AER or DPC handler re-enter
> the error detecting and recovery procedure one after another.
>    The result is the recovery flow mixed between AER and DPC.
> So simplify the pci_dev_set_io_state() function to only return true
> when dev->error_state is really changed.
> 
> Signed-off-by: Ethan Zhao <haifeng.zhao@intel.com>
> Tested-by: Wen Jin <wen.jin@intel.com>
> Tested-by: Shanshan Zhang <ShanshanX.Zhang@intel.com>
> Reviewed-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> Changnes:
>  v2: revise description and code according to suggestion from Andy.
>  v3: change code to simpler.
>  v4: no change.
>  v5: no change.
>  v6: no change.
>  v7: changed based on Bjorn's code and truth table.
> 
>  drivers/pci/pci.h | 53 ++++++++++++++++++-----------------------------
>  1 file changed, 20 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 455b32187abd..47af1ff2a286 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -354,44 +354,31 @@ struct pci_sriov {
>   *
>   * Must be called with device_lock held.
>   *
> - * Returns true if state has been changed to the requested state.
> + * Returns true if state has been really changed to the requested state.
>   */
>  static inline bool pci_dev_set_io_state(struct pci_dev *dev,
>  					pci_channel_state_t new)
>  {
> -	bool changed = false;
> -
>  	device_lock_assert(&dev->dev);
> -	switch (new) {
> -	case pci_channel_io_perm_failure:
> -		switch (dev->error_state) {
> -		case pci_channel_io_frozen:
> -		case pci_channel_io_normal:
> -		case pci_channel_io_perm_failure:
> -			changed = true;
> -			break;
> -		}
> -		break;
> -	case pci_channel_io_frozen:
> -		switch (dev->error_state) {
> -		case pci_channel_io_frozen:
> -		case pci_channel_io_normal:
> -			changed = true;
> -			break;
> -		}
> -		break;
> -	case pci_channel_io_normal:
> -		switch (dev->error_state) {
> -		case pci_channel_io_frozen:
> -		case pci_channel_io_normal:
> -			changed = true;
> -			break;
> -		}
> -		break;
> -	}
> -	if (changed)
> -		dev->error_state = new;
> -	return changed;
> +
> +/*
> + *			Truth table:
> + *			requested new state
> + *     current          ------------------------------------------
> + *     state            normal         frozen         perm_failure
> + *     ------------  +  -------------  -------------  ------------
> + *     normal        |  normal         frozen         perm_failure
> + *     frozen        |  normal         frozen         perm_failure
> + *     perm_failure  |  perm_failure*  perm_failure*  perm_failure
> + */
> +
> +	if (dev->error_state == pci_channel_io_perm_failure)
> +		return false;
> +	else if (dev->error_state == new)
> +		return false;
> +
> +	dev->error_state = new;
> +	return true;

No, you missed the point.  I want

  1) One patch that converts the "switch" to the shorter "if"
     statements.  This one will be big and ugly, but should not change
     the functionality at all, and it should be pretty easy to verify
     that since there aren't very many states involved.

     Since this one is pure code simplification, the commit log won't
     say anything at all about AER or DPC or their requirements
     because it's not changing any behavior.

  2) A separate patch that's tiny and makes whatever functional change
     you need.

>  }
>  
>  static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
> -- 
> 2.18.4
> 
