Return-Path: <linux-pci+bounces-15840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7049B9FF8
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 13:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7800A1C215D9
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 12:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB58118A6A7;
	Sat,  2 Nov 2024 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="piAsmvSS"
X-Original-To: linux-pci@vger.kernel.org
Received: from pv50p00im-ztdg10021801.me.com (pv50p00im-ztdg10021801.me.com [17.58.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB48189F5E
	for <linux-pci@vger.kernel.org>; Sat,  2 Nov 2024 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730550062; cv=none; b=GJlJ38NFx0BA3VZXoDGO704wy/BDpF/NfRv5kzkOgIJXF53cTnUfEmhfDhnFbAWgkUR6CFFOaYtHs57Z9YjpJf+83xmixb7IriVKFR0mw48gWxWtHqE/0+NxUZ9IVPxfm9SANzkmCwBDsTLBTGgmy52IaWRbs9REDHFUEQR1EwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730550062; c=relaxed/simple;
	bh=VkeogyVD+b7IiBKo74qol3vlxCGisDmqc3nE31w2Zr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LKqjghTA68kLxd/mQdgVJWSBAxAYKLgS5uCj6FoTUE+iLHSzZ8U+B+VrfSjG59gugXpzZ4a1LEx7sXBKUWAxkOV34InXdLeyTx62guK171h1W/SPsewczP4sKbAS8lDijsCcbrVuR4r6lDlLY719/L2eS6s3cxevkhbN0F0cWlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=piAsmvSS; arc=none smtp.client-ip=17.58.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730550060;
	bh=4bYq2rCA9Uk+hqeLDrhAppY00kkwrSYtZeSTqp07U2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=piAsmvSS+MErmrxA2icClM4mx0alTM+nrRiw3gRYQnNdsxrIS258ctGu3wGFfnNvd
	 P7e/pELda550BgqN4rTjayvotjSIPhCZ1tVBcMDlm3Ea8AqSAaZgzzeMdaYN6MSBkD
	 RQmbw1vjbVnAE+rPy+bEFAyNjwb2C0MoI33LoYPluIiwMzBYgyjpwbfgGLm60y9+rm
	 t3hnxPYFM7bnWnhqjo0qeNzDWt2dp1/sa8TZEputK1oyHk33Df1e6w1KvbMc0uN6FO
	 a9b0pVbkwFUxGRyCpfUHFXzlQAnV/vJtmLPM/hzd+h9qF/BZtb37QHLb4+eSwICb0s
	 eY/5d8gxm1IQQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id C570220102C6;
	Sat,  2 Nov 2024 12:20:54 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sat, 02 Nov 2024 20:20:07 +0800
Subject: [PATCH v2 2/2] PCI: endpoint: Simplify API pci_epc_get()
 implementation
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241102-pci-epc-core_fix-v2-2-0785f8435be5@quicinc.com>
References: <20241102-pci-epc-core_fix-v2-0-0785f8435be5@quicinc.com>
In-Reply-To: <20241102-pci-epc-core_fix-v2-0-0785f8435be5@quicinc.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <jpinto@synopsys.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: 29hER64X2qV4y4pbYakaL8umkQtqVNMN
X-Proofpoint-GUID: 29hER64X2qV4y4pbYakaL8umkQtqVNMN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-02_11,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 suspectscore=0
 mlxlogscore=961 adultscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411020110
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Simplify pci_epc_get() implementation by API class_find_device_by_name().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 71b6d100056e..eb02d477bc7c 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -60,26 +60,17 @@ struct pci_epc *pci_epc_get(const char *epc_name)
 	int ret = -EINVAL;
 	struct pci_epc *epc;
 	struct device *dev;
-	struct class_dev_iter iter;
 
-	class_dev_iter_init(&iter, &pci_epc_class, NULL, NULL);
-	while ((dev = class_dev_iter_next(&iter))) {
-		if (strcmp(epc_name, dev_name(dev)))
-			continue;
+	dev = class_find_device_by_name(&pci_epc_class, epc_name);
+	if (!dev)
+		goto err;
 
-		epc = to_pci_epc(dev);
-		if (!try_module_get(epc->ops->owner)) {
-			ret = -EINVAL;
-			goto err;
-		}
-
-		class_dev_iter_exit(&iter);
-		get_device(&epc->dev);
+	epc = to_pci_epc(dev);
+	if (try_module_get(epc->ops->owner))
 		return epc;
-	}
 
 err:
-	class_dev_iter_exit(&iter);
+	put_device(dev);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(pci_epc_get);

-- 
2.34.1


