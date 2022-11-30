Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D4563E0F9
	for <lists+linux-pci@lfdr.de>; Wed, 30 Nov 2022 20:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiK3Tps (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Nov 2022 14:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiK3Tp0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Nov 2022 14:45:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5117D54343;
        Wed, 30 Nov 2022 11:45:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECB1DB81CAF;
        Wed, 30 Nov 2022 19:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB0CC433D6;
        Wed, 30 Nov 2022 19:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669837522;
        bh=uNNXGBb4FjBVyKDxuAWjBnHecN+PDevZMiRfEDecVE8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jaY6fmGRj/bMNVgts24I4U7+WMeUHFy/gSMzUAgJONxpRtci19Cdm3ChVVaQIG3nh
         4JFc+pKthb2EYoCZmi1MgLXAwgl1mE55mBDe7ImSxBcejCXeMXAYaMsO/y5ZSl5Qed
         3NUzPMZ/5pKgRKccbr80H5xYnS2J7MYhGevMJOk52+eKgj63UDJ5cb2XKXrZkX+RVY
         1VYl2I0OBCblQXiZcV0fVTw/tgmv97NOryG+OlmWWCvkfhkkyIHuQsByywRXHUXtnG
         HprZ29ZQwddo7DeEQdN4+LyE0oJuOkeDjWj5iQv48VaKDl0tB4dE1K7Bkiq/MfO6O9
         XMyDu/R2sOoGg==
Date:   Wed, 30 Nov 2022 13:45:21 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rostedt@goodmis.org,
        terry.bowman@amd.com, bhelgaas@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, shiju.jose@huawei.com
Subject: Re: [PATCH v4 10/11] PCI/AER: Add optional logging callback for
 correctable error
Message-ID: <20221130194521.GA829038@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166974414546.1608150.4142682712102935008.stgit@djiang5-desk3.ch.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 29, 2022 at 10:49:05AM -0700, Dave Jiang wrote:
> Some new devices such as CXL devices may want to record additional error
> information on a corrected error. Add a callback to allow the PCI device
> driver to do additional logging such as providing additional stats for user
> space RAS monitoring.
> 
> For CXL device, this is actually a need due to CXL needing to write to the
> device AER status register in order to clear the unmasked CEs.

s/CE/correctable error/ since it's the first use and not common in
PCI-land.

"device AER status register" sounds like the PCIe AER Correctable
Error Status Register (PCIe r6.0, sec 7.8.4.5), but I think you mean
something else, maybe a CXL-specific register?

The PCIe core needs to own the AER one (PCI_ERR_COR_STATUS) so it can
coordinate ownership between firmware and Linux.

> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  Documentation/PCI/pci-error-recovery.rst |    7 +++++++
>  drivers/pci/pcie/aer.c                   |    8 +++++++-
>  include/linux/pci.h                      |    3 +++
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
> index 187f43a03200..690220255d5e 100644
> --- a/Documentation/PCI/pci-error-recovery.rst
> +++ b/Documentation/PCI/pci-error-recovery.rst
> @@ -83,6 +83,7 @@ This structure has the form::
>  		int (*mmio_enabled)(struct pci_dev *dev);
>  		int (*slot_reset)(struct pci_dev *dev);
>  		void (*resume)(struct pci_dev *dev);
> +		void (*cor_error_log)(struct pci_dev *dev);

I think I would remove "log" from the name because it suggests this
hook should *only* log, and you need to actually clear some status.
Maybe "cor_error_detected()" to be analogous to error_detected()?

>  	};
>  
>  The possible channel states are::
> @@ -422,5 +423,11 @@ That is, the recovery API only requires that:
>     - drivers/net/cxgb3
>     - drivers/net/s2io.c
>  
> +   The cor_error_log() callback is invoked in handle_error_source() when
> +   the error severity is "correctable". The callback is optional and allows
> +   additional logging to be done if desired. See example:
> +
> +   - drivers/cxl/pci.c
> +
>  The End
>  -------
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e2d8a74f83c3..af1b5eecbb11 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -961,8 +961,14 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>  		if (aer)
>  			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
>  					info->status);
> -		if (pcie_aer_is_native(dev))
> +		if (pcie_aer_is_native(dev)) {
> +			struct pci_driver *pdrv = dev->driver;
> +
> +			if (pdrv && pdrv->err_handler &&
> +			    pdrv->err_handler->cor_error_log)
> +				pdrv->err_handler->cor_error_log(dev);
>  			pcie_clear_device_status(dev);
> +		}
>  	} else if (info->severity == AER_NONFATAL)
>  		pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
>  	else if (info->severity == AER_FATAL)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 575849a100a3..54939b3426a9 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -844,6 +844,9 @@ struct pci_error_handlers {
>  
>  	/* Device driver may resume normal operations */
>  	void (*resume)(struct pci_dev *dev);
> +
> +	/* Allow device driver to record more details of a correctable error */
> +	void (*cor_error_log)(struct pci_dev *dev);
>  };
>  
>  
> 
> 
