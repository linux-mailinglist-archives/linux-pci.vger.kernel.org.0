Return-Path: <linux-pci+bounces-36622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A72EBB8F3EF
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 09:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA3F4202B9
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 07:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5492F5308;
	Mon, 22 Sep 2025 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MRlNdfoG"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF6A2F3C2F;
	Mon, 22 Sep 2025 07:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525191; cv=none; b=eg9rCJ52rBY7CRo5egc1cfiCBwqqEjdI/r5reox0hPuugIfFWHD96sy0NiE+ljK5EXYePFnULonaPUBaZV3o8DsnR55sCRK+OHFY5VSx+PfiJ2WbTswsfHBy/EyMBbGe9hKU7t1ZO0bIluW99YF37wqiadJdCuCyT521PokL5Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525191; c=relaxed/simple;
	bh=tgsnuTZQ+p+3FVYHZX88VPoMm3M4J2mOfqOv+mONVQo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzCDTWxNi4aRPKfdB1RPt+wkDkRZGyUyk48Er0q/lOEkDie7lgrNNlhSOnJC2+U6susqsGjsWU91cNfGSDTC3rpfrkEO1CUrrdBoe6qJPm5NMN3jTqlyX1i4U0VUdMII4EiwfSIVXWAnzoxpIX/qf27ZVWgQUB2dprpSV3u+ACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MRlNdfoG; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58M7CaSo1200440;
	Mon, 22 Sep 2025 02:12:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758525156;
	bh=nf/R5npK7bn+6Y0fPXkVPUfGPQf+QEJ2cGcQG/nZiBI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MRlNdfoGn9HN3TwDEQANlLhDcMMghjDYljxT+VxGATiL+4Vmjh6M8vLNxtCwFx7vf
	 eS6GSL6Tde2Ru48CYLCg7i89aufOXYmklwFZtccO+FdUaLMT8wxTMmqhMUuvjYr6TT
	 BAwjvDO3SSuKCfp5ZIEFPtszWbJT7gk2Zcot4clo=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58M7Caff117942
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 22 Sep 2025 02:12:36 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 22
 Sep 2025 02:12:35 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Sep 2025 02:12:35 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58M7CN0S2369246;
	Mon, 22 Sep 2025 02:12:30 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <christian.bruel@foss.st.com>, <quic_wenbyao@quicinc.com>,
        <inochiama@gmail.com>, <mayank.rana@oss.qualcomm.com>,
        <thippeswamy.havalige@amd.com>, <shradha.t@samsung.com>,
        <cassel@kernel.org>, <kishon@kernel.org>,
        <sergio.paracuellos@gmail.com>, <18255117159@163.com>,
        <rongqianfeng@vivo.com>, <jirislaby@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v3 1/4] PCI: Export pci_get_host_bridge_device() for use by pci-keystone
Date: Mon, 22 Sep 2025 12:42:13 +0530
Message-ID: <20250922071222.2814937-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922071222.2814937-1-s-vadapalli@ti.com>
References: <20250922071222.2814937-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The pci-keystone.c driver uses the 'pci_get_host_bridge_device()' helper.
In preparation for enabling the pci-keystone.c driver to be built as a
loadable module, export 'pci_get_host_bridge_device()'.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v2 of this patch is at:
https://lore.kernel.org/r/20250912122356.3326888-2-s-vadapalli@ti.com/
No changes since v2.

 drivers/pci/host-bridge.c | 1 +
 include/linux/pci.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index afa50b446567..be5ef6516cff 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -33,6 +33,7 @@ struct device *pci_get_host_bridge_device(struct pci_dev *dev)
 	kobject_get(&bridge->kobj);
 	return bridge;
 }
+EXPORT_SYMBOL_GPL(pci_get_host_bridge_device);
 
 void  pci_put_host_bridge_device(struct device *dev)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d1fdf81fbe1e..b253cbc27d36 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -646,6 +646,7 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv);
 struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device *dev,
 						   size_t priv);
 void pci_free_host_bridge(struct pci_host_bridge *bridge);
+struct device *pci_get_host_bridge_device(struct pci_dev *dev);
 struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus);
 
 void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
-- 
2.43.0


