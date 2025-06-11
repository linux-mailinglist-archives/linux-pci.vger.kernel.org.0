Return-Path: <linux-pci+bounces-29392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D691EAD4A1A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 06:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05DBC189CE3C
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 04:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38871DB346;
	Wed, 11 Jun 2025 04:39:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12D417E;
	Wed, 11 Jun 2025 04:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749616745; cv=none; b=rRM1Gba9SnMRFnmHDB5Lo+t0k25gwzPTIoOccxS/BUCUhE9UN4VMA+88t4u7lSNQuWnUrOWv8I/UOGanD/GD6HmdoTinuAH3Atv9xjOwnGed2hEERMolYZ6N+Ep9YeQ+leQu3x5KyAIU0LbLeM2dC6hjuFyHyseDw47/jsNEi60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749616745; c=relaxed/simple;
	bh=DZA6rpZMGkpvSVloY9xR5fbblgafaczRjmes4Ie6mKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byBGj6oyVKkLUrVkirzpBuiaOtIua42B5HzwKdIfOD3q+dKAaZHUgkEJBDshuJPMUgWaQ6vHNvcAk6CV8iLHd6apGMYd9owYcBS55Q++UgQLLsO3uC0aRBrnnYI6L74qNAL3osDhc2wsooxPo2PNrAK8zK8u2pup9feZ0sxFgM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 268772C02510;
	Wed, 11 Jun 2025 06:38:54 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0DE541FB9E; Wed, 11 Jun 2025 06:38:54 +0200 (CEST)
Date: Wed, 11 Jun 2025 06:38:54 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
	bp@alien8.de, ming.li@zohomail.com, shiju.jose@huawei.com,
	dan.carpenter@linaro.org, Smita.KoralahalliChannabasappa@amd.com,
	kobayashi.da-06@fujitsu.com, rrichter@amd.com, peterz@infradead.org,
	fabio.m.de.francesco@linux.intel.com, ilpo.jarvinen@linux.intel.com,
	yazen.ghannam@amd.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 04/16] PCI/AER: Dequeue forwarded CXL error
Message-ID: <aEkIXiM3jaCvKw3o@wunner.de>
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-5-terry.bowman@amd.com>
 <aEexYj8uImRt0kr9@wunner.de>
 <aad4372e-d73b-47f9-9736-31dc1e6e03b0@amd.com>
 <a602603b-e075-46a1-a4bf-3653954faa08@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a602603b-e075-46a1-a4bf-3653954faa08@amd.com>

On Tue, Jun 10, 2025 at 04:20:53PM -0500, Bowman, Terry wrote:
> On 6/10/2025 1:07 PM, Bowman, Terry wrote:
> > On 6/9/2025 11:15 PM, Lukas Wunner wrote:
> >> On Tue, Jun 03, 2025 at 12:22:27PM -0500, Terry Bowman wrote:
> >>> --- a/drivers/cxl/core/ras.c
> >>> +++ b/drivers/cxl/core/ras.c
> >>> +static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
> >>> +{
> >>> +	struct cxl_prot_error_info *err_info = data;
> >>> +	struct pci_dev *pdev_ref __free(pci_dev_put) = pci_dev_get(pdev);
> >>> +	struct cxl_dev_state *cxlds;
> >>> +
> >>> +	/*
> >>> +	 * The capability, status, and control fields in Device 0,
> >>> +	 * Function 0 DVSEC control the CXL functionality of the
> >>> +	 * entire device (CXL 3.0, 8.1.3).
> >>> +	 */
> >>> +	if (pdev->devfn != PCI_DEVFN(0, 0))
> >>> +		return 0;
> >>> +
> >>> +	/*
> >>> +	 * CXL Memory Devices must have the 502h class code set (CXL
> >>> +	 * 3.0, 8.1.12.1).
> >>> +	 */
> >>> +	if ((pdev->class >> 8) != PCI_CLASS_MEMORY_CXL)
> >>> +		return 0;
> >>> +
> >>> +	if (!is_cxl_memdev(&pdev->dev) || !pdev->dev.driver)
> >>> +		return 0;
> >>
> >> Is the point of the "!pdev->dev.driver" check to ascertain that
> >> pdev is bound to cxl_pci_driver?
> >>
> >> If so, you need to check "if (pdev->driver != &cxl_pci_driver)"
> >> directly (like cxl_handle_cper_event() does).
> >>
> >> That's because there are drivers which may bind to *any* PCI device,
> >> e.g. vfio_pci_driver.
> 
> Looking closer to implement this change I find the cxl_pci_driver is
> defined static in cxl/pci.c and is unavailable to reference in
> cxl/core/ras.c as-is. Would you like me to export cxl_pci_driver to
> make available for this check?

I'm not sure you need an export.  The consumer you're introducing
is located in core/ras.c, which is always built-in, never modular,
hence just making it non-static and adding a declaration to cxlpci.h
may be sufficient.

An alternative would be to keep it static, but add a non-static helper
cxl_pci_drv_bound() or something like that.

I'm passing the buck to CXL maintainers for this. :)

> The existing class code check guarantees it is a CXL EP. Is it not
> safe to expect it is bound to a the CXL driver?

Just checking for the pci_dev being bound seems insufficient to me
because of the vfio_pci_driver case and potentially others.

HTH,

Lukas

