Return-Path: <linux-pci+bounces-14310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0CE99A3BD
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 14:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1DF41F2636D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8014A217314;
	Fri, 11 Oct 2024 12:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcGXmSZ5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C72D215026
	for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 12:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728649199; cv=none; b=pkvEfirzZbVWfNWXXg8qTbEB930+vb8iYXVLJ9nXyTdwOzz0+5IfjdyfZPri7v5XVlpEqrUtaNHCNxueC8wlO0aNG+dNT7INVfowrbVYs2pc8cO9ZmQYIJrE/AhYj3FdkoZrO0xVz49qzO6d4ERM7uG1G4OJJeoQY3xCVq1fVDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728649199; c=relaxed/simple;
	bh=USrx1eSbx00KxGW5SNsqKGkCfe9T8LfwHwehSbOrR1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lb2SOUVdevCivZ1UnB1pfFd+Y1AjgQmR0eHpeuuCHMrP0aMrSpje956AOzQxc8hP72525Z5SAnWXL2VC6z705IRpVhprO/zxKXXpoVAnt+BripDJW1Jm4tLuiHIQJHCUWzKMzwm59aAtPRezIxvGzlSkufGuLDrhcxqMhx32PnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcGXmSZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F006C4CECF;
	Fri, 11 Oct 2024 12:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728649198;
	bh=USrx1eSbx00KxGW5SNsqKGkCfe9T8LfwHwehSbOrR1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XcGXmSZ5EBdyza640mDUbyYFCHJvq6TMDw8IAWU758p7dl/BSOWqNRNZyd9UGI3lJ
	 nC/Ukp2LR8pFOUI6a0J8ZF0o236l0qyZjtGMBguHNp7uhQ5YXSsDKotCD+yXK8WyMg
	 LvXrSFHlR1IPfdb02QSUKinQVmICK2jKXjI4+nVqqjOz82xPOfcQAXMgTa0ZOkdGEW
	 0c4UpPQyH4cp6xjG68G4yIBiu5zDJMhfvUEmnENbKugPuxKzvKyaP+2AASFX4C4M5x
	 TH+cv63Gq91FtIgeRIByVI8bxYNGQZzYHq7omHm9BTteTWlbZo1+xAEmW1PgWRmpjm
	 dBq0nWJIyrGGg==
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
Subject: [PATCH v2 2/5] nvmef: export nvmef_create_ctrl()
Date: Fri, 11 Oct 2024 21:19:48 +0900
Message-ID: <20241011121951.90019-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011121951.90019-1-dlemoal@kernel.org>
References: <20241011121951.90019-1-dlemoal@kernel.org>
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
2.47.0


