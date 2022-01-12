Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C3348C68A
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 15:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243201AbiALOxd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 09:53:33 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4406 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354337AbiALOxd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 09:53:33 -0500
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JYr8d5XgGz6883P;
        Wed, 12 Jan 2022 22:50:41 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 12 Jan 2022 15:53:30 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 12 Jan
 2022 14:53:29 +0000
Date:   Wed, 12 Jan 2022 14:53:28 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>
Subject: Re: [PATCH 13/13] cxl: Program decoders for regions
Message-ID: <20220112145328.00000194@huawei.com>
In-Reply-To: <20220107003756.806582-14-ben.widawsky@intel.com>
References: <20220107003756.806582-1-ben.widawsky@intel.com>
        <20220107003756.806582-14-ben.widawsky@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml731-chm.china.huawei.com (10.201.108.82) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu,  6 Jan 2022 16:37:56 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Do the HDM decoder programming for all endpoints and host bridges in a
> region. Switches are currently unimplemented.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
Hi Ben,

Minor bug in the maths below that I'd missed eyeballing the registers
because it happened to give nearly the write value for my normal test config
by complete coincidence...

You may well have already caught this one - I've not checked your latest
tree.

> +/**
> + * cxl_commit_decoder() - Program a configured cxl_decoder
> + * @cxld: The preconfigured cxl decoder.
> + *
> + * A cxl decoder that is to be committed should have been earmarked as enabled.
> + * This mechanism acts as a soft reservation on the decoder.
> + *
> + * Returns 0 if commit was successful, negative error code otherwise.
> + */
> +int cxl_commit_decoder(struct cxl_decoder *cxld)
> +{
> +	u32 ctrl, tl_lo, tl_hi, base_lo, base_hi, size_lo, size_hi;
> +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +	struct cxl_port_state *cxlps;
> +	void __iomem *hdm_decoder;
> +	int rc;
> +
> +	/*
> +	 * Decoder flags are entirely software controlled and therefore this
> +	 * case is purely a driver bug.
> +	 */
> +	if (dev_WARN_ONCE(&port->dev, (cxld->flags & CXL_DECODER_F_ENABLE) != 0,
> +			  "Invalid %s enable state\n", dev_name(&cxld->dev)))
> +		return -ENXIO;
> +
> +	cxlps = dev_get_drvdata(&port->dev);
> +	hdm_decoder = cxlps->regs.hdm_decoder;
> +	ctrl = readl(hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> +
> +	/*
> +	 * A decoder that's currently active cannot be changed without the
> +	 * system being quiesced. While the driver should prevent against this,
> +	 * for a variety of reasons the hardware might not be in sync with the
> +	 * hardware and so, do not splat on error.
> +	 */
> +	size_hi = readl(hdm_decoder +
> +			CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(cxld->id));
> +	size_lo =
> +		readl(hdm_decoder + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(cxld->id));
> +	if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl) &&
> +	    (size_lo + size_hi)) {
> +		dev_err(&port->dev, "Tried to change an active decoder (%s)\n",
> +			dev_name(&cxld->dev));
> +		return -EBUSY;
> +	}
> +
> +	u32p_replace_bits(&ctrl, 8 - ilog2(cxld->interleave_granularity),

This maths is wrong.   interleave_granularity is stored here as log2() anyway
and should be cxld->interleave_granularity - 8;



> +			  CXL_HDM_DECODER0_CTRL_IG_MASK);
> +	u32p_replace_bits(&ctrl, ilog2(cxld->interleave_ways),
> +			  CXL_HDM_DECODER0_CTRL_IW_MASK);
