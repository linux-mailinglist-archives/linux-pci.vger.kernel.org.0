Return-Path: <linux-pci+bounces-22529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AED35A47851
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 09:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01EAE170393
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 08:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0945F225412;
	Thu, 27 Feb 2025 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gWkRrh+3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420A81F16B;
	Thu, 27 Feb 2025 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740646434; cv=none; b=rkWLYeJ2dFKrYeojaShqFsWHAPOacgVI+rUsavw4CGj33gO3LkAWE4wRWaB/9u7C7DQjXtYPZ0uDlRO+FYqIDAdSY2xl+MPWVxl2Zzl/J7tFS38e40ZstbsM9wDq4cLPM0IPGhA/FywteVZFjj0BAT+ebvubP6lGaTvtMxI4r20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740646434; c=relaxed/simple;
	bh=AOLBVio6vzVYJf2bqp+9IX9u7u/JDXUY5gdgspj9cPI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9v5fLG9DemmNjeCBrvJfX/aQwgNImkuCxROuXBk2sVbJog67DnftiG9mryWORKaQ/pE8KvVFnviJFWT/NujSaQOmsPu6RE0qbvagewwFFYahD2HZatFiAPplSjC/SJxIcPVD0yiC9tokorEvbRfmfZlcALgMw7DKXdL2RfP91s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gWkRrh+3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R8DrQP018544;
	Thu, 27 Feb 2025 08:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bw1PYuSEp4O5hdX7H6E/TvKB
	rfllT/ojMop2tlSvOag=; b=gWkRrh+39rQpt3y8l/nF4063PVNAtosrny9DO5qx
	N3Hw8DHc4j2mDS0Az7q8RafcRVAwLhI6xfDejc5ujyUUw/V54+tYpclweX5iMzh/
	cmMX4djzMyDh/ubB7RF/wKgbnIX5NQoyRP1X6ML4/q4/yMY39ea/I+hAtKxUy+B1
	0kZCXBLjMUcZiDF6yeVFhoaKhr6XDReLUcyFZyCM5bnWiJ9zE/bFmaW43w8glDiz
	RUWrU44tjGJFHPXCBLNX+IhWZhroLHe6K/ac1lwQG/QBjXtsHbPtOp6cusraYEH8
	88K5ZLxrvavp4W42tlk9vWeYNHunbUirpyc+vBkQIKApeA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prn4ys4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 08:53:38 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51R8rbrO023753
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 08:53:37 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 27 Feb 2025 00:53:32 -0800
Date: Thu, 27 Feb 2025 14:23:28 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Vinod Koul <vkoul@kernel.org>
CC: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <quic_nsekar@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v10 2/7] phy: qcom: Introduce PCIe UNIPHY 28LP driver
Message-ID: <Z8AoCHxD4IlFeXv9@hu-varada-blr.qualcomm.com>
References: <20250206121803.1128216-1-quic_varada@quicinc.com>
 <20250206121803.1128216-3-quic_varada@quicinc.com>
 <Z64xQcgHIgAEzKFb@vaman>
 <Z7MChDND+iClDNES@hu-varada-blr.qualcomm.com>
 <Z7//eDJZw2SNNc5Z@vaman>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z7//eDJZw2SNNc5Z@vaman>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fqSDG55IYoeVkzP-dc-sUFjEk3UC6RD7
X-Proofpoint-GUID: fqSDG55IYoeVkzP-dc-sUFjEk3UC6RD7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270067

On Thu, Feb 27, 2025 at 11:30:24AM +0530, Vinod Koul wrote:

[ . . .]

> > > should we not unroll the pipe clk registration here?
> >
> > Since it is a 'devm_' clk_hw_register_fixed_rate, wouldn't the devm
> > framework do the unregister?
> >
> > 	$ git diff
> > 	diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
> > 	index 6b4f76b9c4da..3fd1a12cc163 100644
> > 	--- a/drivers/clk/clk-fixed-rate.c
> > 	+++ b/drivers/clk/clk-fixed-rate.c
> > 	@@ -58,6 +58,7 @@ static void
> > 	devm_clk_hw_register_fixed_rate_release(struct device *dev, void *re
> > 		 * the hw, resulting in double free. Just unregister the hw and
> > 		 * let
> > 		 * devres code kfree() it.
> > 		 */
> > 	+	printk("--> %s: %s\n", __func__, __clk_get_name(fix->hw.clk));
> > 		clk_hw_unregister(&fix->hw);
> > 	 }
> >
> > 	diff --git a/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
> > 	b/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
> > 	index 311f98181177..9a8d8d9a7c2b 100644
> > 	--- a/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
> > 	+++ b/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
> > 	@@ -267,6 +268,7 @@ static int qcom_uniphy_pcie_probe(struct
> > 	platform_device *pdev)
> >
> > 		phy_provider = devm_of_phy_provider_register(phy->dev,
> > 							     of_phy_simple_xlate);
> > 	+	phy_provider = ERR_PTR(-EINVAL);
> > 		if (IS_ERR(phy_provider))
> > 			return PTR_ERR(phy_provider);
> >
> > I forced an error here and saw that devm_clk_hw_register_fixed_rate_release
> > is getting called, which in turn calls clk_hw_unregister. Is that sufficient?
> > Or am i missing something.
>
> I missed that internally this is devm_, this is fine

Thanks for the clarification. Have posted V11, please review.

-Varada

