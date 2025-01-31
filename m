Return-Path: <linux-pci+bounces-20604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F58A24297
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 19:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB851888FFA
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 18:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BED71E3784;
	Fri, 31 Jan 2025 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OR+pqsl8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EE87081F
	for <linux-pci@vger.kernel.org>; Fri, 31 Jan 2025 18:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738348224; cv=none; b=HcTtDyPAKj2TNWTwI1sqmdrLPE0DceSfOAIjTv5IOjk3Unuakc/XtMJdL4W5Nk5B6GwP5hFPwpaV0PsCdkwiqnVmi/wwVfeNCVj5QB9Baq3NQt2oXXv34YaF6tvrGRj0xKGveECwVxURm1D7AhV7V6EWESKBeiDmK/493PstLCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738348224; c=relaxed/simple;
	bh=qqKbQsnS1YsboZzTev6G2t0ujPW9WQvQtYPjJ5GZ0zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUKL4hXxyylSDh5mCwCRpFOBtMqxf4rkEjxoaHspy/mXZ5dki8X8g/MQ55D7AoAzWzsbO71I/5EUy1RgbraMjJc279sqt5kNjY0mu1h787KDpdCjvsPnQTJ/oRpinSU1tDMcXy1mXdNQT1sEuvNDc4mNcIGmd8Msv7dapvWIk6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OR+pqsl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CC7C4CED1;
	Fri, 31 Jan 2025 18:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738348223;
	bh=qqKbQsnS1YsboZzTev6G2t0ujPW9WQvQtYPjJ5GZ0zI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OR+pqsl8PvzQMRwFIVBZdYsChlTCLMiRthGBGyAYGphaoHUHgjg5xjaUSby4sZ6pE
	 2UdoCvrmNjdiuPTiPjcCamOnZNtnliIXcQ4VUPNYjF1qAiQwPgHufqhLo3zhU1dSxU
	 Z+MV4V8y5N3zC/hNATeo3TMS5gBqciZEi5Ov/TOx5pfYr2EgKHY60j5bMPqiLRdIfE
	 gn1IV5Z75lD5A9KS/fUSm5vLJwIjIikOrhatEvEp7KET5WEYn/fEg+J00GV5MSazdf
	 Ow3j8H2nxgkkHCafjv2G03FFEX7fJRRQYrWRn0HXDUj+4hejLAFROM/f6FPZyglwJx
	 l9JjE/MmFmQoQ==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 2/7] PCI: endpoint: Add pci_epc_bar_size_to_rebar_cap()
Date: Fri, 31 Jan 2025 19:29:51 +0100
Message-ID: <20250131182949.465530-11-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131182949.465530-9-cassel@kernel.org>
References: <20250131182949.465530-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2290; i=cassel@kernel.org; h=from:subject; bh=qqKbQsnS1YsboZzTev6G2t0ujPW9WQvQtYPjJ5GZ0zI=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLniq06nT0/9NA+MbFHb4IFuPb+aDr1NjZMy0FE9CK/Y KRXgFBLRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACZiq8nwm01o/psMt8/fXjx+ 1RR8ReTD4QbHuWf3nDSc+vHxrMeV1ZMYfrNMZ53W2PaKMyAvc70V26PaVxG/TWzeF7441P3OS/F HBQMA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Add a helper function to convert a size to the representation used by the
Resizable BAR Capability Register.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 27 +++++++++++++++++++++++++++
 include/linux/pci-epc.h             |  1 +
 2 files changed, 28 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 10dfc716328e..5d6aef956b13 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -638,6 +638,33 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 }
 EXPORT_SYMBOL_GPL(pci_epc_set_bar);
 
+/**
+ * pci_epc_bar_size_to_rebar_cap() - convert a size to the representation used
+ *				     by the Resizable BAR Capability Register
+ * @size: the size to convert
+ * @cap: where to store the result
+ *
+ * Returns 0 on success and a negative error code in case of error.
+ */
+int pci_epc_bar_size_to_rebar_cap(size_t size, u32 *cap)
+{
+	/*
+	 * According to PCIe base spec, min size for a resizable BAR is 1 MB,
+	 * thus disallow a requested BAR size smaller than 1 MB.
+	 * Disallow a requested BAR size larger than 128 TB.
+	 */
+	if (size < SZ_1M || (u64)size > (SZ_128G * 1024))
+		return -EINVAL;
+
+	*cap = ilog2(size) - ilog2(SZ_1M);
+
+	/* Sizes in REBAR_CAP start at BIT(4). */
+	*cap = BIT(*cap + 4);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epc_bar_size_to_rebar_cap);
+
 /**
  * pci_epc_write_header() - write standard configuration header
  * @epc: the EPC device to which the configuration header should be written
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 91ce39dc0fd4..713348322dea 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -275,6 +275,7 @@ void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
 			enum pci_epc_interface_type type);
 int pci_epc_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			 struct pci_epf_header *hdr);
+int pci_epc_bar_size_to_rebar_cap(size_t size, u32 *cap);
 int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		    struct pci_epf_bar *epf_bar);
 void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
-- 
2.48.1


