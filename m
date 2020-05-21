Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A2A1DCF4F
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 16:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgEUOQq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 10:16:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbgEUOQq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 10:16:46 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CAC020721;
        Thu, 21 May 2020 14:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590070606;
        bh=J12/yI4JkwQoq0ZSsn8yVG8aHccxtJvArFtbGq3PfLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iLRAgstVdYm1eiYPWiirwh1nShyQnHb3MswJtEKjwgAgUxm1QVDn5HxOYZ69IgQ9O
         +bdDwuNQWPqhCTAcnwC/oKn7WosmzTgtEnBMm154hZhbBmPdVk0+3b4h92ALYIFy4S
         VN3+rF0oD3wb2KHpTYm7ICypRf6sf4/Xdzh9FkDw=
Date:   Thu, 21 May 2020 15:16:39 +0100
From:   Will Deacon <will@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, zhangfei.gao@linaro.org, jgg@ziepe.ca,
        xuzaibo@huawei.com, fenghua.yu@intel.com, hch@infradead.org
Subject: Re: [PATCH v7 07/24] iommu/io-pgtable-arm: Move some definitions to
 a header
Message-ID: <20200521141638.GF6608@willie-the-truck>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
 <20200519175502.2504091-8-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519175502.2504091-8-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 19, 2020 at 07:54:45PM +0200, Jean-Philippe Brucker wrote:
> Extract some of the most generic TCR defines, so they can be reused by
> the page table sharing code.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/io-pgtable-arm.h | 30 ++++++++++++++++++++++++++++++
>  drivers/iommu/io-pgtable-arm.c | 27 ++-------------------------
>  MAINTAINERS                    |  3 +--
>  3 files changed, 33 insertions(+), 27 deletions(-)
>  create mode 100644 drivers/iommu/io-pgtable-arm.h

Acked-by: Will Deacon <will@kernel.org>

Will
