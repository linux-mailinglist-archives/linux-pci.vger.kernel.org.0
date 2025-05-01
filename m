Return-Path: <linux-pci+bounces-27070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1D5AA610C
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 17:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E849C29A0
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 15:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1FF20B807;
	Thu,  1 May 2025 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VR+3thRX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC101210185;
	Thu,  1 May 2025 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746115001; cv=none; b=bKQkUjlU6/mHMQTrQia2gDxcF5OSh8RWu1XVCrdEm7P6DvJeoR9q2pJmIX0CuwSB/aw+dXNv8I7aAjnPHnNk/8PMWmy+hEmMThzj/+VRfWyiUl2Z/IbyRR8FTc/Av5IsoGkfLS0GpAsDN199gdYa17xXTpUc/Ut1NX3sHUWqfq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746115001; c=relaxed/simple;
	bh=dpeZyhbEJMm07kKSWpfBGYSW9Zg23u7YX8CGdRY1guk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDYMao7brH+G5MBpdRcFA9EGpF/ytMHMi462EOLK0J+rgMT4lFVQwqwhdRkYKd8FJSP67g85roHf4Wng+Utd4noCl5KfDCAyxJt/fQ88V1cWbVPdP5DK4kztT/ex9XItmwoJbVn7aPpikCKlmm9IFPkb771v4EzHJj5Ed6d/EWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VR+3thRX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so3403485e9.1;
        Thu, 01 May 2025 08:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746114998; x=1746719798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQy0NQT+3evnck4iehrKrqmJJc+AvuO+V5yJn4et+1Q=;
        b=VR+3thRXROMUAXDJTYD5knmWX/jkHlmyJXJVT6P7cuH4L9lae6q8OXbnM2Yb+Xj3D/
         uUHyNSrT6y2U9kHLH44abQz0FAYWXn965rMwqFjY5rSaIrHyiXAAd1jyZnXf/H77GQgo
         7VFREtb6ppPt9vRc8zvdeSZBHDpSq1aleoMtZbGvTXV2f8UE5+fJEVC+k8DDCX6riTPp
         ZCcGOlMZtAK7nUPW7T9hDULMOiXSJqDAMBD/+4SlPA46x6vRDAgMedJQCDYqaHQ6XCr9
         JAFOnj1lLR4idumLujq385klG3fS4+0frRS4tYCEcKXB4MXqlxxr6ALyxjF3xEkEwEFF
         3HAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746114998; x=1746719798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQy0NQT+3evnck4iehrKrqmJJc+AvuO+V5yJn4et+1Q=;
        b=DUKUQgvZd61ZW8GGqFMUvMl0kD3s8bjZKM/kMCr4lzL5x1yMum2Wfj4QO48/SI8kg1
         KidPmG8V59HdJiOPnREglVFTHMpYZiaB7dJejzWRR1PrhiiBK9KAWPacEIjtmWL5Vcjx
         F2CCTHC0OK9bSB82rTIR98luJuLFN9uKSRFRUKDJDt9j7vxzVrhtTk6a5mot9b0o6Xp6
         cxPGKv4C3nGTfwE6i8WMQaX7snmNTlR/mYG+I1Bgalb8YhbiwsORF0KdphfDVZInNv69
         I+slzVZw1nXSxOMZ+p+H/iznQE4KQViuqJggjy7KIgA8Tro049cGvaqZnLTTkiRYSLwt
         L1Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUNV4XtUU3YKWDHtuRdlR+1GQm8ifEN+jvGbTNBzB54imgfYrrIQK0HTH7evNgMdFAali1cyqNAqPf29Pw=@vger.kernel.org, AJvYcCXhnsOumRlYli0OkDKD10P2wResJyX+iwDBipCM82M+QftmXTpBFOII0u+u6dHFRmgbWJQHqBVHEh6l@vger.kernel.org
X-Gm-Message-State: AOJu0YwH6hauR/4a2dqtcFqRUY+ORok9f0vpAW58TUGINkbLP/xTa5Sa
	joIggL68IWTPfuUe3X2DhOGRdFpcwWice8lvyg4YkvJ2/Mtn/k9A
X-Gm-Gg: ASbGncsROCdAWIEdYNtmEdGiM/GtGSTyOjHArsHrJOYxxtaideMXtTQ/74Pk1pAwqDM
	8D+qU6zDvHBgk5jPn+/vulVpLCzrtdzbvIkLj9sFAzJq22LQ6N52wn1jKAXR7Gy6PxazoYLsVHY
	rUjCqkuq4g0qcq7HoKW0O+h7nTGWEjkuIWCFDdcIkNEqE7DrpFnlkjO8hA1GSeBRH3yc8PADP5J
	uAspyzZKYlFgtWnXIpVI6+V79WdaYC1clgRv6x1nKEz7e7hXefufhNumuOEEueXQ8fD6BshOG1D
	+T34A4pDRyN1lDhZti8wq4vqu/QimUSZBfylEA==
X-Google-Smtp-Source: AGHT+IEDVY77OeKaGakqap7NdROdScgPMVbro1o6hQwKT98+l+7AyAFCKp64NO45BaUXR98syN72vg==
X-Received: by 2002:a05:600c:4e52:b0:43d:934:ea97 with SMTP id 5b1f17b1804b1-441b2695cc2mr62734405e9.27.1746114998156;
        Thu, 01 May 2025 08:56:38 -0700 (PDT)
Received: from pc.. ([197.232.62.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89ee37dsm16226065e9.22.2025.05.01.08.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 08:56:37 -0700 (PDT)
From: Erick Karanja <karanja99erick@gmail.com>
To: manivannan.sadhasivam@linaro.org,
	kw@linux.com
Cc: kishon@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr,
	Erick Karanja <karanja99erick@gmail.com>
Subject: [PATCH 2/2] PCI: endpoint: Use scoped_guard for manual mutex lock/unlock
Date: Thu,  1 May 2025 18:56:12 +0300
Message-ID: <88bf352aab2b3ba68b2381b23706513e4cdea155.1746114596.git.karanja99erick@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746114596.git.karanja99erick@gmail.com>
References: <cover.1746114596.git.karanja99erick@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This refactor replaces manual mutex lock/unlock with scoped_guard()
in places where early exits use goto. Using scoped_guard()
avoids error-prone unlock paths and simplifies control flow.

Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 53 +++++++++++++----------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index beabea00af91..3f3ff36fa8ab 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -709,7 +709,6 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
 {
 	struct list_head *list;
 	u32 func_no;
-	int ret = 0;
 
 	if (IS_ERR_OR_NULL(epc) || epf->is_vf)
 		return -EINVAL;
@@ -720,36 +719,32 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
 	if (type == SECONDARY_INTERFACE && epf->sec_epc)
 		return -EBUSY;
 
-	mutex_lock(&epc->list_lock);
-	func_no = find_first_zero_bit(&epc->function_num_map,
-				      BITS_PER_LONG);
-	if (func_no >= BITS_PER_LONG) {
-		ret = -EINVAL;
-		goto ret;
-	}
-
-	if (func_no > epc->max_functions - 1) {
-		dev_err(&epc->dev, "Exceeding max supported Function Number\n");
-		ret = -EINVAL;
-		goto ret;
+	scoped_guard(mutex, &epc->list_lock) {
+		func_no = find_first_zero_bit(&epc->function_num_map,
+					      BITS_PER_LONG);
+		if (func_no >= BITS_PER_LONG)
+			return -EINVAL;
+
+		if (func_no > epc->max_functions - 1) {
+			dev_err(&epc->dev, "Exceeding max supported Function Number\n");
+			return -EINVAL;
+		}
+
+		set_bit(func_no, &epc->function_num_map);
+		if (type == PRIMARY_INTERFACE) {
+			epf->func_no = func_no;
+			epf->epc = epc;
+			list = &epf->list;
+		} else {
+			epf->sec_epc_func_no = func_no;
+			epf->sec_epc = epc;
+			list = &epf->sec_epc_list;
+		}
+
+		list_add_tail(list, &epc->pci_epf);
 	}
 
-	set_bit(func_no, &epc->function_num_map);
-	if (type == PRIMARY_INTERFACE) {
-		epf->func_no = func_no;
-		epf->epc = epc;
-		list = &epf->list;
-	} else {
-		epf->sec_epc_func_no = func_no;
-		epf->sec_epc = epc;
-		list = &epf->sec_epc_list;
-	}
-
-	list_add_tail(list, &epc->pci_epf);
-ret:
-	mutex_unlock(&epc->list_lock);
-
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_epc_add_epf);
 
-- 
2.43.0


