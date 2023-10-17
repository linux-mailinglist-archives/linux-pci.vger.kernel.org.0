Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BF77CBD36
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 10:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjJQIRp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 04:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQIRo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 04:17:44 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55EB93
        for <linux-pci@vger.kernel.org>; Tue, 17 Oct 2023 01:17:39 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27dc1e4d8b6so163845a91.0
        for <linux-pci@vger.kernel.org>; Tue, 17 Oct 2023 01:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697530659; x=1698135459; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+LlVnjovZQKa7NrShhm24YzALCz3Jiaz+eKNaJ3ulnM=;
        b=e4HO1JKq0DmPe2V97LDtLqxV3RDe7zYZN680NN/ZGQvNeAPnDo5TMzzuUrWQbp/fZP
         XqPpo0ZHyCwJVvUOSNJ8vQjaCBSpIATYaBkvQWppi9csNN3+kVtfID1gEH6FRIhb2nJ1
         cDDHFqsnKFvzj2Bw3Dhg9i0HALMb5ahIR+c+HzUjQGQpKOMo5QBazCoN0ZPpnErPb8eP
         a4T3YOlu+RCI2dIlUT/hG+dYJu7BodvOrLyE//Uf1Bkmqru4GtZcjSw0BQ3cf5VaUWyS
         EVl7mKQfG4kaR7bPAZprkBqqQynwIEOghAMnpkTHfzAZDgW6RzojnAExT7F4+7D/YFJr
         IC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697530659; x=1698135459;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+LlVnjovZQKa7NrShhm24YzALCz3Jiaz+eKNaJ3ulnM=;
        b=Zh4suPfFlxF8GTcJ+TkGpNhEMOODG0mkAhnGBhB0+K3c3NVt191LCXH64TQW2dp/E9
         Bq/c3xt+QXi1N2FIASkpM2misGA4kyZ0Sqj92Xam4vae3uyvdy9hHFetguX1Zc1Pr/X1
         tmehbe36LN480pbkfrNh6oqAlhkc7z9KlwbdILtTNjWlCkF2EievaTTiS563RkU2bvmy
         IlvQrIedMXKWHu57VRJmE9UdC+X8l6zNgpgao4ULnhfnEnZkjb2EK3au+LUYr3jPkLTx
         UQk8od9FUAXT/aCRQkNwYw/LTfzpE0eJHZGOQuFpGMr5w1/7c/yigKhuManU8K2hJaN2
         Whng==
X-Gm-Message-State: AOJu0YzZtDqfpbVxniNnoxkDAURosRBe/du5SVU4wm2bIjQU7yT41ORC
        SRen9wG9VKPs7b4ytCv51QfA
X-Google-Smtp-Source: AGHT+IFJ+XwjBNsHb401tnImJrgO8tIl7GAykVmzgDpD/pNzSxKnSUYd1c7yondYd4ensK7UNVBRzA==
X-Received: by 2002:a17:90a:d98d:b0:261:685:95b6 with SMTP id d13-20020a17090ad98d00b00261068595b6mr1492510pjv.13.1697530659344;
        Tue, 17 Oct 2023 01:17:39 -0700 (PDT)
Received: from thinkpad ([117.207.31.199])
        by smtp.gmail.com with ESMTPSA id h16-20020a17090adb9000b002791d5a3e29sm769640pjv.6.2023.10.17.01.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 01:17:38 -0700 (PDT)
Date:   Tue, 17 Oct 2023 13:47:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.li@nxp.com>
Cc:     Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linuxppc-dev@lists.ozlabs.org>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-pci@vger.kernel.org>,
        "moderated list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 2/3] PCI: layerscape: add suspend/resume for ls1021a
Message-ID: <20231017081731.GD5274@thinkpad>
References: <20230915184306.2374670-1-Frank.Li@nxp.com>
 <20230915184306.2374670-2-Frank.Li@nxp.com>
 <20231016165824.GF39962@thinkpad>
 <ZS2anCpWakttzaAu@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZS2anCpWakttzaAu@lizhi-Precision-Tower-5810>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 16, 2023 at 04:18:36PM -0400, Frank Li wrote:
> On Mon, Oct 16, 2023 at 10:28:24PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Sep 15, 2023 at 02:43:05PM -0400, Frank Li wrote:
> > > ls1021a add suspend/resume support.
> > > 
> > 
> > Please add what the driver is doing during suspend/resume.
> > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  drivers/pci/controller/dwc/pci-layerscape.c | 88 ++++++++++++++++++++-
> > >  1 file changed, 87 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> > > index 20c48c06e2248..bc5a8ff1a26ce 100644
> > > --- a/drivers/pci/controller/dwc/pci-layerscape.c
> > > +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> > > @@ -35,6 +35,12 @@
> > >  #define PF_MCR_PTOMR		BIT(0)
> > >  #define PF_MCR_EXL2S		BIT(1)
> > >  
> > > +/* LS1021A PEXn PM Write Control Register */
> > > +#define SCFG_PEXPMWRCR(idx)	(0x5c + (idx) * 0x64)
> > > +#define PMXMTTURNOFF		BIT(31)
> > > +#define SCFG_PEXSFTRSTCR	0x190
> > > +#define PEXSR(idx)		BIT(idx)
> > > +
> > >  #define PCIE_IATU_NUM		6
> > >  
> > >  struct ls_pcie_drvdata {
> > > @@ -48,6 +54,8 @@ struct ls_pcie {
> > >  	struct dw_pcie *pci;
> > >  	const struct ls_pcie_drvdata *drvdata;
> > >  	void __iomem *pf_base;
> > > +	struct regmap *scfg;
> > > +	int index;
> > >  	bool big_endian;
> > >  };
> > >  
> > > @@ -170,13 +178,91 @@ static int ls_pcie_host_init(struct dw_pcie_rp *pp)
> > >  	return 0;
> > >  }
> > >  
> > > +static void ls1021a_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
> > > +{
> > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > +	struct ls_pcie *pcie = to_ls_pcie(pci);
> > > +	u32 val;
> > > +
> > > +	if (!pcie->scfg) {
> > 
> > Can this ever happen?
> > 
> > > +		dev_dbg(pcie->pci->dev, "SYSCFG is NULL\n");
> > > +		return;
> > > +	}
> > > +
> > > +	/* Send Turn_off message */
> > 
> > "Send PME_Turn_Off message"
> > 
> > > +	regmap_read(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), &val);
> > > +	val |= PMXMTTURNOFF;
> > > +	regmap_write(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), val);
> > > +
> > > +	/* There are not register to check ACK, so wait PCIE_PME_TO_L2_TIMEOUT_US */
> > 
> > "There is no specific register to check for PME_To_Ack from endpoint. So on the
> > safe side, wait for PCIE_PME_TO_L2_TIMEOUT_US."
> > 
> > > +	mdelay(PCIE_PME_TO_L2_TIMEOUT_US/1000);
> > > +
> > > +	/* Clear Turn_off message */
> > 
> > "PME_Turn_off". But I'm not sure if this is really required. Are you doing it
> > because the layerspace hw implements the PME_Turn_Off bit as "level triggered"?
> 
> I am not sure how hardware implement this. But reference manual said:
>  
> PMXMTTURNOFF:
> Generate PM turnoff message for power management of PCI Express controllers.
> This bit should be cleared by software.
> 0 Clear PM turnoff (default)
> 1 Trigger PM turnoff
> 

Hmm, okay. Atleast add the below comment to make it understandable in the
future:

"Layerscape hardware reference manual recommends clearing the PMXMTTURNOFF bit
to complete the PME_Turn_Off handshake."

- Mani

> Frank
> 
> > 
> > > +	regmap_read(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), &val);
> > > +	val &= ~PMXMTTURNOFF;
> > > +	regmap_write(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), val);
> > > +}
> > > +
> > > +static void ls1021a_pcie_exit_from_l2(struct dw_pcie_rp *pp)
> > > +{
> > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > +	struct ls_pcie *pcie = to_ls_pcie(pci);
> > > +	u32 val;
> > > +
> > 
> > A comment here would be good.
> > 
> > > +	regmap_read(pcie->scfg, SCFG_PEXSFTRSTCR, &val);
> > > +	val |= PEXSR(pcie->index);
> > > +	regmap_write(pcie->scfg, SCFG_PEXSFTRSTCR, val);
> > > +
> > > +	regmap_read(pcie->scfg, SCFG_PEXSFTRSTCR, &val);
> > > +	val &= ~PEXSR(pcie->index);
> > > +	regmap_write(pcie->scfg, SCFG_PEXSFTRSTCR, val);
> > > +}
> > > +
> > > +static int ls1021a_pcie_host_init(struct dw_pcie_rp *pp)
> > > +{
> > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > +	struct ls_pcie *pcie = to_ls_pcie(pci);
> > > +	struct device *dev = pcie->pci->dev;
> > > +	u32 index[2];
> > > +	int ret;
> > > +
> > > +	ret = ls_pcie_host_init(pp);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	pcie->scfg = syscon_regmap_lookup_by_phandle(dev->of_node, "fsl,pcie-scfg");
> > > +	if (IS_ERR(pcie->scfg)) {
> > > +		ret = PTR_ERR(pcie->scfg);
> > > +		dev_err(dev, "No syscfg phandle specified\n");
> > > +		pcie->scfg = NULL;
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = of_property_read_u32_array(dev->of_node, "fsl,pcie-scfg", index, 2);
> > > +	if (ret) {
> > > +		pcie->scfg = NULL;
> > > +		return ret;
> > > +	}
> > > +
> > > +	pcie->index = index[1];
> > > +
> > 
> > The above syscon parsing could be done conditionally during probe itself. There
> > is no need to do it during host_init() time.
> > 
> > - Mani
> > 
> > > +	return ret;
> > > +}
> > > +
> > >  static const struct dw_pcie_host_ops ls_pcie_host_ops = {
> > >  	.host_init = ls_pcie_host_init,
> > >  	.pme_turn_off = ls_pcie_send_turnoff_msg,
> > >  };
> > >  
> > > +static const struct dw_pcie_host_ops ls1021a_pcie_host_ops = {
> > > +	.host_init = ls1021a_pcie_host_init,
> > > +	.pme_turn_off = ls1021a_pcie_send_turnoff_msg,
> > > +};
> > > +
> > >  static const struct ls_pcie_drvdata ls1021a_drvdata = {
> > > -	.pm_support = false,
> > > +	.pm_support = true,
> > > +	.ops = &ls1021a_pcie_host_ops,
> > > +	.exit_from_l2 = ls1021a_pcie_exit_from_l2,
> > >  };
> > >  
> > >  static const struct ls_pcie_drvdata layerscape_drvdata = {
> > > -- 
> > > 2.34.1
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
