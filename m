Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD3C1C3FC9
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 18:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgEDQZ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 12:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbgEDQZ4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 May 2020 12:25:56 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A7BC061A0E
        for <linux-pci@vger.kernel.org>; Mon,  4 May 2020 09:25:53 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y3so2670560wrt.1
        for <linux-pci@vger.kernel.org>; Mon, 04 May 2020 09:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GL2JHfWb2mPYeSgeIH5WeIgVbATF3Ra0zLGdb9HxWZQ=;
        b=NPOSWeTNC3Un3eskvozXKMxNnsJ6r9fc/sgBE1d6gnYLdALaK8wjIX/j58IvqfxFmC
         cJ7U5u96OPGUoehpQYLz0ggsicjiGrgSLC1dqZkfAjTE0uE8MD2K1WFx/8y4Pzbpbd5R
         z1XLioC0bjQNb3+Z6msYsAptNDoFZ4CqIP/741UwHR5xz+ADrwIsStOoAMCNc23vCn0O
         CkGZuVDFZP0sdQAJ3dIDW/VXYBbjPmqlBAyRLYt21m9Bo4iyUVDnyUPUU+K5e2tYxPpF
         W5ts90uOmnfyFrIy99D6BSUc9rUBir+ZREIxahMT07HpDKv5DXmykWAMqamGEhd1zCAa
         cW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GL2JHfWb2mPYeSgeIH5WeIgVbATF3Ra0zLGdb9HxWZQ=;
        b=U82L0JXkM8mO4IE+weGoG+lkE+3QyGY1i3uJKYv3nn56/H7RMIMCwzzyBYaG2850u0
         zGIcTt1tlAqJ0/kP7nS30KmMtOnGQPe22OHjpB6CzRgc6hDlkCJTRCGeWjyve8PKf3M9
         ZeFDR5Sg6WGtqTPnyrfqpLp2z8lcUl7CEvho2JOY38oP+e2z00EynYXCQvZfQxE6oA7z
         9WSosa/RwhUmdnoLL+mto7sRN095bdAerzLPOeyUSFG0sNE62dAzDrtn4VmGEoLPxyDm
         hRrO1LiCnYTeEUxMoGrPmxr29VIICLynEeV4cAMOb1Fd0rNtvAkSxmG7W3BaieS4Ccre
         p2cg==
X-Gm-Message-State: AGi0PuYu8V2ynB0H06GDfG4MAmiTajzSyspV3TZ4zH95L9PNe8thBv+e
        fNGT8G82Uubj1Cn4ihkt4RD3BQ==
X-Google-Smtp-Source: APiQypJewC2A5eJu+LlIEsZxNgowtLfUPSFwzAN1NtAObzTj2fsi/+uiw7oQbS2F9/ABw1GE+6Cvxw==
X-Received: by 2002:adf:f606:: with SMTP id t6mr7882808wrp.321.1588609551965;
        Mon, 04 May 2020 09:25:51 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id r15sm6980383wrq.93.2020.05.04.09.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 09:25:51 -0700 (PDT)
Date:   Mon, 4 May 2020 18:25:41 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        Jonathan.Cameron@huawei.com, jacob.jun.pan@linux.intel.com,
        christian.koenig@amd.com, felix.kuehling@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com,
        fenghua.yu@intel.com, hch@infradead.org
Subject: Re: [PATCH v6 05/25] iommu/iopf: Handle mm faults
Message-ID: <20200504162541.GG170104@myrica>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-6-jean-philippe@linaro.org>
 <9fc0e4cc-1242-bf96-5328-cc9039dcc9b6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fc0e4cc-1242-bf96-5328-cc9039dcc9b6@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, May 03, 2020 at 01:54:36PM +0800, Lu Baolu wrote:
> On 2020/4/30 22:34, Jean-Philippe Brucker wrote:
> > When a recoverable page fault is handled by the fault workqueue, find the
> > associated mm and call handle_mm_fault.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> > v5->v6: select CONFIG_IOMMU_SVA
> > ---
> >   drivers/iommu/Kconfig      |  1 +
> >   drivers/iommu/io-pgfault.c | 79 +++++++++++++++++++++++++++++++++++++-
> >   2 files changed, 78 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 4f33e489f0726..1e64ee6592e16 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -109,6 +109,7 @@ config IOMMU_SVA
> >   config IOMMU_PAGE_FAULT
> >   	bool
> > +	select IOMMU_SVA
> 
> It would be better to move this to the previous patch.
> 
[...]
> > @@ -104,6 +156,29 @@ static void iopf_handle_group(struct work_struct *work)
> >    *
> >    * Add a fault to the device workqueue, to be handled by mm.
> >    *
> > + * This module doesn't handle PCI PASID Stop Marker; IOMMU drivers must discard
> > + * them before reporting faults. A PASID Stop Marker (LRW = 0b100) doesn't
> > + * expect a response. It may be generated when disabling a PASID (issuing a
> > + * PASID stop request) by some PCI devices.
> > + *
> > + * The PASID stop request is issued by the device driver before unbind(). Once
> > + * it completes, no page request is generated for this PASID anymore and
> > + * outstanding ones have been pushed to the IOMMU (as per PCIe 4.0r1.0 - 6.20.1
> > + * and 10.4.1.2 - Managing PASID TLP Prefix Usage). Some PCI devices will wait
> > + * for all outstanding page requests to come back with a response before
> > + * completing the PASID stop request. Others do not wait for page responses, and
> > + * instead issue this Stop Marker that tells us when the PASID can be
> > + * reallocated.
> > + *
> > + * It is safe to discard the Stop Marker because it is an optimization.
> > + * a. Page requests, which are posted requests, have been flushed to the IOMMU
> > + *    when the stop request completes.
> > + * b. We flush all fault queues on unbind() before freeing the PASID.
> > + *
> > + * So even though the Stop Marker might be issued by the device *after* the stop
> > + * request completes, outstanding faults will have been dealt with by the time
> > + * we free the PASID.
> > + *
> >    * Return: 0 on success and <0 on error.
> >    */
> >   int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
> > 
> 
> The same for the comments.

I think I'll squash both patches, probably doesn't make it harder to
review.

Thanks,
Jean

