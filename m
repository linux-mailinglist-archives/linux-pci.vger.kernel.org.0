Return-Path: <linux-pci+bounces-31836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA94AFFF26
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 12:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258F33B731A
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 10:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4DC2D8397;
	Thu, 10 Jul 2025 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R1DYcAdG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7408821;
	Thu, 10 Jul 2025 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143133; cv=none; b=Pn03clLGz4bCiYcWAtPFiq9iDKjhm6ehMI4eEi0j1U/ekCYhO/Z7LY7G8VMDQ0ww7HVXguf2zDDaRXOyGd2TVANyuioPgoXyWihpE3Y1/usIM9N4x6YlxnNdo+cm6f6tW5c52h5X/6zsH178XNlo8YCbT4tt2fDxWoxgsJNXkv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143133; c=relaxed/simple;
	bh=1q0jGZCotwRtBVi9Aa70CLuH18o7Rq0YgwEDCowVdiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O2Uhv09EXPxYrJ2eJZV1cW53GM/FjGUdoMdjmRbOAgASKhSTCzFks/y4cnSGv2O3FgBzCAiHUU44ZbFmQkVBqJfkqWgBm2511GPpJ13f7JHQgvaDt1WZpMNBJXgwz5aOkazR5wlyy8b4+NDA5h5A1J6gW7oHiys8Ge4YXMJRpZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R1DYcAdG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A8kAKU016804;
	Thu, 10 Jul 2025 10:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1q0jGZCotwRtBVi9Aa70CLuH18o7Rq0YgwEDCowVdiI=; b=R1DYcAdGBOka5kQf
	dR1Y6DcyRnhF3EDfh74/NWthtnfrOLl13OK9dWLgRCgJuP9ZUK3d4xYu3Z1eTCCP
	nq1QDZle87zvvbbYZHSPwqsBgr/1Ha9keG5vsVYgLQGqF7+6rUuf/q5sAhgADUVa
	oQnEp+X55NsM7HS5fLuPYXx+DmaMLDjz6LhpnP8Nts6o5pDmgUcKSj2dqIz2U/xD
	8DAg3mAvGIhd+oAWMS++crbhILAl9uBENXYPjemLWcQTbYQJh1HO2q29dHdDyxP5
	LctrbFLhVJZtlkFTlhQJ2NGCyPRgwb6dwiromfbaCrBSKSJszb0PhCBMbCMhj+2C
	ipdsKg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smbnvjfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 10:25:16 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56AAP7Yo032077
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 10:25:07 GMT
Received: from [10.253.75.243] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 10 Jul
 2025 03:25:00 -0700
Message-ID: <4f963fcc-2b92-4a01-93a4-f0ae942c1b6f@quicinc.com>
Date: Thu, 10 Jul 2025 18:24:57 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: sa8775p: remove aux clock from
 pcie phy
To: Johan Hovold <johan@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@oss.qualcomm.com>
CC: <andersson@kernel.org>, <konradybcio@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <jingoohan1@gmail.com>,
        <mani@kernel.org>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <bhelgaas@google.com>, <johan+linaro@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <neil.armstrong@linaro.org>,
        <abel.vesa@linaro.org>, <kw@linux.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <qiang.yu@oss.qualcomm.com>,
        <quic_krichai@quicinc.com>, <quic_vbadigan@quicinc.com>
References: <20250625090048.624399-1-quic_ziyuzhan@quicinc.com>
 <20250625090048.624399-4-quic_ziyuzhan@quicinc.com>
 <25ddb70a-7442-4d63-9eff-d4c3ac509bbb@oss.qualcomm.com>
 <aG-LWxKE11Ah_GS0@hovoldconsulting.com>
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
In-Reply-To: <aG-LWxKE11Ah_GS0@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA4OSBTYWx0ZWRfXx6u/93p3/wSe
 gmB5E7RkHIwssuQY8Ga0spaR3+9/JDEBNrEg1pA3W+uuhNQmDvMV5JPHwUPn1eXx2Wys/010R6d
 urXqbJluJg6Clw2r4gEjBTuAOkFcZhc7t9gQsuWOCVXXBk69iGfiXbd5uGhpKRD8KFO7/i/+GzM
 5wOaFCQxeMHJqA2n6Y0eN8tpSmec/wtiIMUAk0aAXoLSektSToZBkJwF2kZHU6k3QrYB0m5FgT6
 3y+S1wTpSqi+yaWkNQmLBtmV/9BY/n5qW6Dn6979GuAAlG8Fnw2eOzUe2gW+j8tJKVF4p4A1DB/
 XzSKj7ydm++4LG6OMfyVsKMJFmMaQ3yElo1e+2WlWvmBTe90SVJ8ampvIBJoQN2ZqrJ4lIS2S2X
 8YOheIgNK0D1IyQZehpLl1Qi1cRrjsUoXULe0KONg1hWJqIAciNm6LstuePNr4QHSO9qKOqF
X-Authority-Analysis: v=2.4 cv=QM1oRhLL c=1 sm=1 tr=0 ts=686f950c cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=EnfF8tveDwBOVxb-o-4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Rsc-n-n6tRHAxd-CNuI8U1R0DAQDFAUn
X-Proofpoint-GUID: Rsc-n-n6tRHAxd-CNuI8U1R0DAQDFAUn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507100089


On 7/10/2025 5:43 PM, Johan Hovold wrote:
> On Fri, Jun 27, 2025 at 04:50:57PM +0200, Konrad Dybcio wrote:
>> On 6/25/25 11:00 AM, Ziyue Zhang wrote:
>>> gcc_aux_clk is used in PCIe RC and it is not required in pcie phy, in
>>> pcie phy it should be gcc_phy_aux_clk, so remove gcc_aux_clk and
>>> replace it with gcc_phy_aux_clk.
>> GCC_PCIE_n_PHY_AUX_CLK is a downstream of the PHY's output..
>> are you sure the PHY should be **consuming** it too?
> Could we get a reply here, please?
>
> A bunch of Qualcomm SoCs in mainline do exactly this currently even
> though it may not be correct (and some downstream dts do not use these
> clocks).
>
> Johan

Hi Johan

After reviewing the downstream platforms, it seems that GCC_PCIE_n_PHY_AUX_CLK
is generally needed. Would you mind letting us know if there are any platforms
where this clock is not required?


