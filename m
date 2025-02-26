Return-Path: <linux-pci+bounces-22430-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 193E5A45EA7
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 13:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7393BA7BE
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 12:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4060219308;
	Wed, 26 Feb 2025 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEt6vLnC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A057F2192FD;
	Wed, 26 Feb 2025 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572045; cv=none; b=SwSsTOp3BpSBX62lWfWfvnXtcwbIyn5KR6dMJxMOuKKbGSBG2u+4rZpXsufupftg4ea5ambfGd4tHCMnFPiVkf2U983VPkNp8SrhFhIdZ9XkYf+CMeT95VT7GIVKPRi1nLco3ad3+/psARSu3+B1VAVZ0ioXERZW45a69XFuRsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572045; c=relaxed/simple;
	bh=irmBivjWDjwlrzcV85gNrnZR1N3lGmmNmqt3eHnw/4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxbDBYO40qPCM3THpq3lHVUV/Gtv0FAo+nRH5iJUmuOk5xTFjTwkzMnMtHTqEnZ10XOg1C06vfvqeSmviHMXi6qHgwCqj+ny1DuKGKGAJfSo4vXsjX0k4uHNpS5SS2yctaK+4JvWaRkeOnPogKV6xDJI7v5FDK77mSfXDPR7Rpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEt6vLnC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823EAC4CEE8;
	Wed, 26 Feb 2025 12:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740572045;
	bh=irmBivjWDjwlrzcV85gNrnZR1N3lGmmNmqt3eHnw/4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bEt6vLnCjfggHIVKdARaQVNwnOVLDNJruRh0yMlHPw2SM+cZZLRuPLn09rNYBb/bV
	 3qi9vUdYseYeZ0rZ/4Fq1o5Pe3wtaScM4BF2S0DLMHIoT75EwY3AUD19R8S8VgK4s3
	 LFcu1SIQTOWD3ZdaaJ3GMDM+1lh/MyIzH9j5JHHyTUyA9bAuOFAne8H2syF34ku3aW
	 rwMV6Y1RqKJDzRuqbpCIyrYWiGF/l3hC9K3nj/4dL5KZCL70K4NQBo52sXUeRnR0NX
	 Vk51cmvMObgwTxUa0FwHex2BE//qCPIYIILyBOCOxLP4+8MF5oWznU71bjwGKRlf1Y
	 D+X+Cfi1UT0xQ==
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
Subject: [RFC PATCH 5/7] tsm: Don't error out for doe mailbox failure
Date: Wed, 26 Feb 2025 17:43:21 +0530
Message-ID: <20250226121323.577328-5-aneesh.kumar@kernel.org>
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

Only function 0 is expected to support the DOE mailbox.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/pci/tsm.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index e798d9bf3da4..a0deddac6767 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -192,21 +192,16 @@ static void __pci_tsm_init(struct pci_dev *pdev)
 	 * a candidate to connect with the platform TSM
 	 */
 	struct pci_dsm *dsm __free(dsm_remove) = tsm_ops->probe(pdev);
-
-	pci_dbg(pdev, "Device security capabilities detected (%s%s ), TSM %s\n",
-		pdev->ide_cap ? " ide" : "", tee_cap ? " tee" : "",
-		dsm ? "attach" : "skip");
-
 	if (!dsm)
 		return;
 
 	mutex_init(&pci_tsm->lock);
 	pci_tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
 					       PCI_DOE_PROTO_CMA);
-	if (!pci_tsm->doe_mb) {
-		pci_warn(pdev, "TSM init failure, no CMA mailbox\n");
-		return;
-	}
+	pci_info(pdev, "Device security capabilities detected (%s%s%s)\n",
+		 pdev->ide_cap ? " ide" : "",
+		 tee_cap ? " tee" : "",
+		 pci_tsm->doe_mb ? " doe" : "");
 
 	pci_tsm->state = PCI_TSM_INIT;
 	pci_tsm->dsm = no_free_ptr(dsm);
-- 
2.43.0


