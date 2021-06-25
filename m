Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F873B4745
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 18:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhFYQR5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 12:17:57 -0400
Received: from foss.arm.com ([217.140.110.172]:59834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhFYQR5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Jun 2021 12:17:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE74D1063;
        Fri, 25 Jun 2021 09:15:35 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FEFA3F719;
        Fri, 25 Jun 2021 09:15:33 -0700 (PDT)
Date:   Fri, 25 Jun 2021 17:15:28 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v6 0/7] Add SR-IOV support in PCIe Endpoint Core
Message-ID: <20210625161528.GA21595@lpieralisi>
References: <20210616211630.GA3007203@bjorn-Precision-5520>
 <0fd19e28-e0a6-fd79-672a-b588fb2763ba@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fd19e28-e0a6-fd79-672a-b588fb2763ba@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 24, 2021 at 08:30:09PM +0530, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> On 17/06/21 2:46 am, Bjorn Helgaas wrote:
> > On Wed, Jun 16, 2021 at 07:35:33PM +0530, Kishon Vijay Abraham I wrote:
> >> Hi Lorenzo, Bjorn,
> >>
> >> On 17/05/21 1:17 pm, Kishon Vijay Abraham I wrote:
> >>> Patch series
> >>> *) Adds support to add virtual functions to enable endpoint controller
> >>>    which supports SR-IOV capability
> >>> *) Add support in Cadence endpoint driver to configure virtual functions
> >>> *) Enable pci_endpoint_test driver to create pci_device for virtual
> >>>    functions
> >>>
> >>> v1 of the patch series can be found at [1]
> >>> v2 of the patch series can be found at [2]
> >>> v3 of the patch series can be found at [3]
> >>> v4 of the patch series can be found at [4]
> >>> v5 of the patch series can be found at [5]
> >>>
> >>> Here both physical functions and virtual functions use the same
> >>> pci_endpoint_test driver and existing pcitest utility can be used
> >>> to test virtual functions as well.
> >>>
> >>> Changes from v5:
> >>> *) Rebased to 5.13-rc1
> >>>
> >>> Changes from v4:
> >>> *) Added a fix in Cadence driver which was overwriting BAR configuration
> >>>    of physical function.
> >>> *) Didn't include Tom's Acked-by since Cadence driver is modified in
> >>>    this revision.
> >>>
> >>> Changes from v3:
> >>> *) Fixed Rob's comment and added his Reviewed-by as suggested by him.
> >>>
> >>> Changes from v2:
> >>> *) Fixed DT binding documentation comment by Rob
> >>> *) Fixed the error check in pci-epc-core.c
> >>>
> >>> Changes from v1:
> >>> *) Re-based and Re-worked to latest kernel 5.10.0-rc2+ (now has generic
> >>>    binding for EP)
> >>>
> >>> [1] -> http://lore.kernel.org/r/20191231113534.30405-1-kishon@ti.com
> >>> [2] -> http://lore.kernel.org/r/20201112175358.2653-1-kishon@ti.com
> >>> [3] -> https://lore.kernel.org/r/20210305050410.9201-1-kishon@ti.com
> >>> [4] -> http://lore.kernel.org/r/20210310160943.7606-1-kishon@ti.com
> >>> [5] -> https://lore.kernel.org/r/20210419083401.31628-1-kishon@ti.com
> >>
> >> Can this series be merged for 5.14? It already includes Ack from Rob for
> >> dt-binding changes and Ack from Tom for Cadence driver changes.
> > 
> > Sorry, I think this was assigned to me in patchwork, but Lorenzo
> > usually takes care of the endpoint stuff.  He's away this week, but no
> > doubt will look at it when he returns.
> 
> Can you consider merging this series for 5.14?

I am running late this cycle on reviews and the merge window is about
to open, I will review it and queue it first thing for the next cycle.

Apologies.

Lorenzo
