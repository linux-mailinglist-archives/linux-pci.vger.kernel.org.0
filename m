Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A272C196D
	for <lists+linux-pci@lfdr.de>; Tue, 24 Nov 2020 00:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgKWX2m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Nov 2020 18:28:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:59402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbgKWX2l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Nov 2020 18:28:41 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E57420717;
        Mon, 23 Nov 2020 23:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606174120;
        bh=JHs4MSzAK1ZX65YT7L9fzKBfEx1vBIrxlceB3sOS6Pk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mavAID2rxjJndYya+YPEcOqHSFopIh5w4222E+LMb9DNuyNsNon+IV2G4CbokJVmO
         L0Mre2fX4TbgPba5jjF2ZJlEDztwvGUX7s99IZ+EAoxY25vrOR0X1gKDFYcnooBfMD
         GvZxrK4je2E/4WX/ChUWCHVxZkq46yqOEy6p8T9A=
Date:   Mon, 23 Nov 2020 17:28:38 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <sean.v.kelley@intel.com>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        xerces.zhao@gmail.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 10/15] PCI/ERR: Limit AER resets in pcie_do_recovery()
Message-ID: <20201123232838.GA498923@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121001036.8560-11-sean.v.kelley@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 20, 2020 at 04:10:31PM -0800, Sean V Kelley wrote:
> In some cases a bridge may not exist as the hardware controlling may be
> handled only by firmware and so is not visible to the OS. This scenario is
> also possible in future use cases involving non-native use of RCECs by
> firmware.
> 
> Explicitly apply conditional logic around these resets by limiting them to
> Root Ports and Downstream Ports.

Can you help me understand this?  The subject says "Limit AER resets"
and here you say "limit them to RPs and DPs", but it's not completely
obvious how the resets are being limited, i.e., the patch doesn't add
anything like:

 +  if (type == PCI_EXP_TYPE_ROOT_PORT ||
 +      type == PCI_EXP_TYPE_DOWNSTREAM)
      reset_subordinates(bridge);

It *does* add checks around pcie_clear_device_status(), but that also
includes RC_EC.  And that's not a reset, so I don't think that's
explicitly mentioned in the commit log.

Also see the question below.

> Link: https://lore.kernel.org/r/20201002184735.1229220-8-seanvk.dev@oregontracks.org
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/pci/pcie/err.c | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 8b53aecdb43d..7883c9791562 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -148,13 +148,17 @@ static int report_resume(struct pci_dev *dev, void *data)
>  
>  /**
>   * pci_walk_bridge - walk bridges potentially AER affected
> - * @bridge:	bridge which may be a Port
> + * @bridge:	bridge which may be a Port, an RCEC with associated RCiEPs,
> + *		or an RCiEP associated with an RCEC
>   * @cb:		callback to be called for each device found
>   * @userdata:	arbitrary pointer to be passed to callback
>   *
>   * If the device provided is a bridge, walk the subordinate bus, including
>   * any bridged devices on buses under this bus.  Call the provided callback
>   * on each device found.
> + *
> + * If the device provided has no subordinate bus, call the callback on the
> + * device itself.
>   */
>  static void pci_walk_bridge(struct pci_dev *bridge,
>  			    int (*cb)(struct pci_dev *, void *),
> @@ -162,6 +166,8 @@ static void pci_walk_bridge(struct pci_dev *bridge,
>  {
>  	if (bridge->subordinate)
>  		pci_walk_bus(bridge->subordinate, cb, userdata);
> +	else
> +		cb(bridge, userdata);
>  }
>  
>  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> @@ -174,10 +180,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  
>  	/*
>  	 * Error recovery runs on all subordinates of the bridge.  If the
> -	 * bridge detected the error, it is cleared at the end.
> +	 * bridge detected the error, it is cleared at the end.  For RCiEPs
> +	 * we should reset just the RCiEP itself.
>  	 */
>  	if (type == PCI_EXP_TYPE_ROOT_PORT ||
> -	    type == PCI_EXP_TYPE_DOWNSTREAM)
> +	    type == PCI_EXP_TYPE_DOWNSTREAM ||
> +	    type == PCI_EXP_TYPE_RC_EC ||
> +	    type == PCI_EXP_TYPE_RC_END)
>  		bridge = dev;
>  	else
>  		bridge = pci_upstream_bridge(dev);
> @@ -185,6 +194,12 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	pci_dbg(bridge, "broadcast error_detected message\n");
>  	if (state == pci_channel_io_frozen) {
>  		pci_walk_bridge(bridge, report_frozen_detected, &status);
> +		if (type == PCI_EXP_TYPE_RC_END) {
> +			pci_warn(dev, "subordinate device reset not possible for RCiEP\n");
> +			status = PCI_ERS_RESULT_NONE;
> +			goto failed;
> +		}
> +
>  		status = reset_subordinates(bridge);
>  		if (status != PCI_ERS_RESULT_RECOVERED) {
>  			pci_warn(bridge, "subordinate device reset failed\n");
> @@ -217,9 +232,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	pci_dbg(bridge, "broadcast resume message\n");
>  	pci_walk_bridge(bridge, report_resume, &status);
>  
> -	if (pcie_aer_is_native(bridge))
> -		pcie_clear_device_status(bridge);
> -	pci_aer_clear_nonfatal_status(bridge);
> +	if (type == PCI_EXP_TYPE_ROOT_PORT ||
> +	    type == PCI_EXP_TYPE_DOWNSTREAM ||
> +	    type == PCI_EXP_TYPE_RC_EC) {
> +		if (pcie_aer_is_native(bridge))
> +			pcie_clear_device_status(bridge);
> +		pci_aer_clear_nonfatal_status(bridge);

This is hard to understand because "type" is from "dev", but "bridge"
is not necessarily the same device.  Should it be this?

  type = pci_pcie_type(bridge);
  if (type == PCI_EXP_TYPE_ROOT_PORT ||
      ...)

> +	}
>  	pci_info(bridge, "device recovery successful\n");
>  	return status;
>  
> -- 
> 2.29.2
> 
