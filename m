Return-Path: <linux-pci+bounces-40553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C24FAC3E768
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 05:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4ACA4E2121
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 04:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9A3271457;
	Fri,  7 Nov 2025 04:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GylMaJDK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TwSbyK55"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3112526F2B3
	for <linux-pci@vger.kernel.org>; Fri,  7 Nov 2025 04:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762490625; cv=none; b=Zd4hi10V+F3KH31Yx0G6PWAd7l2USdkl3pgJ2poOiZoemRoKQnSa9/Ew6Dt5U0q6RDV1hIQdYkIkLL/Q/PGy6+65Vs6w05L7JRwCCXBbtaNMvkm7ACQLR7F3IjiIuB/LZ4LVdc5tlP3ej7YRC1iI5K08F+1csdC3Ci7oq2Ozf3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762490625; c=relaxed/simple;
	bh=G2/vAxxxQz4t8AYVp4CS9gXKXzeSLFuZgLICGLS61Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kw2MP9X+SSuAqLrQ0USsNaMzbhb+ZMTSPNEUwKt3Q3GNznw1MD2pfdn/L0Bn+dU3xPyDtPPhPV5FYJVAkngBD6LToYRWZDlOOnuL6Tr1hEmFO5uMlPoEF5dTBuwy/6nOEVs6xq+sRkLQJSue95swEMRNnsF8qxfh53cnOEXhf88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GylMaJDK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TwSbyK55; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6HWZQ1568016
	for <linux-pci@vger.kernel.org>; Fri, 7 Nov 2025 04:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=DshbN/+SdgJ
	8o5AVzAAO7cIuM+jDLxiKI8eKlaON6a4=; b=GylMaJDKscZuomf2ANZBXI77FH2
	RsTh0eadh0J4vpTeWu7YQa80Bb7CpUE1KLhIxB8Fcy3kvirdQgFCQZBT3EoIXorr
	iEVYax+ObCtwY2P0uX2v18a3un9ppsdf2yk1AcuTpcdxB4D7stMCjssVQqfKh37u
	46oEkGgeSrXDe7y+nucfcBNrSmtxwRi9994Q/AdzYTZLTX2f6vrjVwZCe3kr2yxs
	wSsi+J5XU9N1VqnJLTppKTlSnCbzlAd0HXcc+dPFepHqrmD86ryPlhfXTHNAaAfm
	yjaDQ3oJTRJTA2mtL4cUpM4wrlO9o64xL+PpuX/U8uzRDTVuMh8gSp53LDw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a905qhp0v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 07 Nov 2025 04:43:43 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-341616a6fb7so555433a91.0
        for <linux-pci@vger.kernel.org>; Thu, 06 Nov 2025 20:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762490623; x=1763095423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DshbN/+SdgJ8o5AVzAAO7cIuM+jDLxiKI8eKlaON6a4=;
        b=TwSbyK55eZ+F8DlTRdI5/EJ4rjOd92pwG+i6yw+BEaf1CSnWIazdfHvS7F1tS8A0nC
         5DML4EiZC5RIYocbn7R07wlNg3NF0DYVBb1tJktmdixZSoKm8/VT+6zXYufqk5jBfbi4
         5ykAhhhN/aj1lWILiOEMN4j589PEY0QpFpoAYOLP7VWPrqMJdrJrJHn9CwxyCcd7KFew
         Pm5ShvYEosqe3ityXBllH8ZGzY6K2zX9plpfqpi9oS2T97G+8uYeRLy/98u3HjTT0m5G
         cbPvtX0VGB9FHHK0ODl4Y/aMoxs1VQlsPmpC/CA8yc0yYa72x3y1VZebHbl3cmPUbIJx
         +B5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762490623; x=1763095423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DshbN/+SdgJ8o5AVzAAO7cIuM+jDLxiKI8eKlaON6a4=;
        b=iryBku3bK+lHnVQp+mlxZEkBZcJeVDPv4BoThjXWNe4CR21AsQUpPnxn9LodoAsRaM
         gk3ujww0RO4HXyMgLpTPlqX6q36RDh496hYfTuAyCBBSldrHHBst7MynXX/zqd8VwdyN
         uTjKsreat562kLgiOEWaTfhXJUkYhXMron6mbMqoLN0xku/P8cZJKVI2/uq2Vty3AAaL
         YKxklZgccPRpiXlXxFaMh2W0VYDFuaiGKIvinvAehACPGTrAGyRVmml2eSISzUkQVLRg
         Xp1+cTzBddxvgXNBfTzzYKUnS5AOB2JpSSC9JVCFvI9xu3VqsmRFTYSWl8fFOWuwNwvV
         G0oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEriegrYlcIqBj/yMxMyk4LeWeXbDBwiNf2aXYQERtNKA5uxlHVCpltAQ1LXb1fIdvQexcnpnKS8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy7GlEaAMJiFEtZ+RCLwezwRYrlrS+URaVfatwvU/BvC5lJUy2
	9HbNAvw0pxVd1eFl0SDAKpvdnrP/7XXiD4FiD5ToZw1cOdDHuheJCvTs+DizyePYuaMN3APi0bx
	TADcK6ea4uIH5NhuFLcgAcrXNZ4wqmY62gF479sstnK0LDM8MjhjsfC13SH2Xums=
X-Gm-Gg: ASbGncvLHDpQSXga3zT2nnPTpI30U4vHW2HmK0+E3otU2WfHtxdZ1jtb8l+Wh6OSPsl
	6j3TOj6e0+dV6bCCR9DkfCCNZDSAO2SXX1jSbRSaQojOB7wcdvH9QWLCacXP9PTE82TzD8Nbitr
	I6uoLzKfumutN+JD+qvdcEl/ko0BV5aqruAV/HLcSwn15/1yOdeaHFEAK5xPxVkE6cjEGJNTLpo
	z04iCq1jCkBrDwA0cXFdLL5K0dC0kzgM2aoBclMkoKuqu91FK5yDr846NIfR0sTtbnBrRf/0yIb
	q03hq7RQawtiqb4+fl8xAiAH3ufBajvif2zXOp31RLQLFQAuP2E1A8QXwcvXWBlZBksVN6fcNGg
	Rq69dfOEqIJa1RM0B9g==
X-Received: by 2002:a17:90b:4ac9:b0:341:88c5:2073 with SMTP id 98e67ed59e1d1-3434c4dc552mr2005954a91.2.1762490622286;
        Thu, 06 Nov 2025 20:43:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELudziz9hb7EuaLogNJwCGyLHcXQ49upAv4a7MpFInQ98hOWAEQHJY4aKl5ZMlthqCSZ+L2Q==
X-Received: by 2002:a17:90b:4ac9:b0:341:88c5:2073 with SMTP id 98e67ed59e1d1-3434c4dc552mr2005912a91.2.1762490621748;
        Thu, 06 Nov 2025 20:43:41 -0800 (PST)
Received: from work.. ([120.56.196.127])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c332f1csm1142624a91.11.2025.11.06.20.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 20:43:41 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
        bhelgaas@google.com
Cc: will@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, linux-arm-msm@vger.kernel.org,
        zhangsenchuan@eswincomputing.com, vincent.guittot@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH v2 1/3] PCI: host-common: Add an API to check for any device under the Root Ports
Date: Fri,  7 Nov 2025 10:13:17 +0530
Message-ID: <20251107044319.8356-2-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251107044319.8356-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20251107044319.8356-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0ANz-rjCNm8nXmnHkXlaBDJOYI09MuAi
X-Proofpoint-GUID: 0ANz-rjCNm8nXmnHkXlaBDJOYI09MuAi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDAzNCBTYWx0ZWRfXxKbnpLwTosRc
 dbm/Vse7hc76RMWddooKpmwOOgkyGT06RzqcKlG7p4M0yjwy2pddZmp5Fp+Cwl7b5zf8VjxONxY
 b3+8hJV7HvnIM/D2CXTyFI5zCilq2oKP9ebco6RA0sw+KKB3PqEM1MmsYWLXn2QBzn8F7dQRTQK
 kIJsFFGCTxvw0esYF5jHJTzQzMpXrK4Sj8mzDnMLkAxf94suPu4+SN1u8hXNL2L1RPUgZ74KxTI
 BdkQbptu2yJwqsqbaaUdGzPhYntbVlL/EQLiFal4e2I8xXl9xjYV/dGbMM2p27IcxVFhrUSHPIr
 CBVnKW4Qz04QQ9IQSK9PR70V79pYn/DnwlQAGMUo4lAlL5Yk7CuHTjLrAPGjvtidZtTwokhSsuW
 XOvfz1FaQvu/hBia/36kCjr+TQ405A==
X-Authority-Analysis: v=2.4 cv=D6lK6/Rj c=1 sm=1 tr=0 ts=690d78ff cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=NqeMpCPRvvPHbudmJ2rC7w==:17
 a=X544SMn2G6euAj6E:21 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=dVeha9RqDf-OwfEDNMwA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511070034

Some controller drivers need to check if there is any device available
under the Root Ports. So add an API that returns 'true' if a device is
found under any of the Root Ports, 'false' otherwise.

Controller drivers can use this API for usecases like turning off the
controller resources only if there are no devices under the Root Ports,
skipping PME_Turn_Off broadcast etc...

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/pci-host-common.c | 21 +++++++++++++++++++++
 drivers/pci/controller/pci-host-common.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index 810d1c8de24e..772bac8b3bf2 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -17,6 +17,27 @@
 
 #include "pci-host-common.h"
 
+/**
+ * pci_root_ports_have_device - Check if the Root Ports under the Root bus have
+ *				any device underneath
+ * @root_bus: Root bus to check for
+ *
+ * Return: true if a device is found, false otherwise
+ */
+bool pci_root_ports_have_device(struct pci_bus *root_bus)
+{
+	struct pci_bus *child;
+
+	/* Iterate over the Root Port busses and look for any device */
+	list_for_each_entry(child, &root_bus->children, node) {
+		if (!list_empty(&child->devices))
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(pci_root_ports_have_device);
+
 static void gen_pci_unmap_cfg(void *ptr)
 {
 	pci_ecam_free((struct pci_config_window *)ptr);
diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/controller/pci-host-common.h
index 51c35ec0cf37..ff1c2ff98043 100644
--- a/drivers/pci/controller/pci-host-common.h
+++ b/drivers/pci/controller/pci-host-common.h
@@ -19,4 +19,6 @@ void pci_host_common_remove(struct platform_device *pdev);
 
 struct pci_config_window *pci_host_common_ecam_create(struct device *dev,
 	struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops);
+
+bool pci_root_ports_have_device(struct pci_bus *root_bus);
 #endif
-- 
2.48.1


