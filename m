Return-Path: <linux-pci+bounces-44394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 462C1D0BC45
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 18:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A10D230453A0
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 17:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BE3364EAE;
	Fri,  9 Jan 2026 17:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3RHzJDZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D05B20E025
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767981193; cv=none; b=BDhb07j1jZC6SdX5v+TZDIzvGN7qS7g17fL/sSlx3vlgdFu2D3KV25iO6EK0oTi/4tqznzkbl6tDiD9iwosDPVustcfO4dmzOIHJyUvz7U9pTXq7kvrpG90QivxuCihOZP2pf0sOvCc8ZHLefruC+V6G3rdyuUg96Rtv2gN+hJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767981193; c=relaxed/simple;
	bh=Z/LefxQhDxOS05TUk63yHR7hOc6LFlX4nfV9XCmo5yc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OzrQSV1J8WTE9LVuhiVDolyg3oqeFP7Vm1Vh8xcKDsxYEtNaa39WlB5atNgBPrmt57+hU7S1gfaXnrZ1WSeK2kTocnlRoMxTqARrDQMcQjwMMD7p5YbeKKwFwXF1J1ijXMCLhP5jStK0cMzAhUzqwNYfh1WSvRd60d2BqU9Jnnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M3RHzJDZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767981190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JCV5pbjrQIxVIgwZc8Ps0PqRe7zc0Fp/D+kLwoqANlU=;
	b=M3RHzJDZlK8Sp0C4yx/cPKUB17i4NoM+XY8B+pl2KCk4dpOS/2qUTl+VlWvmwp66RwTg36
	ZdM20eqJXqY9x4gCICVlvYwnhjpGwMIQ0qc7tFjfPQNpBZ7mLDVMvasKEmYj8945/loXcC
	Cg1vnGTM5FE4tud8t+JHeDhMQc7yU6Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-s3dCzBAPP1yeVZORCWB8Og-1; Fri,
 09 Jan 2026 12:53:07 -0500
X-MC-Unique: s3dCzBAPP1yeVZORCWB8Og-1
X-Mimecast-MFC-AGG-ID: s3dCzBAPP1yeVZORCWB8Og_1767981185
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62D9B1956050;
	Fri,  9 Jan 2026 17:53:05 +0000 (UTC)
Received: from thinkpad-p1.kanata.rendec.net (unknown [10.22.65.3])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5544B19560BA;
	Fri,  9 Jan 2026 17:53:02 +0000 (UTC)
From: Radu Rendec <rrendec@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Daniel Tsai <danielsftsai@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Brian Masney <bmasney@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Alessandro Carminati <acarmina@redhat.com>,
	Jared Kangas <jkangas@redhat.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH] fixup! genirq: Add interrupt redirection infrastructure
Date: Fri,  9 Jan 2026 12:52:27 -0500
Message-ID: <20260109175227.1136782-1-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The previous version of this patch has two related bugs:
- irq_chip_redirect_set_affinity() doesn't update the effective affinity
  mask, which triggers the warning in irq_validate_effective_affinity().
  This bug was reported at [1].
- As a result, the cpumask_test_cpu(smp_processor_id(), m) condition in
  demux_redirect_remote() is always false, and the interrupt is always
  redirected, even if it's already running on the target CPU.

The solution is not ideal because it may lie about the effective
affinity of the demultiplexed ("child") interrupt. If the requested
affinity mask includes multiple CPUs, the effective affinity, in
reality, is the intersection between the requested mask and the
demultiplexing ("parent") interrupt's effective affinity mask, plus
the first CPU in the requested mask.

Accurately describing the effective affinity of the demultiplexed
interrupt is not trivial because it requires keeping track of the
demultiplexing interrupt's effective affinity. That is tricky in the
context of CPU hot(un)plugging, where interrupt migration ordering is
not guaranteed. The solution in the original version of the patch,
which stored the first CPU of the demultiplexing interrupt's effective
affinity in the `target_cpu` field, has its own drawbacks and
limitations.

[1] https://lore.kernel.org/all/44509520-f29b-4b8a-8986-5eae3e022eb7@nvidia.com/

Signed-off-by: Radu Rendec <rrendec@redhat.com>
---
 kernel/irq/chip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 433f1dd2b0ca7..35bc17bc369e0 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1493,6 +1493,8 @@ int irq_chip_redirect_set_affinity(struct irq_data *data, const struct cpumask *
 	struct irq_redirect *redir = &irq_data_to_desc(data)->redirect;
 
 	WRITE_ONCE(redir->target_cpu, cpumask_first(dest));
+	irq_data_update_effective_affinity(data, dest);
+
 	return IRQ_SET_MASK_OK;
 }
 EXPORT_SYMBOL_GPL(irq_chip_redirect_set_affinity);
-- 
2.52.0


