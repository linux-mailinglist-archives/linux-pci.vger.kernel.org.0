Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108986BA0FD
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 21:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjCNUsq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 16:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCNUsp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 16:48:45 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 680D083DF;
        Tue, 14 Mar 2023 13:48:41 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 7CB48E0EAF;
        Tue, 14 Mar 2023 23:48:40 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-type:content-type:date
        :from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=post; bh=mPD90DJPcPmP48GK0ojm
        CB01uj25M2d6itepQTmW9pw=; b=imXs0fOT6I2kdFarLpn+5DLc6Sulgu0uKYBS
        8+y7rgDItOEXt6tQKJiSJboGHfR9gyeASF9T1Qegc6dNa8y7mPGusLCGaaNpQq65
        hcDY+cSmj8zMSpLOfeHsIfQgL0yszpuYlFBC2VdcTxZ40HfBHZm5kyaCiq93EHtE
        6VhkXC8=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 55B53E0E1C;
        Tue, 14 Mar 2023 23:48:40 +0300 (MSK)
Received: from mobilestation (10.8.30.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 14 Mar 2023 23:48:39 +0300
Date:   Tue, 14 Mar 2023 23:48:38 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Elad Nachman <enachman@marvell.com>,
        <thomas.petazzoni@bootlin.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 8/8] PCI: dwc: Introduce region limit from DT
Message-ID: <20230314204838.buba4y2iyx3m6qnn@mobilestation>
References: <20230313124016.17102-9-enachman@marvell.com>
 <20230313194802.GA1531673@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230313194802.GA1531673@bhelgaas>
X-Originating-IP: [10.8.30.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn

On Mon, Mar 13, 2023 at 02:48:02PM -0500, Bjorn Helgaas wrote:
> [+cc Serge, who has done most of the recent work in this file]
> 

Thanks for sending copy to me. I'll have a look at the series on
this week.

-Serge(y)

> On Mon, Mar 13, 2023 at 02:40:16PM +0200, Elad Nachman wrote:
> > From: Elad Nachman <enachman@marvell.com>
> > 
> > Allow dts override of region limit for SOCs with older Synopsis
> > Designware PCIe IP but with greater than 32-bit address range support,
> > such as the Armada 7020/7040/8040 family of SOCs by Marvell,
> > when the DT file places the PCIe window above the 4GB region.
> > The Synopsis Designware PCIe IP in these SOCs is too old to specify the
> > highest memory location supported by the PCIe, but practically supports
> > such locations. Allow these locations to be specified in the DT file.
> > DT property is called num-regionmask , and can range between 33 and 64.
> 
> s/Synopsis/Synopsys/ (several occurrences)
> 
> s/Designware/DesignWare/ (several occurrences)
> 
> Remove space before comma.
> 
> > Signed-off-by: Elad Nachman <enachman@marvell.com>
> > ---
> > v4:
> >    1) Fix blank lines removal / addition
> > 
> >    2) Remove usage of variable with same name as dt binding property
> > 
> >  drivers/pci/controller/dwc/pcie-designware.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 53a16b8b6ac2..9773c110c733 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -735,8 +735,10 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
> >  void dw_pcie_iatu_detect(struct dw_pcie *pci)
> >  {
> >  	int max_region, ob, ib;
> > -	u32 val, min, dir;
> > +	u32 val, min, dir, ret;
> >  	u64 max;
> > +	struct device *dev = pci->dev;
> > +	struct device_node *np = dev->of_node;
> >  
> >  	val = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT);
> >  	if (val == 0xFFFFFFFF) {
> > @@ -781,7 +783,13 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
> >  		dw_pcie_writel_atu(pci, dir, 0, PCIE_ATU_UPPER_LIMIT, 0xFFFFFFFF);
> >  		max = dw_pcie_readl_atu(pci, dir, 0, PCIE_ATU_UPPER_LIMIT);
> >  	} else {
> > -		max = 0;
> > +		/* Allow dts override of region limit for older IP with above 32-bit support: */
> 
> Reflow comment to fit in 80 columns.
> 
> > +		ret = of_property_read_u32(np, "num-regionmask", &val);
> > +		if (!ret && val > 32) {
> > +			max = GENMASK(val - 33, 0);
> > +			dev_info(pci->dev, "Overriding region limit to %u bits\n", val);
> > +		} else
> > +			max = 0;
> >  	}
> >  
> >  	pci->num_ob_windows = ob;
> > -- 
> > 2.17.1
> > 
> 

