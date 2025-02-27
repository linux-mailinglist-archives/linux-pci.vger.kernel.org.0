Return-Path: <linux-pci+bounces-22520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC629A47488
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 05:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C4216F7F1
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F7F1EB5D6;
	Thu, 27 Feb 2025 04:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="idPKac2X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kxNXMJ3Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284621EFF82;
	Thu, 27 Feb 2025 04:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740630876; cv=none; b=KVeM/16bfFhPCJT39Rmt6RrDjNkgTjxBwW/jQ+N9Xg5cLW3NQnfdvsHqXkbEsjrGneYWxNcWywl4Es8hzUmGAZ2ITq+/ZSIqSJLsUQOLDxkvuSuvWQCaLe+t8GHumEno5Ph2C1lIxksRWrzRY1Ru6XQ5QZZQrd0FDp6YTX1fcks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740630876; c=relaxed/simple;
	bh=yqe0zcuR8sL3PTTRNmUYhODGCjMj01+ChgLvyDdpsEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iO8/4oAdD7FM/e7/jEIZaKlPsAA7+xNyZJ/OAX9wqijBqvZiBKeNP1U8/lrDKOu2uIjv0Lli5HgesL93UFhU0LKMfcWB/vFuCtwbzM9PIGd0OgCOAzVAAYg+JbC+abOJtsJclgxuTbSuIeANSKIQQF/pDoqvFsF2HETmdgLYYks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=idPKac2X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kxNXMJ3Z; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 2A30311401DC;
	Wed, 26 Feb 2025 23:34:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 26 Feb 2025 23:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1740630874; x=
	1740717274; bh=wpuK8Wow745m20Ym4XzR/6KOmJYhJZqQ4EL2NWYAtFc=; b=i
	dPKac2XUpZNTBOc1IOFWpnXZBTUVpeKuEdXdhbDkfD5au7rH/DFxaoZ18hNcTkrb
	KZB4n3hKCQAZAYcZF0E+YIi8fH8KsDc5TADOjvfDewOxSvdgBi340rOlcgGymH/3
	EsoTUp0PI71mW9d8PUchr+bYCFxyeFf1MRCWZ3qDqaX76v+dmwUTdeNQjmIPLKpO
	kaUx+Gp+SGcj4CyA6jG/AENiivn7fJJIPAofAGxR+9wkJUKMPxiziapK701JQdWB
	JJURrzKfimhV6s+lwen74kqCOKBj5XlDEooal+BRZOLnQD9rs5e8xvEaaEhE/edT
	/yqj38eIgu02K2rUELifA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1740630874; x=1740717274; bh=w
	puK8Wow745m20Ym4XzR/6KOmJYhJZqQ4EL2NWYAtFc=; b=kxNXMJ3ZehA/Dg3pm
	ncnRN9KwRJL9rdq4tqzCGiFeF2jrHT7JH4SQxrXyXWM5mMtI27pU31/BCHJYsIOI
	NCUqEsbaMVIhI2flmG6p1RdbHamd/gsCT6a0zDzoS87o0cpueZcj54FIwG3L48OI
	W50SJPFoXk+j7ewqVMRQJg5bFq/3ONFPwSulEOFSXzHNf8VaTNPf0GH/ZgUMtB+K
	IrFLmAEe5/iLigbMKvrNHHzDiikjchCEe4r0rzriwyMHhh7f6GU66FXH3SuFUR6H
	XV8QR7ca4u2imuTFJaTUc7jqMopfCgbl/ZF4oWObuOIWZ0syZWzeWoOT4NBpcsO9
	T2M6g==
X-ME-Sender: <xms:Weu_Z5ITUmieytSRVWlmlk3hj2C2hpFpmRCx8sG5C9hwZAVvfD46nA>
    <xme:Weu_Z1KdFRcJCIZ63r2pgny8VjYYtKluBEiEtgqMS5WkLRpeWJxRCaTakE4HWWdws
    Pl2S1V37YswKp9UNVA>
X-ME-Received: <xmr:Weu_ZxsAhFoyAk0pS2Jtq7qHjypvi9pWNpLoezkrgATJAkyHugLMsy1uxFqU5gi9oKxxYDpJv-4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekieehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgr
    nhgtihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrg
    htthgvrhhnpeeitdefkeetledvleevveeuueejffeugfeuvdetkeevjeejueetudeftefh
    gfehheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgdpnhgspghrtghpthhtohepudeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglh
    gvrdgtohhmpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehjohhnrghthhgrnhdrtggrmhgvrhhonheshhhurgifvghird
    gtohhmpdhrtghpthhtoheplhhukhgrshesfihunhhnvghrrdguvgdprhgtphhtthhopegr
    lhgvgidrfihilhhlihgrmhhsohhnsehrvgguhhgrthdrtghomhdprhgtphhtthhopegthh
    hrihhsthhirghnrdhkohgvnhhighesrghmugdrtghomhdprhgtphhtthhopehktghhsehn
    vhhiughirgdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurg
    htihhonhdrohhrghdprhgtphhtthhopehlohhgrghnghesuggvlhhtrghtvggvrdgtohhm
X-ME-Proxy: <xmx:Weu_Z6a5E-p3lM9XxcTaWnYv_SCVTQ0d8LsN95kiMTzERnCkpeV6FQ>
    <xmx:Weu_Zwb0fLiOwWtXqjretJljm4re7aYTag0wVxmlzbRlSExdLUap5Q>
    <xmx:Weu_Z-Dm33okHyH3Qz1PWzlHOsScuH9R_sxIK3S-WTu7oxg9MwRPPQ>
    <xmx:Weu_Z-Ye4AMrsBfnPUOWcS8Ra9EaW6SiGRFnd9Sp7vl38BJREmtzyw>
    <xmx:Wuu_Z2wgSMbu3HPoOb5Gh1v-ipbNifMZ48kCCl1WHm25BNz-nM5hhWkV>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 23:34:28 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	lukas@wunner.de
Cc: alex.williamson@redhat.com,
	christian.koenig@amd.com,
	kch@nvidia.com,
	gregkh@linuxfoundation.org,
	logang@deltatee.com,
	linux-kernel@vger.kernel.org,
	alistair23@gmail.com,
	chaitanyak@nvidia.com,
	rdunlap@infradead.org,
	Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v16 4/4] PCI/DOE: Allow enabling DOE without CXL
Date: Thu, 27 Feb 2025 14:34:03 +1000
Message-ID: <20250227043404.2452562-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227043404.2452562-1-alistair@alistair23.me>
References: <20250227043404.2452562-1-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCIe devices (not CXL) can support DOE as well, so allow DOE to be
enabled even if CXL isn't.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v16:
 - No changes

 drivers/pci/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 2fbd379923fd..fff4f3c6f6d3 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -122,7 +122,10 @@ config PCI_ATS
 	bool
 
 config PCI_DOE
-	bool
+	bool "Enable PCI Data Object Exchange (DOE) support"
+	help
+	  Say Y here if you want be able to communicate with PCIe DOE
+	  mailboxes.
 
 config PCI_ECAM
 	bool
-- 
2.48.1


