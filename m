Return-Path: <linux-pci+bounces-38974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD63BFB42E
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 11:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025ED562CAF
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 09:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6723831DDBA;
	Wed, 22 Oct 2025 09:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vaZQl3nd"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4CB31B80D;
	Wed, 22 Oct 2025 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127070; cv=none; b=mRNhNmlflxr/z9Whq8MG8qxZGu0PMFd/gawc8QKdbBb4vo7tSafq6OSJI5csJ55vEYeHHlUzy4L+vXmqQ9Z4grv/rEc2SYA8Tcmj7jglrAZupdIqvsR6SYhCLblU5wEoNURq1NQode+BzDPzRmsUTX/R+jMDk33r9dFdsUPMhSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127070; c=relaxed/simple;
	bh=PzyVA+4IaassXHiYDBcwro8Jeg1BfKKyI4XME+c4zbI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KI88OpPmpGl6JtJu8hYJX6nqomU8WJ8oKaQxd9VV6Vt9coqmqxosPKBs8kr2Qem5LORYyFD78yjC2v92WUoSw2LUq3DLBcL9I1NnfvVaAkO1Dwr9FPRhVhYo1T0wI6EiRbyjsBKkCljw7KPTCtatbr11J7N685AiQ9WVvRjnEOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vaZQl3nd; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59M9vS711387143;
	Wed, 22 Oct 2025 04:57:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761127048;
	bh=Da/XaA3WaCTSdzwdYk0sEhHYo+sgG9siIt2+rDb1DwU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=vaZQl3ndPjmI1KoNdjaFFQeoLrsbwDREm6DPRPz6DzvXTZAS78CUneWEung3wyKL+
	 6X9pk/E0KmCzgPrf7fLWvcdYI8nX49yZgzl1PxMR+TPQ3Fmgpi5f2SPjOKDQzig5pc
	 tQLAqFeK0pwOxuUF0J6OQ+i9MqPks2RxdUFfKK+0=
Received: from DFLE205.ent.ti.com (dfle205.ent.ti.com [10.64.6.63])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59M9vSeY2266303
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Oct 2025 04:57:28 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 04:57:28 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Oct 2025 04:57:28 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59M9vFcW1029418;
	Wed, 22 Oct 2025 04:57:22 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <quic_wenbyao@quicinc.com>, <inochiama@gmail.com>,
        <mayank.rana@oss.qualcomm.com>, <thippeswamy.havalige@amd.com>,
        <shradha.t@samsung.com>, <cassel@kernel.org>, <kishon@kernel.org>,
        <sergio.paracuellos@gmail.com>, <18255117159@163.com>,
        <rongqianfeng@vivo.com>, <jirislaby@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v4 1/4] PCI: Export pci_get_host_bridge_device() for use by pci-keystone
Date: Wed, 22 Oct 2025 15:27:09 +0530
Message-ID: <20251022095724.997218-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022095724.997218-1-s-vadapalli@ti.com>
References: <20251022095724.997218-1-s-vadapalli@ti.com>
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

v3:
https://lore.kernel.org/r/20250922071222.2814937-2-s-vadapalli@ti.com/
Changes since v3:
- Rebased patch on 6.18-rc1 tag of Mainline Linux.

Regards,
Siddharth.

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
2.51.0


