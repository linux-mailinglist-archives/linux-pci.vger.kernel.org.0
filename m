Return-Path: <linux-pci+bounces-5752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF298991BF
	for <lists+linux-pci@lfdr.de>; Fri,  5 Apr 2024 01:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F2F285961
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 23:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A055613119B;
	Thu,  4 Apr 2024 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RQboHFS7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF959286A6;
	Thu,  4 Apr 2024 23:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712271755; cv=none; b=fo+nu4584LMjOguPfRKWewEOTpQ4yJCtlRWa7yaE2dgp8IpbeSkbKPPYrqRFAg9bUDy+ChpJi+0a4ctPTncpSSiazY4MHmiLKRgK7LOMKzuY4K4IA/3fFHnUZGnL4ssAEwfukY+TVKY6BsYKyxqNUnHZB3vgE66xYMFChEZg5JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712271755; c=relaxed/simple;
	bh=zHgnA+az/AHN+9Bc+MNoJKbYM23a7xXZZrs4jZdhGP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Foj+R0O+Dt0IWzl0q/rFn/wdK8Da6nxX8K+fbEBOwGIiyMgikn7sHE3HGq3GueZDeUgBKB+F7HgQ5ej96Rjiceujq2Gc2XWJxcguBAhPlOZB7HhoUyt18Val8tVmszwlG2AV7ss4YcjZfDgG9cCj/a6gx95t+zLMJDQxC4rRUoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RQboHFS7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 434LNHow012929;
	Thu, 4 Apr 2024 23:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=KiPpkxDkZcXdtwbyPMmI8BmVH2/5c7HbjeyOjw18SX4=; b=RQ
	boHFS7AC4+tyeInS93Alj539CnL3v7mfP5WYbe7+Sm1qLMP0mTdrh0viKJaG2abn
	W5nDfNayh/xVydzqm7un6Z3agTi49r0UbIhNTg559jTRBxeUO/fEKU6ZImmf+4jZ
	ws6NEccS3zn2N6jDFPb7Loj4Dg9eOkPrbntHoDD573rHV1GR02ANrt+RqbIZO2Si
	lIUcWwTJgtUYI7gQFTAaY6CBWy13wvR5/M4MoDex+XC+ZW4TOONkQ+n29Au3ewol
	x7o+SWVN4jqcDlurI45qt+kKW9gC9VzNbn63+N07qTxpvFhs0ELHT0oWjzLLBLSj
	90rHxkWp41LvlUckCVaA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa2q389c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 23:02:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 434N2JuF028919
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Apr 2024 23:02:19 GMT
Received: from [10.110.52.194] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 4 Apr 2024
 16:02:18 -0700
Message-ID: <1d2d231a-ab2e-4552-9e72-2655d778f3b8@quicinc.com>
Date: Thu, 4 Apr 2024 16:02:18 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Add Qualcomm PCIe ECAM root complex driver
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-pci@vger.kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <andersson@kernel.org>,
        <manivannan.sadhasivam@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <quic_ramkri@quicinc.com>,
        <quic_nkela@quicinc.com>, <quic_shazhuss@quicinc.com>,
        <quic_msarkar@quicinc.com>, <quic_nitegupt@quicinc.com>
References: <1712257884-23841-1-git-send-email-quic_mrana@quicinc.com>
 <42d1281e-9546-4af1-a30b-8a0c3969be6b@linaro.org>
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <42d1281e-9546-4af1-a30b-8a0c3969be6b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KXi3EU77--FG8qSn1aR12HQ5hm9oxjo9
X-Proofpoint-GUID: KXi3EU77--FG8qSn1aR12HQ5hm9oxjo9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_19,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 malwarescore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404040166

Hi Krzysztof

On 4/4/2024 12:33 PM, Krzysztof Kozlowski wrote:
> On 04/04/2024 21:11, Mayank Rana wrote:
>> On some of Qualcomm platform, firmware takes care of system resources
>> related to PCIe PHY and controller as well bringing up PCIe link and
>> having static iATU configuration for PCIe controller to work into
>> ECAM compliant mode. Hence add Qualcomm PCIe ECAM root complex driver.
>>
>> Tested:
>> - Validated NVME functionality with PCIe0 and PCIe1 on SA877p-ride platform
>>
> 
> RFC means code is not ready, right? Please get internal review done and
> send it when it is ready. I am not sure if you expect any reviews. Some
> people send RFC and do not expect reviews. Some expect. I have no clue
> and I do not want to waste my time. Please clarify what you expect from
> maintainers regarding this contribution.
> 
> Best regards,
> Krzysztof
> 
Thanks for initial comments.
yes, this is work in progress. There are still more functionalities 
planned to be added as part of this driver. Although purpose of sending 
initial change here to get feedback and review comments in terms of 
usage of generic Qualcomm PCIe ECAM driver, and usage of MSI 
functionality with it. I missed mentioning this as part of cover letter. 
So please help to review and provide feedback.

Regards,
Mayank

