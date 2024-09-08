Return-Path: <linux-pci+bounces-12936-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4234970A65
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 00:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC3D1F21BF2
	for <lists+linux-pci@lfdr.de>; Sun,  8 Sep 2024 22:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE46175D2F;
	Sun,  8 Sep 2024 22:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wesleyac.com header.i=@wesleyac.com header.b="HsGtMrRO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mp89Y2N4"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46059139CF2;
	Sun,  8 Sep 2024 22:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725833470; cv=none; b=mzoxukR0lVgj3FnwSemK+ocUpUbtg3gg0BZ808QR7mzG0GXKSBOpVfLX5ZeS3rAOwx/wsKQ3pC/n6AANoE3cs5dp+lV2sMmwu3VeDOeVxDkZt4Ma0JX7MBrqIVGsRpsDswqqoUZp+XAL7ycBhnhI4tdDx7YLfyq9qQNDcSRpAg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725833470; c=relaxed/simple;
	bh=FEcKJi3TIBTVrIlNECG4KBr+qnVdz5w3UlWAN5UGjXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=beUvNvd49dWZyMj6MmKaG3TxLmocTRAKL0Myus1kd+A+wTrowzBswBUt6m50BhBzrS3lxZLKCoScG/V9ItDYu9idaQAcNcMW+iy8hdskkq5GLQSW+IsLAZyhbo8likz2NIiLNuYSuDAMFNDZ/vMXin3gVJo7D86Vako1sR+KSG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesleyac.com; spf=pass smtp.mailfrom=wesleyac.com; dkim=pass (2048-bit key) header.d=wesleyac.com header.i=@wesleyac.com header.b=HsGtMrRO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mp89Y2N4; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesleyac.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesleyac.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5FCA41380169;
	Sun,  8 Sep 2024 18:11:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 08 Sep 2024 18:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wesleyac.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1725833466; x=1725919866; bh=Uy1nYX866y67atgEChVeE
	M+VO7ArBlt1jPxhRI5QO2A=; b=HsGtMrROD5tS+b8FqHGvE5DIzrNqbLXWccHEv
	A3EknhKFd+YY180b7nj1NmZetlIaVS+9omUfUV6TigBSMTAsYG89wqFr1tjSN2vi
	ZSBsDbPsfntVRMyhj9gtBwFquCOwVZs1V7O48JBditUmZZc+ohxbtyi5EtVFe8zD
	2zPz34wTefNAm0n+RTJU/bH8lvcMcA2yI5j82TiCmDpPaB2B5BeA9T9TjHpDDE1X
	izKWcEYEFJaxuthOWln/i6YsSsQqjn6EJ0MML11lFx5IAZh0POV0fWlgg+XYXZrs
	n77wHS5M9CK+lenPNOatxZVIA4J4l4oUfC/79X70kPKiAIExw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725833466; x=1725919866; bh=Uy1nYX866y67atgEChVeEM+VO7Ar
	Blt1jPxhRI5QO2A=; b=mp89Y2N49gus7DH72iR3tsqAPvS8hLpYL6qXxSxdd3T4
	7L0p6zwEKvZe0Uki/JM6NxmcO+MMkjd0kYBtLersFrVc1yzVeJPOeEOlIigvw+zU
	D+GahC7egLF0Sfory2q80AGGx1HJ2ib2d3cqL4RC/u6AKjKNz/uEDbMa4GKMTCv1
	BH6GKb89NambFp7fYS9MJCM+4ZSvVsjyxBN1O9kd8Ouqf3x/K0r29dIy7PaV5xHm
	7T6djPAhtkGqBsc+IS24SOlcx5iV/G/lyYGt897JLOffhtY6oyh3aNs8Z1Z+d9W0
	bZpjP3gtrKiTs5ijbCnmcf3vse7oh0M9U7Ve5DwDHg==
X-ME-Sender: <xms:-iDeZhNYc7luqWPrtDDE70JjCJBpwp1GeE-YQg_iaWyfyG80uz0yFQ>
    <xme:-iDeZj-ut4riWXyY0tmhJdERj9zxjvzR-5qbw0Fb06bd1zJh5IL_kjPUUqFdH9WiJ
    0h5E8UKdeIgAtCvDQ>
X-ME-Received: <xmr:-iDeZgQjNlJmlNQ63cSslTC0fOWXAaQBfQO2L3sj2iZ5x7AHuevadp5dfjM4cbbFV3lnvKslXbbea7w6AcCc2_X3pmmx8mI28-oz_Lwaqtfi-RJM3mqnczGakkn8xPIIKRMfJ7JB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiiedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeghvghslhgvhicutehpthgvkhgrrhdq
    vegrshhsvghlshcuoehmvgesfigvshhlvgihrggtrdgtohhmqeenucggtffrrghtthgvrh
    hnpeelieejhfelffdtiefggeetvdeugeevueetuefgleeigefggeekjeetleeileehleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesfi
    gvshhlvgihrggtrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hmvgesfigvshhlvgihrggtrdgtohhm
X-ME-Proxy: <xmx:-iDeZtvsFakNVk_pAqXalZbxFiRdYe6sQjo0Db5yQaQ1CLXNTBNN9Q>
    <xmx:-iDeZpdfSjGD70AQd6KNtAS1UQjplDUucop7sb79o8NcoKGN1skY8Q>
    <xmx:-iDeZp35pmBwvNykS1rTqd41gPzKVSklRCDsMdBezCWAv2WrfMwpLw>
    <xmx:-iDeZl_ntOBoGLiI8d2MLVcoCwQGcyYfU3OKLscNvLTq_7Eseh1-vQ>
    <xmx:-iDeZiG3I9_mHGyBFZ0RVqzT3kmmXKzR69LNg3IsRBrzNfrD7V6vW93j>
Feedback-ID: i0c594533:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Sep 2024 18:11:05 -0400 (EDT)
From: Wesley Aptekar-Cassels <me@wesleyac.com>
To: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Wesley Aptekar-Cassels <me@wesleyac.com>
Subject: [PATCH] PCI: Disable FLR for more AMD Starship/Matisse functions
Date: Sun,  8 Sep 2024 18:10:28 -0400
Message-ID: <20240908221028.870055-1-me@wesleyac.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On my ASUS PRIME X570-P motherboard, trying to FLR either of these
functions hangs the device and often causes crashes, same as with the
audio and USB drivers on the same device, which are already included in
this list.

Signed-off-by: Wesley Aptekar-Cassels <me@wesleyac.com>
---
 drivers/pci/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a2ce4e08edf5..fe1a2a660095 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5493,6 +5493,8 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
 /*
  * FLR may cause the following to devices to hang:
  *
+ * AMD Starship/Matisse Reserved SPP 0x1485
+ * AMD Starship/Matisse Cryptographic Coprocessor PSPCPP 0x1486
  * AMD Starship/Matisse HD Audio Controller 0x1487
  * AMD Starship USB 3.0 Host Controller 0x148c
  * AMD Matisse USB 3.0 Host Controller 0x149c
@@ -5504,6 +5506,8 @@ static void quirk_no_flr(struct pci_dev *dev)
 {
 	dev->dev_flags |= PCI_DEV_FLAGS_NO_FLR_RESET;
 }
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1485, quirk_no_flr);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1486, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x148c, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, quirk_no_flr);
-- 
2.44.1


