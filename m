Return-Path: <linux-pci+bounces-33691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8434B1FEC1
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 07:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 116DD7AB747
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 05:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E326826D4EB;
	Mon, 11 Aug 2025 05:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zFHUHJ68";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xSY1wHhP"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F7926CE36;
	Mon, 11 Aug 2025 05:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754890914; cv=none; b=DAeD78WTmmqAYSdaUDEhAdC6rOtqh0lFyJfXgCJwIcmZkn40Xz6n4vs/Egr5bfJ1B8LkMmrCb83y3NQ42BLpUAUO4ZUMCq6H4nkmgUlnREGyyUArW9RH5Ut4ElAVIlMBwaodh9/C2fnIizVEh+C4qGVBdebwEtd8HuqTruZ3BLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754890914; c=relaxed/simple;
	bh=+7vtyp62JykU/tuiOkRN+XiOVt5FcIykRX8YDCXC46U=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=a9IUdpt4FGZ5OrMQ7inGBNprWPzoWe1c7NC2MIYQdpkJtR/T424A1r4fOn48siko9ykGDN4LC7OTiHqKYghvFlNlsN9KNB3odHknzLMVnmEMDYzhK3AWSNRN0r3wlVuRWILxRBw54Q1E8fGZ0ZpSp5+8kirhp8SmUlZ2vabHP4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zFHUHJ68; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xSY1wHhP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754890911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XrMwKX+SRUfTd+laIq2RPXWM2s+IfHFPYhm80O9b7rI=;
	b=zFHUHJ68aZkzLP2ReY2er1LhB7uYnOiTcBUSd+5Lu/zzPHN5fSskwus4tlj9ahe2YdHtti
	O1yKND6GvNXIh6cqc4jjI1bicKnUjGT4h9JpmUkvflpS4j+WEpprKkElEfUgcVak5Bu+e7
	arbJteLD7YfE+fMdIfGM64DXxiNkH5nTRZn5zv8Xgwv1spKVgwdrY9zzb1RitzbN9+uqV3
	9N9F8cS9cIh+C5vXwl24afW4cAgt0NmITcHAyIX1gippKtjZR0K8nudeiE/8Vnp4AGt5K7
	+Whawep5w/g7+ivldsTNCqcKOJpN8ng1XkVWA/5TV5Ejd/mwJ652AAvrY4dGHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754890911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XrMwKX+SRUfTd+laIq2RPXWM2s+IfHFPYhm80O9b7rI=;
	b=xSY1wHhPYDA11OkH6cQqKXKUMa9VeKo/v7OzWRulLeadzrNrORfLYdYdUFBcjHJUkLwI86
	8YUJmCyAJ6vkmSDg==
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Michal Simek <michal.simek@amd.com>,
	Nam Cao <namcao@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: xilinx: Fix NULL pointer dereference
Date: Mon, 11 Aug 2025 07:41:44 +0200
Message-Id: <20250811054144.4049448-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit f29861aa301c5 ("PCI: xilinx: Switch to
msi_create_parent_irq_domain()") changed xilinx_pcie::msi_domain from child
devices' interrupt domain into Xilinx AXI bridge's interrupt domain.

However, xilinx_pcie_intr_handler() wasn't changed and still reads Xilinx
AXI bridge's interrupt domain from xilinx_pcie::msi_domain->parent. This
pointer is NULL now.

Update xilinx_pcie_intr_handler() to read the correct interrupt domain
pointer.

Fixes: f29861aa301c5 ("PCI: xilinx: Switch to msi_create_parent_irq_domain(=
)")
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 drivers/pci/controller/pcie-xilinx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/=
pcie-xilinx.c
index f121836c3cf4..937ea6ae1ac4 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -400,7 +400,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, vo=
id *data)
 		if (val & XILINX_PCIE_RPIFR1_MSI_INTR) {
 			val =3D pcie_read(pcie, XILINX_PCIE_REG_RPIFR2) &
 				XILINX_PCIE_RPIFR2_MSG_DATA;
-			domain =3D pcie->msi_domain->parent;
+			domain =3D pcie->msi_domain;
 		} else {
 			val =3D (val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
 				XILINX_PCIE_RPIFR1_INTR_SHIFT;
--=20
2.39.5


