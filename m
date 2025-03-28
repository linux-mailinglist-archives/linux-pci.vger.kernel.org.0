Return-Path: <linux-pci+bounces-24927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BA6A74852
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 11:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B46173071
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 10:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5551121C161;
	Fri, 28 Mar 2025 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qb6C+umn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C60921ABA5
	for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743157756; cv=none; b=ot/ZvJiaqHDMTjm4HRIlt01PaEFx0k7LF2GjsqZ5jMzo8RKf0ZOn8RZ2hyqF+ERNP2Oqf97lC3JRlINkRZT9DDFfQJVodu8glAIzYphXjBKlNWQes0TvaEZZ/+Mv3GkkRkAAyysBFx9jQsUrtmI6j5bm2byolvo3v1HvGBH/K1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743157756; c=relaxed/simple;
	bh=+5NeY14GAaZjhf9/kf9i4kyV16jVK7K3/ekUtxFah+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KP8cg3uTV0enRr2wvrjR+aiOShe1D7uW1ICRnYcKqHT1Vnupvank2R1/K62QSBThIZVnBF2foCx9GPUw/eZg4+5VtP006hLX9LObCXtCofPJFuiMDontNJE5jhMjoKF348EW4e7xS0qmVljIDzDsRx+X/wlu3zPWY946MQUwqkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qb6C+umn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52S4AeDx021908
	for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 10:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	80CEep44lPSG9HKI/yxAQvAq0iPYIRCTfFFMWIfFXLE=; b=Qb6C+umnPj908RUD
	yKF00GV5DZbu24/nhfNJniTVWCKeVdoOkmM/7S7GjTjlTX4orohhjf3yO9RKD7km
	W71mWQ4WyaLAAuh+t558M6+R7VTe2FPBNVpG4ZHykTMEUn1AY65iliZi94TdYI3o
	JHQGUmlQVOYxnTgtYxTm4huRQh+m2qdG8D6Z7GSOaRll2mWU4VmvX8S/H7noIMnC
	zqHTaqdXWAhDlA77Yl//L9FRO71waUbgB0p71lg+INg3MBqQPWA2r6YvTPmoI27W
	DjW9UZvlgpa8pqFijFegNqSyyC6E50Bpx1EvOHk0OUWcMWztDk2yeqcLJhJobPiW
	ja62PA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kyr9shu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 10:29:13 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2254e0b4b85so35365795ad.0
        for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 03:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743157752; x=1743762552;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80CEep44lPSG9HKI/yxAQvAq0iPYIRCTfFFMWIfFXLE=;
        b=eK0MP5Zfp4PTLhisimj7DpVUdU4A5PKBrsXBWOk5U7tLRYt62ejkdM6VaYfU3Dv2B4
         n8Zqv43RPMS/hnPynRXC27LsnLUxeQlp8hR9dRBfRRwXhCE4nSghFdSAnIn2/02s7+OR
         O7pcC2FVwCaTWDkqJAun44NIcv5iogL9ugWJPPPRCp2kG18dahHORe/V51an7CXZQygV
         Y2dIb8PJR/+80PZnW5B3dffId6zilXAK9ojfNpiyqq2+OC7x6sllF7RAE4tlXlXabbCr
         j46abL064QdwhA915BotyvS4fyjWky09ljGjLDhBpjm4/HlQ1iOvOzyVSzC/c3LYfD1M
         9PEg==
X-Forwarded-Encrypted: i=1; AJvYcCXzRyLfrZX8rWahqALWL/0c/kGz0v0axQqUe9QQUCLZ0RhvNeJbzG4YtoAB1cj7+XZdOXaZ1G5MvEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPkvcjhYlubxz1JLA+pYxmtTt2+IcRm8mB3Hmqt+62LOTysoTC
	QeWwg3MMY7XpWUcjYafTOK4F36g+vvNJo9jA2fyvcNdTnDi05jEjWAIBq7FRKEtPHfpYwBqDbT+
	g+t8jWNfkIgpIFm9Ah3wrXBgbulHOuket2sLqsOAYpR0r37MT63cOnLmmdKA=
X-Gm-Gg: ASbGncvxLU+jayYqmVZK3QTVZV7DT/otqK2HLMBDMkptccV11HaoOT5NDyeHtI8Q0K6
	9mOZ/SvGg16DbkkPWmOa6oKpVlGLHrN5a6SlZbG3+5m22zsOcYd6rb5GxyDNzWMJoN1YF+0DXsH
	MVlUJts5Li6/bIB70nb+nGPr1yKt5zd2IgpxUaGXL6pVoSGd+tog2Vi6qGOcHokCdRd6F2fSyF5
	lLYnjiOdOH+z+9sz3iETObgs2E1qxGIXDfgCvtFuujyNwvGqouCSrTvf2z8Z+AseQOtsawK+Gdx
	bTpcvvqeXINf1U89WvHQfS+xk2Ajkpccv2VfHh1UqSRr7pLsyWI=
X-Received: by 2002:a17:903:320e:b0:215:742e:5cff with SMTP id d9443c01a7336-22921f58252mr38676595ad.16.1743157751893;
        Fri, 28 Mar 2025 03:29:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/9+OWQt2tzJ+8IkaPQziFxf8VoAuY+gpALQggWTQ7aiXeiyfL8ffb6i3XDE8ji42HpyiVLQ==
X-Received: by 2002:a17:903:320e:b0:215:742e:5cff with SMTP id d9443c01a7336-22921f58252mr38675985ad.16.1743157751329;
        Fri, 28 Mar 2025 03:29:11 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eee11b7sm14561965ad.86.2025.03.28.03.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 03:29:10 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 28 Mar 2025 15:58:31 +0530
Subject: [PATCH v9 3/5] PCI: dwc: Update pci->num_lanes to maximum
 supported link width
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250328-preset_v6-v9-3-22cfa0490518@oss.qualcomm.com>
References: <20250328-preset_v6-v9-0-22cfa0490518@oss.qualcomm.com>
In-Reply-To: <20250328-preset_v6-v9-0-22cfa0490518@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_mrana@quicinc.com, quic_vbadigan@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743157732; l=2730;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=+5NeY14GAaZjhf9/kf9i4kyV16jVK7K3/ekUtxFah+Q=;
 b=8kWMZulfaiG7eGCAWonbcj+4X20zPIFgg/s0opVxPbR9CUT5jB2an9qsYZhXXiH5Qv34Zb0oN
 p0I6gxSpHwjBgP8nRD7eyV5KHao6nCe8hC2aStQ/HvoMZ1XCYvqBpui
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: yl5MiL9ZVtJvQ9bWV465G_n3-3hheUPO
X-Authority-Analysis: v=2.4 cv=UblRSLSN c=1 sm=1 tr=0 ts=67e679f9 cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=kXhGf0cxdCgfIYue-YsA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: yl5MiL9ZVtJvQ9bWV465G_n3-3hheUPO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_05,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 mlxscore=0 impostorscore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503280071

If the num-lanes property is not present in the devicetree update the
pci->num_lanes with the hardware supported maximum link width using
the newly introduced dw_pcie_link_get_max_link_width() API.

Introduce dw_pcie_link_get_max_link_width() to get the maximum lane
width the hardware supports.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 3 +++
 drivers/pci/controller/dwc/pcie-designware.c      | 8 ++++++++
 drivers/pci/controller/dwc/pcie-designware.h      | 1 +
 3 files changed, 12 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ffaded8f2df7..dd56cc02f4ef 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -504,6 +504,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 
 	dw_pcie_iatu_detect(pci);
 
+	if (pci->num_lanes < 1)
+		pci->num_lanes = dw_pcie_link_get_max_link_width(pci);
+
 	/*
 	 * Allocate the resource for MSG TLP before programming the iATU
 	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 145e7f579072..f39e6f5732a9 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -737,6 +737,14 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
 
 }
 
+int dw_pcie_link_get_max_link_width(struct dw_pcie *pci)
+{
+	u8 cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u32 lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
+
+	return FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap);
+}
+
 static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
 {
 	u32 lnkcap, lwsc, plc;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 501d9ddfea16..61d1fb6b437b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -488,6 +488,7 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
 int dw_pcie_link_up(struct dw_pcie *pci);
 void dw_pcie_upconfig_setup(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
+int dw_pcie_link_get_max_link_width(struct dw_pcie *pci);
 int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 			      const struct dw_pcie_ob_atu_cfg *atu);
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,

-- 
2.34.1


