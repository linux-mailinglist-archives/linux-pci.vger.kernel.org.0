Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB1F8B49D
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 11:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfHMJvr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Aug 2019 05:51:47 -0400
Received: from foss.arm.com ([217.140.110.172]:32866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728466AbfHMJvq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Aug 2019 05:51:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AC3A337;
        Tue, 13 Aug 2019 02:51:46 -0700 (PDT)
Received: from red-moon (red-moon.cambridge.arm.com [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 026FC3F706;
        Tue, 13 Aug 2019 02:51:43 -0700 (PDT)
Date:   Tue, 13 Aug 2019 10:51:51 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "tpiepho@impinj.com" <tpiepho@impinj.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "yue.wang@amlogic.com" <yue.wang@amlogic.com>,
        "hayashi.kunihiko@socionext.com" <hayashi.kunihiko@socionext.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "jonnyc@amazon.com" <jonnyc@amazon.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCHv5 1/2] PCI: layerscape: Add the bar_fixed_64bit
 property in EP driver.
Message-ID: <20190813095151.GA10070@red-moon>
References: <20190813062840.2733-1-xiaowei.bao@nxp.com>
 <61e6df1c-a0dc-8f05-f74a-85a3cac9823f@ti.com>
 <AM5PR04MB32993CC1344DD660A298C7E1F5D20@AM5PR04MB3299.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM5PR04MB32993CC1344DD660A298C7E1F5D20@AM5PR04MB3299.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

You should fix your email client set-up to avoid sticking an [EXT]
tag to your emails $SUBJECT.

On Tue, Aug 13, 2019 at 07:39:48AM +0000, Xiaowei Bao wrote:
> 
> 
> > -----Original Message-----
> > From: Kishon Vijay Abraham I <kishon@ti.com>
> > Sent: 2019年8月13日 15:30
> > To: Xiaowei Bao <xiaowei.bao@nxp.com>; lorenzo.pieralisi@arm.com;
> > bhelgaas@google.com; M.h. Lian <minghuan.lian@nxp.com>; Mingkai Hu
> > <mingkai.hu@nxp.com>; Roy Zang <roy.zang@nxp.com>;
> > l.stach@pengutronix.de; tpiepho@impinj.com; Leonard Crestez
> > <leonard.crestez@nxp.com>; andrew.smirnov@gmail.com;
> > yue.wang@amlogic.com; hayashi.kunihiko@socionext.com;
> > dwmw@amazon.co.uk; jonnyc@amazon.com; linux-pci@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > linux-arm-kernel@lists.infradead.org
> > Subject: [EXT] Re: [PATCHv5 1/2] PCI: layerscape: Add the bar_fixed_64bit
> > property in EP driver.
> > 
> > Caution: EXT Email

See above, this "Caution" stuff should disappear.

Also, quoting the email header is useless, please configure your email
client to remove it.

Thanks,
Lorenzo

> > On 13/08/19 11:58 AM, Xiaowei Bao wrote:
> > > The PCIe controller of layerscape just have 4 BARs, BAR0 and BAR1 is
> > > 32bit, BAR2 and BAR4 is 64bit, this is determined by hardware, so set
> > > the bar_fixed_64bit with 0x14.
> > >
> > > Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> > 
> > Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> > > ---
> > > v2:
> > >  - Replace value 0x14 with a macro.
> > > v3:
> > >  - No change.
> > > v4:
> > >  - send the patch again with '--to'.
> > > v5:
> > >  - fix the commit message.
> > >
> > >  drivers/pci/controller/dwc/pci-layerscape-ep.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > > b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > > index be61d96..ca9aa45 100644
> > > --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > > +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > > @@ -44,6 +44,7 @@ static const struct pci_epc_features
> > ls_pcie_epc_features = {
> > >       .linkup_notifier = false,
> > >       .msi_capable = true,
> > >       .msix_capable = false,
> > > +     .bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4),
> > >  };
> > >
> > >  static const struct pci_epc_features*
> I check other platforms, it is 'static const struct pci_epc_features', I can get the correct 
> Value use this define way in pci-epf-test.c file.
> > >
