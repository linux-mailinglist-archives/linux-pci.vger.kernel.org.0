Return-Path: <linux-pci+bounces-12563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B1A9675BF
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 11:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7781C20CDF
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 09:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030F91448CD;
	Sun,  1 Sep 2024 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crSMoGgw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9894E41C73;
	Sun,  1 Sep 2024 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725182802; cv=none; b=eH7IiSuSwMMvfiI0zcjeNMRz7HbVaESe9CRhJbH2E0OSayeEp8rkTg1+W21YNcl62OKH/hB/yaMH1iXQ8LF+ioYJFf2Ilk7TiSsvED3D4Wk31BJUfN5d2+tzgcok8VFCZTAw3zF/lRJ6OnSwKx+ALjiBpdFepKbjBkmcBAudSC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725182802; c=relaxed/simple;
	bh=lZVi3oPehee7ahWwCiSFhb9Q1DSuoDwJZVSgB5kHzHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZBheQB2uKPSKmpjaqPgYiNeQuiiR3empx/Gk6daWy+IhJHv++H8beA+hooCYhRQgyySeVLfKhEief6d//4W+eMQsuJcX8BwhPOoD74tOvzUYCxmxltVUGg2tO1bC5AGj8ED52XlsiNE1BykFV0T1/VH30N9ImZYpb9MiRtS1SSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crSMoGgw; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-715cdc7a153so2310883b3a.0;
        Sun, 01 Sep 2024 02:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725182801; x=1725787601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TUalWoofG9Hj2A/gtFNJ+hPW7JzT+Ojll8fzqGlR68w=;
        b=crSMoGgwIKqLEZlv3gbpq5pTAXTaq8yDWC4tYnSDsovJmiH8wZEpPptCVEwJWKQKUm
         76g5ABXnY0mvLmF/wmf5fvAPvofxkNpOQnvszBE7QuASWSz05KPOXzDHDOrJctXsUvMC
         GdeX/M48zyQonHTxAcCNuNol2m4xLU7pNy+LfA7WG3vhkEfSYSjm8XOllUuA4de52AvY
         DIjiE+DV2rq19t6rRm1t9WP0Y7ytE1bO7s9sbpZvVNMmbD0noxTJt5ZAl/nU6HlvgQB1
         42b+SwGoglkEIjIYx+wz5l2BUiHv4hqsfGfUugxbdu+YocmRT53kjzLkqjfiF9/S8Adn
         Odvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725182801; x=1725787601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUalWoofG9Hj2A/gtFNJ+hPW7JzT+Ojll8fzqGlR68w=;
        b=C0ZF6Dm0OY2cv/aL4G8xsrGmoLP2sGnCelRAUEw9R1moEoyNbviZ3iwjktg1RzQcHr
         ocs4EhR/CT1yDHaZ1cOduZC7Mzgz55EW1peANr5w7xciq3JlIkzT4k6MvdyUGFcm9qnC
         hFzxBubKVC/HdR3oTPWVakDIsaB3fIGDV7M9TxpiOQ5JCSGszyXf9BOm+PVC7yG18B8b
         Dxqv7idUR62txnGG60y/QAAteWVBRez85fXEpVJeYtm1JxpUkvtkHsazAwxfu48ccV/Y
         TElw9LGkRpmUB0HH44An22RLUm53fGqIYLx8vbdSKEE1io0Po5gpPVw934WZiToVRXDp
         MBPA==
X-Forwarded-Encrypted: i=1; AJvYcCXD8GcukYsO+TIrULUiN8XVYo20/68UgLlK1pThoaAZR8hvFC1ukpqv5ToQccCYMo0RCsrpsf2wA9RwzMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFIau9O1X+wuPOjP20bZc8H4R9Z2J/rztKxzFfKesQk5F64dBz
	clL7+N3ot5jsY0MHQaHrdZrT7KkMiWWC5npE8a+W7cbfu7niP+nf80mHUPrQz1s=
X-Google-Smtp-Source: AGHT+IGPpVflFBhX52kZfcL/EhKVJSEBshOhZdRfRxwtvqa2AKIPR65F9GGfhxC4OUH7B+qP7gdpHw==
X-Received: by 2002:a05:6a21:3991:b0:1c2:8a69:338f with SMTP id adf61e73a8af0-1ccee7ab706mr12817359637.12.1725182800469;
        Sun, 01 Sep 2024 02:26:40 -0700 (PDT)
Received: from fedora.. ([106.219.167.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e575c3efsm5139905b3a.202.2024.09.01.02.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 02:26:40 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: nirmal.patel@linux.intel.com,
	jonathan.derrick@linux.dev
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH] PCI: vmd: Fix indentation issue in vmd_shutdown()
Date: Sun,  1 Sep 2024 14:56:02 +0530
Message-ID: <20240901092602.17414-1-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code in vmd_shutdown() had an indentation
issue where spaces were used instead of tabs. This commit
corrects the indentation to use tabs, adhering to the
Linux kernel coding style guidelines.

Issue reported by checkpatch
- ERROR: code indent should use tabs where possible

No functional changes are intended.

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
 drivers/pci/controller/vmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a726de0af011..28ce903b96b6 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -1053,9 +1053,9 @@ static void vmd_remove(struct pci_dev *dev)
 
 static void vmd_shutdown(struct pci_dev *dev)
 {
-        struct vmd_dev *vmd = pci_get_drvdata(dev);
+	struct vmd_dev *vmd = pci_get_drvdata(dev);
 
-        vmd_remove_irq_domain(vmd);
+	vmd_remove_irq_domain(vmd);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.46.0


