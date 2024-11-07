Return-Path: <linux-pci+bounces-16189-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3259BFAFA
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 01:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA231C21C02
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 00:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF22C79E1;
	Thu,  7 Nov 2024 00:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Kh4gNvkt"
X-Original-To: linux-pci@vger.kernel.org
Received: from pv50p00im-ztdg10011301.me.com (pv50p00im-ztdg10011301.me.com [17.58.6.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A47DFC0A
	for <linux-pci@vger.kernel.org>; Thu,  7 Nov 2024 00:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730940824; cv=none; b=CbfLNe+Xg+0hriqmDWeW5rXgjcOErd/RejwVk6d+rCARhnss8Mi5RIS7n1z0gsQWO/cSIM3+NSjzq8MUu52/oV4Hqkt87dfM6WjWRiwHahYA7ycoXMQZ2P54Xczk2k4jfkRktgkRrmmw/zpCNqUnO7Bgr/IE1m2t2oJtu9Gl4nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730940824; c=relaxed/simple;
	bh=evPvsvxnVfmrQbhMoGVPg1oJmOdp7EpHgCk9OlRy3Zk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rDVQjdatexFkJ+qeBZ/MaPCWvcZfYqz4VfEFyCoCPw/SOd/RXph9NxFMDT2LTwar0RgUSJawLt2/qS2U1WPin9nLpUSWe6N+ktLF//z5wmpF32FgAF7lxtsw/OHJd+e9teSXXu+HNSnR5IGof4YYb2PU1JYx8KLd+0/ZkzqEAys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Kh4gNvkt; arc=none smtp.client-ip=17.58.6.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730940823;
	bh=9Dqeet4LyQ9jgJSzTKaTkyK6p277/iOQ8TDxpGj80qk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=Kh4gNvktfktYmZTKzY3WzysTVDdVHgQgdWtFOYBPYCx+AQC9USclyBqsYgwGJHPW2
	 3PPqX9p403D/zqsC6RD98G3u9XoX0KbQDRT9rP7t/rMJuQBn9PMIJe4e0BSKe5F/Xf
	 f4fcpdZ9NTK8SumbE6PAs+vs+jS/IHyqTdDDQwgDJ5V5FEubRNFVtyfk35U+7Co0J0
	 /ezBOKbMQJnanAzhL990EXvz0vDMOkykrrjZGR6ZEv6Eq3ja4vX4YO2k7M9YP53Y74
	 WE7kQNytqBLnmSpCZEjtduQVTRh/aKW6dSwVRkrUMBcZdewG9xQarnTFsplQIV0Kt2
	 8vrUlVfQDVr1w==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id 2250818020B;
	Thu,  7 Nov 2024 00:53:37 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 07 Nov 2024 08:53:09 +0800
Subject: [PATCH v2 2/2] PCI: endpoint: Fix API pci_epc_remove_epf()
 cleaning up wrong EPC of EPF
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-epc_rfc-v2-2-da5b6a99a66f@quicinc.com>
References: <20241107-epc_rfc-v2-0-da5b6a99a66f@quicinc.com>
In-Reply-To: <20241107-epc_rfc-v2-0-da5b6a99a66f@quicinc.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: DJEibPQ7cXraeHJ-a1j94JMbbY7YE3lR
X-Proofpoint-GUID: DJEibPQ7cXraeHJ-a1j94JMbbY7YE3lR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_19,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=970 phishscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411070004
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

It is wrong for pci_epc_remove_epf(..., epf, SECONDARY_INTERFACE) to
clean up @epf->epc obviously.

Fix by cleaning up @epf->sec_epc instead of @epf->epc for
SECONDARY_INTERFACE.

Fixes: 63840ff53223 ("PCI: endpoint: Add support to associate secondary EPC with EPF")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index bcc9bc3d6df5..62f7dff43730 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -660,18 +660,18 @@ void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
 	if (IS_ERR_OR_NULL(epc) || !epf)
 		return;
 
+	mutex_lock(&epc->list_lock);
 	if (type == PRIMARY_INTERFACE) {
 		func_no = epf->func_no;
 		list = &epf->list;
+		epf->epc = NULL;
 	} else {
 		func_no = epf->sec_epc_func_no;
 		list = &epf->sec_epc_list;
+		epf->sec_epc = NULL;
 	}
-
-	mutex_lock(&epc->list_lock);
 	clear_bit(func_no, &epc->function_num_map);
 	list_del(list);
-	epf->epc = NULL;
 	mutex_unlock(&epc->list_lock);
 }
 EXPORT_SYMBOL_GPL(pci_epc_remove_epf);

-- 
2.34.1


