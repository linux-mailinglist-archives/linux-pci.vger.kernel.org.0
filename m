Return-Path: <linux-pci+bounces-29899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 733A7ADBD0A
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 00:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1237B172C4C
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 22:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BEC282EE;
	Mon, 16 Jun 2025 22:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U4NdQ9fu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7B121C16D
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 22:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113788; cv=none; b=e0MUt2J1fx5U0Y8/u8y6SnSuiYOHYPfueAUFGFHYr0nWyVcnU0R7AXKx2u2HM+oJb/xNpbMqJTTP8Q4wubTMGx8+4I7nrbl9W+JTQ0wYEjy+YBc0hbSQtnbZ0PHR0nALj9XXuut+czeToqvUsR6hBWCobT9V7ItL08LLyYUCuNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113788; c=relaxed/simple;
	bh=zomONDQ0Qx37OkiETP/pnDcvQTypzvtXen0dGdSn/YE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hgku65EYKdndAk0HDHBme6y5suePM7y2gRgBvxrxaGJVP5nqbwBMzyUMHEegg2k9Fff4dNyuW1MkcsuwpdDgHMqH8OhEcK57/BxoZewsxgUhOaW7Sx3cNBIK0+NRqMJDhxTlTvCk7hWWn8iP74sixlvAEoY5sC9JN7mv9ymZGoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U4NdQ9fu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GGeeMG029581
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 22:43:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Xl/pk5AyXw9fWHquf+0bmU
	vgDIjx3jfKKP6iywcs/MU=; b=U4NdQ9fu+E1DUhB3+8fo5hzxXo8K8KkYEjIN8l
	ir+jT8ES00JHeEZ7BHv3GSu1hNK+0N/o3wXIrIYUrrrpPbrb81jW7hC8DTsuw84J
	D8drV/JYvWKj2d4VAOELGqaOAPZi5NR7q3BlI5TkZgXHmzxFlgD2Ofz+9FbajAW4
	92jxibIpjuBozG3DkV0hv6lRYdi0FcUmA4XmA3aJvlbNv+T33WaXLlWofCktqLlC
	5MGDtAfWoG//TvZp2Fz4zHE1DRWAeXDNLfJQ401/yO0ZRJiUzvNSvj2zYaIU2Ltq
	F3nHhvkFSs9hr/MJUU29v3ePzGaqwABXowgdN3rm7lklRPQA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791h962qg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 22:43:05 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-748cf01de06so349513b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 15:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750113784; x=1750718584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xl/pk5AyXw9fWHquf+0bmUvgDIjx3jfKKP6iywcs/MU=;
        b=v1R6EboLOeF0ADKQzni0oM4692Bnm1tXZc5wHzXDBddbNeE2pkYTcO2fEib3/xN8CO
         F3KEDvQ9AjlHO6gkmiWAG0zqMuOtEE79X4dt3Q3jfmkBAPHuKuGLc+K5e/x614ycRrNt
         qa2WRzaq0aNj6yJi4heteKZ6J/YHNzAMyxz07L8lQEgkew2j3IHp0zZHxGfizacwhjUe
         SsnN5S7d9FfTlkmFHFE2nzu4qaEv+GKB2Wt/w03bP85iwlN0NIuemDTE6StsmVGp1FEX
         5RDYWoWyqNKHy8/NIL+k7KltRjKgh0LwVSXyrtv0OPwyb3vUtxp23KuKkqz6THBbgD8i
         SiJg==
X-Gm-Message-State: AOJu0Ywj8vuH500OTT1YCTnE3QL/KDPiZNLHea36bF9G9aPpD4nqRy0K
	TAWAWoTR6rnFDwJbWcihujhr7R7thi9yYw24uzhV3siztTeSBgJvxsDFt8AME12pilAmbEgYlyu
	qEaAPeWHcd+xbFumw7jnEAj+l5LSaK6dyrD91O0X3Oh0sKbrdSf284crh3KGYySD6Swj5t0M=
X-Gm-Gg: ASbGncshsCSV2lBpuCSaNsOwcUwEFtoVaSKr48r/OziJOFZL+h6+9wQEulI7d3/PPNH
	UjRX/IaBDHcfkJZ7/Fk3K7hf2w77aU6/s/ld6jqzAY3faY/ZvtUTFZE1l+bx5skBClyUAUUNlda
	QHe5HhYDUVCb5sNfCSWhRfpzRlGWvlstvMY3l+h3kaQumYu7GbWH+Z0Lco17JJLRfQNHjMBTb1k
	Oo9EMK8XrFDMgQXYzqGpe6W9BWa20rLb4srHo3Vd8Ha+edsVSaf9tf6mD0eKW/t9/iuEQ9RrjwU
	ZRwpn1U/8V90AnGq5GEC1XO7zgwfVn9+RrWvMja5dhdR5Fk6+xfFTBjC+k64bUjHS5Sx2BJD
X-Received: by 2002:a05:6a00:10c8:b0:748:2ff7:5e22 with SMTP id d2e1a72fcca58-7489cff1950mr12695014b3a.10.1750113783755;
        Mon, 16 Jun 2025 15:43:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9UV9wLQcUsY/aC3vfdnxVaPe6n7TpuExyAehf70xpQMa7h1OtnP3qBq8I+prIqhHmzBkG7A==
X-Received: by 2002:a05:6a00:10c8:b0:748:2ff7:5e22 with SMTP id d2e1a72fcca58-7489cff1950mr12694993b3a.10.1750113783346;
        Mon, 16 Jun 2025 15:43:03 -0700 (PDT)
Received: from hu-mrana-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890083029sm7405077b3a.81.2025.06.16.15.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 15:43:02 -0700 (PDT)
From: Mayank Rana <mayank.rana@oss.qualcomm.com>
To: linux-pci@vger.kernel.org, will@kernel.org, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        andersson@kernel.org, mani@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, quic_ramkri@quicinc.com,
        quic_shazhuss@quicinc.com, quic_msarkar@quicinc.com,
        quic_nitegupt@quicinc.com, Mayank Rana <mayank.rana@oss.qualcomm.com>
Subject: [PATCH v5 0/4] Add Qualcomm SA8255p based firmware managed PCIe root complex
Date: Mon, 16 Jun 2025 15:42:55 -0700
Message-Id: <20250616224259.3549811-1-mayank.rana@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tErl7rSCGR00bzkO1zE2rknb3HXanbFv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDE2MiBTYWx0ZWRfX1domElizuLI4
 cUSlNJyCVzLd/y8kkvL1v/WZqV7zZIAz9Oka1WjzJWIQQsJ2VbTH8tehF42x38sybRyB8DnyhGY
 ehEo8h6PDzuSwgDxqnezgi4gyimYqdU4RLfYngKznsbplBSELmxNm9lQ7zsVK8bOmxWqPfKnTma
 Et9P7Z6W4OCL25FZ04xC8k1aXjMDQDaeBibXYxEpr+2UA3+bVCKaWUEwbJBdvEHWSRpdUc2qNyJ
 ZEsPmJFA/WMvwyZlJWUFAdq99rZYuG2Vjbk1IaTFFdCrw3KvtqVo8iLJo3jEqhN3SCCl8IOBu3L
 wmNIYQGISpgoZ+NsFhBpMekDrGV76U0an8qtna8vBDEK6Qeyg7wPLlfOy8E1eB8xIMPrMJtlD9u
 G1AX5FGHDBWWXbk5pri0mDvOZgJK6hgUvYZJ/JqXezvyChFiFjfg0Xh9H5HEpZEJ+u6oFFCi
X-Authority-Analysis: v=2.4 cv=UL/dHDfy c=1 sm=1 tr=0 ts=68509df9 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=cBYbKlKiy6JW2YU5ZBsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: tErl7rSCGR00bzkO1zE2rknb3HXanbFv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_11,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160162

Based on received feedback, this patch series adds support with existing
Linux qcom-pcie.c driver to get PCIe host root complex functionality on
Qualcomm SA8255P auto platform.

1. Interface to allow requesting firmware to manage system resources and
performing PCIe Link up (devicetree binding in terms of power domain and
runtime PM APIs is used in driver)

2. SA8255P is using Synopsys Designware PCIe controller which supports MSI
controller. Using existing MSI controller based functionality by exporting
important pcie dwc core driver based MSI APIs, and using those from
pcie-qcom.c driver.

Below architecture is used on Qualcomm SA8255P auto platform to get ECAM
compliant PCIe controller based functionality. Here firmware VM based PCIe
driver takes care of resource management and performing PCIe link related
handling (D0 and D3cold). Linux pcie-qcom.c driver uses power domain to
request firmware VM to perform these operations using SCMI interface.
--------------------


                                   ┌────────────────────────┐                                               
                                   │                        │                                               
  ┌──────────────────────┐         │     SHARED MEMORY      │            ┌──────────────────────────┐       
  │     Firmware VM      │         │                        │            │         Linux VM         │       
  │ ┌─────────┐          │         │                        │            │    ┌────────────────┐    │       
  │ │ Drivers │ ┌──────┐ │         │                        │            │    │   PCIE Qcom    │    │       
  │ │ PCIE PHY◄─┤      │ │         │   ┌────────────────┐   │            │    │    driver      │    │       
  │ │         │ │ SCMI │ │         │   │                │   │            │    │                │    │       
  │ │PCIE CTL │ │      │ ├─────────┼───►    PCIE        ◄───┼─────┐      │    └──┬──────────▲──┘    │       
  │ │         ├─►Server│ │         │   │    SHMEM       │   │     │      │       │          │       │       
  │ │Clk, Vreg│ │      │ │         │   │                │   │     │      │    ┌──▼──────────┴──┐    │       
  │ │GPIO,GDSC│ └─▲──┬─┘ │         │   └────────────────┘   │     └──────┼────┤PCIE SCMI Inst  │    │       
  │ └─────────┘   │  │   │         │                        │            │    └──▲──────────┬──┘    │       
  │               │  │   │         │                        │            │       │          │       │       
  └───────────────┼──┼───┘         │                        │            └───────┼──────────┼───────┘       
                  │  │             │                        │                    │          │               
                  │  │             └────────────────────────┘                    │          │               
                  │  │                                                           │          │               
                  │  │                                                           │          │               
                  │  │                                                           │          │               
                  │  │                                                           │IRQ       │HVC            
              IRQ │  │HVC                                                        │          │               
                  │  │                                                           │          │               
                  │  │                                                           │          │               
                  │  │                                                           │          │               
┌─────────────────┴──▼───────────────────────────────────────────────────────────┴──────────▼──────────────┐
│                                                                                                          │
│                                                                                                          │
│                                      HYPERVISOR                                                          │
│                                                                                                          │
│                                                                                                          │
│                                                                                                          │
└──────────────────────────────────────────────────────────────────────────────────────────────────────────┘
                                                                                                            
  ┌─────────────┐    ┌─────────────┐  ┌──────────┐   ┌───────────┐   ┌─────────────┐  ┌────────────┐        
  │             │    │             │  │          │   │           │   │  PCIE       │  │   PCIE     │        
  │   CLOCK     │    │   REGULATOR │  │   GPIO   │   │   GDSC    │   │  PHY        │  │ controller │        
  └─────────────┘    └─────────────┘  └──────────┘   └───────────┘   └─────────────┘  └────────────┘        
-----------------
Changes in v5:
- Rebased changes to v6.16-rc1 kernel and updated proposed changes to accomodate new refactoring with pci-host-common.c file
Link to v4: https://patchwork.kernel.org/project/linux-pci/cover/20250522001425.1506240-1-mayank.rana@oss.qualcomm.com/ 

Changes in v4:
- Addressed provided review comments from reviewers
Link to v3: https://lore.kernel.org/lkml/20241106221341.2218416-1-quic_mrana@quicinc.com/

Changes in v3:
- Drop usage of PCIE host generic driver usage, and splitting of MSI functionality
- Modified existing pcie-qcom.c driver to add support for getting ECAM compliant and firmware managed
PCIe root complex functionality
Link to v2: https://lore.kernel.org/linux-arm-kernel/925d1eca-975f-4eec-bdf8-ca07a892361a@quicinc.com/T/

Changes in v2:
- Drop new PCIe Qcom ECAM driver, and use existing PCIe designware based MSI functionality
- Add power domain based functionality within existing ECAM driver
Link to v1: https://lore.kernel.org/all/d10199df-5fb3-407b-b404-a0a4d067341f@quicinc.com/T/                                                                                 

Tested:
- Validated NVME functionality with PCIe1 on SA8255P-RIDE platform

Mayank Rana (4):
  PCI: dwc: Export dwc MSI controller related APIs
  PCI: host-generic: Rename and export gen_pci_init() to allow ECAM
    creation
  dt-bindings: PCI: qcom,pcie-sa8255p: Document ECAM compliant PCIe root
    complex
  PCI: qcom: Add support for Qualcomm SA8255p based PCIe root complex

 .../bindings/pci/qcom,pcie-sa8255p.yaml       | 122 ++++++++++++++++++
 drivers/pci/controller/dwc/Kconfig            |   1 +
 .../pci/controller/dwc/pcie-designware-host.c |  38 +++---
 drivers/pci/controller/dwc/pcie-designware.h  |  14 ++
 drivers/pci/controller/dwc/pcie-qcom.c        | 116 +++++++++++++++--
 drivers/pci/controller/pci-host-common.c      |   5 +-
 drivers/pci/controller/pci-host-common.h      |   2 +
 7 files changed, 269 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml

-- 
2.25.1


