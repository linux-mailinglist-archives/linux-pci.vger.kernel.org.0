Return-Path: <linux-pci+bounces-19848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9528A11B61
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 08:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A053A7DAD
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 07:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E6722F152;
	Wed, 15 Jan 2025 07:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dhtbnpdR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7234B236A61;
	Wed, 15 Jan 2025 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736927929; cv=none; b=U/sCnZpNbbpKeW3m25f3QjYutg21p1cyjwdCTuNrXMum/BHQXXZ4CW+ae9b2gZhkN4iTFE+BR9FhMjzpkmP5E9Yip3VZXjHUB83eaDmcqWQupks5+pqz/OZvbVfp19ZKPi6jqQUlm2bj0oAut3Y/7x7Vea8GIftprnR7JpJB43g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736927929; c=relaxed/simple;
	bh=/dJoj0mqOTmkoV3UXIGqPt6FEKyI9UYbUD8611H/sMw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xl5nUMdwWmYnG5fM/Sqe/CYzWjJm2T2LR0xUDMb2zazqGL6VicEKFiPIDQOCACxxvyBqg1rZrVf7MGhxU4F4x6EAQdoaHFLyB0uLHb/+I/8aiuTOpxmZHrldTZ0oQm62TSz6JvcRVuSkJap+eNV+1KKexYsz0qllBFb0OyjAdow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dhtbnpdR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F5cPBr013921;
	Wed, 15 Jan 2025 07:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=sLwXMdQzvWOJb4WsDCioa7Jt
	yHeUekEJUQu8MLw0PwA=; b=dhtbnpdRaLQZUPFuV2cZaSiWLROQ0s1I2Y1ZzWvw
	39TsTQsfepXYWwpH2whs6VPVPVoFQQFdXAEIZBAlPd/6h3zbjwmhq1RWeWRF5VsF
	ZTo6PJiEshco8oaA9dDdw7oSZFRH92Lxdn238GsfUnjDExRWHAiW90Lw7CLhU0/R
	jj5ZlydOr4w3LDukgWW+bokC/tjXF9G/XQIYAgDBz786uOm+EFc8lLVWv1zwZmL2
	KTkd2MhBXlQdZH9OyeYoFXiZOFGN0Sxlra3I3zX+2Di3gcXPkDaC1EM1kiQDqpna
	bRV2IvxeDMhX0aB69kd13gUK9hB9QhOaYt9RUBR6SWlwPw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44671q0asn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 07:58:33 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50F7wXvk031194
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 07:58:33 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 14 Jan 2025 23:58:26 -0800
Date: Wed, 15 Jan 2025 13:28:22 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <quic_nsekar@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        Praveenkumar I <quic_ipkumar@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v5 4/5] arm64: dts: qcom: ipq5332: Add PCIe related nodes
Message-ID: <Z4dqnr9+MTue3VbX@hu-varada-blr.qualcomm.com>
References: <20250102113019.1347068-5-quic_varada@quicinc.com>
 <20250108183235.GA220566@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250108183235.GA220566@bhelgaas>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yEiBqHoUvMPVEeVoNLX-JJ4sCL9GcypG
X-Proofpoint-ORIG-GUID: yEiBqHoUvMPVEeVoNLX-JJ4sCL9GcypG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_03,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150059

On Wed, Jan 08, 2025 at 12:32:35PM -0600, Bjorn Helgaas wrote:
> On Thu, Jan 02, 2025 at 05:00:18PM +0530, Varadarajan Narayanan wrote:
> > From: Praveenkumar I <quic_ipkumar@quicinc.com>
> >
> > Add phy and controller nodes for pcie0_x1 and pcie1_x2.
>
> > +		pcie1: pcie@18000000 {
> > +			compatible = "qcom,pcie-ipq5332", "qcom,pcie-ipq9574";
> > +			reg = <0x00088000 0x3000>,
> > +			      <0x18000000 0xf1d>,
> > +			      <0x18000f20 0xa8>,
> > +			      <0x18001000 0x1000>,
> > +			      <0x18100000 0x1000>,
> > +			      <0x0008b000 0x1000>;
> > +			reg-names = "parf",
> > +				    "dbi",
> > +				    "elbi",
> > +				    "atu",
> > +				    "config",
> > +				    "mhi";
> > +			device_type = "pci";
> > +			linux,pci-domain = <1>;
> > +			bus-range = <0x00 0xff>;
>
> This bus-range isn't needed, is it?  pci_parse_request_of_pci_ranges()
> should default to 0x00-0xff if no bus-range property is present.

Ok.

>
> > +			num-lanes = <2>;
> > +			phys = <&pcie1_phy>;
> > +			phy-names = "pciephy";
>
> I think num-lanes and PHY info are per-Root Port properties, not a
> host controller properties, aren't they?  Some of the clock and reset
> properties might also be per-Root Port.
>
> Ideally, I think per-Root Port properties should be in a child device
> as they are here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/mvebu-pci.txt?id=v6.12#n137
> but it looks like the num-lanes parsing is done in
> dw_pcie_get_resources(), which can only handle a single num-lanes per
> DWC controller, so maybe it's impractical to add a child device here.
>
> But I wonder if it would be useful to at least group the per-Root Port
> things together in the binding to help us start thinking about the
> difference between the controller and the Root Port(s).

This looks like a big change and might impact the existing
SoCs/platforms. To minimize the impact, should we continue
supporting the legacy method in addition to the new per-Root port
approach. Should we take this up separately? Kindly advice.

Thanks
Varada

