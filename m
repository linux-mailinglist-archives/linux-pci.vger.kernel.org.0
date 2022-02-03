Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC33D4A83C3
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 13:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350376AbiBCMWQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 07:22:16 -0500
Received: from foss.arm.com ([217.140.110.172]:43618 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229379AbiBCMWQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Feb 2022 07:22:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B206211D4;
        Thu,  3 Feb 2022 04:22:15 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6F9A3F774;
        Thu,  3 Feb 2022 04:22:13 -0800 (PST)
Date:   Thu, 3 Feb 2022 12:22:11 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org, jonathanh@nvidia.com,
        krzysztof.kozlowski@canonical.com, robh@kernel.org, kw@linux.com,
        p.zabel@pengutronix.de, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 5/5] PCI: tegra194: Handle errors in BPMP response
Message-ID: <20220203122211.GB24443@lpieralisi>
References: <20210915085517.1669675-1-mperttunen@nvidia.com>
 <20210915085517.1669675-5-mperttunen@nvidia.com>
 <YV86l4OhqKN0AkMN@orome.fritz.box>
 <20211013125956.GA11036@lpieralisi>
 <20211129121918.GA24438@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129121918.GA24438@lpieralisi>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 29, 2021 at 12:19:18PM +0000, Lorenzo Pieralisi wrote:
> On Wed, Oct 13, 2021 at 01:59:56PM +0100, Lorenzo Pieralisi wrote:
> > On Thu, Oct 07, 2021 at 08:21:11PM +0200, Thierry Reding wrote:
> > > On Wed, Sep 15, 2021 at 11:55:17AM +0300, Mikko Perttunen wrote:
> > > > The return value from tegra_bpmp_transfer indicates the success or
> > > > failure of the IPC transaction with BPMP. If the transaction
> > > > succeeded, we also need to check the actual command's result code.
> > > > Add code to do this.
> > > > 
> > > > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-tegra194.c | 9 ++++++++-
> > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > Acked-by: Thierry Reding <treding@nvidia.com>
> > 
> > Hi Thierry,
> > 
> > can I pull this patch into the PCI tree ? Or if you want the series
> > to go via another tree:
> > 
> > Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> Hi,
> 
> I would like to ask please how you want this series to be handled.

Should I apply this patch stand-alone ?

I will mark all other patches in this series as Not Applicable in
the PCI queue.

Thanks,
Lorenzo
