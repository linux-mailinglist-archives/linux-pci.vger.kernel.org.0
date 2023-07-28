Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2201766215
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 04:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjG1Cva (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jul 2023 22:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjG1Cv3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jul 2023 22:51:29 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEFC30DA
        for <linux-pci@vger.kernel.org>; Thu, 27 Jul 2023 19:51:26 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d0e55215aebso1630128276.1
        for <linux-pci@vger.kernel.org>; Thu, 27 Jul 2023 19:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690512685; x=1691117485;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h7X8L6p589ll7Zf62DX6c/G8of71ByjuSRxlGh0J6TA=;
        b=lY4GoB42VcQZ6vSgsNZF8Xw2gPFjDwQ8i3lvCWNm37uhUsak6UeJ/iQseTiNTWDWj4
         5wYkYT+Vl5jKoOQRGBdJeKLvVt9aHh4LmL9Hg8lfEZopklR6eX0g40sKcizfNFrtboX6
         Qy/h6sTMxBHQ3N6knfygwSRUPLx+ZbaQJwhQQZa9bvzj0ty6nSSXACdjPCiGFJjnEGu8
         zzJxvWX0EvFPKN3ixy1PlMfoccIqg1nv34qfMWm0I3Wx7SBa/wgdc4zoPrpA31eToxkb
         aqoNFk8wxX1tFz6epmW5JhVQzRdPqgCuwH44Y+3jhFLXxaD1is41ZUrszABtAcejzeB+
         tWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690512685; x=1691117485;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7X8L6p589ll7Zf62DX6c/G8of71ByjuSRxlGh0J6TA=;
        b=H29eLlGExfADxKWx96tvOybuFvzpJJSXZCjd1KqOloFOCEjuff9LbDRR5Geeyl/Z1K
         e94nyzhrU1pAiWnpIcYbfbxdQO0/aDjN2mPm0ReyIYmSlJt2DVzce8MTwYcd6uGXhe4J
         LcOt0KZgVo9JsrOjctOKwyxdy1D6SL1QEyJtzUcS7CK0P3RTUg8LB5AGqBdOGfo3lq4M
         ACv4Ky1AJ3Z7eLIxZr/JMTxwONAhWMmLnLgPPySicwCvSzAAl2483IvAkgglPBx6+3Ww
         kS/5zQ+XU3m2fPZ098knDOVC4FwuNDb+nSE2og7p3o50r1cOm1Otk6zsIPi32EbDxTWB
         t4BQ==
X-Gm-Message-State: ABy/qLbS04ryCrGceDn2aGkVnhjzoBa0exs+ZBTtlHDU3Lb3ha2cRRbo
        5R9Tou1fS5flIEfrHexK1Fba
X-Google-Smtp-Source: APBJJlFK94mxYcpwPCLn92HIZF7pozKl6uao3GoE0MCGD58qITbFGEIRf6y5Jr/s7f4Tw9Nf8klcpw==
X-Received: by 2002:a25:3615:0:b0:c61:a1a8:d0b3 with SMTP id d21-20020a253615000000b00c61a1a8d0b3mr566790yba.53.1690512684837;
        Thu, 27 Jul 2023 19:51:24 -0700 (PDT)
Received: from thinkpad ([2405:201:e002:907b:3cd6:46d1:3de:9a66])
        by smtp.gmail.com with ESMTPSA id a18-20020a62bd12000000b0067acbc74977sm2198206pff.96.2023.07.27.19.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 19:51:24 -0700 (PDT)
Date:   Fri, 28 Jul 2023 08:21:19 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
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
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v18 09/20] PCI: dwc: Add PCI_EXP_LNKCAP_MLW handling
Message-ID: <20230728025119.GB4433@thinkpad>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-10-yoshihiro.shimoda.uh@renesas.com>
 <20230724110344.GH6291@thinkpad>
 <TYBPR01MB534165847452C8A2398B03D9D800A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYBPR01MB534165847452C8A2398B03D9D800A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 26, 2023 at 02:12:15AM +0000, Yoshihiro Shimoda wrote:
> Hi Manivannan,
> 
> > From: Manivannan Sadhasivam, Sent: Monday, July 24, 2023 8:04 PM
> > 
> > Subject should contain the word "missing". Like, "Add missing PCI_EXP_LNKCAP_MLW
> > handling".
> 
> I got it.
> 
> > On Fri, Jul 21, 2023 at 04:44:41PM +0900, Yoshihiro Shimoda wrote:
> > > Update dw_pcie_link_set_max_link_width() to set PCI_EXP_LNKCAP_MLW.
> > > In accordance with the DW PCIe RC/EP HW manuals [1,2,3,...] aside with
> > > the PORT_LINK_CTRL_OFF.LINK_CAPABLE and GEN2_CTRL_OFF.NUM_OF_LANES[8:0]
> > > field there is another one which needs to be updated. It's
> > > LINK_CAPABILITIES_REG.PCIE_CAP_MAX_LINK_WIDTH. If it isn't done at
> > > the very least the maximum link-width capability CSR won't expose
> > > the actual maximum capability.
> > >
> > > [1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
> > >     Version 4.60a, March 2015, p.1032
> > > [2] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
> > >     Version 4.70a, March 2016, p.1065
> > > [3] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
> > >     Version 4.90a, March 2016, p.1057
> > > ...
> > > [X] DesignWare Cores PCI Express Controller Databook - DWC PCIe Endpoint,
> > >       Version 5.40a, March 2019, p.1396
> > > [X+1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
> > >       Version 5.40a, March 2019, p.1266
> > >
> > > Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> > 
> > Add Reported-by also?
> 
> I don't think so because Serge suggested the commit description from my submitted patch [1].
> 
> [1]
> https://lore.kernel.org/linux-pci/20230322065701.po7owyzwisntalyz@mobilestation/
> 

Fine then.

> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > 
> > This looks like a potential bug fix to me. So please move this change before the
> > previous patch that introduces dw_pcie_link_set_max_link_width(), tag fixes and
> > CC stable list for backporting.
> 
> I think that this patch should be a next branch because this is possible to
> cause side effective. Almost all drivers/pcie/controller/dwc/ host drivers except
> pcie-tegra194.c doesn't have this setting, but I assume that the drivers work correctly
> without this setting.
> 
> Also, to be honest, I could not find a suitable commit ID for this patch's "Fixes" tag.
> Additionally, I could not determine which old kernel versions should have this patch
> applied as backporting.
> 

Ok. But you can still move this patch as I suggested. If we happen to hit any
issue with this setting, then we can easily revert it.

- Mani

> Best regards,
> Yoshihiro Shimoda
> 
> > - Mani
> > 
> > > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index 5cca34140d2a..c4998194fe74 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -730,7 +730,8 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
> > >
> > >  static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
> > >  {
> > > -	u32 lwsc, plc;
> > > +	u32 lnkcap, lwsc, plc;
> > > +	u8 cap;
> > >
> > >  	if (!num_lanes)
> > >  		return;
> > > @@ -766,6 +767,12 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
> > >  	}
> > >  	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc);
> > >  	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, lwsc);
> > > +
> > > +	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > > +	lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
> > > +	lnkcap &= ~PCI_EXP_LNKCAP_MLW;
> > > +	lnkcap |= FIELD_PREP(PCI_EXP_LNKCAP_MLW, num_lanes);
> > > +	dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, lnkcap);
> > >  }
> > >
> > >  void dw_pcie_iatu_detect(struct dw_pcie *pci)
> > > --
> > > 2.25.1
> > >
> > 
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
