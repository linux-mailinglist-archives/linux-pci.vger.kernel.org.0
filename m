Return-Path: <linux-pci+bounces-30917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90786AEB60B
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 13:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8D71884F9D
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 11:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EE8280CF6;
	Fri, 27 Jun 2025 11:12:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3D626B77D;
	Fri, 27 Jun 2025 11:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751022746; cv=none; b=MQIVec06Xobz9c4z+HYBqHz5zIi6/0iO3mIVb84tZ0h3ehFwH662dboGUuZ333bC5q1G2TpTbGlF6MVi/k3ewtaQfgR649z/Av0k6wl18uGshZGNT5Nl5hDRfk7t/Mep00rpE7jfTu7iGKy+msJMNGHShAc4eYptgSCSAnDtjaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751022746; c=relaxed/simple;
	bh=LPvj6lgt5p03KqH9T4eWKI+qTbEPZgCvTOfVOzdyN6w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXsD0+kvtsDPkxDlJPI5aGng7w8zafeGzbKGoKxCtMiY6Ru8D6Z0UfFefiOkfZb07amIfbJmff9cBdA5+PSzJjvOK2kBDRs/b3EvbL3KjIze9OQMLekGpPFZNJvDaA4AAJONfqfleqa4Q4f2bUryxSoeX5Uvev8WZ7OrlCFbMfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bTCYK205mz6M4VJ;
	Fri, 27 Jun 2025 19:11:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CFE4D14011D;
	Fri, 27 Jun 2025 19:12:21 +0800 (CST)
Received: from localhost (10.48.153.213) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 27 Jun
 2025 13:12:20 +0200
Date: Fri, 27 Jun 2025 12:12:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v10 08/17] cxl/pci: Move RAS initialization to cxl_port
 driver
Message-ID: <20250627121219.00005068@huawei.com>
In-Reply-To: <20250626224252.1415009-9-terry.bowman@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
	<20250626224252.1415009-9-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 26 Jun 2025 17:42:43 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The cxl_port driver is intended to manage CXL Endpoint Ports and CXL Switch
> Ports. Move existing RAS initialization to the cxl_port driver.
> 
> Restricted CXL Host (RCH) Downstream Port RAS initialization currently
> resides in cxl/core/pci.c. The PCI source file is not otherwise associated
> with CXL Port management.
> 
> Additional CXL Port RAS initialization will be added in future patches to
> support a CXL Port device's CXL errors.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
One small thing inline.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index fe4b593331da..021f35145c65 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -6,6 +6,7 @@

> +
> +static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
> +{
> +	void __iomem *aer_base = dport->regs.dport_aer;
> +	u32 aer_cmd_mask, aer_cmd;
> +
> +	if (!aer_base)
> +		return;
> +
> +	/*
> +	 * Disable RCH root port command interrupts.
> +	 * CXL 3.2 12.2.1.1 - RCH Downstream Port-detected Errors
Don't update spec versions in a code move patch.  That's a separate change
appropriate for doing in a separate patch.

For this we just want to see code moved with zero changes at all.
> +	 *
> +	 * This sequence may not be necessary. CXL spec states disabling
> +	 * the root cmd register's interrupts is required. But, PCI spec
> +	 * shows these are disabled by default on reset.
> +	 */
> +	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
> +			PCI_ERR_ROOT_CMD_NONFATAL_EN |
> +			PCI_ERR_ROOT_CMD_FATAL_EN);
> +	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
> +	aer_cmd &= ~aer_cmd_mask;
> +	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
> +}
> +


