Return-Path: <linux-pci+bounces-39378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B23D4C0CC45
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 10:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 470F34F42B6
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 09:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B885F2F6592;
	Mon, 27 Oct 2025 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FS828tRE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3AD2F619F;
	Mon, 27 Oct 2025 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558646; cv=none; b=eEjNkMrlzyyjNwelqqmAfkDT3hJtBRwdiK6gudgoaVVpDRzRB92rNx0jIkUFyCWknWHfYNYK7FuWV9Jz3XSol/eUjxZ69/ypJC/9YwlSCdbrw0J0Bha97Md9gWsXEHVkGRSnkB7sMIY9FyAVPG4/zqsP5/nb3gbGER8Tym3tkHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558646; c=relaxed/simple;
	bh=+QJQxLvf5/Nw2WwKAhM43PutwuEiTS23ygXc8gN9Crc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A00OqtL+LVyhZvQfbJHEQeDV2DGgX41DyuVbq9YwzPTVVBRBxPa6J1pjI3Fes6Q7uCZmE8rF0O1HJ1Egp5ZsfIEbpSD3tj7ajCwM4pef7voQsnS+wqCjJkDQyQzU/JnFT4+dhqhtmUSxhLEtPKp8J+lnKjCsJ20OiyCX99mwWR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FS828tRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F48C4CEF1;
	Mon, 27 Oct 2025 09:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761558646;
	bh=+QJQxLvf5/Nw2WwKAhM43PutwuEiTS23ygXc8gN9Crc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FS828tREuF9qesM2SZh+1SnIH6AKcWkTgGiLoaNzZqhKp8WCup+UVcQu1y/B0Ym9X
	 kCFscCXoGvGZWVoeCiasY74QG+tliU19rrWvdh58pY+Ps777kSnQ+RAa65GB1saNH6
	 CSPuoCyDnzQ5/F3NBTvoh015rbLxWZtrLZ8vwYnZ+zSYOSqXYyURmZGKY4hHB4RvZL
	 d7AF7wWYPBwzD1DiDi9VgXUsinh3yZl2CRFE802H6KSSAiOnL3+vFZAdyC/vB88sAS
	 fYpcqyTprTT8ykNJgF/5wynvu9FVT0ulN45AzANkv3mE8fhr0duVdMyOSoRwD+mLh8
	 PizHve4m+R5Rw==
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
Subject: [PATCH 08/12] coco: host: arm64: Instantiate RMM pdev during device connect
Date: Mon, 27 Oct 2025 15:18:59 +0530
Message-ID: <20251027094916.1153143-8-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251027094916.1153143-1-aneesh.kumar@kernel.org>
References: <20251027094916.1153143-1-aneesh.kumar@kernel.org>
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


