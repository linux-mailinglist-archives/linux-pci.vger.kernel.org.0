Return-Path: <linux-pci+bounces-24080-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB48A6871D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 09:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D8C3B7408
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 08:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5417B15A85A;
	Wed, 19 Mar 2025 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Upe/rv32"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C74211484
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 08:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742373688; cv=none; b=NIrH4kv6DpFtBFNExtbzKgw64HH51RX0f+oXurqrc0ztBD+QUvTQzH81nF2LdFFJYBNhTKDtExMz19Ze27PFTkY0jXLDn54/iaS+aNH1u1AbcBQYTwQfgLsMWFakd/Wwq+G8WngYaSflH2Gy2nWLJHv3R8VVyr34Fi4NN3CL4ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742373688; c=relaxed/simple;
	bh=aPlde8woHV7SJa++l2GOra75ZVpTRhppXL0d3g+34BE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AxhOCyhziGUXhuEoCIUguqQoh0593fcYVAvyY/lCkQQJhKRkiASwiDhMRkE9zXu+FxX0n1p7LbnXFZ8B4r04zSTWxVfDGqn1KbUzDqyPN8dGrFfO8Q0xJtriF1Sg5jmgfVfeXT3xrPTiOTH2SZCpNuIZV8GYrylM//Vk7T4PtlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Upe/rv32; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff854a2541so6779077a91.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 01:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742373686; x=1742978486; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3G6AS6LhHp49BAqWSgpAT7caVkxV4HX8oBMiv1eA1Uc=;
        b=Upe/rv324Gvww+JBSXC7S/47p1jj/hNu5K0UbnKtbtOxZmoucf3LD7RyMCQNLepuMD
         ocTPA9lrJwMbgL6X7xC9AdCg4dZRyb2z1SqEdUK5xxV/bGWkV2WthqS1/6mOIXl5MrcV
         qZf9ftxqUMDQfbDJW+04AJQjlpobV/A9mm2PEmLg8IQAcrNW+tZSU0mndb0k4djRnMhx
         f4moZMfF0eX/0GzxwP7g8R0HpDdck5DxHyJPQS2/c1SX2K1yvjYJPtNQaF3fkz+kjiwn
         Py8xBJXNHrFt95dsyX+1/nTCBSi6PG+rlaEfYoJIswflHO7AMC4OEqIOxPIuvpMafAC8
         iNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742373686; x=1742978486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3G6AS6LhHp49BAqWSgpAT7caVkxV4HX8oBMiv1eA1Uc=;
        b=eNFii6SNSP1GFHprehb4jtBZF7YsH4b5M8P3dCRfU1lhkR05BRXJ0qTOHpX+xZNgwl
         UtQzgA+aEGwSwLXOIEPLkMlVh6mZ53shzQ9BQhUnr26gm4mCXgsN54YDpWkf1JORiUxw
         6byucnYUSGUfl6YCWOMnAOw4/nSSZlC9kilrX6weOB2rvfqy3ch5IL5Zu4kD/6hOv97b
         aqSGxT4Ylu+3VA4T+rWthMq1vTOqtiF3cXT+PQlhNmAO7b4C342ukPGLCTgtu5u4wiCX
         zPsqmofxGuDQmr5HHtnrDjqdZ0q9mNQeQwM+BRX8NNNr59vVKh+1Xg2S02j2Yim8alSw
         /QNg==
X-Gm-Message-State: AOJu0YxgmT/biXYsNMv/6yWYiF0ci3gg13JT91Quxx0fBPG+jyPQd910
	zpxjECo4c2ackgWXwcAwq4VtIElggUkpw2RWBleur/DxOsrP/KxWXJr2/xRd10AZIQy73EvjEyD
	+Zw==
X-Google-Smtp-Source: AGHT+IFNtICnzFQq/J6NoAFE4IJHd4+rL3ozRKFPa63yDKQ7KJsjUjSncsQZk7736fSpdcAeDmmx+Vvj4HI=
X-Received: from pjbpl11.prod.google.com ([2002:a17:90b:268b:b0:2fc:13d6:b4cb])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4fc5:b0:2f8:4a3f:dd2d
 with SMTP id 98e67ed59e1d1-301bdf9364bmr3254019a91.15.1742373686183; Wed, 19
 Mar 2025 01:41:26 -0700 (PDT)
Date: Wed, 19 Mar 2025 01:40:49 -0700
In-Reply-To: <20250319084050.366718-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319084050.366718-1-pandoh@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250319084050.366718-9-pandoh@google.com>
Subject: [PATCH v3 8/8] PCI/AER: Update AER sysfs ABI filename
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <Terry.bowman@amd.com>, 
	Jon Pan-Doh <pandoh@google.com>
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
index b45a2e18d1cf..043cdb3194be 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -97,14 +97,14 @@ AER uses the default ratelimit of DEFAULT_RATELIMIT_BURST (10 events) over
 DEFAULT_RATELIMIT_INTERVAL (5 seconds).
 
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
2.49.0.rc1.451.g8f38331e32-goog


