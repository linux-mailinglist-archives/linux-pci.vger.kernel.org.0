Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9265290A8A
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 19:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390367AbgJPRWN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Oct 2020 13:22:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390217AbgJPRWN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Oct 2020 13:22:13 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B984820704;
        Fri, 16 Oct 2020 17:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602868932;
        bh=B2nFS5GlTtH8/HnTMPOmwLUFB4yuB1O45kTS6SX8Q3Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Qb+10I1vdbsqZe8uwvcmY+mTQ0NpQAMw0MzlnGKjWYnlEn5SkGg72ip0PwkdPzfcN
         AVcwlXHLl7TmEGu7K7JCG9SXC2zwcX7V1I4bgh/YPtAnzxkCyTDitJagVj3U+L7Pyb
         D51KbvpCCsIxdY841pA0h2hBZT9ahxbQqQqZCz9A=
Date:   Fri, 16 Oct 2020 12:22:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <seanvk.dev@oregontracks.org>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: Re: [PATCH v9 10/15] PCI/ERR: Limit AER resets in pcie_do_recovery()
Message-ID: <20201016172210.GA86168@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016001113.2301761-11-seanvk.dev@oregontracks.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 15, 2020 at 05:11:08PM -0700, Sean V Kelley wrote:
> From: Sean V Kelley <sean.v.kelley@intel.com>
> 
> In some cases a bridge may not exist as the hardware controlling may be
> handled only by firmware and so is not visible to the OS. This scenario is
> also possible in future use cases involving non-native use of RCECs by
> firmware.
> 
> Explicitly apply conditional logic around these resets by limiting them to
> Root Ports and Downstream Ports.
> 
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

Looks like *this* is the patch where the "no subordinate bus" case
becomes possible?  If you agree, I can just move the test here, no
need to repost.

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
> +	}
>  	pci_info(bridge, "device recovery successful\n");
>  	return status;
>  
> -- 
> 2.28.0
> 
