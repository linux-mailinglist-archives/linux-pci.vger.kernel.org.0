Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A25A76A54B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 02:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjHAAAx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 20:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjHAAAw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 20:00:52 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A851F1726;
        Mon, 31 Jul 2023 17:00:50 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe0e23a4b1so8027395e87.3;
        Mon, 31 Jul 2023 17:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690848049; x=1691452849;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hr/EFJtKpxuy91SBRHvO09p/ziWuLvlFHdHn4b6TGy0=;
        b=OcavihvuVCZH6g7X7PGqJSAJDgtUZjwsn5BvjB9ZUHBTWuUTVQwoOrWEp897Ju8Jgd
         6v00ykgr7BBkqkPzvtkJPFqAjT4JgMtUSzYUljoVv9GmYxeU+0g+/FMa41PUDlHj7QS8
         pLnVUJs3KrT6unhaHeRA3kRZtX3N6UUzLtXcatV69tFRz/jtsa2JUOF1voIzIuxkWgNP
         qAkSbhVllHbQWTwru7KOO7xYHibJRcWyiO9tcnAP1aZRlODKfHmm0nMOk2SPT0NNBq2F
         zu2bLez4nYTkVlfDzSMZzm8AnIHj2c/ilip0pwM5eQqHoyGOKPF7AUT9gHxU9URi2Wb6
         Z/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690848049; x=1691452849;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hr/EFJtKpxuy91SBRHvO09p/ziWuLvlFHdHn4b6TGy0=;
        b=U9TIXQ3P9Uw7ecaIsAXOrTvImLc4O6xYQYHSJ/SYaLcALdNzaVk1Xi8f3ADchVJ6ko
         7KjEA0leJ1R7388dE9yX2Pct6v0VK5fRG0FpwR9dqmca1i1bI1I7NbZJ6rfU7irAkg2g
         b79/hq+ZnVP+Ruod8EHj6j4UCG3CaBre3N3IcrRYGJADTBNwEQ/UxMPLqKNtW8NJkypW
         V2q7mknmEi9+/Vvus4paeKvMgDgrIvLERAIW910fBkX4TtqpQ/uCX1dKFJdk+Z6ifxQo
         y0wDgtZmyaCEkOUhSeuQHK5Tj4RqkLpncaKBadi+fudez2EKsI9H9KbBgawMTl37vvCT
         57HA==
X-Gm-Message-State: ABy/qLb7mo5uKICbc0z8WgWp8DsNQTzNSOxOm8+wT5HywZJfR5Nnmsvn
        CxmhPFuM40NURMmes9tKFWw=
X-Google-Smtp-Source: APBJJlGU8xPDeVOY2BH2/WAysxWmVw/4FwmHNKvLcWutnZQG7mxAz3LjVl5KemXW2N5lfAe+zCNdmQ==
X-Received: by 2002:a19:6509:0:b0:4fd:fabf:b6ee with SMTP id z9-20020a196509000000b004fdfabfb6eemr813375lfb.9.1690848048739;
        Mon, 31 Jul 2023 17:00:48 -0700 (PDT)
Received: from mobilestation ([95.79.172.181])
        by smtp.gmail.com with ESMTPSA id a1-20020a19f801000000b004fb757bd429sm2108429lff.96.2023.07.31.17.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 17:00:48 -0700 (PDT)
Date:   Tue, 1 Aug 2023 03:00:46 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
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
Message-ID: <7utf36jc3v7kadsuxxf4tuvxrzlashu737jaalyprjj4w54rx6@2i2uqcknnvgb>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-10-yoshihiro.shimoda.uh@renesas.com>
 <20230724110344.GH6291@thinkpad>
 <TYBPR01MB534165847452C8A2398B03D9D800A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230728025119.GB4433@thinkpad>
 <TYBPR01MB534130DF2431F0A49E0C5C3BD806A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <2zv7mcxa7skywhxe2ene3c5ycine6tsmsfwmpf4nknhoeye7rx@m525r5ph3xow>
 <OSYPR01MB5334ACE9FCE20E92B7776919D805A@OSYPR01MB5334.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OSYPR01MB5334ACE9FCE20E92B7776919D805A@OSYPR01MB5334.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 31, 2023 at 01:15:02AM +0000, Yoshihiro Shimoda wrote:
> Hi Serge,
> 
> > From: Serge Semin, Sent: Saturday, July 29, 2023 1:07 AM
> > 
> > On Fri, Jul 28, 2023 at 04:19:38AM +0000, Yoshihiro Shimoda wrote:
> > > Hi Manivannan,
> > >
> > > > From: Manivannan Sadhasivam, Sent: Friday, July 28, 2023 11:51 AM
> > > >
> > > > On Wed, Jul 26, 2023 at 02:12:15AM +0000, Yoshihiro Shimoda wrote:
> > > > > Hi Manivannan,
> > > > >
> > > > > > From: Manivannan Sadhasivam, Sent: Monday, July 24, 2023 8:04 PM
> > > > > >
> > > > > > Subject should contain the word "missing". Like, "Add missing PCI_EXP_LNKCAP_MLW
> > > > > > handling".
> > > > >
> > > > > I got it.
> > > > >
> > > > > > On Fri, Jul 21, 2023 at 04:44:41PM +0900, Yoshihiro Shimoda wrote:
> > > > > > > Update dw_pcie_link_set_max_link_width() to set PCI_EXP_LNKCAP_MLW.
> > > > > > > In accordance with the DW PCIe RC/EP HW manuals [1,2,3,...] aside with
> > > > > > > the PORT_LINK_CTRL_OFF.LINK_CAPABLE and GEN2_CTRL_OFF.NUM_OF_LANES[8:0]
> > > > > > > field there is another one which needs to be updated. It's
> > > > > > > LINK_CAPABILITIES_REG.PCIE_CAP_MAX_LINK_WIDTH. If it isn't done at
> > > > > > > the very least the maximum link-width capability CSR won't expose
> > > > > > > the actual maximum capability.
> > > > > > >
> > > > > > > [1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
> > > > > > >     Version 4.60a, March 2015, p.1032
> > > > > > > [2] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
> > > > > > >     Version 4.70a, March 2016, p.1065
> > > > > > > [3] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
> > > > > > >     Version 4.90a, March 2016, p.1057
> > > > > > > ...
> > > > > > > [X] DesignWare Cores PCI Express Controller Databook - DWC PCIe Endpoint,
> > > > > > >       Version 5.40a, March 2019, p.1396
> > > > > > > [X+1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
> > > > > > >       Version 5.40a, March 2019, p.1266
> > > > > > >
> > > > > > > Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> > > > > >
> > > > > > Add Reported-by also?
> > > > >
> > > > > I don't think so because Serge suggested the commit description from my submitted patch [1].
> > > > >
> > > > > [1]
> > > > >
> > > <snip URL>
> > > > >
> > > >
> > > > Fine then.
> > > >
> > > > > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > > >
> > > > > > This looks like a potential bug fix to me. So please move this change before the
> > > > > > previous patch that introduces dw_pcie_link_set_max_link_width(), tag fixes and
> > > > > > CC stable list for backporting.
> > > > >
> > > > > I think that this patch should be a next branch because this is possible to
> > > > > cause side effective. Almost all drivers/pcie/controller/dwc/ host drivers except
> > > > > pcie-tegra194.c doesn't have this setting, but I assume that the drivers work correctly
> > > > > without this setting.
> > > > >
> > > > > Also, to be honest, I could not find a suitable commit ID for this patch's "Fixes" tag.
> > > > > Additionally, I could not determine which old kernel versions should have this patch
> > > > > applied as backporting.
> > > > >
> > > >
> > 
> > > > Ok. But you can still move this patch as I suggested. If we happen to hit any
> > > > issue with this setting, then we can easily revert it.
> > >
> > > I got it. I'll move this patch as you suggested.
> > 
> > No. By moving this patch to be implemented before the patch:
> > [PATCH v18 08/20] PCI: dwc: Add dw_pcie_link_set_max_link_width()
> > you won't be able to easily revert it afterwards because the patch #8
> > will move the code added by the patch #9 to the
> > dw_pcie_link_set_max_link_width() function. Basically you suggest to
> > switch the preparation and functional patches order which doesn't look
> > right.
> 
> You're correct. If moving this patch to the top of this series and then
> still apply the original #8, it's difficult to revert this patch.
> 
> > Basically the Link-width-related part of this series currently implies
> > the next logic:
> > 
> > 1. Prepare the DW PCIe core driver to implementing a comprehensive
> > Max-link-width setup methods (aka as it's done in
> > dw_pcie_link_set_max_speed()) by moving the Link-width related code to
> > a dedicated method:
> > [PATCH v18 08/20] PCI: dwc: Add dw_pcie_link_set_max_link_width()
> > 
> > 2. Add the PCI_EXP_LNKCAP_MLW field update, which
> > dw_pcie_link_set_max_link_width() lacks to be comprehensive:
> > [PATCH v18 09/20] PCI: dwc: Add PCI_EXP_LNKCAP_MLW handling
> > 
> > 3. Drop the duplicating code from the Tegra194 PCIe driver:
> > [PATCH v18 10/20] PCI: tegra194: Drop PCI_EXP_LNKSTA_NLW setting
> 
> Yes.
> 
> > In case if the patch #9 appears to be a bug fix, then it will need to
> > be backported together with patch #8 which isn't a problem at all
> > (though it's doubtfully to happen since nobody reported any problem
> > with that so far).
> 
> Basically, I don't think that backporting #8 is good as backport because
> the #8 patch is a clean up code for readability.
> 
> > But if patch #9 turns out to break something in
> > current circumstances we'll be able to either easily revert it (since
> > it's applied after the preparation patch) or fix somehow. If you
> > switch patch #8 and #9 order, the reversion will require to be
> > performed for both these patches to avoid the conflicts. Thus I'd
> > suggest to leave the patches order as is which looks more natural and
> > won't cause any problems to revert the functional change or to
> > backport it.
> 
> To follow Manivannan's suggestion and your comments, I'm thinking that
> - drop the #8 because this is just clean up code for readability.
> -- After this patch series is merged and worked correctly without any
>    regression on other platforms, we can apply the #8.
> - move the #9 to the top of this series as Manivannan suggested.
> -- This mean adding this code into dw_pcie_setup().
> 
> But, what do you think?

No. It's better to leave the preparation patch and the order as is.
Once again this patch doesn't look as a bug-fix since nobody reported
any related problem so far. If anyone decides to back it port there
won't a problem with porting both #8 and #9. It's a common practice.

-Serge(y)

> 
> Best regards,
> Yoshihiro Shimoda
> 
> > -Serge(y)
> > 
> > >
> > > Best regards,
> > > Yoshihiro Shimoda
> > >
> > > > - Mani
> > > >
> > > > > Best regards,
> > > > > Yoshihiro Shimoda
> > > > >
> > > > > > - Mani
> > > > > >
> > > > > > > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > > > > > > ---
> > > > > > >  drivers/pci/controller/dwc/pcie-designware.c | 9 ++++++++-
> > > > > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > > index 5cca34140d2a..c4998194fe74 100644
> > > > > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > > @@ -730,7 +730,8 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
> > > > > > >
> > > > > > >  static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
> > > > > > >  {
> > > > > > > -	u32 lwsc, plc;
> > > > > > > +	u32 lnkcap, lwsc, plc;
> > > > > > > +	u8 cap;
> > > > > > >
> > > > > > >  	if (!num_lanes)
> > > > > > >  		return;
> > > > > > > @@ -766,6 +767,12 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
> > > > > > >  	}
> > > > > > >  	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc);
> > > > > > >  	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, lwsc);
> > > > > > > +
> > > > > > > +	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > > > > > > +	lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
> > > > > > > +	lnkcap &= ~PCI_EXP_LNKCAP_MLW;
> > > > > > > +	lnkcap |= FIELD_PREP(PCI_EXP_LNKCAP_MLW, num_lanes);
> > > > > > > +	dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, lnkcap);
> > > > > > >  }
> > > > > > >
> > > > > > >  void dw_pcie_iatu_detect(struct dw_pcie *pci)
> > > > > > > --
> > > > > > > 2.25.1
> > > > > > >
> > > > > >
> > > > > > --
> > > > > > மணிவண்ணன் சதாசிவம்
> > > >
> > > > --
> > > > மணிவண்ணன் சதாசிவம்
