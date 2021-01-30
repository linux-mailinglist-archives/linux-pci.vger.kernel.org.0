Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB243098FC
	for <lists+linux-pci@lfdr.de>; Sun, 31 Jan 2021 00:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhA3Xwr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 30 Jan 2021 18:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbhA3XwZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Jan 2021 18:52:25 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32091C0613D6
        for <linux-pci@vger.kernel.org>; Sat, 30 Jan 2021 15:51:45 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id c132so9422991pga.3
        for <linux-pci@vger.kernel.org>; Sat, 30 Jan 2021 15:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=GDv15DwnRp3MS5y0X9bL9QkhV0S8PjNmrscexBhhUtA=;
        b=Mniksk0+xMkFOMZyyZxYvBktssUOJFhazgAfgAHn9e+16eIYt+3GlpWg6E0DAJ8fYY
         WDuDlRb+ul9uZLNgaLXC4pv8dqBpjAjemOJWnSsOSyiy69MNK+dOs/FZDn7dLcxhzUNS
         59fLeXPXG9kHc1/bO/wl17ZNmqBSO12pGkj4fTSPU8f8wXSUykglI65cZ1o3wa7S+uC7
         WjnOnqrs8SPFn6yfNbHYcMWzjiHuBQaWXhxy6t+TrLWD5+PfN1LqKdWyN5QyGpSwfr9m
         ec4kibCqC+jcrS3ail6HKNoQTR0CkaVYGqzRs/nXdEYb5wVMTjzQ8l7kqTklE8pFArx7
         bm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=GDv15DwnRp3MS5y0X9bL9QkhV0S8PjNmrscexBhhUtA=;
        b=F4kViwS1OblmcJOLb9v8eBtD25ta43s1Jc7beYo884M44a+va0vZ3rtGigCT2cEPmF
         dlAIxnvZHEhRi0vb9kyE/B2RDVwTL2Zqo8ihuHViPHzYWZHIABjsDc1NQNjgOrbhf843
         WQJZfX/lO8HBGBPSPVJVqxNzXNHbczl0DPoXxwaFdN3ah/XxNhDuvISMRVYnYh3gOTFp
         aefK0shcwpxPklkMY7Jp3tefFy6rk3iqYsOXihS4+ZLpMWaOLMmuHXk7lXmD6wwzOATb
         vn1kVeSnhZbSvlrRRwZKjxyBVOT7StaazShEyRGQBQlb9rxO4vRTAHlP7Yfvw5BNT3Iq
         3YqQ==
X-Gm-Message-State: AOAM530411sXSb927utziizL8xgeijPnoomSEK2rhikC+sWdAZvYBLa0
        11/RHwSFlqS2XOLBCw1aqq3yRg==
X-Google-Smtp-Source: ABdhPJwbuQ4nVg0OQPgeWs57sXjRNYE2dA+6UJRCYf1jVILDhdLj6k91Bbw9k3VuSrWFNKVhFs7mpg==
X-Received: by 2002:a63:f405:: with SMTP id g5mr10896366pgi.276.1612050704574;
        Sat, 30 Jan 2021 15:51:44 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id a25sm12812739pgv.40.2021.01.30.15.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 15:51:43 -0800 (PST)
Date:   Sat, 30 Jan 2021 15:51:42 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: Re: [PATCH 02/14] cxl/mem: Map memory device registers
In-Reply-To: <20210130002438.1872527-3-ben.widawsky@intel.com>
Message-ID: <792edaa-a11b-41c6-c2a1-2c72a3e4e815@google.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com> <20210130002438.1872527-3-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 29 Jan 2021, Ben Widawsky wrote:

> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> new file mode 100644
> index 000000000000..d81d0ba4617c
> --- /dev/null
> +++ b/drivers/cxl/cxl.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2020 Intel Corporation. */
> +
> +#ifndef __CXL_H__
> +#define __CXL_H__
> +
> +/**
> + * struct cxl_mem - A CXL memory device
> + * @pdev: The PCI device associated with this CXL device.
> + * @regs: IO mappings to the device's MMIO
> + */
> +struct cxl_mem {
> +	struct pci_dev *pdev;
> +	void __iomem *regs;
> +};
> +
> +#endif

Stupid question: can there be more than one CXL.mem capable logical 
device?  I only ask to determine if an ordinal is needed to enumerate 
multiple LDs.

> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index f4ee9a507ac9..a869c8dc24cc 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -4,6 +4,58 @@
>  #include <linux/pci.h>
>  #include <linux/io.h>
>  #include "pci.h"
> +#include "cxl.h"
> +
> +/**
> + * cxl_mem_create() - Create a new &struct cxl_mem.
> + * @pdev: The pci device associated with the new &struct cxl_mem.
> + * @reg_lo: Lower 32b of the register locator
> + * @reg_hi: Upper 32b of the register locator.
> + *
> + * Return: The new &struct cxl_mem on success, NULL on failure.
> + *
> + * Map the BAR for a CXL memory device. This BAR has the memory device's
> + * registers for the device as specified in CXL specification.
> + */
> +static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
> +				      u32 reg_hi)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cxl_mem *cxlm;
> +	void __iomem *regs;
> +	u64 offset;
> +	u8 bar;
> +	int rc;
> +
> +	offset = ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
> +	bar = (reg_lo >> CXL_REGLOC_BIR_SHIFT) & CXL_REGLOC_BIR_MASK;
> +
> +	/* Basic sanity check that BAR is big enough */
> +	if (pci_resource_len(pdev, bar) < offset) {
> +		dev_err(dev, "BAR%d: %pr: too small (offset: %#llx)\n", bar,
> +			&pdev->resource[bar], (unsigned long long)offset);
> +		return NULL;
> +	}
> +
> +	rc = pcim_iomap_regions(pdev, BIT(bar), pci_name(pdev));
> +	if (rc != 0) {
> +		dev_err(dev, "failed to map registers\n");
> +		return NULL;
> +	}
> +
> +	cxlm = devm_kzalloc(&pdev->dev, sizeof(*cxlm), GFP_KERNEL);
> +	if (!cxlm) {
> +		dev_err(dev, "No memory available\n");
> +		return NULL;
> +	}
> +
> +	regs = pcim_iomap_table(pdev)[bar];
> +	cxlm->pdev = pdev;
> +	cxlm->regs = regs + offset;
> +
> +	dev_dbg(dev, "Mapped CXL Memory Device resource\n");
> +	return cxlm;
> +}
>  
>  static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
>  {
> @@ -32,15 +84,42 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
>  static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct device *dev = &pdev->dev;
> -	int regloc;
> +	struct cxl_mem *cxlm;
> +	int rc, regloc, i;
> +
> +	rc = pcim_enable_device(pdev);
> +	if (rc)
> +		return rc;
>  
>  	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC);
>  	if (!regloc) {
>  		dev_err(dev, "register location dvsec not found\n");
>  		return -ENXIO;
>  	}
> +	regloc += 0xc; /* Skip DVSEC + reserved fields */

Assuming the DVSEC revision number is always 0x0 or there's no value in 
storing this in struct cxl_mem for the future.

Acked-by: David Rientjes <rientjes@google.com>
