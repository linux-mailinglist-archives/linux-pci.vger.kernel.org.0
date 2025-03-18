Return-Path: <linux-pci+bounces-24059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C412CA67A33
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 18:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8207B189DBD5
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 17:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4737C210F5A;
	Tue, 18 Mar 2025 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IgrPoCcP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A083C20FAA4
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742317268; cv=none; b=uwLt/IO62ZTlxWh3GU/hGt0aiMLI/D08pLeL+X+sTb8BR23tOlHSIrDYDDiyS7xQ/2S9A6TPMLXw+pgWVe6d37HMtpqMqM3ar53B6scDdu8rWTivvdFTsBQP7XeMb96VK9CJ5i9IIGSNlhuQ2XEsL9rZvZs3aRev/8m0LsGCbXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742317268; c=relaxed/simple;
	bh=5YRH59i3/B7xwBfGl0fAC2tOhBLqq9TfHRpTHq8NO1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nhffV88NlT2Dwx/cTkLh0kHHD65ARjhJ5ijsbnxv6HV8Zx68913YHoDKocL9Gg/7aZVosf0GcXOUsyxh6uGzcR6XfJu7ZpFvOTZj5FJpU+3nB3ohKCUNXxSd2+iPM7KorRF8x2SoMB0vWDpyUJznWh5ZHSnhpL6ax2MxWx+13zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IgrPoCcP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I9KWdC025504
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 17:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=StafdzDurWimpaN7Jmu0PfeK
	ZDx8G4OwDsbuc8PNM9E=; b=IgrPoCcPYnheQSaGKkKIGiLW/xDjOFUsu2fmXJV6
	Eeg5lfM7fwxSJnPvlRthkilps+xbGSX8V66vhRQfXeQE6+eoOIrHe8IWnyRpzg9w
	/00ZFNZtxF3jtF79/l0N7xQzjfAqZWpIV/8KCMHPU1OU/0n05jpNfJPBJfOaT4G+
	qWL/CirAMECuZjnzcA7GI2zt0S3QPfI+s4Bdlh2YeW7KOEOUj722wag3/+My6UK5
	GqObDARGRTm0D7aQf8qa6FSNV6Z7VzN2+2hD6vzk1jBhHwoVZSTIEaYqEULXRLeP
	uqEzKY7qvd9MN2dgiSTzJ2jel5q91z+naqvbVz225h8JWw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1tx8xvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 17:01:05 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff64898e2aso5012501a91.1
        for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 10:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742317264; x=1742922064;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=StafdzDurWimpaN7Jmu0PfeKZDx8G4OwDsbuc8PNM9E=;
        b=Zuk7TEwAYHIuq4kirekMRpivphlvyZeS2MIcBYfCxCVkK29SUOIzUzym/VRsxFgnl8
         sl0x9zSYnbrGXDvWHUOuSx0drE1OdTtyX/aj7xtrM/qLTMddy/K2y5yAmHMVBSbuoT89
         Cqobqxv+JOm9QysfaxEMxFppZsMD+jTL3OkA42HjVzdHLfOOI+82bCfxMDqHGdmGn7N0
         QPqzVFu4lgG73BlzVM/9HhziGueLC3gr6YlErdjixBg3/WNB7NvppQBwC1B/N0FXQz4L
         mePGW8xhKv1DItDAy9avMlzmAlfE+LWzM4FntvTahV7MpteXz6piYeYPSbpFUt3dCWIT
         0S/A==
X-Forwarded-Encrypted: i=1; AJvYcCWxXWAGvTZLjOb0oVifblqjVK2tFYgQOEGXF6su4suEC+PvonnoMth87TvfocrLvWACiU8lVySFoiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLZ7x7CqvPZcqbRpCbY3XcUKxWOULbtXsKNgtrF0+63kScBlCn
	oECp8zoZHk5DpnnSwJOEDQS8N7Gh1iVAujLONNtR4ulrQy/mwUqBgZCjgkVjDf+kB4rExAzLSbW
	Bth28qP6xFPMZcNHTHMOX/yjCCfYphakwFo5GRLrqF0MefCUVhkGKkVC2ZBp4aQosI+FGQmoD3S
	1DuTCq1F+wNxpWEpa3q/VanbzH9cpYT0JDuw==
X-Gm-Gg: ASbGnctk0TM4QasC+vavo0zYFsMQN5lKDQOKd17zfpa6/pqFEEgUA5zX0e4XjsdgpWt
	8NnKEBX0Gn3ne7Zk4VNrJFnN0dvcWrGnJZDNarQSr3jQyadxFkp1Z1RsFhoYxUO5jbQ13iqyymc
	MW5zniFlDw5giA+lkur/Tn8jBDwUI=
X-Received: by 2002:a17:90a:e7c4:b0:2ff:53d6:2b82 with SMTP id 98e67ed59e1d1-301a5bde7f8mr4505558a91.11.1742317263925;
        Tue, 18 Mar 2025 10:01:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2mM99w8Yif66L5megEI3tCN8I1is5NdBdBjhAmcSxNUnHnOXDld02TDvQk6YE8NcQBxnvweP7i88nDW0PPE8=
X-Received: by 2002:a17:90a:e7c4:b0:2ff:53d6:2b82 with SMTP id
 98e67ed59e1d1-301a5bde7f8mr4505503a91.11.1742317263432; Tue, 18 Mar 2025
 10:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-2-e08633a7bdf8@oss.qualcomm.com> <kao2wccsiflgrvq7vj22cffbxeessfz5lc2o2hml54kfuv2mpn@2bf2qkdozzjq>
 <8a2bce29-95dc-53b0-0516-25a380d94532@oss.qualcomm.com>
In-Reply-To: <8a2bce29-95dc-53b0-0516-25a380d94532@oss.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 18 Mar 2025 19:00:51 +0200
X-Gm-Features: AQ5f1JqVmcNBPDgEyh5aAISGonCmVLn-AMt1AX9j-2qGS6_UgHA5JMDqMgl1I_k
Message-ID: <CAO9ioeW6-KgRmFO93Ouhyx9uQcdaPoX3=mjpz_2SPHKiHh3RkQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] arm64: dts: qcom: qcs6490-rb3gen2: Add TC956x
 PCIe switch node
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
        amitk@kernel.org, dmitry.baryshkov@linaro.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        jorge.ramirez@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=W/I4VQWk c=1 sm=1 tr=0 ts=67d9a6d1 cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=ccs1Irad_oSE8X62F2EA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: -XGDhuY5KMn2qIssR0oLmZCqBYdRdkLn
X-Proofpoint-ORIG-GUID: -XGDhuY5KMn2qIssR0oLmZCqBYdRdkLn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_08,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180125

On Tue, 18 Mar 2025 at 18:11, Krishna Chaitanya Chundru
<krishna.chundru@oss.qualcomm.com> wrote:
>
>
>
> On 3/17/2025 4:57 PM, Dmitry Baryshkov wrote:
> > On Tue, Feb 25, 2025 at 03:03:59PM +0530, Krishna Chaitanya Chundru wrote:
> >> Add a node for the TC956x PCIe switch, which has three downstream ports.
> >> Two embedded Ethernet devices are present on one of the downstream ports.
> >>
> >> Power to the TC956x is supplied through two LDO regulators, controlled by
> >> two GPIOs, which are added as fixed regulators. Configure the TC956x
> >> through I2C.
> >>
> >> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> >> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> >> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >> ---
> >>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 116 +++++++++++++++++++++++++++
> >>   arch/arm64/boot/dts/qcom/sc7280.dtsi         |   2 +-
> >>   2 files changed, 117 insertions(+), 1 deletion(-)
> >>
> >> @@ -735,6 +760,75 @@ &pcie1_phy {
> >>      status = "okay";
> >>   };
> >>
> >> +&pcie1_port {
> >> +    pcie@0,0 {
> >> +            compatible = "pci1179,0623", "pciclass,0604";
> >> +            reg = <0x10000 0x0 0x0 0x0 0x0>;
> >> +            #address-cells = <3>;
> >> +            #size-cells = <2>;
> >> +
> >> +            device_type = "pci";
> >> +            ranges;
> >> +            bus-range = <0x2 0xff>;
> >> +
> >> +            vddc-supply = <&vdd_ntn_0p9>;
> >> +            vdd18-supply = <&vdd_ntn_1p8>;
> >> +            vdd09-supply = <&vdd_ntn_0p9>;
> >> +            vddio1-supply = <&vdd_ntn_1p8>;
> >> +            vddio2-supply = <&vdd_ntn_1p8>;
> >> +            vddio18-supply = <&vdd_ntn_1p8>;
> >> +
> >> +            i2c-parent = <&i2c0 0x77>;
> >> +
> >> +            reset-gpios = <&pm8350c_gpios 1 GPIO_ACTIVE_LOW>;
> >> +
> >
> > I think I've responded here, but I'm not sure where the message went:
> > please add pinctrl entry for this pin.
> >
> Do we need to also add pinctrl property for this node and refer the
> pinctrl entry for this pin?

I think that is what I've asked for, was that not?

-- 
With best wishes
Dmitry

