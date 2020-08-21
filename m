Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5AB24D0A4
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 10:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgHUIkB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 04:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgHUIkA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2020 04:40:00 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590F4C061385
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2020 01:40:00 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id m22so1358557eje.10
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2020 01:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XadaanCr4lDO+zLVqWWUMPb1BVlfqUxXq/ClehyNMJE=;
        b=HRYysz8OrEROQJ+s0ZlS9JhcEJ84ZPeORKAXDPtjU4NIM31gA5GvMBD9MxnqNLhaIC
         lsGVes1QCLYuP78wbfFbNycx8Surhm2k/xSV85puFaZr8NxnFmO4RGcldl5WYiC5Scag
         9W3SPqSl1jYgL8OPg7yAk6327TcJU2/TieHHNnlbPYrJz/khiVdz40lijkIySn/ow5cr
         itMajhJhz7RByWWbXnBD9kyWlfliVib5gPhn0DgtLQBQaxvaaQ4OQmNuLTWmn0Le7/+f
         0n8RNP6S5LCsVs4kjPremaLB3J9atTJk/9q03GFvHSfidPEAiKEMTqwHh2+qnyj4dCYw
         My5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XadaanCr4lDO+zLVqWWUMPb1BVlfqUxXq/ClehyNMJE=;
        b=G1QkgJ4IiW6CE7TOwLGcYhCNRTL6ub/i/l5t77LnbGaJHmkindrjjGfZ5Cz42a+Z6K
         U9j8jSIfGX1iEHc9+72AEGR1ovpLfEtb2BDGUJ8oslEtrJW2WFulx+omsRPw/5KCZRUz
         tJELg0e3M92osaQe2MTddlXUIoNnySz7VU+3TDZ6MkdNRZ6nlIEKg4Uo4YewdlPZuMz1
         EsDnIr5QFdZXgsUt3+o0mcrzJvIkQgYOEHLKwC9xM9MOAAOhYlN0gf93Zn5430RClN1f
         sLwn7r117uzZJySeRIq6Eq5UstOTtM/PtbGdSFEuiuFW1jbAPPsv5DGm8y59XhKcUjxk
         1n3Q==
X-Gm-Message-State: AOAM5318GIqJi+O9qTEXhgDjmM6zNHhqRc6KTDEPSXlBcVocRhO1m9li
        EzeRCbSm1Z3JoCtIhglBKcJO1Q==
X-Google-Smtp-Source: ABdhPJzOu67KhPib/7zfI7mgHnrftLzWEt8v5fYXk10FlxSsjIV57STeY43DqysK8UOWTKLL9Quh9g==
X-Received: by 2002:a17:906:c1c3:: with SMTP id bw3mr1966407ejb.8.1597999198248;
        Fri, 21 Aug 2020 01:39:58 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id j11sm888155ejx.0.2020.08.21.01.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 01:39:57 -0700 (PDT)
Date:   Fri, 21 Aug 2020 10:39:41 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "Boeuf, Sebastien" <sebastien.boeuf@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Message-ID: <20200821083941.GA2312546@myrica>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D86D9C9@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D86D9C9@SHSMSX104.ccr.corp.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

While preparing the next version I noticed I forgot to send this reply.
Better late than never I suppose...

On Tue, Apr 21, 2020 at 07:31:12AM +0000, Tian, Kevin wrote:
> > From: Jean-Philippe Brucker
> > Sent: Saturday, February 29, 2020 1:26 AM
> > 
> > Platforms without device-tree do not currently have a method for
> > describing the vIOMMU topology. Provide a topology description embedded
> > into the virtio device.
[...]
> > diff --git a/drivers/iommu/virtio-iommu-topology.c b/drivers/iommu/virtio-
> > iommu-topology.c
> > new file mode 100644
> > index 000000000000..2188624ef216
> > --- /dev/null
> > +++ b/drivers/iommu/virtio-iommu-topology.c
> > @@ -0,0 +1,343 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/dma-iommu.h>
> > +#include <linux/list.h>
> > +#include <linux/pci.h>
> > +#include <linux/virt_iommu.h>
> > +#include <linux/virtio_ids.h>
> > +#include <linux/virtio_pci.h>
> > +#include <uapi/linux/virtio_iommu.h>
> > +
> > +struct viommu_cap_config {
> > +	u8 bar;
> > +	u32 length; /* structure size */
> > +	u32 offset; /* structure offset within the bar */
> > +};
> > +
> > +union viommu_topo_cfg {
> > +	__le16					type;
> > +	struct virtio_iommu_topo_pci_range	pci;
> > +	struct virtio_iommu_topo_endpoint	ep;
> > +};
> > +
> > +struct viommu_spec {
> > +	struct device				*dev; /* transport device */
> > +	struct fwnode_handle			*fwnode;
> > +	struct iommu_ops			*ops;
> > +	struct list_head			list;
> > +	size_t					num_items;
> 
> Intel DMAR allows an IOMMU to claim INCLUDE_ALL thus avoid listing
> every endpoint one-by-one. It is especially useful when there is only
> one IOMMU device in the system. Do you think whether making sense
> to allow such optimization in this spec?

The DMAR INCLUDE_PCI_ALL is for a single PCI domain, so I think is
equivalent to having a single virtio_iommu_topo_pci_range structure with
start=0 and end=0xffff. That only takes 16 bytes of config space and is
pretty easy to parse, so a special case doesn't seem necessary to me.

If more than one PCI domain is managed by the IOMMU, then INCLUDE_ALL
isn't sufficient since we need to describe how endpoint IDs are associated
to domain:RID (one of the domains would have its endpoint IDs = RID +
0x10000 for example). Furthermore non-PCI devices don't have an implicit
endpoint ID like the RID.

Thanks,
Jean

> It doesn't work for ARM since
> you need ID mapping to find the MSI doorbell. But for architectures
> where only topology info is required, it makes the enumeration process
> much simpler.
> 
> Thanks
> Kevin
