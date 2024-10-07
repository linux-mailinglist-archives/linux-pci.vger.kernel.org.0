Return-Path: <linux-pci+bounces-13926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7678B9923AF
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 06:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7721F21E76
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 04:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4CE132111;
	Mon,  7 Oct 2024 04:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fI3mIYwa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC20A43ABC
	for <linux-pci@vger.kernel.org>; Mon,  7 Oct 2024 04:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728276238; cv=none; b=QYoOCiquz6UHV36DyVtyTc1k5pwpQscyoTYTeEZlQLR41S8psvJNzGptpw5WAFXE89WBN8wwiXxcRBeYxv2VFfheTIKvFny0P1IJ9R3ppzDo+p8gj88y671PxXWGEzvJvQXVK5tJke9acotlOA9M/v2C3qTk/Gec1gQrIEW80Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728276238; c=relaxed/simple;
	bh=ksVCnorPjWn7+AyFB7R0NeXDZPsR2eZvsmvQ/R3OnJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGVuFiTdfD7hkANigCf5hbuqh7ayW01JGaKiz3RdFqnGkBD4Kss6nQPnNv7cUD8auo5haVU5r2hgHIorM4C6Sv2MRN3IAi06wvtqy148vSSte5OtJ16hsoC3ciQrQVcv8YIvDeSklhtm3coJ+uWG10qzxXK1asDMP5leXPKz1K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fI3mIYwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A49BC4CECF;
	Mon,  7 Oct 2024 04:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728276237;
	bh=ksVCnorPjWn7+AyFB7R0NeXDZPsR2eZvsmvQ/R3OnJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fI3mIYwaOgSApf8p5+di9x584jUdgCpNG/mpOyYjW5/o379m7Kt4/yxGUG4pTXyLv
	 X34LeUK67xZFsdFgtTiXS8XagLNUba5vRr3Q5sN8a513B8YyzXLxYepuS55uHWhgf7
	 Ascrknql9LYK2ew1Im+gatjFsp3zBCnbSGmvkhqrmAuIsOybuU8O+FuEJpfBkDGpzz
	 Gq1xd+qCyQLoznx1YTqeGmrBaOTLqDZ0UEg1JABH8LJtViL7xZKmC/JGB0At4IuWrq
	 sjyi26kl99KZtPLVFzJW/03yRLNvRs+vPXvMBFBH7EOZq2zmMCF0qq77L4Nj+eOHPl
	 aNwlcROvIC9vQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v1 2/5] nvmef: export nvmef_create_ctrl()
Date: Mon,  7 Oct 2024 13:43:48 +0900
Message-ID: <20241007044351.157912-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007044351.157912-1-dlemoal@kernel.org>
References: <20241007044351.157912-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export nvmef_create_ctrl() to allow drivers to directly call this
function instead of forcing the creation of a fabrics host controller
with a write to /dev/nvmef. The export is restricted to the NVME_FABRICS
namespace.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/host/fabrics.c | 4 ++--
 drivers/nvme/host/fabrics.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 432efcbf9e2f..e3c990d50704 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1276,8 +1276,7 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
 				 NVMF_OPT_FAIL_FAST_TMO | NVMF_OPT_DHCHAP_SECRET |\
 				 NVMF_OPT_DHCHAP_CTRL_SECRET)
 
-static struct nvme_ctrl *
-nvmf_create_ctrl(struct device *dev, const char *buf)
+struct nvme_ctrl *nvmf_create_ctrl(struct device *dev, const char *buf)
 {
 	struct nvmf_ctrl_options *opts;
 	struct nvmf_transport_ops *ops;
@@ -1346,6 +1345,7 @@ nvmf_create_ctrl(struct device *dev, const char *buf)
 	nvmf_free_options(opts);
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_NS_GPL(nvmf_create_ctrl, NVME_FABRICS);
 
 static const struct class nvmf_class = {
 	.name = "nvme-fabrics",
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 21d75dc4a3a0..2dd3aeb8c53a 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -214,6 +214,7 @@ static inline unsigned int nvmf_nr_io_queues(struct nvmf_ctrl_options *opts)
 		min(opts->nr_poll_queues, num_online_cpus());
 }
 
+struct nvme_ctrl *nvmf_create_ctrl(struct device *dev, const char *buf);
 int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val);
 int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val);
-- 
2.46.2


