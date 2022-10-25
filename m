Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2986D60CCBE
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 14:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbiJYMz4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 08:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbiJYMzj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 08:55:39 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F278BB489A
        for <linux-pci@vger.kernel.org>; Tue, 25 Oct 2022 05:51:50 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29PCpffT034240;
        Tue, 25 Oct 2022 07:51:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666702301;
        bh=HgP27iUh3ikV8+Pj3Lp8cBDsKGF6jEt7/MSPqaVezi8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=EzAKrWMkkMtDLtQ4t3KQRhcOaIVwl/3c5JS3PK7onGnrlNrx6nmFCaUP1UvQ+zQCf
         GKJntwnQPQ/v2Wt5f6QZK1l6dpVQsDuiOG6N3GFO08w8/Ovr9pB+UDKCcD69oGo0a4
         3a8TVW7/VwhWnv0k0nGY1tE1mL09OvmDudNDXKPA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29PCpf6G110709
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Oct 2022 07:51:41 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 25
 Oct 2022 07:51:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 25 Oct 2022 07:51:40 -0500
Received: from ubuntu (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with SMTP id 29PCpXut112594;
        Tue, 25 Oct 2022 07:51:35 -0500
Date:   Tue, 25 Oct 2022 05:51:31 -0700
From:   Matt Ranostay <mranostay@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     <robh@kernel.org>, <tjoseph@cadence.com>, <nm@ti.com>,
        <a-verma1@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] PCI: j721e: Add PCIe 4x lane selection support
Message-ID: <Y1fb0/ZBoy68AYV4@ubuntu>
References: <20221020012911.305139-1-mranostay@ti.com>
 <20221020012911.305139-2-mranostay@ti.com>
 <e33dc6fd-1227-e01f-715e-947fac2fd233@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e33dc6fd-1227-e01f-715e-947fac2fd233@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 25, 2022 at 05:23:20PM +0530, Vignesh Raghavendra wrote:
> Hi Matt,
> 
> On 20/10/22 6:59 am, Matt Ranostay wrote:
> > Add support for setting of two-bit field that allows selection of 4x
> > lane PCIe which was previously limited to only 2x lanes.
> > 
> > Signed-off-by: Matt Ranostay <mranostay@ti.com>
> > ---
> >  drivers/pci/controller/cadence/pci-j721e.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> > index a82f845cc4b5..d9b1527421c3 100644
> > --- a/drivers/pci/controller/cadence/pci-j721e.c
> > +++ b/drivers/pci/controller/cadence/pci-j721e.c
> > @@ -43,7 +43,6 @@ enum link_status {
> >  };
> >  
> >  #define J721E_MODE_RC			BIT(7)
> > -#define LANE_COUNT_MASK			BIT(8)
> >  #define LANE_COUNT(n)			((n) << 8)
> >  
> >  #define GENERATION_SEL_MASK		GENMASK(1, 0)
> > @@ -207,11 +206,15 @@ static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
> >  {
> >  	struct device *dev = pcie->cdns_pcie->dev;
> >  	u32 lanes = pcie->num_lanes;
> > +	u32 mask = GENMASK(8, 8);
> >  	u32 val = 0;
> >  	int ret;
> >  
> > +	if (lanes == 4)
> > +		mask = GENMASK(9, 8);
> 
> 
> Shouldn't we decide "mask" based on max_lanes added in 2/3 (ie how many
> lanes HW can support and thus width of this bit field) instead of
> num_lanes? Hypothetically, what if bootloader / other entity has set MSb
> but Linux is restricted to 2 lanes in DT?

Ah yes that is a very good point, and the mask should be based on max_lanes.

Will fix up in v4...

- Matt

> 
> > +
> >  	val = LANE_COUNT(lanes - 1);
> > -	ret = regmap_update_bits(syscon, offset, LANE_COUNT_MASK, val);
> > +	ret = regmap_update_bits(syscon, offset, mask, val);
> >  	if (ret)
> >  		dev_err(dev, "failed to set link count\n");
> >  
