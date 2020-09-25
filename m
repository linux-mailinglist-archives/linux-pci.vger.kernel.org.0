Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D445278CD3
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 17:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgIYPe5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 11:34:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgIYPe5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Sep 2020 11:34:57 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03C42208B6;
        Fri, 25 Sep 2020 15:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601048097;
        bh=isVzHZ3nVuZIMD/UCtK27yZnNv9xwKk4e6gsdrwViRE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Q8l1/5txbGVUFYp+yS5jaVgBKf7HBxVWWvn7dssI/T/VnXgtOB3Yh/7ap1pyo1o5L
         68VuRk9wGLg9eN4ujSNKD2a6mD+n9gCRf/V/9MQCib3gQCnjawrnDRi5UXZY5E+uCt
         JGwodDTR2rO5rp3MdsEcOdGztSNeOjeGLARtuDMk=
Date:   Fri, 25 Sep 2020 10:34:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org,
        joro@8bytes.org, bhelgaas@google.com, mst@redhat.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, eric.auger@redhat.com,
        lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v3 5/6] iommu/virtio: Support topology description in
 config space
Message-ID: <20200925153455.GA2437869@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925081243.GA490533@myrica>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 25, 2020 at 10:12:43AM +0200, Jean-Philippe Brucker wrote:
> On Thu, Sep 24, 2020 at 10:22:03AM -0500, Bjorn Helgaas wrote:
> > On Fri, Aug 21, 2020 at 03:15:39PM +0200, Jean-Philippe Brucker wrote:

> > > +	/* Perform the init sequence before we can read the config */
> > > +	ret = viommu_pci_reset(common_cfg);
> > 
> > I guess this is some special device-specific reset, not any kind of
> > standard PCI reset?
> 
> Yes it's the virtio reset - writing 0 to the status register in the BAR.

I wonder if this should be named something like viommu_virtio_reset(),
so there's no confusion with PCI resets and all the timing
restrictions, config space restoration, etc. associated with them.

Bjorn
