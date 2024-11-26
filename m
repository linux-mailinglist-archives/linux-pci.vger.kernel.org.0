Return-Path: <linux-pci+bounces-17309-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 074AA9D914C
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 06:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B97287A2F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 05:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B81182BC;
	Tue, 26 Nov 2024 05:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oWgdd+7e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4C33D6D;
	Tue, 26 Nov 2024 05:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732598292; cv=none; b=DA4b7EjzuaSpzadKkoCfWSqNCadwck3Bp1p+5iJKtaD/pGV4LKkj40J/LcDufzjewhTaZvw2wUbiKBm8WyZrUFKCrPlU56VXIZhzcTHzJPQpffEq7mluCsFbI19KF8VnhgB0tg2ZPfcwn6AM2RuMD1ka6Gv5r+5BZa44+N46MSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732598292; c=relaxed/simple;
	bh=ITML5GCZ4QoIaHvbGnJdenWmfVQ7hI79gIhmG7nb28w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=euPtH78RQ/cH9Cbfhkb1YS0VUrVsRuB2MKgur59Mh2EaBwFPoAXx3V94TExk4HamHhK+AqQpqQgPBwIxMeTF6NRRhudXYIua5eCh6ky9MJkJvbp3Tg8jsNWiDpe/O9JC2BjqVgznoIBlN0a+mPH+VStyCiuZmttjDpz1sJgIMIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oWgdd+7e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APJE7BO023534;
	Tue, 26 Nov 2024 05:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O/XWCo4/BzHg2lMO92tloK63C1BypGsvrGEGTvkAKsY=; b=oWgdd+7evO7Ar8ms
	3HPWnxgztMsBfk5twg9V7K78lYn1i7YEC1B6QPgFxUdQM2uGPkKV+CLaaZorTqCD
	qsj3nv94vfw5Ycpt8HhGYbiL5TuMh2h3ZiUcSs6x3S7JgbOLsF7b6adI0Zwa87Ys
	cq8vyMlfmGltU24AA6LODh0YEmmnTfkYe7ZZFGeU/Md1FJvx6hnqKbFYe3SRBJk/
	+U7gswcz0QR25qZiKLQKmltG5pCWf+BsQLqtZxBFNgLByiypEiBMuAx3oT4U63cB
	9q9R66ssyoeHxiz0q2SUwuPNny7TnGrn45WqtNr1J16+lyHFz8gM3riqdsdySml/
	WIFcHA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4336cfq01p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 05:17:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AQ5HuNJ027223
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 05:17:56 GMT
Received: from [10.216.8.10] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 25 Nov
 2024 21:17:52 -0800
Message-ID: <03c5bf0e-d65b-7ebb-d12d-3f9b3bae2a4c@quicinc.com>
Date: Tue, 26 Nov 2024 10:47:49 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 0/3] Add support for RAS DES feature in PCIe DW
Content-Language: en-US
To: Shradha Todi <shradha.t@samsung.com>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
CC: <manivannan.sadhasivam@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <fancer.lancer@gmail.com>,
        <yoshihiro.shimoda.uh@renesas.com>, <conor.dooley@microchip.com>,
        <pankaj.dubey@samsung.com>, <gost.dev@samsung.com>,
        <quic_nitegupt@quicinc.com>
References: <CGME20240625094434epcas5p2e48bda118809ccb841c983d737d4f09d@epcas5p2.samsung.com>
 <20240625093813.112555-1-shradha.t@samsung.com>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240625093813.112555-1-shradha.t@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: o3E8-NbYm7y-ZNWzl0rM5wmQQL5XhbzC
X-Proofpoint-ORIG-GUID: o3E8-NbYm7y-ZNWzl0rM5wmQQL5XhbzC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411260042


forgot to add the email in the previous mail.

- Krishna chaitanya.
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

