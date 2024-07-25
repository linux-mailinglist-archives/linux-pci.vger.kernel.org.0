Return-Path: <linux-pci+bounces-10787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D439593C171
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 14:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752CC1F218EF
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 12:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454361991C3;
	Thu, 25 Jul 2024 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBfAvRmW"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD9222089
	for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909297; cv=none; b=WaEL6HlPmrFQ5ZPO0FOAMS0jMGFZiWmPU0BDL1dL/UlgKgjXNvs8Q1Uf+MPJ7yRQ/WLmdYZ3JxFOyg867I97PXecHeev/dN63cjFwXmJJ7nHNBzeAtTvucGBpQNLtsdf5Q9QOpy42gBS51qkp4daQ45ELoo8nRHqWfqBB5Y5rSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909297; c=relaxed/simple;
	bh=rQ+UT5p/NV1ClrF7k0Ek2XgjC6lNtbEvzf7W+/EEbRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UiTfN8cEDZc9Je9I0+uFaTOmaHiaq+ChifvJbPQSVlwy+y7lkmhIi1zlYzOyMuEcxFamPpaENtNpILHnnh9x5AtMZ5eXQduniXfcxpmWSRcUuFhNakj6vBxrGCgtKX5js9c8IvTI2jWTa+4gDVhY4Ph3TollTc+IsXacWTVwS+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IBfAvRmW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721909294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vuhrzqz609EphZ9EkpRhHshpMt64cWKXo3E+j3oTh8c=;
	b=IBfAvRmWHx1+O0Ff5iBvGH92R9MvWL8wOjgVFEGt2Bp5bvS0Ra8qXIQiyNOnr6SRvEwn0A
	ZKGvBa0o0omLB64pTE5YMTIgHJBZBjwZI+URnQjl9C+gBLQsQej0iEVuyZNPBcC0SNOTKZ
	WkJ65xOszxMyPmGiYRjnLgpnqo98csQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-0afdvj_bOy-xBQF6Dy1mzQ-1; Thu, 25 Jul 2024 08:08:13 -0400
X-MC-Unique: 0afdvj_bOy-xBQF6Dy1mzQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42808f5d220so248645e9.0
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 05:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721909292; x=1722514092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vuhrzqz609EphZ9EkpRhHshpMt64cWKXo3E+j3oTh8c=;
        b=NqL4LJ2ZHKd8NGTWtKdlWUBV/JpDQwLUu6dJuBl4laD5ZoyyC3J6ybzIneEwhb+Ijw
         BwerhXtVZqYeDysxDaW5euAl9VfO6ZZ1nF1GYNIs3SCZ9470LwDl7IPcG0zf2qY1bIrh
         Rfr4F2UrvveS34mdbgk2yzHNRYog2pGH2v+cfYjZQxXKINXZgSiUW/VA6YzLz6Gp979N
         YAdiiBRo3kbVl5SiYJ39SNtEjBgHtNJ7Ycaz+CoelXAv6fz+ZaDp4HARhZ/qufZb0ZfI
         soQvZCCtlJDEzn801gCzV3mcrcFMbZo10vxKfgBogO4wA27HT0FRr2rzllZgN2+PZLR+
         GBVQ==
X-Gm-Message-State: AOJu0YwpSdwi9jgHUdXC7f+hgvqOJAazdZI/I56HCy4uVa+IBdAxvkJy
	pfiejzK/UGBl26GIAgcbb2TVWUwld7l3yi0umuHWEeNR2ioxGScNiyZixhZeJzpADFHb1HtJcOF
	YmuiZJDq4CfI49EO/WKW510Ql3ZTVMtzcspmvfb3snpz/Sp9CpN8Xj7khIw==
X-Received: by 2002:a5d:5f53:0:b0:368:aa2:2b4e with SMTP id ffacd0b85a97d-36b34d23accmr907860f8f.4.1721909291988;
        Thu, 25 Jul 2024 05:08:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdBZfokjupGiSedSXRZUFXcdEL5xOY05AFTRmn7ch58F+QFptfSpqkSaMUPpueEP3eU+g3og==
X-Received: by 2002:a5d:5f53:0:b0:368:aa2:2b4e with SMTP id ffacd0b85a97d-36b34d23accmr907848f8f.4.1721909291440;
        Thu, 25 Jul 2024 05:08:11 -0700 (PDT)
Received: from pstanner-thinkpadp1gen5.fritz.box (200116b82d135a0064271627c11682d8.dip.versatel-1u1.de. [2001:16b8:2d13:5a00:6427:1627:c116:82d8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367d95dfsm1963483f8f.35.2024.07.25.05.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 05:08:11 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Philipp Stanner <pstanner@redhat.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH] PCI: Fix devres regression in pci_intx()
Date: Thu, 25 Jul 2024 14:07:30 +0200
Message-ID: <20240725120729.59788-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_intx() is a function that becomes managed if pcim_enable_device()
has been called in advance. Commit 25216afc9db5 ("PCI: Add managed
pcim_intx()") changed this behavior so that pci_intx() always leads to
creation of a separate device resource for itself, whereas earlier, a
shared resource was used for all PCI devres operations.

Unfortunately, pci_intx() seems to be used in some drivers' remove()
paths; in the managed case this causes a device resource to be created
on driver detach.

Fix the regression by only redirecting pci_intx() to its managed twin
pcim_intx() if the pci_command changes.

Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()")
Reported-by: Damien Le Moal <dlemoal@kernel.org>
Closes: https://lore.kernel.org/all/b8f4ba97-84fc-4b7e-ba1a-99de2d9f0118@kernel.org/
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Alright, I reproduced this with QEMU as Damien described and this here
fixes the issue on my side. Feedback welcome. Thank you very much,
Damien.

It seems that this might yet again be the issue of drivers not being
aware that pci_intx() might become managed, so they use it in their
unwind path (rightfully so; there probably was no alternative back
then).

That will make the long term cleanup difficult. But I think this for now
is the most elegant possible workaround.
---
 drivers/pci/pci.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e3a49f66982d..ffaaca0978cb 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4477,12 +4477,6 @@ void pci_intx(struct pci_dev *pdev, int enable)
 {
 	u16 pci_command, new;
 
-	/* Preserve the "hybrid" behavior for backwards compatibility */
-	if (pci_is_managed(pdev)) {
-		WARN_ON_ONCE(pcim_intx(pdev, enable) != 0);
-		return;
-	}
-
 	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
 
 	if (enable)
@@ -4490,8 +4484,15 @@ void pci_intx(struct pci_dev *pdev, int enable)
 	else
 		new = pci_command | PCI_COMMAND_INTX_DISABLE;
 
-	if (new != pci_command)
+	if (new != pci_command) {
+		/* Preserve the "hybrid" behavior for backwards compatibility */
+		if (pci_is_managed(pdev)) {
+			WARN_ON_ONCE(pcim_intx(pdev, enable) != 0);
+			return;
+		}
+
 		pci_write_config_word(pdev, PCI_COMMAND, new);
+	}
 }
 EXPORT_SYMBOL_GPL(pci_intx);
 
-- 
2.45.2


