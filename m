Return-Path: <linux-pci+bounces-61-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 495457F361D
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 19:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2E21C20DED
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 18:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821ED51039;
	Tue, 21 Nov 2023 18:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkqMSfp4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510AC51032
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 18:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA569C433C7;
	Tue, 21 Nov 2023 18:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700591825;
	bh=3Izh/8YivRbhQV8XlIsV2wimO/ukDV888NfvTAlrLdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GkqMSfp4QvHraguZpfhrbsvGogT0mgl0KOjBBDILIekYojqExQ9KVG9PhsHPt9H8y
	 DfmLCOjeV9MMba0Ac/3YXGWaxT4T8hRNns2R1y3+5ISLTmmoaNnNP3FkLnX9jJk0kw
	 v6SMoXIjGBsN+wc5Tt+P7mqpmB+3DtewO/ZRr8XIBjkYoq0DHWhXuqZsPuLe6209wp
	 Z3XILl/fzd+z3F/XqqBYyv15lKzS8ioSvjHeOykGj4tupcqw3v2zMKubyUYoPr8bX8
	 xuDlgq/lCIDo/bn8KaDfhJ8xWlgO7jL+11KQylE/u2yoQnStcYG4YWk1SP2sz1rG9P
	 TCRI4xoxo6ugg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Yunying Sun <yunying.sun@intel.com>,
	Tomasz Pala <gotar@polanet.pl>,
	Sebastian Manciulea <manciuleas@protonmail.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 8/9] x86/pci: Return pci_mmconfig_add() failure early
Date: Tue, 21 Nov 2023 12:36:42 -0600
Message-Id: <20231121183643.249006-9-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121183643.249006-1-helgaas@kernel.org>
References: <20231121183643.249006-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

If pci_mmconfig_alloc() fails, return the failure early so it's obvious
that the failure is the exception, and the success is the normal case.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/mmconfig-shared.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 459e95782bb1..0cc9520666ef 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -102,14 +102,15 @@ struct pci_mmcfg_region *__init pci_mmconfig_add(int segment, int start,
 	struct pci_mmcfg_region *new;
 
 	new = pci_mmconfig_alloc(segment, start, end, addr);
-	if (new) {
-		mutex_lock(&pci_mmcfg_lock);
-		list_add_sorted(new);
-		mutex_unlock(&pci_mmcfg_lock);
+	if (!new)
+		return NULL;
 
-		pr_info("ECAM %pR (base %#lx) for domain %04x [bus %02x-%02x]\n",
-			&new->res, (unsigned long)addr, segment, start, end);
-	}
+	mutex_lock(&pci_mmcfg_lock);
+	list_add_sorted(new);
+	mutex_unlock(&pci_mmcfg_lock);
+
+	pr_info("ECAM %pR (base %#lx) for domain %04x [bus %02x-%02x]\n",
+		&new->res, (unsigned long)addr, segment, start, end);
 
 	return new;
 }
-- 
2.34.1


