Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6ABE7CCB
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 00:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfJ1XWz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 19:22:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbfJ1XWz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Oct 2019 19:22:55 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F2BF208C0;
        Mon, 28 Oct 2019 23:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572304973;
        bh=EF3dpHK4pg7pwvoigV06vGz0l4QtJ4OUEpMzNif67vo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=0zJaP2YlmqoKKDO5r+bJo7bwQ/zhEEqsjeamRB0iZnCxE4HHqgU5mrI65bGcwtLgp
         pHQJvjNuT323U7owH7/YFLloIbjqeGU8jpQme6sGjyMWL+ZITWEalGJkeCZVTWGt4I
         ox+KLd72GesflBEVj0KiF7HdQ5iTd+YjVTGenpDE=
Date:   Mon, 28 Oct 2019 18:22:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v9 5/8] PCI/AER: Allow clearing Error Status Register in
 FF mode
Message-ID: <20191028232251.GA205542@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6de212ec82651ca6361e21926497a26c590d037.1570145778.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 03, 2019 at 04:39:01PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> As per PCI firmware specification r3.2 Downstream Port Containment
> Related Enhancements ECN, sec 4.5.1, table 4-6,

That table adds bit 7, "DPC config control" to the _OSC control field
and talks about modifying registers in the DPC capability.

It doesn't say anything about firmware-first or about the OS modifying
registers in the AER capability.  But this patch doesn't do anything
related to DPC or _OSC.

> Error Disconnect
> Recover (EDR) support allows OS to handle error recovery and
> clearing Error Registers even in FF mode. So remove FF mode checks in
> pci_cleanup_aer_uncorrect_error_status(), pci_aer_clear_fatal_status()
> and pci_cleanup_aer_error_status_regs() functions.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Acked-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/pcie/aer.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index b45bc47d04fe..e1509bb900c5 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -383,9 +383,6 @@ int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
>  	if (!pos)
>  		return -EIO;
>  
> -	if (pcie_aer_get_firmware_first(dev))
> -		return -EIO;
> -
>  	/* Clear status bits for ERR_NONFATAL errors only */
>  	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
>  	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
> @@ -406,9 +403,6 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>  	if (!pos)
>  		return;
>  
> -	if (pcie_aer_get_firmware_first(dev))
> -		return;
> -
>  	/* Clear status bits for ERR_FATAL errors only */
>  	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
>  	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);

> @@ -430,9 +424,6 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>  	if (!pos)
>  		return -EIO;
>  
> -	if (pcie_aer_get_firmware_first(dev))
> -		return -EIO;
> -
>  	port_type = pci_pcie_type(dev);
>  	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
>  		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &status);
> @@ -455,7 +446,8 @@ void pci_aer_init(struct pci_dev *dev)
>  	if (dev->aer_cap)
>  		dev->aer_stats = kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
>  
> -	pci_cleanup_aer_error_status_regs(dev);
> +	if (!pcie_aer_get_firmware_first(dev))
> +		pci_cleanup_aer_error_status_regs(dev);

This effectively moves the "if (pcie_aer_get_firmware_first())" check
from pci_cleanup_aer_error_status_regs() into one of the callers.  But
there are two other callers: pci_aer_init() and pci_restore_state().
Do they need the change, or do you want to cleanup the AER error
registers there, but not here?

>  }
>  
>  void pci_aer_exit(struct pci_dev *dev)
> -- 
> 2.21.0
> 
