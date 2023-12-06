Return-Path: <linux-pci+bounces-595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CACD6807B95
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 23:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8666628244F
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 22:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DC41798D;
	Wed,  6 Dec 2023 22:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udeflMBF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A823017737
	for <linux-pci@vger.kernel.org>; Wed,  6 Dec 2023 22:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6D5C433C9;
	Wed,  6 Dec 2023 22:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701902560;
	bh=7cHmMbybKrcpsaIuCFsEGmwf1pycx3Ksk6fyQJF+zME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=udeflMBF4LfGQE+1gMmco53gECNUhwPIYb1EpsGpaa9OW+4tQlZc2nhTHNReQ2ioE
	 TLF+CbG4qCR+Ql1SjfAyEuKy5Zy1CqoNYH7lcRMrVs8i47VgeYd6ZzYhQyKe1KTqzC
	 XnT9Jvzqv9HNvZLqeXPiHUX64Q1UxNKS3itjy9tqr8+/kXzP/EQ2uS9UpxWzKd+N9E
	 8qO8vyGDdOaywN7EkOuRMhW6IW6cJk05deGN2H3isCvCsJQ/H4a/KeprlRygSVV1AP
	 CQdJ70a3h5C+DW11ZdbfdG6euahmWVRG71FQs3KvHUaQ6Q/KETtNACDb9wfZsIfb3j
	 KdFaqqi5nItfw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/3] PCI/AER: Use 'Correctable' and 'Uncorrectable' spec terms for errors
Date: Wed,  6 Dec 2023 16:42:29 -0600
Message-Id: <20231206224231.732765-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206224231.732765-1-helgaas@kernel.org>
References: <20231206224231.732765-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

The PCIe spec classifies errors as either "Correctable" or "Uncorrectable".
Previously we printed these as "Corrected" or "Uncorrected".  To avoid
confusion, use the same terms as the spec.

One confusing situation is when one agent detects an error, but another
agent is responsible for recovery, e.g., by re-attempting the operation.
The first agent may log a "correctable" error but it has not yet been
corrected.  The recovery agent must report an uncorrectable error if it is
unable to recover.  If we print the first agent's error as "Corrected", it
gives the false impression that it has already been resolved.

Sample message change:

  - pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
  + pcieport 0000:00:1c.5: AER: Correctable error received: 0000:00:1c.5

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 42a3bd35a3e1..20db80018b5d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -436,9 +436,9 @@ void pci_aer_exit(struct pci_dev *dev)
  * AER error strings
  */
 static const char *aer_error_severity_string[] = {
-	"Uncorrected (Non-Fatal)",
-	"Uncorrected (Fatal)",
-	"Corrected"
+	"Uncorrectable (Non-Fatal)",
+	"Uncorrectable (Fatal)",
+	"Correctable"
 };
 
 static const char *aer_error_layer[] = {
-- 
2.34.1


