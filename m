Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46C7C1A2224
	for <lists+linux-pci@lfdr.de>; Wed,  8 Apr 2020 14:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgDHMgS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Apr 2020 08:36:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40086 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgDHMgR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Apr 2020 08:36:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id a81so5244149wmf.5;
        Wed, 08 Apr 2020 05:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=K2/ZZgf9mAgGPg5RQdW8XmMc7QHT56dxiERZrqmIlXI=;
        b=c3UoiulBTTw+EjdO3+3DsSxh6EgM+Zl5/tcYheVTBff7vQ5oijQhkXiQoFPMAL0ZD0
         Jwj4LxgHPk1fj5MDZsmoiZrO1VyFGhxCAwBZGvvwLCi1TL9xXGTLK+jg8GPPA/ISLGNp
         lTap1nwZWT39ht5/EZXZiPC/Exl0QWRf9cyebrLUkE6cdxxifkVH4pqdtS7mZJvCQJ/7
         qLXuf07xoVuihlHtFWk95bvUH7BO//5XWVqGW3bYthcwNLJpTA0r0VNCfRF+yl/ghQdV
         UVUm1/IMnwjDzkoeD+4sEbgQTFoETj5vPAJZvMxdB5lashjLsRRpJ9fPVHPD1cK2VZPd
         Fr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=K2/ZZgf9mAgGPg5RQdW8XmMc7QHT56dxiERZrqmIlXI=;
        b=GJjAoai89y5GRfmQtzqP53OLhadrvaGC9xv5s6/xeGf2eJhoxzv4Ah0OcPyH6sVh2V
         esRzjZaINMFE4LLj9g3dIY/meWA8Unee2FWPtVQwjAjBKDTAmcP3dFb03xppukHFXiQ6
         3wVKodKWRigWebxkYNVY+u0V4oBYuEo4IWpLTe+ovdcxGnD+YXTzn/tAPcmkUTdj90+D
         CEIdX3vZCUJZ+tL+/FSEgYlPZHn1/RxpjOZca+Q5nenx3gOBLF8e+j30thA2UkFitd8B
         s65VELA5jYbhHkFO3s9AEdcYGlnWx8Y1LTGySfpfl4g9qllAdaVRf6prSVeRKYxFpsDC
         cxhQ==
X-Gm-Message-State: AGi0PuZrKA5mHSoSSx407E/2n75j0nj+mXOHjprhY+UPBD5OaFaYD71T
        iudGTFWUiP9YOIzYB8yWvAA=
X-Google-Smtp-Source: APiQypJMIIuYnj3h812I/IE1fZG6gNF1wH2/EMIRqA12hvsLUvIqW6iJgzdmub9BCk4J9S8rI9MfXw==
X-Received: by 2002:a05:600c:2f90:: with SMTP id t16mr4692378wmn.66.1586349373751;
        Wed, 08 Apr 2020 05:36:13 -0700 (PDT)
Received: from AnsuelXPS (host117-205-dynamic.180-80-r.retail.telecomitalia.it. [80.180.205.117])
        by smtp.gmail.com with ESMTPSA id p22sm6638259wmc.42.2020.04.08.05.36.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 05:36:13 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Stanimir Varbanov'" <svarbanov@mm-sol.com>,
        "'Andy Gross'" <agross@kernel.org>
Cc:     "'Sham Muthayyan'" <smuthayy@codeaurora.org>,
        "'Bjorn Andersson'" <bjorn.andersson@linaro.org>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "'Andrew Murray'" <amurray@thegoodpenguin.co.uk>,
        "'Philipp Zabel'" <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200402121148.1767-1-ansuelsmth@gmail.com> <20200402121148.1767-2-ansuelsmth@gmail.com> <b09627a8-d928-cf5d-c765-406959138a29@mm-sol.com>
In-Reply-To: <b09627a8-d928-cf5d-c765-406959138a29@mm-sol.com>
Subject: R: [PATCH v2 01/10] PCIe: qcom: add missing ipq806x clocks in PCIe driver
Date:   Wed, 8 Apr 2020 14:36:10 +0200
Message-ID: <053d01d60da2$49e0ca60$dda25f20$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLxewcL6EghaIoibfUjxKO3XpeZ4wIE8vndAX3+x+GmHDaucA==
Content-Language: it
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> PCIe driver
> 
> Ansuel,
> 
> On 4/2/20 3:11 PM, Ansuel Smith wrote:
> > Aux and Ref clk are missing in pcie qcom driver.
> > Add support in the driver to fix pcie inizialization in ipq806x.
> >
> > Fixes: 82a82383 PCI: qcom: Add Qualcomm PCIe controller driver
> 
> this should be:
> 
> Fixes: 82a823833f4e PCI: qcom: Add Qualcomm PCIe controller driver
> 
> and add:
> 
> Cc: stable@vger.kernel.org # v4.5+
> 
> But, I wonder, as apq8064 shares the same ops_2_1_0 how it worked until
> now. Something more I cannot find such clocks for apq8064, which means
> that this patch will break it.
> 
> One option is to use those new clocks only for ipq806x.
> 

How to add this new clocks only for ipq806x? Check the compatible and add
them accordingly? 

> > Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 38
> ++++++++++++++++++++++----
> >  1 file changed, 33 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c
> b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 5ea527a6bd9f..f958c535de6e 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -88,6 +88,8 @@ struct qcom_pcie_resources_2_1_0 {
> >  	struct clk *iface_clk;
> >  	struct clk *core_clk;
> >  	struct clk *phy_clk;
> > +	struct clk *aux_clk;
> > +	struct clk *ref_clk;
> >  	struct reset_control *pci_reset;
> >  	struct reset_control *axi_reset;
> >  	struct reset_control *ahb_reset;
> > @@ -246,6 +248,14 @@ static int
> qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
> >  	if (IS_ERR(res->phy_clk))
> >  		return PTR_ERR(res->phy_clk);
> >
> > +	res->aux_clk = devm_clk_get(dev, "aux");
> > +	if (IS_ERR(res->aux_clk))
> > +		return PTR_ERR(res->aux_clk);
> > +
> > +	res->ref_clk = devm_clk_get(dev, "ref");
> > +	if (IS_ERR(res->ref_clk))
> > +		return PTR_ERR(res->ref_clk);
> > +
> >  	res->pci_reset = devm_reset_control_get_exclusive(dev, "pci");
> >  	if (IS_ERR(res->pci_reset))
> >  		return PTR_ERR(res->pci_reset);
> > @@ -278,6 +288,8 @@ static void qcom_pcie_deinit_2_1_0(struct
> qcom_pcie *pcie)
> >  	clk_disable_unprepare(res->iface_clk);
> >  	clk_disable_unprepare(res->core_clk);
> >  	clk_disable_unprepare(res->phy_clk);
> > +	clk_disable_unprepare(res->aux_clk);
> > +	clk_disable_unprepare(res->ref_clk);
> >  	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
> >  }
> >
> > @@ -307,16 +319,28 @@ static int qcom_pcie_init_2_1_0(struct
> qcom_pcie *pcie)
> >  		goto err_assert_ahb;
> >  	}
> >
> > +	ret = clk_prepare_enable(res->core_clk);
> > +	if (ret) {
> > +		dev_err(dev, "cannot prepare/enable core clock\n");
> > +		goto err_clk_core;
> > +	}
> > +
> >  	ret = clk_prepare_enable(res->phy_clk);
> >  	if (ret) {
> >  		dev_err(dev, "cannot prepare/enable phy clock\n");
> >  		goto err_clk_phy;
> >  	}
> >
> > -	ret = clk_prepare_enable(res->core_clk);
> > +	ret = clk_prepare_enable(res->aux_clk);
> >  	if (ret) {
> > -		dev_err(dev, "cannot prepare/enable core clock\n");
> > -		goto err_clk_core;
> > +		dev_err(dev, "cannot prepare/enable aux clock\n");
> > +		goto err_clk_aux;
> > +	}
> > +
> > +	ret = clk_prepare_enable(res->ref_clk);
> > +	if (ret) {
> > +		dev_err(dev, "cannot prepare/enable ref clock\n");
> > +		goto err_clk_ref;
> >  	}
> >
> >  	ret = reset_control_deassert(res->ahb_reset);
> > @@ -372,10 +396,14 @@ static int qcom_pcie_init_2_1_0(struct
> qcom_pcie *pcie)
> >  	return 0;
> >
> >  err_deassert_ahb:
> > -	clk_disable_unprepare(res->core_clk);
> > -err_clk_core:
> > +	clk_disable_unprepare(res->ref_clk);
> > +err_clk_ref:
> > +	clk_disable_unprepare(res->aux_clk);
> > +err_clk_aux:
> >  	clk_disable_unprepare(res->phy_clk);
> >  err_clk_phy:
> > +	clk_disable_unprepare(res->core_clk);
> > +err_clk_core:
> >  	clk_disable_unprepare(res->iface_clk);
> >  err_assert_ahb:
> >  	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
> >
> 
> --
> regards,
> Stan

