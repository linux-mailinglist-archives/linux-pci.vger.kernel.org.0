Return-Path: <linux-pci+bounces-22494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 229CCA47366
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390241890584
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 03:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E561B3930;
	Thu, 27 Feb 2025 03:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="fR6BDKqz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xqpnSk1l"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BCE1B21B5;
	Thu, 27 Feb 2025 03:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740625865; cv=none; b=RGZkxcjTBotUjoLs9mBy2VddIoDT27EeRzhk7zAPKChzFJ2PreVvvfH8vFk313nYscQ8Vg7SgMh2kGGHF5X+6wjLkbojUs6IY/kJLFtsE/0u6KFUmtVES/h2Ipzb/d3s+6EkqT4WGQ281UWlm+DqruKlp7Bbjl3psmagqo5IfrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740625865; c=relaxed/simple;
	bh=lzr7fQoSOlz3qcUZVp7oldKdhrwHytiLUH5Z76q3iTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZgC6RFAVgbA1btWNM0qrtnKFZ5p7mKED8QQsyeNFWX9a0gnc3ImQx2UHQzJjCdCm8cEIlGiFdNtL8wr1KBH7h8AsZmHOXs3Ebcu+CkVKW/Z2wREkLR8fUh3ZugrTjt4vS+3meGYjW6xRo30IhoNzR+rcBtqORbjcHnsl4h2AZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=fR6BDKqz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xqpnSk1l; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id A846B1140199;
	Wed, 26 Feb 2025 22:11:02 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 26 Feb 2025 22:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1740625862; x=
	1740712262; bh=7MZPNGyEHz7YQqqrumb3k4zZCVPZQwkJTHv4U15Cp0g=; b=f
	R6BDKqzdqwa1pniMWOOsqB2qHnpyQ2F55ZTabnUN9QcsM235BHhs7DZYc9S5HDqH
	mf4nPvrLFdOb2YwrRHz6kTpejpf3aLlTRBPwwj+N8obYRdciNzWq1EtMxg0oo7lm
	RqJ1ShvuchGmUzzWs0byDVcetixpzDVF/QnF6v5idBsrDj4H4QsFKMYAGGXUY+oH
	Q2KwilJrbO7TBbUDaBJfW/eZMq22R26WjfNO8o/FhgzJzrU0tH6f2dDmmRA6dIGP
	N1tTqjz1lKb9FdN6O6aKmGKy5s0M6fEjnIG0aYE0i1CUWPQXglyvrHXAySlA4QV0
	AhyyMhfQgUAZiBJmLRFuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1740625862; x=1740712262; bh=7
	MZPNGyEHz7YQqqrumb3k4zZCVPZQwkJTHv4U15Cp0g=; b=xqpnSk1lg7ZvNsGf1
	vQB3UWcdLA9VoKJ7R9GX8UU0p+K4nH5wO80fjp/wx3UabhyV8RT2qTkvV9yohI91
	PkUW13McAsEsuQlv6f1UMN82eXgjTpHhSm9SxnBNdsrl4y4UER0sKxvz6q9zkasB
	S1yTsfY8Q7HLtbitg6FfC/PWabvj7JV51w8ZnfN0xrhW3EhO+JVmkKLVpyLoR1xY
	Oi3AOh/cvyKiVe3/CpgRQ0Sp3xAkfk2C7cGY0qKcgecU1TA8EvZMeb2Sw+OyOR2R
	fIflbk43/GX0kiyNV0/PPQiXiPDg9N4ch4/ugNv/fOwF40gGJb5ofsz57HVLKMJK
	CwJyA==
X-ME-Sender: <xms:xte_ZznZTheI1nUIhVJeUNAo00Ht349L8KaRF81xoco64LBPy0pEyg>
    <xme:xte_Z23PPboRjiYdHTUIsKukJ0eS3Q7MmcOWrKnLUsdeqITBQTSDNHWbLzP-HknPn
    hDhCXgNalRYbbxALSQ>
X-ME-Received: <xmr:xte_Z5qXiYoLA15RCmXyb-SXSnrVKXvX6MPG-T241jEh_I0OaI1OiQhpilxJhh33sGpXW0RqEkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekieefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfuohhrthgvugftvg
    gtihhpvdculdegtddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlh
    hishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeitdefkeetledvleevveeu
    ueejffeugfeuvdetkeevjeejueetudeftefhgfehheenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhr
    vdefrdhmvgdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehlihhnuhigqdgtgihlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhukhgrshesfihunhhnvghrrdguvgdprhgtphhtthhopehlihhnuhigqdhptghi
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghhvghlghgrrghssehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhdrtggrmhgvrhhonheshhhu
    rgifvghirdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgu
    rghtihhonhdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:xte_Z7lUpS2ukg3R4YFMdbP7pHQRGzVocpT02MsqWbratpimGVIdUQ>
    <xmx:xte_Zx0NU754SZQAluFOtAB6mOXrMhdfR0rkWyLTZAKASFtMgpph5g>
    <xmx:xte_Z6s_x2QMS76Ils1YcLfLAFoBsOM0skQ9dxvJf37j4PHzgQO57A>
    <xmx:xte_Z1VPS1qnQkgwpy0D5aHj2EspIzzgyHQ4mOBOt2O_r4NkkFyCJQ>
    <xmx:xte_ZzUtiPwXzw-gq8CSYFcOeOmP3hokA78mwSkN31OG1aiPgquhjeVr>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 22:10:56 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lukas@wunner.de,
	linux-pci@vger.kernel.org,
	bhelgaas@google.com,
	Jonathan.Cameron@huawei.com,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org
Cc: boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	ojeda@kernel.org,
	alistair23@gmail.com,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	gary@garyguo.net,
	alex.gaynor@gmail.com,
	benno.lossin@proton.me,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC v2 08/20] PCI/CMA: Reauthenticate devices on reset and resume
Date: Thu, 27 Feb 2025 13:09:40 +1000
Message-ID: <20250227030952.2319050-9-alistair@alistair23.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227030952.2319050-1-alistair@alistair23.me>
References: <20250227030952.2319050-1-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

CMA-SPDM state is lost when a device undergoes a Conventional Reset.
(But not a Function Level Reset, PCIe r6.2 sec 6.6.2.)  A D3cold to D0
transition implies a Conventional Reset (PCIe r6.2 sec 5.8).

Thus, reauthenticate devices on resume from D3cold and on recovery from
a Secondary Bus Reset or DPC-induced Hot Reset.

The requirement to reauthenticate devices on resume from system sleep
(and in the future reestablish IDE encryption) is the reason why SPDM
needs to be in-kernel:  During ->resume_noirq, which is the first phase
after system sleep, the PCI core walks down the hierarchy, puts each
device in D0, restores its config space and invokes the driver's
->resume_noirq callback.  The driver is afforded the right to access the
device already during this phase.

To retain this usage model in the face of authentication and encryption,
CMA-SPDM reauthentication and IDE reestablishment must happen during the
->resume_noirq phase, before the driver's first access to the device.
The driver is thus afforded seamless authenticated and encrypted access
until the last moment before suspend and from the first moment after
resume.

During the ->resume_noirq phase, device interrupts are not yet enabled.
It is thus impossible to defer CMA-SPDM reauthentication to a user space
component on an attached disk or on the network, making an in-kernel
SPDM implementation mandatory.

The same catch-22 exists on recovery from a Conventional Reset:  A user
space SPDM implementation might live on a device which underwent reset,
rendering its execution impossible.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/pci/cma.c        | 15 +++++++++++++++
 drivers/pci/pci-driver.c |  1 +
 drivers/pci/pci.c        | 12 ++++++++++--
 drivers/pci/pci.h        |  2 ++
 drivers/pci/pcie/err.c   |  3 +++
 5 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
index e974d489c7a2..f2c435b04b92 100644
--- a/drivers/pci/cma.c
+++ b/drivers/pci/cma.c
@@ -195,6 +195,21 @@ void pci_cma_init(struct pci_dev *pdev)
 	spdm_authenticate(pdev->spdm_state);
 }
 
+/**
+ * pci_cma_reauthenticate() - Perform CMA-SPDM authentication again
+ * @pdev: Device to reauthenticate
+ *
+ * Can be called by drivers after device identity has mutated,
+ * e.g. after downloading firmware to an FPGA device.
+ */
+void pci_cma_reauthenticate(struct pci_dev *pdev)
+{
+	if (!pdev->spdm_state)
+		return;
+
+	spdm_authenticate(pdev->spdm_state);
+}
+
 void pci_cma_destroy(struct pci_dev *pdev)
 {
 	if (!pdev->spdm_state)
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index f57ea36d125d..6dd24ae2d1ee 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -566,6 +566,7 @@ static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
 	pci_pm_power_up_and_verify_state(pci_dev);
 	pci_restore_state(pci_dev);
 	pci_pme_restore(pci_dev);
+	pci_cma_reauthenticate(pci_dev);
 }
 
 static void pci_pm_bridge_power_up_actions(struct pci_dev *pci_dev)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..b462bab597f7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5074,8 +5074,16 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 
 	rc = pci_dev_reset_slot_function(dev, probe);
 	if (rc != -ENOTTY)
-		return rc;
-	return pci_parent_bus_reset(dev, probe);
+		goto done;
+
+	rc = pci_parent_bus_reset(dev, probe);
+
+done:
+	/* CMA-SPDM state is lost upon a Conventional Reset */
+	if (!probe)
+		pci_cma_reauthenticate(dev);
+
+	return rc;
 }
 
 static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 69ba2ae9a0cd..fa6e3ae10b67 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -451,9 +451,11 @@ static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
 #ifdef CONFIG_PCI_CMA
 void pci_cma_init(struct pci_dev *pdev);
 void pci_cma_destroy(struct pci_dev *pdev);
+void pci_cma_reauthenticate(struct pci_dev *pdev);
 #else
 static inline void pci_cma_init(struct pci_dev *pdev) { }
 static inline void pci_cma_destroy(struct pci_dev *pdev) { }
+static inline void pci_cma_reauthenticate(struct pci_dev *pdev) { }
 #endif
 
 #ifdef CONFIG_PCI_NPEM
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 31090770fffc..0028582f0590 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -133,6 +133,9 @@ static int report_slot_reset(struct pci_dev *dev, void *data)
 	pci_ers_result_t vote, *result = data;
 	const struct pci_error_handlers *err_handler;
 
+	/* CMA-SPDM state is lost upon a Conventional Reset */
+	pci_cma_reauthenticate(dev);
+
 	device_lock(&dev->dev);
 	pdrv = dev->driver;
 	if (!pdrv || !pdrv->err_handler || !pdrv->err_handler->slot_reset)
-- 
2.48.1


