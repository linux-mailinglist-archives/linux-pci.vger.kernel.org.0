Return-Path: <linux-pci+bounces-21351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 891CEA3427B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 15:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2BD41886848
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 14:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92A328382;
	Thu, 13 Feb 2025 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5Q2IoWj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1CF281341;
	Thu, 13 Feb 2025 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457266; cv=none; b=YRRelRcj50de8MstzCqikwEQ1O+tCT7r29C0o+CeAdDGGR4dpkMk+phJ1+m4tl9bitqm18d6Lp4WP/WwHUqa/ajYmHsxgXHKnTrI2HSudHZSfa6dLH9Kmn7NHFu3VR2gfYpGr4/OI4PZyM2WesCGhJVCA+dKnFtF4ayo92ACIcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457266; c=relaxed/simple;
	bh=x9esiaGq0KK2qewu87bHS3Bit8mLr73xNbk4rWWChKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGzoeKWB19eRwvH/yhfBsZaZ2zL1xOYbE3mKUWmz9wljxjU/z6pKF6helrZ0ssUEZEf50pShrBJ899dEXCApXDP4fHlR4L2etG/dT1aq1GPelUlCpB9qQR4XJOv3qv2tLdRQGGcjRm1nYVbWOREFzhh2jaLhf8cpsutEAjX2o3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5Q2IoWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D77C4CEE7;
	Thu, 13 Feb 2025 14:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739457266;
	bh=x9esiaGq0KK2qewu87bHS3Bit8mLr73xNbk4rWWChKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z5Q2IoWjfOynnESM6yPsukIJs9UG7UgPVA9SZHtmsMk+3lplnYggDYx4hcy5DMM63
	 wlA1aUM+jPufjIgVLgH+9dknto67zahYpd+1s4iRousCKmfExM7HFPbHc5BdBFoaK8
	 Rfoc9kbZDknt/9Zz6eqAsKfmr7oPPRgSUkleUquqGUWh0rYE5F8XNy5JgOCI+pIlRH
	 aPT4ZnJQ2nKPGmOVP+h0gEttCFn04mp7/c3SqeC7AFzPkFH8uuEGC+HxJ8/6w1jq0f
	 5mHCHzstuEYRA0OHLhaQT30WRLnrYdgXPuRonn+Eq9nNDBet0jGwm8d9yaA6FnczJn
	 OdguZOtp8h4sw==
Date: Thu, 13 Feb 2025 15:34:21 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: jingoohan1@gmail.com, shradha.t@samsung.com,
	manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rockswang7@gmail.com
Subject: Re: [v2] PCI: dwc: Add the debugfs property to provide the LTSSM
 status of the PCIe link
Message-ID: <Z64C7dzY3J7hCbZy@ryzen>
References: <20250206151343.26779-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206151343.26779-1-18255117159@163.com>

On Thu, Feb 06, 2025 at 11:13:43PM +0800, Hans Zhang wrote:
> Add the debugfs property to provide a view of the current link's LTSSM
> status from the root port device.
> 
>   /sys/kernel/debug/dwc_pcie_<dev>/ltssm_status
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
> Changes since v1:
> https://lore.kernel.org/linux-pci/20250123071326.1810751-1-18255117159@163.com/
> 
> - Do not place into sysfs node as recommended by maintainer. Shradha-based patch
>   is put into debugfs.
> - Submissions based on the following patches:
> https://patchwork.kernel.org/project/linux-pci/patch/20250121111421.35437-2-shradha.t@samsung.com/
> https://patchwork.kernel.org/project/linux-pci/patch/20250121111421.35437-3-shradha.t@samsung.com/
> https://patchwork.kernel.org/project/linux-pci/patch/20250121111421.35437-4-shradha.t@samsung.com/
> https://patchwork.kernel.org/project/linux-pci/patch/20250121111421.35437-5-shradha.t@samsung.com/
> ---
>  Documentation/ABI/testing/debugfs-dwc-pcie    |  6 ++
>  .../controller/dwc/pcie-designware-debugfs.c  | 70 ++++++++++++++++---
>  .../pci/controller/dwc/pcie-designware-ep.c   |  4 +-
>  .../pci/controller/dwc/pcie-designware-host.c | 54 +++++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.h  | 43 ++++++++++--
>  5 files changed, 159 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/debugfs-dwc-pcie b/Documentation/ABI/testing/debugfs-dwc-pcie
> index d3f84f46b400..bf0116012175 100644
> --- a/Documentation/ABI/testing/debugfs-dwc-pcie
> +++ b/Documentation/ABI/testing/debugfs-dwc-pcie
> @@ -142,3 +142,9 @@ Description:	(RW) Some lanes in the event list are lane specific events. These i
>  		events 1) - 11) and 34) - 35).
>  		Write lane number for which counter needs to be enabled/disabled/dumped.
>  		Read will return the current selected lane number. Lane0 is selected by default.
> +
> +What:		/sys/kernel/debug/dwc_pcie_<dev>/ltssm_status
> +Date:		February 2025
> +Contact:	Hans Zhang <18255117159@163.com>
> +Description:	(RO) Read will return the current value of the PCIe link status raw value and
> +		string status.
> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> index 5d883b13be84..ddfb854aa684 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> @@ -465,7 +465,7 @@ static const struct file_operations dwc_pcie_counter_value_ops = {
>  	.read = counter_value_read,
>  };
>  
> -void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
> +static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
>  {
>  	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
>  
> @@ -473,13 +473,12 @@ void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
>  	mutex_destroy(&rinfo->reg_lock);
>  }
>  
> -int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci)
> +static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
>  {
> -	struct dentry *dir, *rasdes_debug, *rasdes_err_inj, *rasdes_event_counter, *rasdes_events;
> +	struct dentry *rasdes_debug, *rasdes_err_inj, *rasdes_event_counter, *rasdes_events;
>  	struct dwc_pcie_rasdes_info *rasdes_info;
>  	struct dwc_pcie_rasdes_priv *priv_tmp;
>  	const struct dwc_pcie_vendor_id *vid;
> -	char dirname[DWC_DEBUGFS_BUF_MAX];
>  	struct device *dev = pci->dev;
>  	int ras_cap, i, ret;
>  
> @@ -498,12 +497,6 @@ int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci)
>  	if (!rasdes_info)
>  		return -ENOMEM;
>  
> -	/* Create main directory for each platform driver */
> -	snprintf(dirname, DWC_DEBUGFS_BUF_MAX, "dwc_pcie_%s", dev_name(dev));
> -	dir = debugfs_create_dir(dirname, NULL);
> -	if (IS_ERR(dir))
> -		return PTR_ERR(dir);
> -
>  	/* Create subdirectories for Debug, Error injection, Statistics */
>  	rasdes_debug = debugfs_create_dir("rasdes_debug", dir);
>  	rasdes_err_inj = debugfs_create_dir("rasdes_err_inj", dir);
> @@ -559,3 +552,60 @@ int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci)
>  	dwc_pcie_rasdes_debugfs_deinit(pci);
>  	return ret;
>  }
> +
> +static int dwc_pcie_ltssm_status_show(struct seq_file *s, void *v)
> +{
> +	struct dw_pcie *pci = s->private;
> +	enum dw_pcie_ltssm val;
> +
> +	val = dw_pcie_get_ltssm(pci);
> +	seq_printf(s, "%s (0x%02x)\n", dw_ltssm_sts_string(val), val);
> +
> +	return 0;
> +}
> +
> +static int dwc_pcie_ltssm_status_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, dwc_pcie_ltssm_status_show, inode->i_private);
> +}
> +
> +static const struct file_operations dwc_pcie_ltssm_status_ops = {
> +	.open = dwc_pcie_ltssm_status_open,
> +	.read = seq_read,
> +};
> +
> +static void dwc_pcie_ltssm_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
> +{
> +	debugfs_create_file("ltssm_status", 0444, dir, pci,
> +			    &dwc_pcie_ltssm_status_ops);
> +}
> +
> +void dwc_pcie_debugfs_deinit(struct dw_pcie *pci)
> +{
> +	dwc_pcie_rasdes_debugfs_deinit(pci);
> +	debugfs_remove_recursive(pci->debugfs);
> +}
> +
> +int dwc_pcie_debugfs_init(struct dw_pcie *pci)
> +{
> +	char dirname[DWC_DEBUGFS_BUF_MAX];
> +	struct device *dev = pci->dev;
> +	struct dentry *dir;
> +	int ret;
> +
> +	/* Create main directory for each platform driver */
> +	snprintf(dirname, DWC_DEBUGFS_BUF_MAX, "dwc_pcie_%s", dev_name(dev));
> +	dir = debugfs_create_dir(dirname, NULL);
> +	if (IS_ERR(dir))
> +		return PTR_ERR(dir);
> +
> +	pci->debugfs = dir;
> +	ret = dwc_pcie_rasdes_debugfs_init(pci, dir);
> +	if (ret)
> +		dev_dbg(dev, "rasdes debugfs init failed\n");
> +
> +	dwc_pcie_ltssm_debugfs_init(pci, dir);
> +
> +	return 0;
> +}
> +

Stray newline here.
This causes:

/home/nks/src/linux/.git/worktrees/linux-scratch/rebase-apply/patch:136: new blank line at EOF.
+
warning: 1 line adds whitespace errors.

when doing git am.


Also, this patch does not apply anymore, because of a conflict introduce by:
112aba9a7934 ("PCI: dwc: Remove LTSSM state test in dw_pcie_suspend_noirq()")

Which added:
+       DW_PCIE_LTSSM_DETECT_WAIT = 0x6,
to drivers/pci/controller/dwc/pcie-designware.h


Kind regards,
Niklas

