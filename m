Return-Path: <linux-pci+bounces-39396-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3D6C0CCFE
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 10:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A98188C493
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 09:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDFE2F744A;
	Mon, 27 Oct 2025 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0Os/H7j"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FE12F6935;
	Mon, 27 Oct 2025 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559033; cv=none; b=Yfg5F4+/G0NPZmdQ3iqoTkGG9RF+HgKiPi8GcoQYzJI4i8V/+BjKGakhdcu3RrIb2VTs4NUSfJp6/BIZFS80CtHou85oBsUhcCbEvk3uKzOOLBmgmewS2w+TpWeFfAR3dlA201f70nmJRYkknszceGEqGDE91+uyLyKCEbGZDL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559033; c=relaxed/simple;
	bh=+QJQxLvf5/Nw2WwKAhM43PutwuEiTS23ygXc8gN9Crc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvhoB7y6PwfJRh9lhZOX7kpDWAOEhikiz+p020WulbmPS0r32Ta/MGWSKZxRRNrswXbW9kcYpFdNFXUmq81Uhb+BGqHvdlotW4C+ILED3AYOA8clPbfjPTeimcbjf4+SqI5T6BnT0RRu4O+6IZPUKDM2SRkcOgVtA80Su6xIyTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0Os/H7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB02C4CEFF;
	Mon, 27 Oct 2025 09:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761559033;
	bh=+QJQxLvf5/Nw2WwKAhM43PutwuEiTS23ygXc8gN9Crc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A0Os/H7j8zaFaQWVYnDkr4ulrgBuxWXxJ6Cgfpd6XKuKi4FMcrMqWwYteaIV6w2Az
	 KwBdKAHplsA/Jr6QUbgktRLb2SJYONtBFqUNzFkyVbOoK5+UL5VZg/6+nV1upo+yWm
	 xBZ2VCwsv23tf90eJlDD14ibPq3FFHYKU4mtfvyfUQx6+OsmT9lfS+rQ7c8M+fsanR
	 3GineL9o6r9n2VI6wie01IFNyZ1gh5gnwawl/aGyJKqvKBO6vdU3ZEMYgt6sNgM2qE
	 z8snAyYKZzOQMfie3RKa7BzJ89n7PD7Vvmap6wCv7CB1FSgYLflrSYprcKmpz/vg5s
	 zaGYEvYTEb/Aw==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dan.j.williams@intel.com,
	aik@amd.com,
	lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [PATCH RESEND v2 08/12] coco: host: arm64: Instantiate RMM pdev during device connect
Date: Mon, 27 Oct 2025 15:25:58 +0530
Message-ID: <20251027095602.1154418-9-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251027095602.1154418-1-aneesh.kumar@kernel.org>
References: <20251027095602.1154418-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An RMM pdev object represents a communication channel between the RMM
and a physical device, for example a PCIe device. With the required
helpers now in place, update the connect callback to create an RMM pdev
object.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/virt/coco/arm-cca-host/arm-cca.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/coco/arm-cca-host/arm-cca.c b/drivers/virt/coco/arm-cca-host/arm-cca.c
index e79f05fee516..8eaf8749e59d 100644
--- a/drivers/virt/coco/arm-cca-host/arm-cca.c
+++ b/drivers/virt/coco/arm-cca-host/arm-cca.c
@@ -71,8 +71,8 @@ static void cca_tsm_pci_remove(struct pci_tsm *tsm)
 	}
 }
 
-static __maybe_unused int init_dev_communication_buffers(struct pci_dev *pdev,
-							 struct cca_host_comm_data *comm_data)
+static int init_dev_communication_buffers(struct pci_dev *pdev,
+					  struct cca_host_comm_data *comm_data)
 {
 	int ret = -ENOMEM;
 
@@ -160,6 +160,16 @@ static int cca_tsm_connect(struct pci_dev *pdev)
 	if (rc)
 		goto err_tsm;
 
+	rc = init_dev_communication_buffers(pdev, &pf0_dsc->comm_data);
+	if (rc)
+		goto err_comm_buff;
+	rc = pdev_create(pdev);
+	if (rc)
+		goto err_pdev_create;
+
+	rc = pdev_ide_setup(pdev);
+	if (rc)
+		goto err_ide_setup;
 	/*
 	 * Once ide is setup, enable the stream at the endpoint
 	 * Root port will be done by RMM
@@ -167,6 +177,12 @@ static int cca_tsm_connect(struct pci_dev *pdev)
 	pci_ide_stream_enable(pdev, ide);
 	return 0;
 
+err_ide_setup:
+	pdev_stop_and_destroy(pdev);
+err_pdev_create:
+	free_dev_communication_buffers(&pf0_dsc->comm_data);
+err_comm_buff:
+	tsm_ide_stream_unregister(ide);
 err_tsm:
 	pci_ide_stream_teardown(rp, ide);
 	pci_ide_stream_teardown(pdev, ide);
@@ -193,6 +209,9 @@ static void cca_tsm_disconnect(struct pci_dev *pdev)
 	stream_id = ide->stream_id;
 	pf0_dsc->sel_stream = NULL;
 
+	pdev_stop_and_destroy(pdev);
+	free_dev_communication_buffers(&pf0_dsc->comm_data);
+
 	pci_ide_stream_release(ide);
 	clear_bit(stream_id, cca_stream_ids);
 }
-- 
2.43.0


