Return-Path: <linux-pci+bounces-18003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BFC9EAC6A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 10:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116E128BCC0
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 09:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061E722331D;
	Tue, 10 Dec 2024 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnt3De4D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D628422331A
	for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823287; cv=none; b=ZY2MsiBd6ih2a0BSwDbiovC/BzZRxP1vOretMW+Ho8qVzd1kGP64x7dIUZ+Qf1d/6+thMleoncbIZ3sCGWNl/oHqmKu5gygfipZhDrhj4fJQvbGJ1iHMDQMfxukRjpsFQUie734s1yEceBCPTdolDdIZaZQqFCIjlq/fNGHfV0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823287; c=relaxed/simple;
	bh=ymQPMrexDXM7rhDRBES8iekLUnPyugTUnBCTpQeYkCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Joi5bGl7Z2hYBHqWYBE5VhS1gNkdDZ/UxfWoKhTBlUUjIQ7KehRgPqa5k4IpFStCJd+7W+DBR4NPKhOrehsdyk0IB2qMjpXy4d42Jq8JtU+FqtqVDDUcr4GD+n9Oj59wpKmuVm8I8TFXICopMibjkn7pAtTQkPqgVyfLA7t2lOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnt3De4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2E1C4CEDD;
	Tue, 10 Dec 2024 09:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733823287;
	bh=ymQPMrexDXM7rhDRBES8iekLUnPyugTUnBCTpQeYkCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jnt3De4DRfjV0E9gX2o/d5BuCqGGy65SuGNzSZ06iDWNjkc8YXlEEA34n7Jz7Crnq
	 RyR81mnbp0a9btcMTSEnPZjApOuRXKrXwbRfFxabIKmFndUdJRTFWF2KNJoPi1mAVm
	 FxvfrEhl568dpqjQ80himhmAONDV4YFM0ilbnSSu3UvWU25/MCiXds5eW0CsVP+eVv
	 DRcqYwRwjzbbEaH8+Zk1hI+GPSkjobWRpF6HgvAYzMPY53Q4xy6xi4KS0XBvTf3INv
	 v4bspqMX8THLJDA+jrWGiuhMupvzep71gH+1bVEzxzbm53XCx+fLizTzhZKT8WNxGl
	 RpqPj9la0a0gw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 05/17] nvme: Add PCI transport type
Date: Tue, 10 Dec 2024 18:33:56 +0900
Message-ID: <20241210093408.105867-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210093408.105867-1-dlemoal@kernel.org>
References: <20241210093408.105867-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define the transport type NVMF_TRTYPE_PCI for PCI endpoint targets.
This transport type is defined using the value 0 which is reserved in
the NVMe base specifications v2.1 (Figure 294). Given that struct
nvmet_port are zeroed out on creation, to avoid having this transsport
type becoming the new default, nvmet_referral_make() and
nvmet_ports_make() are modified to initialize a port discovery address
transport type field (disc_addr.trtype) to NVMF_TRTYPE_MAX.

Any port using this transport type is also skipped and not reported in
the discovery log page (nvmet_execute_disc_get_log_page()).

The helper function nvmet_is_pci_ctrl() is also introduced to check if
a target controller uses the PCI transport.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/target/configfs.c  | 4 ++++
 drivers/nvme/target/discovery.c | 3 +++
 drivers/nvme/target/nvmet.h     | 5 +++++
 include/linux/nvme.h            | 1 +
 4 files changed, 13 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 4b2b8e7d96f5..20cad722c060 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -37,6 +37,7 @@ static struct nvmet_type_name_map nvmet_transport[] = {
 	{ NVMF_TRTYPE_RDMA,	"rdma" },
 	{ NVMF_TRTYPE_FC,	"fc" },
 	{ NVMF_TRTYPE_TCP,	"tcp" },
+	{ NVMF_TRTYPE_PCI,	"pci" },
 	{ NVMF_TRTYPE_LOOP,	"loop" },
 };
 
@@ -46,6 +47,7 @@ static const struct nvmet_type_name_map nvmet_addr_family[] = {
 	{ NVMF_ADDR_FAMILY_IP6,		"ipv6" },
 	{ NVMF_ADDR_FAMILY_IB,		"ib" },
 	{ NVMF_ADDR_FAMILY_FC,		"fc" },
+	{ NVMF_ADDR_FAMILY_PCI,		"pci" },
 	{ NVMF_ADDR_FAMILY_LOOP,	"loop" },
 };
 
@@ -1839,6 +1841,7 @@ static struct config_group *nvmet_referral_make(
 		return ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD(&port->entry);
+	port->disc_addr.trtype = NVMF_TRTYPE_MAX;
 	config_group_init_type_name(&port->group, name, &nvmet_referral_type);
 
 	return &port->group;
@@ -2064,6 +2067,7 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 	port->inline_data_size = -1;	/* < 0 == let the transport choose */
 	port->max_queue_size = -1;	/* < 0 == let the transport choose */
 
+	port->disc_addr.trtype = NVMF_TRTYPE_MAX;
 	port->disc_addr.portid = cpu_to_le16(portid);
 	port->disc_addr.adrfam = NVMF_ADDR_FAMILY_MAX;
 	port->disc_addr.treq = NVMF_TREQ_DISABLE_SQFLOW;
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 28843df5fa7c..7a13f8e8d33d 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -224,6 +224,9 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 	}
 
 	list_for_each_entry(r, &req->port->referrals, entry) {
+		if (r->disc_addr.trtype == NVMF_TRTYPE_PCI)
+			continue;
+
 		nvmet_format_discovery_entry(hdr, r,
 				NVME_DISC_SUBSYS_NAME,
 				r->disc_addr.traddr,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index abcc1f3828b7..4dad413e5fef 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -693,6 +693,11 @@ static inline bool nvmet_is_disc_subsys(struct nvmet_subsys *subsys)
     return subsys->type != NVME_NQN_NVME;
 }
 
+static inline bool nvmet_is_pci_ctrl(struct nvmet_ctrl *ctrl)
+{
+	return ctrl->port->disc_addr.trtype == NVMF_TRTYPE_PCI;
+}
+
 #ifdef CONFIG_NVME_TARGET_PASSTHRU
 void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys);
 int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index a5a4ee56efcf..42fc00dc494e 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -64,6 +64,7 @@ enum {
 
 /* Transport Type codes for Discovery Log Page entry TRTYPE field */
 enum {
+	NVMF_TRTYPE_PCI		= 0,	/* PCI */
 	NVMF_TRTYPE_RDMA	= 1,	/* RDMA */
 	NVMF_TRTYPE_FC		= 2,	/* Fibre Channel */
 	NVMF_TRTYPE_TCP		= 3,	/* TCP/IP */
-- 
2.47.1


