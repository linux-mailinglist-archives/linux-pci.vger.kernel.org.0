Return-Path: <linux-pci+bounces-21418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 715CAA354CB
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 03:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6E23AC233
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 02:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CB5137930;
	Fri, 14 Feb 2025 02:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0xfzyJWF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB88136326
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 02:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739500587; cv=none; b=npYhPq8BiijUeTl+8aoz1agWvywh+r1bIoKnXvPWF/vGguxPoVVgMHDw0AxLjFDTM0fFVHg1fWq/IeLBIRdhj+LXTnyVAy5jL1NjEPweaSAnYQ4ur2tmP1LBtVADIc5EaPqz/1weoR8lzDwi78QI/u+2oPkjUnPNwX5BaUqa8mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739500587; c=relaxed/simple;
	bh=Yuq5l1NiN6fjvrrWbUu7o5sj3p+udm3WIOCWFe+Pze4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aJ5Tm2BPWatz5T1Rmj+TT3s/E0zDOcjeooq7X2QiYIokPBM/V2QSK74WI+7U1ABsk0UUhUt3LU6J0RxsmCcgqjsXrdlrApCA228ABaOt4SctW5V+zz+wHl+f0jt1V4+fygCqcaODEuW+vgQnCMFdBaz0TKLZnGNk4muasdhayX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0xfzyJWF; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f816a85facso3345232a91.3
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 18:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739500586; x=1740105386; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CNzbR5kAPwkRGF4I5JQHtNxEieO0XebzGWjA9DqqAA4=;
        b=0xfzyJWFh+Q0FdzpFwGUcw0oilVdzRejGtSEHjyBcfJvptI/HBrKDRqZdYBx2mUVWz
         +GboayY/Pm/eTSc8aJid0iZRRo6ZEMFQCWZG8kQZojSJ/QLPBOAaoHRj449kvX31Fc29
         8L6pqW2gR/o4Iid3q1RzbaS7E93R5jA3NxEpOmUnOhBhfe1n8XagbOXeox8tjmDKlVUq
         VvYQpvnl+JBrykZ4/14iKt3vVD/mBpwtHV2p3sH63RfbF2ZDfUkpbuRKuMjTSTjSAatQ
         dgzyhmebMp/4IWvjFVpe0h9M/j8bjiKJ3N1wcV2RsHVtqpq6iAB+R+NL3xB0WsyXY5im
         uEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739500586; x=1740105386;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNzbR5kAPwkRGF4I5JQHtNxEieO0XebzGWjA9DqqAA4=;
        b=sK51nQkt6prBP61n4SreJgO2+uj0zc8EDNl6BIk6Qa12gOgGlfLbAA3OUpGQbCUPmm
         NzMZTmTS0oZ+8/aeFk48H+jN8HPyy0xmdCmkyeSSBX27H24N6Esr1NvIKiclElwJNyzR
         nmzTO2s/h29y0MAK8FSbxHLg2vxel2FhHWCPbfExlhYHsUgsh/4b7hUQCbIrfmZuyf+8
         +w10I0MhPau2APzIP9Gn/2FjZt87ZIWHi2YW+OLwepXTWSCZvIYY+O1kkpdACaM07CyC
         wIzQ2RR2Vaz0D0jcRgCzlrNUs8wYSGMvXIi1lsaJyRu3n3IzYzM3Xn8l6NyJlRoTBwvy
         RQTg==
X-Gm-Message-State: AOJu0YxEuXPw2QgbVc3mQHOvxnUQiFcGfot2lyzjZWHNhJ6EgaPD2+/j
	8YKB/UZL43aoYZs0pMuWFnr4xNdXklgZuENbybbVsjJCFRPnUyHznGmzGTUc48dRCcSH1ZmUeDh
	1mw==
X-Google-Smtp-Source: AGHT+IG1g6c+44C3V48azkYXd4gzAXt2GdLC0WxcnLaJo6TRqwDB5OQDRqYp8mHnHyVAN7wVlqw1o7Qgxuw=
X-Received: from pfbay3.prod.google.com ([2002:a05:6a00:3003:b0:730:8d2f:6eb1])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:804:b0:730:75b1:721b
 with SMTP id d2e1a72fcca58-7322c3f6d6emr15182215b3a.18.1739500585880; Thu, 13
 Feb 2025 18:36:25 -0800 (PST)
Date: Thu, 13 Feb 2025 18:35:43 -0800
In-Reply-To: <20250214023543.992372-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250214023543.992372-1-pandoh@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250214023543.992372-9-pandoh@google.com>
Subject: [PATCH v2 8/8] PCI/AER: Update AER sysfs ABI filename
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"

Change Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats to
Documentation/ABI/testing/sysfs-bus-pci-devices-aer to reflect the broader
scope of AER sysfs attributes (e.g. stats and ratelimits).

Signed-off-by: Jon Pan-Doh <pandoh@google.com>
---
 ...fs-bus-pci-devices-aer_stats => sysfs-bus-pci-devices-aer} | 0
 Documentation/PCI/pcieaer-howto.rst                           | 4 ++--
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/ABI/testing/{sysfs-bus-pci-devices-aer_stats => sysfs-bus-pci-devices-aer} (100%)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
similarity index 100%
rename from Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
rename to Documentation/ABI/testing/sysfs-bus-pci-devices-aer
diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index ab5b0f232204..912d70b9e178 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -94,14 +94,14 @@ default ratelimit to DEFAULT_RATELIMIT_BURST over
 DEFAULT_RATELIMIT_INTERVAL (10 per 5 seconds).
 
 Ratelimits are exposed in the form of sysfs attributes and configurable.
-See Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats.
+See Documentation/ABI/testing/sysfs-bus-pci-devices-aer.
 
 AER Statistics / Counters
 -------------------------
 
 When PCIe AER errors are captured, the counters / statistics are also exposed
 in the form of sysfs attributes which are documented at
-Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
+Documentation/ABI/testing/sysfs-bus-pci-devices-aer.
 
 Developer Guide
 ===============
-- 
2.48.1.601.g30ceb7b040-goog


