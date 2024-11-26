Return-Path: <linux-pci+bounces-17308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADC89D9149
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 06:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DCD3B2524F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 05:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3973F262BE;
	Tue, 26 Nov 2024 05:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OyLBfDlf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE62653;
	Tue, 26 Nov 2024 05:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732598213; cv=none; b=S3r5mbpX8zuFbGsTqTQwaBZA60MzDNtt+/eeVL0g4F12ADw2VWoFyM0hqCEQpbkJb93Ae7ViuhqK8RNG8UkH+htdoTP+dZSJrg1wZzAc7ZyDeGpLH1m22SMu+oKTNnnggIrTX0NOYPl1qL1BIuPfNKlcneIOk37d4WitUG1G/bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732598213; c=relaxed/simple;
	bh=F3EQM6zq3ydwSlvCGNb8VJU8zX6Mlyxg6Fcfv3j4sQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KZ1Hrxrrm8lDZiHLXawCILMu6q4PWVhOuktp/GFP8cMdZRbZnMYecJP+GB9oIHMKZLFAKFrvxPEHiACHjdEjr+WJqMv4kEB4OrNsuAbfhhiU23JjLrcIAmUHJzQKilKxHjn6yNaKPx8tLje0LIjaE8HPwe1gFF2mzO/FBq5Ol9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OyLBfDlf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APNYUk6026659;
	Tue, 26 Nov 2024 05:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ec/fHnASTeToD4OX5B0ZNH6mpcWIFbxbkxdPTazbvL0=; b=OyLBfDlfC7CtY/d3
	XEBcVVP4axuaADP7ySQ0gs1Tog5+OiDLJfUV5YNulk97GcQ5GlZcbxYP0zk0t4Mu
	rlBar9coyGtRWjP6/5ZolYN/msyM+Y/GWStuM4LCq3h6xJB6vPTQ6Eu1MvKC7IXp
	WEFv06d2bcJR1RRaKWUu1UWHwvS0mEvsoJUsPzm/XyXQBGYYjCFWY5RhFYBy340O
	8BBMExZvXkUnoeS1Us+PE7tj0c7mbqWJoFcUOgCnIOYOXO4jxrA5BD8QL6tpYch+
	OmPyststIpbX+tYizHnB6fe21YKvMACsRE+K56zNEgWxkFyWB2LOkUMoNP0fbZ76
	hY0cZA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4336mxeucs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 05:16:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AQ5GWRA002030
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 05:16:32 GMT
Received: from [10.216.8.10] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 25 Nov
 2024 21:16:27 -0800
Message-ID: <cc403025-d7ac-27dc-21c1-59dba1b724fa@quicinc.com>
Date: Tue, 26 Nov 2024 10:46:24 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 0/3] Add support for RAS DES feature in PCIe DW
To: Shradha Todi <shradha.t@samsung.com>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
CC: <manivannan.sadhasivam@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <fancer.lancer@gmail.com>,
        <yoshihiro.shimoda.uh@renesas.com>, <conor.dooley@microchip.com>,
        <pankaj.dubey@samsung.com>, <gost.dev@samsung.com>,
        <",quic_nitegupt"@quicinc.com>
References: <CGME20240625094434epcas5p2e48bda118809ccb841c983d737d4f09d@epcas5p2.samsung.com>
 <20240625093813.112555-1-shradha.t@samsung.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240625093813.112555-1-shradha.t@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pPFJ0RaDqqkHIMvZd-LV5sU1yIqWO3NS
X-Proofpoint-GUID: pPFJ0RaDqqkHIMvZd-LV5sU1yIqWO3NS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1011 suspectscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411260042

+cc nitesh

On 6/25/2024 3:08 PM, Shradha Todi wrote:
> DesignWare controller provides a vendor specific extended capability
> called RASDES as an IP feature. This extended capability  provides
> hardware information like:
>   - Debug registers to know the state of the link or controller.
>   - Error injection mechanisms to inject various PCIe errors including
>     sequence number, CRC
>   - Statistical counters to know how many times a particular event
>     occurred
> 
> However, in Linux we do not have any generic or custom support to be
> able to use this feature in an efficient manner. This is the reason we
> are proposing this framework. Debug and bring up time of high-speed IPs
> are highly dependent on costlier hardware analyzers and this solution
> will in some ways help to reduce the HW analyzer usage.
> 
> The debugfs entries can be used to get information about underlying
> hardware and can be shared with user space. Separate debugfs entries has
> been created to cater to all the DES hooks provided by the controller.
> The debugfs entries interacts with the RASDES registers in the required
> sequence and provides the meaningful data to the user. This eases the
> effort to understand and use the register information for debugging.
> 
> v2: https://lore.kernel.org/lkml/20240319163315.GD3297@thinkpad/T/
> 
> v1: https://lore.kernel.org/all/20210518174618.42089-1-shradha.t@samsung.com/T/
> 
> Shradha Todi (3):
>    PCI: dwc: Add support for vendor specific capability search
>    PCI: debugfs: Add support for RASDES framework in DWC
>    PCI: dwc: Create debugfs files in DWC driver
> 
>   drivers/pci/controller/dwc/Kconfig            |   8 +
>   drivers/pci/controller/dwc/Makefile           |   1 +
>   .../controller/dwc/pcie-designware-debugfs.c  | 474 ++++++++++++++++++
>   .../controller/dwc/pcie-designware-debugfs.h  |   0
>   .../pci/controller/dwc/pcie-designware-host.c |   2 +
>   drivers/pci/controller/dwc/pcie-designware.c  |  20 +
>   drivers/pci/controller/dwc/pcie-designware.h  |  18 +
>   7 files changed, 523 insertions(+)
>   create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.c
>   create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.h
> 

