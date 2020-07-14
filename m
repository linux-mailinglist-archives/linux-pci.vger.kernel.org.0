Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B89E2200DB
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 01:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgGNXIG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 19:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgGNXIG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jul 2020 19:08:06 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35F752065E;
        Tue, 14 Jul 2020 23:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594768085;
        bh=50NGcG7PTBsEuD+JIw7+r+6rrm7C47cIsguIyorgA+U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dCePTbovhLGakx5PakWD/j6cC7xbxIH7Q92dSlIlVISjtA1AQLWQoOY8gtUZ1Nh4P
         ZlfggI5XhMpA+tkobe8q39WcLsvDGxuXP+mqMlhGmr/MC5V7+rqYr2IcrH3+2LX9L1
         NkeBMGsK5iT7cIiPs9sGTrvnqVIQFE6g/5P5borE=
Date:   Tue, 14 Jul 2020 18:08:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        Jay Vosburgh <jay.vosburgh@canonical.com>
Subject: Re: [PATCH v2 1/2] PCI/ERR: Fix fatal error recovery for non-hotplug
 capable devices
Message-ID: <20200714230803.GA92891@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce417fbf81a8a46a89535f44b9224ee9fbb55a29.1591307288.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 04, 2020 at 02:50:01PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Fatal (DPC) error recovery is currently broken for non-hotplug
> capable devices. With current implementation, after successful
> fatal error recovery, non-hotplug capable device state won't be
> restored properly. You can find related issues in following links.
> 
> https://lkml.org/lkml/2020/5/27/290
> https://lore.kernel.org/linux-pci/12115.1588207324@famine/
> https://lkml.org/lkml/2020/3/28/328

Can you please convert these all to lore.kernel.org links?  lkml.org
is not quite as useful or reliable.

> Current fatal error recovery implementation relies on hotplug handler
> for detaching/re-enumerating the affected devices/drivers on DLLSC
> state changes. 

Can you remind us exactly how this relies on hotplug?  I know it
*does*, but I can't remember how.  It would sure be nice if we could
decouple this from pciehp somehow.

> So when dealing with non-hotplug capable devices,
> recovery code does not restore the state of the affected devices
> correctly. Correct implementation should call report_slot_reset()
> function after resetting the link to restore the state of the
> device/driver.

We don't restore the state correctly.  What does this look like to the
user?  Does the device not work?

> So use PCI_ERS_RESULT_NEED_RESET as error status for successful
> reset_link() operation and use PCI_ERS_RESULT_DISCONNECT for failure
> case. PCI_ERS_RESULT_NEED_RESET error state will ensure slot_reset()
> is called after reset link operation which will also fix the above
> mentioned issue.

I think PCI_ERS_RESULT_NEED_RESET results in calling driver
->slot_reset() callbacks, right?  Where does the state restoration
happen?

No, I guess it must be something in the hotplug driver that restores
the state, because you said devices below hotplug-capable ports work
correctly, but others don't.

> [original patch is from jay.vosburgh@canonical.com]
> [original patch link https://lore.kernel.org/linux-pci/12115.1588207324@famine/]
> Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
> Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/pcie/err.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 14bb8f54723e..5fe8561c7185 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -165,8 +165,28 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	pci_dbg(dev, "broadcast error_detected message\n");
>  	if (state == pci_channel_io_frozen) {
>  		pci_walk_bus(bus, report_frozen_detected, &status);
> -		status = reset_link(dev);
> -		if (status != PCI_ERS_RESULT_RECOVERED) {
> +		/*
> +		 * After resetting the link using reset_link() call, the
> +		 * possible value of error status is either
> +		 * PCI_ERS_RESULT_DISCONNECT (failure case) or
> +		 * PCI_ERS_RESULT_NEED_RESET (success case).
> +		 * So ignore the return value of report_error_detected()
> +		 * call for fatal errors. Instead use
> +		 * PCI_ERS_RESULT_NEED_RESET as initial status value.
> +		 *
> +		 * Ignoring the status return value of report_error_detected()
> +		 * call will also help in case of EDR mode based error
> +		 * recovery. In EDR mode AER and DPC Capabilities are owned by
> +		 * firmware and hence report_error_detected() call will possibly
> +		 * return PCI_ERS_RESULT_NO_AER_DRIVER. So if we don't ignore
> +		 * the return value of report_error_detected() then
> +		 * pcie_do_recovery() would report incorrect status after
> +		 * successful recovery. Ignoring PCI_ERS_RESULT_NO_AER_DRIVER
> +		 * in non EDR case should not have any functional impact.

I can't make sense out of the comment.  We already ignore the "status"
from pci_walk_bus(bus, report_frozen_detected, &status).

No idea what to make of the second paragraph.  If we make the commit
log make sense, maybe some summary of that would be useful here.

I think this code is equivalent and makes the patch much clearer:

  status = reset_link(dev);
  if (status == PCI_ERS_RESULT_RECOVERED) {
    status = PCI_ERS_RESULT_NEED_RESET;
  } else {
    status = PCI_ERS_RESULT_DISCONNECT;
    goto failed;
  }

> +		 */
> +		status = PCI_ERS_RESULT_NEED_RESET;
> +		if (reset_link(dev) != PCI_ERS_RESULT_RECOVERED) {
> +			status = PCI_ERS_RESULT_DISCONNECT;
>  			pci_warn(dev, "link reset failed\n");
>  			goto failed;
>  		}
> -- 
> 2.17.1
> 
