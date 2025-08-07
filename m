Return-Path: <linux-pci+bounces-33530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6EEB1D411
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 10:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E97433B3A79
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 08:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549C6242D8C;
	Thu,  7 Aug 2025 08:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="usbxQSzd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PKtyp8/e"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160BC2253F2;
	Thu,  7 Aug 2025 08:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754554274; cv=none; b=RWOd/dU9J2QhxDC+GrIJCe1AJqS9VFJnhkolJdq0mSo5fL0Z7BqZqDaJX5kSvM7uOh7lko9u3ikpANbizCjuzndBFYBze75RzR0b3N3J0RLbaPxS2O+hGcc7egeRFu0v5qD0+f/k4lyFqaifcUz9tq7H1fCWljIk6pKAtNBN648=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754554274; c=relaxed/simple;
	bh=5aKGQmsykQ4YHSNcqMkkGkOQMP71M+/2z4kV/REFkc0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qxAdMPuUDbxVrNOytpVbE6uYLxFjpKxi1yVZ1oA5U1qWU3+Vjb3yi3xG10aa/A9F5AEHJvk8pQM6/NERpOAA9ryQFJ5NlL6nzQZk2j6kK+jY1Di80CiEULwqrL10/9MLcj4QLN1mM+3kRypbQnatHbeCiDoJIlSTsPAnAKgzjGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=usbxQSzd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PKtyp8/e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754554264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qyDsKn1cvshzt5w4qfnD1ZngtpdUolUH5csMP8VFrqA=;
	b=usbxQSzdeRq9jwMtPeZEX5Z32jk8PDI+RjAM4A+u07i+KUe3O4/+k0gFsR/KJikdjt9jyG
	zZiscs4nNcVE1Ct/xV57Z6+3wsiwq0xK2vNXpYrXGRKKp0nYf+X6N8o6aHD5FRg8MkIlPH
	xj96vAmf151lE9Oc/XFhIjsarEwlaVuV2hy1cskhINZUGK39XIo47WNVODGYEEmbtvyv96
	wFKldPESx5hagUEyCTdpTArHdyC6qGZLjhcA5vnICidedR2bFH0SVdBeHygVwQYW/GmvP6
	JUXrJsUEYT3aMa8kHVmmrq2851VeZ917EleWIj7xvtjfX67RnVBUwcluBMlztw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754554264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qyDsKn1cvshzt5w4qfnD1ZngtpdUolUH5csMP8VFrqA=;
	b=PKtyp8/e48A1fyib0m80072mCH25Ba+Z1smfn9UMcLJORu+GJcWy+FSBABdkVATDu60r7E
	W9sl9dQyXTO6UJAw==
To: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Kenneth Crudup <kenny@panix.com>,
	Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [PATCH v2] PCI: vmd: Fix wrong kfree() in vmd_msi_free()
Date: Thu,  7 Aug 2025 10:10:51 +0200
Message-Id: <20250807081051.2253962-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

vmd_msi_alloc() allocates struct vmd_irq and stashes it into
irq_data->chip_data associated with the VMD's interrupt domain.
vmd_msi_free() extracts the pointer by calling irq_get_chip_data() and
frees it.

irq_get_chip_data() returns the chip_data associated with the top interrupt
domain. This worked in the past, because VMD's interrupt domain was the top
domain.

But since commit d7d8ab87e3e7 ("PCI: vmd: Switch to
msi_create_parent_irq_domain()") changed the interrupt domain hierarchy,
VMD's interrupt domain is not the top domain anymore. irq_get_chip_data()
now returns the chip_data at the MSI devices' interrupt domains. It is
therefore broken for vmd_msi_free() to kfree() this chip_data.

Fix this issue, correctly extract the chip_data associated with the VMD's
interrupt domain.

Fixes: d7d8ab87e3e7 ("PCI: vmd: Switch to msi_create_parent_irq_domain()")
Reported-by: Kenneth Crudup <kenny@panix.com>
Closes: https://lore.kernel.org/linux-pci/dfa40e48-8840-4e61-9fda-25cdb3ad8=
1c1@panix.com/
Reported-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Closes: https://lore.kernel.org/linux-pci/ed53280ed15d1140700b96cca2734bf32=
7ee92539e5eb68e80f5bbbf0f01@linux.gnuweeb.org/
Tested-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Tested-by: Kenneth Crudup <kenny@panix.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
v2: Fix typo and describe the change more precisely
---
 drivers/pci/controller/vmd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 9bbb0ff4cc15..b679c7f28f51 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -280,10 +280,12 @@ static int vmd_msi_alloc(struct irq_domain *domain, u=
nsigned int virq,
 static void vmd_msi_free(struct irq_domain *domain, unsigned int virq,
 			 unsigned int nr_irqs)
 {
+	struct irq_data *irq_data;
 	struct vmd_irq *vmdirq;
=20
 	for (int i =3D 0; i < nr_irqs; ++i) {
-		vmdirq =3D irq_get_chip_data(virq + i);
+		irq_data =3D irq_domain_get_irq_data(domain, virq + i);
+		vmdirq =3D irq_data->chip_data;
=20
 		synchronize_srcu(&vmdirq->irq->srcu);
=20
--=20
2.39.5


