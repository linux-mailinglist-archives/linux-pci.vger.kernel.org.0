Return-Path: <linux-pci+bounces-19347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE28A02DD2
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 17:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7343A5439
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 16:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7031DE89C;
	Mon,  6 Jan 2025 16:31:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8151DA112;
	Mon,  6 Jan 2025 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181063; cv=none; b=L/KCi7u/vQNEJduHU8goPVytCoA7wse/Gve5tUwgf0g38I9bnZr3hk+fXxipkWI5TbHx5cdU8Km3qo2iF9dxZlUvuKP4L6FJTdycj3B72WEp59zWT9mmvIynQIcnuw2t0DE15OPw8UJrot7V5y7KpPJX3eQXtdpLJHa+ucROJgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181063; c=relaxed/simple;
	bh=T+P1wly3cBwmrhrI1N5TjmUvzX2hyNJrRZzK7hGIWAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0lTLVhWwa4qECP7i0jeMz6S7VOIlJYbMzwryHPd17yJREMfvd4Y2nRrOYW4gjPkmwrmPeQTQDZ6AEQuD9OxT6gKE+mkvp3ReuNtN1+rRy4Cejg2QcBgQa5EX2N6lvrUOF7i50PhwqIF5mq7afi7oIplpLacOB3dwYxAXmKrCwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DE0616F2;
	Mon,  6 Jan 2025 08:31:28 -0800 (PST)
Received: from ampere-altra-2-1.usa.arm.com (ampere-altra-2-1.usa.arm.com [10.118.91.158])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E48B33F673;
	Mon,  6 Jan 2025 08:30:59 -0800 (PST)
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
To: linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lenb@kernel.org,
	robert.moore@intel.com,
	bhelgaas@google.com
Cc: wei.huang2@amd.com,
	honnappa.nagarahalli@arm.com,
	dhruv.tripathi@arm.com,
	rob.herring@arm.com,
	jeremy.linton@arm.com,
	Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [RFC PATCH 2/2] PCI: Add generic netlink interface to TPH _DSM
Date: Mon,  6 Jan 2025 16:30:45 +0000
Message-ID: <20250106163045.508959-3-wathsala.vithanage@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250106163045.508959-1-wathsala.vithanage@arm.com>
References: <20250106163045.508959-1-wathsala.vithanage@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Applications capable of configuring direct cache injection for PCIe
devices from the user space require steering tags extracted from the
PCIe root port’s TPH _DSM method. This patch exposes the TPH _DSM method
via the ACPI GENL interface for such applications. The messages sent
over the GNEL interface querying PCIe steering tags should be prefixed
with an acpi_genl_dsm_id header and PCI domain, slot, and function
information, as shown in the message format diagram. PKG ARG0, ARG1, and
ARG2 correspond to input structures defined in PCIe firmware
specification ECN titled "Revised _DSM for Cache Locality TPH Features."

    0       1       2       3       4       5       6       7
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                                                               |
   +                     acpi_genl_dsm_id header                   +
   |                                                               |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
16 |           PCI DOMAIN          |           PCI SLOT            |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |           PCI DEVFN           |           PKG ARG0            |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |           PKG ARG1            |           PKG ARG2            |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                               |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

Kernel responds via the same GENL socket with the steering tag info
and a status code in the following format. Steering tag info is the same
structure returned by TPH _DSM of the root port as specified in the PCI
firmware specification ECN titled "Revised _DSM for Cache Locality TPH
Features."

    0       1       2       3       4       5       6       7
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                                                               |
   +                     acpi_genl_dsm_id header                   +
   |                                                               |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
16 |            Status             |       Steering Tag Info       |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                               |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

The status code is always 0 for successful invocations of the _DSM.
Status is -EINVAL, -ENODEV, or -EOPNOTSUPP if ACPI or TPH is disabled,
No PCI device found or TPH is not supported respectively.

Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
---
 drivers/pci/tph.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 1e604fbbda65..8a70b663cb78 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -53,6 +53,36 @@ union st_info {
 	u64 value;
 };
 
+/*
+ * The tph_genl_dsm_info struct defines both the input and the return container
+ * for Generic Netlink interface of the TPH _DSM of PCIe root ports.
+ */
+struct tph_genl_dsm_info {
+	/* _DSM method identfier {GUID, REV, FUNCTION-INDEX}*/
+	struct acpi_genl_dsm_id id;
+	union {
+		struct {
+			/* bus, dev, devfn of the PCIe device */
+			int bus;
+			u32 dev;
+			u32 devfn;
+			/*
+			 * args for the TPH _DSM of the PCIe root-port of
+			 * the specified device.
+			 */
+			u32 pkg_arg0;
+			u32 pkg_arg1;
+			u64 pkg_arg2;
+		} arg;
+		struct {
+			/* return status */
+			int status;
+			/* st_info returned by the PCIe root-port TPH _DSM */
+			union st_info st;
+		} ret;
+	} info;
+};
+
 static u16 tph_extract_tag(enum tph_mem_type mem_type, u8 req_type,
 			   union st_info *info)
 {
@@ -130,6 +160,95 @@ static acpi_status tph_invoke_dsm(acpi_handle handle, u32 cpu_uid,
 
 	return AE_OK;
 }
+
+static int tph_invoke_dsm_genl_cb(struct acpi_genl_dsm_id *in,
+				  struct acpi_genl_dsm_id *out)
+{
+	struct pci_dev *pdev, *pdev_rp;
+	acpi_handle handle;
+	u32 cpu_uid;
+	int status = 0;
+
+	struct tph_genl_dsm_info *arg = (struct tph_genl_dsm_info *)in;
+	struct tph_genl_dsm_info *ret = (struct tph_genl_dsm_info *)out;
+
+	/* Honor  notph and acpi kernel parameters */
+	if (acpi_disabled || acpi_pci_disabled || pci_tph_disabled) {
+		status = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * pkg_arg1 contains the kernel logical CPU id provided by the user,
+	 * make sure it's a valid CPU id before passing it to down to firmware.
+	 * pkg_arg2 is not use by tph_invoke_dsm, hence no validation is
+	 * required.
+	 */
+	if (!(arg->info.arg.pkg_arg1 < nr_cpu_ids &&
+	    cpu_present(arg->info.arg.pkg_arg1))) {
+		status = -EINVAL;
+		goto out;
+	}
+
+	cpu_uid = topology_core_id(arg->info.arg.pkg_arg1);
+
+	ret->id.guid = pci_acpi_dsm_guid;
+	ret->id.rev = 7;
+	ret->id.func = TPH_ST_DSM_FUNC_INDEX;
+
+	pdev = pci_get_domain_bus_and_slot(arg->info.arg.bus, arg->info.arg.dev,
+					   arg->info.arg.devfn);
+	if (!pdev) {
+		status = -ENODEV;
+		goto out;
+	}
+
+	pdev_rp = pcie_find_root_port(pdev);
+	if (!pdev_rp || !pdev_rp->bus || !pdev_rp->bus->bridge) {
+		status = -ENODEV;
+		goto out;
+	}
+
+	handle = ACPI_HANDLE(pdev_rp->bus->bridge);
+
+	if (tph_invoke_dsm(handle, arg->info.arg.pkg_arg1, &ret->info.ret.st) !=
+			   AE_OK) {
+		status = -EOPNOTSUPP;
+		goto out;
+	}
+out:
+	ret->info.ret.status = status;
+	return 0;
+}
+
+static int tph_register_genl_cb(void)
+{
+	int err = 0;
+	struct acpi_genl_dsm_handle *handle =
+		kzalloc(sizeof(struct acpi_genl_dsm_handle), GFP_ATOMIC);
+	if (!handle) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	handle->id.guid = pci_acpi_dsm_guid;
+	handle->id.rev  = 7;
+	handle->id.func = TPH_ST_DSM_FUNC_INDEX;
+	handle->arg_len = sizeof(struct tph_genl_dsm_info);
+	handle->ret_len = sizeof(struct tph_genl_dsm_info);
+	handle->dsm_cb  = tph_invoke_dsm_genl_cb;
+	handle->cap     = CAP_SYS_ADMIN;
+
+	err = acpi_genl_dsm_add_handle(handle);
+	if (err) {
+		kfree(handle);
+		goto out;
+	}
+out:
+	return err;
+}
+
+late_initcall(tph_register_genl_cb);
 #endif
 
 /* Update the TPH Requester Enable field of TPH Control Register */
-- 
2.43.0


