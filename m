Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CFE68F33B
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 17:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjBHQfO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 11:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjBHQfN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 11:35:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCDA47EFE;
        Wed,  8 Feb 2023 08:35:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE574B81D42;
        Wed,  8 Feb 2023 16:35:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEA1C433D2;
        Wed,  8 Feb 2023 16:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675874103;
        bh=FXaPjW3ceCX1o65WyKM27JljalbZnb73IGkfHoLx/68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qliT6IkiSi1hF7xhTXWkvU7HfK4mIU8Afeq6Yzp+vcamiVs0iXbnsKDtiMNQ5TqHr
         VSfJ4t8eLGnUrqCkOR5gw7UJZkMmpDyIq03ftHiiB95twj+yaa7GmWKrDawq2DYxGm
         NhOxI6EcZhKAGFKi03AEy3ahX7n04TTp6Ud2u81kJ0ZrdDIwk6Uan8fRC/KZwCMo+J
         9+xzGdBUaCvktAcGiBI0pGRmmGrxMHprqKqOoi+Bv2sTlz5gbKMBGq489vsOOF/kEh
         mB8i0hYjvYNzIyeIC6Hj0P09SFcnBjfHwu4Si3zCoOU8LlCKv6gnZ/DVRQ0XtAKLeo
         v5Us3hk+xrqOQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pPnQ3-0005tJ-NM; Wed, 08 Feb 2023 17:35:39 +0100
Date:   Wed, 8 Feb 2023 17:35:39 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v7 08/12] phy: qcom-qmp-pcie: Add support for SM8550 g3x2
 and g4x2 PCIEs
Message-ID: <Y+PPWymsIfYW9OHX@hovoldconsulting.com>
References: <20230203081807.2248625-1-abel.vesa@linaro.org>
 <20230203081807.2248625-9-abel.vesa@linaro.org>
 <Y9zU2jBdSD72W28F@hovoldconsulting.com>
 <Y+EJDofgt6I/abyp@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+EJDofgt6I/abyp@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 06, 2023 at 04:05:02PM +0200, Abel Vesa wrote:
> On 23-02-03 10:33:14, Johan Hovold wrote:
> > On Fri, Feb 03, 2023 at 10:18:03AM +0200, Abel Vesa wrote:
> > > Add the SM8550 both g4 and g3 configurations. In addition, there is a
> > > new "lane shared" table that needs to be configured for g4, along with
> > > the No-CSR list of resets.
> > 
> > Could you add a comment about the new nocsr reset and how it is used
> > here?
> >  
> > > Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > > 
> > > This patchset relies on the following patchset:
> > > https://lore.kernel.org/all/20230117224148.1914627-1-abel.vesa@linaro.org/
> > > 
> > > The v6 of this patch is:
> > > https://lore.kernel.org/all/20230202123902.3831491-9-abel.vesa@linaro.org/
> > > 
> > > Changes since v6:
> > >  * none
> > > 
> > > Changes since v5:
> > >  * renmaed the no-CSR reset to "phy_nocsr" as discussed off-list with
> > >    Bjorn and Johan
> > > 
> > > Changes since v4:
> > >  * dropped _serdes infix from ln_shrd table name and from every ln_shrd
> > >    variable name
> > >  * added hyphen between "no CSR" in both places
> > >  * dropped has_ln_shrd_serdes_tbl
> > >  * reordered qmp_pcie_offsets_v6_20 by struct members
> > >  * added rollback for no-CSR reset in qmp_pcie_init fail path
> > >  * moved ln_shrd offset calculation after port_b
> > > 
> > > Changes since v3:
> > >  * added Dmitry's R-b tag
> > > 
> > > Changes since v2:
> > >  * none
> > > 
> > > Changes since v1:
> > >  * split all the offsets into separate patches, like Vinod suggested
> > > 
> > > 
> > >  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 367 ++++++++++++++++++++++-
> > >  1 file changed, 365 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > > index 907f3f236f05..ff6c0b526fde 100644
> > > --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > > @@ -1506,6 +1506,234 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_ep_pcs_misc_tbl[] =
> > >  	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5, 0x08),
> > >  };
> > 
> [...]
> > 
> > >  
> > > @@ -2214,6 +2469,68 @@ static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
> > >  	.phy_status		= PHYSTATUS_4_20,
> > >  };
> > >  
> > > +static const struct qmp_phy_cfg sm8550_qmp_gen3x2_pciephy_cfg = {
> > > +	.lanes = 2,
> > > +
> > > +	.offsets		= &qmp_pcie_offsets_v5,
> > 
> > Did you really intend to use the v5 offsets here? It seems you use v6.20
> > defines in the tables below. This may work but it looks a little strange
> > and does not match how we name and use these resources for the other
> > SoCs (e.g. reusing structures and defines from older IP revisions is
> > fine, but not necessarily the other way round).
> 
> So here is what is happening here. The actual IP block version is 6 for
> the g3x2. The offsets of the tables are the same as on v5, but the
> actual offsets of some of the registers within those tables are
> entirely different. Now, if you compare the PCS PCIe offsets (v5 vs v6)
> you'll notice that all v6 registers currently added are the same as v5
> (both names and values). With that in mind, we still need to keep the v6
> offsets for the case when a new register, that might not be in v5, might
> be added later on. As for the table offsets, since they look the same we
> should probably not add a dedicated v6 one.

Ok, makes sense.

Johan
