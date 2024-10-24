Return-Path: <linux-pci+bounces-15191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D07A39AE22E
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 12:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5EC71C2141C
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 10:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA4D1C07CD;
	Thu, 24 Oct 2024 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fk7ZmD1Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6233D17B51A;
	Thu, 24 Oct 2024 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729764806; cv=none; b=SIHB3tzsdWCrPkwi5cmchlEyCeAuJZIEOYS/cbYlVVJpcNS7F9ayGTPAtM4LjKdin8kBAGvSBbowGWmFIpaTovXf38tNfA9kLbGh8n6gM6Cs6gsrudFX7/PNDzigKZus5oaU3IauB3HsnrBgOMLm4ZKAdznwaJDHBp5wlTb3MMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729764806; c=relaxed/simple;
	bh=L0wG5NAB837vwgfGLXcFMaWmBToiph15GFjRBSGChqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sVAMpqga7lDpAcv+abPSON72ftuTM9dZFjuxaIDRyNHyAMiw/3AwVwVa2hP7RCokpYhMo59TlAynhPFiLLmH9Za6zDRUfpcYFCM74nFHazR92J4NJhkmWa4W/Gq/eN3BN1MnuJqMauitcy24ZSxHSH35juacNy7CJ2bBzmQ9TtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fk7ZmD1Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49O9xCH6031137;
	Thu, 24 Oct 2024 10:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nA66XR+3hg4rn29/8sheuZijZiUknqI2xNQksymz+kY=; b=fk7ZmD1Q9IQivqrP
	PD2Fg3g2oljO8AJl/HrTC/keDTFWv3qxD+2g5YIhrh+8o/p7+f4n/HUT0EQL8alZ
	srHNz4tHRYSsbtHhnWa+FlfjtJmfTNlh+mzDH0mTC8p+4T734VoZtGWowPeqDEfl
	JiPDAVVn4JLNOMyptrUSJLa383UfHeK3x6OGz8Aaj9KZOVsfzQZeHfDyGURjLu1y
	5cQZr9ooCaPHXyekvLzW6RQHVLVc1jo9iLvsswmk+rhTMw0tSGw7V0SCPyDsUw+c
	NMI1yu3t1lwOTSDsThrFG5KmASYPZNxsK4upIhxXdsIp1yhTgGOMXZ0jxrJ3Uztk
	NCkLhQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3vwchc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 10:13:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49OADGVt007852
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 10:13:16 GMT
Received: from [10.216.22.131] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 24 Oct
 2024 03:13:13 -0700
Message-ID: <258bf011-cca6-6d56-c6f2-a9c619c9a212@quicinc.com>
Date: Thu, 24 Oct 2024 15:43:10 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/5] PCI/pwrctl: Ensure that the pwrctl drivers are probed
 before PCI client drivers
Content-Language: en-US
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        <manivannan.sadhasivam@linaro.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        "Abel
 Vesa" <abel.vesa@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson
	<bjorn.andersson@oss.qualcomm.com>,
        <stable+noautosel@kernel.org>
References: <20241022-pci-pwrctl-rework-v1-0-94a7e90f58c5@linaro.org>
 <CACMJSeuhEQVaXhB8hotG_cimQ4rqQVyzF1DyPwtV4m1T5D=o+g@mail.gmail.com>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <CACMJSeuhEQVaXhB8hotG_cimQ4rqQVyzF1DyPwtV4m1T5D=o+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _qhtnl4baAQi3BAw7AK3PTJtuDR3B6D2
X-Proofpoint-ORIG-GUID: _qhtnl4baAQi3BAw7AK3PTJtuDR3B6D2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1011 lowpriorityscore=0
 mlxlogscore=704 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410240081



On 10/23/2024 4:00 PM, Bartosz Golaszewski wrote:
> On Tue, 22 Oct 2024 at 12:28, Manivannan Sadhasivam via B4 Relay
> <devnull+manivannan.sadhasivam.linaro.org@kernel.org> wrote:
>>
>> Hi,
>>
>> This series reworks the PCI/pwrctl integration to ensure that the pwrctl drivers
>> are always probed before the PCI client drivers. This series addresses a race
>> condition when both pwrctl and pwrctl/pwrseq drivers probe parallely (even when
>> the later one probes last). One such issue was reported for the Qcom X13s
>> platform with WLAN module and fixed with 'commit a9aaf1ff88a8 ("power:
>> sequencing: request the WLAN enable GPIO as-is")'.
>>
>> Though the issue was fixed with a hack in the pwrseq driver, it was clear that
>> the issue is applicable to all pwrctl drivers. Hence, this series tries to
>> address the issue in the PCI/pwrctl integration.
>>
>> - Mani
>>
>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> ---
>> Manivannan Sadhasivam (5):
>>        PCI/pwrctl: Use of_platform_device_create() to create pwrctl devices
>>        PCI/pwrctl: Create pwrctl devices only if at least one power supply is present
>>        PCI/pwrctl: Ensure that the pwrctl drivers are probed before the PCI client drivers
>>        PCI/pwrctl: Move pwrctl device creation to its own helper function
>>        PCI/pwrctl: Remove pwrctl device without iterating over all children of pwrctl parent
>>
>>   drivers/pci/bus.c         | 64 +++++++++++++++++++++++++++++++++++++++++------
>>   drivers/pci/of.c          | 27 ++++++++++++++++++++
>>   drivers/pci/pci.h         |  5 ++++
>>   drivers/pci/pwrctl/core.c | 10 --------
>>   drivers/pci/remove.c      | 17 ++++++-------
>>   5 files changed, 96 insertions(+), 27 deletions(-)
>> ---
>> base-commit: 48dc7986beb60522eb217c0016f999cc7afaf0b7
>> change-id: 20241022-pci-pwrctl-rework-a1b024158555
>>
>> Best regards,
>> --
>> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>
>>
> 
> Excellent work, thanks for doing this.
> 
> Tested on: sc8280xp-crd, RB5 and sm8450-hdk.
> 
> Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Just a couple nits from my side under respective patches.
> 
> Bart
Tested on: qcs6490-rb3gen board with work in progress qps615 pcie switch

Tested-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

- Krishna Chaitanya.
> 

