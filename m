Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DA72B5EE7
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 13:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgKQMKT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 07:10:19 -0500
Received: from foss.arm.com ([217.140.110.172]:55144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgKQMKT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Nov 2020 07:10:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B11C101E;
        Tue, 17 Nov 2020 04:10:18 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF44E3F719;
        Tue, 17 Nov 2020 04:10:16 -0800 (PST)
Date:   Tue, 17 Nov 2020 12:10:11 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "robh@kernel.org" <robh@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
Subject: Re: [PATCH 0/3] Add support to handle prefetchable memoryg
Message-ID: <20201117121011.GA6050@e121166-lin.cambridge.arm.com>
References: <20201023195655.11242-1-vidyas@nvidia.com>
 <SLXP216MB04777D651A59246A60D036A8AA1B0@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
 <20201026123012.GA356750@ulmo>
 <53277a71-13e5-3e7e-7c51-aca367b99d31@nvidia.com>
 <92d5ead4-a3d2-42ba-a542-3e305f3d5523@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92d5ead4-a3d2-42ba-a542-3e305f3d5523@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 17, 2020 at 10:08:35AM +0530, Vidya Sagar wrote:
> Hi Lorenzo & Bjorn,
> Sorry to bother you.
> Could you please take a look at the patches-1 & 2 from this series?

IIUC we should:

(1) apply https://patchwork.kernel.org/project/linux-pci/patch/20201026181652.418729-1-robh@kernel.org
(2) apply [1,2] from this series

For (2), are they rebased against v5.10-rc3 with (1) applied ? I need to
check but I will probably have to use v5.10-rc3 as baseline owing to
commit:

9fff3256f93d

(1) depends on it.

Lorenzo

> Thanks,
> Vidya Sagar
> 
> On 11/4/2020 1:16 PM, Vidya Sagar wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > Lorenzo / Bjorn,
> > Could you please review patches-1 & 2 in this series?
> > For the third patch, we already went with Rob's patch @
> > http://patchwork.ozlabs.org/project/linux-pci/patch/20201026154852.221483-1-robh@kernel.org/
> > 
> > 
> > Thanks,
> > Vidya Sagar
> > 
> > On 10/26/2020 6:02 PM, Thierry Reding wrote:
> > > On Sat, Oct 24, 2020 at 04:03:41AM +0000, Jingoo Han wrote:
> > > > On 10/23/20, 3:57 PM, Vidya Sagar wrote:
> > > > > 
> > > > > This patch series adds support for configuring the DesignWare IP's ATU
> > > > > region for prefetchable memory translations.
> > > > > It first starts by flagging a warning if the size of non-prefetchable
> > > > > aperture goes beyond 32-bit as PCIe spec doesn't allow it.
> > > > > And then adds required support for programming the ATU to handle higher
> > > > > (i.e. >4GB) sizes and then finally adds support for differentiating
> > > > > between prefetchable and non-prefetchable regions and
> > > > > configuring one of
> > > > > the ATU regions for prefetchable memory translations purpose.
> > > > > 
> > > > > Vidya Sagar (3):
> > > > >    PCI: of: Warn if non-prefetchable memory aperture size is > 32-bit
> > > > >    PCI: dwc: Add support to program ATU for >4GB memory aperture sizes
> > > > >    PCI: dwc: Add support to handle prefetchable memory mapping
> > > > 
> > > > For 2nd & 3rd,
> > > > Acked-by: Jingoo <jingoohan1@gmail.com>
> > > > But, I still want someone to ack 1st patch, not me.
> > > > 
> > > > To Vidya,
> > > > If possible, can you ask your coworker to give 'Tested-by'? It
> > > > will be very helpful.
> > > > Thank you.
> > > 
> > > On next-20201026 (but also going back quite a while) I'm seeing this
> > > during boot on Jetson AGX Xavier (Tegra194):
> > > 
> > > [    3.493382] ahci 0001:01:00.0: version 3.0
> > > [    3.493889] ahci 0001:01:00.0: SSS flag set, parallel bus scan
> > > disabled
> > > [    4.497706] ahci 0001:01:00.0: controller reset failed (0xffffffff)
> > > [    4.498114] ahci: probe of 0001:01:00.0 failed with error -5
> > > 
> > > After applying this series, AHCI over PCI is back to normal:
> > > 
> > > [    3.543230] ahci 0001:01:00.0: AHCI 0001.0000 32 slots 1 ports 6
> > > Gbps 0x1 impl SATA mode
> > > [    3.550841] ahci 0001:01:00.0: flags: 64bit ncq sntf led only pmp
> > > fbs pio slum part sxs
> > > [    3.559747] scsi host0: ahci
> > > [    3.561998] ata1: SATA max UDMA/133 abar m512@0x1230010000 port
> > > 0x1230010100 irq 63
> > > 
> > > So for the series:
> > > 
> > > Tested-by: Thierry Reding <treding@nvidia.com>
> > > 
