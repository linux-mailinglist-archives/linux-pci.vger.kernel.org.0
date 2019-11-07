Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECE3F2ADE
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 10:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387596AbfKGJjy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 04:39:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50234 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfKGJjx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Nov 2019 04:39:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GKBY9R45D3jLjHPP9vTN8xezy3kWbDosv9Dt0qppl+Q=; b=ManZYR0eplbkfL4+Ypqtvgcid
        PrXa9JSfiHL7p9zWb1z2yZVj2Afuvr+qMunpdmTPmmRVWziF27ttyzgJgCLSpp9H++t3cb/ucyIJb
        JqZF3ZSd020m22FaTU/4UvuPai/YmWkjwIw/WzaH3s33D4nPhS2UH4ejDhGBoVKMqCY2zXSV9F69M
        3yFsHfTz5xSz3i6wVCMhv+slMhraPiGP5CummmAC/dylT0S19vhi+kOO+KZJO+Cv6u+sJbOev5K6f
        K+Nrl+0WZKPRR0NJqi4aSEcwDUpl9dzxQD35mivaqA1QFbLVuzY40JUWwrztOrr1/WI7EMqW3QkP/
        A6UpH9ikw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSeGe-0003pH-8b; Thu, 07 Nov 2019 09:39:52 +0000
Date:   Thu, 7 Nov 2019 01:39:52 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI: vmd: Reducing tail latency by affining to the
 storage stack
Message-ID: <20191107093952.GA13826@infradead.org>
References: <1573040408-3831-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573040408-3831-1-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 06, 2019 at 04:40:05AM -0700, Jon Derrick wrote:
> This patchset optimizes VMD performance through the storage stack by locating
> commonly-affined NVMe interrupts on the same VMD interrupt handler lists.
> 
> The current strategy of round-robin assignment to VMD IRQ lists can be
> suboptimal when vectors with different affinities are assigned to the same VMD
> IRQ list. VMD is an NVMe storage domain and this set aligns the vector
> allocation and affinity strategy with that of the NVMe driver. This invokes the
> kernel to do the right thing when affining NVMe submission cpus to NVMe
> completion vectors as serviced through the VMD interrupt handler lists.
> 
> This set greatly reduced tail latency when testing 8 threads of random 4k reads
> against two drives at queue depth=128. After pinning the tasks to reduce test
> variability, the tests also showed a moderate tail latency reduction. A
> one-drive configuration also shows improvements due to the alignment of VMD IRQ
> list affinities with NVMe affinities.

How does this compare to simplify disabling VMD?
