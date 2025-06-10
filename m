Return-Path: <linux-pci+bounces-29270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F38AD2C81
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 06:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5898A16B70A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 04:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BA98F5B;
	Tue, 10 Jun 2025 04:15:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E0B747F;
	Tue, 10 Jun 2025 04:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749528936; cv=none; b=I7ypSoQ/IdzzR3zCUY0iyJPgPhWL98XQ9Vu8sZhwbEpXatXS/ZWFBpHpg3mQLBxcmSs2q6YpLmOdvgoUsD4L7uoucZYzpRKMQm4ahawlbaK6rXgGsfKM3gV82JLGvHV+aXcoQWi3EeaYOhcgc2mCT1fI+yCHsniYyNidbFwFuqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749528936; c=relaxed/simple;
	bh=llhOqEqb+waz6qtvUyFF2WI74JyhttJdc0ni7u0DfY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QU4qK5iEj2N1+NIcODhl9C8lGUdvv/Vpvj/N5amby+q19J3rVLqSRwCdGiw1FEqjrZhTrROVgyENS32C1I2hZCkrLq218jQk8kVCtGxSshmOjh1in5YAivlasMTKgZ8UjaDDNEweWMUF9nVYE4SywgAai/XBQZsaxJyPovVh15M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id D6F0B2009D03;
	Tue, 10 Jun 2025 06:15:30 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C1250366B3E; Tue, 10 Jun 2025 06:15:30 +0200 (CEST)
Date: Tue, 10 Jun 2025 06:15:30 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Terry Bowman <terry.bowman@amd.com>
Cc: PradeepVineshReddy.Kodamati@amd.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
	bp@alien8.de, ming.li@zohomail.com, shiju.jose@huawei.com,
	dan.carpenter@linaro.org, Smita.KoralahalliChannabasappa@amd.com,
	kobayashi.da-06@fujitsu.com, yanfei.xu@intel.com, rrichter@amd.com,
	peterz@infradead.org, colyli@suse.de, uaisheng.ye@intel.com,
	fabio.m.de.francesco@linux.intel.com, ilpo.jarvinen@linux.intel.com,
	yazen.ghannam@amd.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 04/16] PCI/AER: Dequeue forwarded CXL error
Message-ID: <aEexYj8uImRt0kr9@wunner.de>
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-5-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603172239.159260-5-terry.bowman@amd.com>

On Tue, Jun 03, 2025 at 12:22:27PM -0500, Terry Bowman wrote:
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> +static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
> +{
> +	struct cxl_prot_error_info *err_info = data;
> +	struct pci_dev *pdev_ref __free(pci_dev_put) = pci_dev_get(pdev);
> +	struct cxl_dev_state *cxlds;
> +
> +	/*
> +	 * The capability, status, and control fields in Device 0,
> +	 * Function 0 DVSEC control the CXL functionality of the
> +	 * entire device (CXL 3.0, 8.1.3).
> +	 */
> +	if (pdev->devfn != PCI_DEVFN(0, 0))
> +		return 0;
> +
> +	/*
> +	 * CXL Memory Devices must have the 502h class code set (CXL
> +	 * 3.0, 8.1.12.1).
> +	 */
> +	if ((pdev->class >> 8) != PCI_CLASS_MEMORY_CXL)
> +		return 0;
> +
> +	if (!is_cxl_memdev(&pdev->dev) || !pdev->dev.driver)
> +		return 0;

Is the point of the "!pdev->dev.driver" check to ascertain that
pdev is bound to cxl_pci_driver?

If so, you need to check "if (pdev->driver != &cxl_pci_driver)"
directly (like cxl_handle_cper_event() does).

That's because there are drivers which may bind to *any* PCI device,
e.g. vfio_pci_driver.

Thanks,

Lukas

