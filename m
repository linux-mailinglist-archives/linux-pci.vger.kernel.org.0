Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5928C2CCA70
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 00:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgLBXTm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Dec 2020 18:19:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:42326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgLBXTm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Dec 2020 18:19:42 -0500
Date:   Wed, 2 Dec 2020 17:18:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1606951141;
        bh=FZ7CRM5O5yFAaY/TWEVrh2Y0rLGcnVO58PrxIl7NIE4=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=bRYu2rxutO5MLiHWMyAu5rOvehFmkEU9z41twDBwS/+zDtLRr05aSlJYzBtUgacc7
         XZtQ0a1mFW6g2PHcZsAbdyZG9y/gpLYKKK9+QoNVAlNfPunA9p/yG7U/LNk6R8+P2k
         qJZO3RQqay2hxoPgrRSPF/0oQeu1RxWVvWP8wpD4bMyJrQGXp/CjP7Fdt++IU+1ai9
         F241qmftM4HZCjl3pw8cmNzumvoai+ElFxyip6avV8RxRQxf/rSyuAUDJ6as3d/rD5
         /I3eeDJq17p2gLlCV/1bPBgpMnLrE40mJmjwhCvYA9n24EpO1LDQaENT37L1EoLOEh
         zs6OUC8o9wXaQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <sean.v.kelley@intel.com>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        xerces.zhao@gmail.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v12 07/15] PCI/ERR: Use "bridge" for clarity in
 pcie_do_recovery()
Message-ID: <20201202231859.GA1484005@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121001036.8560-8-sean.v.kelley@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 20, 2020 at 04:10:28PM -0800, Sean V Kelley wrote:
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 7a5af873d8bc..46a5b84f8842 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -151,24 +151,27 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev))
>  {
>  	int type = pci_pcie_type(dev);
> -	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> +	struct pci_dev *bridge;
>  	struct pci_bus *bus;
> +	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>  
>  	/*
> -	 * Error recovery runs on all subordinates of the first downstream port.
> -	 * If the downstream port detected the error, it is cleared at the end.
> +	 * Error recovery runs on all subordinates of the bridge.  If the
> +	 * bridge detected the error, it is cleared at the end.
>  	 */
>  	if (!(type == PCI_EXP_TYPE_ROOT_PORT ||
>  	      type == PCI_EXP_TYPE_DOWNSTREAM))
> -		dev = pci_upstream_bridge(dev);
> -	bus = dev->subordinate;
> +		bridge = pci_upstream_bridge(dev);
> +	else
> +		bridge = dev;

I think there's a bug here even before your series.  We started with:

  pcie_do_recovery(struct pci_dev *dev, ..., pci_ers_result_t (*reset_link)())
  {
    if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
	  pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
      dev = dev->bus->self;
    ...
    reset_link(dev);

so if we called pcie_do_recovery() with an Endpoint, we set "dev" to
the upstream bridge, either a Root Port or a Switch Downstream Port,
which we then pass on to reset_link().  For native AER and APEI,
that's aer_root_reset(), which assumes it gets a Root Port.

If we pass a Switch Downstream Port, aer_root_reset() writes to the
*switch port's* PCI_ERR_ROOT_COMMAND and PCI_ERR_ROOT_STATUS, which
are reserved since it's not a Root Port or an RCEC.

The writes probably don't *break* anything since those registers are
reserved, but they also don't disable the interrupt or clear the Root
Error Status.

Bjorn
