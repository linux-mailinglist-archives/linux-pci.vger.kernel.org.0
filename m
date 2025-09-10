Return-Path: <linux-pci+bounces-35808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3017FB517FB
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 15:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DFF01C85110
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 13:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856D3284B4C;
	Wed, 10 Sep 2025 13:33:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491AD268C40;
	Wed, 10 Sep 2025 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757511201; cv=none; b=vGMoHUhJKYj8Rbiln9IZIqI0p3xHdsWljxKOKOi+pPtkADCbpYxHhn72uAx+yeub0HtdT1tuWZbRqJGSTVCI+nuxd+9wAQQK/4oetO1A5yu87N5m8oeHYEGlJ5PGahxj32+X+tx0b/wHHEREGSg7Fhiznp4eMozvCAoddzSCZIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757511201; c=relaxed/simple;
	bh=mm8ZHp2llaxc5rR9/AJ1BbnRRUYcAIrw9QAjKCsusy8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rEBJX68qqOZ+vkPfiG7fEDEKTBzU5l6hqD+fzlL9oQobmxTPc+Z4aBPvrr7AYzH9Gy66VdJBHJ5XwjE8DYK4tzfUT6cKkw/wHEqzThFnpT8CUEtergU2p3aXUkaN1GWt5I4egp6wZcWRO6G6J4Cq63ElvZEnEbrjJEjaTeuNGEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cMM3P6PXfz6K5wF;
	Wed, 10 Sep 2025 21:29:05 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E0A81402F2;
	Wed, 10 Sep 2025 21:33:16 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 10 Sep
 2025 15:33:15 +0200
Date: Wed, 10 Sep 2025 14:33:14 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v11 21/23] CXL/PCI: Introduce CXL uncorrectable protocol
 error recovery
Message-ID: <20250910143314.0000147b@huawei.com>
In-Reply-To: <20250827013539.903682-22-terry.bowman@amd.com>
References: <20250827013539.903682-1-terry.bowman@amd.com>
	<20250827013539.903682-22-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 26 Aug 2025 20:35:36 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> Populate the cxl_do_recovery() function with uncorrectable protocol error (UCE)
> handling. Follow similar design as found in PCIe error driver,
> pcie_do_recovery(). One difference is cxl_do_recovery() will treat all UCEs
> as fatal with a kernel panic. This is to prevent corruption on CXL memory.
> 
> Introduce cxl_walk_port(). Make this analogous to pci_walk_bridge() but walking
> CXL ports instead. This will iterate through the CXL topology from the
> erroring device through the downstream CXL Ports and Endpoints.
> 
> Export pci_aer_clear_fatal_status() for CXL to use if a UCE is not found.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---
> Changes in v10->v11:
> - pci_ers_merge_results() - Move to earlier patch

One trivial formatting thing below.

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 536ca9c815ce..3da675f72616 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c

> +static void cxl_walk_port(struct device *port_dev,
> +			  int (*cb)(struct device *, void *),
> +			  void *userdata)
> +{
> +	struct cxl_dport *dport = NULL;
> +	struct cxl_port *port;
> +	unsigned long index;
> +
> +	if (!port_dev)
> +		return;
> +
> +	port = to_cxl_port(port_dev);
> +	if (port->uport_dev && dev_is_pci(port->uport_dev))
> +		cb(port->uport_dev, userdata);
> +
> +	xa_for_each(&port->dports, index, dport)
> +	{

	xa_for_each(&port->dports, index, dport) {

as it's just a fancy for loop.

> +		struct device *child_port_dev __free(put_device) =
> +			bus_find_device(&cxl_bus_type, &port->dev, dport,
> +					match_port_by_parent_dport);
> +
> +		cb(dport->dport_dev, userdata);
> +
> +		cxl_walk_port(child_port_dev, cxl_report_error_detected, userdata);
> +	}
> +
> +	if (is_cxl_endpoint(port))
> +		cb(port->uport_dev->parent, userdata);
> +}

