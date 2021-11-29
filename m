Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6164614E9
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 13:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344185AbhK2MYs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 07:24:48 -0500
Received: from foss.arm.com ([217.140.110.172]:37344 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241775AbhK2MWn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Nov 2021 07:22:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AD741042;
        Mon, 29 Nov 2021 04:19:25 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B24B3F694;
        Mon, 29 Nov 2021 04:19:23 -0800 (PST)
Date:   Mon, 29 Nov 2021 12:19:18 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, jonathanh@nvidia.com,
        krzysztof.kozlowski@canonical.com, robh@kernel.org, kw@linux.com,
        p.zabel@pengutronix.de, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 5/5] PCI: tegra194: Handle errors in BPMP response
Message-ID: <20211129121918.GA24438@lpieralisi>
References: <20210915085517.1669675-1-mperttunen@nvidia.com>
 <20210915085517.1669675-5-mperttunen@nvidia.com>
 <YV86l4OhqKN0AkMN@orome.fritz.box>
 <20211013125956.GA11036@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013125956.GA11036@lpieralisi>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 13, 2021 at 01:59:56PM +0100, Lorenzo Pieralisi wrote:
> On Thu, Oct 07, 2021 at 08:21:11PM +0200, Thierry Reding wrote:
> > On Wed, Sep 15, 2021 at 11:55:17AM +0300, Mikko Perttunen wrote:
> > > The return value from tegra_bpmp_transfer indicates the success or
> > > failure of the IPC transaction with BPMP. If the transaction
> > > succeeded, we also need to check the actual command's result code.
> > > Add code to do this.
> > > 
> > > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-tegra194.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > Acked-by: Thierry Reding <treding@nvidia.com>
> 
> Hi Thierry,
> 
> can I pull this patch into the PCI tree ? Or if you want the series
> to go via another tree:
> 
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Hi,

I would like to ask please how you want this series to be handled.

Thanks,
Lorenzo
