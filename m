Return-Path: <linux-pci+bounces-13160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A267977B64
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 10:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5725A1C25AB6
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 08:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623E01D6C68;
	Fri, 13 Sep 2024 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RpG2SRz6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80151D6C57;
	Fri, 13 Sep 2024 08:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726216909; cv=none; b=qcdLzWg6cVXb6cbkGPETbrkZ+EEnl7cmRMr7+njH9I9TJVlbrFCVExUfMTXixOtik+rKW3xJQYtCWcBuXqXqOm4HkPOAnTK2K35N4eh7VEFMI/oJXtJP9fKqwrHFgSf07IUJEOKaVKMHMVnWwPM1rOIw+26JIRFLwRv0Z10u9w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726216909; c=relaxed/simple;
	bh=Mxg17ZKwDAnIFw5xzrZFUsi1NwSXcmpAqbBiabD/dq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Wv2o/TFuuaJR5CcRK1bzY861CjKKs5NHnI6bGnRT0ZGmJVTmr5EvtFjPuNJRor6Rg7Ug7RJKQLS7xSZGZgYPGYIJl2L00GKUsAGuELOiDCzvybpnQfOZ+2oNuNFpMwRY2zr9tum741I5RlZzxdB6gkpeo2NFnoS7msrgZnKidlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RpG2SRz6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CMBArh025473;
	Fri, 13 Sep 2024 08:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XaldEHcAoyUk0jfzc2R4+o02uTW5r7INZBjjuXVthlQ=; b=RpG2SRz6WbSt/xje
	ejYnyWexT9Wv6R0Lq0sEqup8phF+Xaf+cjPasr5TSFuqVj1OQrrcqd0l9hzAySZh
	pnXXcMl8OUX6rzcEzDH2WQqwG3N4+9QBnEJbZKXooe54O/VG1YMaKZOuhAjzUdPl
	83liJXjsQ+FiXkMs94+01P1TPKVI591S6zSHFoDEb0ax2/RqiNpElnLuL/oJj5M4
	55cr2S3tPElJVPd6z8s8BErBmloIaEOC1JMUP75L45uxeKg64cS1pLpu0+KAGVET
	ksUeZaIMqKUfeMcpTUejEhbAPDg3iSUFEzO57tGmyKm8uweuPbPrSwUB35yGwOvg
	fSivJA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy8p857g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 08:41:09 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48D8f7VZ018352
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 08:41:07 GMT
Received: from [10.239.29.179] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Sep
 2024 01:41:02 -0700
Message-ID: <0c3347a5-85a0-4f28-a393-58f9653d80c6@quicinc.com>
Date: Fri, 13 Sep 2024 16:41:00 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] PCI: qcom: Add support to PCIe slot power supplies
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>
CC: Konrad Dybcio <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh@kernel.org>, <andersson@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <abel.vesa@linaro.org>, <quic_msarkar@quicinc.com>,
        <quic_devipriy@quicinc.com>, <kw@linux.com>, <lpieralisi@kernel.org>,
        <neil.armstrong@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
References: <20240827063631.3932971-1-quic_qianyu@quicinc.com>
 <20240827063631.3932971-9-quic_qianyu@quicinc.com>
 <CAA8EJpq5KergZ8czg4F=EYMLANoOeBsiSVoO-zAgfG0ezQrKCQ@mail.gmail.com>
 <20240827165826.moe6cnemeheos6jn@thinkpad>
 <26f2845f-2e29-4887-9f33-0b5b2a06adb6@quicinc.com>
 <20240911153228.7ajcqicxnu2afhbp@thinkpad>
 <9222ef18-2eef-4ba3-95aa-fae540c06925@quicinc.com>
 <d5468dd2-0f81-4d89-a3bd-a546b2395ca6@kernel.org>
 <20240912144439.fnne4x7qvggveve2@thinkpad>
 <CAA8EJppSFb+Me6w5vUpmbogQ4DS2=15FmHu4nzGz2POWQPouwA@mail.gmail.com>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <CAA8EJppSFb+Me6w5vUpmbogQ4DS2=15FmHu4nzGz2POWQPouwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _vNsLo3ok6ERoauWgDGeuNLPTcuWKCiI
X-Proofpoint-ORIG-GUID: _vNsLo3ok6ERoauWgDGeuNLPTcuWKCiI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130059


On 9/12/2024 10:49 PM, Dmitry Baryshkov wrote:
> On Thu, 12 Sept 2024 at 17:45, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
>> On Thu, Sep 12, 2024 at 04:15:56PM +0200, Konrad Dybcio wrote:
>>> On 12.09.2024 3:39 PM, Qiang Yu wrote:
>>>> On 9/11/2024 11:32 PM, Manivannan Sadhasivam wrote:
>>>>> On Wed, Sep 11, 2024 at 04:17:41PM +0800, Qiang Yu wrote:
>>>>>> On 8/28/2024 12:58 AM, Manivannan Sadhasivam wrote:
>>>>>>> On Tue, Aug 27, 2024 at 02:44:09PM +0300, Dmitry Baryshkov wrote:
>>>>>>>> On Tue, 27 Aug 2024 at 09:36, Qiang Yu <quic_qianyu@quicinc.com> wrote:
>>>>>>>>> On platform x1e80100 QCP, PCIe3 is a standard x8 form factor. Hence, add
>>>>>>>>> support to use 3.3v, 3.3v aux and 12v regulators.
>>>>>>>> First of all, I don't see corresponding bindings change.
>>>>>>>>
>>>>>>>> Second, these supplies power up the slot, not the host controller
>>>>>>>> itself. As such these supplies do not belong to the host controller
>>>>>>>> entry. Please consider using the pwrseq framework instead.
>>>>>>>>
>>>>>>> Indeed. For legacy reasons, slot power supplies were populated in the host
>>>>>>> bridge node itself until recently Rob started objecting it [1]. And it makes
>>>>>>> real sense to put these supplies in the root port node and handle them in the
>>>>>>> relevant driver.
>>>>>>>
>>>>>>> I'm still evaluating whether the handling should be done in the portdrv or
>>>>>>> pwrctl driver, but haven't reached the conclusion. Pwrctl seems to be the ideal
>>>>>>> choice, but I see a few issues related to handling the OF node for the root
>>>>>>> port.
>>>>>>>
>>>>>>> Hope I'll come to a conclusion in the next few days and will update this thread.
>>>>>>>
>>>>>>> - Mani
>>>>>>>
>>>>>>> [1] https://lore.kernel.org/lkml/20240604235806.GA1903493-robh@kernel.org/
>>>>>> Hi Mani, do you have any updates?
>>>>>>
>>>>> I'm working with Bartosz to add a new pwrctl driver for rootports. And we are
>>>>> debugging an issue currently. Unfortunately, the progress is very slow as I'm on
>>>>> vacation still.
>>>>>
>>>>> Will post the patches once it got resolved.
>>>>>
>>>>> - Mani
>>>> OK, thanks for your update.
>>> Qiang, you can still resubmit the rest of the patches without having
>>> to wait on that to be resolved
>>>
>> In that case, the slot supplies should be described in the PCIe bridge.
> Patches 1-6 don't seem to depend on slot supplies, so they can be
> submitted separately.
OK, let me send v2 patch. Hi Mani, if you need any supports, please let 
me know.

Thanks,
Qiang
>
>> - Mani
>>
>>> Konrad
>> --
>> மணிவண்ணன் சதாசிவம்
>
>

