Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04054423A1D
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 10:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237819AbhJFJAu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Oct 2021 05:00:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237653AbhJFJAt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Oct 2021 05:00:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2882761154;
        Wed,  6 Oct 2021 08:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633510737;
        bh=++lqEzQxtoW7xfOop+3aaHSFfCOnbuI0IZsaxmI1SwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U44MV0I+Y7MJ6VUgb5Zmwxs0dfF1p2KQU2+dd0zK8in5c21w8sAH6CYVHJwBOQOk7
         39H45Z4x4k3pZXCNWfODnm981s+m9HOW6SEDaoDmIcY7xpTx4fiQG0p9nDenpY+iju
         fVnxn0DPgcGoXk5LI8V9r5/SRkWIMwX2c0JN3UIxJhd2IVHPc5fb0HSIMFmu76qM0A
         PSb/xnshsD3UX4CyqpPxGU16aruhSp9jJKdlOmKEm1Oeq47Bj/Idb+lg2GgGUJj+y6
         IvIk/o+WKLjeohjaADhQBSr1mktt4YyFribvW1F+KEtBTdeitHEo/gGqv2LPT0VN1V
         iCNt2bDWNSiuA==
Date:   Wed, 6 Oct 2021 11:58:52 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com,
        bhelgaas@google.com, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/5] platform/x86/intel: Move intel_pmt from MFD to
 Auxiliary Bus
Message-ID: <YV1lTMwBSVlvadiG@unreal>
References: <20211001012815.1999501-1-david.e.box@linux.intel.com>
 <20211001012815.1999501-3-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001012815.1999501-3-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 30, 2021 at 06:28:12PM -0700, David E. Box wrote:
> Intel Platform Monitoring Technology (PMT) support is indicated by presence
> of an Intel defined PCIe DVSEC structure with a PMT ID. However DVSEC
> structures may also be used by Intel to indicate support for other
> capabilities unrelated to PMT.  The Out Of Band Management Services Module
> (OOBMSM) is an example of a device that can have both PMT and non-PMT
> capabilities. In order to support these capabilities it is necessary to
> modify the intel_pmt driver to handle the creation of platform devices more
> generically. To that end the following changes are made.
> 
> Convert the driver and child drivers from MFD to the Auxiliary Bus. This
> architecture is more suitable anyway since the driver partitions a
> multifunctional PCIe device. This also moves the driver out of the MFD
> subsystem and into platform/x86/intel.
> 
> Before, devices were named by their capability (e.g. pmt_telemetry).
> Instead, generically name them by their capability ID (e.g.
> intel_extended_cap.2). This allows the IDs to be created automatically,
> minimizing the code needed to support future capabilities. However, to
> ensure that unsupported devices aren't created, use an allow list to
> specify supported capabilities. Along these lines, rename the driver from
> intel_pmt to intel_extended_caps to better reflect the purpose.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> 
> V1:	New patch. However incorporates some elements of [1] which was
> 	dropped. Namely enumerating features generically and creating an
> 	allow list. Also cleans up probe by moving some code to functions
> 	and using a bool instead of an int to track whether a device was
> 	added.
> 
> [1] https://lore.kernel.org/all/20210922213007.2738388-3-david.e.box@linux.intel.com/

<...>

> +static int extended_caps_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct extended_caps_platform_info *info;
> +	bool have_devices = false;
> +	unsigned long quirks = 0;
> +	int ret;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret)
> +		return ret;
> +
> +	info = (struct extended_caps_platform_info *)id->driver_data;

pci_get_drvdata() in all places and no need to cast void *.

> +	if (info)
> +		quirks = info->quirks;
> +
> +	have_devices |= extended_caps_walk_dvsec(pdev, quirks);
> +
> +	if (info && (info->quirks & EXT_CAPS_QUIRK_NO_DVSEC))
> +		have_devices |= extended_caps_walk_header(pdev, quirks, info->capabilities);
> +
> +	if (!have_devices)
> +		return -ENODEV;
> +
> +	return 0;
> +}

<...>

> -static struct platform_driver pmt_telem_driver = {
> -	.driver = {
> -		.name   = TELEM_DEV_NAME,
> -	},
> -	.remove = pmt_telem_remove,
> -	.probe  = pmt_telem_probe,
> +static const struct auxiliary_device_id pmt_telem_aux_id_table[] = {
> +	{ .name = "intel_extended_caps.2", },

Why "2" in the name?

Thanks

> +	{},
> +};
> +MODULE_DEVICE_TABLE(auxiliary, pmt_telem_aux_id_table);
> +
> +static struct auxiliary_driver pmt_telem_aux_driver = {
> +	.id_table	= pmt_telem_aux_id_table,
> +	.remove		= pmt_telem_remove,
> +	.probe		= pmt_telem_probe,
>  };
>  
