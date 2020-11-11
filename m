Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954882AE9B8
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 08:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgKKHWP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 02:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgKKHMd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2020 02:12:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21E5C0613D4;
        Tue, 10 Nov 2020 23:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9NVZFoWOtk2drwb+CBbjE6+h56gdwxT/Zba1uNpXaGw=; b=Ly/FwRGB6s17s+VOTeDWLpa5bI
        U/tAKGAsqHG29rGnzgsx9kRnnJB0ESyPoLkqB0N8gAjBawjuZ43jgi/VK/qA6iJLtj/uI6xpjQ9U5
        DMvKqgOiJaUnq2uvDQZzipHzHChurgPWtFZr25G8ApM9zr697X/1b53eDLKCOi5pcF1rY9weOlqxT
        SSnl3SxN2KNn40M027o30R6h6z19/TtKqgKxI8PIxp1NW/cvjjHlNuHnX712+AoZZupp8+WR0h+pk
        xRnd1ydcUZ50imKbLNBX/wmuUQhPIvXAI31LLyGLzplFwxT0yCtWMLcxzCfVc0WJiWTKzL1L3Y0uK
        fPOJ8+tA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kckIx-0002qG-Cf; Wed, 11 Nov 2020 07:12:31 +0000
Date:   Wed, 11 Nov 2020 07:12:31 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH 3/9] cxl/mem: Add a driver for the type-3 mailbox
Message-ID: <20201111071231.GC7829@infradead.org>
References: <20201111054356.793390-1-ben.widawsky@intel.com>
 <20201111054356.793390-4-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111054356.793390-4-ben.widawsky@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 10, 2020 at 09:43:50PM -0800, Ben Widawsky wrote:
> +config CXL_MEM
> +        tristate "CXL.mem Device Support"
> +        depends on PCI && CXL_BUS_PROVIDER != n

depend on PCI && CXL_BUS_PROVIDER

> +        default m if CXL_BUS_PROVIDER

Please don't set weird defaults for new code.  Especially not default
to module crap like this.

> +// Copyright(c) 2020 Intel Corporation. All rights reserved.

Please don't use '//' for anything but the SPDX header.

> +
> +		pci_read_config_word(pdev, pos + PCI_DVSEC_VENDOR_OFFSET, &vendor);
> +		pci_read_config_word(pdev, pos + PCI_DVSEC_ID_OFFSET, &id);
> +		if (vendor == PCI_DVSEC_VENDOR_CXL && dvsec == id)
> +			return pos;
> +
> +		pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC);

Overly long lines again.

> +static void cxl_mem_remove(struct pci_dev *pdev)
> +{
> +}

No need for the empty remove callback.

> +MODULE_AUTHOR("Intel Corporation");

A module author is not a company.
