Return-Path: <linux-pci+bounces-17552-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00899E0D45
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 21:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF181B8168A
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 19:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D83A1DE4E6;
	Mon,  2 Dec 2024 19:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ORIs5AhQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6646A1DE3D4;
	Mon,  2 Dec 2024 19:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166181; cv=none; b=OYCb+rq3O+5JfEQdrlyWv2DhMZ3GAEyTnTOoWz9KKleknJvVGMUC1QGqe3O/Xz0j6xgIXeDAiyiAdvFKLXcunz3Cgzq4S1Mzglcw7V9iQb5B7OvR2k9aS7BYmvWdfcAMjvyzIWj2xfsnsdZXANN08SRmOvRxk3B9cI7/WHV3KSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166181; c=relaxed/simple;
	bh=+lQgrVXGmqskGkJ0EZVsQvVGvqiHQqZh0rqrRdQ2bXQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Gd1w0clvWDnXacEAO80ntm8sLrrXTiX38KqZFAqmhwBja9MSLnONIsFZ9mXg6/f0dCoh4hJHObz8E7IZFexw2jQKDE+1C+xerJLgk+pCmWQ7Lf40MHddmuIEwZQ01TrLTGibScSwZ5d3DVxCiPMrmz0UM/pQUEQ9hUbgfV9OweI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ORIs5AhQ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733166178;
	bh=+lQgrVXGmqskGkJ0EZVsQvVGvqiHQqZh0rqrRdQ2bXQ=;
	h=From:Subject:Date:To:Cc:From;
	b=ORIs5AhQzO9Vc6vUE/7EUlp6YcbuwevsJZU1ECLwEGIPQThg1QS4Mw0kFWdZXLXRl
	 0/yjxj/lbqWBle7vbJ94owbJwmPrDDB9bde0Igl0qeg2iGpq891MyRQCJDIeFeF85C
	 YDhs5JxyrhN/84ipc2Kajg597L6mLvU0HMZBuZyw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/4] PCI: Constify 'struct bin_attribute'
Date: Mon, 02 Dec 2024 20:02:56 +0100
Message-Id: <20241202-sysfs-const-bin_attr-pci-v1-0-c32360f495a7@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGAETmcC/x3MMQqAMAxA0atIZgM2VBGvIiK1Rs1SpSmiiHe3O
 L7h/weUo7BCVzwQ+RSVPWSYsgC/ubAyypwNVJE1VBnUWxdFvwdNOEkYXUoRDy84MVmq2bi2biD
 nR+RFrn/dD+/7ARGkquZqAAAA
X-Change-ID: 20241201-sysfs-const-bin_attr-pci-be2425e1a856
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Logan Gunthorpe <logang@deltatee.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733166177; l=1067;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=+lQgrVXGmqskGkJ0EZVsQvVGvqiHQqZh0rqrRdQ2bXQ=;
 b=3cSuvdzQxw91cAQKKffNXHOj12Mh5lJT+gcQuAZXR2P819DWMthaAjgCc1bhmmGoBYdRtNELF
 /6ve7/vm8uFDWPNLdG8GBI6FXxIbIOeYgb3x0NvNpp02XYMafUaVJll
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

The usage of read_new/write_new/bin_attrs_new is a transition mechanism
and will be reverted after the transition is complete.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (4):
      PCI/sysfs: Constify 'struct bin_attribute'
      PCI/VPD: Constify 'struct bin_attribute'
      PCI/P2PDMA: Constify 'struct bin_attribute'
      PCI/ACPI: Constify 'struct bin_attribute'

 drivers/pci/hotplug/acpiphp_ibm.c |  6 +++---
 drivers/pci/p2pdma.c              |  6 +++---
 drivers/pci/pci-sysfs.c           | 42 +++++++++++++++++++--------------------
 drivers/pci/vpd.c                 | 14 ++++++-------
 4 files changed, 34 insertions(+), 34 deletions(-)
---
base-commit: e70140ba0d2b1a30467d4af6bcfe761327b9ec95
change-id: 20241201-sysfs-const-bin_attr-pci-be2425e1a856

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


