Return-Path: <linux-pci+bounces-24871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0549BA73A36
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 18:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17D1C188C275
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 17:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A72B218EA1;
	Thu, 27 Mar 2025 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ewc7R7lY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397101CAA67;
	Thu, 27 Mar 2025 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743095617; cv=none; b=AM6xPge+VtODJGsLtsxvD15E+v02c2aSqtuf8B9tBzo0EPiAXUKMvbaDIiLF6czxldVVdW004FEWOp7reTs3ZtwAvWhzXsmAyZQMTKaCIRPgPOmILVWa35pmivobJjQ6e4AW7GvOt8ry3VxdZa+gtu0uhKPGNwLSPoBXDOGXwLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743095617; c=relaxed/simple;
	bh=STwTYAcMIoUCtu5JwOrxBG0ls065VxHEEYzu4qhbO5U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LwetI9t57SPM1U3IdKY6MfnXJjVt6M+iCO8ZnNygikt+dnfmhhUd9N8ofuGw+mM3Nucw8dytrcMZBv+7UuAmb3do07xuB6Ltdx+xXC6K2Z0VAFlChGOY7ApbB2XJj8Mx7nA3vMDc9Ck+eAeEpjI5ZjBuBJnt4cnckimw2oh8D7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ewc7R7lY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAD8C4CEDD;
	Thu, 27 Mar 2025 17:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743095616;
	bh=STwTYAcMIoUCtu5JwOrxBG0ls065VxHEEYzu4qhbO5U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Ewc7R7lYDnxtDZy/g9J3sIWfgNBSykD0RWQ1ARA3etI3alb4tUl6+O82xgN6WMiTr
	 zfSWqkhD5Y1+jFjuBPfWi1FxLY5VxIucRU69Dwlmj4aSJq0E45KzMARev/SEKdLvo4
	 MXIHXHDzj91Xdtu7yuH5XMYmJ5X8MKjIySYFQvqDx8aBciaoTQM8uaspheiUA7EOAY
	 ftyXMQZge3KD0WCVxckRFBaq5KqYzgPj/GGLLUY4iJaOv9FBOWj6QfoG0hIlWlp0dA
	 7MUAviIecH5f4HwJ+DOkLMSet1x2fTTNu402pyEoxSdBZ0TxlMZ9+sCx1rajvUtClh
	 r3+WjjE3KMZSA==
Date: Thu, 27 Mar 2025 12:13:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
Subject: Re: [PATCH v8 04/16] cxl/aer: AER service driver forwards CXL error
 to CXL driver
Message-ID: <20250327171335.GA1436609@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327014717.2988633-5-terry.bowman@amd.com>

On Wed, Mar 26, 2025 at 08:47:05PM -0500, Terry Bowman wrote:
> The AER service driver includes a CXL-specific kfifo, intended to forward
> CXL errors to the CXL driver. However, the forwarding functionality is
> currently unimplemented. Update the AER driver to enable error forwarding
> to the CXL driver.
> 
> Modify the AER service driver's handle_error_source(), which is called from
> process_aer_err_devices(), to distinguish between PCIe and CXL errors.
> 
> Rename and update is_internal_error() to is_cxl_error(). Ensuring it
> checks both the 'struct aer_info::is_cxl' flag and the AER internal error
> masks.
> 
> If the error is a standard PCIe error then continue calling pcie_aer_handle_error()
> as done in the current AER driver.
> 
> If the error is a CXL-related error then forward it to the CXL driver for
> handling using the kfifo mechanism.
> 
> Introduce a new function forward_cxl_error(), which constructs a CXL
> protocol error context using cxl_create_prot_err_info(). This context is
> then passed to the CXL driver via kfifo using a 'struct work_struct'.

This only touches drivers/pci, so I would make the subject prefix be
"PCI/AER".

> +static void forward_cxl_error(struct pci_dev *_pdev, struct aer_err_info *info)
> +{
> +	int severity = info->severity;
> +	struct cxl_prot_err_work_data wd;
> +	struct cxl_prot_error_info *err_info = &wd.err_info;
> +	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(_pdev);
> +
> +	if (!cxl_create_prot_err_info) {
> +		pci_err(pdev, "Failed. CXL-AER interface not initialized.");
> +		return;
> +	}
> +
> +	if (cxl_create_prot_err_info(pdev, severity, err_info)) {
> +		pci_err(pdev, "Failed to create CXL protocol error information");
> +		return;
> +	}
> +
> +	struct device *cxl_dev __free(put_device) = get_device(err_info->dev);
> +
> +	if (!kfifo_put(&cxl_prot_err_fifo, wd)) {
> +		pr_err_ratelimited("CXL kfifo overflow\n");

Needs a dev identifier here to anchor the message to something.

> +		return;
> +	}
> +
> +	schedule_work(cxl_prot_err_work);
> +}

