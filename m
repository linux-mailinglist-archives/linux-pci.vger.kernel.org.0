Return-Path: <linux-pci+bounces-3552-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A97C856F86
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 22:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66EF1C2165E
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 21:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556AE13DB87;
	Thu, 15 Feb 2024 21:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7YJtVAW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6396A349;
	Thu, 15 Feb 2024 21:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708033764; cv=none; b=YxPm4katsMX/q+fqFYiPSFNozYiWZknCQXiJ/+7ev2gqaOco6tgAK1eZkZGrSEwrpwYg3yZFRKHjKTTozxTGZ39LWzttx0HXb0F8eZ8AxRAMr1GDiA2odC85AMUKpeiKRyTIKCXbILsumG4O4Jm00EsTtQ6O455GfL7ouIeX8KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708033764; c=relaxed/simple;
	bh=EnXDx5tZ2XTa3uVyWR4zjNnpoHT5ApDfDUZsj5v9SqI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tauTt03Nrr2QmR4+QEUqunAz2uLpGU/dMJwaGC3vm15IA5Pc8qWal9tt8Dhm1/RrRWaX7B2s+5a0plbhoEnvh327eVHzgwJqY4inziUN+VLm1c5rN0+aiYT1AjsHYt4i//O+AH98IXZ3TyRGopeRdxSqAeVRtLy1H+vBKxNCAtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7YJtVAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657B7C433C7;
	Thu, 15 Feb 2024 21:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708033763;
	bh=EnXDx5tZ2XTa3uVyWR4zjNnpoHT5ApDfDUZsj5v9SqI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=r7YJtVAWFgSIzCn/IZQIgYmjyS01NbUbYk8qbDmEv2BIva0OxhYQCJp17ljqgfRVL
	 Xu2XK66hVf3uWO2/Bblsz6oo+MlElUWDuyrxpm9GL7iPVN1tOWWjZPXl0qnvkgO8N1
	 RU2J9Oa9gc6ltoUyZgmupaMcRni5VY7sSyq6bbGiHLPLcNv/tjFLQbgWispnHf0gfs
	 KMuQGlt6QolNfEMljyBz9wIOXB4pzazFhb7elZPr8EW0Qh8Q8Y//haPrJUWzZqdvp+
	 yLEO5bSEF38NEakVnjxHRDTdOx94B+jjT06nBuTuvUzzJI9oOThmjATT7UuFS74RVU
	 24v5ttL1f+EIg==
Date: Thu, 15 Feb 2024 15:49:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, bhelgaas@google.com
Subject: Re: [RFC PATCH 4/6] pcie/cxl_timeout: Add CXL.mem error isolation
 support
Message-ID: <20240215214921.GA1310551@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215194048.141411-5-Benjamin.Cheatham@amd.com>

On Thu, Feb 15, 2024 at 01:40:46PM -0600, Ben Cheatham wrote:
> Add and enable CXL.mem error isolation support (CXL 3.0 12.3.2)
> to the CXL Timeout & Isolation service driver.

> @@ -341,7 +366,8 @@ static int cxl_timeout_probe(struct pcie_device *dev)
>  	struct pci_dev *port = dev->port;
>  	struct pcie_cxlt_data *pdata;
>  	struct cxl_timeout *cxlt;
> -	int rc = 0;
> +	bool timeout_enabled;
> +	int rc;
>  
>  	/* Limit to CXL root ports */
>  	if (!pci_find_dvsec_capability(port, PCI_DVSEC_VENDOR_ID_CXL,
> @@ -360,6 +386,18 @@ static int cxl_timeout_probe(struct pcie_device *dev)
>  		pci_dbg(dev->port, "Failed to enable CXL.mem timeout: %d\n",
>  			rc);
>  
> +	timeout_enabled = !rc;

This ends up being a little weird: mixing int and bool, negating rc
here and then negating timeout_enabled later, several messages.

Maybe could just keep rc1 and rc2, drop the pci_dbg messages and
enhance the "enabled" message to be something like:
"enabled %s%s with IRQ", rc1 ? "" : "timeout", rc2 ? "" : "isolation"
("&" left for your imagination).

Or something like
#define FLAG(x) ((x) ? '-' : '+')
"CXL.mem timeout%c isolation%c enabled with IRQ %d", FLAG(rc1), FLAG(rc2)

> +	rc = cxl_enable_isolation(dev, cxlt);

> +	if (rc)
> +		pci_dbg(dev->port, "Failed to enable CXL.mem isolation: %d\n",
> +			rc);

"(%pe)"

> +	if (rc && !timeout_enabled) {
> +		pci_info(dev->port,
> +			 "Failed to enable CXL.mem timeout and isolation.\n");

Most messages don't include a period at end.  It just adds the chance
for line wrapping unnecessarily.

