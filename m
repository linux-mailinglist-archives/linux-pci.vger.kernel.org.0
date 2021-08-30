Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A073FBE75
	for <lists+linux-pci@lfdr.de>; Mon, 30 Aug 2021 23:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238468AbhH3VoO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Aug 2021 17:44:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238718AbhH3VoN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Aug 2021 17:44:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5DBD60E90;
        Mon, 30 Aug 2021 21:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630359799;
        bh=zbF3yv3WsPc6wc8t9qfmmgZ/lsdWyqbDW8FcCrDPuyU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kBXWL/TQGLTNPzPT5D1t87Hd+gPPA12194U6gqUgTgOFjGN6ii3xJMWicLvkbRmgF
         XVwshnvVeiN9iMrc4FFbRj59YUQk04lQi6bBCL+2GTo7D+lJfy4hNXsVD5TrAdsyFf
         VxpmLP+Ct8VykrxQuK8Sheqhu0Ae+P/T6ewQr8vHeAxzwLHRExW+E7YZFwnUI48Ta/
         WUlU3rCydCVeGmRmiDdW3Jx5N1ha0ke9S5ycXg3eVu2ramZcp9WMShG2qm1prMMBsF
         kX1hbDVvP/WhP6SwQADep/x4y5OQWKTzrYG64YklfpHiGo9UOZT032NOZCDS6qibdw
         Sj+Gr6a7gZQYQ==
Date:   Mon, 30 Aug 2021 16:43:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Chuanjia Liu <chuanjia.liu@mediatek.com>
Cc:     robh+dt@kernel.org, bhelgaas@google.com, matthias.bgg@gmail.com,
        lorenzo.pieralisi@arm.com, ryder.lee@mediatek.com,
        jianjun.wang@mediatek.com, yong.wu@mediatek.com,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 2/6] PCI: mediatek: Add new method to get shared
 pcie-cfg base address
Message-ID: <20210830214317.GA27606@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <968266ecd5889721aa234c414361bedbe66b9539.camel@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 30, 2021 at 03:09:44PM +0800, Chuanjia Liu wrote:
> On Fri, 2021-08-27 at 11:46 -0500, Bjorn Helgaas wrote:
> > On Mon, Aug 23, 2021 at 11:27:56AM +0800, Chuanjia Liu wrote:

> > > @@ -995,6 +1004,14 @@ static int mtk_pcie_subsys_powerup(struct
> > > mtk_pcie *pcie)
> > >  			return PTR_ERR(pcie->base);
> > >  	}
> > >  
> > > +	cfg_node = of_find_compatible_node(NULL, NULL,
> > > +					   "mediatek,generic-pciecfg");
> > > +	if (cfg_node) {
> > > +		pcie->cfg = syscon_node_to_regmap(cfg_node);
> > 
> > Other drivers in drivers/pci/controller/ use
> > syscon_regmap_lookup_by_phandle() (j721e, dra7xx, keystone,
> > layerscape, artpec6) or syscon_regmap_lookup_by_compatible() (imx6,
> > kirin, v3-semi).
> > 
> > You should do it the same way unless there's a need to be different.
>
> I have used phandle, but Rob suggested to search for the node by 
> compatible.

> The reason why syscon_regmap_lookup_by_compatible() is not 
> used here is that the pciecfg node is optional, and there is no need to
> return error when the node is not searched.

How about this?

  regmap = syscon_regmap_lookup_by_compatible("mediatek,generic-pciecfg");
  if (!IS_ERR(regmap))
    pcie->cfg = regmap;
