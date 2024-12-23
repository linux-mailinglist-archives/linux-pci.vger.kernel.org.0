Return-Path: <linux-pci+bounces-18956-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD00B9FAAD7
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 07:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CDA97A165E
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 06:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AA774BE1;
	Mon, 23 Dec 2024 06:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cQ8q9KVR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9044528DA1;
	Mon, 23 Dec 2024 06:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734936954; cv=none; b=Y/LfDjGi+50s/JCFqf6FZ30uZxPzxyB4hWtb5Quk/iuWacn8ciL4VwlBp1ylo32yg4K1iYEdxKfFqaM/+2g8cM5RiT31ibI0zprYN42o5DjG1MDnXdHuVM8TwtmtzKTQVn945mY1urs64Yn6btreGIka1wcv+FkjCWXX7uz4isM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734936954; c=relaxed/simple;
	bh=2ttBKUVOZX2jW8rOGOfo9Rw37szCGRq0JH3sOy/Y7Ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b3c2tMnK4lNeJ9Lh4+gGtWT3MlPN8Gbz0uEhrZCYMoMUYKxLFgRDrPS3yzQfvbr9+YqxhJrQIB27lpeZMcQX1bXkhONABXUwBwUofbNviRbGtfKqjz+fUJ+2OVt1UM1LKOsmATaL/dkMxdwCXwRDfUB1HCU0b/TWhCkdW4PP4D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cQ8q9KVR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BN6VXne029156;
	Mon, 23 Dec 2024 06:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	abeKnHzcmizE1Vy4o9LG9Zf8D09HoQUXuX6ai48eh+A=; b=cQ8q9KVRTF8+Q0tq
	3gJD+fvTHD6ZLzpVE3jyrMBd27kPI6+/smPL+s2JDweyDQXg0c7qoBxpDUShjanJ
	Yy9dt4CHLXUoTDh5/21fIDszh/vVAJg68d+gFbZtqfv4jHDcmUkS2kWVLEk3M3D9
	HmqjceB1kDLKJZM73MsxGTFTokvegczo9TFcNQPIi5zYdmHVwF17lzWXzf0rIuvY
	cYplQ4RK4noAo1+IXOEyWZU45eFuNmqzePrD0QcBxuK9rwilDLMTHpsXnLxALHBM
	jGusd8PStePi+FOdX+st0Me7vgwWc9VNw1OlN1lo2lUWgA7vyBeAkIIgitksF0s6
	FmkpCA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43q2p083cn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 06:55:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BN6tgqd013937
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 06:55:42 GMT
Received: from [10.216.2.152] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 22 Dec
 2024 22:55:38 -0800
Message-ID: <6f815dd0-f111-6f7e-16dc-80b0dad7806a@quicinc.com>
Date: Mon, 23 Dec 2024 12:25:35 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 0/3] PCI: dwc: Skip waiting for link up if vendor
 drivers can detect Link up event
Content-Language: en-US
To: Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Konrad Dybcio <konradybcio@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kwilczynski@kernel.org>,
        <andersson@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_mrana@quicinc.com>
References: <20241123-remove_wait2-v5-0-b5f9e6b794c2@quicinc.com>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20241123-remove_wait2-v5-0-b5f9e6b794c2@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TaLhMoBi78aSddeeaEF4SIXbbGx42zaf
X-Proofpoint-ORIG-GUID: TaLhMoBi78aSddeeaEF4SIXbbGx42zaf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=644 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412230059


Could this series be picked up?

- Krishna Chaitanya.

On 11/23/2024 12:39 AM, Krishna chaitanya chundru wrote:
> If the vendor drivers can detect the Link up event using mechanisms
> such as Link up IRQ, then waiting for Link up during probe is not
> needed. if the drivers can be notified when the link comes up,
> vendor driver can enumerate downstream devices instead of waiting
> here, which optimizes the boot time.
> 
> So skip waiting for link to be up if the driver supports 'use_linkup_irq'.
> 
> Currently, only Qcom RC driver supports the 'use_linkup_irq' as it can
> detect the Link Up event using its own 'global IRQ' interrupt. So set
> 'use_linkup_irq' flag for QCOM drivers.
> 
> And as part of the PCIe link up event, the ICC and OPP values are updated.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
> Changes in v5:
> - update the commit text as suggested by (mani).
> Changes in v4:
> - change the linkup_irq name to use_linkup_irq a suggested by (bjorn
>    andresson)
> - update commit text as suggested by bjorn andresson.
> - Link to v3: https://lore.kernel.org/r/linux-arm-msm/20241101-remove_wait-v3-0-7accf27f7202@quicinc.com/T/
> Changes in v3:
> - seperate dwc changes and qcom changes as suggested (mani)
> - update commit & comments as suggested (mani & bjorn)
> - Link to v2: https://lore.kernel.org/linux-pci/20240920-remove_wait-v2-0-7c0fcb3b581d@quicinc.com/T/
> Changes in v2:
> - Updated the bypass_link_up_wait name to linkup_irq  & added comment as
>    suggested (mani).
> - seperated the icc and opp update patch (mani).
> - Link to v1: https://lore.kernel.org/r/20240917-remove_wait-v1-1-456d2551bc50@quicinc.com
> 
> ---
> Krishna chaitanya chundru (3):
>        PCI: dwc: Skip waiting for link up if vendor drivers can detect Link up event
>        PCI: qcom: Set use_linkup_irq if global IRQ handler is present
>        PCI: qcom: Update ICC and OPP values during link up event
> 
>   drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++++++++--
>   drivers/pci/controller/dwc/pcie-designware.h      |  1 +
>   drivers/pci/controller/dwc/pcie-qcom.c            |  7 ++++++-
>   3 files changed, 15 insertions(+), 3 deletions(-)
> ---
> base-commit: cfba9f07a1d6aeca38f47f1f472cfb0ba133d341
> change-id: 20241122-remove_wait2-d581b40380ea
> 
> Best regards,

