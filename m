Return-Path: <linux-pci+bounces-14311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F3C99A3BE
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 14:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D278287E7B
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DDF1F9415;
	Fri, 11 Oct 2024 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtSPV42p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838DB1BDAA1
	for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728649201; cv=none; b=LEdGFqeZeCrGYLNUtTeOhgwBI8N+Y3sn9wKZN/RXCb1YSkmTpv1tlDMuBw4HXDt/w6aKGvIu4ef1rSOZQHXszYvNjkUnBeAjFzPVSinAjU+4jz4SCR9g0bmlRKS4ZhshWX10V55Gv4K11UexjizF9mWmyqD7EcHZQ2uqjyYOmRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728649201; c=relaxed/simple;
	bh=oPxanfHmqSGpINPKSIFc4wvoW0qyQNZj9s2w5ak3H0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVLYEO1TYpy0ivt9fzT/Ia42bvNMuPbd6qFLOpu59cQDAqjGvCaI/GRY/9To2XjQWMUZBEG9KCfUjeWGD+jqLvh3LlnxC4ambsBf3unJz+26jG6ckI/X78mFC4D4t1XzT8iDZ5xVxagy3quT1gsHZgvmVorX1YPql3OfxqohDSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtSPV42p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BA7C4CED0;
	Fri, 11 Oct 2024 12:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728649201;
	bh=oPxanfHmqSGpINPKSIFc4wvoW0qyQNZj9s2w5ak3H0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YtSPV42p36ky9dlF8FFAm4SVoynaMBWrMpjJrv5nL75vkCcO3lf4ksfwd4gUwot7L
	 abaXVfrihGNk7WAp9tb9tsjjsyg8fo8TQePMsgZUU6Ps26dTj7S2Qsb+VLwhbSmObJ
	 z02RtWreHE4xkPB9AtkKFHUT7By+Z4etfsP+i+5tWQwlLdp6QewCXtLzL2svYsPqxm
	 87azbLcyvzpbmTXs0Bxp6a3Ew1XsQ4sjEBsbPmkJeL/jLtwqdTTYqbV851zfdYn9S0
	 3TQAePsuwp8RpjF0AKCETj3EvLoaULvzzBnzEEOb/CFmBIGe1Oys/v2Fs9B12cdsx5
	 bJnLAnJUzi4jg==
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
Subject: [PATCH v2 3/5] nvmef: Introduce the NVME_OPT_HIDDEN_NS option
Date: Fri, 11 Oct 2024 21:19:49 +0900
Message-ID: <20241011121951.90019-4-dlemoal@kernel.org>
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

Introduce the NVME fabrics option NVME_OPT_HIDDEN_NS to allow a host
controller to be created without any user visible or internally usable
namespace devices. That is, if set, this option will result in the
controller having no character device and no block device for any of its
namespaces.

This option should be used only when the nvme controller will be
managed using passthrough commands using the controller character
device, either by the user or by another device driver.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/host/core.c    | 17 ++++++++++++++---
 drivers/nvme/host/fabrics.c |  7 ++++++-
 drivers/nvme/host/fabrics.h |  4 ++++
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 43d73d31c66f..6559e1028685 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1714,11 +1714,17 @@ static void nvme_enable_aen(struct nvme_ctrl *ctrl)
 	queue_work(nvme_wq, &ctrl->async_event_work);
 }
 
+static inline bool nvme_hidden_ns(struct nvme_ctrl *ctrl)
+{
+	return ctrl->opts && ctrl->opts->hidden_ns;
+}
+
 static int nvme_ns_open(struct nvme_ns *ns)
 {
 
 	/* should never be called due to GENHD_FL_HIDDEN */
-	if (WARN_ON_ONCE(nvme_ns_head_multipath(ns->head)))
+	if (WARN_ON_ONCE(nvme_ns_head_multipath(ns->head) ||
+			 nvme_hidden_ns(ns->ctrl)))
 		goto fail;
 	if (!nvme_get_ns(ns))
 		goto fail;
@@ -3828,6 +3834,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	disk->fops = &nvme_bdev_ops;
 	disk->private_data = ns;
 
+	if (nvme_hidden_ns(ctrl))
+		disk->flags |= GENHD_FL_HIDDEN;
+
 	ns->disk = disk;
 	ns->queue = disk->queue;
 	ns->ctrl = ctrl;
@@ -3879,7 +3888,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	if (device_add_disk(ctrl->device, ns->disk, nvme_ns_attr_groups))
 		goto out_cleanup_ns_from_list;
 
-	if (!nvme_ns_head_multipath(ns->head))
+	if (!nvme_ns_head_multipath(ns->head) &&
+	    !nvme_hidden_ns(ctrl))
 		nvme_add_ns_cdev(ns);
 
 	nvme_mpath_add_disk(ns, info->anagrpid);
@@ -3945,7 +3955,8 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	/* guarantee not available in head->list */
 	synchronize_srcu(&ns->head->srcu);
 
-	if (!nvme_ns_head_multipath(ns->head))
+	if (!nvme_ns_head_multipath(ns->head) &&
+	    !nvme_hidden_ns(ns->ctrl))
 		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
 	del_gendisk(ns->disk);
 
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index e3c990d50704..64e95727ae2a 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -707,6 +707,7 @@ static const match_table_t opt_tokens = {
 #ifdef CONFIG_NVME_TCP_TLS
 	{ NVMF_OPT_TLS,			"tls"			},
 #endif
+	{ NVMF_OPT_HIDDEN_NS,		"hidden_ns"		},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -1053,6 +1054,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			opts->tls = true;
 			break;
+		case NVMF_OPT_HIDDEN_NS:
+			opts->hidden_ns = true;
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
@@ -1274,7 +1278,8 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
 				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
 				 NVMF_OPT_DISABLE_SQFLOW | NVMF_OPT_DISCOVERY |\
 				 NVMF_OPT_FAIL_FAST_TMO | NVMF_OPT_DHCHAP_SECRET |\
-				 NVMF_OPT_DHCHAP_CTRL_SECRET)
+				 NVMF_OPT_DHCHAP_CTRL_SECRET | \
+				 NVMF_OPT_HIDDEN_NS)
 
 struct nvme_ctrl *nvmf_create_ctrl(struct device *dev, const char *buf)
 {
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 2dd3aeb8c53a..5388610e475d 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -66,6 +66,7 @@ enum {
 	NVMF_OPT_TLS		= 1 << 25,
 	NVMF_OPT_KEYRING	= 1 << 26,
 	NVMF_OPT_TLS_KEY	= 1 << 27,
+	NVMF_OPT_HIDDEN_NS	= 1 << 28,
 };
 
 /**
@@ -108,6 +109,8 @@ enum {
  * @nr_poll_queues: number of queues for polling I/O
  * @tos: type of service
  * @fast_io_fail_tmo: Fast I/O fail timeout in seconds
+ * @fast_io_fail_tmo: Fast I/O fail timeout in seconds
+ * @hide_dev: Hide block devices for the namesapces of the controller
  */
 struct nvmf_ctrl_options {
 	unsigned		mask;
@@ -133,6 +136,7 @@ struct nvmf_ctrl_options {
 	bool			disable_sqflow;
 	bool			hdr_digest;
 	bool			data_digest;
+	bool			hidden_ns;
 	unsigned int		nr_write_queues;
 	unsigned int		nr_poll_queues;
 	int			tos;
-- 
2.47.0


