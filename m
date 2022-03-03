Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C01F4CC447
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 18:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiCCRtS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 12:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbiCCRtR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 12:49:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F39A5643C
        for <linux-pci@vger.kernel.org>; Thu,  3 Mar 2022 09:48:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4EFCB82506
        for <linux-pci@vger.kernel.org>; Thu,  3 Mar 2022 17:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3959EC004E1;
        Thu,  3 Mar 2022 17:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646329708;
        bh=i2VoLtDi+zvtNXtQqYZKxc5NfRFIEKh6hYssNBU92gw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oe4RInrI0aCyPUASWkmvOH0cniycmaA3HI1uaqeBoYTMIdiLN06rqZ/nybbTXQspz
         qx4Q12etD0xLgF/qd45DHeSbBQSCN5kidr+dN/Z95iP73joWBjl9t5SvZWUrP3AryJ
         iI0ex1gavv49t3E7fs6DSk7jmbXb6PdFBq+BcPr9xqho+j47t11qEj4dndLBUfD38Y
         mlZO+E/sXhWDAtYbz009SUfQrZKfKRDWWTNVuxCZyTqoOkSKuzOSq90RTmoMtFx7dc
         lOzKuPNDPNFrJdG2oHUd2bXTikuCsyaFLad3FskuDyDvFpR1jueYQxnBZ1znNmX4P1
         Jhy18oee9NWEg==
Date:   Thu, 3 Mar 2022 11:48:26 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhi Li <lznuaa@gmail.com>
Cc:     Frank Li <Frank.Li@nxp.com>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH 4/5] PCI: imx6: add PCIe embedded DMA support
Message-ID: <20220303174826.GA815663@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHrpEqSBLMU-RO8moqvSQUcP62N7xqpNyHfH1UERB_qAByK+2Q@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 02, 2022 at 03:28:48PM -0600, Zhi Li wrote:
> On Wed, Mar 2, 2022 at 3:21 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Mar 02, 2022 at 02:49:45PM -0600, Zhi Li wrote:
> > > On Wed, Mar 2, 2022 at 2:15 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Tue, Mar 01, 2022 at 09:26:45PM -0600, Frank Li wrote:
> > > > > ...

> > > > > The DMA can transfer data to any remote address location
> > > > > regardless PCI address space size.
> > > >
> > > > What is this sentence telling us?  Is it merely that the DMA "inbound
> > > > address space" may be larger than the MMIO "outbound address space"?
> > > > I think there's no necessary connection between them, and there's no
> > > > need to call it out as though it's something special.
> > >
> > > There are outbound address windows. such as 256M, but RC sides have more
> > > than 256M ddr memory, such as 16GB. If CPU or external DMA controller,
> > > only can access 256M
> > > address space.
> > >
> > > But if using an embedded DMA controller,  it can access the whole RC's
> > > 16G address without
> > > changing iAtu mapping.
> > >
> > > I want to say why I need enable embedded DMA for EP.
> >
> > OK, so if IIUC, the DMA controller is embedded in the imx6 host bridge
> > (of course; that's obvious from what you're doing here).  And unlike
> > DMA from devices *below* the host bridge, DMAs from the embedded
> > controller don't go through the iATU, so they are not subject to any
> > of the iATU limitations.  Right?
> 
> Yes!

I guess that means the DMA controller is functionally and logically
sort of a separate device from the PCI host bridge?  Sounds like the
DMA controller doesn't receive or generate PCI transactions?

Bjorn
