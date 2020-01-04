Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84D0312FF9F
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2020 01:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgADAe4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jan 2020 19:34:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:57752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgADAe4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Jan 2020 19:34:56 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9787221835;
        Sat,  4 Jan 2020 00:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578098095;
        bh=P592d/rNMY7Mi1PfCbmAq0WHzzd3CjVYhCxS5q2g+m0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MJBUTR5BoDpLk4EMA7bTw1yqok6Q9XS0Ssy/qLX36TxfRi15d1HIZPHyfcTOBNAB+
         /WrSA1lepLXKsXAExKYRynZvP9FnmuqDX4Th4hD41RgH4Pg3segZ8qbn2T3U5V9TQL
         VbN3G4WhWSg1Xli+deLz4kJ+mf7isfBDZ7PYHASw=
Date:   Fri, 3 Jan 2020 18:34:52 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v11 1/8] PCI/ERR: Update error status after reset_link()
Message-ID: <20200104003452.GA63827@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2e57496135fcfc1dab8d201cb49f5717e7459a4.1577400653.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 26, 2019 at 04:39:07PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Commit bdb5ac85777d ("PCI/ERR: Handle fatal error recovery") uses
> reset_link() to recover from fatal errors. But, if the reset is
> successful there is no need to continue the rest of the error recovery
> checks. Also, during fatal error recovery, if the initial value of error
> status is PCI_ERS_RESULT_DISCONNECT or PCI_ERS_RESULT_NO_AER_DRIVER then
> even after successful recovery (using reset_link()) pcie_do_recovery()
> will report the recovery result as failure. So update the status of
> error after reset_link().

I like the part about updating "status" with the result of
reset_link(), and I split that into its own patch because it
seems like a fix that *can* be separated.

But I'm not convinced that we should skip the ->slot_reset()
callbacks if the reset_link() was successful.  According to
Documentation/PCI/pci-error-recovery.rst, we should call
->slot_reset() after completion of the reset.

For example, rsxx_err_handler implements ->slot_reset(), but
not ->resume().  If we reset the device, we'll claim success and
return, but we won't call rsxx_slot_reset(), which does a bunch
of important-looking recovery stuff.

If pci-error-recovery.rst is wrong, we should fix that (after
auditing all the drivers to make sure they match).

> Fixes: bdb5ac85777d ("PCI/ERR: Handle fatal error recovery")
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Acked-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/pcie/err.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index b0e6048a9208..53cd9200ec2c 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -204,9 +204,12 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
>  	else
>  		pci_walk_bus(bus, report_normal_detected, &status);
>  
> -	if (state == pci_channel_io_frozen &&
> -	    reset_link(dev, service) != PCI_ERS_RESULT_RECOVERED)
> -		goto failed;
> +	if (state == pci_channel_io_frozen) {
> +		status = reset_link(dev, service);
> +		if (status != PCI_ERS_RESULT_RECOVERED)
> +			goto failed;
> +		goto done;
> +	}
>  
>  	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>  		status = PCI_ERS_RESULT_RECOVERED;
> @@ -228,6 +231,7 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
>  	if (status != PCI_ERS_RESULT_RECOVERED)
>  		goto failed;
>  
> +done:
>  	pci_dbg(dev, "broadcast resume message\n");
>  	pci_walk_bus(bus, report_resume, &status);
>  
> -- 
> 2.21.0
> 
