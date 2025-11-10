Return-Path: <linux-pci+bounces-40691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCEBC460FA
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 11:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B10318822C2
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 10:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8273A3054EE;
	Mon, 10 Nov 2025 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YwOOKMqs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A091E2FDC57
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771923; cv=none; b=VJK6OFeUflTVchlBYu4CaAFVGRiMxznz2jCf+7NfJtOmGWpg7mEiXqaWLUFhST1kIixo4qIIa/PWfUI7RXU+JAlsQriI+NnoNOg1l/c6Fxh63hZJqXKMg1FnjHejmlp6tN8hRpFktDGiOAp4zkgY2mPcHFYpHSYC2VTyc1h+2u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771923; c=relaxed/simple;
	bh=y3edu1LJoiiM9LC+PEFZk26GY+1kMRaZynUHxgNfbZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RM9r/BglSlDGvi9F4klApkDW62zJCM5TEUpvbePO6qCyp3mEEh37uZyL98mNw74cQcjp1fzGChSzbBgG2xpdfe+TUiNhMPO+KIlEKHdd7WCHG3ItxTYLzE/uQSaQkAREgfhY3saojEhS++Tw1YCnwgkwt8eq0r8Tt81Mal2jwEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YwOOKMqs; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6419aaced59so920221a12.0
        for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 02:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762771920; x=1763376720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hlF8y7focvzFqRSo0xYtMNEXP2QB9fpiWlRAbhS1B/M=;
        b=YwOOKMqsvRuTx0jTMnkaD06bBMCN8ErckrQFoZi8W63ys1y3WFpcUYPoSanTykbytM
         3/oaeCmoouTzGPP0qEsOTzU/2/XeHsT50ZU79QayWITvg2FCNI9H5u2zFoRxUKVuT7RC
         njjrxSxXl1lBeqo7nH/IVIU+XNCV0O9xuKcBr+AXNG5Vn9df3oss0gDBloCoYpIB6DQm
         rCbaVhmlE+M7/Ce5cmPC8vylz6wyXC74zvIbhKTG+l55Kgrduz2ft/WsY1sMXs1pCThq
         mLqepJec3odPNvwnaEw/GLg2Dfxl9YVjqr0Mcf1mMAf1rmbvDJtDAHoSRDGDTUmtMTnJ
         2RSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762771920; x=1763376720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlF8y7focvzFqRSo0xYtMNEXP2QB9fpiWlRAbhS1B/M=;
        b=wnYCalZXIRacAni5t1M3XrDq4k1YS4gdB6Y58b8x5jdoXUSNbY00Y6dFiUdrsQBfpL
         LIFp6lvyvezUzQ3p4rJAM6RqDQFhU3fmlm5m1KgLtSRHppejDt/8zZ3mNwO0u49c1kZB
         pgY/JVCBat/MxDVmnUFrZO3jJyI0eQgeM5iSwf1PQiBq2CvO5rwSQCTkIs+D7ztbf23s
         vhgw7oYOVwR1NSFCYxYUaou3Cn1NfJflX3m3F+YTxsmHxArbU54LnoMyoCzPuQDFqkLt
         o1xZx2M7JZe4pil9yP2PeTRxj1m41GnNcXLTOdal9yWjq3KFpq4di6m6+wpeLeU/r6qD
         cQ/A==
X-Forwarded-Encrypted: i=1; AJvYcCXI/6dtJnF270HDsOVRO/saRiuVv1/y+vRMd4lQkdbr+m/8DS8UYraviYl+ePY7p+yQyalaxKwkXLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYzCQIvlq4P1+1+GwiwHhytd86V40xL8liGiPE3/P4hcEdIScJ
	nwmSKk9z59gktiVI3q9GcTs00XXxjhD8fL8IccLSG/SZ9GV2huR9YrV38MVbKUohZHU=
X-Gm-Gg: ASbGnctqgJJyUCGE10EHNh9ioNGhUjmx+qhJsJeiNiZ3SAOW/n62Z7pQn5npz/M3Lk7
	f/T+9nOSkt1QE35Qc+ZaaRWL8SmL9gQCRQbvKN+tAhFSvNM71041z7JSGU8VyOAXS4gpPTM7EZC
	mptSReUypb74SZlI/ir12Z6QeEul0wxrPChjM6+5NyD6zZYdpKDNYmxNkjJ5FqCB0lQJ36ALpfF
	vTlRkNGc4DxG/Jl73ucJrQB6smrFt+wRjqvvk9kxmD+I/b+qk2TM7J2En4CF0lBmrKdT4AenfLU
	P3disXevMryqd0SaDtaX3wI41hd5mjMftnfXkcw2F0DqzpEm1KNQprqDQKhuZvI4IFpBhZo2Adk
	/N7tOyto1gA7BsIX2/RYrukF6x9MFtrWV1fSY9u1hRkl3loyUh6FBHZWKbCSmVmp5/CZwimcDX2
	dP1pXC0vFRub6ytTfdEK9kGTtMJFDU3cieMId2jSIkgUR7BcD5KaOZtPHWeJBn9x8Z/sQ=
X-Google-Smtp-Source: AGHT+IEJOeTNgGSs6glS/5JXjFHhVoGWQ87V9gmhirZTX566XAbdRF9c9nY+pzK/lLddmBIEA1OCuQ==
X-Received: by 2002:a05:6402:2346:b0:641:1cd6:fecd with SMTP id 4fb4d7f45d1cf-6415dc084e5mr5969245a12.8.1762771920024;
        Mon, 10 Nov 2025 02:52:00 -0800 (PST)
Received: from localhost (host-79-49-235-115.retail.telecomitalia.it. [79.49.235.115])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f814164sm11079924a12.13.2025.11.10.02.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:51:59 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mbrugger@suse.com,
	guillaume.gardet@arm.com,
	tiwai@suse.com,
	Lizhi Hou <lizhi.hou@amd.com>,
	Rob Herring <robh@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v3] PCI: of: Drop error message on missing of_root node
Date: Mon, 10 Nov 2025 11:54:15 +0100
Message-ID: <20251110105415.9584-1-andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_PCI_DYNAMIC_OF_NODES is enabled, an error message
is generated if no 'of_root' node is defined.

On DT-based systems, this cannot happen as a root DT node is
always present.
On ACPI-based systems that declare an empty root DT node (e.g.
x86 with CONFIG_OF_EARLY_FLATTREE=y), this also won't happen.
On platforms where ACPI is mutually exclusive to DT (e.g. ARM)
the error will be caught (and possibly shown) by drivers that
rely on the root node.

Drop the error message altogether.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
Changes in V3:
- Dropped the error message
- Changed the commit subject

V2: https://lore.kernel.org/all/955bc7a9b78678fad4b705c428e8b45aeb0cbf3c.1762367117.git.andrea.porta@suse.com/
---
 drivers/pci/of.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3579265f1198..71899b385f7c 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -775,7 +775,6 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
 
 	/* Check if there is a DT root node to attach the created node */
 	if (!of_root) {
-		pr_err("of_root node is NULL, cannot create PCI host bridge node\n");
 		return;
 	}
 
-- 
2.35.3


