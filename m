Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666DA1DCF65
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 16:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbgEUORi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 10:17:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729678AbgEUORi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 10:17:38 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A49A20721;
        Thu, 21 May 2020 14:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590070657;
        bh=5MRn3H5sZAZmyAJ7ms4hcDmOF+0kJdAcWrKPmQYOlR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hk9BuL52Yd+s1F9PZBKDi1fOj/hBpMdLhnVRrqDGLJHOMJUJ4cx1CtTqJjqji14lA
         se04HPgcV50e35bBPs6oZN10HauSB5SCTxRi9BAEpAi6JOpzQotWs8pN2P23RLU3T9
         jRk0X8KLGknqWO03sXQQpGyIbmzpKdaGmJhlarzo=
Date:   Thu, 21 May 2020 15:17:31 +0100
From:   Will Deacon <will@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, zhangfei.gao@linaro.org, jgg@ziepe.ca,
        xuzaibo@huawei.com, fenghua.yu@intel.com, hch@infradead.org,
        maz@kernel.org
Subject: Re: [PATCH v7 13/24] iommu/arm-smmu-v3: Enable broadcast TLB
 maintenance
Message-ID: <20200521141730.GJ6608@willie-the-truck>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
 <20200519175502.2504091-14-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519175502.2504091-14-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Marc]

On Tue, May 19, 2020 at 07:54:51PM +0200, Jean-Philippe Brucker wrote:
> The SMMUv3 can handle invalidation targeted at TLB entries with shared
> ASIDs. If the implementation supports broadcast TLB maintenance, enable it
> and keep track of it in a feature bit. The SMMU will then be affected by
> inner-shareable TLB invalidations from other agents.
> 
> A major side-effect of this change is that stage-2 translation contexts
> are now affected by all invalidations by VMID. VMIDs are all shared and
> the only ways to prevent over-invalidation, since the stage-2 page tables
> are not shared between CPU and SMMU, are to either disable BTM or allocate
> different VMIDs. This patch does not address the problem.

This sounds like a potential performance issue, particularly as we expose
stage-2 contexts via VFIO directly. Maybe we could reserve some portion of
VMID space for the SMMU? Marc, what do you reckon?

Will
