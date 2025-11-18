Return-Path: <linux-pci+bounces-41543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2305DC6BD51
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 23:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DFBF4E297E
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 22:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC5F30F7EE;
	Tue, 18 Nov 2025 22:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPphCY+R"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CD52F7AA3
	for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 22:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763504011; cv=none; b=E7G3l+DfjNzScvo9+Bzl69uG07l9DY5vg9i1/X23/qRvJHsay7WirYkZf1NlAsOS+brdNjCANdHJw+Yqicr8znc7K18fzxO6lqB+b7drghhcW/kRCgQyt5zJoff6zFdVGOrqAYu/A8GNWLDpKZrt3iTrlwlMgrlpviKqqT9ZANY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763504011; c=relaxed/simple;
	bh=LAhEXpPf+IaJU/vWShOCq5DJc9vunzpwtInvskyR3G8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YhTY+Mb39mMWY/wJn+kjson2WOxbcXUO9AWwz5RnGRcks4E+lhWlnjXymBXuhKgKSZ5Jc9PEBE/40ou/0ZfXuNkA1mytsuM3x1XLfoqVIOayV8yR/gKdAZZhX+oLdyTxGODrD00OiE/uX40rz4tchepQIpulskNWIocv8/cegBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SPphCY+R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763504008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ko9X3F2pJefo8kFJzOpo7ZCLmuSA3XuPcJxCSpJR+O8=;
	b=SPphCY+RXQY64XRZpC2IjKCZI4fwVxlJ5eEfUFCNjVRpGIpmhXr5MGwEjgGrQSaUUEcz+0
	Ehn5WcB+BBpnKLtDosOcCU5vuTbI6txkdne8y8x+P0HaIgcJO+DGjkTPouqInzhB4Oodwj
	rAG7k+2L0Sbyc/wRBgn9d9Z4ywoyPGI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-lLEnVWWeNQCqTetmi_WxcQ-1; Tue,
 18 Nov 2025 17:13:22 -0500
X-MC-Unique: lLEnVWWeNQCqTetmi_WxcQ-1
X-Mimecast-MFC-AGG-ID: lLEnVWWeNQCqTetmi_WxcQ_1763504000
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C49FE19560B0;
	Tue, 18 Nov 2025 22:13:19 +0000 (UTC)
Received: from thinkpad-p1.kanata.rendec.net (unknown [10.22.88.100])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5ABD6180047F;
	Tue, 18 Nov 2025 22:13:17 +0000 (UTC)
From: Radu Rendec <rrendec@redhat.com>
To: Marc Zyngier <maz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] PCI: host-common: Allow drivers to use the device's drvdata pointer
Date: Tue, 18 Nov 2025 17:12:42 -0500
Message-ID: <20251118221244.372423-1-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Currently there's only one user of pci_host_common_init(), the
pcie-apple driver, and it goes to great lengths to store its own
per-device private pointer, because the device's drvdata is used by
pci_host_common_init() to store a pointer to struct pci_host_bridge.
See commit 643c0c9d0496 ("PCI: apple: Add tracking of probed root
ports").

However, it looks like this is necessary only for simple drivers that
use pci_host_common_{probe,remove}() directly as their platform
probe/remove functions. More complex drivers that allocate their own
private structure, like pcie-apple, can store a pointer to that instead;
the pointer to struct pci_host_bridge can be encapsulated in the private
structure if it's needed.

The first patch changes the pci-host-common library to free up drvdata
for drivers that do not use pci_host_common_{probe,remove}() directly.

The second patch uses the changes in the first patch to simplify the
pointer storage logic. This patch is *untested* because I don't have
access to the hardware.

Radu Rendec (2):
  PCI: host-common: Do not set drvdata in pci_host_common_init()
  PCI: apple: Store private pointer in platform device's drvdata

 drivers/pci/controller/pci-host-common.c | 36 +++++++++++-----
 drivers/pci/controller/pci-host-common.h |  6 ++-
 drivers/pci/controller/pcie-apple.c      | 53 ++++--------------------
 3 files changed, 36 insertions(+), 59 deletions(-)

-- 
2.51.1


