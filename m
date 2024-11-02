Return-Path: <linux-pci+bounces-15846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E98EF9BA0C3
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 15:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9469B1F21913
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 14:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1520319F420;
	Sat,  2 Nov 2024 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="td3vmpMy"
X-Original-To: linux-pci@vger.kernel.org
Received: from pv50p00im-hyfv10011601.me.com (pv50p00im-hyfv10011601.me.com [17.58.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD77919F101
	for <linux-pci@vger.kernel.org>; Sat,  2 Nov 2024 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730557614; cv=none; b=f5rF2/slphUPCeXaT/6dnCkuiXXBzNMB/vIySqgufiHanmI44jDjdrn+AejQeyG9sOZK78EsOt9cBCA+ytEeIw74buCmOr55hW+C+GExi5IappXafGByehdYKq8ZJDy4B4/0H/Em2RgD8poy63P/zzoP2fWVzwL/Msg4ptSQhsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730557614; c=relaxed/simple;
	bh=T6eBO5iVTcRI5KZzTMTJjHYTqiaf8JA8f7PAHq8h1mw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RTErstJCWSkoVjbDHX5FN5e2f3YYBa/jvPdrk80pDMcqHdWVBJpEb6+IXvly554HkvRtzV6eoaElXo8NRQ4J8xkCMozlWfT85h2h6GEWZScVECoF9Thz5KJu4UX0tXRWpcoQkghsZL7WZynTKS1gK+iTqQe7ZIppg1jQMJkm3Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=td3vmpMy; arc=none smtp.client-ip=17.58.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730557612;
	bh=uKD823wbXW1lUHeTJ2B39H4c7+jz7b+f4lLA+PDf368=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=td3vmpMy0BbS+eYXRDoI6riefgrFTv9fRPDkZ/39BYDR5r3KocBQ1YkNUBDkXSh+6
	 UiD4BXK6T6jjF8nG6OrKJuvxrDWC9n+iN2cmdx9J3SG4WQIdI9f86tnw3ZNzwem2JV
	 D01uX3Z1JeHp7yZOBvn4p4q/LTx4OXEFC4ey1hSZvTsHKaSHuWe/0tL2sfBxKoDVBS
	 Ue9HZ1muQJaPIdPctg+PZgsCtaiAOzwDAJoqpiiuxvwp7kI0wZRpHniP2gSJPhz/Wl
	 IyJwdWpaDGeINpkeqv6odXgTFvai/3BHUFgBGX1pj/CBMB4YsR97lF7TVrRt9XCFAH
	 Zm0c0rSEu0Q5w==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id 64D6FC8010E;
	Sat,  2 Nov 2024 14:26:45 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sat, 02 Nov 2024 22:26:15 +0800
Subject: [PATCH RFC 2/2] PCI: endpoint: Fix that API pci_epc_remove_epf()
 cleans up wrong EPC of EPF
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241102-epc_rfc-v1-2-5026322df5bc@quicinc.com>
References: <20241102-epc_rfc-v1-0-5026322df5bc@quicinc.com>
In-Reply-To: <20241102-epc_rfc-v1-0-5026322df5bc@quicinc.com>
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
X-Proofpoint-GUID: mMWpy04VA6p7kIxKb8cIQsZ1LBQzWOZt
X-Proofpoint-ORIG-GUID: mMWpy04VA6p7kIxKb8cIQsZ1LBQzWOZt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-02_12,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxscore=0 mlxlogscore=895 malwarescore=0 spamscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411020128
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

It is wrong for pci_epc_remove_epf(..., epf, SECONDARY_INTERFACE) to
clean up @epf->epc.

Fixed by cleaning up @epf->sec_epc instead of @epf->epc for
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


