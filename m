Return-Path: <linux-pci+bounces-10733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 446BC93B54A
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 18:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5351C2327F
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 16:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E2215ECC1;
	Wed, 24 Jul 2024 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iscVs6SH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EB129CA;
	Wed, 24 Jul 2024 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721839941; cv=none; b=syjJKaTidxoAfGT6YW4YVBF4M2JbeKSEVHwPR5kB1GuDrVAESzx9GuCO1BySQIcmR3RuANm9dKV+Xo8KgLkdgMhe0ZmYH6zoZZsyBRut6v2kMVjwjZdYacZmdo/d3sx02w/VJKsN9yAdYHJ8wxVj1dt3iwi22fuqshdkhw6Z5m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721839941; c=relaxed/simple;
	bh=pU30HpDdNh96JD/b3XKpwATR1e2+s/+rcBjBJVgbalo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dmMB00i90J87Xn9dcGsNwio6M7OMlhA5ac5xhA5rzAbHx5QMyS4XcCWL3m5DQpVBkQ+kgFvP6KqPaX0a8b6Akyj8mEmOKOZUeuUYlNE84/jJvP3QfP2U7ALYtJPiNP1d7xHlpbD9FrGm0+q9Ampp2WhkKrKNDpve+pw8SgJSOAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iscVs6SH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46O9heoF003709;
	Wed, 24 Jul 2024 16:51:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gObzenHDuwVHtxRXBAVQdTTADLO5fEyIxGKeUOI5k4M=; b=iscVs6SHZXVFHV54
	4F08FU0uakMXidpJ1yNsT+mntMH3UVeIX4UiYpUJmnP5UqoU97scJxnGuTLFEsOO
	hh+K3hIB0kgQIbLmgw0sT5Ze1bQuO4qzsLUjbJSpaqYNi3QRaY0d9758JUYIHgkj
	3F0zSBU8/NoNWHT47TK5HHL8tqYRjE6yktNxqXBDV64hJiOzyhhJIXTVUOl0b/Xi
	I4zzTbw2i868JuDqKDoxmfO+ZFzdKqNlZqq4rIHs2Tedhth8vbzQeRbocB7OoNaU
	jOZ/Q4ajvrt/WRDqteOM6ULIyhZ4k8pOMAF+J/Xyrmfh+MLZVfII8OfkX5VrK+W9
	MN+6jA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g5autnn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 16:51:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46OGpKHm004312
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 16:51:20 GMT
Received: from [10.110.5.87] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Jul
 2024 09:51:19 -0700
Message-ID: <5c4a230e-ed7b-44d4-a2a3-0ecb9e784dd0@quicinc.com>
Date: Wed, 24 Jul 2024 09:51:19 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/7] Add power domain and MSI functionality with PCIe
 host generic ECAM driver
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>
CC: <will@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <cassel@kernel.org>, <yoshihiro.shimoda.uh@renesas.com>,
        <s-vadapalli@ti.com>, <u.kleine-koenig@pengutronix.de>,
        <dlemoal@kernel.org>, <amishin@t-argos.ru>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <Frank.Li@nxp.com>,
        <ilpo.jarvinen@linux.intel.com>, <vidyas@nvidia.com>,
        <marek.vasut+renesas@gmail.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <quic_ramkri@quicinc.com>, <quic_nkela@quicinc.com>,
        <quic_shazhuss@quicinc.com>, <quic_msarkar@quicinc.com>,
        <quic_nitegupt@quicinc.com>
References: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
 <rzf5jaxs2g4usnqzgvisiols2zlizcqr3pg4b63kxkoaekkjdf@rleudqbiur5m>
 <a87d4948-a9ce-473b-ae36-9f0c04c3041e@quicinc.com>
 <CAA8EJpq=rj-=JsYpPmwXiYkL=AALf-ZPQeq9drEoCkCAufLdig@mail.gmail.com>
 <20240724133139.GB3349@thinkpad>
 <CAA8EJprSTfddwT1DxK7_B-bLbqWO7hTWKRfHnN5kxya6GbcmEA@mail.gmail.com>
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <CAA8EJprSTfddwT1DxK7_B-bLbqWO7hTWKRfHnN5kxya6GbcmEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8D5wnAS4-Q6Bf-cJ3f4W_J0JI9vlffhP
X-Proofpoint-GUID: 8D5wnAS4-Q6Bf-cJ3f4W_J0JI9vlffhP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_17,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=850
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407240121



On 7/24/2024 6:34 AM, Dmitry Baryshkov wrote:
> On Wed, 24 Jul 2024 at 16:31, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
>>
>> On Wed, Jul 24, 2024 at 10:12:17AM +0300, Dmitry Baryshkov wrote:
>>> On Wed, 24 Jul 2024 at 06:58, Mayank Rana <quic_mrana@quicinc.com> wrote:
>>>>
>>>>
>>>>
>>>> On 7/23/2024 7:13 PM, Dmitry Baryshkov wrote:
>>>>> On Mon, Jul 15, 2024 at 11:13:28AM GMT, Mayank Rana wrote:
>>>>>> Based on previously received feedback, this patch series adds functionalities
>>>>>> with existing PCIe host generic ECAM driver (pci-host-generic.c) to get PCIe
>>>>>> host root complex functionality on Qualcomm SA8775P auto platform.
>>>>>>
>>>>>> Previously sent RFC patchset to have separate Qualcomm PCIe ECAM platform driver:
>>>>>> https://lore.kernel.org/all/d10199df-5fb3-407b-b404-a0a4d067341f@quicinc.com/T/
>>>>>>
>>>>>> 1. Interface to allow requesting firmware to manage system resources and performing
>>>>>> PCIe Link up (devicetree binding in terms of power domain and runtime PM APIs is used in driver)
>>>>>> 2. Performing D3 cold with system suspend and D0 with system resume (usage of GenPD
>>>>>> framework based power domain controls these operations)
>>>>>> 3. SA8775P is using Synopsys Designware PCIe controller which supports MSI controller.
>>>>>> This MSI functionality is used with PCIe host generic driver after splitting existing MSI
>>>>>> functionality from pcie-designware-host.c file into pcie-designware-msi.c file.
>>>>>
>>>>> Please excuse me my ignorance if this is described somewhere. Why are
>>>>> you using DWC-specific MSI handling instead of using GIC ITS?
>>>> Due to usage of GIC v3 on SA8775p with Gunyah hypervisor, we have
>>>> limitation of not supporting GIC ITS
>>>> functionality. We considered other approach as usage of free SPIs (not
>>>> available, limitation in terms of mismatch between number of SPIs
>>>> available with physical GIC vs hypervisor) and extended SPIs (not
>>>> supported with GIC hardware). Hence we just left with DWC-specific MSI
>>>> controller here for MSI functionality.
>>>
>>> ... or extend Gunyah to support GIC ITS. I'd say it is a significant
>>> deficiency if one can not use GIC ITS on Gunyah platforms.
>>>
>>
>> It if were possible, Qcom would've went with that. Unfortunately, it is not.
> 
> Ack.
> Mayank, if the patch gets resent for any reason, please add this to
> the commit message.
ACK.

Regards,
Mayank
>>
>> - Mani
>>
>> --
>> மணிவண்ணன் சதாசிவம்
> 
> 
> 

