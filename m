Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3F51D2244
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 00:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731512AbgEMWox (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 May 2020 18:44:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731497AbgEMWox (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 May 2020 18:44:53 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6F6F204EF;
        Wed, 13 May 2020 22:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589409892;
        bh=SaXEtxehBPXNgHzxv6SxCYt0qjGeXgQurv3G6wTPpAU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jbkIbctTPcxjp+MFlS9oh6QvN2AiF2pz772yweD79fJfp5R4pmoh8sihgRDr31Lav
         IUfFd49RzCmsgnizlgF9BHMgD1CVdlWZ63DRybM2zpY2nqzKreSWGjcvaTuKDI61Gi
         +BsgJBAV2aV7sHg9VFkYnYGeM+cY7IfZIEKAqlao=
Date:   Wed, 13 May 2020 17:44:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     bhelgaas@google.com, jay.vosburgh@canonical.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
Subject: Re: [PATCH v1 1/1] PCI/ERR: Handle fatal error recovery for
 non-hotplug capable devices
Message-ID: <20200513224449.GA347443@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4bbacd3af453285271c8fc733652969e11b84f8.1588821160.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 06, 2020 at 08:32:59PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> If there are non-hotplug capable devices connected to a given
> port, then during the fatal error recovery(triggered by DPC or
> AER), after calling reset_link() function, we cannot rely on
> hotplug handler to detach and re-enumerate the device drivers
> in the affected bus. Instead, we will have to let the error
> recovery handler call report_slot_reset() for all devices in
> the bus to notify about the reset operation. Although this is
> only required for non hot-plug capable devices, doing it for
> hotplug capable devices should not affect the functionality.

Apparently this fixes a bug.  Can you include a link to a problem
report?  The above is a description of a *solution*, but it's hard to
understand without starting with the problem itself.

The above talks about reset_link(), which is only used in the
io_frozen case.  In that case, I think the only thing this patch
changes is that when reset_link() fails, we'll return with
PCI_ERS_RESULT_DISCONNECT instead of whatever reset_link()
returned.

What this patch *does* change is that in the normal_detected case, we
previously never called reset_link() but now we will if an
.error_detected() callback requested it.

> Along with above issue, this fix also applicable to following
> issue.
> 
> Commit 6d2c89441571 ("PCI/ERR: Update error status after
> reset_link()") added support to store status of reset_link()
> call. Although this fixed the error recovery issue observed if
> the initial value of error status is PCI_ERS_RESULT_DISCONNECT
> or PCI_ERS_RESULT_NO_AER_DRIVER, it also discarded the status
> result from report_frozen_detected. This can cause a failure to
> recover if _NEED_RESET is returned by report_frozen_detected and
> report_slot_reset is not invoked.

Sorry, I'm not following this explanation.  IIUC this fixes a bug when
the channel is frozen and .error_detected() returns NEED_RESET.

In that case, the current code does:

  * state == io_frozen
  * .error_detected() returns status == NEED_RESET
  * status = reset_link()
  * if status != RECOVERED, we return status
  * otherwise status == RECOVERED
  * we do not call report_slot_reset()
  * we return RECOVERED

It does seem like we *should* call the .slot_reset() callbacks, but
the only time we return recovery failure is if reset_link() failed.

I can certainly understand if drivers don't recover when we reset
their device but don't call their .slot_reset() callback.  Is that
what this fixes?

After the patch,

  * state == io_frozen
  * .error_detected() returns status == NEED_RESET
  * we set status = NEED_RESET (doesn't change anything in this case)
  * we call reset_link()
  * if reset_link() failed, we return DISCONNECT
  * otherwise continue with status == NEED_RESET
  * we *do* call report_slot_reset()
  * we return whatever .slot_reset() returned

I think the change to call .slot_reset() makes sense, but that's not
at all clear from the commit log.  Am I understanding the behavior
correctly?

> Such an event can be induced for testing purposes by reducing the
> Max_Payload_Size of a PCIe bridge to less than that of a device
> downstream from the bridge, and then initiating I/O through the
> device, resulting in oversize transactions.  In the presence of DPC,
> this results in a containment event and attempted reset and recovery
> via pcie_do_recovery.  After 6d2c89441571 report_slot_reset is not
> invoked, and the device does not recover.

Use "pcie_do_recovery()" and "report_slot_reset()" (including the
parentheses) to follow convention.  Also fix other occurrences above.

> [original patch is from jay.vosburgh@canonical.com]
> [original patch link https://lore.kernel.org/linux-pci/18609.1588812972@famine/]
> Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
> Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/pcie/err.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 14bb8f54723e..db80e1ecb2dc 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -165,13 +165,24 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	pci_dbg(dev, "broadcast error_detected message\n");
>  	if (state == pci_channel_io_frozen) {
>  		pci_walk_bus(bus, report_frozen_detected, &status);
> -		status = reset_link(dev);
> -		if (status != PCI_ERS_RESULT_RECOVERED) {
> +		status = PCI_ERS_RESULT_NEED_RESET;
> +	} else {
> +		pci_walk_bus(bus, report_normal_detected, &status);
> +	}
> +
> +	if (status == PCI_ERS_RESULT_NEED_RESET) {
> +		if (reset_link) {
> +			if (reset_link(dev) != PCI_ERS_RESULT_RECOVERED)
> +				status = PCI_ERS_RESULT_DISCONNECT;
> +		} else {
> +			if (pci_bus_error_reset(dev))
> +				status = PCI_ERS_RESULT_DISCONNECT;

As far as I can tell, there is no caller of pcie_do_recovery() where
reset_link is NULL, so this call of pci_bus_error_reset() looks like
dead code.

We did not previously check whether reset_link was NULL, and this
patch changes nothing that could result in it being NULL.

> +		}
> +
> +		if (status == PCI_ERS_RESULT_DISCONNECT) {
>  			pci_warn(dev, "link reset failed\n");
>  			goto failed;
>  		}
> -	} else {
> -		pci_walk_bus(bus, report_normal_detected, &status);
>  	}
>  
>  	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
> -- 
> 2.17.1
> 
