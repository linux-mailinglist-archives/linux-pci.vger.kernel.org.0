Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5BED179203
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 15:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgCDOKz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Mar 2020 09:10:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43776 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729616AbgCDOKz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Mar 2020 09:10:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id h9so2552865wrr.10
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2020 06:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7HwHHOirHwI1c4j5Tv3u9lHj4prOjYmBbBNbHrFitZg=;
        b=Q/6/YBabh+3hoAX2lwxr9pv+BA6F8RdNG6tLtX1bg/aislj9n8Gmj4CeXizdPlqgft
         CmQpjJEBAbscYl1+fBWSTwIw3Q+wl4TrDmjZJrl5wmkDlW6cEO2OLALqUjnUpgfw44/u
         XRD2SH+U+3LGbzsauCnxCczIwaG31q4mtJq6cN5NZdMgXdtdPJRXNnmjCr+94tPg+lLA
         KHTfh6h5pCiaaBcIZl39MWPMll42zzUvIORJenCDE9jzUv9vXF8eUanvdU7aIzACWArf
         8xEZxTj5/LYzGeCYId9/Id5fwR1H6KylI5CO0NUUG2UMvrQ0U4LwsnJmTGCM23qHOhp1
         tgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7HwHHOirHwI1c4j5Tv3u9lHj4prOjYmBbBNbHrFitZg=;
        b=QlGaT2GjLXkV8XglZtNfG19kbypV4rWd9fOPipKGOxKHwAWZVuud6Z+n8ZwE7Wa4rN
         lTSuLfQ0PfULeFnlWOTTDx30Rxdgp1ksMbvwskoSd7dUwPueqtW7+mfrIRgOz/Pi1fqQ
         s+wvOGBs6oePN31c8AMzcY6AT/UxXmEolKAqkcDajMnr+jl5+ecgA76QnnipNxhUXz0p
         k4pMo/XOWZtCpg9DbSccKB9JiDXMwbd7r5TRFlSihZGdrmdfFkV8sC3lBkB33QSd35eA
         m1w0dZkaIvU5aouJJsFPbtF6MAU8O8rTHQkV4niIQUvmIk8KiOLGwXtj0NReN1B554+4
         1koA==
X-Gm-Message-State: ANhLgQ2E0Q1FpOIqAlz1OpA6ETR3MHKnKLincjJqKLbQetMfU+Bt2+4M
        ui5eVIz5OrRC9h7ARM6Ujw7A+g==
X-Google-Smtp-Source: ADFU+vtjRZ/ieGhvG1dNL4yvCidxtjrzWvostamf6vAXdMbRNS014Ivp7HqYWw4uSzXl8u6GytSgWA==
X-Received: by 2002:a5d:698a:: with SMTP id g10mr4347543wru.155.1583331052514;
        Wed, 04 Mar 2020 06:10:52 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id t124sm4805947wmg.13.2020.03.04.06.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 06:10:52 -0800 (PST)
Date:   Wed, 4 Mar 2020 15:10:45 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, jacob.jun.pan@linux.intel.com,
        christian.koenig@amd.com, yi.l.liu@intel.com,
        zhangfei.gao@linaro.org,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v4 07/26] arm64: mm: Pin down ASIDs for sharing mm with
 devices
Message-ID: <20200304141045.GD646000@myrica>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-8-jean-philippe@linaro.org>
 <20200227174351.00004d0d@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227174351.00004d0d@Huawei.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 27, 2020 at 05:43:51PM +0000, Jonathan Cameron wrote:
> On Mon, 24 Feb 2020 19:23:42 +0100
> Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> 
> > From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > 
> > To enable address space sharing with the IOMMU, introduce mm_context_get()
> > and mm_context_put(), that pin down a context and ensure that it will keep
> > its ASID after a rollover. Export the symbols to let the modular SMMUv3
> > driver use them.
> > 
> > Pinning is necessary because a device constantly needs a valid ASID,
> > unlike tasks that only require one when running. Without pinning, we would
> > need to notify the IOMMU when we're about to use a new ASID for a task,
> > and it would get complicated when a new task is assigned a shared ASID.
> > Consider the following scenario with no ASID pinned:
> > 
> > 1. Task t1 is running on CPUx with shared ASID (gen=1, asid=1)
> > 2. Task t2 is scheduled on CPUx, gets ASID (1, 2)
> > 3. Task tn is scheduled on CPUy, a rollover occurs, tn gets ASID (2, 1)
> >    We would now have to immediately generate a new ASID for t1, notify
> >    the IOMMU, and finally enable task tn. We are holding the lock during
> >    all that time, since we can't afford having another CPU trigger a
> >    rollover. The IOMMU issues invalidation commands that can take tens of
> >    milliseconds.
> > 
> > It gets needlessly complicated. All we wanted to do was schedule task tn,
> > that has no business with the IOMMU. By letting the IOMMU pin tasks when
> > needed, we avoid stalling the slow path, and let the pinning fail when
> > we're out of shareable ASIDs.
> > 
> > After a rollover, the allocator expects at least one ASID to be available
> > in addition to the reserved ones (one per CPU). So (NR_ASIDS - NR_CPUS -
> > 1) is the maximum number of ASIDs that can be shared with the IOMMU.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> A few more trivial points.

I'll fix those, thanks

Jean
