Return-Path: <linux-pci+bounces-39678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2800C1C289
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01969188A930
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 16:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5071A34B1B6;
	Wed, 29 Oct 2025 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6u7zSRA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C29D347FEC
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755635; cv=none; b=S0q2IVrbSkTPmUmJWBSUGMxMfZHGsUV0Gegc9hjdoy8TPMytCQy9Vmg4+DUxJLQ2joRI2Cx/MWofsF/VnJm0BlbdD2Gx117zepjNqsWN5tbJPtkBUHwAwuhLQixSROZTnmApkhs+decAj7psu1INH/fr5OG6xDeXTp97v1n2kOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755635; c=relaxed/simple;
	bh=T06l1/4GOHE/LpDkePy4eVSTWo0uNva18SmJ0icOHLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGt8QQia+zyIh1fqmnn+vFfrtgks7JFsgIQV2JRXJTl3dPptFC/F3PUK87PHfHVdoZKcNfpFCUU/uoZZimeYSu4GhpDfugKo9vfGDYTHYTCQiM7CpXItZKcpOOxQRWQjTiAlQCOVO/MpXBbZLbbvzMlnCMAgAs/tYuw6a8qptyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6u7zSRA; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b6d6984a5baso11065566b.3
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 09:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761755630; x=1762360430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XbRLU+7LExsM1Q2W4kgKdkH4Wh0K6zsU36k2L5dwa0=;
        b=a6u7zSRALXcD5cAfl7zziHXqingpPMwA+3HQpLoOUYAN+T4DZYbzvXQku88P5LytsG
         dSepd0zu7KwPEm+SLTpu7V5mZsAQiytCslwBZjiW4yUtTcTJQVUXYl8R4juqoTdj51JI
         hCf1+U2YwclJoZF5yhDg/VxPsE6YKgy2pkmrqgE4KuIgw4dbPiW6aPL5RpFKbASmU9Fr
         AQZoN4oxCVq06kTWykouoPPTYq731ySwec2CxMhlePbiX0q6OgoGOpbNmyKXbrtrsNd6
         Wt1rhpU4kMgjFyK9e0qmJH4LqvKrN/HO0Gl3VvRi3eWCGseFGqkfUaC9te4+Xnky0T79
         IADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761755630; x=1762360430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XbRLU+7LExsM1Q2W4kgKdkH4Wh0K6zsU36k2L5dwa0=;
        b=VL88jlM+HDp51TNJRPEwRqw5aJAIEHaD3MMC7e61Or97hnA2UOnoslNXod+n/Q7lTr
         7oJwe6LM/gLsI8qoKMHfF6K3+8KG+RSQhEsxDcTv6czHrRUfcdpD2Y+GItAP01keKdVK
         b1FuetWtc3KdP9Q/sB/54afgro2IJEEmS1mY08oixjusdUiNdMufsQ+/oxBBeQ+qV5qZ
         S9yW+ASRvtshds0wyLx3kUdzv4Qd/6R3bJue7Op+1fgY60ySoRTldbQEUsb1HtITbkqo
         alCyBmeu/VIUlCfNoXtKzac4o4CAuFSz+jsAaUxTVmq3S2DVTILYXVp93Q/gwLB3xnA2
         KB+g==
X-Forwarded-Encrypted: i=1; AJvYcCU/Rc0O5FUTbq46w82+nOdnwxCFLh9ZZGTXbxE+rlqNxzgJKCtwJEYYCImnlHVyl0kXknhfnW4vYcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzGcN7rGceeAhJ1qU+DWO+/d2bLbbPb2hz8RLrq6v08059qVxC
	CdXzE28GUdDoGL7bpnVfIXCqIqOLmBL2R7lVd3fyrSCBYy9MvvFnLqnE
X-Gm-Gg: ASbGncs9SPUP51WnPVSxioAFlszWN91KJIQOHJQVrDH9EQ/Vb/r144k8gx3mMHzSrFf
	UFsHzMrhV/1j2C5c0KEyhLkIMj1SvTU08gjDsiWP7yjypYezBxrvs/TsxyAnvOo1+m+IXKg+ld2
	1W4dWb24nrEcDH6Jy+P7RGI/1rNfVBx9pf22q+rq4B8eiDogmhzGJY3G4s8UNRnLObatlrh5Ujs
	LknSrEeSLp+v6Ksel9bEDgFBDyVDbeEL8nDDXLX9lIUy6dfCphu9/SJm6ocJa0BdsNXrlshK0Y6
	tn10qAUnG/neoUFYiFJrQuKldY9vfllo8LmZmT7OOiSVVViuGxtELEk7mKSx0xiBeEI8NcTYOzU
	V50QU8gBwLK/3jIn1O9/ETIw4JH7y/8mQrZxmOQXLh+yFJ0uEROr2i6pp0/HxvROYsQ8jP33MXw
	1r3UzpPSuHqREZDBL1YunBuGAJK7kE5gr3hsFRWIVsJH29KL/rTGhPClE2ttRXAKdnvoIJ
X-Google-Smtp-Source: AGHT+IFQlpirQWvqETIaDsilJH4sjQW05iHSTqO+BVFy04krtNR3muOIO8OYFK3MmzGZwCCaLhUORw==
X-Received: by 2002:a17:907:1c8c:b0:b3e:580a:1842 with SMTP id a640c23a62f3a-b703d557003mr393915166b.48.1761755629552;
        Wed, 29 Oct 2025 09:33:49 -0700 (PDT)
Received: from localhost (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b6dad195456sm939661066b.72.2025.10.29.09.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:33:48 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-mips@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] bus: mvebu-mbus: Use contextual data instead of global variable
Date: Wed, 29 Oct 2025 17:33:32 +0100
Message-ID: <20251029163336.2785270-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029163336.2785270-1-thierry.reding@gmail.com>
References: <20251029163336.2785270-1-thierry.reding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

Pass the driver-specific data via the syscore struct and use it in the
syscore ops.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- adjust for API changes and update commit message

 drivers/bus/mvebu-mbus.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index dd94145c9b22..d33c8e42e91c 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -130,6 +130,7 @@ struct mvebu_mbus_win_data {
 };
 
 struct mvebu_mbus_state {
+	struct syscore syscore;
 	void __iomem *mbuswins_base;
 	void __iomem *sdramwins_base;
 	void __iomem *mbusbridge_base;
@@ -1008,7 +1009,7 @@ fs_initcall(mvebu_mbus_debugfs_init);
 
 static int mvebu_mbus_suspend(void *data)
 {
-	struct mvebu_mbus_state *s = &mbus_state;
+	struct mvebu_mbus_state *s = data;
 	int win;
 
 	if (!s->mbusbridge_base)
@@ -1042,7 +1043,7 @@ static int mvebu_mbus_suspend(void *data)
 
 static void mvebu_mbus_resume(void *data)
 {
-	struct mvebu_mbus_state *s = &mbus_state;
+	struct mvebu_mbus_state *s = data;
 	int win;
 
 	writel(s->mbus_bridge_ctrl,
@@ -1074,10 +1075,6 @@ static const struct syscore_ops mvebu_mbus_syscore_ops = {
 	.resume = mvebu_mbus_resume,
 };
 
-static struct syscore mvebu_mbus_syscore = {
-	.ops = &mvebu_mbus_syscore_ops,
-};
-
 static int __init mvebu_mbus_common_init(struct mvebu_mbus_state *mbus,
 					 phys_addr_t mbuswins_phys_base,
 					 size_t mbuswins_size,
@@ -1122,7 +1119,9 @@ static int __init mvebu_mbus_common_init(struct mvebu_mbus_state *mbus,
 		writel(UNIT_SYNC_BARRIER_ALL,
 		       mbus->mbuswins_base + UNIT_SYNC_BARRIER_OFF);
 
-	register_syscore(&mvebu_mbus_syscore);
+	mbus->syscore.ops = &mvebu_mbus_syscore_ops;
+	mbus->syscore.data = mbus;
+	register_syscore(&mbus->syscore);
 
 	return 0;
 }
-- 
2.51.0


