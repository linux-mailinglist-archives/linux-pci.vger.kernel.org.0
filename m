Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024F427A49B
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 01:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgI0Xpt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 19:45:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbgI0Xpt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Sep 2020 19:45:49 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D0A523A32;
        Sun, 27 Sep 2020 23:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601250348;
        bh=k2I0AjRhB2xyAVs5+JOSNrQz8ZCGD56r2njVEF9Jov0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vop/41BzdLIAZRyxeAhU+9KaK4yecqk2pVw8yxyjq985PMA5mAjOC+3LXBmt/M+vX
         VVgrKCuGtAVIqO8MjQPS0H1GtGthLSeP5q59dfqiHvYEDCQFExym6GC9t1X61YuLjP
         8Nol6x+GWRN7GiWiDBJeuv5jzV3nYPLhj6WN1n8Q=
Date:   Sun, 27 Sep 2020 18:45:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <seanvk.dev@oregontracks.org>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: Re: [PATCH v6 07/10] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Message-ID: <20200927234545.GA2470139@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922213859.108826-8-seanvk.dev@oregontracks.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 22, 2020 at 02:38:56PM -0700, Sean V Kelley wrote:
> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> 
> When attempting error recovery for an RCiEP associated with an RCEC device,
> there needs to be a way to update the Root Error Status, the Uncorrectable
> Error Status and the Uncorrectable Error Severity of the parent RCEC.
> In some non-native cases in which there is no OS visible device
> associated with the RCiEP, there is nothing to act upon as the firmware
> is acting before the OS. So add handling for the linked 'rcec' in AER/ERR
> while taking into account non-native cases.
> 
> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---
>  drivers/pci/pcie/aer.c |  9 +++++----
>  drivers/pci/pcie/err.c | 38 ++++++++++++++++++++++++--------------
>  2 files changed, 29 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 65dff5f3457a..dccdba60b5d9 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1358,17 +1358,18 @@ static int aer_probe(struct pcie_device *dev)
>  static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>  {
>  	int aer = dev->aer_cap;
> +	int rc = 0;
>  	u32 reg32;
> -	int rc;
> -
>  
>  	/* Disable Root's interrupt in response to error messages */
>  	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>  	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
>  	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
>  
> -	rc = pci_bus_error_reset(dev);
> -	pci_info(dev, "Root Port link has been reset\n");
> +	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC) {
> +		rc = pci_bus_error_reset(dev);
> +		pci_info(dev, "Root Port link has been reset\n");
> +	}
>  
>  	/* Clear Root Error Status */
>  	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 5380ecc41506..a61a2518163a 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -149,7 +149,8 @@ static int report_resume(struct pci_dev *dev, void *data)
>  /**
>   * pci_bridge_walk - walk bridges potentially AER affected
>   * @bridge   bridge which may be an RCEC with associated RCiEPs,
> - *           an RCiEP associated with an RCEC, or a Port.
> + *           or a Port.
> + * @dev      an RCiEP lacking an associated RCEC.
>   * @cb       callback to be called for each device found
>   * @userdata arbitrary pointer to be passed to callback.
>   *
> @@ -160,13 +161,16 @@ static int report_resume(struct pci_dev *dev, void *data)
>   * If the device provided has no subordinate bus, call the provided
>   * callback on the device itself.
>   */
> -static void pci_bridge_walk(struct pci_dev *bridge, int (*cb)(struct pci_dev *, void *),
> +static void pci_bridge_walk(struct pci_dev *bridge, struct pci_dev *dev,
> +			    int (*cb)(struct pci_dev *, void *),
>  			    void *userdata)
>  {
> -	if (bridge->subordinate)
> +	if (bridge && bridge->subordinate)

I *guess* this means there's a possibility that bridge is NULL?  And I
guess that case is when pci_upstream_bridge(dev) in pcie_do_recovery()
was NULL?

I can't figure out what that means in practice.  Oh, wait, I bet I
know -- this is the non-native case where there's no OS-visible
reporting device.

We need some sort of comment because this is really not a top-of-mind
situation unless you happen to be working on one of the few systems
like that.

Not too sure this scenario is really a good fit for the
pci_bridge_walk() model, but I think it's OK for now with a hint so we
can remember this no RCEC, no Root Port model.

>  		pci_walk_bus(bridge->subordinate, cb, userdata);
> -	else
> +	else if (bridge)
>  		cb(bridge, userdata);
> +	else
> +		cb(dev, userdata);
>  }
>  
>  static pci_ers_result_t flr_on_rciep(struct pci_dev *dev)
> @@ -196,16 +200,24 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	type = pci_pcie_type(dev);
>  	if (type == PCI_EXP_TYPE_ROOT_PORT ||
>  	    type == PCI_EXP_TYPE_DOWNSTREAM ||
> -	    type == PCI_EXP_TYPE_RC_EC ||
> -	    type == PCI_EXP_TYPE_RC_END)
> +	    type == PCI_EXP_TYPE_RC_EC)
>  		bridge = dev;
> +	else if (type == PCI_EXP_TYPE_RC_END)
> +		bridge = dev->rcec;
>  	else
>  		bridge = pci_upstream_bridge(dev);
>  
>  	pci_dbg(dev, "broadcast error_detected message\n");
>  	if (state == pci_channel_io_frozen) {
> -		pci_bridge_walk(bridge, report_frozen_detected, &status);
> +		pci_bridge_walk(bridge, dev, report_frozen_detected, &status);
>  		if (type == PCI_EXP_TYPE_RC_END) {
> +			/*
> +			 * The callback only clears the Root Error Status
> +			 * of the RCEC (see aer.c).
> +			 */
> +			if (bridge)
> +				reset_subordinate_devices(bridge);

It's unfortunate to add yet another special case in this code, and I'm
not thrilled about the one in aer_root_reset() either.  It's just not
obvious why they should be there.  I'm sure if I spent 30 minutes
decoding things, it would all make sense.  Guess I'm just griping
because I don't have a better suggestion.

>  			status = flr_on_rciep(dev);
>  			if (status != PCI_ERS_RESULT_RECOVERED) {
>  				pci_warn(dev, "function level reset failed\n");
> @@ -219,13 +231,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  			}
>  		}
>  	} else {
> -		pci_bridge_walk(bridge, report_normal_detected, &status);
> +		pci_bridge_walk(bridge, dev, report_normal_detected, &status);
>  	}
>  
>  	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>  		status = PCI_ERS_RESULT_RECOVERED;
>  		pci_dbg(dev, "broadcast mmio_enabled message\n");
> -		pci_bridge_walk(bridge, report_mmio_enabled, &status);
> +		pci_bridge_walk(bridge, dev, report_mmio_enabled, &status);
>  	}
>  
>  	if (status == PCI_ERS_RESULT_NEED_RESET) {
> @@ -236,18 +248,16 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  		 */
>  		status = PCI_ERS_RESULT_RECOVERED;
>  		pci_dbg(dev, "broadcast slot_reset message\n");
> -		pci_bridge_walk(bridge, report_slot_reset, &status);
> +		pci_bridge_walk(bridge, dev, report_slot_reset, &status);
>  	}
>  
>  	if (status != PCI_ERS_RESULT_RECOVERED)
>  		goto failed;
>  
>  	pci_dbg(dev, "broadcast resume message\n");
> -	pci_bridge_walk(bridge, report_resume, &status);
> +	pci_bridge_walk(bridge, dev, report_resume, &status);
>  
> -	if (type == PCI_EXP_TYPE_ROOT_PORT ||
> -	    type == PCI_EXP_TYPE_DOWNSTREAM ||
> -	    type == PCI_EXP_TYPE_RC_EC) {
> +	if (bridge) {
>  		if (pcie_aer_is_native(bridge))
>  			pcie_clear_device_status(bridge);
>  		pci_aer_clear_nonfatal_status(bridge);
> -- 
> 2.28.0
> 
