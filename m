Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84D042D223
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 08:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbhJNGMg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 02:12:36 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:44220 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229502AbhJNGMf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Oct 2021 02:12:35 -0400
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 47495440E8C;
        Thu, 14 Oct 2021 09:09:38 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1634191778;
        bh=b3FjnC6Y05E5hG5u3UIiVVSTKHITQy5TaKb0+qkPMHo=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=EkK+bQ6dLelKGXty+O3shrKajc+SRM/F8Tov9GQE0qKKNc2QWqNDqqct473FiT6Ej
         iWF1hLf5jhG6LtEoatWX8avuipSwNr0+EXp5aNedq3Gq2shLqJDYmXPrjHUW2L1M5o
         CFcnJJDRNsFOiQtSDEXUhEM93wWyfV51K79rzbI9AiWEQCVmSGEddAq2iZF0+KNq7l
         gv0EnOhcB/FhGxK27QhsxZ6dzKcycEK+Ao3/OwkWuFtHyq0NnLeCV97qOHILyHpX2N
         PVhgsTlcJhF2WawXtBaM4hzD10TO8QGeXxWotIa1tnMbZp+SDgrXsNlacAa96o3PPQ
         Uj2aOobOk/twQ==
References: <cover.1630311481.git.baruch@tkos.co.il>
 <af067a193527e8d2bdbcc8b76e256eef87f6db06.1630311481.git.baruch@tkos.co.il>
User-agent: mu4e 1.6.6; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/3] PCI: qcom: add support for IPQ60xx PCIe controller
Date:   Thu, 14 Oct 2021 09:02:32 +0300
In-reply-to: <af067a193527e8d2bdbcc8b76e256eef87f6db06.1630311481.git.baruch@tkos.co.il>
Message-ID: <87lf2wkugd.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andy, Bjorn,

On Mon, Aug 30 2021, Baruch Siach wrote:
> From: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
>
> IPQ60xx series of SoCs have one port of PCIe gen 3. Add support for that
> platform.
>
> The code is based on downstream[1] Codeaurora kernel v5.4 (branch
> win.linuxopenwrt.2.0).
>
> Split out the DBI registers access part from .init into .post_init. DBI
> registers are only accessible after phy_power_on().
>
> [1] https://source.codeaurora.org/quic/qsdk/oss/kernel/linux-ipq-5.4/

Can I get your ack on this? DT bits are already in Linus' tree, as well
as the PHY. So this is the only missing part for IPQ60xx PCIe support.

Thanks,
baruch

>
> Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v3:
>   * Drop speed setup; rely on generic code (Rob Herring)
>
>   * Drop unused CLK_RATE macros (Bjorn Helgaas)
>
>   * Minor formatting fixes (Bjorn Helgaas)
>
>   * Add reference to downstream Codeaurora kernel tree (Bjorn Helgaas)
>
> v2:
>   * Drop ATU configuration; rely on common code instead
>
>   * Use more common register macros
>
>   * Use bulk clk and reset APIs
> ---
>  drivers/pci/controller/dwc/pcie-designware.h |   1 +
>  drivers/pci/controller/dwc/pcie-qcom.c       | 141 +++++++++++++++++++
>  2 files changed, 142 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index ea87809ee298..279c3778a13b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -76,6 +76,7 @@
>  
>  #define GEN3_RELATED_OFF			0x890
>  #define GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL	BIT(0)
> +#define GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS	BIT(13)
>  #define GEN3_RELATED_OFF_GEN3_EQ_DISABLE	BIT(16)
>  #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
>  #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 8a7a300163e5..cb53fd574621 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -52,6 +52,10 @@
>  #define PCIE20_PARF_DBI_BASE_ADDR		0x168
>  #define PCIE20_PARF_SLV_ADDR_SPACE_SIZE		0x16C
>  #define PCIE20_PARF_MHI_CLOCK_RESET_CTRL	0x174
> +#define AHB_CLK_EN				BIT(0)
> +#define MSTR_AXI_CLK_EN				BIT(1)
> +#define BYPASS					BIT(4)
> +
>  #define PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT	0x178
>  #define PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2	0x1A8
>  #define PCIE20_PARF_LTSSM			0x1B0
> @@ -168,6 +172,11 @@ struct qcom_pcie_resources_2_7_0 {
>  	struct clk *pipe_clk;
>  };
>  
> +struct qcom_pcie_resources_2_9_0 {
> +	struct clk_bulk_data clks[5];
> +	struct reset_control *rst;
> +};
> +
>  union qcom_pcie_resources {
>  	struct qcom_pcie_resources_1_0_0 v1_0_0;
>  	struct qcom_pcie_resources_2_1_0 v2_1_0;
> @@ -175,6 +184,7 @@ union qcom_pcie_resources {
>  	struct qcom_pcie_resources_2_3_3 v2_3_3;
>  	struct qcom_pcie_resources_2_4_0 v2_4_0;
>  	struct qcom_pcie_resources_2_7_0 v2_7_0;
> +	struct qcom_pcie_resources_2_9_0 v2_9_0;
>  };
>  
>  struct qcom_pcie;
> @@ -1266,6 +1276,127 @@ static void qcom_pcie_post_deinit_2_7_0(struct qcom_pcie *pcie)
>  	clk_disable_unprepare(res->pipe_clk);
>  }
>  
> +static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
> +	struct dw_pcie *pci = pcie->pci;
> +	struct device *dev = pci->dev;
> +	int ret;
> +
> +	res->clks[0].id = "iface";
> +	res->clks[1].id = "axi_m";
> +	res->clks[2].id = "axi_s";
> +	res->clks[3].id = "axi_bridge";
> +	res->clks[4].id = "rchng";
> +
> +	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
> +	if (ret < 0)
> +		return ret;
> +
> +	res->rst = devm_reset_control_array_get_exclusive(dev);
> +	if (IS_ERR(res->rst))
> +		return PTR_ERR(res->rst);
> +
> +	return 0;
> +}
> +
> +static void qcom_pcie_deinit_2_9_0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
> +
> +	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
> +}
> +
> +static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
> +	struct device *dev = pcie->pci->dev;
> +	int ret;
> +
> +	ret = reset_control_assert(res->rst);
> +	if (ret) {
> +		dev_err(dev, "reset assert failed (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	usleep_range(2000, 2500);
> +
> +	ret = reset_control_deassert(res->rst);
> +	if (ret) {
> +		dev_err(dev, "reset deassert failed (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Don't have a way to see if the reset has completed.
> +	 * Wait for some time.
> +	 */
> +	usleep_range(2000, 2500);
> +
> +	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
> +	if (ret)
> +		goto err_reset;
> +
> +	return 0;
> +
> +	/*
> +	 * Not checking for failure, will anyway return
> +	 * the original failure in 'ret'.
> +	 */
> +err_reset:
> +	reset_control_assert(res->rst);
> +
> +	return ret;
> +}
> +
> +static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	u32 val;
> +	int i;
> +
> +	writel(SLV_ADDR_SPACE_SZ,
> +		pcie->parf + PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE);
> +
> +	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> +	val &= ~BIT(0);
> +	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> +
> +	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> +
> +	writel(DEVICE_TYPE_RC, pcie->parf + PCIE20_PARF_DEVICE_TYPE);
> +	writel(BYPASS | MSTR_AXI_CLK_EN | AHB_CLK_EN,
> +		pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> +	writel(GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS
> +		| GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL,
> +		pci->dbi_base + GEN3_RELATED_OFF);
> +
> +	writel(MST_WAKEUP_EN | SLV_WAKEUP_EN | MSTR_ACLK_CGC_DIS
> +		| SLV_ACLK_CGC_DIS | CORE_CLK_CGC_DIS |
> +		AUX_PWR_DET | L23_CLK_RMV_DIS | L1_CLK_RMV_DIS,
> +		pcie->parf + PCIE20_PARF_SYS_CTRL);
> +
> +	writel(0, pcie->parf + PCIE20_PARF_Q2A_FLUSH);
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +	writel(PCIE_CAP_LINK1_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
> +
> +	/* Configure PCIe link capabilities for ASPM */
> +	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
> +	val &= ~PCI_EXP_LNKCAP_ASPMS;
> +	writel(val, pci->dbi_base + offset + PCI_EXP_LNKCAP);
> +
> +	writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base + offset +
> +			PCI_EXP_DEVCTL2);
> +
> +	for (i = 0; i < 256; i++)
> +		writel(0x0, pcie->parf + PCIE20_PARF_BDF_TO_SID_TABLE_N
> +				+ (4 * i));
> +
> +	return 0;
> +}
> +
>  static int qcom_pcie_link_up(struct dw_pcie *pci)
>  {
>  	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> @@ -1456,6 +1587,15 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
>  	.config_sid = qcom_pcie_config_sid_sm8250,
>  };
>  
> +/* Qcom IP rev.: 2.9.0  Synopsys IP rev.: 5.00a */
> +static const struct qcom_pcie_ops ops_2_9_0 = {
> +	.get_resources = qcom_pcie_get_resources_2_9_0,
> +	.init = qcom_pcie_init_2_9_0,
> +	.post_init = qcom_pcie_post_init_2_9_0,
> +	.deinit = qcom_pcie_deinit_2_9_0,
> +	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> +};
> +
>  static const struct dw_pcie_ops dw_pcie_ops = {
>  	.link_up = qcom_pcie_link_up,
>  	.start_link = qcom_pcie_start_link,
> @@ -1555,6 +1695,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-qcs404", .data = &ops_2_4_0 },
>  	{ .compatible = "qcom,pcie-sdm845", .data = &ops_2_7_0 },
>  	{ .compatible = "qcom,pcie-sm8250", .data = &ops_1_9_0 },
> +	{ .compatible = "qcom,pcie-ipq6018", .data = &ops_2_9_0 },
>  	{ }
>  };


-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
