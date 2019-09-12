Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 970B0B0F6F
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2019 15:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731943AbfILNCD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 09:02:03 -0400
Received: from foss.arm.com ([217.140.110.172]:33888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731937AbfILNCC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Sep 2019 09:02:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA45928;
        Thu, 12 Sep 2019 06:02:01 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09BF13F71F;
        Thu, 12 Sep 2019 06:02:01 -0700 (PDT)
Date:   Thu, 12 Sep 2019 14:01:59 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>, "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: Re: [PATCH v3 10/11] arm64: dts: layerscape: Add PCIe EP node for
 ls1088a
Message-ID: <20190912130159.GF9720@e119886-lin.cambridge.arm.com>
References: <20190902031716.43195-1-xiaowei.bao@nxp.com>
 <20190902031716.43195-11-xiaowei.bao@nxp.com>
 <20190902130628.GL9720@e119886-lin.cambridge.arm.com>
 <AM5PR04MB329926C6F424C4BE1CE9B787F5B90@AM5PR04MB3299.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM5PR04MB329926C6F424C4BE1CE9B787F5B90@AM5PR04MB3299.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 03, 2019 at 02:01:32AM +0000, Xiaowei Bao wrote:
> 
> 
> > -----Original Message-----
> > From: Andrew Murray <andrew.murray@arm.com>
> > Sent: 2019年9月2日 21:06
> > To: Xiaowei Bao <xiaowei.bao@nxp.com>
> > Cc: robh+dt@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org; Leo
> > Li <leoyang.li@nxp.com>; kishon@ti.com; lorenzo.pieralisi@arm.com; M.h.
> > Lian <minghuan.lian@nxp.com>; Mingkai Hu <mingkai.hu@nxp.com>; Roy
> > Zang <roy.zang@nxp.com>; jingoohan1@gmail.com;
> > gustavo.pimentel@synopsys.com; linux-pci@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linuxppc-dev@lists.ozlabs.org;
> > arnd@arndb.de; gregkh@linuxfoundation.org; Z.q. Hou
> > <zhiqiang.hou@nxp.com>
> > Subject: Re: [PATCH v3 10/11] arm64: dts: layerscape: Add PCIe EP node for
> > ls1088a
> > 
> > On Mon, Sep 02, 2019 at 11:17:15AM +0800, Xiaowei Bao wrote:
> > > Add PCIe EP node for ls1088a to support EP mode.
> > >
> > > Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> > > ---
> > > v2:
> > >  - Remove the pf-offset proparty.
> > > v3:
> > >  - No change.
> > >
> > >  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 31
> > ++++++++++++++++++++++++++
> > >  1 file changed, 31 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > > index c676d07..da246ab 100644
> > > --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > > @@ -483,6 +483,17 @@
> > >  			status = "disabled";
> > >  		};
> > >
> > > +		pcie_ep@3400000 {
> > > +			compatible = "fsl,ls1088a-pcie-ep","fsl,ls-pcie-ep";
> > 
> > Here you specify a fallback "fsl,ls-pcie-ep" that is removed by this series.
> > 
> > Besides that, this looks OK.
> 
> As explained, the "fsl,ls-pcie-ep" is needed, due to the u-boot will fixup the status
> property base on this compatible, I think we reserve this compatible is helpfully,
> if delate this compatible, I have to modify the code of bootloader.

I assume you mean that u-boot fixes up "fsl,ls-pcie-ep" *only* for ls1046a
devices?

Thanks,

Andrew Murray

> 
> Thanks 
> XIaowei
> 
> > 
> > Thanks,
> > 
> > Andrew Murray
> > 
> > > +			reg = <0x00 0x03400000 0x0 0x00100000
> > > +			       0x20 0x00000000 0x8 0x00000000>;
> > > +			reg-names = "regs", "addr_space";
> > > +			num-ib-windows = <24>;
> > > +			num-ob-windows = <128>;
> > > +			max-functions = /bits/ 8 <2>;
> > > +			status = "disabled";
> > > +		};
> > > +
> > >  		pcie@3500000 {
> > >  			compatible = "fsl,ls1088a-pcie";
> > >  			reg = <0x00 0x03500000 0x0 0x00100000   /* controller
> > registers */
> > > @@ -508,6 +519,16 @@
> > >  			status = "disabled";
> > >  		};
> > >
> > > +		pcie_ep@3500000 {
> > > +			compatible = "fsl,ls1088a-pcie-ep","fsl,ls-pcie-ep";
> > > +			reg = <0x00 0x03500000 0x0 0x00100000
> > > +			       0x28 0x00000000 0x8 0x00000000>;
> > > +			reg-names = "regs", "addr_space";
> > > +			num-ib-windows = <6>;
> > > +			num-ob-windows = <8>;
> > > +			status = "disabled";
> > > +		};
> > > +
> > >  		pcie@3600000 {
> > >  			compatible = "fsl,ls1088a-pcie";
> > >  			reg = <0x00 0x03600000 0x0 0x00100000   /* controller
> > registers */
> > > @@ -533,6 +554,16 @@
> > >  			status = "disabled";
> > >  		};
> > >
> > > +		pcie_ep@3600000 {
> > > +			compatible = "fsl,ls1088a-pcie-ep","fsl,ls-pcie-ep";
> > > +			reg = <0x00 0x03600000 0x0 0x00100000
> > > +			       0x30 0x00000000 0x8 0x00000000>;
> > > +			reg-names = "regs", "addr_space";
> > > +			num-ib-windows = <6>;
> > > +			num-ob-windows = <8>;
> > > +			status = "disabled";
> > > +		};
> > > +
> > >  		smmu: iommu@5000000 {
> > >  			compatible = "arm,mmu-500";
> > >  			reg = <0 0x5000000 0 0x800000>;
> > > --
> > > 2.9.5
> > >
