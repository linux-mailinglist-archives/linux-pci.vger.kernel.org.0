Return-Path: <linux-pci+bounces-34974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28F2B3957C
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 09:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44BC63626E1
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 07:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD193043B3;
	Thu, 28 Aug 2025 07:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E5krZRSO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A54C2D6410
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 07:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366535; cv=none; b=B8hhF7/hOex2VET1nFLQbRoQk8v8ztdaReLxoQk3zjpmLu5lEs9InETR79WPi3johse/ba8VpTZekYCQr5dU5/HMHI+wIEpTsCe7S07qD84S89Y1G0BQ41YbPTwr2VKuPh/LuEAj6J7jAHjKx71vzdGGpiO6Nb8W22EHgEZgHiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366535; c=relaxed/simple;
	bh=RhlPWZq6Ql42bTovAKhXMpPmIjKZlHY5zh7e1V0AKB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gvYBql6xNmPX2STlgl2Gn1rPdDmpK9/3u/mdDzqnNik2yQS1AORMPJ1XiYdhQ6bCTMV+FV0Fbbmqk1iQlf/5GmN7fysFaiNHhLrfbpfKfcgL8x9FsZodAOhLlaKW03pidQmvxPD6UDfs0xKUuWTq4jAd9Oj7CE+AnbTeHLeDBMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E5krZRSO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S33WqF001040
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 07:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i2hv8zySTFskMihifTLDMmKmlG/86gfnPpzETLZ1VDU=; b=E5krZRSOCemZO2SL
	bD4m7JuCKj+g4P++BbzSIk7avgl1EPyfJzCD02K653Sk1EMePTsdMauZEN0KawT7
	LvEkxdj63WgD9cTRUpL8jvwCo+bEjiwKpBJKxM8nAjUw+KqG3th3JJfqEE82XN85
	+4kY8e6ZJOJfce6A7CcE83oh60D/9AOk7O8e9pGsd3JUZQLuBdcPhJxVD8+zOCcl
	rU6EAdfHnbvBDdbhh3jLhhou6x83CpO/iOQSEiVydkc6gEF/BZtEmZEZm+mN3s1t
	m8UR2CN7fUyoodikSJNILVPJkG9tDspj9yMLvePIrTHbfrpx8J9DMgLvpVt94n8H
	9fghAw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48t47bac9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 07:35:32 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-771e331f176so637887b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 00:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366532; x=1756971332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2hv8zySTFskMihifTLDMmKmlG/86gfnPpzETLZ1VDU=;
        b=JXmIImI6woYoPMXrJ17nTqLhrtycFSPa0DPaNtU8fKhxbqgSxFyu9S3QRH57XM85cP
         +FwiyN4cD8S7kHwoCLPKMLz0+LUJy8TgZxUi7HDPpZ952GEXgN+TFeNOnhGgHn0bvaIz
         bsZotcg6B23eP6hbU1kFq4U+lRvq7Z9G6fZgq1hNPbvloHvAM/CKhlIefXpNNA560No/
         bIduDmDFcTnPXNdEOSJaOEB+2CXrTD+IYQNX151qmtvXWZ+N/taQ6EXXygTY82sU3oNk
         16IZ2lsim6r6z9tFXn9pazcxQStLQKwSIKXXpILfKv3TdV/rxmlebvUgCCwMUJpott+d
         d6zw==
X-Forwarded-Encrypted: i=1; AJvYcCWIq//LcJY9tEvqpv4WAV1a1IXzphm2RRs5Rqd/czVZEIcbHddhwYIAYQZ+1ftSha7/XBLbAtjnryk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKB4XyL54xygL11c78g/gG7lML3BDKqYVB34VA8HhnbzDqjBIo
	zPRsxN9eli6kFKsyiAXuBAxHMUDXQHfLvFrxrCU3d03+a2OT4px9mRakddzhSSUVPHUBPaBgk6T
	D8r1wicve0Qy8i4USk3jrsm3nrU3rNZW/SdAmZo7B8jqpbFA7KdzEAVsdko6p9NM=
X-Gm-Gg: ASbGncsx68kfpWvQ/BkdqksoOBmy/V4aPZLPG+bHcGWGKSZkusuFRMIXFDVH1YcSq9Q
	rfx0B6C6E6DMteSB8SkTn78SJHhk9w4JR8B8jRIHF5ul3aMd0bu7CvJAspb8x6zgjC5J5morFmA
	I3N9pXxlXSk/DennPt1gim5zsOwHdoTEIPMJNijNOByiCI9UtMHUgmJSP8Qk9q2xPgBQ8j04zK7
	jw/lQBMUWdkrOO5c/m2GFl0T6fhOeDrY1M3Lql1O5P8KyZ95aBEXHiQkqar02qHfvb4Tz9Qt5oA
	tHRH2rKXDtsfBZRg5ku/ybJjlaT55Dk/thM1iyRw9K+uHEv9RyJ5ze5IAoU7hXT/22wulUNisTw
	=
X-Received: by 2002:a05:6a20:9148:b0:243:af83:6c75 with SMTP id adf61e73a8af0-243af8371abmr1702355637.28.1756366531582;
        Thu, 28 Aug 2025 00:35:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETTLCkOG5SjGj9E9sbiq93kMShGujzEjgOgexU71zwzEtZKGXgxOlHgQ/zYh9bM+s+JD7PIQ==
X-Received: by 2002:a05:6a20:9148:b0:243:af83:6c75 with SMTP id adf61e73a8af0-243af8371abmr1702301637.28.1756366530988;
        Thu, 28 Aug 2025 00:35:30 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4b77dc7614sm9605810a12.8.2025.08.28.00.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:35:30 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 13:04:25 +0530
Subject: [PATCH v8 4/5] PCI: dwc: Add ECAM support with iATU configuration
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-ecam_v4-v8-4-92a30e0fa02d@oss.qualcomm.com>
References: <20250828-ecam_v4-v8-0-92a30e0fa02d@oss.qualcomm.com>
In-Reply-To: <20250828-ecam_v4-v8-0-92a30e0fa02d@oss.qualcomm.com>
To: cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756366503; l=10695;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=RhlPWZq6Ql42bTovAKhXMpPmIjKZlHY5zh7e1V0AKB4=;
 b=dI7n/6t0fzkt/58hBSLjEl7uElcepU6I8uZEY4d9z+6iLh7bsWVsdQnyJEwiSNJhR+f3bL6Yr
 x3YxMlm2FQlCzGltbKH1poDEzd5sKXsyOgbEVgcB/geOPtQE8H4NnfU
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: egZmD0sR4Sjgs15K92PvLO5T7vD8Xdy9
X-Authority-Analysis: v=2.4 cv=CYoI5Krl c=1 sm=1 tr=0 ts=68b006c4 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=hD80L64hAAAA:8
 a=XZV-MPuiRh-Ah259ym0A:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: egZmD0sR4Sjgs15K92PvLO5T7vD8Xdy9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDEyOCBTYWx0ZWRfXylHbxI4ySawU
 JNusvonfQ9fJ+1pGLYyuFkz+KDjfuHNlktv5MOyipVX0w+CKU2WiafC2IM0aO4R6sGbDuAiEuGE
 //ScdoihBBuLRwUERvzcasZp1TF6kk5pu6N9DfWCivioICM9i6l2cuOc28Ohp/F0JUc95olfzIk
 C3Jx55LEfJmo6XG2otfY0B0PvRM3H+nO34gEGYwT2dQ3kWwZIJolp2e8b/Db88cJBfVN9hp91jD
 v26RqhRA9eQGolukGRygtT/O3JoYLBGqx4XWZfAqvYh8cQ/iAAlO1UrbxiVBU+Hj9o13SkL9/qY
 lizhDr5Ee0iDm+PsrcIkftw/fPT/BDPMw3qk9dXoOdm0dOo+PeTbd/GGzCTSu6SFFjvuJMgnMcy
 DaAnJpOB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508270128

The current implementation requires iATU for every configuration
space access which increases latency & cpu utilization.

Designware databook 5.20a, section 3.10.10.3 says about CFG Shift Feature,
which shifts/maps the BDF (bits [31:16] of the third header DWORD, which
would be matched against the Base and Limit addresses) of the incoming
CfgRd0/CfgWr0 down to bits[27:12]of the translated address.

Configuring iATU in config shift feature enables ECAM feature to access the
config space, which avoids iATU configuration for every config access.

Add "ctrl2" into struct dw_pcie_ob_atu_cfg  to enable config shift feature.

As DBI comes under config space, this avoids remapping of DBI space
separately. Instead, it uses the mapped config space address returned from
ECAM initialization. Change the order of dw_pcie_get_resources() execution
to achieve this.

Enable the ECAM feature if the config space size is equal to size required
to represent number of buses in the bus range property.

As per PCIe spec 6, sec 7.2.2 the memory should be aligned to 256MB for
ECAM. The synopsys iATU also uses bits [27:12] to form BDF, so the base
address must be 256MB aligned. Add a check to ensure the configuration
space base address is 256MB aligned before enabling ECAM.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/Kconfig                |   1 +
 drivers/pci/controller/dwc/pcie-designware-host.c | 145 +++++++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.c      |   2 +-
 drivers/pci/controller/dwc/pcie-designware.h      |   5 +
 4 files changed, 138 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index ff6b6d9e18ecfa44273e87931551f9e63fbe3cba..a0e7ad3fb5afec63b0f919732a50147229623186 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -20,6 +20,7 @@ config PCIE_DW_HOST
 	bool
 	select PCIE_DW
 	select IRQ_MSI_LIB
+	select PCI_HOST_COMMON
 
 config PCIE_DW_EP
 	bool
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 952f8594b501254d2b2de5d5e056e16d2aa8d4b7..eda7affcdcb2075d07ba6eeab70e41b6548a4b18 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -8,6 +8,7 @@
  * Author: Jingoo Han <jg1.han@samsung.com>
  */
 
+#include <linux/align.h>
 #include <linux/iopoll.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqchip/irq-msi-lib.h>
@@ -32,6 +33,8 @@ static struct pci_ops dw_child_pcie_ops;
 				     MSI_FLAG_PCI_MSIX			| \
 				     MSI_GENERIC_FLAGS_MASK)
 
+#define IS_256MB_ALIGNED(x) IS_ALIGNED(x, SZ_256M)
+
 static const struct msi_parent_ops dw_pcie_msi_parent_ops = {
 	.required_flags		= DW_PCIE_MSI_FLAGS_REQUIRED,
 	.supported_flags	= DW_PCIE_MSI_FLAGS_SUPPORTED,
@@ -413,6 +416,92 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
 	}
 }
 
+static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = {0};
+	resource_size_t bus_range_max;
+	struct resource_entry *bus;
+	int ret;
+
+	bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
+
+	/*
+	 * Root bus under the host bridge doesn't require any iATU configuration
+	 * as DBI region will be used to access root bus config space.
+	 * Immediate bus under Root Bus, needs type 0 iATU configuration and
+	 * remaining buses need type 1 iATU configuration.
+	 */
+	atu.index = 0;
+	atu.type = PCIE_ATU_TYPE_CFG0;
+	atu.parent_bus_addr = pp->cfg0_base + SZ_1M;
+	/* 1MiB is to cover 1 (bus) * 32 (devices) * 8 (functions) */
+	atu.size = SZ_1M;
+	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
+	ret = dw_pcie_prog_outbound_atu(pci, &atu);
+	if (ret)
+		return ret;
+
+	bus_range_max = resource_size(bus->res);
+
+	if (bus_range_max < 2)
+		return 0;
+
+	/* Configure remaining buses in type 1 iATU configuration */
+	atu.index = 1;
+	atu.type = PCIE_ATU_TYPE_CFG1;
+	atu.parent_bus_addr = pp->cfg0_base + SZ_2M;
+	atu.size = (SZ_1M * bus_range_max) - SZ_2M;
+	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
+
+	return dw_pcie_prog_outbound_atu(pci, &atu);
+}
+
+static int dw_pcie_create_ecam_window(struct dw_pcie_rp *pp, struct resource *res)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct device *dev = pci->dev;
+	struct resource_entry *bus;
+
+	bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
+	if (!bus)
+		return -ENODEV;
+
+	pp->cfg = pci_ecam_create(dev, res, bus->res, &pci_generic_ecam_ops);
+	if (IS_ERR(pp->cfg))
+		return PTR_ERR(pp->cfg);
+
+	pci->dbi_base = pp->cfg->win;
+	pci->dbi_phys_addr = res->start;
+
+	return 0;
+}
+
+static bool dw_pcie_ecam_enabled(struct dw_pcie_rp *pp, struct resource *config_res)
+{
+	struct resource *bus_range;
+	u64 nr_buses;
+
+	/*
+	 * 256MB alignment is required for Enhanced Configuration Address Mapping (ECAM),
+	 * as per PCIe Spec 6, Sec 7.2.2. It ensures proper mapping of memory addresses
+	 * to Bus-Device-Function (BDF) fields in config TLPs.
+	 *
+	 * The synopsys iATU also uses bits [27:12] to form BDF, so the base address must
+	 * be 256MB aligned.
+	 */
+	if (!IS_256MB_ALIGNED(config_res->start))
+		return false;
+
+	bus_range = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS)->res;
+	if (!bus_range)
+		return false;
+
+	nr_buses = resource_size(config_res) >> PCIE_ECAM_BUS_SHIFT;
+
+	return !!(nr_buses >= resource_size(bus_range));
+}
+
 static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -422,10 +511,6 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
 	struct resource *res;
 	int ret;
 
-	ret = dw_pcie_get_resources(pci);
-	if (ret)
-		return ret;
-
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	if (!res) {
 		dev_err(dev, "Missing \"config\" reg space\n");
@@ -435,9 +520,32 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
 	pp->cfg0_size = resource_size(res);
 	pp->cfg0_base = res->start;
 
-	pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
-	if (IS_ERR(pp->va_cfg0_base))
-		return PTR_ERR(pp->va_cfg0_base);
+	pp->ecam_enabled = dw_pcie_ecam_enabled(pp, res);
+	if (pp->ecam_enabled) {
+		ret = dw_pcie_create_ecam_window(pp, res);
+		if (ret)
+			return ret;
+
+		pp->bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
+		pp->bridge->sysdata = pp->cfg;
+		pp->cfg->priv = pp;
+	} else {
+		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
+		if (IS_ERR(pp->va_cfg0_base))
+			return PTR_ERR(pp->va_cfg0_base);
+
+		/* Set default bus ops */
+		pp->bridge->ops = &dw_pcie_ops;
+		pp->bridge->child_ops = &dw_child_pcie_ops;
+		pp->bridge->sysdata = pp;
+	}
+
+	ret = dw_pcie_get_resources(pci);
+	if (ret) {
+		if (pp->cfg)
+			pci_ecam_free(pp->cfg);
+		return ret;
+	}
 
 	/* Get the I/O range from DT */
 	win = resource_list_first_type(&pp->bridge->windows, IORESOURCE_IO);
@@ -476,14 +584,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		return ret;
 
-	/* Set default bus ops */
-	bridge->ops = &dw_pcie_ops;
-	bridge->child_ops = &dw_child_pcie_ops;
-
 	if (pp->ops->init) {
 		ret = pp->ops->init(pp);
 		if (ret)
-			return ret;
+			goto err_free_ecam;
 	}
 
 	if (pci_msi_enabled()) {
@@ -525,6 +629,14 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		goto err_free_msi;
 
+	if (pp->ecam_enabled) {
+		ret = dw_pcie_config_ecam_iatu(pp);
+		if (ret) {
+			dev_err(dev, "Failed to configure iATU in ECAM mode\n");
+			goto err_free_msi;
+		}
+	}
+
 	/*
 	 * Allocate the resource for MSG TLP before programming the iATU
 	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
@@ -560,8 +672,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		/* Ignore errors, the link may come up later */
 		dw_pcie_wait_for_link(pci);
 
-	bridge->sysdata = pp;
-
 	ret = pci_host_probe(bridge);
 	if (ret)
 		goto err_stop_link;
@@ -587,6 +697,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (pp->ops->deinit)
 		pp->ops->deinit(pp);
 
+err_free_ecam:
+	if (pp->cfg)
+		pci_ecam_free(pp->cfg);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_host_init);
@@ -609,6 +723,9 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
 
 	if (pp->ops->deinit)
 		pp->ops->deinit(pp);
+
+	if (pp->cfg)
+		pci_ecam_free(pp->cfg);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_host_deinit);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 4684c671a81bee468f686a83cc992433b38af59d..6826ddb9478d41227fa011018cffa8d2242336a9 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -576,7 +576,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 		val = dw_pcie_enable_ecrc(val);
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
 
-	val = PCIE_ATU_ENABLE;
+	val = PCIE_ATU_ENABLE | atu->ctrl2;
 	if (atu->type == PCIE_ATU_TYPE_MSG) {
 		/* The data-less messages only for now */
 		val |= PCIE_ATU_INHIBIT_PAYLOAD | atu->code;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ceb022506c3191cd8fe580411526e20cc3758fed..f770e160ce7c538e0835e7cf80bae9ed099f906c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -20,6 +20,7 @@
 #include <linux/irq.h>
 #include <linux/msi.h>
 #include <linux/pci.h>
+#include <linux/pci-ecam.h>
 #include <linux/reset.h>
 
 #include <linux/pci-epc.h>
@@ -169,6 +170,7 @@
 #define PCIE_ATU_REGION_CTRL2		0x004
 #define PCIE_ATU_ENABLE			BIT(31)
 #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
+#define PCIE_ATU_CFG_SHIFT_MODE_ENABLE	BIT(28)
 #define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
 #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
 #define PCIE_ATU_LOWER_BASE		0x008
@@ -387,6 +389,7 @@ struct dw_pcie_ob_atu_cfg {
 	u8 func_no;
 	u8 code;
 	u8 routing;
+	u32 ctrl2;
 	u64 parent_bus_addr;
 	u64 pci_addr;
 	u64 size;
@@ -425,6 +428,8 @@ struct dw_pcie_rp {
 	struct resource		*msg_res;
 	bool			use_linkup_irq;
 	struct pci_eq_presets	presets;
+	bool			ecam_enabled;
+	struct pci_config_window *cfg;
 };
 
 struct dw_pcie_ep_ops {

-- 
2.34.1


