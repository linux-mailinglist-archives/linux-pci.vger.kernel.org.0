Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11C027AAF1
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 11:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgI1JjP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 05:39:15 -0400
Received: from foss.arm.com ([217.140.110.172]:48302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbgI1JjP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Sep 2020 05:39:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1AE01063;
        Mon, 28 Sep 2020 02:39:14 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C703F3F73B;
        Mon, 28 Sep 2020 02:39:13 -0700 (PDT)
Date:   Mon, 28 Sep 2020 10:39:11 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Michael Walle <michael@walle.cc>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of
 dw_child_pcie_ops
Message-ID: <20200928093911.GB12010@e121166-lin.cambridge.arm.com>
References: <20200916054130.8685-1-Zhiqiang.Hou@nxp.com>
 <CAL_JsqJwgNUpWFTq2YWowDUigndSOB4rUcVm0a_U=FEpEmk94Q@mail.gmail.com>
 <HE1PR0402MB3371F8191538F47E8249F048843F0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <CAL_JsqLdQY_DqpduaTv4hMDM_-cvZ_+s8W+HdOuZVVYjTO4yxw@mail.gmail.com>
 <HE1PR0402MB337180458625B05D1529535384390@HE1PR0402MB3371.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HE1PR0402MB337180458625B05D1529535384390@HE1PR0402MB3371.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 24, 2020 at 04:24:47AM +0000, Z.q. Hou wrote:
> Hi Rob,
> 
> Thanks a lot for your comments!
> 
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: 2020年9月18日 23:28
> > To: Z.q. Hou <zhiqiang.hou@nxp.com>
> > Cc: linux-kernel@vger.kernel.org; PCI <linux-pci@vger.kernel.org>; Lorenzo
> > Pieralisi <lorenzo.pieralisi@arm.com>; Bjorn Helgaas
> > <bhelgaas@google.com>; Gustavo Pimentel
> > <gustavo.pimentel@synopsys.com>; Michael Walle <michael@walle.cc>;
> > Ard Biesheuvel <ardb@kernel.org>
> > Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of
> > dw_child_pcie_ops
> > 
> > On Fri, Sep 18, 2020 at 5:02 AM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
> > >
> > > Hi Rob,
> > >
> > > Thanks a lot for your comments!
> > >
> > > > -----Original Message-----
> > > > From: Rob Herring <robh@kernel.org>
> > > > Sent: 2020年9月17日 4:29
> > > > To: Z.q. Hou <zhiqiang.hou@nxp.com>
> > > > Cc: linux-kernel@vger.kernel.org; PCI <linux-pci@vger.kernel.org>;
> > > > Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Bjorn Helgaas
> > > > <bhelgaas@google.com>; Gustavo Pimentel
> > > > <gustavo.pimentel@synopsys.com>; Michael Walle
> > <michael@walle.cc>;
> > > > Ard Biesheuvel <ardb@kernel.org>
> > > > Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of
> > > > dw_child_pcie_ops
> > > >
> > > > On Tue, Sep 15, 2020 at 11:49 PM Zhiqiang Hou
> > <Zhiqiang.Hou@nxp.com>
> > > > wrote:
> > > > >
> > > > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > > >
> > > > > On NXP Layerscape platforms, it results in SError in the
> > > > > enumeration of the PCIe controller, which is not connecting with
> > > > > an Endpoint device. And it doesn't make sense to enumerate the
> > > > > Endpoints when the PCIe link is down. So this patch added the link
> > > > > up check to avoid to fire configuration transactions on link down bus.
> > > >
> > > > Michael reported the same issue as well.
> > > >
> > > > What happens if the link goes down between the check and the access?
> > >
> > > This patch cannot cover this case, and will get the SError.
> > > But I think it makes sense to avoid firing transactions on link down bus.
> > 
> > That's impossible to do without a race even in h/w.
> 
> Agree.
> 
> > 
> > > > It's a racy check. I'd like to find an alternative solution. It's
> > > > even worse if Layerscape is used in ECAM mode. I looked at the EDK2
> > > > setup for layerscape[1] and it looks like root ports are just skipped if link
> > is down.
> > > > Maybe a link down just never happens once up, but if so, then we
> > > > only need to check it once and fail probe.
> > >
> > > Many customers connect the FPGA Endpoint, which may establish PCIe
> > > link after the PCIe enumeration and then rescan the PCIe bus, so I
> > > think it should not exit the probe of root port even if there is not link up
> > during enumeration.
> > 
> > That's a good reason. I want to unify the behavior here as it varies per
> > platform currently and wasn't sure which way to go.
> > 
> > 
> > > > I've dug into this a bit more and am curious about the PCIE_ABSERR
> > > > register setting which is set to:
> > > >
> > > > #define PCIE_ABSERR_SETTING 0x9401 /* Forward error of non-posted
> > > > request */
> > > >
> > > > It seems to me this is not what we want at least for config
> > > > accesses, but commit 84d897d6993 where this was added seems to say
> > > > otherwise. Is it not possible to configure the response per access type?
> > >
> > > Thanks a lot for your investigation!
> > > The story is like this: Some customers worry about these silent error
> > > (DWC PCIe IP won't forward the error of outbound non-post request by
> > > default), so we were pushed to enable the error forwarding to AXI in
> > > the commit
> > > 84d897d6993 as you saw. But it cannot differentiate the config
> > > transactions from the MEM_rd, except the Vendor ID access, which is
> > > controlled by a separate bit and it was set to not forward error of access
> > of Vendor ID.
> > > So we think it's okay to enable the error forwarding, the SError
> > > should not occur, because after the enumeration it won't access the
> > non-existent functions.
> > 
> > We've rejected upstream support for platforms aborting on config
> > accesses[1]. I think there's clear consensus that aborting is the wrong
> > behavior.
> > 
> > Do MEM_wr errors get forwarded? Seems like that would be enough. Also,
> > wouldn't page faults catch most OOB accesses anyways? You need things
> > page aligned anyways with an IOMMU and doing userspace access or guest
> > assignment.
> 
> Yes, errors of MEM_wr can be forwarded.
> 
> > 
> > Here's another idea, how about only enabling forwarding errors if the link is
> > up? If really would need to be configured any time the link state changes
> > rather than just at probe. I'm not sure if you have a way to disable it on link
> > down though.
> 
> Dug deeper into this issue and found the setting of not forwarding
> error of non-existent Vender ID access counts on the link partner: 1.
> When there is a link partner (namely link up), it will return 0xffff
> when read non-existent function Vendor ID and won't forward error to
> AXI.  2. When no link partner (link down), it will forward the error
> of reading non-existent function Vendor ID to AXI and result in
> SError.
> 
> I think this is a DWC PCIe IP specific issue but not get feedback from
> design team.  I'm thinking to disable this error forwarding just like
> other platforms, since when these errors (UR, CA and CT) are detected,
> AER driver can also report the error and try to recover.

I take this as you shall send a patch to fix this issue shortly,
is this correct ?

Thanks,
Lorenzo
