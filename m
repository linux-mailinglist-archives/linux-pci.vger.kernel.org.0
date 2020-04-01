Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C118819B7F5
	for <lists+linux-pci@lfdr.de>; Wed,  1 Apr 2020 23:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732864AbgDAVzY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Apr 2020 17:55:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34284 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732357AbgDAVzY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Apr 2020 17:55:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id 65so1922815wrl.1;
        Wed, 01 Apr 2020 14:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=23XR5mx8Dze93AnMWKyPVY0N8s5g7kVY+bkAn8g7cvA=;
        b=QAniw9SjKQdOhTQ6+egXHh8NRepoYDY4AiDAN7Uj1eGxSWo4AArd8Xtg/NIoC8BIDL
         KRShWuizd69H8UwgFcT+nsJPKSweoIyITSUfLUqvs6AofqWK+y3TZRVbbvuiCocT3d34
         1xYjOdKTWqw5ROCwZLYMo2mLc1wISqW/FV8ZJYhX6FQ0Zx41nYXpV8cU4TL7OIH0yXFx
         CrPbHQtca7er4Idus89zSrtFbSpzq5cTu9jYKK6a2aDUz+WlTe/yJOVckTa7FPeYaETu
         kYVOgbRKRj1TDcVlxbf9KMv4jmjmrSGAleN6jEjqAaYebTQCSV/TZw8qeWh8gBmxYEUJ
         w5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=23XR5mx8Dze93AnMWKyPVY0N8s5g7kVY+bkAn8g7cvA=;
        b=UzCXBV4jBvb+BvjLbZRIjSEV11o7/PqfTzzQ1D+GUkknsLSCa4eXFbdZrGddHMjASQ
         k3hgA9wVw6v+rxGPHQj+9Gzu3eh/HAUFKgyHrIzVv++DbYO+pvhcUc0ozikH3kus4efM
         w83yczLTX43YvIeq2jk4fx8VYKiqCo0coxJ1VYkmqxfVt//MV5wilCwic/abpeM6GA0o
         97r7Elfg7Mr4XtJNTk9o90uBW3M3s7PY53aJtRMVeazmtuQO2yOytFcLGV8bboaWdQDH
         etYuKynoByQzTP6dc1S0RcUV3HZGPwVLHgtqZZu8s9x2UFIj0U9PM/XbLjHiHkpxzioN
         o8Lg==
X-Gm-Message-State: AGi0PuaproIXC6WnEqhUwA9vupKblam7oIGZMnOKEwRIqRQmh3Nyg1VU
        TpI9VP9m/mqVzHuKP5EZZck=
X-Google-Smtp-Source: APiQypLPNH390ekbgjowk9SJkVwRaMOwDEpGqo7J6aTA93oIuwiRwrzQR7kuqQyKFmyS2KRB8S9NlA==
X-Received: by 2002:adf:a549:: with SMTP id j9mr39711wrb.183.1585778121081;
        Wed, 01 Apr 2020 14:55:21 -0700 (PDT)
Received: from AnsuelXPS (host3-220-static.183-80-b.business.telecomitalia.it. [80.183.220.3])
        by smtp.gmail.com with ESMTPSA id a186sm4244571wmh.33.2020.04.01.14.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 14:55:20 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Bjorn Andersson'" <bjorn.andersson@linaro.org>
Cc:     "'Stanimir Varbanov'" <svarbanov@mm-sol.com>,
        "'Sham Muthayyan'" <smuthayy@codeaurora.org>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "'Andrew Murray'" <amurray@thegoodpenguin.co.uk>,
        "'Philipp Zabel'" <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200320183455.21311-1-ansuelsmth@gmail.com> <20200320183455.21311-7-ansuelsmth@gmail.com> <20200401204007.GG254911@minitux>
In-Reply-To: <20200401204007.GG254911@minitux>
Subject: R: [PATCH 07/12] pcie: qcom: add tx term offset support
Date:   Wed, 1 Apr 2020 23:55:17 +0200
Message-ID: <006501d60870$3cf99fc0$b6ecdf40$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: it
Thread-Index: AQF7DJ39byRpk4MoIUXZtcQDafvd5gIhNZ99Afu/Pz6o+d5HcA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> On Fri 20 Mar 11:34 PDT 2020, Ansuel Smith wrote:
> 
> > From: Sham Muthayyan <smuthayy@codeaurora.org>
> >
> > Add tx term offset support to pcie qcom driver
> > need in some revision of the ipq806x soc
> >
> > Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 61
> ++++++++++++++++++++++----
> >  1 file changed, 52 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c
> b/drivers/pci/controller/dwc/pcie-qcom.c
> > index ecc22fd27ea6..8009e3117765 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -45,7 +45,13 @@
> >  #define PCIE_CAP_CPL_TIMEOUT_DISABLE		0x10
> >
> >  #define PCIE20_PARF_PHY_CTRL			0x40
> > +#define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	(0x1f << 16)
> > +#define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		(x << 16)
> > +
> >  #define PCIE20_PARF_PHY_REFCLK			0x4C
> > +#define REF_SSP_EN				BIT(16)
> > +#define REF_USE_PAD				BIT(12)
> > +
> >  #define PCIE20_PARF_DBI_BASE_ADDR		0x168
> >  #define PCIE20_PARF_SLV_ADDR_SPACE_SIZE		0x16C
> >  #define PCIE20_PARF_MHI_CLOCK_RESET_CTRL	0x174
> > @@ -77,6 +83,18 @@
> >  #define DBI_RO_WR_EN				1
> >
> >  #define PERST_DELAY_US				1000
> > +/* PARF registers */
> > +#define PCIE20_PARF_PCS_DEEMPH			0x34
> > +#define PCS_DEEMPH_TX_DEEMPH_GEN1(x)		(x << 16)
> > +#define PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(x)	(x << 8)
> > +#define PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(x)	(x << 0)
> > +
> > +#define PCIE20_PARF_PCS_SWING			0x38
> > +#define PCS_SWING_TX_SWING_FULL(x)		(x << 8)
> > +#define PCS_SWING_TX_SWING_LOW(x)		(x << 0)
> > +
> > +#define PCIE20_PARF_CONFIG_BITS			0x50
> > +#define PHY_RX0_EQ(x)				(x << 24)
> >
> >  #define PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE	0x358
> >  #define SLV_ADDR_SPACE_SZ			0x10000000
> > @@ -97,6 +115,7 @@ struct qcom_pcie_resources_2_1_0 {
> >  	struct reset_control *phy_reset;
> >  	struct reset_control *ext_reset;
> >  	struct regulator_bulk_data
> supplies[QCOM_PCIE_2_1_0_MAX_SUPPLY];
> > +	uint8_t phy_tx0_term_offset;
> >  };
> >
> >  struct qcom_pcie_resources_1_0_0 {
> > @@ -184,6 +203,16 @@ struct qcom_pcie {
> >
> >  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> >
> > +static inline void
> > +writel_masked(void __iomem *addr, u32 clear_mask, u32 set_mask)
> > +{
> > +	u32 val = readl(addr);
> > +
> > +	val &= ~clear_mask;
> > +	val |= set_mask;
> > +	writel(val, addr);
> > +}
> > +
> >  static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
> >  {
> >  	gpiod_set_value_cansleep(pcie->reset, 1);
> > @@ -277,6 +306,10 @@ static int
> qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
> >  	if (IS_ERR(res->ext_reset))
> >  		return PTR_ERR(res->ext_reset);
> >
> > +	if (of_property_read_u8(dev->of_node, "phy-tx0-term-offset",
> > +				&res->phy_tx0_term_offset))
> > +		res->phy_tx0_term_offset = 0;
> 
> The appropriate way is to encode differences in hardware is to use
> different compatibles for the two different versions of the hardware.
> 
> Regards,
> Bjorn
> 

So a better way to handle this would be to check the SoC compatible?
AFAIK a different offset is only needed on ipq8064 revision 2 and ipq8065
but
it looks bad to add a special code just for that 2 SoC. 
I would prefer to handle this with the offset definition but If you think
this would be
the right way, I will follow that. Waiting for your response about this.

> > +
> >  	res->phy_reset = devm_reset_control_get_exclusive(dev, "phy");
> >  	return PTR_ERR_OR_ZERO(res->phy_reset);
> >  }
> > @@ -304,7 +337,6 @@ static int qcom_pcie_init_2_1_0(struct
> qcom_pcie *pcie)
> >  	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
> >  	struct dw_pcie *pci = pcie->pci;
> >  	struct device *dev = pci->dev;
> > -	u32 val;
> >  	int ret;
> >
> >  	ret = reset_control_assert(res->ahb_reset);
> > @@ -355,15 +387,26 @@ static int qcom_pcie_init_2_1_0(struct
> qcom_pcie *pcie)
> >  		goto err_deassert_ahb;
> >  	}
> >
> > -	/* enable PCIe clocks and resets */
> > -	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> > -	val &= ~BIT(0);
> > -	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> > +	writel_masked(pcie->parf + PCIE20_PARF_PHY_CTRL, BIT(0), 0);
> > +
> > +	/* Set Tx termination offset */
> > +	writel_masked(pcie->parf + PCIE20_PARF_PHY_CTRL,
> > +		      PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK,
> > +		      PHY_CTRL_PHY_TX0_TERM_OFFSET(res-
> >phy_tx0_term_offset));
> > +
> > +	/* PARF programming */
> > +	writel(PCS_DEEMPH_TX_DEEMPH_GEN1(0x18) |
> > +	       PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(0x18) |
> > +	       PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(0x22),
> > +	       pcie->parf + PCIE20_PARF_PCS_DEEMPH);
> > +	writel(PCS_SWING_TX_SWING_FULL(0x78) |
> > +	       PCS_SWING_TX_SWING_LOW(0x78),
> > +	       pcie->parf + PCIE20_PARF_PCS_SWING);
> > +	writel(PHY_RX0_EQ(0x4), pcie->parf + PCIE20_PARF_CONFIG_BITS);
> >
> > -	/* enable external reference clock */
> > -	val = readl(pcie->parf + PCIE20_PARF_PHY_REFCLK);
> > -	val |= BIT(16);
> > -	writel(val, pcie->parf + PCIE20_PARF_PHY_REFCLK);
> > +	/* Enable reference clock */
> > +	writel_masked(pcie->parf + PCIE20_PARF_PHY_REFCLK,
> > +		      REF_USE_PAD, REF_SSP_EN);
> >
> >  	ret = reset_control_deassert(res->phy_reset);
> >  	if (ret) {
> > --
> > 2.25.1
> >

