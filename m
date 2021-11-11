Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B85744DD3E
	for <lists+linux-pci@lfdr.de>; Thu, 11 Nov 2021 22:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbhKKVr2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 16:47:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:52660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbhKKVr2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Nov 2021 16:47:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15346611C0;
        Thu, 11 Nov 2021 21:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636667078;
        bh=HeBg888XneREwYs2D1oL9Fbiy9/LIFLtfcsXmvNGOuk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gU1vapMExoIwcO5ulvWbL5DKTPzuDfIRCY9KOp3Lt3OE31Q+YjoxghQHD/zU3cb8s
         hAIkEP1E5h1ZM+CvdklkVPOZgQlb8i7V3xcdNL+MeROL0fpYMA4WEv1lGGuW8vd7aM
         QTXjxh1apUputbCJ/3aqb9qlcAwJtZYqgmsZ+juSyjC9IARIxF29IYKRqpb2hWelit
         wGGlN+CYTPaQvpzqZ8SZ67DeEY8qI2XJxv2me6MGAhvxXi6w+SuSewd+L4QPUHYDmQ
         ftNABpjuDiVDhPVN9tx2+R/24vMWKx0yYTFGdT0NO77gSBk5w7DCy00y4eO+VfTgc3
         kdO1r817abuDw==
Date:   Thu, 11 Nov 2021 15:44:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>, linux-pci@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>, gustavo.pimentel@synopsys.com,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>
Subject: Re: [PATCHv5 0/6] PCI: layerscape: Add power management support
Message-ID: <20211111214436.GA1352369@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADRPPNRL8m+YawUJJe0MNLhRQ4NJROv4DVzP+rWTGeS6fCbDnQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 11, 2021 at 03:21:37PM -0600, Li Yang wrote:
> On Wed, Apr 7, 2021 at 9:13 AM Zhiqiang Hou <Zhiqiang.Hou@nxp.com> wrote:
> >
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > This patch series is to add PCIe power management support for NXP
> > Layerscape platforms.
> >
> > Hou Zhiqiang (6):
> >   PCI: layerscape: Change to use the DWC common link-up check function
> >   dt-bindings: pci: layerscape-pci: Add a optional property big-endian
> >   arm64: dts: layerscape: Add big-endian property for PCIe nodes
> >   dt-bindings: pci: layerscape-pci: Update the description of SCFG
> >     property
> >   arm64: dts: ls1043a: Add SCFG phandle for PCIe nodes
> >   PCI: layerscape: Add power management support
> >
> >  .../bindings/pci/layerscape-pci.txt           |   6 +-
> >  .../arm64/boot/dts/freescale/fsl-ls1012a.dtsi |   1 +
> >  .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |   6 +
> >  .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   3 +
> >  drivers/pci/controller/dwc/pci-layerscape.c   | 450 ++++++++++++++----
> >  drivers/pci/controller/dwc/pcie-designware.h  |   1 +
> >  6 files changed, 370 insertions(+), 97 deletions(-)
> 
> Hi Bjorn,
> 
> I don't see any feedback on this version.  Is there any chance that
> the binding/driver changes can be picked up?

Probably slipped through the cracks.  We're in the middle of the v5.16
merge window right now.  After v5.16-rc1 is tagged (probably Nov 14),
rebase your series on top of that, incorporate Rob's reviewed-by, and
repost it.  Then Lorenzo will see it and take a look.

Bjorn
