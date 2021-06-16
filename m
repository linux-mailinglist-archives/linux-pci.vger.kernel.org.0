Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD80C3AA606
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 23:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbhFPVSo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 17:18:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233836AbhFPVSn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jun 2021 17:18:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEB65613DF;
        Wed, 16 Jun 2021 21:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623878197;
        bh=g0jleB/kEeeiGGDNq1Chp/dzNVZGcHFtnZ8EpEOi+lg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LhfE3ydVx732Lk8ZAGuNehW4CtJ7CP+EGLJaXRG5cqlco3TT1Gxm25PByaM8S2Vlj
         JHemkB/lt6CQ3kew15b0BZ18wY/qYbY3Jeheb+nsx6k1Vwn00wrS5/yP67dcDGdeMi
         61KBaUNQ2/xrB4xa9TT1Jb4iRgmjyqxVHebUXgRnPz58nZVCt/c7C8Sis0EC7f/BeZ
         o1AbmvKAmk3rEp4zs2aVS5lO3zjYB+fOOdhCED/AFQVBvz282hhrsMk7WIhRKKnflV
         HTsyLyPOAD9md50qvx8h9WQ2W+/ARkK4dMZ5pWU53893wMqEW0mFTKEz40V+6FzNvk
         5/bHuiY3CTipA==
Date:   Wed, 16 Jun 2021 16:16:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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
Message-ID: <20210616211630.GA3007203@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5bcf443-a0ee-fda5-5c5c-d69d25b53bb9@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 16, 2021 at 07:35:33PM +0530, Kishon Vijay Abraham I wrote:
> Hi Lorenzo, Bjorn,
> 
> On 17/05/21 1:17 pm, Kishon Vijay Abraham I wrote:
> > Patch series
> > *) Adds support to add virtual functions to enable endpoint controller
> >    which supports SR-IOV capability
> > *) Add support in Cadence endpoint driver to configure virtual functions
> > *) Enable pci_endpoint_test driver to create pci_device for virtual
> >    functions
> > 
> > v1 of the patch series can be found at [1]
> > v2 of the patch series can be found at [2]
> > v3 of the patch series can be found at [3]
> > v4 of the patch series can be found at [4]
> > v5 of the patch series can be found at [5]
> > 
> > Here both physical functions and virtual functions use the same
> > pci_endpoint_test driver and existing pcitest utility can be used
> > to test virtual functions as well.
> > 
> > Changes from v5:
> > *) Rebased to 5.13-rc1
> > 
> > Changes from v4:
> > *) Added a fix in Cadence driver which was overwriting BAR configuration
> >    of physical function.
> > *) Didn't include Tom's Acked-by since Cadence driver is modified in
> >    this revision.
> > 
> > Changes from v3:
> > *) Fixed Rob's comment and added his Reviewed-by as suggested by him.
> > 
> > Changes from v2:
> > *) Fixed DT binding documentation comment by Rob
> > *) Fixed the error check in pci-epc-core.c
> > 
> > Changes from v1:
> > *) Re-based and Re-worked to latest kernel 5.10.0-rc2+ (now has generic
> >    binding for EP)
> > 
> > [1] -> http://lore.kernel.org/r/20191231113534.30405-1-kishon@ti.com
> > [2] -> http://lore.kernel.org/r/20201112175358.2653-1-kishon@ti.com
> > [3] -> https://lore.kernel.org/r/20210305050410.9201-1-kishon@ti.com
> > [4] -> http://lore.kernel.org/r/20210310160943.7606-1-kishon@ti.com
> > [5] -> https://lore.kernel.org/r/20210419083401.31628-1-kishon@ti.com
> 
> Can this series be merged for 5.14? It already includes Ack from Rob for
> dt-binding changes and Ack from Tom for Cadence driver changes.

Sorry, I think this was assigned to me in patchwork, but Lorenzo
usually takes care of the endpoint stuff.  He's away this week, but no
doubt will look at it when he returns.

Bjorn
