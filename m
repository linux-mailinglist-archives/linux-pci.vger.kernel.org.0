Return-Path: <linux-pci+bounces-44555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DED0D15658
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 22:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3FCE301E144
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 21:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C790330663;
	Mon, 12 Jan 2026 21:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RdQnzcqP"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AEE335544
	for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 21:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768252479; cv=none; b=nzWOdFJ7mkUPgSPQHrZNX/mH7dcARP4LNfQpBzX3EqfoY+4Z3BEuJNx0QceJga8xCBrPAJxfhX1N8BKp5p2Dig1PmeWt23FBEjQCHkx9Tvc0d/14Ai2o5o5bQDdjNCwE5Bu71rF+oZCoE1Yfr002gOXMdqZlO7jMIT50B6/OJ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768252479; c=relaxed/simple;
	bh=11rPxRbGdrYXlwihgKm3nwcDS2u96qlQ9O/q0lvVezg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sCdEB4s7FSCV6Q0LIYD6QdHbj1ednyFTAm4IdrzpRUahJefXZ4/HzKLUMDSRRG1uSuKU4nW6shdXAcYPGZk64fCOE0y0n/gJgz7GtvtyMZ6I7+Rtz2jXnpb4SsGWmEdiCPVqNU2NZnwuYmICZVJxUXnu7BsrVGfkA0lwHMQ6JGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RdQnzcqP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768252477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RZFjy2UOgSOGEbpf2qLU37/z9nWUH/1fw04IFlrOKjs=;
	b=RdQnzcqPhT6mJilziINjjGK3mIWqr9nZ569SCD+7wrxY4jhrGE6CnAEDBqB+F1Id2j+B0U
	5+WbeLlIzEW/OqzlgNDFr4TV0jPu7e4szggZYJfLwqTcfdFTWPIE7RVOUYdo6dDh2mjxTL
	H1+k1qo3Ni6YclqwYh6HbgxUZ4tjl60=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-aLlVSyOtN_erK3DykUP3YA-1; Mon,
 12 Jan 2026 16:14:31 -0500
X-MC-Unique: aLlVSyOtN_erK3DykUP3YA-1
X-Mimecast-MFC-AGG-ID: aLlVSyOtN_erK3DykUP3YA_1768252469
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AC311800473;
	Mon, 12 Jan 2026 21:14:29 +0000 (UTC)
Received: from thinkpad-p1.kanata.rendec.net (unknown [10.22.88.141])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7AA49180049F;
	Mon, 12 Jan 2026 21:14:26 +0000 (UTC)
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
Subject: [PATCH] genirq: Update effective affinity for redirected interrupts
Date: Mon, 12 Jan 2026 16:14:02 -0500
Message-ID: <20260112211402.2927336-1-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

For redirected interrupts, irq_chip_redirect_set_affinity() does not
update the effective affinity mask, which then triggers the warning in
irq_validate_effective_affinity(). Also, because the effective affinity
mask is empty, the cpumask_test_cpu(smp_processor_id(), m) condition in
demux_redirect_remote() is always false, and the interrupt is always
redirected, even if it's already running on the target CPU.

Set the effective affinity mask to be the same as the requested affinity
mask. It's worth noting that irq_do_set_affinity() filters out offline
CPUs before calling chip->irq_set_affinity() (unless `force` is set), so
the mask passed to irq_chip_redirect_set_affinity() is already filtered.

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
not guaranteed. The solution in the initial version of the fixed patch,
which stored the first CPU of the demultiplexing interrupt's effective
affinity in the `target_cpu` field, has its own drawbacks and
limitations.

Fixes: fcc1d0dabdb6 ("genirq: Add interrupt redirection infrastructure")
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Closes: https://lore.kernel.org/all/44509520-f29b-4b8a-8986-5eae3e022eb7@nvidia.com/
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


