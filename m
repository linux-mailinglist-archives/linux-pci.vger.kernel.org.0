Return-Path: <linux-pci+bounces-23617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFEBA5F36F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 12:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71BBA17EB0A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 11:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B75266B6E;
	Thu, 13 Mar 2025 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fq3rii6i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384A9266B73;
	Thu, 13 Mar 2025 11:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866694; cv=none; b=iXRxxH4Y3cGdvQVmxfLAvqWuMekIium2P4VVXX5X0sVBUIpxvhsjuxYgRwxgI4iAv089gRITfSkyAGAqUXqK7+7zSlxuhdmdKw31gT2zAjyb/Aq8Ls3vINOyuqrl6rkk+sbfLICvB3g4elVb/7hg/FyB+Z1yWf8C/dlaxfpqy14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866694; c=relaxed/simple;
	bh=8+biv/o8wlO/TJhXQ6nHjtxQmSZnc0sQWpG/GVdRxQI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J98N0T4kAUDQhQQIL9Cges507JAmd15SGn2DzQ5Woxo5Eq8TKr2POXbgI8rm6VhqLyX+r3wlPFYGxvUdDxP67dbR7cJdvg4pRcBOouMdQk7Gp5Jt9QHPEEamW0muqbh0RTjGjY1kAc2Zmegsq0I6eV9xxyGwCg5PId7PnESKIpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fq3rii6i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DBmopg008735;
	Thu, 13 Mar 2025 11:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1nU7k0GAFnYM9yJq3OCZJOiT
	i3oB1t4nTqFNeNJiZsE=; b=fq3rii6imITpBO14SRBQIOBjV2LEXNZwYHwGvALQ
	a8VO+UUOrrljKXOmMCyuZ4lny00rV8YPWnK0t/pBcrGgY2WE1WK69FiJNzCjZNNn
	27WXgyy8ku60cZx6yD0JhqnA8mqZCiFUQrpqS5qOXv0lE7yy67K5qdMERN4B1UYC
	c0oFP6xBWm0EzZkOQnRgY+1wL+sCCxtUQHESVVwJuktp/dt1ea0zO6tnPVL2wZxW
	dscXCy1oTPQI673LY6yGnaq0boo0tmwIOou29bQUp5JcrsnR2ypNrYF7GAMhfuxt
	s+x/jyn8nLKcVrL22YG7sorxnLCUy1ng/1RoLs1rGGTefg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45bpg89f2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 11:51:27 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52DBpQEO010042
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 11:51:26 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 13 Mar 2025 04:51:22 -0700
Date: Thu, 13 Mar 2025 17:21:18 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 1/4] dt-bindings: PCI: qcom: Add MHI registers for
 IPQ9574
Message-ID: <Z9LGti0cdg9Sj6xa@hu-varada-blr.qualcomm.com>
References: <20250313080600.1719505-1-quic_varada@quicinc.com>
 <20250313080600.1719505-2-quic_varada@quicinc.com>
 <1c88f01b-4414-4f02-91ed-572a9261543a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1c88f01b-4414-4f02-91ed-572a9261543a@kernel.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=PtWTbxM3 c=1 sm=1 tr=0 ts=67d2c6bf cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=eKiS_yBL17JveMwNzzEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: bxmIp-tD8B4YV8kCoZKExp-eFGTOJZtr
X-Proofpoint-ORIG-GUID: bxmIp-tD8B4YV8kCoZKExp-eFGTOJZtr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 mlxlogscore=743 impostorscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130093

On Thu, Mar 13, 2025 at 12:01:54PM +0100, Krzysztof Kozlowski wrote:
> On 13/03/2025 09:05, Varadarajan Narayanan wrote:
> > Append the MHI register range to IPQ9574. This is an optional range used
>
> Same question, you still did not answer - does hardware have this range?
> Which hardware has it?

Yes. All three (ipq6018, ipq8074, ipq9574) have this range.

> I pointed out that you affect at least two other variants. Your commit
> msg must explain that. For example what if they do not have this range?
> Then this change is just wrong.
>
> Start documenting the hardware, not your drivers.

Since all three have this range will this commit message be ok?

	Append the MHI register range to ipq6018, ipq8074-gen3 & ipq9574. This
	is an optional range used by the dwc controller driver to print debug
	stats via the debugfs file 'link_transition_count'.

Additionally, should I update ipq6018.dtsi and ipq8074.dtsi also and include in
this patchset?

Thanks
Varada

