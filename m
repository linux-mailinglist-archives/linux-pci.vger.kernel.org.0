Return-Path: <linux-pci+bounces-12771-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC7096C40A
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 18:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991471F25CB6
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442F81E1307;
	Wed,  4 Sep 2024 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qa7o67Hk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35B81E1322;
	Wed,  4 Sep 2024 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466900; cv=none; b=QZ0jTcy5zBfTebpfFqf8c3GVdnD6Y+B9LxUiCIe2KDTc493zsWCqgRNaOu0kgpq384u9eq94bB89tUSAGI6UULYQStTZe4oXEXdQbf7x5lsnCCyLl/ctmqiXhnNtHqIu2fEBD4UEzitBAOaX/s52g0u/2XDeI/IfW1n5AUrciFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466900; c=relaxed/simple;
	bh=OZoso0PULyARjWAe4fPQ16rDIFB7Bx5gFBcDAR+D2jM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mY4JTS1r+HXWwnEb+4vCr0GBhxI9APLSfD/eE9o0f082hdoXLnMeZUpG9o1niEN+EX7I7NDeEavBTMN+9pB6D4nha7wh8EUzjGmkYxKQOos1Ml9T1eP1fhstBDJm2qLouiNspebidPKc6845Orx70OvyBKm33Hjoxt4fMYxQT0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qa7o67Hk; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2055136b612so41485815ad.0;
        Wed, 04 Sep 2024 09:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725466898; x=1726071698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dS4ZeJxSiku8iXspYoVwHHZ8/8DKLfEgc8n0+jdQ0S0=;
        b=Qa7o67Hkj38GPHR+7/9WQ4ETFcowQHzojweyuI025yQnaiuYN00F1yQykV/7Q1e62V
         nruvHSWVa2dLNHNYOV+bEWt3ad1/QvLQoLtOA2bxlvPDyTB3RFigaoY6cF1zndrkrP+j
         DYKk3MY8DWUVL/RDE2JTJNnWsJyjRYYzgF/vSc+ILanSxbd4qg3HHK7WnLqGNKVby7G7
         cFidM9Blfavb65+VR+3rNoXnRu6vF0IPe5w6shZqXOV9P0PbmO8tjsprPsYEjIjPqL5+
         9fktksRe7hRmDZUmt4rWI9gPP9x5OxMaqhESDgJO4yKAFUzkO5WAKhhTHP4PO4dxRyR7
         woiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725466898; x=1726071698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dS4ZeJxSiku8iXspYoVwHHZ8/8DKLfEgc8n0+jdQ0S0=;
        b=kezdxdqXKucngEIb5vAQ5cDzWFubFaoRvUbJKARM95YnFl8QYtjLoxxqevEEZanScn
         1mdto5QvQ0F35/UQ+WtaTgKeUAOTF8Ii2UB4zhtRlrVCbt3nuQ2n8mM9Jw+KoWOoPo3H
         cMPb1HXfVgRhzvleDsdyYMKZYoN0PpAwa+lJ1ONlLGirKmCslbjwC0OG+yrFI3kl8PKE
         wp1MgjzwZTpMBaFp5SpF35aA9HNAKFjmbq5iNvk4IxUyV+Dnore2WWEyhq8IrW8eE190
         H18fJtDN/XB6BULHn67HT5rqYwoW1izZZCEZ8r/9vJH1v26WHMueMNrUcnbgMjCgn/h2
         duTw==
X-Forwarded-Encrypted: i=1; AJvYcCVx5MxuI2qfNOzK+HWfcuzsDOE2rPZlQJ8Dqr8NjgYBxP1bUEPvOm1uT6QlLtPU5zLU0KZysnGl7mo1yT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKtetjK0i3Rlp4e4kRqY6njD0AtSOY9ZffwBnHsQYSLBeep3HH
	D2dCINLiq4rKSakmVW5lVZK5S/tX8PSSmByisL62EqJWRQMCfHrU
X-Google-Smtp-Source: AGHT+IH8pTFO9vIr0YaBR42MHh6KIRHCMK398x+2mhfnYznIbMjWOg4qLWVLoeGg0z6Q1caTBnmwHw==
X-Received: by 2002:a17:903:2a8f:b0:205:79c:56f5 with SMTP id d9443c01a7336-20546600327mr148748115ad.27.1725466897699;
        Wed, 04 Sep 2024 09:21:37 -0700 (PDT)
Received: from fedora.. ([106.219.166.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea35478sm15316985ad.123.2024.09.04.09.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 09:21:37 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: jim2101024@gmail.com,
	nsaenz@kernel.org,
	lorian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH next] PCI: brmstb: Fix type mismatch for num_inbound_wins in brcm_pcie_setup()
Date: Wed,  4 Sep 2024 21:49:54 +0530
Message-ID: <20240904161953.46790-2-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change num_inbound_wins from u8 to int in brcm_pcie_setup() function to correctly 
handle potential negative error codes returned by brcm_pcie_get_inbound_wins().
The u8 type was inappropriate for capturing the function's return value,
which can include error codes.

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index e8332fe5396e..b2859c4fd931 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1030,7 +1030,8 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	struct pci_host_bridge *bridge;
 	struct resource_entry *entry;
 	u32 tmp, burst, aspm_support;
-	u8 num_out_wins = 0, num_inbound_wins = 0;
+	u8 num_out_wins = 0
+	int num_inbound_wins = 0;
 	int memc, ret;
 
 	/* Reset the bridge */
-- 
2.46.0


