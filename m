Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E99125658A
	for <lists+linux-pci@lfdr.de>; Sat, 29 Aug 2020 09:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgH2HI2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Aug 2020 03:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgH2HI1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Aug 2020 03:08:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC435C061236
        for <linux-pci@vger.kernel.org>; Sat, 29 Aug 2020 00:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QB//6Se/PwN6GvSv/9WDlotukz26aOQelOfBoaCGjo4=; b=lPlY+5e2PJc55L35Wm1SGoULrK
        9Ww4X6h4/xmTgOZixAoHkmNEpE38/Rk9+gOKJRCZSqtZ91ZNLS1T7hf2SH2k5kCQyK4ChoOFzqg5h
        XdqmY+NKXsEqn7+Iu6fy9akagWPM0pnvrFwKfnsjVvde9KRCnYgqG9N+8xJrDvKNZtm2jRHECznO4
        EHSJqSut8lz+dLPaahPy+XYAS3tFccxryqRgRAOwKbfpucu/Cig+064vx+89UzkYpvK0mA26TfqSV
        42R2YveR6schhNzUJhGO5r0s3XrT908VW9+QdkQfxFRe7pNXghJfCGqYQ6V4g7PCOscSu109mVzzh
        8WaEEg5g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBuyO-0000xk-DN; Sat, 29 Aug 2020 07:08:24 +0000
Date:   Sat, 29 Aug 2020 08:08:24 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1] PCI/P2PDMA: Use DMA ops setter instead of direct
 assignment
Message-ID: <20200829070824.GA2526@infradead.org>
References: <20200828111157.7639-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828111157.7639-1-andriy.shevchenko@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 28, 2020 at 02:11:57PM +0300, Andy Shevchenko wrote:
> Use DMA ops setter instead of direct assignment. Even we know that
> this module doesn't perform access to the dma_ops member of struct device,
> it's better to use setter to avoid potential problems in the future.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

As mentioned in reply to the intel-iommu patch: I plan to remove these
accessors soon.
