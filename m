Return-Path: <linux-pci+bounces-10557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FDF937DDA
	for <lists+linux-pci@lfdr.de>; Sat, 20 Jul 2024 00:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 674C7B214EB
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 22:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA5B146A85;
	Fri, 19 Jul 2024 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3nb3sKE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BA2824AF;
	Fri, 19 Jul 2024 22:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721428693; cv=none; b=rQSyy+W6VS6PqaITXS+iccP9/PV0hdgyFqAUWK/XRG1D4UGC4nU69vwX+horkISf8X11gBivzhyG7O7gi9Q3niybzJGo1kFZOgt1Uq8tcvb5WE6POFGLV3h/7OAobQDPp4Y4OzAq3ChrjaKw2XG7oDeb7ZPgI1MMq6b9Wq9dUz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721428693; c=relaxed/simple;
	bh=AOL6oybNsYv+kJz4Fuq3KaL7kwQeJyV1WWFA69iVw3A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=St6w6P82bukhPLDK1/4RGtWrRh+IhBQqqkXpyLfrgPqYBndi5TvTC80c9o7ScRD6EU6DPAPu7pdFgNVRzH/oJJdhhjCFVA62s9zn6SQiqx6zdvXYjPWjnYasoSR9b1iExLdWDux1R9jg2up/wSVR3LBrQnHLESOVm9BVcZhhxKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3nb3sKE; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e05f913e382so2288134276.2;
        Fri, 19 Jul 2024 15:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721428691; x=1722033491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yajgJ/IJhYEcik8fV89GUj52LUucEX1C3ZbhAbCZRMw=;
        b=Q3nb3sKEHZKQwVEl/Y4YkHPfxWHm03wxjUKkfUaC9+OU65kNqBF+6SAqG3Gxfo89uX
         MxIxzywBZAZaY1973DJ5gNzM5Ma2YdMFTYpksfK/CROk+AVkO3FY2Fdv9ytP3d8bTEDB
         NFyFrCftub199dPWJwR1x1DwOVUt6r3AVs5kHwDQ15n7KNunZBnHl24a6rocZmi55Hnx
         ClnQTFl4yCyqgOdmhdSalX38aqN/wHmVQ7xNYYEQcLnOiXXJ+rCSOmiLK0gCTqEDxKSc
         RecyAWO81Azr9D/fPKHDyigdXToWMgB2jw9UaNIafgFBTMYwXs7rGg0n20Zte1QhIq4K
         VR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721428691; x=1722033491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yajgJ/IJhYEcik8fV89GUj52LUucEX1C3ZbhAbCZRMw=;
        b=xHrcyMK7xYmXZMSuVKhmdPLVWyoOGWlQRFFeqP5JUkiC1Pu3QxYlevwLPfOx5yEk1V
         q3K3if3qMngxaWPDbiJT0ID2SPxoelF6jgEwITvbC/Z84vcg+iH2in0dDX4IDb6NdEVS
         HKOqq9KMd5MgkHjq0fIvw4lGGwre07Wjz97aYuKzcMuy43iL7bcByJR8b+nt1EXQa04Y
         Kdrs3t/OHWEF+SHvzdAgbTFQe0nS7vJwlMoXnqwAJZHZdWLXCUn+fxg2E5quXQDz1+Vj
         81fVXTIYfahHkul+699Dcdm99K/2qz35ioh2uJQAYO07CiYdYIUHsbnrFlxlmgbzy4y8
         sJvw==
X-Forwarded-Encrypted: i=1; AJvYcCUj6A+Fap27EK3k2UMasKeh1lO+5MyrQEms42kpHKgbYnORrtJcQJLGfJFoHaNz4DHGnsrtOKi6awt5mUUg87OJ8YI83TdWZOyhP53p7Bm8filycRmdoFfQQsBF3vrTSQ26nBreOm9b
X-Gm-Message-State: AOJu0YzPzERTE6cu3ALg4iORnDjpSt2+sIP/eNwDEGqiNHnCt+JuxlN/
	JOuDVZpBxB1dMJG9uBgR8opVSmAhrH8G5ln/RS9u97Akz/M0G73VD4nDfQ==
X-Google-Smtp-Source: AGHT+IGmXKWQZHMr3IUXXDpQWn3TUSxg4V0pQqCoFif08uPl/I6Pyhjee+X2Nz+i39t5xVSIb1QY0w==
X-Received: by 2002:a05:690c:dcd:b0:65f:a486:5a61 with SMTP id 00721157ae682-668b9ef212dmr79286537b3.10.1721428690876;
        Fri, 19 Jul 2024 15:38:10 -0700 (PDT)
Received: from localhost (c-76-153-16-50.hsd1.fl.comcast.net. [76.153.16.50])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-66951f7282dsm7325987b3.8.2024.07.19.15.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 15:38:10 -0700 (PDT)
From: David Hunter <david.hunter.linux@gmail.com>
To: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Hunter <david.hunter.linux@gmail.com>,
	julia.lawall@inria.fr,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com
Subject: [PATCH] of.c: replace of_node_put with __free improves cleanup
Date: Fri, 19 Jul 2024 18:38:05 -0400
Message-Id: <20240719223805.102929-1-david.hunter.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of the __free function allows the cleanup to be based on scope
instead of on another function called later. This makes the cleanup
automatic and less susceptible to errors later.

This code was compiled without errors or warnings.

Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
---
 drivers/pci/of.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index b908fe1ae951..8b150982f5cd 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -616,16 +616,14 @@ int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
 
 void of_pci_remove_node(struct pci_dev *pdev)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node) = pci_device_to_OF_node(pdev);
 
-	np = pci_device_to_OF_node(pdev);
 	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
 		return;
 	pdev->dev.of_node = NULL;
 
 	of_changeset_revert(np->data);
 	of_changeset_destroy(np->data);
-	of_node_put(np);
 }
 
 void of_pci_make_dev_node(struct pci_dev *pdev)
-- 
2.34.1


