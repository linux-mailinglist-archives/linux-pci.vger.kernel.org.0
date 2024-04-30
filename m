Return-Path: <linux-pci+bounces-6838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321668B6A82
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 08:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D27B1B21530
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 06:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A2B33EC;
	Tue, 30 Apr 2024 06:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JW19BNTd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DD6205E25;
	Tue, 30 Apr 2024 06:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714458703; cv=none; b=bMP8hmWv4FdZAiBTs4XiARLP6O3tclp2OvvWkxKS7Y9GuXEC6bR897xZ1HBJHn0r4A+3YYPVL4d4/6fSqi8SgbMqBkQUE4nIK5FrvWTl9Q01XW3VBGKXYrPwHVqTeEx3xGvEVOAmV7Xyofjy9klH6H0I1geT+aQelhMyll4mwY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714458703; c=relaxed/simple;
	bh=7JutYdlyKjRm/d6CPhcXCZiskF7ZHRoD4M0QLTajHCA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugy0yDI3a0VBb6xrFI8CXTxFAR9KPdrUPadmMQ0hRWiSgHDzmbf/pYXDY6McKuhY4CWIGmn0M9ANvOIQZYMhdsvQA7ckNKrlQMvcopYjcHChJUM4z5lXn1HePhA9OdoBLXt/xc9xx/acrQDwdD0EzfMtTt+I2KofDUgAUL6GTMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JW19BNTd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U4RaBk019841;
	Tue, 30 Apr 2024 06:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=/EDHGHEVWUCmdxp3Bjyh7
	Wce+g5mQmyF9Sk2EZ1/ZSE=; b=JW19BNTdgmH04Jj119dRFlpPitsdisGC8g4iD
	cdj7l26qhA9cvTNh1ZeQNuwlrBJD4bgiw6RnB09pNs5PxIPlsKoROng4rE13UrPW
	DGkFkxlZtVXLgHvNaQRloS/wLMlt5Dd9G7WracQKSE7kcgelGJBaQ+iQOZt+PVxr
	Mj5F0LBtXpjdB3IxnCwZMH9HsqHMkdbHbdlC8qxyTCHCwRA57fsIrkuhhWqi9Sj/
	yImsDK6EUFl6FK844wer1ev/p/OJ2g+ZL8bt8ku827neEfK6Au2LJNNp9lxKP92W
	xGxK3VmvlhuotxnIQpuefuXrlhBa6c2Wmqnhf5TWQhrQXPGiQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtd8kkmjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 06:31:26 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43U6VP4x008281
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 06:31:25 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 23:31:18 -0700
Date: Tue, 30 Apr 2024 12:01:15 +0530
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
Message-ID: <ZjCQM24T2XIJ6GAR@hu-varada-blr.qualcomm.com>
References: <20240415182052.374494-1-mr.nuke.me@gmail.com>
 <20240415182052.374494-7-mr.nuke.me@gmail.com>
 <CAA8EJpqY1aDZMaeqBULEOD26UeGYbLd8RsA16jZw7zXJ7_oGPQ@mail.gmail.com>
 <6726fa2b-f5fe-10fb-6aab-f76d61f0b3cd@gmail.com>
 <4a7b1e1d-ac68-4857-8925-f90c9e123fd1@gmail.com>
 <CAA8EJppGW=qyk2P6Z_S=dp0njsCjqZaXjw8qU4MY1HOZR-N=4A@mail.gmail.com>
 <Zi88Hdx6UgBo/gti@hu-varada-blr.qualcomm.com>
 <CAA8EJpq+Bbws8yH5Xq7rHyA+-=DaCcfEcgUa5RUt2+LWQW0kKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJpq+Bbws8yH5Xq7rHyA+-=DaCcfEcgUa5RUt2+LWQW0kKg@mail.gmail.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Kz9y3fLxciuZSj0DW7v68K0H1YjdIf0m
X-Proofpoint-ORIG-GUID: Kz9y3fLxciuZSj0DW7v68K0H1YjdIf0m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_02,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300046

On Mon, Apr 29, 2024 at 01:55:32PM +0300, Dmitry Baryshkov wrote:
> On Mon, 29 Apr 2024 at 09:20, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
> >
> > On Wed, Apr 17, 2024 at 12:50:49AM +0300, Dmitry Baryshkov wrote:
> > > On Wed, 17 Apr 2024 at 00:25, Alex G. <mr.nuke.me@gmail.com> wrote:
> > > >
> > > > Hi Dmitry,
> > > >
> > > > On 4/15/24 16:25, mr.nuke.me@gmail.com wrote:
> > > > >
> > > > >
> > > > > On 4/15/24 15:10, Dmitry Baryshkov wrote:
> > > > >> On Mon, 15 Apr 2024 at 21:23, Alexandru Gagniuc <mr.nuke.me@gmail.com>
> > > > >> wrote:
> > > > >>>
> > > > >>> Add support for the gen3x2 PCIe PHY on IPQ9574, ported form downstream
> > > > >>> 5.4 kernel. Only the serdes and pcs_misc tables are new, the others
> > > > >>> being reused from IPQ8074 and IPQ6018 PHYs.
> > > > >>>
> > > > >>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> > > > >>> ---
> > > > >>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 136 +++++++++++++++++-
> > > > >>>   .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |  14 ++
> > > > >>>   2 files changed, 149 insertions(+), 1 deletion(-)
> > > > >>>
> > > > >>
> > > > >> [skipped]
> > > > >>
> > > > >>> @@ -2448,7 +2542,7 @@ static inline void qphy_clrbits(void __iomem
> > > > >>> *base, u32 offset, u32 val)
> > > > >>>
> > > > >>>   /* list of clocks required by phy */
> > > > >>>   static const char * const qmp_pciephy_clk_l[] = {
> > > > >>> -       "aux", "cfg_ahb", "ref", "refgen", "rchng", "phy_aux",
> > > > >>> +       "aux", "cfg_ahb", "ref", "refgen", "rchng", "phy_aux",
> > > > >>> "anoc", "snoc"
> > > > >>
> > > > >> Are the NoC clocks really necessary to drive the PHY? I think they are
> > > > >> usually connected to the controllers, not the PHYs.
> > > > >
> > > > > The system will hang if these clocks are not enabled. They are also
> > > > > attached to the PHY in the QCA 5.4 downstream kernel.
> > >
> > > Interesting.
> > > I see that Varadarajan is converting these clocks into interconnects.
> > > Maybe it's better to wait for those patches to land and use
> > > interconnects instead. I think it would better suit the
> > > infrastructure.
> > >
> > > Varadarajan, could you please comment, are these interconnects
> > > connected to the PHY too or just to the PCIe controller?
> >
> > Sorry for the late response. Missed this e-mail.
> >
> > These 2 clks are related to AXI port clk on Aggnoc/SNOC, not
> > directly connected to PCIE wrapper, but it should be enabled to
> > generate pcie traffic.
>
> So, are they required for the PHY or are they required for the PCIe
> controller only?

These 2 clks are required for PCIe controller only.
PCIE controller need these clks to send/receive axi pkts.

Thanks
Varada

> > > > They are named "anoc_lane", and "snoc_lane" in the downstream kernel.
> > > > Would you like me to use these names instead?
> > >
> > > I'm fine either way.
> > >
>
>
>
> --
> With best wishes
> Dmitry

