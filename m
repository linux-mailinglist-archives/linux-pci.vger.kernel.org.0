Return-Path: <linux-pci+bounces-15567-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CA99B5D42
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 08:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 184C21C211E0
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 07:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14D61DFD81;
	Wed, 30 Oct 2024 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NBKYc8AK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02E21D9595;
	Wed, 30 Oct 2024 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730275022; cv=none; b=EeTnxfRNu67MJ6ShrbZgbabMS1+3so2lHT2puvQIkBcav52wLOxAG29Fcxx07hphYYXc+bfQrE47iwVgEqpA6MW8VJQlOA3k0c5qh0RoTlXN8XJpgvYm5nYkKL2Hi6MguqRCCWTEtOf2Ola1gLJzOnQGFJNljI5bKQ9cLkTGxJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730275022; c=relaxed/simple;
	bh=jzy6NjUhpqgplvP6dO3x/nvFG3N0AVPu8SNofLcz4Hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RkoYf+UCgVyzFELalgMI0S0ufJgvhyF4SbiJ41osFH++1cZFJKNQdapxg6f30KP25ieoGjFf9Y9CDWYLMUQE7yBL8Sw7vWlW/mHdGsprJ+kTKxlgYEnMIsKmKj34ZeTKBozB7+aH9jlcHlo9djVlIVOP9JIG3hn/2EZYd3o2ncE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NBKYc8AK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TLJk7B009006;
	Wed, 30 Oct 2024 07:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jzy6NjUhpqgplvP6dO3x/nvFG3N0AVPu8SNofLcz4Hc=; b=NBKYc8AKdAoc6cQb
	m26okJRdHgGm2oHFADZdq1KTIfSvotELmMf4DftVqdtVGndYkbVMsz/6X3TMG/vL
	Vy78aC8Or01vYeBUtK0B1TDbnrJxMGjpeBmFD68++PtYAc0wYUi5QeK2bLIHKhxo
	McXw4coCS5p8Gt6GYWzhRd+iSc/k6TlQAlt1Bvg0K35klquE5ot/OLR5HvvttZ6r
	CA0YdDuNfdrV2s247C1lkk7ZxsWVAmD+1htVqfauvyJP8s+LdE5YJ/IuH99gk6ha
	D+lUTfjwA9XrODer/4WFCJgyn2DzzlAJrEqpuw8rtfS4tI5S7ADK2wnBm62nEAg1
	o/G68A==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gsq8k41w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 07:56:52 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49U7upce020939
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 07:56:51 GMT
Received: from [10.239.29.179] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 30 Oct
 2024 00:56:45 -0700
Message-ID: <58e5dbbf-7c35-49ae-b2ff-954fc0e3fe48@quicinc.com>
Date: Wed, 30 Oct 2024 15:56:42 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/7] PCI: qcom: Disable ASPM L0s and remove BDF2SID
 mapping config for X1E80100 SoC
To: Johan Hovold <johan@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>
CC: <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <abel.vesa@linaro.org>, <quic_msarkar@quicinc.com>,
        <quic_devipriy@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <kw@linux.com>, <lpieralisi@kernel.org>, <neil.armstrong@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <johan+linaro@kernel.org>, <stable@vger.kernel.org>
References: <20241017030412.265000-1-quic_qianyu@quicinc.com>
 <20241017030412.265000-7-quic_qianyu@quicinc.com>
 <ZxJrUQDGMDw3wI3Q@hovoldconsulting.com>
 <91395c5e-22a0-4117-a4b5-4985284289ab@quicinc.com>
 <250bce05-a095-4eb3-a445-70bbf4366526@quicinc.com>
 <ZyHc-TkRtKxLU5-p@hovoldconsulting.com>
 <20241030071851.sdm3fu6ecaddoiit@thinkpad>
 <ZyHjSCWGYLDu27ys@hovoldconsulting.com>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <ZyHjSCWGYLDu27ys@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: D5Cb7mxE4A_JpgHN_bxxcjll1VkaFGrq
X-Proofpoint-ORIG-GUID: D5Cb7mxE4A_JpgHN_bxxcjll1VkaFGrq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=865 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410300061


On 10/30/2024 3:42 PM, Johan Hovold wrote:
> On Wed, Oct 30, 2024 at 12:48:51PM +0530, Manivannan Sadhasivam wrote:
>> On Wed, Oct 30, 2024 at 08:15:05AM +0100, Johan Hovold wrote:
>>> Also, are there any Qualcomm platforms that actually support L0s?
>>> Perhaps we should just disable it everywhere?
>> Most of the mobile chipsets from Qcom support L0s. It is not supported only on
>> the compute ones. So we cannot disable it everywhere.
>>
>> Again, it is not the hw issue but the PHY init sequence not tuned support L0s.
> Right, this should be mentioned in the commit message.
OK, I got it. Will write this into commit message.

Thanks,
Qiang Yu
>
> Johan

