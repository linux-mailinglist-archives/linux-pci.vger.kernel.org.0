Return-Path: <linux-pci+bounces-4187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1731B86B2DB
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 16:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE661C219A3
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 15:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F25815B119;
	Wed, 28 Feb 2024 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IZ8WXMYK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B3A2D022;
	Wed, 28 Feb 2024 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133256; cv=none; b=CbyDm3sCA8IhD8cdzjb3rExBhnaY1gJK98buPQ5MbLnt91ti+grSE+sunX+S1SoHWIc7ROyc/zbFP0HQWZW3PuFWZplFXYaJzWsJ6D9TAJSUjabfVhnLhhDpUpbBYn2wKZoHzm1Fr8QlPyJamHTVNTPokLO5JwXKmmhvN/QJSJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133256; c=relaxed/simple;
	bh=FedmOcx+12JCaQuHQYsl/0EN1PWNm7pn/4UWiFW4KUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h8aIIeDomHDYZQr6MVbuPFoHPCP/sp+okfMUxMCqa8mmBdjLO2vMDpVH3rRav/6XZXoxqE8ityjOEatZQf+N4KQ4O1WSIWRDX/hmAbwfved5Mmwt2g+oAAF18D5dY+blnIGHjJkuWNRh7XW3cYaNyvJ28BkPSfHYwf/GWmfQ9+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IZ8WXMYK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S8uJBE023007;
	Wed, 28 Feb 2024 15:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tJ7QEADpRFi/RSXmkk/gzENuH5VtQMs0GppYk9Fz/kY=; b=IZ
	8WXMYKXgb6kBYCsCnBp5xJWXTYQt2ApgCegpePry0RQd2LQBSPzAFVKDBAQUtWIR
	aIYhc5XkDcnaAa9HKbXtt2pPDCH67kmgZmJiEbN5tZhnTwsMHtP2uTyCdXFbeLmX
	sZ0gHlHCuaySshLoWFC9aDXQjGVx/usf/DfKkISaG4GytQ8XNEToGgr5NBWgFj+H
	ArxU9Qt/1gMSduxbqTQR2cK7Kzn/IX9u0MXAjYh47v7EyckGvHjbuqpCOGYr12Qc
	vflZ5Q1BO3if7J+8K2Cp/yIV+66MJg0r/r3kztnAyyrDaVRvkg2E4FAZzSv3Ntil
	r5CnVQn8hq/t9niVU8ig==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wj1r1rwxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 15:14:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SFE5gf023435
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 15:14:05 GMT
Received: from [10.216.14.152] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 28 Feb
 2024 07:13:56 -0800
Message-ID: <22c7a6a3-70d1-9964-3f34-c7ec550c379c@quicinc.com>
Date: Wed, 28 Feb 2024 20:43:53 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v7 3/7] PCI: qcom: Add ICC bandwidth vote for CPU to PCIe
 path
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Brian Masney
	<bmasney@redhat.com>, Georgi Djakov <djakov@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_parass@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20240227232235.GA251235@bhelgaas>
 <b2e136ba-a7fd-ee8d-e71a-dce1442ada03@quicinc.com>
 <Zd83r8Kg8aJJRBDu@hovoldconsulting.com>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <Zd83r8Kg8aJJRBDu@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uHGBpjv8Jo32uA2vjsG8UK1BT-LAe-df
X-Proofpoint-GUID: uHGBpjv8Jo32uA2vjsG8UK1BT-LAe-df
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_07,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280120



On 2/28/2024 7:09 PM, Johan Hovold wrote:
> On Wed, Feb 28, 2024 at 12:08:37PM +0530, Krishna Chaitanya Chundru wrote:
> 
>> We have limit up to 100 columns in the driver right, I am ok to change
>> to 80 but just checking if I misunderstood something.
> 
> Please take a look at Documentation/process/coding-style.rst, which
> clearly states:
> 
> 	The preferred limit on the length of a single line is 80
> 	columns.
> 
> 	Statements longer than 80 columns should be broken into sensible
> 	chunks, unless exceeding 80 columns significantly increases
> 	readability and does not hide information.
> 
> So generally you should stay within 80 columns, unless not doing so
> *significantly* increases readability. (And note that making such
> decisions requires human judgement, which is why checkpatch now only
> warns about lines longer than 100 chars.)
> 
> Johan
ok got it Johan, As checkpatch is not reporting any warnings or errors
for I misunderstood this. I will correct the comments to fit in 80 
columns in my next series.

- Krishna Chaitanya.

