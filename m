Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48DDD3C8294
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jul 2021 12:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238849AbhGNKSW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jul 2021 06:18:22 -0400
Received: from 8bytes.org ([81.169.241.247]:37742 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238728AbhGNKSW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Jul 2021 06:18:22 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C73C1352; Wed, 14 Jul 2021 12:15:27 +0200 (CEST)
Date:   Wed, 14 Jul 2021 12:15:20 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-pci@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Rajat Jain <rajatja@google.com>, Will Deacon <will@kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Saravana Kannan <saravanak@google.com>,
        Jonathan Corbet <corbet@lwn.net>, quic_c_gdjako@quicinc.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sonny Rao <sonnyrao@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH v2 0/3] iommu: Enable non-strict DMA on QCom SD/MMC
Message-ID: <YO65OOScL5vru1Kr@8bytes.org>
References: <20210624171759.4125094-1-dianders@chromium.org>
 <YNXXwvuErVnlHt+s@8bytes.org>
 <CAD=FV=UFxZH7g8gH5+M=Fv4Y-e1bsLkNkPGJhNwhvVychcGQcQ@mail.gmail.com>
 <CAD=FV=W=HmgH3O3z+nThWL6U+X4Oh37COe-uTzVB9SanP2n86w@mail.gmail.com>
 <YOaymBHc4g2cIfRn@8bytes.org>
 <edd1de35-5b9e-b679-9428-23c6d5005740@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edd1de35-5b9e-b679-9428-23c6d5005740@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Robin,

On Fri, Jul 09, 2021 at 02:56:47PM +0100, Robin Murphy wrote:
> As I mentioned before, conceptually I think this very much belongs in sysfs
> as a user decision. We essentially have 4 levels of "strictness":
> 
> 1: DMA domain with bounce pages
> 2: DMA domain
> 3: DMA domain with flush queue
> 4: Identity domain

Together with reasonable defaults (influenced by compile-time
options) it seems to be a good thing to configure at runtime via
sysfs.

We already have CONFIG_IOMMU_DEFAULT_PASSTHROUGH, which can probably be
extended to be an option list:

	- CONFIG_IOMMU_DEFAULT_PASSTHROUGH: Trusted devices are identity
					    mapped

	- CONFIG_IOMMU_DEFAULT_DMA_STRICT: Trusted devices are DMA
					   mapped with strict flush
					   behavior on unmap

	- CONFIG_IOMMU_DEFAULT_DMA_LAZY: Trusted devices are DMA mapped
					 with flush queues for performance

Untrusted devices always get into the DMA domain with bounce pages by
default.

The defaults can be changed at runtime via sysfs. We already have basic
support for runtime switching of the default domain, so that can be
re-used.

Regards,

	Joerg

