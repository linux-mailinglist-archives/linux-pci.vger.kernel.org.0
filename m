Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1933A1D1351
	for <lists+linux-pci@lfdr.de>; Wed, 13 May 2020 14:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbgEMMyt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 May 2020 08:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbgEMMyt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 May 2020 08:54:49 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125F8C061A0C;
        Wed, 13 May 2020 05:54:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id v12so20716613wrp.12;
        Wed, 13 May 2020 05:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=gjKKMxa6xHI1LOhBmFUHbDk1I1ew8jSwGc3Qoec8V+Q=;
        b=UBNz8U1As5Vt7c5ZDDS1AoaWSmwZKNX6frEeTvbyV71E0BCKVyd2TEF4KA3888hxpS
         l6mSMgwqDLXr2mFZR7GpBZr0Wkrtw6gCHanK5TOuUuI9qa8Ndv7P98jrySSmVln7LFwJ
         +O+V5roxN+jRG60EAHChKxZGgr+s0YC4RCi9K2hDcnPf6CY/Zl62PyWvc1hyXzHLarKh
         PoFqjzdCzb2/0MKKPDcLAAxyZR+gLiRn0CtPGr+Mdp5jZL480s1myIvtg8taa26ANgHg
         WGPXa6jNEpWIBQ8WY2LjglX2XDGGDBUaRL62Xj13Uj9hmBT2SFyFuzXH2CMMqHjkY3Kq
         XBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=gjKKMxa6xHI1LOhBmFUHbDk1I1ew8jSwGc3Qoec8V+Q=;
        b=DXw+PWej1TzOXWEezifwXEwSVSx5cq6P8BrJejMmDCdruGxTIDIlYC9KSlLikZ3kkA
         jZKPCydIgRfjIdw0XQe3XnLi9Brbf/bZ1l9OG6sAmTnojNCVkgClzq1hIRz+MoJkUQ4P
         HzdUhtLDgHBNc8AlTJpJtNL+w2RQOofAEYHH8ZowRCsedE2tM80+VmjA2Gwn86/6qmla
         6w3iXEXR5+CLWkVktqmR9bI60laQ6xy/xr628ky8UKuY1Y8Maoge4l8lvEWXQjbTEpge
         lnuBNQtEHotnEtDWFHIvKDWMUslZQcE+K1WRFP2TDvWbYfFEeShoe8plgaHhrFH8hhQD
         j/Zw==
X-Gm-Message-State: AGi0PuajDTnPgnUc7IbEFfUrC3W1hrGGDyPTIAQwvipArOMeitpZCVlR
        fxhWOWh5SQi5XtqGCLGKPo4=
X-Google-Smtp-Source: APiQypLJGcQe8kgxzp9RurwNj5AFOM4KYK86duozmEFZkimTMBGkUPYtCVcNV/c9bznSQgyJbAP0xA==
X-Received: by 2002:a5d:4806:: with SMTP id l6mr31495243wrq.121.1589374486610;
        Wed, 13 May 2020 05:54:46 -0700 (PDT)
Received: from AnsuelXPS (host122-89-dynamic.247-95-r.retail.telecomitalia.it. [95.247.89.122])
        by smtp.gmail.com with ESMTPSA id s11sm36459960wms.5.2020.05.13.05.54.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 05:54:45 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Stanimir Varbanov'" <svarbanov@mm-sol.com>,
        "'Bjorn Andersson'" <bjorn.andersson@linaro.org>
Cc:     "'Sham Muthayyan'" <smuthayy@codeaurora.org>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "'Andrew Murray'" <amurray@thegoodpenguin.co.uk>,
        "'Philipp Zabel'" <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200430220619.3169-1-ansuelsmth@gmail.com> <20200430220619.3169-10-ansuelsmth@gmail.com> <3dc89ec6-d550-9402-1a4a-ca0c6f1e1fb9@mm-sol.com>
In-Reply-To: <3dc89ec6-d550-9402-1a4a-ca0c6f1e1fb9@mm-sol.com>
Subject: R: [PATCH v3 09/11] PCI: qcom: add ipq8064 rev2 variant and set tx term offset
Date:   Wed, 13 May 2020 14:54:41 +0200
Message-ID: <02df01d62925$acd160a0$067421e0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: it
Thread-Index: AQH0plL6ngkayUAAEEU7BifA9vEwhgKDdr3rAu/CbUKoPWRmMA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Hi Ansuel,
> 
> On 5/1/20 1:06 AM, Ansuel Smith wrote:
> > From: Sham Muthayyan <smuthayy@codeaurora.org>
> >
> > Add tx term offset support to pcie qcom driver need in some revision of
> > the ipq806x SoC.
> > Ipq8064 have tx term offset set to 7.
> > Ipq8064-v2 revision and ipq8065 have the tx term offset set to 0.
> >
> > Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c
> b/drivers/pci/controller/dwc/pcie-qcom.c
> > index da8058fd1925..372d2c8508b5 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -45,6 +45,9 @@
> >  #define PCIE_CAP_CPL_TIMEOUT_DISABLE		0x10
> >
> >  #define PCIE20_PARF_PHY_CTRL			0x40
> > +#define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(12,
> 16)
> 
> The mask definition is not correct. Should be GENMASK(20, 16)
> 
> > +#define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
> > +
> >  #define PCIE20_PARF_PHY_REFCLK			0x4C
> >  #define PHY_REFCLK_SSP_EN			BIT(16)
> >  #define PHY_REFCLK_USE_PAD			BIT(12)
> > @@ -118,6 +121,7 @@ struct qcom_pcie_resources_2_1_0 {
> >  	u32 tx_swing_full;
> >  	u32 tx_swing_low;
> >  	u32 rx0_eq;
> > +	u8 phy_tx0_term_offset;
> >  };
> >
> >  struct qcom_pcie_resources_1_0_0 {
> > @@ -318,6 +322,11 @@ static int
> qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
> >  	if (IS_ERR(res->ext_reset))
> >  		return PTR_ERR(res->ext_reset);
> >
> > +	if (of_device_is_compatible(dev->of_node, "qcom,pcie-ipq8064"))
> > +		res->phy_tx0_term_offset = 7;
> 
> Before your change the phy_tx0_term_offser was 0 for apq8064, but here
> you change it to 7, why?
> 

apq8064 board should use qcom,pcie-apq8064 right? This should be set to 0
only with pcie-ipq8064 compatible. Tell me if I'm wrong.

> > +	else
> > +		res->phy_tx0_term_offset = 0;
> > +
> >  	res->phy_reset = devm_reset_control_get_exclusive(dev, "phy");
> >  	return PTR_ERR_OR_ZERO(res->phy_reset);
> >  }
> > @@ -402,6 +411,11 @@ static int qcom_pcie_init_2_1_0(struct
> qcom_pcie *pcie)
> >  	/* enable PCIe clocks and resets */
> >  	qcom_clear_and_set_dword(pcie->parf + PCIE20_PARF_PHY_CTRL,
> BIT(0), 0);
> >
> > +	/* set TX termination offset */
> > +	qcom_clear_and_set_dword(pcie->parf + PCIE20_PARF_PHY_CTRL,
> > +			PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK,
> 
> As the mask definition is incorrect you actually clear 12 to 16 bit in
> the register where is another PHY parameter. Is that was intentional?
> 

Will check this and the wrong genmask.

> > +			PHY_CTRL_PHY_TX0_TERM_OFFSET(res-
> >phy_tx0_term_offset));
> > +
> >  	writel(PCS_DEEMPH_TX_DEEMPH_GEN1(res->tx_deemph_gen1) |
> >  	       PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(res-
> >tx_deemph_gen2_3p5db) |
> >  	       PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(res-
> >tx_deemph_gen2_6db),
> > @@ -1485,6 +1499,7 @@ static int qcom_pcie_probe(struct
> platform_device *pdev)
> >  static const struct of_device_id qcom_pcie_match[] = {
> >  	{ .compatible = "qcom,pcie-apq8084", .data = &ops_1_0_0 },
> >  	{ .compatible = "qcom,pcie-ipq8064", .data = &ops_2_1_0 },
> > +	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &ops_2_1_0 },
> >  	{ .compatible = "qcom,pcie-apq8064", .data = &ops_2_1_0 },
> >  	{ .compatible = "qcom,pcie-msm8996", .data = &ops_2_3_2 },
> >  	{ .compatible = "qcom,pcie-ipq8074", .data = &ops_2_3_3 },
> >
> 
> --
> regards,
> Stan

