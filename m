Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFA8559D1B
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 17:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbiFXPNZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 11:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbiFXPNV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 11:13:21 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E97CDEFE;
        Fri, 24 Jun 2022 08:13:13 -0700 (PDT)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LV0wl5vXpz67xMg;
        Fri, 24 Jun 2022 23:12:39 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 24 Jun 2022 17:13:11 +0200
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 24 Jun
 2022 16:13:11 +0100
Date:   Fri, 24 Jun 2022 16:13:10 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        "Matthew Wilcox" <willy@infradead.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 00/46] CXL PMEM Region Provisioning
Message-ID: <20220624161310.00006689@huawei.com>
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 23 Jun 2022 19:45:00 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> tl;dr: 46 patches is way too many patches to review in one sitting. Jump
> to the PATCH SUMMARY below to find a subset of interest to jump into.
> 
> The series is also posted on the 'preview' branch [1]. Note that branch
> rebases, the tip of that branch at time of posting is:
> 
> 7e5ad5cb1580 cxl/region: Introduce cxl_pmem_region objects
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=preview

Via a W=1 build some docs are out of sync with parameter names.
I'm lazy so I'll leave finding the right patch to you ;)
drivers/cxl/core/region.c:1490: warning: Function parameter or member 'type' not described in 'devm_cxl_add_region'
drivers/cxl/core/region.c:1719: warning: Function parameter or member 'cxlr' not described in 'devm_cxl_add_pmem_region'
drivers/cxl/core/region.c:1719: warning: Excess function parameter 'host' description in 'devm_cxl_add_pmem_region'

whilst here, docs for generic_nvdimm_flush() need updating to reflect
generic getting added to the name in 2019...

Jonathan
