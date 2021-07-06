Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F323BD89C
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jul 2021 16:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhGFOpM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jul 2021 10:45:12 -0400
Received: from verein.lst.de ([213.95.11.211]:33850 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232771AbhGFOog (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Jul 2021 10:44:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 67BF268BEB; Tue,  6 Jul 2021 16:05:13 +0200 (CEST)
Date:   Tue, 6 Jul 2021 16:05:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
        peterz@infradead.org, benh@kernel.crashing.org,
        joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
        chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
        Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Saravana Kannan <saravanak@google.com>, mpe@ellerman.id.au,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        bskeggs@redhat.com, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Thierry Reding <treding@nvidia.com>,
        intel-gfx@lists.freedesktop.org, matthew.auld@intel.com,
        linux-devicetree <devicetree@vger.kernel.org>,
        Jianxiong Gao <jxgao@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        maarten.lankhorst@linux.intel.com, airlied@linux.ie,
        Dan Williams <dan.j.williams@intel.com>,
        linuxppc-dev@lists.ozlabs.org, jani.nikula@linux.intel.com,
        Nathan Chancellor <nathan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, rodrigo.vivi@intel.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Claire Chang <tientzu@chromium.org>,
        boris.ostrovsky@oracle.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        jgross@suse.com, Nicolas Boichat <drinkcat@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Jim Quinlan <james.quinlan@broadcom.com>, xypron.glpk@gmx.de,
        Tom Lendacky <thomas.lendacky@amd.com>, bauerman@linux.ibm.com
Subject: Re: [PATCH v15 06/12] swiotlb: Use is_swiotlb_force_bounce for
 swiotlb data bouncing
Message-ID: <20210706140513.GA26498@lst.de>
References: <YNyUQwiagNeZ9YeJ@Ryzen-9-3900X.localdomain> <20210701074045.GA9436@willie-the-truck> <ea28db1f-846e-4f0a-4f13-beb67e66bbca@kernel.org> <20210702135856.GB11132@willie-the-truck> <0f7bd903-e309-94a0-21d7-f0e8e9546018@arm.com> <YN/7xcxt/XGAKceZ@Ryzen-9-3900X.localdomain> <20210705190352.GA19461@willie-the-truck> <20210706044848.GA13640@lst.de> <20210706132422.GA20327@willie-the-truck> <a59f771f-3289-62f0-ca50-8f3675d9b166@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a59f771f-3289-62f0-ca50-8f3675d9b166@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 06, 2021 at 03:01:04PM +0100, Robin Murphy wrote:
> FWIW I was pondering the question of whether to do something along those 
> lines or just scrap the default assignment entirely, so since I hadn't got 
> round to saying that I've gone ahead and hacked up the alternative 
> (similarly untested) for comparison :)
>
> TBH I'm still not sure which one I prefer...

Claire did implement something like your suggestion originally, but
I don't really like it as it doesn't scale for adding multiple global
pools, e.g. for the 64-bit addressable one for the various encrypted
secure guest schemes.
