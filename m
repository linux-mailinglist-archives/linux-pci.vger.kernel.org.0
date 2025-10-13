Return-Path: <linux-pci+bounces-37879-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 362A9BD2891
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 12:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC61188F5E2
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 10:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267E32FF170;
	Mon, 13 Oct 2025 10:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FWD8z0Bz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C681946AA
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 10:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760350887; cv=none; b=rH3WKc4OwEaHVKQro0/+j5aclTQHO2bwuakhHp0v+C507R2LTMYO1/GqPQzJmQiOPk5UK+Q2e0VxWI/z8KIe5FcXVmGDCXCaGe1RISINFD+/he2qd3ErwvrEOhCWiPEMwvC4XP1JL16SYC/AjxAber/0SHHoVRfXn0jSIn6yXck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760350887; c=relaxed/simple;
	bh=+FW/t/JZLoRj3fCJ6l0uGs6lOtXEWsH1VJl9JV8psyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJJkOU5VyqRFjPK13jpZD6Ak7+9eEzGZFQ3kEBNbwm2X0YzXcG+5I0X8bB3NUmBEcNAqLJWjD2NnmxBH54I6mEmzM7ndsUiBFJ5Dm+LKkN2gtxr7OsP7Ad7wy4oAID5Ij+gYiFIyzkLuyAX55mM9RBtGfCKlZIFNqqy7jhhup2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FWD8z0Bz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2nPDF018067
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 10:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4Fadm5UWE9Z1SeNHKDkEAbSo
	CIBBWtecpyx1PD/Kvao=; b=FWD8z0BzbgIF46ZnojQnErH4b5eudWnBC7z3aGME
	OY2+7gs58kou9JC0hFSIV3242zzpDUzauoJXjd6g9UuEdUQwoangnH6LmPpR4s30
	6gSGZzHZMdEou+s/f4IE3u8N5HQVzsaAWVzVMti57D0IKzo3070zF4l2qZmPJizz
	RgvI6fr24uszRX3s1oFE1AKSl/pC9d09deoJ3nj+Yj2/gJtAsJ2jdYaZ45AQcY/e
	L7usewEy9edKnf65wBKrypRJ40qPui/klZ2WwigqLe85ZTqXefX41EFKX06Pcq4K
	lJJkXIPi6U/J/OA7MTuaKFO9U2WZLaCdY0k9uDGyBtKFEg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdk4706-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 10:21:24 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-28e8d1d9b13so83315865ad.0
        for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 03:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760350883; x=1760955683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Fadm5UWE9Z1SeNHKDkEAbSoCIBBWtecpyx1PD/Kvao=;
        b=sS6C2ThqmyKy55KTccWqtULg8g+rEDn+osoFGEjbONlTETo4dzNGy1nqxg2+edOwRa
         KeQNLMhkF336mM36BVycFT0wuU44QrAyd4pykmnr4iYA9i9F7dYTIhhW48OP1zAEoaa9
         q4A5sOiXdlhONYECC8sutVTnPsoWVjqt/7iiISrdD4gn/rJcq2vG+5kHkYZdBy3IQwDN
         I0AMTP05ZERaP+y7JMZaGvvH5h8TuMmBWzbBjmKP15EZtA1/A7DgBbmhJbCekfach1jA
         qWqAhvTp4XTo8WrBMkzg+YkmT0+WAMqvfJEnqGPtl3gDtLRNzs9lTal9/xE/D/Ng7N0c
         fiiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtXL2xun5e2iRcuzNVcECKeluuINcg5lq6KmUcaaTmlKrAgBslbpoxHNNLGh1awqVaJ+cM7Up1O/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Vnsq69ldwUkBhDraWFZiuTj8f9jsQHzO9Qw5dn0loyEO8/wa
	4CJfiHumBF0b0FXMjOWi1Sqs4XaeU+30ogTPiVnHNpfaDXzaQG18+K9O1grs8kHqcpbyLIqwHUJ
	dLYkGi6udPIku1fXgeoVCz79t513KKChKjAK5A02jJeQjCOzLpnI/DOCf+FEbbH8=
X-Gm-Gg: ASbGncssop3K3KXzF7s6MpMwht92jSaZX5adGKuGJOt8swrfvSbAEpdHOI4UvjNGnhL
	F2NsqekgsJTOw66tqh0ewoaGemzOLdsz5E9UcPKWYXrHQ4G8holDJ9jO7+drRP4HlN1VmUBs11h
	nQ6sQXQy8vAH7835RiGofUsfdRwRJAmys6ceyduDR0ysv+N4hvFMWAfPdClA6wiwIZXJwRte2Xu
	FsWGxx1RScK11P4nBk9q9tV+oUnWPw8ylRyiNohQ4i4AUS6rXEHFrcJM7opP55Dc1Vi+smOdBtM
	w39CZ6IsAVA4gp92c7HfNswJgGILPb1ERz29UEON8pjktO/mfuwQqnlebOsYyKqctx3709eEkX+
	ExJz+wBNwC+U=
X-Received: by 2002:a17:903:1510:b0:27e:ec72:f62 with SMTP id d9443c01a7336-2902728b8a2mr258678595ad.6.1760350883030;
        Mon, 13 Oct 2025 03:21:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI2xIesTPKfihzbvuN6SjY2IhVfnvd+E8VKr6jMCnNPvpl/9my3behcmfa8v1Mlq4cfp6Z2A==
X-Received: by 2002:a17:903:1510:b0:27e:ec72:f62 with SMTP id d9443c01a7336-2902728b8a2mr258678235ad.6.1760350882443;
        Mon, 13 Oct 2025 03:21:22 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f0726asm129326225ad.72.2025.10.13.03.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 03:21:21 -0700 (PDT)
Date: Mon, 13 Oct 2025 03:21:19 -0700
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
        yijie.yang@oss.qualcomm.com
Subject: Re: [PATCH 3/6] phy: qcom-qmp: qserdes-txrx: Add QMP PCIe PHY
 v8-specific register offsets
Message-ID: <aOzSnxuuAb4gFCkk@hu-qianyu-lv.qualcomm.com>
References: <20250924-knp-pcie-v1-0-5fb59e398b83@oss.qualcomm.com>
 <20250924-knp-pcie-v1-3-5fb59e398b83@oss.qualcomm.com>
 <fw5hf4p2mjybvfo756dhdm6wwlgnkzks4uwgo7k3dy7hyjhzyr@bv4p7msxapcb>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fw5hf4p2mjybvfo756dhdm6wwlgnkzks4uwgo7k3dy7hyjhzyr@bv4p7msxapcb>
X-Proofpoint-ORIG-GUID: -qEDqd2osEFzAMUznvtaAryONDjxsN-P
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68ecd2a4 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=_a7lAMoHYZZEAV_m-VEA:9
 a=CjuIK1q_8ugA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: -qEDqd2osEFzAMUznvtaAryONDjxsN-P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXwjBwr7LXjhKo
 oU4jrN/MZAYDt7okgax5OZT5uhvLwbxO50Un0IOXmKMbGP3AYtY7vQRkUviVFxvgCI8zv2YASax
 Z6m/zJBzQltHLJxNpzbAMpNKpYkHvC/lvGjyErWNsyUpPcZtBc3y19WcPTC+E2N6SuK4ipiWlm6
 MqUN/boy26QGYicxFpzJSulVgQeTVpWMIggcHKyvYTxMw3kRid9rcI5SKq7tziiaXCgWqlpqZoM
 vUEWL5zMb98ioxiJLI77rQRDzzwTTzPS081CztOw3Hj7QQ5C8lITA16PZV9Z/RjlCm29AlzVYWY
 adMq2ZIOygai5UVja+YZzUEez1znVgIeo6Zmjty7HtyGQ9ODjj9lvjNdlWrwclGSEiEAUQtAFGg
 osKhI/n/b4R8OUjxUyyucRQtH47sZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1011 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Thu, Sep 25, 2025 at 05:28:15AM +0300, Dmitry Baryshkov wrote:
> On Wed, Sep 24, 2025 at 04:33:19PM -0700, Jingyi Wang wrote:
> > From: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > 
> > Kaanapali SoC uses QMP PHY with version v8 for PCIe Gen3 x2, but its
> > qserdes-txrx register offsets differ from the existing v8 offsets. To
> > accommodate these differences, add the qserdes-txrx specific offsets in
> > a dedicated header file.
> 
> With this approach it's not obvious, which register names are shared
> with the existing header and which fields are unique. Please provide a
> full set of defines in this header.

Sorry, I didn't get you. Do you mean we need to add defines for all PCIe
qserdes-txrx registers? I don't understand how this makes which register
names are shared and which fields are unique more obvious.

- Qiang Yu
> 
> > 
> > Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> > ---
> >  .../qualcomm/phy-qcom-qmp-qserdes-txrx-pcie-v8.h   | 71 ++++++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-pcie-v8.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-pcie-v8.h
> > new file mode 100644
> > index 000000000000..181846e08c0f
> > --- /dev/null
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-pcie-v8.h
> > @@ -0,0 +1,71 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
> > + */
> > +
> > +#ifndef QCOM_PHY_QMP_QSERDES_TXRX_PCIE_V8_H_
> > +#define QCOM_PHY_QMP_QSERDES_TXRX_PCIE_V8_H_
> > +
> > +#define QSERDES_V8_PCIE_TX_RES_CODE_LANE_OFFSET_TX		0x030
> > +#define QSERDES_V8_PCIE_TX_RES_CODE_LANE_OFFSET_RX		0x034
> > +#define QSERDES_V8_PCIE_TX_LANE_MODE_1		0x07c
> > +#define QSERDES_V8_PCIE_TX_LANE_MODE_2		0x080
> > +#define QSERDES_V8_PCIE_TX_LANE_MODE_3		0x084
> > +#define QSERDES_V8_PCIE_TX_TRAN_DRVR_EMP_EN		0x0b4
> > +#define QSERDES_V8_PCIE_TX_TX_BAND0		0x0e0
> > +#define QSERDES_V8_PCIE_TX_TX_BAND1		0x0e4
> > +#define QSERDES_V8_PCIE_TX_SEL_10B_8B		0x0f4
> > +#define QSERDES_V8_PCIE_TX_SEL_20B_10B		0x0f8
> > +#define QSERDES_V8_PCIE_TX_PARRATE_REC_DETECT_IDLE_EN		0x058
> > +#define QSERDES_V8_PCIE_TX_TX_ADAPT_POST_THRESH1		0x118
> > +#define QSERDES_V8_PCIE_TX_TX_ADAPT_POST_THRESH2		0x11c
> > +#define QSERDES_V8_PCIE_TX_PHPRE_CTRL		0x128
> > +#define QSERDES_V8_PCIE_TX_EQ_RCF_CTRL_RATE3		0x148
> > +#define QSERDES_V8_PCIE_TX_EQ_RCF_CTRL_RATE4		0x14c
> > +
> > +#define QSERDES_V8_PCIE_RX_UCDR_FO_GAIN_RATE4		0x0dc
> > +#define QSERDES_V8_PCIE_RX_UCDR_SO_GAIN_RATE3		0x0ec
> > +#define QSERDES_V8_PCIE_RX_UCDR_SO_GAIN_RATE4		0x0f0
> > +#define QSERDES_V8_PCIE_RX_UCDR_PI_CONTROLS		0x0f4
> > +#define QSERDES_V8_PCIE_RX_VGA_CAL_CNTRL1		0x170
> > +#define QSERDES_V8_PCIE_RX_VGA_CAL_MAN_VAL		0x178
> > +#define QSERDES_V8_PCIE_RX_RX_EQU_ADAPTOR_CNTRL4		0x1b4
> > +#define QSERDES_V8_PCIE_RX_SIGDET_ENABLES			0x1d8
> > +#define QSERDES_V8_PCIE_RX_SIGDET_LVL			0x1e0
> > +#define QSERDES_V8_PCIE_RX_RXCLK_DIV2_CTRL			0x0b8
> > +#define QSERDES_V8_PCIE_RX_RX_BAND_CTRL0			0x0bc
> > +#define QSERDES_V8_PCIE_RX_RX_TERM_BW_CTRL0			0x0c4
> > +#define QSERDES_V8_PCIE_RX_RX_TERM_BW_CTRL1			0x0c8
> > +#define QSERDES_V8_PCIE_RX_SVS_MODE_CTRL			0x0b4
> > +#define QSERDES_V8_PCIE_RX_UCDR_PI_CTRL1			0x058
> > +#define QSERDES_V8_PCIE_RX_UCDR_PI_CTRL2			0x05c
> > +#define QSERDES_V8_PCIE_RX_UCDR_SB2_THRESH2_RATE3			0x084
> > +#define QSERDES_V8_PCIE_RX_UCDR_SB2_GAIN1_RATE3			0x098
> > +#define QSERDES_V8_PCIE_RX_UCDR_SB2_GAIN2_RATE3			0x0ac
> > +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE_0_1_B0			0x218
> > +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE_0_1_B1			0x21c
> > +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE_0_1_B2			0x220
> > +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE_0_1_B4			0x228
> > +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE_0_1_B7			0x234
> > +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE3_B0			0x260
> > +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE3_B1			0x264
> > +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE3_B2			0x268
> > +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE3_B3			0x26c
> > +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE3_B4			0x270
> > +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE4_SA_B0			0x284
> > +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE4_SA_B1			0x288
> > +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE4_SA_B2			0x28c
> > +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE4_SA_B3			0x290
> > +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE4_SA_B4			0x294
> > +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE4_SA_B5			0x298
> > +#define QSERDES_V8_PCIE_RX_Q_PI_INTRINSIC_BIAS_RATE32			0x31c
> > +#define QSERDES_V8_PCIE_RX_Q_PI_INTRINSIC_BIAS_RATE4			0x320
> > +#define QSERDES_V8_PCIE_RX_EOM_MAX_ERR_LIMIT_LSB			0x11c
> > +#define QSERDES_V8_PCIE_RX_EOM_MAX_ERR_LIMIT_MSB			0x120
> > +#define QSERDES_V8_PCIE_RX_AUXDATA_BIN_RATE23			0x108
> > +#define QSERDES_V8_PCIE_RX_AUXDATA_BIN_RATE4			0x10c
> > +#define QSERDES_V8_PCIE_RX_VTHRESH_CAL_MAN_VAL_RATE3			0x198
> > +#define QSERDES_V8_PCIE_RX_VTHRESH_CAL_MAN_VAL_RATE4			0x19c
> > +#define QSERDES_V8_PCIE_RX_GM_CAL			0x1a0
> > +
> > +#endif
> > 
> > -- 
> > 2.25.1
> > 
> 
> -- 
> With best wishes
> Dmitry

