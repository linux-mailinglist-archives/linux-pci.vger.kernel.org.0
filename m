Return-Path: <linux-pci+bounces-16188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9359BFAF7
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 01:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42C6282C21
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 00:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234EE4C96;
	Thu,  7 Nov 2024 00:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="GxLe/4sD"
X-Original-To: linux-pci@vger.kernel.org
Received: from pv50p00im-ztdg10011301.me.com (pv50p00im-ztdg10011301.me.com [17.58.6.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF78C2ED
	for <linux-pci@vger.kernel.org>; Thu,  7 Nov 2024 00:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730940819; cv=none; b=dERjBaUxJxD/nsjlaKh0syV1M2IfTXQ4Bm40UEx56/YYouTjBJ/jkNo2WmUcCDd2SRKgyQiFdzYZ77xK6URyhmToyudKLssnsNweRD21Aj6Iv7ImJIvweZIsac/HwzUVjfY6feQfmZKl7pzc9IRAEJj4TL+wMDk9g5dmyqy53Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730940819; c=relaxed/simple;
	bh=2DVxZdJ8G/nWZGhEHo1sngh49q84LISpUTQwcFcQljA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uYditkI+5l+2rx6ElzkQQx1uUtn5ryyFIUtlVKlmreFi6XqnQw6znsivEYLI/jtz6+NAcSY48O3VubgEPuzkWeqbPSqdwWXHRztWwiV4KxBNrz5qTXQ/NuWOLioWSymYZFyRZWFYHDb5siA6JJ6O2FxlwJgSTf0swxaq0t7S+Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=GxLe/4sD; arc=none smtp.client-ip=17.58.6.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730940817;
	bh=qWo3iReSch/+mnhq8b71sYqoOrBP+GcMhriCoORgRgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=GxLe/4sDcECTbSBsK+/vUAeV+wOGRK59opMxqtCsLI8SvQQljkeDA8y7heE3qfCFE
	 OXYGtNCe2m6KVvVIKI2BL7/VYkCPRARKNGgOH9nAZ3C+okI6GKGrLclaLyRWQ88vqS
	 uow3w7+e/sLOAY1SYIJsPNGiZqZXVfopm9of0z+zt62uBWTrJQVmKGRh+PIPPvS6Jp
	 tkUuI1tHxaw09s/Dr+h8GIXy+p4ACgV4pjUzyIE6qIb7IwiTj3S2EUPd9GQReI9MB4
	 CE/6++Rjs+JhVjb4sVF9DGAyumFDIEp6v6BjK6m2NVpMFl55bDo13yJhA6CVGlVMAj
	 KmAs5mO554nBA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id 6183C180212;
	Thu,  7 Nov 2024 00:53:30 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 07 Nov 2024 08:53:08 +0800
Subject: [PATCH v2 1/2] PCI: endpoint: Fix API pci_epc_destroy() releasing
 domain_nr ID faults
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-epc_rfc-v2-1-da5b6a99a66f@quicinc.com>
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
 Zijun Hu <quic_zijuhu@quicinc.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: XfdNADfY-sJw3sBu6XQnr3JdfZi_TIo_
X-Proofpoint-GUID: XfdNADfY-sJw3sBu6XQnr3JdfZi_TIo_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_19,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=761 phishscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411070004
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

pci_epc_destroy() invokes pci_bus_release_domain_nr() to release domain_nr
ID, but the invocation has below 2 faults:

- The later accesses device @epc->dev which has been kfree()ed by previous
  device_unregister(), namely, it is a UAF issue.

- The later frees the domain_nr ID into @epc->dev, but the ID is actually
  allocated from @epc->dev.parent, so it will destroy domain_nr IDA.

Fix by freeing the ID to @epc->dev.parent before unregistering @epc->dev.

The file(s) affected are shown below since they indirectly use the API.
drivers/pci/controller/cadence/pcie-cadence-ep.c
drivers/pci/controller/dwc/pcie-designware-ep.c
drivers/pci/controller/pcie-rockchip-ep.c
drivers/pci/controller/pcie-rcar-ep.c

Fixes: 0328947c5032 ("PCI: endpoint: Assign PCI domain number for endpoint controllers")
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 17f007109255..bcc9bc3d6df5 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -837,11 +837,10 @@ EXPORT_SYMBOL_GPL(pci_epc_bus_master_enable_notify);
 void pci_epc_destroy(struct pci_epc *epc)
 {
 	pci_ep_cfs_remove_epc_group(epc->group);
-	device_unregister(&epc->dev);
-
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
-	pci_bus_release_domain_nr(&epc->dev, epc->domain_nr);
+	pci_bus_release_domain_nr(epc->dev.parent, epc->domain_nr);
 #endif
+	device_unregister(&epc->dev);
 }
 EXPORT_SYMBOL_GPL(pci_epc_destroy);
 

-- 
2.34.1


