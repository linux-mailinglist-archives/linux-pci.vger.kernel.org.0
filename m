Return-Path: <linux-pci+bounces-22429-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B45A45E81
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 13:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896C316C214
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 12:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932FB218AB2;
	Wed, 26 Feb 2025 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmyQTbfz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9E1214A62;
	Wed, 26 Feb 2025 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572041; cv=none; b=OICrsXhQHonrCJglzOdle69itkywgFN+/UyQQ7K1YTw/Mn2YCfUmEA94AF3gKrEgrwmWH2grs/fRNlG6QofDw2nwNLG0B37e+CahgZ5isrnfwP8d9mEEwsc4GezTsEEaWLoHOAixgHP/dxC9Jz5tbW1GaSgFWtLdRYE4ex+jcic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572041; c=relaxed/simple;
	bh=Mrnv4DyUql6CRwuvuO9gA2qlVAcZZy5c9EzmEzlektA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSkWt40kyW/2rLbiwydN0AmgqoMyZTdtzQZrgcPw2KuEiI05GEAV/p6DIKkjuh8W/8BWljQmwZ1bKO4bFEg+2ANE20tJB+LeDI/RmnKhGuSPR89LTZ8c0Fb7dBKUrDLQnTjTIEweJUPT2niqJBTc/rcLQ0qwiVmdDUDcjS5UDqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmyQTbfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BAC2C4CEE4;
	Wed, 26 Feb 2025 12:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740572040;
	bh=Mrnv4DyUql6CRwuvuO9gA2qlVAcZZy5c9EzmEzlektA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DmyQTbfz5GsBXB5Kf9wRE+CFvQxshm2V7RzqVX1EWeoN91NSnCk1Xjq/apnUT2XBj
	 urXyZR4L5O/gbz/JzELchRTUFx8B/e3066/Pn5WlZCKprhJn11gmG4GB8gDDHiq2OU
	 WbJgcpgXX3br8jznmyPkP2vCrCJsghJ/a7XyBeUqr81ea0yQdw6yUIoXlNlOgWPmK4
	 18CNkR0GYv6jlzzcE9eMuZwM3KZV4p+PvmVQZ6b4DSRBJx57GQV99fURJzQcRRfUWz
	 HfJf1tOdERpNkBGZ3BhoVSkRi8zMznnPZGoLSfVX2AXb369CCXleIb4NkKRLk2DD6s
	 ey1NRapycSl4Q==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	gregkh@linuxfoundation.org,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [RFC PATCH 4/7] tsm: Allow tsm ops function to be called for multi-function devices
Date: Wed, 26 Feb 2025 17:43:20 +0530
Message-ID: <20250226121323.577328-4-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226121323.577328-1-aneesh.kumar@kernel.org>
References: <yq5a4j0gc3fp.fsf@kernel.org>
 <20250226121323.577328-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IDE spec says "For Endpoints, including Functions of a Multi-Function
Device, associated with an Upstream Port, only Function 0 must implement
the IDE Extended Capability." So we expect ide_cap to be present only
for function 0. Allow tsm probe ops to be called for all PCI devices

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/pci/tsm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 1a071130dea3..e798d9bf3da4 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -176,8 +176,7 @@ static void __pci_tsm_init(struct pci_dev *pdev)
 		return;
 
 	tee_cap = pdev->devcap & PCI_EXP_DEVCAP_TEE;
-
-	if (!(pdev->ide_cap || tee_cap))
+	if (!tee_cap)
 		return;
 
 	lockdep_assert_held_write(&pci_tsm_rwsem);
-- 
2.43.0


