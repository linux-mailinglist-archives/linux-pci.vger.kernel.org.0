Return-Path: <linux-pci+bounces-39748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D14C1E37A
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 04:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D02E03AC70D
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 03:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8755F2D23A6;
	Thu, 30 Oct 2025 03:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YmmWK9mh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="chLRdcXs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000862C11C5
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 03:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761795526; cv=none; b=EAwVw0btJu4RrezuZfuyr5Rzazizzg9uVsGZMmd3QdR0xI2rbtIEgBoL+G60HePNYeRGgt1slWryeFacZigXUn/gsBHVPEvs1onCxmTapQpV3/kcPeSeTwG2BiXr+JuAieHESJPoQ5FwgF6Uu9aNAq6LxX3mL/8135exWhFHY8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761795526; c=relaxed/simple;
	bh=VSHG8DAhQjKVcCyq5B5QW7BaODCyRga+pKRT+PEcoCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cvtsoY8pkDaUSiqQWfmhIyFQTlI+CDz8e/gYBdewpD/pBaegGkc5Kh9gMAt4pl0ZamYjclbGkeKO3kX2CX+dDrzNzOSsO3m9scy3dd11w4mNBKfRfw2ywaQkE5c14qojhlua75OPvkoDP43t/KEa6U8+hSHUDnC+zEEt19zdN0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YmmWK9mh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=chLRdcXs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U0iOwm1994626
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 03:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8cTGlLixs0EcG4dKWmS5DgH7TjtJvlrFipCs1gJW+1M=; b=YmmWK9mhT2/HxmP2
	d/nFKs3NQn4xlGvZZfIFG5MSrL3wNBGzzzVHkjrBYqKjMtp6d9O8Q+yEH+BI9Agd
	UdVzS/cq64ZiTm/qTUrq1gJ/XNX52oZhy8VDJYarB9G6gvVC2JYAknbBUtHPbEf0
	MCOlLD755Tx5npzVGJqQlVMchCTMw7bZ68LjrZsPb0nMDCllscrLvRBaWnr0DzZp
	9mfy05Wa7L+DYSVNG4c9nXNr5yv2kUaZKCNlscxbLBYon318zPTxzAteBic5quaC
	XPU9Ed62Qqph09EaEuqTnIC5OY59+k+C2bYrJBFuHUPjWvb9UrjRgUU8lJRPgrI0
	vr3Eng==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3wr70ce4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 03:38:42 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33be01bcda8so574295a91.2
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 20:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761795522; x=1762400322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8cTGlLixs0EcG4dKWmS5DgH7TjtJvlrFipCs1gJW+1M=;
        b=chLRdcXsdWx7Q+qxzI9UMlgcybBJ0c0hDI8zuytqOfc3z3PJ8Vq6gPbsDrImIpO2RW
         rGX+eY58hxYca1gWUmjTL56DuDWM9YiE0mUwm9MqWK14jcFEAJxx9bNMJlUsToqxwcCJ
         LkISyUte6MefPWMr2tGoJsDkZ66kcE4tzr2epmeoTgjdFagkz8hOmLMRNTS1lfCnx2nm
         3j7/Mf7lmktslhyWLGSjHkZ97NqOZEovCk0eFFV8Iw4Y4kVqOfhj1JW/4U4wNA1ApvGZ
         lvE+yt0O9pZb6SDXETGLV9Wr+tYy8qLC5f1lt+kSWMrZnWfVonBHzIag5aBeZUnUfAz8
         JPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761795522; x=1762400322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8cTGlLixs0EcG4dKWmS5DgH7TjtJvlrFipCs1gJW+1M=;
        b=Ics0h9dfjbwprXUv+4aMEx5GlEnzdwEqCgrxl/NvHm3W2/jwFNnmRwCQ6dkdmZxOyY
         d/AqVmgOz32+KFOmL1oXXgnbJawhkB6FtfLAzuP9dNIkjxYSGzKw34PldK0Z0DtWzrM0
         OZ6aIUNUBzfglHkArw9++d3I/59zTZpP0w+Hczuhc6njRfcVzo0pP3XjUPs7lnm1e96C
         xpZAINvUQdde8nw0xTi2qdRhWghBNqchPP0SCZG2Z7zn6Ruh6Ngqch8QdcM9JV2pBSxl
         oVtJs1Xl50ivABoJxBfGy3jz9bXVgRngSeeG9U0MflT//4uzAyIkur7u32T4ho3mVBlQ
         YzdA==
X-Forwarded-Encrypted: i=1; AJvYcCUn8jUaUfLjf2n/5Zfo7hbaSUiMdNCd33tO+ttO96q12kjZFuSJCBf0REllz0WRY3SSC7847nJJYSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWTFDAaB3a3dF6iHvIyIqvYKLV2psFCafZlO5zWgLmXmhAoXfh
	ThuBJxIBHZcwmHVsx3uHuK2vwzvFFCwxJzYWlFG1OY+/SgDyn6Jp03mBDYBlqp10LNBHY3FBzPy
	JDJGRpiGztc/75MXiyobfWYAk7hfEfVCFXcEEPrvTNjmTiiqsgHd3qBFzomAr+e8=
X-Gm-Gg: ASbGncsHegMzTQ1MVtljr+CNBFmI/8EjoykM74uwOV+2V0nGrvy1RkW7/JL3HUgY0Pu
	tLUbEwcTv2mTyHvJdGwG48Efj5Nk/pG173dX0/ZFhV0dXk8QAngW/pf4e0U5mmuUPeNgXPSL9Dx
	3ls4I1F543rciDps/Cw4sPO1nN8YkzGB2yzYPlRM7mbb8On9zWNzlQIPVR8C2gzvdcocbsibiJZ
	man/huMDFW3clwEbEDYgboEvaUR8sQc6dH7S+8/jvkUQYjNhxKrAXYgfOu8zR3nARRRsGRT55Mm
	5iZ1fpeiBsfxvB5hKO4rNQYYrshpUsGziHR05vkc/x1oCB3MxPyPWOXAr+0lwrTQ+QHu+lIZbsM
	7UEOf7EiLtb8oTgZRamRcjJKTlSEDeh4=
X-Received: by 2002:a17:90b:38cb:b0:32d:e07f:3236 with SMTP id 98e67ed59e1d1-3403a2a22a8mr5280687a91.22.1761795521536;
        Wed, 29 Oct 2025 20:38:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETSXZA/9AUH+eCeARyftxGQaYC5tfLi6TMdi8gQWvqS2Cl78YWh6ARpNw6aUIpThTzHdcxfQ==
X-Received: by 2002:a17:90b:38cb:b0:32d:e07f:3236 with SMTP id 98e67ed59e1d1-3403a2a22a8mr5280661a91.22.1761795520939;
        Wed, 29 Oct 2025 20:38:40 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3402a5ba7fesm3305920a91.9.2025.10.29.20.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 20:38:40 -0700 (PDT)
Message-ID: <a876f8d4-969a-40a8-8988-2f716a742741@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 09:08:28 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/8] arm64: defconfig: Enable TC9563 PWRCTL driver
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, quic_vbadigan@quicnic.com,
        amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Baryshkov <lumag@kernel.org>
References: <20251029-qps615_v4_1-v7-0-68426de5844a@oss.qualcomm.com>
 <20251029-qps615_v4_1-v7-7-68426de5844a@oss.qualcomm.com>
 <CAMRc=McWw6tAjjaa6wst6y3+Dw=JT8446wwvQ0_c5LHHm=1Y-Q@mail.gmail.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <CAMRc=McWw6tAjjaa6wst6y3+Dw=JT8446wwvQ0_c5LHHm=1Y-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDAyNyBTYWx0ZWRfX36Am2iiJIsqa
 7Cf4uElQOcr7YAb/aFfgBkQUNA5ZtWYDK34rwpSYlIS8jMvJVVj/VyHAkyIiedTutbpuHxadkAv
 fv+6Xh7Pd2xNEKH7LUpuyuRgZpLTWBNQSe85ApANmSwFpnnfIHYxJ1zsKZUdVGcg5LQWWBTs36u
 VD6vL5BdnYqdfMKea3a7q8ui+NjzrU/C4TpagGj0sT97spR7CtegIxUsF+AFvaRnk0XOOMtNiW8
 0tm8ih6WgOOjVTKBQOCWE2Tlip1CJYQG8VerqkvlYx8hJ4cOgRH2Apxcc6jAUh1484eMfESHxLp
 nPM7KBYcjqt/GGunI4udz+/gTqV2/wiajKKlLi+ThmPL9wnhPjJXDbBdEJSGJytyRtfSQj+XXZE
 Z1i1xdUg5im/6I97niXbN/8VgjNbjw==
X-Authority-Analysis: v=2.4 cv=P+Y3RyAu c=1 sm=1 tr=0 ts=6902ddc2 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=0FT5JWsqCLsmEzCoxIcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: LG2EgPpDrwV21ignHajB09YZ4w9OgJ85
X-Proofpoint-GUID: LG2EgPpDrwV21ignHajB09YZ4w9OgJ85
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300027


On 10/29/2025 6:45 PM, Bartosz Golaszewski wrote:
> On Wed, Oct 29, 2025 at 12:30 PM Krishna Chaitanya Chundru
> <krishna.chundru@oss.qualcomm.com> wrote:
>> Enable TC9563 PCIe switch pwrctl driver by default. This is needed
>> to power the PCIe switch which is present in Qualcomm RB3gen2 platform.
>> Without this the switch will not powered up and we can't use the
>> endpoints connected to the switch.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   arch/arm64/configs/defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index e3a2d37bd10423b028f59dc40d6e8ee1c610d6b8..fe5c9951c437a67ac76bf939a9e436eafa3820bf 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -249,6 +249,7 @@ CONFIG_PCIE_LAYERSCAPE_GEN4=y
>>   CONFIG_PCI_ENDPOINT=y
>>   CONFIG_PCI_ENDPOINT_CONFIGFS=y
>>   CONFIG_PCI_EPF_TEST=m
>> +CONFIG_PCI_PWRCTRL_TC9563=m
>>   CONFIG_DEVTMPFS=y
>>   CONFIG_DEVTMPFS_MOUNT=y
>>   CONFIG_FW_LOADER_USER_HELPER=y
>>
>> --
>> 2.34.1
>>
> Can't we just do the following in the respective Kconfig entry?
>
> config PCI_PWRCTRL_TC9563
>      tristate ...
>      default m if ARCH_QCOM

Ack, I will do in next series

- Krishna Chaitanya.

> Bart

