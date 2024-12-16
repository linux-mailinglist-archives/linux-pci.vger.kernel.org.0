Return-Path: <linux-pci+bounces-18483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2269F2A2E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 07:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D435C18856FA
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 06:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C16D1CCB4A;
	Mon, 16 Dec 2024 06:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BmOjfsjV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED051C878E;
	Mon, 16 Dec 2024 06:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734330683; cv=none; b=IezupvUXW/k08501a7fIYcWy1IghXK6Poj3F+qA6st1ev+kYaFnWx1WA9ZTWeoA4QU2sec1paU6lUQOk1p9+rVRWhOQfVch2Iqk5nxEy7+yle6M/vj+mlUx0kUma7+NpvDoOMIwo9FU8RQ5hTk1NEjVgb2H9HKfceP7bHqc4r18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734330683; c=relaxed/simple;
	bh=ZuLWWhM6BgTAVQR7VgGSwyys8SX1T5E1Hhc5P84eUzc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVoprW4D6HYPuvMXK3XetzgWorzox6ZjSz+6+/bCID/P+VoepMsaVOqyKOwL223AE+N3FVDAZsyZS+h4clBLmaFTslGQtjT04vWr+UWe7cBy6ZxA+Wy7xdh210sTeeCR9KYXdqgFnZD4WrL8Qoq69+UfmH8YXvDlOiB9HVzZkuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BmOjfsjV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG3HGhr021637;
	Mon, 16 Dec 2024 06:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/vSVfCXOF4iVZRrIFkv7hhmD
	VMvNpOocSjbRo9mQITU=; b=BmOjfsjVHLp1M9R8BSW27K9xTZbzK3OjEAF0y8l2
	YF5gLVqmzbwd2wsYe6a+6NWwcv8RAvsoDb3nmEjgJMz0lI6GajPUvxo5sRDHCqfD
	QyqRi3b7pAD6KkXCZ7dnemjtXL1ktnHpCyEixbT3TKX35nv/stc5AkdUpIb29+3+
	qDzQmzrAMDEp8Ruft1kRoe3pLv8n105OOv9zx0C0HkjhF6yFZLMCzBXQw/WEfj/k
	AlarKoDKNyHRusI8olN2XIQN+g2VGnn00XzorqJpHYI3fG4n++CYC22Z6nuuJ+u5
	UgVON49lnbTbxKNVZ3y/mKOeBbnlG6rKLoeyEE2RFPCkPg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jc5kgdjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 06:31:05 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BG6V44g021652
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 06:31:04 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 15 Dec 2024 22:30:58 -0800
Date: Mon, 16 Dec 2024 12:00:51 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
CC: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <p.zabel@pengutronix.de>,
        <quic_nsekar@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v2 2/6] phy: qcom: Introduce PCIe UNIPHY 28LP driver
Message-ID: <Z1/JG+RkTBW9JuMO@hu-varada-blr.qualcomm.com>
References: <20241204113329.3195627-1-quic_varada@quicinc.com>
 <20241204113329.3195627-3-quic_varada@quicinc.com>
 <710aa948-d27f-49f6-a4a8-73f6208502c3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <710aa948-d27f-49f6-a4a8-73f6208502c3@oss.qualcomm.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: j_eREXnaHXyx9uLLkPXB50WXUkT3bRAy
X-Proofpoint-GUID: j_eREXnaHXyx9uLLkPXB50WXUkT3bRAy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=924 priorityscore=1501
 mlxscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160051

On Thu, Dec 05, 2024 at 05:40:15PM +0100, Konrad Dybcio wrote:
> On 4.12.2024 12:33 PM, Varadarajan Narayanan wrote:
> > From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> >
> > Add Qualcomm PCIe UNIPHY 28LP driver support present
> > in Qualcomm IPQ5332 SoC and the phy init sequence.
> >
> > Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
>
> [...]
>
> > +struct qcom_uniphy_pcie_regs {
> > +	unsigned int offset;
> > +	unsigned int val;
>
> u32

ok.

> > +};
> > +
> > +struct qcom_uniphy_pcie_data {
> > +	int lanes;
> > +	/* 2nd lane offset */
> > +	int lane_offset;
>
> 'lanes', 'lane_offset' and '2nd lane' together imply one of:
>
> - there can be more lines, all at an equal offset
> - there can only ever be two lines
>
> Please specify which one is the case

There can be more lines all at an equal offset. However, it is
just 2 lines in this SoC's case. Will remove the "2nd lane offset"
comment.

> > +	unsigned int phy_type;
> > +	const struct qcom_uniphy_pcie_regs *init_seq;
> > +	unsigned int init_seq_num;
> > +	unsigned int pipe_clk_rate;
> > +};
> > +
> > +struct qcom_uniphy_pcie {
> > +	struct phy phy;
> > +	struct device *dev;
> > +	const struct qcom_uniphy_pcie_data *data;
> > +	struct clk_bulk_data *clks;
> > +	int num_clks;
> > +	struct reset_control *resets;
> > +	void __iomem *base;
> > +};
> > +
> > +#define	phy_to_dw_phy(x)	container_of((x), struct qca_uni_pcie_phy, phy)
>
> A space after #define, please

ok

> > +
> > +static const struct qcom_uniphy_pcie_regs ipq5332_regs[] = {
> > +	{
> > +		.offset = PHY_CFG_PLLCFG,
> > +		.val = 0x30,
> > +	}, {
> > +		.offset = PHY_CFG_EIOS_DTCT_REG,
> > +		.val = 0x53ef,
> > +	}, {
> > +		.offset = PHY_CFG_GEN3_ALIGN_HOLDOFF_TIME,
> > +		.val = 0xCf,
>
> mixed case hex.. please make it lowercase

ok

> > +	},
> > +};
> > +
> > +static const struct qcom_uniphy_pcie_data ipq5332_x1_data = {
> > +	.lanes		= 1,
> > +	.phy_type	= PHY_TYPE_PCIE_GEN3,
> > +	.init_seq	= ipq5332_regs,
> > +	.init_seq_num	= ARRAY_SIZE(ipq5332_regs),
> > +	.pipe_clk_rate	= 250000000,
> > +};
> > +
> > +static const struct qcom_uniphy_pcie_data ipq5332_x2_data = {
> > +	.lanes		= 2,
> > +	.lane_offset	= 0x800,
> > +	.phy_type	= PHY_TYPE_PCIE_GEN3,
> > +	.init_seq	= ipq5332_regs,
> > +	.init_seq_num	= ARRAY_SIZE(ipq5332_regs),
> > +	.pipe_clk_rate	= 250000000,
> > +};
>
> Are there going to be more UNIPHY-equipped SoCs?

Not sure. Since this driver was initially posted for ipq5018 and
ipq5332 suport was added later, there are two sets of data one
for 5018 and one for 5332.

> > +static void qcom_uniphy_pcie_init(struct qcom_uniphy_pcie *phy)
> > +{
> > +	const struct qcom_uniphy_pcie_data *data = phy->data;
> > +	const struct qcom_uniphy_pcie_regs *init_seq;
> > +	void __iomem *base = phy->base;
> > +	int lane, i;
> > +
> > +	for (lane = 0; lane != data->lanes; lane++) {
>
> while effectively the same, < would be less eyebrow-raising

ok.

> > +		init_seq = data->init_seq;
> > +
> > +		for (i = 0; i < data->init_seq_num; i++, init_seq++)
> > +			writel(init_seq->val, base + init_seq->offset);
>
> writel(init_seq[i].val, ...)

ok.

> > +
> > +		base += data->lane_offset;
> > +	}
> > +}
> > +
> > +static int qcom_uniphy_pcie_power_off(struct phy *x)
> > +{
> > +	struct qcom_uniphy_pcie *phy = phy_get_drvdata(x);
> > +
> > +	clk_bulk_disable_unprepare(phy->num_clks, phy->clks);
> > +
> > +	reset_control_assert(phy->resets);
>
> This can fail, return it instead of zero

ok.

> [...]
>
> > +MODULE_LICENSE("Dual BSD/GPL");
>
> I think this is too vague, there are many BSD variants

Will change it to "GPL v2"

Thanks
Varada

