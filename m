Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73B6471117
	for <lists+linux-pci@lfdr.de>; Sat, 11 Dec 2021 04:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244505AbhLKDLb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 22:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244455AbhLKDLa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 22:11:30 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD97C061746
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 19:07:54 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id k6-20020a17090a7f0600b001ad9d73b20bso9047377pjl.3
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 19:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oz4rGmnSY/U0D1W4bE3rbc97m3xSWZffnTKmM/3z2Ag=;
        b=Zs+qTA+X2niuPQc3jq01NdOSFfAczRKys2TQkRCs/e64Fq2XlMkfBv7H5PZn9SpKE1
         6Y3+jNwv0AiARdtypJ/cigsJK9EwdBB4XDko2WKqLBBcK7XrXUX6dBAUbnLw60TPbNUC
         Z6tlxWcdyh4UjJ69fmwgIfsqaNf2SSMYEkvl7LBRUKh2Qn7k0sp409grJZEhXDrdMPzk
         D/ymGWp0KCD7/s+efdETQmKHdsVtO/PRz+OWLuzF2/zixxq5uRR4d50pLHyT+9i5/TnX
         JrLSA3l9lGlBDgGteBhBil/Z0Gb2VFyTBBBSVV8DVo2SSVnwLLPo/5diM0IdwDCYYorB
         Nzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oz4rGmnSY/U0D1W4bE3rbc97m3xSWZffnTKmM/3z2Ag=;
        b=cefezap2VR8b35JAF09F6O+7BM/5kIteSxWVDURYFH2I9vXOFBQQZpaj8pScxu8c8J
         qoTinTJ7AezcBzQMgcs9UGW1CpZsT0Z2eTi61Yk3Ebs8/TAM3LluJ6U4FnhujRypW7OV
         t6na132u69Cc8Y4kzbWw18NqZw0V25NE/FMPxqRg9g45ZNfcLavQO8f8VIsib2G2TVbZ
         8SK0yeW8NNgCFll1OZ7//Q7KhDmJZ7MfaO9ow0+Z+CiCMIakDEokQEYzUcFzgvO3PJuZ
         F4NGCmf+HVlczzHPGHcoUA+3cs2TtX7WpuP+exDylIj4y8g1IfF3jufqdfjoYfHypu2b
         spMg==
X-Gm-Message-State: AOAM532Kj9JKMycXHq5c6Y1w+mUYst0dHBnRRT0my2P5/wOpBXMz8xtC
        Xxjh79AIsOSS6PcfRqtC0bdE
X-Google-Smtp-Source: ABdhPJxliJiccVKf26Fz5gWrn1TSho7W1A233c2UC574RlzazDU0ncYDSJsrMlskJXR+sr3pypl8Sw==
X-Received: by 2002:a17:90b:2502:: with SMTP id ns2mr28167086pjb.51.1639192073774;
        Fri, 10 Dec 2021 19:07:53 -0800 (PST)
Received: from workstation ([202.21.42.75])
        by smtp.gmail.com with ESMTPSA id q190sm1018085pgq.38.2021.12.10.19.07.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Dec 2021 19:07:53 -0800 (PST)
Date:   Sat, 11 Dec 2021 08:37:48 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v2 06/10] PCI: qcom: Add SM8450 PCIe support
Message-ID: <20211211030748.GA21304@workstation>
References: <20211208171442.1327689-1-dmitry.baryshkov@linaro.org>
 <20211208171442.1327689-7-dmitry.baryshkov@linaro.org>
 <20211210113031.GF1734@thinkpad>
 <8d6c224b-b854-8d0e-8437-366b72dd4a83@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d6c224b-b854-8d0e-8437-366b72dd4a83@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Dec 11, 2021 at 05:01:01AM +0300, Dmitry Baryshkov wrote:
> On 10/12/2021 14:30, Manivannan Sadhasivam wrote:
> > On Wed, Dec 08, 2021 at 08:14:38PM +0300, Dmitry Baryshkov wrote:
> > > On SM8450 platform PCIe hosts do not use all the clocks (and add several
> > > additional clocks), so expand the driver to handle these requirements.
> > > 
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-qcom.c | 47 +++++++++++++++++++-------
> > >   1 file changed, 34 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index 803d3ac18c56..ada9c816395d 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -161,7 +161,7 @@ struct qcom_pcie_resources_2_3_3 {
> > >   /* 6 clocks typically, 7 for sm8250 */
> > >   struct qcom_pcie_resources_2_7_0 {
> > > -	struct clk_bulk_data clks[7];
> > > +	struct clk_bulk_data clks[9];
> > >   	int num_clks;
> > >   	struct regulator_bulk_data supplies[2];
> > >   	struct reset_control *pci_reset;
> > > @@ -196,7 +196,10 @@ struct qcom_pcie_cfg {
> > >   	const struct qcom_pcie_ops *ops;
> > >   	/* flags for ops 2.7.0 and 1.9.0 */
> > >   	unsigned int pipe_clk_need_muxing:1;
> > > +	unsigned int has_tbu_clk:1;
> > >   	unsigned int has_ddrss_sf_tbu_clk:1;
> > > +	unsigned int has_aggre0_clk:1;
> > > +	unsigned int has_aggre1_clk:1;
> > >   };
> > >   struct qcom_pcie {
> > > @@ -1147,6 +1150,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
> > >   	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> > >   	struct dw_pcie *pci = pcie->pci;
> > >   	struct device *dev = pci->dev;
> > > +	unsigned int idx;
> > 
> > u32?
> 
> Why? it's just a counter.
> 

Yeah but IMO using the kernel defined datatype is mostly preferred. This
is not touching any MMIO but still it is a good practice.

> > 
> > >   	int ret;
> > >   	res->pci_reset = devm_reset_control_get_exclusive(dev, "pci");
> > > @@ -1160,18 +1164,22 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
> > >   	if (ret)
> > >   		return ret;
> > > -	res->clks[0].id = "aux";
> > > -	res->clks[1].id = "cfg";
> > > -	res->clks[2].id = "bus_master";
> > > -	res->clks[3].id = "bus_slave";
> > > -	res->clks[4].id = "slave_q2a";
> > > -	res->clks[5].id = "tbu";
> > > -	if (pcie->cfg->has_ddrss_sf_tbu_clk) {
> > > -		res->clks[6].id = "ddrss_sf_tbu";
> > > -		res->num_clks = 7;
> > > -	} else {
> > > -		res->num_clks = 6;
> > > -	}
> > > +	idx = 0;
> > > +	res->clks[idx++].id = "aux";
> > > +	res->clks[idx++].id = "cfg";
> > > +	res->clks[idx++].id = "bus_master";
> > > +	res->clks[idx++].id = "bus_slave";
> > > +	res->clks[idx++].id = "slave_q2a";
> > > +	if (pcie->cfg->has_tbu_clk)
> > > +		res->clks[idx++].id = "tbu";
> > > +	if (pcie->cfg->has_ddrss_sf_tbu_clk)
> > > +		res->clks[idx++].id = "ddrss_sf_tbu";
> > > +	if (pcie->cfg->has_aggre0_clk)
> > > +		res->clks[idx++].id = "aggre0";
> > > +	if (pcie->cfg->has_aggre1_clk)
> > > +		res->clks[idx++].id = "aggre1";
> > > +
> > > +	res->num_clks = idx;
> > 
> > res->num_clks = idx + 1?
> 
> No. the idx is equal to the amount of clocks we added to the array, so this
> is correct.
> 

Oops, brain fade. Sorry, the usual post-increment confusion :) Ignore my
comment.

Thanks,
Mani

> > 
> > Thanks,
> > Mani
> > 
> > >   	ret = devm_clk_bulk_get(dev, res->num_clks, res->clks);
> > >   	if (ret < 0)
> > > @@ -1510,15 +1518,27 @@ static const struct qcom_pcie_cfg ipq4019_cfg = {
> > >   static const struct qcom_pcie_cfg sdm845_cfg = {
> > >   	.ops = &ops_2_7_0,
> > > +	.has_tbu_clk = true,
> > >   };
> > >   static const struct qcom_pcie_cfg sm8250_cfg = {
> > >   	.ops = &ops_1_9_0,
> > > +	.has_tbu_clk = true,
> > >   	.has_ddrss_sf_tbu_clk = true,
> > >   };
> > > +/* Only for the PCIe0! */
> > > +static const struct qcom_pcie_cfg sm8450_cfg = {
> > > +	.ops = &ops_1_9_0,
> > > +	.has_ddrss_sf_tbu_clk = true,
> > > +	.pipe_clk_need_muxing = true,
> > > +	.has_aggre0_clk = true,
> > > +	.has_aggre1_clk = true,
> > > +};
> > > +
> > >   static const struct qcom_pcie_cfg sc7280_cfg = {
> > >   	.ops = &ops_1_9_0,
> > > +	.has_tbu_clk = true,
> > >   	.pipe_clk_need_muxing = true,
> > >   };
> > > @@ -1626,6 +1646,7 @@ static const struct of_device_id qcom_pcie_match[] = {
> > >   	{ .compatible = "qcom,pcie-sdm845", .data = &sdm845_cfg },
> > >   	{ .compatible = "qcom,pcie-sm8250", .data = &sm8250_cfg },
> > >   	{ .compatible = "qcom,pcie-sc8180x", .data = &sm8250_cfg },
> > > +	{ .compatible = "qcom,pcie-sm8450", .data = &sm8450_cfg },
> > >   	{ .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },
> > >   	{ }
> > >   };
> > > -- 
> > > 2.33.0
> > > 
> 
> 
> -- 
> With best wishes
> Dmitry
