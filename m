Return-Path: <linux-pci+bounces-37655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E12BC0D8A
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 11:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 347FA3BD905
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 09:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4F22D877A;
	Tue,  7 Oct 2025 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="Ogs+k34i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8C12D8396
	for <linux-pci@vger.kernel.org>; Tue,  7 Oct 2025 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759829021; cv=none; b=gOs3ZOnIfoiMFMgOSExtn9SV35jbFxSwHvqlyE1aXaNoytt5AJBJ1bO5YvB9z0rLQ6z5pALZIGvM8tcT0jrKKFuLDUF8q4Jjf3IwVg7uY3op1Sv2cjOpdbLYi6wCzQQAt3xQ6Xe9G6M987s67TIZXsLLu2VM4PHfuPzTCsv7FxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759829021; c=relaxed/simple;
	bh=vOEMENaovdm9ccCHM/8VsN0k/NdulbFSwwEhhfsljgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igo4rsdLhVQnF8k60h74zjnyS4zx5gs+3gUe3ChmbDeUVLgCAapCu8COff5o+C9vEGvCn9J8RWcrpSnyW84BJdGyro37sCv8ddXcptKH7ym8WdzFqatO8GrKrpsAvdRxI4jbn9yidyCbfbByPBKHMiiXOh9+CIgqrx7ZtS4TOTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=Ogs+k34i; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7833765433cso7312001b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 07 Oct 2025 02:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1759829019; x=1760433819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkgHB/Rx6YD5mkkjItctKin/3uCiIG1rZ2SooPNG71I=;
        b=Ogs+k34iQj80mUBqXe/0tEw2JB1j4Ufz02d0zKGt+PIdWtEPkKi4iJ3qMBzwWzdvLR
         D8xkrYNWu3eUWW9IkZwn7V6oZIZ8s9h/fu4kJc3AgajMwvQR4gfv0hjyoWcFcEPE3B2Z
         AG5MHusaaPkoyNrjupGrso0hC0sAryHpT5M1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759829019; x=1760433819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkgHB/Rx6YD5mkkjItctKin/3uCiIG1rZ2SooPNG71I=;
        b=PHkJ/5BAyK/KwOHaVfA2ma5DVhzXAil0CjAYbW/mHnxHlxejvxXwRnCZ/wrM64Vnjc
         Xi6Ru66gZfoRcqu2Y4fA0cPXkyTfuVQy+p8sn4CLegcMuoFZ0LXRPaT7t222Pm6L1mcX
         dDtAeKGFW11g2H7IGIntm2+3Es20jJbbP0uBwZGr7G1bCRpAZgOjtNCvSHIuZbZJ8ucR
         f6SJc+fLvyMuMV1TDKMyGKe0pOW7yD2u9XJY3hhtOwreMO3oWLm4t4ch3jZ0Wtpl1gj3
         tyoDw/FO5WblZC+o4tb2psvcQk97WHqd1njFBFClZuZ3JUEsqu5asgcV/P1e9ZL2Xd/X
         gtmw==
X-Forwarded-Encrypted: i=1; AJvYcCWkYGQawDOdfbkh6C01cPx9JDVTCZx5un0CU8X6MqrF2pmaUHLjAvrktZm4xrmkZY4tpgLhYrQpcVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YycNj2coRay9n96r6gmGs387WpWpv7nXj12dstn1hGlzffmsgse
	88RlYTlvrMe0DRTkyWgq2+hSHG1ZgkFwOoPGkP8es9zvGFw8G/Isby69hfONdCjN8XQ=
X-Gm-Gg: ASbGnctnoPN0DoGTe4xMWH/f34nD9yMm4Z6ol4U7bNWvqXw1lxfSxV4NjaryBbrkSR/
	AZL5UjSR7ZGsaSFAmSFoJd5WVX5hRBBUdcJRK9otjFDBdrGAUvmtPGJqMylDdiiTbsREynj/B0H
	N7FHbCrJeJuQIMPJC8Oj275+oJe7L9DO4S4f2VIeu7SACe/zGyz2rnAsX9H1LhIACQp7+Ms4rrZ
	9mTBaAIXFSQzJrLF8SQiP/iAU7FVdjpHlXm1UGRVw+iXBanIF1F44QOT7wWfvbdVaxi0hsg77FE
	se3bnRhFcjj4npQ/WDBs6Tvrjoj/jWuoSusgP+FZS6P+FXD0gG9gIsWW7y2VdxctVvFyvYuBQSh
	8tXiakO+3rdJA0b4yUANd4pptJcB0zJuQfxBAVTQD8xMDm+wS3gAqYMBxO49vOR/wPoVTgfpZ5C
	qbqpqUmIdUifDnzLYfL/zbPq0RevjpViHzimc=
X-Google-Smtp-Source: AGHT+IEkoZ49NHDSFtXnBk2cm2DDRooGytgcNKyAOw5DMVDLSoZWdRSYe50TuAE1idLzf3WVMAfdyQ==
X-Received: by 2002:a05:6a20:958f:b0:24e:e270:2f64 with SMTP id adf61e73a8af0-32b61b30302mr20565633637.0.1759829019271;
        Tue, 07 Oct 2025 02:23:39 -0700 (PDT)
Received: from kinako.work.home.arpa (p1522181-ipxg00c01sizuokaden.shizuoka.ocn.ne.jp. [122.26.198.181])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-78b01f99acesm15123273b3a.5.2025.10.07.02.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 02:23:38 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: linux-m68k@lists.linux-m68k.org,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@thingy.jp>
Subject: [RFC PATCH 3/5] m68k: amiga: Allow PCI
Date: Tue,  7 Oct 2025 18:23:11 +0900
Message-ID: <20251007092313.755856-4-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007092313.755856-1-daniel@thingy.jp>
References: <20251007092313.755856-1-daniel@thingy.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Amiga has various options for adding a PCI bus so select HAVE_PCI.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 arch/m68k/Kconfig.machine | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index de39f23b180e..b170ebf39273 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -7,6 +7,7 @@ config AMIGA
 	bool "Amiga support"
 	depends on MMU
 	select LEGACY_TIMER_TICK
+	select HAVE_PCI
 	help
 	  This option enables support for the Amiga series of computers. If
 	  you plan to use this kernel on an Amiga, say Y here and browse the
-- 
2.51.0


