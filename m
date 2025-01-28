Return-Path: <linux-pci+bounces-20426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EEFA203F5
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 06:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5CEE164F50
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 05:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BD81581F1;
	Tue, 28 Jan 2025 05:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nid+QL2S"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E88290F;
	Tue, 28 Jan 2025 05:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738041925; cv=none; b=YvGZ4tULMEnPw51TL0Ih3rWESRY6n5KoU61TgCvgxt/5T9ec1t9/VLffvzS9b3yV/LZiWWgEg16kiNZ4a5RC3m4XFPIZ3k9wF+kFWGxa/KzrtZygurQ5mYtPJrIZZXjN2b3va87QI5W3td5sURxwF4tfdUXwxUSjgrHc9Z541PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738041925; c=relaxed/simple;
	bh=F8wgy4NP6e9rdil0+rdGGy2xW42QDT03wgDYwps56Cc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+yVCfkS0jj8LMS1MTLlUS2YJocXFD/iPKEVz/9zIH3CmMh8Y2bFh6rrnaCKIzPuDLpablnFgiajmT6uAa2Z6B6oTdsbbgDQ769XWwlNdC7U8RIggyBlAhSbQFwNNm+5fptIYMUizSVPG1yuony8o4S7cWuQuGvSjAbKLyuZZgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nid+QL2S; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S4vTOv001797;
	Tue, 28 Jan 2025 05:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=d/gIjDxyx63X4WNg7bj6CGX6
	2jfTe+88mNKY9RRlw1E=; b=nid+QL2Sxrmho0AfOwXyMx1voL6CDJ3Tx5GSdwR/
	WGtqqYn4W3mx6MVyrC7W6ZOBgLecUCbWpBnvpsiodYYSoe8VS3rrjIdJ2Klcz+l9
	KpoYkwyFfNBeSgsmc2IV3JE/Di53PaRljg4WfrKx3Rb8tb8GCcnEWn5D20KTLYCy
	4mD4g8PL9uH/M6v7VOfQh4aS21sku2IBM3QJHJ9o7onqJUxBJpccGBCsAkn9qCVo
	asItf1GklaqHhOl4+ZewaExoFIS57Eldo4SMrFePdc+lbQMxgCYaNJZ1u/iYSA5R
	GRQXwj9u0ZeTqC3YpSKm3q7voHwGoXYfeTuM/IcYlf9uaQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ernkr1f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 05:25:08 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50S5P78j024739
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 05:25:07 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 27 Jan 2025 21:25:01 -0800
Date: Tue, 28 Jan 2025 10:54:58 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
CC: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <p.zabel@pengutronix.de>,
        <dmitry.baryshkov@linaro.org>, <quic_nsekar@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v8 2/7] phy: qcom: Introduce PCIe UNIPHY 28LP driver
Message-ID: <Z5hqKufgEsbF12Tr@hu-varada-blr.qualcomm.com>
References: <20250127072850.3777975-1-quic_varada@quicinc.com>
 <20250127072850.3777975-3-quic_varada@quicinc.com>
 <60d02c55-0d18-4704-9126-8b8ffef5bd68@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <60d02c55-0d18-4704-9126-8b8ffef5bd68@oss.qualcomm.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YM0f33nQZSQLNgtWPPsR5ngfk5TBKTml
X-Proofpoint-ORIG-GUID: YM0f33nQZSQLNgtWPPsR5ngfk5TBKTml
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_01,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=906 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280038

On Mon, Jan 27, 2025 at 04:16:32PM +0100, Konrad Dybcio wrote:
> On 27.01.2025 8:28 AM, Varadarajan Narayanan wrote:
> > From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> >
> > Add Qualcomm PCIe UNIPHY 28LP driver support present
> > in Qualcomm IPQ5332 SoC and the phy init sequence.
> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
>
> [...]
>
> > +	usleep_range(CLK_EN_DELAY_MIN_US, CLK_EN_DELAY_MAX_US);
> > +
> > +	qcom_uniphy_pcie_init(phy);
> > +	return 0;
>
> Please add a newline before the return statement
>
> [...]
>
> > +static int qcom_uniphy_pcie_probe(struct platform_device *pdev)
> > +{
> > +	struct phy_provider *phy_provider;
> > +	struct device *dev = &pdev->dev;
> > +	struct qcom_uniphy_pcie *phy;
> > +	struct phy *generic_phy;
> > +	int ret;
> > +
> > +	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
> > +	if (!phy)
> > +		return -ENOMEM;
> > +
> > +	platform_set_drvdata(pdev, phy);
> > +	phy->dev = &pdev->dev;
> > +
> > +	phy->data = of_device_get_match_data(dev);
> > +	if (!phy->data)
> > +		return -EINVAL;
> > +
> > +	phy->lanes = 1;
> > +	if (of_property_read_u32(dev_of_node(dev), "num-lanes", &phy->lanes))
> > +		dev_info(dev, "Not able to get num-lanes. Assuming 1\n");
>
> return dev_err_probe(dev, ret, "Couldn't read num-lanes\n");
>
> And please make num-lanes required in bindings there
>
> We don't want silent fallbacks in such cases, as it's easy to miss those and
> e.g. ship a product which would then run the PCIe link at half the speed

Sure, will post a new version.

Thanks
Varada

