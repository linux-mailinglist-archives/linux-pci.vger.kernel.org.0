Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7AD31D72D
	for <lists+linux-pci@lfdr.de>; Wed, 17 Feb 2021 10:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhBQJ5O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Feb 2021 04:57:14 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2579 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhBQJ5N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Feb 2021 04:57:13 -0500
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DgY545pj4z67nyq;
        Wed, 17 Feb 2021 17:51:20 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 17 Feb 2021 10:56:31 +0100
Received: from localhost (10.47.29.73) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Wed, 17 Feb
 2021 09:56:30 +0000
Date:   Wed, 17 Feb 2021 09:55:24 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        "Chris Browy" <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Jon Masters" <jcm@jonmasters.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4 4/9] cxl/mem: Add basic IOCTL interface
Message-ID: <20210217095524.000071f5@Huawei.com>
In-Reply-To: <20210216183432.lf2uj63uckogfad4@intel.com>
References: <20210216014538.268106-1-ben.widawsky@intel.com>
        <20210216014538.268106-5-ben.widawsky@intel.com>
        <20210216152223.000009e8@Huawei.com>
        <20210216175314.ut2dn5ujayj57zp2@intel.com>
        <20210216182849.00002c8c@Huawei.com>
        <20210216183432.lf2uj63uckogfad4@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.29.73]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 16 Feb 2021 10:34:32 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

...

> > > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > > index 237b956f0be0..4ca4f5afd9d2 100644
> > > --- a/drivers/cxl/mem.c
> > > +++ b/drivers/cxl/mem.c
> > > @@ -686,7 +686,11 @@ static int cxl_validate_cmd_from_user(struct cxl_mem *cxlm,
> > > 
> > >         memcpy(out_cmd, c, sizeof(*c));
> > >         out_cmd->info.size_in = send_cmd->in.size;
> > > -       out_cmd->info.size_out = send_cmd->out.size;
> > > +       /*
> > > +        * XXX: out_cmd->info.size_out will be controlled by the driver, and the
> > > +        * specified number of bytes @send_cmd->out.size will be copied back out
> > > +        * to userspace.
> > > +        */
> > > 
> > >         return 0;
> > >  }  
> > 
> > This deals with the buffer overflow being triggered from userspace.
> > 
> > I'm still nervous.  I really don't like assuming hardware will do the right
> > thing and never send us more data than we expect.
> > 
> > Given the check that it will fit in the target buffer is simple,
> > I'd prefer to harden it and know we can't have a problem.
> > 
> > Jonathan  
> 
> I'm working on hardening __cxl_mem_mbox_send_cmd now per your request. With
> that, I think this solves the issue, right?

Should do.  Thanks,

Jonathan

