Return-Path: <linux-pci+bounces-33519-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980E3B1D28E
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 08:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3168A724CE4
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 06:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB241F7580;
	Thu,  7 Aug 2025 06:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="frCpnqYh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PN92FSqg"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06B71D63F7;
	Thu,  7 Aug 2025 06:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754548750; cv=none; b=b5MUwM7B9xmxwr7vfmtMLuXeCbZ7p7ZxKk5R9vET6XZCAqmWtuutH46bFxskD+FxI7EloQSY94SX1xsxW7DGDoJDaPrNBpCM/PEl+RZRubG6tnW0CoWqxsrPmgUiEsCSYi9x9oAGjo1dQFcfkPeAB3WmD5RG4kEwyArv7a7jVkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754548750; c=relaxed/simple;
	bh=+C8TjlOLxdLO/qmnnkveXprg9V+WXxCSUSDCkAD3bP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uhqU8SOZU18xm+0ZD8Mi5GSGWRXCQKW/B7QXHPrpT+3WP+SxZaE5mz2CNNeQ3Qi56zQbigW8jUzSXQFSBVcwDtsgP2uAt3D8wre7FoOXfMRwXrAhShXsTHhVtbJWruGTKeHdsgZ1a7sik/j8Ax75zfU1GfYZI0ygais2WIFP6i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=frCpnqYh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PN92FSqg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754548746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o7Q4cP3eWaYf1JheoCeQ/Ru/MW3OUWE6jBFVj9EMMwE=;
	b=frCpnqYhV+oOo6XqkO/EbwQuusmWYnvm09lUPKOr5y3KnuNlbBBAFKOZDCcts+0JkAdTfY
	xB3P5i5LTuafnaLuMlaZEpTemiYw59my+SroabVQitaEDUqyzggCbGggqjuRFoB8Wzj/XE
	aLVBifOKvyfFOe2vtV0I6f7bcSBBq25mjr0A7U1tJzbP9kLNrOh54cKxLzRjXToGd9hqzx
	f0WZuemHBp2vOXcIxRvcKOYQmXKr+8yr3UzLe/Z4dNIaokQ0LPPGTwUZTUVzUY1mFWzeV8
	H34TIhunzX3nR6h961pVWaKMjdHiI7UU2TwuN1hJNctHiCnY0AjQEHcH0Z252g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754548746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o7Q4cP3eWaYf1JheoCeQ/Ru/MW3OUWE6jBFVj9EMMwE=;
	b=PN92FSqgZ9e66PM8hBb0FJCVvXBRJM8aipzNwZnDbipA7v4TpKr8ebJgOewgF0uLFWz7m4
	k0oaGWeWSpB8EuBA==
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
Subject: [PATCH] PCI: vmd: Fix wrong kfree() in vmd_msi_free()
Date: Thu,  7 Aug 2025 08:38:57 +0200
Message-Id: <20250807063857.2175355-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

vmd_msi_alloc() allocates struct vmd_irq and stashes it into
irq_domain->irq-data->chip_data. vmd_msi_free() extracts the pointer by
calling irq_get_chip_data() and frees it.

irq_get_chip_data() returns the chip_data of the top interrupt domain. This
worked in the past, because VMD's interrupt domain was the top domain.

But since commit d7d8ab87e3e7 ("PCI: vmd: Switch to
msi_create_parent_irq_domain()") changed the interrupt domain hierarchy,
VMD's interrupt domain is not the top domain anymore. irq_get_chip_data()
now returns the chip_data of the MSI devices' interrupt domain. It is
therefore broken for vmd_msi_free() to kfree() this irq_data.

Fix this issue, correctly extract the chip_data of VMD's interrupt domain.

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


