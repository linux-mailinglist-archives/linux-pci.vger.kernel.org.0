Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6B7777D01
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 17:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjHJP7a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 11:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjHJP73 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 11:59:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285A4E53;
        Thu, 10 Aug 2023 08:59:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B09B666151;
        Thu, 10 Aug 2023 15:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EF5C433C7;
        Thu, 10 Aug 2023 15:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691683168;
        bh=gaCDJQX2O6yppUzsCM6ukAAErkl/jocCV207jMlCYOM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=byu4qO+z+PHPPb4T0QegjmagBG1lVmv+X1nT8e5g84Hy8rXzbHQiHeixadtbWSGdh
         aMVQNpOXaZ/OQjPdEZuwkYarYWnlTX8P5yQ52/j9ynwSPAD9kJW9mIr/Inz51/TF8B
         eBHZ2ComMGKCbz5DcgPOYElNsrxiY8ninrLZdhM4dpp21k1FhHxhnr+9luKumWrmGg
         PvDFtfPM7yfyIxtMunJOM6yVZS/6fHtWGcVaBz98gxSJNT/3861dBNH1gMTL9qiPJN
         a7pdJy18+R7rHgjaBA+6nLLY9JI/69r2dJGYdzbK6poFwE9qKHhcoQ8rQKYadczsMC
         uAhTQFLA5Lemw==
Date:   Thu, 10 Aug 2023 10:59:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, eric.auger@redhat.com
Subject: Re: [PATCH v2 1/2] PCI/VPD: Add runtime power management to sysfs
 interface
Message-ID: <20230810155926.GA32250@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803171233.3810944-2-alex.williamson@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 03, 2023 at 11:12:32AM -0600, Alex Williamson wrote:
> Unlike default access to config space through sysfs, the vpd read and
> write function don't actively manage the runtime power management state
> of the device during access.  Since commit 7ab5e10eda02 ("vfio/pci: Move
> the unused device into low power state with runtime PM"), the vfio-pci
> driver will use runtime power management and release unused devices to
> make use of low power states.  Attempting to access VPD information in
> this low power state can result in incorrect information or kernel
> crashes depending on the system behavior.
> 
> Wrap the vpd read/write bin attribute handlers in runtime PM and take
> into account the potential quirk to select the correct device to wake.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/pci/vpd.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index a4fc4d0690fe..81217dd4789f 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -275,8 +275,23 @@ static ssize_t vpd_read(struct file *filp, struct kobject *kobj,
>  			size_t count)
>  {
>  	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
> +	struct pci_dev *vpd_dev = dev;
> +	ssize_t ret;
> +
> +	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0) {
> +		vpd_dev = pci_get_func0_dev(dev);
> +		if (!vpd_dev)
> +			return -ENODEV;
> +	}
> +
> +	pci_config_pm_runtime_get(vpd_dev);
> +	ret = pci_read_vpd(vpd_dev, off, count, buf);
> +	pci_config_pm_runtime_put(vpd_dev);
> +
> +	if (dev != vpd_dev)
> +		pci_dev_put(vpd_dev);

I first thought this would leak a reference if dev was func0 and had
PCI_DEV_FLAGS_VPD_REF_F0 set, because in that case vpd_dev would be
the same as dev.

But I think that case can't happen because quirk_f0_vpd_link() does
nothing for func0 devices, so PCI_DEV_FLAGS_VPD_REF_F0 should never be
set for func0.  But it seems like this might be easier to analyze as:

  if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0)
    pci_dev_put(vpd_dev);

Or am I missing something?

> -	return pci_read_vpd(dev, off, count, buf);
> +	return ret;
>  }
>  
>  static ssize_t vpd_write(struct file *filp, struct kobject *kobj,
> @@ -284,8 +299,23 @@ static ssize_t vpd_write(struct file *filp, struct kobject *kobj,
>  			 size_t count)
>  {
>  	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
> +	struct pci_dev *vpd_dev = dev;
> +	ssize_t ret;
> +
> +	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0) {
> +		vpd_dev = pci_get_func0_dev(dev);
> +		if (!vpd_dev)
> +			return -ENODEV;
> +	}
> +
> +	pci_config_pm_runtime_get(vpd_dev);
> +	ret = pci_write_vpd(vpd_dev, off, count, buf);
> +	pci_config_pm_runtime_put(vpd_dev);
> +
> +	if (dev != vpd_dev)
> +		pci_dev_put(vpd_dev);
>  
> -	return pci_write_vpd(dev, off, count, buf);
> +	return ret;
>  }
>  static BIN_ATTR(vpd, 0600, vpd_read, vpd_write, 0);
>  
> -- 
> 2.40.1
> 
