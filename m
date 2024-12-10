Return-Path: <linux-pci+bounces-18031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B94C9EB28F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 15:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F09D1695BA
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 14:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1F71B2190;
	Tue, 10 Dec 2024 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="UztrZSeK"
X-Original-To: linux-pci@vger.kernel.org
Received: from pv50p00im-tydg10011801.me.com (pv50p00im-tydg10011801.me.com [17.58.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E011AAA02
	for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839294; cv=none; b=WXoIKMifS10V+z42CxckY6bAMrmyMonbuJMLJ0CSaNRbJ3VaeTQevMjjR6lSuUVZ10T9o6dNwTac0Ns+rjbHQ86MGGqEji+63QmuJO/jZzY4isOTw1J4VBsoTiH18FveKYmCXiBjknDmb9vUC0PiceIu03QceCj4MMyyiZxR2oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839294; c=relaxed/simple;
	bh=eYMW9hHwPHqiPLBKFjol8BZpfo0bKQbBb10Nr3+vlqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iix0A+/v5OLjzfQeYw5jhprjBQJJKxssHSpQPdVp/hbGT1Q+3qNnHtY+bCSnGByKpINxmHIkGxR/5+qZgcY168gWM21jJD3xv2FWVClJ6ZhiqmvNlaGRipSK5YZJNG4+WY/sCD6zzEMMgvYPYOk7d/DsKgmQS1+ASfbYx4hl0Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=UztrZSeK; arc=none smtp.client-ip=17.58.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733839291;
	bh=lyLsWjXmuagjO0JYLheAQbjG7pu5wh1gMuC5bWUKHX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=UztrZSeKMUSDRWGWM1ZaOXqwBHFS3eTzE33De+daZjVDyBRrEG7QQeqcKs2tYf4lX
	 wTEzhd9HbI9Wj8azKuEDx3NusLBFBNhiTzCyaqxV0lIymvS16y8nQpAbm7x6fk8Tup
	 f8jXD7BpeeqRt2TAyyPIMlvkm3xo3apKxYP8tisA2sO2tuy3ADBBnr+9p719BLeyPF
	 yNdhdjzTMvINHOYJ3xxvyrlOQ3ECMODtppWOtvWcfKaWxxECR0NtC4mXHcuVWNXgeb
	 eTWqMu5M5PkZllJxbB2E+wtjrOMI7zq1oJmpEdVM0afEkaE0j89/oSt/nEVHH6+bJI
	 Nb/Sv5iA83Dxw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id 45A92800391;
	Tue, 10 Dec 2024 14:01:24 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 10 Dec 2024 22:00:20 +0800
Subject: [PATCH v3 3/3] PCI: endpoint: Fix API pci_epf_add_vepf() returning
 -EBUSY error
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-pci-epc-core_fix-v3-3-4d86dd573e4b@quicinc.com>
References: <20241210-pci-epc-core_fix-v3-0-4d86dd573e4b@quicinc.com>
In-Reply-To: <20241210-pci-epc-core_fix-v3-0-4d86dd573e4b@quicinc.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <jpinto@synopsys.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Wei Yongjun <weiyongjun1@huawei.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: tWbp0T0O1YH03JZBuAhap_YTQqzC8Tu0
X-Proofpoint-ORIG-GUID: tWbp0T0O1YH03JZBuAhap_YTQqzC8Tu0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_07,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 mlxlogscore=812 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412100105
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

pci_epf_add_vepf() will suffer -EBUSY error by steps below:

pci_epf_add_vepf(@epf_pf, @epf_vf)       // add
pci_epf_remove_vepf(@epf_pf, @epf_vf)   // remove
pci_epf_add_vepf(@epf_pf, @epf_vf)     // add again, -EBUSY error.

Fix by clearing @epf_vf->epf_pf in pci_epf_remove_vepf().

Fixes: 1cf362e907f3 ("PCI: endpoint: Add support to add virtual function in endpoint core")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 8fa2797d4169a9f21136bbf73daa818da6c4ac49..50bc2892a36c54aa82c819ac5a9c99e9155d92c1 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -202,6 +202,7 @@ void pci_epf_remove_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf)
 
 	mutex_lock(&epf_pf->lock);
 	clear_bit(epf_vf->vfunc_no, &epf_pf->vfunction_num_map);
+	epf_vf->epf_pf = NULL;
 	list_del(&epf_vf->list);
 	mutex_unlock(&epf_pf->lock);
 }

-- 
2.34.1


