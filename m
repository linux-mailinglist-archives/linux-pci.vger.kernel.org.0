Return-Path: <linux-pci+bounces-43027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D02CBC463
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 03:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0EF130052FF
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 02:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3A8315D3D;
	Mon, 15 Dec 2025 02:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjGLRyi9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB3E2BE642
	for <linux-pci@vger.kernel.org>; Mon, 15 Dec 2025 02:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765767294; cv=none; b=cKhpJ+cC+7Uhf1eRAU99jpacbrYRW3M2AFYwNDts06/0t8KK1kCt4eUvAcuvzbf4MY7r3q+ESfWKweKbIDYvyWMa3tGUThZk9pa8W1Jir24NVrb1E1QF9GGhACuyfHE/hAIV4Cl85FvmfMQc+ptYb6lPdov31HQrKHvdA6udVqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765767294; c=relaxed/simple;
	bh=OZpQGwLdHBh8hnjQRhC78YEbdmHP4sP/KDISZGBHfLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KrdXq4AD+8nD9vuCCVOOjR7WTwuIUQDanvFutsohL6DECQHe1vywNYKnTn7vI4UgjNcA8WQkpVX5HqiaoaKVCIaaJqCIEugryxkEJAFuVmFoYfAi97wTd4g2w6ORwCHglBTC1OeX5qOKtRXR9tpFrxLcxpMnE3DrhYS/ZmvttKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjGLRyi9; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b31a665ba5so360696985a.2
        for <linux-pci@vger.kernel.org>; Sun, 14 Dec 2025 18:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765767291; x=1766372091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B67shbMqTgY6v/9Tv+VflehYM/ScLwG61ilBqh+emag=;
        b=UjGLRyi9xPKXSTKzlhUw0Mp9fcnFDxu0/f2pvIoDlU7f9T7WmG0/9jiN3r1KshQ4Or
         kWDRXzh1gs1oTZ3yQM6EW5iVRx4Lo3EvEK54EMxo8EC3PExCErSNuLAjYAW8SgBXzirr
         +IGTOzy/xmiJSG0+NXEVbXYk2p+4kt6cc+INVpYVk5bnX2r9GnMCUJn36vW7VhXMb49d
         NgiWr0VEEUeVx+aybrKSg+zHtAqnrq1CCBXshZrA5sd8NI1oXrCeZPa+7h21U46XestR
         1bgn8CxJggOO0raVtRTBJy03IarNgc5ZwiGmn/oA1pJ3Y38hTCngOi5pWSEi0FSJH9Hi
         Uu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765767291; x=1766372091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B67shbMqTgY6v/9Tv+VflehYM/ScLwG61ilBqh+emag=;
        b=R4fXTsHnWbh57wS5jcf9LPuHi6nvui3/UH6DLokjTjxtjCwn2qO5UXHcILt/YzeI6n
         0wqVEMBlMOIyQ2WboMRjCmJhAkiS1X5jEq/1mSww6GD155KofXL3D/ljBMUtffqIUn47
         F3lzGzXrGngelZftbMvpP95ds+RmdoXeXC2o4sPkgV4LMEz0417PsLDCixiEFnlEklAX
         pxwQOVPIuUoI5Dx9vF+sSo4QeB6jU/6J9I8YRZUvFK45Rd1pPoCbhE75johFuopIq16a
         Otrh/mG5yygZdGPC9t8599Pb8Ol4+aL9rWnHLHctL1dkAYibutfSbNU3VPQoOOnuH7ba
         tdJw==
X-Forwarded-Encrypted: i=1; AJvYcCXa3mHGUYUpQH2lOktpHOPy85j1zILEdMVcA/+Dx7nswLzuOkx/WKJXu//YA0O/4SlJJEVl7+xGiJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx94qItfZKvsM6kiyHmoBOxU/fMFsuYJbMm5uN9TZNI5fABdUj4
	X9/g/uPH+wdUOjwqZU+rMzUbsDx5tJOlaz64XdBh6XH5XEVote5g5175
X-Gm-Gg: AY/fxX7l7lFLIFZFm3xdiifOoc741/i7+gQuH667QnHMYStsjrChEiM3uQoTyTnizUv
	j/PQSHDhGq2EGd0kPqjuVYh3ToIJCUxH4c16vq/D1Hi9GCcIfYL16mW3e8Nk/MV/PTrEAwKQXaM
	83nQ6Oi8ryZs7NY4nJI4w/PaF1vVnO4RH3WBzg1nrtra3QXm5S8OZ6LU8/7ZlrakHJwxFFlk+7L
	MIcqqeDfXWP4BhGNtszosDkeJgIKLBlUOCR2GcNZcvl9kj7rN86YRjYQO56lW6jJgyAyKV8nYCG
	ZDP45dFwBUHOiexCWuORA/Tu6r25m55qflxdsfVMLjAi0S7z2U4y9V78tuS3bJHVeQf2Y2OXC9E
	0keV8x/xpC/QECxXEhLVknFX1CSEjdswGuLQW7C6hik1+ZVFaKhbf4XRwGt21BTew94RI02zyE/
	nQJ2Nra7NHxwbFXsoiNkU1OeGLbQ8SpYi+AY1FmSSwbTXIdB5fQ8qQm8CUhWBIQJ7Z+UiH3va2c
	BPPcmlnA7VJi80=
X-Google-Smtp-Source: AGHT+IEPrm3mJhjKN7UoHK/lnHsODtrzDz/crX3wXXtREUTn/MrMsUyJFJGuzZS4JmvRaUEjLfaVMQ==
X-Received: by 2002:a05:620a:4714:b0:8b1:728f:952e with SMTP id af79cd13be357-8bb398e2713mr1555240985a.31.1765767291178;
        Sun, 14 Dec 2025 18:54:51 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8899f5bbba8sm42165636d6.34.2025.12.14.18.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 18:54:50 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2F50FF40078;
	Sun, 14 Dec 2025 21:54:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 14 Dec 2025 21:54:50 -0500
X-ME-Sender: <xms:eng_aSmXzBT_NADsWwQWSgGwCOI-z91XOCEKuGYvqBecYboAoPRUDQ>
    <xme:eng_aZZx1TAEdj1MilEwuIy-cIA41HCQ_nMm0uriRF2VLhFkK3I_Bt1J90Xa8ssho
    Z1Cu0pln6kz9h_SwBnHtdiXaCC_aCzs2JwLSVw0NCnto8WWT6Kj9w>
X-ME-Received: <xmr:eng_aU-0sTvDVqpgBAyiHRsC7qhEwa47lEohptk7dGx-egORVxpl0NNTCEL6xhK8DrF3790dbkzQiOgvP5uEEu8AeNTZil5k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefheeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfhvghn
    ghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnh
    epgfetfffhheejgedtudeiffduteefhefggedujeduhfeifefgiefgveeuudeludffnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunh
    domhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeej
    keehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnh
    grmhgvpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegshhgvlhhgrggrshesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    grrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhr
    ohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheplhhoshhsihhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:eng_aZE_XQ4XyLTW_HUou0u05B4opkjLlWT5nmXEiro7HOBMzyVKbw>
    <xmx:eng_aefnN38NOqcvL5fH6l0kFiEa4YWPtQPxfJX0vvMCArYzZnUk1A>
    <xmx:eng_aSlcUAcyob2KspsUznr5cqNkZqHt1D4TFRUqM7hn3jTFsJXArw>
    <xmx:eng_aVqzloAl3vZ5bi14gtSMyllrNVrbNmFaGZ1OY7moCP9cZr2ZQg>
    <xmx:eng_aXFdrKOU2Rn5h2I6dD0OLTx1RXnszPzHI7EPT91wsqXzFVVwUis3>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Dec 2025 21:54:49 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH] PCI: Provide pci_free_irq_vectors() for CONFIG_PCI=n
Date: Mon, 15 Dec 2025 11:54:44 +0900
Message-ID: <20251215025444.65544-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 473b9f331718 ("rust: pci: fix build failure when CONFIG_PCI_MSI
is disabled") fixed a build error by providing rust helpers when
CONFIG_PCI_MSI=n. However the rust helpers rely on the
pci_alloc_irq_vectors() function is defined, which is not true when
CONFIG_PCI=n. There are multiple ways to fix this, e.g. a possible fix
could be just remove the calling of pci_alloc_irq_vectors() since it's
empty when CONFIG_PCI_MSI=n anyway. However, since PCI irq APIs, such as
pci_alloc_irq_vectors(), are already defined even when CONFIG_PCI=n, the
more reasonable fix is to define pci_alloc_irq_vectors() when
CONFIG_PCI=n and this aligns with the situations of other primitives as
well.

Fixes: 473b9f331718 ("rust: pci: fix build failure when CONFIG_PCI_MSI is disabled")
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
I hit a build error without this:

../rust/helpers/pci.c:36:2: error: call to undeclared function 'pci_free_irq_vectors'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   36 |         pci_free_irq_vectors(dev);
      |         ^
../rust/helpers/pci.c:36:2: note: did you mean 'pci_alloc_irq_vectors'?
../include/linux/pci.h:2208:1: note: 'pci_alloc_irq_vectors' declared here
 2208 | pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
      | ^
1 error generated.

when ./tools/testing/kunit/kunit.py run --make_options LLVM=1 --arch arm64 --kconfig_add CONFIG_RUST=y  rust_doctests_kernel

 include/linux/pci.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 864775651c6f..b5cc0c2b9906 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2210,6 +2210,10 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 {
 	return -ENOSPC;
 }
+
+static inline void pci_free_irq_vectors(struct pci_dev *dev)
+{
+}
 #endif /* CONFIG_PCI */
 
 /* Include architecture-dependent settings and functions */
-- 
2.51.0


