Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E046480C7
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 11:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiLIKRz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 05:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLIKRy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 05:17:54 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5357B2AE35;
        Fri,  9 Dec 2022 02:17:46 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 7B1D1E0EE7;
        Fri,  9 Dec 2022 13:17:44 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-type:content-type:date
        :from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=post; bh=Ec3ViA1L+1+zRfJZ8e1q
        eQl0OyxR+BM/2+3K7g2BZ9I=; b=R05EYE98HzQ0MxHVk6hVIH3+DWnkwj2TU15o
        xM5JYoXYcFUipO5pL1Tuuu6LTKPYRcIq9fjgzXUOxqajVeC484NeGt8fdrup9/Wm
        5t9YJEO2ewtD4StEPy6kx11pH2SY5PEAse137DbDyJmdGBlDU4aOsoxwkj+aZH0/
        2aJCQJo=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 5D9B6E0ED4;
        Fri,  9 Dec 2022 13:17:44 +0300 (MSK)
Received: from mobilestation (10.8.30.6) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 9 Dec 2022 13:17:44 +0300
Date:   Fri, 9 Dec 2022 13:17:43 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <vidyas@nvidia.com>,
        <mmaddireddy@nvidia.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: PCI: tegra234: Add ECAM support
Message-ID: <20221209101743.uzyw5ejubkbfm5di@mobilestation>
References: <20221114155333.234496-1-jonathanh@nvidia.com>
 <20221114155333.234496-2-jonathanh@nvidia.com>
 <Y3ap1o2SbNvFw8Vd@orome>
 <CAL_JsqKpyn=mWXv4tuS4U8AahNPkL6hpNQCfyRdf9bDY1EqSJg@mail.gmail.com>
 <Y49xg7wptRweHd4I@orome>
 <CAL_JsqK+BxHB8__aN=84R4xpoJtf4_7xHeTkbgPakdNqzywJWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAL_JsqK+BxHB8__aN=84R4xpoJtf4_7xHeTkbgPakdNqzywJWw@mail.gmail.com>
X-Originating-IP: [10.8.30.6]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 06, 2022 at 03:14:58PM -0600, Rob Herring wrote:
> On Tue, Dec 6, 2022 at 10:44 AM Thierry Reding <thierry.reding@gmail.com> wrote:
> >
> > On Mon, Dec 05, 2022 at 05:41:55PM -0600, Rob Herring wrote:
> > > On Thu, Nov 17, 2022 at 3:38 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> > > >
> > > > On Mon, Nov 14, 2022 at 03:53:32PM +0000, Jon Hunter wrote:
> > > > > From: Vidya Sagar <vidyas@nvidia.com>
> > > > >
> > > > > Add support for ECAM aperture that is only supported for Tegra234
> > > > > devices.
> > > > >
> > > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > > Co-developed-by: Jon Hunter <jonathanh@nvidia.com>
> > > > > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> > > > > ---
> > > > > Changes since V2:
> > > > > - Avoid duplication of reg items and reg-names
> > > > > Changes since V1:
> > > > > - Restricted the ECAM aperture to only Tegra234 devices that support it.
> > > > >
> > > > >  .../bindings/pci/nvidia,tegra194-pcie.yaml    | 34 +++++++++++++++++--
> > > > >  .../devicetree/bindings/pci/snps,dw-pcie.yaml |  2 +-
> > > > >  2 files changed, 33 insertions(+), 3 deletions(-)
> > > >
> > > > Both patches applied now.
> > >
> > > linux-next now fails with this. I suspect it is due to Sergey's
> > > changes to the DWC schema.
> > >
> > > /builds/robherring/linux-dt/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.example.dtb:
> > > pcie@14160000: reg-names:4: 'oneOf' conditional failed, one must be
> > > fixed:
> > >         'dbi' was expected
> > >         'dbi2' was expected
> > >         'ecam' is not one of ['elbi', 'app']
> > >         'atu' was expected
> > >         'dma' was expected
> > >         'phy' was expected
> > >         'config' was expected
> > >         /builds/robherring/linux-dt/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.example.dtb:
> > > pcie@14160000: reg-names:4: 'oneOf' conditional failed, one must be
> > > fixed:
> > >                 'ecam' is not one of ['apb', 'mgmt', 'link', 'ulreg', 'appl']
> > >                 'ecam' is not one of ['atu_dma']
> > >                 'ecam' is not one of ['smu', 'mpu']
> > >         From schema:
> > > /builds/robherring/linux-dt/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
> >
> > Stephen reported the other day that he wasn't able to resolve this
> > conflict in linux-next, so he dropped the ECAM bits. The ECAM patch has
> > now propagated to ARM SoC so it can't be easily backed out, but I guess
> > we could revert on that tree and instead apply the patch to the DT tree
> > and resolve the conflict there.
> >
> > I guess the better alternative would be to try and resolve the merge
> > properly and let Stephen (and Linus) know.
> 

> Instead, can you prepare a patch on top of Sergey's adding a 'oneOf'
> entry with 'ecam'. As this is a new thing, it should have its own
> entry. Then when merging, we just throw out the change from your side.

Right, the only change that is required here is to extend the
reg-names oneOf list of the DT-bindings:
< Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
with the 'ecam' entry. If it's a vendor-specific part then add to the
last the last entry defines the vendor-specific duplicates of the generic CSR
spaces.

On the other hand I don't really see a reason in adding the ECAM CSRs
space to the generic DW PCIe device since basically the ECAM memory is
just a pre-configured outbound iATU window. So if it's a ECAM-based
device then it should have been already configured by the system
bootloader upon the kernel boot up. Thus there is no point in having
the generic DW PCIe resources and it should be just a generic
ECAM-based device with a single ECAM CSR space as the
"snps,dw-pcie-ecam"/"pci-host-ecam-generic" DT-bindings require
especially seeing the Nvidia low-level driver doesn't use the ECAM
registers at all. Moreover the DW PCIe core driver doesn't
differentiate between the already configured iATU windows and the one
available for the ranges-based mapping. Instead the DW PCIe core just
disables all the detected in- and outbound iATUs by means of the
dw_pcie_iatu_setup() method. So the pre-configured ECAM space will be
reset by the driver core anyway.

What I would suggest here is to split up the devices:
1. If it's a ECAM-based device, then it should be identified as
"snps,dw-pcie-ecam"/"pci-host-ecam-generic", then it will have a
single ECAM CSR space with no need in other resources.
2. If it's a DW PCIe device with Nvidia Tegra194-specific settings,
then it should be identified as "nvidia,tegra194-pcie" with no ECAM
registers.

Thus we wouldn't need to have any modifications applied to the
bindings and to the DT-files. What do you think?

-Serge(y)

> 
> I'd really prefer that bindings don't go thru the soc tree unless
> there's some strong reason. The default is to go via the subsystem
> trees. Beyond 'we are running the dtschema checks on all our dts files
> and can't have the warnings', I don't know what that would be. I wish
> everyone was doing that, but I'm pretty sure most are not.
> 
> Rob
> 

