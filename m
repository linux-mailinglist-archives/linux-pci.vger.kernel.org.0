Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96C3EE7CD7
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 00:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfJ1X1f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 19:27:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfJ1X1e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Oct 2019 19:27:34 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E70BF208C0;
        Mon, 28 Oct 2019 23:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572305254;
        bh=bjSV5yV8N18Dq9EKwCo1gotWA9fJzywtcEjkGdWpJOA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nXB7DvZ6vS4pgehWbzRDpiy4VxMcTcMPcUaSmBhBWaMcNr0owOzulO3xp9OZblG5u
         DpHnxeMehkGewYHi4AP/wznDM6vQJc18YNgXturxdXl9aRAREOY4PFCKhaGk/X6YTu
         52vd4z4MZxnhrYt/7G1WnBbi6kFChdewe4jNr1uk=
Date:   Mon, 28 Oct 2019 18:27:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v9 7/8] PCI/DPC: Clear AER registers in EDR mode
Message-ID: <20191028232732.GA206631@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4e51ce547feb6251ee2c64a4141c6dc772717ac.1570145778.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 03, 2019 at 04:39:03PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> As per PCI firmware specification r3.2 Downstream Port Containment
> Related Enhancements ECN, 

Specific reference, please, e.g., the section/table/figure of the PCI
Firmware Spec being modified by the ECN.

> OS is responsible for clearing the AER
> registers in EDR mode. So clear AER registers in dpc_process_error()
> function.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Acked-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/pcie/dpc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index fafc55c00fe0..de2d892bc7c4 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -275,6 +275,10 @@ static void dpc_process_error(struct dpc_dev *dpc)
>  		pci_aer_clear_fatal_status(pdev);
>  	}
>  
> +	/* In EDR mode, OS is responsible for clearing AER registers */
> +	if (dpc->firmware_dpc)

I guess "EDR mode" is effectively the same as "firmware-first mode"?

At least, the only place we set "firmware_dpc = 1" is:

  +       if (pcie_aer_get_firmware_first(pdev))
  +               dpc->firmware_dpc = 1;

If they're the same, why do we need two different names for it?

> +		pci_cleanup_aer_error_status_regs(pdev);
> +
>  	/*
>  	 * Irrespective of whether the DPC event is triggered by
>  	 * ERR_FATAL or ERR_NONFATAL, since the link is already down,
> -- 
> 2.21.0
> 
