Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0BA5170057
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2020 14:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgBZNnO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Feb 2020 08:43:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:52072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgBZNnO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Feb 2020 08:43:14 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A9A72467B;
        Wed, 26 Feb 2020 13:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582724593;
        bh=C1ahJ+LU3a0ufsaDJOBZ7o3+pztpaXNfmz35HXOccso=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YcN6KksGPKD+OU0aCzAV5SEj5tbfCqL19pix3qAs4T2ULS5uTqJAZQwwBgok/xg6w
         4odez8/0c5iLP9gEVTeOjFIR2KS1nZv+xAhXnK6VpLyzV1zMgYXa0Y3FgyWQKnU3Xs
         YjkSP1LP8I9ffUBcqFmkDNi/Vz++90BALVcjUFm8=
Date:   Wed, 26 Feb 2020 07:43:11 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
Subject: Re: [PATCH v15 2/5] PCI/DPC: Remove pcie_device reference from
 dpc_dev structure
Message-ID: <20200226134311.GA109052@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48cc718aef4c4612b0896bd4a270c6c1f0c0f1a7.1581617873.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 13, 2020 at 10:20:14AM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Currently the only use of pcie_device member in dpc_dev structure is to
> get the associated pci_dev reference. Since none of the users of
> dpc_dev need reference to pcie_device, just remove it and replace it
> with associated pci_dev pointer reference.
> 
> Removing pcie_device reference will help if we have need to call DPC
> driver functions outside PCIe port drivers.

I like this a lot, thanks for doing this.

> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/pcie/dpc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index e06f42f58d3d..99fca8400956 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -18,7 +18,7 @@
>  #include "../pci.h"
>  
>  struct dpc_dev {
> -	struct pcie_device	*dev;
> +	struct pci_dev		*pdev;
>  	u16			cap_pos;
>  	bool			rp_extensions;
>  	u8			rp_log_size;
> @@ -101,7 +101,7 @@ void pci_restore_dpc_state(struct pci_dev *dev)
>  static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
>  {
>  	unsigned long timeout = jiffies + HZ;
> -	struct pci_dev *pdev = dpc->dev->port;
> +	struct pci_dev *pdev = dpc->pdev;
>  	u16 cap = dpc->cap_pos, status;
>  
>  	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
> @@ -149,7 +149,7 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>  
>  static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
>  {
> -	struct pci_dev *pdev = dpc->dev->port;
> +	struct pci_dev *pdev = dpc->pdev;
>  	u16 cap = dpc->cap_pos, dpc_status, first_error;
>  	u32 status, mask, sev, syserr, exc, dw0, dw1, dw2, dw3, log, prefix;
>  	int i;
> @@ -228,7 +228,7 @@ static irqreturn_t dpc_handler(int irq, void *context)
>  {
>  	struct aer_err_info info;
>  	struct dpc_dev *dpc = context;
> -	struct pci_dev *pdev = dpc->dev->port;
> +	struct pci_dev *pdev = dpc->pdev;
>  	u16 cap = dpc->cap_pos, status, source, reason, ext_reason;
>  
>  	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
> @@ -267,7 +267,7 @@ static irqreturn_t dpc_handler(int irq, void *context)
>  static irqreturn_t dpc_irq(int irq, void *context)
>  {
>  	struct dpc_dev *dpc = (struct dpc_dev *)context;
> -	struct pci_dev *pdev = dpc->dev->port;
> +	struct pci_dev *pdev = dpc->pdev;
>  	u16 cap = dpc->cap_pos, status;
>  
>  	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
> @@ -299,7 +299,7 @@ static int dpc_probe(struct pcie_device *dev)
>  		return -ENOMEM;
>  
>  	dpc->cap_pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
> -	dpc->dev = dev;
> +	dpc->pdev = pdev;
>  	set_service_data(dev, dpc);
>  
>  	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
> -- 
> 2.21.0
> 
