Return-Path: <linux-pci+bounces-40676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8C4C45265
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 08:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A19D33469E9
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 07:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52612EB5CE;
	Mon, 10 Nov 2025 06:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PV37QXHp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KAOWAS+F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E8E2EA158
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 06:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757990; cv=none; b=B0yvLefC5HMa2DmnRCp5RvSFRvOFRBK7YjKRDxAqgLtvZ1yLhEmqSgSkR5yvP4y6L72hXl87EFAVXst+Er+Ezz6sz8hhwpkrAqLVPCQdQR9gawzVPwTbsP6poxPQVaTqB9YJDfuDYF/qeVqnfjpxxCMT+Nam64oKnp2VcoxPxug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757990; c=relaxed/simple;
	bh=hqQvTcsdaEoA9+Xh3Z8OKwCXQnyyBaKEZqGjPB6mXCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hy1fI3eEdzRHBvLuPI8GuvaJhFR/eb1lQ9Tgv6M7934AfyFJKRTDQacwAgJE2LECtm1F1EoyG0LZ3CQY9dXM1o5bTBqOIQQ1Sw98ATwkn4GYQA7Xx7in+WQe8fmWaa7MVQu+9ALq5byzuZNJAvwCzfiLZ++ug/kPMWhU16F8bas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PV37QXHp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KAOWAS+F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9KOAah1558322
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 06:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mYziPPcWOcBexeJkEZqaFdvsUz8rXfl8MMCLo92Ben8=; b=PV37QXHp7wM4bj/s
	grYsCL8yLpulimrPKA3ZHLQ5kbX+XRmOrSJx0tqbeXSo1pSuNt12NwlBcCeMiczp
	cnkdWG3jrAc2ThCeuGlgNSVNWyVmqvJqhHU8niuUbOYmzyLmgZWYlFMvt3kT4JBN
	FHHm8GM2Xkl5rBUBCVsz7YGp+VY+EvpW0rK1BSizfADLlfNS7v3cvFeQjaK8IzEB
	FiQFw3MRnBH3Bc1HcJ3dEpCu3yUM+GpkHeWrU9MQY/GsfZJLx5LOQM4VTmD3IVtT
	FKIJwzSdgIDYvHIZHiluTFgAPRA7w4RvFK+AFqqI6awn+peAa5yXPgpPUqTiaJve
	YsHerw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xueknm5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 06:59:47 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b969f3f5bb1so6138449a12.0
        for <linux-pci@vger.kernel.org>; Sun, 09 Nov 2025 22:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762757987; x=1763362787; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mYziPPcWOcBexeJkEZqaFdvsUz8rXfl8MMCLo92Ben8=;
        b=KAOWAS+Fg69+H4J1F9CwNPsjRE6N4WaR2FUFIapuSZzj+c9zd9JT8v4U9RcYLIktF+
         n7qhYgTTWFIZ2KpHHGmCDL7UCvO//98jTGga6ofwT68MwDDlfuooYB6u0UyR3v3xtj50
         SAK74VIYVz6YZNGbRTqzdLJ7B9YcaxBu7T0GwP8TJpyIsKc3eRiXvxx9Md2w/vnNaPGd
         cC1nIT6Uy6xl/+LBK45gAclHOpvIjDxjKJ0VhEZ29u8kJG/1eJaDUqkQ5sRmmtDKr3p1
         raqLJMMMK9NEogStjkbEkW5ftsURFKKXTzKEiy+p/2XJ9JZVdnZuxDdY0qWkAfLXttLG
         DalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762757987; x=1763362787;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mYziPPcWOcBexeJkEZqaFdvsUz8rXfl8MMCLo92Ben8=;
        b=etJ27JloAYwzzqXoH5+vHjwB23RRgm/J5ifH1bJGENmrLQM4884JwCsOG1JYze6LA3
         rs6DYcQIeoT3pVmseYDu/wGh5pammf9LIM+43lk9YLJ/o+Ag+ZUl1MXbI+AiUe25C7Kv
         EfV2d2io4I/4MdAROwULEE+xelpVYd3uoqvc7Gv8wqZEuBwnwc5C9n8g5S8LtlPZ1FOh
         kZNBd1osdJVxZ9fKRjZlkw4SXiOBdkIgF3X8eOuyGT4AXrSUG5yDXzQ1keWeFOSF5VAz
         8+fIQJ8mM8RIBTbdsbJa5Y1mhIfuuYLuz3sAntkyhjnktZ8njyz11RXcREy85SuAynXA
         ESnA==
X-Gm-Message-State: AOJu0Yx9/N90BaYVWcBquHk+jIjvXPmdjbUf+lWRwrl4wDqFB+Ap26ta
	zJgVN97pXaY9AUdJtoSevlJPh3vHen1v/drVkr5TKmevcx0rzscVeJvkVCpoWyqvbeV5kgk9EiO
	QsGAZuuidB2vJFGDokLrNy0o+G/YoBPd/cZ9juyhDrBPBRS6YZihkzTvkHEEhFtg=
X-Gm-Gg: ASbGncuwAsSJRZu8cnAr6VQta3afYyDJM/R6XoMZvNI9dRGI2xapY7dAk7QM2OzKVBZ
	sL0o829p2BmIiKfCu8deR5lQEbmp0ZyYzh56iPkYgqeYbSy3msrHC5HMo3URFBTW5D+qJqwWmPZ
	WcfaI3YCGbnQ6EbnIsDR4nae0VwUdPITQ393EkrJpg6BUfMCusE3H0aRkGnsncZKCtc33UEDnMG
	Pk5jwcmMtJ/z6zzdrNjAKIZ9vBv91/oWNW14FDx08mm63XlyVADeBSy73wOwuguzr33T7o9+4DA
	bIevm6Z9+Plqf6RSD4/Ji39WNUqxN4Cq8klL70zmyB6v/x9/WOyu7KfIDGfj3iAFEBbOCg/AmtA
	ttd8IYUS9/h39jtO08Qf33lvcc2edmhJeCL5jR++KNfcTSA==
X-Received: by 2002:a05:6a20:7493:b0:340:e2dc:95ae with SMTP id adf61e73a8af0-353a3c5a177mr9628301637.42.1762757986893;
        Sun, 09 Nov 2025 22:59:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3z0Nf+Q3hsU4EESDEEfUFc+DFDUPQpL2ymkKD+yZf8xXnCnqsksN0b/+02pqZtLCAHdVbgA==
X-Received: by 2002:a05:6a20:7493:b0:340:e2dc:95ae with SMTP id adf61e73a8af0-353a3c5a177mr9628273637.42.1762757986337;
        Sun, 09 Nov 2025 22:59:46 -0800 (PST)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9c09f22sm10565900b3a.20.2025.11.09.22.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 22:59:46 -0800 (PST)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Sun, 09 Nov 2025 22:59:42 -0800
Subject: [PATCH 3/5] PCI: dwc: Remove MSI/MSIX capability if iMSI-RX is
 used as MSI controller
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-remove_cap-v1-3-2208f46f4dc2@oss.qualcomm.com>
References: <20251109-remove_cap-v1-0-2208f46f4dc2@oss.qualcomm.com>
In-Reply-To: <20251109-remove_cap-v1-0-2208f46f4dc2@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762757982; l=2379;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=hqQvTcsdaEoA9+Xh3Z8OKwCXQnyyBaKEZqGjPB6mXCc=;
 b=a9TNQphv0olEWd4VZeZicZIvivZzIDMYwEDpaxxIOnLRVfiJaisq6pzmb71V78utdnylUOr5k
 l1B9B2hAcppCFWYavnsq836rkyolkarAOQc99T9xPK87VlrsLQifiEs
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA1OSBTYWx0ZWRfXymzfKS7LuFjd
 zox2w95xfY9FFrfLRTl7CY0Fh5WaDvehoRYUGHcXwpMX7on3DjDWg4XG2vsj2SoudYvWKp5bOK2
 lHzc1k7So+3/XYPoWVYQ6iOj9ei3AtTw/IF9pOcRdJ9+PxXI2sOxLs3S51Nk9fAM0hO/iyEFvzs
 HcM+t28C58fWgiKrM1nJRbli/b6xq8QQ4Y8ZpPAEP60oGfanwNR+OM7RDYPgh3EXVsqoWgjlmWV
 dr+GDot/vku3ZxSnyX11L0p0KM7CZ3bvLfTwfvMm0BFYEObL2OLjnhnaL72XkRpG/QGCQ7HXlfP
 6tO9ag/hEOHxKnuCL6Ia/735z3XUq8YSYqn6pQXnINNnHyi+FlAg0mRg7RgpNdlwXYoIXpaO1UP
 7VNOPpbWANGhvFgegf8xDWwF+FKvrw==
X-Proofpoint-GUID: HlFgGDXq9WVAjveMf73-aeACdkfbBAp4
X-Proofpoint-ORIG-GUID: HlFgGDXq9WVAjveMf73-aeACdkfbBAp4
X-Authority-Analysis: v=2.4 cv=BOK+bVQG c=1 sm=1 tr=0 ts=69118d63 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=q7mzEFEhQNumAzJHHS8A:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100059

Some platforms may not support ITS (Interrupt Translation Service) and
MBI (Message Based Interrupt), or there are not enough available empty SPI
lines for MBI, in which case the msi-map and msi-parent property will not
be provided in device tree node. For those cases, the DWC PCIe driver
defaults to using the iMSI-RX module as MSI controller. However, due to
DWC IP design, iMSI-RX cannot generate MSI interrupts for Root Ports even
when MSI is properly configured and supported as iMSI-RX will only monitor
and intercept incoming MSI TLPs from PCIe link, but the memory write
generated by Root Port are internal system bus transactions instead of
PCIe TLPs, so they are ignored.

This leads to interrupts such as PME, AER from the Root Port not received
on the host and the users have to resort to workarounds such as passing
"pcie_pme=nomsi" cmdline parameter.

To ensure reliable interrupt handling, remove MSI and MSI-X capabilities
from Root Ports when using iMSI-RX as MSI controller, which is indicated
by has_msi_ctrl == true. This forces a fallback to INTx interrupts,
eliminating the need for manual kernel command line workarounds.

With this behavior:
- Platforms with ITS/MBI support use ITS/MBI MSI for interrupts from all
  components.
- Platforms without ITS/MBI support fall back to INTx for Root Ports and
  use iMSI-RX for other PCI devices.

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 20c9333bcb1c4812e2fd96047a49944574df1e6f..3724aa7f9b356bfba33a6515e2c62a3170aef1e9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1083,6 +1083,16 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 
 	dw_pcie_dbi_ro_wr_dis(pci);
 
+	/*
+	 * If iMSI-RX module is used as the MSI controller, remove MSI and
+	 * MSI-X capabilities from PCIe Root Ports to ensure fallback to INTx
+	 * interrupt handling.
+	 */
+	if (pp->has_msi_ctrl) {
+		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSI);
+		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSIX);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);

-- 
2.34.1


