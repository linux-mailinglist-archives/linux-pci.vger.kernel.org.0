Return-Path: <linux-pci+bounces-12775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF5C96C555
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 19:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B80C28169B
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 17:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02DE1E0081;
	Wed,  4 Sep 2024 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UdLEGLuV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7251E4932;
	Wed,  4 Sep 2024 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470524; cv=none; b=junCeYQJRgaB5Sc6kQi/qGXbWQriw66KnuQAlv0FmtLWmdbVYyWV10uB9/nleblY0MpwYdISpRAk9zFXFHCkN5VMlTRGNOqEOcexSA8BRBeKPx0DlLovuPZ8jzNm+8BLZFSyyRehzY+n8eN9UCJtEwYv9dNvMIYXaeOrwquJWJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470524; c=relaxed/simple;
	bh=mHg0AXNu7Xn1u+Xl5zGyhOLNhE66eg1oZoCXjyVy/F4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UFk2VRIYOIEMCBwemuWsTupdb2ifjkfL4H/2vjnMnFgyX/vU1GhT2Hf3agnb4ag4+fkL/v75bB23uxR92EJb3g9GzDQZ6pqxo+F6YkPVvnoJO4ZTS4QfMkLPVPTBtYO4/8E9/CkCC//ucgmRadWeje5kO/P28pWj50V4YTluLRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UdLEGLuV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484BE0UI015575;
	Wed, 4 Sep 2024 17:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ifcXyK1VksfIVr5U6pkXKNqIKZ/EJtOyoODGhx5JbsE=; b=UdLEGLuVhu1yb7Fx
	lG9mdwwzMW5WtolFmXRSJnWnI1WI2B75Fk882TKESmqWvrUTgDd18iAtp3USfHkA
	Ch0yngdSQUN3w4PHaYkmRjzylMFZSa5VjRIk+1kfM5ioWk61fym0ZDOkTz/PfK+g
	ZippnJUkYdH9pNG1B/0PvNaLeRkR2y7fl+I9e8yu9Bcb9Hrhh1PrqD0uuGrPbZwh
	VklG9Tt7EvtTN6aH2smqI2dZM9qPIGe5gLyfToO8cQ1mY1Fd5tWhpHGFCcd9jJaI
	nLdAejtMl1cibJawy+c3dIu3lOz4InYqvxw2eUFbLJeRVsvOyQZabCKBtv5EKP7x
	qAQxnw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41dt69dp18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 17:21:45 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 484HLish025251
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 17:21:44 GMT
Received: from [10.50.7.129] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 10:21:35 -0700
Message-ID: <ea8ccb1e-2344-4c35-8a95-7b3f1fe23e08@quicinc.com>
Date: Wed, 4 Sep 2024 22:51:30 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 4/6] PCI: qcom: Add support for IPQ5018
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <p.zabel@pengutronix.de>,
        <dmitry.baryshkov@linaro.org>, <quic_nsekar@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <robimarko@gmail.com>
References: <20240827045757.1101194-1-quic_srichara@quicinc.com>
 <20240827045757.1101194-5-quic_srichara@quicinc.com>
 <20240830083852.cwjc6skgypva6u6u@thinkpad>
Content-Language: en-US
From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <20240830083852.cwjc6skgypva6u6u@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MphsN_zb9IeVUWR0Vo0gGqdEPpeFOl7t
X-Proofpoint-ORIG-GUID: MphsN_zb9IeVUWR0Vo0gGqdEPpeFOl7t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_15,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=850 mlxscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040132



On 8/30/2024 2:08 PM, Manivannan Sadhasivam wrote:
> On Tue, Aug 27, 2024 at 10:27:55AM +0530, Sricharan R wrote:
>> Introduce a new compatible and re-use 2_9_0 ops.
>>
> 
> While adding a new SoC, please add more info about the controller. Like the
> hardware revision (internal/synopsys), max number of lanes supported, max link
> speed, is it a derivative etc...
> 
  ok sure, will add.

Regards,
  Sricharan


