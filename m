Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8F01791F9
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 15:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgCDOJv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Mar 2020 09:09:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41461 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgCDOJv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Mar 2020 09:09:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id v4so2552440wrs.8
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2020 06:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EpXtvX1PfW3FZz13OtRHOjQvZ2fsaz2TnoP+n0E2ZUg=;
        b=g8SWXvPTyPZzLcsUAC4+i3gEYS7VjOjujoBVioj8kKYK73oXfKh+MAvo8mRWnu071C
         gxiMmhvSdwjKzrw34AWvhgikZX0Hrhz4jre0uVLyzI7CZYL/VDsf5gHJObclPdLagxZi
         s+6qEVWA3DXyXew+YkVb+rgAVC49YN8D3mPAbPfbz2b2vq1fO6ty0UB+H65pdv6FjJ6Y
         v3/70bPC/jxD75YgWO2V9B7pyWv0bv8SImmbScC8XftPtCDEBeJXHlj8SYkcVTIy6y7V
         32lZyBoyNgNFy1f0QHfB5NbM0+cCHEojMhPDvMZmAXMM6fqrb+f7yzzdQe1b3vIru/ak
         r5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EpXtvX1PfW3FZz13OtRHOjQvZ2fsaz2TnoP+n0E2ZUg=;
        b=qslJ1hdkvI+yKcpRT16ozoVIAVZFEQmFRvBHoDso58pWoN58/ZGETsN2Y7hb9KQbb9
         nJgN6fDlwIZlXfRlvCWAtjW2r6cW1lp5xo0ezqvujZPIGWHZetqNICMtsuUq3buBo4cq
         6DlW9kbgx9BaIF+piGivM+O+tjOMToMMSnaQnOYJ5kmF8Hbv3Ywe3OlD2JrvPlUgVFh2
         nTudLxRBaJk4RHoFQaepFSZpHJBTBK1z60EZgdg07GhS0PUbQYIFkO51BboeTvf9lK9C
         4B/vEDB+iWAZxa8ubjG+fII90bJ7LyOqn1vdaSzJrmoEY+h9i4imOQiUdewpMhSN93qw
         mcJA==
X-Gm-Message-State: ANhLgQ1eMQzGWza5gD33/cEvKcqCs01bg8+8JxZtwQc50Wnc4Uk2rI1z
        OOCQhrvQEoLD1+U4czse0dYsNQ==
X-Google-Smtp-Source: ADFU+vtZMIq6Jg8tdrdLMObmNELyKi8gzYZ2wKQ8Qt7PTkGgWzXVAaeuMwK7RkrXzELghSD1BcL3DQ==
X-Received: by 2002:adf:e542:: with SMTP id z2mr4532686wrm.150.1583330987727;
        Wed, 04 Mar 2020 06:09:47 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id q12sm41792293wrg.71.2020.03.04.06.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 06:09:46 -0800 (PST)
Date:   Wed, 4 Mar 2020 15:09:40 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Xu Zaibo <xuzaibo@huawei.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, mark.rutland@arm.com, kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        catalin.marinas@arm.com, robin.murphy@arm.com, robh+dt@kernel.org,
        zhangfei.gao@linaro.org, will@kernel.org, christian.koenig@amd.com
Subject: Re: [PATCH v4 23/26] iommu/arm-smmu-v3: Add stall support for
 platform devices
Message-ID: <20200304140940.GC646000@myrica>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-24-jean-philippe@linaro.org>
 <db6fc8c2-2ff3-631f-2294-c1b49acd27aa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db6fc8c2-2ff3-631f-2294-c1b49acd27aa@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 26, 2020 at 04:44:53PM +0800, Xu Zaibo wrote:
> Hi,
> 
> 
> On 2020/2/25 2:23, Jean-Philippe Brucker wrote:
> > From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > 
> > The SMMU provides a Stall model for handling page faults in platform
> > devices. It is similar to PCI PRI, but doesn't require devices to have
> > their own translation cache. Instead, faulting transactions are parked and
> > the OS is given a chance to fix the page tables and retry the transaction.
> > 
> > Enable stall for devices that support it (opt-in by firmware). When an
> > event corresponds to a translation error, call the IOMMU fault handler. If
> > the fault is recoverable, it will call us back to terminate or continue
> > the stall.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >   drivers/iommu/arm-smmu-v3.c | 271 ++++++++++++++++++++++++++++++++++--
> >   drivers/iommu/of_iommu.c    |   5 +-
> >   include/linux/iommu.h       |   2 +
> >   3 files changed, 269 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> > index 6a5987cce03f..da5dda5ba26a 100644
> > --- a/drivers/iommu/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm-smmu-v3.c
> > @@ -374,6 +374,13 @@
> >   #define CMDQ_PRI_1_GRPID		GENMASK_ULL(8, 0)
> >   #define CMDQ_PRI_1_RESP			GENMASK_ULL(13, 12)
> [...]
> > +static int arm_smmu_page_response(struct device *dev,
> > +				  struct iommu_fault_event *unused,
> > +				  struct iommu_page_response *resp)
> > +{
> > +	struct arm_smmu_cmdq_ent cmd = {0};
> > +	struct arm_smmu_master *master = dev_iommu_fwspec_get(dev)->iommu_priv;
> Here can use 'dev_to_master' ?

Certainly, good catch

Thanks,
Jean
