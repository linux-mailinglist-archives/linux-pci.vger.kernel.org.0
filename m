Return-Path: <linux-pci+bounces-32062-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F94B03BD5
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 12:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE5817A1D4
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 10:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351CC244667;
	Mon, 14 Jul 2025 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SV2NH9S3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C928241682
	for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752488793; cv=none; b=sUcHSFNXLrG96Wta5XcWE5xeOdjD7VW9CvQX5GBe7rKQE/yIYHiJpJDiVq9iu5qd8Sn1QrMAdJ5BnQN4QoS5F64tpR1xQCrrCaRKQob119lYvMdLFeV7jCKnaPNJdvw/S5jE6Lj4laoCkFYhIKzlc96ym8+n0LoGt2uioBY3ClQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752488793; c=relaxed/simple;
	bh=3WgJKsJNXm6nkCQk25rfynsk5InHOlPiGe+VoI8VjoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPFuUjWMwVZaC1ZW85anwOcdV70AVzZPs2kgPyTegww9hqs8+dFdxwxayjHeVxbJEB0ax0KUzkZGAxClLFOM7H/UQLsaS9d2yFAOfqZ6ahgsGqdYJhraJJcT2mnbKdHPYnUXpdmPkj/VjEimW7uc0UrmVE3HiUFZzIusb9m1I1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SV2NH9S3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9x95s011602
	for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 10:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	egAELupiCZx06w7wEK2KFv4UsZXmQJRYPb1g2z2YVqY=; b=SV2NH9S3KyTAlgcK
	40EZ36lyqXFJ1HVoZwyB43XOXkIu/ldTZXodxZ6bC0y/XckneTlzgE+yFYlWffGf
	udJcJT8CmQfddyxX+vsvS+Frevh0IqP93p8ajTOG+Ymk2dGVvWOIFNow3kCjZCGo
	5jXDUahHQ+M66zDYi/f/vYf6V/bzDDaFKLEt20AVX36dQpUqcM1cuqA7qvXW2AG0
	fF5Yg0ez6bVk7x9UbM2TYItKccB/dwFUtrXHQ4G1/GdnOZUM8vQ3+pfn9mHwBry8
	fjPwD8Q0Tw6UbWr4HB1julg/Mqnt1dZYBhvGh/uSOCs2Xwv5ztg4+eh5LuBKGnij
	LP5w1g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ugfhc9kt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 10:26:29 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ab716c33cdso2766191cf.0
        for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 03:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752488788; x=1753093588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=egAELupiCZx06w7wEK2KFv4UsZXmQJRYPb1g2z2YVqY=;
        b=FkgQMJiZGtJMiYXnO4oi4MJxWy1h35fXRwLSCrRbTAWAz0GA4LTvqtthn5m6UZIrY4
         Uh1RbuUtbiHecithADKhPXs1nft9bHwU/04Owa9DgaGBoeyy3WF0UfKTXCLCfBiULdU0
         Fdd4uRyn5huwhQFOeXsMu6lyIKgxIYoFMWI1W3BQt+Ex9pMijXcqP4QrvjMwup0FmHPv
         FEvOCv0f1m76NPWNbnwQ+TW2CAIrLz7eMPompnpviX7c5ijRFUjVWl418OrdAfkvpoIS
         0llGMsy0iwKi9pbV6+sdtGnkv5lTLXa9/levR3KVw9unBFVbzoVhW4nnmXabKu+PTrq+
         MnkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaVB3dbUCautjK/TBM4pS61ebf52QsTjewL6kWl/qOLZsYy3b5i3Pdz5inpbmlORU1lCkzb/nCJhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOq0e2aEX6fD2EhgEiZKeg4pIndyZRNqYpJcMov4S+cTl8+6np
	jRmlHV6oyLqj8R8L3Ix8lgeGb7K0BrOxpVOrByukT7dh1VclYJhLBwz1KSy6RHwXlm4rGPI3Z8K
	dRwUIdQq05pk14Wq5bcFQrY3f/AyyBXlibLE1vVUEkpe06T7GXoBcd3lQ4gOETt8=
X-Gm-Gg: ASbGncsaKf8E4EXmE7CyunZOl85/1T8utomgg4RpjMj2oxmPo7sCSvO9yAzu49LgiFL
	4Il+pHioe2FAt4yiTJLxrWa5p9UUL24C4kqu7ERDSQw51kJ6lhnf9asUv/PZhvcJpUqL7yly11O
	4l8/DSEpeAMj8SXiFZvfIBLcrtGtwFwo0jPLBOcPD9tkfTLiLr5KnbrYKvLeLHwglTD8Lo3BgJh
	LR7s4XwFDVOntvK+m7jRoDBM53gbhq8LvoNuQKxMkiZ2SCdEu6IB/BF4t47LVHpAgbCHoZgWHrw
	6BlRwq4Y2e2VMYg/JMY/6wHwhzojxVYDOgAJ1OkMjQv0dvwcihoiBt3LmAB9eLWeQeUJSSOQWS2
	TBZf/OR32v4OW/sAzed4i
X-Received: by 2002:a05:620a:3194:b0:7c3:bae4:2339 with SMTP id af79cd13be357-7dea52c0555mr554053585a.11.1752488788014;
        Mon, 14 Jul 2025 03:26:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDL1NLrtu1vBkvJOxO8syOjdbhxl5epP7yC4DT9HmFC8zYh1BXgqTPIUl4qDv2CMgF8y+JcA==
X-Received: by 2002:a05:620a:3194:b0:7c3:bae4:2339 with SMTP id af79cd13be357-7dea52c0555mr554051585a.11.1752488787599;
        Mon, 14 Jul 2025 03:26:27 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7f292d2sm801836866b.72.2025.07.14.03.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 03:26:27 -0700 (PDT)
Message-ID: <e0e08139-6231-40c3-8153-5a1acebadf3c@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 12:26:24 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] PCI: dwc: qcom: Switch to dwc ELBI resource
 mapping
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com
References: <20250712-ecam_v4-v6-0-d820f912e354@qti.qualcomm.com>
 <20250712-ecam_v4-v6-3-d820f912e354@qti.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250712-ecam_v4-v6-3-d820f912e354@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: -0MEyI1QGY-EB30ep8OaiS1VPDbTasrc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA2MSBTYWx0ZWRfX1r5TXMJIIKjp
 mTelu6f8hnjRNyi29+yz3XPO4wh2MxQW7P2MNlDuW0Rs9nO6Ib9bhE11FN/hclzDgrqhYTaUEQ+
 hpqcxZ5A+QYYCEWpHdm2ejKHfHXXL9ny8XTEflEaayz9YebldiHQi837qtALKELm48zZTzYM5/m
 rrLlFQ4G7dqUU+n7zY1zFI/sSaCMpektVuybOx5IX3fxjeBS5kSgOe8SFsO5nfMEQbGnW4t9WAg
 jSi5NFbP94gF0rqPSuUwmT5olXsunPB8IT2DTyVvQxRICaaF3WAPPX7Md3rjX/ZNRDaRieA56j3
 OjCLlSTOHz8Q9ynA5ocYOhcwXPhwYEcwCkgKGi2eDGqdXw6JqcqoZ98VONiGeYP09PYrEEAPbe0
 VdKh9W9bD6Tms+mGNjI61P2mZFJTtyJ3abKT5wPcVb02cvf9skMlsx3ba2wOSDohEjFh5uzY
X-Proofpoint-GUID: -0MEyI1QGY-EB30ep8OaiS1VPDbTasrc
X-Authority-Analysis: v=2.4 cv=HYkUTjE8 c=1 sm=1 tr=0 ts=6874db55 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=6pHcnep46kEejBPVP2gA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=828 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140061

On 7/12/25 1:42 AM, Krishna Chaitanya Chundru wrote:
> Instead of using qcom ELBI resources mapping let the DWC core map it
> ELBI is DWC specific.
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

I see this can also improve:

pci-exynos.c
pcie-histb.c
pci-meson.c
pcie-qcom-ep.c
pcie-kirin.c

but this is ok to put in another series

Konrad

