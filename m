Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E0942C0D7
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 15:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhJMNCH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 09:02:07 -0400
Received: from foss.arm.com ([217.140.110.172]:38748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233368AbhJMNCH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Oct 2021 09:02:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F1451FB;
        Wed, 13 Oct 2021 06:00:03 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 753CE3F66F;
        Wed, 13 Oct 2021 06:00:01 -0700 (PDT)
Date:   Wed, 13 Oct 2021 13:59:56 +0100
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
Message-ID: <20211013125956.GA11036@lpieralisi>
References: <20210915085517.1669675-1-mperttunen@nvidia.com>
 <20210915085517.1669675-5-mperttunen@nvidia.com>
 <YV86l4OhqKN0AkMN@orome.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV86l4OhqKN0AkMN@orome.fritz.box>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 07, 2021 at 08:21:11PM +0200, Thierry Reding wrote:
> On Wed, Sep 15, 2021 at 11:55:17AM +0300, Mikko Perttunen wrote:
> > The return value from tegra_bpmp_transfer indicates the success or
> > failure of the IPC transaction with BPMP. If the transaction
> > succeeded, we also need to check the actual command's result code.
> > Add code to do this.
> > 
> > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-tegra194.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> Acked-by: Thierry Reding <treding@nvidia.com>

Hi Thierry,

can I pull this patch into the PCI tree ? Or if you want the series
to go via another tree:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
