Return-Path: <linux-pci+bounces-38457-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BF6BE86F4
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 13:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 11B714F74E9
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 11:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB03332ED0;
	Fri, 17 Oct 2025 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lsmam6MI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABE8332EDC
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760701268; cv=none; b=nhVjZmXoS4bXPKc2ILjexPN2eiYHfjtORo2uFDWDhGL19kHn0g5img3HHdV6bQRm/Tw1v5MB/xz2up7U7a69B/hwGu4Qtpd09NmtHhY8/yE9Oh/oQiUMg16q9DUq+lJM4qncYroYLbFmMBXyEc1+P6Hulx+nfNw+2VBwfp5qjBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760701268; c=relaxed/simple;
	bh=SYQnOLzoc/XQlIR6zJugeR+7h1RDTEhIgsyWh1ZHDpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pwdeTg92ozABcZDuYBlHuuw7kvpKa4MvcocViH+GbdrP7bBApCCSAtKd7/KFlNl1Mo4OEr1va27vcQSCSz0tEHULNFpUerrCT2/aEMLlNypZqT7l50qy645JLcdMXwv1H2dwwb9HwGfTm+VtLokHnMvLHuakWq110AotN6XTzXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lsmam6MI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H84irb001700
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 11:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BVVLiDkYNXzDn9k+peiV6qbonML0XVUZrJ/W3exuaFs=; b=Lsmam6MISayC59Bq
	7wvRDLxV43rQKidoPOJqd1YVuI4IvUIZfSaSxqODoJQIf3P1eK6miFVmfBhuOdMS
	Yi05h9S4ctd+gADvjdEidF0mGfP6ncJCQsJEtxBfBept764LeUFwh0eM8KGrJK9o
	2TPCfV/ybMYLzu2IdELA8Oos/wcYJEHfjjACREdXu41vwx7CGY4Kiai3DhCKABYk
	Vr4PemiZj2VZfRjRhh4yBogo+NiSzqRU5N/APL/k2P4+6vGaavy85tECtzNCkFjI
	cC5XA56N1JXS7JQWGdhUclZuK4ktRlqInF8LJwlrlVQArz3XPP8Inxf3r+Wi98lk
	VOVijg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd9c4a2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 11:41:05 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-269880a7bd9so23499265ad.3
        for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 04:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760701265; x=1761306065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVVLiDkYNXzDn9k+peiV6qbonML0XVUZrJ/W3exuaFs=;
        b=jroxPU8PB7pQdDcQmUzBIgnEjoYEXROWCry9zSq1FgyqDPGrTxPFp4wYjqB7YBheRS
         144WlBZLTtTAUMc/j590sP9bPbWucyHOTjo+u0RrDptjOSFa/nJ45cGKeGJpuvBl39yb
         amZ0k2DOSsHhzkLc9pQoH5xK5jf9sgATtVaykZWBfWB8vln5pNK1ifmjeMJABC3UXnkE
         mNO35t1Qb4Yhr7Qnz2bfnMBXp1BoE5dNU80gCldbItfV+8HvHGCTt/5mL3FMXPTjwjWt
         CKFU0IaZB+8YoRhr0ozRiqnEIsgK4SfojKLo6llqNU9qlI4D09BbV0YoVSFMEc3yuEJY
         ZsWw==
X-Gm-Message-State: AOJu0YzztmdbvSHMoq6kB7g5P/tkSmBlZYNxNgKK91hyGuWWYNz83kpL
	dLnF6EUDMG6f13FVLMqLRNT2ulwxInN4LswUfp+Ygzrra2lT5pPwjPTrPUPY66xO+7rX2kekCPe
	5PtJs5JL2qZbtXACoZhRHoOGlgB9QsydPG8e+LnVqbcpbjJVKODirmiers3TEZec=
X-Gm-Gg: ASbGncukCMFnSCtf1dU5hCeuSKawRebnyyrAXb8yskAqxshIpHArV52Nzzg6sGhRtWa
	/bsROnkPMF3YmjuvjzvTeJVV8RrhSLsA/GY692zNTMk2lUqJ1WPPshiA7hmkrnomhKZIszJUizG
	euT3IERRWTxwkHZ50K5uEQNdKkPLBOZSib7y5hQRLXr+AMcPRMD8BRsCA4zaILy6NK0FmAS1w+Y
	/M4wCBDIoSeZwwIluuaorGvV4Qcov87o1z/vAEmy6kHdIf/C+ACWZGmjLtoMpMbFn6jr4KyZUde
	C4JTe1Gb75w7gZCHVJH3ZH1eHHKS/+8ckjz5frpslcGHhMoysGAHvue4WdLGEpJq50ZjuRt+hfw
	4nAGSC9LOUv+XMc4kJgN8bP6cr8z1RIpjBQ==
X-Received: by 2002:a17:902:d60d:b0:28e:acf2:a782 with SMTP id d9443c01a7336-290cba4edf7mr41580265ad.37.1760701265089;
        Fri, 17 Oct 2025 04:41:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1ijODrnEfO8x6cQ5RXjEcoMcy8dr8bkmS1kfEONZv1VUVtXJCoUGK0vbnLyqd6PrGLg4p3g==
X-Received: by 2002:a17:902:d60d:b0:28e:acf2:a782 with SMTP id d9443c01a7336-290cba4edf7mr41579885ad.37.1760701264569;
        Fri, 17 Oct 2025 04:41:04 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7de45sm61489675ad.54.2025.10.17.04.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 04:41:04 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 17:10:53 +0530
Subject: [PATCH 1/2] PCI: dwc: Fix ECAM enablement when used with vendor
 drivers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-ecam_fix-v1-1-f6faa3d0edf3@oss.qualcomm.com>
References: <20251017-ecam_fix-v1-0-f6faa3d0edf3@oss.qualcomm.com>
In-Reply-To: <20251017-ecam_fix-v1-0-f6faa3d0edf3@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Ron Economos <re@w6rz.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760701257; l=3169;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=SYQnOLzoc/XQlIR6zJugeR+7h1RDTEhIgsyWh1ZHDpU=;
 b=StbwIRrfzZ1eRAU+lCV0Pa3Kriw8R0MnjcDC+5okRn9gN8BsHhx8yTQp0XQb5/VnZnpHKbDba
 meSn/O+a7EOBaI7jmwK0jsR2dDvyblaGiYdR/N50BRaxGnIqTyRvO3p
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: zRydkiQYIWQnNajJARVX7jxKcePj9Kkh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX9bfDHgu8CKwO
 udn6I8OcrFOGAJwn1AqIYcwLCVdgeyOzlcldINDuIYZWBBjVSdIqHlIrqdjEsJMNcTU2XoA2zdo
 tU6ZKiNt8eLaGo/BDrlPM4SxT5zSKmNR/7sHeo104GHoPBTe/hAB6KWRa1TJk4lcN6HGud/Qjx3
 UQ0OL3ruku8Yqf9aqMUWFAfWsyu7oaoQuPKa4Ji7AtiPqTp9jaJmilgYHIjXwHraTM8ug2pewHK
 EtqPRig4ooTKFxjYrlIIEmDM6iXGVHDrCwSeeX1GYC6exuUuBii8O3iVIaGWI012nio1BbC2wNQ
 g1ODfR90i57BhGR6ToHIDKzx/BFwUgiAEIOLJ5Mq3pDIywWm7AQ4dTiIZOrWPiuMGnAiyHnIDA2
 4uZmLqqd5KBWZaOmvBT6ScG20CYknw==
X-Proofpoint-GUID: zRydkiQYIWQnNajJARVX7jxKcePj9Kkh
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68f22b52 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=HaFmDPmJAAAA:8 a=EUspDBNiAAAA:8 a=h4B-02p0z56_JbXvspoA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=nmWuMzfKamIsx3l42hEX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

When the vendor configuration space is 256MB aligned, the DesignWare
PCIe host driver enables ECAM access and sets the DBI base to the start
of the config space. This causes vendor drivers to incorrectly program
iATU regions, as they rely on the DBI address for internal accesses.

To fix this, avoid overwriting the DBI base when ECAM is enabled.
Instead, introduce a custom ECAM PCI ops implementation that accesses
the DBI region directly for bus 0 and uses ECAM for other buses.

Fixes: f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling ECAM mechanism using iATU 'CFG Shift Feature'")
Reported-by: Ron Economos <re@w6rz.net>
Closes: https://lore.kernel.org/all/eac81c57-1164-4d74-a1b4-6f353c577731@w6rz.net/
Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 28 +++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 20c9333bcb1c4812e2fd96047a49944574df1e6f..e92513c5bda51bde3a7157033ddbd73afa370d78 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -23,6 +23,7 @@
 #include "pcie-designware.h"
 
 static struct pci_ops dw_pcie_ops;
+static struct pci_ops dw_pcie_ecam_ops;
 static struct pci_ops dw_child_pcie_ops;
 
 #define DW_PCIE_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS		| \
@@ -471,9 +472,6 @@ static int dw_pcie_create_ecam_window(struct dw_pcie_rp *pp, struct resource *re
 	if (IS_ERR(pp->cfg))
 		return PTR_ERR(pp->cfg);
 
-	pci->dbi_base = pp->cfg->win;
-	pci->dbi_phys_addr = res->start;
-
 	return 0;
 }
 
@@ -529,7 +527,7 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
 		if (ret)
 			return ret;
 
-		pp->bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
+		pp->bridge->ops = &dw_pcie_ecam_ops;
 		pp->bridge->sysdata = pp->cfg;
 		pp->cfg->priv = pp;
 	} else {
@@ -842,12 +840,34 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
 }
 EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
 
+static void __iomem *dw_pcie_ecam_conf_map_bus(struct pci_bus *bus, unsigned int devfn, int where)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	struct dw_pcie_rp *pp = cfg->priv;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	unsigned int busn = bus->number;
+
+	if (busn > 0)
+		return pci_ecam_map_bus(bus, devfn, where);
+
+	if (PCI_SLOT(devfn) > 0)
+		return NULL;
+
+	return pci->dbi_base + where;
+}
+
 static struct pci_ops dw_pcie_ops = {
 	.map_bus = dw_pcie_own_conf_map_bus,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
 };
 
+static struct pci_ops dw_pcie_ecam_ops = {
+	.map_bus = dw_pcie_ecam_conf_map_bus,
+	.read = pci_generic_config_read,
+	.write = pci_generic_config_write,
+};
+
 static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);

-- 
2.34.1


