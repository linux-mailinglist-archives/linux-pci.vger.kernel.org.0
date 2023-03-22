Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4866C58AD
	for <lists+linux-pci@lfdr.de>; Wed, 22 Mar 2023 22:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjCVVTj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Mar 2023 17:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCVVTi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Mar 2023 17:19:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4054F222FB;
        Wed, 22 Mar 2023 14:19:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B13B62199;
        Wed, 22 Mar 2023 21:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B40C433D2;
        Wed, 22 Mar 2023 21:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679519971;
        bh=5Lr4+LiAe/vyJjSpCgbGrH8T22xmcBxh9ZpVbFE0NpY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RVMGpnosVaaSykQcODe1kChh1yrK8nue3a8krWRC30QZUjZY71F+ENcZPHEVuZnmq
         lN9loILAp+HBq+s6F1+XfMVbJ09nZFa977xbfUisFB+BysYblpPWft48j1H0mUGqw/
         fU4WxhzWOk2HoxCwD5zHi1PdhoKzKehY704Va0T56vbzJUZU36sXoY6L7Ieqxlvh+C
         MB67XSbpm4k6pOu6nh6JgaMDfwDCWZMejl0L5/mAnHE2i3emSCW/+kLSKadOn1pCYn
         htkhsd4pj3qa7G5Z0Y/3bSp+HaKcUcPhEvCALwbsh3tUJ1YFgRY+Ex0AxV8A5wv/4l
         H2O/U1XCwVd/A==
Date:   Wed, 22 Mar 2023 16:19:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Li <frank.li@nxp.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        Leo Li <leoyang.li@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "M.H. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Roy Zang <roy.zang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>
Subject: Re: [EXT] Re: [PATCH v2 1/1] PCI: layerscape: Add power management
 support
Message-ID: <20230322211929.GA2493702@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB4838BC2054AA11A2C29189F788819@AM6PR04MB4838.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 21, 2023 at 09:39:44PM +0000, Frank Li wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Tuesday, March 21, 2023 3:59 PM
> > To: Frank Li <frank.li@nxp.com>
> > Cc: bhelgaas@google.com; Leo Li <leoyang.li@nxp.com>; dl-linux-imx <linux-
> > imx@nxp.com>; devicetree@vger.kernel.org;
> > gustavo.pimentel@synopsys.com; kw@linux.com; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> > pci@vger.kernel.org; lorenzo.pieralisi@arm.com; M.H. Lian
> > <minghuan.lian@nxp.com>; Mingkai Hu <mingkai.hu@nxp.com>;
> > robh+dt@kernel.org; Roy Zang <roy.zang@nxp.com>;
> > shawnguo@kernel.org; Z.Q. Hou <zhiqiang.hou@nxp.com>
> > Subject: [EXT] Re: [PATCH v2 1/1] PCI: layerscape: Add power management
> > support
> > 
> > Caution: EXT Email
> > 
> > On Tue, Mar 21, 2023 at 12:02:20PM -0400, Frank Li wrote:
> > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > >
> > > Add PME_Turn_Off/PME_TO_Ack handshake sequence to PCIe devices,
> > such as
> > > NVME or wifi module, and finally put the PCIe controller into D3 state
> > > after the L2/L3 ready state transition process completion.
> > >
> > > However, it's important to note that not all devices may be able to
> > > tolerate the PME_Turn_Off command. In general, fixed PCIe devices
> > > connected to Layerscape, such as NXP wifi devices, are able to handle
> > > this command.
> > 
> > I know this paragraph is here because I asked whether all PCIe devices
> > could tolerate PME_Turn_Off.  I don't know much about that level of
> > the protocol, but it does look to me like PME_Turn_Off is required,
> > e.g., PCIe r6.0, sec 5.3.3.2.1, 5.3.3.4.
> > 
> > So I'm not sure this paragraph adds anything useful.  If the spec
> > requires it, this paragraph is like saying "it's important to note
> > that some PCIe devices may not follow the spec," which is pointless.
> > 
> > This functionality results in any downstream devices being put in
> > D3cold, right?  I think that *would* be worth mentioning.  There are a
> > few cases where we try to avoid putting devices in D3cold, e.g.,
> > no_d3cold, and I suspect this functionality would put them in D3cold
> > regardless of no_d3cold.  Those are corner cases that you would
> > probably never see on your platform, so a brief mention here is
> > probably enough.
> > 
> > > +static void ls_pcie_set_dstate(struct ls_pcie *pcie, u32 dstate)
> > > +{
> > > +     struct dw_pcie *pci = pcie->pci;
> > > +     u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_PM);
> > > +     u32 val;
> > > +
> > > +     val = dw_pcie_readw_dbi(pci, offset + PCI_PM_CTRL);
> > > +     val &= ~PCI_PM_CTRL_STATE_MASK;
> > > +     val |= dstate;
> > > +     dw_pcie_writew_dbi(pci, offset + PCI_PM_CTRL, val);
> > 
> > Is this a power management register for the *Root Port*, i.e., as
> > defined by PCIe r6.0 sec 7.5.2?
> > 
> > Or is it a similar register for the *Root Complex* as a whole that is
> > defined by a Layerscape or DesignWare spec and coincidentally uses the
> > same Capability ID and control register layout as the PCIe one?
> 
> I think it is root port. Does linux framework can do that for it
> automatically?  Or need call pci_set_power_state here instead of
> write register directly?

Well, maybe, the linux framework might already put Root Ports in D3 if
the right conditions are satisfied.  I don't understand all of them,
but you can start at pci_dev_check_d3cold() and look at its users and
instrument things to see what actually happens.

But it might be a problem if that has to be synchronized and done in
the right order with respect to the RC things you do here, because I
don't think there's a hook for the PCI core to call your driver to do
the RC stuff.

Bjorn
