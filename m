Return-Path: <linux-pci+bounces-43615-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A39CDA4A3
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 19:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04CA23028D92
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 18:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5024C34575D;
	Tue, 23 Dec 2025 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsYzFgEp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DF03376AC
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766515222; cv=none; b=bdDYyfQykx91FWvdOuP7byOpswijc0MI4QEpxGHwukJ5ONedXQaSa3Id4sVAvi6PCsdFdUFws3OOO6N/nssEmXqKHZWlYw0amHgcZ+kvnabycB2dIyGnjhb9d0mKRWFjgkXSmsgna9jjZ8M22YH/i0BjPG3J1NTbI6U+Ns0zcuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766515222; c=relaxed/simple;
	bh=rTc0WBXn6GBONjf8xQ1wBO4OSPF1Cakj8Nhe7e3ZSqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I6LfSuVUYRe0lHSe0jDdKu8PgDnXy1KXfbGYXyx+ujKu6XDucJmmDTuydwNZj4F0bFhlh2QmkNfgkfoaFwXX0LlUhpUfSM/dl7AtT2DYqDI63765yMhZCXis2MnOKuTYA3EAI2kQnsnqjuyeORZnscc8vErJTJe8sQqzS7xCfMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsYzFgEp; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a0bb2f093aso54528915ad.3
        for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 10:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766515220; x=1767120020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7zozgjBAq0lA5Zf8cCK0+g/Id5/R96R9bAfP94R8/dI=;
        b=dsYzFgEp8yj2a9iMlChFxUZw3DZHodKHrYyfODpdj1sxRt/xUiCCHess4ilaOvFBbo
         zoVnBckhvOAyoQMByRHKVSDkFVqgdRx46CPRKl4uG3S8osw0LhyVHM5JcwkxOEqb0Tyk
         TLYdoRcu8pswu6A21SBddOR2vWZS83SBjN6IDFJK5F41oCjjFivLf5wOvhdD8eIUz6vy
         +QpNxRLFC8u7NVGJwDWu6kvYnQOeQoZsAkmpCyk9WBl5nn1VIhlBkBgBn53LeYbGZcBy
         T2t52idwJ0TV5KF8HRcEfEui+cqr4J9R0Uy7SkTzQUnCj85i3L3d+NwPmcYT4dlb+yL1
         NbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766515220; x=1767120020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zozgjBAq0lA5Zf8cCK0+g/Id5/R96R9bAfP94R8/dI=;
        b=hdJR6un2mxMbMnWu2LJysNvMMZ5RHZQWswgWQEvsC0lKUNvcna9wuEhLOXVzj3uOL4
         3yBxVFb7FSW6s5MDSc6U6BMvw1Yc0CDeJ6Vt85kBC9ApA32saFgU5mBtO+Gl7NP0Yx5n
         L5Sndc2lC2TLO6hln0teGN7B2MM6VmsEvnlQYooh4ZLsUiwOo4ptLI+26daCy9Gn7VML
         tCjJGmWqjnm4MlVGqRAPSnVjNzsDkv9YDoylXXhVZBjck5oGfJeKwjMF/tFW/3wD+lux
         ez1/sI3KOOES8VzuB2jniBUXmTH6vT+WwEyTcyddB+cNQTrPpUEAjzk7KdNRqAAE6/JF
         yrDw==
X-Forwarded-Encrypted: i=1; AJvYcCWgryxxDhzCaWQikoHzO5K/+RLmEAWzCDQKF56BWh4L7GBycAO3Sj1MTkBbM9b1VbzYPz1MOo7Np4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtCALYvLx3EZqcQ6Qy5NB1vg97BYKsaD5GI7trr5pP443+JXua
	T3ulAEqZaiows5ER7wpiwiIbO9gXaNRTMu0bYdxw8On6Y4/7miAO6qzQ
X-Gm-Gg: AY/fxX47v/nscLzobUU0vem9h270+iCCHIB6aHoX2mCTeIco9zAf0b3dK3AbUspGoT1
	CfusHE1nJLRn8dNK5JfbaXUmL5XFf/WeSMu7gPsevfBRC2SlzjjTRO++zdaN/9T1/OMz6k4CD2Z
	pvLMzAr4rzU9ebuMOVw4PJkJFBAIHMzGWvu9eLljdfzIZQ1qNpa0P3zqpQhSiYkVc7A64ObQLw3
	pzy/aBT6lBkZNqQ0KVGvxOBtrJfCeJ+i7NKEfChbijQOss5+5dNdnMEUeeUJeDMBWQLkmsdJ4qp
	6aARBiBAbLrDg1OLCO7iTwzO0hs7qazO8mPlWUZGLUheSu5ZBTexUjmvpj7HavjsMShKSqWiA/D
	RnL7S80fYmj3TXYdvTKWijBPHnPqK3TROVLQ/K267lQMaWeScQAEIa3k2Fch9KrbeA9ymoQDizF
	N+s1kOcb+RevnhSFW87w==
X-Google-Smtp-Source: AGHT+IFxgClBFNPKpyMfM2FA4fTuWSDftPkXE/DYwotZ4CErh/oBbW9sPZ85sSPoQfjexcj+JxRWiQ==
X-Received: by 2002:a17:902:d484:b0:29e:c283:39fb with SMTP id d9443c01a7336-2a2f2a35736mr155387235ad.52.1766515220015;
        Tue, 23 Dec 2025 10:40:20 -0800 (PST)
Received: from rakuram-MSI ([2401:4900:67c4:84e8:6962:6799:c49e:5939])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d74ba5sm131772295ad.89.2025.12.23.10.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 10:40:19 -0800 (PST)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com
Cc: lkp@intel.com,
	error27@gmail.com,
	sai.krishna.musham@amd.com,
	tglx@linutronix.de,
	jirislaby@kernel.org,
	thippeswamy.havalige@amd.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rakuram Eswaran <rakuram.e96@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] PCI: amd-mdb: fix incorrect IRQ number in INTx error message
Date: Wed, 24 Dec 2025 00:10:03 +0530
Message-ID: <20251223184003.32950-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The INTx devm_request_irq() failure path logs an incorrect IRQ
number. The printed 'irq' variable refers to a previous MDB
interrupt mapping and does not correspond to the INTx IRQ being
requested.

Fix the error message to report pcie->intx_irq, which is the IRQ
associated with the failing request.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202512230112.AaiGqMWM-lkp@intel.com/
Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
---
Testing note:
Compile-tested only.

Static analysis was performed with Smatch to ensure the reported warning
no longer reproduces after applying this fix.

Command using for testing:
~/project/smatch/smatch_scripts/kchecker ./drivers/pci/controller/dwc/pcie-amd-mdb.c

 drivers/pci/controller/dwc/pcie-amd-mdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/controller/dwc/pcie-amd-mdb.c
index 3c6e837465bb..7e50e11fbffd 100644
--- a/drivers/pci/controller/dwc/pcie-amd-mdb.c
+++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
@@ -389,7 +389,7 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie *pcie,
 			       IRQF_NO_THREAD, NULL, pcie);
 	if (err) {
 		dev_err(dev, "Failed to request INTx IRQ %d, err=%d\n",
-			irq, err);
+			pcie->intx_irq, err);
 		return err;
 	}
 
-- 
2.51.0


