Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85F33E2AE3
	for <lists+linux-pci@lfdr.de>; Fri,  6 Aug 2021 14:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343815AbhHFMuT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Aug 2021 08:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343812AbhHFMsk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Aug 2021 08:48:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A3D261181;
        Fri,  6 Aug 2021 12:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628254105;
        bh=b/bL5U8oRfw9K2rvpOxRukG6+MpqFpdlJFgnTeAUI7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k6zl6Pqf9LGixgcugEhcjqLxx3OxIgIGkP9ayZdpxvTI4TR9jVr0/AV00F4Sa2nwO
         Fxng7ETGRoegqD5poO1xaxdCE+5voY/S4ZFxIe5J3mTIszLatN1JgCXvsqmvSx42dp
         sLbE4JqDdx33okp8Zskrnqq7YTLGvPX4bnTV8xftXOPu/kARFMWGF1HFFMgiGwki50
         T87ou5IcNGHTNc11Fwos0WpDBZcGT22pw/oKX6G+JPvkK+Oee9a4cvnqevPfbNF9Q1
         PxTgg0db2rkjmgG20IernlJ9Qw1BjqnVvgm7FSu8UYg+4W9+A7NbgjNHLT2VyszKaf
         f/TQjM+6W5vlQ==
Date:   Fri, 6 Aug 2021 18:18:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Baruch Siach <baruch@tkos.co.il>, Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/6] arm64: IPQ6018 PCIe support
Message-ID: <YQ0vlNekc289LqJl@matsya>
References: <cover.1620203062.git.baruch@tkos.co.il>
 <87o8acxtqm.fsf@tarshish>
 <20210805094237.GA18330@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805094237.GA18330@lpieralisi>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 05-08-21, 10:42, Lorenzo Pieralisi wrote:
> On Thu, Aug 05, 2021 at 09:58:57AM +0300, Baruch Siach wrote:
> > Hi Lorenzo, Rob, Krzysztof,
> > 
> > On Wed, May 05 2021, Baruch Siach wrote:
> > > This series adds support for the single PCIe lane on IPQ6018 SoCs. The code is 
> > > ported from downstream Codeaurora v5.4 kernel. The main difference from 
> > > downstream code is the split of PCIe registers configuration from .init to 
> > > .post_init, since it requires phy_power_on().
> > >
> > > Tested on IPQ6010 based hardware.
> > 
> > It's been 3 months with no comment. Would you consider applying the dwc
> > part (patches #1 and #2) for the v5.15 merge window?
> > 
> > I tested the patches here successfully on top of v5.14-rc4.
> 
> You need an ACK from the respective drivers maintainers. We look into
> overall pci/controller drivers structure and common code, it is up
> to drivers maintainers to review and ACK your patches, I will certainly
> pick them up when that's done.

Also is there any dependency b/w various pieces, if not consider sending
patches to respective subsystems...

Too many patch series these days are adding cross subsystem stuff even
if there are no dependencies. Yes it all needs to come together to work
but that does not require a common series to be posted!

-- 
~Vinod
