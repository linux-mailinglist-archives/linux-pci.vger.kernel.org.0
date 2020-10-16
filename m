Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E698E28FEDE
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 09:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394482AbgJPHIS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Oct 2020 03:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394372AbgJPHIS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Oct 2020 03:08:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E7CC061755;
        Fri, 16 Oct 2020 00:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7hDZyCA6qqeFEGjeTlc4gGrS7CvSOlfXIwAkcHsgm2w=; b=k8oyVg7rGOZx44tA0mS5WPKXXs
        C63Oo7WDgn57KNzl4V7otFTkuu/0VbSILsCkheyAWt7GJ8qcgaL8nwAIg3yDJbneC45+q2nuUmtM0
        4Pwep9eEw2kj9CyGrILIpTxHElmf+CGdazQPfLA+ZsO59LzWxIJ8w2hIr/Nrj0EYnhegzYIG/L25T
        fIbRZptfAP10eR46Orq4V5rtGBQnn5GnTipw+Tja6/7EGWefxrx9jr1Ompn1PxcLLEYhkidd7lOLs
        wPhdBf2SQ86kIP/+ewYyX54amShiiaXPdBXob2I4SgPFZYK5fuM9TU/0fC/upkTt9+aOJokhY0NaP
        al55VkQA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTJqJ-0003Sd-NB; Fri, 16 Oct 2020 07:07:59 +0000
Date:   Fri, 16 Oct 2020 08:07:59 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        zhangfei.gao@linaro.org, wangzhou1@hisilicon.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-accelerators@lists.ozlabs.org,
        kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
        ashok.raj@intel.com, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] iommu: Add IOMMU_UNBIND_FAULT_PENDING flag
Message-ID: <20201016070759.GA12905@infradead.org>
References: <20201015090028.1278108-1-jean-philippe@linaro.org>
 <20201015090028.1278108-3-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015090028.1278108-3-jean-philippe@linaro.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 15, 2020 at 11:00:29AM +0200, Jean-Philippe Brucker wrote:
> IOMMU drivers only need to flush their PRI queue when faults might be
> pending. According to the PCIe spec (quoted below) this only happens
> when using the "Stop Marker" method. Otherwise the function waits for
> pending faults before signaling to the device driver that it can
> unbind().
> 
> Add the IOMMU_UNBIND_FAULT_PENDING flags to unbind(), to tell the IOMMU
> driver whether it's worth flushing the queue.

As we have no code using the "stop marker" method please just remove
the code entirely instead of adding a flag that is just dead code.
