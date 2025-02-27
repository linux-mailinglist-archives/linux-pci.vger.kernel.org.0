Return-Path: <linux-pci+bounces-22503-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1149A47374
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053B417216A
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 03:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18981A841B;
	Thu, 27 Feb 2025 03:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="kpGZ1x4P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jpMwrTHk"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9B81B0409;
	Thu, 27 Feb 2025 03:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740625929; cv=none; b=ltdiyBBvLalg8gJgMnUyd4BAq+5OuDvnbpARE5MQL8UUtiaJLFXVXBpL4dA3CiCI7G2/4BYJyih/PvNzBLdla0RaouNLMeJsL2e39o+p+PuqN9440gCxh6TT+6JZFW1jTXdEnCnBmQfqtO1oLh0p24WK+DW0CkZ4aI9LvgJplJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740625929; c=relaxed/simple;
	bh=U/g3eQTMR1Nrt00+4SlWpupeJ4a45LyJy/RDOh1OZSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdRPxMvHrH0JMXOAvBeRE3dmbg6v+vxvXv/cFP6ZPeqkuoGnMAVjSF19rmjPVjaLy4ulXJx+lL9xeYZkTZW+diqghP+mURWX6O+i7TaCL24JZDcrGkKJy02rDJ2kL8cJjLQqD0WBd0oTbrvU6tVSOTV7ewQxb6au68UO2cwy8jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=kpGZ1x4P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jpMwrTHk; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 13D1F25400E5;
	Wed, 26 Feb 2025 22:12:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Wed, 26 Feb 2025 22:12:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1740625926; x=
	1740712326; bh=ETaO0MKiUxQhhDGFr/kw3wzQd9hq+z6Q0USbIeJj8PY=; b=k
	pGZ1x4PP2rYlQIPgW9ynZ9ACly5u4HrHbEYIV/n+15G4nHaikHzg9pjJsfUhQ/yK
	eNWIN8+W2C4wQO2ao6JbG+tVlO9zSCzXvPs7J1XJz3BvNdse//Gxt/gjzkF3XuDC
	JAlPCYwBvKLQBtHVOnUlNBRBixCqJ6QvV8erojAaunTemvGF73Q8NzT5N/4zJe8z
	7IJBldmPNvGrRiOl3zGx1ZSZ1ub7dFKZf7JlRz6jC9JMbefZe4+uPV9lNS1npLDt
	HLR/s2lmsj87mxWIvusYntiDR7u9A6FtVSwjtGBq4OYbFgLq8srhSQJXIZY9krNI
	ZVrOqE4Xd42hxvoIo4zXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1740625926; x=1740712326; bh=E
	TaO0MKiUxQhhDGFr/kw3wzQd9hq+z6Q0USbIeJj8PY=; b=jpMwrTHkEfnfYgv76
	NkeffH3wc9afCMStkrPHdgcqgA0oZBYMjPC6Bn7pNAVE3ir6+OHbSOKfgfvHsFmy
	NA+lN69Ys7y7tVsl7+9tTRnpSOBZ5GEee2axp+tv669e7TZ32rR/RuKrYGcf+ZZU
	bOpyQWOylmiCMwFaZdLO2WTsPkXANHzwdTa/W+fl8wU6FVRc7xyHhmqJV4/Cy8CJ
	PwMBhFqrnLaJtOw9rOmTlvd9rb3myfiVQv6DSg+xJII1MI89JnSPo5dYho6914Mw
	CgrPBmvMEF4u2/XxY3pBZNVdWd8vNxUUYfBgFj3pAc5HzdKwbwErjzsSgALuX5Hg
	S9rYg==
X-ME-Sender: <xms:Bti_ZyZsa8owbuEw424Q4GhF_Nt1MjI6_gjMlBM2Sg9et_lYYPvPfA>
    <xme:Bti_Z1ZM5aGqXZIAunjLz93iBNovltWhsZsF0EatoMRs4oyWqD6wSvPRcL2S-lzlQ
    2I0mv3if7yhi7WQDQ0>
X-ME-Received: <xmr:Bti_Z88c39tUA97JVJ6WlnxHyB5u_tO4gsSohbt-374J6YOtaZQD3HzFQWZZpTe-OrV97o6Mjbg>
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
X-ME-Proxy: <xmx:Bti_Z0qqmGdx5PyF6bnBGDApy_wDUWU1kOY-1xETLUmHmWsZ7K7LSw>
    <xmx:Bti_Z9rBeqmKx4C6NFxys9Ur3WsBtCRgx8O1bnLTibvtS3ca4Xr56g>
    <xmx:Bti_ZyQCTbUlyzirECZqU2DOEcGWc__U_VYX7IhEd8o2vMxBN2yD-w>
    <xmx:Bti_Z9rSgwX-qd3h4nYEpzK89zeJi7b2UCubKGzlZ5LLxpZZOCATTQ>
    <xmx:Bti_Z5rP_zEtI0FyAq3LJFiWeHa8AJ28B8m7uTpzWmLf4YQc8nk-1dLy>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 22:12:01 -0500 (EST)
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
	Alistair Francis <alistair@alistair23.me>
Subject: [RFC v2 17/20] PCI/CMA: Support built in X.509 certificates
Date: Thu, 27 Feb 2025 13:09:49 +1000
Message-ID: <20250227030952.2319050-18-alistair@alistair23.me>
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

Support building the X.509 certificates into the CMA certificate store.
This allows certificates to be built into the kernel which can be used
to authenticate PCIe devices via SPDM.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/pci/cma.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
index 59558714f143..381d8f32a5a7 100644
--- a/drivers/pci/cma.c
+++ b/drivers/pci/cma.c
@@ -24,6 +24,10 @@
 /* Keyring that userspace can poke certs into */
 static struct key *pci_cma_keyring;
 
+extern __initconst const u8 system_certificate_list[];
+extern __initconst const unsigned long system_certificate_list_size;
+extern __initconst const unsigned long module_cert_size;
+
 /*
  * The spdm_requester.c library calls pci_cma_validate() to check requirements
  * for Leaf Certificates per PCIe r6.1 sec 6.31.3.
@@ -222,8 +226,31 @@ void pci_cma_destroy(struct pci_dev *pdev)
 	spdm_destroy(pdev->spdm_state);
 }
 
+/*
+ * Load the compiled-in list of X.509 certificates.
+ */
+static int load_system_certificate_list(void)
+{
+	const u8 *p;
+	unsigned long size;
+
+	pr_notice("Loading compiled-in X.509 certificates for CMA\n");
+
+#ifdef CONFIG_MODULE_SIG
+	p = system_certificate_list;
+	size = system_certificate_list_size;
+#else
+	p = system_certificate_list + module_cert_size;
+	size = system_certificate_list_size - module_cert_size;
+#endif
+
+	return x509_load_certificate_list(p, size, pci_cma_keyring);
+}
+
 __init static int pci_cma_keyring_init(void)
 {
+	int rc;
+
 	pci_cma_keyring = keyring_alloc(".cma", KUIDT_INIT(0), KGIDT_INIT(0),
 					current_cred(),
 					(KEY_POS_ALL & ~KEY_POS_SETATTR) |
@@ -236,6 +263,10 @@ __init static int pci_cma_keyring_init(void)
 		return PTR_ERR(pci_cma_keyring);
 	}
 
+	rc = load_system_certificate_list();
+	if (rc)
+		return rc;
+
 	return 0;
 }
 arch_initcall(pci_cma_keyring_init);
-- 
2.48.1


