Return-Path: <linux-pci+bounces-37641-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D47BBFB2B
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 00:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 781D14E2290
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 22:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AE11E376C;
	Mon,  6 Oct 2025 22:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5YovkzJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC801DF261
	for <linux-pci@vger.kernel.org>; Mon,  6 Oct 2025 22:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759790334; cv=none; b=WH+Spea2/CISCda6Ndsi8/s0Tq1EOEo20dFuDbuFvv73K9oHsGMJs4VPFYOFwoZSZFXkmlbYSYf82IOgqlhbUkwd6TIwa0cD5/Ke8AJjl50s2hQgX1DxOtLs7aIWyM4O+V79LH/VTKzvqw6MuWEByeytvYpMAd7opB61hmx9bE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759790334; c=relaxed/simple;
	bh=hAfYBMHPx4SL0CGF9z/5CE1gPni2z7TafaalDEB4P7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=naYf+v0mRuMdA3SMd0ABbJCmUSt4ANwH/e9RA7FXEgHAXxAOirEFYvWz7kFCv0nM6GUzu2htBW9hemTXFCTC3oj0T/i2eJNPsW2QvXwq3cFTHRFpD8hjcTm3I18p37+Q22TAkZCiN6+WaC4CQWVIUYY1tUwW2Vd3o5mBcEcZduk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5YovkzJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759790331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lt1XDt+iqYJyCmKmJhO9a3u66KtKOoS8YbEa9uYzXU4=;
	b=Z5YovkzJi2pK5yuyrfrfcHReeUBOapVgI3Vnn4eFaoLybjFFc4EV3mNNnNfFrLoeYwZsg2
	B21xlPyqbZlaiPb6umBK9hBRLDcTLXWTzdhNaHt/Ohr2GvQpsREw/7H6vshrWY2XoX85ue
	EfIDFDE9YcdbxTKmGGAyLZY5Asp8QoY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-qGWzE8P9O9uG9asD58o6jQ-1; Mon,
 06 Oct 2025 18:38:50 -0400
X-MC-Unique: qGWzE8P9O9uG9asD58o6jQ-1
X-Mimecast-MFC-AGG-ID: qGWzE8P9O9uG9asD58o6jQ_1759790328
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3373C1800576;
	Mon,  6 Oct 2025 22:38:48 +0000 (UTC)
Received: from thinkpad-p1.kanata.rendec.net (unknown [10.22.90.133])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E5AA21800452;
	Mon,  6 Oct 2025 22:38:44 +0000 (UTC)
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
Subject: [PATCH v2 0/3] Enable MSI affinity support for dwc PCI
Date: Mon,  6 Oct 2025 18:38:10 -0400
Message-ID: <20251006223813.1688637-1-rrendec@redhat.com>
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

Last but not least, since most of the code in these patches is your
code, I took the liberty to add your From and Signed-off-by tags to
properly attribute authorship. I hope that's all right, and if for any
reason you don't want that, then please accept my apologies and I will
remove them in a future version. Of course, you can always remove them
yourself if you want (assuming the patches are merged at some point),
since you are the maintainer :)

[1] https://lore.kernel.org/all/20220502102137.764606ee@thinkpad/
[2] https://lore.kernel.org/all/20230530214550.864894-1-rrendec@redhat.com/
[3] https://lore.kernel.org/linux-pci/878qpg4o4t.ffs@tglx/

Signed-off-by: Radu Rendec <rrendec@redhat.com>
---
Changes in v2:
- Fix compile errors on configurations where CONFIG_SMP is disabled

---
Radu Rendec (3):
  genirq: Add interrupt redirection infrastructure
  PCI: dwc: Code cleanup
  PCI: dwc: Enable MSI affinity support

 .../pci/controller/dwc/pcie-designware-host.c | 127 ++++++++----------
 drivers/pci/controller/dwc/pcie-designware.h  |   7 +-
 include/linux/irq.h                           |  10 ++
 include/linux/irqdesc.h                       |  11 +-
 kernel/irq/chip.c                             |  22 ++-
 kernel/irq/irqdesc.c                          |  51 ++++++-
 kernel/irq/manage.c                           |  16 ++-
 7 files changed, 164 insertions(+), 80 deletions(-)

-- 
2.51.0


