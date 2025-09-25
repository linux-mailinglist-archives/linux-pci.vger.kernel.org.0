Return-Path: <linux-pci+bounces-36919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF98B9D30C
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 04:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76A31BC2971
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 02:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E7F2E6CA7;
	Thu, 25 Sep 2025 02:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gYRJ1QYO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487542E54D1
	for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 02:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758767390; cv=none; b=Y+3dQpnu6rvsry797F6RUHt3o8FPCymtKscy9+BjUYg2objdnwXh/DQdA7nl0fL/hPZGLL/F3e9e//hPbxpZ3sw5V9R9vtxjSQ7QURWvj3KHvbw/MsyUMegMSEYx42Pmxp1Ewdx9MQTDyNY46g3Co3vHfR5ZD9b5yizfbLPsgUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758767390; c=relaxed/simple;
	bh=ig9L/TbF6Sv0c80a+2apyRrVBuOtIZS6lwO4ZxpqWCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ad2tLbzVr9AfWwLel9NprfdwewfGYTl5SwpKcT0ovnbCZhu5jwdo5xgFA/RXvkPk7NUQSKXx/wSY4KwyX4UDZs6uUYlJZWkf728a4qy6Xe3X+gkmKltzYU/gfTMZaWIE7Ul9pV7cVeuaOnUIsLPYLVE9fnQ6Uv5ouTYjq/DaTWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gYRJ1QYO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P04F71023766
	for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 02:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LQaOq8baqYH8YR9JWG0sLMEI
	8nnQsGHizuPggbt5gk0=; b=gYRJ1QYOcdWerhNPoWvNjro0jgCRAMHQ6LCAocnj
	wIQWk3bbVXtMB9b1wOLpP0Rc7pfDxkIwiBVs6ACQUxEmC6d7CmCI8ZqCsWn0DaTU
	/Q0dX92wegz6yfmUirgKw7iwZIGotuOL6P1XWwH3WcMs1QkjOgCf9EBrI4EIAj/S
	E3aF4jx0HK4sE3r39/XSlhcqECjKONZSNMdNXgNLOftC/7nRo38EMngPKlWFr57N
	yRWOUNybBFJYOqdyG0gdtRrKSS17vauOq4rtUl/CuGBvhCSd+2dJU4bDd1fFPNnT
	AEj30tCsxVATcU+MOArktE/MQ3JCz7P62xfvn/XuJL/H/Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0df8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 02:29:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-84a63a0c496so144392685a.3
        for <linux-pci@vger.kernel.org>; Wed, 24 Sep 2025 19:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758767387; x=1759372187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQaOq8baqYH8YR9JWG0sLMEI8nnQsGHizuPggbt5gk0=;
        b=hWzh2YB+Afg67UFt40NdiWzecQrYUdQ+YbNIo9mtGDHaZD6APwRYvMZVaEZDQXap0Z
         TBD2UuHsMan6NT+9WHRhFCAWgouSPi3W4tW6n/+aah2wYHvQJSR4RUtlUwdpIY9jSgSw
         RPE0IwqiSM6LtzbYBlICo5lmYpfwfoWLZM+/VEnbQoPvurJq6Q/fA+ctXa6e4PsEwK1h
         7AeKbxm6im77j7DzX+iF1SdX39YMAOEXsPBP5vJBvS/EDk3Y4PilNnCuLlRVp+Oa/Rod
         mRK+ZtEE9cw27Xtdze7koQix7xNzkQJEA91Bp8UNtZug6C0vly2/tXMA14Qv4DwIBgkj
         VzPw==
X-Forwarded-Encrypted: i=1; AJvYcCU27HLGe2ch0RpT1a9w2DLWLeIEOuuwURiTOsr40EMxTL3Ef/s2FLBEVzV4n/FZ4WgDyJtv9YKH+eY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy95TWpTaO2j/ogfNQfYnRPw0MqNqxzQJenZ3o2ujjW6I/wvVm2
	K93hAhX8Rw69Guf7HP6XgTiIPcaRhsGSXVPjl4gog4g1YlBjwo15BdDqmmEvWr/0uMR/jUDbNjj
	WofJ8pZ6SaaP84Xnn/0FTyWiFN2PwDDphuDS/mDbkIyzKfIMG/uybLifY+8wEIyk=
X-Gm-Gg: ASbGnct6xaw7Tphw7eb44xYDrFx/+KeGsa7jRI8cW/O64mge5PA+QMQYcFXrlId3HJZ
	pqVjt0m66Cpqg1R1c8DU6KqFFFn0TS6VlcXoRXe6fLDJ0UhLPVjOJX0ZdiJEkC1zyh00Nl0Gh5v
	Dt+vB7TJHOSYqmwbpxb5sXnpDlPzkEbUPRfhXW/Q4fNRCyQtV6WLaoHh0EcV72CNux6vJJ5rfis
	xkeHmVFMXPusVyloo0L8auu6uKoGSukgRquAqori8iklxOsduM0KvWZdWsJmVXLJmwwzavbJUv5
	k7rNzHPoPYFtVUE/gH3qMrQLqO5ohGeYJ7KtjA9zBGVSecFPC1m2xLBQIHF5e3jGv2x2xzBhP7j
	dnCI5s2NRybM/mq1Ungai0vSKZEurmvZU8mSEEIc2FIANXanG0ZNY
X-Received: by 2002:a05:620a:4450:b0:828:e3d4:36d0 with SMTP id af79cd13be357-85ae2d581c7mr282339285a.14.1758767387178;
        Wed, 24 Sep 2025 19:29:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWjHvPcJ9HcmIfCHUrXsALZGizOf4u+4lYXayYXBFqIMa+H71rcPlbCPTpugkDeALbYOyCwA==
X-Received: by 2002:a05:620a:4450:b0:828:e3d4:36d0 with SMTP id af79cd13be357-85ae2d581c7mr282337685a.14.1758767386697;
        Wed, 24 Sep 2025 19:29:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb4772cadsm2084701fa.9.2025.09.24.19.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:29:44 -0700 (PDT)
Date: Thu, 25 Sep 2025 05:29:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: Re: [PATCH 4/6] phy: qcom-qmp: pcs-pcie: Add v8 register offsets
Message-ID: <6357bmgvlc3wl3zffd56svny33fy7hml3b43ri5pzm3mrdvh4h@7iqqbil5jzrk>
References: <20250924-knp-pcie-v1-0-5fb59e398b83@oss.qualcomm.com>
 <20250924-knp-pcie-v1-4-5fb59e398b83@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-knp-pcie-v1-4-5fb59e398b83@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d4a91c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=_dzLxsmZBOyHC3WYtbYA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: sNAbI0-YQ1uO233zfuHeJ-4YSldz3dhC
X-Proofpoint-ORIG-GUID: sNAbI0-YQ1uO233zfuHeJ-4YSldz3dhC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfX3VtuTIyrk17n
 JFaMCeIpjJSL0ms0UfN8e7er+dfGij9KmRr0e6viqlvSKrvUSxP5qs3nqRWAsUJ71ALk58l8moF
 j5DFXqTHrdXU8BBpU6MX5W442TXb8aJHScgTLXH668HWs4+y9a6CYPgtYKpzyB06qIpEgEzgCwu
 XKCqNF+Yo76P0EMcjH1Dtz58+vQdT99JDMpEILcdRF4/tOk+57ryD8wAw5d8NO9asF3pKjdduc7
 gW8B0jVk42xZbVAtHKyi5ToV+cGzpmO2IXVL2xHhsOMmD+fi9iifWBxo6WhA+Fd7iK7sNOJlhhS
 CoGqvVK7gyL8VkMptAL3ZbC18bD3LjD7CZou9u/yO2KkijHc4BkqI8W0Sez1BHd5HQ9b9Pgni5C
 y5X4lrPn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

On Wed, Sep 24, 2025 at 04:33:20PM -0700, Jingyi Wang wrote:
> From: Qiang Yu <qiang.yu@oss.qualcomm.com>
> 
> Kaanapali SoC uses QMP phy with version v8 for PCIe Gen3 x2. Add the new
> PCS PCIE specific offsets in a dedicated header file.
> 
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v8.h | 35 +++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v8.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v8.h
> new file mode 100644
> index 000000000000..5d630e5123a5
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v8.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
> + */
> +
> +#ifndef QCOM_PHY_QMP_PCS_PCIE_V8_H_
> +#define QCOM_PHY_QMP_PCS_PCIE_V8_H_
> +
> +/* Only for QMP V8 PHY - PCIE PCS registers */
> +
> +#define QPHY_PCIE_V8_PCS_POWER_STATE_CONFIG2		0x00c
> +#define QPHY_PCIE_V8_PCS_TX_RX_CONFIG		0x018
> +#define QPHY_PCIE_V8_PCS_ENDPOINT_REFCLK_DRIVE	0x01c
> +#define QPHY_PCIE_V8_PCS_OSC_DTCT_ACTIONS		0x090
> +#define QPHY_PCIE_V8_PCS_EQ_CONFIG1			0x0a0
> +#define QPHY_PCIE_V8_PCS_G3_RXEQEVAL_TIME		0x0f0
> +#define QPHY_PCIE_V8_PCS_G4_RXEQEVAL_TIME		0x0f4
> +#define QPHY_PCIE_V8_PCS_G4_EQ_CONFIG5		0x108
> +#define QPHY_PCIE_V8_PCS_G4_PRE_GAIN			0x15c
> +#define QPHY_PCIE_V8_PCS_RX_MARGINING_CONFIG1	0x17c
> +#define QPHY_PCIE_V8_PCS_RX_MARGINING_CONFIG3	0x184
> +#define QPHY_PCIE_V8_PCS_RX_MARGINING_CONFIG5	0x18c
> +#define QPHY_PCIE_V8_PCS_G3_FOM_EQ_CONFIG5		0x1ac
> +#define QPHY_PCIE_V8_PCS_G4_FOM_EQ_CONFIG5		0x1c0
> +#define QPHY_PCIE_V8_PCS_POWER_STATE_CONFIG6			0x1d0
> +
> +#define QPHY_PCIE_V8_PCS_G12S1_TXDEEMPH_M6DB			0x170
> +#define QPHY_PCIE_V8_PCS_G3S2_PRE_GAIN			0x178

Please keep them sorted.

> +#define QPHY_PCIE_V8_PCS_RX_SIGDET_LVL			0x190
> +#define QPHY_PCIE_V8_PCS_ELECIDLE_DLY_SEL			0x1b8
> +#define QPHY_PCIE_V8_PCS_PCS_TX_RX_CONFIG1			0x1dc
> +#define QPHY_PCIE_V8_PCS_PCS_TX_RX_CONFIG2			0x1e0
> +#define QPHY_PCIE_V8_PCS_EQ_CONFIG4			0x1f8
> +#define QPHY_PCIE_V8_PCS_EQ_CONFIG5			0x1fc
> +#endif
> 
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

