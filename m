Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22DE02D304
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2019 02:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfE2A64 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 May 2019 20:58:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35030 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfE2A6z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 May 2019 20:58:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id p1so276551plo.2
        for <linux-pci@vger.kernel.org>; Tue, 28 May 2019 17:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dB5GfLc57cH6bwtQrAmsQw+qYEcHdnY9B3siLBUP8uk=;
        b=tLFATLFYr4475dDD6gdRPblwkVp37ut14jAhMGAKgDqy/FEKqbNCpymi8UgGLXX0yc
         ubeAhI9iPxmQHwjCNZ91dSqb3zokbVjGyh1avWonTN/AdxsPbQov+N9nBdITLIN30V6W
         dnkWfainrxBlolQas37BhgY0HEx9GJ1wYUlFvPhEjPJycBTTMPXXQFwZJDn54kw2i4fK
         A5dHihK96brpHAlFxR+FCRKmGnzSlDcq1vTQHIaJpJovkwOXj0CvmsJEanudE0DxjPDc
         sUzR+c6lF/pOuJgirMBTDNB9FEWj+Bh8/RMQNjHT06KfX0Oz7bTPxMXdGt5P8VELGzQP
         bvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dB5GfLc57cH6bwtQrAmsQw+qYEcHdnY9B3siLBUP8uk=;
        b=UQJvjw0qJlEEgpMQHFMr7GGoVHPW0kMhihyRlbQPvo2Q9fNyEfYimi4tZ+T0HkwYgD
         BJ77n2EfP75RlBhsv289iWVs8CydVZ8uhcL1m/VIUDgwSqIaTDhazMQ64+8gjpRqE3gz
         9c/tbHCiiyEc/1glPtSuwjWI1UiYpoZq36LQ8wuXPkpHuyeKkGWBitJUSIDVNH61T0sg
         CWxcZ4hAnnm3Wuka4t9PBEHkMJGyax4VwIiobAXdpzneTuohhd9ouRUUutQDOjv7FJoQ
         tm2q+lP8FIhOrc9Zh9wt3HgVeUBuVtmHlfPLCOhqjI94jnRI4YBsYuCzUBLXEPzGeTBR
         2UBQ==
X-Gm-Message-State: APjAAAVJfyCL8zouhSOtUQnFz8TvPGbORMp6lyS5jO/HWSZF1m3YWjNN
        6SFh4LaCfT9MitZzt/s/qbiJlw==
X-Google-Smtp-Source: APXvYqwxh6jDK5DVOgkaZM5rVzp3+LyBXrFZZTjYOOYOzEtNmwHBrNbU2n5KLBLmmwYvFxPSAjRXeQ==
X-Received: by 2002:a17:902:704a:: with SMTP id h10mr47656719plt.294.1559091535018;
        Tue, 28 May 2019 17:58:55 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z4sm16431588pfa.142.2019.05.28.17.58.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 17:58:53 -0700 (PDT)
Date:   Tue, 28 May 2019 17:58:51 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] PCI: qcom: Use clk_bulk API for 2.4.0 controllers
Message-ID: <20190529005851.GA3923@builder>
References: <20190502001955.10575-1-bjorn.andersson@linaro.org>
 <20190502001955.10575-2-bjorn.andersson@linaro.org>
 <fcfcd3b4-99d2-7b10-e82d-b92e6bf37a33@mm-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcfcd3b4-99d2-7b10-e82d-b92e6bf37a33@mm-sol.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu 16 May 02:14 PDT 2019, Stanimir Varbanov wrote:

> Hi Bjorn,
> 
> On 5/2/19 3:19 AM, Bjorn Andersson wrote:
> > Before introducing the QCS404 platform, which uses the same PCIe
> > controller as IPQ4019, migrate this to use the bulk clock API, in order
> > to make the error paths slighly cleaner.
> > 
> > Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>
> > Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > Changes since v2:
> > - Defined QCOM_PCIE_2_4_0_MAX_CLOCKS
> > 
> >  drivers/pci/controller/dwc/pcie-qcom.c | 49 ++++++++------------------
> >  1 file changed, 14 insertions(+), 35 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 0ed235d560e3..d740cbe0e56d 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -112,10 +112,10 @@ struct qcom_pcie_resources_2_3_2 {
> >  	struct regulator_bulk_data supplies[QCOM_PCIE_2_3_2_MAX_SUPPLY];
> >  };
> >  
> > +#define QCOM_PCIE_2_4_0_MAX_CLOCKS	3
> >  struct qcom_pcie_resources_2_4_0 {
> > -	struct clk *aux_clk;
> > -	struct clk *master_clk;
> > -	struct clk *slave_clk;
> > +	struct clk_bulk_data clks[QCOM_PCIE_2_4_0_MAX_CLOCKS];
> > +	int num_clks;
> >  	struct reset_control *axi_m_reset;
> >  	struct reset_control *axi_s_reset;
> >  	struct reset_control *pipe_reset;
> > @@ -638,18 +638,17 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
> >  	struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
> >  	struct dw_pcie *pci = pcie->pci;
> >  	struct device *dev = pci->dev;
> > +	int ret;
> >  
> > -	res->aux_clk = devm_clk_get(dev, "aux");
> > -	if (IS_ERR(res->aux_clk))
> > -		return PTR_ERR(res->aux_clk);
> > +	res->clks[0].id = "aux";
> > +	res->clks[1].id = "master_bus";
> > +	res->clks[2].id = "slave_bus";
> >  
> > -	res->master_clk = devm_clk_get(dev, "master_bus");
> > -	if (IS_ERR(res->master_clk))
> > -		return PTR_ERR(res->master_clk);
> > +	res->num_clks = 3;
> 
> Use the new fresh define QCOM_PCIE_2_4_0_MAX_CLOCKS?
> 

As I replace it in patch 3/3 with a value different from "max clocks", I
don't think it makes sense to use the define here. So I'm leaving this
as is.

> >  
> > -	res->slave_clk = devm_clk_get(dev, "slave_bus");
> > -	if (IS_ERR(res->slave_clk))
> > -		return PTR_ERR(res->slave_clk);
> > +	ret = devm_clk_bulk_get(dev, res->num_clks, res->clks);
> > +	if (ret < 0)
> > +		return ret;
> >  
> >  	res->axi_m_reset = devm_reset_control_get_exclusive(dev, "axi_m");
> >  	if (IS_ERR(res->axi_m_reset))
> > @@ -719,9 +718,7 @@ static void qcom_pcie_deinit_2_4_0(struct qcom_pcie *pcie)
> >  	reset_control_assert(res->axi_m_sticky_reset);
> >  	reset_control_assert(res->pwr_reset);
> >  	reset_control_assert(res->ahb_reset);
> > -	clk_disable_unprepare(res->aux_clk);
> > -	clk_disable_unprepare(res->master_clk);
> > -	clk_disable_unprepare(res->slave_clk);
> > +	clk_bulk_disable_unprepare(res->num_clks, res->clks);
> >  }
> >  
> >  static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
> > @@ -850,23 +847,9 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
> >  
> >  	usleep_range(10000, 12000);
> >  
> > -	ret = clk_prepare_enable(res->aux_clk);
> > -	if (ret) {
> > -		dev_err(dev, "cannot prepare/enable iface clock\n");
> > +	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
> > +	if (ret)
> >  		goto err_clk_aux;
> 
> Maybe you have to change the name of the label too?
> 

Updated this and posted v5. Should be good to be merged now.

Thanks for your reviews!

Regards,
Bjorn
