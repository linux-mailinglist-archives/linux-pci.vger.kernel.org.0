Return-Path: <linux-pci+bounces-44736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A73D1E571
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 12:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D07C30049F9
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 11:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D02C394464;
	Wed, 14 Jan 2026 11:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="bN5fGUsE"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-o90.zoho.com (sender4-pp-o90.zoho.com [136.143.188.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C07393DF6;
	Wed, 14 Jan 2026 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389317; cv=pass; b=fs2A6bS8XQx01ms6lxXec4enjdjSmP+VQBQD45t3vzVQ+fCZ7YZUIN5STLS4JbyOF3aDduKr3HTRa5DhIUsdlnb5HOyYFzL9zqaVGf0umzAhFAVvoEnfDizVpzCXwJZAbEP5ZilS5FjAnPDfrNQyxUbFHl9wCihCdrVSkvJwWAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389317; c=relaxed/simple;
	bh=LPPwlz73/+z1pYfVWh2PWZw0b4qUercK70vLtoi4SxI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=POEGP4HrUQSRDg/+ymKG2doDZq+4Sh+NUWTnqUsQTfNA2oUw6z59TdeDctscZhnB3qIzskRuRcHVDRUrO6OwXwTVjmvFQngHDsmtJI39+wThvzpt7H42tH1sPIRpJKsKTakp2ICm0uleajgz12XKg6QA+YQSBA10Gt9Za++9NP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=bN5fGUsE; arc=pass smtp.client-ip=136.143.188.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1768389306; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=idklMtmzgU37Dkyalbk5S5B1UIgaBY2ETvAC64g6exYiSrRvteqQq5ibdzrXuPRd7Ja+HJi/T5pqT4ATnP1gQ1HLm8DSLl0tyPFjlX2USVackjXEgBKqRZu4ctSN6D8E3qsLtKWGti8jBXhYWOMYO6Q6s7IKJFahzQuoxuCL9Vs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768389306; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WpqHerWN0fLAd3RNCX750NkC+k/KfFL2Rd0iq1NMVcU=; 
	b=dvMTWFc67LBiSiqPnfsmUJ6UhYim/434KtJ7xeWSbupQjLU9kR0KQlPjL0BjF1TZrT+6dmySROWl7eshJhIKpbTYHVNldXoqNeITWgvMxSwAp7L8NWoWVIJ97cJddy216J+rsySsiAePWlUomVPqHEvrt4ki1/7vhL3yCyXuoHA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768389305;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=WpqHerWN0fLAd3RNCX750NkC+k/KfFL2Rd0iq1NMVcU=;
	b=bN5fGUsExfiFZnuYKtmmKCeS3XZxesPPCG3ufhHVWiepTWSZRW+IwwXlvimaQ246
	ZgQAbPVL/orfKaD6+3e/23onnssdgTrfIWQWUhxKkwKgceMQG2S28Gqh+t9BDDHtGYk
	MZjOoh4WDzklvNpN4vA/mHM6tiMMiaS8a4sBFeP0=
Received: by mx.zohomail.com with SMTPS id 1768389304430316.02879079140484;
	Wed, 14 Jan 2026 03:15:04 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
To: helgaas@kernel.org,
	dan.j.williams@intel.com
Cc: linux-pci@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v2 1/1] PCI/IDE: Fix using wrong VF ID for RID range calculation
Date: Wed, 14 Jan 2026 19:14:55 +0800
Message-Id: <20260114111455.550984-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227a92b0bd26dc0d18c2cb4ee6100009939737c2a05c73e881e4eabad6d678cf128bba41e5c5bbf36:zu080112276a528f98b94ac2614bc54b8900008630618b6d75801446ed451df3328650fef14921229bcdab82:rf0801123291d012e50f005ca760478e2c00003f1e1f360a860f994587022782d57be69d26cdf0145faabb8ceba99a0bd3f04a492bd35d:ZohoMail
X-ZohoMailClient: External

When allocate a new IDE stream for a PCI device in SR-IOV case, the RID
range of the new IDE stream should cover all VFs of the device. VF ID
range of a PCI device is [0, num_VFs - 1], so should use (num_VFs - 1)
as the last VF's ID.

Fixes: 1e4d2ff3ae45 ("PCI/IDE: Add IDE establishment helpers")
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
v2:
 * Make kernel-doc more detailed. (Yilun)
 * Fix typos in commit log. (Bjorn)
---
 drivers/pci/ide.c       | 4 ++--
 include/linux/pci-ide.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index f0ef474e1a0d..799caa94ab94 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -283,8 +283,8 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
 	/* for SR-IOV case, cover all VFs */
 	num_vf = pci_num_vf(pdev);
 	if (num_vf)
-		rid_end = PCI_DEVID(pci_iov_virtfn_bus(pdev, num_vf),
-				    pci_iov_virtfn_devfn(pdev, num_vf));
+		rid_end = PCI_DEVID(pci_iov_virtfn_bus(pdev, num_vf - 1),
+				    pci_iov_virtfn_devfn(pdev, num_vf - 1));
 	else
 		rid_end = pci_dev_id(pdev);
 
diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
index 37a1ad9501b0..381a1bf22a95 100644
--- a/include/linux/pci-ide.h
+++ b/include/linux/pci-ide.h
@@ -26,7 +26,7 @@ enum pci_ide_partner_select {
 /**
  * struct pci_ide_partner - Per port pair Selective IDE Stream settings
  * @rid_start: Partner Port Requester ID range start
- * @rid_end: Partner Port Requester ID range end
+ * @rid_end: Partner Port Requester ID range end (inclusive)
  * @stream_index: Selective IDE Stream Register Block selection
  * @mem_assoc: PCI bus memory address association for targeting peer partner
  * @pref_assoc: PCI bus prefetchable memory address association for
-- 
2.34.1


