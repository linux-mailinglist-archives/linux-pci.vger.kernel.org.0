Return-Path: <linux-pci+bounces-22426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B4EA45E7F
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 13:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F6B1655DA
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 12:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D6C21B1BE;
	Wed, 26 Feb 2025 12:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+eqlPkl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA5D2153D5;
	Wed, 26 Feb 2025 12:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572027; cv=none; b=hPZl440zzocEwfSc3AO0aaavuM96ecl5yhKQ5yClxdbpoFMjeQ1Zt6GpP9G6lPv9LlvqETvNV6NMAXYYDmY69+vFaTj67LLU9csXcvBVT4qxoVxu5yI6g8G5lqGAyln2Zf7etRqyWsRvoVXYRPDWkXYG8GQ4TVcd4vGqtBJw0ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572027; c=relaxed/simple;
	bh=zrA0EbJ9ewDYmPPGyh8oTo13uA4Pj3X5Ahucd1DlLgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bn8FXxXRPSgeFnwhL71k3gY/NH+YMu4BKItP/ZlTOANHwNnz5K9tgEte2coHhirofAauKHVtUjDZ7Esp9+elTuZ2qT7vRUsFoXrfefqWHXpxXmQ9385IrPhze57JBd/hzveARczN42/PU2tAzlqg8d3KOyx5l5utdnxVU/tOcDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+eqlPkl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75788C4CED6;
	Wed, 26 Feb 2025 12:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740572026;
	bh=zrA0EbJ9ewDYmPPGyh8oTo13uA4Pj3X5Ahucd1DlLgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E+eqlPkl5VcP/x9ILGYimx9U2ebmW8x4CBJCzN1nU4SN2AQArK0SYnccxzDWG5f2r
	 rN6V1hOUubh3QlD7RZGhqOOKr5aciKVp0ylrEXm6Y/8heeTafItDgcNrEimSij8DaH
	 B/jToVtO09/AhFcaOtoi0avWLh0TC8Y6hPeIr4TThd/wyC2qtqh+uP/dUP0kPHW5dz
	 9PcLwLPJKwafTWahGcUfpsodNCA3GZJFXOz10EW9S9zh0WpwPZk+aLLfsxlWzpNAxN
	 016Zku9ZoBBm+Hgi8ff20+huXu41RC8JpQITBzCdZIdINoeM4E32DWrPAC4OyDVDw5
	 wZ3cBICWVhVYA==
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
Subject: [RFC PATCH 1/7] tsm: Select PCI_DOE which is required for PCI_TSM
Date: Wed, 26 Feb 2025 17:43:17 +0530
Message-ID: <20250226121323.577328-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <yq5a4j0gc3fp.fsf@kernel.org>
References: <yq5a4j0gc3fp.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/pci/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 8dab60dadb7d..f16d0e99a109 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -127,6 +127,7 @@ config PCI_IDE
 config PCI_TSM
 	bool "TEE Security Manager for PCI Device Security"
 	select PCI_IDE
+	select PCI_DOE
 	help
 	  The TEE (Trusted Execution Environment) Device Interface
 	  Security Protocol (TDISP) defines a "TSM" as a platform agent
-- 
2.43.0


