Return-Path: <linux-pci+bounces-27402-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B30AAEF4B
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 01:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945DF9815F9
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 23:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA0828E59F;
	Wed,  7 May 2025 23:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nSc9E0IF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618754B1E7F
	for <linux-pci@vger.kernel.org>; Wed,  7 May 2025 23:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746660574; cv=none; b=jIwxm5lalcVxN++ONc7+vDXGt5qiEScm6BR4DxBj33cBqDzhKVsCuEmnZ56yyxlELpaapFJ7q6WRKmbu0prY1Afm4QAinjW5L2M9Zz2bN/x3G8pV6SmjKED3QS4H0G4PGTbNKMP6Q3PBzSpuSV0CQqLUXMQTvvLMvkHbTGLAVYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746660574; c=relaxed/simple;
	bh=cA3nZ+47Np47/k2SgDsvbWMsfWOH1A6Ausk1woOuJlw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qDntXKnUlnh1iRRs4oDnh30/tkAZ2iEZvrhBXGQjM8/w68e77gdrBZd5RRrzm9CPTfW0EzgBKfRRIbb6MF1gda6aA0QaCG4ikNau3sNunsbjZg6GQPHlv7c0Hywkj7og/i/YSiRBxlGIepVy3ILH/+QiVX1cE+2u00H0CfVi3Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ammarq.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nSc9E0IF; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ammarq.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74089884644so410399b3a.3
        for <linux-pci@vger.kernel.org>; Wed, 07 May 2025 16:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746660573; x=1747265373; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g4vZXdmlr0Ib3hABccKLLz+7+GjpdBalfaH2InUcmWA=;
        b=nSc9E0IFu2QYeYCPmh6xkKv9g78oDQoUf4TTBO9L1zExsmmAhHg+kqWJnKhShktCrd
         8ufaA4pDrnmB/nf/laTKzmSGsFVhuJ7pe8fftx7iu1+YuBVz5Xqi4i3mi5YpovwDldvN
         iU89OA4Hqm+9+ciJqumxGNLa7vwILLJE3coHA4iWC2GXGACa9Ml1AOyZiPlowUirHJ9N
         Wy95SfbUVi0ADDwVyEGmfPzI1pOW14ub0Ct81kSyomq3rJ8l+as4yWcD6Bn+dbdjBXJl
         EHDj8J2wMFsyN2sNDWkbCaPBMlUB/bNOEqgT3wtLS5Qq6wJP8G5+aCIFAGhrZZZLTh35
         rm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746660573; x=1747265373;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g4vZXdmlr0Ib3hABccKLLz+7+GjpdBalfaH2InUcmWA=;
        b=wNPLoNzGsh9SbXrCxSbQj3//DnPsu9ZCMGgFLViLx8Y/Z5KcvQL2AVgtQ6OtAb+i8L
         E+FGi3uEZ1S3pSaUmuBOG6tfBX/y5nXQsVx70VfFJRB5fN2bax/Oe2qXJi5go9tLGv7A
         staG+V0ImNv+njPeX2EXzuiKmA+wA6xsfSRF1ZLyOHz5VhozhejWKTcgyesIjTdFN6ne
         YiIRDYS/MtWvtUtzSUmUs6f0YZ5/q7SM/JsQ4nSp1LWxBVomqBkmYZmMxnGrdpyfEzKr
         n2VFbTGcME4drwaPofLf0fwNV8Ab1ObDvvfQgzf33iJuaH3jBXjblG3UyRR6tzjdnKKb
         NKuA==
X-Gm-Message-State: AOJu0Yw6gVs+Cs8hsUMRB55baIi+CGG2kx3D5O8HWGxgrT4EpsOrAhuu
	u9eRcm9tNT6X9VryN4kkIPapjBrbnxx10pz/X2LNTAZBdtXWbaXtsmjrPWkAN2en5eIvadadHFv
	TLQ==
X-Google-Smtp-Source: AGHT+IHHAYzNaFA/bcGy/j5LLehiRiaIWZ/+FhNrGNe7rHwAPk8GvTUcemAtW3iw6AAELIGDuhFfIh+cIwU=
X-Received: from pfie11.prod.google.com ([2002:a62:ee0b:0:b0:73e:665:360])
 (user=ammarq job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3305:b0:736:5725:59b4
 with SMTP id d2e1a72fcca58-7409cedc6dbmr8091350b3a.3.1746660572653; Wed, 07
 May 2025 16:29:32 -0700 (PDT)
Date: Wed,  7 May 2025 23:29:19 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.987.g0cc8ee98dc-goog
Message-ID: <20250507232919.801801-1-ammarq@google.com>
Subject: [PATCH] PCI: Reduce verbosity of device enable messages
From: Ammar Qadri <ammarq@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ammar Qadri <ammarq@google.com>
Content-Type: text/plain; charset="UTF-8"

Excessive logging of PCIe device enable operations can create significant
noise in system logs, especially in environments with a high number of
such devices, especially VFs.

High-rate logging can cause log files to rotate too quickly, losing
valuable information from other system components.This commit addresses
this issue by downgrading the logging level of "enabling device" messages
from `info` to `dbg`.

Signed-off-by: Ammar Qadri <ammarq@google.com>
---
 drivers/pci/setup-res.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index c6657cdd06f67..be669ff6ca240 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -516,7 +516,7 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
 	}
 
 	if (cmd != old_cmd) {
-		pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
+		pci_dbg(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
 	return 0;
-- 
2.49.0.987.g0cc8ee98dc-goog


