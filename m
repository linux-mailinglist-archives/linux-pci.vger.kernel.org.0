Return-Path: <linux-pci+bounces-29919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0826ADC87A
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 12:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F9B3B81BF
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 10:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786A52D12F7;
	Tue, 17 Jun 2025 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qkx953TD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840D72C08BB;
	Tue, 17 Jun 2025 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750156464; cv=none; b=MCcDb85tGjgTaQt9icteUcyjNsiDikoY4cdfzY6dC+2hkz4d6PVgQyCk9XMXwrUlJEtxTvLw6GzlMYowPeKeHFKSVKZnyZ693te3HLH+FEg2YzCiztjPBHAMykw5YCz2BDDxxLz7i9c9ZbVDwVu/s/eQ2ruXsmvZrhzvqlf8Xs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750156464; c=relaxed/simple;
	bh=LA8Agp/KNHj/8B3w+aPec2ZQeyJE4KmhTO75m9QPzn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WFAmoPAMd38BHATV5EZp5XLodQV79h1rCrJnd8c4/hsnzrM1OqBYpl2oilD/6tWbmV5al+SpWsEjk8O+uApoA+jR2glK36dzP7fGcKAL/uOd9g0e10+vh1reu6sUNXjQ9h0t1cX89Y3Dde45aD6t9lJL5D/ka0EBOeNe2cK3K7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qkx953TD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H9kmnE002613;
	Tue, 17 Jun 2025 10:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	REQwFfem1/wZK/Q8qhNl4HvAi0fc5WZdIoHe86nsrVE=; b=Qkx953TDD5ybu/FV
	HMuIlg00yeGXKDCYs8szVerjT6NU0DHriquK9vdQHnAOzfovhL/1wyP5x9+6jlWN
	NNv9AYlEogC+oBf5quE/mC0Z4inQtq/hAkR5jx9MsZhR9SyAh7pKIfiBlJM1IV+r
	MNRUZmzj4oZYSp/j7dYN3bNaNyLnHqVim0bdnjnZzpE8PHuMP5PnuDMeoqFYwpoM
	+tYZI2BN8xYHD02vz5DUIimobgNnC4+G8JNwg1N41LQnAzaz2oASrJArItJLg75C
	ponyWNt/hOf7scPzCEAu+ZMcmr+Pp8zOFWqzY4PornLUwBb9lAemvH5a0YOXjbqB
	xaBGxg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47akuwbdfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 10:34:12 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55HAYBld022993
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 10:34:11 GMT
Received: from [10.253.79.108] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 17 Jun
 2025 03:34:06 -0700
Message-ID: <d67ba247-6b2d-4f2e-9583-ddbe375bf08d@quicinc.com>
Date: Tue, 17 Jun 2025 18:34:03 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] pci: qcom: Add QCS615 PCIe support
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>,
        <neil.armstrong@linaro.org>, <abel.vesa@linaro.org>, <kw@linux.com>,
        <conor+dt@kernel.org>, <vkoul@kernel.org>, <kishon@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_qianyu@quicinc.com>,
        <quic_krichai@quicinc.com>, <quic_vbadigan@quicinc.com>
References: <20250527072036.3599076-1-quic_ziyuzhan@quicinc.com>
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
In-Reply-To: <20250527072036.3599076-1-quic_ziyuzhan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qFW4Pp51uU_W74rv7Yaq1I_sLYShsqXI
X-Authority-Analysis: v=2.4 cv=He0UTjE8 c=1 sm=1 tr=0 ts=685144a4 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=hZAuWOsFeZFjXlRRXhUA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: qFW4Pp51uU_W74rv7Yaq1I_sLYShsqXI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA4NSBTYWx0ZWRfXxBl1/CLmbaO8
 d5/NoG63pOVTLrN687epg7WqXD/uls/SBTY4Hf8KS/MPEAArPwcwA/oG1VgHeh6efHrKvd1lyS3
 oUutrWVAIH65Gj1v57v/FpqRXDO8wE38/3NUgNkUrt2hSoEy0/AZMq2pf+LcvZj/XeSar4jhQTi
 EpqQAF98AWXWkBsdla5wRPBEj3KGGaURbS9e/HJH2bXDTGLvFurBy/Fm4OFjzD4PMoLh99i10ns
 fz5BGCbsrCKVwh1f6eGJ4N7hzfFoQ/UCntZGmkO8W+S/Oly90p9bR6SobqCrrVM9o9+O7jupLHj
 VZvgpOoUq4lHBlPV3q4gxGnfzpgCE5DF1OJrlm85hqF+WKPxA43RW+/+4kqQpnIKFVMJlBtn0wF
 M+vnNbnjB5aH2+AxjB8DgLrWG2AU/6V7MOllfD8REufrVoeSChr3aVW53sxE0y72o+KZw66/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_04,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=701 lowpriorityscore=0 phishscore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170085


On 5/27/2025 3:20 PM, Ziyue Zhang wrote:
> This series adds document, phy, configs support for PCIe in QCS615.
>
> This series depend on the dt-bindings change
> https://lore.kernel.org/all/20250521-topic-8150_pcie_drop_clocks-v1-0-3d42e84f6453@oss.qualcomm.com/
>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
> Have following changes:
> 	- Add a new Document the QCS615 PCIe Controller
> 	- Add configurations in devicetree for PCIe, including registers, clocks, interrupts and phy setting sequence.
> 	- Add configurations in devicetree for PCIe, platform related gpios, PMIC regulators, etc.
>
> Changes in v5:
> - Drop qcs615-pcie.yaml and use sm8150, as qcs615 is the downgraded
>    version of sm8150, which can share the same yaml.
> - Drop compatible enrty in driver and use sm8150's enrty (Krzysztof)
> - Fix the DT format problem (Konrad)
> - Link to v4: https://lore.kernel.org/all/20250507031559.4085159-1-quic_ziyuzhan@quicinc.com/
>
> Changes in v4:
> - Fixed compile error found by kernel test robot(Krzysztof)
> - Update DT format (Konrad & Krzysztof)
> - Remove QCS8550 compatible use QCS615 compatible only (Konrad)
> - Update phy dt bindings to fix the dtb check errors.
> - Link to v3: https://lore.kernel.org/all/20250310065613.151598-1-quic_ziyuzhan@quicinc.com/
>
> Changes in v3:
> - Update qcs615 dt-bindings to fit the qcom-soc.yaml (Krzysztof & Dmitry)
> - Removed the driver patch and using fallback method (Mani)
> - Update DT format, keep it same with the x1e801000.dtsi (Konrad)
> - Update DT commit message (Bojor)
> - Link to v2: https://lore.kernel.org/all/20241122023314.1616353-1-quic_ziyuzhan@quicinc.com/
>
> Changes in v2:
> - Update commit message for qcs615 phy
> - Update qcs615 phy, using lowercase hex
> - Removed redundant function
> - split the soc dtsi and the platform dts into two changes
> - Link to v1: https://lore.kernel.org/all/20241118082619.177201-1-quic_ziyuzhan@quicinc.com/
>
> Krishna chaitanya chundru (2):
>    arm64: dts: qcom: qcs615: enable pcie
>    arm64: dts: qcom: qcs615-ride: Enable PCIe interface
>
> Ziyue Zhang (2):
>    dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
>      for QCS615
>    dt-bindings: PCI: qcom,pcie-sm8150: document qcs615
>
>   .../bindings/pci/qcom,pcie-sm8150.yaml        |   7 +-
>   .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |   2 +-
>   arch/arm64/boot/dts/qcom/qcs615-ride.dts      |  42 +++++
>   arch/arm64/boot/dts/qcom/qcs615.dtsi          | 146 ++++++++++++++++++
>   4 files changed, 195 insertions(+), 2 deletions(-)
>
>
> base-commit: ac12494a238dba00fe8d1459fcf565f98

Hi Maintainers,

It seems merge window just close recently, can you give this series further comment ?
Thanks very much.

BRs
Ziyue

> 77960f1

