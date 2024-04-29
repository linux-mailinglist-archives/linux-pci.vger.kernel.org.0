Return-Path: <linux-pci+bounces-6753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 879DB8B5145
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 08:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B85281DEB
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 06:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444ED1095C;
	Mon, 29 Apr 2024 06:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Np+klgc2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C2811C94;
	Mon, 29 Apr 2024 06:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714371654; cv=none; b=CszHVfszxjMOvHz8WtXJwMrZdj6Fky31FkfCWDzlqukhAx4cUyd6yDcXN9m7LdfLpQO4KlrMQgGYyJdVjx8mm4R1hc3BrvUfCia7ygP95AjP1pkrtNF7MBlZxiXAo5TX6CpLrsTGGIpJZG20AnKZ99+/W1bmiK8sfPDc90lPAVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714371654; c=relaxed/simple;
	bh=VLmgLXg3lTx43zyCfWGZBtq+OeWH6qurd2HZ1uHF6o8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDJSuykf2shWIwIO6i4jvI4NqmHw7s1d4b6j+MlKvd/OPMXWhhDdq6kPhwQW8Yy0dBphMEDR9t8CYo6woosLRFFCKlp8wKHi9465Mg27HQ2kV/EqX9y5BrFYQuCgbSMlC7/rmPTChGPZnH0Xw2DNo1GKX38w60/m61vDKOrXFHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Np+klgc2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T4pTwT020186;
	Mon, 29 Apr 2024 06:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=ACiZszjXaFTGYybnh+vSo
	0PNRyNJHSwRV6HPMbdN/8A=; b=Np+klgc2quZizyZqcvJ/z/14tEJb4qjhEy6d7
	2z/bAJ+6vnSgIblZdlXn4ppW17owcqSwKJPQVJuYbBeddhbRMoZWc3GPIX0T6WaM
	e752xsL95EuTdoeVnwB0yanp3Xrp0KGLI+s+5T+V/6kLRPRF4xLOTY2+hR3vm+yj
	jPYIyy+ZVlp/WhLYX7yErcVewMOyyyoRrtqeSuTJSNc4QeYe7cqHojdJXrvXvbpJ
	zqUzddti7/JUI0UJ6VtQ7VPbhORrx4SxsN63T2tXXQaMNdVUr7lW2kQIseD+Fdw6
	WC4f6z92aagROMPvCCn0iaVeHUYThxEEAS+earzLnSmyyl7TQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrravjxtm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 06:20:25 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43T6KOxD017362
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 06:20:24 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 28 Apr 2024 23:20:17 -0700
Date: Mon, 29 Apr 2024 11:50:13 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Alex G. <mr.nuke.me@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I
	<kishon@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen
 Boyd <sboyd@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v3 6/7] phy: qcom-qmp-pcie: add support for ipq9574
 gen3x2 PHY
Message-ID: <Zi88Hdx6UgBo/gti@hu-varada-blr.qualcomm.com>
References: <20240415182052.374494-1-mr.nuke.me@gmail.com>
 <20240415182052.374494-7-mr.nuke.me@gmail.com>
 <CAA8EJpqY1aDZMaeqBULEOD26UeGYbLd8RsA16jZw7zXJ7_oGPQ@mail.gmail.com>
 <6726fa2b-f5fe-10fb-6aab-f76d61f0b3cd@gmail.com>
 <4a7b1e1d-ac68-4857-8925-f90c9e123fd1@gmail.com>
 <CAA8EJppGW=qyk2P6Z_S=dp0njsCjqZaXjw8qU4MY1HOZR-N=4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJppGW=qyk2P6Z_S=dp0njsCjqZaXjw8qU4MY1HOZR-N=4A@mail.gmail.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ubTXDsCE8tRZ8LDYsC8D6R6s_iQNkitZ
X-Proofpoint-ORIG-GUID: ubTXDsCE8tRZ8LDYsC8D6R6s_iQNkitZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_03,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404290041

On Wed, Apr 17, 2024 at 12:50:49AM +0300, Dmitry Baryshkov wrote:
> On Wed, 17 Apr 2024 at 00:25, Alex G. <mr.nuke.me@gmail.com> wrote:
> >
> > Hi Dmitry,
> >
> > On 4/15/24 16:25, mr.nuke.me@gmail.com wrote:
> > >
> > >
> > > On 4/15/24 15:10, Dmitry Baryshkov wrote:
> > >> On Mon, 15 Apr 2024 at 21:23, Alexandru Gagniuc <mr.nuke.me@gmail.com>
> > >> wrote:
> > >>>
> > >>> Add support for the gen3x2 PCIe PHY on IPQ9574, ported form downstream
> > >>> 5.4 kernel. Only the serdes and pcs_misc tables are new, the others
> > >>> being reused from IPQ8074 and IPQ6018 PHYs.
> > >>>
> > >>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> > >>> ---
> > >>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 136 +++++++++++++++++-
> > >>>   .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |  14 ++
> > >>>   2 files changed, 149 insertions(+), 1 deletion(-)
> > >>>
> > >>
> > >> [skipped]
> > >>
> > >>> @@ -2448,7 +2542,7 @@ static inline void qphy_clrbits(void __iomem
> > >>> *base, u32 offset, u32 val)
> > >>>
> > >>>   /* list of clocks required by phy */
> > >>>   static const char * const qmp_pciephy_clk_l[] = {
> > >>> -       "aux", "cfg_ahb", "ref", "refgen", "rchng", "phy_aux",
> > >>> +       "aux", "cfg_ahb", "ref", "refgen", "rchng", "phy_aux",
> > >>> "anoc", "snoc"
> > >>
> > >> Are the NoC clocks really necessary to drive the PHY? I think they are
> > >> usually connected to the controllers, not the PHYs.
> > >
> > > The system will hang if these clocks are not enabled. They are also
> > > attached to the PHY in the QCA 5.4 downstream kernel.
>
> Interesting.
> I see that Varadarajan is converting these clocks into interconnects.
> Maybe it's better to wait for those patches to land and use
> interconnects instead. I think it would better suit the
> infrastructure.
>
> Varadarajan, could you please comment, are these interconnects
> connected to the PHY too or just to the PCIe controller?

Sorry for the late response. Missed this e-mail.

These 2 clks are related to AXI port clk on Aggnoc/SNOC, not
directly connected to PCIE wrapper, but it should be enabled to
generate pcie traffic.

Thanks
Varada

> > They are named "anoc_lane", and "snoc_lane" in the downstream kernel.
> > Would you like me to use these names instead?
>
> I'm fine either way.
>
> > e>>>   };
> > >>>
> > >>>   /* list of regulators */
> > >>> @@ -2499,6 +2593,16 @@ static const struct qmp_pcie_offsets
> > >>> qmp_pcie_offsets_v4x1 = {
> > >>>          .rx             = 0x0400,
> > >>>   };
> > >>>
> > >>> +static const struct qmp_pcie_offsets qmp_pcie_offsets_ipq9574 = {
> > >>> +       .serdes         = 0,
> > >>> +       .pcs            = 0x1000,
> > >>> +       .pcs_misc       = 0x1400,
> > >>> +       .tx             = 0x0200,
> > >>> +       .rx             = 0x0400,
> > >>> +       .tx2            = 0x0600,
> > >>> +       .rx2            = 0x0800,
> > >>> +};
> > >>> +
> > >>>   static const struct qmp_pcie_offsets qmp_pcie_offsets_v4x2 = {
> > >>>          .serdes         = 0,
> > >>>          .pcs            = 0x0a00,
> > >>> @@ -2728,6 +2832,33 @@ static const struct qmp_phy_cfg
> > >>> sm8250_qmp_gen3x1_pciephy_cfg = {
> > >>>          .phy_status             = PHYSTATUS,
> > >>>   };
> > >>>
> > >>> +static const struct qmp_phy_cfg ipq9574_pciephy_gen3x2_cfg = {
> > >>> +       .lanes                  = 2,
> > >>> +
> > >>> +       .offsets                = &qmp_pcie_offsets_ipq9574,
> > >>> +
> > >>> +       .tbls = {
> > >>> +               .serdes         = ipq9574_gen3x2_pcie_serdes_tbl,
> > >>> +               .serdes_num     =
> > >>> ARRAY_SIZE(ipq9574_gen3x2_pcie_serdes_tbl),
> > >>> +               .tx             = ipq8074_pcie_gen3_tx_tbl,
> > >>> +               .tx_num         = ARRAY_SIZE(ipq8074_pcie_gen3_tx_tbl),
> > >>> +               .rx             = ipq6018_pcie_rx_tbl,
> > >>> +               .rx_num         = ARRAY_SIZE(ipq6018_pcie_rx_tbl),
> > >>> +               .pcs            = ipq6018_pcie_pcs_tbl,
> > >>> +               .pcs_num        = ARRAY_SIZE(ipq6018_pcie_pcs_tbl),
> > >>> +               .pcs_misc       = ipq9574_gen3x2_pcie_pcs_misc_tbl,
> > >>> +               .pcs_misc_num   =
> > >>> ARRAY_SIZE(ipq9574_gen3x2_pcie_pcs_misc_tbl),
> > >>> +       },
> > >>> +       .reset_list             = ipq8074_pciephy_reset_l,
> > >>> +       .num_resets             = ARRAY_SIZE(ipq8074_pciephy_reset_l),
> > >>> +       .vreg_list              = NULL,
> > >>> +       .num_vregs              = 0,
> > >>> +       .regs                   = pciephy_v4_regs_layout,
> > >>
> > >> So, is it v4 or v5?
> > >
> > > Please give me a day or so to go over my notes and give you a more
> > > coherent explanation of why this versioning was chosen. I am only
> > > working from the QCA 5.4 downstream sources. I don't have any
> > > documentation for the silicon
> >
> > The downstream QCA kernel uses the same table for ipq6018, ipq8074-gen3,
> > and ipq9574. It is named "ipq_pciephy_gen3_regs_layout". Thus, it made
> > sense to use the same upstream table for ipq9574, "pciephy_v4_regs_layout".
> >
> > As far as the register tables go, the pcs/pcs_misc are squashed into the
> > same table in the downstream 5.4 kernel. I was able to separate the two
> > tables because the pcs_misc registers were defined with an offset of
> > 0x400. For example:
> >
> > /* QMP V2 PHY for PCIE gen3 2 Lane ports - PCS Misc registers */
> > #define PCS_PCIE_X2_POWER_STATE_CONFIG2                    0x40c
> > #define PCS_PCIE_X2_POWER_STATE_CONFIG4                    0x414
> > #define PCS_PCIE_X2_ENDPOINT_REFCLK_DRIVE                  0x420
> > #define PCS_PCIE_X2_L1P1_WAKEUP_DLY_TIME_AUXCLK_L          0x444
> > #define PCS_PCIE_X2_L1P1_WAKEUP_DLY_TIME_AUXCLK_H          0x448
> > #define PCS_PCIE_X2_L1P2_WAKEUP_DLY_TIME_AUXCLK_L          0x44c
> > #define PCS_PCIE_X2_L1P2_WAKEUP_DLY_TIME_AUXCLK_H          0x450
> > ...
> >
> > Here, QPHY_V4_PCS_PCIE_POWER_STATE_CONFIG2 = 0xc would be correct,
> > assuming a pcs_misc offset of 0x400. However, starting with
> > ENDPOINT_REFCLK_DRIVE, the register would be
> > QPHY_V4_PCS_PCIE_ENDPOINT_REFCLK_DRIVE = 0x1c. Our offsets are off-by 0x4.
> >
> > The existing V5 offsets, on the other hand, were all correct. For this
> > reason, I considered that V5 is the most likely place to add the missing
> > PCS misc definitions.
>
> Ok, sounds sane. Please use _v5 for the regs layout.
>
> >
> > Is this explanation sufficiently convincing? Where does the v4/v5 scheme
> > in upstream kernel originate?
>
> Sometimes it's vendor kernels, sometimes it's a feedback from devs
> that have access to actual specs.
>
>
> --
> With best wishes
> Dmitry

