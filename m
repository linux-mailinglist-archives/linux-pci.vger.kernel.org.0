Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FE02CA60B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Dec 2020 15:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388786AbgLAOpN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Dec 2020 09:45:13 -0500
Received: from foss.arm.com ([217.140.110.172]:44166 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387462AbgLAOpN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Dec 2020 09:45:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A91FC30E;
        Tue,  1 Dec 2020 06:44:27 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2E5E3F718;
        Tue,  1 Dec 2020 06:44:25 -0800 (PST)
Date:   Tue, 1 Dec 2020 14:44:20 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, robh+dt@kernel.org,
        bhelgaas@google.com, jonathanh@nvidia.com,
        amanharitsh123@gmail.com, dinghao.liu@zju.edu.cn, kw@linux.com,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4 4/6] PCI: tegra: Continue unconfig sequence even if
 parts fail
Message-ID: <20201201144420.GA4397@e121166-lin.cambridge.arm.com>
References: <20201109171937.28326-1-vidyas@nvidia.com>
 <20201109171937.28326-5-vidyas@nvidia.com>
 <20201130121007.GC16758@e121166-lin.cambridge.arm.com>
 <X8ZSGCdp3lqORsPh@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8ZSGCdp3lqORsPh@ulmo>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 01, 2020 at 03:24:24PM +0100, Thierry Reding wrote:
> On Mon, Nov 30, 2020 at 12:10:07PM +0000, Lorenzo Pieralisi wrote:
> > On Mon, Nov 09, 2020 at 10:49:35PM +0530, Vidya Sagar wrote:
> > > Currently the driver checks for error value of different APIs during the
> > > uninitialization sequence. It just returns from there if there is any error
> > > observed for one of those calls. Comparatively it is better to continue the
> > > uninitialization sequence irrespective of whether some of them are
> > > returning error. That way, it is more closer to complete uninitialization.
> > 
> > Hi Vidya, Thierry,
> > 
> > I can apply this series (dropping patches as suggested by Thierry),
> > before though I wanted to ask you if this patch is really an
> > improvement, it is hard to understand why skipping some error
> > codes is OK for device correct operations to continue, maybe it
> > is worth describing why some of those failures aren't really
> > fatal.
> > 
> > Please let me know, thanks.
> 
> As explained in the commit message, the idea is to continue tearing
> down even if things fail somewhere in the middle, because that ensures
> that the hardware gets as close to an "uninitialized" state as possible.
> If for example the first reset assert were to fail, then none of the
> PHYs get disabled, the regulator stays on and the clocks stays on, all
> of which can continue draining power after the controller has already
> been torn down.

Understood. By reading the code it looked weird that eg a reset failure
was tolerable - I thought an error would be fatal (I don't know what are
the consequences for instance on a subsequent resume) but it looks like
it actually is not, that's the only point I raised.

> So yes, I think this is an improvement. It's unclear to me what you're
> asking for, though. Would you rather have a comment somewhere near the
> tegra_pcie_unconfig_controller() function that states the same thing as
> the commit message?

It could be useful but it is up to you, I will merge the series as-is
or I can add it myself, as you wish.

Thanks,
Lorenzo
