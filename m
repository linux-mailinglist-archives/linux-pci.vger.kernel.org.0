Return-Path: <linux-pci+bounces-25921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D094A898A1
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 11:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D7E3AE5EF
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 09:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AF32820DA;
	Tue, 15 Apr 2025 09:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SaAyArZV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCB127FD6B;
	Tue, 15 Apr 2025 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744710654; cv=none; b=I8at3D1aQ0E3tUP1Nxf2d0jTlJTAU+HVoEv3T9PgoATSdiGdr90e4Ew/s1YRY19O9O7H75AP+6U+sjf4LEvHdrsKHfQCw2SIUvKJeBa2cYup1akexo2FbNg+rjcSpDgNW0luqaWGiUaA2qcE2zfj1sFzWbOCsgA4DrMVcwHLkZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744710654; c=relaxed/simple;
	bh=uWXNFhSWbSEShQiyQF5i1yq9PoN545++J/zBx1ZtRbg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1lfv9Z0qfsuJBxbWKrQGy8YTbmkJGaAkZ2jtvjgjK7mKumbiP7h9ZUoYRNHynAHs34GaMU+Bw4iVCI2x89dyXLtWNXYmPItHcNez8lwK1f1OVIpHGFW2KMllWs84Ek0bZ4P5sfwWMOk+pd6I15YgWZcdE2ZMgfk8S0KYCkFQh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SaAyArZV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F8tIdu012707;
	Tue, 15 Apr 2025 09:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uWXNFhSWbSEShQiyQF5i1yq9
	PoN545++J/zBx1ZtRbg=; b=SaAyArZVsdvFFtlUz5ImfF26EeuyRdUfTBkSars9
	rwuu3m3syvUHOyOPKIxyb3dWPZsTcvQVpI/cp02vree61xZc8B4E7O9jAI3KHoJR
	Dujt5R7Hrq/jY/DEhzwjJ3iUwHnEvcssL5B+YHRNv4wZ/TBFLWPDDVJEV4PvDWxS
	ycc2AdvEQ+Ea4vF5yfjHt9Iq0uyyxvfNlX4jvz8DqTLGoAGzpDhkeFRov8p0FzMO
	g2TnVsbrYMhyyqlh5PriJ3NPAF25PVXNuT5niTMJERzpc4rt8g0RyxKObniDJyk5
	Vbt4pT9cGMdFptGd1D8ta5DYoqaRBqSLGZnW8G8b1Q4Grw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ydhq7t6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 09:50:44 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53F9oVYK016076
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 09:50:31 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Apr 2025 02:50:27 -0700
Date: Tue, 15 Apr 2025 15:20:23 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Praveenkumar I
	<quic_ipkumar@quicinc.com>
Subject: Re: [PATCH v14 3/4] arm64: dts: qcom: ipq5332: Add PCIe related nodes
Message-ID: <20250415095023.dxipm4hd73jxoe4n@hu-varada-blr.qualcomm.com>
References: <20250317100029.881286-1-quic_varada@quicinc.com>
 <20250317100029.881286-4-quic_varada@quicinc.com>
 <48361e2a-89b2-4474-97aa-557fbbbdf601@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <48361e2a-89b2-4474-97aa-557fbbbdf601@oss.qualcomm.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zOicwmg99osoW_qkt04ALmcbknNXxAD4
X-Authority-Analysis: v=2.4 cv=C7DpyRP+ c=1 sm=1 tr=0 ts=67fe2bf4 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=PnGFYBFXPhy9mkTWHzgA:9 a=CjuIK1q_8ugA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: zOicwmg99osoW_qkt04ALmcbknNXxAD4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=587
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150069

On Fri, Apr 11, 2025 at 01:22:39PM +0200, Konrad Dybcio wrote:
> On 3/17/25 11:00 AM, Varadarajan Narayanan wrote:
> > From: Praveenkumar I <quic_ipkumar@quicinc.com>
> >
> > Add phy and controller nodes for pcie0_x1 and pcie1_x2.
> >
> > Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
>
> [...]
>
> I think you're reaching out of the BAR register space by an order of magnitude,
> on both hosts
>
> IIUC it's only 32 MiB for both

Checked with h/w person and he confirmed that the BAR register space is correct.
It is 256MB for one and 128MB for the other controller.

> the register addresses/sizes look good

Ok.

Thanks
Varada

> I'm not super glad that we decided to move forward with not putting PARF first,
> as the other registers are in the BAR region, but bindings are bindings and
> bindings are ABI..
>
> Konrad

