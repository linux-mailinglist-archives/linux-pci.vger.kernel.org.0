Return-Path: <linux-pci+bounces-25704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54552A86A45
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 03:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE001888FF8
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 01:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6AF18C92F;
	Sat, 12 Apr 2025 01:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FZkk7pN9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB31189F3F
	for <linux-pci@vger.kernel.org>; Sat, 12 Apr 2025 01:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744422655; cv=none; b=gl1YfM2ur6U8S0gFTkqN4T3FhbFt5N4+VKPVw30sJvoXZNmQXPCJ55cN0kZx5/QtXH75eprYCXv6atPIjW8/4ablAb7ucCAXvMXIveTFL7Hx2WC/i0JTs2CeO9XmSzx2slBrKlYz5QHlG6SNeOTBNJpnbn7VHwqF0JnnyCV7srM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744422655; c=relaxed/simple;
	bh=kCAWt0BML5WV1SVIGZYgFbzaKmu2Qzj+fUlzFOOF8M8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ph9+oKS+Dsy7I7XfYVSmHb1p/ztIQB9ZxFmU749eBuutI53GS73kUPE5rCZIgLfT10Dc64JlBtpoYkw8CJXpKeKzd/XXv4JfBAXotwJ+/ELJzfMPAxuMa3UvfgwKUsSVjL78Hvtdijy45v0Df6JsASH6LIaMvbLRWF5QjShzZZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FZkk7pN9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BGIOHh000337
	for <linux-pci@vger.kernel.org>; Sat, 12 Apr 2025 01:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	glgoRiyhxfL/Te3esQieLchBRxrL4qfaUkWRNwVRA10=; b=FZkk7pN93BW3EIgm
	37mg24I3RKY/aSvBEwzSAbbx96OPgJ0dlbM9faIbLKwdlqr39KXpWp34tdtl0S/q
	iQjArEGH65vZ5J7W1x0HBiNCO9C0nt/ARa+WfJDgdmN/hMB/2S46oniDyKoPupBB
	vc52mSQt4SHfLcipXPF3OPZ4FWVXkQ5mpZ005ceuGRo9diOcYm4a8MpHsaY+3eio
	HTnfixA7Vxlpvo5mY5iT4D3BJZa7ipZNQGopAkCVxV+WrSt3P+hTMh5+d/jRWEao
	1OLmSi6wKNpVxZkljnlXm7t9CLmcp5qpopFpzjQoNBCDL9oRTRte/sTR2Vdr88X/
	qwq+kw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twfkuutt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 12 Apr 2025 01:50:51 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-736b5f9279cso2219806b3a.2
        for <linux-pci@vger.kernel.org>; Fri, 11 Apr 2025 18:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744422642; x=1745027442;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glgoRiyhxfL/Te3esQieLchBRxrL4qfaUkWRNwVRA10=;
        b=G+ZFZO/P2cYIf8zSycQij0Pk44dSi43OmfDus7quFjdpeykEHTHQZB/NWQSsOgGJ12
         NutnNVXKm0oupLAyhsHxztQ9baurTTan40XmOwDXxJv4EWgqFCoMsoTP4wErQo24e1I8
         DlIT8FkNXEXIf9Ba81HruJ0T0lAeWxnEuibLlnXFtJa2UjLXcjzPv9Gyatgt+7BfM4EP
         uKZx85drCQmzR8x/4gLF/PyiqUR+3eIEbNK2r/qnymFpxoZBqyO8pR6bjCsclyYePz39
         HccUIok3dEJ4nbg5q2g1CqhtJIGoXSVDt3v96FG/l1PwDTMEpRYMljxOfGrn/ODo8Cvc
         ayTA==
X-Forwarded-Encrypted: i=1; AJvYcCUkk0EmR02qzZAP3kc4VCoGq8wiXr/ugS0XN2Lg8ZoJHqBuz39U2iXhx9XXFK3r50oLFu0MuJU3hYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwDL/j2KyPihFMTfnJs+PPSTa16dyG+7vge2rdh/lxp556MzVA
	dg8wMo3lx3yI4AhWl+ZG8eJ5Haz8OEuDm+BVXn+mpSemYxvz5S+duK+Ja53Cx+g/ZEhJ/JMS32A
	DvUpphSwJ4X/Fc0k2UKIA28KVLZYpIUBbXkmCGR0VjmrZ4ACiMaSqqtmWWZc=
X-Gm-Gg: ASbGncsdIgl8SNhsSmogq9OWTFPnkZtF+kRzGtQu7iMDaFyfxH0+uSvWjPY56vSCyBA
	3biaeF0eq0xB/CuoVDADOaIlVOEs4Dbb3iL5dEeIjYr8G3uvRdC5ZtRdE1o0V/+nP6udEVkfua/
	So95I0xKBX4LTvPP6hzqvhF1UmPzdFJlYeAIG01rhkgmm3LRNA9KAkBH+PEgl2uoYdi8Ipx+7gx
	lzOdYgnEwkcRAJsq5ZtKWcx2C2CZKUrdxqqWBq9HlanHKVXMy1QIrJJPPjUZm91ypv+FymdkMzE
	2Z/wPS8lLZGUuo3p1pOKKBmi4O/gXWY3Cjkp7z4Y8OO88RE=
X-Received: by 2002:a05:6a20:d48c:b0:1f3:397d:86f1 with SMTP id adf61e73a8af0-201797a30bbmr7051250637.16.1744422642218;
        Fri, 11 Apr 2025 18:50:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzJLmehtyGqwCwy4UtxG9p6ZLMjrO+dqexw4oYkH8h2BtyHuukt/AlHGG0NKBbbxBgfg3hTQ==
X-Received: by 2002:a05:6a20:d48c:b0:1f3:397d:86f1 with SMTP id adf61e73a8af0-201797a30bbmr7051219637.16.1744422641747;
        Fri, 11 Apr 2025 18:50:41 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a3221832sm5516825a12.70.2025.04.11.18.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 18:50:40 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 12 Apr 2025 07:19:54 +0530
Subject: [PATCH v5 5/9] PCI: dwc: Implement .start_link(), .stop_link()
 hooks
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250412-qps615_v4_1-v5-5-5b6a06132fec@oss.qualcomm.com>
References: <20250412-qps615_v4_1-v5-0-5b6a06132fec@oss.qualcomm.com>
In-Reply-To: <20250412-qps615_v4_1-v5-0-5b6a06132fec@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: quic_vbadigan@quicnic.com, amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744422605; l=1453;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=kCAWt0BML5WV1SVIGZYgFbzaKmu2Qzj+fUlzFOOF8M8=;
 b=/+uFXCTf1bqF5t6g/+9yhijvRHjpSMx1KHn4h1Hyg+gKRxf6WiynmaXFgOw4lt68wVeracKnT
 F8+++3bUJvKCoASKv6Opu7cM/nrJ4KF+DzDmGGCMBoj2NCcgWjcWd4G
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: T3HEzXaG1AJ6N-5dK_sy32-4pSLUHLap
X-Proofpoint-ORIG-GUID: T3HEzXaG1AJ6N-5dK_sy32-4pSLUHLap
X-Authority-Analysis: v=2.4 cv=b7Oy4sGx c=1 sm=1 tr=0 ts=67f9c6fb cx=c_pps a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=4bBsNf6MAaYI6lVPmewA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-12_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 mlxlogscore=828 bulkscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504120012

Implement stop_link() and  start_link() function op for dwc drivers.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ecc33f6789e32cd022a5e5fb487bdec5d7759880..0af734f269a342127132540514b68a8487c5b867 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -720,10 +720,28 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
 }
 EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
 
+static int dw_pcie_op_start_link(struct pci_bus *bus)
+{
+	struct dw_pcie_rp *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	return dw_pcie_host_start_link(pci);
+}
+
+static void dw_pcie_op_stop_link(struct pci_bus *bus)
+{
+	struct dw_pcie_rp *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	dw_pcie_host_stop_link(pci);
+}
+
 static struct pci_ops dw_pcie_ops = {
 	.map_bus = dw_pcie_own_conf_map_bus,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
+	.start_link = dw_pcie_op_start_link,
+	.stop_link = dw_pcie_op_stop_link,
 };
 
 static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)

-- 
2.34.1


