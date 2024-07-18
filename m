Return-Path: <linux-pci+bounces-10490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73808934838
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 08:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53F3281268
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 06:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3066CDCC;
	Thu, 18 Jul 2024 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JwtpzhL/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C7E41C65;
	Thu, 18 Jul 2024 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721284869; cv=none; b=nqJ2lnRBunAbwMiHRxuBwecFZixoGW7xBhsTL5Z8BGF0KSRzxmXiz8CNmaU5btqTKchvfyISxAWbzdCB7HRLJMsyLdo46/UDqmVj0mNP4NRV1VrMdTIGOPx3VeCXTZJyFVTbWEB+1207Wg2/vyNrItlWjdMl3FJ0QWMO/ajj3ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721284869; c=relaxed/simple;
	bh=r79Ck8mh6a6fiuyhAyywJZ0j1dFwu/87hYwtUX9tpZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NSzQ07cCvos4e4ge0MGl8Y0ljOxWoqi27jc0blkyEu2OZ6OV9GjK12KDqvKkPbNPxVmKops4Yv7LDW95D6CihOplERj9dvzCFgkn2SWUsZfsaDK/QI8YBK5XGcYK6zBQ+svSmYIBbLRGRyO1Our6zt7iD3FLXXvZb/iqG9/OFck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JwtpzhL/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I5L4Yf009132;
	Thu, 18 Jul 2024 06:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r79Ck8mh6a6fiuyhAyywJZ0j1dFwu/87hYwtUX9tpZo=; b=JwtpzhL/ktCRSeF6
	5xclZz7nq4utedQe4qJz66Z6qlCXGj3Hcc6SmKz6rg5q6iMDbfad5hB0Jh2Wq0JA
	7yP/rqKgNfeKkp6ig8hMxntV4s6k+f/I5aR7nnhlCir+7LC+BcCKE7pKGr0Rgykf
	zc38NOyw5pCbWffRCPnyIxmYJBZyF9AaKNzHNa1OcYZG4KaKyDZ2S0gsPjiF7ygc
	SickA2VCv2zjYRSu8oGD4AEtfGA+Mo/RDM1JXoVOEwhwiQnhIaSJcGBIp0zMsHCQ
	Os1nkxymtkmV2cblQEw0ALRvchcViyiv5AO2mj8kc66n5W9ekQGJvBDL/EhihoTH
	6lCaKw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfu4hj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 06:40:56 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46I6et5J029946
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 06:40:55 GMT
Received: from [10.151.37.100] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Jul
 2024 23:40:50 -0700
Message-ID: <cde6db36-e3ce-4b93-9703-58928b9e59ac@quicinc.com>
Date: Thu, 18 Jul 2024 12:10:47 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 1/4] dt-bindings: PCI: qcom: Document the IPQ9574 PCIe
 controller.
To: Krzysztof Kozlowski <krzk@kernel.org>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <manivannan.sadhasivam@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: devi priya <quic_devipriy@quicinc.com>
References: <20240716092347.2177153-1-quic_srichara@quicinc.com>
 <20240716092347.2177153-2-quic_srichara@quicinc.com>
 <c696fac6-1f26-437d-84fc-b14eb15ccce4@kernel.org>
Content-Language: en-US
From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <c696fac6-1f26-437d-84fc-b14eb15ccce4@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Rhn7aAlXYLiU0EsJ-Yivg00cf0WhLLJ0
X-Proofpoint-GUID: Rhn7aAlXYLiU0EsJ-Yivg00cf0WhLLJ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_03,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 bulkscore=0 impostorscore=0 mlxscore=0 mlxlogscore=660
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407180044



On 7/17/2024 1:12 AM, Krzysztof Kozlowski wrote:
> On 16/07/2024 11:23, Sricharan R wrote:
>> From: devi priya <quic_devipriy@quicinc.com>
>>
>> Document the PCIe controller on IPQ9574 platform.
> Subjects are without full stop.
ok, will fix.
> With that fixed:
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Thanks

Regards,
  Sricharan

