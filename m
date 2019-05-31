Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFD193167B
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2019 23:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfEaVQv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 May 2019 17:16:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbfEaVQv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 May 2019 17:16:51 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C017926F38;
        Fri, 31 May 2019 21:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559337410;
        bh=c2pv3UGEvPHler4RZI9AO4XMMtkbISSMYlJ167PAtPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LdBjFu6KfciYCDWWmv+DuahF7VCnvl9Odv8PL7Kuy3LLohhYqw2h1hmvEo7l35v9H
         XbrSSTcz5TCAN5taXh0JwSvcrqspZYxIZgF+qItCAPe3XV9qm8svY7UoKYiwMsEW3v
         sWGFOkmBMAerGoooJXv92W12ZYlUkNmBBVuKNClU=
Date:   Fri, 31 May 2019 16:16:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: PM: Avoid resuming devices in D3hot during system
 suspend
Message-ID: <20190531211648.GB58810@google.com>
References: <4561083.VtDMOnK5Me@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4561083.VtDMOnK5Me@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 31, 2019 at 11:49:30AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The current code resumes devices in D3hot during system suspend if
> the target power state for them is D3cold, but that is not necessary
> in general.  It only is necessary to do that if the platform firmware
> requires the device to be resumed, but that should be covered by
> the platform_pci_need_resume() check anyway, so rework
> pci_dev_keep_suspended() to avoid returning 'false' for devices
> in D3hot which need not be resumed due to platform firmware
> requirements.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/pci/pci.c |   15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/pci/pci.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci.c
> +++ linux-pm/drivers/pci/pci.c
> @@ -2474,10 +2474,19 @@ bool pci_dev_keep_suspended(struct pci_d
>  {
>  	struct device *dev = &pci_dev->dev;
>  	bool wakeup = device_may_wakeup(dev);
> +	pci_power_t target_state;
>  
> -	if (!pm_runtime_suspended(dev)
> -	    || pci_target_state(pci_dev, wakeup) != pci_dev->current_state
> -	    || platform_pci_need_resume(pci_dev))
> +	if (!pm_runtime_suspended(dev) || platform_pci_need_resume(pci_dev))
> +		return false;
> +
> +	target_state = pci_target_state(pci_dev, wakeup);

Nit, add a blank line here.

> +	/*
> +	 * If the earlier platform check has not triggered, D3cold is just power
> +	 * removal on top of D3hot, so no need to resume the device in that
> +	 * case.
> +	 */
> +	if (target_state != pci_dev->current_state &&
> +	    target_state != PCI_D3cold && pci_dev->current_state != PCI_D3hot)
>  		return false;

This is more a comment on the existing code than on this particular
patch, but I find this whole function hard to understand, and I think
one reason is that there are a lot of negative conditions, both in
this function and in its callers.  This "target_state != ... &&
target_state != ...  && current_state != ..." is one example.  Another
is the function name itself.  It might be easier to read as something
like this:

  bool pci_dev_need_resume(...)
  {
    if (!pm_runtime_suspended(...))
      return true;

    if (platform_pci_need_resume(...))
      return true;

    if (target_state != current_state)
      return true;

    ...

Another reason I think it's hard to read is that
"pci_dev_keep_suspended" suggests that this is a pure boolean function
without side-effects, but in fact it also fiddles with the PME state
in some cases.  I don't have any ideas for that part.

Bjorn
