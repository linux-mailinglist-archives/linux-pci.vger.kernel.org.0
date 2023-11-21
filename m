Return-Path: <linux-pci+bounces-58-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FA87F3616
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 19:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8362B21A11
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 18:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2425E51038;
	Tue, 21 Nov 2023 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uwt2R144"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CE051035
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 18:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA9CC433CB;
	Tue, 21 Nov 2023 18:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700591819;
	bh=ks9s3ODzJPgxlrZ34fpMdEf9kOaOEvMAaQEGGAEQrtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uwt2R144vun2y7PN5CRe6Kc/nrvVoO5JerX2sRIJ/2APNdfidyj1Y3Hx87T/VAoNN
	 wgLL46K7seOlNSRQ5p0o7QcFDTg+14KqqeW9SsKKH+nzv6CPZutqVrsBzSr62pFQi+
	 CCqFNky92FqTQr7ZpTxNOS0tQsAu+vBjv0aJiENTIxpxsKKY7hKET+TdS1fuwXzoXO
	 9CcUzr+G6X5Qvo1Om4pOhB3ZirUSTardxrB+atcxCZZdcFB6vL+Xn3Z6uB6of2H5uw
	 NgE82W22Io4RT4kyCC0aXAihXfa3eYQBvWeqWIGrMu365JMVE+cK0ghJFAKWxbA498
	 8YfO6tobt2+VQ==
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
Subject: [PATCH 5/9] x86/pci: Rename acpi_mcfg_check_entry() to acpi_mcfg_valid_entry()
Date: Tue, 21 Nov 2023 12:36:39 -0600
Message-Id: <20231121183643.249006-6-helgaas@kernel.org>
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

"acpi_mcfg_check_entry()" doesn't give a hint about what the return value
means.  Rename it to "acpi_mcfg_valid_entry()", convert the return value to
bool, and update the return values and callers to match so testing
"if (acpi_mcfg_valid_entry())" makes sense.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/mmconfig-shared.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 896cc11013bd..91fd7921d221 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -576,22 +576,22 @@ static void __init pci_mmcfg_reject_broken(int early)
 	}
 }
 
-static int __init acpi_mcfg_check_entry(struct acpi_table_mcfg *mcfg,
-					struct acpi_mcfg_allocation *cfg)
+static bool __init acpi_mcfg_valid_entry(struct acpi_table_mcfg *mcfg,
+					 struct acpi_mcfg_allocation *cfg)
 {
 	if (cfg->address < 0xFFFFFFFF)
-		return 0;
+		return true;
 
 	if (!strncmp(mcfg->header.oem_id, "SGI", 3))
-		return 0;
+		return true;
 
 	if ((mcfg->header.revision >= 1) && (dmi_get_bios_year() >= 2010))
-		return 0;
+		return true;
 
 	pr_err("ECAM at %#llx for %04x [bus %02x-%02x] is above 4GB, ignored\n",
 	       cfg->address, cfg->pci_segment, cfg->start_bus_number,
 	       cfg->end_bus_number);
-	return -EINVAL;
+	return false;
 }
 
 static int __init pci_parse_mcfg(struct acpi_table_header *header)
@@ -622,7 +622,7 @@ static int __init pci_parse_mcfg(struct acpi_table_header *header)
 	cfg_table = (struct acpi_mcfg_allocation *) &mcfg[1];
 	for (i = 0; i < entries; i++) {
 		cfg = &cfg_table[i];
-		if (acpi_mcfg_check_entry(mcfg, cfg)) {
+		if (!acpi_mcfg_valid_entry(mcfg, cfg)) {
 			free_all_mmcfg();
 			return -ENODEV;
 		}
-- 
2.34.1


