Return-Path: <linux-pci+bounces-28994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5850AACE3C6
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 19:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84ABE18965D9
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 17:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3651ACEDA;
	Wed,  4 Jun 2025 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jlXBYn9i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6D21C6FF9
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 17:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749058746; cv=none; b=O7vqO59fBqd5/2ZiUr7VZmg8vl+JdEzrGR2jRlXZ4bPSUjdyomqsh2EKtdSuiBT9tdCeyIxKu04flN9AC86AgrIse+Fyt6RGjDIZ85daEi2V9fP8Y/0uYTuITOtHh7uQYSSS/KB83WKrKUQBMG95VoEg4JIOnJLDmbdw0aVN/Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749058746; c=relaxed/simple;
	bh=jroGMO5AkV8Ovxz0MYp5BHp3GgjYnVkrNMoKqqHJPBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=onsCMRWQg8ROzPuPDT+RnLr5JEq95VvFpe93Ra8UVDN25cVNYnznR/JwYLGMG1IsIpJsP47DF1gO4j2V7tOj6rt3etaXR41qg+EdoaDLW1IBdJdDEA17xlIooufkBS19xfw8rLXkTgLjMN4mFrzZHMEcVHfP/zcq0aV81cEQKMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jlXBYn9i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5548ObhB013606
	for <linux-pci@vger.kernel.org>; Wed, 4 Jun 2025 17:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fsF/mWMPVk1F5lUmzbIbWurkFTDnR1ya0VDDIO7Ymwo=; b=jlXBYn9iZYcTArub
	8dH4uWTeD4R32qi5AcexBzSm58lYDf/jsa2lFUkf1s2PSQCpvEyvrVM+oGyPV5pj
	fcg1wnGghi3oqUIYY3ldXq0b2VLJvCfwRZWqCGoTyLFVL7Fkpmh4u7R5Wkbz+APo
	IOrR3ZB8oADiDIEz1TxUTskxuP4z4oJgwXlq/ijbt5/HSiHTqEK8virQqotA8Waj
	ydV8fgVdrOX5vsmAxEwMQmC2N5+QMer2kd1SNRT55NZt6GVO+l3Z2Sa3BFiOOypX
	5U+YnECh6a7nPuntKmKWRExHf0TOCGWRtTc3tUJ8WXHRbhyMqfkX8XQtWvP7o5ro
	r23Tew==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8npvc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 04 Jun 2025 17:39:04 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-742951722b3so106221b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Jun 2025 10:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749058743; x=1749663543;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fsF/mWMPVk1F5lUmzbIbWurkFTDnR1ya0VDDIO7Ymwo=;
        b=uFvCVs/ccqDKAHO3QRjLUujytIHS4SqjyvswnuqfyMW1ic2FKGbx/nprSNpN0SOQA8
         dVi7mk7psYQPXw2n2oTGjYHNrri5xGaySyMCTcZPjh8MGwzE4BLi2ii38cly8QdrY84R
         ZSoyFNgiMrcCJFogvAf+aT5f9RL3c5K8n9mZOYUQRGde0XeVMa3xEtBkLtRHj6KL20a1
         h1hD9ugHrBqblFzlq+OdUVRZj/PDAQpaGsZUD1qP9denHkkokgvGj7RHmDfhM7cXBcQO
         PHzkTXZn3OHMaULNsM0/CVBn4qQLsPWAwxQfPTyeMwtBRLOYuak+WapK1Rze+wnoAnLY
         uZNw==
X-Gm-Message-State: AOJu0Yye9vsnGs9XcVUYeg+0IpbwUvC1NBat+aD4/aX0CU8+ZcPyY78k
	nAlu3aBlgaRoqoAWxwlDv4nvutNE/v+PEfMvS3YFPll+L0XVRTvUgl/VNPSRyd1T9y933PPdddh
	w8ZPBjghXdxVUBUa4Z63z3RPVhxicD00B5/erQDXu7dqL73f90IqdfF2j5faomffgt1d0GC4=
X-Gm-Gg: ASbGncvIfZEgZY7PLrIBNMGU7AKqCstZrALSKjlRw1k+kJzx379LY8lc1NKsLYShCdk
	7IbCAkX98fvQMwRJRcnNOjsz5XAuSITPw4ZAqQVyUlh4LeIDBwD6EtY8uDbGHx03+Iu4PxrICaS
	dIw2IGhPYX7yjwxoThLNGUUZgWwQ97jD1sHyOBkTIlZhjOSa/xRm7fDcHjyzEcl4jh+0t5ymIMJ
	Cpp3AJ2q9UyHNpsyT8iYU8yOtTP4M7LZl/KyEgylAj8V8EOug8G6rC3QsNnJB6chTacMS1lm0/X
	bzVDGvrUsZwKLK21vKNrDhFzjygWC1zbsy+Yn8DRueMiVwavm5TSd/s=
X-Received: by 2002:a05:6a00:3991:b0:736:9f20:a175 with SMTP id d2e1a72fcca58-7480b28ae10mr5330868b3a.2.1749058742947;
        Wed, 04 Jun 2025 10:39:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAMU3gjS9f0zLmHXLR+uJZMjk9c4OLrEdUrP5tIKUjh1bzGk6Z9HQjnSf4ko+2ScZjIrvJ0g==
X-Received: by 2002:a05:6a00:3991:b0:736:9f20:a175 with SMTP id d2e1a72fcca58-7480b28ae10mr5330830b3a.2.1749058742447;
        Wed, 04 Jun 2025 10:39:02 -0700 (PDT)
Received: from [10.73.113.218] (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afff7e3bsm11752681b3a.175.2025.06.04.10.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 10:39:01 -0700 (PDT)
Message-ID: <584d217a-e8df-4dbe-ad70-2c69597a0545@oss.qualcomm.com>
Date: Wed, 4 Jun 2025 10:38:06 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Add Qualcomm SA8255p based firmware managed PCIe
 root complex
To: linux-pci@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, andersson@kernel.org,
        manivannan.sadhasivam@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, quic_ramkri@quicinc.com,
        quic_nkela@quicinc.com, quic_shazhuss@quicinc.com,
        quic_msarkar@quicinc.com, quic_nitegupt@quicinc.com
References: <20250522001425.1506240-1-mayank.rana@oss.qualcomm.com>
Content-Language: en-US
From: Mayank Rana <mayank.rana@oss.qualcomm.com>
In-Reply-To: <20250522001425.1506240-1-mayank.rana@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uTIjMf-mPEBa7lFdWJuLoFrNegqtyTJG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDEzNyBTYWx0ZWRfX9+1uXi7TUySB
 2KJetjMKmEzNzO9R7cztddnIjGh6KrvCORyLjYhuCvU1XwIJGv6OzAnp1/HK+032Ekir+CD4mi3
 fB7ZDQMuhoBFelplYqwi4VawOUWcv/Dyvjoz9ousxSuP2QVgOoHWBh4IHSdk4u3sSzhhxKYrKgO
 9zeRWYuh5I52nXu5OxzCEEXtSBMBCjIeOXVRMXgo3D0nEx0dMZ1FkckAUjU54fHpgKoETGwn1hS
 u8d/5bjD55FruVYk721HMLWfyCFroEIIavjffwW2C8NgVsZYlRJTtFsVqYQtw68pC4rH8yCVied
 FaMZM/FSu/+WLyzq7hB/ACpRg7tIbV9UzDmyuEI1b4gPKZWyGi6bXxUkklJDt99mlvovZ5kz8Ze
 67dEB6il6cOzv7TLwoNAVvPDc6tNmhXqaUoffJxie4zBxAO22X9yNjsOI9KQl8G/1mxvSMkQ
X-Proofpoint-ORIG-GUID: uTIjMf-mPEBa7lFdWJuLoFrNegqtyTJG
X-Authority-Analysis: v=2.4 cv=UphjN/wB c=1 sm=1 tr=0 ts=684084b8 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZdW6uxA9NKXbfdqeeS2OGA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=X0UA8UkCL550gklx81IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0 adultscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040137

Hi Mani

As we discussed previously, I resumed working on this functionality.
Please help with reviewing this patchset.

Regards,
Mayank
On 5/21/2025 5:14 PM, Mayank Rana wrote:
> Based on received feedback, this patch series adds support with existing
> Linux qcom-pcie.c driver to get PCIe host root complex functionality on
> Qualcomm SA8255P auto platform.
> 
> 1. Interface to allow requesting firmware to manage system resources and
> performing PCIe Link up (devicetree binding in terms of power domain and
> runtime PM APIs is used in driver)
> 
> 2. SA8255P is using Synopsys Designware PCIe controller which supports MSI
> controller. Using existing MSI controller based functionality by exporting
> important pcie dwc core driver based MSI APIs, and using those from
> pcie-qcom.c driver.
> 
> Below architecture is used on Qualcomm SA8255P auto platform to get ECAM
> compliant PCIe controller based functionality. Here firmware VM based PCIe
> driver takes care of resource management and performing PCIe link related
> handling (D0 and D3cold). Linux pcie-qcom.c driver uses power domain to
> request firmware VM to perform these operations using SCMI interface.
> --------------------
> 
> 
>                                     ┌────────────────────────┐
>                                     │                        │
>    ┌──────────────────────┐         │     SHARED MEMORY      │            ┌──────────────────────────┐
>    │     Firmware VM      │         │                        │            │         Linux VM         │
>    │ ┌─────────┐          │         │                        │            │    ┌────────────────┐    │
>    │ │ Drivers │ ┌──────┐ │         │                        │            │    │   PCIE Qcom    │    │
>    │ │ PCIE PHY◄─┤      │ │         │   ┌────────────────┐   │            │    │    driver      │    │
>    │ │         │ │ SCMI │ │         │   │                │   │            │    │                │    │
>    │ │PCIE CTL │ │      │ ├─────────┼───►    PCIE        ◄───┼─────┐      │    └──┬──────────▲──┘    │
>    │ │         ├─►Server│ │         │   │    SHMEM       │   │     │      │       │          │       │
>    │ │Clk, Vreg│ │      │ │         │   │                │   │     │      │    ┌──▼──────────┴──┐    │
>    │ │GPIO,GDSC│ └─▲──┬─┘ │         │   └────────────────┘   │     └──────┼────┤PCIE SCMI Inst  │    │
>    │ └─────────┘   │  │   │         │                        │            │    └──▲──────────┬──┘    │
>    │               │  │   │         │                        │            │       │          │       │
>    └───────────────┼──┼───┘         │                        │            └───────┼──────────┼───────┘
>                    │  │             │                        │                    │          │
>                    │  │             └────────────────────────┘                    │          │
>                    │  │                                                           │          │
>                    │  │                                                           │          │
>                    │  │                                                           │          │
>                    │  │                                                           │IRQ       │HVC
>                IRQ │  │HVC                                                        │          │
>                    │  │                                                           │          │
>                    │  │                                                           │          │
>                    │  │                                                           │          │
> ┌─────────────────┴──▼───────────────────────────────────────────────────────────┴──────────▼──────────────┐
> │                                                                                                          │
> │                                                                                                          │
> │                                      HYPERVISOR                                                          │
> │                                                                                                          │
> │                                                                                                          │
> │                                                                                                          │
> └──────────────────────────────────────────────────────────────────────────────────────────────────────────┘
>                                                                                                              
>    ┌─────────────┐    ┌─────────────┐  ┌──────────┐   ┌───────────┐   ┌─────────────┐  ┌────────────┐
>    │             │    │             │  │          │   │           │   │  PCIE       │  │   PCIE     │
>    │   CLOCK     │    │   REGULATOR │  │   GPIO   │   │   GDSC    │   │  PHY        │  │ controller │
>    └─────────────┘    └─────────────┘  └──────────┘   └───────────┘   └─────────────┘  └────────────┘
> -----------------
> Changes in v4:
> - Addressed provided review comments from reviewers
> Link to v3: https://lore.kernel.org/lkml/20241106221341.2218416-1-quic_mrana@quicinc.com/
> 
> Changes in v3:
> - Drop usage of PCIE host generic driver usage, and splitting of MSI functionality
> - Modified existing pcie-qcom.c driver to add support for getting ECAM compliant and firmware managed
> PCIe root complex functionality
> Link to v2: https://lore.kernel.org/linux-arm-kernel/925d1eca-975f-4eec-bdf8-ca07a892361a@quicinc.com/T/
> 
> Changes in v2:
> - Drop new PCIe Qcom ECAM driver, and use existing PCIe designware based MSI functionality
> - Add power domain based functionality within existing ECAM driver
> Link to v1: https://lore.kernel.org/all/d10199df-5fb3-407b-b404-a0a4d067341f@quicinc.com/T/
> 
> Tested:
> - Validated NVME functionality with PCIe1 on SA8255P-RIDE platform
> 
> Mayank Rana (4):
>    PCI: dwc: Export dwc MSI controller related APIs
>    PCI: host-generic: Rename and export gen_pci_init() API to allow ECAM
>      creation
>    dt-bindings: PCI: qcom,pcie-sa8255p: Document ECAM compliant PCIe root
>      complex
>    PCI: qcom: Add Qualcomm SA8255p based PCIe root complex functionality
> 
>   .../bindings/pci/qcom,pcie-sa8255p.yaml       | 103 ++++++++++++++++
>   drivers/pci/controller/dwc/Kconfig            |   1 +
>   .../pci/controller/dwc/pcie-designware-host.c |  38 +++---
>   drivers/pci/controller/dwc/pcie-designware.h  |  14 +++
>   drivers/pci/controller/dwc/pcie-qcom.c        | 114 ++++++++++++++++--
>   drivers/pci/controller/pci-host-common.c      |   5 +-
>   include/linux/pci-ecam.h                      |   2 +
>   7 files changed, 248 insertions(+), 29 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml
> 


