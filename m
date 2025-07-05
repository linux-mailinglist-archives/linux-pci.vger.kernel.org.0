Return-Path: <linux-pci+bounces-31572-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9477AFA259
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jul 2025 01:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC7F4A3F71
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jul 2025 23:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7ADD238C36;
	Sat,  5 Jul 2025 23:49:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpout7.mo534.mail-out.ovh.net (smtpout7.mo534.mail-out.ovh.net [54.36.140.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21821200112
	for <linux-pci@vger.kernel.org>; Sat,  5 Jul 2025 23:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.36.140.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751759359; cv=none; b=gsD8FbM+Xn2jjXAdQyGH3F3r9I89tn1+OGzGp97gLij+JFu5S95RTT8wgCbFq69xbjCSuaaf870jISPaiYeSgtMRbaIejFbaG0+l2sCD3t6y6SRUoOVljggReNCsHvQC9BPoyusD64cbofbF5p6TT9rl5m7xRYFdE0SsMfnuKJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751759359; c=relaxed/simple;
	bh=mOs+XewepzXvG+nOgkKT9IVP0KnAjus+b4UwbPplEhE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y/HhkLvgf2eXBLzeF9ma1P3FD/c18+YdVqlbld8xkfzeMpYkmgSMvkV9ItZDpCIXKF+cuNoQnkGrzvro9qifFNDfab4sfTglV0xHGdcwrl28ieP6T1paOnIH+cXYNkkzPQmkHCVn0BImyutAskj6hK2vJSDAHLBnbNQhjQKN1UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; arc=none smtp.client-ip=54.36.140.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net [152.228.215.222])
	by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4bZRcp57x5z6CM3;
	Sat,  5 Jul 2025 23:32:42 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net. [127.0.0.1])
        by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <bhelgaas@google.com>; Sat,  5 Jul 2025 23:32:42 +0000 (UTC)
Received: from mta10.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.188.134])
	by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4bZRcp3r0Tz5wFR;
	Sat,  5 Jul 2025 23:32:42 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.6])
	by mta10.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 04055DA3D52;
	Sat,  5 Jul 2025 23:32:41 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-102R004e742e852-2cb6-4def-8a10-6135a02faf00,
                    6309C3B5282082938C1B0D62F70632481A582291) smtp.auth=marcos@orca.pet
X-OVh-ClientIp:147.156.42.5
From: Marcos Del Sol Vives <marcos@orca.pet>
To: linux-kernel@vger.kernel.org
Cc: marcos@orca.pet,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH] pci: disable MSI on RDC PCI to PCI-E bridges
Date: Sun,  6 Jul 2025 01:32:08 +0200
Message-Id: <20250705233209.721507-1-marcos@orca.pet>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13121800464492353126
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvjeefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforghrtghoshcuffgvlhcuufholhcugghivhgvshcuoehmrghrtghoshesohhrtggrrdhpvghtqeenucggtffrrghtthgvrhhnpefghffgfeevgffhteevvefghfelffejvdejkeeijeegieduvdffteeijeejjefggeenucfkphepuddvjedrtddrtddruddpudegjedrudehiedrgedvrdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehmrghrtghoshesohhrtggrrdhpvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehmrghrtghoshesohhrtggrrdhpvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheefgegmpdhmohguvgepshhmthhpohhuth

These bridges, present on Vortex86DX3 and Vortex86EX2 SoCs, do not
support MSIs. If enabled, interrupts generated by PCI-E devices never
reach the processor.

I have contacted the manufacturer (DM&P) and they confirmed that PCI MSIs
need to be disabled for them.

Signed-off-by: Marcos Del Sol Vives <marcos@orca.pet>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d7f4ee634263..f610ea45ca9e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2715,6 +2715,7 @@ static void quirk_disable_msi(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_BRIDGE, quirk_disable_msi);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, 0xa238, quirk_disable_msi);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x5a3f, quirk_disable_msi);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_RDC, 0x1031, quirk_disable_msi);
 
 /*
  * The APC bridge device in AMD 780 family northbridges has some random
-- 
2.34.1


