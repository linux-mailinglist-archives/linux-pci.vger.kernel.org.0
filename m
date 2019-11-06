Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 276D2F194D
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 16:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfKFPBg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 10:01:36 -0500
Received: from foss.arm.com ([217.140.110.172]:41282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727321AbfKFPBg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 10:01:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DA6F46A;
        Wed,  6 Nov 2019 07:01:35 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A418A3F71A;
        Wed,  6 Nov 2019 07:01:33 -0800 (PST)
Date:   Wed, 6 Nov 2019 15:01:28 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "M.h. Lian" <minghuan.lian@nxp.com>
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        Roy Zang <roy.zang@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: Re: [PATCH v6 3/3] PCI: layerscape: Add LS1028a support
Message-ID: <20191106150128.GA18689@e121166-lin.cambridge.arm.com>
References: <20190902034319.14026-1-xiaowei.bao@nxp.com>
 <20190902034319.14026-3-xiaowei.bao@nxp.com>
 <20191105123233.GA26960@e121166-lin.cambridge.arm.com>
 <AM5PR04MB32999C59EE51DACC030E13D7F5790@AM5PR04MB3299.eurprd04.prod.outlook.com>
 <VI1PR0401MB22372AF4F02D3F22EA2184BEE8790@VI1PR0401MB2237.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR0401MB22372AF4F02D3F22EA2184BEE8790@VI1PR0401MB2237.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 06, 2019 at 03:46:17AM +0000, M.h. Lian wrote:
> Hi Lorenzo,
> 
> Sorry for the late reply.
> 
> Acked-by: Minghuan Lian <minghuan.Lian@nxp.com>

https://en.wikipedia.org/wiki/Posting_style#Top-posting

Never top-post on kernel mailing lists.

Thanks,
Lorenzo

> Thanks,
> Minghuan
> 
> > -----Original Message-----
> > From: Xiaowei Bao <xiaowei.bao@nxp.com>
> > Sent: Wednesday, November 6, 2019 11:36 AM
> > To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: robh+dt@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org;
> > Leo Li <leoyang.li@nxp.com>; M.h. Lian <minghuan.lian@nxp.com>; Mingkai
> > Hu <mingkai.hu@nxp.com>; Roy Zang <roy.zang@nxp.com>; linux-
> > pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linuxppc-
> > dev@lists.ozlabs.org; bhelgaas@google.com; Z.q. Hou
> > <zhiqiang.hou@nxp.com>
> > Subject: RE: [PATCH v6 3/3] PCI: layerscape: Add LS1028a support
> > 
> > 
> > 
> > > -----Original Message-----
> > > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Sent: 2019年11月5日 20:33
> > > To: Xiaowei Bao <xiaowei.bao@nxp.com>
> > > Cc: robh+dt@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org;
> > Leo
> > > Li <leoyang.li@nxp.com>; M.h. Lian <minghuan.lian@nxp.com>; Mingkai
> > Hu
> > > <mingkai.hu@nxp.com>; Roy Zang <roy.zang@nxp.com>;
> > > linux-pci@vger.kernel.org; devicetree@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > linuxppc-dev@lists.ozlabs.org; bhelgaas@google.com; Z.q. Hou
> > > <zhiqiang.hou@nxp.com>
> > > Subject: Re: [PATCH v6 3/3] PCI: layerscape: Add LS1028a support
> > >
> > > On Mon, Sep 02, 2019 at 11:43:19AM +0800, Xiaowei Bao wrote:
> > > > Add support for the LS1028a PCIe controller.
> > > >
> > > > Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> > > > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > > ---
> > > > v2:
> > > >  - No change.
> > > > v3:
> > > >  - Reuse the ls2088 driver data structurt.
> > > > v4:
> > > >  - No change.
> > > > v5:
> > > >  - No change.
> > > > v6:
> > > >  - No change.
> > > >
> > > >  drivers/pci/controller/dwc/pci-layerscape.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > >
> > > I have not seen any comment on any layerscape driver patches coming
> > > from the maintainers as listed in the MAINTAINERS file (and CCed in this
> > series).
> > >
> > > I request maintainers ACK on these patches and I expect them to start
> > > reviewing your code if they want to be still considered maintainers
> > > for this driver.
> > >
> > > The changes look OK minus Shawn's remark on compatible string that was
> > > ignored.
> > 
> > Hi Lorenzo,
> > 
> > Thanks for your comments.
> > 
> > In fact, the patches have reviewed in our internal mail list, after the review by
> > Minghuan and Mingkai, I will send these patches to opensource, they will
> > give the ACK when these patches seems is OK and no comments on this.
> > 
> > Thanks
> > Xiaowei
> > 
> > >
> > > Thanks,
> > > Lorenzo
> > >
> > > > diff --git a/drivers/pci/controller/dwc/pci-layerscape.c
> > > > b/drivers/pci/controller/dwc/pci-layerscape.c
> > > > index 3a5fa26..f24f79a 100644
> > > > --- a/drivers/pci/controller/dwc/pci-layerscape.c
> > > > +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> > > > @@ -263,6 +263,7 @@ static const struct ls_pcie_drvdata
> > > > ls2088_drvdata = {  static const struct of_device_id ls_pcie_of_match[] = {
> > > >  	{ .compatible = "fsl,ls1012a-pcie", .data = &ls1046_drvdata },
> > > >  	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021_drvdata },
> > > > +	{ .compatible = "fsl,ls1028a-pcie", .data = &ls2088_drvdata },
> > > >  	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043_drvdata },
> > > >  	{ .compatible = "fsl,ls1046a-pcie", .data = &ls1046_drvdata },
> > > >  	{ .compatible = "fsl,ls2080a-pcie", .data = &ls2080_drvdata },
> > > > --
> > > > 2.9.5
> > > >
