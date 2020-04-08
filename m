Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12C381A2227
	for <lists+linux-pci@lfdr.de>; Wed,  8 Apr 2020 14:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgDHMi2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Apr 2020 08:38:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51063 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgDHMi1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Apr 2020 08:38:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id x25so4973593wmc.0;
        Wed, 08 Apr 2020 05:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=7WVwy+SP+eZ7W/A++0vMqnUIR9Agu3yjwjMz6EovfMY=;
        b=JbuD071ifrKUYqa4oD+asFtTeSa7v9MY45CwueqXXHNRH3KhN5lQ8Onp5T665XIQjj
         dvR2uuyrdh4WvEUlNnnmDpj+vOJV9CgFLY0vaoEYWIZQtFrWWfVNZdWLazQR8yo/ePZ2
         tOLg4bbB0nSbeqgHwS2wAXx5ZpSz+InwRjcqrUeDdIwmyzsS06CMiKcHMNUDM/EufEFl
         iydiywBS1wVjqE+ecW2MgMz5nijIo+UOA9V9+X4EoMiD8u1qE0Wo1u3m7tofjIWp3ZVu
         9QAEye7wh/80MJFN56KgRsCPWzTk6brhcqvHLjR25swvPX6kaAn4+x4rBo2wdHHatmUF
         7dTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=7WVwy+SP+eZ7W/A++0vMqnUIR9Agu3yjwjMz6EovfMY=;
        b=QRJ/28tman2olPPu1nCjOk1oOsiiTHmQjREONYMvdvxDdI/xD/04M+2NVNXaB3a41z
         G4FRtvQpZxjdQCTg6IQ5CbTz8bSbZku1sBHNmtoF8ChrLCbVmXM84RyGY/v5YAN+kY17
         F7HPBfbEsH2DGz1zfaT8m6MOtaLim0bGSAc099SjNNwi1s9fwLSJMC4I+HVm9DZOVF/8
         lOEE8YhyVnftOzyS0KhJj9NWWXk0FCRnDhVR0MuRgPA1IKZYTrqaAC6Mr4u75W+rjVxH
         GmPddSdYHV+x3dZZeVoQ9Fm7EyyT72WMEZ4ab97S/nfWAT2K5ktSvXMysQn2jBEVyiai
         KQhg==
X-Gm-Message-State: AGi0PuZwcUV7drh7Lx7zJCcIEwGuPZ6SWRhKuLcKSW4uQzhvkHFIBRcU
        MznaEIjgMJD0WIn99xCpqj8=
X-Google-Smtp-Source: APiQypLk1OSAe8sQxynwPyLUwCr+hQf8DZOMyYWR5Kg8u966nzjURUJs7DUm/o8qnsBF4vC9gi5YqA==
X-Received: by 2002:a1c:80d3:: with SMTP id b202mr4474826wmd.8.1586349505289;
        Wed, 08 Apr 2020 05:38:25 -0700 (PDT)
Received: from AnsuelXPS (host117-205-dynamic.180-80-r.retail.telecomitalia.it. [80.180.205.117])
        by smtp.gmail.com with ESMTPSA id k185sm6952872wmb.7.2020.04.08.05.38.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 05:38:24 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Stanimir Varbanov'" <svarbanov@mm-sol.com>,
        "'Andy Gross'" <agross@kernel.org>
Cc:     "'Bjorn Andersson'" <bjorn.andersson@linaro.org>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "'Andrew Murray'" <amurray@thegoodpenguin.co.uk>,
        "'Philipp Zabel'" <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200402121148.1767-1-ansuelsmth@gmail.com> <20200402121148.1767-8-ansuelsmth@gmail.com> <fea9cfd1-2bc7-0141-444e-9c781877ad02@mm-sol.com>
In-Reply-To: <fea9cfd1-2bc7-0141-444e-9c781877ad02@mm-sol.com>
Subject: R: [PATCH v2 07/10] PCIe: qcom: fix init problem with missing PARF programming
Date:   Wed, 8 Apr 2020 14:38:21 +0200
Message-ID: <053e01d60da2$984f1170$c8ed3450$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLxewcL6EghaIoibfUjxKO3XpeZ4wIq3QoPAak0GR+mGa3/MA==
Content-Language: it
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> PARF programming
> 
> Hi Ansuel,
> 
> Please fix the patch subject for all patches in the series per Bjorn H.
> request.
> 
> PCI: qcom: Fix init problem with missing PARF programming
> 
> Also the patch subject is misleading to me. Actually you change few phy
> parameters: Tx De-Emphasis, Tx Swing and Rx equalization. On the other
> side I guess those parameters are board specific and I'm not sure how
> this change will reflect on apq8064 boards.
> 

I also think that this would brake apq8064, on ipq8064 this is needed or 
the system doesn't boot. 
Should I move this to the dts and set this params only if they are present
in dts or also here check for compatible and set accordingly? 

> On 4/2/20 3:11 PM, Ansuel Smith wrote:
> > PARF programming was missing and this cause initilizzation problem on
> > some ipq806x based device (Netgear R7800 for example). This cause a
> > total lock of the system on kernel load.
> >
> > Fixes: 82a82383 PCI: qcom: Add Qualcomm PCIe controller driver
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 48 +++++++++++++++++++++--
> ---
> >  1 file changed, 39 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c
> b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 211a1aa7d0f1..77b1ab7e23a3 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -46,6 +46,9 @@
> >
> >  #define PCIE20_PARF_PHY_CTRL			0x40
> >  #define PCIE20_PARF_PHY_REFCLK			0x4C
> > +#define REF_SSP_EN				BIT(16)
> > +#define REF_USE_PAD				BIT(12)
> 
> Could you rename this to:
> 
> PHY_REFCLK_SSP_EN
> PHY_REFCLK_USE_PAD
> 
> > +
> >  #define PCIE20_PARF_DBI_BASE_ADDR		0x168
> >  #define PCIE20_PARF_SLV_ADDR_SPACE_SIZE		0x16C
> >  #define PCIE20_PARF_MHI_CLOCK_RESET_CTRL	0x174
> > @@ -77,6 +80,18 @@
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
> > +#define PCIE20_PARF_CONFIG_BITS		0x50
> > +#define PHY_RX0_EQ(x)				(x << 24)
> >
> >  #define PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE	0x358
> >  #define SLV_ADDR_SPACE_SZ			0x10000000
> > @@ -184,6 +199,16 @@ struct qcom_pcie {
> >
> >  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> >
> > +static inline void qcom_clear_and_set_dword(void __iomem *addr,
> 
> drop 'inline' the compiler is smart enough to decide.
> 
> > +				 u32 clear_mask, u32 set_mask)
> > +{
> > +	u32 val = readl(addr);
> > +
> > +	val &= ~clear_mask;
> > +	val |= set_mask;
> > +	writel(val, addr);
> > +}
> > +
> 
> If you add such function you should introduce it in a separate patch and
> use it in the whole driver where it is applicable. After that we can see
> what is the benefit of it.
> 
> >  static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
> >  {
> >  	gpiod_set_value_cansleep(pcie->reset, 1);
> > @@ -304,7 +329,6 @@ static int qcom_pcie_init_2_1_0(struct
> qcom_pcie *pcie)
> >  	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
> >  	struct dw_pcie *pci = pcie->pci;
> >  	struct device *dev = pci->dev;
> > -	u32 val;
> >  	int ret;
> >
> >  	ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res-
> >supplies);
> > @@ -355,15 +379,21 @@ static int qcom_pcie_init_2_1_0(struct
> qcom_pcie *pcie)
> >  		goto err_deassert_ahb;
> >  	}
> >
> > -	/* enable PCIe clocks and resets */
> > -	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> > -	val &= ~BIT(0);
> > -	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> > +	qcom_clear_and_set_dword(pcie->parf + PCIE20_PARF_PHY_CTRL,
> BIT(0), 0);
> 
> please keep the comment.
> 
> > +
> > +	/* PARF programming */
> 
> pointless comment, please drop it.
> 
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
> > +	/* enable reference clock */
> 
> Why you dropped 'external' ?
> 
> > +	qcom_clear_and_set_dword(pcie->parf +
> PCIE20_PARF_PHY_REFCLK,
> > +		      REF_USE_PAD, REF_SSP_EN);
> >
> >  	ret = reset_control_deassert(res->phy_reset);
> >  	if (ret) {
> >
> 
> --
> regards,
> Stan

