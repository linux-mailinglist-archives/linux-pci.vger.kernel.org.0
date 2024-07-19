Return-Path: <linux-pci+bounces-10547-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5905F937761
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 13:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA2CF1F21056
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 11:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F0512C550;
	Fri, 19 Jul 2024 11:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCNWCjcv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B996012C48A;
	Fri, 19 Jul 2024 11:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721390297; cv=none; b=EY7zvyevDGJ2ffgr0Iy05sAoz3ycdIP/shQmI8zKjCxHtLWfL3DWPW/nmwi5BNQ/wZMxAcA7hshB3+sKfY75iLiPlasR71AGWoOuOSazHx3Xu6mIlcCv/+LewCAq6uTx8ck9vkOezdqtgbSTNaFWEPE09q9qwAAngtHKgbNITzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721390297; c=relaxed/simple;
	bh=nGmCtyaoo/NenZbRAcwq02lmK89X8ME9OviEr2cgy0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ojx64snooKdgsWC+bhuD8RBNZ7G1gjT2GeDqARlSMSlrMWdUbdcCkIuCr5Cjao42DYm5Uk5JspC3GEXsqTNm10KdL6wu7iH/lJ1dxjifU67j6TPXZgrxcDi0i5wkq8hIwdVhJd+cQuADB+QpIhpKy2s2jhXN3hFC/LWImOaRCRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCNWCjcv; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eea8ea8bb0so35499671fa.1;
        Fri, 19 Jul 2024 04:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721390294; x=1721995094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ndYd3/BRas2vcGoQPROgeJBUT+iVBkkW19vxoWstj8=;
        b=LCNWCjcvfR758kQXRcwxWY9hHdUrIqDhuW8DFGFAYsfUCFvPa6pvbDDTknSmc2xqSg
         di9EJ2S7MUEHJVP+Xl/fIABPa5shmlhwPCTr/FUa4TNyeXKyPvc0LJppbVveKBir/cJU
         jKPXtDa98Kn4Tr+wQI3m2mP31n85dnSgR2TxD4elPALoCYaVjvNCJ4OK78JXu00ew/zF
         7wegWZLhZ6lxXNHIMH4bdqizJXo75/vScP98vHNdAKhhwa83oJgrLxcyeEx3+QUb5uCP
         GlC6dHvHZ+dfJ08/IGIi7wZXRrOE0lDprXs4GSZoumoYlPCiiIbNeYCoLeh4L83oS/oh
         diwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721390294; x=1721995094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ndYd3/BRas2vcGoQPROgeJBUT+iVBkkW19vxoWstj8=;
        b=AZftq04DSzVtTMEYHDL0CXDcJDT/iJ5FsL+qQBB5Z8VV0yjr5qYzndKAlaYeApYlEV
         SD60MLQgnx3Pal1Nfuep8kDvrEDIu7ia7FSVwNEk8uFQ8JgIg76QuJNj2xycFa3WZtof
         I55c6VKTZmnaRjPA8NA5Z/YP1c9pWygCQEFMgOBaG8aRROq/w0Rc+mw4D1BDC6jBvKQ7
         OEDHdcsUl0SdsyjBp89RrAXw9pPrVgvtFYObPHJdmpnTmnsCc+PdkCNJ9N2CqRxzhLR4
         lqKVJAErvUOi9OP/Sw22JIiVZBokHXG6D/E66NF1T/vZ0oe3es+UTJjS337E1Wd0gM5h
         /lrw==
X-Forwarded-Encrypted: i=1; AJvYcCV+szmb8Yjhrns9A5ShM3pLw1XeK0sPuzDKXziKsEkHAWCUkDV59E6pgqHdcqfyWp3mRXUE0XSBxvBfjBrnTkclCrBlvYWzSUtT33p0TEi56+36dy8oJIUp9pmTZg73npBarUItuCQB
X-Gm-Message-State: AOJu0YynXt3UzBD+V37DxphNSfKgZ0dwxB6viJ8EU69AFTzqdG2wjo/Q
	kbJQSn5csU25w9Axyx+CQgV7LUEUzyq0fY9Se1Ty3Oe60HX4GIdr
X-Google-Smtp-Source: AGHT+IEK7y+j95P+ubpLkTdvJX5WZ7sJ8PWs/Q7ObGPtB2V2NOiCCg/AXRNfHFsMD5z0rFqnKV0wmw==
X-Received: by 2002:a2e:3610:0:b0:2ee:87b9:91a8 with SMTP id 38308e7fff4ca-2ef05c7393emr41859111fa.19.1721390293781;
        Fri, 19 Jul 2024 04:58:13 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5a30c2f869dsm1093824a12.65.2024.07.19.04.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 04:58:13 -0700 (PDT)
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
To: rick.wertenbroek@heig-vd.ch
Cc: damien.lemoal@kernel.org,
	alberto.dassatti@heig-vd.ch,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PCI: endpoint: Introduce 'get_bar' to map fixed address BARs in EPC
Date: Fri, 19 Jul 2024 13:57:38 +0200
Message-Id: <20240719115741.3694893-2-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240719115741.3694893-1-rick.wertenbroek@gmail.com>
References: <20240719115741.3694893-1-rick.wertenbroek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current mechanism for BARs is as follows: The endpoint function
allocates memory with 'pci_epf_alloc_space' which calls
'dma_alloc_coherent' to allocate memory for the BAR and fills a
'pci_epf_bar' structure with the physical address, virtual address,
size, BAR number and flags. This 'pci_epf_bar' structure is passed
to the endpoint controller driver through 'set_bar'. The endpoint
controller driver configures the actual endpoint to reroute PCI
read/write TLPs to the BAR memory space allocated.

The problem with this is that not all PCI endpoint controllers can
be configured to reroute read/write TLPs to their BAR to a given
address in memory space. Some PCI endpoint controllers e.g., FPGA
IPs for Intel/Altera and AMD/Xilinx PCI endpoints. These controllers
come with pre-assigned memory for the BARs (e.g., in FPGA BRAM),
because of this the endpoint controller driver has no way to tell
these controllers to reroute the read/write TLPs to the memory
allocated by 'pci_epf_alloc_space' and no way to get access to the
memory pre-assigned to the BARs through the current API.

Therefore, introduce 'get_bar' which allows to get access to a BAR
without calling 'pci_epf_alloc_space'. Controllers with pre-assigned
bars can therefore implement 'get_bar' which will assign the BAR
pyhsical address, virtual address through ioremap, size, and flags.

PCI endpoint functions can query the endpoint controller through the
'fixed_addr' boolean in the 'pci_epc_bar_desc' structure. Similarly
to the BAR type, fixed size or fixed 64-bit descriptions. With this
information they can either call 'pci_epf_alloc_space' and 'set_bar'
as is currently the case, or call the new 'get_bar'. Both will provide
a working, memory mapped BAR, that can be used in the endpoint
function.

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 37 +++++++++++++++++++++++++++++
 include/linux/pci-epc.h             |  7 ++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 84309dfe0c68..fcef848876fe 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -544,6 +544,43 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 }
 EXPORT_SYMBOL_GPL(pci_epc_set_bar);
 
+/**
+ * pci_epc_get_bar - get BAR configuration from a fixed address BAR
+ * @epc: the EPC device on which BAR resides
+ * @func_no: the physical endpoint function number in the EPC device
+ * @vfunc_no: the virtual endpoint function number in the physical function
+ * @bar: the BAR number to get
+ * @epf_bar: the struct epf_bar to fill
+ *
+ * Invoke to get the configuration of the endpoint device fixed address BAR
+ */
+int pci_epc_get_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+		    enum pci_barno bar, struct pci_epf_bar *epf_bar)
+{
+	int ret;
+
+	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
+		return -EINVAL;
+
+	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
+		return -EINVAL;
+
+	if (bar < 0 || bar >= PCI_STD_NUM_BARS)
+		return -EINVAL;
+
+	if (!epc->ops->get_bar)
+		return -EINVAL;
+
+	epf_bar->barno = bar;
+
+	mutex_lock(&epc->lock);
+	ret = epc->ops->get_bar(epc, func_no, vfunc_no, bar, epf_bar);
+	mutex_unlock(&epc->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_get_bar);
+
 /**
  * pci_epc_write_header() - write standard configuration header
  * @epc: the EPC device to which the configuration header should be written
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 85bdf2adb760..a5ea50dd49ba 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -37,6 +37,7 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
  * @write_header: ops to populate configuration space header
  * @set_bar: ops to configure the BAR
  * @clear_bar: ops to reset the BAR
+ * @get_bar: ops to get a fixed address BAR that cannot be set/cleared
  * @map_addr: ops to map CPU address to PCI address
  * @unmap_addr: ops to unmap CPU address and PCI address
  * @set_msi: ops to set the requested number of MSI interrupts in the MSI
@@ -61,6 +62,8 @@ struct pci_epc_ops {
 			   struct pci_epf_bar *epf_bar);
 	void	(*clear_bar)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			     struct pci_epf_bar *epf_bar);
+	int	(*get_bar)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			   enum pci_barno, struct pci_epf_bar *epf_bar);
 	int	(*map_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			    phys_addr_t addr, u64 pci_addr, size_t size);
 	void	(*unmap_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
@@ -163,6 +166,7 @@ enum pci_epc_bar_type {
  * struct pci_epc_bar_desc - hardware description for a BAR
  * @type: the type of the BAR
  * @fixed_size: the fixed size, only applicable if type is BAR_FIXED_MASK.
+ * @fixed_addr: indicates that the BAR has a fixed address in memory map.
  * @only_64bit: if true, an EPF driver is not allowed to choose if this BAR
  *		should be configured as 32-bit or 64-bit, the EPF driver must
  *		configure this BAR as 64-bit. Additionally, the BAR succeeding
@@ -176,6 +180,7 @@ enum pci_epc_bar_type {
 struct pci_epc_bar_desc {
 	enum pci_epc_bar_type type;
 	u64 fixed_size;
+	bool fixed_addr;
 	bool only_64bit;
 };
 
@@ -238,6 +243,8 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		    struct pci_epf_bar *epf_bar);
 void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		       struct pci_epf_bar *epf_bar);
+int pci_epc_get_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+		    enum pci_barno, struct pci_epf_bar *epf_bar);
 int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		     phys_addr_t phys_addr,
 		     u64 pci_addr, size_t size);
-- 
2.25.1


