Return-Path: <linux-pci+bounces-42275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A625C932F9
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 22:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9BF4F34DBFD
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 21:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3D72DCC06;
	Fri, 28 Nov 2025 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LpzKwIts"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3888229E0E6
	for <linux-pci@vger.kernel.org>; Fri, 28 Nov 2025 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764364892; cv=none; b=pxmmnskYPwxaUJyEacrO/3sWmsi+Tp6Yw1SwMiDkA0x7A42u9zPLImvDb/Nv4u+dcGJGuwvFqhIvLqhpBG4ReS9z+6nucPpwQfxBg3XxxhmucnPtmZliLsACy77hASxao6ZIwuBBLjewiKRD9a9LOvS8y0kuJQ9VqyHjn9tw7vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764364892; c=relaxed/simple;
	bh=3RO8uAHy8jG6mdWt4mN/ukH0v6kqX61Qo+E4LCA/LpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=otrHsKXUVgy2XUcLfMZhZz/mUXnC4HCghzsXbOZZ2MEGW5Jq3W5meFNNn3le1w7AhiaKpKAsHS3CYC/RCDsHkOdzvEj/OBgrAksVk5nuL/Vjj2Hq+xVV6ioZMUKSdkRsOqLhYU2spcqLrzV2jFXv7fsMN4HSsYeUxOOJ2Q7/Rr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LpzKwIts; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764364889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EUWOn+5hNIOYtuarOfX1JRAwDD6qqT45ISBo06339iU=;
	b=LpzKwItszRENhNXuKCwiFYcna14zMSH/AMPZxSFy3r3LY/qahT4Y7fBjvFDWc3IhzUitf0
	zAS6oR4t2Cw6glLP/RP70vvw7hv7GOBSyJyrcF0vBCzvJeBiPptSZjZG13sEPEALHdCjr9
	TVFc9Yk3wSmjoB5vm2BpspdmBdBqcug=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-CFFuniVVP8etPAb4SP7viw-1; Fri,
 28 Nov 2025 16:21:25 -0500
X-MC-Unique: CFFuniVVP8etPAb4SP7viw-1
X-Mimecast-MFC-AGG-ID: CFFuniVVP8etPAb4SP7viw_1764364881
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1604619560B2;
	Fri, 28 Nov 2025 21:21:21 +0000 (UTC)
Received: from thinkpad-p1.kanata.rendec.net (unknown [10.22.88.129])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 67EFD18004A3;
	Fri, 28 Nov 2025 21:21:17 +0000 (UTC)
From: Radu Rendec <rrendec@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Daniel Tsai <danielsftsai@google.com>,
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
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Enable MSI affinity support for dwc PCI
Date: Fri, 28 Nov 2025 16:20:52 -0500
Message-ID: <20251128212055.1409093-1-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Various attempts have been made so far to support CPU affinity control
for (de)multiplexed interrupts. Some examples are [1] and [2]. That work
was centered around the idea to control the parent interrupt's CPU
affinity, since the child interrupt handler runs in the context of the
parent interrupt handler, on whatever CPU it was triggered.

This is a new attempt based on a different approach. Instead of touching
the parent interrupt's CPU affinity, the child interrupt is allowed to
freely change its affinity setting, independently of the parent. If the
interrupt handler happens to be triggered on an "incompatible" CPU (a
CPU that's not part of the child interrupt's affinity mask), the handler
is redirected and runs in IRQ work context on a "compatible" CPU. This
is a direct follow up to the (unsubmitted) patches that Thomas Gleixner
proposed in [3].

The first patch adds support for interrupt redirection to the IRQ core,
without making any functional change to irqchip drivers. The other two
patches modify the dwc PCI core driver to enable interrupt redirection
using the new infrastructure added in the first patch.

Thomas, however, I made a small design change to your original patches.
Instead of keeping track of the parent interrupt's affinity setting (or
rather the first CPU in its affinity mask) and attempting to pick the
same CPU for the child (as the target CPU) if possible, I just check if
the child handler fires on a CPU that's part of its affinity mask (which
is already stored anyway). As an optimization for the case when the
current CPU is *not* part of the mask and the handler needs to be
redirected, I pre-calculate and store the first CPU in the mask, at the
time when the child affinity is set. In my opinion, this is simpler and
cleaner, at the expense of a cpumask_test_cpu() call on the fast path,
because:
- It no longer needs to keep track of the parent interrupt's affinity
  setting.
- If the parent interrupt can run on more than one CPU, the child can
  also run on any of those CPUs without being redirected (in case the
  child's affinity mask is the same as the parent's or a superset).

[1] https://lore.kernel.org/all/20220502102137.764606ee@thinkpad/
[2] https://lore.kernel.org/all/20230530214550.864894-1-rrendec@redhat.com/
[3] https://lore.kernel.org/linux-pci/878qpg4o4t.ffs@tglx/

Signed-off-by: Radu Rendec <rrendec@redhat.com>
---
Changes in v3:
- Use an Originally-by tag (instead of Signed-off-by) to attribute
  initial authorship to Thomas Gleixner <tglx@linutronix.de>.
- All changes below are related to patch 1. Patches 2 and 3 are
  unchanged, since they received no review comments in v2.
- Rename `fallback_cpu` to `target_cpu` to make it less confusing.
- Make a stub for demux_redirect_remote() for the !CONFIG_SMP case.
- Move all redirection code from generic_handle_demux_domain_irq() to
  demux_redirect_remote(), including locking desc->lock.
- Add a short comment to explain cpumask_test_cpu(smp_processor_id(), m).
- Add a comment to explain why calling irq_work_queue_on() inside
  demux_redirect_remote() is safe w.r.t. CPU unplugging.
- Move the synchronize_irqwork() call from __synchronize_hardirq() to
  __synchronize_irq(), since it can sleep.
- Link to v2: https://lore.kernel.org/all/20251006223813.1688637-1-rrendec@redhat.com/

Changes in v2:
- Fix compile errors on configurations where CONFIG_SMP is disabled
- Link to v1: https://lore.kernel.org/all/20251003160421.951448-1-rrendec@redhat.com/

---
Radu Rendec (3):
  genirq: Add interrupt redirection infrastructure
  PCI: dwc: Code cleanup
  PCI: dwc: Enable MSI affinity support

 .../pci/controller/dwc/pcie-designware-host.c | 127 ++++++++----------
 drivers/pci/controller/dwc/pcie-designware.h  |   7 +-
 include/linux/irq.h                           |  10 ++
 include/linux/irqdesc.h                       |  17 ++-
 kernel/irq/chip.c                             |  22 ++-
 kernel/irq/irqdesc.c                          |  86 +++++++++++-
 kernel/irq/manage.c                           |  15 ++-
 7 files changed, 204 insertions(+), 80 deletions(-)

-- 
2.51.1


