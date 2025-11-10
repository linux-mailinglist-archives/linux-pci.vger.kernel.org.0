Return-Path: <linux-pci+bounces-40694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E26C46321
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 12:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 891184EA65E
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 11:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5969D309EF6;
	Mon, 10 Nov 2025 11:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OXq52Cb7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CF3306B00
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773537; cv=none; b=shfB4Odvl8ifFc7tD/EeFGbPmN4XhLId2zgv3tI7zRSRRvx36S/W9CchRbZ2Ho/ou6HsI9rG4c0URso5yKJHr/hd6kU02J92LiSx43kmf6e44k/5OYPNELwTsKK5Uo7FxmzxKvHlUCEBSdDhsv1GvuCMFTWkwUEfRU4efyXL66M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773537; c=relaxed/simple;
	bh=CtcnWX3Saefaqoy8rC2bEN8d8RUkMd9EngZJbMCIyr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fiE+tbGwNZWOONGcLqCDVX4GtwbzEZGIEeQJ5vxWG9JYxGwWFw88OKt7JPaz4OzQjQInIn5JtJnAJiTwepETTCCDy0XH01SXmjYKBuZRZacO/tbfstxPVdhcmUv4YP4yg2rmFfqmCP6imDPfl9o2aWkH255LRgKm9mJLwpUe0Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OXq52Cb7; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64175dfc338so2209019a12.0
        for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 03:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762773532; x=1763378332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fWujc1t71h98OiupS/0FkoKIpGifqdnl63DSESHd7Mo=;
        b=OXq52Cb7SWnSIzwdEYTgNtqfRqxu97eff2EFTTPGm8+hM2bN8cy3tn+3nUa4Box/Bq
         nJLUQcXknP7RQN1rBoDAlnHGIe8N4PJVpecddcivug/2wLxBK0gPdEfkXr9a7/RfHmvR
         2+dSTbmPEIgpAaM34ZWnAdNmvhWV7XDVV0IHQ3fsJX/Nagel7DU8qoPoL4jCgP6/esCw
         eQc1rHCbW5ahjIyAP1eEMLMbGNyMCzA9n8ED+yEmbtRGNWH8Z4uyMvpOMt/GYNBScSCU
         Ds0RYcu0BlqzvYVBph3amLc/uUdWT6QoAFWWamlplwgzh+RfOX122UmDX8HpMfDHH3YU
         4STQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762773532; x=1763378332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWujc1t71h98OiupS/0FkoKIpGifqdnl63DSESHd7Mo=;
        b=FqyTCX54PdMrODDdU0mc2xQGNjVNUKFx5wXz4iWXsF5t50G8j6KiKUNY/KlNo3YDj2
         52/Qu5NhZMq38dBlg94hqCH2TQYAbBgDUB8x3s/hTtZZVl5nt6PPgPTBHUknEEo/N+Ov
         hSBEgb4dWq0RM9PR3cnI5sOw374H3K1l1tfrDp0M9ds7kQlAcjiYXa+ve1/bxfEiVFqJ
         JSEIKu76BOKXupa3sDhEFhMA10Zithe/AVkKbp60OIlqlkX2vsA8ThSHnEkicAc/98fw
         GVWfI2ygsZQT0MJS5nmOm9hq9FKHqf2oRVwd+tIgDYFto1Xdh0x7M9ULCtbhpuBTGyIM
         2sow==
X-Forwarded-Encrypted: i=1; AJvYcCUzX14eLigQh9a9u4SZ6UpSHHgkqK5arr1ZC/T1YADbgW8XIONPtTQYWLYhmqu8aTuwcqBgqJPYJTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt3QvHcm25W79tz7/SvXA66SdR+BTbReQP0Z6Svf8IdVv05XFX
	0jBryviTiIH3A/krxp9ZaSCJviwwzgEx9fYyoQOM9GXKN4/j5kC9oeSnyjcVKPSRwI0=
X-Gm-Gg: ASbGncvUNTaZzDACw8IUj0rOvEKeXl7tLBNAvv/dO9PChzATio+jvu1G4EzSwyEb+z0
	/GyyDai91w8C126tt6+WrrpvhxLCdBeLX5BSSlzQ4RAf0Dd/V9T9EvPpS//RPaeNgOy2AHfJdKI
	yWAH+BAg+Mp0MgYAQIeAJ85OQdBvwb3pF1YvIB+AVteYKF+msy4ATgBEqQx89XqsLhJP2f02mmY
	U0ankWuC/OtoHsBuM3/vYE1K4tRQKPMoMKPEIcKxfW5TjMPVrstSy2Xl3EE66k4LPU2sDIx00Dn
	CMfTyMCA+Swrqpdyjx3fWVVKxkocdg2NDQVvYONmQBZp/2QHy9+mopHUnT5eC2kOt87OruPxeRF
	oQkRqB5bBSUcTpHBBnOlIAOwH8AgOKSsOAylPATKX7VUnjuc/R50c+5pI210aDjWMHXrbHPjeib
	WqZyqG197ShcW78JWYdvMduyP+0ZOWAbQ7krbkFAJwuDPrlg==
X-Google-Smtp-Source: AGHT+IGKZ4MeSZHa1um6peBrNmfVOTXndNtZud9k37T7qMj8M9oQCOFbXIJKx4r88XPM9ZK0mYZCng==
X-Received: by 2002:a05:6402:440a:b0:640:bb31:cbf4 with SMTP id 4fb4d7f45d1cf-6415dc0dcc6mr6197325a12.11.1762773532050;
        Mon, 10 Nov 2025 03:18:52 -0800 (PST)
Received: from localhost (host-79-49-235-115.retail.telecomitalia.it. [79.49.235.115])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f86ea13sm11070391a12.37.2025.11.10.03.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 03:18:51 -0800 (PST)
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
Subject: [PATCH v4] PCI: of: Drop error message on missing of_root node
Date: Mon, 10 Nov 2025 12:21:10 +0100
Message-ID: <20251110112110.10620-1-andrea.porta@suse.com>
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
CHANGES in V4:
- dropped {} from the single line conditional body

V3: https://lore.kernel.org/all/20251110105415.9584-1-andrea.porta@suse.com/
---
 drivers/pci/of.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3579265f1198..c222944eec40 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -774,10 +774,8 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
 	}
 
 	/* Check if there is a DT root node to attach the created node */
-	if (!of_root) {
-		pr_err("of_root node is NULL, cannot create PCI host bridge node\n");
+	if (!of_root)
 		return;
-	}
 
 	name = kasprintf(GFP_KERNEL, "pci@%x,%x", pci_domain_nr(bridge->bus),
 			 bridge->bus->number);
-- 
2.35.3


