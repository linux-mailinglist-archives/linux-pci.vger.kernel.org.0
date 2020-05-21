Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27AA1DD030
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 16:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgEUOii (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 10:38:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbgEUOii (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 10:38:38 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D32A20671;
        Thu, 21 May 2020 14:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590071917;
        bh=OiPs36foL9u2qM53WH6N6taB239fXx9YwYNRpOR+uc8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IOEcaexAkIOaBlLyjmM4y4cc/lI+AvTt2XG3MJSe97tPOOBgmi21ZXYe/wbygmmAv
         5aXAD0JnBq4smiwKKP0tkBFg6mfmBK9KQxomojoIgqFlfdKP3EZ7WzahgMAIQfnPLY
         ixdP2n51XBJE02yNEqT0nnudoDksFaXfwPwqR4lA=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jbmLD-00EFyF-AE; Thu, 21 May 2020 15:38:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 21 May 2020 15:38:35 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, zhangfei.gao@linaro.org, jgg@ziepe.ca,
        xuzaibo@huawei.com, fenghua.yu@intel.com, hch@infradead.org
Subject: Re: [PATCH v7 13/24] iommu/arm-smmu-v3: Enable broadcast TLB
 maintenance
In-Reply-To: <20200521141730.GJ6608@willie-the-truck>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
 <20200519175502.2504091-14-jean-philippe@linaro.org>
 <20200521141730.GJ6608@willie-the-truck>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <0c896ad27b43b2de554cf772f9453d0a@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, jean-philippe@linaro.org, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com, robin.murphy@arm.com, kevin.tian@intel.com, baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com, jacob.jun.pan@linux.intel.com, christian.koenig@amd.com, felix.kuehling@amd.com, zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com, fenghua.yu@intel.com, hch@infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-05-21 15:17, Will Deacon wrote:
> [+Marc]
> 
> On Tue, May 19, 2020 at 07:54:51PM +0200, Jean-Philippe Brucker wrote:
>> The SMMUv3 can handle invalidation targeted at TLB entries with shared
>> ASIDs. If the implementation supports broadcast TLB maintenance, 
>> enable it
>> and keep track of it in a feature bit. The SMMU will then be affected 
>> by
>> inner-shareable TLB invalidations from other agents.
>> 
>> A major side-effect of this change is that stage-2 translation 
>> contexts
>> are now affected by all invalidations by VMID. VMIDs are all shared 
>> and
>> the only ways to prevent over-invalidation, since the stage-2 page 
>> tables
>> are not shared between CPU and SMMU, are to either disable BTM or 
>> allocate
>> different VMIDs. This patch does not address the problem.
> 
> This sounds like a potential performance issue, particularly as we 
> expose
> stage-2 contexts via VFIO directly. Maybe we could reserve some portion 
> of
> VMID space for the SMMU? Marc, what do you reckon?

Certainly doable when we have 16bits VMIDs. With smaller VMID spaces 
(like on
v8.0), this is a bit more difficult (we do have pretty large v8.0 
systems
around). How many VMID bits are we talking about?

         M.
-- 
Jazz is not dead. It just smells funny...
