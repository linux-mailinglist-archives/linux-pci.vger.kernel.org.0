Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC1F486DA3
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 00:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245429AbiAFXUK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 18:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbiAFXUK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 18:20:10 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D504CC061245
        for <linux-pci@vger.kernel.org>; Thu,  6 Jan 2022 15:20:09 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id n3-20020a4a3443000000b002dad63979b8so1056948oof.4
        for <linux-pci@vger.kernel.org>; Thu, 06 Jan 2022 15:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L+fLuX/n7EnIi85I1EffajEmAykxdA4jMPFkokOcSKA=;
        b=P23zGdDhwsXAaXNeQKB2eghsXQAeDQwQLX/F1XTxW+GgJDvKJ8mSAnXxMWsDTibMBl
         XgkKMQ46v2enbcG8Bk2crGWOQJx8B+l1R0pGeOhta7eX1vhnZG2lkMs1axJ//iYEzMDT
         nbFG+XEmBNLGKlvT3ZjJw+zThRsRnIR2PuFPq2qpjI27y6BNr42hiQ4uTC5AVHIpQehk
         TdVfLSczKBqjXqX3/M8nPgeypesE51WvVYxieknODpVbFLq4tzWEFMvWftYBVSlkyjoy
         Ab2rg3xp0fmNf7hQOevzNfqCAOf8Pke7Ki5kOydJ9SfMobXCT3dpPTfNlfWdsBhGQNPV
         IWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L+fLuX/n7EnIi85I1EffajEmAykxdA4jMPFkokOcSKA=;
        b=K6zH+xlquet1jtiXZqFGLkqW1WVzqViJPcFgG+URz7B8Jm4rYdbIfh2bOOqrt5emq+
         RyeXpTrJNCAlj2lF8IRc6ztks3epUlfU5zZ+vS4VVqWmYXQeWp+O0ZpoHGQm7/vCJB5B
         zLPFnLkcG843sdUip/V5aH5OE35xE/BKv9lg6TxnSxRNYykr99NWNt5OrwkjgAftAemy
         6xka6vKR/F8NiDvP4B/pYjkjvpNbvvvv0lmPmG+FhFt+t2+EIsaAAWOn9yHhiCzo6kmw
         JkYOvdMzDTr3BLGXnzHnJcGlO0uZC4ikLKLcpI2+G3GSoxFaJsDRPs7ZHBuCNYHIQOWI
         Jd8Q==
X-Gm-Message-State: AOAM533pwdSeogdvcwX16SXpSe/QSQp10oquvBy0Bag7ekYywgGHCf5P
        ShABEzTpblZmTY/DUV1DoH0BCQ==
X-Google-Smtp-Source: ABdhPJzjhr0/uqKVNZ3jBW8TAon2i6DzxDAl9KoMViywhZ7NA7oYtcQTVC2BFPb5/c3tEeXtXcuahQ==
X-Received: by 2002:a4a:ab05:: with SMTP id i5mr38377802oon.61.1641511209087;
        Thu, 06 Jan 2022 15:20:09 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c24sm569378oih.54.2022.01.06.15.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 15:20:08 -0800 (PST)
Date:   Thu, 6 Jan 2022 15:20:58 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andy Gross <agross@kernel.org>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH v4 3/3] PCI: qcom: add support for IPQ60xx PCIe controller
Message-ID: <Ydd5Wh0KeADBQ/h1@ripper>
References: <cover.1640587131.git.baruch@tkos.co.il>
 <a2406bf515124afad50ca3c947e2cd758c0896b1.1640587131.git.baruch@tkos.co.il>
 <20220106144518.GA15482@lpieralisi>
 <87k0fcenuw.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0fcenuw.fsf@tarshish>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu 06 Jan 10:05 PST 2022, Baruch Siach wrote:

> Hi Lorenzo,
> 
> On Thu, Jan 06 2022, Lorenzo Pieralisi wrote:
> > [+Pali - query on reset delay]
> >
> > On Mon, Dec 27, 2021 at 08:46:05AM +0200, Baruch Siach wrote:
> >> From: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> >> 
> >> IPQ60xx series of SoCs have one port of PCIe gen 3. Add support for that
> >> platform.
> >> 
> >> The code is based on downstream[1] Codeaurora kernel v5.4 (branch
> >> win.linuxopenwrt.2.0).
> >> 
> >> Split out the DBI registers access part from .init into .post_init. DBI
> >> registers are only accessible after phy_power_on().
> >> 
> >> [1] https://source.codeaurora.org/quic/qsdk/oss/kernel/linux-ipq-5.4/
> >> 
> >> Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> >> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
> >> ---
> >> v4:
> >> 
> >>   * Rebase on v5.16-rc1
> >> 
> >> v3:
> >>   * Drop speed setup; rely on generic code (Rob Herring)
> >> 
> >>   * Drop unused CLK_RATE macros (Bjorn Helgaas)
> >> 
> >>   * Minor formatting fixes (Bjorn Helgaas)
> >> 
> >>   * Add reference to downstream Codeaurora kernel tree (Bjorn Helgaas)
> >> 
> >> v2:
> >>   * Drop ATU configuration; rely on common code instead
> >> 
> >>   * Use more common register macros
> >> 
> >>   * Use bulk clk and reset APIs
> >> ---
> >>  drivers/pci/controller/dwc/pcie-designware.h |   1 +
> >>  drivers/pci/controller/dwc/pcie-qcom.c       | 145 +++++++++++++++++++
> >>  2 files changed, 146 insertions(+)
> >> 
> >> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> >> index ea87809ee298..279c3778a13b 100644
> >> --- a/drivers/pci/controller/dwc/pcie-designware.h
> >> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> >> @@ -76,6 +76,7 @@
> >>  
> >>  #define GEN3_RELATED_OFF			0x890
> >>  #define GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL	BIT(0)
> >> +#define GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS	BIT(13)
> >>  #define GEN3_RELATED_OFF_GEN3_EQ_DISABLE	BIT(16)
> >>  #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
> >>  #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)
> >> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> >> index 1c3d1116bb60..14f86c45a8d9 100644
> >> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> >> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> >> @@ -52,6 +52,10 @@
> >>  #define PCIE20_PARF_DBI_BASE_ADDR		0x168
> >>  #define PCIE20_PARF_SLV_ADDR_SPACE_SIZE		0x16C
> >>  #define PCIE20_PARF_MHI_CLOCK_RESET_CTRL	0x174
> >> +#define AHB_CLK_EN				BIT(0)
> >> +#define MSTR_AXI_CLK_EN				BIT(1)
> >> +#define BYPASS					BIT(4)
> >> +
> >>  #define PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT	0x178
> >>  #define PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2	0x1A8
> >>  #define PCIE20_PARF_LTSSM			0x1B0
> >> @@ -171,6 +175,11 @@ struct qcom_pcie_resources_2_7_0 {
> >>  	struct clk *ref_clk_src;
> >>  };
> >>  
> >> +struct qcom_pcie_resources_2_9_0 {
> >> +	struct clk_bulk_data clks[5];
> >> +	struct reset_control *rst;
> >> +};
> >> +
> >>  union qcom_pcie_resources {
> >>  	struct qcom_pcie_resources_1_0_0 v1_0_0;
> >>  	struct qcom_pcie_resources_2_1_0 v2_1_0;
> >> @@ -178,6 +187,7 @@ union qcom_pcie_resources {
> >>  	struct qcom_pcie_resources_2_3_3 v2_3_3;
> >>  	struct qcom_pcie_resources_2_4_0 v2_4_0;
> >>  	struct qcom_pcie_resources_2_7_0 v2_7_0;
> >> +	struct qcom_pcie_resources_2_9_0 v2_9_0;
> >>  };
> >>  
> >>  struct qcom_pcie;
> >> @@ -1297,6 +1307,127 @@ static void qcom_pcie_post_deinit_2_7_0(struct qcom_pcie *pcie)
> >>  	clk_disable_unprepare(res->pipe_clk);
> >>  }
> >>  
> >> +static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
> >> +{
> >> +	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
> >> +	struct dw_pcie *pci = pcie->pci;
> >> +	struct device *dev = pci->dev;
> >> +	int ret;
> >> +
> >> +	res->clks[0].id = "iface";
> >> +	res->clks[1].id = "axi_m";
> >> +	res->clks[2].id = "axi_s";
> >> +	res->clks[3].id = "axi_bridge";
> >> +	res->clks[4].id = "rchng";
> >> +
> >> +	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	res->rst = devm_reset_control_array_get_exclusive(dev);
> >> +	if (IS_ERR(res->rst))
> >> +		return PTR_ERR(res->rst);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static void qcom_pcie_deinit_2_9_0(struct qcom_pcie *pcie)
> >> +{
> >> +	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
> >> +
> >> +	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
> >> +}
> >> +
> >> +static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
> >> +{
> >> +	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
> >> +	struct device *dev = pcie->pci->dev;
> >> +	int ret;
> >> +
> >> +	ret = reset_control_assert(res->rst);
> >> +	if (ret) {
> >> +		dev_err(dev, "reset assert failed (%d)\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	usleep_range(2000, 2500);
> >> +
> >> +	ret = reset_control_deassert(res->rst);
> >> +	if (ret) {
> >> +		dev_err(dev, "reset deassert failed (%d)\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	/*
> >> +	 * Don't have a way to see if the reset has completed.
> >> +	 * Wait for some time.
> >
> > Is this arbitrary ? What does this reset represent ?
> 
> I have no idea. I'm just porting working downstream kernel code, and I
> have no access to hardware documentation.
> 

The reset here doesn't literally reset the device, it will assert (hold)
the reset line, then sleep 2ms, then deassert (release) it and the sleep
below will ensure that we don't enable the clocks etc until the hardware
has been given 2ms to "recover".

So it's not a matter of us waiting because we don't know how to check,
it's a matter of following the datasheet stating the minimum timing of
the operations to be performed to get the PCIe controller into a known
(clean) state..


I'm slightly puzzled to why this matters if the clocks are off, but if
you're porting downstream code, my suggestion is that you should just
omit the comment.

> Note that some other variants also add delays before or after reset
> deassert:
> 
>   qcom_pcie_init_2_4_0()
> 
>   qcom_pcie_init_2_3_3()
> 
>   qcom_pcie_init_2_7_0()
> 
> baruch
> 
> >> +	 */
> >> +	usleep_range(2000, 2500);
> >> +
> >> +	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
> >> +	if (ret)
> >> +		goto err_reset;
> >> +
> >> +	return 0;
> >> +
> >> +	/*
> >> +	 * Not checking for failure, will anyway return
> >> +	 * the original failure in 'ret'.
> >> +	 */

I think you can omit this comment as well. You failed to enable the
clocks and you want to inform the caller about that error.

Also, you're asserting the reset line to put the hardware in reset
again, if that fails there's not much to do.

Regards,
Bjorn

> >> +err_reset:
> >> +	reset_control_assert(res->rst);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
> >> +{
> >> +	struct dw_pcie *pci = pcie->pci;
> >> +	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> >> +	u32 val;
> >> +	int i;
> >> +
> >> +	writel(SLV_ADDR_SPACE_SZ,
> >> +		pcie->parf + PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE);
> >> +
> >> +	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> >> +	val &= ~BIT(0);
> >> +	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> >> +
> >> +	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> >> +
> >> +	writel(DEVICE_TYPE_RC, pcie->parf + PCIE20_PARF_DEVICE_TYPE);
> >> +	writel(BYPASS | MSTR_AXI_CLK_EN | AHB_CLK_EN,
> >> +		pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> >> +	writel(GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS
> >> +		| GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL,
> >> +		pci->dbi_base + GEN3_RELATED_OFF);
> >> +
> >> +	writel(MST_WAKEUP_EN | SLV_WAKEUP_EN | MSTR_ACLK_CGC_DIS
> >> +		| SLV_ACLK_CGC_DIS | CORE_CLK_CGC_DIS |
> >> +		AUX_PWR_DET | L23_CLK_RMV_DIS | L1_CLK_RMV_DIS,
> >> +		pcie->parf + PCIE20_PARF_SYS_CTRL);
> >> +
> >> +	writel(0, pcie->parf + PCIE20_PARF_Q2A_FLUSH);
> >> +
> >> +	dw_pcie_dbi_ro_wr_en(pci);
> >> +	writel(PCIE_CAP_LINK1_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
> >> +
> >> +	/* Configure PCIe link capabilities for ASPM */
> >> +	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
> >> +	val &= ~PCI_EXP_LNKCAP_ASPMS;
> >> +	writel(val, pci->dbi_base + offset + PCI_EXP_LNKCAP);
> >> +
> >> +	writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base + offset +
> >> +			PCI_EXP_DEVCTL2);
> >> +
> >> +	for (i = 0; i < 256; i++)
> >> +		writel(0x0, pcie->parf + PCIE20_PARF_BDF_TO_SID_TABLE_N
> >> +				+ (4 * i));
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  static int qcom_pcie_link_up(struct dw_pcie *pci)
> >>  {
> >>  	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> >> @@ -1487,6 +1618,15 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
> >>  	.config_sid = qcom_pcie_config_sid_sm8250,
> >>  };
> >>  
> >> +/* Qcom IP rev.: 2.9.0  Synopsys IP rev.: 5.00a */
> >> +static const struct qcom_pcie_ops ops_2_9_0 = {
> >> +	.get_resources = qcom_pcie_get_resources_2_9_0,
> >> +	.init = qcom_pcie_init_2_9_0,
> >> +	.post_init = qcom_pcie_post_init_2_9_0,
> >> +	.deinit = qcom_pcie_deinit_2_9_0,
> >> +	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> >> +};
> >> +
> >>  static const struct qcom_pcie_cfg apq8084_cfg = {
> >>  	.ops = &ops_1_0_0,
> >>  };
> >> @@ -1520,6 +1660,10 @@ static const struct qcom_pcie_cfg sc7280_cfg = {
> >>  	.pipe_clk_need_muxing = true,
> >>  };
> >>  
> >> +static const struct qcom_pcie_cfg ipq6018_cfg = {
> >> +	.ops = &ops_2_9_0,
> >> +};
> >> +
> >>  static const struct dw_pcie_ops dw_pcie_ops = {
> >>  	.link_up = qcom_pcie_link_up,
> >>  	.start_link = qcom_pcie_start_link,
> >> @@ -1629,6 +1773,7 @@ static const struct of_device_id qcom_pcie_match[] = {
> >>  	{ .compatible = "qcom,pcie-sm8250", .data = &sm8250_cfg },
> >>  	{ .compatible = "qcom,pcie-sc8180x", .data = &sm8250_cfg },
> >>  	{ .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },
> >> +	{ .compatible = "qcom,pcie-ipq6018", .data = &ipq6018_cfg },
> >>  	{ }
> >>  };
> >>  
> >> -- 
> >> 2.34.1
> >> 
> 
> 
> -- 
>                                                      ~. .~   Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>    - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
