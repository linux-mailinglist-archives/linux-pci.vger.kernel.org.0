Return-Path: <linux-pci+bounces-44018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F52CF3876
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 13:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93E42307156A
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 12:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA0C33B979;
	Mon,  5 Jan 2026 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eBI69wSI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PRJTWqlV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C15433B94A
	for <linux-pci@vger.kernel.org>; Mon,  5 Jan 2026 12:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767616104; cv=none; b=CYCcO4Dywam1JbjNXutD55gLXWA/E+VX6iBRe2MdTUevCq8bJfN3F3dfPIhvcrZK4BKgcjtO1I6T01DvPvPNFbtgXhUmFAlTMtj4JkQ03AcJHCVj04hp+y7pnsZ5ImRIwxXLcftMAm548Fs9lKQU774JOKUMy9G92rcYIcgKXCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767616104; c=relaxed/simple;
	bh=PpB/m1gJTMQMTX0vFxuSFv/chuv/UflEufPn0M3zptk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BMd/dOhzcZLZeRdKNwHArLbmG2P+bYFpCMkbOGG8KgmHg5yqrotb7cYQ4Uu6gQb2tquMPhposgfbqIm4ZjVbbt31+UN7A+TxGp6PpA1s7sa65bLU39QorP6U3KV1qv2c8Ws6o1pcFAm4ctZdRNDuxJ8VmGX63pWP3R8Sy4dgiWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eBI69wSI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PRJTWqlV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 605BdQpl3520974
	for <linux-pci@vger.kernel.org>; Mon, 5 Jan 2026 12:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CBFYHO0C6Kk6N+QrFXXXFlcKOp9qo98Yeql0J+xKQe0=; b=eBI69wSI/osXsl7O
	qRyjkGuMysg9O8lz8xtVuXcwubY6v2F+C0GRWT/5z+rQWNGoubCdc5CbZO5V3A78
	oJY2G9setfBVLvNV0mif9MQoSJohxQ5sKNax5Vc0kTxtLL0IM+/ASxpaw35NtVSI
	WcDZA9xEQDSjgTiGZTQvxB+/JEeLykLrybV/mJzd7XHo4MHsJ8dh421HL6uJmSy0
	uYSi9CQT4XiUJV+8MGK5sPAXV9pONYMVWIYC81S8NQVLBBVrDFSUYe4NSsJCCOwz
	nbMe2tWAePT4ihOqcDDRF2C2dOGKL8LV4EEKEMxbd6eazd9rQpJvwjHXrArs5kx5
	hvuG7g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bg6uu983p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 05 Jan 2026 12:28:20 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0f4822f77so378886465ad.2
        for <linux-pci@vger.kernel.org>; Mon, 05 Jan 2026 04:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767616100; x=1768220900; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CBFYHO0C6Kk6N+QrFXXXFlcKOp9qo98Yeql0J+xKQe0=;
        b=PRJTWqlVtNJgJ/q7pBcCa/zsrzitL5lqmfTeYXA/4GsJiMVQNKufzwTFv7ncdBhziN
         AdDj6EqrsZTGvm7CaaYXiTKceT8/4bOip1KELvzZ1D6pM3YYlqXEowaW710ZnOKzcdSP
         n1KHlhxhfsREARQDBuRQARhKiDqqQdRKhbkm7LXbRrG/4SWJwp1dweLLa8G8eLY9BVgn
         DblgP3ON3wo95GxzsFJueRMirHnTGYWiCdaJmcWql23G8V1Mq5LlTbdF5xJdaKPZoD5/
         MiqmbKPEd3bvcbYIvMI1m4Ue8oEAscccaaem2HjqdvHv8BrDn/hhE6eAW3mwD0tVzLiU
         oa9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767616100; x=1768220900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CBFYHO0C6Kk6N+QrFXXXFlcKOp9qo98Yeql0J+xKQe0=;
        b=FXr0RlCAO0wAuOq5nLo0zzwIOlHv1QATDubWIu9TMmf02OY1IK5FvKA6ODk7DgUph5
         ldBcrpjcdULexJyEknNR31Xwdv1ZQharCuktT41VyF3/yAtpeEB0ygM4itO8Pt1I5ApX
         QbWaAK6ZfOcWInzDAaZyHb5I1k8AsdVQ+dYenzSSWwyG4hFcInEJWHhl0xLYKA3q0Rde
         ZZ6dGQzRDDSnrmV2PUxbKOuMsdQCxvsDDCQHYowSx8uGVO2ujGHB/8x6FSFR3Ng0hDbV
         ifm3/Y4mRWuENr2uirQV6zVqfvBj6fC3XhjenJ/T4PGmwNskwlF/mjwRrafG0+Pz14vJ
         M7Cw==
X-Gm-Message-State: AOJu0YzMQb+sB9GA4rQyEbHiv13Rms1tUCcI+FyUxYW5PaHR5aBkOXEH
	d72h1+EIiflPgn6geRCM8fwOeAlhLxNv/QVPwa5tXUrsPV66yfwTZfj58O/7FOj96BybQ2Rg3YY
	82gGtCOApoOnK+XFpDnxBX37zzXq0qRjAny7/PO2m9ysmaugQ2hcwJ36N7fFg1UU=
X-Gm-Gg: AY/fxX7rx8C0Eopvm1nB0EYe43ZVkBZ+ur2pWveW3C+YYCCyyaJZ31nNJwAc9ybsFpg
	LWAgGEmnKkg9rGq0fgJJUW7lJfy5I5brAvZupSh+sePjJNIa/MkIDCm5bMfCwftgu77zIqWchdg
	yesdMWVhvcghaA1DeMJEZBZDrQhKo+6ej3cMG7gzrRaSMue4j+eqpro9bSKPbT1QRB8ZQe+8CdZ
	kgEK0wjvYtwfrvuMpWZ8fCkmgaoNYTptfM2Cu3tU6MPx4t0dJmrdgsjeia78v4bPtiM75FLYZYg
	MRRh4jKzLV27RAnFM+H9ix94s7Hk/h07T9yOg5KLAUkUhqqemJRZrmI40mJbCR6gIU1kIUNcFpZ
	wnCa1AQIyPnKZozi0w+zlT1fS5aFDiFastYU=
X-Received: by 2002:a17:903:2f82:b0:2a2:f2e6:cc54 with SMTP id d9443c01a7336-2a2f2e6cc7bmr512249615ad.4.1767616099598;
        Mon, 05 Jan 2026 04:28:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0UKyUvXerMX21bnjBAhF6AG6XXCayaIe7tQngiVFg2WkvJ67HwAbgKGU99xM74jozlgyeNA==
X-Received: by 2002:a17:903:2f82:b0:2a2:f2e6:cc54 with SMTP id d9443c01a7336-2a2f2e6cc7bmr512249235ad.4.1767616098933;
        Mon, 05 Jan 2026 04:28:18 -0800 (PST)
Received: from hu-sumk-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c82a10sm448109275ad.26.2026.01.05.04.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:28:18 -0800 (PST)
From: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
Date: Mon, 05 Jan 2026 17:57:54 +0530
Subject: [PATCH 1/2] PCI: API changes for multi-port controller support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-dt-parser-v1-1-b11c63cb5e2c@oss.qualcomm.com>
References: <20260105-dt-parser-v1-0-b11c63cb5e2c@oss.qualcomm.com>
In-Reply-To: <20260105-dt-parser-v1-0-b11c63cb5e2c@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Yue Wang <yue.wang@Amlogic.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        Chuanhua Lei <lchuanhua@maxlinear.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Sumit Kumar <sumit.kumar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767616078; l=3103;
 i=sumit.kumar@oss.qualcomm.com; s=20250409; h=from:subject:message-id;
 bh=PpB/m1gJTMQMTX0vFxuSFv/chuv/UflEufPn0M3zptk=;
 b=GZFtZaD7jCyIpCFrp+hdjsax21pknJcBxL8vAxnhFDnfZj47lMwrBRAT21E3qZGvMjJkEW8ux
 BqW2LAmuAn6Bin1Gz5N2VInqCcnD4NPJG2jM/9hN2ngl6jFso9HAv9x
X-Developer-Key: i=sumit.kumar@oss.qualcomm.com; a=ed25519;
 pk=3cys6srXqLACgA68n7n7KjDeM9JiMK1w6VxzMxr0dnM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDEwOSBTYWx0ZWRfXwU5btcD0E45h
 CMKIRHnwFVxyGnE0TnNSBGiMMjLaxseZoBpEeRmg3j2OC4KYwVT6xlL0ZTNh6p19heEBuIbFLhb
 2afW9zKap375giKZKotUB/Qc0x/dT5pqkhm788Q/GFglXsHfzOHQqvguLBZ5pgr48G2yTiKlKyG
 w7qxRDrHhHJCYVawiDy7v6Cr6mIJ9gsNv1mwJsL6dOZnJu67K4W4qsPY1cnMiawG96TQoxRzTcR
 bxvtyuVjp9zV7r36RvaZfDa+E91aLRW23roqYsn0727xqliJuqob6TnnwvEVUsPfjwsg2so52hh
 mmNd4h2v5VLUMAYkzimT9gSKNclPRoWFBCdY1lCg8ERONL6w5CoGDIWBXT+zMOuGfoANEvUwkmk
 xLAPIw6pQIlOTxccnm2Ai7x+2AlE7yNkXVQwxcEc38YdCwTUFlZUNqtrLFcqBj+OnN2ux92uHus
 aKeUxzOiAHlpCnOHWwA==
X-Authority-Analysis: v=2.4 cv=eZ8wvrEH c=1 sm=1 tr=0 ts=695bae64 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=ujblt7VnwxmsJrSXvRcA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: B31ZgK6BLnt1Gq8K5qGtkUW7JzAMAck4
X-Proofpoint-ORIG-GUID: B31ZgK6BLnt1Gq8K5qGtkUW7JzAMAck4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1011 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050109

For multi-port controllers, equalization preset properties should be
specified in individual root port nodes rather than the controller node,
allowing each port to have its own configuration.

Change of_pci_get_equalization_presets() to accept a device_node pointer.
This allows parsing equalization presets from any device tree node,
which is needed for multi-port PCIe controllers.

Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
---
 drivers/pci/of.c  | 6 ++++--
 drivers/pci/pci.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3579265f119845637e163d9051437c89662762f8..d09eff40b523c920c9ca3eaa64f784765b3c5bf8 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -971,6 +971,7 @@ EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
  * of_pci_get_equalization_presets - Parses the "eq-presets-Ngts" property.
  *
  * @dev: Device containing the properties.
+ * @node: Device tree node containing the properties.
  * @presets: Pointer to store the parsed data.
  * @num_lanes: Maximum number of lanes supported.
  *
@@ -981,6 +982,7 @@ EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
  * errno otherwise.
  */
 int of_pci_get_equalization_presets(struct device *dev,
+				    struct device_node *node,
 				    struct pci_eq_presets *presets,
 				    int num_lanes)
 {
@@ -988,7 +990,7 @@ int of_pci_get_equalization_presets(struct device *dev,
 	int ret;
 
 	presets->eq_presets_8gts[0] = PCI_EQ_RESV;
-	ret = of_property_read_u16_array(dev->of_node, "eq-presets-8gts",
+	ret = of_property_read_u16_array(node, "eq-presets-8gts",
 					 presets->eq_presets_8gts, num_lanes);
 	if (ret && ret != -EINVAL) {
 		dev_err(dev, "Error reading eq-presets-8gts: %d\n", ret);
@@ -998,7 +1000,7 @@ int of_pci_get_equalization_presets(struct device *dev,
 	for (int i = 0; i < EQ_PRESET_TYPE_MAX - 1; i++) {
 		presets->eq_presets_Ngts[i][0] = PCI_EQ_RESV;
 		snprintf(name, sizeof(name), "eq-presets-%dgts", 8 << (i + 1));
-		ret = of_property_read_u8_array(dev->of_node, name,
+		ret = of_property_read_u8_array(node, name,
 						presets->eq_presets_Ngts[i],
 						num_lanes);
 		if (ret && ret != -EINVAL) {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 34f65d69662e9f61f0c489ec58de2ce17d21c0c6..72fa6db95b8a75f6e69b8019d1eb2262b6a46c13 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -965,6 +965,7 @@ void pci_release_bus_of_node(struct pci_bus *bus);
 int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge);
 bool of_pci_supply_present(struct device_node *np);
 int of_pci_get_equalization_presets(struct device *dev,
+				    struct device_node *node,
 				    struct pci_eq_presets *presets,
 				    int num_lanes);
 #else
@@ -1013,6 +1014,7 @@ static inline bool of_pci_supply_present(struct device_node *np)
 }
 
 static inline int of_pci_get_equalization_presets(struct device *dev,
+						  struct device_node *node,
 						  struct pci_eq_presets *presets,
 						  int num_lanes)
 {

-- 
2.34.1


