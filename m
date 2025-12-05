Return-Path: <linux-pci+bounces-42694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9361CA7996
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 13:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2AFA30B75A2
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 12:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B479332B9B5;
	Fri,  5 Dec 2025 12:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YQz2uIEW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fMbH+bfN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF15280A5A
	for <linux-pci@vger.kernel.org>; Fri,  5 Dec 2025 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764938469; cv=none; b=aUlDu71QVByl5dbgGcotOQLlrExsPkiPDfCgwZBWeZ7Pdeme6cIbihhHy2p2W0Oc+DsfKAV502aShfXtSwgkrwFd1/dPX3AJ/xwjN9pSlcqn2abUpp+pvwhOeAtKd4j5qyJ4YS2iRqV4qcUBhds04hGskgXxwmxKvB0tzAaPWTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764938469; c=relaxed/simple;
	bh=LuS6cJuwCHqTpc/8wT8Eqz9oQBQQ8ufaL4Ptj0yzA0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYnkpkkadm6b51e9Ci4ccA6fJ1/ZuGPYPMpSxuBSnsYoNt/9ptMsjvDWMt5XlXtopEAE+D945CaGHqDWwfu5WPzx83h6y2aWSwLrueQJ1CvqWfSdI/RJ/nxwBX2cxJeGHUtlDj7HpapHEOdex/NkHXIVNYlpGQ+R6Zz9UwGp+UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YQz2uIEW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fMbH+bfN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5Ammi23173593
	for <linux-pci@vger.kernel.org>; Fri, 5 Dec 2025 12:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HnCPES3TY5m+khiG/G30vWaEapq4iKf9VJ6xM7BbpfA=; b=YQz2uIEW713A1lUM
	TsdGfAI14HLiP7ms1d1FhNJq8tKKwo/lvlF+5V2yL5fvfecI2YwJlp2Do0SwtNMu
	n/+oLihgTf8o/H2w7whzf95JNKRWJg3P+9r0ln5mJm+7G+LHhpuOke7TE+qkYw8L
	vcNdQ82VjsNYmQaWlr0mCf5h5StL5AFwqmkgf80RuTsFl0dhKZA/8ABd5UwI43VG
	9UoTX6tG5l/qJiic8IWWia7xmHjLSk7gxtlpD+aZfrhldFH64KP0aIf9dKLqcE2t
	2s0ltpIfum6JYQEtMpHcksGPtZTrFCNFQceqyoADQBGuj2ZzDVhYJZ3yv1RiC4GC
	M9QIxw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4auptqsjes-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 05 Dec 2025 12:41:02 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b6097ca315bso3346670a12.3
        for <linux-pci@vger.kernel.org>; Fri, 05 Dec 2025 04:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764938461; x=1765543261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HnCPES3TY5m+khiG/G30vWaEapq4iKf9VJ6xM7BbpfA=;
        b=fMbH+bfNtD0DVk59MycEN1Ysrovvy5tjNqMWeH0TIkKlR9fC2R7QAz2QfjmtasqJEZ
         pSmgG+mbd7DS/sTif/AeMgfM+/DiMnbk0BYskdyjngl3gyq+Fas1mbEP+yB8B/0cwBSc
         lT1HNVLZGsO8SRK0dhYbJOha0FoFZd8y4iexjP6kQaP6r0U2p8QjI1T3iUWw/YanXxHr
         1rj1uKOiLRJlVHTRt1rqmQ59GF5Y6Ssu2z3SoAcOaYee+eEzwj8CaPktmsie6dHc762I
         d3X338sn3qV232s6fthV8tJpHj6nrWUO51xEM7cV9Nra8ewJEDQPUc+iNn3v5vY1Fex2
         wIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764938461; x=1765543261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HnCPES3TY5m+khiG/G30vWaEapq4iKf9VJ6xM7BbpfA=;
        b=A3Wxg754j2K0Aj60jP19PUXR8uE9k5qd2DDt0zYW5frr92he2VJ+sOGCosYiHaJpOZ
         n6skHMvPMZ7WTELsbk+IYq1eQIsX0xzZu4wIMr8m3NxgiekUheL3ZUVqTExmuIdYEIjJ
         5lhl7CQD/ofGNP+dPUDmFi2DlzF6VeP08jdh1tPm65J873SLA8FyxSHV1nz07lRuF1Vs
         IgOLBy0MSs44zZxLWmWepZ2trX+t1tlMTN6J/mvcZWFvGnsXl61/wwPdXmQrWDPyLkuw
         l0O14bO26hw5Q42J9b/5bTpTUqcPB9fN2iwNcburGk2Tlb5FJXp18U0OkoPsY8dWnCmD
         iq6w==
X-Forwarded-Encrypted: i=1; AJvYcCXSMwmf2/A0G5XHhhlT6gZiFdRh94SoD+GcDPBIY9AVBSAz5RyT4R1x6e8m6p6HIauM88klgR2jafg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8DenKkYZWwBCzlZCztgCn0oq8WZGR1FMGwKSeKQK7SNLaLNJH
	fIDQbkG6mSE75CR/Lh/5T7ET2LGwqukCFeMaD8x/1oQwTF2ZQ5wSKnIcD/HVPUvJF0v1KnBzrsT
	MQ+nZo9r1tmEOb2t72OWr1txbALwY8Tm8Gd+fv+Ui3nMFdRkAgIDh76kuNgAThhk=
X-Gm-Gg: ASbGncs6Fn8FTaLGRxo7nsB/07QIAymIO42AFAEE4JezBCKv3jOvzdS4ynBh+nsLkNQ
	bJx4xt5FE23MJ0SKlwvNYoKXbGy4fBXC9QtPk0oyAXgc50CG1vHHZVCGmT4obkqRQ3AeandnHCw
	+ttdHzoHV00eyWVBA5Kclr4SgqL2SK0HeXaigikzZ3NzzGOV2AAmAuV55+bU76HNTLs3BsEKbQE
	1JP1UAqIYHB3GBGoNFiKv/pc2RQP6tTTTv81iWvtcJ55M8S++l7/bVI6FtbbI15EKm2d2N6xRsk
	buROMlZH1GbkV08D9cGlpYDs+E8cUrdNBvd9wAa202pcEPJof5d+WHPLVjUVdR/VCj7Vw5zDS5k
	GWmmluCEnmvhRGloGqFGLGta3bg5JnS26M42zycoEBQ==
X-Received: by 2002:a05:6a20:3d21:b0:358:dc7d:a2cc with SMTP id adf61e73a8af0-363f5d40220mr13087970637.17.1764938461429;
        Fri, 05 Dec 2025 04:41:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvGSBFxvpkadvSnZpaeXLYp2kWn5qQdrvC4WPSbz1yyCf6E8mOu/gVRHQHC/my11VK+egE0A==
X-Received: by 2002:a05:6a20:3d21:b0:358:dc7d:a2cc with SMTP id adf61e73a8af0-363f5d40220mr13087938637.17.1764938460858;
        Fri, 05 Dec 2025 04:41:00 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf686951586sm4639261a12.12.2025.12.05.04.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 04:41:00 -0800 (PST)
Message-ID: <a1b692f6-6abd-4edd-8498-9ca00cd8fc13@oss.qualcomm.com>
Date: Fri, 5 Dec 2025 18:10:53 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] PCI: eic7700: Add Eswin PCIe host controller
 driver
To: zhangsenchuan@eswincomputing.com, bhelgaas@google.com, mani@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org,
        kwilczynski@kernel.org, robh@kernel.org, p.zabel@pengutronix.de,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, christian.bruel@foss.st.com,
        mayank.rana@oss.qualcomm.com, shradha.t@samsung.com,
        thippeswamy.havalige@amd.com, inochiama@gmail.com, Frank.li@nxp.com
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
        pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com
References: <20251202090225.1602-1-zhangsenchuan@eswincomputing.com>
 <20251202090406.1636-1-zhangsenchuan@eswincomputing.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20251202090406.1636-1-zhangsenchuan@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: e2CqycDGCmMhvJPooVLszMDml2CydJ6R
X-Proofpoint-ORIG-GUID: e2CqycDGCmMhvJPooVLszMDml2CydJ6R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDA5MCBTYWx0ZWRfX8ah9OLUs0W8Z
 hzkHBS4+HrAfQxrPvsIE8874AC1jP6b68VODVgTTKWJpFP4MxLXNCcu1ea2DLj0dBiDtNzLFZDb
 iVoMy/ogRw4JTqyaM7wkYH8Q6QlnkXSzrzh0/+eyTn3ghwnpDLfpWS3bK2CjsW0K9zS2ePfSnLI
 3nrk+pQvRfX8ZRVQ4k5aUIOMeGMY24YnH8In3RrEz+s4zSEYwAfDHmpsmOSqNbifMlg4MG4unFK
 QjEIMH8D35ODUAoj4RRP89XfFYu/iSjlG39TTHKuTj1zz9x2Kc0MnOJrc2lWh5QMY4Xsz8Vk5DN
 9hZT7BHnLOtZDrqWfp/4Q/Vjr76lyxAqy8Z900UusTHz63nUQVM526RQalOBRP1iXgLPJQJw/iC
 IHve9FBnZuZ+jsG8u3uRIE6a/naGXA==
X-Authority-Analysis: v=2.4 cv=fKQ0HJae c=1 sm=1 tr=0 ts=6932d2de cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=h4SL0BZ7AAAA:8 a=YOnMdS_8F9R1mhJqLl4A:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=Cfupvnr7wbb3QRzVG_cV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_04,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512050090



On 12/2/2025 2:34 PM, zhangsenchuan@eswincomputing.com wrote:
> From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
>
> Add driver for the Eswin EIC7700 PCIe host controller, which is based on
> the DesignWare PCIe core, IP revision 5.96a. The PCIe Gen.3 controller
> supports a data rate of 8 GT/s and 4 channels, support INTx and MSI
> interrupts.
>
> Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
> Signed-off-by: Yanghui Ou <ouyanghui@eswincomputing.com>
> Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> ---
>   drivers/pci/controller/dwc/Kconfig        |  11 +
>   drivers/pci/controller/dwc/Makefile       |   1 +
>   drivers/pci/controller/dwc/pcie-eic7700.c | 378 ++++++++++++++++++++++
>   3 files changed, 390 insertions(+)
>   create mode 100644 drivers/pci/controller/dwc/pcie-eic7700.c
>
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 519b59422b47..c837cb5947b6 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -93,6 +93,17 @@ config PCIE_BT1
>   	  Enables support for the PCIe controller in the Baikal-T1 SoC to work
>   	  in host mode. It's based on the Synopsys DWC PCIe v4.60a IP-core.
>   
> +config PCIE_EIC7700
> +	tristate "Eswin EIC7700 PCIe controller"
> +	depends on ARCH_ESWIN || COMPILE_TEST
> +	depends on PCI_MSI
> +	select PCIE_DW_HOST
> +	help
> +	  Say Y here if you want PCIe controller support for the Eswin EIC7700.
> +	  The PCIe controller on EIC7700 is based on DesignWare hardware,
> +	  enables support for the PCIe controller in the EIC7700 SoC to work in
> +	  host mode.
> +
>   config PCI_IMX6
>   	bool
>   
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index 67ba59c02038..7c5a5186ea83 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
>   obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
>   obj-$(CONFIG_PCIE_AMD_MDB) += pcie-amd-mdb.o
>   obj-$(CONFIG_PCIE_BT1) += pcie-bt1.o
> +obj-$(CONFIG_PCIE_EIC7700) += pcie-eic7700.o
>   obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
>   obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
>   obj-$(CONFIG_PCIE_FU740) += pcie-fu740.o
> diff --git a/drivers/pci/controller/dwc/pcie-eic7700.c b/drivers/pci/controller/dwc/pcie-eic7700.c
> new file mode 100644
> index 000000000000..cb7cdea6a94b
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-eic7700.c
> @@ -0,0 +1,378 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ESWIN EIC7700 PCIe root complex driver
> + *
> + * Copyright 2025, Beijing ESWIN Computing Technology Co., Ltd.
> + *
> + * Authors: Yu Ning <ningyu@eswincomputing.com>
> + *          Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> + *          Yanghui Ou <ouyanghui@eswincomputing.com>
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/resource.h>
> +#include <linux/reset.h>
> +#include <linux/types.h>
> +
> +#include "pcie-designware.h"
> +
> +/* ELBI registers */
> +#define PCIEELBI_CTRL0_OFFSET		0x0
> +#define PCIEELBI_STATUS0_OFFSET		0x100
> +
> +/* LTSSM register fields */
> +#define PCIEELBI_APP_LTSSM_ENABLE	BIT(5)
> +
> +/* APP_HOLD_PHY_RST register fields */
> +#define PCIEELBI_APP_HOLD_PHY_RST	BIT(6)
> +
> +/* PM_SEL_AUX_CLK register fields */
> +#define PCIEELBI_PM_SEL_AUX_CLK		BIT(16)
> +
> +/* DEV_TYPE register fields */
> +#define PCIEELBI_CTRL0_DEV_TYPE		GENMASK(3, 0)
> +
> +/* Vendor and device ID value */
> +#define PCI_VENDOR_ID_ESWIN		0x1fe1
> +#define PCI_DEVICE_ID_ESWIN		0x2030
> +
> +#define EIC7700_NUM_RSTS		ARRAY_SIZE(eic7700_pcie_rsts)
> +
> +static const char * const eic7700_pcie_rsts[] = {
> +	"pwr",
> +	"dbi",
> +};
> +
> +struct eic7700_pcie_data {
> +	bool no_pme_handshake;
> +};
> +
> +struct eic7700_pcie_port {
> +	struct list_head list;
> +	struct reset_control *perst;
> +	int num_lanes;
> +};
> +
> +struct eic7700_pcie {
> +	struct dw_pcie pci;
> +	struct clk_bulk_data *clks;
> +	struct reset_control_bulk_data resets[EIC7700_NUM_RSTS];
> +	struct list_head ports;
> +	const struct eic7700_pcie_data *data;
> +	int num_clks;
> +};
> +
> +#define to_eic7700_pcie(x) dev_get_drvdata((x)->dev)
> +
> +static int eic7700_pcie_start_link(struct dw_pcie *pci)
> +{
> +	u32 val;
> +
> +	/* Enable LTSSM */
> +	val = readl_relaxed(pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
> +	val |= PCIEELBI_APP_LTSSM_ENABLE;
> +	writel_relaxed(val, pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
> +
> +	return 0;
> +}
> +
> +static bool eic7700_pcie_link_up(struct dw_pcie *pci)
> +{
> +	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	u16 val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> +
> +	return val & PCI_EXP_LNKSTA_DLLLA;
> +}
> +
> +static int eic7700_pcie_perst_reset(struct eic7700_pcie_port *port,
> +				    struct eic7700_pcie *pcie)
> +{
> +	int ret;
> +
> +	ret = reset_control_assert(port->perst);
> +	if (ret) {
> +		dev_err(pcie->pci.dev, "Failed to assert PERST#\n");
> +		return ret;
> +	}
> +
> +	/* Ensure that PERST# has been asserted for at least 100 ms */
> +	msleep(PCIE_T_PVPERL_MS);
> +
> +	ret = reset_control_deassert(port->perst);
> +	if (ret) {
> +		dev_err(pcie->pci.dev, "Failed to deassert PERST#\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int eic7700_pcie_parse_port(struct eic7700_pcie *pcie,
> +				   struct device_node *node)
> +{
> +	struct device *dev = pcie->pci.dev;
> +	struct eic7700_pcie_port *port;
> +
> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +
> +	port->perst = of_reset_control_get_exclusive(node, "perst");
> +	if (IS_ERR(port->perst)) {
> +		dev_err(dev, "Failed to get PERST# reset\n");
> +		return PTR_ERR(port->perst);
> +	}
> +
> +	/*
> +	 * TODO: Since the Root Port node is separated out by pcie devicetree,
> +	 * the DWC core initialization code can't parse the num-lanes attribute
> +	 * in the Root Port. Before entering the DWC core initialization code,
> +	 * the platform driver code parses the Root Port node. The EIC7700 only
> +	 * supports one Root Port node, and the num-lanes attribute is suitable
> +	 * for the case of one Root Rort.
> +	 */
> +	if (!of_property_read_u32(node, "num-lanes", &port->num_lanes))
> +		pcie->pci.num_lanes = port->num_lanes;
> +
> +	INIT_LIST_HEAD(&port->list);
> +	list_add_tail(&port->list, &pcie->ports);
> +
> +	return 0;
> +}
> +
> +static int eic7700_pcie_parse_ports(struct eic7700_pcie *pcie)
> +{
> +	struct eic7700_pcie_port *port, *tmp;
> +	struct device *dev = pcie->pci.dev;
> +	int ret;
> +
> +	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> +		ret = eic7700_pcie_parse_port(pcie, of_port);
> +		if (ret)
> +			goto err_port;
> +	}
> +
> +	return 0;
> +
> +err_port:
> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
> +		list_del(&port->list);
> +
> +	return ret;
> +}
> +
> +static int eic7700_pcie_host_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct eic7700_pcie *pcie = to_eic7700_pcie(pci);
> +	struct eic7700_pcie_port *port;
> +	u32 val;
> +	int ret;
> +
> +	pcie->num_clks = devm_clk_bulk_get_all_enabled(pci->dev, &pcie->clks);
> +	if (pcie->num_clks < 0)
> +		return dev_err_probe(pci->dev, pcie->num_clks,
> +				     "Failed to get pcie clocks\n");
> +
> +	/*
> +	 * The PWR and DBI Reset signals are respectively used to reset the
> +	 * PCIe controller and the DBI registers.
> +	 * The PERST# signal is a reset signal that simultaneously controls the
> +	 * PCIe controller, PHY, and Endpoint.
> +	 * Before configuring the PHY, the PERST# signal must first be
> +	 * deasserted.
> +	 * The external reference clock is supplied simultaneously to the PHY
> +	 * and EP. When the PHY is configurable, the entire chip already has
> +	 * stable power and reference clock.
> +	 * The PHY will be ready within 20ms after writing app_hold_phy_rst
> +	 * register of ELBI register space.
> +	 */
> +	ret = reset_control_bulk_deassert(EIC7700_NUM_RSTS, pcie->resets);
> +	if (ret) {
> +		dev_err(pcie->pci.dev, "Failed to deassert resets\n");
> +		return ret;
> +	}
> +
> +	/* Configure Root Port type */
> +	val = readl_relaxed(pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
> +	val &= ~PCIEELBI_CTRL0_DEV_TYPE;
> +	val |= FIELD_PREP(PCIEELBI_CTRL0_DEV_TYPE, PCI_EXP_TYPE_ROOT_PORT);
> +	writel_relaxed(val, pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
> +
> +	list_for_each_entry(port, &pcie->ports, list) {
> +		ret = eic7700_pcie_perst_reset(port, pcie);
> +		if (ret)
> +			goto err_perst;
> +	}
> +
> +	/* Configure app_hold_phy_rst */
> +	val = readl_relaxed(pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
> +	val &= ~PCIEELBI_APP_HOLD_PHY_RST;
> +	writel_relaxed(val, pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
> +
> +	/* The maximum waiting time for the clock switch lock is 20ms */
> +	ret = readl_poll_timeout(pci->elbi_base + PCIEELBI_STATUS0_OFFSET,
> +				 val, !(val & PCIEELBI_PM_SEL_AUX_CLK), 1000,
> +				 20000);
> +	if (ret) {
> +		dev_err(pci->dev, "Timeout waiting for PM_SEL_AUX_CLK ready\n");
> +		goto err_phy_init;
> +	}
> +
> +	/*
> +	 * Configure ESWIN VID:DID for Root Port as the default values are
> +	 * invalid.
> +	 */
we need to make dbi registers writeable before this through this API
dw_pcie_dbi_ro_wr_en().
> +	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, PCI_VENDOR_ID_ESWIN);
> +	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, PCI_DEVICE_ID_ESWIN);
> +
> +	return 0;
> +
> +err_phy_init:
> +	list_for_each_entry(port, &pcie->ports, list)
> +		reset_control_assert(port->perst);
> +err_perst:
> +	reset_control_bulk_assert(EIC7700_NUM_RSTS, pcie->resets);
> +
> +	return ret;
> +}
> +
> +static void eic7700_pcie_host_deinit(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct eic7700_pcie *pcie = to_eic7700_pcie(pci);
> +	struct eic7700_pcie_port *port;
> +
> +	list_for_each_entry(port, &pcie->ports, list)
> +		reset_control_assert(port->perst);
> +	reset_control_bulk_assert(EIC7700_NUM_RSTS, pcie->resets);
> +	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
> +}
> +
> +static const struct dw_pcie_host_ops eic7700_pcie_host_ops = {
> +	.init = eic7700_pcie_host_init,
> +	.deinit = eic7700_pcie_host_deinit,
> +};
> +
> +static const struct dw_pcie_ops dw_pcie_ops = {
> +	.start_link = eic7700_pcie_start_link,
> +	.link_up = eic7700_pcie_link_up,
> +};
> +
> +static int eic7700_pcie_probe(struct platform_device *pdev)
> +{
> +	const struct eic7700_pcie_data *data;
> +	struct eic7700_pcie_port *port, *tmp;
> +	struct device *dev = &pdev->dev;
> +	struct eic7700_pcie *pcie;
> +	struct dw_pcie *pci;
> +	int ret, i;
> +
> +	data = of_device_get_match_data(dev);
> +	if (!data)
> +		return dev_err_probe(dev, -ENODATA, "OF data missing\n");
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&pcie->ports);
> +
> +	pci = &pcie->pci;
> +	pci->dev = dev;
> +	pci->ops = &dw_pcie_ops;
> +	pci->pp.ops = &eic7700_pcie_host_ops;
> +	pcie->data = data;
> +	pci->no_pme_handshake = pcie->data->no_pme_handshake;
> +
> +	for (i = 0; i < EIC7700_NUM_RSTS; i++)
> +		pcie->resets[i].id = eic7700_pcie_rsts[i];
> +
> +	ret = devm_reset_control_bulk_get_exclusive(dev, EIC7700_NUM_RSTS,
> +						    pcie->resets);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get resets\n");
> +
> +	ret = eic7700_pcie_parse_ports(pcie);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to parse Root Port: %d\n", ret);
> +
> +	platform_set_drvdata(pdev, pcie);
> +
> +	pm_runtime_no_callbacks(dev);
> +	devm_pm_runtime_enable(dev);
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0)
> +		goto err_pm_runtime_put;
Any specific reason why we are enabling runtime pm and doing 
pm_runtime_get_sync()

- Krishna Chaitanya.
> +
> +	ret = dw_pcie_host_init(&pci->pp);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize host\n");
> +		goto err_init;
> +	}
> +
> +	return 0;
> +
> +err_init:
> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> +		list_del(&port->list);
> +		reset_control_put(port->perst);
> +	}
> +err_pm_runtime_put:
> +	pm_runtime_put(dev);
> +
> +	return ret;
> +}
> +
> +static int eic7700_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct eic7700_pcie *pcie = dev_get_drvdata(dev);
> +
> +	return dw_pcie_suspend_noirq(&pcie->pci);
> +}
> +
> +static int eic7700_pcie_resume_noirq(struct device *dev)
> +{
> +	struct eic7700_pcie *pcie = dev_get_drvdata(dev);
> +
> +	return dw_pcie_resume_noirq(&pcie->pci);
> +}
> +
> +static const struct dev_pm_ops eic7700_pcie_pm_ops = {
> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(eic7700_pcie_suspend_noirq,
> +				  eic7700_pcie_resume_noirq)
> +};
> +
> +static const struct eic7700_pcie_data eic7700_data = {
> +	.no_pme_handshake = true,
> +};
> +
> +static const struct of_device_id eic7700_pcie_of_match[] = {
> +	{ .compatible = "eswin,eic7700-pcie", .data = &eic7700_data },
> +	{},
> +};
> +
> +static struct platform_driver eic7700_pcie_driver = {
> +	.probe = eic7700_pcie_probe,
> +	.driver = {
> +		.name = "eic7700-pcie",
> +		.of_match_table = eic7700_pcie_of_match,
> +		.suppress_bind_attrs = true,
> +		.pm = &eic7700_pcie_pm_ops,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +};
> +builtin_platform_driver(eic7700_pcie_driver);
> +
> +MODULE_DESCRIPTION("Eswin EIC7700 PCIe host controller driver");
> +MODULE_AUTHOR("Yu Ning <ningyu@eswincomputing.com>");
> +MODULE_AUTHOR("Senchuan Zhang <zhangsenchuan@eswincomputing.com>");
> +MODULE_AUTHOR("Yanghui Ou <ouyanghui@eswincomputing.com>");
> +MODULE_LICENSE("GPL");


