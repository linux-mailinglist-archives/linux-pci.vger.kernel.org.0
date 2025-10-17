Return-Path: <linux-pci+bounces-38435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DABBE7457
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 10:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EFBF622979
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 08:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578C22BEC41;
	Fri, 17 Oct 2025 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsutJEW5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFA723958C;
	Fri, 17 Oct 2025 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690892; cv=none; b=fVqPf4VoHMK8cHuVRfgW5A+/DqYigNYEoaT18Ik4ZoWeukr8l0/iKo4+UG6Lo8s5lh51O3rtPNkEgwlWv7aVRbAkm6XIMzU0+nqXbapsSKkkMl4R18jsJrR90WEMVWtxRVMDlVEM5jDAHUQwrAlGSXv9xxSRLNdDtdeYtP9gufc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690892; c=relaxed/simple;
	bh=aQM8S1gRQ5jL8Y273uYJ9Sl4vppeQ81J+AkspAyr2H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGvAoj/y19qY/f7DW4LitZlNU9veGnZeCJlYASV31nSOqd5lt0mlyybaKzCJDzJKCouzrOc5PrAeq3JgmoT722PnbuMjL47d1Ku2B4jSe2zKaiQAX3xul2GftLJ9KmC69UF/N9wI//Id1nOErHnGQc2FGz72GGuPD0mihdFuPY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsutJEW5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC0BC116C6;
	Fri, 17 Oct 2025 08:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760690892;
	bh=aQM8S1gRQ5jL8Y273uYJ9Sl4vppeQ81J+AkspAyr2H8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OsutJEW55HQyO+td7OWiczhMBPckM32yQP4VtNVV2xrDdYjzrloB/Un+AZ5bIsqbu
	 01EyN6iYYyuZb50D3HWUCKDjMJwyk28rwfWLjiZLVYCQW8VW6fEgJrLgybyMdpxegH
	 gDVf0LT5hdZzInU/YseP+w1c5cUXrv8QIEqYojzsnjoY2aqiiRKQYwwxkhrqOatb0Z
	 6UwgnjF4+n0zTwZpB2HwpeosTG60RWUVpOSpwqXOHRIUwPVUr7aJVGE4t7U6kj54QM
	 PwFfnQ4dNFvYF2EukQWYGoFSuLvD1qV4WT4gFXdbvLfvKMopVPQmDScDq3ysb5b2c2
	 hPRFL57qy+Crw==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Scott Branden <sbranden@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ray Jui <rjui@broadcom.com>,
	Frank Li <Frank.Li@nxp.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH v3 3/5] of/irq: Export of_msi_xlate() for module usage
Date: Fri, 17 Oct 2025 10:47:50 +0200
Message-ID: <20251017084752.1590264-4-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251017084752.1590264-1-lpieralisi@kernel.org>
References: <20251017084752.1590264-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_msi_xlate() is required by drivers that can be configured
as modular, export the symbol.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Rob Herring <robh@kernel.org>
---
 drivers/of/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 9f6cd5abba76..889d0dfbcb3f 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -732,6 +732,7 @@ u32 of_msi_xlate(struct device *dev, struct device_node **msi_np, u32 id_in)
 	}
 	return id_out;
 }
+EXPORT_SYMBOL_GPL(of_msi_xlate);
 
 /**
  * of_msi_map_get_device_domain - Use msi-map to find the relevant MSI domain
-- 
2.50.1


