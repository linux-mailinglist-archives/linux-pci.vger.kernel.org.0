Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAE37797B6
	for <lists+linux-pci@lfdr.de>; Fri, 11 Aug 2023 21:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbjHKTZr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Aug 2023 15:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjHKTZq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Aug 2023 15:25:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD6830F5;
        Fri, 11 Aug 2023 12:25:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0DD966CB2;
        Fri, 11 Aug 2023 19:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB02C433CA;
        Fri, 11 Aug 2023 19:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691781945;
        bh=qogkYJjVXhmRZxo6AWvtBEFp2qI0IoouK46TXSQKCu8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=L7emNhzIm0vJtDRorG43+e41FMNje5x7Gudy9DM0QGx9DhkxmuKPKjQY0nID4neLc
         vEtXHXqieFb4eQl7majMAHujPP/3A3fcgihr+OilLfjxiPaX3lo/zEfsd5Ahf2BMdM
         jpYyj1fH06XVdYSz7s0AyucsVhSUytLa5rfnVxdPTl7mgbmUBvMxmkpi5ohCyDBram
         A+cH1G3pG2ZuQCYpwxURV3EkTg5SsNvyh9htZluUG0eOPkbT1r+mcQTLbvb8Up9viD
         faztcHWtBI8pUu+D926TV6GiLS81F0PboA2Jhlh/qA66ydsxPskozSTIAv7SRlZlef
         YJrWiGhMq/iGQ==
Date:   Fri, 11 Aug 2023 14:25:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, eric.auger@redhat.com
Subject: Re: [PATCH v2 1/2] PCI/VPD: Add runtime power management to sysfs
 interface
Message-ID: <20230811192543.GA80176@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803171233.3810944-2-alex.williamson@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

I guess this specifically refers to D3cold, right?  VPD is accessed
via config space, which should work in all D0-D3hot states, but not in
D3cold.  I don't see anything in the spec about needing to be in D0 to
access VPD.

I assume there's no public problem report we could cite here?  I
suppose the behavior in D3cold is however the system handles a UR
error.

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
>  
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
