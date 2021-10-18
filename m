Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB7E43137F
	for <lists+linux-pci@lfdr.de>; Mon, 18 Oct 2021 11:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhJRJcW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Oct 2021 05:32:22 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3995 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbhJRJcU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Oct 2021 05:32:20 -0400
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HXs2766kRz67yDH;
        Mon, 18 Oct 2021 17:26:23 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 18 Oct 2021 11:30:04 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 18 Oct
 2021 10:30:04 +0100
Date:   Mon, 18 Oct 2021 10:30:02 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 06/10] cxl/pci: Add @base to cxl_register_map
Message-ID: <20211018103002.00007199@Huawei.com>
In-Reply-To: <CAPcyv4j9W4NJFTPk8c5_nG_fAUpecnY886jKmhYzZONW4RCf5Q@mail.gmail.com>
References: <163379783658.692348.16064992154261275220.stgit@dwillia2-desk3.amr.corp.intel.com>
        <163379786922.692348.2318044990911111834.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20211015172732.000012fc@Huawei.com>
        <CAPcyv4j9W4NJFTPk8c5_nG_fAUpecnY886jKmhYzZONW4RCf5Q@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 15 Oct 2021 09:55:57 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Fri, Oct 15, 2021 at 9:27 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Sat, 9 Oct 2021 09:44:29 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >  
> > > In addition to carrying @barno, @block_offset, and @reg_type, add @base
> > > to keep all map/unmap parameters in one object. The helpers
> > > cxl_{map,unmap}_regblock() handle adjusting @base to the @block_offset
> > > at map and unmap time.
> > >
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> >
> > I don't really mind them, but why the renames
> > from cxl_pci_* to cxl_* ?  
> 
> Primarily because we had a mix of some functions including the _pci
> and some not, and I steered towards just dropping it. I think the
> "PCI" aspect of the function is clear by its function signature, and
> that was being muddied by passing @cxlm unnecessarily. So instead of:
> 
> cxl_pci_$foo(struct cxl_mem *cxlm...)
> 
> ...I went with:
> 
> cxl_$foo(struct pci_dev *pdev...)
> 
> ...concerns?

That's fine,

J

