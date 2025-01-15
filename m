Return-Path: <linux-pci+bounces-19842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CBDA11B30
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 08:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F40E13A8280
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 07:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DF118952C;
	Wed, 15 Jan 2025 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mAMf6IJ+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE8B22F84A
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736927014; cv=none; b=egPyfJFiV5FEU8VPSsNK3Z2nJBNuKesCE1yjWp5+vYKiEh1ZCIOB1XV1xaEvkBP4zj3qUgyGM2EiIPTP/MhHvQ/p8LYRIL41/COYgLcplp1rHWYJV9D+OUcju2FcZCuj1MmoTvZA8Gy+zwgrkttLPGdXE0A/cnQNxCv63N7BVGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736927014; c=relaxed/simple;
	bh=aLs1kVabz8SXWHoDYirdPtPlYiUBWZR4XLsoSu4ojQY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KZuHgiKMXAEKssZeqcpV1SiVHMCI7ELE080jm0uUXAZ3sacRT7LTqcvqNq0BO9apZ12W9F2GicYrqLG8AD9Mg25BLuqum90fu/BMQAKMvgxzgIYeQld2nQs8EGrNZCetkJjWjH0vk9cXftjz8ObGaEKaq2cqHWCBJ61oMeVm8zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mAMf6IJ+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef9204f898so10922871a91.2
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2025 23:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736927012; x=1737531812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2gAaVaoZaLejhKa/KYtuGMLg0tIhxnvk0TL9V6UpHa8=;
        b=mAMf6IJ+SnuIGUZzXMemS4vNyOXB2pZsCjhEKaXMcKQnyHw670lOStyzV1omEhD43F
         KnsVQQas/gBTxTC7ugS1eDtZxsKT60D/oaiilrSFVvOXfgd1CIoJZ5Pw7+eOBlV+0twj
         ud2MXr6tQBwud+N+wgpvl3KaRNRAo5CCcWGeBFMhJqz9Dh/P06M8261sXQtzM4nVvV9F
         aJfmbHZRNOnhTlvQ94HMlIFVCs91/HSsJZvVed9kXwez8Y5NT7h8xvNt2AYCbKPW3Fyf
         dqkBLP9SF3NHxLkCmqTN5LZyjQLIIJHxtYzeIR2YIqoqPLM4p87ZPWpudVbLqHiu8sr2
         U/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736927012; x=1737531812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2gAaVaoZaLejhKa/KYtuGMLg0tIhxnvk0TL9V6UpHa8=;
        b=kEtwZIM78kPicfIEQxvcYaAxafreN5rRcBu09CXRDe7yeHbdOJnBAjGhWOaKlu6zyK
         QCcG0TLLaT9yx78Zw2ZhbodOBUoBe7G0iUQv2X2IaYfKE5PbVR6iMfJwziqt/dX6fvQc
         K/CjM6rzqOurMpmqkj/68Q+HzqxTdhtGXodYYpjz544B9cH13AUhKxWJMy/iVNnzKWWn
         bI3M8lKniWrv7PAdCxjiya2yCdWMM49c13AjFUAiM85xbLDuV0SHsTKRweV5UsgHpqRR
         VEFkNvMoSiWe6uR2uVIZqQdps5ivxVtTzdcp+QlKGIratQuz/klNvQLf21LciwRYKm5Y
         nGxA==
X-Gm-Message-State: AOJu0YzLVt2rc+mg7RKJXV9jtm/xmUF4+2jvVT6ejrhjRj7ILC6YhUUO
	lLScw3Vqs/Rhu0+oYaiE2623pZOMDQJ6rzkAcvBddygUlotuefKvqS5M8QkjeC+i2PfwmAwty19
	8Vw==
X-Google-Smtp-Source: AGHT+IGkmv6i+kASnX9W44jzEIpkZXcgCM6WcYxW+/+/4GmwxrQ4iA8Z3/wjLONgW5H1ZUmQA0H7qlMaYys=
X-Received: from pjbtb7.prod.google.com ([2002:a17:90b:53c7:b0:2ea:5fc2:b503])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:53c5:b0:2ea:a9ac:eee1
 with SMTP id 98e67ed59e1d1-2f548f33ba3mr42227271a91.10.1736927012585; Tue, 14
 Jan 2025 23:43:32 -0800 (PST)
Date: Tue, 14 Jan 2025 23:42:59 -0800
In-Reply-To: <20250115074301.3514927-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250115074301.3514927-1-pandoh@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250115074301.3514927-8-pandoh@google.com>
Subject: [PATCH 7/8] PCI/AER: Update AER sysfs ABI filename
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
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
index 4d5b0638f120..4c9d31ae7d88 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -91,14 +91,14 @@ AER Ratelimits
 Errors, both at log and IRQ level, are ratelimited per device and error type.
 This prevents spammy devices from stalling execution. Ratelimits are exposed
 in the form of sysfs attributes and configurable. See
-Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
+Documentation/ABI/testing/sysfs-bus-pci-devices-aer
 
 AER Statistics / Counters
 -------------------------
 
 When PCIe AER errors are captured, the counters / statistics are also exposed
 in the form of sysfs attributes which are documented at
-Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
+Documentation/ABI/testing/sysfs-bus-pci-devices-aer
 
 Developer Guide
 ===============
-- 
2.48.0.rc2.279.g1de40edade-goog


