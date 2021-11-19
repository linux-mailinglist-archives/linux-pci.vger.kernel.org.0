Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB22457144
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 15:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbhKSO6x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 09:58:53 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4114 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbhKSO6w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Nov 2021 09:58:52 -0500
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Hwfq81THpz67vp2;
        Fri, 19 Nov 2021 22:55:32 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Fri, 19 Nov 2021 15:55:47 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 19 Nov
 2021 14:55:47 +0000
Date:   Fri, 19 Nov 2021 14:55:20 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <ben.widawsky@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 5/5] cxl/cdat: Parse out DSMAS data from CDAT table
Message-ID: <20211119145451.0000682f@huawei.com>
In-Reply-To: <20211105235056.3711389-6-ira.weiny@intel.com>
References: <20211105235056.3711389-1-ira.weiny@intel.com>
        <20211105235056.3711389-6-ira.weiny@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 5 Nov 2021 16:50:56 -0700
<ira.weiny@intel.com> wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> Parse and cache the DSMAS data from the CDAT table.  Store this data in
> Unmarshaled data structures for use later.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

More fun from clashing patch sets below.
I think this is wrong rather than the other patch, but I'm prepared to
be persuaded otherwise!

Ben, this is related to your mega RFC for regions etc.

Jonathan


> +static int parse_dsmas(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_dsmas *dsmas_ary = NULL;
> +	u32 *data = cxlmd->cdat_table;
> +	int bytes_left = cxlmd->cdat_length;
> +	int nr_dsmas = 0;
> +	size_t dsmas_byte_size;
> +	int rc = 0;
> +
> +	if (!data || !cdat_hdr_valid(cxlmd))
> +		return -ENXIO;
> +
> +	/* Skip header */
> +	data += CDAT_HEADER_LENGTH_DW;
> +	bytes_left -= CDAT_HEADER_LENGTH_BYTES;
> +
> +	while (bytes_left > 0) {
> +		u32 *cur_rec = data;
> +		u8 type = FIELD_GET(CDAT_STRUCTURE_DW0_TYPE, cur_rec[0]);
> +		u16 length = FIELD_GET(CDAT_STRUCTURE_DW0_LENGTH, cur_rec[0]);
> +
> +		if (type == CDAT_STRUCTURE_DW0_TYPE_DSMAS) {
> +			struct cxl_dsmas *new_ary;
> +			u8 flags;
> +
> +			new_ary = krealloc(dsmas_ary,
> +					   sizeof(*dsmas_ary) * (nr_dsmas+1),
> +					   GFP_KERNEL);
> +			if (!new_ary) {
> +				dev_err(&cxlmd->dev,
> +					"Failed to allocate memory for DSMAS data\n");
> +				rc = -ENOMEM;
> +				goto free_dsmas;
> +			}
> +			dsmas_ary = new_ary;
> +
> +			flags = FIELD_GET(CDAT_DSMAS_DW1_FLAGS, cur_rec[1]);
> +
> +			dsmas_ary[nr_dsmas].dpa_base = CDAT_DSMAS_DPA_OFFSET(cur_rec);
> +			dsmas_ary[nr_dsmas].dpa_length = CDAT_DSMAS_DPA_LEN(cur_rec);
> +			dsmas_ary[nr_dsmas].non_volatile = CDAT_DSMAS_NON_VOLATILE(flags);
> +
> +			dev_dbg(&cxlmd->dev, "DSMAS %d: %llx:%llx %s\n",
> +				nr_dsmas,
> +				dsmas_ary[nr_dsmas].dpa_base,
> +				dsmas_ary[nr_dsmas].dpa_base +
> +					dsmas_ary[nr_dsmas].dpa_length,
> +				(dsmas_ary[nr_dsmas].non_volatile ?
> +					"Persistent" : "Volatile")
> +				);
> +
> +			nr_dsmas++;
> +		}
> +
> +		data += (length/sizeof(u32));
> +		bytes_left -= length;
> +	}
> +
> +	if (nr_dsmas == 0) {
> +		rc = -ENXIO;
> +		goto free_dsmas;
> +	}
> +
> +	dev_dbg(&cxlmd->dev, "Found %d DSMAS entries\n", nr_dsmas);
> +
> +	dsmas_byte_size = sizeof(*dsmas_ary) * nr_dsmas;
> +	cxlmd->dsmas_ary = devm_kzalloc(&cxlmd->dev, dsmas_byte_size, GFP_KERNEL);

Here is another place where we need to hang this off cxlds->dev rather than this
one to avoid breaking Ben's code.


> +	if (!cxlmd->dsmas_ary) {
> +		rc = -ENOMEM;
> +		goto free_dsmas;
> +	}
> +
> +	memcpy(cxlmd->dsmas_ary, dsmas_ary, dsmas_byte_size);
> +	cxlmd->nr_dsmas = nr_dsmas;
> +
> +free_dsmas:
> +	kfree(dsmas_ary);
> +	return rc;
> +}
> +
