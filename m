Return-Path: <linux-pci+bounces-28996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E534ACE3D4
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 19:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2020717484B
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 17:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180951F8F09;
	Wed,  4 Jun 2025 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GruciZtv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441C51C6FF9
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749058950; cv=none; b=FPJBlxd07cR1JViq/AoTkAibBYwevi975jHv2i2fKmvBl3sNB8THEVCGEPL3SYnw3PSHQvInhmCTakc6Au8ADOdPEtFWrLBLpn8jQLYplscPijPMqK7ag/KyZ7W58XFcIw+Uw4ETHN3rj/Ge4fEPWHoL+gZibtQnIpMvpIudd90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749058950; c=relaxed/simple;
	bh=dpxRtcosDSTfIRom80YFmbFdkntRSBKKUBI9ZUOL0JI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UoRbLDZZ9Ycl1r8dQu/UCP4Vv3kXtkzXFtNjt/x1vUBUYfLqibChlld0yg+9+foayvZD/J98qJ2SP4dZjepcBOFAyUU6VMTlbxtbUTt/1z1RV2weafMIOkMicnrtbmyw5ANLAnAWjIUZaR0J5OBqja8LmZfyZ8XvfYgq0BdJ0Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GruciZtv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554H8PVA010823
	for <linux-pci@vger.kernel.org>; Wed, 4 Jun 2025 17:42:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lYFzLmcgSL8jz/bslCcGB9/eezZpP/4JDxDoimk1+uo=; b=GruciZtv6AHQ8imE
	UUp3H3G7YZYkJfi043qAA4GqC2HCseyHuWfHEcTTUtM8xuUmwahO0BqwNrPxOT/5
	7FTUWNTN5dcradUo8uh3WoxDILOWcvyQ3MkqNFkDYNvzNf5DaxPJqdGzRJzeKADy
	KpkTjN11CYXr0iOH99ffSUU1niivL1sVBAzrBPyf7gFUUIcf9H3omfrzp535nJWn
	TlI7uijsqnQ4jo0t+699ULiKncAXsmmh57wMHOUhxYSgUyur1W9QiXXAgoJkcJBM
	OO8L1YRET4XnOreWXD6lAFKJ9Ru52QAPs/jndN9iGbZtuV2Iejmb07pCCHs2nU6R
	S9PmGA==
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8ypvgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 04 Jun 2025 17:42:26 +0000 (GMT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-86d01ff56ebso5998139f.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Jun 2025 10:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749058945; x=1749663745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lYFzLmcgSL8jz/bslCcGB9/eezZpP/4JDxDoimk1+uo=;
        b=h2iHp+PdjSPW7ZLnqhrKLVmGb1a/rNazQ+H9gHTXXRqNu+r4WhVhtlkCLGX9o3NYBn
         MHei2MNUe5mVb8/mTJ8OsznaZWLUMuMfvykB62a+uMqrgk/nMDvTVjZfJLasvxkUoAaE
         wekJlqdk0n/18XP1OnSokewBbve1jVZGwbMdTFc6mrvJ9ddyfEQms18Pt4+UPyxr4+YZ
         7aby+kI46cTkqo65KULDXYXYZIXQKB3t7iSCE5L/yd9Q2Qrp/tCTQ9aScEYdOD0uWw5y
         wnG9PqPqJsGrJkN4xeVIxXj5esPGEdtzZefNDplELyscbV4QVDREwOA0MQmBKayAFypU
         9+RA==
X-Gm-Message-State: AOJu0YySgHEeReYBDErps3xO3veTFQoVuIqANENBk3yT5VG5uK/Gc8yR
	A5ipiFgnvFhsC+oJ5V7NEQXes4tqL7CLZKUK5Kw9VA2zHj9GejlQcAXpjocMq91+yMtokOfmyhH
	Vw+lNBkg2RzkSupjeRfvebVwjqSZs4/AHdiZWvKneZhWo849Lw6BYCX44VRoCdatqoXZWHVU=
X-Gm-Gg: ASbGncsAdh04Qw8P34nohnjOeyTAZ+//PZo2ZlKmZVucTVXf3ANV3s1c0ufibjniqD+
	xcdMGaojnaFvZh06Wec+YeHWPr+0xj367T324VfmgYNNlYwVY30u7+adn8u8gW9OQfVWzH8s1Zz
	KRWi02h9gzjD1CPrEsGooYPmKIoAVJRqx3C3mQjZdO8DaYRXy3KUmlGJWFaIWuueIhRm/3eOYDB
	U9kniP4dsSgPYoQUumGEhEbUIZteib4Gm0ml/0OK0TFxwxadEY/yOrmr/k7XcMfyWlg5hSCeMiI
	4oGAbep7PR0Vyq0QQrEOjoI2czc0Eu9SXbhpEY6MCdugbJyZdcIyK3k=
X-Received: by 2002:a05:6602:379b:b0:85b:3f06:1fd4 with SMTP id ca18e2360f4ac-8731c68b23bmr399868039f.9.1749058945358;
        Wed, 04 Jun 2025 10:42:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCHyZ4xXAVPCUM2tAS2VGFRxO6rT03ktGF3F1YWr5XpQMT0IvmrYdg4zr7jNop57H3p28lQQ==
X-Received: by 2002:a17:903:2305:b0:235:cb94:1399 with SMTP id d9443c01a7336-235e10184b7mr43431495ad.6.1749058934256;
        Wed, 04 Jun 2025 10:42:14 -0700 (PDT)
Received: from [10.73.113.218] (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506d19bfesm106622675ad.253.2025.06.04.10.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 10:42:13 -0700 (PDT)
Message-ID: <7024d638-cf6d-454e-99e1-1eef51461cac@oss.qualcomm.com>
Date: Wed, 4 Jun 2025 10:42:12 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] dt-bindings: PCI: qcom,pcie-sa8255p: Document ECAM
 compliant PCIe root complex
To: linux-pci@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, andersson@kernel.org,
        manivannan.sadhasivam@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, quic_ramkri@quicinc.com,
        quic_nkela@quicinc.com, quic_shazhuss@quicinc.com,
        quic_msarkar@quicinc.com, quic_nitegupt@quicinc.com
References: <20250522001425.1506240-1-mayank.rana@oss.qualcomm.com>
 <20250522001425.1506240-4-mayank.rana@oss.qualcomm.com>
Content-Language: en-US
From: Mayank Rana <mayank.rana@oss.qualcomm.com>
In-Reply-To: <20250522001425.1506240-4-mayank.rana@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDEzNyBTYWx0ZWRfX1fLivBshXbWW
 vT0Cz3/QQgpLZ3O9/QKu6IxvBk4JrOdbtExZa5HEoL/IL+/yHYlzc3j2OOW5sDZWX2KWBtrHXaQ
 MoP55bmmT78UNoA8vsrT/sBboCwx4iWUVpgsSDEKBuERtxa1RR3yrxYoFNW+rdPk4eOnOnmuFP1
 hahpdOUBmCePWw+XKByUIsFM8WiXLe0O3fFFy/4W9L2+gzO1pedltvE3WK+8TkSPvdS//hfbb40
 xqBSGU9puaBite4nQO9G9Fu9FIFRYetm30H9dqLL+5VkyMX6B1Bou6/RZwxZQ3iB8kaRIy4g40v
 5k3l3gJQ1bapvzeWzLbtUVQNnVvBGAhJkZNmwK85yGcsl8cLYMO97BVsq0rX8TILhi7h+bEPhpG
 6tVJXARDrLl5SDGJFa7dsC0W/asijOw9iZV/IBINfSOdNq8moY8iP2OMCCcHkluODfjrkvws
X-Proofpoint-ORIG-GUID: YjYd6tW2utv25Adme_2CXFmJNTBzy5nL
X-Proofpoint-GUID: YjYd6tW2utv25Adme_2CXFmJNTBzy5nL
X-Authority-Analysis: v=2.4 cv=T/uMT+KQ c=1 sm=1 tr=0 ts=68408582 cx=c_pps
 a=uNfGY+tMOExK0qre0aeUgg==:117 a=ZdW6uxA9NKXbfdqeeS2OGA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=x9MGDe5N4ij58YJjnH8A:9 a=QEXdDO2ut3YA:10
 a=61Ooq9ZcVZHF1UnRMGoz:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 adultscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040137

Hi Krzysztof

Please help with reviewing updated patchset.

Regards,
Mayank

On 5/21/2025 5:14 PM, Mayank Rana wrote:
> Document the required configuration to enable the PCIe root complex on
> SA8255p, which is managed by firmware using power-domain based handling
> and configured as ECAM compliant.
> 
> Signed-off-by: Mayank Rana <mayank.rana@oss.qualcomm.com>
> ---
>   .../bindings/pci/qcom,pcie-sa8255p.yaml       | 122 ++++++++++++++++++
>   1 file changed, 122 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml
> new file mode 100644
> index 000000000000..88c8f012708c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/qcom,pcie-sa8255p.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SA8255p based firmware managed and ECAM compliant PCIe Root Complex
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +
> +description:
> +  Qualcomm SA8255p SoC PCIe root complex controller is based on the Synopsys
> +  DesignWare PCIe IP which is managed by firmware, and configured in ECAM mode.
> +
> +properties:
> +  compatible:
> +    const: qcom,pcie-sa8255p
> +
> +  reg:
> +    description:
> +      The Configuration Space base address and size, as accessed from the parent
> +      bus. The base address corresponds to the first bus in the "bus-range"
> +      property. If no "bus-range" is specified, this will be bus 0 (the
> +      default).
> +    maxItems: 1
> +
> +  ranges:
> +    description:
> +      As described in IEEE Std 1275-1994, but must provide at least a
> +      definition of non-prefetchable memory. One or both of prefetchable Memory
> +      may also be provided.
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupts:
> +    minItems: 8
> +    maxItems: 8
> +
> +  interrupt-names:
> +    items:
> +      - const: msi0
> +      - const: msi1
> +      - const: msi2
> +      - const: msi3
> +      - const: msi4
> +      - const: msi5
> +      - const: msi6
> +      - const: msi7
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  dma-coherent: true
> +  iommu-map: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - ranges
> +  - power-domains
> +  - interrupts
> +  - interrupt-names
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pci@1c00000 {
> +           compatible = "qcom,pcie-sa8255p";
> +           reg = <0x4 0x00000000 0 0x10000000>;
> +           device_type = "pci";
> +           #address-cells = <3>;
> +           #size-cells = <2>;
> +           ranges = <0x02000000 0x0 0x40100000 0x0 0x40100000 0x0 0x1ff00000>,
> +                    <0x43000000 0x4 0x10100000 0x4 0x10100000 0x0 0x40000000>;
> +           bus-range = <0x00 0xff>;
> +           dma-coherent;
> +           linux,pci-domain = <0>;
> +           power-domains = <&scmi5_pd 0>;
> +           iommu-map = <0x0 &pcie_smmu 0x0000 0x1>,
> +                       <0x100 &pcie_smmu 0x0001 0x1>;
> +           interrupt-parent = <&intc>;
> +           interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
> +                        <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
> +                        <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
> +                        <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
> +                        <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
> +                        <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
> +                        <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
> +                        <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
> +           interrupt-names = "msi0", "msi1", "msi2", "msi3",
> +                                  "msi4", "msi5", "msi6", "msi7";
> +
> +           #interrupt-cells = <1>;
> +           interrupt-map-mask = <0 0 0 0x7>;
> +           interrupt-map = <0 0 0 1 &intc GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> +                           <0 0 0 2 &intc GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
> +                           <0 0 0 3 &intc GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
> +                           <0 0 0 4 &intc GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
> +
> +           pcie@0 {
> +                   device_type = "pci";
> +                   reg = <0x0 0x0 0x0 0x0 0x0>;
> +                   bus-range = <0x01 0xff>;
> +
> +                   #address-cells = <3>;
> +                   #size-cells = <2>;
> +                   ranges;
> +            };
> +        };
> +    };


