Return-Path: <linux-pci+bounces-40282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6DCC32B1E
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 19:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5CC4239E7
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 18:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C1985C4A;
	Tue,  4 Nov 2025 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNAcaMEW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104F51E89C;
	Tue,  4 Nov 2025 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281924; cv=none; b=I3gc1IiH6V+J2MIQaL2k36MfrQEsxZTXrflv5jUnwmus3Y4Qc5cWHXlq8A65T3qRIeEYJN/B5q67cNxiAWZnPVSvP1+X2ZHOvam6yILxP2kPTeO3pKc5Rqsg9+eeOwd/tKOKUt/t8WEl/u55E1cKXN4bsP0wHaCj5lSsFZPtwKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281924; c=relaxed/simple;
	bh=j6DHQwND3B/wVmd9hSP3uuycWTXBOPVHkm4Vo4PaQ4c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nNd5k65j7VZzOfF1ftCOf9Mva/ROvZF0esXV/O39tWS+rBdhBZ1BJxTmBbe1t1eg/tZzMrNRSirsqORy5oANK892ZnAwxlxs/vkU8xpOcwJnYl+kKJEJYenVdn7a+0snp21J+Xyi7hL2jShSSRxnxRsocsD4huAy0e0dHqlY1Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNAcaMEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663F9C4CEF7;
	Tue,  4 Nov 2025 18:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762281923;
	bh=j6DHQwND3B/wVmd9hSP3uuycWTXBOPVHkm4Vo4PaQ4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KNAcaMEWBQ+9YMlrPq5L7n+Kdg2USDJBeqiplJuNMF5X5gpn61RmbRxqqg84q+5Pe
	 +gtvYI07oqwCuFSVsPOzF6mIJAApsyTyPw3zAvuS/h5W51WY56jiOOJuPEhLQEKKbv
	 pp/MbL6gE0kSBQS000Ukp4x+NcZojHUWwjUyfFPPhYbod6g2lGc1FhVN/jycOtpCHI
	 dUL2HlAflmfmp/plSHH13ZgU2kMWKgL/p6DJ5BkQieANg8RaNl6kQDXyoaRJxfT3yk
	 zEzPDTtbKSstY5WeBNtOFC6Prafze6PO48bdL8MlUiqU2tNUAqV4HfInttqDEgMDZW
	 RQ+EuiBovIXaA==
Date: Tue, 4 Nov 2025 12:45:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND v13 21/25] PCI/AER: Dequeue forwarded CXL error
Message-ID: <20251104184522.GA1864503@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104170305.4163840-22-terry.bowman@amd.com>

On Tue, Nov 04, 2025 at 11:03:01AM -0600, Terry Bowman wrote:
> The AER driver now forwards CXL protocol errors to the CXL driver via a
> kfifo. The CXL driver must consume these work items, initiate protocol
> error handling, and ensure RAS mappings remain valid throughout processing.
> 
> Implement cxl_proto_err_work_fn() to dequeue work items forwarded by the
> AER service driver and begin protocol error processing by calling
> cxl_handle_proto_error().
> 
> Add a PCI device lock on &pdev->dev within cxl_proto_err_work_fn() to
> keep the PCI device structure valid during handling. Locking an Endpoint
> will also defer RAS unmapping until the device is unlocked.
> 
> For Endpoints, add a lock on CXL memory device cxlds->dev. The CXL memory
> device structure holds the RAS register reference needed during error
> handling.
> 
> Add lock for the parent CXL Port for Root Ports, Downstream Ports, and
> Upstream Ports to prevent destruction of structures holding mapped RAS
> addresses while they are in use.
> 
> Invoke cxl_do_recovery() for uncorrectable errors. Treat this as a stub for
> now; implement its functionality in a future patch.
> 
> Export pci_clean_device_status() to enable cleanup of AER status following
> error handling.

s/pci_clean_device_status/pcie_clear_device_status/

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

>  drivers/cxl/core/ras.c | 153 ++++++++++++++++++++++++++++++++++++++---
>  drivers/pci/pci.c      |   1 +
>  drivers/pci/pci.h      |   1 -
>  include/linux/pci.h    |   2 +

Looks like this is primarily a CXL change, and the PCI part is
minimal, so I question the "PCI/AER:" prefix in the subject.

> +static struct cxl_port *get_cxl_port(struct pci_dev *pdev)
> +{
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +	{
> +		struct cxl_dport *dport;
> +		struct cxl_port *port = find_cxl_port(&pdev->dev, &dport);
> +
> +		if (!port) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +		return port;
> +	}
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	{
> +		struct cxl_port *port = find_cxl_port_by_uport(&pdev->dev);
> +
> +		if (!port) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +		return port;
> +	}
> +	case PCI_EXP_TYPE_ENDPOINT:
> +	{
> +		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +		struct cxl_port *port = cxlds->cxlmd->endpoint;
> +
> +		get_device(&port->dev);
> +		return port;
> +	}
> +	}
> +	pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));

Maybe use "%#x" so it's clear that this is hex?  PCI typically uses
lower-case hex; maybe the CXL convention is different.

> +static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
> +{
> +	struct pci_dev *pdev = err_info->pdev;
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +
> +	if (err_info->severity == AER_CORRECTABLE) {
> +
> +		if (pdev->aer_cap)
> +			pci_clear_and_set_config_dword(pdev,
> +						       pdev->aer_cap + PCI_ERR_COR_STATUS,
> +						       0, PCI_ERR_COR_INTERNAL);
> +
> +		if (is_pcie_endpoint(pdev))
> +			cxl_cor_error_detected(&cxlds->cxlmd->dev);
> +		else
> +			cxl_port_cor_error_detected(&pdev->dev);
> +
> +		pcie_clear_device_status(pdev);

The AER clear above and pcie_clear_device_status() require
ownership of the PCIe Capability and the AER Capability, typically
granted by _OSC.

I suppose it's obvious that the OS does own these Capabilities if we
get here, but I'm not familiar with this code.


