Return-Path: <linux-pci+bounces-3746-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 281F085B1DD
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 05:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0496BB227AC
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 04:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3AE53E3B;
	Tue, 20 Feb 2024 04:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R9V6B11+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05971E480;
	Tue, 20 Feb 2024 04:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708402391; cv=none; b=NDIcKqEhav0a8PAnOrEPXl64icndiBJ/Bp/Io/DEtY2w7kLna77wwSki9jCFeVOd8k46AkrVXjgHMLiF9PtT9y3SePesp9Hb/r2t5f8jR8RHmMrWxhBoA6gAgk13pyGFY4ALsZUsfQl5Sr9vXlVd+X2gg/2e43PA1cQbp9aH99M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708402391; c=relaxed/simple;
	bh=1CJx60QByZXdPBCAWLPc+lHQU+iK6zJfyZMKkza44Oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JnhB0VpIPZ/ztTAe1u6rrF658K1zXoVeS0Ok2WY7C8LcegBe69U8wrdoXt4pgwFqsgCxqRtaO5/RHAU44U2udHBgr/IcUdHtgP7A3XdVQbRlaUWpDq79vOSGYnKUjGxWGJT6gSy9zE6JcPhP56pfAYK7wfKDau5u6jjrzCzrU9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R9V6B11+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41K3MFL3030150;
	Tue, 20 Feb 2024 04:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=k9TGXgHqR537hv7YITq1dq2LZ4ixRDqdvBuzBWzXrKs=; b=R9
	V6B11+ilPkNP9436BlOHlxQdRVZ2PTipgnz5X9UPw/NWy3rms7+0hjK/79NfKAXI
	BC/UP5qW/8FBfsfUYj8jdJaIvpKsiWkHMEwtE1ESZA/CJ1qRvNDTcuL4hsCpo2fW
	rR1BjyOUxELghtvWpCY/7UE+lqMTM5iiW9PS5Q5Yx5TxsBl9drMNssDpkQXA+EzL
	uKsuHfCke8z7PGsvr7G98eNff7hZBIUFnQYUTHbpe2SYW2rJ3lOpDEesgdHVdf7T
	AEZkRKmayblarBxfFZrp8G73T3IuKzB5WXSezk84QLFEJaNId3cDPwAcJ/JviSOr
	nSVJ4Vl36hHOZCC8f/jw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wc2bxj5eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 04:12:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41K4CmMS022259
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 04:12:48 GMT
Received: from [10.216.36.13] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 19 Feb
 2024 20:12:44 -0800
Message-ID: <39f28d21-e178-68df-c7b6-eef30f0584e3@quicinc.com>
Date: Tue, 20 Feb 2024 09:42:41 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 3/3] PCI: qcom: properly implement RC shutdown/power up
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Johan Hovold <johan+linaro@kernel.org>,
        "Bjorn Andersson" <quic_bjorande@quicinc.com>
References: <20240210-topic-8280_pcie-v2-0-1cef4b606883@linaro.org>
 <20240210-topic-8280_pcie-v2-3-1cef4b606883@linaro.org>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240210-topic-8280_pcie-v2-3-1cef4b606883@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ygIgGV9J_ttBq5PhA7CDXLqZcFviHfU8
X-Proofpoint-GUID: ygIgGV9J_ttBq5PhA7CDXLqZcFviHfU8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_03,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402200028



On 2/10/2024 10:40 PM, Konrad Dybcio wrote:
> Currently, we've only been minimizing the power draw while keeping the
> RC up at all times. This is suboptimal, as it draws a whole lot of power
> and prevents the SoC from power collapsing.
> 
> Implement full shutdown and re-initialization to allow for powering off
> the controller.
> 
> This is mainly indended for SC8280XP with a broken power rail setup,
> which requires a full RC shutdown/reinit in order to reach SoC-wide
> power collapse, but sleeping is generally better than not sleeping and
> less destructive suspend can be implemented later for platforms that
> support it.
> 
> Co-developed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/pci/controller/dwc/Kconfig     |   1 +
>   drivers/pci/controller/dwc/pcie-qcom.c | 159 ++++++++++++++++++++++++++-------
>   2 files changed, 126 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 8afacc90c63b..4ce266951cb6 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -268,6 +268,7 @@ config PCIE_DW_PLAT_EP
>   config PCIE_QCOM
>   	bool "Qualcomm PCIe controller (host mode)"
>   	depends on OF && (ARCH_QCOM || COMPILE_TEST)
> +	depends on QCOM_COMMAND_DB || QCOM_COMMAND_DB=n
>   	depends on PCI_MSI
>   	select PCIE_DW_HOST
>   	select CRC8
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 6a469ed213ce..c807833ee4a7 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -30,13 +30,18 @@
>   #include <linux/reset.h>
>   #include <linux/slab.h>
>   #include <linux/types.h>
> +#include <soc/qcom/cmd-db.h>
>   
>   #include "../../pci.h"
>   #include "pcie-designware.h"
>   
> +#include <dt-bindings/interconnect/qcom,icc.h>
> +#include <dt-bindings/interconnect/qcom,rpm-icc.h>
> +
>   /* PARF registers */
>   #define PARF_SYS_CTRL				0x00
>   #define PARF_PM_CTRL				0x20
> +#define PARF_PM_STTS				0x24
>   #define PARF_PCS_DEEMPH				0x34
>   #define PARF_PCS_SWING				0x38
>   #define PARF_PHY_CTRL				0x40
> @@ -80,7 +85,10 @@
>   #define L1_CLK_RMV_DIS				BIT(1)
>   
>   /* PARF_PM_CTRL register fields */
> -#define REQ_NOT_ENTR_L1				BIT(5)
> +#define REQ_NOT_ENTR_L1				BIT(5) /* "Prevent L0->L1" */
> +
> +/* PARF_PM_STTS register fields */
> +#define PM_ENTER_L23				BIT(5)
>   
>   /* PARF_PCS_DEEMPH register fields */
>   #define PCS_DEEMPH_TX_DEEMPH_GEN1(x)		FIELD_PREP(GENMASK(21, 16), x)
> @@ -122,6 +130,7 @@
>   
>   /* ELBI_SYS_CTRL register fields */
>   #define ELBI_SYS_CTRL_LT_ENABLE			BIT(0)
> +#define ELBI_SYS_CTRL_PME_TURNOFF_MSG		BIT(4)
>   
>   /* AXI_MSTR_RESP_COMP_CTRL0 register fields */
>   #define CFG_REMOTE_RD_REQ_BRIDGE_SIZE_2K	0x4
> @@ -243,6 +252,7 @@ struct qcom_pcie {
>   	const struct qcom_pcie_cfg *cfg;
>   	struct dentry *debugfs;
>   	bool suspended;
> +	bool soc_is_rpmh;
>   };
>   
>   #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> @@ -272,6 +282,24 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
>   	return 0;
>   }
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
>   static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
>   {
>   	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> @@ -987,9 +1015,19 @@ static void qcom_pcie_host_post_init_2_7_0(struct qcom_pcie *pcie)
>   static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
>   {
>   	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> +	u32 val;
> +
> +	/* Disable PCIe clocks and resets */
> +	val = readl(pcie->parf + PARF_PHY_CTRL);
> +	val |= PHY_TEST_PWR_DOWN;
> +	writel(val, pcie->parf + PARF_PHY_CTRL);
> +	readl(pcie->parf + PARF_PHY_CTRL);
>   
>   	clk_bulk_disable_unprepare(res->num_clks, res->clks);
>   
> +	reset_control_assert(res->rst);
> +	usleep_range(2000, 2500);
> +
>   	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
>   }
>   
> @@ -1545,6 +1583,9 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>   		goto err_phy_exit;
>   	}
>   
> +	/* If the soc features RPMh, cmd_db must have been prepared by now */
> +	pcie->soc_is_rpmh = !cmd_db_ready();
> +
>   	qcom_pcie_icc_update(pcie);
>   
>   	if (pcie->mhi)
> @@ -1561,58 +1602,108 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>   	return ret;
>   }
>   
> -static int qcom_pcie_suspend_noirq(struct device *dev)
> +static int qcom_pcie_resume_noirq(struct device *dev)
>   {
>   	struct qcom_pcie *pcie = dev_get_drvdata(dev);
>   	int ret;
>   
> -	/*
> -	 * Set minimum bandwidth required to keep data path functional during
> -	 * suspend.
> -	 */
> -	ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
> -	if (ret) {
> -		dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
> -		return ret;
> +	if (pcie->soc_is_rpmh) {
> +		/*
> +		 * Undo the tag change from qcom_pcie_suspend_noirq first in
> +		 * case RPMh spontaneously decides to power collapse the
> +		 * platform based on other inputs.
> +		 */
> +		icc_set_tag(pcie->icc_mem, QCOM_ICC_TAG_ALWAYS);
> +
> +		/* Flush the tag change */
> +		ret = icc_enable(pcie->icc_mem);
> +		if (ret) {
> +			dev_err(pcie->pci->dev, "failed to icc_enable: %d", ret);
> +			return ret;
> +		}
>   	}
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
> +	/* Only check this now to make sure the icc tag has been set. */
> +	if (!pcie->suspended)
> +		return 0;
> +
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
>   	return 0;
> +
> +deinit_host:
> +	qcom_pcie_host_deinit(&pcie->pci->pp);
> +revert_icc_tag:
> +	if (pcie->soc_is_rpmh) {
> +		icc_set_tag(pcie->icc_mem, QCOM_ICC_TAG_WAKE);
> +
> +		/* Ignore the retval, failing here would be tragic anyway.. */
> +		icc_enable(pcie->icc_mem);
> +	}
> +
> +	return ret;
>   }
>   
> -static int qcom_pcie_resume_noirq(struct device *dev)
> +static int qcom_pcie_suspend_noirq(struct device *dev)
>   {
>   	struct qcom_pcie *pcie = dev_get_drvdata(dev);
>   	int ret;
>   
> -	if (pcie->suspended) {
> -		ret = qcom_pcie_host_init(&pcie->pci->pp);
> +	if (pcie->suspended)
> +		return 0;
> +
> +	if (dw_pcie_link_up(pcie->pci)) {
> +		ret = qcom_pcie_stop_link(pcie->pci);
>   		if (ret)
>   			return ret;
> +	}
>   
> -		pcie->suspended = false;
> +	qcom_pcie_host_deinit(&pcie->pci->pp);
> +
> +	if (pcie->soc_is_rpmh) {
> +		/*
> +		 * The PCIe RC may be covertly accessed by the secure firmware
> +		 * on sleep exit. Use the WAKE bucket to let RPMh pull the plug
> +		 * on PCIe in sleep, but guarantee it comes back up for resume.
> +		 */
> +		icc_set_tag(pcie->icc_mem, QCOM_ICC_TAG_WAKE);
> +
> +		/* Flush the tag change */
> +		ret = icc_enable(pcie->icc_mem);
> +		if (ret) {
> +			dev_err(pcie->pci->dev, "failed to icc_enable %d\n", ret);
> +
> +			/* Revert everything and pray icc calls succeed */
> +			return qcom_pcie_resume_noirq(dev);
> +		}
> +	} else {
> +		/*
> +		 * Set minimum bandwidth required to keep data path functional
> +		 * during suspend.
> +		 */
calling qcom_pcie_host_deinit(&pcie->pci->pp) above will turn off all 
the resources, setting BW to 1Kbps will not make sense here.

- Krishna Chaitanya.
> +		ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
> +		if (ret) {
> +			dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
> +			return ret;
> +		}
>   	}
>   
> -	qcom_pcie_icc_update(pcie);
> +	pcie->suspended = true;
>   
>   	return 0;
>   }
> 

