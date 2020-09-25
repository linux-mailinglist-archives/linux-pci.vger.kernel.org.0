Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3260B2793D7
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 23:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgIYV66 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 17:58:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbgIYV66 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Sep 2020 17:58:58 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03CF72068D;
        Fri, 25 Sep 2020 21:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601071137;
        bh=cuxPA7oSZFL1vZUF+tnIoB0ZayYgP50U6fmiU2EcMzA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pYu+Q8d0tshd0wLJaLE3NsSqe5M7UGbip4En6laQrjy/GMkBFfAz20Q/fkW8mPtsg
         hLmTttLBKQB8TuCTZlELGk5bonqgMhSnGR3RM8Ci3WRe0gVBJV1VwxavPqUIszKWc1
         8BVzfoF1M9df78sEdoDFciVVGJsIzxUINd515M38=
Date:   Fri, 25 Sep 2020 16:58:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <seanvk.dev@oregontracks.org>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/10] PCI/AER: Apply function level reset to RCiEP on
 fatal error
Message-ID: <20200925215854.GA2460270@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922213859.108826-6-seanvk.dev@oregontracks.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 22, 2020 at 02:38:54PM -0700, Sean V Kelley wrote:
> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> 
> Attempt to do function level reset for an RCiEP associated with an
> RCEC device on fatal error.
> 
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---
>  drivers/pci/pcie/err.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index e575fa6cee63..5380ecc41506 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -169,6 +169,17 @@ static void pci_bridge_walk(struct pci_dev *bridge, int (*cb)(struct pci_dev *,
>  		cb(bridge, userdata);
>  }
>  
> +static pci_ers_result_t flr_on_rciep(struct pci_dev *dev)
> +{
> +	if (!pcie_has_flr(dev))
> +		return PCI_ERS_RESULT_NONE;
> +
> +	if (pcie_flr(dev))
> +		return PCI_ERS_RESULT_DISCONNECT;
> +
> +	return PCI_ERS_RESULT_RECOVERED;
> +}

Either we reset the device or we didn't; there is no third option.

If I read it correctly, nothing in pcie_do_recovery() cares about the
difference between PCI_ERS_RESULT_NONE and PCI_ERS_RESULT_DISCONNECT.
The status does get returned, but only edr_handle_event() looks at it,
and it doesn't care about the difference either.

So I think this should just return PCI_ERS_RESULT_RECOVERED or
PCI_ERS_RESULT_DISCONNECT.

>  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  			pci_channel_state_t state,
>  			pci_ers_result_t (*reset_subordinate_devices)(struct pci_dev *pdev))
> @@ -195,15 +206,17 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	if (state == pci_channel_io_frozen) {
>  		pci_bridge_walk(bridge, report_frozen_detected, &status);
>  		if (type == PCI_EXP_TYPE_RC_END) {
> -			pci_warn(dev, "link reset not possible for RCiEP\n");
> -			status = PCI_ERS_RESULT_NONE;
> -			goto failed;
> -		}
> -
> -		status = reset_subordinate_devices(bridge);
> -		if (status != PCI_ERS_RESULT_RECOVERED) {
> -			pci_warn(dev, "subordinate device reset failed\n");
> -			goto failed;
> +			status = flr_on_rciep(dev);
> +			if (status != PCI_ERS_RESULT_RECOVERED) {
> +				pci_warn(dev, "function level reset failed\n");
> +				goto failed;
> +			}
> +		} else {
> +			status = reset_subordinate_devices(bridge);
> +			if (status != PCI_ERS_RESULT_RECOVERED) {
> +				pci_warn(dev, "subordinate device reset failed\n");
> +				goto failed;
> +			}
>  		}
>  	} else {
>  		pci_bridge_walk(bridge, report_normal_detected, &status);
> -- 
> 2.28.0
> 
