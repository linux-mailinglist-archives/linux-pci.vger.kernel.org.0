Return-Path: <linux-pci+bounces-11262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF99947450
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 06:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A9E8B207E7
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 04:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD2313D52B;
	Mon,  5 Aug 2024 04:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="orhs7ijc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F89182B9;
	Mon,  5 Aug 2024 04:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722831545; cv=none; b=Y1AqaRD+/dAviNFsptVG+QcGfLLBt0DtmK+7KEf9/2lJDrDccVpgOzfj7w4zSvLKkkOzf3jMVNlslyHfWcdTiUrBue8E24EmYWdKEqEbgnHP7blsMFdh5/BAsvykbGDgLfcwZjyuBLQr8bE/6d/NgED9Upg2nHkenATB7tJd9cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722831545; c=relaxed/simple;
	bh=TgjjUgnCspHV1FYRZGIAeX9BKSTM9zTuylKOSGViULw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qb2d/MDYMCkcOY9Qc8gSNw3DRnrwTK2ecHdRICuOFGSndDqFw2jTzU8AmAIYv48sabGPmlLF2r9KgEW/65yTyKBU2Ctw3ABP/u9mvaLoEzSeBDyFYilVCHRvii/Yqtmdo+0A/Nj0b/a0ncIE6oeQo5TMYn1CVUDLpaAUCgGj+gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=orhs7ijc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4752VlfZ010967;
	Mon, 5 Aug 2024 04:18:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8Q9xTk6LEYjMXAvpWV/OkfScyXPzQP7rfg7q5H+rjFU=; b=orhs7ijcwu6afQoV
	Rz9QgUvQmoR76W2tYv1e6mC74jxN+ba8+kBlTqDsSl50eVY9EtaLz65uTH9XFEFD
	I5KZXW4tfIJlZ6v1e1FZZmiEv1gqOHZsj7ivS9XKQe7CvNJeDfbyYevUULP5n4tD
	6YLRXKiQa71++U+2+YhYtvyw0Hi8sVFLN4IaaSnylEaFO8S8AzcHStfRLL+cldO4
	lcEgbl30AKdKv0MO2PJuzWQRfInIhPQXVGJQ9qDi7BLZJeWWlBsh167QlKR7g4XD
	TqatqPecQUsilk0mYjOw+7UzqKJrrO3FwpmhyAO29t4m8S8YKIe2Zl9/rS8RuMhz
	d92MJg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40sc4y2sxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 04:18:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4754IrOd029096
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Aug 2024 04:18:53 GMT
Received: from [10.216.50.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 4 Aug 2024
 21:18:47 -0700
Message-ID: <a1981c4d-a81e-ecb3-bb81-b77d9c14789a@quicinc.com>
Date: Mon, 5 Aug 2024 09:48:43 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/8] PCI: Enable Power and configure the QPS615 PCIe
 switch
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>
CC: <andersson@kernel.org>, <quic_vbadigan@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>
References: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
 <fcfe1ce3-6835-44e8-807d-290a641813ed@kernel.org>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <fcfe1ce3-6835-44e8-807d-290a641813ed@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oHuJxT852NLvsL6W459IrhcSBVWerlcG
X-Proofpoint-GUID: oHuJxT852NLvsL6W459IrhcSBVWerlcG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-04_14,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 mlxlogscore=763 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050028



On 8/4/2024 2:27 PM, Krzysztof Kozlowski wrote:
> On 03/08/2024 05:22, Krishna chaitanya chundru wrote:
>> QPS615 is the PCIe switch which has one upstream and three downstream
>> ports. One of the downstream ports is used as endpoint device of Ethernet
>> MAC. Other two downstream ports are supposed to connect to external
>> device. One Host can connect to QPS615 by upstream port.
>>
>> QPS615 switch power is controlled by the GPIO's. After powering on
>> the switch will immediately participate in the link training. if the
>> host is also ready by that time PCIe link will established.
>>
>> The QPS615 needs to configured certain parameters like de-emphasis,
>> disable unused port etc before link is established.
>>
>> The device tree properties are parsed per node under pci-pci bridge in the
>> devicetree. Each node has unique bdf value in the reg property, driver
>> uses this bdf to differentiate ports, as there are certain i2c writes to
>> select particulat port.
>>   
>> As the controller starts link training before the probe of pwrctl driver,
>> the PCIe link may come up before configuring the switch itself.
>> To avoid this introduce two functions in pci_ops to start_link() &
>> stop_link() which will disable the link training if the PCIe link is
>> not up yet.
>>
>> Now PCI pwrctl device is the child of the pci-pcie bridge, if we want
>> to enable the suspend resume for pwrctl device there may be issues
>> since pci bridge will try to access some registers in the config which
>> may cause timeouts or Un clocked access as the power can be removed in
>> the suspend of pwrctl driver.
>>
>> To solve this make PCIe controller as parent to the pci pwr ctrl driver
>> and create devlink between host bridge and pci pwrctl driver so that
>> pci pwrctl driver will go suspend only after all the PCIe devices went
>> to suspend.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>> Changes in V1:
>> - Fix the code as per the comments given.
> 
> You did not implement the comments so such changelog is rather a joke.
> Respond to each comment from v1 and acknowledge it.
> 
> Then write detailed changelog.
> 
> Best regards,
> Krzysztof
> 
I will write a detailed changelog from v3 onwards spare me for this time.

- Krishna Chaitanya.

