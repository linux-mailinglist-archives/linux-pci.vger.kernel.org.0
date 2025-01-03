Return-Path: <linux-pci+bounces-19203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E727A0048C
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 07:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB1A3A36B8
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 06:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A481AF0B9;
	Fri,  3 Jan 2025 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JOPrO8De"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DA71957FF;
	Fri,  3 Jan 2025 06:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735887190; cv=none; b=Yy/ngbqK7+1RrAbah3jtzUfWD+PB2zlS8vizU2rak3dAtBsxOZKhG0RT5cTYpR/r05R9rBWxvWl6Z+Htp3P5cRw8Q8s2YskmTXL9W6JW98d5x03KldybKHcLtWOLehHWCAgeujusMH9a32EGAw5Z12VsT0wD9uQOiyjEoi0i4hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735887190; c=relaxed/simple;
	bh=isYiBb7oiYBaJGWmsjMnSGVAfyOYn1rcJKu/1b0r6dY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwLgPdHg2VMhGhptl6mXsKBlg37mKtJ2fRXlJrP1YHenVxWCsYPxBrzUD5UBVXrIK5JxV4AEdcfGYf/p3iUhMw2rt2i/LUqmgJssNcuCf6Jlf+thYP9NSJaDzLSzyzAOXb6hNoBE7/gT8rM3b+zcishTPZ4FLgg8rmaRLDUVZ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JOPrO8De; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5030sbNQ008188;
	Fri, 3 Jan 2025 06:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hyaFWJ3uV6VryfgSKh0Yayoi
	83S+mBT6y9wX8ulhkHM=; b=JOPrO8DelrWKfJDagsT83DQfs244ORMO4Dtwx2b1
	yRjFbLOOUI+/o5hXlsPI/zxb6QVEUiV6aqUcP0x5aGUJDfwwt7aV0T21NAiFDHOZ
	JD20nG3yrhfRt6bjncIQmZ3OwIA9LZL0m8nFwzxETGAttZPKbCEIgMt/ff9d43is
	v+s97CU9+7oWOngFostJQ5ZR0iuyk4e5WL6hehO+fPQDteM7b7UED63cixPnxwNR
	y95IG5hqLUJFvzY19u2cj1oL3KZArH00ep5M3Wh2EnqvK8sbIYqObEKGmLSBskH4
	qTTPMK66r5RYFnxYg7v2uj0rCvZ8U3n87Njyjet8kWs3pg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43x5s0rn1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jan 2025 06:53:01 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5036r0t2012610
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 Jan 2025 06:53:00 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 2 Jan 2025 22:52:55 -0800
Date: Fri, 3 Jan 2025 12:22:51 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <quic_srichara@quicinc.com>
Subject: Re: [PATCH 4/4] arm64: dts: qcom: ipq5424: Enable PCIe PHYs and
 controllers
Message-ID: <Z3eJQyJXSBG+oFF4@hu-varada-blr.qualcomm.com>
References: <20241213134950.234946-1-quic_mmanikan@quicinc.com>
 <20241213134950.234946-5-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241213134950.234946-5-quic_mmanikan@quicinc.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lT6gXrGBlZrGDdzVkjHQ1dyfzH1S9LgO
X-Proofpoint-GUID: lT6gXrGBlZrGDdzVkjHQ1dyfzH1S9LgO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 mlxlogscore=614
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501030058

On Fri, Dec 13, 2024 at 07:19:50PM +0530, Manikanta Mylavarapu wrote:

[ .  .  . ]

> +&pcie2_phy {
> +	status = "okay";
> +};
> +
> +&pcie2 {
> +	pinctrl-0 = <&pcie2_default_state>;
> +	pinctrl-names = "default";
> +
> +	perst-gpios = <&tlmm 31 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};

pcie2 should come before pcie2_phy

> +
> +&pcie3_phy {
> +	status = "okay";
> +};
> +
> +&pcie3 {
> +	pinctrl-0 = <&pcie3_default_state>;
> +	pinctrl-names = "default";
> +
> +	perst-gpios = <&tlmm 34 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};

same here.

-Varada

