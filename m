Return-Path: <linux-pci+bounces-10340-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 895F6931DEF
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 02:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DB351F2220F
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 00:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02145193;
	Tue, 16 Jul 2024 00:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fIdAhbT+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE08182;
	Tue, 16 Jul 2024 00:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721088343; cv=none; b=qvh9Y9kubKequqFRjfIwIyvPK1RAfvh6a9Pfryw6OUVGWlGxndl32IaM43GH1ATf//nflbTdLci+736bpdhD3QCSKnNGBjDWr+PZnZ1tImtp+QTSM1Llk+V1l/NR3rCpxpubKJXK/01T4WAuSXe7xp1aDXIlVIyZ0b1NfoA+7Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721088343; c=relaxed/simple;
	bh=C4aKHdI+pMXhQa1VV2fGMqBHzjAK+98g4idgc3puck0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a+gJ61C2R1/+Ay10mSYIGnWkuYjP0EcRC3+PcCR7+kFKOpYwyXrtlaKVTl33mQIOAHaQ91uF2oxhqYLaWdXHTACuqd6NgeB6vrJzSPu3dibGSKVQfXTbm0t2qJmMJtCZg2pSsH5PreJFfoksToOIZnWoHjtVTcdFYrB4Chz/z1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fIdAhbT+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FH8nhE022489;
	Tue, 16 Jul 2024 00:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s3COLPyUyljWm+zU/iZd1HAfm7/jelNuscT18zuMsDc=; b=fIdAhbT+/+21xzOW
	xINy3j+33nK4EIF/CkoBKfScxuulSUDJ+DBvD/FJX/DpVlG1zsGPj7B7qYIdZlAH
	hCYbzVrBE3dcjs10e79RfnyRoCdrpNFlrCej1rmUCID/MN3Cpt9MlNiAVUnaFQN+
	4mhbm5nSgCGK38Mcz/gqEQdJ2ITKJeSpMlz+DimL2VbFmu6VyB0kGLUDXepdiS+z
	mySJqEY+c+oPXAVA5Xih+I/jb5zaWaVeNuRkXyIu9lMLlea8MLa1B3gweGzNN1Ot
	TQ358tuNtW5q3Q7LvrQ9BNGAK+5aS1tIbsU/pqvp4/R2aAkQHYYVcQMugIUugFeR
	Sr3/Lw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bjv8nj30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 00:04:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46G04CnA000664
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 00:04:12 GMT
Received: from [10.110.79.225] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Jul
 2024 17:04:11 -0700
Message-ID: <32bd8297-761a-4132-b168-800709e0d703@quicinc.com>
Date: Mon, 15 Jul 2024 17:04:10 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/7] PCI: dwc: Add pcie-designware-msi driver related
 Kconfig option
To: Andrew Lunn <andrew@lunn.ch>
CC: <will@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <manivannan.sadhasivam@linaro.org>, <cassel@kernel.org>,
        <yoshihiro.shimoda.uh@renesas.com>, <s-vadapalli@ti.com>,
        <u.kleine-koenig@pengutronix.de>, <dlemoal@kernel.org>,
        <amishin@t-argos.ru>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <Frank.Li@nxp.com>,
        <ilpo.jarvinen@linux.intel.com>, <vidyas@nvidia.com>,
        <marek.vasut+renesas@gmail.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <quic_ramkri@quicinc.com>, <quic_nkela@quicinc.com>,
        <quic_shazhuss@quicinc.com>, <quic_msarkar@quicinc.com>,
        <quic_nitegupt@quicinc.com>
References: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
 <1721067215-5832-4-git-send-email-quic_mrana@quicinc.com>
 <c6e0a6db-588b-4838-a134-5ce51b1cebea@lunn.ch>
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <c6e0a6db-588b-4838-a134-5ce51b1cebea@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rSKTVtABDCg_TXZcrjpZqy72xLeFk4FS
X-Proofpoint-GUID: rSKTVtABDCg_TXZcrjpZqy72xLeFk4FS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_17,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 phishscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=825 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407150187

Hi Andrew

On 7/15/2024 11:39 AM, Andrew Lunn wrote:
> On Mon, Jul 15, 2024 at 11:13:31AM -0700, Mayank Rana wrote:
>> PCIe designware MSI driver (pcie-designware-msi.c) shall be used without
>> enabling pcie-designware core drivers (e.g. usage with ECAM driver). Hence
>> add Kconfig option to enable pcie-designware-msi driver as separate module.
>>
>> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/Kconfig               |  8 ++++++++
>>   drivers/pci/controller/dwc/Makefile              |  3 ++-
>>   drivers/pci/controller/dwc/pcie-designware-msi.h | 14 ++++++++++++++
>>   3 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>> index 8afacc9..a4c8920 100644
>> --- a/drivers/pci/controller/dwc/Kconfig
>> +++ b/drivers/pci/controller/dwc/Kconfig
>> @@ -6,8 +6,16 @@ menu "DesignWare-based PCIe controllers"
>>   config PCIE_DW
>>   	bool
>>   
>> +config PCIE_DW_MSI
>> +	bool "DWC PCIe based MSI controller"
>> +	depends on PCI_MSI
>> +	help
>> +	  Say Y here to enable DWC PCIe based MSI controller to support
>> +	  MSI functionality.
>> +
> 
> Nit picking, but in the commit message you say separate module. But it
> is a bool, not a tristate, so it cannot be built as a module.
I don't mean to make this driver as loadable module here. Saying this
I agree that commit text is saying as separate module. I shall update
commit text by replacing "separate module" as "separate driver".

> 	Andrew
> 
Regards,
Mayank

