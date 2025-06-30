Return-Path: <linux-pci+bounces-31077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339C9AEDCC8
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 14:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41BAC7A4E23
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 12:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09637286404;
	Mon, 30 Jun 2025 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BNrukPs/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DCE20E716
	for <linux-pci@vger.kernel.org>; Mon, 30 Jun 2025 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751286624; cv=none; b=V0n0ui2yVqNmHYC4w2SLgG+8mhS0r8J5frm+DB4nKYEuNjnZTt4ZJfQcOaJjLSXbx4fM5YadcMBnyYIMHMquYuROEkeJb2izPM8/Mmj3yDbS5Zeh7MN9mmAjGmeV2Pe6OI06r5Gn7lIwvmprFfcOxLjmysn3nFUMIwr7Tb1vIxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751286624; c=relaxed/simple;
	bh=3f1Py/orZHfiSTe0C6MP8gxhoceXINqIBaCHjb7/zSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=byrk9T1KBisn8AuhSVp5wvhafn9jymVYk7CDtXj6gEHA0KFdKbdmWjlSMmUdfrKvJm67yreZGwRZgfNo+hqsCs44MVnAlaitjmDMErGCLj5dQo5l13b20ZacROUbEKNq7YyAiPvXLfmp718lZkPUPRz3imE2KjNDiTbZ7aqxuxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BNrukPs/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U8DblC001184
	for <linux-pci@vger.kernel.org>; Mon, 30 Jun 2025 12:30:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2dWxWYq2K7GOUCuWuG1yENQqxzaE0+54jEHV+QMm2Os=; b=BNrukPs/nNJ0qaHS
	LWTu6LjgvbZFBSLNC+oAhIPnl4Us9Elul9jdAnKMZFFftOO8B1obXtZVxfvO7MWt
	shjEpSEADQTPkOSUhhPFsDln/dstCoJv+fn/SCyOWkk+mqZRZPfUxaduo6El6Onp
	PujuZ5mZtOb3wgl6JOnwoMg3F20KBzIzIvOKEU31qhTzUpXpkuXnn0mo+JSk3uo2
	+optlSS+dEXRhNKnoLnzfmU/XAMOkGRgk4JKMcyIbBRMPUzxegd7TNDi0wRzIbWM
	Cu73+s1G02hJSxfvTxdoaPFITrFBdp3D2lN8HLg+N/zSQ2yfYWbQIlJ8EQMwnv1Z
	LouDFQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j7qm4qe1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 30 Jun 2025 12:30:22 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7489ac848f3so3749514b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 30 Jun 2025 05:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751286621; x=1751891421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2dWxWYq2K7GOUCuWuG1yENQqxzaE0+54jEHV+QMm2Os=;
        b=KG8slCXwpFaxROzLH1/Z4vyIf4yGlDjEhhRp4jOO397K2pzpubh6i7kBB6f5wsZ1In
         fZcdjA8Xj8/8eRN4yO/AIs3T4p3UtGm+A2g95LmbSEvf/B1cdKo6CzBForx0/9KSGcKQ
         aBYmtLovn2sLO327We9VV5OZuXsLjWgLVj+zfV5xqOHcyxr2Xz9BgLmGetYrxoKElDTe
         1xftfH8AqoVX5E1/VMHxM8zw+qc5lHJhKUfj0PaQFHqHS+tnvvwhKfzMdgUQAaeq/8je
         d0wBYf1WYGQfyUxlQbSJ92YK7FpdD4wE4GSiNhm/rzlbMh3QloFFrvX/GdEz50hHTduT
         tLOA==
X-Forwarded-Encrypted: i=1; AJvYcCXU/r5G4ei7HeWOjnT46LgHsUYcSnx5ytz0c8DhKE7yzhxshGt1kx8133DHKePtu1CD+WdHdEIhX38=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCeTwb3pt1NM2Gd6htIgWGNluwoRa50IPYMCYAitMpsPAaeScj
	QWa+mfwyFGb/qaMLK8ylwAm8Ky70Im0hrC8z0GV1h0kWlSRmqc5PCt3fy3lAVKFFHMb/AeAk27U
	f6j4jq9/ra6O1a0tVG6ljT+ZzOqfEqcvxOl+rKwyCBotQFhT0QZD6ixU2s6B++/A=
X-Gm-Gg: ASbGncvFx31VBSO/wRTQEIqLlglRC7Rz9xgNUQ5/+jv41QoVxY5LFna624SpNSlYS9l
	lMv+PeQKrBOcuuQJxropYdmqG+DHe+HdPd5hqUanIXE33+R0y/wd6/JGXb5rQe1bTyy7fCa9YlH
	yc0FMF3L4NmF+dmNK+m4yD4VT/wUvuWCvwzAcm5WSqZ0vHbz8njFwJBcngMGwwBqZFZsAOXv+t8
	WjRKLaEw7o0/IJrskyA+PCasRK01NcgfAHwSk4pdxpBr9bO+aQAssDQQoqVXdusrcf6Tb3D1cvY
	CGBGkJwK+H9wREttU8A5gdEYka+nexi4tdhTCZ3aqU7kBQCSMmjh
X-Received: by 2002:a05:6a00:1988:b0:748:f365:bedd with SMTP id d2e1a72fcca58-74af6f4d4bcmr17197283b3a.17.1751286620560;
        Mon, 30 Jun 2025 05:30:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkaFNPxqWvP2slDuEpYtj3r5EnhD15Tr2DIQp6ChiI+aHrargB99nmYkj5G7fm4yQY9LxhLg==
X-Received: by 2002:a05:6a00:1988:b0:748:f365:bedd with SMTP id d2e1a72fcca58-74af6f4d4bcmr17197201b3a.17.1751286619834;
        Mon, 30 Jun 2025 05:30:19 -0700 (PDT)
Received: from [10.92.200.128] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af55c6a3asm8487704b3a.118.2025.06.30.05.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 05:30:19 -0700 (PDT)
Message-ID: <4bae822e-e7bd-461f-99cc-866771c0b954@oss.qualcomm.com>
Date: Mon, 30 Jun 2025 18:00:12 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] PCI: qcom: Move PERST# GPIO & phy retrieval from
 controller to PCIe bridge node
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
References: <20250605-perst-v4-0-efe8a0905c27@oss.qualcomm.com>
 <y3umoz5yuofaoloseapugjbebcgkefanqzggdjd5svq5dkchnb@rkbjfpiiveng>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <y3umoz5yuofaoloseapugjbebcgkefanqzggdjd5svq5dkchnb@rkbjfpiiveng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=C4TpyRP+ c=1 sm=1 tr=0 ts=6862835e cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=qGq9QQooCmLM_m6diiQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: PBEqL2Jiy3sI0NjmH12dGIfzeH2t4BwL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDEwMiBTYWx0ZWRfX/8PD9zZLAdel
 gZ57XfuVrLHl99bM3m6E1AW0DQbC8tL6CkrdS1+LXbQ50AxSkrViDd5LvlKSD4eU76553rhAqh/
 Zu7uPyvuVGvWxYifBX+QJQCSoT/hBV1SswtcbIYvVkrm8J0NZNVEcvPIHpwEohHAsqK3SZZaTOb
 vwSVphsFSzregT+nzPtXI5lAvanS3zLaDtGwUOTdSgoUuX4ENWcFQ4C9RRpxyDc97GjLtTKjacc
 UY1Z1QqulRRCXy83vZkTecQz+NRkmyq88D8QfzXE3RGKzz4O9KtgDbE/cGFPa/jhw0A9/RkiYI8
 TYN//NwsMgV1ICEbXYQsEPqLKft5A5xrJE2qUnOEy/H+94vXA/OcoSPAbbKbpnw6ELhKX90YO2X
 PgckmV5rl2gHh8UiCM6CCJUAlNWJfAUrmcXNezkrvd5g/8AkHv4GLgJcskNIP8veloiHdaSf
X-Proofpoint-GUID: PBEqL2Jiy3sI0NjmH12dGIfzeH2t4BwL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_03,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300102



On 6/23/2025 4:37 PM, Manivannan Sadhasivam wrote:
> On Thu, Jun 05, 2025 at 02:00:36PM +0530, Krishna Chaitanya Chundru wrote:
>> The main intention of this series is to move wake# to the root port node.
>> After this series we will come up with a patch which registers for wake IRQ
>> from the pcieport driver. The wake IRQ is needed for the endpoint to wakeup
>> the host from D3cold. The driver change for wake IRQ is posted here[1].
>>
>> There are many places we agreed to move the wake and perst gpio's
>> and phy etc to the pcie root port node instead of bridge node[2] as the
>> these properties are root port specific and does not belongs to
>> bridge node.
>>
>> So move the phy, phy-names, wake-gpio's in the root port.
>> There is already reset-gpio defined for PERST# in pci-bus-common.yaml,
>> start using that property instead of perst-gpio.
>>
>> For backward compatibility, don't remove any existing properties in the
>> bridge node.
>>
>> There are some other properties like num-lanes, max-link-speed which
>> needs to be moved to the root port nodes, but in this series we are
>> excluding them for now as this requires more changes in dwc layer and
>> can complicate the things.
>>
>> Once this series gets merged all other platforms also will be updated
>> to use this new way.
>>
>> Note:- The driver change needs to be merged first before dts changes.
>> Krzysztof Wilczyński or Mani can you provide the immutable branch with
>> these PCIe changes.
>>
> 
> You've dropped the DTS changes in this revision. So the above comment is stale.
> 
>> [1] https://lore.kernel.org/all/20250401-wake_irq_support-v1-0-d2e22f4a0efd@oss.qualcomm.com/
>> [2] https://lore.kernel.org/linux-pci/20241211192014.GA3302752@bhelgaas/
>>
> 
> I don't have a device to test this series right now. So could you please test
> this series with the legacy binding and make sure it is not breaking?
> 
> Once you confirm, I'll merge this series.
> 
I have verified with legacy binding with this change and it is working fine.

- Krishna Chaitanya.
> - Mani
> 
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>> Changes in v4:
>> - Removed dts patch as Mani suggested to merge driver and dt-binding
>>    patch in this release and have dts changes in the next release.
>> - Remove wake property from as this will be addressed in
>>    pci-bus-common.yaml (Mani)
>> - Did couple of nits in the comments, function names code etc (Mani).
>> - Link to v3: https://lore.kernel.org/r/20250419-perst-v3-0-1afec3c4ea62@oss.qualcomm.com
>>
>> Changes in v3:
>> - Make old properties as deprecated, update commit message (Dmitry)
>> - Add helper functions wherever both multiport and legacy methods are used. (Mani)
>> - Link to v2: https://lore.kernel.org/r/20250414-perst-v2-0-89247746d755@oss.qualcomm.com
>>
>> Changes in v2:
>> - Remove phy-names property and change the driver, dtsi accordingly (Rob)
>> - Link to v1: https://lore.kernel.org/r/20250322-perst-v1-0-e5e4da74a204@oss.qualcomm.com
>>
>> ---
>> Krishna Chaitanya Chundru (2):
>>        dt-bindings: PCI: qcom: Move phy & reset gpio's to root port
>>        PCI: qcom: Add support for multi-root port
>>
>>   .../devicetree/bindings/pci/qcom,pcie-common.yaml  |  32 +++-
>>   .../devicetree/bindings/pci/qcom,pcie-sc7280.yaml  |  16 +-
>>   drivers/pci/controller/dwc/pcie-qcom.c             | 177 +++++++++++++++++----
>>   3 files changed, 192 insertions(+), 33 deletions(-)
>> ---
>> base-commit: ec7714e4947909190ffb3041a03311a975350fe0
>> change-id: 20250101-perst-cb885b5a6129
>>
>> Best regards,
>> -- 
>> krishnachaitanya-linux <krishna.chundru@oss.qualcomm.com>
>>
> 

