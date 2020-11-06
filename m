Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E31F2A9AFC
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 18:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgKFRjh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 12:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgKFRjg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2020 12:39:36 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A1CC0613CF
        for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2020 09:39:35 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id g17so1324220qts.5
        for <linux-pci@vger.kernel.org>; Fri, 06 Nov 2020 09:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QqZ++Pt3MZPl0c26h7esX3kKVTLpDd4DLyuldQOeJ6E=;
        b=aVspDJwpvtyG5+kighP26kbunhoVoDrk2g+dikuA78Pm3bA2qTEMgmEOIf1kZJzMIf
         jREWUhSOExSA/q/FCxqA4XBVE24zI+bsJoB1MfEIxBjq2vdyDXVafteyCmFKOVp6mNFr
         a+tx6++MRi2ULgDc9l1aIYs8bYmkHkHdREfE1OJi7rMzsOZFvHKvzXQ7XJqg4Rv2jtLq
         /+Dlp7JoggqKZn8R6W1cCZQ0admWy+NkyCMZtOTh144o5mkYSgGm7bfVWOa4R1qrCUIm
         0U96w1WKj0KdQqF8ogG0DBvSehQPHSPP+p8q7o2QpQF4H1UThgaq/hW1ayZpgvaa/xXc
         nKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QqZ++Pt3MZPl0c26h7esX3kKVTLpDd4DLyuldQOeJ6E=;
        b=nL/aKaTIsvo7xbEZrHgIZ8+fUZfgJF740ZCYhJfylB3WaPYEEu7KLbxFoCKivrjYIO
         z5IS1MC7ORqcPdKvuU3tFIE9BQwt1K8fl4vywU3QeR/a/0M5sgiQVCZHHIgT0ViLyoOC
         i6FN1NoXQA2wfSZE0DERBGe3StZw8z0nvLwLkaaXG18k+BeFlwmRQ/giHU0oM8Nc9JZm
         VJV0OEfj1Ec2tvgBVPVforLGNyXiPLdqqGirA/p5ono0XUl9TkJess4EieTPcPkbCpSl
         zgGyHBQellrcCo5/AAYqS+L3A75ayjWJYlaqrNx5PbXLFLz3mShxSAzusIxj4zuFfOMP
         fifQ==
X-Gm-Message-State: AOAM5319u8clp/TjElRQWLuXIuA3Vbl3tV+FddJ2sy0zMG0J+ktPPtWp
        xkvk0+Wq0AUQymVEfgcUQeT5zQ==
X-Google-Smtp-Source: ABdhPJwk/LVr/ux401xFB0f8tEBQvqxB/lNHOmPBnGlIZGn/taGrIczG0r9kVyPbYEVYIeCjEKrF7Q==
X-Received: by 2002:ac8:1e84:: with SMTP id c4mr2651870qtm.340.1604684374450;
        Fri, 06 Nov 2020 09:39:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id o19sm1032238qko.3.2020.11.06.09.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 09:39:33 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kb5i0-000zRk-Qy; Fri, 06 Nov 2020 13:39:32 -0400
Date:   Fri, 6 Nov 2020 13:39:32 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [RFC PATCH 15/15] nvme-pci: Allow mmaping the CMB in userspace
Message-ID: <20201106173932.GT36674@ziepe.ca>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-16-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106170036.18713-16-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 06, 2020 at 10:00:36AM -0700, Logan Gunthorpe wrote:
> Allow userspace to obtain CMB memory by mmaping the controller's
> char device. The mmap call allocates and returns a hunk of CMB memory,
> (the offset is ignored) so userspace does not have control over the
> address within the CMB.
> 
> A VMA allocated in this way will only be usable by drivers that set
> FOLL_PCI_P2PDMA when calling GUP. And inter-device support will be
> checked the first time the pages are mapped for DMA.
> 
> Currently this is only supported by O_DIRECT to an PCI NVMe device
> or through the NVMe passthrough IOCTL.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>  drivers/nvme/host/core.c | 11 +++++++++++
>  drivers/nvme/host/nvme.h |  1 +
>  drivers/nvme/host/pci.c  |  9 +++++++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f14316c9b34a..fc642aba671d 100644
> +++ b/drivers/nvme/host/core.c
> @@ -3240,12 +3240,23 @@ static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
>  	}
>  }
>  
> +static int nvme_dev_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	struct nvme_ctrl *ctrl = file->private_data;
> +
> +	if (!ctrl->ops->mmap_cmb)
> +		return -ENODEV;
> +
> +	return ctrl->ops->mmap_cmb(ctrl, vma);
> +}

This needs to ensure that the VMA created is destroyed before the
driver is unprobed - ie the struct pages backing the BAR memory is
destroyed.

I don't see anything that synchronizes this in the nvme_dev_release()?

Many places do this by putting all the VMAs into an address space and
zaping the address space when unprobing the driver to revoke the
pages, but there is a tricky race here :\

https://lore.kernel.org/dri-devel/20201021125030.GK36674@ziepe.ca/

Jason
