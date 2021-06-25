Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE543B4445
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 15:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhFYNVX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 09:21:23 -0400
Received: from 8bytes.org ([81.169.241.247]:52276 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230151AbhFYNVW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Jun 2021 09:21:22 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A7AA23FC; Fri, 25 Jun 2021 15:18:59 +0200 (CEST)
Date:   Fri, 25 Jun 2021 15:18:58 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     will@kernel.org, robin.murphy@arm.com, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, adrian.hunter@intel.com,
        bhelgaas@google.com, john.garry@huawei.com, robdclark@chromium.org,
        quic_c_gdjako@quicinc.com, saravanak@google.com,
        rajatja@google.com, saiprakash.ranjan@codeaurora.org,
        vbadigan@codeaurora.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, sonnyrao@chromium.org,
        joel@joelfernandes.org, Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Reddy <vdumpa@nvidia.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iommu: Enable non-strict DMA on QCom SD/MMC
Message-ID: <YNXXwvuErVnlHt+s@8bytes.org>
References: <20210624171759.4125094-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624171759.4125094-1-dianders@chromium.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Douglas,

On Thu, Jun 24, 2021 at 10:17:56AM -0700, Douglas Anderson wrote:
> The goal of this patch series is to get better SD/MMC performance on
> Qualcomm eMMC controllers and in generally nudge us forward on the
> path of allowing some devices to be in strict mode and others to be in
> non-strict mode.

So if I understand it right, this patch-set wants a per-device decision
about setting dma-mode to strict vs. non-strict.

I think we should get to the reason why strict mode is used by default
first. Is the default on ARM platforms to use iommu-strict mode by
default and if so, why?

The x86 IOMMUs use non-strict mode by default (yes, it is a security
trade-off).

Regards,

	Joerg
