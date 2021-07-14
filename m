Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B693C8336
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jul 2021 12:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhGNKvG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jul 2021 06:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbhGNKvG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jul 2021 06:51:06 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FDDC06175F;
        Wed, 14 Jul 2021 03:48:14 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id DE14E352; Wed, 14 Jul 2021 12:48:11 +0200 (CEST)
Date:   Wed, 14 Jul 2021 12:48:10 +0200
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
Message-ID: <YO7A6qRJrQYzljlv@8bytes.org>
References: <20210624171759.4125094-1-dianders@chromium.org>
 <YNXXwvuErVnlHt+s@8bytes.org>
 <CAD=FV=UFxZH7g8gH5+M=Fv4Y-e1bsLkNkPGJhNwhvVychcGQcQ@mail.gmail.com>
 <CAD=FV=W=HmgH3O3z+nThWL6U+X4Oh37COe-uTzVB9SanP2n86w@mail.gmail.com>
 <YOaymBHc4g2cIfRn@8bytes.org>
 <edd1de35-5b9e-b679-9428-23c6d5005740@arm.com>
 <YO65OOScL5vru1Kr@8bytes.org>
 <255adda2-3b5f-b080-4da1-f3c5d5a4f7a6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <255adda2-3b5f-b080-4da1-f3c5d5a4f7a6@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 14, 2021 at 11:29:08AM +0100, Robin Murphy wrote:
> As mentioned yesterday, already done! I'm hoping to be able to post the
> patches next week after some testing :)

Great, looking forward to your patches :-)

