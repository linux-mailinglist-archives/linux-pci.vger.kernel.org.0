Return-Path: <linux-pci+bounces-23167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6231FA57486
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 23:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D583B4C48
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 22:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3806725CC65;
	Fri,  7 Mar 2025 22:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FvvM3kdo"
X-Original-To: linux-pci@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CBB25A2B4;
	Fri,  7 Mar 2025 22:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741384991; cv=none; b=ZRTd0XCopEc2X94TRB/3O0N2ZEpStiTPfukulLDuoOuksBneK30lLMFMboMG7jYatHtX/jyasiYZyh+ZP0NE0xFPbdAVReouWc/tD3U+EH8A5JwFmRw29fflmntVwRCCiBcKKa5AVlNJnZNPNdW7rk3kwNRyCWWGceiYbxI++DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741384991; c=relaxed/simple;
	bh=xEv09iQgdL/tuKt/qBi9FICBYLL5WWF9UJ9RsAeChrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FANNKcOOW3jMm6AhD33OoqN994JeSWkrtFIpwkVmPlE2/lopCpVy/jwzyZfUvC2noJ1xNLk6FwzQjD6LwHMatO1H8NDgGr+PmJ50agGo/Z8U+NLfrwCh6LyDyVZhDET0K9LygYZlbjX++a1tk1H88xNex+30kRwgKPML+MgrxXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FvvM3kdo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4D2132038F4A;
	Fri,  7 Mar 2025 14:03:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4D2132038F4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741384989;
	bh=Xg8ME5dONHSFnRO8dojS197sIBlu9wGWCIsq5ezNrqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FvvM3kdoL3jyLeJuKYumMqYAyA7ZKisqeRofTGX7CZuahsdA/KFoN79jaiuovFjmW
	 SgfVVQdBA3CySpRBGmfE5tfg5HPbHEFDV1YeKA+7/KN8wD2yFlalkMMuVM5M7QwjRR
	 xqzaHSDQs4q8k4fZX1/P0yyILm1TXHTIA5aBumgM=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	catalin.marinas@arm.com,
	conor+dt@kernel.org,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	joey.gouly@arm.com,
	krzk+dt@kernel.org,
	kw@linux.com,
	kys@microsoft.com,
	lenb@kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	mingo@redhat.com,
	oliver.upton@linux.dev,
	rafael@kernel.org,
	robh@kernel.org,
	ssengar@linux.microsoft.com,
	sudeep.holla@arm.com,
	suzuki.poulose@arm.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	will@kernel.org,
	yuzenghui@huawei.com,
	devicetree@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v5 10/11] ACPI: irq: Introduce acpi_get_gsi_dispatcher()
Date: Fri,  7 Mar 2025 14:03:02 -0800
Message-ID: <20250307220304.247725-11-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307220304.247725-1-romank@linux.microsoft.com>
References: <20250307220304.247725-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using acpi_irq_create_hierarchy() in the cases where the code
also handles OF leads to code duplication as the ACPI subsystem
doesn't provide means to compute the IRQ domain parent whereas
the OF does.

Introduce acpi_get_gsi_dispatcher() so that the drivers relying
on both ACPI and OF may use irq_domain_create_hierarchy() in the
common code paths.

No functional changes.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/acpi/irq.c   | 14 ++++++++++++--
 include/linux/acpi.h |  5 ++++-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index 1687483ff319..6243db610137 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -12,7 +12,7 @@
 
 enum acpi_irq_model_id acpi_irq_model;
 
-static struct fwnode_handle *(*acpi_get_gsi_domain_id)(u32 gsi);
+static acpi_gsi_domain_disp_fn acpi_get_gsi_domain_id;
 static u32 (*acpi_gsi_to_irq_fallback)(u32 gsi);
 
 /**
@@ -307,12 +307,22 @@ EXPORT_SYMBOL_GPL(acpi_irq_get);
  *	for a given GSI
  */
 void __init acpi_set_irq_model(enum acpi_irq_model_id model,
-			       struct fwnode_handle *(*fn)(u32))
+	acpi_gsi_domain_disp_fn fn)
 {
 	acpi_irq_model = model;
 	acpi_get_gsi_domain_id = fn;
 }
 
+/**
+ * acpi_get_gsi_dispatcher - Returns dispatcher function that
+ *                           computes the domain fwnode for a
+ *                           given GSI.
+ */
+acpi_gsi_domain_disp_fn acpi_get_gsi_dispatcher(void)
+{
+	return acpi_get_gsi_domain_id;
+}
+
 /**
  * acpi_set_gsi_to_irq_fallback - Register a GSI transfer
  * callback to fallback to arch specified implementation.
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4e495b29c640..abc51288e867 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -336,8 +336,11 @@ int acpi_register_gsi (struct device *dev, u32 gsi, int triggering, int polarity
 int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
 int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
 
+typedef struct fwnode_handle *(*acpi_gsi_domain_disp_fn)(u32);
+
 void acpi_set_irq_model(enum acpi_irq_model_id model,
-			struct fwnode_handle *(*)(u32));
+	acpi_gsi_domain_disp_fn fn);
+acpi_gsi_domain_disp_fn acpi_get_gsi_dispatcher(void);
 void acpi_set_gsi_to_irq_fallback(u32 (*)(u32));
 
 struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
-- 
2.43.0


