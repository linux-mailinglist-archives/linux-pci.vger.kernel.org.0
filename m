Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F239C664815
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 19:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbjAJSFY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 13:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238763AbjAJSEt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 13:04:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A8085C89;
        Tue, 10 Jan 2023 10:02:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E340AB81903;
        Tue, 10 Jan 2023 18:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8EAC433EF;
        Tue, 10 Jan 2023 18:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673373774;
        bh=YIJe4Sbi90ZM5MZspqHWq3/zFAVIJE3Xh1CUKfmBVlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JU9RwYbn8DPJol5KQGf8epu5BTm/Kx3sREhzcYfXoT/QNOm2kNElrMgQKTRQq9BFA
         uC/u812UPJlCmqPUGWctbVQFdRgZOwHn59pEQYeln4Ho8WbFBLu+L0j+NRHJ7JbgoH
         5NIIJ0Vpe7YV6HXXh16JW/F/QBg82oZwcCpNguxPm7i/yrvu1o4mJteZ7E8nNrdr8b
         BeeIBTpq5a+VM0F3Dv79z+MEMGOnHWQkqbVhexd8NdtqsFN1d/vl6n/9aCVpsmfcod
         BKoQc3gXUIMJt7P0fbVPJkw0XibgNsdSiaAyR6lOCk37K08fs2YmYXjJgvM2QC0Wg1
         9kYi8sKlrbYug==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Dan J Williams <dan.j.williams@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        David E Box <david.e.box@intel.com>,
        Yunying Sun <yunying.sun@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hans de Goede <hdegoede@redhat.com>,
        Florent DELAHAYE <linuxkernelml@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        =?UTF-8?q?Benoit=20Gr=C3=A9goire?= <benoitg@coeus.ca>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] x86/pci: Simplify is_mmconf_reserved() messages
Date:   Tue, 10 Jan 2023 12:02:42 -0600
Message-Id: <20230110180243.1590045-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230110180243.1590045-1-helgaas@kernel.org>
References: <20230110180243.1590045-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

is_mmconf_reserved() takes a "with_e820" parameter that only determines the
message logged if it finds the MMCONFIG region is reserved.  Pass the
message directly, which will simplify a future patch that adds a new way of
looking for that reservation.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/mmconfig-shared.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 758cbfe55daa..cd16bef5f2d9 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -446,13 +446,12 @@ typedef bool (*check_reserved_t)(u64 start, u64 end, enum e820_type type);
 
 static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
 				     struct pci_mmcfg_region *cfg,
-				     struct device *dev, int with_e820)
+				     struct device *dev, char *method)
 {
 	u64 addr = cfg->res.start;
 	u64 size = resource_size(&cfg->res);
 	u64 old_size = size;
 	int num_buses;
-	char *method = with_e820 ? "E820" : "ACPI motherboard resources";
 
 	while (!is_reserved(addr, addr + size, E820_TYPE_RESERVED)) {
 		size >>= 1;
@@ -464,10 +463,10 @@ static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
 		return false;
 
 	if (dev)
-		dev_info(dev, "MMCONFIG at %pR reserved in %s\n",
+		dev_info(dev, "MMCONFIG at %pR reserved as %s\n",
 			 &cfg->res, method);
 	else
-		pr_info(PREFIX "MMCONFIG at %pR reserved in %s\n",
+		pr_info(PREFIX "MMCONFIG at %pR reserved as %s\n",
 		       &cfg->res, method);
 
 	if (old_size != size) {
@@ -500,7 +499,8 @@ static bool __ref
 pci_mmcfg_check_reserved(struct device *dev, struct pci_mmcfg_region *cfg, int early)
 {
 	if (!early && !acpi_disabled) {
-		if (is_mmconf_reserved(is_acpi_reserved, cfg, dev, 0))
+		if (is_mmconf_reserved(is_acpi_reserved, cfg, dev,
+				       "ACPI motherboard resource"))
 			return true;
 
 		if (dev)
@@ -527,7 +527,8 @@ pci_mmcfg_check_reserved(struct device *dev, struct pci_mmcfg_region *cfg, int e
 	/* Don't try to do this check unless configuration
 	   type 1 is available. how about type 2 ?*/
 	if (raw_pci_ops)
-		return is_mmconf_reserved(e820__mapped_all, cfg, dev, 1);
+		return is_mmconf_reserved(e820__mapped_all, cfg, dev,
+					  "E820 entry");
 
 	return false;
 }
-- 
2.25.1

