Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3276735F0B9
	for <lists+linux-pci@lfdr.de>; Wed, 14 Apr 2021 11:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348534AbhDNJXJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Apr 2021 05:23:09 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2850 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348526AbhDNJXI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Apr 2021 05:23:08 -0400
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FKxZq4rnxz6893H;
        Wed, 14 Apr 2021 17:12:51 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Wed, 14 Apr 2021 11:22:43 +0200
Received: from localhost (10.47.83.55) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 14 Apr
 2021 10:22:42 +0100
Date:   Wed, 14 Apr 2021 10:21:15 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
        "Linux ACPI" <linux-acpi@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Vishal L Verma" <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/8] cxl/mem: Move some definitions to mem.h
Message-ID: <20210414102115.00001f09@Huawei.com>
In-Reply-To: <CAPcyv4iueMDPxcEuLg=NKydkRL+xmEn-udHjKYB493iTQShaAg@mail.gmail.com>
References: <161728744224.2474040.12854720917440712854.stgit@dwillia2-desk3.amr.corp.intel.com>
        <161728744762.2474040.11009693084215696415.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20210406173845.00000bec@Huawei.com>
        <CAPcyv4h4z9Y_Zbzk_jiZXs6+gPAbdw0UJHW5NvTaM2ZcvJ6ftw@mail.gmail.com>
        <CAPcyv4iueMDPxcEuLg=NKydkRL+xmEn-udHjKYB493iTQShaAg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.83.55]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 13 Apr 2021 17:42:37 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Tue, Apr 13, 2021 at 5:18 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Tue, Apr 6, 2021 at 10:47 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:  
> > >
> > > On Thu, 1 Apr 2021 07:30:47 -0700
> > > Dan Williams <dan.j.williams@intel.com> wrote:
> > >  
> > > > In preparation for sharing cxl.h with other generic CXL consumers,
> > > > move / consolidate some of the memory device specifics to mem.h.
> > > >
> > > > Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> > >
> > > Hi Dan,
> > >
> > > Would be good to see something in this patch description saying
> > > why you chose to have mem.h rather than push the defines down
> > > into mem.c (which from the current code + patch set looks like
> > > the more logical thing to do).  
> >
> > The main motivation was least privilege access to memory-device
> > details, so they had to move out of cxl.h. As to why move them in to a
> > new mem.h instead of piling more into mem.c that's just a personal
> > organizational style choice to aid review. I tend to go to headers
> > first and read data structure definitions before reading the
> > implementation, and having that all in one place is cleaner than
> > interspersed with implementation details in the C code. It's all still
> > private to drivers/cxl/ so I don't see any "least privilege" concerns
> > with moving it there.
> >
> > Does that satisfy your concern?
> >
> > If yes, I'll add the above to v3.  
> 
> Oh, another thing it helps is the information content of diffstats to
> distinguish definition changes from implementation development.

I go the other way style wise, but agree it doesn't really matter for
local headers included from few other files.  Adding a above to
comment will at least avoid anyone else (or forgetful me) raising question on v3.

Jonathan
