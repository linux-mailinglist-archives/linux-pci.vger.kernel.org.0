Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC45E3D982A
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 00:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbhG1WIq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 18:08:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231668AbhG1WIp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 18:08:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57F0660FED;
        Wed, 28 Jul 2021 22:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627510123;
        bh=H2Y1+Sq9QtbYo5PwIHp3aaXPyV8HfD43k8oAInR8+1s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kW9Qv4GlHHK4gBCVNAB8toz48c1nwSP7v33mjObvx6F/QXtfx02beCyVa4IaZdUqw
         xfG6pzJREK9lUbi9xtN8wAmbTb1VcbSckJ3mS7YzVoDJCJP4XTFknHrZyyQn7GCnEK
         VT79ED8hYHirnLUMcvk3sv9Skdc11CnRgcpY3anpZA5ib4JXkW2svfy+vHV/IcrJNb
         HQKwiKj8mPumeT6GMp5TLh2ed1Yv8XIrmhgoh2zxMlstqvTCcgAnqws5OGRACcyPcP
         uEIwhq8tM9Js6QfdqCADuMkYXh5ipMVV7hCXcBwcalmyXy9y54tBT3nlnt+d1vA5kk
         xhs3e4wJG0Xlw==
Date:   Wed, 28 Jul 2021 17:08:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     bhelgaas@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        sean.v.kelley@intel.com, Jonathan.Cameron@huawei.com,
        refactormyself@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v2] PCI/AER: Change to use helper pcie_aer_is_native() in
 some places
Message-ID: <20210728220842.GA856517@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1612490648-44817-1-git-send-email-tanxiaofei@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 05, 2021 at 10:04:08AM +0800, Xiaofei Tan wrote:
> Use helper function pcie_aer_is_native() in some places to keep
> the code tidy. No function changes.
> 
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> 
> ---
> Changes from v1 to v2:
> - Add the fix suggested by Krzysztof.
> ---
>  drivers/pci/pcie/aer.c          | 4 ++--
>  drivers/pci/pcie/err.c          | 2 +-
>  drivers/pci/pcie/portdrv_core.c | 3 +--
>  3 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 77b0f2c..03212d0 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1397,7 +1397,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>  	 */
>  	aer = root ? root->aer_cap : 0;
>  
> -	if ((host->native_aer || pcie_ports_native) && aer) {
> +	if (pcie_aer_is_native(dev) && aer) {

Are we guaranteed that "dev" has an AER capability?  I guess so,
because the function comment says "dev" is a Root Port, an RCEC, or an
RCiEP.  I *guess* that we only get here if "dev" has an AER
capability?  I wish this were a little more obvious from the code.

If "dev" does not have AER, we previously cleared
ROOT_PORT_INTR_ON_MESG_MASK, but after this patch we won't.

  pcie_aer_is_native(struct pci_dev *dev)
  {
    struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);

    if (!dev->aer_cap)
      return 0;

    return pcie_ports_native || host->native_aer;
  }

If we do decide this patch is correct, I think we can drop the "host",
which is no longer used in this function.

>  		/* Disable Root's interrupt in response to error messages */
>  		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>  		reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> @@ -1417,7 +1417,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>  		pci_info(dev, "Root Port link has been reset (%d)\n", rc);
>  	}
>  
> -	if ((host->native_aer || pcie_ports_native) && aer) {
> +	if (pcie_aer_is_native(dev) && aer) {
>  		/* Clear Root Error Status */
>  		pci_read_config_dword(root, aer + PCI_ERR_ROOT_STATUS, &reg32);
>  		pci_write_config_dword(root, aer + PCI_ERR_ROOT_STATUS, reg32);
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 510f31f..1d6cfb9 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -237,7 +237,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	 * this status.  In that case, the signaling device may not even be
>  	 * visible to the OS.
>  	 */
> -	if (host->native_aer || pcie_ports_native) {
> +	if (pcie_aer_is_native(dev)) {
>  		pcie_clear_device_status(bridge);

Is it guaranteed that "dev" has an AER capability here?  Again, it's
not obvious to me that it must; this path is used from DPC and EDR as
well as AER.

If it's not guaranteed, assume "dev" is a PCIe device with no AER
capability.  It still has a Device Status register, and previously we
called pcie_clear_device_status() to clear it.

Now we won't clear it.

>  		pci_aer_clear_nonfatal_status(bridge);
>  	}
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index e1fed664..3b3743e 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -221,8 +221,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	}
>  
>  #ifdef CONFIG_PCIEAER
> -	if (dev->aer_cap && pci_aer_available() &&
> -	    (pcie_ports_native || host->native_aer)) {
> +	if (pci_aer_available() && pcie_aer_is_native(dev)) {
>  		services |= PCIE_PORT_SERVICE_AER;
>  
>  		/*
> -- 
> 2.8.1
> 
