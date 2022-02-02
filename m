Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949094A6E02
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 10:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245542AbiBBJol (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 04:44:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4615 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbiBBJol (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Feb 2022 04:44:41 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JpcGQ4hcxz67y1n;
        Wed,  2 Feb 2022 17:39:58 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Wed, 2 Feb 2022 10:44:38 +0100
Received: from localhost (10.47.70.124) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 2 Feb
 2022 09:44:38 +0000
Date:   Wed, 2 Feb 2022 09:44:37 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
        "Linux NVDIMM" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 31/40] cxl/memdev: Add numa_node attribute
Message-ID: <20220202094437.00003c03@Huawei.com>
In-Reply-To: <CAPcyv4iYpj7MH4kKMP57ouHb85GffEmhXPupq5i1mwJwzFXr0w@mail.gmail.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164298428430.3018233.16409089892707993289.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20220131184126.00002a47@Huawei.com>
        <CAPcyv4iYpj7MH4kKMP57ouHb85GffEmhXPupq5i1mwJwzFXr0w@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.70.124]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 1 Feb 2022 15:57:10 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> On Mon, Jan 31, 2022 at 10:41 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Sun, 23 Jan 2022 16:31:24 -0800
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >  
> > > While CXL memory targets will have their own memory target node,
> > > individual memory devices may be affinitized like other PCI devices.
> > > Emit that attribute for memdevs.
> > >
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> >
> > Hmm. Is this just duplicating what we can get from
> > the PCI device?  It feels a bit like overkill to have it here
> > as well.  
> 
> Not all cxl_memdevs are associated with PCI devices.

Platform devices have numa nodes too...



