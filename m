Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2DE57BD5E
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 20:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbiGTSFs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 14:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbiGTSFr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 14:05:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E7A3AB12;
        Wed, 20 Jul 2022 11:05:44 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lp3SR5vYlz67MfC;
        Thu, 21 Jul 2022 02:02:15 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Jul 2022 20:05:42 +0200
Received: from localhost (10.81.205.121) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Jul
 2022 19:05:41 +0100
Date:   Wed, 20 Jul 2022 19:05:37 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <bwidawsk@kernel.org>,
        <hch@lst.de>, <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 28/28] cxl/region: Introduce cxl_pmem_region objects
Message-ID: <20220720190537.0000547a@Huawei.com>
In-Reply-To: <165784340111.1758207.3036498385188290968.stgit@dwillia2-xfh.jf.intel.com>
References: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
        <165784340111.1758207.3036498385188290968.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.205.121]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 14 Jul 2022 17:03:21 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> The LIBNVDIMM subsystem is a platform agnostic representation of system
> NVDIMM / persistent memory resources. To date, the CXL subsystem's
> interaction with LIBNVDIMM has been to register an nvdimm-bridge device
> and cxl_nvdimm objects to proxy CXL capabilities into existing LIBNVDIMM
> subsystem mechanics.
> 
> With regions the approach is the same. Create a new cxl_pmem_region
> object to proxy CXL region details into a LIBNVDIMM definition. With
> this enabling LIBNVDIMM can partition CXL persistent memory regions with
> legacy namespace labels. A follow-on patch will add CXL region label and
> CXL namespace label support to persist region configurations across
> driver reload / system-reset events.
> 
> Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
> Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
On trivial query below.  Either way I think this looks good.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> +
> +static void unregister_nvdimm_region(void *nd_region)
> +{
> +	struct cxl_nvdimm_bridge *cxl_nvb;
> +	struct cxl_pmem_region *cxlr_pmem;
> +	int i;
> +
> +	cxlr_pmem = nd_region_provider_data(nd_region);
> +	cxl_nvb = cxlr_pmem->bridge;
> +	device_lock(&cxl_nvb->dev);
> +	for (i = 0; i < cxlr_pmem->nr_mappings; i++) {
> +		struct cxl_pmem_region_mapping *m = &cxlr_pmem->mapping[i];
> +		struct cxl_nvdimm *cxl_nvd = m->cxl_nvd;
> +
> +		if (cxl_nvd->region) {
> +			put_device(&cxlr_pmem->dev);
> +			cxl_nvd->region = NULL;
> +		}
> +	}
> +	device_unlock(&cxl_nvb->dev);
> +
> +	nvdimm_region_delete(nd_region);

I'm not convinced by the ordering in here. Can we do the nvdimm_region_delete() before
taking the device_lock()?  That would make this a nice mirror image of what is
going on in probe().  I may well be missing a reason that doesn't work though.

> +}
> +
