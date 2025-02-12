Return-Path: <linux-pci+bounces-21300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C716DA32EF4
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 19:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A607B167DA2
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 18:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5510A260A42;
	Wed, 12 Feb 2025 18:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pz2jRufu"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDDC25EFAA
	for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2025 18:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739386443; cv=none; b=p7izxK9D3PUEvT4y6PKVJsxGHz0WcfXu9ApdyPuZmORxLC4DHm4BKuhsAUNxoPflhzlo9XuBAcQ+cvyk1AD7iB5U9rIlHjIbqaiji58eeBK0D28fXcieowReRmHBi4l/iObQ3zTmM6xBlTRDw0rFvsr/sCNKWrxxBTFbpHqUo1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739386443; c=relaxed/simple;
	bh=88U6LkkyjwbgU3fwElzt9RyVjJumxgt5JSaA4PqEjSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JT9IZvHTNcBh7OORGvDASf/QgAPqRli9lhhmxlQQ3MJRv7HG9XwaTFukOjNgKV97vSZQ3XJlzksmXke5qtzLZG/dFF+ruIjEYIAfeaVkbK2JppRwRaKa92KhJugDtM/63OZjfaMVKF5gDGjKbH9o82ZxZLpYOt7q904lFgnV7u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pz2jRufu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739386440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8Pk1/OrFBXHG51Uy+54VqQQAZpp/Rcxfrj0+oCV3QUE=;
	b=Pz2jRufuIyEjOBqdZ3yzPG3sT5bPjFb/XS2eIcMBHZChs0f50dQ5J8it88N4SUzHyFmmgM
	ZPlHKXE73lF4Zhg62xfQ3VGQenPUX3jOrYQw7jpncLA9X5fgQoI0NEP+I9os/tfvC85bO8
	oAHzooF7GfnjZ7GhFLHQx21hg2AGC1k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657--a0L9dtiOOiU_a_5OBq_GA-1; Wed,
 12 Feb 2025 13:53:58 -0500
X-MC-Unique: -a0L9dtiOOiU_a_5OBq_GA-1
X-Mimecast-MFC-AGG-ID: -a0L9dtiOOiU_a_5OBq_GA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A488719560A7;
	Wed, 12 Feb 2025 18:53:56 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.88.77])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3C6B21800876;
	Wed, 12 Feb 2025 18:53:54 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: bhelgaas@google.com
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mitchell.augustin@canonical.com,
	ilpo.jarvinen@linux.intel.com,
	david.laight.linux@gmail.com,
	Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v2] PCI: Fix BUILD_BUG_ON usage for old gcc
Date: Wed, 12 Feb 2025 11:53:32 -0700
Message-ID: <20250212185337.293023-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

As reported in the below link, it seems older versions of gcc cannot
determine that the howmany variable is known for all callers.  Include
a test so that newer compilers can enforce this sanity check and older
compilers can still work.  Add __always_inline attribute to give the
compiler an even better chance to know the inputs.

Fixes: 4453f360862e ("PCI: Batch BAR sizing operations")
Link: https://lore.kernel.org/all/20250209154512.GA18688@redhat.com
Reported-by: Oleg Nesterov <oleg@redhat.com>
Tested-by: Oleg Nesterov <oleg@redhat.com>
Tested-by: Mitchell Augustin <mitchell.augustin@canonical.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

v2:
 - Switch to statically_true (David Laight)
 - Add __always_inline (David Laight)
 - Included Tested-by reports

 drivers/pci/probe.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b6536ed599c3..246744d8d268 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -339,13 +339,14 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 	return (res->flags & IORESOURCE_MEM_64) ? 1 : 0;
 }
 
-static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
+static __always_inline void pci_read_bases(struct pci_dev *dev,
+					   unsigned int howmany, int rom)
 {
 	u32 rombar, stdbars[PCI_STD_NUM_BARS];
 	unsigned int pos, reg;
 	u16 orig_cmd;
 
-	BUILD_BUG_ON(howmany > PCI_STD_NUM_BARS);
+	BUILD_BUG_ON(statically_true(howmany > PCI_STD_NUM_BARS));
 
 	if (dev->non_compliant_bars)
 		return;
-- 
2.48.1


