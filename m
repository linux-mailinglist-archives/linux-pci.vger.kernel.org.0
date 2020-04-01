Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8AA19B915
	for <lists+linux-pci@lfdr.de>; Thu,  2 Apr 2020 01:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733305AbgDAXwP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Apr 2020 19:52:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35736 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732872AbgDAXwP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Apr 2020 19:52:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id c12so636420plz.2
        for <linux-pci@vger.kernel.org>; Wed, 01 Apr 2020 16:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=39o7ZeExYpkfTbZoKHgoBseO9KDqeuMtrYpVQ76wHvQ=;
        b=g7KGE2ct8ZghoiGIERIsopK2WwcCW24r4+BhCyOrIrAO9QA+wACwNYk8KWp7X1ZSF2
         3ccANG0k3AmbQKvv9Eguif8ww/gMmCGxH7hyLdiqEBSuH5Bt1qIodKPF261uREWWKGGX
         SV9XzvvE2ok1Ob9eWNoW+M3pLPzRQ39oCDuo+up1xltLUYMcqEa4tHITqqupbx2UMnZC
         pI3toKLL+KgyHH96V5JHLBew/9cRjcSxFLTDw6f72T0jREZj3xjIO7loC5jxZkZ04F0G
         d3eB/yjwJk7bJAfQDKjQ4W0ciZ/r73QQbuMpRaIbnZ4t0brMs0Pj2r2b9uuSJCFU3BmZ
         ZjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=39o7ZeExYpkfTbZoKHgoBseO9KDqeuMtrYpVQ76wHvQ=;
        b=moyYZyID4wisIDZJxJx/65lbSIhmBJWe0kPPV4zECKIEDdapxuEThvpjStjNlQsXqp
         mdvwaeCx1eFbwPxqQmH5KA6v8gPJgJWa/MKfGd/4snX70eO38aWvjolacErmAhMYyk/k
         6+0svTqSSIitNj3HNPe+KvwoYzwJFzfM33F0KBLCXwB0vOn/pzPAi3Cw53uexlZYMkLj
         TCd95zym1S1EWYg4ggUfwvJyifxSbRERqezLKIxRFsNoiCDi72xiFVZo6f7C3K5Rn92Q
         nDZJ+ZDmnfQF5TXhCkjaN79bZ490hTjnhlMNydiy4yHYtV2RrMe1xsOednxUjiOUZOql
         OUSg==
X-Gm-Message-State: AGi0PuY1aofwa1Qn8ruTamg3VLsESArQMRiKVgKbV1RtWys8zgcSHvVL
        G/PkWaWzsh+F3nrnjmd3l5P5IA==
X-Google-Smtp-Source: APiQypLd+V9fUOfcYn6J9ceh3M1sNQNMmr8IkTNDiIx6b9iFuOJavZ+5tEa5M0Ne+AMErvILIozTxQ==
X-Received: by 2002:a17:902:8b82:: with SMTP id ay2mr332388plb.221.1585785133978;
        Wed, 01 Apr 2020 16:52:13 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i197sm2401468pfe.137.2020.04.01.16.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 16:52:13 -0700 (PDT)
Date:   Wed, 1 Apr 2020 16:52:11 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     ansuelsmth@gmail.com
Cc:     'Stanimir Varbanov' <svarbanov@mm-sol.com>,
        'Sham Muthayyan' <smuthayy@codeaurora.org>,
        'Andy Gross' <agross@kernel.org>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        'Rob Herring' <robh+dt@kernel.org>,
        'Mark Rutland' <mark.rutland@arm.com>,
        'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>,
        'Andrew Murray' <amurray@thegoodpenguin.co.uk>,
        'Philipp Zabel' <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: R: [PATCH 07/12] pcie: qcom: add tx term offset support
Message-ID: <20200401235211.GK254911@minitux>
References: <20200320183455.21311-1-ansuelsmth@gmail.com>
 <20200320183455.21311-7-ansuelsmth@gmail.com>
 <20200401204007.GG254911@minitux>
 <006501d60870$3cf99fc0$b6ecdf40$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006501d60870$3cf99fc0$b6ecdf40$@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed 01 Apr 14:55 PDT 2020, ansuelsmth@gmail.com wrote:

> > On Fri 20 Mar 11:34 PDT 2020, Ansuel Smith wrote:
> > 
> > > From: Sham Muthayyan <smuthayy@codeaurora.org>
> > >
> > > Add tx term offset support to pcie qcom driver
> > > need in some revision of the ipq806x soc
> > >
> > > Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-qcom.c | 61
> > ++++++++++++++++++++++----
> > >  1 file changed, 52 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c
> > b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index ecc22fd27ea6..8009e3117765 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -45,7 +45,13 @@
> > >  #define PCIE_CAP_CPL_TIMEOUT_DISABLE		0x10
> > >
> > >  #define PCIE20_PARF_PHY_CTRL			0x40
> > > +#define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	(0x1f << 16)
> > > +#define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		(x << 16)
> > > +
> > >  #define PCIE20_PARF_PHY_REFCLK			0x4C
> > > +#define REF_SSP_EN				BIT(16)
> > > +#define REF_USE_PAD				BIT(12)
> > > +
> > >  #define PCIE20_PARF_DBI_BASE_ADDR		0x168
> > >  #define PCIE20_PARF_SLV_ADDR_SPACE_SIZE		0x16C
> > >  #define PCIE20_PARF_MHI_CLOCK_RESET_CTRL	0x174
> > > @@ -77,6 +83,18 @@
> > >  #define DBI_RO_WR_EN				1
> > >
> > >  #define PERST_DELAY_US				1000
> > > +/* PARF registers */
> > > +#define PCIE20_PARF_PCS_DEEMPH			0x34
> > > +#define PCS_DEEMPH_TX_DEEMPH_GEN1(x)		(x << 16)
> > > +#define PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(x)	(x << 8)
> > > +#define PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(x)	(x << 0)
> > > +
> > > +#define PCIE20_PARF_PCS_SWING			0x38
> > > +#define PCS_SWING_TX_SWING_FULL(x)		(x << 8)
> > > +#define PCS_SWING_TX_SWING_LOW(x)		(x << 0)
> > > +
> > > +#define PCIE20_PARF_CONFIG_BITS			0x50
> > > +#define PHY_RX0_EQ(x)				(x << 24)
> > >
> > >  #define PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE	0x358
> > >  #define SLV_ADDR_SPACE_SZ			0x10000000
> > > @@ -97,6 +115,7 @@ struct qcom_pcie_resources_2_1_0 {
> > >  	struct reset_control *phy_reset;
> > >  	struct reset_control *ext_reset;
> > >  	struct regulator_bulk_data
> > supplies[QCOM_PCIE_2_1_0_MAX_SUPPLY];
> > > +	uint8_t phy_tx0_term_offset;
> > >  };
> > >
> > >  struct qcom_pcie_resources_1_0_0 {
> > > @@ -184,6 +203,16 @@ struct qcom_pcie {
> > >
> > >  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> > >
> > > +static inline void
> > > +writel_masked(void __iomem *addr, u32 clear_mask, u32 set_mask)
> > > +{
> > > +	u32 val = readl(addr);
> > > +
> > > +	val &= ~clear_mask;
> > > +	val |= set_mask;
> > > +	writel(val, addr);
> > > +}
> > > +
> > >  static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
> > >  {
> > >  	gpiod_set_value_cansleep(pcie->reset, 1);
> > > @@ -277,6 +306,10 @@ static int
> > qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
> > >  	if (IS_ERR(res->ext_reset))
> > >  		return PTR_ERR(res->ext_reset);
> > >
> > > +	if (of_property_read_u8(dev->of_node, "phy-tx0-term-offset",
> > > +				&res->phy_tx0_term_offset))
> > > +		res->phy_tx0_term_offset = 0;
> > 
> > The appropriate way is to encode differences in hardware is to use
> > different compatibles for the two different versions of the hardware.
> > 
> > Regards,
> > Bjorn
> > 
> 
> So a better way to handle this would be to check the SoC compatible?
> AFAIK a different offset is only needed on ipq8064 revision 2 and ipq8065
> but
> it looks bad to add a special code just for that 2 SoC. 
> I would prefer to handle this with the offset definition but If you think
> this would be
> the right way, I will follow that. Waiting for your response about this.
> 

Yes, please do this by having different compatibles for the different
revisions of the hardware block.

You should be able to use the same implementation for the two
compatibles, just make the phy_tx0_term_offset depends on which was
used.

Regards,
Bjorn
