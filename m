Return-Path: <linux-pci+bounces-42782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69011CAE00C
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 19:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 848BF3089E16
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 18:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E952D7802;
	Mon,  8 Dec 2025 18:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwoWX0Y6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082C516DEB1;
	Mon,  8 Dec 2025 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765218965; cv=none; b=EMyNqY/4AwNk+v+dJfBosoIQesr0xIhILA9t35ajZbOwiK5wpWcXaCDU+2estCy/gOlDWJWK7x9CAl5CkAR1TcvnsQOUL7THAwKbTugCfuH0bXiX/BZFExRUnPMJAGrGhJTbt7l9ZmgQgiTa3iVfDVyFrZrer/CG6rbXe+VlSEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765218965; c=relaxed/simple;
	bh=e6oEN7mUZHL5X67H4xZvg4LsfepLTw1LPUGIpN5xYqU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sxMmdmgyRT4lUhNJxsA88wFmP6oOadMBjGKjumv2Cjvnw+zEGA03MsXwqGGiD/Pkt1RFdx7ZAxj+CBPN1Hl4gdR0aNqC/brFmA37J+SEuFwLROq1n2FokAiwwf3VhgWoFMnZ57FbZ3x2iwJfrCatmXL04swhBrpEe/I/quBb57Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwoWX0Y6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825D9C4CEF1;
	Mon,  8 Dec 2025 18:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765218964;
	bh=e6oEN7mUZHL5X67H4xZvg4LsfepLTw1LPUGIpN5xYqU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GwoWX0Y6mcvyRcOpyZT5cQxnSsGYeSwS4qdGKs4bSNGhxrGkMhgDlVZ/H23RMKmDU
	 1QbjHK+AhnoelYEBdCI3JJXUeHEn3sCInsMfkAItv44wMbdDRa9abOSGwld9KPWir0
	 rm40XirxB/nq2kDJsgSDruZJxMfMMJmlfDgnVVKFCaIWC/xkQ1nAD4+C/u3H/ABf8G
	 v3vJioojWqwg/oQ9geX15xna8ii6T/78uqnjqEWH1R0z6/Vx2pehLGxYyePC0K8LfH
	 ZURWK1NfnUeKFbR5B8Y93QxssMg0e7Cirrud5jJQwi06CjbSX50c/hkewJCdKA8BJ1
	 Ika9JppXJiWjw==
Date: Mon, 8 Dec 2025 12:36:03 -0600
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
Subject: Re: [PATCH v13 16/25] CXL/AER: Introduce pcie/aer_cxl_vh.c in AER
 driver for forwarding CXL errors
Message-ID: <20251208183603.GA3302185@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104001001.3833651-17-terry.bowman@amd.com>

Maybe:

  PCI/AER: Add CXL error forwarding in aer_cxl_vh.c

On Mon, Nov 03, 2025 at 06:09:52PM -0600, Terry Bowman wrote:
> CXL virtual hierarchy (VH) RAS handling for CXL Port devices will be added
> soon. This requires a notification mechanism for the AER driver to share
> the AER interrupt with the CXL driver. The notification will be used as an
> indication for the CXL drivers to handle and log the CXL RAS errors.
> 
> Note, 'CXL protocol error' terminology will refer to CXL VH and not
> CXL RCH errors unless specifically noted going forward.
> 
> Introduce a new file in the AER driver to handle the CXL protocol errors
> named pci/pcie/aer_cxl_vh.c.
> 
> Add a kfifo work queue to be used by the AER and CXL drivers. The AER
> driver will be the sole kfifo producer adding work and the cxl_core will be
> the sole kfifo consumer removing work. Add the boilerplate kfifo support.
> Encapsulate the kfifo, RW semaphore, and work pointer in a single structure.
> 
> Add CXL work queue handler registration functions in the AER driver. Export
> the functions allowing CXL driver to access. Implement registration
> functions for the CXL driver to assign or clear the work handler function.
> Synchronize accesses using the RW semaphore.
> 
> Introduce 'struct cxl_proto_err_work_data' to serve as the kfifo work data.
> This will contain a reference to the erring PCI device and the error
> severity. This will be used when the work is dequeued by the cxl_core driver.

s/erring PCI device/PCI error source device/

> +bool cxl_error_is_native(struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> +
> +	return (pcie_ports_native || host->native_aer);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_error_is_native, "CXL");

I don't see modular callers of any of these that would require
EXPORT().

> +++ b/include/linux/aer.h
> @@ -10,6 +10,7 @@
>  
>  #include <linux/errno.h>
>  #include <linux/types.h>
> +#include <linux/workqueue_types.h>

Looks like "struct work_struct;" would be sufficient without including
linux/workqueue_types.h.

> +struct cxl_proto_err_work_data {
> +	int severity;
> +	struct pci_dev *pdev;

Is there a reason to order them this way?  I would have put the pdev
pointer first because it's the more general part and might result in
better alignment in memory.

