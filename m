Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EF8416C00
	for <lists+linux-pci@lfdr.de>; Fri, 24 Sep 2021 08:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244442AbhIXGqA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Sep 2021 02:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244396AbhIXGpy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Sep 2021 02:45:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35A4C061768;
        Thu, 23 Sep 2021 23:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yk37TJ1pv0m2OGjoSFSGGxlGCD0GciEiUSGDQBv+q1U=; b=ExiK0QjAHvn7VukF4+rlC/14Vm
        LC2bgapE+fU1Ac5IN8TOH7oMV+JoT56Q2EMxin+FgHZWhyPvGOovy1m5chiiewrMkZi50AYtvs8iB
        pYFykWdvAjVPdZnO8zNGvYREoJONApQKBAvoldhvcUIXGDxNvgXJFjDxT1h7aYXh7OLq9V0j0mSJE
        xpMrPWN/21I8lYyUIK6h+1Z1pWcC7FyCesrmVbVftrBKyiCG/ZXfEkOyeNrRFw9b3nnBd01G6OeSY
        qh6cZyXTYQxnMVWHZUSRscGikh2QWgRJOEVSELa57arYvW1uwiPhtKx174wgdL3BFb1A0hiwg0D9O
        qncrghsQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTeuh-006vf6-60; Fri, 24 Sep 2021 06:43:02 +0000
Date:   Fri, 24 Sep 2021 07:42:27 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 9/9] iommu/vt-d: Use pci core's DVSEC functionality
Message-ID: <YU1zU2jn/mGYDThY@infradead.org>
References: <20210923172647.72738-1-ben.widawsky@intel.com>
 <20210923172647.72738-10-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923172647.72738-10-ben.widawsky@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 23, 2021 at 10:26:47AM -0700, Ben Widawsky wrote:
>   */
>  static int siov_find_pci_dvsec(struct pci_dev *pdev)
>  {
> +	return pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_INTEL, 5);
>  }

I hink the siov_find_pci_dvsec helper is pretty pointless now and can be
folded into its only caller.  And independent of that: this capability
really needs a symbolic name.  Especially for a vendor like Intel that
might have a few there should be a list of them somewhere.

