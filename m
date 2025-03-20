Return-Path: <linux-pci+bounces-24264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DD1A6B019
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 22:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C47C189F526
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 21:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A394215F7F;
	Thu, 20 Mar 2025 21:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5fjRckm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41D6635;
	Thu, 20 Mar 2025 21:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742507147; cv=none; b=nE3El1d7XX6BHtEQ3FkDQsIMPbkWb6Wa+yhJ+k8inuHhd2A+v5RBjSbBSIBm2UuMQ7Lao0OcPMBI/20sfTs1VN1UBtn8cu71wWYLM/lh4YlOvREPNYIPSVhHWI1YvQuyDo0kVF6jOFTSSksNhzTLGgbPi4xXq3fkpvLQ+ir+GAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742507147; c=relaxed/simple;
	bh=ViU30AgeNG8w8kd9yX9xiY75+6HCSwN79gRM+10rZIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uitrjtv3Bc3XbyRbzucL0bdAGxdLmLPlaqWH59gJU59xRCQ1xdzwGqyh6uisy9wfetj7XiTKV2lUuhGTLs4dBEKSI+QiCeXJmQ2orRDYdC8PI+omVgN/E29KDMCXB/4u/l18KgvthQuY0OLPgez/gPEESKrldCxBG5haRCL4glE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5fjRckm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C791C4CEDD;
	Thu, 20 Mar 2025 21:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742507146;
	bh=ViU30AgeNG8w8kd9yX9xiY75+6HCSwN79gRM+10rZIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=A5fjRckmFh3wBvBW/+7cFeUQ+W/ZMwRCbeEHvMK8s+WDYXym0x++8/1ORuQL9f39c
	 PCdaC3o3UDPZeRKo8jgK2eDpKu85M2Uj1PfQ7poTtIbuODt2kxxqrY5Z0+dBjAV5c2
	 baOCPDHA1w46KZCX64NoXlEpH4527+x9tVYgwrmMvijea2gBUkOe9YPdDvuEqUD7gv
	 3pdCSDeDHlMFA7vX9CFh/4XsB9OWlErKia/0aXlWbfpDB7yFg+2ZVwtRgZIV0R//Yc
	 cJ2DFjDXXXeT3dijxb1BEV7y0RzKV7ZaNG2ABDZdHfKMavrbaPocLrgtTGNAXzDUUX
	 /N1BiDVDvY5uQ==
Date: Thu, 20 Mar 2025 16:45:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Subject: Re: [PATCH v3 1/1] PCI: Fix BAR resizing when VF BARs are assigned
Message-ID: <20250320214544.GA1102414@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250320142837.8027-1-ilpo.jarvinen@linux.intel.com>

On Thu, Mar 20, 2025 at 04:28:37PM +0200, Ilpo Järvinen wrote:
> __resource_resize_store() attempts to release all resources of the
> device before attempting the resize. The loop, however, only covers
> standard BARs (< PCI_STD_NUM_BARS). If a device has VF BARs that are
> assigned, pci_reassign_bridge_resources() finds the bridge window still
> has some assigned child resources and returns -NOENT which makes
> pci_resize_resource() to detect an error and abort the resize.
> 
> Change the release loop to cover all resources up to VF BARs which
> allows the resize operation to release the bridge windows and attempt
> to assigned them again with the different size.
> 
> If SR-IOV is enabled, disallow resize as it requires releasing also IOV
> resources.
> 
> Fixes: 91fa127794ac ("PCI: Expose PCIe Resizable BAR support via sysfs")
> Reported-by: Michał Winiarski <michal.winiarski@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Replaced the v2 patch [1] on pci/resource, headed for v6.15, thanks!

[1] https://lore.kernel.org/r/20250307140349.5634-1-ilpo.jarvinen@linux.intel.com

> ---
> 
> v3:
> - Check that SR-IOV is not enabled before resizing
> 
> v2:
> - Removed language about expansion ROMs
> 
>  drivers/pci/pci-sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index b46ce1a2c554..0e7eb2a42d88 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1556,7 +1556,7 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
>  		return -EINVAL;
>  
>  	device_lock(dev);
> -	if (dev->driver) {
> +	if (dev->driver || pci_num_vf(pdev)) {
>  		ret = -EBUSY;
>  		goto unlock;
>  	}
> @@ -1578,7 +1578,7 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
>  
>  	pci_remove_resource_files(pdev);
>  
> -	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> +	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
>  		if (pci_resource_len(pdev, i) &&
>  		    pci_resource_flags(pdev, i) == flags)
>  			pci_release_resource(pdev, i);
> 
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> -- 
> 2.39.5
> 

