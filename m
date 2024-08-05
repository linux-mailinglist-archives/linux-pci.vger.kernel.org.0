Return-Path: <linux-pci+bounces-11264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58416947461
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 06:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6A8DB20ABD
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 04:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E1413D245;
	Mon,  5 Aug 2024 04:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JRKS2ea6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7ACA3B;
	Mon,  5 Aug 2024 04:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722832516; cv=none; b=NB12bckpFcti4r2u1EAF8T7veh8Lo/9HvUSCS4T5oyxW4X13BTEZeEQfljnwzLEBCraEHsbGCqNMY9yxf5p0P1AIx6tM1fKXyOLSumWLwWu6ssXvO1NMDjs8pN5NWnYxd0L+JjZT2kN75oMZK29MsSKNF440Z85awmwn9dkLZDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722832516; c=relaxed/simple;
	bh=2KPdzFQw1w/YiSbNcR5VKd6YpSJptdoc3OyRJH3k6+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=awTaWWLLe/ZSI/cAgMKm2w0RkTgrf9MwfDfesuDHxmnKeKBMFOsnDz2g+2mUphqsLWxosYU4s/MbRbQ/UP3GDL30x2Vxb9u6uTRMRPUy4keKYxvHdbskeDq1CPxOvon2/nmUBnXBwHaYqNtXjaHGUjavf30tIvDk4SB0Wcz86ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JRKS2ea6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4752Vh4h010422;
	Mon, 5 Aug 2024 04:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aNl20ubvftUYbfrnFN1yNrsKAtubMNZnCXumrlEcBlA=; b=JRKS2ea63C2pGkKX
	4Kvz7cH/RNVkBW7ezED5qmAOzAlELgrB5Ld+1nWcbNoBn78mWY7v3W509fCITM5k
	Uk2l6KP3tr7HWKP0frRfefiCusNsViLnjFyrKaWOhYEOIFW5qhFc/OT7uDobJFFx
	DQGHZXwq/ZgN83oab8w8s71c1BH2idLrYSXugbRfr+HxQlN3VwI31STWNHXG4XU9
	xgMJCnsaVSxADvDOQQxODZ+SuXVJDARFjtvqwED4u2huqN96vdXq7pY90tiZeUOa
	+yWH9pxU8VmDk5N7hEBoDTiZZLolXZf32t07sRRO+e7UIBujqi8Bhg+D/MMA1wVZ
	zvNaPA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40sc4y2tsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 04:35:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4754Z3WH001944
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Aug 2024 04:35:03 GMT
Received: from [10.216.50.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 4 Aug 2024
 21:34:57 -0700
Message-ID: <ae069a46-a1f4-e847-8b9b-81ca1329d2a3@quicinc.com>
Date: Mon, 5 Aug 2024 10:04:54 +0530
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
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
 Sadhasivam" <manivannan.sadhasivam@linaro.org>
CC: <andersson@kernel.org>, <quic_vbadigan@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>
References: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0aOEQlq-a79jQKZ86MXTaeKTN21OUzI_
X-Proofpoint-GUID: 0aOEQlq-a79jQKZ86MXTaeKTN21OUzI_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-04_14,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050030



On 8/3/2024 8:52 AM, Krishna chaitanya chundru wrote:
> QPS615 is the PCIe switch which has one upstream and three downstream
> ports. One of the downstream ports is used as endpoint device of Ethernet
> MAC. Other two downstream ports are supposed to connect to external
> device. One Host can connect to QPS615 by upstream port.
> 
> QPS615 switch power is controlled by the GPIO's. After powering on
> the switch will immediately participate in the link training. if the
> host is also ready by that time PCIe link will established.
> 
> The QPS615 needs to configured certain parameters like de-emphasis,
> disable unused port etc before link is established.
> 
> The device tree properties are parsed per node under pci-pci bridge in the
> devicetree. Each node has unique bdf value in the reg property, driver
> uses this bdf to differentiate ports, as there are certain i2c writes to
> select particulat port.
>   
> As the controller starts link training before the probe of pwrctl driver,
> the PCIe link may come up before configuring the switch itself.
> To avoid this introduce two functions in pci_ops to start_link() &
> stop_link() which will disable the link training if the PCIe link is
> not up yet.
> 
> Now PCI pwrctl device is the child of the pci-pcie bridge, if we want
> to enable the suspend resume for pwrctl device there may be issues
> since pci bridge will try to access some registers in the config which
> may cause timeouts or Un clocked access as the power can be removed in
> the suspend of pwrctl driver.
> 
> To solve this make PCIe controller as parent to the pci pwr ctrl driver
> and create devlink between host bridge and pci pwrctl driver so that
> pci pwrctl driver will go suspend only after all the PCIe devices went
> to suspend.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
> Changes in V1:
> - Fix the code as per the comments given.
changes in v1:
- Instead of referencing whole i2c-bus add i2c-client node and reference 
it (Dmitry)
- Change the regulator's as per the schematics as per offline review
(bjorn Andresson)
- Remove additional host check in bus.c (Bart)
- For stop_link op change return type from int to void (Bart)
- Remove firmware based approach for configuring sequence as suggested
by multiple reviewers.
- Introduce new dt-properties for the switch to configure the switch
as we are replacing the firmware based approach.
- The downstream ports add properties in the child nodes which will
represented in PCIe hierarchy format.
- Removed D3cold D0 sequence in suspend resume for now as it needs
separate discussion.

- Krishna Chaitanya.
> - Removed D3cold D0 sequence in suspend resume for now as it needs
>    seperate discussion.
> - change to dt approach for configuring the switch instead of request_firmware() approach
> - Link to v1: https://lore.kernel.org/linux-pci/20240626-qps615-v1-4-2ade7bd91e02@quicinc.com/T/
> ---
> 
> ---
> Krishna chaitanya chundru (8):
>        dt-bindings: PCI: Add binding for qps615
>        dt-bindings: trivial-devices: Add qcom,qps615
>        arm64: dts: qcom: qcs6490-rb3gen2: Add node for qps615
>        PCI: Change the parent to correctly represent pcie hierarchy
>        PCI: Add new start_link() & stop_link function ops
>        PCI: dwc: Add support for new pci function op
>        PCI: qcom: Add support for host_stop_link() & host_start_link()
>        PCI: pwrctl: Add power control driver for qps615
> 
>   .../devicetree/bindings/pci/qcom,qps615.yaml       | 191 ++++++
>   .../devicetree/bindings/trivial-devices.yaml       |   2 +
>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       | 121 ++++
>   arch/arm64/boot/dts/qcom/sc7280.dtsi               |   2 +-
>   drivers/pci/bus.c                                  |   3 +-
>   drivers/pci/controller/dwc/pcie-designware-host.c  |  18 +
>   drivers/pci/controller/dwc/pcie-designware.h       |  16 +
>   drivers/pci/controller/dwc/pcie-qcom.c             |  39 ++
>   drivers/pci/pwrctl/Kconfig                         |   7 +
>   drivers/pci/pwrctl/Makefile                        |   1 +
>   drivers/pci/pwrctl/core.c                          |   9 +-
>   drivers/pci/pwrctl/pci-pwrctl-qps615.c             | 638 +++++++++++++++++++++
>   include/linux/pci.h                                |   2 +
>   13 files changed, 1046 insertions(+), 3 deletions(-)
> ---
> base-commit: 1722389b0d863056d78287a120a1d6cadb8d4f7b
> change-id: 20240727-qps615-e2894a38d36f
> 
> Best regards,

