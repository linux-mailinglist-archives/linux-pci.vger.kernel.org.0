Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1DB456115
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 18:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbhKRRFP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 12:05:15 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4106 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbhKRRFL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 12:05:11 -0500
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Hw5bL6Sbhz67tXN;
        Fri, 19 Nov 2021 00:58:22 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Thu, 18 Nov 2021 18:02:08 +0100
Received: from localhost (10.52.127.148) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 18 Nov
 2021 17:02:07 +0000
Date:   Thu, 18 Nov 2021 17:02:05 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <ben.widawsky@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 5/5] cxl/cdat: Parse out DSMAS data from CDAT table
Message-ID: <20211118170205.000047b2@Huawei.com>
In-Reply-To: <20211105235056.3711389-6-ira.weiny@intel.com>
References: <20211105235056.3711389-1-ira.weiny@intel.com>
        <20211105235056.3711389-6-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.127.148]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
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
> 

> +static bool cdat_hdr_valid(struct cxl_memdev *cxlmd)
> +{
> +	u32 *data = cxlmd->cdat_table;
> +	u8 *data8 = (u8 *)data;
> +	u32 length, seq;
> +	u8 rev, cs;
> +	u8 check;
> +	int i;
> +
> +	length = FIELD_GET(CDAT_HEADER_DW0_LENGTH, data[0]);
> +	if (length < CDAT_HEADER_LENGTH_BYTES)
> +		return false;
> +
> +	rev = FIELD_GET(CDAT_HEADER_DW1_REVISION, data[1]);
> +	cs = FIELD_GET(CDAT_HEADER_DW1_CHECKSUM, data[1]);
rev and cs both parsed out but not used...

W=1 is complaining at me, hence I noticed whilst rebasing this
series.

Jonathan

> +	seq = FIELD_GET(CDAT_HEADER_DW3_SEQUENCE, data[3]);
> +
> +	/* Store the sequence for now. */
> +	cxlmd->cdat_seq = seq;
> +
> +	for (check = 0, i = 0; i < length; i++)
> +		check += data8[i];
> +
> +	return check == 0;
> +}
