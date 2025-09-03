Return-Path: <linux-pci+bounces-35369-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 402CEB41F80
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 14:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D358188E0BD
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 12:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3555B3009C7;
	Wed,  3 Sep 2025 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Uruiri59"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797733002C4;
	Wed,  3 Sep 2025 12:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903539; cv=none; b=iYIl+jK8/AA4Gtp0KfWZiCECQYPk4lvWimyn1KkX85Fhl53qTwrRMEibJ2l/KENPD+w8x0BeCOJUhDiQQFdI8bW3kESFKKGyS9D6OEFFrou5p0eKcJO/rsNOPEmt/vSoccPe+d5sMRtn1dpJql/TmuBl2BLIcxcXFx22aryIvmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903539; c=relaxed/simple;
	bh=Ud2B27Eh56vwZK+XhNEM6d0W8BWXEkBJ+KeVOWRRnnY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RXhBMhQzjm0igXHMJQvTdI58VxJEPR1AwgghodkxbioRy1d9CVcq3rpg5wVjAhiF8ewxHuOrhIFR+k0jmo2xXnWM9jf4Bd3mJrrsghXOsg08MGROWYfdb//JSNUfgsti5vMwh7XkW2JJOZJZVp3FEWYf1vat/aIvsBEZ43xYy6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Uruiri59; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 583CjKdK3263776;
	Wed, 3 Sep 2025 07:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756903520;
	bh=Y7DJKYlXrJxu80EYCcBCLZKzR+uhECr5mDBhtoKfNEc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Uruiri59eA50IV/6eoRqLg2QxiA3p2iTX+gLik5CGr3KrHF/RRZu4i5J9q85gok0x
	 CgVL3BxTcPFeaxbSBvCu2tFmxoc82b/CXcCBBgCG98YLTVILzxM/lRIU20ecVSa8BA
	 II2mUNC+bRp4C+ki2J5i0vVzg/XbJfgdK2DDSciw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 583CjJph3601454
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 07:45:19 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 07:45:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 07:45:19 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 583Cj5wS1576150;
	Wed, 3 Sep 2025 07:45:13 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <fan.ni@samsung.com>, <quic_wenbyao@quicinc.com>,
        <namcao@linutronix.de>, <mayank.rana@oss.qualcomm.com>,
        <thippeswamy.havalige@amd.com>, <quic_schintav@quicinc.com>,
        <shradha.t@samsung.com>, <inochiama@gmail.com>, <cassel@kernel.org>,
        <kishon@kernel.org>, <18255117159@163.com>, <rongqianfeng@vivo.com>,
        <jirislaby@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 01/11] PCI: Export pci_get_host_bridge_device() for use by pci-keystone
Date: Wed, 3 Sep 2025 18:14:42 +0530
Message-ID: <20250903124505.365913-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903124505.365913-1-s-vadapalli@ti.com>
References: <20250903124505.365913-1-s-vadapalli@ti.com>
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


