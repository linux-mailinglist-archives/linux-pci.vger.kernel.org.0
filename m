Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF121ABBC5
	for <lists+linux-pci@lfdr.de>; Thu, 16 Apr 2020 10:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502988AbgDPIys (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Apr 2020 04:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502984AbgDPIyR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Apr 2020 04:54:17 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE39C061A41
        for <linux-pci@vger.kernel.org>; Thu, 16 Apr 2020 01:54:12 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h9so3847554wrc.8
        for <linux-pci@vger.kernel.org>; Thu, 16 Apr 2020 01:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZEfcdbyCoFlwcBaVZ+sf0k9hPs9ies0vbK3IcfLzskw=;
        b=LLp5LveCwz1C/4FgavId+LAMO+lPQeQAh5i6g/dwBkd5KRmxdDAOZ9/FDSM6LaE2DO
         Td6D1PD2vfJMUfU418BKIvqN2n542k0/GOSD1zFfk3KEg6YVnVpiYcQElgtfTWfhW1Hc
         pyRHcoAoIzLIeqmthE1eiaqNblTBPZh2QK//NuiYOH4m49CJlMjlge+Af8W0dLnPXfDM
         TI6i6FGWr2uL3dkWfiES2q+uTGrtmI8VH2eWwpnuQoWS1aDfIKdtLlIrcAMs/dkatob5
         C2RU6qFiWHenxSdOpD61IuhKr0PagtaYgwqeoLijcAccCZ9r8LhwudjqfQNZwoQRmc4d
         jdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZEfcdbyCoFlwcBaVZ+sf0k9hPs9ies0vbK3IcfLzskw=;
        b=iilUXP24Dd+q6d68vx5/lRlHeqWFz2BEAIzKEa3ZrZS2Mi2a7nVSVfQMNYITIYhNU5
         h4xcRTLPP8r9qMMrd2PJCb+CmuXtNfTtd8nEe7ThWzAhkJSfIH6AtEKqE/aYq/r6hqzj
         5TKEk1gKPa7tbMmTJKo9lLP0SJigVKEY7lnMC/WrdPKcY/qZg301cKViPlto96utZzij
         fn8wA12LQEBefwkK3OcKoBzFjGiLnkFeqrnvMEatksjDt+UdV3gbRVXdTcDZtTp50ZiD
         gNeXTPALtDtC3KIM4lB7YeozOEzp6ROxDE5iAe9D/8PFW/0ZwBlzYOz8KPtK3jDrZYLP
         4gPQ==
X-Gm-Message-State: AGi0PuYPjKj7pzYVk7HKbVrr/QVIwGKxfsHnpIu8Wj7z8nIA3nakW8Wc
        jGi8qZxNQwtMW/RLV5f1PmYpmQ==
X-Google-Smtp-Source: APiQypL1oyr16FXQx+dkfWQBU6EhMLZhnOgOJbCMSB0gnYSQVADLx4g3CAzdUNtaCRw76OTkBu7LoA==
X-Received: by 2002:a5d:6305:: with SMTP id i5mr34790010wru.203.1587027251542;
        Thu, 16 Apr 2020 01:54:11 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id u7sm3027041wmg.41.2020.04.16.01.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 01:54:11 -0700 (PDT)
Date:   Thu, 16 Apr 2020 10:54:02 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com
Subject: Re: [PATCH v5 02/25] iommu/sva: Manage process address spaces
Message-ID: <20200416085402.GB1286150@myrica>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
 <20200414170252.714402-3-jean-philippe@linaro.org>
 <20200416072852.GA32000@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416072852.GA32000@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 16, 2020 at 12:28:52AM -0700, Christoph Hellwig wrote:
> > +	rcu_read_lock();
> > +	hlist_for_each_entry_rcu(bond, &io_mm->devices, mm_node)
> > +		io_mm->ops->invalidate(bond->sva.dev, io_mm->pasid, io_mm->ctx,
> > +				       start, end - start);
> > +	rcu_read_unlock();
> > +}
> 
> What is the reason that the devices don't register their own notifiers?
> This kinds of multiplexing is always rather messy, and you do it for
> all the methods.

This sends TLB and ATC invalidations through the IOMMU, it doesn't go
through device drivers

Thanks,
Jean
