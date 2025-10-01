Return-Path: <linux-pci+bounces-37359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31362BB127A
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 17:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAAAB194748F
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 15:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8D928134D;
	Wed,  1 Oct 2025 15:42:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CE1280CC8;
	Wed,  1 Oct 2025 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759333378; cv=none; b=hzD+A9rqts6Sntuza02GtTv33YrBqOwExeCvCpJkFv/4srOVXkSMS1i4NQP5LH7173HIuPFu/ivUuL5vN8ejgnEBlUfY38Z6mMV49M+Aj1tzoHtYroXxBO0O0Xpy5SL7RrAXIuZcnYXgOoF4QlZhL0rlRi3aATZ/GdjQV52Ifvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759333378; c=relaxed/simple;
	bh=zl8OvM2e0RnXj6a9R/TsMxcv9Vyq3M+XKQyuJFBKwBs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lplOrS4W9F1GmebWRBUBxlh/5J2dhqPpJ2HcA1MZ/lYNB5lqiKXLHnY+DU2ABXayAKKSBmxAx4+fm7bxDRzL82COZY7mbyVjw7Mi1vGfnfAKgZiBT1YwmXAA8oIy1jbyMbnOoeKz3b7eH0O5q7psLYlXwOonftkWpRD85uWMxMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ccJyR0RM1z6K8tR;
	Wed,  1 Oct 2025 23:39:43 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 94130140276;
	Wed,  1 Oct 2025 23:42:51 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 1 Oct
 2025 16:42:50 +0100
Date: Wed, 1 Oct 2025 16:42:48 +0100
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
Subject: Re: [PATCH v12 06/25] CXL/AER: Introduce aer_cxl_rch.c into AER
 driver for handling CXL RCH errors
Message-ID: <20251001164248.0000182a@huawei.com>
In-Reply-To: <20250925223440.3539069-7-terry.bowman@amd.com>
References: <20250925223440.3539069-1-terry.bowman@amd.com>
	<20250925223440.3539069-7-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 25 Sep 2025 17:34:21 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The restricted CXL Host (RCH) AER error handling logic currently resides
> in the AER driver file, drivers/pci/pcie/aer.c. CXL specific changes are
> conditionally compiled using #ifdefs.
> 
> Improve the AER driver maintainability by separating the RCH specific logic
> from the AER driver's core functionality and removing the ifdefs. Introduce
> drivers/pci/pcie/aer_cxl_rch.c for moving the RCH AER logic into.
> Conditionally compile the file using the CONFIG_CXL_RCH_RAS Kconfig.
> 
> Move the CXL logic into the new file but leave helper functions in aer.c
> for now as they will be moved in future patch for CXL virtual hierarchy
> handling. Export the handler functions as needed. Export
> pci_aer_unmask_internal_errors() allowing for all subsystems to use.
> Avoid multiple declaration moves and export cxl_error_is_native() now to
> allow for cxl_core access.
> 
> Inorder to maintain compilation after the move other changes are required.
> Change cxl_rch_handle_error() & cxl_rch_enable_rcec() to be non-static
> inorder for accessing from the AER driver in aer.c.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---
> 
> Changes in v11->v12:
> - Rename drivers/pci/pcie/cxl_rch.c to drivers/pci/pcie/aer_cxl_rch.c (Lukas)
> - Removed forward declararation of 'struct aer_err_info' in pci/pci.h (Terry)

Unwise given the bot reply.

Fun is that it's only needed I think in the !CONFIG_CXL_RCH_RAS bit as that
can occur with !CONFIG_PCIE_AER.

Other than that, just a few trivial comments.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
> new file mode 100644
> index 000000000000..bfe071eebf67
> --- /dev/null
> +++ b/drivers/pci/pcie/aer_cxl_rch.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2025 AMD Corporation. All rights reserved. */

For a code move, the date at least should I think be a bit older.

> +
> +#include <linux/pci.h>
> +#include <linux/aer.h>
> +#include <linux/bitfield.h>
> +#include "../pci.h"
> +
> +static bool is_cxl_mem_dev(struct pci_dev *dev)
> +{
> +	/*
> +	 * The capability, status, and control fields in Device 0,
> +	 * Function 0 DVSEC control the CXL functionality of the
> +	 * entire device (CXL 3.0, 8.1.3).
> +	 */
> +	if (dev->devfn != PCI_DEVFN(0, 0))
> +		return false;
> +
> +	/*
> +	 * CXL Memory Devices must have the 502h class code set (CXL
> +	 * 3.0, 8.1.12.1).
> +	 */
> +	if ((dev->class >> 8) != PCI_CLASS_MEMORY_CXL)
> +		return false;
> +
> +	return true;
> +}
> +
> +static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
> +{
> +	struct aer_err_info *info = (struct aer_err_info *)data;
> +	const struct pci_error_handlers *err_handler;
> +
> +	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
> +		return 0;
> +
> +	/* Protect dev->driver */
> +	device_lock(&dev->dev);

Unrelated but guard() might be nice to use here.  Perhaps that's
in a later patch.

> +
> +	err_handler = dev->driver ? dev->driver->err_handler : NULL;
> +	if (!err_handler)
> +		goto out;
> +
> +	if (info->severity == AER_CORRECTABLE) {
> +		if (err_handler->cor_error_detected)
> +			err_handler->cor_error_detected(dev);
> +	} else if (err_handler->error_detected) {
> +		if (info->severity == AER_NONFATAL)
> +			err_handler->error_detected(dev, pci_channel_io_normal);
> +		else if (info->severity == AER_FATAL)
> +			err_handler->error_detected(dev, pci_channel_io_frozen);
> +	}
> +out:
> +	device_unlock(&dev->dev);
> +	return 0;
> +}



