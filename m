Return-Path: <linux-pci+bounces-1604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8315C82200A
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 18:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E575D1F2204D
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 17:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C47B15493;
	Tue,  2 Jan 2024 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSFnBOTE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382DB156F8;
	Tue,  2 Jan 2024 17:08:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FCDC433C7;
	Tue,  2 Jan 2024 17:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704215284;
	bh=Vh7w2Zm7IPKpg3RcIIgKY9vwrmakmJ0aX6srxDGwVyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cSFnBOTEKpnf4UcrIpY77YNDqkZHRmqkyJ6pkhJTiQfsoFM5rEd0Xm2NfuVZ8XRBQ
	 8c3m0Yi0gxXzhu8XRQQKi4CbPo4gUxYBZU4R45xzsDhkja4/fQcYecs7jkRy/IXevr
	 RMbrizQXkucVLYt3DGTwH9CpYGcdob4Glhl3sTXXhBg2Qt1UCTQlz9PuNYxDjrDMg+
	 K+ML+1WtLx2LftKvRWBnnwZtnQV6nAKqlz69rIvlxUZ7bz9j5b6whtF4f+19G/hMIL
	 iAxcoka1U8VZu3dqs08zIWZ0xGMiySqMsHVFv9Gungo/SIEi/148tAsrxT6P0vkno6
	 YkY2fDmX+BKpw==
Date: Tue, 2 Jan 2024 22:37:49 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Vinod Koul <vkoul@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH 4/4] PCI: qcom: Implement RC shutdown/power up
Message-ID: <20240102170749.GF4917@thinkpad>
References: <20231227-topic-8280_pcie-v1-0-095491baf9e4@linaro.org>
 <20231227-topic-8280_pcie-v1-4-095491baf9e4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231227-topic-8280_pcie-v1-4-095491baf9e4@linaro.org>

On Wed, Dec 27, 2023 at 11:17:22PM +0100, Konrad Dybcio wrote:
> Currently, we've only been minimizing the power draw while keeping the
> RC up at all times. This is suboptimal, as it draws a whole lot of power
> and prevents the SoC from power collapsing.
> 
> Implement full shutdown and re-initialization to allow for powering off
> the controller.
> 
> This is mainly intended for v1_9_0 (sc8280xp), but the hardware is rather
> similar across the board. More platform-specific details may be added in
> the future as necessary.
> 
> Co-developed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

There should be s-o-b for Bjorn also.

> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Before going into the patch, I should ask you how you are dealing with properly
powering down the PCIe device drivers before pulling the plug here.

- Mani

> ---
>  drivers/pci/controller/dwc/Kconfig     |   1 +
>  drivers/pci/controller/dwc/pcie-qcom.c | 132 +++++++++++++++++++++++++--------
>  2 files changed, 102 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 5ac021dbd46a..591c4109ed62 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -268,6 +268,7 @@ config PCIE_DW_PLAT_EP
>  config PCIE_QCOM
>  	bool "Qualcomm PCIe controller (host mode)"
>  	depends on OF && (ARCH_QCOM || COMPILE_TEST)
> +	depends on QCOM_COMMAND_DB || QCOM_COMMAND_DB=n
>  	depends on PCI_MSI
>  	select PCIE_DW_HOST
>  	select CRC8
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 3d77269e70da..a9e24fcd1f66 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -30,13 +30,18 @@
>  #include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> +#include <soc/qcom/cmd-db.h>
>  
>  #include "../../pci.h"
>  #include "pcie-designware.h"
>  
> +#include <dt-bindings/interconnect/qcom,icc.h>
> +#include <dt-bindings/interconnect/qcom,rpm-icc.h>
> +
>  /* PARF registers */
>  #define PARF_SYS_CTRL				0x00
>  #define PARF_PM_CTRL				0x20
> +#define PARF_PM_STTS				0x24
>  #define PARF_PCS_DEEMPH				0x34
>  #define PARF_PCS_SWING				0x38
>  #define PARF_PHY_CTRL				0x40
> @@ -80,7 +85,10 @@
>  #define L1_CLK_RMV_DIS				BIT(1)
>  
>  /* PARF_PM_CTRL register fields */
> -#define REQ_NOT_ENTR_L1				BIT(5)
> +#define REQ_NOT_ENTR_L1				BIT(5) /* "Prevent L0->L1" */
> +
> +/* PARF_PM_STTS register fields */
> +#define PM_ENTER_L23				BIT(5)
>  
>  /* PARF_PCS_DEEMPH register fields */
>  #define PCS_DEEMPH_TX_DEEMPH_GEN1(x)		FIELD_PREP(GENMASK(21, 16), x)
> @@ -122,6 +130,7 @@
>  
>  /* ELBI_SYS_CTRL register fields */
>  #define ELBI_SYS_CTRL_LT_ENABLE			BIT(0)
> +#define ELBI_SYS_CTRL_PME_TURNOFF_MSG		BIT(4)
>  
>  /* AXI_MSTR_RESP_COMP_CTRL0 register fields */
>  #define CFG_REMOTE_RD_REQ_BRIDGE_SIZE_2K	0x4
> @@ -244,6 +253,7 @@ struct qcom_pcie {
>  	const struct qcom_pcie_cfg *cfg;
>  	struct dentry *debugfs;
>  	bool suspended;
> +	bool soc_is_rpmh;
>  };
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> @@ -273,6 +283,24 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
>  	return 0;
>  }
>  
> +static int qcom_pcie_stop_link(struct dw_pcie *pci)
> +{
> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> +	u32 ret_l23, val;
> +
> +	writel(ELBI_SYS_CTRL_PME_TURNOFF_MSG, pcie->elbi + ELBI_SYS_CTRL);
> +	readl(pcie->elbi + ELBI_SYS_CTRL);
> +
> +	ret_l23 = readl_poll_timeout(pcie->parf + PARF_PM_STTS, val,
> +				     val & PM_ENTER_L23, 10000, 100000);
> +	if (ret_l23) {
> +		dev_err(pci->dev, "Failed to enter L2/L3\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
>  static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
>  {
>  	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> @@ -991,9 +1019,19 @@ static void qcom_pcie_host_post_init_2_7_0(struct qcom_pcie *pcie)
>  static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
>  {
>  	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> +	u32 val;
> +
> +	/* Disable PCIe clocks and resets */
> +	val = readl(pcie->parf + PARF_PHY_CTRL);
> +	val |= PHY_TEST_PWR_DOWN;
> +	writel(val, pcie->parf + PARF_PHY_CTRL);
> +	readl(pcie->parf + PARF_PHY_CTRL);
>  
>  	clk_bulk_disable_unprepare(res->num_clks, res->clks);
>  
> +	reset_control_assert(res->rst);
> +	usleep_range(2000, 2500);
> +
>  	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
>  }
>  
> @@ -1553,6 +1591,9 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_phy_exit;
>  	}
>  
> +	/* If the soc features RPMh, cmd_db must have been prepared by now */
> +	pcie->soc_is_rpmh = !cmd_db_ready();
> +
>  	qcom_pcie_icc_update(pcie);
>  
>  	if (pcie->mhi)
> @@ -1569,60 +1610,89 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int qcom_pcie_suspend_noirq(struct device *dev)
> +static int qcom_pcie_resume_noirq(struct device *dev)
>  {
>  	struct qcom_pcie *pcie = dev_get_drvdata(dev);
>  	int ret;
>  
>  	/*
> -	 * Set minimum bandwidth required to keep data path functional during
> -	 * suspend.
> +	 * Undo the tag change from qcom_pcie_suspend_noirq first in case
> +	 * RPM(h) spontaneously decides to power collapse the platform based
> +	 * on other inputs.
>  	 */
> -	ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
> +	icc_set_tag(pcie->icc_mem, pcie->soc_is_rpmh ? QCOM_ICC_TAG_ALWAYS : RPM_ALWAYS_TAG);
> +	/* Flush the tag change */
> +	ret = icc_set_bw(pcie->icc_mem, 0, pcie->last_bw);
>  	if (ret) {
> -		dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
> +		dev_err(pcie->pci->dev, "failed to set interconnect bandwidth: %d\n", ret);
>  		return ret;
>  	}
>  
> -	pcie->last_bw = kBps_to_icc(1);
> +	/* Only check this now to make sure the icc vote is in before going furhter. */
> +	if (!pcie->suspended)
> +		return 0;
>  
> -	/*
> -	 * Turn OFF the resources only for controllers without active PCIe
> -	 * devices. For controllers with active devices, the resources are kept
> -	 * ON and the link is expected to be in L0/L1 (sub)states.
> -	 *
> -	 * Turning OFF the resources for controllers with active PCIe devices
> -	 * will trigger access violation during the end of the suspend cycle,
> -	 * as kernel tries to access the PCIe devices config space for masking
> -	 * MSIs.
> -	 *
> -	 * Also, it is not desirable to put the link into L2/L3 state as that
> -	 * implies VDD supply will be removed and the devices may go into
> -	 * powerdown state. This will affect the lifetime of the storage devices
> -	 * like NVMe.
> -	 */
> -	if (!dw_pcie_link_up(pcie->pci)) {
> -		qcom_pcie_host_deinit(&pcie->pci->pp);
> -		pcie->suspended = true;
> -	}
> +	ret = qcom_pcie_host_init(&pcie->pci->pp);
> +	if (ret)
> +		goto revert_icc_tag;
> +
> +	dw_pcie_setup_rc(&pcie->pci->pp);
> +
> +	ret = qcom_pcie_start_link(pcie->pci);
> +	if (ret)
> +		goto deinit_host;
> +
> +	/* Ignore the retval, the devices may come up later. */
> +	dw_pcie_wait_for_link(pcie->pci);
> +
> +	qcom_pcie_icc_update(pcie);
> +
> +	pcie->suspended = false;
>  
>  	return 0;
> +
> +deinit_host:
> +	qcom_pcie_host_deinit(&pcie->pci->pp);
> +revert_icc_tag:
> +	icc_set_tag(pcie->icc_mem, pcie->soc_is_rpmh ? QCOM_ICC_TAG_WAKE : RPM_ACTIVE_TAG);
> +	/* Ignore the retval, failing here would be tragic anyway.. */
> +	icc_set_bw(pcie->icc_mem, 0, pcie->last_bw);
> +
> +	return ret;
>  }
>  
> -static int qcom_pcie_resume_noirq(struct device *dev)
> +static int qcom_pcie_suspend_noirq(struct device *dev)
>  {
>  	struct qcom_pcie *pcie = dev_get_drvdata(dev);
>  	int ret;
>  
> -	if (pcie->suspended) {
> -		ret = qcom_pcie_host_init(&pcie->pci->pp);
> +	if (pcie->suspended)
> +		return 0;
> +
> +	if (dw_pcie_link_up(pcie->pci)) {
> +		ret = qcom_pcie_stop_link(pcie->pci);
>  		if (ret)
>  			return ret;
> +	}
>  
> -		pcie->suspended = false;
> +	qcom_pcie_host_deinit(&pcie->pci->pp);
> +
> +	/*
> +	 * The PCIe RC may be covertly accessed by the secure firmware on sleep exit.
> +	 * Use the WAKE bucket to let RPMh pull the plug on PCIe in sleep,
> +	 * but guarantee it comes back for resume.
> +	 */
> +	icc_set_tag(pcie->icc_mem, pcie->soc_is_rpmh ? QCOM_ICC_TAG_WAKE : RPM_ACTIVE_TAG);
> +	/* Flush the tag change */
> +	ret = icc_set_bw(pcie->icc_mem, 0, pcie->last_bw);
> +	if (ret) {
> +		dev_err(pcie->pci->dev, "failed to set interconnect bandwidth: %d\n", ret);
> +
> +		/* Revert everything and hope the next icc_set_bw goes through.. */
> +		return qcom_pcie_resume_noirq(dev);
>  	}
>  
> -	qcom_pcie_icc_update(pcie);
> +	pcie->suspended = true;
>  
>  	return 0;
>  }
> 
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

