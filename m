Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B301E2469
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 16:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgEZOrJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 10:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgEZOrI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 10:47:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C375CC03E96D;
        Tue, 26 May 2020 07:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0Lm8kIZucM9N101SLlLcwGvyzcwDFh9rh0/kpGAsWR8=; b=iFU/FK7WgcwuU1nzH+IvLCDEOD
        YW7VLT4NCbBO4cOYoghFHPWsHEwrpF4u0zer832+q3IxpnxJl8WDMI88a5n0shvG+FnLOoglo6l7m
        nBwOdx29rjE2SXhYw9An4k+rTcd3zEWAbd4T3H/2czviIm9e1FgwaCa4ecfsOuFylZmMf66QNPWs+
        6mzmPJOUafuLVb3g45f1LeBEz6HRq9V37zOT3LER8/BKQPtI/WSburZIopEnE2UKazsrtlu2QzVH1
        Pd3yDpx5Z4HpRq6oYD/qL7uamCmt81uIRkA46myiz5qRqe1u7cgEMkkmlUNal1fWdOAApqtTrftfn
        UyN0pNcQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdaqq-0005YE-Ty; Tue, 26 May 2020 14:46:44 +0000
Date:   Tue, 26 May 2020 07:46:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] PCI: Introduce PCI_FIXUP_IOMMU
Message-ID: <20200526144644.GA20784@infradead.org>
References: <1590493749-13823-1-git-send-email-zhangfei.gao@linaro.org>
 <1590493749-13823-2-git-send-email-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590493749-13823-2-git-send-email-zhangfei.gao@linaro.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 26, 2020 at 07:49:08PM +0800, Zhangfei Gao wrote:
> Some platform devices appear as PCI but are actually on the AMBA bus,
> and they need fixup in drivers/pci/quirks.c handling iommu_fwnode.
> Here introducing PCI_FIXUP_IOMMU, which is called after iommu_fwnode
> is allocated, instead of reusing PCI_FIXUP_FINAL since it will slow
> down iommu probing as all devices in fixup final list will be
> reprocessed.

Who is going to use this?  I don't see a single user in the series.
