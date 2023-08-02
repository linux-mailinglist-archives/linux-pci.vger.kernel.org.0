Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7603076CB34
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 12:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjHBKqt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 06:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjHBKqs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 06:46:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDA3A3;
        Wed,  2 Aug 2023 03:46:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DAF26191C;
        Wed,  2 Aug 2023 10:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39A0C433C8;
        Wed,  2 Aug 2023 10:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690973206;
        bh=njKZjcNCttht7Dk3VXvnUjPNwPhNR/pW2VtdqrlKiOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xf2NQTMud1K9i6v59fp0A5Mf02CQRNzqrNmgxcSxaczbfh90aSxVozsI5gKY4gqRu
         ElLWAaqvWfwUaQNmY0qlez0wnHH1rA0rtYw3YJtjerTpAZ85DtJOE8buthRyiFBwYW
         JCajZPNF5jZHOZ8oLx7pM71bWxMEmo0Cpj8U86dW/bxcAxqrFWHRRGE/cl/MRB+asc
         Orw11dAbgL4lNZR3Hk6l9C1tvhzp5/zx4gfllHXMlOGFCx9JkTCVTph5J8ybSzCel9
         EPRmCpq1cmyuXGB3xUDw1n4iVLs4FIBnrBW7nd0IUMc0/CsvQ98bxqXJZ9Xi3autaC
         MvTih8V2OWZUg==
Date:   Wed, 2 Aug 2023 16:16:30 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v18 09/20] PCI: dwc: Add PCI_EXP_LNKCAP_MLW handling
Message-ID: <20230802104630.GC57374@thinkpad>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-10-yoshihiro.shimoda.uh@renesas.com>
 <20230724110344.GH6291@thinkpad>
 <TYBPR01MB534165847452C8A2398B03D9D800A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230728025119.GB4433@thinkpad>
 <TYBPR01MB534130DF2431F0A49E0C5C3BD806A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <2zv7mcxa7skywhxe2ene3c5ycine6tsmsfwmpf4nknhoeye7rx@m525r5ph3xow>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2zv7mcxa7skywhxe2ene3c5ycine6tsmsfwmpf4nknhoeye7rx@m525r5ph3xow>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 28, 2023 at 07:07:03PM +0300, Serge Semin wrote:
> On Fri, Jul 28, 2023 at 04:19:38AM +0000, Yoshihiro Shimoda wrote:
> > Hi Manivannan,
> > 
> > > From: Manivannan Sadhasivam, Sent: Friday, July 28, 2023 11:51 AM
> > > 
> > > On Wed, Jul 26, 2023 at 02:12:15AM +0000, Yoshihiro Shimoda wrote:
> > > > Hi Manivannan,
> > > >
> > > > > From: Manivannan Sadhasivam, Sent: Monday, July 24, 2023 8:04 PM
> > > > >
> > > > > Subject should contain the word "missing". Like, "Add missing PCI_EXP_LNKCAP_MLW
> > > > > handling".
> > > >
> > > > I got it.
> > > >
> > > > > On Fri, Jul 21, 2023 at 04:44:41PM +0900, Yoshihiro Shimoda wrote:
> > > > > > Update dw_pcie_link_set_max_link_width() to set PCI_EXP_LNKCAP_MLW.
> > > > > > In accordance with the DW PCIe RC/EP HW manuals [1,2,3,...] aside with
> > > > > > the PORT_LINK_CTRL_OFF.LINK_CAPABLE and GEN2_CTRL_OFF.NUM_OF_LANES[8:0]
> > > > > > field there is another one which needs to be updated. It's
> > > > > > LINK_CAPABILITIES_REG.PCIE_CAP_MAX_LINK_WIDTH. If it isn't done at
> > > > > > the very least the maximum link-width capability CSR won't expose
> > > > > > the actual maximum capability.
> > > > > >
> > > > > > [1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
> > > > > >     Version 4.60a, March 2015, p.1032
> > > > > > [2] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
> > > > > >     Version 4.70a, March 2016, p.1065
> > > > > > [3] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
> > > > > >     Version 4.90a, March 2016, p.1057
> > > > > > ...
> > > > > > [X] DesignWare Cores PCI Express Controller Databook - DWC PCIe Endpoint,
> > > > > >       Version 5.40a, March 2019, p.1396
> > > > > > [X+1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
> > > > > >       Version 5.40a, March 2019, p.1266
> > > > > >
> > > > > > Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> > > > >
> > > > > Add Reported-by also?
> > > >
> > > > I don't think so because Serge suggested the commit description from my submitted patch [1].
> > > >
> > > > [1]
> > > >
> > <snip URL>
> > > >
> > > 
> > > Fine then.
> > > 
> > > > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > >
> > > > > This looks like a potential bug fix to me. So please move this change before the
> > > > > previous patch that introduces dw_pcie_link_set_max_link_width(), tag fixes and
> > > > > CC stable list for backporting.
> > > >
> > > > I think that this patch should be a next branch because this is possible to
> > > > cause side effective. Almost all drivers/pcie/controller/dwc/ host drivers except
> > > > pcie-tegra194.c doesn't have this setting, but I assume that the drivers work correctly
> > > > without this setting.
> > > >
> > > > Also, to be honest, I could not find a suitable commit ID for this patch's "Fixes" tag.
> > > > Additionally, I could not determine which old kernel versions should have this patch
> > > > applied as backporting.
> > > >
> > > 
> 
> > > Ok. But you can still move this patch as I suggested. If we happen to hit any
> > > issue with this setting, then we can easily revert it.
> > 
> > I got it. I'll move this patch as you suggested.
> 
> No. By moving this patch to be implemented before the patch:
> [PATCH v18 08/20] PCI: dwc: Add dw_pcie_link_set_max_link_width()
> you won't be able to easily revert it afterwards because the patch #8
> will move the code added by the patch #9 to the
> dw_pcie_link_set_max_link_width() function. Basically you suggest to
> switch the preparation and functional patches order which doesn't look
> right.
> 
> Basically the Link-width-related part of this series currently implies
> the next logic:
> 
> 1. Prepare the DW PCIe core driver to implementing a comprehensive
> Max-link-width setup methods (aka as it's done in
> dw_pcie_link_set_max_speed()) by moving the Link-width related code to
> a dedicated method:
> [PATCH v18 08/20] PCI: dwc: Add dw_pcie_link_set_max_link_width()
> 
> 2. Add the PCI_EXP_LNKCAP_MLW field update, which
> dw_pcie_link_set_max_link_width() lacks to be comprehensive:
> [PATCH v18 09/20] PCI: dwc: Add PCI_EXP_LNKCAP_MLW handling
> 
> 3. Drop the duplicating code from the Tegra194 PCIe driver:
> [PATCH v18 10/20] PCI: tegra194: Drop PCI_EXP_LNKSTA_NLW setting
> 
> In case if the patch #9 appears to be a bug fix, then it will need to
> be backported together with patch #8 which isn't a problem at all
> (though it's doubtfully to happen since nobody reported any problem
> with that so far). But if patch #9 turns out to break something in
> current circumstances we'll be able to either easily revert it (since
> it's applied after the preparation patch) or fix somehow. If you
> switch patch #8 and #9 order, the reversion will require to be
> performed for both these patches to avoid the conflicts. Thus I'd
> suggest to leave the patches order as is which looks more natural and
> won't cause any problems to revert the functional change or to
> backport it.
> 

Hmm, I overlooked the dependency. Let's keep the order as it is.

- Mani

> -Serge(y)
> 
> > 
> > Best regards,
> > Yoshihiro Shimoda
> > 
> > > - Mani
> > > 
> > > > Best regards,
> > > > Yoshihiro Shimoda
> > > >
> > > > > - Mani
> > > > >
> > > > > > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > > > > > ---
> > > > > >  drivers/pci/controller/dwc/pcie-designware.c | 9 ++++++++-
> > > > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > index 5cca34140d2a..c4998194fe74 100644
> > > > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > @@ -730,7 +730,8 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
> > > > > >
> > > > > >  static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
> > > > > >  {
> > > > > > -	u32 lwsc, plc;
> > > > > > +	u32 lnkcap, lwsc, plc;
> > > > > > +	u8 cap;
> > > > > >
> > > > > >  	if (!num_lanes)
> > > > > >  		return;
> > > > > > @@ -766,6 +767,12 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
> > > > > >  	}
> > > > > >  	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc);
> > > > > >  	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, lwsc);
> > > > > > +
> > > > > > +	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > > > > > +	lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
> > > > > > +	lnkcap &= ~PCI_EXP_LNKCAP_MLW;
> > > > > > +	lnkcap |= FIELD_PREP(PCI_EXP_LNKCAP_MLW, num_lanes);
> > > > > > +	dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, lnkcap);
> > > > > >  }
> > > > > >
> > > > > >  void dw_pcie_iatu_detect(struct dw_pcie *pci)
> > > > > > --
> > > > > > 2.25.1
> > > > > >
> > > > >
> > > > > --
> > > > > மணிவண்ணன் சதாசிவம்
> > > 
> > > --
> > > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
