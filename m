Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8ED62479E
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 17:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiKJQxM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 11:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiKJQxL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 11:53:11 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CE6F3
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 08:53:09 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AAGqrAI060833;
        Thu, 10 Nov 2022 10:52:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668099173;
        bh=w5j86CzKYF07xOJPyY0nX885GuLyWGBKxDMS3NjTkr8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=QFEDh1C39N10WcwxTCN5gl0Trp9wH+VGB9nhDWjgoRgSakxHVSQj+MgL2p5Edq8E/
         O1Hamgx7EqAnWBBrA9ilKNpIz1xnnKOA3u6uF2QWetpMwXo+9lsJHCET6kkbSVmCUc
         NSkMrlzhKYj6X5JuUwwfhNbHYRSc+N4kmn1WByH8=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AAGqr0k067265
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Nov 2022 10:52:53 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 10
 Nov 2022 10:52:52 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 10 Nov 2022 10:52:52 -0600
Received: from ubuntu (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with SMTP id 2AAGqjv8024440;
        Thu, 10 Nov 2022 10:52:47 -0600
Date:   Thu, 10 Nov 2022 08:52:44 -0800
From:   Matt Ranostay <mranostay@ti.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
CC:     <vigneshr@ti.com>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 1/4] PCI: j721e: Add per platform maximum lane settings
Message-ID: <Y20sXJZOS7svwTQX@ubuntu>
References: <20221109082556.29265-1-mranostay@ti.com>
 <20221109082556.29265-2-mranostay@ti.com>
 <Y20czRFAkngbbC19@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y20czRFAkngbbC19@lpieralisi>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 10, 2022 at 04:46:21PM +0100, Lorenzo Pieralisi wrote:
> On Wed, Nov 09, 2022 at 12:25:53AM -0800, Matt Ranostay wrote:
> > Various platforms have different maximum amount of lanes that
> > can be selected. Add max_lanes to struct j721e_pcie to allow
> > for error checking on num-lanes selection from device tree.
> 
> https://lore.kernel.org/linux-pci/CAL_JsqJ5cOLXhD-73esmhVwMEWGT+w3SJC14Z0jY4tQJQRA7iw@mail.gmail.com
> 
> Why have you reposted this patch ?
> 

Max lanes is still needed to calculate the bitmask (i.e. 2x needing one-bit mask, and 4x needing 2-bit mask), but
noticed that I should have change th commit message to be more clear, and drop the part of it being for device-tree
validation..

'PCI: j721e: Add warnings on num-lanes misconfiguration' could be dropped in the series if validation
should be done in the YAML schema checking.

- Matt

> Lorenzo
> 
> > Signed-off-by: Matt Ranostay <mranostay@ti.com>
> > Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> > ---
> >  drivers/pci/controller/cadence/pci-j721e.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> > index a82f845cc4b5..875224d34958 100644
> > --- a/drivers/pci/controller/cadence/pci-j721e.c
> > +++ b/drivers/pci/controller/cadence/pci-j721e.c
> > @@ -48,8 +48,6 @@ enum link_status {
> >  
> >  #define GENERATION_SEL_MASK		GENMASK(1, 0)
> >  
> > -#define MAX_LANES			2
> > -
> >  struct j721e_pcie {
> >  	struct cdns_pcie	*cdns_pcie;
> >  	struct clk		*refclk;
> > @@ -72,6 +70,7 @@ struct j721e_pcie_data {
> >  	unsigned int		quirk_disable_flr:1;
> >  	u32			linkdown_irq_regfield;
> >  	unsigned int		byte_access_allowed:1;
> > +	unsigned int		max_lanes;
> >  };
> >  
> >  static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32 offset)
> > @@ -291,11 +290,13 @@ static const struct j721e_pcie_data j721e_pcie_rc_data = {
> >  	.quirk_retrain_flag = true,
> >  	.byte_access_allowed = false,
> >  	.linkdown_irq_regfield = LINK_DOWN,
> > +	.max_lanes = 2,
> >  };
> >  
> >  static const struct j721e_pcie_data j721e_pcie_ep_data = {
> >  	.mode = PCI_MODE_EP,
> >  	.linkdown_irq_regfield = LINK_DOWN,
> > +	.max_lanes = 2,
> >  };
> >  
> >  static const struct j721e_pcie_data j7200_pcie_rc_data = {
> > @@ -303,23 +304,27 @@ static const struct j721e_pcie_data j7200_pcie_rc_data = {
> >  	.quirk_detect_quiet_flag = true,
> >  	.linkdown_irq_regfield = J7200_LINK_DOWN,
> >  	.byte_access_allowed = true,
> > +	.max_lanes = 2,
> >  };
> >  
> >  static const struct j721e_pcie_data j7200_pcie_ep_data = {
> >  	.mode = PCI_MODE_EP,
> >  	.quirk_detect_quiet_flag = true,
> >  	.quirk_disable_flr = true,
> > +	.max_lanes = 2,
> >  };
> >  
> >  static const struct j721e_pcie_data am64_pcie_rc_data = {
> >  	.mode = PCI_MODE_RC,
> >  	.linkdown_irq_regfield = J7200_LINK_DOWN,
> >  	.byte_access_allowed = true,
> > +	.max_lanes = 1,
> >  };
> >  
> >  static const struct j721e_pcie_data am64_pcie_ep_data = {
> >  	.mode = PCI_MODE_EP,
> >  	.linkdown_irq_regfield = J7200_LINK_DOWN,
> > +	.max_lanes = 1,
> >  };
> >  
> >  static const struct of_device_id of_j721e_pcie_match[] = {
> > @@ -433,7 +438,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
> >  	pcie->user_cfg_base = base;
> >  
> >  	ret = of_property_read_u32(node, "num-lanes", &num_lanes);
> > -	if (ret || num_lanes > MAX_LANES)
> > +	if (ret || num_lanes > data->max_lanes)
> >  		num_lanes = 1;
> >  	pcie->num_lanes = num_lanes;
> >  
> > -- 
> > 2.38.GIT
> > 
