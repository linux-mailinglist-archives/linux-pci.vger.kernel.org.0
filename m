Return-Path: <linux-pci+bounces-26159-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0205A93014
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 04:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9596172B5E
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 02:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA27D267B74;
	Fri, 18 Apr 2025 02:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YHl7eiwC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B042638B2
	for <linux-pci@vger.kernel.org>; Fri, 18 Apr 2025 02:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744944119; cv=none; b=BnIrYOQ23IyW7i+Cf/bentt8EKl2puFpmg9gbloOOya7b4CS8wWZZdN2038YRbjhkIOsY7wvBu36hIUoWrFhlQJ1mO0xBXVXyRfEWzHK08gyyeN6TISZ1r6TXgaedBHVFkoROo+inwPvSn0s5TEvjpZckKubPRflXF1qbhVa/RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744944119; c=relaxed/simple;
	bh=DozjTuLrbwjnEzVBnOWp7eNmW96ej4c4j7/GRdtqk0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m83g6Z4XdcuworzvSr06fA3WdPhXUWjXXtl5wt0BtbZaYO4KbZuV+KRGgk4q0IPHnONn6YIaSWgy3yx7GMrz3ipfGYRrZXAddU3OgYocY6ynTqRBAwHDaENrgnDb1WagH/tCDrlrF/RRJ21ysSqCJDOHQfuwQNzb1Tmi/KHERcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YHl7eiwC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I1YLhH023867
	for <linux-pci@vger.kernel.org>; Fri, 18 Apr 2025 02:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wabn3SPWgE4ngsitdU1yaao9FABzWG1dUldwByH4HuY=; b=YHl7eiwCH21wZOHY
	ce7d9dvQ28FNFgISxfXZVYtthfOzb6jrR6zDJVPg7epcWdZsSGzGAGpdCv2NQgjd
	cXBX2uIVsMNXdAFawSgZNDwPQBLJcMFfQvsQ5Aadw5/TebtR9W5PcpK4EmCe1HW2
	L1s8RPlOymK4h9sQNk8qelh/KAtnAFUNROjbpX2rdsNQnavax+E8iZLMDDLGmnNU
	jwJqxTvXf8wNTtn5nj/JrEht9iiF3tJ9Co3dPgwS58MKumyvTH9yPRCm8Cyu2x9h
	RbAJv2S95E/xxh7zSVvKMfF/vfJUu0zDkdO1stoIWsqT9GWWYrTHjH4WbZLjaY4s
	bt4VpQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yhbq0j2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 18 Apr 2025 02:41:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2265a09dbfcso22027965ad.0
        for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2025 19:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744944116; x=1745548916;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wabn3SPWgE4ngsitdU1yaao9FABzWG1dUldwByH4HuY=;
        b=sNBcb31JDtdrVppN7cFtU7XbPMJPZ9u1jYb6KV0HUsq9KM+84JdEeTJ5SoyZwFp1+E
         GvtJjR2dFPz94ngDS0XBL1xRjEduyj2hLPJ8D59xjbTKxg8M/rJIBk++gwDmpuPpkhKj
         oLvDQ2I7Q81qhaKfjPm+ogyhvI8/iwmJpmxJvbYC1aowfo5NOnxtZJkjQgcwGXlJWvHY
         DIw9/s0J3SBHvHbofvStsKKojWYzPExV8wd4imvjq45mar2SrStk9PwyxsZy5L8Yrcve
         UkooARf6H3VEyrS2IzPkM7urWZFrE/zeo1/E2BVacriKvszl/zmsay955LHPpKvtjRh8
         +Jmg==
X-Forwarded-Encrypted: i=1; AJvYcCXXG3ZmI5TldMpMFR9CgGWKkwAaafR+w6rIJiTwrScxGke03Q8bQTeQstgXnUOHPyFJxyzImIsHsJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0NjXfVXqO3s7K8L/OTqake5++g/KAzsJppwVXPX77blLdvfJq
	naHtptfJgZk1O/QIZgXiAYUeXX5n5MUcMXV4lB2y6pOaKISoq01IU6JpZNP35xQhBmjlsRkVkK8
	BI5jVn0oEvKWGPMdvcUx8lBUgL37VJ0y8WH34NtbVCH0DkeKbvJnsClBY0Ws=
X-Gm-Gg: ASbGncsDj+N89uXebf50E+HLaYYtHXoP/cusccAox0SNRI7xQ0gPmGdJTiZdeZajgKA
	GC9/Oli191V/hOtWzZC4uOt++P27MvSIRV5z6tnjMeNLqttpPvECGKkdK4Ij5ly0m81On4+/sbm
	LbnCQkARfNN8UDBm5npOz8EP8TIjxScATRMxHD2wUT7yrR6b9Vr5zYJjG/nH2PR6843AgM46K3q
	tr9yS10PPQN86uGLUe3TSP09Crq6VlmTOpxy7MD879Ea54hoF7NB7qB4W5XyVFqKDIQYkNZ7wFr
	eAxOIkvqsMLYO8jxk9AIfZh9KR6aBjr0FMF0J+CfuQ==
X-Received: by 2002:a17:902:dac2:b0:220:e9ef:ec98 with SMTP id d9443c01a7336-22c53583621mr16504725ad.19.1744944115972;
        Thu, 17 Apr 2025 19:41:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ1R80IP+m/UVpZGFU/SviBU6cKnJSLKE56EDWqKuSdN6jJEjDxSr+gHIv7/6CwD3TJmzaEQ==
X-Received: by 2002:a17:902:dac2:b0:220:e9ef:ec98 with SMTP id d9443c01a7336-22c53583621mr16504395ad.19.1744944115516;
        Thu, 17 Apr 2025 19:41:55 -0700 (PDT)
Received: from [10.92.199.136] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bf3ff0sm7690775ad.74.2025.04.17.19.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 19:41:55 -0700 (PDT)
Message-ID: <f32b2ece-f7ed-45ab-2867-9d276b88cf62@oss.qualcomm.com>
Date: Fri, 18 Apr 2025 08:11:47 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 5/5] PCI: qcom: Add support for resetting the slot due
 to link down event
Content-Language: en-US
To: manivannan.sadhasivam@linaro.org,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>,
        Will Deacon <will@kernel.org>, Robert Richter <rric@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>
Cc: dingwei@marvell.com, cassel@kernel.org, Lukas Wunner <lukas@wunner.de>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
References: <20250417-pcie-reset-slot-v3-0-59a10811c962@linaro.org>
 <20250417-pcie-reset-slot-v3-5-59a10811c962@linaro.org>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250417-pcie-reset-slot-v3-5-59a10811c962@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: vT24-tx01JzB2CGu8V_g9oPge6nXqL_r
X-Proofpoint-GUID: vT24-tx01JzB2CGu8V_g9oPge6nXqL_r
X-Authority-Analysis: v=2.4 cv=I+plRMgg c=1 sm=1 tr=0 ts=6801bbf4 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=HZEN96OWHqwnsOiu:21 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=h0UufrOjtTHVMtGttLUA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180018



On 4/17/2025 10:46 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> The PCIe link can go down under circumstances such as the device firmware
> crash, link instability, etc... When that happens, the PCIe slot needs to
> be reset to make it operational again. Currently, the driver is not
> handling the link down event, due to which the users have to restart the
> machine to make PCIe link operational again. So fix it by detecting the
> link down event and resetting the slot.
> 
> Since the Qcom PCIe controllers report the link down event through the
> 'global' IRQ, enable the link down event by setting PARF_INT_ALL_LINK_DOWN
> bit in PARF_INT_ALL_MASK register.
> 
> Then in the case of the event, call pci_host_handle_link_down() API
> in the handler to let the PCI core handle the link down condition.
> 
> The API will internally call, 'pci_host_bridge::reset_slot()' callback to
> reset the slot in a platform specific way. So implement the callback to
> reset the slot by first resetting the PCIe core, followed by reinitializing
> the resources and then finally starting the link again.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/pci/controller/dwc/Kconfig     |  1 +
>   drivers/pci/controller/dwc/pcie-qcom.c | 90 +++++++++++++++++++++++++++++++++-
>   2 files changed, 89 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index d9f0386396edf66ad0e514a0f545ed24d89fcb6c..ce04ee6fbd99cbcce5d2f3a75ebd72a17070b7b7 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -296,6 +296,7 @@ config PCIE_QCOM
>   	select PCIE_DW_HOST
>   	select CRC8
>   	select PCIE_QCOM_COMMON
> +	select PCI_HOST_COMMON
>   	help
>   	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
>   	  PCIe controller uses the DesignWare core plus Qualcomm-specific
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index dc98ae63362db0422384b1879a2b9a7dc564d091..6b18a2775e7fcde1d634b3f58327ecc7d028e4ec 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -34,6 +34,7 @@
>   #include <linux/units.h>
>   
>   #include "../../pci.h"
> +#include "../pci-host-common.h"
>   #include "pcie-designware.h"
>   #include "pcie-qcom-common.h"
>   
> @@ -55,6 +56,7 @@
>   #define PARF_INT_ALL_STATUS			0x224
>   #define PARF_INT_ALL_CLEAR			0x228
>   #define PARF_INT_ALL_MASK			0x22c
> +#define PARF_STATUS				0x230
>   #define PARF_SID_OFFSET				0x234
>   #define PARF_BDF_TRANSLATE_CFG			0x24c
>   #define PARF_DBI_BASE_ADDR_V2			0x350
> @@ -130,8 +132,11 @@
>   
>   /* PARF_LTSSM register fields */
>   #define LTSSM_EN				BIT(8)
> +#define SW_CLEAR_FLUSH_MODE			BIT(10)
> +#define FLUSH_MODE				BIT(11)
>   
>   /* PARF_INT_ALL_{STATUS/CLEAR/MASK} register fields */
> +#define PARF_INT_ALL_LINK_DOWN			BIT(1)
>   #define PARF_INT_ALL_LINK_UP			BIT(13)
>   #define PARF_INT_MSI_DEV_0_7			GENMASK(30, 23)
>   
> @@ -145,6 +150,9 @@
>   /* PARF_BDF_TO_SID_CFG fields */
>   #define BDF_TO_SID_BYPASS			BIT(0)
>   
> +/* PARF_STATUS fields */
> +#define FLUSH_COMPLETED				BIT(8)
> +
>   /* ELBI_SYS_CTRL register fields */
>   #define ELBI_SYS_CTRL_LT_ENABLE			BIT(0)
>   
> @@ -169,6 +177,7 @@
>   						PCIE_CAP_SLOT_POWER_LIMIT_SCALE)
>   
>   #define PERST_DELAY_US				1000
> +#define FLUSH_TIMEOUT_US			100
>   
>   #define QCOM_PCIE_CRC8_POLYNOMIAL		(BIT(2) | BIT(1) | BIT(0))
>   
> @@ -274,11 +283,14 @@ struct qcom_pcie {
>   	struct icc_path *icc_cpu;
>   	const struct qcom_pcie_cfg *cfg;
>   	struct dentry *debugfs;
> +	int global_irq;
>   	bool suspended;
>   	bool use_pm_opp;
>   };
>   
>   #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> +static int qcom_pcie_reset_slot(struct pci_host_bridge *bridge,
> +				  struct pci_dev *pdev);
>   
>   static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
>   {
> @@ -1263,6 +1275,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>   			goto err_assert_reset;
>   	}
>   
> +	pp->bridge->reset_slot = qcom_pcie_reset_slot;
> +
>   	return 0;
>   
>   err_assert_reset:
> @@ -1300,6 +1314,73 @@ static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
>   	.post_init	= qcom_pcie_host_post_init,
>   };
>   
> +static int qcom_pcie_reset_slot(struct pci_host_bridge *bridge,
> +				  struct pci_dev *pdev)
> +{
> +	struct pci_bus *bus = bridge->bus;
> +	struct dw_pcie_rp *pp = bus->sysdata;
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> +	struct device *dev = pcie->pci->dev;
> +	u32 val;
> +	int ret;
> +
> +	/* Wait for the pending transactions to be completed */
> +	ret = readl_relaxed_poll_timeout(pcie->parf + PARF_STATUS, val,
> +					 val & FLUSH_COMPLETED, 10,
> +					 FLUSH_TIMEOUT_US);
> +	if (ret) {
> +		dev_err(dev, "Flush completion failed: %d\n", ret);
> +		goto err_host_deinit;
> +	}
> +
> +	/* Clear the FLUSH_MODE to allow the core to be reset */
> +	val = readl(pcie->parf + PARF_LTSSM);
> +	val |= SW_CLEAR_FLUSH_MODE;
> +	writel(val, pcie->parf + PARF_LTSSM);
> +
> +	/* Wait for the FLUSH_MODE to clear */
> +	ret = readl_relaxed_poll_timeout(pcie->parf + PARF_LTSSM, val,
> +					 !(val & FLUSH_MODE), 10,
> +					 FLUSH_TIMEOUT_US);
> +	if (ret) {
> +		dev_err(dev, "Flush mode clear failed: %d\n", ret);
> +		goto err_host_deinit;
> +	}
> +
> +	qcom_pcie_host_deinit(pp);
> +
> +	ret = qcom_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "Host init failed\n");
> +		return ret;
> +	}
> +
> +	ret = dw_pcie_setup_rc(pp);
> +	if (ret)
> +		goto err_host_deinit;
> +
> +	/*
> +	 * Re-enable global IRQ events as the PARF_INT_ALL_MASK register is
> +	 * non-sticky.
> +	 */
> +	if (pcie->global_irq)
> +		writel_relaxed(PARF_INT_ALL_LINK_UP | PARF_INT_ALL_LINK_DOWN |
> +			       PARF_INT_MSI_DEV_0_7, pcie->parf + PARF_INT_ALL_MASK);
do we need to enable linkup again here, since all the devices are
enumerated previously, the linkup irq will do a rescan again which is
not needed. Instead of linkup we update icc & opp bandwidths after
dw_pcie_wait_for_link() in the below.

- Krishna Chaitanya.
> +
> +	qcom_pcie_start_link(pci);
> +	dw_pcie_wait_for_link(pci);
> +
> +	dev_dbg(dev, "Slot reset completed\n");
> +
> +	return 0;
> +
> +err_host_deinit:
> +	qcom_pcie_host_deinit(pp);
> +
> +	return ret;
> +}
> +
>   /* Qcom IP rev.: 2.1.0	Synopsys IP rev.: 4.01a */
>   static const struct qcom_pcie_ops ops_2_1_0 = {
>   	.get_resources = qcom_pcie_get_resources_2_1_0,
> @@ -1571,6 +1652,9 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
>   		pci_unlock_rescan_remove();
>   
>   		qcom_pcie_icc_opp_update(pcie);
> +	} else if (FIELD_GET(PARF_INT_ALL_LINK_DOWN, status)) {
> +		dev_dbg(dev, "Received Link down event\n");
> +		pci_host_handle_link_down(pp->bridge);
>   	} else {
>   		dev_WARN_ONCE(dev, 1, "Received unknown event. INT_STATUS: 0x%08x\n",
>   			      status);
> @@ -1732,8 +1816,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>   			goto err_host_deinit;
>   		}
>   
> -		writel_relaxed(PARF_INT_ALL_LINK_UP | PARF_INT_MSI_DEV_0_7,
> -			       pcie->parf + PARF_INT_ALL_MASK);
> +		writel_relaxed(PARF_INT_ALL_LINK_UP | PARF_INT_ALL_LINK_DOWN |
> +			       PARF_INT_MSI_DEV_0_7, pcie->parf + PARF_INT_ALL_MASK);
> +
> +		pcie->global_irq = irq;
>   	}
>   
>   	qcom_pcie_icc_opp_update(pcie);
> 

