Return-Path: <linux-pci+bounces-21122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B2CA2FB57
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 22:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBD60188556D
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 21:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B0824CECB;
	Mon, 10 Feb 2025 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2TTVpKm"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EAD24CEC6
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 21:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739221282; cv=none; b=jj52Ga1YYC70AG6fnFxiVwRmYwRu/W83vchRqh3P515IdQif7KeYUOH3ESKwzAPUhnH0BJn5YT5dRhTKBMDVQWyU1FL937ovJB2xe1JZpldYm5bxuPwrrfFH8sDGwUDw4qvR5npxb+Yqmf3517zj+ovzbV8fl1kTAP/bllG1XJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739221282; c=relaxed/simple;
	bh=36o87z6xWTQyfY9/SjKt1Sh6IXrD8DRaSo37Y6Czn4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KC6K2A5aj6/pjDKv23bNSuKAxlS+ABfG86wJL6MIv41bYNyKwrv0Bz3ORC+JOk07kZTgN9iypMe3pHBwQBB4IMjkbX3Bl2xlBLzJCQZ7B8MfUlMbRzTMu7hCt+QX5BQkSeMbiIhHROCL/PVD8hgxsGmkGZFIvk1y6ci/jIkbxUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B2TTVpKm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739221279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1U6TznFSKmzqG45lZG7d6iMZHmQhSo9El2Dr9GTdKpw=;
	b=B2TTVpKm/GLOBeOXLnYdUFc9WSrtX6iDjV5YE198FA5xT2atWcCGAhIQ6GnixpsJwC10Wh
	VGXxyO7wmwKwV3+wyIXxemwW8AyoOSS4Lahd282WnRQbqlktWy8o3zekNXfVsBPObA4fL3
	BHfysxQoogOlgXacKCtKv64p+8cDbuw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-dUhMBbJEO36V1yiJdgpbqw-1; Mon,
 10 Feb 2025 16:01:16 -0500
X-MC-Unique: dUhMBbJEO36V1yiJdgpbqw-1
X-Mimecast-MFC-AGG-ID: dUhMBbJEO36V1yiJdgpbqw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 067291956088;
	Mon, 10 Feb 2025 21:01:15 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.64.183])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 25FB11956048;
	Mon, 10 Feb 2025 21:01:12 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: bhelgaas@google.com
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mitchell.augustin@canonical.com,
	ilpo.jarvinen@linux.intel.com,
	Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH] PCI: Fix BUILD_BUG_ON usage for old gcc
Date: Mon, 10 Feb 2025 14:01:04 -0700
Message-ID: <20250210210109.3673582-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

As reported in the below link, it seems older versions of gcc cannot
determine that the howmany variable is known for all callers.  Include
a test so that newer compilers can still enforce this sanity check and
older compilers can still work.

Fixes: 4453f360862e ("PCI: Batch BAR sizing operations")
Link: https://lore.kernel.org/all/20250209154512.GA18688@redhat.com
Reported-by: Oleg Nesterov <oleg@redhat.com>
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

Verified against gcc 14.2.1 to still trigger a build error if called
with a constant value greater than 6, Oleg to confirm build issue is
resolved for gcc 5.3.1.

 drivers/pci/probe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b6536ed599c3..1bde89d0dc0d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -345,7 +345,8 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 	unsigned int pos, reg;
 	u16 orig_cmd;
 
-	BUILD_BUG_ON(howmany > PCI_STD_NUM_BARS);
+	BUILD_BUG_ON(__builtin_constant_p(howmany) &&
+		     howmany > PCI_STD_NUM_BARS);
 
 	if (dev->non_compliant_bars)
 		return;
-- 
2.47.1


