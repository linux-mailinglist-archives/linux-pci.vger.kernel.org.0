Return-Path: <linux-pci+bounces-11263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FA6947453
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 06:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADAF280A8E
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 04:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CFB13D52B;
	Mon,  5 Aug 2024 04:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QpHXvxyP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EDD182B9;
	Mon,  5 Aug 2024 04:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722831587; cv=none; b=FpTkMgXhyWYF7vWwsJ01kxsbDdmYM9bYHzmZXiRLyWH8biQsZbRiwpGnlKTLjryKLYZJan4gndsC5l2D802RsNKfg8oyBOXqrfTMLtLTdhNS19jkeH/bJngqteJeWGrIxXr3cvMBKLjntCWY13V0xOiOEwSpu9FxoMABYkzoKLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722831587; c=relaxed/simple;
	bh=7cOMV7VQBPqLJQvT+NALykIWPnus53f8gwiGWxc2Gjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Eb16GFx2M5jrm8Q5Cs+SV9A8vH6eySUqG29+CS+A4NxUceDcWDC1etaZAGUYStdg4CJ5omxafiqfD56fds5eyNDLSpKIb38dewJns46J1wH7huhjEnw2vO5sxRD5pQqGM3c98Kzsa+gEi99NWCBKvmrQM5xBxjkd2jWgIakOqRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QpHXvxyP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4752VXXJ000440;
	Mon, 5 Aug 2024 04:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HVLvPMw0luzApYNvqT+YqoGGGGnmBR1sIdmWnrRHtzY=; b=QpHXvxyPQvcrEXew
	v0Bpec7j+k4aNkiFqhd4VV8BC//Bb7XQ+YdUTSHEBuELy/SoA2Xi0K+EBGJLflkg
	qYVuHFEEQQYg7+JmoR/06sxx3S2/okNjlfRISERIUkqQ81ngOaQXy7kWD+l3uscg
	+PYcTbxL0iE1GX4sRr9UKF7e0u01fSp/VA5Tng06yCLq19ddVLM8BvzqsaJPS5oh
	ff2hDNOK9qVXxKZozyIyfg6MCguhE2cd8tnyGoEpWgChVIavZOPY9Q8BIr2Hv0Ps
	XNTP7EJr+Y3XWm8V3D9gOQ9iPuc/3vPEsY8YTaucLbmWDZhhiM+W9KmMkYtgBrff
	YQdfMQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40sbvgatw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 04:19:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4754JZZT030319
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Aug 2024 04:19:35 GMT
Received: from [10.216.50.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 4 Aug 2024
 21:19:30 -0700
Message-ID: <efe6862e-21bd-cd11-1760-d97a67ec88b2@quicinc.com>
Date: Mon, 5 Aug 2024 09:49:26 +0530
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
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        "Bartosz
 Golaszewski" <brgl@bgdev.pl>,
        Jingoo Han <jingoohan1@gmail.com>,
        "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        <andersson@kernel.org>, <quic_vbadigan@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
References: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
 <hq4ptnfy4bxc3javkjuos7tbncrjw2qa3znokx3ocu75ei5fhu@bgwryygnbcq2>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <hq4ptnfy4bxc3javkjuos7tbncrjw2qa3znokx3ocu75ei5fhu@bgwryygnbcq2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: h3OpC0CcGsnXqB-x0-vnNPqzR-pmoFIh
X-Proofpoint-ORIG-GUID: h3OpC0CcGsnXqB-x0-vnNPqzR-pmoFIh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-04_14,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=871 adultscore=0 malwarescore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050028



On 8/3/2024 4:26 PM, Dmitry Baryshkov wrote:
> On Sat, Aug 03, 2024 at 08:52:46AM GMT, Krishna chaitanya chundru wrote:
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
> This is not a proper changelog entry. It doesn't allow reviewers to
> understand what actually happened. Could you please list your actual
> changes in a reply and also include them in a changelog if there is a
> need for v3.
> 
ack
- Krishna Chaitanya.
>> - Removed D3cold D0 sequence in suspend resume for now as it needs
>>    seperate discussion.
>> - change to dt approach for configuring the switch instead of request_firmware() approach
>> - Link to v1: https://lore.kernel.org/linux-pci/20240626-qps615-v1-4-2ade7bd91e02@quicinc.com/T/
>> ---
>>
> 

