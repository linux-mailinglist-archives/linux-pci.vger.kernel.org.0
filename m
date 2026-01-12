Return-Path: <linux-pci+bounces-44549-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2ABD14E9E
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 20:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 235293031CF1
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 19:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3710D31B833;
	Mon, 12 Jan 2026 19:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LZEyCo93"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359DB31ED80;
	Mon, 12 Jan 2026 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768245779; cv=none; b=oVQh5XhschZXCo4kyU+4D3nl1v6Q+m5u9IgMh/wLECYcBeyNp5/2GOfsKQEYW+F+/1Vr021akap5PmvwJXo/DXwbYs0wXtQ+BDjYioJvI7AQDalA8WzKsqJuulMsvJWwJ/Wfm2So+7d/KDkU+c6lJb2egN1SGX5hw1HK/JvN/BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768245779; c=relaxed/simple;
	bh=ZhRs7xnPZSV6XzTqCAD9BCDygo93shWOqBF0P1AaaRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzOFyZHnRzDFLzhHMao+5LGyKiTVJKN8/hKH217f4bkEZrHyjxEXXtjegcwzPrje9efqBca8DsG/ia/cQukeT7yvBagdE14eEgrF6ZWEWCC/ZJB+vYLv/+BN9bl57B7++/f86AexhMQ85R4RCh3Iflpq1BO+Qr0BfSaqtoXCpyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LZEyCo93; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768245768; x=1799781768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZhRs7xnPZSV6XzTqCAD9BCDygo93shWOqBF0P1AaaRE=;
  b=LZEyCo93wnXyTfQbLqFQg0VpXsXl8PqF7X2A6MLtmiKMTbw2BO8U+MSt
   dRXBqLL3n+4ZsfsVnv1QbOo/sk+abxPg9r89OI2gWeho20fSIICb+8Oa5
   a2pJ3MA2CqyYw5j4y6CjDEszz8t+Y4a8Bxp1iZW2V3dG5Wp/aPsRwdffC
   lhunireMdavEvJ+suCtRKmeVgA0HrTVteOA80aBDbj0eUrdo29RN6J/od
   pOi/nyE679ci6KhBOrvruykiDBJMHdh+RMcOeunnU1nxK9ZYebMEC1mBq
   otT6lyAgjYEWJDDXP2a+8/R8Npq6Gfv8pQEDuL2FwK/We+c17Fd5vzRWh
   g==;
X-CSE-ConnectionGUID: M1qEcAmqSamuh7M1v4oe2g==
X-CSE-MsgGUID: 9l0OgbWyQUO7Mk6WGs7k4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="95004014"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="95004014"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 11:22:47 -0800
X-CSE-ConnectionGUID: /POQ5LCQRMmFK2RRBMq4iA==
X-CSE-MsgGUID: sRBvAVgdRVW3CVbcLKyFvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="208690532"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.37])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 11:22:40 -0800
Date: Mon, 12 Jan 2026 21:22:38 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 9/9] power: sequencing: pcie-m2: Create serdev device
 for WCN7850 bluetooth
Message-ID: <aWVJ_ncUkAYswE3W@smile.fi.intel.com>
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
 <20260112-pci-m2-e-v4-9-eff84d2c6d26@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112-pci-m2-e-v4-9-eff84d2c6d26@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 12, 2026 at 09:56:08PM +0530, Manivannan Sadhasivam via B4 Relay wrote:

> For supporting bluetooth over the non-discoverable UART interface of
> WCN7850, create the serdev device after enumerating the PCIe interface.
> This is mandatory since the device ID is only known after the PCIe
> enumeration and the ID is used for creating the serdev device.
> 
> Since by default there is no OF or ACPI node for the created serdev,
> create a dynamic OF 'bluetooth' node with the 'compatible' property and
> attach it to the serdev device. This will allow the serdev device to bind
> to the existing bluetooth driver.

...

> +static int pwrseq_m2_pcie_notify(struct notifier_block *nb, unsigned long action,
> +			      void *data)
> +{
> +	struct pwrseq_pcie_m2_ctx *ctx = container_of(nb, struct pwrseq_pcie_m2_ctx, nb);
> +	struct pci_dev *pdev = to_pci_dev(data);
> +	struct serdev_controller *serdev_ctrl;
> +	struct device *dev = ctx->dev;
> +	struct device_node *pci_parent;
> +	int ret;
> +
> +	/*
> +	 * Check whether the PCI device is associated with this M.2 connector or
> +	 * not, by comparing the OF node of the PCI device parent and the Port 0
> +	 * (PCIe) remote node parent OF node.
> +	 */
> +	pci_parent = of_graph_get_remote_node(dev_of_node(ctx->dev), 0, 0);

> +	if (!pci_parent || (pci_parent != pdev->dev.parent->of_node)) {

!device_match_of_node()

> +		of_node_put(pci_parent);
> +		return NOTIFY_DONE;
> +	}
> +	of_node_put(pci_parent);
> +
> +	switch (action) {
> +	case BUS_NOTIFY_ADD_DEVICE:
> +		/* Create serdev device for WCN7850 */
> +		if (pdev->vendor == PCI_VENDOR_ID_QCOM && pdev->device == 0x1107) {
> +			struct device_node *serdev_parent __free(device_node) =
> +				of_graph_get_remote_node(dev_of_node(ctx->dev), 1, 1);
> +			if (!serdev_parent)
> +				return NOTIFY_DONE;
> +
> +			serdev_ctrl = of_find_serdev_controller_by_node(serdev_parent);
> +			if (!serdev_ctrl)
> +				return NOTIFY_DONE;
> +
> +			ctx->serdev = serdev_device_alloc(serdev_ctrl);
> +			if (!ctx->serdev)
> +				return NOTIFY_BAD;
> +
> +			ret = pwrseq_m2_pcie_create_bt_node(ctx, serdev_parent);
> +			if (ret) {
> +				serdev_device_put(ctx->serdev);
> +				return notifier_from_errno(ret);
> +			}
> +
> +			ret = serdev_device_add(ctx->serdev);
> +			if (ret) {
> +				dev_err(dev, "Failed to add serdev for WCN7850: %d\n", ret);
> +				of_changeset_revert(ctx->ocs);
> +				of_changeset_destroy(ctx->ocs);
> +				serdev_device_put(ctx->serdev);
> +				return notifier_from_errno(ret);
> +			}
> +		}
> +		break;
> +	case BUS_NOTIFY_REMOVED_DEVICE:
> +		/* Destroy serdev device for WCN7850 */
> +		if (pdev->vendor == PCI_VENDOR_ID_QCOM && pdev->device == 0x1107) {
> +			serdev_device_remove(ctx->serdev);
> +			of_changeset_revert(ctx->ocs);
> +			of_changeset_destroy(ctx->ocs);
> +		}
> +		break;
> +	}
> +
> +	return NOTIFY_OK;
> +}

-- 
With Best Regards,
Andy Shevchenko



